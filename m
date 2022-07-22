Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17B657DA29
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 08:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbiGVGSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 02:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbiGVGSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 02:18:15 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB8066AD0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 23:18:14 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d10so3674410pfd.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 23:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CAqG/DkhRcYIDqD1nBDDfbap2mlkP7fUxSgcEJwyURQ=;
        b=lIcMUVL6HYKpel4MOiunAbUe0klrpEn3tRTx32R6t0zZiNITa2O4/e/PGifUaJqlYH
         kbl4QBykTRDLeW12VjDezb2VyPNK+29oD0P1LGXgItVr4ZBRzKDNdG50ZKMo+l2MZ4ba
         M9kknr5QPLI6We3mIBzet/H1GXJi7ubTJyJaypeG+rcDXM+NjaqIjUL4JN/hNnIP3Y04
         y45SVefCbYAdZdhQDyNyUknDV2cbJk2UUnsv+scxzCxIyL4IcoxfPVMVF2tmJpqNM2Pc
         8ULQop5Ig92PNClY1QcszypJ93e7oIus1ebGyrz/FVM00vkj6TNy33vOQixjRtc8K5g0
         Sxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CAqG/DkhRcYIDqD1nBDDfbap2mlkP7fUxSgcEJwyURQ=;
        b=bC7cbtb+qRRZQ3Y6AueAVLdcM6lhbwiZ00aj7YMKTUAWmgyNMDkHHHcw0415H4LYxF
         eDM36bFtSZWLl/DbOEQrG1B4T2B7d0H217epnbRksfGCP1bCIKCxuJO907NrC1PclBYR
         0CKySADy0/zgN0tw8BCuoCmHda+Lx28AWI3JgeTKPfyBoTm88oPxX7MvsW0nGTmK8ed1
         +5VVJewld4+AkNAau+0ekTN8+vdD9V62aEt9wfkorN9lBq4ZueRqEI/WC2NkFL9tvk0O
         mrjfDqO3i7qO3TuizFtycpM+6gMf2iXvxACoDXYBCpne3H0RXpX+d2a5ruXLfxAbX9S0
         VH5w==
X-Gm-Message-State: AJIora/szzYgsZ+DoQlhL2m/gGQRm5Ii+c/7pCYMnMMUIUviy2li+Nrv
        bMcXV3C/9dxS/dnb4r0a0R7/IKmhHVEe6g==
X-Google-Smtp-Source: AGRyM1vI3gG4RmJi2e2urpgBjLfVvEdAmWQwFmEgH1XeZmRLtIK8RfajDlVI7Ku8VqBySZ6VxE0WEg==
X-Received: by 2002:a05:6a00:1485:b0:52a:ca0b:5383 with SMTP id v5-20020a056a00148500b0052aca0b5383mr1959242pfu.0.1658470694116;
        Thu, 21 Jul 2022 23:18:14 -0700 (PDT)
Received: from localhost ([58.33.57.226])
        by smtp.gmail.com with ESMTPSA id a24-20020aa79718000000b005255f5d8f9fsm2863762pfg.112.2022.07.21.23.18.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jul 2022 23:18:13 -0700 (PDT)
Date:   Fri, 22 Jul 2022 14:18:11 +0800
From:   lijiazi <jqqlijiazi@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Jiazi.Li" <jiazi.li@transsion.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Do not add a device that has been removed
 in device_shutdown to devices_kset list again.
Message-ID: <20220722061246.GA4801@Jiazi.Li>
References: <20220721123325.4675-1-jiazi.li@transsion.com>
 <Ytmlih/TgGNrRTwy@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ytmlih/TgGNrRTwy@kroah.com>
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

On Thu, Jul 21, 2022 at 09:14:18PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jul 21, 2022 at 08:33:25PM +0800, Jiazi.Li wrote:
> > There is a race between device_shutdown and devices_kset_move_last:
> > 1. device_shutdown remove dev from devices_kset, unlock list_lock
> > 
> > 2. supplier call device_link_add move this consummer dev to
> > last of devices_kset:
> > devices_kset_move_last+0x184/0x1fc
> > device_reorder_to_tail+0x50/0x17c
> > device_link_add+0x670/0x9c0
> > phy_get+0x88/0x300
> > 
> > 3. device_shutdown call dev->bus->shutdown first time
> > 
> > 4. in next loop, device_shutdown pick this dev from devices_kset
> > again, and call dev->bus->shutdown for the second time.
> > 
> > If the protection mechanism of dev->bus->shutdown is not perfect,
> > the following crash will occur:
> > [37.366651] [T1000001] Unable to handle kernel NULL pointer
> > dereference at virtual address 0000000000000070
> > [37.414053] [T1600001] Kernel Offset: 0x2c73800000 from 0xffffffc010000000
> > [37.414908] [T1600001] PHYS_OFFSET: 0x40000000
> > [37.415458] [T1600001] pstate: 60400005 (nZCv daif +PAN -UAO)
> > [37.416172] [T1600001] pc : [0xffffffec83eccd40] kernfs_find_ns+0x18/0x154
> > [37.417025] [T1600001] lr : [0xffffffec83ed8714] sysfs_unmerge_group+0x70/0x2e0
> > [37.417931] [T1600001] sp : ffffffc01008ba90
> > [37.418456] [T1600001] x29: ffffffc01008ba90 x28: ffffffec863c1000
> > [37.419221] [T1600001] x27: ffffffec85234e30 x26: ffffffec86490000
> > [37.419985] [T1600001] x25: ffffff80c854a4c0 x24: ffffff80c854a428
> > [37.420750] [T1600001] x23: 0000000000400100 x22: ffffffec85c4c5c8
> > [37.421514] [T1600001] x21: ffffffec85c4c5a0 x20: 0000000000000000
> > [37.422277] [T1600001] x19: ffffff80c0178000 x18: ffffffc010083068
> > [37.423043] [T1600001] x17: 0000000000000000 x16: 00000000000000d8
> > [37.423807] [T1600001] x15: ffffffec842b9314 x14: ffffffec85b04050
> > [37.424572] [T1600001] x13: 0000000000000000 x12: 000000000000000a
> > [37.425336] [T1600001] x11: 0000000000000000 x10: ffffffec863e9000
> > [37.426102] [T1600001] x9 : 0000000000000001 x8 : 0000000000000000
> > [37.426869] [T1600001] x7 : 332e37332020205b x6 : ffffffec863e6e7e
> > [37.427633] [T1600001] x5 : ffffffffffffffff x4 : 0000000000000000
> > [37.428396] [T1600001] x3 : 000000000000003c x2 : 0000000000000000
> > [37.429161] [T1600001] x1 : ffffffec85c4c5c8 x0 : 0000000000000000
> > [37.612410] [T1600001] Call trace:
> > [37.612831] [T1600001]  dump_backtrace.cfi_jt+0x0/0x8
> > [37.613457] [T1600001]  dump_stack_lvl+0xc4/0x140
> > [37.614038] [T1600001]  dump_stack+0x1c/0x2c
> > [37.614588] [T1600001]  mrdump_common_die+0x3a8/0x544 [mrdump]
> > [37.615326] [T1600001]  ipanic_die+0x24/0x38 [mrdump]
> > [37.615951] [T1600001]  die+0x344/0x748
> > [37.616425] [T1600001]  die_kernel_fault+0x84/0x94
> > [37.617016] [T1600001]  __do_kernel_fault+0x230/0x27c
> > [37.617642] [T1600001]  do_page_fault+0xb4/0x754
> > [37.618212] [T1600001]  do_translation_fault+0x48/0x64
> > [37.618846] [T1600001]  do_mem_abort+0x6c/0x164
> > [37.619406] [T1600001]  el1_abort+0x44/0x68
> > [37.619921] [T1600001]  el1_sync_handler+0x58/0x88
> > [37.620512] [T1600001]  el1_sync+0x8c/0x140
> > [37.621028] [T1600001]  kernfs_find_ns+0x18/0x154
> > [37.621608] [T1600001]  sysfs_unmerge_group+0x70/0x2e0
> > [37.622246] [T1600001]  device_del+0x198/0xd00
> > [37.622794] [T1600001]  device_unregister+0x1c/0x3c
> > [37.623409] [T1600001]  charger_device_unregister+0x40/0x54 [charger_class]
> > [37.624277] [T1600001]  sgm41516d_shutdown+0x54/0x84 [sgm41516d]
> > [37.625021] [T1600001]  i2c_device_shutdown+0x68/0x118
> > [37.625656] [T1600001]  device_shutdown+0x234/0x614
> > [37.626259] [T1600001]  kernel_restart+0x74/0x1e8
> > [37.626840] [T1600001]  __arm64_sys_reboot+0x3b0/0x424
> > [37.627475] [T1600001]  el0_svc_common+0xd4/0x270
> > [37.628056] [T1600001]  el0_svc+0x28/0x88
> > [37.628549] [T1600001]  el0_sync_handler+0x8c/0xf0
> > [37.629141] [T1600001]  el0_sync+0x1b4/0x1c0
> > 
> > because dev->kobject.sd has been set to NULL in fisrt shutdown.
> 
> We can't take kernel changes to fix bugs in out-of-tree kernel modules.
> Can you reproduce this with the in-tree drivers?  If so, which ones?
> 
> thanks,
> 
> greg k-h

I'm sorry, I am working on mobile phone base on android12+GKI2.0.
So far, I found two charger driver have this issue , maybe more.
Reproduce method is plug/unplug usb cable when device shutdown or
reboot.
GKI2.0 requires that most vendor's drivers are out-of-tree modules.
I haven't found in-tree drivers has this issue.

thanks,

Jiazi.Li
