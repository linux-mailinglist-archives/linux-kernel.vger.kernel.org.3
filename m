Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8FA4BED2B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 23:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbiBUWWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 17:22:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbiBUWWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 17:22:02 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC97E22
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 14:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645482098; x=1677018098;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XD/QnGDyucc+ihEeTnUvGtHSPCLuDU838JzWCytPOIs=;
  b=ml6eYiUmcUCY977IBGCtx4f06M7IXNhQTYLBIXN6gEtX7YoJLmHWQzCW
   s+B9O10lXRYsGuyAEx5afnr7GAbiTLIEyvdaXMyAqk63ua9kZIpLxCNrF
   q8+FeP8+OgWRVb8ho7YAqPKHRfybEzQIcCZgM88hfks0cqxtq7Wwk77iB
   WxEGtGRybbOTADP/CQMrmIXi9W7SrZ2tPKac5Xw+LVhM1cJM7BcTVD+IR
   FO1m3paZGgUY6ZqiekYT5Q1mYVo84cZJgo5IOpe3gX7y70hRNFg0DU0Ls
   o4US6Iislyg5/eP7Ij8FD0fkPUeYd7iCGWjdCUJVQYd+niR0c+BUIzwOC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="338006742"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="338006742"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 14:21:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="776105942"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 21 Feb 2022 14:21:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 6597B12C; Tue, 22 Feb 2022 00:21:49 +0200 (EET)
Date:   Tue, 22 Feb 2022 01:21:49 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 02/32] x86/coco: Add API to handle encryption mask
Message-ID: <20220221222149.jpuwlinaihq6fjwy@black.fi.intel.com>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
 <20220218161718.67148-3-kirill.shutemov@linux.intel.com>
 <66fcd7e7-deb6-f27e-9fc6-33293ce04f16@intel.com>
 <20220218213300.2bs4t3admhozonaq@black.fi.intel.com>
 <7ebd6ba1-85a4-6fee-c897-22ed108ac8b7@intel.com>
 <YhPst1DdG3T5hsnM@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhPst1DdG3T5hsnM@zn.tnic>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 08:49:11PM +0100, Borislav Petkov wrote:
> On Mon, Feb 21, 2022 at 11:28:16AM -0800, Dave Hansen wrote:
> > Why don't we just have:
> > 
> > 	pgprot_t cc_mkenc(pgprot prot)
> > 	pgprot_t cc_mkenc(pgprot prot)
> > 
> > and *no* pgprot_{en,de}crypted()?
> 
> Yes, and can the above cc_get_mask() thing be:
> 
> 	cpa.mask_set = enc ? cc_mkenc(0) : cc_mkdec(0);
> 	cpa.mask_clr = enc ? cc_mkdec(0) : cc_mkenc(0);
> 
> since we're going to feed it pgprot things?

Well, it actually going to be

 	cpa.mask_set = enc ? cc_mkenc(__pgprot(0)) : cc_mkdec(__pgprot(0));
 	cpa.mask_clr = enc ? cc_mkdec(__pgprot(0)) : cc_mkenc(__pgprot(0));

as '0' is not a valid pgprot_t.

Still wonna go this path?

-- 
 Kirill A. Shutemov
