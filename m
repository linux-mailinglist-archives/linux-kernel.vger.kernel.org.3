Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24BB492EB6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 20:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348931AbiARTuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 14:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240120AbiARTty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:49:54 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDC8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 11:49:54 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 23so175589ybf.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 11:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SPNUEWy64jcIESJR21s2AAiZ0oxHG9SyOta1sOy+ejA=;
        b=b3F4sC/tGUxdR1CB6JzE8wzqSNHwIHiQyUms34qTLiR6m2TosmVhLs8qRa734b/JqZ
         bK3DFbdqaNA26GuMqT5zEizNzjiuno6vD9YHsRKqLXWcaoCu/mjCohF8rfX8D2mFpWOy
         NmFf/AgBoV4fCGNKf8Hxa89b5l8BCkJBUMf+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SPNUEWy64jcIESJR21s2AAiZ0oxHG9SyOta1sOy+ejA=;
        b=ac3/P1Xd4OXm2wyMz2VHUg9uHLeZzvu2f4gULV2M8vg8S2hGv1EU95fp3/0M6fRh+9
         LBZo5ZcAVZRLbJeB6H1JDaeQ62i7H+xqMfTXoPq5ldobJfB+p1DlIZ173GxpKc22Iau1
         KkZa1GCHDo60WXPWS8Kt0SwCH9Q0dqZKd+9DgYIjEhvDyiJgpN2beCd7cSvZv6sKVCp1
         jF44viSqUYbsSYMxvMvtvlTWTA+rk1q2ozF84MqLXc0z78GCh2emmewth7nv77kl1jKB
         eMaStXFoboofcIvQNb9QJqGmNZFJB+2jX8YO4h8+SwcAaRQeV5YWtgp47fR1OA/wwOGm
         C1IA==
X-Gm-Message-State: AOAM532fofANxoqWwSqVWBhWABz1/s9qNrK4QUTt/IF3wKs/HO/oybdd
        CL+Qn3JySKtyED8eV/5bL2FRMM10wZN9L7LVKZN0scLlsgYgww==
X-Google-Smtp-Source: ABdhPJyIAJHP7eAqaMetfAtJTS6NAvSXq4nywHiTeQHFAFp6C3356+Z9jPyDinvTWPU8iFbF8EV+xSCquPXQXmPeuKk=
X-Received: by 2002:a5b:501:: with SMTP id o1mr35246095ybp.454.1642535393291;
 Tue, 18 Jan 2022 11:49:53 -0800 (PST)
MIME-Version: 1.0
References: <20220118163754.nfy53mfjpazgw2a2@eve> <YecV+rh/4rzygUbx@google.com>
In-Reply-To: <YecV+rh/4rzygUbx@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 18 Jan 2022 11:49:42 -0800
Message-ID: <CACeCKaeHAV1RLovgMt43uFtHioOeKNrqEbaPq8ZtKNiCS_tTsQ@mail.gmail.com>
Subject: Re: Null pointer dereference in cros-ec-typec
To:     Benson Leung <bleung@google.com>
Cc:     Alyssa Ross <hi@alyssa.is>, Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benson and Alyssa,

On Tue, Jan 18, 2022 at 11:33 AM Benson Leung <bleung@google.com> wrote:
>
> Hi Alyssa,
>
> Thanks for reaching out.
>
> On Tue, Jan 18, 2022 at 04:37:54PM +0000, Alyssa Ross wrote:
> > My distribution recently enabled the Chrome OS EC Type C control driver
> > in its kernel builds.  On my Google Pixelbook i7 (eve), the driver repo=
rts
> > a null pointer dereference at boot.  From what I can tell, this happens
> > because typec->ec is set to NULL in cros_typec_probe.  Other drivers,
> > like cros-usbpd-notify, appear to be set up to handle this case.  As a
> > result of this bug, I'm no longer able to reboot my computer, because
> > udevd hangs while trying to do something with the device whose driver
> > isn't working.
> >
>
> I've copied Prashant, who's the author of the typec driver as well as
> cros-usbpd-notify.
>
> Prashant, any thoughts on a more graceful failure out of the typec driver=
's
> probe in case there's no ec object?

We can add a NULL check and just abort the driver probe if the pointer is
not valid (the driver is useless without that pointer anyway).

A note: The NULL check makes sense on older drivers like cros-usbpd-notify =
since
they can exist in ACPI configurations where they are *not* embedded
inside the GOOG0004
EC device (on older Chromebooks). That is not the case for the EC Type C de=
vice.

This raises another issue: the custom BIOS from Mr. Chromebox is
likely not setting
up the EC Type C ACPI (GOOG0014) device correctly; it *must* be
embedded inside the overall
EC device (GOOG0004). If this is not being done, then the GOOG0014
device should not
be added to the ACPI tables at all.

I would like to understand whether the above was intentional from the
Mr. Chromebox BIOS developers;
otherwise we are letting an incorrect ACPI configuration just fail
with a probe error.

Thanks,

-Prashant

>
> > Here's the full Oops.  I was able to reproduce the issue with every
> > kernel I tried, from 5.10 to mainline.
> >
> > cros-usbpd-notify-acpi GOOG0003:00: Couldn't get Chrome EC device point=
er.
> > input: Intel Virtual Buttons as /devices/pci0000:00/0000:00:1f.0/PNP0C0=
9:00/INT33D6:00/input/input14
> > BUG: kernel NULL pointer dereference, address: 00000000000000d8
> > #PF: supervisor read access in kernel mode
> > #PF: error_code(0x0000) - not-present page
> > PGD 0 P4D 0
> > Oops: 0000 [#1] SMP PTI
> > CPU: 1 PID: 561 Comm: systemd-udevd Not tainted 5.15.12 #4
> > Hardware name: Google Eve/Eve, BIOS MrChromebox-4.14 08/06/2021
>
>
> Ah, here's the problem. It looks like this is a custom bios from Mr Chrom=
ebox,
> so this is not a bios combination we validate at Google.
>
> Thank you for the report. We'll look into fixing this and marking the fix
> for stable kernels so that it goes back to 5.10.
>
> Thanks,
>
> Benson
>
> > RIP: 0010:__mutex_lock+0x59/0x8c0
> > Code: 53 48 89 cb 48 83 ec 70 89 75 9c be 3d 02 00 00 4c 89 45 90 e8 18=
 47 33 ff e8 e3 e2 ff ff 44 8b 35 a4 85 e8 02 45 85 f6 75 0a <4d> 3b 6d 68 =
0f 85 bf 07 00 00 65 ff 05 b6 5b 23 75 ff 75 90 4d 8d
> > RSP: 0018:ffffb44580a4bb50 EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
> > RDX: 0000000000000000 RSI: ffffffff8bf91320 RDI: ffff922cbba50e20
> > RBP: ffffb44580a4bbf0 R08: 0000000000000000 R09: ffff922c5bac8140
> > R10: ffffb44580a4bc10 R11: 0000000000000000 R12: 0000000000000000
> > R13: 0000000000000070 R14: 0000000000000000 R15: 0000000000000001
> > FS:  00007f55338d6b40(0000) GS:ffff922fae200000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00000000000000d8 CR3: 000000011bbb2006 CR4: 00000000003706e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  ? fs_reclaim_acquire+0x4d/0xd0
> >  ? lock_is_held_type+0xaa/0x120
> >  ? cros_ec_cmd_xfer_status+0x1f/0x110
> >  ? lock_is_held_type+0xaa/0x120
> >  ? cros_ec_cmd_xfer_status+0x1f/0x110
> >  cros_ec_cmd_xfer_status+0x1f/0x110
> >  cros_typec_ec_command+0x91/0x1c0 [cros_ec_typec]
> >  cros_typec_probe+0x7f/0x5a8 [cros_ec_typec]
> >  platform_probe+0x3f/0x90
> >  really_probe+0x1f5/0x3f0
> >  __driver_probe_device+0xfe/0x180
> >  driver_probe_device+0x1e/0x90
> >  __driver_attach+0xc4/0x1d0
> >  ? __device_attach_driver+0xe0/0xe0
> >  ? __device_attach_driver+0xe0/0xe0
> >  bus_for_each_dev+0x67/0x90
> >  bus_add_driver+0x12e/0x1f0
> >  driver_register+0x8f/0xe0
> >  ? 0xffffffffc04ec000
> >  do_one_initcall+0x67/0x320
> >  ? rcu_read_lock_sched_held+0x3f/0x80
> >  ? trace_kmalloc+0x38/0xe0
> >  ? kmem_cache_alloc_trace+0x17c/0x2b0
> >  do_init_module+0x5c/0x270
> >  __do_sys_finit_module+0x95/0xe0
> >  do_syscall_64+0x3b/0x90
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > RIP: 0033:0x7f55344b1f3d
> > Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 8b 0d bb ee 0e 00 f7 d8 64 89 01 48
> > RSP: 002b:00007fff187f1388 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> > RAX: ffffffffffffffda RBX: 000055a53acbe6e0 RCX: 00007f55344b1f3d
> > RDX: 0000000000000000 RSI: 00007f553461732c RDI: 000000000000000e
> > RBP: 0000000000020000 R08: 0000000000000000 R09: 0000000000000002
> > R10: 000000000000000e R11: 0000000000000246 R12: 00007f553461732c
> > R13: 000055a53ad94010 R14: 0000000000000007 R15: 000055a53ad95690
> >  </TASK>
> > Modules linked in: fjes(+) cros_ec_typec(+) typec intel_vbtn(+) cros_us=
bpd_notify sparse_keymap soc_button_array int3403_thermal int340x_thermal_z=
one int3400_thermal acpi_thermal_rel cros_kbd_led_backlight zram ip_tables =
i915 hid_multitouch i2c_algo_bit ttm crct10dif_pclmul crc32_pclmul crc32c_i=
ntel drm_kms_helper nvme ghash_clmulni_intel sdhci_pci cqhci cec nvme_core =
sdhci serio_raw drm mmc_core i2c_hid_acpi i2c_hid video pinctrl_sunrisepoin=
t fuse
> > CR2: 00000000000000d8
> > ---[ end trace 4a12c4896d70352b ]---
>
>
>
> --
> Benson Leung
> Staff Software Engineer
> Chrome OS Kernel
> Google Inc.
> bleung@google.com
> Chromium OS Project
> bleung@chromium.org
