Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9F04AA4E2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 01:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378653AbiBEAGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 19:06:38 -0500
Received: from mga01.intel.com ([192.55.52.88]:10556 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345660AbiBEAGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 19:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644019596; x=1675555596;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=87x09wCX42YlCANd6MmEcEG2zLb348pELCJaCSnL3h8=;
  b=KNreZiqvnumEivsDjoZ813foA5uAns/qhPQvixLGKYSKd5WdE8dTuG+p
   7Rve68Uw2EOOwZgc3ZnzOXTkGFtSarl2nTy8C8E0JV76NZP8ALn7awQev
   81m1xJWdNFILD/PXe/VHgk7ZmOsfKAYpbtqx6+k0JE+gEKXoWHKbxHO/l
   MOs7ZW2P0yD1diFxl6oBUrL7am52RL1lTv2waoeuqbrAhr9yrgf4WO8H0
   4tHxCN/5/BO7ZZ+SPaKnr6yxPkvUH9jcrVwnLtiPgdFD13kBQYzdS35By
   nQCKAlEPF6dAVlqsvyCnk/rGQEcO287VT2rPnTqO9SW9wdoqusAK8bFSS
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="272972041"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="272972041"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 16:06:35 -0800
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="483776846"
Received: from sburujup-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.251.129.31])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 16:06:30 -0800
Date:   Sat, 5 Feb 2022 13:06:28 +1300
From:   Kai Huang <kai.huang@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <aarcange@redhat.com>, <ak@linux.intel.com>,
        <dan.j.williams@intel.com>, <david@redhat.com>, <hpa@zytor.com>,
        <jgross@suse.com>, <jmattson@google.com>, <joro@8bytes.org>,
        <jpoimboe@redhat.com>, <knsathya@kernel.org>,
        <pbonzini@redhat.com>, <sdeep@vmware.com>, <seanjc@google.com>,
        <tony.luck@intel.com>, <vkuznets@redhat.com>,
        <wanpengli@tencent.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 03/29] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
Message-Id: <20220205130628.150d250ee08c3143e9b5e0b2@intel.com>
In-Reply-To: <20220204131826.x57bgwn46kvkm2yw@black.fi.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
        <20220124150215.36893-4-kirill.shutemov@linux.intel.com>
        <87a6faz7cs.ffs@tglx>
        <20220202025519.csymm7r23b3ltpia@black.fi.intel.com>
        <20220202235910.c512857813ea5b14aa73267f@intel.com>
        <20220203144403.ytyw5vcv4gshxyhn@black.fi.intel.com>
        <20220204034312.43rotpihciik2gk6@black.fi.intel.com>
        <20220204231239.bff3626ec6c3c630371cbd4d@intel.com>
        <20220204131826.x57bgwn46kvkm2yw@black.fi.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > Is declaration of __tdx_module_call() outside of CONFIG_INTEL_TDX_GUEST?
> 
> No, it is defined within CONFIG_INTEL_TDX_GUEST. Why? Host side has to
> build their helper anyway.
> 

Right. Fine to me.
