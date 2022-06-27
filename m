Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F2355C5B8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240258AbiF0S2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 14:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240206AbiF0S1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 14:27:53 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B811BE86
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 11:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656354334; x=1687890334;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xe7kacyl9bO/ZeCSzMnNJMOTxfLtXjZzNmW8e5Zn/ok=;
  b=Vnfqxn3oB/gkdY63Fqbwae2k/sekdJb6XuV4/stT3PkmKI+smi1KFgx+
   2HE6tLFgFQp5zoLxXm9+36/guowdbH7oNeP99X6zSoywgPvvSxYi3oPXy
   VdDdW/NQBoLJBB8nFb/spnbFQQ+MYlFL+qSA1+8BQn35Epfjfr46OB6bZ
   0fAI080BKCCPRaR8O8ApyWkdJ9ExcWxwE7auzP9wOk8ftAaujtlU7vIbt
   qaEIxIindLMig3NgEbmChZj1XMCyg0nFul/cf5dKpsrR+kWV3lVVJIy+9
   Km/JpTwAaYM0F8uhJpfsQXp+nBGqI+VO+yp2meRNmnPT/vjvbgO0+j0wz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="264572146"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="264572146"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 11:25:31 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="732427370"
Received: from jsagoe-mobl1.amr.corp.intel.com (HELO [10.209.12.66]) ([10.209.12.66])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 11:25:30 -0700
Message-ID: <fe896ec7-cfce-e8ce-240d-88cca47f8996@intel.com>
Date:   Mon, 27 Jun 2022 11:24:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 4/5] x86/mm: Add noalias variants of
 set_memory_*crypted() functions
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <b4190b5d-89e8-b02f-5ef6-c05047af8166@intel.com>
 <20220627151257.fhynhvcnpk22kflw@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220627151257.fhynhvcnpk22kflw@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/22 08:12, Kirill A. Shutemov wrote:
> It made me thing about my recent story with load_unaligned_zeropad(). 
> If we leave the page in direct mapping mapped as private and
> load_unaligned_zeropad() will roll off to it, we will get SEPT violation
> that will terminate the TD as it is considered unaccepted.
> 
> I think we must keep aliases in think. And vmap() doesn't make much sense
> in this case :/
> 
> I urge you folks to consider DMA API again. Or have any other way to tap
> into swiotlb pool.

Ugh.  This is a good point.  We need *PHYSICAL* pages to pad the front
of any page we use for the quotes.  That means some crazy code like:

	struct page *pages[nr_pages];
	struct page *pages_vmap[nr_pages];

	for (i = 0; i < nr_pages; i++) {
		// allocate an extra "padding" page:
		pages[i] = alloc_pages(1, GFP_WHATEVER);
				       ^ note the order=1
		// record the page that will be vmap()'d:
		pages_vmap[i] = pages[i]+1;
		set_pages_decrypted(page_to_virt(pages_vmap[i]));
	}

	vmap(pages_vmap, nr_pages);

That's just adorable.  The other way is to do alloc_pages_exact() with
*one* extra page and just use contiguous memory for it.

I still don't like the idea of using the DMA API itself.  But, maybe we
need some common infrastructure that the DMA API and this code use which
says, "get me some pages that I can safely make shared".
