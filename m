Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AE354545B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241566AbiFISpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239383AbiFISpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:45:07 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32255BF66;
        Thu,  9 Jun 2022 11:45:05 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-313a8a8b95aso16748147b3.5;
        Thu, 09 Jun 2022 11:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ketC8ANShl5T/DJexVfPFGmyQceFPvOn5sBuN5PaWWk=;
        b=nO+cJIgvAEpEMw7IkKrm8K4sYZf+I+tRqq49YMI7zB/bNslMY1iwLKAwVed4XBhM1j
         1ZEyvQlVexphHb9JAHEIpYsL3bUx5Ki74plVKUudpIL0RfW/HbGr88RX6bk9okAVgLQM
         Lm0UMLcSXdFNUpNXCdOpwKN6sQ3qKk4XpptrA7kwVg31KUuuZgJoSh5xj+HSYMycvl0c
         08x712zroJnF0fWSD/7tVv68ctyxItLft+3OeARWngoj0fGfHStOLNgBPmWCxZjHC/Wy
         TQW0FvYku5y3xnhTwt9hXNDoRy4DIVuTXbvgJCcet4FRVunQDVTCygCseZ3lQ4UKakNc
         VWlg==
X-Gm-Message-State: AOAM532oJa0TrANIUzFPgJRrzybjqdYxDiZ9pFWJKF/X8abl642YEySs
        5R8INs6Tv/6sYvZ/kYBW9GJWCJaoB/gmUdxhLBI=
X-Google-Smtp-Source: ABdhPJzaSV2Ou7aW6ZlIz1jOmShiXqw5dvran8jtr+6HB5ThEBFSoVgxH+xh5yCwJo4tKLw6Zu2MkDdF0Rbhq7drggE=
X-Received: by 2002:a81:1341:0:b0:30c:3a7e:65e9 with SMTP id
 62-20020a811341000000b0030c3a7e65e9mr46370847ywt.7.1654800304445; Thu, 09 Jun
 2022 11:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220607222458.1864805-1-gpiccoli@igalia.com>
In-Reply-To: <20220607222458.1864805-1-gpiccoli@igalia.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Jun 2022 20:44:53 +0200
Message-ID: <CAJZ5v0j-g66TEizAV+j5it_uKkf+=+259yqNNkzJjUtL79=d9w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor/idle: Annotate more functions to live in
 cpuidle section
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        kernel@gpiccoli.net, kernel-dev@igalia.com,
        Len Brown <lenb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
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

On Wed, Jun 8, 2022 at 12:25 AM Guilherme G. Piccoli
<gpiccoli@igalia.com> wrote:
>
> Commit 6727ad9e206c ("nmi_backtrace: generate one-line reports for idle cpus")
> introduced a new text section called cpuidle; with that, we have a mechanism
> to add idling functions in such section and skip them from nmi_backtrace
> output, since they're useless and potentially flooding for such report.
>
> Happens that inlining might cause some real idle functions to end-up
> outside of such section; this is currently the case of ACPI processor_idle
> driver; the functions acpi_idle_enter_* do inline acpi_idle_do_entry(),
> hence they stay out of the cpuidle section.
> Fix that by marking such functions to also live in the cpuidle section.
>
> Fixes: 6727ad9e206c ("nmi_backtrace: generate one-line reports for idle cpus")
> Cc: Len Brown <lenb@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>
> Hi folks, this was tested on top of v5.19-rc1, with sysrq-l.
>
> An alternative for this approach would be to mark acpi_idle_do_entry()
> as noinline, but I'd risk to say that's a bit worse performance-wise.
> Let me know your preference, I can rework the patch if you prefer =)
>
> Thanks in advance for reviews,
>
>
> Guilherme
>
>
>  drivers/acpi/processor_idle.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 6a5572a1a80c..13200969ccf3 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -607,7 +607,7 @@ static DEFINE_RAW_SPINLOCK(c3_lock);
>   * @cx: Target state context
>   * @index: index of target state
>   */
> -static int acpi_idle_enter_bm(struct cpuidle_driver *drv,
> +static int __cpuidle acpi_idle_enter_bm(struct cpuidle_driver *drv,
>                                struct acpi_processor *pr,
>                                struct acpi_processor_cx *cx,
>                                int index)
> @@ -664,7 +664,7 @@ static int acpi_idle_enter_bm(struct cpuidle_driver *drv,
>         return index;
>  }
>
> -static int acpi_idle_enter(struct cpuidle_device *dev,
> +static int __cpuidle acpi_idle_enter(struct cpuidle_device *dev,
>                            struct cpuidle_driver *drv, int index)
>  {
>         struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
> @@ -693,7 +693,7 @@ static int acpi_idle_enter(struct cpuidle_device *dev,
>         return index;
>  }
>
> -static int acpi_idle_enter_s2idle(struct cpuidle_device *dev,
> +static int __cpuidle acpi_idle_enter_s2idle(struct cpuidle_device *dev,
>                                   struct cpuidle_driver *drv, int index)
>  {
>         struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
> --

Applied as 5.20 material, thanks!
