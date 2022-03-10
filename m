Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6554D4D4C52
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241066AbiCJOzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 09:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345153AbiCJOlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:41:40 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ADA18CC57
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 06:36:11 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id g16-20020a05660226d000b00638d8e1828bso3978553ioo.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 06:36:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=/nFRmxTez6K2Yscezf65lFNbRB6MilZeTX4ziqTbL08=;
        b=lWuBw27XouIi/9Aj2A3R5LIY4zAvqoE6Tz0Q8GOqPbEk7RxwkqyRbWkyZl6rpIK8N4
         iNrEuIlrPT/O6OzzOoHVQfkixq4OA4LDDJ4LW8OZSHmnd1pygGwBKd8xzfAhr7tuuWZM
         dplYntMpac6na1E/LgQ2LKqNMJ18Ja9EY5UZtcsHT7C77zODUmzj/31TvpbYyFwb4XHt
         jsxJ/rxedjRyPCQ3jcijGN9f0A+Y/4qiJ/VDl9dCSupn+0qJd08RGtWQ2mD/JTCTcOrp
         M9yGYpj+34+pF2r0wN7ISyWg4VNUjU6f+fS++KVIvXJlyMQMXaZlOjyofeqe0b8tfmRA
         t5kw==
X-Gm-Message-State: AOAM530h6TOf5ZA96VXJqaOZS7/n19op6tOzenZKc5zNdjovt0AIcqLt
        VCoVsdp75Y31LLk9Bf6CDOiPaqKN65s2QFM5kMx3+xwNiO5m
X-Google-Smtp-Source: ABdhPJxSn3psUeIFHx3/jv0fGSrKem5x2i2JnTdYlIfsyrvQuQAUck0rmtM+b50+1xivNLh+j8vT1E+GsRNH0gkFZ0OQfuIXcNFQ
MIME-Version: 1.0
X-Received: by 2002:a5d:9c0f:0:b0:645:bc04:fd5 with SMTP id
 15-20020a5d9c0f000000b00645bc040fd5mr4051907ioe.28.1646922970615; Thu, 10 Mar
 2022 06:36:10 -0800 (PST)
Date:   Thu, 10 Mar 2022 06:36:10 -0800
In-Reply-To: <b7bd6b82-03e3-eac8-21f5-1b05c97c98a3@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a2d7be05d9de2250@google.com>
Subject: Re: [syzbot] memory leak in usb_get_configuration
From:   syzbot <syzbot+f0fae482604e6d9a87c9@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, oneukum@suse.com,
        pavel.hofman@ivitera.com, rob@robgreener.com,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

1] usbcore: registered new interface driver ftdi_sio
[    5.441302][    T1] usbserial: USB Serial support registered for FTDI USB Serial Device
[    5.442817][    T1] usbcore: registered new interface driver garmin_gps
[    5.444351][    T1] usbserial: USB Serial support registered for Garmin GPS usb/tty
[    5.446230][    T1] usbcore: registered new interface driver ipaq
[    5.447590][    T1] usbserial: USB Serial support registered for PocketPC PDA
[    5.448887][    T1] usbcore: registered new interface driver ipw
[    5.450507][    T1] usbserial: USB Serial support registered for IPWireless converter
[    5.452018][    T1] usbcore: registered new interface driver ir_usb
[    5.453200][    T1] usbserial: USB Serial support registered for IR Dongle
[    5.454435][    T1] usbcore: registered new interface driver iuu_phoenix
[    5.455836][    T1] usbserial: USB Serial support registered for iuu_phoenix
[    5.457168][    T1] usbcore: registered new interface driver keyspan
[    5.458324][    T1] usbserial: USB Serial support registered for Keyspan - (without firmware)
[    5.460443][    T1] usbserial: USB Serial support registered for Keyspan 1 port adapter
[    5.461726][    T1] usbserial: USB Serial support registered for Keyspan 2 port adapter
[    5.463474][    T1] usbserial: USB Serial support registered for Keyspan 4 port adapter
[    5.464949][    T1] usbcore: registered new interface driver keyspan_pda
[    5.466125][    T1] usbserial: USB Serial support registered for Keyspan PDA
[    5.467341][    T1] usbserial: USB Serial support registered for Keyspan PDA - (prerenumeration)
[    5.468789][    T1] usbcore: registered new interface driver kl5kusb105
[    5.470271][    T1] usbserial: USB Serial support registered for KL5KUSB105D / PalmConnect
[    5.471764][    T1] usbcore: registered new interface driver kobil_sct
[    5.472861][    T1] usbserial: USB Serial support registered for KOBIL USB smart card terminal
[    5.474462][    T1] usbcore: registered new interface driver mct_u232
[    5.475760][    T1] usbserial: USB Serial support registered for MCT U232
[    5.476978][    T1] usbcore: registered new interface driver metro_usb
[    5.478278][    T1] usbserial: USB Serial support registered for Metrologic USB to Serial
[    5.479903][    T1] usbcore: registered new interface driver mos7720
[    5.481270][    T1] usbserial: USB Serial support registered for Moschip 2 port adapter
[    5.482519][    T1] usbcore: registered new interface driver mos7840
[    5.483564][    T1] usbserial: USB Serial support registered for Moschip 7840/7820 USB Serial Driver
[    5.485397][    T1] usbcore: registered new interface driver mxuport
[    5.486484][    T1] usbserial: USB Serial support registered for MOXA UPort
[    5.487661][    T1] usbcore: registered new interface driver navman
[    5.488684][    T1] usbserial: USB Serial support registered for navman
[    5.489779][    T1] usbcore: registered new interface driver omninet
[    5.491003][    T1] usbserial: USB Serial support registered for ZyXEL - omni.net usb
[    5.492731][    T1] usbcore: registered new interface driver opticon
[    5.494396][    T1] usbserial: USB Serial support registered for opticon
[    5.495708][    T1] usbcore: registered new interface driver option
[    5.496818][    T1] usbserial: USB Serial support registered for GSM modem (1-port)
[    5.498671][    T1] usbcore: registered new interface driver oti6858
[    5.499976][    T1] usbserial: USB Serial support registered for oti6858
[    5.501237][    T1] usbcore: registered new interface driver pl2303
[    5.502576][    T1] usbserial: USB Serial support registered for pl2303
[    5.503913][    T1] usbcore: registered new interface driver qcaux
[    5.505349][    T1] usbserial: USB Serial support registered for qcaux
[    5.506983][    T1] usbcore: registered new interface driver qcserial
[    5.508283][    T1] usbserial: USB Serial support registered for Qualcomm USB modem
[    5.510280][    T1] usbcore: registered new interface driver quatech2
[    5.511377][    T1] usbserial: USB Serial support registered for Quatech 2nd gen USB to Serial Driver
[    5.513067][    T1] usbcore: registered new interface driver safe_serial
[    5.514766][    T1] usbserial: USB Serial support registered for safe_serial
[    5.516333][    T1] usbcore: registered new interface driver sierra
[    5.517494][    T1] usbserial: USB Serial support registered for Sierra USB modem
[    5.519626][    T1] usbcore: registered new interface driver usb_serial_simple
[    5.521363][    T1] usbserial: USB Serial support registered for carelink
[    5.522901][    T1] usbserial: USB Serial support registered for zio
[    5.524620][    T1] usbserial: USB Serial support registered for funsoft
[    5.525949][    T1] usbserial: USB Serial support registered for flashloader
[    5.527179][    T1] usbserial: USB Serial support registered for google
[    5.528746][    T1] usbserial: USB Serial support registered for libtransistor
[    5.530414][    T1] usbserial: USB Serial support registered for vivopay
[    5.531429][    T1] usbserial: USB Serial support registered for moto_modem
[    5.533174][    T1] usbserial: USB Serial support registered for motorola_tetra
[    5.535259][    T1] usbserial: USB Serial support registered for novatel_gps
[    5.536637][    T1] usbserial: USB Serial support registered for hp4x
[    5.537967][    T1] usbserial: USB Serial support registered for suunto
[    5.539315][    T1] usbserial: USB Serial support registered for siemens_mpi
[    5.540670][    T1] usbcore: registered new interface driver spcp8x5
[    5.541718][    T1] usbserial: USB Serial support registered for SPCP8x5
[    5.543047][    T1] usbcore: registered new interface driver ssu100
[    5.544124][    T1] usbserial: USB Serial support registered for Quatech SSU-100 USB to Serial Driver
[    5.546410][    T1] usbcore: registered new interface driver symbolserial
[    5.547622][    T1] usbserial: USB Serial support registered for symbol
[    5.548926][    T1] usbcore: registered new interface driver ti_usb_3410_5052
[    5.550176][    T1] usbserial: USB Serial support registered for TI USB 3410 1 port adapter
[    5.551822][    T1] usbserial: USB Serial support registered for TI USB 5052 2 port adapter
[    5.553865][    T1] usbcore: registered new interface driver upd78f0730
[    5.555511][    T1] usbserial: USB Serial support registered for upd78f0730
[    5.557254][    T1] usbcore: registered new interface driver visor
[    5.558590][    T1] usbserial: USB Serial support registered for Handspring Visor / Palm OS
[    5.559852][    T1] usbserial: USB Serial support registered for Sony Clie 5.0
[    5.561053][    T1] usbserial: USB Serial support registered for Sony Clie 3.5
[    5.562196][    T1] usbcore: registered new interface driver wishbone_serial
[    5.563411][    T1] usbserial: USB Serial support registered for wishbone_serial
[    5.564868][    T1] usbcore: registered new interface driver whiteheat
[    5.566295][    T1] usbserial: USB Serial support registered for Connect Tech - WhiteHEAT - (prerenumeration)
[    5.568057][    T1] usbserial: USB Serial support registered for Connect Tech - WhiteHEAT
[    5.569588][    T1] usbcore: registered new interface driver xr_serial
[    5.570749][    T1] usbserial: USB Serial support registered for xr_serial
[    5.572449][    T1] usbcore: registered new interface driver xsens_mt
[    5.573995][    T1] usbserial: USB Serial support registered for xsens_mt
[    5.575599][    T1] usbcore: registered new interface driver adutux
[    5.576912][    T1] usbcore: registered new interface driver appledisplay
[    5.578299][    T1] usbcore: registered new interface driver cypress_cy7c63
[    5.579875][    T1] usbcore: registered new interface driver cytherm
[    5.581096][    T1] usbcore: registered new interface driver emi26 - firmware loader
[    5.582351][    T1] usbcore: registered new interface driver emi62 - firmware loader
[    5.583692][    T1] ftdi_elan: driver ftdi-elan
[    5.584986][    T1] usbcore: registered new interface driver ftdi-elan
[    5.586395][    T1] usbcore: registered new interface driver idmouse
[    5.587912][    T1] usbcore: registered new interface driver iowarrior
[    5.589125][    T1] usbcore: registered new interface driver isight_firmware
[    5.590448][    T1] usbcore: registered new interface driver usblcd
[    5.591723][    T1] usbcore: registered new interface driver ldusb
[    5.592857][    T1] usbcore: registered new interface driver legousbtower
[    5.594328][    T1] usbcore: registered new interface driver usbtest
[    5.595531][    T1] usbcore: registered new interface driver usb_ehset_test
[    5.596704][    T1] usbcore: registered new interface driver trancevibrator
[    5.597994][    T1] usbcore: registered new interface driver uss720
[    5.599467][    T1] uss720: USB Parport Cable driver for Cables using the Lucent Technologies USS720 Chip
[    5.601116][    T1] uss720: NOTE: this is a special purpose driver to allow nonstandard
[    5.602633][    T1] uss720: protocols (eg. bitbang) over USS720 usb to parallel cables
[    5.604271][    T1] uss720: If you just want to connect to a printer, use usblp instead
[    5.605764][    T1] usbcore: registered new interface driver usbsevseg
[    5.607103][    T1] usbcore: registered new interface driver yurex
[    5.608598][    T1] usbcore: registered new interface driver chaoskey
[    5.609880][    T1] usbcore: registered new interface driver sisusb
[    5.611270][    T1] usbcore: registered new interface driver lvs
[    5.612432][    T1] usbcore: registered new interface driver cxacru
[    5.613741][    T1] usbcore: registered new interface driver speedtch
[    5.615224][    T1] usbcore: registered new interface driver ueagle-atm
[    5.616318][    T1] xusbatm: malformed module parameters
[    5.618076][    T1] dummy_hcd dummy_hcd.0: USB Host+Gadget Emulator, driver 02 May 2005
[    5.619418][    T1] dummy_hcd dummy_hcd.0: Dummy host controller
[    5.620801][    T1] dummy_hcd dummy_hcd.0: new USB bus registered, assigned bus number 1
[    5.622385][    T1] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.17
[    5.623968][    T1] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.625214][    T1] usb usb1: Product: Dummy host controller
[    5.626042][    T1] usb usb1: Manufacturer: Linux 5.17.0-rc6-syzkaller-00242-g0014404f9c18-dirty dummy_hcd
[    5.627434][    T1] usb usb1: SerialNumber: dummy_hcd.0
[    5.628888][    T1] BUG: kernel NULL pointer dereference, address: 0000000000000004
[    5.630204][    T1] #PF: supervisor read access in kernel mode
[    5.631138][    T1] #PF: error_code(0x0000) - not-present page
[    5.632065][    T1] PGD 0 P4D 0 
[    5.632713][    T1] Oops: 0000 [#1] PREEMPT SMP
[    5.633380][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc6-syzkaller-00242-g0014404f9c18-dirty #0
[    5.635094][    T1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[    5.636772][    T1] RIP: 0010:usb_choose_configuration.part.0+0x1d0/0x4c0
[    5.637898][    T1] Code: bf 6b fe 41 39 ed 0f 8e ae 01 00 00 49 83 c4 01 83 c5 01 48 81 c3 a8 02 00 00 48 8d 83 58 fd ff ff 48 89 04 24 e8 e0 ba 6b fe <44> 0f b6 bb 5c fd ff ff 31 ff 44 89 fe e8 9e c0 6b fe 45 84 ff 0f
[    5.638381][    T1] RSP: 0000:ffffc90000e737d8 EFLAGS: 00010293
[    5.638381][    T1] RAX: 0000000000000000 RBX: 00000000000002a8 RCX: 0000000000000000
[    5.638381][    T1] RDX: ffff88810121e040 RSI: ffffffff82ca46e0 RDI: 0000000000000003
[    5.638381][    T1] RBP: 0000000000000001 R08: 0000000000000004 R09: 0000000000000000
[    5.638381][    T1] R10: ffffffff82ca4562 R11: 0000000000000000 R12: 0000000000000000
[    5.638381][    T1] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
[    5.638381][    T1] FS:  0000000000000000(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
[    5.638381][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.638381][    T1] CR2: 0000000000000004 CR3: 0000000005a29000 CR4: 00000000003506e0
[    5.638381][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    5.638381][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    5.638381][    T1] Call Trace:
[    5.638381][    T1]  <TASK>
[    5.638381][    T1]  ? kernfs_create_link+0xb5/0xf0
[    5.638381][    T1]  usb_generic_driver_probe+0x52/0xc0
[    5.638381][    T1]  usb_probe_device+0x5c/0x140
[    5.638381][    T1]  ? unbind_marked_interfaces.isra.0+0xb0/0xb0
[    5.638381][    T1]  really_probe.part.0+0xe7/0x380
[    5.638381][    T1]  __driver_probe_device+0x10c/0x1e0
[    5.638381][    T1]  driver_probe_device+0x2a/0x120
[    5.638381][    T1]  __device_attach_driver+0xf6/0x140
[    5.638381][    T1]  ? driver_allows_async_probing+0x90/0x90
[    5.638381][    T1]  bus_for_each_drv+0xb7/0x100
[    5.638381][    T1]  __device_attach+0x122/0x260
[    5.638381][    T1]  bus_probe_device+0xc6/0xe0
[    5.638381][    T1]  device_add+0x5fb/0xdf0
[    5.638381][    T1]  ? _raw_spin_unlock_irqrestore+0x24/0x40
[    5.638381][    T1]  ? add_device_randomness+0xa8/0x2c0
[    5.638381][    T1]  usb_new_device.cold+0x10f/0x58e
[    5.638381][    T1]  usb_add_hcd.cold+0x651/0x8ec
[    5.638381][    T1]  dummy_hcd_probe+0xee/0x1d5
[    5.638381][    T1]  ? dummy_hcd_suspend.cold+0x20/0x20
[    5.638381][    T1]  platform_probe+0x81/0x120
[    5.638381][    T1]  ? platform_remove+0x50/0x50
[    5.638381][    T1]  really_probe.part.0+0xe7/0x380
[    5.638381][    T1]  __driver_probe_device+0x10c/0x1e0
[    5.638381][    T1]  driver_probe_device+0x2a/0x120
[    5.638381][    T1]  __device_attach_driver+0xf6/0x140
[    5.638381][    T1]  ? driver_allows_async_probing+0x90/0x90
[    5.638381][    T1]  bus_for_each_drv+0xb7/0x100
[    5.638381][    T1]  __device_attach+0x122/0x260
[    5.638381][    T1]  bus_probe_device+0xc6/0xe0
[    5.638381][    T1]  device_add+0x5fb/0xdf0
[    5.638381][    T1]  ? dev_set_name+0x63/0x90
[    5.638381][    T1]  platform_device_add+0x1d7/0x320
[    5.638381][    T1]  init+0x323/0x5ef
[    5.638381][    T1]  ? usb_udc_init+0x78/0x78
[    5.638381][    T1]  do_one_initcall+0x63/0x2e0
[    5.638381][    T1]  kernel_init_freeable+0x255/0x2cf
[    5.638381][    T1]  ? rest_init+0xd0/0xd0
[    5.638381][    T1]  kernel_init+0x1a/0x1c0
[    5.638381][    T1]  ? rest_init+0xd0/0xd0
[    5.638381][    T1]  ret_from_fork+0x1f/0x30
[    5.638381][    T1]  </TASK>
[    5.638381][    T1] Modules linked in:
[    5.638381][    T1] CR2: 0000000000000004
[    5.638381][    T1] ---[ end trace 0000000000000000 ]---
[    5.638381][    T1] RIP: 0010:usb_choose_configuration.part.0+0x1d0/0x4c0
[    5.638381][    T1] Code: bf 6b fe 41 39 ed 0f 8e ae 01 00 00 49 83 c4 01 83 c5 01 48 81 c3 a8 02 00 00 48 8d 83 58 fd ff ff 48 89 04 24 e8 e0 ba 6b fe <44> 0f b6 bb 5c fd ff ff 31 ff 44 89 fe e8 9e c0 6b fe 45 84 ff 0f
[    5.638381][    T1] RSP: 0000:ffffc90000e737d8 EFLAGS: 00010293
[    5.638381][    T1] RAX: 0000000000000000 RBX: 00000000000002a8 RCX: 0000000000000000
[    5.638381][    T1] RDX: ffff88810121e040 RSI: ffffffff82ca46e0 RDI: 0000000000000003
[    5.638381][    T1] RBP: 0000000000000001 R08: 0000000000000004 R09: 0000000000000000
[    5.638381][    T1] R10: ffffffff82ca4562 R11: 0000000000000000 R12: 0000000000000000
[    5.638381][    T1] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
[    5.638381][    T1] FS:  0000000000000000(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
[    5.638381][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.638381][    T1] CR2: 0000000000000004 CR3: 0000000005a29000 CR4: 00000000003506e0
[    5.638381][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    5.638381][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    5.638381][    T1] Kernel panic - not syncing: Fatal exception
[    5.638381][    T1] Kernel Offset: disabled
[    5.638381][    T1] Rebooting in 86400 seconds..


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=125ae129700000


Tested on:

commit:         0014404f Merge branch 'akpm' (patches from Andrew)
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f0a704147ec8e32
dashboard link: https://syzkaller.appspot.com/bug?extid=f0fae482604e6d9a87c9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10e87036700000

