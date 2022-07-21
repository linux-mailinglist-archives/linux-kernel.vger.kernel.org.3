Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6BC57D3E9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 21:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiGUTPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 15:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbiGUTPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 15:15:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A1B8EED7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 12:15:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B397962073
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 19:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890C8C3411E;
        Thu, 21 Jul 2022 19:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658430899;
        bh=xJQzhg0PIuAJBxdE58x3tjd5Wx7lXZe41N4gywU9Co8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BAZB9RMpc0i2Ra0kc7oRXVqkc3TQguUhJeOE/AKG6e2oiWpycN/GRTfo9O7BsmPi+
         OKdMKqx7m/B+XAeb3+FBl4GTO108IjgDMkSKIBH2XL7QcyVO2dM+Os1aDSUBca3dcv
         bjHnwJLPXMdyjAZeJmq6hSx5wsPU7710OQymoPq0=
Date:   Thu, 21 Jul 2022 21:14:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Jiazi.Li" <jqqlijiazi@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Jiazi.Li" <jiazi.li@transsion.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Do not add a device that has been removed
 in device_shutdown to devices_kset list again.
Message-ID: <Ytmlih/TgGNrRTwy@kroah.com>
References: <20220721123325.4675-1-jiazi.li@transsion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721123325.4675-1-jiazi.li@transsion.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 08:33:25PM +0800, Jiazi.Li wrote:
> There is a race between device_shutdown and devices_kset_move_last:
> 1. device_shutdown remove dev from devices_kset, unlock list_lock
> 
> 2. supplier call device_link_add move this consummer dev to
> last of devices_kset:
> devices_kset_move_last+0x184/0x1fc
> device_reorder_to_tail+0x50/0x17c
> device_link_add+0x670/0x9c0
> phy_get+0x88/0x300
> 
> 3. device_shutdown call dev->bus->shutdown first time
> 
> 4. in next loop, device_shutdown pick this dev from devices_kset
> again, and call dev->bus->shutdown for the second time.
> 
> If the protection mechanism of dev->bus->shutdown is not perfect,
> the following crash will occur:
> [37.366651] [T1000001] Unable to handle kernel NULL pointer
> dereference at virtual address 0000000000000070
> [37.414053] [T1600001] Kernel Offset: 0x2c73800000 from 0xffffffc010000000
> [37.414908] [T1600001] PHYS_OFFSET: 0x40000000
> [37.415458] [T1600001] pstate: 60400005 (nZCv daif +PAN -UAO)
> [37.416172] [T1600001] pc : [0xffffffec83eccd40] kernfs_find_ns+0x18/0x154
> [37.417025] [T1600001] lr : [0xffffffec83ed8714] sysfs_unmerge_group+0x70/0x2e0
> [37.417931] [T1600001] sp : ffffffc01008ba90
> [37.418456] [T1600001] x29: ffffffc01008ba90 x28: ffffffec863c1000
> [37.419221] [T1600001] x27: ffffffec85234e30 x26: ffffffec86490000
> [37.419985] [T1600001] x25: ffffff80c854a4c0 x24: ffffff80c854a428
> [37.420750] [T1600001] x23: 0000000000400100 x22: ffffffec85c4c5c8
> [37.421514] [T1600001] x21: ffffffec85c4c5a0 x20: 0000000000000000
> [37.422277] [T1600001] x19: ffffff80c0178000 x18: ffffffc010083068
> [37.423043] [T1600001] x17: 0000000000000000 x16: 00000000000000d8
> [37.423807] [T1600001] x15: ffffffec842b9314 x14: ffffffec85b04050
> [37.424572] [T1600001] x13: 0000000000000000 x12: 000000000000000a
> [37.425336] [T1600001] x11: 0000000000000000 x10: ffffffec863e9000
> [37.426102] [T1600001] x9 : 0000000000000001 x8 : 0000000000000000
> [37.426869] [T1600001] x7 : 332e37332020205b x6 : ffffffec863e6e7e
> [37.427633] [T1600001] x5 : ffffffffffffffff x4 : 0000000000000000
> [37.428396] [T1600001] x3 : 000000000000003c x2 : 0000000000000000
> [37.429161] [T1600001] x1 : ffffffec85c4c5c8 x0 : 0000000000000000
> [37.612410] [T1600001] Call trace:
> [37.612831] [T1600001]  dump_backtrace.cfi_jt+0x0/0x8
> [37.613457] [T1600001]  dump_stack_lvl+0xc4/0x140
> [37.614038] [T1600001]  dump_stack+0x1c/0x2c
> [37.614588] [T1600001]  mrdump_common_die+0x3a8/0x544 [mrdump]
> [37.615326] [T1600001]  ipanic_die+0x24/0x38 [mrdump]
> [37.615951] [T1600001]  die+0x344/0x748
> [37.616425] [T1600001]  die_kernel_fault+0x84/0x94
> [37.617016] [T1600001]  __do_kernel_fault+0x230/0x27c
> [37.617642] [T1600001]  do_page_fault+0xb4/0x754
> [37.618212] [T1600001]  do_translation_fault+0x48/0x64
> [37.618846] [T1600001]  do_mem_abort+0x6c/0x164
> [37.619406] [T1600001]  el1_abort+0x44/0x68
> [37.619921] [T1600001]  el1_sync_handler+0x58/0x88
> [37.620512] [T1600001]  el1_sync+0x8c/0x140
> [37.621028] [T1600001]  kernfs_find_ns+0x18/0x154
> [37.621608] [T1600001]  sysfs_unmerge_group+0x70/0x2e0
> [37.622246] [T1600001]  device_del+0x198/0xd00
> [37.622794] [T1600001]  device_unregister+0x1c/0x3c
> [37.623409] [T1600001]  charger_device_unregister+0x40/0x54 [charger_class]
> [37.624277] [T1600001]  sgm41516d_shutdown+0x54/0x84 [sgm41516d]
> [37.625021] [T1600001]  i2c_device_shutdown+0x68/0x118
> [37.625656] [T1600001]  device_shutdown+0x234/0x614
> [37.626259] [T1600001]  kernel_restart+0x74/0x1e8
> [37.626840] [T1600001]  __arm64_sys_reboot+0x3b0/0x424
> [37.627475] [T1600001]  el0_svc_common+0xd4/0x270
> [37.628056] [T1600001]  el0_svc+0x28/0x88
> [37.628549] [T1600001]  el0_sync_handler+0x8c/0xf0
> [37.629141] [T1600001]  el0_sync+0x1b4/0x1c0
> 
> because dev->kobject.sd has been set to NULL in fisrt shutdown.

We can't take kernel changes to fix bugs in out-of-tree kernel modules.
Can you reproduce this with the in-tree drivers?  If so, which ones?

thanks,

greg k-h
