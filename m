Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076BC59180A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 03:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbiHMBLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 21:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbiHMBLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 21:11:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3ACEA598E
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 18:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=JWBoT2glIn/13QDTu41Nqhp1XoaLX7F6+qyi5O/vBqI=; b=Vrk13mcLQUjTlS7qDwG4jIdHoI
        q/89MPbAAkRadYDMu4MjWUVmwe99hDpczUWZLpkmYO/McelIQlhJQCljDCUeMEXqFjUqcjxLTsVu/
        NFqaIrozbN9/a5iP+3oyd50TAdoJd197xQq47XAc/vamfsO9xU4qSHJqm6bGiFUN5T8i47lZSxCBB
        bI4hSiGwJq7xXTnkF1vi58Kkiztzo4dZt0B4OXyxOAPYDUypFoOqIgmPiyrm5Ga2giZgLnBY2ire0
        ev7cp7AUIXRbRL1Yj/QXdWbdOPD1qlSFPlS9d4znI+asLAvPA2hqwQY/Qi755jhqRVJNk8hGZiApl
        /0UQcDgg==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oMfgb-001eXA-3V; Sat, 13 Aug 2022 01:11:33 +0000
Message-ID: <becc0751-9ce9-6fab-8e58-477e962e54c5@infradead.org>
Date:   Fri, 12 Aug 2022 18:11:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v2 09/12] mm: Make MAX_ORDER of buddy allocator
 configurable via Kconfig SET_MAX_ORDER.
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        David Rientjes <rientjes@google.com>,
        James Houghton <jthoughton@google.com>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
References: <20220811231643.1012912-1-zi.yan@sent.com>
 <20220811231643.1012912-10-zi.yan@sent.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220811231643.1012912-10-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 8/11/22 16:16, Zi Yan wrote:

> diff --git a/mm/Kconfig b/mm/Kconfig
> index bbe31e85afee..e558f5679707 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -441,6 +441,20 @@ config SPARSEMEM_VMEMMAP
>  	  pfn_to_page and page_to_pfn operations.  This is the most
>  	  efficient option when sufficient kernel resources are available.
>  
> +config SET_MAX_ORDER
> +	int "Set maximum order of buddy allocator"
> +    depends on SPARSEMEM_VMEMMAP && (ARCH_FORCE_MAX_ORDER = 0)
> +	range 10 255
> +	default "10"
> +	help
> +	  The kernel memory allocator divides physically contiguous memory
> +	  blocks into "zones", where each zone is a power of two number of
> +	  pages.  This option selects the largest power of two that the kernel
> +	  keeps in the memory allocator.  If you need to allocate very large
> +	  blocks of physically contiguous memory, then you may need to
> +	  increase this value. A value of 10 means that the largest free memory
> +	  block is 2^10 pages.

Please make sure that all lines of help text are indented with one tab + 2 spaces,
as specified in Documentation/process/coding-style.rst.

thanks.
-- 
~Randy
