Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D104E4AC694
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244235AbiBGQ7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236345AbiBGQ5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:57:43 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1636BC0401D3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644253063; x=1675789063;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=Z79hgMEkdxybZRadlKM7A5bBrra05DMpKTx5SRcwoac=;
  b=ekaUYtF4EX221o0SX/gwcBI18Y6qYqKzOgS1bMZUyBDeL4a0nkzSI8TJ
   u2Ba+jYYqJP+WvOXBBuwvF2Ckb/w7MufCHAu+OFgkuJvESS5Sk+PBWMzS
   Wdax/G6PrDwSTU+8MNHie9Od3Igj4/xGsrU5El7bMvr5cHu/IWFHXcqbN
   r3j5QZ4RsEmX3AoXQLariPl4tWHJUOI+kkoU7H0ArbIUDb2mzwbNarrgX
   Ay/CAmqHFNaobDEESgBWXotM3rl+JgnbMFVUXgp3gvamxSnLXKH8/ceua
   75qGhon/OXKSyKuS4kfjE83s9upVvkvB6AJQd9iQnrdHchGeH9nPYeGya
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="309502441"
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="309502441"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 08:57:42 -0800
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="525203095"
Received: from hgrunes-mobl1.amr.corp.intel.com (HELO [10.251.3.57]) ([10.251.3.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 08:57:41 -0800
Message-ID: <1d77e91c-e151-7846-6cd4-6264236ca5ae@intel.com>
Date:   Mon, 7 Feb 2022 08:57:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, jpoimboe@redhat.com,
        knsathya@kernel.org, pbonzini@redhat.com, sdeep@vmware.com,
        seanjc@google.com, tony.luck@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-23-kirill.shutemov@linux.intel.com>
 <YgFIaJ8ijgQQ04Nv@zn.tnic>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv2 22/29] x86/tdx: Make pages shared in ioremap()
In-Reply-To: <YgFIaJ8ijgQQ04Nv@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/22 08:27, Borislav Petkov wrote:
> On Mon, Jan 24, 2022 at 06:02:08PM +0300, Kirill A. Shutemov wrote:
>> -/*
>> - * Macros to add or remove encryption attribute
>> - */
>> -#define pgprot_encrypted(prot)	__pgprot(__sme_set(pgprot_val(prot)))
>> -#define pgprot_decrypted(prot)	__pgprot(__sme_clr(pgprot_val(prot)))
> Why can't you simply define
> 
> cc_set() and cc_clear()
> 
> helpers which either call the __sme variants or __tdx variants, the
> latter you can define the same way, respectively, as the __sme ones.

I think your basic point here is valid: Let's have a single function to
take a pgprot and turn it into an "encrypted" or "decrypted" pgprot.

But, we can't do it with functions like cc_set() and cc_clear() because
the polarity is different:

> +pgprot_t pgprot_encrypted(pgprot_t prot)
> +{
> +        if (sme_me_mask)
> +                return __pgprot(__sme_set(pgprot_val(prot)));
> +        else if (is_tdx_guest())
> +		return __pgprot(pgprot_val(prot) & ~tdx_shared_mask());
> +
> +        return prot;
> +}

For "encrypted", SME sets bits and TDX clears bits.

For "decrypted", SME clears bits and TDX sets bits.

We can surely *do* this with cc_something() helpers.  It's just not as
easy as making cc_set/cc_clear().
