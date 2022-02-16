Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F354B8B16
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 15:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbiBPOKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 09:10:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiBPOKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 09:10:12 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A9224B2A5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 06:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645020600; x=1676556600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JE5rZMM5sajVsKRI8JKQu1RABLxCXwK0RKNEJpXdTE8=;
  b=A5llajUfm9HHsR0+jQBUftHehyrjPR3h1ii7YmIcwk8B+wPU17trgn/6
   1+f6X4/Ke8kkv21lc6u1zoogRv02k6if5JRESUvssFIsrNW4UTYt/FT8u
   zl0jYsUPaqDgDmWBdTrKVdTX5F9M1L9piYCYbtvcsNA3sWliUnMRbnr9t
   uAR5h6SygtXFjaZs4q9FOT5ZE7oaiPvleZaX4yji5VCD1n5mbnYw7iXW1
   LlbwLJtHwKdywGftrPTZDmn8HPwdMK6tlRssRLz1sepdbWsLEkrhw+2VP
   3WLfx7lfTNnrrN/9irwTdJQEksw7/jBzfLIiuMXvwuh0XLaVv4aYXPusr
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="311347615"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="311347615"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 06:09:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="636503598"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 16 Feb 2022 06:09:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 5497437E; Wed, 16 Feb 2022 16:10:09 +0200 (EET)
Date:   Wed, 16 Feb 2022 17:10:09 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCHv2 16/29] x86/boot: Add a trampoline for booting APs via
 firmware handoff
Message-ID: <20220216141009.ymmjduf5doqnhnqy@black.fi.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-17-kirill.shutemov@linux.intel.com>
 <Yfpqk0amEbcyte+w@zn.tnic>
 <25fec256-7feb-e94d-5e37-3a174b6c6a66@linux.intel.com>
 <Yf0vB+TBR2AjHmV5@zn.tnic>
 <20220215213624.tzdahmbhucupwtqe@black.fi.intel.com>
 <YgzM03ovVdaXhT39@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgzM03ovVdaXhT39@zn.tnic>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 11:07:15AM +0100, Borislav Petkov wrote:
> On Wed, Feb 16, 2022 at 12:36:24AM +0300, Kirill A. Shutemov wrote:
> > How can signle trampoline_start cover all cases?
> 
> All I'm saying is that the real mode header should have a single
> 
> 	u32     trampoline_start;
> 
> instead of:
> 
> 	u32     trampoline_start;
> 	u32     sev_es_trampoline_start;
> 	u32     trampoline_start64;
> 
> which all are the same thing on a single system.

But these are generated at build time, no?

As far as I can see it is initialized in arch/x86/realmode/rm/header.S by
linker.

I'm confused.

-- 
 Kirill A. Shutemov
