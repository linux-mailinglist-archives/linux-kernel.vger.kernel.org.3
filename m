Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BC85723DD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 20:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbiGLSyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 14:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbiGLSxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 14:53:49 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540CBDABBB;
        Tue, 12 Jul 2022 11:45:38 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 75so14193728ybf.4;
        Tue, 12 Jul 2022 11:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OjvcswXUwB2Pb+ms5uvcJJXESqqNUnsytuAFqZsR5PY=;
        b=NoqN1d/YxZlfDKChnAnq8d8NApqr7A4OewNwbHGZrtKTZO74v1PMF6Vx2SsY38kkxa
         TdLR1vPKZmlMpx7lqFP5w1apMw8MKtWo5QTzrIGxfv5hZwEuDaCrKvtgQqPhgp4+MIdf
         WUFhEQ1gNTHoBWPCjUKBjWvF/mZbd4cElbK3OHSmq6cgXXKVCLWA3wPs/kJt/RcKfAw7
         i4LEJl4dCLViuKLNDvbZf77MN2xPh5PRUdh02uPkzV/AZpDD1k/tXfbOe8KQnM+iFQCx
         A3pwxEnQzvZavJRD6NWICOiCpPWODYo7J1PAJQMedcYWwtO5wDDp+N4t7EQcojjtUbO/
         Y96Q==
X-Gm-Message-State: AJIora+tuvd0uYf6mmni1LjK0Ku2q/2bCohp6DpmplzaTwrZHIGlyr6q
        rxJ0Qj1MOxAHOnbwZVTOzZIHTAgCzLlH00v6cSk=
X-Google-Smtp-Source: AGRyM1tccpyquhG63LJBv3ExX2zg01BoYg2i4799MYW2qAlMgrgSmXwt0vB+DDtaTZhOd/qz2StJWxMWxld3lcwHUEc=
X-Received: by 2002:a25:a2ca:0:b0:66e:719e:279 with SMTP id
 c10-20020a25a2ca000000b0066e719e0279mr22941849ybn.622.1657651529768; Tue, 12
 Jul 2022 11:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220629011146.299521-1-xiongxin@kylinos.cn> <20220629011146.299521-2-xiongxin@kylinos.cn>
In-Reply-To: <20220629011146.299521-2-xiongxin@kylinos.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Jul 2022 20:45:18 +0200
Message-ID: <CAJZ5v0hhdxnPRpmvB9SSs7X9bQ=zz7pZ-+KOE67WwMvEOwXCRA@mail.gmail.com>
Subject: Re: [PATCH -next 1/2] PM: suspend: expand the assignment scope of the pm_suspend_target_state
To:     xiongxin <xiongxin@kylinos.cn>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Riwen Lu <luriwen@kylinos.cn>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 5:35 AM xiongxin <xiongxin@kylinos.cn> wrote:
>
> The pm_suspend_target_state variable can be used as a suspend state
> identifier and given to the specific device driver as a code judgment;
>
> Because the suspend_prepare() function is time-consuming for the
> operation of freezing processes, and this stage is actually in the suspend
> stage, it is necessary to expand the scope of the pm_suspend_target_state
> variable to be assigned to the suspend state at enter_state() function;

I don't see why it is necessary, sorry.

> Another reason is that the specific device driver can locate whether it is
> in the suspend state based on this variable, so as to determine the
> validity of its wake-up source.

I think you have a specific use case in mind, so please explain why
and how this change helps in your specific use case.

So far I don't see a reason for applying this patch.

> Signed-off-by: xiongxin <xiongxin@kylinos.cn>
> ---
>  kernel/power/suspend.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 827075944d28..c754b084ec03 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -564,6 +564,12 @@ static int enter_state(suspend_state_t state)
>         if (state == PM_SUSPEND_TO_IDLE)
>                 s2idle_begin();
>
> +       /*
> +        * Expand the scope of suspend state for suspend operations
> +        * performed from the /sys/power/state entry.
> +        */
> +       pm_suspend_target_state = state;
> +
>         if (sync_on_suspend_enabled) {
>                 trace_suspend_resume(TPS("sync_filesystems"), 0, true);
>                 ksys_sync_helper();
> @@ -590,6 +596,7 @@ static int enter_state(suspend_state_t state)
>         pm_pr_dbg("Finishing wakeup.\n");
>         suspend_finish();
>   Unlock:
> +       pm_suspend_target_state = PM_SUSPEND_ON;
>         mutex_unlock(&system_transition_mutex);
>         return error;
>  }
> --
> 2.25.1
>
>
> No virus found
>                 Checked by Hillstone Network AntiVirus
