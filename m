Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D044C7E6E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 00:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiB1Xbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 18:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiB1Xby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 18:31:54 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2DA29C99
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 15:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646091074; x=1677627074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q3ouRHA17/OhwmmDm9IMWmyuwjMFCNY5jIGBBeeZw0g=;
  b=j+sCvNiIB4zm7ymQPJ5n3lADLQ8aZew2EC/VzpwU8I78k9PShVaS+hCT
   X6XJ/vXc9OVsRpqfmibNSARbIUFTb5zaAfV96S2KCtSgl6Zze1f06oB7e
   sn9U3UQKr0amk1Csm4Dz3qNAYuBVbmI8d6WYQMBCAG57Sv0IiTE4zNed4
   LCJ79yVqlKT9N5QnvAsds5pj95Igv7Ytge7dm7THiukzpQFWu2/KHCjPB
   sdbmm59O4DEmBx/EzNSxfx2nkpkCkfctjRtZyjdtFLJyytgMlKm5BxMun
   h74dXkcQGiBb3EkgNCizVcs0zyF/+AGxNigMMjLa9PwWitNvLgCfphZlT
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="233630144"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="233630144"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 15:31:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="593398323"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 28 Feb 2022 15:31:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 99822142; Tue,  1 Mar 2022 01:31:25 +0200 (EET)
Date:   Tue, 1 Mar 2022 02:31:25 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 10/30] x86/tdx: Handle CPUID via #VE
Message-ID: <20220228233125.z35h5f7lpvspfohv@black.fi.intel.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-11-kirill.shutemov@linux.intel.com>
 <51b6613d-eabd-941d-19b2-95b33ec27e99@intel.com>
 <20220227010733.abapkmyaroglcafl@black.fi.intel.com>
 <7a8c4e5e-c0ba-ee8e-a912-c71f89b4d4f2@intel.com>
 <20220228225336.k3lxk5qqm4vpaocv@black.fi.intel.com>
 <76b54855-d2b6-e224-ccb4-3f6c4cd1f7e7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76b54855-d2b6-e224-ccb4-3f6c4cd1f7e7@intel.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 03:05:26PM -0800, Dave Hansen wrote:
> On 2/28/22 14:53, Kirill A. Shutemov wrote:
> > On Mon, Feb 28, 2022 at 08:41:38AM -0800, Dave Hansen wrote:
> >>> We realise that this is possible vector of attack and plan to implement
> >>> proper filtering. But it is beyon core enabling.
> >>>
> >>>> Is this better than just returning 0's, for instance?
> >>> Plain 0 injection breaks the boot. More complicated solution is need.
> >> OK, so we're leaving the kernel open to something that might be an
> >> attack vector: we know that we don't know how this might be bad.  It's a
> >> "known unknown"[1].
> > I looked deeper. The only CPUIDs that actually required are from the
> > hypervisor range (the range is reserved and never will be used by CPU, so
> > hypervisors adopt it for own use).
> > 
> > So this filtering makes kernel boot (I didn't test much beyond that).
> > 
> > 	/*
> > 	 * Only allow VMM to control range reserved for hypervisor
> > 	 * communication.
> > 	 *
> > 	 * Return all-zeros for any CPUID outside the range.
> > 	 */
> > 	if (regs->ax < 0x40000000 || regs->ax > 0x4FFFFFFF) {
> > 		regs->ax = regs->bx = regs->cx = regs->dx = 0;
> > 		return true;
> > 	}
> > 
> > We may tighten the range further (only few leafs from the range is
> > actually used during the boot), but this should be good enough for this
> > stage of enabling.
> 
> Seems sane to me.  This closes off basically any ability for the VMM to
> confuse the guest with CPUID values except for the ones that *must* by
> hypervisor-controlled.
> 
> Does this, in practice, keep TDX guests from detecting any features that
> it supports today?

I scanned through the list of CPUID that probed via #VE during the boot
and they are related to cache/TLB hierarchy enumeration, thermal and
topology. Without cache/TLB enumeration we may miss some optimization.
Topology can be problematic, we may miss ability to communicate the
configuration, I donno.

Shouldn't be a show-stopper.

-- 
 Kirill A. Shutemov
