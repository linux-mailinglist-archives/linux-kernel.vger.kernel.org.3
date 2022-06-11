Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FF95476B4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 19:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbiFKRAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 13:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiFKQ77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 12:59:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B82C31366;
        Sat, 11 Jun 2022 09:59:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85D86611BC;
        Sat, 11 Jun 2022 16:59:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B11C34116;
        Sat, 11 Jun 2022 16:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654966796;
        bh=td3QUBwwsry8onXVWlMpMtj7u5lJAKc5UggZDaDCp0k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JiqHMJ5oLxTh1CEbgPPoC0kPTCqGNTVSlfMDIvX+xPyV+whSeYcvK5TvibbLWY1q4
         AzHC/RJ0oA/x+4MXu333rJ8WVdfpbu2CUbWkqttD3c8vVcbMUU8BH5YhrZr20H/tSI
         wDbXdtsKC1CpldLx/sw7igZNO/JRNgMzUMNkR3wAFQnVbsgI0JXxlsIXhnFDufCq/u
         GJO26mZ65UNRrJ+TrACJ4SLnjDcMy+0FQj7UfXsad9KA7CuWysOIPhE5ksJ1wA01LS
         pKVCeEuh3tvq4dvUIKQRBKMRrmfm5/hmmS0TM7cX/JFi/xrBvbtNU6zYqxbiHgbYLO
         wnPmNudn1KDLA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6E2E15C0612; Sat, 11 Jun 2022 09:59:56 -0700 (PDT)
Date:   Sat, 11 Jun 2022 09:59:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
Subject: Re: Commit 282d8998e997 (srcu: Prevent expedited GPs and blocking
 readers from consuming CPU) cause qemu boot slow
Message-ID: <20220611165956.GO1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20615615-0013-5adc-584f-2b1d5c03ebfc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20615615-0013-5adc-584f-2b1d5c03ebfc@linaro.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 12:32:59AM +0800, Zhangfei Gao wrote:
> Hi, Paul
> 
> When verifying qemu with acpi rmr feature on v5.19-rc1, the guest kernel
> stuck for several minutes.

Stuck for several minutes but then continues normally?  Or stuck for
several minutes before you kill qemu?

And I have to ask...  What happened without the ACPI RMR feature?

> And on 5.18, there is no such problem.
> 
> After revert this patch, the issue solved.
> Commit 282d8998e997 (srcu: Prevent expedited GPs and blocking readers from 
> consuming CPU)
> 
> 
> qemu cmd:
> build/aarch64-softmmu/qemu-system-aarch64 -machine
> virt,gic-version=3,iommu=smmuv3 \
> -enable-kvm -cpu host -m 1024 \
> -kernel Image -initrd mini-rootfs.cpio.gz -nographic -append \
> "rdinit=init console=ttyAMA0 earlycon=pl011,0x9000000 kpti=off acpi=force" \
> -bios QEMU_EFI.fd
> 
> log:
> InstallProtocolInterface: 5B1B31A1-9562-11D2-8E3F-00A0C969723B 7AA4D040
> add-symbol-file /home/linaro/work/edk2/Build/ArmVirtQemu-AARCH64/DEBUG_GCC48/AARCH64/NetworkPkg/IScsiDxe/IScsiDxe/DEBUG/IScsiDxe.dll
> 0x75459000
> Loading driver at 0x00075458000 EntryPoint=0x00075459058 IScsiDxe.efi
> InstallProtocolInterface: BC62157E-3E33-4FEC-9920-2D3B36D750DF 7AA4DE98
> ProtectUefiImageCommon - 0x7AA4D040
>   - 0x0000000075458000 - 0x000000000003F000
> SetUefiImageMemoryAttributes - 0x0000000075458000 - 0x0000000000001000
> (0x0000000000004008)
> SetUefiImageMemoryAttributes - 0x0000000075459000 - 0x000000000003B000
> (0x0000000000020008)
> SetUefiImageMemoryAttributes - 0x0000000075494000 - 0x0000000000003000
> (0x0000000000004008)
> InstallProtocolInterface: 18A031AB-B443-4D1A-A5C0-0C09261E9F71 754952C8
> InstallProtocolInterface: 107A772C-D5E1-11D4-9A46-0090273FC14D 75495358
> InstallProtocolInterface: 6A7A5CFF-E8D9-4F70-BADA-75AB3025CE14 75495370
> InstallProtocolInterface: 18A031AB-B443-4D1A-A5C0-0C09261E9F71 754952F8
> InstallProtocolInterface: 107A772C-D5E1-11D4-9A46-0090273FC14D 75495358
> InstallProtocolInterface: 6A7A5CFF-E8D9-4F70-BADA-75AB3025CE14 75495370
> InstallProtocolInterface: 59324945-EC44-4C0D-B1CD-9DB139DF070C 75495348
> InstallProtocolInterface: 09576E91-6D3F-11D2-8E39-00A0C969723B 754953E8
> InstallProtocolInterface: 330D4706-F2A0-4E4F-A369-B66FA8D54385 7AA4D728
> 
> 
> Not sure it is either reported or solved.

This is the first I have heard of it, so thank you for reporting it.

Do you have a way of collecting something sysrq-t output?

							Thanx, Paul
