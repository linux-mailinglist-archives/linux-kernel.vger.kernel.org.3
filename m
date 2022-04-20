Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B799D508D2F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380530AbiDTQ0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376497AbiDTQ0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:26:45 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAAB3D1F3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:23:59 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id h8so3781284ybj.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mcUG9jT1MP4gZGzrrHFPQrMBUUAYLB2/16OlxpDgwWY=;
        b=nY9QlGpa/L1JQzvLHxjLJvAwIbAq0fWwlRPtc2dM/Ev/sqZs4xZbBEZhdFf8gjK9pX
         oI0+UKjcVkq1dsmAMwtL/BnPkNT0nHocEJiN0LeuDN0UTut3vd0dU0eTnkvZ7SroHxzS
         6ay/yUQ9DVtKIgWjmR2I5MpynMWJHr/+tmB3dw0i6s0Klg7Vy6nyKuWi9oZF94heZrUm
         PiYeWgfHymwSRU3jae4Z0mZfn/yyxBv411ItBYGvKI4v/+924+JQIXdWM/3Yg6dnsGgi
         qH6VqgBQAk5TUucZ9uS7rOnKbRKfP2mVz4veDmvIby3vrY0CSGahDas/qqQuoUqHftGJ
         F2rg==
X-Gm-Message-State: AOAM532MMDFYGowkjvnYWCWZ24v+0HIOjC5kkssOB3P8Zlj9Q0AW1UUs
        bG1uA4WMXYkt9m5L17aqujbWP0r6FmKbOHZjTOSUwAbJ
X-Google-Smtp-Source: ABdhPJyWjpIqJVTaJBzTKbjNHExUScy+MpTY4jLQTcUxMAG9nD1txHvzGK4YxK/U4et3/Zpia43Yq/GPHrhUxWj1r5w=
X-Received: by 2002:a25:e082:0:b0:641:cf5:b91f with SMTP id
 x124-20020a25e082000000b006410cf5b91fmr20653666ybg.482.1650471838920; Wed, 20
 Apr 2022 09:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220420140521.45361-1-kernelfans@gmail.com> <20220420140521.45361-7-kernelfans@gmail.com>
In-Reply-To: <20220420140521.45361-7-kernelfans@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Apr 2022 18:23:48 +0200
Message-ID: <CAJZ5v0h2SWN-=-5=OsMGm1amMJrYELqM6BC+J=98EAxSUmxMqg@mail.gmail.com>
Subject: Re: [PATCH 6/9] pm/irq: make for_each_irq_desc() safe of irq_desc release
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 4:06 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> The invloved context is no a RCU read section. Furthermore there may be
> more than one task at this point. Hence it demands a measure to prevent
> irq_desc from freeing. Use irq_lock_sparse to serve the protection
> purpose.

Can you please describe an example scenario in which the added locking
will prevent a failure from occurring?

> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> To: linux-kernel@vger.kernel.org
> ---
>  kernel/irq/pm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
> index ca71123a6130..4b67a4c7de3c 100644
> --- a/kernel/irq/pm.c
> +++ b/kernel/irq/pm.c
> @@ -133,6 +133,7 @@ void suspend_device_irqs(void)
>         struct irq_desc *desc;
>         int irq;
>
> +       irq_lock_sparse();
>         for_each_irq_desc(irq, desc) {
>                 unsigned long flags;
>                 bool sync;
> @@ -146,6 +147,7 @@ void suspend_device_irqs(void)
>                 if (sync)
>                         synchronize_irq(irq);
>         }
> +       irq_unlock_sparse();
>  }
>  EXPORT_SYMBOL_GPL(suspend_device_irqs);
>
> @@ -186,6 +188,7 @@ static void resume_irqs(bool want_early)
>         struct irq_desc *desc;
>         int irq;
>
> +       /* The early resume stage is free of irq_desc release */
>         for_each_irq_desc(irq, desc) {
>                 unsigned long flags;
>                 bool is_early = desc->action &&
> --
> 2.31.1
>
