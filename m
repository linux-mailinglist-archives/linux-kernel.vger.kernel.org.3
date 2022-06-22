Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBF3556EBB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 00:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376760AbiFVW6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 18:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376778AbiFVW6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 18:58:38 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC503EF03
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 15:58:37 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id m16so11093602ilf.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 15:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E2W8cT9+eQP/K3OUSNqcjrwuCQBrEUD6L/kph3gY7Hc=;
        b=O6fnv4Cy/i2qtk+aGdD62UymIG285EMWD2hCwVrCefUiTfvUsRYlcMEjKreYwTu3lZ
         +iq1QI+GIo2tKBd2guBzCADuALCeRGVy2rpDkfOdjeJC7D677/MibJXcZVX+28Lt02WF
         80Z8jfTk5AyIgUL6JFFK67L6Es9LFlcmAeFEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E2W8cT9+eQP/K3OUSNqcjrwuCQBrEUD6L/kph3gY7Hc=;
        b=g3EXpRQVKOkDZAq64N0jh5h/gOnGB2T6oR8wrEO2HXuTbatB5lSBKefzwxVQmbwGC+
         K79C2ENRmnCPWXQETIN/EwANV/7IZdWf/fHg/RV4At3y2FPFaXrD6DR89qvLHkJtVekY
         L+Mbhq3PB0kiljMYQOuTQxhxbRzPK7H8m6ai+P852MDk7SFHlp5uozXVK1NEh0wUCUhc
         UNhX6yROwP274EHa2uEboVpAa/i91oBx58nlU7rh2pj+TGul5yGdvTTb6y30AUZLmkfo
         MfpmoPrB82kemRHPQC7SxHYW15Q/VAcmru0XUbUMRELEgyz89ZXxcDK0GweUUb6wpad5
         PlSA==
X-Gm-Message-State: AJIora9UC1ITzATMQuwJdjYMk/lI4NTWxJrBsr8xGdvx35/yIlUIr9T1
        eogBnO8szoETbiRQG71hJrGbDbjktAf9xJvnUddY/w==
X-Google-Smtp-Source: AGRyM1uTjEDV3Av4QdjU0tC4xCKF/aqqmjNl9hypJfT8/qlCycU0mufZSPFw49wVHjACPx9kjglUutCG8FIRJIoKGMw=
X-Received: by 2002:a05:6e02:1986:b0:2d4:dfae:edef with SMTP id
 g6-20020a056e02198600b002d4dfaeedefmr3326335ilf.280.1655938716831; Wed, 22
 Jun 2022 15:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220622225102.2112026-1-joel@joelfernandes.org> <20220622225102.2112026-2-joel@joelfernandes.org>
In-Reply-To: <20220622225102.2112026-2-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 22 Jun 2022 18:58:26 -0400
Message-ID: <CAEXW_YQaXGmwmFbfSPAEG9SpfuSy3muhWhTFeuxSY4OwUWeHdA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] context_tracking: Use arch_atomic_read() in
 __ct_state for KASAN
To:     rcu <rcu@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, vineeth@bitbyteword.org,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies, I accidentally picked this specific commit up in my recent
git format-patch which ended up sending it out. Totally unintended.

On Wed, Jun 22, 2022 at 6:51 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> From: "Paul E. McKenney" <paulmck@kernel.org>
>
> Context tracking's __ct_state() function can be invoked from noinstr state
> where RCU is not watching.  This means that its use of atomic_read()
> causes KASAN to invoke the non-noinstr __kasan_check_read() function
> from the noinstr function __ct_state().  This is problematic because
> someone tracing the __kasan_check_read() function could get a nasty
> surprise because of RCU not watching.
>
> This commit therefore replaces the __ct_state() function's use of
> atomic_read() with arch_atomic_read(), which KASAN does not attempt to
> add instrumention to.
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Marco Elver <elver@google.com>
> Reviewed-by: Marco Elver <elver@google.com>
> ---
>  include/linux/context_tracking_state.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
> index 0aecc07fb4f5..81c51e5f0314 100644
> --- a/include/linux/context_tracking_state.h
> +++ b/include/linux/context_tracking_state.h
> @@ -49,7 +49,7 @@ DECLARE_PER_CPU(struct context_tracking, context_tracking);
>
>  static __always_inline int __ct_state(void)
>  {
> -       return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_STATE_MASK;
> +       return arch_atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_STATE_MASK;
>  }
>  #endif
>
> --
> 2.37.0.rc0.104.g0611611a94-goog
>
