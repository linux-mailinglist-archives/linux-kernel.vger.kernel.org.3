Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CA34E9B42
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238285AbiC1Pne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbiC1Pnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:43:33 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4D25F27A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 08:41:51 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so8807850wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 08:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=NcKxCZg+gu8L2J0feDz8KLUFBSMWZ9smUHJWBqlXtWU=;
        b=j8+TROXlzza8JxgN6pVgEDAdEvwNWzzqZlXNDGoX7aP8ix3vC3xd4sziKPrC/WfQ9R
         WgtpXvqvs701VbUFrKx5eX7FaB7Djr7LdKTsm57QpQZm7h7VWy8FAkiiewx3HndAgBhS
         W6aiwlindcu7R0O5VCGqJi52nlu5rim68ARLPFQoS68e0d4Me5/bjsQgPusjp9Fbo/WW
         lLnzw5iXF8sBf/4d4EOYH/2q3V3bBdhmmHcM0vOq1OkecZtdnhofxxj8HLbSM/CpY54n
         7OOeuE6dl8QZJtMagTbVq9kxxNAYbtU5c7WI11Q1f2YNHNPmDPK8eJiCc45vFgdZLYcP
         vnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=NcKxCZg+gu8L2J0feDz8KLUFBSMWZ9smUHJWBqlXtWU=;
        b=H1Zz5J2O1Z3uKfrYMhtfrHOV3vPvFyfO4axyLaAlMUKDc8EXs1fT3U5DiEwmapV3JW
         z01mommDj+9omZp7PyhklOHv30stpb6Z7XA9todmOtBxYxih8d+AP/SGdNUzQsoBV5iY
         99kKPI2iCgwtH5DxZUszlEYWSS/5XtADF+ktK78wlXN5dW/ufpjCvwzYdVWZ2W2p7RL9
         js8lN+lDjJ+8HCH0Oq7OwCyWoSFAARbyzkAMCPAsziwVja0TGBTBFTFiIyn9IND+vY1a
         oa+sTKeRN8WjTh4Z3/+vowIqF0wSnvFD8l4P1fFOT2U0vBLuGuBlnYXPgXDOD+69zsWr
         mAjg==
X-Gm-Message-State: AOAM530d8kfHwoYeVAc6Hfeqj+phixZKsQdOqf7d4ppIWgLRSqaqWEpP
        azlWX7EeMjUCVCNv7SEpnjg=
X-Google-Smtp-Source: ABdhPJyDFwkndZkOr7tdlqjdriS1B6sAiotAGBs8NeuteWJF7tx7Se7Vso3otxLbxbH9pjYcvG32PQ==
X-Received: by 2002:a7b:c347:0:b0:37e:68e6:d85c with SMTP id l7-20020a7bc347000000b0037e68e6d85cmr37600641wmj.176.1648482109742;
        Mon, 28 Mar 2022 08:41:49 -0700 (PDT)
Received: from debian (host-78-145-97-89.as13285.net. [78.145.97.89])
        by smtp.gmail.com with ESMTPSA id b3-20020adfd1c3000000b00205820686dasm14751984wrd.5.2022.03.28.08.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 08:41:49 -0700 (PDT)
Date:   Mon, 28 Mar 2022 16:41:47 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Zack Rusin <zackr@vmware.com>,
        Hans de Goede <hdegoede@redhat.com>,
        torvalds@linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
Subject: regression: NULL pointer dereference due to 27599aacbaef ("fbdev:
 Hot-unplug firmware fb devices on forced removal")
Message-ID: <YkHXO6LGHAN0p1pq@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

We usually run boot tests with linux mainline HEAD commit almost every
night on ppc64 qemu. And my tests had been failing for last few days.
Testing locally gave me:

Mar 28 13:16:36 debian-ppc64 kernel: [   11.038791] BUG: Kernel NULL pointer dereference on read at 0x00000060
Mar 28 13:16:36 debian-ppc64 kernel: [   11.038995] Faulting instruction address: 0xc00000000080dfa4
Mar 28 13:16:36 debian-ppc64 kernel: [   11.039572] Oops: Kernel access of bad area, sig: 11 [#1]
Mar 28 13:16:36 debian-ppc64 kernel: [   11.039723] LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
Mar 28 13:16:36 debian-ppc64 kernel: [   11.040012] Modules linked in: bochs(+) drm_vram_helper xhci_pci drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper sr_mod ttm cdrom xhci_hcd virtio_net virtio_console net_failover virtio_blk virtio_scsi failover ibmvscsi scsi_transport_srp virtio_pci virtio virtio_pci_legacy_dev virtio_pci_modern_dev usbcore drm drm_panel_orientation_quirks virtio_ring usb_common
Mar 28 13:16:36 debian-ppc64 kernel: [   11.040918] CPU: 2 PID: 139 Comm: systemd-udevd Not tainted 5.17.0-ae085d7f9365 #1
Mar 28 13:16:36 debian-ppc64 kernel: [   11.041245] NIP:  c00000000080dfa4 LR: c00000000080df9c CTR: c000000000797430
Mar 28 13:16:36 debian-ppc64 kernel: [   11.041376] REGS: c000000004132fe0 TRAP: 0300   Not tainted  (5.17.0-ae085d7f9365)
Mar 28 13:16:36 debian-ppc64 kernel: [   11.041528] MSR:  8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 28228282  XER: 20000000
Mar 28 13:16:36 debian-ppc64 kernel: [   11.042017] CFAR: c00000000000c80c DAR: 0000000000000060 DSISR: 40000000 IRQMASK: 0 
Mar 28 13:16:36 debian-ppc64 kernel: [   11.042017] GPR00: c00000000080df9c c000000004133280 c00000000169d200 0000000000000029 
Mar 28 13:16:36 debian-ppc64 kernel: [   11.042017] GPR04: 00000000ffffefff c000000004132f90 c000000004132f88 0000000000000000 
Mar 28 13:16:36 debian-ppc64 kernel: [   11.042017] GPR08: c0000000015658f8 c0000000015cd200 c0000000014f57d0 0000000048228283 
Mar 28 13:16:36 debian-ppc64 kernel: [   11.042017] GPR12: 0000000000000000 c00000003fffe300 0000000020000000 0000000000000000 
Mar 28 13:16:36 debian-ppc64 kernel: [   11.042017] GPR16: 0000000000000000 0000000113fc4a40 0000000000000005 0000000113fcfb80 
Mar 28 13:16:36 debian-ppc64 kernel: [   11.042017] GPR20: 000001000f7283b0 0000000000000000 c000000000e4a588 c000000000e4a5b0 
Mar 28 13:16:36 debian-ppc64 kernel: [   11.042017] GPR24: 0000000000000001 00000000000a0000 c008000000db0168 c0000000021f6ec0 
Mar 28 13:16:36 debian-ppc64 kernel: [   11.042017] GPR28: c0000000016d65a8 c000000004b36460 0000000000000000 c0000000016d64b0 
Mar 28 13:16:36 debian-ppc64 kernel: [   11.043184] NIP [c00000000080dfa4] do_remove_conflicting_framebuffers+0x184/0x1d0
Mar 28 13:16:36 debian-ppc64 kernel: [   11.043748] LR [c00000000080df9c] do_remove_conflicting_framebuffers+0x17c/0x1d0
Mar 28 13:16:36 debian-ppc64 kernel: [   11.043982] Call Trace:
Mar 28 13:16:36 debian-ppc64 kernel: [   11.044108] [c000000004133280] [c00000000080df9c] do_remove_conflicting_framebuffers+0x17c/0x1d0 (unreliable)
Mar 28 13:16:36 debian-ppc64 kernel: [   11.044335] [c000000004133350] [c00000000080e4d0] remove_conflicting_framebuffers+0x60/0x150
Mar 28 13:16:36 debian-ppc64 kernel: [   11.044468] [c0000000041333a0] [c00000000080e6f4] remove_conflicting_pci_framebuffers+0x134/0x1b0
Mar 28 13:16:36 debian-ppc64 kernel: [   11.044588] [c000000004133450] [c008000000e70438] drm_aperture_remove_conflicting_pci_framebuffers+0x90/0x100 [drm]
Mar 28 13:16:36 debian-ppc64 kernel: [   11.045443] [c000000004133490] [c008000000da0ce4] bochs_pci_probe+0x6c/0xa64 [bochs]
Mar 28 13:16:36 debian-ppc64 kernel: [   11.045624] [c000000004133570] [c0000000007ca518] local_pci_probe+0x68/0x110
Mar 28 13:16:36 debian-ppc64 kernel: [   11.045730] [c0000000041335f0] [c0000000007cb438] pci_call_probe+0x88/0x1a0
Mar 28 13:16:36 debian-ppc64 kernel: [   11.045830] [c000000004133750] [c0000000007cc6ac] pci_device_probe+0xbc/0x1a0
Mar 28 13:16:36 debian-ppc64 kernel: [   11.045928] [c000000004133790] [c0000000008969e0] really_probe+0x100/0x5e0
Mar 28 13:16:36 debian-ppc64 kernel: [   11.046025] [c000000004133810] [c00000000089704c] __driver_probe_device+0x18c/0x250
Mar 28 13:16:36 debian-ppc64 kernel: [   11.046125] [c000000004133890] [c00000000089716c] driver_probe_device+0x5c/0x140
Mar 28 13:16:36 debian-ppc64 kernel: [   11.046225] [c0000000041338d0] [c000000000897cf8] __driver_attach+0x118/0x290
Mar 28 13:16:36 debian-ppc64 kernel: [   11.046322] [c000000004133950] [c000000000892d38] bus_for_each_dev+0xa8/0x130
Mar 28 13:16:36 debian-ppc64 kernel: [   11.046425] [c0000000041339b0] [c000000000895c24] driver_attach+0x34/0x50
Mar 28 13:16:36 debian-ppc64 kernel: [   11.046521] [c0000000041339d0] [c000000000895308] bus_add_driver+0x1b8/0x2e0
Mar 28 13:16:36 debian-ppc64 kernel: [   11.046618] [c000000004133a60] [c000000000898ea4] driver_register+0xb4/0x1c0
Mar 28 13:16:36 debian-ppc64 kernel: [   11.046714] [c000000004133ad0] [c0000000007c9d28] __pci_register_driver+0x68/0x80
Mar 28 13:16:36 debian-ppc64 kernel: [   11.046815] [c000000004133af0] [c008000000da174c] bochs_pci_driver_init+0x70/0x98 [bochs]
Mar 28 13:16:36 debian-ppc64 kernel: [   11.046931] [c000000004133b20] [c000000000011fd0] do_one_initcall+0x60/0x2d0
Mar 28 13:16:36 debian-ppc64 kernel: [   11.047033] [c000000004133c00] [c000000000229d38] do_init_module+0x68/0x360
Mar 28 13:16:36 debian-ppc64 kernel: [   11.047136] [c000000004133c90] [c00000000022dc3c] __do_sys_finit_module+0xdc/0x180
Mar 28 13:16:36 debian-ppc64 kernel: [   11.047239] [c000000004133db0] [c00000000002aaa0] system_call_exception+0x170/0x2d0
Mar 28 13:16:36 debian-ppc64 kernel: [   11.050839] [c000000004133e10] [c00000000000c3cc] system_call_common+0xec/0x250
Mar 28 13:16:36 debian-ppc64 kernel: [   11.053127] --- interrupt: c00 at 0x7fffa43100c4
Mar 28 13:16:36 debian-ppc64 kernel: [   11.055616] NIP:  00007fffa43100c4 LR: 00007fffa457fe2c CTR: 0000000000000000
Mar 28 13:16:36 debian-ppc64 kernel: [   11.058073] REGS: c000000004133e80 TRAP: 0c00   Not tainted  (5.17.0-ae085d7f9365)
Mar 28 13:16:36 debian-ppc64 kernel: [   11.060563] MSR:  800000000000f033 <SF,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 24222824  XER: 00000000
Mar 28 13:16:36 debian-ppc64 kernel: [   11.063048] IRQMASK: 0 
Mar 28 13:16:36 debian-ppc64 kernel: [   11.063048] GPR00: 0000000000000161 00007fffe8930710 00007fffa43f7100 0000000000000015 
Mar 28 13:16:36 debian-ppc64 kernel: [   11.063048] GPR04: 00007fffa458b448 0000000000000000 0000000000000000 0000000000000000 
Mar 28 13:16:36 debian-ppc64 kernel: [   11.063048] GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
Mar 28 13:16:36 debian-ppc64 kernel: [   11.063048] GPR12: 0000000000000000 00007fffa465ddd0 0000000020000000 0000000000000000 
Mar 28 13:16:36 debian-ppc64 kernel: [   11.063048] GPR16: 0000000000000000 0000000113fc4a40 0000000000000005 0000000113fcfb80 
Mar 28 13:16:36 debian-ppc64 kernel: [   11.063048] GPR20: 000001000f7283b0 0000000000000000 0000000113fcfb68 000001000f729570 
Mar 28 13:16:36 debian-ppc64 kernel: [   11.063048] GPR24: 0000000000000000 000001000f7283b0 0000000000020000 000001000f7282f0 
Mar 28 13:16:36 debian-ppc64 kernel: [   11.063048] GPR28: 00007fffa458b448 0000000000020000 0000000000000000 000001000f7283b0 
Mar 28 13:16:36 debian-ppc64 kernel: [   11.086658] NIP [00007fffa43100c4] 0x7fffa43100c4
Mar 28 13:16:36 debian-ppc64 kernel: [   11.091853] LR [00007fffa457fe2c] 0x7fffa457fe2c
Mar 28 13:16:36 debian-ppc64 kernel: [   11.097294] --- interrupt: c00
Mar 28 13:16:36 debian-ppc64 kernel: [   11.103124] Instruction dump:
Mar 28 13:16:36 debian-ppc64 kernel: [   11.112912] 7d710120 7d708120 4e800020 e8df0000 7fc407b4 7f45d378 7ec3b378 f8810068 
Mar 28 13:16:36 debian-ppc64 kernel: [   11.119165] 38c600f0 4b9b9c7d 60000000 3d22fff3 <e9550060> 392979e8 e8810068 7c2a4800 
Mar 28 13:16:36 debian-ppc64 kernel: [   11.123573] ---[ end trace 0000000000000000 ]---

My last good test was with 5.17.0-3bf03b9a0839 and can be seen at:
https://openqa.qa.codethink.co.uk/tests/932

A failure test with 5.17.0-52d543b5497c can be seen at: https://openqa.qa.codethink.co.uk/tests/937

After reverting 27599aacbaef ("fbdev: Hot-unplug firmware fb devices on
forced removal") on top of latest Linux mainline HEAD fixes the problem
and I can see qemu booting again.

I will be happy to test any patch fixing the problem.


--
Regards
Sudip
