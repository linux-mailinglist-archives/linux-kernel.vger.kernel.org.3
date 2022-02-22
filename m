Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD164BF6FF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 12:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiBVLL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 06:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiBVLL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 06:11:27 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83277B54EC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645528262; x=1677064262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B2IQb4utuizq8KLjc41aVift6d3W5gPnAvZk1wsXDAw=;
  b=IPXi1v4KppzzL457FZG1/FjNOTGtFc5/qHlDEK8EM4H0rlt9jdaTZgs1
   amqLBk4WNPvXMrsBWXFaXfEHiEuso+s2TvKtBsuJwGon7catQRJWtmvSc
   zNXQvoj6wZfBs8VwRLa22CUBMhjaFFQE8Bv43KGdHnghGc5LnoArTy8fZ
   wYyDocyNy86jm96MB2D8PtuWNA3ppGdWYI/TuS4zX9741UUVXfsw1UJW1
   4ZBUX19/8/fBgmk/bWWLo5wzO+4G/tBEbejcFul2fhzxWsXF1m65I/jdn
   WFjdx+LpYWmmM1aUldF6fwRk8kenbx3lhBwOB+0VclMRaWj1fmDSYYfxF
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="232293050"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="232293050"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 03:11:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="638868685"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 22 Feb 2022 03:10:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id ED7A9142; Tue, 22 Feb 2022 13:11:10 +0200 (EET)
Date:   Tue, 22 Feb 2022 14:11:10 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dingji Li <dj_lee@sjtu.edu.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCHv3 08/32] x86/traps: Add #VE support for TDX guest
Message-ID: <20220222111110.qe3bjqq6huomqqmi@black.fi.intel.com>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
 <20220218161718.67148-9-kirill.shutemov@linux.intel.com>
 <6A6FFE5E-16C3-4054-837D-77D28A490C85@sjtu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6A6FFE5E-16C3-4054-837D-77D28A490C85@sjtu.edu.cn>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 03:19:47PM +0800, Dingji Li wrote:
> Hi all,
> 
> I hope it is appropriate to ask these questions here:
> 
> I'm wondering if there are any performance comparisons available between
> TDX guests and VMX guests. The #VE processing adds non-trivial overhead
> to various VM exits, but how does it affect the performance of
> real-world applications? Existing patches have listed alternative
> methods to avoid the #VE in the first place, but there are trade-offs
> (e.g., bloated code, reduced generality). Besides, how much does the
> time spent in the TDX module affect VM exits / applications? (I guess
> the TDX module has a low overhead when compared to the #VE processing,
> but there is no public data.) Maybe some performance data can help make
> better trade-offs?

This is basic enabling of TDX guest support. The goal is to make TDX guest
functional. Yes, #VE handling adds non-trivial overhead and we have plan
to migrate it: there are patches in the queue that help to avoid bulk of
#VE, like replacing #VE-based MMIO with direct hypercalls. TDX will still
have performance penalty over plain VMX no matter what, but we aim to
minimize it.

I don't have any performance numbers to share at the moment.

-- 
 Kirill A. Shutemov
