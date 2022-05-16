Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF667528660
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244213AbiEPOFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244170AbiEPOFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:05:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B023A1AC
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 07:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652709914; x=1684245914;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xfUbkQZw0S92oKI8y36PgkSXoImP8mak437/D1fQZ04=;
  b=fBIfnBO8aMJESwDdQLWpS7Eqcrnk2lRnTkBcip27UtIbqeYNmtlJSkKM
   72xDs9rPbiWBRbYQaqgnIw071IneDdxHJMedLopcp+h4gZwLAQnVudx67
   s4eIeASFQmHYE4cu4Bn9IkCDREPFm/0FXwb3kKImrezPTSUqyswzxou3k
   Z826kUL4dA6OYYoH6q+M59qrWCw6Te+8jtEoZECoHvQ4P0O7MUYs4HCVQ
   d2UnNN5iIoKs0do9qN0NH+Bt/+IMT4p/VcuLAsZkGRZyGeDUGI1NNNrg2
   lgU+zqG9mrdsxjT37QGSXWLuGHe+jGhuWyWst/cn3el9K/SCN+bQgFFLd
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="250735951"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="250735951"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 07:04:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="555263415"
Received: from dmjacob-mobl.amr.corp.intel.com (HELO [10.212.130.28]) ([10.212.130.28])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 07:04:33 -0700
Message-ID: <3f2f7c09-ddf3-6052-9860-8554a4ff2798@intel.com>
Date:   Mon, 16 May 2022 07:04:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Is _PAGE_PROTNONE set only for user mappings?
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
        akpm@linux-foundation.org, willy@infradead.org
References: <20220506051940.156952-1-42.hyeyoo@gmail.com>
 <56f89895-601e-44c9-bda4-5fae6782e27e@amd.com> <YnpTHMvOO/pLJQ+l@hyeyoo>
 <5fe161cb-6c55-6c4d-c208-16c77e115d3f@amd.com>
 <8c2735ac-0335-6e2a-8341-8266d5d13c30@intel.com> <YntHrTX12TGp35aF@hyeyoo>
 <20220512103748.GH3441@techsingularity.net> <Yn3tssUR8w8mC1DJ@hyeyoo>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Yn3tssUR8w8mC1DJ@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/22 22:33, Hyeonggon Yoo wrote:
> Thanks Mel, and IIUC nor does do_kern_addr_fault() in arch/x86/mm/fault.c
> expect _PAGE_PROTNONE instead of _PAGE_GLOBAL. I want to make it clear
> in the code that _PAGE_PROTNONE is only used for user mappings.
> 
> How does below look?
> 
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index 40497a9020c6..f8d02b91a90c 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -35,7 +35,10 @@
>  #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
>  
>  /* If _PAGE_BIT_PRESENT is clear, we use these: */
> -/* - if the user mapped it with PROT_NONE; pte_present gives true */
> +/*
> + * if the user mapped it with PROT_NONE; pte_present gives true
> + * this is only used for user mappings (with _PAGE_BIT_USER)
> + */
>  #define _PAGE_BIT_PROTNONE	_PAGE_BIT_GLOBAL
>  
>  #define _PAGE_PRESENT	(_AT(pteval_t, 1) << _PAGE_BIT_PRESENT)
> @@ -115,7 +118,8 @@
>  #define _PAGE_DEVMAP	(_AT(pteval_t, 0))
>  #endif
>  
> -#define _PAGE_PROTNONE	(_AT(pteval_t, 1) << _PAGE_BIT_PROTNONE)
> +#define _PAGE_PROTNONE	((_AT(pteval_t, 1) << _PAGE_BIT_USER) | \
> +			 (_AT(pteval_t, 1) << _PAGE_BIT_PROTNONE))
>  
>  /*
>   * Set of bits not changed in pte_modify.  The pte's

I don't like the idea of _PAGE_BIT_USER being so implicit.  It is
something kernel users should know explicitly that they are messing with.

I was thinking of something more along the lines of taking the
set_memory.c code and ensuring that it never sets (or even observes)
_PAGE_BIT_GLOBAL on a _PAGE_USER mapping.  There was also a question of
if set_memory.c is ever used on userspace mappings.  It would be good to
validate whether it's possible in-tree today and if not, enforce that
_PAGE_USER PTEs should never even be observed with set_memory.c.

The arch/x86/mm/dump_pagetables.c code is also a reasonable place to put
assumptions about the page tables since it walks *everything* when asked.
