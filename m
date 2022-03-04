Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A0C4CDBEF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241514AbiCDSPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239955AbiCDSPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:15:11 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14351C60CE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 10:14:22 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2dc28791ecbso86949337b3.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 10:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=roOvrpzRBBuu6X1VnPdwFDfTIg5X39LNxw0wRlde0q0=;
        b=iVNEGaLsI/oTddyIVfrof90wANBQmPt96gurLud4I8iwWZs9qalXO+7UcXMzuIO8tw
         7aTcVPEoqPanpkJ5vOenbgiPMHiUFwBA+J6Y9a7abdyfG4RC+c7JozAJeOaNhw2+F34U
         M5XFCqasPH3yPIp8UOZOo5Q/FdGuuqhycyAXdMnBcIWDnLoO/PBloBz+xFZYO8JtgrCf
         WxenyT5JVS0BzVwF24Rgzlz8pUmwHIiDtOey4RH6ixTRoqmNjI3UUiHPqD9Ctg1H1EaT
         oARIUNVfbQR1mFIqSQx8YPcEFMRvWgBCJgIjGbRuJZHKPqjJ/x8SA/USAfkbkRBvkG8k
         htAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=roOvrpzRBBuu6X1VnPdwFDfTIg5X39LNxw0wRlde0q0=;
        b=cL4hB7fosIH9VXo8tUiKLTOoREoh1dKmH3Ub9Tzmydu4Rib/zlRo+kSJXMhGK6PZW1
         6P4zlFFf27/KDP9yYIM7Yu0cFYRxI94xq/vpapwbGxB1leuMRNX4Rudp/9Qrdl8MpITB
         7cNROwniCff6hRh+dh3P/57lJuTc5FLPR/flZBdD1ZDGRutyKBYMmJdr/b1DykkWOBVC
         DIccUTMUImJOPy78eIjZwFRTJPXJyt7wZ5RZuPty4bpK7TMUzn7C9Fw5sK94n8KbvELf
         LxiMdsR6NDBcR+kAjgpcE7Y7HVj3nMQizj7mU2n3Coy1r118BsmRL+UUDHfVk3IM0bml
         ioSw==
X-Gm-Message-State: AOAM533CfjH8C2HgZBUDkQ150CxjRDyVGCn8Z7bXlIErJEF6sHZqL6Ff
        VBsgFP7xfE8gVWKsve1CeL7T9OphY9F0Oc86A9FAXw==
X-Google-Smtp-Source: ABdhPJxV/T1UYsvhtBW/QXPyM+sLHYNKaGr4+8JbGihlbMoplFbfcKOi8eRcdtTJRFYgJ5n5azU1Y2E87jPi6aBBgSg=
X-Received: by 2002:a81:9ad7:0:b0:2db:f000:32e7 with SMTP id
 r206-20020a819ad7000000b002dbf00032e7mr17923054ywg.412.1646417661910; Fri, 04
 Mar 2022 10:14:21 -0800 (PST)
MIME-Version: 1.0
References: <20220303031505.28495-1-dtcccc@linux.alibaba.com> <20220303031505.28495-2-dtcccc@linux.alibaba.com>
In-Reply-To: <20220303031505.28495-2-dtcccc@linux.alibaba.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 4 Mar 2022 19:13:45 +0100
Message-ID: <CANpmjNOOkg=OUmgwdcRus2gdPXT41Y7GkFrgzuBv+o8KHKXyEA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] kfence: Allow re-enabling KFENCE after system startup
To:     Tianchen Ding <dtcccc@linux.alibaba.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2022 at 04:15, Tianchen Ding <dtcccc@linux.alibaba.com> wrote:
>
> If once KFENCE is disabled by:
> echo 0 > /sys/module/kfence/parameters/sample_interval
> KFENCE could never be re-enabled until next rebooting.
>
> Allow re-enabling it by writing a positive num to sample_interval.
>
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>

The only problem I see with this is if KFENCE was disabled because of
a KFENCE_WARN_ON(). See below.

> ---
>  mm/kfence/core.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 13128fa13062..19eb123c0bba 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -55,6 +55,7 @@ EXPORT_SYMBOL_GPL(kfence_sample_interval); /* Export for test modules. */
>  #endif
>  #define MODULE_PARAM_PREFIX "kfence."
>
> +static int kfence_enable_late(void);
>  static int param_set_sample_interval(const char *val, const struct kernel_param *kp)
>  {
>         unsigned long num;
> @@ -65,10 +66,11 @@ static int param_set_sample_interval(const char *val, const struct kernel_param
>
>         if (!num) /* Using 0 to indicate KFENCE is disabled. */
>                 WRITE_ONCE(kfence_enabled, false);
> -       else if (!READ_ONCE(kfence_enabled) && system_state != SYSTEM_BOOTING)
> -               return -EINVAL; /* Cannot (re-)enable KFENCE on-the-fly. */
>
>         *((unsigned long *)kp->arg) = num;
> +
> +       if (num && !READ_ONCE(kfence_enabled) && system_state != SYSTEM_BOOTING)

Should probably have an 'old_sample_interval = *((unsigned long
*)kp->arg)' somewhere before, and add a '&& !old_sample_interval',
because if old_sample_interval!=0 then KFENCE was disabled due to a
KFENCE_WARN_ON(). Also in this case, it should return -EINVAL. So you
want a flow like this:

old_sample_interval = ...;
...
if (num && !READ_ONCE(kfence_enabled) && system_state != SYSTEM_BOOTING)
  return old_sample_interval ? -EINVAL : kfence_enable_late();
...

Thanks,
-- Marco
