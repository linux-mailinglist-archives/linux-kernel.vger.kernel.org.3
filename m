Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BD6544B1D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244879AbiFIL5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244064AbiFIL52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:57:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F61414085
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:57:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A354B82D03
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 11:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A599CC3411B;
        Thu,  9 Jun 2022 11:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654775843;
        bh=OypU/OgmdIE82Czce754wZSkPYqIeHYmcc3YDTKRUCc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hg036Jq6tRQxbSfxhePXWNh7rY1YzBQji8mWHKwFIQkvGjHhuwsmB/YWuUaE+RGVg
         BYl8F9kOHSiSypJJ/VxYobtGaBQB9K9M6afPa4qniGj8e8jF/RrAeNLfI317N1so7a
         iP/n92kuorohBLVa820HErpOembgsRzutaoIPLhaaKiWLmsQq5lC2UJVwG/QFpfDfC
         2gp+Shnp0pzmcBnid61jngmuFxnZiP7cB6wkLQhQsv0LSGEzgyVHr8azCJYBHwlrT3
         pi5bukGinvsaPmnK9Ym+RabGc+Gxpn3LlRnxH8fJO4LA9W+3sqArBlAUW7ETyIUBWZ
         1yQJc88RqXzBw==
Date:   Thu, 9 Jun 2022 12:57:17 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        yj.chiang@mediatek.com, Marc Zyngier <maz@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, jean-philippe.brucker@arm.com
Subject: Re: [PATCH] arm64: Clear OS lock in enable_debug_monitors
Message-ID: <20220609115716.GA2427@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609033322.12436-1-mark-pk.tsai@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 11:33:18AM +0800, Mark-PK Tsai wrote:
> Always clear OS lock before enable debug event.
> 
> The OS lock is clear in cpuhp ops in recent kernel,
> but when the debug exception happened before it
> kernel might crash because debug event enable didn't
> take effect when OS lock is hold.
> 
> Below is the use case that having this problem:
> 
> Register kprobe in console_unlock and kernel will
> panic at secondary_start_kernel on secondary core.
> 
> CPU: 1 PID: 0 Comm: swapper/1 Tainted: P
> ...
> pstate: 004001c5 (nzcv dAIF +PAN -UAO)
> pc : do_undefinstr+0x5c/0x60
> lr : do_undefinstr+0x2c/0x60
> sp : ffffffc01338bc50
> pmr_save: 000000f0
> x29: ffffffc01338bc50 x28: ffffff8115e95a00 T
> x27: ffffffc01258e000 x26: ffffff8115e95a00
> x25: 00000000ffffffff x24: 0000000000000000
> x23: 00000000604001c5 x22: ffffffc014015008
> x21: 000000002232f000 x20: 00000000000000f0 j
> x19: ffffffc01338bc70 x18: ffffffc0132ed040
> x17: ffffffc01258eb48 x16: 0000000000000403 L&
> x15: 0000000000016480 x14: ffffffc01258e000 i/
> x13: 0000000000000006 x12: 0000000000006985
> x11: 00000000d5300000 x10: 0000000000000000
> x9 : 9f6c79217a8a0400 x8 : 00000000000000c5
> x7 : 0000000000000000 x6 : ffffffc01338bc08 2T
> x5 : ffffffc01338bc08 x4 : 0000000000000002
> x3 : 0000000000000000 x2 : 0000000000000004
> x1 : 0000000000000000 x0 : 0000000000000001 *q
> Call trace:
>  do_undefinstr+0x5c/0x60
>  el1_undef+0x10/0xb4
>  0xffffffc014015008
>  vprintk_func+0x210/0x290
>  printk+0x64/0x90
>  cpuinfo_detect_icache_policy+0x80/0xe0
>  __cpuinfo_store_cpu+0x150/0x160
>  secondary_start_kernel+0x154/0x440
> 
> The root cause is that OS_LSR_EL1.OSLK is reset
> to 1 on a cold reset[1] and the firmware didn't
> unlock it by default.
> So the core didn't go to el1_dbg as expected after
> kernel_enable_single_step and eret.

Hmm, I thought we didn't use hardware single-step for kprobes after
7ee31a3aa8f4 ("arm64: kprobes: Use BRK instead of single-step when executing
instructions out-of-line"). What is triggering this exception?

Will
