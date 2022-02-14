Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E6B4B3FBD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 03:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbiBNCim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 21:38:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbiBNCil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 21:38:41 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9174219288
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:38:34 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id i62so18345056ioa.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fhTIyjQrks8YWYHGKpnJ4cPHVuWtXADAbz/+ltcbh1A=;
        b=LA6BJe7r2AxyUTpA9+4vDIumOI8DEq/578pErvLSQ25QixnhCo64ib7ECk3zNNpCu/
         CCc5d5l9rVlINhmb38kQ2+N58wJ1aCNLvWi8b7twh276IzxQ/FZkhSeN7c6WndeLm7bs
         SLXT4tqkD8Y5i2KpqhbQxibHff22H/uAu3wbVqVIEVeWfws3T2lxnkLOXKUub7ZiH4sG
         RKxvnvkeK8oxJ6dOyvVTG+A0Lvm007O1g33FBEyA9nJf64KatYVNaU6KdlN4fQ9VXZcA
         cBGtYTKppalPV4Jdux/nTdUjKWrOk3dhQ88AkkK6OlxLjfr+VljT9g/nPdqL+ZGCY5Xd
         2rQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fhTIyjQrks8YWYHGKpnJ4cPHVuWtXADAbz/+ltcbh1A=;
        b=aLtDfOSkWNwkelT5Slr8tY/5f5CKF9JOn1VMXJn04gR7nJp59srNdDb7WkiQNhnZbz
         fLyEEl5Q4yeqR8P1DKTEHaIQI6hUzzfHtjujkBsOiLjBG+wKx/6Kbt9hwDNiG3UyxJhW
         C5vjV7vPJFZlxxDUWLCl0TYxduv5BGyNcnNdliGlHHgnoJ6q3Y7FrEec9qq5+W547E33
         V2ZMVsxWqgX71vTE+0NsGkUYEOwWmsBuunYdhSvUgpiv8+RafJXSE63hzwISzIVQuzPq
         XuLAYyXhKSZhZUPvpP2gM1+N2fxjBil3ZpbKKx1C5AuvIlJxX4ZInow4P4/TU3wGhOVu
         kkUw==
X-Gm-Message-State: AOAM533Bfa3IkytIB264lknzgyipIOlHnovMUD0iJUDcpuLgp18ewQWk
        ms6ME08QBxqrd9aYyGzaa+qtQtPkWulvwFqSYGF0Th0=
X-Google-Smtp-Source: ABdhPJyBbWmL8660Hetk2PGEYDWi2fCeOCo3RF0+NkL6Y4PDXeID9C2NZCchB5mBK7PntThAulqm9uZrpnqIoJoQSvE=
X-Received: by 2002:a5e:d610:: with SMTP id w16mr6092572iom.87.1644806313873;
 Sun, 13 Feb 2022 18:38:33 -0800 (PST)
MIME-Version: 1.0
References: <20220127090215.32000-1-kernelfans@gmail.com>
In-Reply-To: <20220127090215.32000-1-kernelfans@gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 14 Feb 2022 10:38:22 +0800
Message-ID: <CAFgQCTsVyH5mctKeYpBJY3GvmODDMq3xmqT+z0C0pOZNjjPXxw@mail.gmail.com>
Subject: Re: [PATCHv2] kexec: disable cpu hotplug until the rebooting cpu is stable
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Baokun Li <libaokun1@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kexec Mailing List <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gently ping, maintainers, could you share your opinions?


Thanks

On Thu, Jan 27, 2022 at 5:02 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> The following identical code piece appears in both
> migrate_to_reboot_cpu() and smp_shutdown_nonboot_cpus():
>
>         if (!cpu_online(primary_cpu))
>                 primary_cpu = cpumask_first(cpu_online_mask);
>
> This is due to a breakage like the following:
>    migrate_to_reboot_cpu();
>    cpu_hotplug_enable();
>                           --> comes a cpu_down(this_cpu) on other cpu
>    machine_shutdown();
>
> Although the kexec-reboot task can get through a cpu_down() on its cpu,
> this code looks a little confusing.
>
> Make things straight forward by keeping cpu hotplug disabled until
> smp_shutdown_nonboot_cpus() holds cpu_add_remove_lock. By this way, the
> breakage is squashed out and the rebooting cpu can keep unchanged.
>
> Note: this patch only affects the kexec-reboot on arches, which rely on
> cpu hotplug mechanism.
>
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Vincent Donnefort <vincent.donnefort@arm.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: YueHaibing <yuehaibing@huawei.com>
> Cc: Baokun Li <libaokun1@huawei.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: kexec@lists.infradead.org
> To: linux-kernel@vger.kernel.org
> ---
> v1 -> v2:
>  improve commit log
>
>  kernel/cpu.c        | 16 ++++++++++------
>  kernel/kexec_core.c | 10 ++++------
>  2 files changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 9c92147f0812..87bdf21de950 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1240,20 +1240,24 @@ int remove_cpu(unsigned int cpu)
>  }
>  EXPORT_SYMBOL_GPL(remove_cpu);
>
> +/* primary_cpu keeps unchanged after migrate_to_reboot_cpu() */
>  void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
>  {
>         unsigned int cpu;
>         int error;
>
> +       /*
> +        * Block other cpu hotplug event, so primary_cpu is always online if
> +        * it is not touched by us
> +        */
>         cpu_maps_update_begin();
> -
>         /*
> -        * Make certain the cpu I'm about to reboot on is online.
> -        *
> -        * This is inline to what migrate_to_reboot_cpu() already do.
> +        * migrate_to_reboot_cpu() disables CPU hotplug assuming that
> +        * no further code needs to use CPU hotplug (which is true in
> +        * the reboot case). However, the kexec path depends on using
> +        * CPU hotplug again; so re-enable it here.
>          */
> -       if (!cpu_online(primary_cpu))
> -               primary_cpu = cpumask_first(cpu_online_mask);
> +       __cpu_hotplug_enable();
>
>         for_each_online_cpu(cpu) {
>                 if (cpu == primary_cpu)
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 68480f731192..db4fa6b174e3 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1168,14 +1168,12 @@ int kernel_kexec(void)
>                 kexec_in_progress = true;
>                 kernel_restart_prepare("kexec reboot");
>                 migrate_to_reboot_cpu();
> -
>                 /*
> -                * migrate_to_reboot_cpu() disables CPU hotplug assuming that
> -                * no further code needs to use CPU hotplug (which is true in
> -                * the reboot case). However, the kexec path depends on using
> -                * CPU hotplug again; so re-enable it here.
> +                * migrate_to_reboot_cpu() disables CPU hotplug. If an arch
> +                * relies on the cpu teardown to achieve reboot, it needs to
> +                * re-enable CPU hotplug there.
>                  */
> -               cpu_hotplug_enable();
> +
>                 pr_notice("Starting new kernel\n");
>                 machine_shutdown();
>         }
> --
> 2.31.1
>
