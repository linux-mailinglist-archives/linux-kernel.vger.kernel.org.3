Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60794B777B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237435AbiBORdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:33:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239664AbiBORdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:33:23 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BA927FDF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644946393; x=1676482393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gJUGtCvvXeZqrYRso3Nwr3JInrBDJ7SWRDxdjwvW/Mk=;
  b=Jgcfuoi2cT0ysLSuNII9+Za6Pk0wzC6gk4NB1sJoOIZYn+qqPMFILFHy
   GFA4sz5fubs+qdRiItPtgami5voj8wdcvWTK/+gFVHMqfi6v3vqDvpw0R
   qvQy31c0/DaXjNiTxfsPTS3mb8i1XWFIdILYA98meHpqjPAcrYrzlnA++
   GHi32QsfOv+SUmcqYg2LCFc0MCpUST1xO2IuTmHl8bLAkQZDWOHYyg1//
   1flyAEf9FG5estAwBAWy71gBP8ouJVeXvZF7YSSGTwwPEJo7rvuz9sC3S
   Ygyo9ZH9HNj+tzEIRjO4QU+JqpLoimZr7xti9KpdM/QyP1y7BGlf1k1uY
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="250352695"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="250352695"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 09:33:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="587813737"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 15 Feb 2022 09:33:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id DBA48107; Tue, 15 Feb 2022 19:33:21 +0200 (EET)
Date:   Tue, 15 Feb 2022 20:33:21 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>, tglx@linutronix.de,
        mingo@redhat.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 22/29] x86/tdx: Make pages shared in ioremap()
Message-ID: <20220215173321.lwvfl6rxifrkcoit@black.fi.intel.com>
References: <20220124150215.36893-23-kirill.shutemov@linux.intel.com>
 <YgFIaJ8ijgQQ04Nv@zn.tnic>
 <1d77e91c-e151-7846-6cd4-6264236ca5ae@intel.com>
 <YgFWpGQfA84Y0mW/@zn.tnic>
 <20220214220926.fjwlyieatwjhcpij@black.fi.intel.com>
 <f1dfc268-7b2f-9980-27ce-0b5bb1aea962@amd.com>
 <20220215154118.ldpvvk5seljntl44@black.fi.intel.com>
 <dd21e54a-a431-4d6f-47b7-ab1a3e8e0cc8@amd.com>
 <20220215162722.cvzik5r57spr2krz@black.fi.intel.com>
 <52e34ee2-e6a8-5b5c-41f9-5fcf21902a25@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52e34ee2-e6a8-5b5c-41f9-5fcf21902a25@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 08:34:53AM -0800, Dave Hansen wrote:
> On 2/15/22 08:27, Kirill A. Shutemov wrote:
> >>> But with u64 as type, I'm not sure 'pgprot' in the name is jutified.
> >> Maybe cc_mask_{enc,dec}()? It just sounds like cc_{enc,dec}() is actually
> >> performing encryption or decryption and can be confusing.
> > cc_{enc,dec}_mask() sounds better to me.
> 
> The pte_mk*() functions might be a good naming model here.  Some of them
> clear bits and some set them, but they all "make" a PTE.

Like cc_mkencrypted()/cc_mkdecrypted()? I donno. Looks strange.

-- 
 Kirill A. Shutemov
