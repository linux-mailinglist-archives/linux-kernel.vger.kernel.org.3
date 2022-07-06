Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24459568DFB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbiGFPsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbiGFPsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:48:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DB72A279
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 08:41:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4881B81D8B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 15:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E284AC3411C;
        Wed,  6 Jul 2022 15:40:59 +0000 (UTC)
Date:   Wed, 6 Jul 2022 16:40:56 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
Cc:     Mike Rapoport <rppt@kernel.org>, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        baolin.wang@linux.alibaba.com, akpm@linux-foundation.org,
        david@redhat.com, jianyong.wu@arm.com, james.morse@arm.com,
        quic_qiancai@quicinc.com, christophe.leroy@csgroup.eu,
        jonathan@marek.ca, mark.rutland@arm.com,
        thunder.leizhen@huawei.com, anshuman.khandual@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        geert+renesas@glider.be, linux-mm@kvack.org,
        yaohongbo@linux.alibaba.com, alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v4] arm64: mm: fix linear mem mapping access performance
 degradation
Message-ID: <YsWtCLIG2qKETqmq@arm.com>
References: <5d044fdd-a61a-d60f-d294-89e17de37712@linux.alibaba.com>
 <20220705121115.GB1012@willie-the-truck>
 <YsRSajyMxahXe7ZS@kernel.org>
 <YsRZ8V8mQ+HM31D6@arm.com>
 <YsRfgX7FFZLxQU50@kernel.org>
 <YsRvPTORdvIwzShL@arm.com>
 <YsSi9HAOOzbPYN+w@kernel.org>
 <YsVeKPzaO0SJdwFW@arm.com>
 <YsWULnvZZxoHtyRo@kernel.org>
 <9974bea5-4db9-0104-c9c9-d9b49c390f1b@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9974bea5-4db9-0104-c9c9-d9b49c390f1b@linux.alibaba.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 11:18:22PM +0800, guanghui.fgh wrote:
> 在 2022/7/6 21:54, Mike Rapoport 写道:
> > One thing I can think of is to only remap the crash kernel memory if it is
> > a part of an allocation that exactly fits into one ore more PUDs.
> > 
> > Say, in reserve_crashkernel() we try the memblock_phys_alloc() with
> > PUD_SIZE as alignment and size rounded up to PUD_SIZE. If this allocation
> > succeeds, we remap the entire area that now contains only memory allocated
> > in reserve_crashkernel() and free the extra memory after remapping is done.
> > If the large allocation fails, we fall back to the original size and
> > alignment and don't allow unmapping crash kernel memory in
> > arch_kexec_protect_crashkres().
> 
> There is a new method.
> I think we should use the patch v3(similar but need add some changes)
> 
> 1.We can walk crashkernle block/section pagetable,
> [[[(keep the origin block/section mapping valid]]]
> rebuild the pte level page mapping for the crashkernel mem
> rebuild left & right margin mem(which is in same block/section mapping but
> out of crashkernel mem) with block/section mapping
> 
> 2.'replace' the origin block/section mapping by new builded mapping
> iterately
> 
> With this method, all the mem mapping keep valid all the time.

As I already commented on one of your previous patches, this is not
allowed by the architecture. If FEAT_BBM is implemented (ARMv8.4 I
think), the worst that can happen is a TLB conflict abort and the
handler should invalidate the TLBs and restart the faulting instruction,
assuming the handler won't try to access the same conflicting virtual
address. Prior to FEAT_BBM, that's not possible as the architecture does
not describe a precise behaviour of conflicting TLB entries (you might
as well get the TLB output of multiple entries being or'ed together).

-- 
Catalin
