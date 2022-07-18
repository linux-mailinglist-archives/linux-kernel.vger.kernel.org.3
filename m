Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0336C57833B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbiGRNKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbiGRNKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:10:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A6812AB1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFEFBB81607
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 13:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FA2C341C0;
        Mon, 18 Jul 2022 13:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658149814;
        bh=hdsWoAacUlbtUsKYM7Fe7L2NSapcAMw6cTP36dELNto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GwA3mNLUulPloNbONSLsDZACF7hUfHV0fY4DrHU2VveDdLJvhRLg9RbKosmmiafZD
         9Hqc2ojdFd9zgs4/Ff60q8fScSFzEE01jLqAY5PK3S4+hkNlZ8Ynvq4XzG2Ls5guLs
         gUQSS68IB9XNiYxkciO64glvbjEp0oEm9JgC/DRbnHIPb/1m7tNoo8W8xJfXke3voe
         P4LlRmVDgwWXqWjKqECUV/0jeYRvd8nL8hOSb1juhn8wx5PCPwdf1WGik3UkzyWtkn
         UeA+VqLF70nrSe+WsDuMlkv+swx9Wd1x24x/8/8ZP6X59996uWI9FMq+HH+v28Y2f8
         Q8ScC2k+QkHFw==
Date:   Mon, 18 Jul 2022 14:10:06 +0100
From:   Will Deacon <will@kernel.org>
To:     "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
Cc:     baolin.wang@linux.alibaba.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org, david@redhat.com, jianyong.wu@arm.com,
        james.morse@arm.com, quic_qiancai@quicinc.com,
        christophe.leroy@csgroup.eu, jonathan@marek.ca,
        mark.rutland@arm.com, thunder.leizhen@huawei.com,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rppt@kernel.org,
        geert+renesas@glider.be, ardb@kernel.org, linux-mm@kvack.org,
        yaohongbo@linux.alibaba.com, alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v5] arm64: mm: fix linear mem mapping access performance
 degradation
Message-ID: <20220718131005.GA12406@willie-the-truck>
References: <f0dd1176-39f1-0a08-d0e2-627dd437aa5f@linux.alibaba.com>
 <1657460657-25698-1-git-send-email-guanghuifeng@linux.alibaba.com>
 <a6caa7b5-6a15-987d-c0a3-dcf9c1cdd3b0@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6caa7b5-6a15-987d-c0a3-dcf9c1cdd3b0@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2022 at 11:33:02PM +0800, guanghui.fgh wrote:
> In short, this path work:
> 
> 1.Before doing work for rebuiling crashkernel mem, the pgd is swapper_pg_dir
> in [[[ttbr1]]]
> 
> 2.Change the [[[ttbr0]]]to use idmap_pg_dir pgd
> 
> 3.The [[[idmap_cpu_replace_ttbr1_with_flush_tlb]]] are mapped [[[only]]]
> with idmap_pg_dir mapping in [[[ttbr0]]]
> 
> 4.The [[[idmap_cpu_replace_ttbr1_with_flush_tlb]]] will flush tlb all,
> switch [[[ttbr1]]] to use init_pg_dir pgd(and flush tlb all again).
> There is no tlb conflict to swapper_pg_dir.
> There is no tlb cache for swapper_pg_dir.
> 
> 5.Woring with init_pg_dir pgd to access swapper_pg_dir pagetable with fix
> mapping. And modify crashkernel mapping in the swapper_pg_dir without any
> tlb conflict and flush.
> 
> 6.When finishing the work, switch ttbr1 pgd to the origin swapper_pg_dir
> with cpu_replace_ttbr1 function(similar to the above).

I do not think that this complexity is justified. As I have stated on
numerous occasions already, I would prefer that we leave the crashkernel
mapped when rodata is not "full". That fixes your performance issue and
matches what we do for module code, so I do not see a security argument
against it.

I do not plan to merge this patch as-is.

Thanks,

Will
