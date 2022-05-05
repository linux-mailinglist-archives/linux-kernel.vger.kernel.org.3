Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6719751C577
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382129AbiEEQ5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 12:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbiEEQ5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 12:57:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D3D57B15;
        Thu,  5 May 2022 09:54:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5AF10B82E0B;
        Thu,  5 May 2022 16:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6051C385A4;
        Thu,  5 May 2022 16:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651769646;
        bh=p+Bv32mI3hSoH46S0grONiKmXRZCUz+77zQaW/pFQpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ge893G0ricbEaTvms2L5/YKhHTsgFuJ/7NLqXN3SX8NpXoG2SV4/QAnKg1fa109xu
         k7OgZmCSKyvaWwnM3hHRoJ7fcDiiDzSqvYkeAQPgZqW9PoY6NESDTdv+bgwuPCaE6R
         2c3iK+pMen4QnzLomiBDyIhvf+zfmylWCC7WvWpZC5MYR7MkJ47Xn8s42+jHPDU2Ar
         3Vn2VIByNoahv8T79eZxtwcpkmm4bl0dxt6r/UIY/LwKtlSJ/LKOOlpIewpoxoR5un
         jdfKjFww+mxhzHURhRk8F2TWG51rnNI922vQ/Y5tjFIgC5eeeBLRfY+wMN/sFcMtTH
         oxd028ySdMxMw==
Date:   Thu, 5 May 2022 09:54:00 -0700
From:   Mike Rapoport <rppt@kernel.org>
To:     Faiyaz Mohammed <quic_faiyazm@quicinc.com>
Cc:     quic_vjitta@quicinc.com, karahmed@amazon.de, qperret@google.com,
        robh@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org
Subject: Re: [PATCH] mm: memblock: avoid to create memmap for memblock nomap
 regions
Message-ID: <YnQBKPWtPa87y4NA@kernel.org>
References: <1649704172-13181-1-git-send-email-quic_faiyazm@quicinc.com>
 <YlW2TO0O8qDHpkGW@kernel.org>
 <7b18bea8-b996-601d-f490-cb8aadfffa1b@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b18bea8-b996-601d-f490-cb8aadfffa1b@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 08:46:15PM +0530, Faiyaz Mohammed wrote:
> 
> On 4/12/2022 10:56 PM, Mike Rapoport wrote:
> > On Tue, Apr 12, 2022 at 12:39:32AM +0530, Faiyaz Mohammed wrote:
> >> This 'commit 86588296acbf ("fdt: Properly handle "no-map" field in the
> >> memory region")' is keeping the no-map regions in memblock.memory with
> >> MEMBLOCK_NOMAP flag set to use no-map memory for EFI using memblock api's,
> >> but during the initialization sparse_init mark all memblock.memory as
> >> present using for_each_mem_pfn_range, which is creating the memmap for
> >> no-map memblock regions. To avoid it skiping the memblock.memory regions
> >> set with MEMBLOCK_NOMAP set and with this change we will be able to save
> >> ~11MB memory for ~612MB carve out.
> > The MEMBLOCK_NOMAP is very fragile and caused a lot of issues already. I
> > really don't like the idea if adding more implicit assumptions about how
> > NOMAP memory may or may not be used in a generic iterator function.
> 
> Sorry for delayed response.
> Yes, it is possible that implicit assumption can create
> misunderstanding. How about adding command line option and control the
> no-map region in fdt.c driver, to decide whether to keep "no-map" region
> with NOMAP flag or remove?. Something like below

I really don't like memblock_remove() for such cases.
Pretending there is a hole when there is an actual DRAM makes things really
hairy when it comes to memory map and page allocator initialization.
You wouldn't want to trade system stability and random memory corruptions
for 11M of "saved" memory.
 
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1180,8 +1180,10 @@ int __init __weak
> early_init_dt_reserve_memory_arch(phys_addr_t base,
>                  */
>                 if (memblock_is_region_reserved(base, size))
>                         return -EBUSY;
> -
> -               return memblock_mark_nomap(base, size);
> +               if (remove_nomap_region)
> +                       return memblock_remove(base, size);
> +               else
> +                       return memblock_mark_nomap(base, size);
> Thanks and regards,
> Mohammed Faiyaz
> 

-- 
Sincerely yours,
Mike.
