Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6327A531719
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238906AbiEWQrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238871AbiEWQrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:47:36 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C923271F
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:47:35 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id w10so13185397vsa.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=80S8PctliGOeW9sdmtk62ftvrGXBeuID8tBu3II0AtQ=;
        b=QLFTfJxJAcj0vuVPdjG7/2oNQcI4B55nhUKl0e57e/VCkr+UGv1PcDJK5EmLaFCVQ2
         R/BP4hb32JPOLe9GjyQVCjiL/pLDR8CNlot+jh65KF5Lt9nvtSeVMPYiWBwOM1bWgW/+
         2Mzr9axl2uS32Wzsct8LDbwBYaAW/2lVuxxEtl79X2SzvUqvVQaoOUvm0L0ag/ts9ry5
         H8PD7/qLEKJG2AnO+TDllQDpKYFQ8zXextCOLXEounaAiAfBIsU+mro63woWX7n8nEK1
         X2sC+wlF+X5Nh4Mn3AsPfhzvDA7ob+g0UC/TINJRwedLhMMXfI6nlLDFnJmENXhyaa9J
         SPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=80S8PctliGOeW9sdmtk62ftvrGXBeuID8tBu3II0AtQ=;
        b=0LxmaySdmedyal2zD68V24VqxADe227WmAnhxARHbXufUUi82/ntJS1zFt7TWPmGAh
         aJBzP8bG6gc/YxAnf/k4e9uIcZ9Wlb9K43hbvSDUEit6NC9kzxAM7zZg/9XUPEdAxuim
         CBZCWaRPotav0CI172JMQQBPS2TJZkmU+i0Z81/0UPIE8ntNLZEQD0fwLUWYqrxKgjqj
         XBNEMgi9UKXuaNInZ0GsFJ2JsdHhnO8zLwWyJemPSCS00xlL2vct6jfgGvQzs4AY7AuC
         3TpVjaGbveZDV1DOLH8Mmc/+Sx57CXp8WfNAefJnbHslc0mV9bla0Ly2WNrd3TqRAgZT
         1Fqw==
X-Gm-Message-State: AOAM532wDU7j74BNf9gjHaYYOr7bisr9aPFnuMWjA+Say03Jj9VPI7CR
        +LPjpgzf75ZkxuKernMdNHAy8KpFURVjHFGZjPnv
X-Google-Smtp-Source: ABdhPJwqtmK7aM4Q4deJfPW2cZGIcvXkBikK5NrznWed0II6tLlTEkYtSSzfjEZ8CHLO5dUR1QKGOpmqDeagd5cSjCY=
X-Received: by 2002:a05:6102:32c6:b0:333:bdd3:14f6 with SMTP id
 o6-20020a05610232c600b00333bdd314f6mr9042054vss.19.1653324453954; Mon, 23 May
 2022 09:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <d7fc85736adee02ce52ee88a54fa7477fbd18ed2.1653236802.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <d7fc85736adee02ce52ee88a54fa7477fbd18ed2.1653236802.git.christophe.jaillet@wanadoo.fr>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 23 May 2022 09:47:23 -0700
Message-ID: <CANDhNCqPH5SQR6YhZjqHF0BvC-Wo+epCkxmFKqzFSj7+POMWZA@mail.gmail.com>
Subject: Re: [RFC PATCH] timers: Optimize usleep_range()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dan.carpenter@oracle.com, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 9:38 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> diff --git a/include/linux/delay.h b/include/linux/delay.h
> index 039e7e0c7378..e84e7f9c1a47 100644
> --- a/include/linux/delay.h
> +++ b/include/linux/delay.h
> @@ -61,10 +61,23 @@ void msleep(unsigned int msecs);
>  unsigned long msleep_interruptible(unsigned int msecs);
>  void usleep_range_state(unsigned long min, unsigned long max,
>                         unsigned int state);
> +void __nsleep_range_delta_state(u64 min, u64 delta, unsigned int state);
>
>  static inline void usleep_range(unsigned long min, unsigned long max)
>  {
> -       usleep_range_state(min, max, TASK_UNINTERRUPTIBLE);
> +       /*
> +        * Most of the time min and max are constant, so the time delta and the
> +        * convertion to ns can be computed at compile time.
> +        */
> +       if (__builtin_constant_p(min) &&
> +           __builtin_constant_p(max)) {
> +               u64 delta = (u64)(max - min) * NSEC_PER_USEC;
> +
> +               __nsleep_range_delta_state(min * NSEC_PER_USEC, delta,
> +                                          TASK_UNINTERRUPTIBLE);
> +       } else {
> +               usleep_range_state(min, max, TASK_UNINTERRUPTIBLE);
> +       }
>  }

It seems the key optimization is just moving the multiplication to the
inlined header function, so rather than duplicating most of
usleep_range_state() in __nsleep_range_delta_state(), could you not
switch all uses of usleep_range_state() to use the
__nsleep_range_delta_state()?  Then you don't need the
__buildint_constant_p() checks since the compiler can decide on its
own, no?


> +/**
> + * __nsleep_range_delta_state - Sleep for an approximate time in a given state
> + * @min:       Minimum time in nsecs to sleep
> + * @delta:     Maximum time in nsecs to sleep

I don't think that's the right value description here. Maybe this
should be the slack value?


thanks
-john
