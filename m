Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7483259180B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 03:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238097AbiHMBL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 21:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbiHMBLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 21:11:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4255A98EC
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 18:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=z3LeUQqSqNF+zhPbEyas/WieBbgXjfc7Yll+8WLvVYo=; b=aSd2jTOp0qdGoLetyk5Y3kMQOU
        10yUdTRNC7JbNHiytTDePtm5OGrFoc6SjNyemyIjvMpkKG+zE7syj82THgfvFdIzfsAW7i9o8kbss
        tv4doHTI7QT+iswFWj2SUiXVZLyPB3ilhEw6vC241b4R7pVKbe2oTfH9RSN3LRBkX7LweTVJ4nCn6
        YRswF8BGt94/7bk+U+blOTlD4x5X+gYujRBwXlggYnAMVQd9NRon4kPo7hkpllT5sw6ka+tG6sAbB
        nuzd1NBM+AaCItBjkGeSw0WDhhqlYsAx24QU72ArX0vrhBnEEHJqR/f3vnaRu0bHgXSRlyFsGXzTM
        iZ9R+D2Q==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oMfgd-001eZT-Vy; Sat, 13 Aug 2022 01:11:36 +0000
Message-ID: <2e15fc72-5483-b901-5a54-d4a4529d61d9@infradead.org>
Date:   Fri, 12 Aug 2022 18:11:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v2 12/12] mm: make MAX_ORDER a kernel boot time
 parameter.
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
 <20220811231643.1012912-13-zi.yan@sent.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220811231643.1012912-13-zi.yan@sent.com>
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
> index e558f5679707..acccb919d72d 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -455,6 +455,19 @@ config SET_MAX_ORDER
>  	  increase this value. A value of 10 means that the largest free memory
>  	  block is 2^10 pages.
>  
> +config BOOT_TIME_MAX_ORDER
> +	bool "Set maximum order of buddy allocator at boot time"
> +	depends on SPARSEMEM_VMEMMAP && (ARCH_FORCE_MAX_ORDER != 0 || SET_MAX_ORDER != 0)
> +	help
> +	  It enables users to set the maximum order of buddy allocator at system
> +      boot time instead of a static MACRO set at compilation time. Systems with
> +      a lot of memory might want to allocate large pages whereas it is much
> +      less feasible and desirable for systems with less memory. This option
> +      allows different systems to control the largest page they want to
> +      allocate. By default, MAX_ORDER will be set to ARCH_FORCE_MAX_ORDER or
> +      SET_MAX_ORDER, whichever is non-zero, when the boot time parameter is not
> +      set. The maximum of MAX_ORDER is currently limited at 256.

Please make sure that all lines of help text are indented with one tab + 2 spaces,
as specified in Documentation/process/coding-style.rst.

Thanks.
-- 
~Randy
