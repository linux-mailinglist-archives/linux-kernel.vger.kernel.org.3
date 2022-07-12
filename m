Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420BC570EC5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiGLAQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiGLAQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:16:23 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C0A31352;
        Mon, 11 Jul 2022 17:15:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1657584897; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=bJmObJhUXPfREMqCN/WvVFaSBUz3AzVlTwIJKfvLDHoe1aG6K7Iqc4ovk/XOOtlgXLTGsjOwF4JoS8ZWQfquvAZ+nspaUKHGAabfjufMaeksl3J0Wma8w3FrjHTrYGL/azYM2wZr1L7giIUz5mvI/OeW1d/maBtAD4yGIyjVZIk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1657584897; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=fhJVT85aTlBQWQb6yaeXraBInDSuiyuvEmq9JyUyXYE=; 
        b=HJXLnQdePfBzYS5gYvF2NWYq6Ar0h+zlTQeWYGDsmpy47vOMKQ1cguN2NJ3nOFpcdqRWJEYd0V0ewebpw87dq4EmRKZC1Mt1eEv6zcO0Hj50baqOiLSxitRYwkUC33qqZQ05ygR7jv4iKMRhZ2KOt7bR4+5Xp7O8A08iD42DfB0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1657584897;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=fhJVT85aTlBQWQb6yaeXraBInDSuiyuvEmq9JyUyXYE=;
        b=ht469zLCvWSqlKO3GMKF5L1p8SJlW6uMKUtxZUtAmkO/WlFcm1aMBSqQvNJ/dgUN
        vTxuNTnejwgRWnlF1T5TDGb3pDxejhjEgsaZYCNzMF3F/15bHdKcnGgUDFjdVU02U6D
        TZdqG93CB0fZCtau2mX8Ml/V9B1YS81TCUVheAU8=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1657584897026777.3647169706071; Mon, 11 Jul 2022 17:14:57 -0700 (PDT)
Date:   Tue, 12 Jul 2022 08:14:56 +0800
From:   Li Chen <me@linux.beauty>
To:     "Christoph Hellwig" <hch@infradead.org>
Cc:     "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Frank Rowand" <frowand.list@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "devicetree" <devicetree@vger.kernel.org>,
        "linux-mm" <linux-mm@kvack.org>
Message-ID: <181efc24bdd.108279419521615.7697137316951540027@linux.beauty>
In-Reply-To: <YsxLU66tNvi10c82@infradead.org>
References: <20220711122459.13773-1-me@linux.beauty>
 <Ysw7TMFO8Mw0nq8x@infradead.org>
 <181ee01d384.b809bd01412268.496620746959082770@linux.beauty> <YsxLU66tNvi10c82@infradead.org>
Subject: Re: [PATCH 0/4] add struct page and Direct I/O support to reserved
 memory
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,
 ---- On Tue, 12 Jul 2022 00:09:55 +0800  Christoph Hellwig <hch@infradead.org> wrote --- 
 > On Tue, Jul 12, 2022 at 12:05:06AM +0800, Li Chen wrote:
 > > My use case has been stated in the cover letter, but our driver is not ready for upstream yet.
 > 
 > Which means we can't review the use case.  I'd suggest you come back
 > when you submit your driver.

Totally agree, but we plan to start rewriting the code of our video driver in a long time, it has many legacy codes and I need to rewrite a lot of codes to migrate to v4l2.
That's why I also submit a sample driver here: to make the review progress easier and don't need reviewers to read video driver codes.

 > 
 > > With DMA allocator, we can access buffer in kernel space, not userspace, however, this patch
 > 
 > Take a look at dma_mmap_* on how to map DMA coherent allocations to
 > usersapce.  This is of course easily possible.
 > 

Yes, I know them. They take use of remap_pfn_range, which set VM_IO and VM_PFNMAP on vma, so dio is not possible with them.
IIUC, if you want to expose the kernel's reserved memory to userspace, it doesn't matter whether the memory came from dma allocator or something else.
The point is if they want to get better throughput, they can consider replacing their dma_mmap_* with my reserved_mem_memremap_pages + reserved_mem_dio_mmap.

Regards,
Li
