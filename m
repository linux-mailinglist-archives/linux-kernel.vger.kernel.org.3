Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA3653952A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 19:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346279AbiEaRCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 13:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243327AbiEaRCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 13:02:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B658A11A28
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 10:02:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6EFD8B810F5
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 17:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB68C385A9;
        Tue, 31 May 2022 17:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654016523;
        bh=djguEZZRDPP3prGCOje7q6bgq4eAd52mgC9VJE+UvZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u8LXi8TrTLqG5iEZu55P2t2fyZ7OD8tsnQ5PXBbTHF/LgZ7Gi/yTmdTg35xoBS1iF
         kPWVMEi0YCNM3eiemsEVp4EWCKCcBMPir39ZJGsRQAiXvhi47LZTtJIz5CnwwL+BCC
         itAMIVSohp4iS+gL8uhbPTelu0YU8Tmf5gErzxEd7PqW/ikfvH/Nd1XUPACMS3Imf9
         KytTjEIc588n91CXJVh98FTVqVQQZ2/k/hHrC/O9VTR0YgOVWOc6xBnSEYwTmVv49V
         L3TY/sY3bxouJIpPcwL6yYLVMiIsCRS3RfMNniPc4lETv9a6GNBVMmERdniNJycG7o
         FnXOpjXSYq6BQ==
Date:   Tue, 31 May 2022 18:01:58 +0100
From:   Will Deacon <will@kernel.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Fix memory leaks from stage2 pagetable
Message-ID: <20220531170157.GC25631@willie-the-truck>
References: <20220526203956.143873-1-quic_qiancai@quicinc.com>
 <20220531165710.GB25631@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531165710.GB25631@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 05:57:11PM +0100, Will Deacon wrote:
> On Thu, May 26, 2022 at 04:39:56PM -0400, Qian Cai wrote:
> > Running some SR-IOV workloads could trigger some leak reports from
> > kmemleak.
> > 
> > unreferenced object 0xffff080243cef500 (size 128):
> >   comm "qemu-system-aar", pid 179935, jiffies 4298359506 (age 1629.732s)
> >   hex dump (first 32 bytes):
> >     28 00 00 00 01 00 00 00 00 e0 4c 52 03 08 ff ff  (.........LR....
> >     e0 af a4 7f 7c d1 ff ff a8 3c b3 08 00 80 ff ff  ....|....<......
> >   backtrace:
> >      kmem_cache_alloc_trace
> >      kvm_init_stage2_mmu
> 
> Hmm, I can't spot a 128-byte allocation in here so this is pretty cryptic.
> I don't really like the idea of papering over the report; we'd be better off
> trying to reproduce it.

... although the hexdump does look like {u32; u32; ptr; ptr; ptr}, which
would match 'struct kvm_pgtable'. I guess the allocation is aligned to
ARCH_DMA_MINALIGN, which could explain the size?

Have you spotted any pattern for when the leak occurs? How are you
terminating the guest?

Will
