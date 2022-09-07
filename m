Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C735B0635
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiIGOON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiIGOOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:14:10 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB915FF4D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 07:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mj1OiWPjt52swNp0JTJUVkkngcL48BBzi0LfTDeNR/Y=; b=WEVmPDHwu9P16B32z1r+8MRiGb
        wFGq2g9gEn0g31N3tix22w4pbc6CifWOtdOPI+VMa7lkOcVh05jmqgRIGdDFiM/npD6JGDq6ScIh+
        siLsRDmWyrXtAGH3RmqFaXQRELDSMcF24DcgyjKpGwzpfQiMeKI0FI2i1oH3tugYDrxBX8eysg1xy
        ZEw80+s7hU5W2t+AWxuOJhBb1holToHJHRRQLuT0vIPiGr3jdNrH2XOyfXN8CWANPsQuAoLoVUzRb
        /lrdoRFSvUdXy0DaRzyLjtS+hPhsVQ4l09PI6MVqMa0SvkjBOU4J10ZUEnM+LjrdADSHnqVyBOPpp
        P/1egXvA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34180)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oVvoW-0005U2-F2; Wed, 07 Sep 2022 15:14:00 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oVvoT-0001AP-B6; Wed, 07 Sep 2022 15:13:57 +0100
Date:   Wed, 7 Sep 2022 15:13:57 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@armlinux.org.uk
Subject: Re: [PATCH v2 0/2] arm: Replace this_cpu_* with raw_cpu_* in
 panic_bad_stack()
Message-ID: <YxinJcixamAEO2yr@shell.armlinux.org.uk>
References: <20220826095112.289-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826095112.289-1-thunder.leizhen@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please distinguish your patches/patch series between arch/arm and
arch/arm64. The two are maintained separately, and it gets quite
annoying to read messages nd then realise that they're not for 32-bit
ARM, but are for arm64/aarch64.

Thanks.

On Fri, Aug 26, 2022 at 05:51:10PM +0800, Zhen Lei wrote:
> v1 --> v2:
> Update commit message of two patches.
> 
> v1:
> I'm analyzing a strange problem these days, and I find that there are some areas in
> panic_bad_stack() that can be optimized. That is, replace this_cpu_* with raw_cpu_* .
> 
> Just optimization, it is unlikely to cause the following exception nesting, because of
> "lr : __bad_stack+0x88/0x8c".
> 
> [20220819163739]Unable to handle kernel paging request at virtual address f7ffff94901b8048
> [20220819163739]Mem abort info:
> [20220819163739]  ESR = 0x96000004
> [20220819163739]  EC = 0x25: DABT (current EL), IL = 32 bits
> [20220819163739]  SET = 0, FnV = 0
> [20220819163739]  EA = 0, S1PTW = 0
> [20220819163739]Data abort info:
> [20220819163739]  ISV = 0, ISS = 0x00000004
> [20220819163739]  CM = 0, WnR = 0
> [20220819163739][f7ffff94901b8048] address between user and kernel address ranges
> [20220819163739]Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [20220819163739]Modules linked in: ...
> [20220819163740]CPU: 2 PID: 1272 Comm: 00002SWDLMain Tainted: G        W  O      5.10.0 #1
> [20220819163740]Hardware name: hisilicon,hi1213-fpga (DT)
> [20220819163740]pstate: 000003c5 (nzcv DAIF -PAN -UAO -TCO BTYPE=--)
> [20220819163740]pc : __bad_stack+0x4c/0x8c
> [20220819163740]lr : __bad_stack+0x88/0x8c
> [20220819163740]sp : ffffff953ffa8160
> [20220819163740]x29: f7ffff953ffa8120 x28: f7ffff94901b8040 
> [20220819163740]x27: ffffffeb72ea6940 x26: ffffffebeee6cf10 
> [20220819163740]x25: ffffffebef627000 x24: 0000000000000000 
> [20220819163740]x23: 00000000600003c5 x22: f7ffffebeee11904 
> [20220819163740]x21: ffffff953ffa82b0 x20: 0000007fffffffff 
> [20220819163740]x19: f7ffffc0133ab898 x18: 0000000000000000 
> [20220819163740]x17: 0000000000000000 x16: ffffffebef32f0a0 
> [20220819163740]x15: 00000000624057a0 x14: 953325a7da350fb3 
> [20220819163740]x13: 09bbbe32ce2b3c11 x12: c15a0e2d1991997b 
> [20220819163740]x11: 0bc8be839e7850d0 x10: cafa1cb223203045 
> [20220819163740]x9 : f36bed299e5840dc x8 : ffffffc0133aba48 
> [20220819163740]x7 : ffffff953b1b0480 x6 : ffffffebef3e1000 
> [20220819163740]x5 : 0000000000000000 x4 : 0000000000000001 
> [20220819163740]x3 : f7ffffc0133ab750 x2 : 0000000000000025 
> [20220819163740]x1 : 0000000096000004 x0 : ffffff953ffa8160 
> [20220819163740]Call trace:
> [20220819163740] __bad_stack+0x4c/0x8c
> [20220819163740]Code: a90d6ffa a90e77fc 910543f5 d538411c (f9400794) 
> [20220819163740]---[ end trace 07532bfa2c24851c ]---
> [20220819163740]Kernel panic - not syncing: Oops: Fatal exception
> 
> Zhen Lei (2):
>   arm64/traps: Replace this_cpu_* with raw_cpu_* in panic_bad_stack()
>   ARM: replace this_cpu_* with raw_cpu_* in panic_bad_stack()
> 
>  arch/arm/kernel/traps.c   | 4 ++--
>  arch/arm64/kernel/traps.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> -- 
> 2.25.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
