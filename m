Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028AA4C71C6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbiB1Qeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbiB1QeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:34:23 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E2F4553D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646066024; x=1677602024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VlHnhmwNwO/GBLBiot4vMGB+Zw3qP5eoaVyiPtEbzfY=;
  b=bc1eZ6zBScbxV4UiGsBsp4wxADbbCC5BszFo9udZ8XnVwlxoK3UHoEqB
   DgB0YW5GgiVC1E7eAtwlvWsn2fEdrPMCcFGRaNHMooAc+OGenQWVq1Ao4
   9g4q3lgXyvO7pzFf2OJWwSUSdYWoJ+pxCewwP+86zjyvrGFj6nkZVO/vz
   qK4ZsVQF0yhUMaqIDaXdFwDHvZF69ycE3jKfQgJSo8Ahnyt9Ux5D9pwv0
   MQx2PxEa4kiFAdVUmjo2rtB36DqPHdEjGlYXDokM0U710Oiir8gN0A4gA
   RKCz1KzdOm3d19hYYUFpomR4kZIdvBaT9zdl7iykC1IS2X3rHC5scEzHv
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="251755740"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="251755740"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 08:33:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="510153382"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 28 Feb 2022 08:33:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 59722142; Mon, 28 Feb 2022 18:33:53 +0200 (EET)
Date:   Mon, 28 Feb 2022 19:33:53 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, knsathya@kernel.org, pbonzini@redhat.com,
        sdeep@vmware.com, seanjc@google.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 15/30] x86/boot: Allow to hook up alternative port I/O
 helpers
Message-ID: <20220228163353.d6redrbv3kpb557n@black.fi.intel.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-16-kirill.shutemov@linux.intel.com>
 <20220227220219.6myd32n6oojwbnyh@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220227220219.6myd32n6oojwbnyh@treble>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2022 at 02:02:19PM -0800, Josh Poimboeuf wrote:
> On Thu, Feb 24, 2022 at 06:56:15PM +0300, Kirill A. Shutemov wrote:
> > Port I/O instructions trigger #VE in the TDX environment. In response to
> > the exception, kernel emulates these instructions using hypercalls.
> > 
> > But during early boot, on the decompression stage, it is cumbersome to
> > deal with #VE. It is cleaner to go to hypercalls directly, bypassing #VE
> > handling.
> > 
> > Add a way to hook up alternative port I/O helpers in the boot stub.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> I think you missed my comment from v3.

I did not missed it, but I failed to acknowledge it.

To me it is a judgement call. Either way has right to live.
I talked to Borislav on this and we suggested to keep it as. Rework later
as needed.

> Repeating it here:
> 
> At least from reading the commit message it's not self-evident why #VE
> handling would be worse, especially since there's already #VC support in
> boot.  It would help to give more info about that in the commit message.
> 
> The current approach also seems fragile, doesn't it require all future
> code to remember to not do i/o directly?  How do we make sure that
> doesn't happen going forward?
> 
> How does it fail if some code accidentally does i/o directly?  Or
> triggers #VE some other way?  Is the error understandable and
> actionable?

Dealing with failure in decompression code is a pain. We don't have usual
infrastructure there. The patch deals with port I/O which is the only way
to communicate issue to the user. If it fails for whatever reason we are
screwed. And it doesn't depend on how it was implemented.

-- 
 Kirill A. Shutemov
