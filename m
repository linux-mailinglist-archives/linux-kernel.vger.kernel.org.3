Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F0957F996
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 08:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiGYGqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 02:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGYGqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 02:46:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A8FB1FD
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 23:46:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2D066112A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 06:46:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF0EC341C7;
        Mon, 25 Jul 2022 06:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658731575;
        bh=hIZrYAxn265ebgeF7Bwq7AWTsRMM8aNkjPhwdYrVvPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=osNv7G6brArIxFH6QeFgaRQ6faY2Q0HTiCZ1w/P+kGwwRNfXEJMAHrbYdJY2g1aFa
         qHTyjZ/CCqMxNbJd6JjQSSBfbLFbXr7PAtJKicGfARZgvm/uATPZ9KNmKkophIW5lo
         XdagoKwJqC3B78lYz417IQxdGlnTr/RiojJn2nBPN9GOwtJ17VSDxlkZFtfdqPlr9U
         BienTQy1Fcxw2C1faujgJCrzJdQXrwhaKOtLnaitvQe50I44I6mQqR+0rnwfHQk/SC
         iKl7uAedh7x2u8PAJqiGQnIfoII+C6ypUkQAP7GARtMT/Cd7hYryBlytp56Vh/4lqh
         M5fNWDCiB67rw==
Date:   Mon, 25 Jul 2022 09:46:04 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     "guanghui.fgh" <guanghuifeng@linux.alibaba.com>,
        baolin.wang@linux.alibaba.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org, david@redhat.com, jianyong.wu@arm.com,
        james.morse@arm.com, quic_qiancai@quicinc.com,
        christophe.leroy@csgroup.eu, jonathan@marek.ca,
        mark.rutland@arm.com, thunder.leizhen@huawei.com,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, geert+renesas@glider.be,
        ardb@kernel.org, linux-mm@kvack.org, yaohongbo@linux.alibaba.com,
        alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v5] arm64: mm: fix linear mem mapping access performance
 degradation
Message-ID: <Yt48LK6pU/VL1dJ3@kernel.org>
References: <f0dd1176-39f1-0a08-d0e2-627dd437aa5f@linux.alibaba.com>
 <1657460657-25698-1-git-send-email-guanghuifeng@linux.alibaba.com>
 <a6caa7b5-6a15-987d-c0a3-dcf9c1cdd3b0@linux.alibaba.com>
 <20220718131005.GA12406@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718131005.GA12406@willie-the-truck>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 02:10:06PM +0100, Will Deacon wrote:
> On Sun, Jul 10, 2022 at 11:33:02PM +0800, guanghui.fgh wrote:
> > In short, this path work:
> > 
> > 1.Before doing work for rebuiling crashkernel mem, the pgd is swapper_pg_dir
> > in [[[ttbr1]]]
> > 
> > 2.Change the [[[ttbr0]]]to use idmap_pg_dir pgd
> > 
> > 3.The [[[idmap_cpu_replace_ttbr1_with_flush_tlb]]] are mapped [[[only]]]
> > with idmap_pg_dir mapping in [[[ttbr0]]]
> > 
> > 4.The [[[idmap_cpu_replace_ttbr1_with_flush_tlb]]] will flush tlb all,
> > switch [[[ttbr1]]] to use init_pg_dir pgd(and flush tlb all again).
> > There is no tlb conflict to swapper_pg_dir.
> > There is no tlb cache for swapper_pg_dir.
> > 
> > 5.Woring with init_pg_dir pgd to access swapper_pg_dir pagetable with fix
> > mapping. And modify crashkernel mapping in the swapper_pg_dir without any
> > tlb conflict and flush.
> > 
> > 6.When finishing the work, switch ttbr1 pgd to the origin swapper_pg_dir
> > with cpu_replace_ttbr1 function(similar to the above).
> 
> I do not think that this complexity is justified. As I have stated on
> numerous occasions already, I would prefer that we leave the crashkernel
> mapped when rodata is not "full". That fixes your performance issue and
> matches what we do for module code, so I do not see a security argument
> against it.

The protection of the crash kernel is not about security. This is about an
ability to do post mortem with kdump and such when the things go awry.

I think it's possible to have both large pages in the linear map and the
protection of crash kernel in much simpler way that this patch does, I'll
try to send an RFC Really Soon.

> I do not plan to merge this patch as-is.
> 
> Thanks,
> 
> Will

-- 
Sincerely yours,
Mike.
