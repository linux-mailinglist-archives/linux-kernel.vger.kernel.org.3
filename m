Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A521F57DC44
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbiGVIWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbiGVIWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:22:47 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594819E29F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 01:22:46 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id c3so3870988pfb.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 01:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EirilG4zfS2DcWmUkxCg1D0A5xglcDZZ2K3Ik28Ovbw=;
        b=NaZh/IkQPzQMzo+JwNF3ysF7pJz+uJ3F5lgvmwZBOQPcsvG/pF7fyZEs6NEJW9tFJ5
         mnkPMrN8MNlidvePL3C+p+rSzoGXRSgSjZftZfuqBrAoplc5JpoRFyGw11lIeRqlLe+O
         7fYB5y6M+w2wHeHZFfNqFD+PcfvppYz3tPXV5vB6/zwbPDQmWiLZNDRvf8UrEtcjg5iw
         uE/Hz5RWxAnXPc4qkcV/NB0FFfI1sebbF3e23osuBjbhp1Wnp1Y9U7hHK3QeiCmaPAak
         Qi9owGKUuZ6PknigSkqzn0xNjOwmhGkgi9nEfjjcKbLNVIiRAASegSRi7BrCF+ZCm1M/
         9Pyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EirilG4zfS2DcWmUkxCg1D0A5xglcDZZ2K3Ik28Ovbw=;
        b=7E2IJMWB5fQYwUIpHC9KEFo4xiXeJtE/1ToEoxkvu97jbKbhGSZUaH83RXnJNAQD+X
         L0awtnbIRVt4SwJXOUpXId1vzPNZZ618LALIgnhNtTRZDCAvpUyWMqHPH7y3BtX7oHky
         88AKoTo4/7fMqBrhsfDXJ1uSSHX5Btm6P/s6SBMPg7P4cqHKGngfINEN3vgXYKOSYiUl
         36XeARijeFE5DKzMa4Sdhye8B3SL3hW5NOpsrt4zBPUiKlkDy6HjPlY4YvecWfvsvaa2
         hK5HDAFxmhitWbc0pl4r6ZU2cWGRI77PmayH/goikZPjkDfZcspAvvCjUqL7mtRSZ9NV
         VgOg==
X-Gm-Message-State: AJIora8a3djUBgCWT1gf5X55ut/Gnxh8JdDZTXV/Y3KVhr5XhdUNsgn5
        atK01DOAjEZCKPP2omvHZ1dPUO9XyYXHMA==
X-Google-Smtp-Source: AGRyM1t22uyH7TeGukD5tWDW2r2Lj5XO4GZCm7rf7DZVoLhhmp57IItnI+fO4BLiPZMYdUvOlW1OsQ==
X-Received: by 2002:a63:6908:0:b0:41a:3c2:622b with SMTP id e8-20020a636908000000b0041a03c2622bmr2197693pgc.304.1658478165658;
        Fri, 22 Jul 2022 01:22:45 -0700 (PDT)
Received: from localhost ([58.33.57.226])
        by smtp.gmail.com with ESMTPSA id c13-20020a170903234d00b0016c0408932dsm3078820plh.129.2022.07.22.01.22.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jul 2022 01:22:45 -0700 (PDT)
Date:   Fri, 22 Jul 2022 16:22:42 +0800
From:   lijiazi <jqqlijiazi@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Jiazi.Li" <jiazi.li@transsion.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Do not add a device that has been removed
 in device_shutdown to devices_kset list again.
Message-ID: <20220722082242.GA5656@Jiazi.Li>
References: <20220721123325.4675-1-jiazi.li@transsion.com>
 <Ytmlih/TgGNrRTwy@kroah.com>
 <20220722061246.GA4801@Jiazi.Li>
 <YtpJg90L0OUxa5DS@kroah.com>
 <20220722072903.GA5390@Jiazi.Li>
 <YtpXYzMPje44SdyE@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtpXYzMPje44SdyE@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 09:53:07AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jul 22, 2022 at 03:31:19PM +0800, lijiazi wrote:
> > On Fri, Jul 22, 2022 at 08:53:55AM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Jul 22, 2022 at 02:18:11PM +0800, lijiazi wrote:
> > > > On Thu, Jul 21, 2022 at 09:14:18PM +0200, Greg Kroah-Hartman wrote:
> > > > > On Thu, Jul 21, 2022 at 08:33:25PM +0800, Jiazi.Li wrote:
> > > > > > There is a race between device_shutdown and devices_kset_move_last:
> > > > > > 1. device_shutdown remove dev from devices_kset, unlock list_lock
> > > > > > 
> > > > > > 2. supplier call device_link_add move this consummer dev to
> > > > > > last of devices_kset:
> > > > > > devices_kset_move_last+0x184/0x1fc
> > > > > > device_reorder_to_tail+0x50/0x17c
> > > > > > device_link_add+0x670/0x9c0
> > > > > > phy_get+0x88/0x300
> > > > > > 
> > > > > > 3. device_shutdown call dev->bus->shutdown first time
> > > > > > 
> > > > > > 4. in next loop, device_shutdown pick this dev from devices_kset
> > > > > > again, and call dev->bus->shutdown for the second time.
> > > > > > 
> > > > > > If the protection mechanism of dev->bus->shutdown is not perfect,
> > > > > > the following crash will occur:
> > > > > > [37.366651] [T1000001] Unable to handle kernel NULL pointer
> > > > > > dereference at virtual address 0000000000000070
> > > > > > [37.414053] [T1600001] Kernel Offset: 0x2c73800000 from 0xffffffc010000000
> > > > > > [37.414908] [T1600001] PHYS_OFFSET: 0x40000000
> > > > > > [37.415458] [T1600001] pstate: 60400005 (nZCv daif +PAN -UAO)
> > > > > > [37.416172] [T1600001] pc : [0xffffffec83eccd40] kernfs_find_ns+0x18/0x154
> > > > > > [37.417025] [T1600001] lr : [0xffffffec83ed8714] sysfs_unmerge_group+0x70/0x2e0
> > > > > > [37.417931] [T1600001] sp : ffffffc01008ba90
> > > > > > [37.418456] [T1600001] x29: ffffffc01008ba90 x28: ffffffec863c1000
> > > > > > [37.419221] [T1600001] x27: ffffffec85234e30 x26: ffffffec86490000
> > > > > > [37.419985] [T1600001] x25: ffffff80c854a4c0 x24: ffffff80c854a428
> > > > > > [37.420750] [T1600001] x23: 0000000000400100 x22: ffffffec85c4c5c8
> > > > > > [37.421514] [T1600001] x21: ffffffec85c4c5a0 x20: 0000000000000000
> > > > > > [37.422277] [T1600001] x19: ffffff80c0178000 x18: ffffffc010083068
> > > > > > [37.423043] [T1600001] x17: 0000000000000000 x16: 00000000000000d8
> > > > > > [37.423807] [T1600001] x15: ffffffec842b9314 x14: ffffffec85b04050
> > > > > > [37.424572] [T1600001] x13: 0000000000000000 x12: 000000000000000a
> > > > > > [37.425336] [T1600001] x11: 0000000000000000 x10: ffffffec863e9000
> > > > > > [37.426102] [T1600001] x9 : 0000000000000001 x8 : 0000000000000000
> > > > > > [37.426869] [T1600001] x7 : 332e37332020205b x6 : ffffffec863e6e7e
> > > > > > [37.427633] [T1600001] x5 : ffffffffffffffff x4 : 0000000000000000
> > > > > > [37.428396] [T1600001] x3 : 000000000000003c x2 : 0000000000000000
> > > > > > [37.429161] [T1600001] x1 : ffffffec85c4c5c8 x0 : 0000000000000000
> > > > > > [37.612410] [T1600001] Call trace:
> > > > > > [37.612831] [T1600001]  dump_backtrace.cfi_jt+0x0/0x8
> > > > > > [37.613457] [T1600001]  dump_stack_lvl+0xc4/0x140
> > > > > > [37.614038] [T1600001]  dump_stack+0x1c/0x2c
> > > > > > [37.614588] [T1600001]  mrdump_common_die+0x3a8/0x544 [mrdump]
> > > > > > [37.615326] [T1600001]  ipanic_die+0x24/0x38 [mrdump]
> > > > > > [37.615951] [T1600001]  die+0x344/0x748
> > > > > > [37.616425] [T1600001]  die_kernel_fault+0x84/0x94
> > > > > > [37.617016] [T1600001]  __do_kernel_fault+0x230/0x27c
> > > > > > [37.617642] [T1600001]  do_page_fault+0xb4/0x754
> > > > > > [37.618212] [T1600001]  do_translation_fault+0x48/0x64
> > > > > > [37.618846] [T1600001]  do_mem_abort+0x6c/0x164
> > > > > > [37.619406] [T1600001]  el1_abort+0x44/0x68
> > > > > > [37.619921] [T1600001]  el1_sync_handler+0x58/0x88
> > > > > > [37.620512] [T1600001]  el1_sync+0x8c/0x140
> > > > > > [37.621028] [T1600001]  kernfs_find_ns+0x18/0x154
> > > > > > [37.621608] [T1600001]  sysfs_unmerge_group+0x70/0x2e0
> > > > > > [37.622246] [T1600001]  device_del+0x198/0xd00
> > > > > > [37.622794] [T1600001]  device_unregister+0x1c/0x3c
> > > > > > [37.623409] [T1600001]  charger_device_unregister+0x40/0x54 [charger_class]
> > > > > > [37.624277] [T1600001]  sgm41516d_shutdown+0x54/0x84 [sgm41516d]
> > > > > > [37.625021] [T1600001]  i2c_device_shutdown+0x68/0x118
> > > > > > [37.625656] [T1600001]  device_shutdown+0x234/0x614
> > > > > > [37.626259] [T1600001]  kernel_restart+0x74/0x1e8
> > > > > > [37.626840] [T1600001]  __arm64_sys_reboot+0x3b0/0x424
> > > > > > [37.627475] [T1600001]  el0_svc_common+0xd4/0x270
> > > > > > [37.628056] [T1600001]  el0_svc+0x28/0x88
> > > > > > [37.628549] [T1600001]  el0_sync_handler+0x8c/0xf0
> > > > > > [37.629141] [T1600001]  el0_sync+0x1b4/0x1c0
> > > > > > 
> > > > > > because dev->kobject.sd has been set to NULL in fisrt shutdown.
> > > > > 
> > > > > We can't take kernel changes to fix bugs in out-of-tree kernel modules.
> > > > > Can you reproduce this with the in-tree drivers?  If so, which ones?
> > > > > 
> > > > > thanks,
> > > > > 
> > > > > greg k-h
> > > > 
> > > > I'm sorry, I am working on mobile phone base on android12+GKI2.0.
> > > > So far, I found two charger driver have this issue , maybe more.
> > > > Reproduce method is plug/unplug usb cable when device shutdown or
> > > > reboot.
> > > > GKI2.0 requires that most vendor's drivers are out-of-tree modules.
> > > 
> > > That is not true, Google would much rather accept in-tree modules that
> > > are upstream.  It's your choice to not submit them for inclusion, please
> > > don't pass the blame to someone else.
> > > 
> > 
> > You are right.
> > > > I haven't found in-tree drivers has this issue.
> > > 
> > > Then perhaps your drivers are broken?  Do you have a link to the source
> > > anywhere?
> > 
> > Yes, as I said earlier, I have encountered two broken drivers.
> > Sorry for can't provide a link.
> 
> Why not, the license of your driver is GPLv2, right?
> 

The driver is GPLv2, but for some other reason.
> > Instead of fix driver one by one, perhaps add a list_empty check is
> > a better method.
> 
> Please work to find the problem in your driver first.  We do not add
> "hardening" code to the kernel core to prevent buggy drivers from
> causing problems, for obvious reasons.
> 

I have fixed the problem in vendor's driver, but I can't stop them from
make similar mistake. So I try to solve this issue in kernel.
You are right, kernel do not add code to prevent buggy drivers from
causing problem.
> thanks,
> 
> greg k-h

thanks,

Jiazi.Li
