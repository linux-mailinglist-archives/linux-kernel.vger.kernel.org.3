Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A93E4CA53C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241948AbiCBMvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbiCBMvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:51:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D238E1A8;
        Wed,  2 Mar 2022 04:51:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95C396195A;
        Wed,  2 Mar 2022 12:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781E7C004E1;
        Wed,  2 Mar 2022 12:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646225465;
        bh=VhKOfxRbM46UzbAFZL42T2QOSs+Z6JUQ7yUbXR1FvoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ROemNp7UHfj7Tgx9Ocr+KK716iO5wqcr/0dnPXKaznA6R3rXINpK1f8ejcx5IAHDb
         hh2ceBje5GRG8MVEtKtFxKfbqc9xCus1B9RRHxcd3m3xekZ2juvb6xaA27iGn3Ut8G
         fnZaFezGf7f7pht+KwMXgpVez02TTiEtinh05nqPmLucnSmI/AqIkWLnyOfBujS0M2
         9GyNfMpVM43Dy4aNN6GTCnzEcHZ7oTnpLx0CEh0OrPKlBT26C/jsSixlDR7WoKxi0w
         3crGG1XMuu4Nrq1lQjDlAumaK1sr9PzOdfDdsi2EApw7Dx+ds9TtA7klW5RH72TCZN
         fl/bwD79lYqRg==
Date:   Wed, 2 Mar 2022 14:50:57 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] MIPS: Modify mem= and memmap= parameter
Message-ID: <Yh9oMdvPYtbzjxlV@kernel.org>
References: <1646108941-27919-1-git-send-email-yangtiezhu@loongson.cn>
 <Yh3tgr+g/6IElq0P@kernel.org>
 <cfd74b5b-39c3-733a-5226-515991f91f39@loongson.cn>
 <Yh4uUoYT+YS5Jxsv@kernel.org>
 <8956c625-c18d-846e-3e65-7920776b27f3@loongson.cn>
 <Yh8kzK7TM7EhaKEQ@kernel.org>
 <ab104917-d370-cbf3-6017-6e8e40221860@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab104917-d370-cbf3-6017-6e8e40221860@loongson.cn>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 05:28:27PM +0800, Tiezhu Yang wrote:
> 
> On 03/02/2022 04:03 PM, Mike Rapoport wrote:
> > On Wed, Mar 02, 2022 at 09:50:49AM +0800, Tiezhu Yang wrote:
> 
> [    0.000000] Linux version 5.17.0-rc3+ (loongson@linux) (gcc (GCC) 7.3.1
> 20180303 (Red Hat 7.3.1-6), GNU ld version 2.28-13.fc21.loongson.6) #1 SMP
> PREEMPT Wed Mar 2 09:07:39 CST 2022
> [    0.000000] CpuClock = 1800000000
> [    0.000000] The bridge chip is LS7A
> [    0.000000] CP0_Config3: CP0 16.3 (0xdc8030a0)
> [    0.000000] CP0_PageGrain: CP0 5.1 (0x28000000)
> [    0.000000] NUMA: Discovered 4 cpus on 1 nodes
> [    0.000000] Node0: mem_type:1, mem_start:0x200000, mem_size:0xee MB
> [    0.000000]        start_pfn:0x80, end_pfn:0x3c00, num_physpages:0x3b80
> [    0.000000] Node0: mem_type:2, mem_start:0x90200000, mem_size:0x6fe MB
> [    0.000000]        start_pfn:0x24080, end_pfn:0x40000,
> num_physpages:0x1fb00
> [    0.000000] Node0: mem_type:2, mem_start:0x120000000, mem_size:0x1600 MB
> [    0.000000]        start_pfn:0x48000, end_pfn:0xa0000,
> num_physpages:0x77b00
> [    0.000000] Node0's addrspace_offset is 0x0
> [    0.000000] Node0: start_pfn=0x80, end_pfn=0xa0000
> [    0.000000] NUMA: set cpumask cpu 0 on node 0
> [    0.000000] NUMA: set cpumask cpu 1 on node 0
> [    0.000000] NUMA: set cpumask cpu 2 on node 0
> [    0.000000] NUMA: set cpumask cpu 3 on node 0
> [    0.000000] printk: bootconsole [early0] enabled
> [    0.000000] CPU0 revision is: 0014c001 (ICT Loongson-3)
> [    0.000000] FPU revision is: 00f70501
> [    0.000000] MSA revision is: 00060140
> [    0.000000] OF: fdt: No chosen node found, continuing without
> [    0.000000] MIPS: machine is loongson,loongson64g-4core-ls7a
> [    0.000000] User-defined physical RAM map overwrite
> [    0.000000] Kernel sections are not in the memory maps
> [    0.000000] memblock_add: [0x0000000000200000-0x000000000231185f]
> setup_arch+0x140/0x794
> [    0.000000] memblock_reserve: [0x0000000001260520-0x0000000001262560]
> setup_arch+0x148/0x794
> [    0.000000] Initrd not found or empty - disabling initrd
> [    0.000000] memblock_alloc_try_nid: 8257 bytes align=0x40 nid=-1
> from=0x0000000000000000 max_addr=0x0000000000000000
> early_init_dt_alloc_memory_arch+0x30/0x60
> [    0.000000] memblock_reserve: [0x0000000004000000-0x0000000004002040]
> memblock_alloc_range_nid+0xf0/0x178
> [    0.000000] memblock_alloc_try_nid: 37972 bytes align=0x8 nid=-1
> from=0x0000000000000000 max_addr=0x0000000000000000
> early_init_dt_alloc_memory_arch+0x30/0x60
> [    0.000000] memblock_reserve: [0x0000000004002048-0x000000000400b49b]
> memblock_alloc_range_nid+0xf0/0x178
 
As far as I can tell, the kernel lives in 0x200000 and using mem=3G@64M
removes the memory with the kernel and also makes the kernel think there is
memory between 0x400000 and 0xf000000 while there seem to be a hole up to
0x90200000.

This definitely can be reason for the hangs.



-- 
Sincerely yours,
Mike.
