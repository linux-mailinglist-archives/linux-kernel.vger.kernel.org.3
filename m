Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48E158CF17
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 22:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244184AbiHHU10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 16:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238253AbiHHU1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 16:27:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEEFB1A824
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 13:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659990437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Qp5AM4XVaPe/EBBC2evVCwqqCv3S2jup+FrmZdbJPc=;
        b=AbcmbE9CaXGFMLdLFH2r/iILr3pOtpoHcTpjTSlEtjdumC0uDddScD6RqB228Womv4sL7/
        NPeINIeBHCEhkcncPHZEZcm4ppaKywHzI3BVTJEWAFt6oxawQfyJ4ctEQE7cPRocaviMNh
        nA+3c0uvjdIE0+J2IAgDe49KSg08tak=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-wPbDPP82PYW-yJxGkGaUcQ-1; Mon, 08 Aug 2022 16:27:15 -0400
X-MC-Unique: wPbDPP82PYW-yJxGkGaUcQ-1
Received: by mail-il1-f199.google.com with SMTP id w6-20020a056e021a6600b002dea6904708so7212960ilv.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 13:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc;
        bh=0Qp5AM4XVaPe/EBBC2evVCwqqCv3S2jup+FrmZdbJPc=;
        b=QkP6s+tkd0DYbrD2GguQswX6l6+NGqT4mDAsDGyq/SGQSaMVstI403t6KS/gD2uYM0
         mjvP5VTuYov6lhFIr84UEMziA4Fx/TpNzNMInWObq1R/aj/41wYPxMWIhMNuQZxCa/2e
         yWYU+xUE9tEP3GUPxshxFLduBQlD+5bHM99vU0b9pMOESigGFuuGVcYLzA4ugGIXknDy
         hZt4FghBjkGRw/PFvTJVTBxcqhu57J/MV+M/V5QKIImbfuXb+8S5p4snilSVU3mFAGvV
         1Ri6ntlOps/CzadBVV/lrSo0PBA/2lNVfhTFefXXKsM8ysWxg/rbdlYI3YiNKz+AfH7g
         3IQw==
X-Gm-Message-State: ACgBeo016uNujOkWnLmfMulEohPz7WCIcmnOJoqWv6UhCKV+k6+GboAP
        4BkP3QglZKHwAYZ218OpqMcdJdt3Bh2g/BY5dQLGXFkbnW28J9SZsJFTxwOh6th7GpdfTmMuNcY
        M18P2UQS/vKOXaayvwOdARlwW
X-Received: by 2002:a05:6e02:1091:b0:2dd:f304:5a50 with SMTP id r17-20020a056e02109100b002ddf3045a50mr9034207ilj.146.1659990434670;
        Mon, 08 Aug 2022 13:27:14 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4Gaui8ymkiPVLMaq6QF40dDHROTa/RWHRYWbJX4otUgVWItDO99iOsHXAQySvfwQD8L8xi6Q==
X-Received: by 2002:a05:6e02:1091:b0:2dd:f304:5a50 with SMTP id r17-20020a056e02109100b002ddf3045a50mr9034200ilj.146.1659990434384;
        Mon, 08 Aug 2022 13:27:14 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id m3-20020a02a143000000b0034278894fccsm5517418jah.90.2022.08.08.13.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 13:27:14 -0700 (PDT)
Date:   Mon, 8 Aug 2022 14:27:11 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Zhi Wang <zhi.wang.linux@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        Zhi Wang <zhi.a.wang@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Vivi Rodrigo <rodrigo.vivi@intel.com>,
        Christoph Hellwig <hch@lst.de>, Zhi Wang <zhi.a.wang@intel.com>
Subject: Re: [PATCH v9 1/3] i915/gvt: Separate the MMIO tracking table from
 GVT-g
Message-ID: <20220808142711.02d16782.alex.williamson@redhat.com>
In-Reply-To: <20220407071945.72148-2-zhi.a.wang@intel.com>
References: <20220407071945.72148-1-zhi.a.wang@intel.com>
        <20220407071945.72148-2-zhi.a.wang@intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Apr 2022 03:19:43 -0400
Zhi Wang <zhi.wang.linux@gmail.com> wrote:

> From: Zhi Wang <zhi.a.wang@gmail.com>
> 
> To support the new mdev interfaces and the re-factor patches from
> Christoph, which moves the GVT-g code into a dedicated module, the GVT-g
> MMIO tracking table needs to be separated from GVT-g.
> 

Since this commit I'm unable to make use of GVT-g on a Xeon W-1290 IGD.
The following in dmesg is the first sign of trouble:

------------[ cut here ]------------
assign a handler to a non-tracked mmio 4ab8
WARNING: CPU: 16 PID: 504 at drivers/gpu/drm/i915/gvt/handlers.c:123 setup_mmio_info.constprop.0+0xd1/0xf0 [i915]
ixgbe 0000:02:00.0: 31.504 Gb/s available PCIe bandwidth (8.0 GT/s PCIe x4 link)
Modules linked in: nouveau(+) i915(+) mdev vfio_iommu_type1 vfio prime_numbers intel_gtt ast drm_buddy mxm_wmi drm_dp_helper drm_vram_helper drm_ttm_helper drm_kms_helper sd_mod t10_pi syscopyarea sysfillrect sysimgblt sg fb_sys_fops cec ttm crct10dif_pclmul drm ixgbe(+) crc32_pclmul igb crc32c_intel ahci e1000e libahci mdio libata ghash_clmulni_intel i2c_algo_bit dca wmi video pinctrl_cannonlake rndis_host cdc_ether usbnet mii dm_mirror dm_region_hash dm_log dm_mod fuse
ixgbe 0000:02:00.0: MAC: 4, PHY: 0, PBA No: 020C08-0F8
CPU: 16 PID: 504 Comm: systemd-udevd Not tainted 5.18.0-rc1+ #16
ixgbe 0000:02:00.0: 3c:ec:ef:27:ef:0e
Hardware name: Supermicro Super Server/X12SCZ-F, BIOS 1.0 06/16/2020
RIP: 0010:setup_mmio_info.constprop.0+0xd1/0xf0 [i915]
Code: 83 c6 04 81 ef e4 e6 dd 78 39 f5 77 a2 31 c0 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 c7 c7 d8 c1 07 c1 e8 fe 83 cc c9 <0f> 0b 48 83 c4 08 b8 ed ff ff ff 5b 5d 41 5c 41 5d 41 5e 41 5f c3
RSP: 0018:ffffa2014090fa28 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff934754a38000 RCX: 0000000000000000
RDX: ffff9346ce42c740 RSI: ffff9346ce41fca0 RDI: ffff9346ce41fca0
RBP: 0000000000004abc R08: 0000000000000000 R09: 00000000ffff7fff
R10: ffffa2014090f868 R11: ffffffff8bfe65e8 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000008 R15: 0000000000000000
FS:  00007f345634d540(0000) GS:ffff9346ce400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562eacfa8980 CR3: 0000002058ac0001 CR4: 00000000007706e0
PKRU: 55555554
Call Trace:
 <TASK>
 init_skl_mmio_info+0x1532/0x15a0 [i915]
 intel_gvt_setup_mmio_info+0x1aa/0x240 [i915]
 ? gen9_dbuf_ctl_mmio_write+0x40/0x40 [i915]
 intel_gvt_init_device+0x106/0x300 [i915]
 intel_gvt_init+0x41/0xa0 [i915]
 i915_driver_hw_probe+0x2b2/0x340 [i915]
 i915_driver_probe+0x1fd/0x570 [i915]
 ? drm_privacy_screen_get+0x15f/0x190 [drm]
 i915_pci_probe+0x56/0x1e0 [i915]
 local_pci_probe+0x42/0x80
 pci_call_probe+0x56/0x160
 pci_device_probe+0x75/0xf0
 ? driver_sysfs_add+0x6f/0xd0
 really_probe+0x199/0x380
ixgbe 0000:02:00.0: Intel(R) 10 Gigabit Network Connection
 __driver_probe_device+0xfe/0x180
 driver_probe_device+0x1e/0x90
 __driver_attach+0xc0/0x1c0
 ? __device_attach_driver+0xe0/0xe0
 ? __device_attach_driver+0xe0/0xe0
 bus_for_each_dev+0x75/0xc0
 bus_add_driver+0x149/0x1e0
 driver_register+0x8f/0xe0
 i915_init+0x1d/0x7c [i915]
 ? 0xffffffffc0768000
 do_one_initcall+0x41/0x200
 ? kmem_cache_alloc_trace+0x174/0x2f0
 do_init_module+0x4c/0x250
 __do_sys_finit_module+0xb4/0x120
 do_syscall_64+0x59/0x80
 ? syscall_exit_to_user_mode+0x12/0x30
 ? do_syscall_64+0x69/0x80
 ? do_syscall_64+0x69/0x80
 ? do_syscall_64+0x69/0x80
 ? sysvec_call_function+0x3c/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f3456e5a3ed
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 03 aa 1b 00 f7 d8 64 89 01 48
RSP: 002b:00007fff4df686b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 0000562eacf62920 RCX: 00007f3456e5a3ed
RDX: 0000000000000000 RSI: 0000562eacf886b0 RDI: 000000000000001a
RBP: 0000000000020000 R08: 0000000000000000 R09: 0000000000000002
R10: 000000000000001a R11: 0000000000000246 R12: 0000562eacf886b0
R13: 0000562eacf627c0 R14: 0000000000000000 R15: 0000562eacf8d2d0
 </TASK>
---[ end trace 0000000000000000 ]---


> diff --git a/drivers/gpu/drm/i915/gvt/handlers.c b/drivers/gpu/drm/i915/gvt/handlers.c
> index 520a7e1942f3..9bd3c15bfab6 100644
> --- a/drivers/gpu/drm/i915/gvt/handlers.c
> +++ b/drivers/gpu/drm/i915/gvt/handlers.c
...
> @@ -3440,7 +2729,6 @@ static int init_skl_mmio_info(struct intel_gvt *gvt)
>  		 NULL, NULL);
>  
>  	MMIO_DFH(GAMT_CHKN_BIT_REG, D_KBL | D_CFL, F_CMD_ACCESS, NULL, NULL);
> -	MMIO_D(GEN9_CTX_PREEMPT_REG, D_SKL_PLUS & ~D_BXT);
>  	MMIO_DFH(_MMIO(0xe4cc), D_BDW_PLUS, F_CMD_ACCESS, NULL, NULL);
>  
>  	return 0;

I tracked this to the above code segment, where the untouched line
provides this mmio address:

#define GAMT_CHKN_BIT_REG                       _MMIO(0x4ab8)

If I comment out setup of this register, GVT-g appears to initialize
and I can list available mdev types.  I haven't tried assignment of the
resulting device to a VM yet.  I do however get lots of spew about
unclaimed reads:

i915 0000:00:02.0: Unclaimed read from register 0x7257c
i915 0000:00:02.0: Unclaimed read from register 0x60110
i915 0000:00:02.0: Unclaimed read from register 0x6f03c
i915 0000:00:02.0: Unclaimed read from register 0x6003c
i915 0000:00:02.0: Unclaimed read from register 0x61038
i915 0000:00:02.0: Unclaimed read from register 0x45104
i915 0000:00:02.0: Unclaimed read from register 0x70428
i915 0000:00:02.0: Unclaimed read from register 0x68884
i915 0000:00:02.0: Unclaimed read from register 0x7f040
i915 0000:00:02.0: Unclaimed read from register 0x4510c
i915 0000:00:02.0: Unclaimed read from register 0x6203c
i915 0000:00:02.0: Unclaimed read from register 0x70430
i915 0000:00:02.0: Unclaimed read from register 0x704c0
i915 0000:00:02.0: Unclaimed read from register 0x7142c
i915 0000:00:02.0: Unclaimed read from register 0x72428
i915 0000:00:02.0: Unclaimed read from register 0x6f04c
i915 0000:00:02.0: Unclaimed read from register 0x6004c
i915 0000:00:02.0: Unclaimed read from register 0x61048
i915 0000:00:02.0: Unclaimed read from register 0x68070
i915 0000:00:02.0: Unclaimed read from register 0x71284
i915 0000:00:02.0: Unclaimed read from register 0x70438
i915 0000:00:02.0: Unclaimed read from register 0x71434
i915 0000:00:02.0: Unclaimed read from register 0x714c4
i915 0000:00:02.0: Unclaimed read from register 0x72430
i915 0000:00:02.0: Unclaimed read from register 0x724c0
i915 0000:00:02.0: Unclaimed read from register 0x6204c
i915 0000:00:02.0: Unclaimed read from register 0x69074
i915 0000:00:02.0: Unclaimed read from register 0x64044
i915 0000:00:02.0: Unclaimed read from register 0x7143c
i915 0000:00:02.0: Unclaimed read from register 0x72438
i915 0000:00:02.0: Unclaimed read from register 0x46508
i915 0000:00:02.0: Unclaimed read from register 0x69270
i915 0000:00:02.0: Unclaimed read from register 0x45124
i915 0000:00:02.0: Unclaimed read from register 0x68080
i915 0000:00:02.0: Unclaimed read from register 0x61208
i915 0000:00:02.0: Unclaimed read from register 0x45200
i915 0000:00:02.0: Unclaimed read from register 0x69084
i915 0000:00:02.0: Unclaimed read from register 0x6f020
i915 0000:00:02.0: Unclaimed read from register 0x60020
i915 0000:00:02.0: Unclaimed read from register 0x42020
i915 0000:00:02.0: Unclaimed read from register 0x69280
i915 0000:00:02.0: Unclaimed read from register 0x71184
i915 0000:00:02.0: Unclaimed read from register 0x68090
i915 0000:00:02.0: Unclaimed read from register 0x7f024
i915 0000:00:02.0: Unclaimed read from register 0x70024
i915 0000:00:02.0: Unclaimed read from register 0x70578
i915 0000:00:02.0: Unclaimed read from register 0x43218
i915 0000:00:02.0: Unclaimed read from register 0x62020
i915 0000:00:02.0: Unclaimed read from register 0x68870
i915 0000:00:02.0: Unclaimed read from register 0x7157c
i915 0000:00:02.0: Unclaimed read from register 0x72024
i915 0000:00:02.0: Unclaimed read from register 0x72578
i915 0000:00:02.0: Unclaimed read from register 0x46020
i915 0000:00:02.0: Unclaimed read from register 0x6f038
i915 0000:00:02.0: Unclaimed read from register 0x60038
i915 0000:00:02.0: Unclaimed read from register 0x45100
i915 0000:00:02.0: Unclaimed read from register 0x44030
i915 0000:00:02.0: Unclaimed read from register 0x68880
i915 0000:00:02.0: Unclaimed read from register 0x61110
i915 0000:00:02.0: Unclaimed read from register 0x6103c
i915 0000:00:02.0: Unclaimed read from register 0x45108
i915 0000:00:02.0: Unclaimed read from register 0x62038
i915 0000:00:02.0: Unclaimed read from register 0x6e554
i915 0000:00:02.0: Unclaimed read from register 0x7042c
i915 0000:00:02.0: Unclaimed read from register 0x71428
i915 0000:00:02.0: Unclaimed read from register 0x48800
i915 0000:00:02.0: Unclaimed read from register 0x7f044
i915 0000:00:02.0: Unclaimed read from register 0x6f048
i915 0000:00:02.0: Unclaimed read from register 0x60048
i915 0000:00:02.0: Unclaimed read from register 0x48268
i915 0000:00:02.0: Unclaimed read from register 0x45110
i915 0000:00:02.0: Unclaimed read from register 0x70284
i915 0000:00:02.0: Unclaimed read from register 0x7f000
i915 0000:00:02.0: Unclaimed read from register 0x70434
i915 0000:00:02.0: Unclaimed read from register 0x704c4
i915 0000:00:02.0: Unclaimed read from register 0x71430
i915 0000:00:02.0: Unclaimed read from register 0x714c0
i915 0000:00:02.0: Unclaimed read from register 0x44040
i915 0000:00:02.0: Unclaimed read from register 0x7242c
i915 0000:00:02.0: Unclaimed read from register 0x68890
i915 0000:00:02.0: Unclaimed read from register 0x42004
i915 0000:00:02.0: Unclaimed read from register 0x6104c
i915 0000:00:02.0: Unclaimed read from register 0x62048
i915 0000:00:02.0: Unclaimed read from register 0x68074
i915 0000:00:02.0: Unclaimed read from register 0x69070
i915 0000:00:02.0: Unclaimed read from register 0x7043c
i915 0000:00:02.0: Unclaimed read from register 0x72284
i915 0000:00:02.0: Unclaimed read from register 0x71438
i915 0000:00:02.0: Unclaimed read from register 0x72434
i915 0000:00:02.0: Unclaimed read from register 0x724c4
i915 0000:00:02.0: Unclaimed read from register 0x45120
i915 0000:00:02.0: Unclaimed read from register 0x7243c
i915 0000:00:02.0: Unclaimed read from register 0x42014
i915 0000:00:02.0: Unclaimed read from register 0x69274
i915 0000:00:02.0: Unclaimed read from register 0x45128
i915 0000:00:02.0: Unclaimed read from register 0x68084
i915 0000:00:02.0: Unclaimed read from register 0x6120c
i915 0000:00:02.0: Unclaimed read from register 0x69080
i915 0000:00:02.0: Unclaimed read from register 0x70184
i915 0000:00:02.0: Unclaimed read from register 0x43408
i915 0000:00:02.0: Unclaimed read from register 0x61020
i915 0000:00:02.0: Unclaimed read from register 0x72184
i915 0000:00:02.0: Unclaimed read from register 0x69090
i915 0000:00:02.0: Unclaimed read from register 0x7057c
i915 0000:00:02.0: Unclaimed read from register 0x71024
i915 0000:00:02.0: Unclaimed read from register 0x71578
i915 0000:00:02.0: Unclaimed read from register 0x68874

This looks like a regression in v5.19 to me.  Thanks,

Alex

