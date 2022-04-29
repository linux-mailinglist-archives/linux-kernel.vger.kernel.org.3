Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42195514592
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356677AbiD2JqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238887AbiD2JqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:46:10 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4877ABF303
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:42:53 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p10so13005976lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jkxpW3EdVAmqaoDM04pa7Fls99UHVBaNQniA0KfeFwg=;
        b=LlNxkv2Et2hjxXNddYh87SBmC5hYSOujjgg24Uo8lcr4G+sb7/dJtUOoles0kZrGtr
         nb+1We3zvwO7gmwGN0D5xrq8VJVqtBIC8L6/JYzNUU++KuCuJzvLinR9X2QRsmFy9Cpo
         4gSeXZnpNTK4JqphnpzYG1u0wxJSprbIH/ouE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jkxpW3EdVAmqaoDM04pa7Fls99UHVBaNQniA0KfeFwg=;
        b=EchGxGmfZcWabLTJYHUsDxLvqOqvRzgAGID/tBTFuoqT3hc0jc843/XKOc+Jz0KCy8
         q3pNjI+ynEjudkPl0EgoFs/6jXdJPuiwMub55XoSnIFs4AW1WIIDld54Gwwf2krxVU54
         XMuta0K7QkK4bLiMeWR7hdhwoLUKCJL4osxjtVLViC08FRBpftTwmXr02fTEQMDorjtV
         C/VpuWZeNw/KZvROd5+Oa//ewC4sN6Ectq+xXYmwc8bB1a1iS1lr6Pt/q7C9Zp2BNnR3
         7VWDrC7bdv6hiag2Tqx1g2CC7xeISdgCC/CIMipBQAz6YGQPn37aVcmseFoLLfjh8Pqu
         I1Pw==
X-Gm-Message-State: AOAM531Pk4G/ZtXL5GrHcgkwx1JfiJL/lKzpVqW9px8jedA+KYhypyAo
        pIX9RmR9cFTcEDKxqUlo4YN/362YKbfh4wODZei2r3d1TTF1W37a
X-Google-Smtp-Source: ABdhPJxQ4ryA2tYTRZ94S76YdZelWYjf5tfAgH5HawCXSSq8+UOoE+WbPV/mgCuTZO9vIPqIll75OctNYwK0C3lvnvQ=
X-Received: by 2002:a05:6512:108e:b0:472:2f9:ecae with SMTP id
 j14-20020a056512108e00b0047202f9ecaemr18910638lfg.618.1651225371669; Fri, 29
 Apr 2022 02:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220429023113.74993-1-sargun@sargun.me> <20220429023113.74993-2-sargun@sargun.me>
In-Reply-To: <20220429023113.74993-2-sargun@sargun.me>
From:   Rodrigo Campos <rodrigo@kinvolk.io>
Date:   Fri, 29 Apr 2022 11:42:15 +0200
Message-ID: <CACaBj2bW8XkENHoLNXEprQ_d8=_aLT_XQdjCZtSOiPJis8G_pQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] seccomp: Add wait_killable semantic to seccomp
 user notifier
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Alban Crequy <alban@kinvolk.io>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 4:32 AM Sargun Dhillon <sargun@sargun.me> wrote:
> the concept is searchable. If the notifying process is signaled prior
> to the notification being received by the userspace agent, it will
> be handled as normal.

Why is that? Why not always handle in the same way (if wait killable
is set, wait like that)

> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index db10e73d06e0..9291b0843cb2 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1081,6 +1088,12 @@ static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd, struct seccomp_kn
>         complete(&addfd->completion);
>  }
>
> +static bool should_sleep_killable(struct seccomp_filter *match,
> +                                 struct seccomp_knotif *n)
> +{
> +       return match->wait_killable_recv && n->state == SECCOMP_NOTIFY_SENT;

Here for some reason we check the notification state to be SENT.

> +}
> +
>  static int seccomp_do_user_notification(int this_syscall,
>                                         struct seccomp_filter *match,
>                                         const struct seccomp_data *sd)
> @@ -1111,11 +1124,25 @@ static int seccomp_do_user_notification(int this_syscall,
>          * This is where we wait for a reply from userspace.
>          */
>         do {
> +               bool wait_killable = should_sleep_killable(match, &n);
> +

So here, the first time this runs this will be false even if the
wait_killable flag was used in the filter (because that function
checks the notification state to be sent, that is not true the first
time)

Why not just do wait_for_completion_killable if match->wait_killable
and wait_for_completion_interruptible otherwise? Am I missing
something?



Best,
Rodrigo
