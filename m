Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0543B490429
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238327AbiAQImO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:42:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58643 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238330AbiAQImH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:42:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642408926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XGK1SlpJXhWBG+NMFQFueBq+YAxFBORg6nehgEQYpqw=;
        b=Zd+y0zN3aYj7Z1zv5oI6R2PRqZlb9NgeiwlKARPFuwWwrtf7HHHpA1nWv1CepPAJh417Ap
        g1sIvTnaVEFNpjBdo16G8kB6Bu3o8bRfsGTJnsnuOd92obDgsoy0O5v/3qK2NYODRY/Boy
        Gn1wBO/Vdw3R+BIsnTjIYKm+jNWINZI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-QMngAcABM3m5UqQ4s22PJw-1; Mon, 17 Jan 2022 03:42:05 -0500
X-MC-Unique: QMngAcABM3m5UqQ4s22PJw-1
Received: by mail-ed1-f70.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso13510983edt.20
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 00:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XGK1SlpJXhWBG+NMFQFueBq+YAxFBORg6nehgEQYpqw=;
        b=kJPthfDO1R0bBub+XLZdGiS/iMKYyUdci1c7I/j6km+/VioVzeYIwOyXLjIBa+O+ox
         HzINH/ZJW2YUoIPaSfxK7NyOmHewyqmZhBVY5UT+3oAzWjYURwDOdOHX254fXwvPoZhl
         tZhZXAHRaZ2pLgt7rvORGBMWs6MDImIiKN/f4x32VTdO3KiqpDQzdSNt6yu9l/gAmHxn
         XUlEr+7hQZJN6OAIogP5s6+m69MCeznGnxkfMQwZd7NYguFoU6ySQYWtUjXthNgLuHVv
         xFKUyCXGtssjaSd2WTLXi3YOM1b3R0UtgYqRkGvysKqDgmSlzPc4BgyScJPbT54PC2KM
         tZYw==
X-Gm-Message-State: AOAM530uI65wzI+iCtfs6DlbqwP3KGwCn6VbqpleFLVYpqqZ9mqEjbeV
        efj7WLDhw0a57q9mfPa/9OGCPdWTtgU2RHB82Kit8Y6DNNr8Fsugj9mpKg+LAZ+W+mLytaAEz4X
        zT4Eyb8BVapUjI8rzA1fD5qTG
X-Received: by 2002:aa7:d88d:: with SMTP id u13mr12929566edq.217.1642408923695;
        Mon, 17 Jan 2022 00:42:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQaNHnu9csjbqL/rvTKocAVaWQGdF9eKIb7dk2s05zyxmDzJTWikk+EcxQrUKDwpxHigdkag==
X-Received: by 2002:aa7:d88d:: with SMTP id u13mr12929556edq.217.1642408923485;
        Mon, 17 Jan 2022 00:42:03 -0800 (PST)
Received: from janakin.usersys.redhat.com ([83.148.38.137])
        by smtp.gmail.com with ESMTPSA id y7sm4989329edq.27.2022.01.17.00.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 00:42:02 -0800 (PST)
Date:   Mon, 17 Jan 2022 09:42:01 +0100
From:   Jan Stancek <jstancek@redhat.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>, amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: RIP: 0010:radeon_vm_fini+0x15/0x220 [radeon]
Message-ID: <20220117084158.GA2673957@janakin.usersys.redhat.com>
References: <YeLyToEyBFnQqQGB@zn.tnic>
 <1049939c-422f-787a-7481-21a2598eeedd@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1049939c-422f-787a-7481-21a2598eeedd@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 08:16:09AM +0100, Christian König wrote:
>Hi Borislav,
>
>Am 15.01.22 um 17:11 schrieb Borislav Petkov:
>>Hi folks,
>>
>>so this is a *very* old K8 laptop - yap, you read it right, family 0xf.
>>
>>[   31.353032] powernow_k8: fid 0xa (1800 MHz), vid 0xa
>>[   31.353569] powernow_k8: fid 0x8 (1600 MHz), vid 0xc
>>[   31.354081] powernow_k8: fid 0x0 (800 MHz), vid 0x16
>>[   31.354844] powernow_k8: Found 1 AMD Turion(tm) 64 Mobile Technology MT-34 (1 cpu cores) (version 2.20.00)
>>
>>This is true story.
>
>well, that hardware is ancient ^^.
>
>Interesting to see that even that old stuff is still used.
>
>>Anyway, it blows up, see below.
>>
>>Kernel is latest Linus tree, top commit is:
>>
>>a33f5c380c4b ("Merge tag 'xfs-5.17-merge-3' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux")
>>
>>I can bisect if you don't see it immediately why it blows up.
>
>Immediately I see that code is called which isn't for this hardware 
>generation.
>
>This is extremely odd because it means that we either have recently 
>added a logic bug or the detection of the hardware generation doesn't 
>work as expected any more.
>
>Please bisect,
>Christian.

I'm see panics like this one as well on multiple systems in lab (e.g. ProLiant SL390s G7,
PowerEdge R805). Looks same to what Bruno reported here:
  https://lore.kernel.org/all/CA+QYu4rt2VHWzbOt-SegA9yABqC-D36PoqTZmy6DscWvp+6ZMQ@mail.gmail.com/

It started around 8d0749b4f83b - Merge tag 'drm-next-2022-01-07', running a bisect atm.

[   15.230105] SGI XFS with ACLs, security attributes, scrub, quota, no debug enabled 
[   15.234816] XFS (sdb1): Mounting V5 Filesystem 
[   15.342261] [drm] ib test succeeded in 0 usecs 
[   15.343311] [drm] No TV DAC info found in BIOS 
[   15.344061] [drm] Radeon Display Connectors 
[   15.344330] [drm] Connector 0: 
[   15.344961] [drm]   VGA-1 
[   15.345174] [drm]   DDC: 0x60 0x60 0x60 0x60 0x60 0x60 0x60 0x60 
[   15.345991] [drm]   Encoders: 
[   15.346617] [drm]     CRT1: INTERNAL_DAC1 
[   15.346942] [drm] Connector 1: 
[   15.347561] [drm]   VGA-2 
[   15.347746] [drm]   DDC: 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c 
[   15.348598] [drm]   Encoders: 
[   15.349217] [drm]     CRT2: INTERNAL_DAC2 
[   15.349521] BUG: kernel NULL pointer dereference, address: 0000000000000000 
[   15.349974] #PF: supervisor read access in kernel mode 
[   15.350305] #PF: error_code(0x0000) - not-present page 
[   15.350675] PGD 0 P4D 0  
[   15.350814] Oops: 0000 [#[   15.431048] CPU: 0 PID: 410 Comm: systemd-udevd Tainted: G          I       5.16.0 #1 
[   15.443401] XFS (sdb1): Ending clean mount 
[   15.451541] Hardware name: HP ProLiant SL390s G7/, BIOS P69 07/02/2013 
[   15.451545] RIP: 0010:radeon_vm_fini+0x174/0x300 [radeon] 
[   15.452689] Code: e8 74 cc 7a c1 eb d1 4c 8b 24 24 4d 8d 74 24 48 49 8b 5c 24 48 49 39 de 74 38 66 2e 0f 1f 84 00 00 00 00 00 66 90 4c 8d 7b a8 <48> 8b 2b 48 8d 7b 18 e8 30 1e f4 ff 48 83 c3 c0 48 89 df e8 34 f3 
[   15.454412] RSP: 0018:ffffa3494800001 R08: 0000000000200000 R09: 0000000000000000 
[   15.533944] R10: 0000000000000000 R11: ffffffffc04f7810 R12: ffff979b4ba46730 
[   15.533945] R13: ffff979d5c260000 R14: ffff979b4ba46778 R15: ffffffffffffffa8 
[   15.533947] FS:  00007f3a13141500(0000) GS:ffff979d4ba00000(0000) knlGS:0000000000000000 
[   15.533948] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 
[   15.533950] CR2: 0000000000000000 CR3: 000000031c7fc005 CR4: 00000000000206f0 
[   15.533952] Call Trace: 
[   15.533956]  <TASK> 
[   15.533959]  radeon_driver_open_kms+0x118/0x180 [radeon] 
[   15.533998]  drm_file_alloc+0x1a8/0x230 [drm] 
[      
  OK   [[   15.961755]  drm_client_init+0x99/0x130 [drm] 
  [   15.961777]  drm_fb_helper_init+0x32/0x50 [drm_kms_helper] 
  [   15.961809]  radeon_fbdev_init+0xbc/0x110 [radeon] 
  [   15.963653]  radeon_modeset_init+0x857/0x9e0 [radeon] 
  0m] Mounted  [0;[   15.964003]  radeon_driver_load_kms+0x19b/0x290 [radeon] 
  [   15.964474]  drm_dev_register+0xf5/0x2d0 [drm] 
  1;39msysroot.mou[   15.965196]  radeon_pci_probe+0xc3/0x120 [radeon] 
  [   15.965972]  pci_device_probe+0x185/0x220 
  [   15.966225]  call_driver_probe+0x32/0xd0 
  [   15.966505]  really_probe+0x157/0x380 
  [   15.99bus_add_driver+0x111/0x210 
  [   16.467150]  ? 0xffffffffc0412000 
  [   16.467805]  driver_register+0x81/0x120 
  [   16.468069]  do_one_initcall+0xb0/0x290 
  [   16.468359]  ? down_write+0xe/0x40 
  [   16.469008]  ? kernfs_activate+0x28/0x130 
  [   16.469267]  ? kernfs_add_one+0x1c8/0x210 
  [   16.469563]  ? vunmap_p4d_range+0x3dc/0x420 
  [   16.469858]  ? __vunmap+0x1df/0x2a0 
  [   16.470466]  ? kmem_cache_alloc_trace+0x1a4/0x330 
  [   16.471224]  ? do_init_module+0x24/0x230 
  [   16.471485]  do_init_module+0x5a/0x230 
  [   16.471779]  load_module+0x145f/0x1630 
  [   16.472022]  ? kernel_read_file_from_fd+0x5d/0x80 
  [   16.472762]  __se_sys_finit_module+0x9f/0xd0 
  [   16.473480]  do_syscall_64+0x43/0x90 
  [   16.473778]  entry_SYSCALL_64_after_hwframe+0x44/0xae 
  [   16.474123] RIP: 0033:0x7f3a13d11e2d 
  [   16.474422] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d bb 7f 0e 00 f7 d8 64 89 01 48 
  [   16.476010] RSP: 002b:00007fff9cb92b78 EFLAGS: 00000246 ORIG_RAX: 000000 R08: 0000000000000000 R09: 0000000000000002 
  [   16.977414] R10: 0000000000000012 R11: 0000000000000246 R12: 00007f3a13e6d43c 
  [   16.978320] R13: 0000555c5eba3080 R14: 0000000000000007 R15: 0000555c5eba3d70 
  [   16.979218]  </TASK> 
  [   16.979381] Modules linked in: xfs radeon(+) drm_ttm_helper ttm i2c_algo_bit drm_kms_helper crct10dif_pclmul crc32_pclmul crc32c_intel cec ata_generic ghash_clmulni_intel drm serio_raw pata_acpi hpwdt 
  [   16.980516] CR2: 0000000000000000 
  [   16.981179] ---[ end trace d6f7f573dad76bd2 ]--- 
  [   16.981861] RIP: 0010:radeon_vm_fini+0x174/0x300 [radeon] 
  [   16.982257] Code: e8 74 cc 7a c1 eb d1 4c 8b 24 24 4d 8d 74 24 48 49 8b 5c 24 48 49 39 de 74 38 66 2e 0f 1f 84 00 00 00 00 00 66 90 4c 8d 7b a8 <48> 8b 2b 48 8d 7b 18 e8 30 1e f4 ff 48 83 c3 c0 48 89 df e8 34 f3 
  [   16.983766] RSP: 0018:ffffa3494801f8e8 EFLAGS: 00010286 
  [   16.984124] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000 
  nt   
   - /sysroo[   16.984981] RDX: 0000000000000001 RSI: ffff979b4ba46730 RDI: ffff979b4ba46750 
   [   16.985898] RBP: 0000000000000001 R08: 0000000000200000 R09: 0000000000000000 
   [   16.986730] R10: 0000000000000000 R11: ffffffffc04f7810 R12: 0 ES: 0000 CR0: 0000000080050033 
   [   17.488057] CR2: 0000000000000000 CR3: 000000031c7fc005 CR4: 00000000000206f0 
   [   17.489013] Kernel panic - not syncing: Fatal exception 
   [   17.489404] Kernel Offset: 0x0 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff) 
   [   17.490485] ---[ end Kernel panic - not syncing: Fatal exception ]--- 


