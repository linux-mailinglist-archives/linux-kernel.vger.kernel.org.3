Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E86D4BEE0E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 00:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbiBUXTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 18:19:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236520AbiBUXTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 18:19:17 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E7C24F25
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645485502; x=1677021502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6cWXqnm3BDGaKFT3v5LpcFFRCelK7Kg/AgqC0yuSaeM=;
  b=TwBV+rDXTZS4iwE0flFrSKC+7L/4gKBO1y68WwP3SoVAxXhWxf9fJa2k
   wLyRxHpVuh3srpHFRyLsteOQL8fe/jl6/7gGujBO13AGQ0Jd5RdSaoSCE
   Qpu6wNvLL4HW/jFQW9M/55fFf0Qae6T81DY2gnMap/iy/uQloeTW/EG9B
   WjOt4vTdlEFJivvT61xXUDT44+qpwpi5JNzxDnlcvXZM62F4m7s2Y27tU
   VgQc7I95FXNlJq6jGZoezTxf3yddCmQfzkCu7aD0vHQC6ToGmi4JtidLf
   pBOz0tiZOimhak1iF7VLBU2NUCP2WBb5ALWL94yJsbQNKV3qMPYwvLNGe
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="250400470"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="250400470"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 15:18:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="591099072"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 21 Feb 2022 15:18:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 1207A12C; Tue, 22 Feb 2022 01:18:31 +0200 (EET)
Date:   Tue, 22 Feb 2022 02:18:31 +0300
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
Message-ID: <20220221231831.dukkbvjdc5e3mu7c@black.fi.intel.com>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
 <20220218161718.67148-3-kirill.shutemov@linux.intel.com>
 <66fcd7e7-deb6-f27e-9fc6-33293ce04f16@intel.com>
 <20220218213300.2bs4t3admhozonaq@black.fi.intel.com>
 <7ebd6ba1-85a4-6fee-c897-22ed108ac8b7@intel.com>
 <YhPst1DdG3T5hsnM@zn.tnic>
 <20220221222149.jpuwlinaihq6fjwy@black.fi.intel.com>
 <YhQYgBYOBtdPD65X@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhQYgBYOBtdPD65X@zn.tnic>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 11:56:00PM +0100, Borislav Petkov wrote:
> On Tue, Feb 22, 2022 at 01:21:49AM +0300, Kirill A. Shutemov wrote:
> > Well, it actually going to be
> > 
> >  	cpa.mask_set = enc ? cc_mkenc(__pgprot(0)) : cc_mkdec(__pgprot(0));
> >  	cpa.mask_clr = enc ? cc_mkdec(__pgprot(0)) : cc_mkenc(__pgprot(0));
> > 
> > as '0' is not a valid pgprot_t.
> > 
> > Still wonna go this path?
> 
> Why "still"? What's wrong with that?

IMO, it makes these statement substantially uglier.

-- 
 Kirill A. Shutemov
