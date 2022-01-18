Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC2A493096
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 23:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349528AbiARWRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 17:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238049AbiARWRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 17:17:01 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C1DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 14:17:01 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id g12so1328942ybh.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 14:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5S+LgNnn3oPUzKLpvxVcoxgN2Wj6vQsIt7IbjeUsy+0=;
        b=V1oWQlTsDWWo7g+Pgp3irTiBKInjc6d6Nj74wfZXV94Rys4xSElevXDxSsWPr63j/D
         iwUxkcBTxc3IrvQV6xqAgIdd6c6V99Zg0DOd8rETGFWlFnQEDgt+icgGajbx5Mbg4N9a
         WZCz/G0HdCXt6xNpc+SBVfqtg6t81Zb/t8fFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5S+LgNnn3oPUzKLpvxVcoxgN2Wj6vQsIt7IbjeUsy+0=;
        b=depaL6yvDu9QMmyFCDih1Ics0OnDcaa18RN71HVIuki9g5Kp9mCeqQ7Qvq1h6xLWvB
         8w+sJNXMpnfYM3KhlgEGj8e0A3PxxM3+0NVDmhOl52wVASulDy+Y8db+TK8c8eRHSmY4
         3Io9Xy4Rf0f3KBWB1Uf16tVUwpYr8LV38wrP8cEuSGAsie/nmI9QtKDev8lS0iWDgQWG
         dipSYkrtHDSPebodo3DqBMO/9BrJAFPo9EOiIIh2fPaapHryyOxvoZTK8eS5a2GevTF7
         9qlwsrM8kPZhnmT7+QAZCB5JJ06bWAYmvGt4/tT25nfzq21ol3iBlz0WgspYEkBxMR15
         Mx4A==
X-Gm-Message-State: AOAM530ZSJ7CGBe5GqXPCrC1vk3ueRKjigpvR/fTORmNKA9Vc/d/h9td
        VA5yceQjqz6ZpM7Ys7F6EjweVxmazdldZfpNhoB+Eg==
X-Google-Smtp-Source: ABdhPJzuI7b6muU5qxv/7lxAmqvI/4FgnXUfZf/fuCu24r9ntEArcOHv5Xkt/rPbTdwe3wFmK6ieWDrTBpYhTuPVkSk=
X-Received: by 2002:a25:3f46:: with SMTP id m67mr33091169yba.656.1642544220767;
 Tue, 18 Jan 2022 14:17:00 -0800 (PST)
MIME-Version: 1.0
References: <20220118163754.nfy53mfjpazgw2a2@eve> <YecV+rh/4rzygUbx@google.com>
 <CACeCKaeHAV1RLovgMt43uFtHioOeKNrqEbaPq8ZtKNiCS_tTsQ@mail.gmail.com>
 <CACeCKac0BctZae4n2CiAnpD4J-Dn+h2ROkx7CEVA9EmnobbNUw@mail.gmail.com> <CAFTm+6APx0PkRgp+7LLEOi=2E-7ZSgYdQ824U1XB+q1wMPNg3g@mail.gmail.com>
In-Reply-To: <CAFTm+6APx0PkRgp+7LLEOi=2E-7ZSgYdQ824U1XB+q1wMPNg3g@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 18 Jan 2022 14:16:49 -0800
Message-ID: <CACeCKaeAaS3QcLwvcPNYVtkKxaBViij53TBjOXvwcpKQk+NDbA@mail.gmail.com>
Subject: Re: Null pointer dereference in cros-ec-typec
To:     "Mr. Chromebox" <mrchromebox@gmail.com>
Cc:     Benson Leung <bleung@google.com>, Alyssa Ross <hi@alyssa.is>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

On Tue, Jan 18, 2022 at 2:04 PM Mr. Chromebox <mrchromebox@gmail.com> wrote=
:
>
> hi Prashant,
>
> my releases track upstream coreboot; my most recent release was based
> on coreboot 4.14 (I'm behind on getting a 4.15-based release out).
>
> A quick perusal of the source for src/ec/google/chromeec/ doesn't show
> any recent changes to the location of the GOOG0014 ACPI device. The
> most recent change was 2 years ago (so, landed in the 4.12 release),
> which moved the USB-C child device to its present location: under
> \_SB.PCI0.LPCB.EC0.CREC
>
> ref: https://github.com/coreboot/coreboot/commit/eec30f7beae074c3f80a182c=
c2950ed8e4f0a640
>
> prior to that, it was located under  \_SB.PCI0.LPCB.EC0.
>
> I also dumped/disassembled the ACPI from a recent build to confirm the ab=
ove.

Is it possible to share the disassembled ACPI tables? We can then
compare it to the ones on shipping Chromebooks to identify a
discrepancy.
If the GOOG0014 device is correctly listed as a child of the EC device
(GOOG0004), then the kernel ACPI framework should be setting
GOOG0004 as a parent (and dev_get_drvdata(pdev->dev.parent) shouldn't
return NULL).
>
> regards,
> Matt / MrChromebox
>
> On Tue, Jan 18, 2022 at 2:12 PM Prashant Malani <pmalani@chromium.org> wr=
ote:
> >
> > (+Mr.Chromebox team; using the address listed in
> > https://mrchromebox.tech/#support )
> >
> > Hi Team Mr.Chromebox,
> >
> > Could you kindly provide some more detail regarding how the GOOG0014
> > Type C ACPI device is set up in the Mr Chromebox BIOS for Chromebooks
> > (the driver expects it to be embedded in the GOOG0004 EC device)?
> > We want to enable Alyssa and other developers using the Mr.Chromebox
> > BIOS to have a functional cros-ec-typec driver, so would like to help
> > ensure that the device is set up correctly in ACPI.
> >
> > Thanks!
> >
> > -Prashant
> >
> > On Tue, Jan 18, 2022 at 11:49 AM Prashant Malani <pmalani@chromium.org>=
 wrote:
> > >
> > > Hi Benson and Alyssa,
> > >
> > > On Tue, Jan 18, 2022 at 11:33 AM Benson Leung <bleung@google.com> wro=
te:
> > > >
> > > > Hi Alyssa,
> > > >
> > > > Thanks for reaching out.
> > > >
> > > > On Tue, Jan 18, 2022 at 04:37:54PM +0000, Alyssa Ross wrote:
> > > > > My distribution recently enabled the Chrome OS EC Type C control =
driver
> > > > > in its kernel builds.  On my Google Pixelbook i7 (eve), the drive=
r reports
> > > > > a null pointer dereference at boot.  From what I can tell, this h=
appens
> > > > > because typec->ec is set to NULL in cros_typec_probe.  Other driv=
ers,
> > > > > like cros-usbpd-notify, appear to be set up to handle this case. =
 As a
> > > > > result of this bug, I'm no longer able to reboot my computer, bec=
ause
> > > > > udevd hangs while trying to do something with the device whose dr=
iver
> > > > > isn't working.
> > > > >
> > > >
> > > > I've copied Prashant, who's the author of the typec driver as well =
as
> > > > cros-usbpd-notify.
> > > >
> > > > Prashant, any thoughts on a more graceful failure out of the typec =
driver's
> > > > probe in case there's no ec object?
> > >
> > > We can add a NULL check and just abort the driver probe if the pointe=
r is
> > > not valid (the driver is useless without that pointer anyway).
> > >
> > > A note: The NULL check makes sense on older drivers like cros-usbpd-n=
otify since
> > > they can exist in ACPI configurations where they are *not* embedded
> > > inside the GOOG0004
> > > EC device (on older Chromebooks). That is not the case for the EC Typ=
e C device.
> > >
> > > This raises another issue: the custom BIOS from Mr. Chromebox is
> > > likely not setting
> > > up the EC Type C ACPI (GOOG0014) device correctly; it *must* be
> > > embedded inside the overall
> > > EC device (GOOG0004). If this is not being done, then the GOOG0014
> > > device should not
> > > be added to the ACPI tables at all.
> > >
> > > I would like to understand whether the above was intentional from the
> > > Mr. Chromebox BIOS developers;
> > > otherwise we are letting an incorrect ACPI configuration just fail
> > > with a probe error.
> > >
> > > Thanks,
> > >
> > > -Prashant
> > >
> > > >
> > > > > Here's the full Oops.  I was able to reproduce the issue with eve=
ry
> > > > > kernel I tried, from 5.10 to mainline.
> > > > >
> > > > > cros-usbpd-notify-acpi GOOG0003:00: Couldn't get Chrome EC device=
 pointer.
> > > > > input: Intel Virtual Buttons as /devices/pci0000:00/0000:00:1f.0/=
PNP0C09:00/INT33D6:00/input/input14
> > > > > BUG: kernel NULL pointer dereference, address: 00000000000000d8
> > > > > #PF: supervisor read access in kernel mode
> > > > > #PF: error_code(0x0000) - not-present page
> > > > > PGD 0 P4D 0
> > > > > Oops: 0000 [#1] SMP PTI
> > > > > CPU: 1 PID: 561 Comm: systemd-udevd Not tainted 5.15.12 #4
> > > > > Hardware name: Google Eve/Eve, BIOS MrChromebox-4.14 08/06/2021
> > > >
> > > >
> > > > Ah, here's the problem. It looks like this is a custom bios from Mr=
 Chromebox,
> > > > so this is not a bios combination we validate at Google.
> > > >
> > > > Thank you for the report. We'll look into fixing this and marking t=
he fix
> > > > for stable kernels so that it goes back to 5.10.
> > > >
> > > > Thanks,
> > > >
> > > > Benson
> > > >
> > > > > RIP: 0010:__mutex_lock+0x59/0x8c0
> > > > > Code: 53 48 89 cb 48 83 ec 70 89 75 9c be 3d 02 00 00 4c 89 45 90=
 e8 18 47 33 ff e8 e3 e2 ff ff 44 8b 35 a4 85 e8 02 45 85 f6 75 0a <4d> 3b =
6d 68 0f 85 bf 07 00 00 65 ff 05 b6 5b 23 75 ff 75 90 4d 8d
> > > > > RSP: 0018:ffffb44580a4bb50 EFLAGS: 00010246
> > > > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
> > > > > RDX: 0000000000000000 RSI: ffffffff8bf91320 RDI: ffff922cbba50e20
> > > > > RBP: ffffb44580a4bbf0 R08: 0000000000000000 R09: ffff922c5bac8140
> > > > > R10: ffffb44580a4bc10 R11: 0000000000000000 R12: 0000000000000000
> > > > > R13: 0000000000000070 R14: 0000000000000000 R15: 0000000000000001
> > > > > FS:  00007f55338d6b40(0000) GS:ffff922fae200000(0000) knlGS:00000=
00000000000
> > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > CR2: 00000000000000d8 CR3: 000000011bbb2006 CR4: 00000000003706e0
> > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > > Call Trace:
> > > > >  <TASK>
> > > > >  ? fs_reclaim_acquire+0x4d/0xd0
> > > > >  ? lock_is_held_type+0xaa/0x120
> > > > >  ? cros_ec_cmd_xfer_status+0x1f/0x110
> > > > >  ? lock_is_held_type+0xaa/0x120
> > > > >  ? cros_ec_cmd_xfer_status+0x1f/0x110
> > > > >  cros_ec_cmd_xfer_status+0x1f/0x110
> > > > >  cros_typec_ec_command+0x91/0x1c0 [cros_ec_typec]
> > > > >  cros_typec_probe+0x7f/0x5a8 [cros_ec_typec]
> > > > >  platform_probe+0x3f/0x90
> > > > >  really_probe+0x1f5/0x3f0
> > > > >  __driver_probe_device+0xfe/0x180
> > > > >  driver_probe_device+0x1e/0x90
> > > > >  __driver_attach+0xc4/0x1d0
> > > > >  ? __device_attach_driver+0xe0/0xe0
> > > > >  ? __device_attach_driver+0xe0/0xe0
> > > > >  bus_for_each_dev+0x67/0x90
> > > > >  bus_add_driver+0x12e/0x1f0
> > > > >  driver_register+0x8f/0xe0
> > > > >  ? 0xffffffffc04ec000
> > > > >  do_one_initcall+0x67/0x320
> > > > >  ? rcu_read_lock_sched_held+0x3f/0x80
> > > > >  ? trace_kmalloc+0x38/0xe0
> > > > >  ? kmem_cache_alloc_trace+0x17c/0x2b0
> > > > >  do_init_module+0x5c/0x270
> > > > >  __do_sys_finit_module+0x95/0xe0
> > > > >  do_syscall_64+0x3b/0x90
> > > > >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > > > RIP: 0033:0x7f55344b1f3d
> > > > > Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8=
 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d =
01 f0 ff ff 73 01 c3 48 8b 0d bb ee 0e 00 f7 d8 64 89 01 48
> > > > > RSP: 002b:00007fff187f1388 EFLAGS: 00000246 ORIG_RAX: 00000000000=
00139
> > > > > RAX: ffffffffffffffda RBX: 000055a53acbe6e0 RCX: 00007f55344b1f3d
> > > > > RDX: 0000000000000000 RSI: 00007f553461732c RDI: 000000000000000e
> > > > > RBP: 0000000000020000 R08: 0000000000000000 R09: 0000000000000002
> > > > > R10: 000000000000000e R11: 0000000000000246 R12: 00007f553461732c
> > > > > R13: 000055a53ad94010 R14: 0000000000000007 R15: 000055a53ad95690
> > > > >  </TASK>
> > > > > Modules linked in: fjes(+) cros_ec_typec(+) typec intel_vbtn(+) c=
ros_usbpd_notify sparse_keymap soc_button_array int3403_thermal int340x_the=
rmal_zone int3400_thermal acpi_thermal_rel cros_kbd_led_backlight zram ip_t=
ables i915 hid_multitouch i2c_algo_bit ttm crct10dif_pclmul crc32_pclmul cr=
c32c_intel drm_kms_helper nvme ghash_clmulni_intel sdhci_pci cqhci cec nvme=
_core sdhci serio_raw drm mmc_core i2c_hid_acpi i2c_hid video pinctrl_sunri=
sepoint fuse
> > > > > CR2: 00000000000000d8
> > > > > ---[ end trace 4a12c4896d70352b ]---
> > > >
> > > >
> > > >
> > > > --
> > > > Benson Leung
> > > > Staff Software Engineer
> > > > Chrome OS Kernel
> > > > Google Inc.
> > > > bleung@google.com
> > > > Chromium OS Project
> > > > bleung@chromium.org
