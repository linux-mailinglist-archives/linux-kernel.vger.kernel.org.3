Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DAE5127B3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 01:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbiD0Xud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 19:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiD0Xu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 19:50:29 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5569923152
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 16:47:14 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id k12so5734555lfr.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 16:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d3JBH032OZXYtpGBAJOzi6uljYApdpfKzOYh6bko7eE=;
        b=Zg3c9TEeRcdmFxIUpyUxh/c2tfEr/aXAjm2pGWVZHwiw4P6Kmi/L06xaTKfuLgurXT
         qVPh8TPrmvVNdlaqB0UkF+w2Jy1JrwSLn2ljHkkxT3ESMZJY5sSd+jIu5IkRrcYOW/eD
         nPzQpVv+yCMe/1OaO+WUq+ojpx4C/Oo3Rhu2gSHHhuRCDVr0BzUmVW1moSFRctlK60q5
         4kjRArum4zfjukZQMKc9UfOW24hPl06V4NKl1B93D+vC4LkWqPrW30+IBByE30/J7AZi
         gyIiaiyRcJJmmThYd92r7ncjW4ygt8hJ5fMqypqpSiuzmRP/zYWrrD/0IlvkzP4AkSRX
         +F0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d3JBH032OZXYtpGBAJOzi6uljYApdpfKzOYh6bko7eE=;
        b=3KPb+fdApgW1+9+lBgE6zza9INVLX6nsrkP+Lm38JgrCBS9QgsDfJcK2xI88gRurwa
         IrBXWPL3+0SQJHKFqKAEIsPU1cuGlrM8FRZDlG0OSH5J9DYyKhCh5YBxoJF1M8F4grRP
         tFthc4hiYxEq6/MLENIlb4XxyfohwbJZmIfKHC4+bx8wWfR8L7U71KywaZXcbsQmPbxj
         zykKN1RN0rU7dSCjS4TY4lf4YHgb6T+LAZxsE/P+/UBa9+2K4y7cCIK2l204Gg6rdWFq
         neiDAbUmQVW3pguOGyuUZOSjAX7b0CGXFOY+KmhBVUi5Ca9HlPiij6DqDufQUArBNvGF
         Tzew==
X-Gm-Message-State: AOAM531JOJw8O8Aq3YnH0cXzFCGr5GS3HTx27s1YDqrlzWwJDmBT9miG
        0D1NLm8Hm8GkZiC+mkUV3z42sw==
X-Google-Smtp-Source: ABdhPJyd7/6yh5iiIuj8rn3P0ozgbW9QsBWtwoT+5W/WRCywnd7rODQGiWIZNF2Y10nc1W1hO8atgw==
X-Received: by 2002:a05:6512:3f26:b0:46b:92c0:54da with SMTP id y38-20020a0565123f2600b0046b92c054damr23590201lfa.369.1651103232451;
        Wed, 27 Apr 2022 16:47:12 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id n7-20020a19ef07000000b004720eb4c309sm939338lfh.201.2022.04.27.16.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 16:47:11 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 74DEB103701; Thu, 28 Apr 2022 02:48:53 +0300 (+03)
Date:   Thu, 28 Apr 2022 02:48:53 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 03/12] efi/x86: Get full memory map in allocate_e820()
Message-ID: <20220427234853.6kt67gjrwzrhgvoa@box.shutemov.name>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-4-kirill.shutemov@linux.intel.com>
 <YmmmpxVDyc3R5K2t@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmmmpxVDyc3R5K2t@zn.tnic>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 10:25:11PM +0200, Borislav Petkov wrote:
> On Mon, Apr 25, 2022 at 06:39:25AM +0300, Kirill A. Shutemov wrote:
> >  static efi_status_t allocate_e820(struct boot_params *params,
> > +				  struct efi_boot_memmap *map,
> >  				  struct setup_data **e820ext,
> >  				  u32 *e820ext_size)
> >  {
> > -	unsigned long map_size, desc_size, map_key;
> >  	efi_status_t status;
> > -	__u32 nr_desc, desc_version;
> > +	__u32 nr_desc;
> >  
> > -	/* Only need the size of the mem map and size of each mem descriptor */
> > -	map_size = 0;
> > -	status = efi_bs_call(get_memory_map, &map_size, NULL, &map_key,
> > -			     &desc_size, &desc_version);
> > -	if (status != EFI_BUFFER_TOO_SMALL)
> > -		return (status != EFI_SUCCESS) ? status : EFI_UNSUPPORTED;
> > -
> > -	nr_desc = map_size / desc_size + EFI_MMAP_NR_SLACK_SLOTS;
> > +	status = efi_get_memory_map(map);
> > +	if (status != EFI_SUCCESS)
> > +		return status;
> >  
> > -	if (nr_desc > ARRAY_SIZE(params->e820_table)) {
> > -		u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table);
> > +	nr_desc = *map->map_size / *map->desc_size;
> > +	if (nr_desc > ARRAY_SIZE(params->e820_table) - EFI_MMAP_NR_SLACK_SLOTS) {
> > +		u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table) +
> > +			EFI_MMAP_NR_SLACK_SLOTS;
> >  
> >  		status = alloc_e820ext(nr_e820ext, e820ext, e820ext_size);
> >  		if (status != EFI_SUCCESS)
> > -			return status;
> > +			goto out;
> 
> Still silly, that label is useless then. Pasting the whole, simplified
> function below.
> 
> It looks like it all boils down to propagating the retval up the chain...

Right. That's true. But having goto here makes patch 5/12 a bit cleaner.
I will move the goto there. Is that what you want to see?

-- 
 Kirill A. Shutemov
