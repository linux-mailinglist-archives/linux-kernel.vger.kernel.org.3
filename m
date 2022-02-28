Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210404C719E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbiB1QWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbiB1QWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:22:05 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F308983022
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646065287; x=1677601287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fwU+TO/qK+rZqtODMYpxS2Ztzz09O92uLhRMqm2SguI=;
  b=dBkI5icY9t8YczHOQO2siCx2Akl4zc3/HOLQudZ3S7S6gtcRNO+4yri2
   AiwyX2e36F9Io3lVLDpJxSHm23pjanBv+esPVDfk2eKVEusP1T+HJMLsQ
   +hBFVIsvu7xf56K2pi1pn1ReIQaQzVKghTcgkKnjq3EnbNDSfYksskPLN
   7f3HCaC+LLHbXe+OudED1t0Heb/E/3aLuJfEgBNEBy0nMeE2p1z+z9hag
   rjyIY2VBvWTkFX/sLI+GQHnzszgB0NqFH6Qu/svVm4zGskgsfiHYYYxbh
   IgE+VsxCYv1TzD1DJHtbvr2qBtnPRr9B5eK2qw38Z8KCLjgbnoEOCpjIo
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="250505609"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="250505609"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 08:20:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="708696781"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 28 Feb 2022 08:20:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 65C03142; Mon, 28 Feb 2022 18:20:56 +0200 (EET)
Date:   Mon, 28 Feb 2022 19:20:56 +0300
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
        linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>
Subject: Re: [PATCHv4 01/30] x86/mm: Fix warning on build with
 X86_MEM_ENCRYPT=y
Message-ID: <20220228162056.gul22bjr4w6zjslq@black.fi.intel.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-2-kirill.shutemov@linux.intel.com>
 <20220227220130.23yjme7jucxo266l@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220227220130.23yjme7jucxo266l@treble>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2022 at 02:01:30PM -0800, Josh Poimboeuf wrote:
> On Thu, Feb 24, 2022 at 06:56:01PM +0300, Kirill A. Shutemov wrote:
> > So far, AMD_MEM_ENCRYPT is the only user of X86_MEM_ENCRYPT. TDX will be
> > the second. It will make mem_encrypt.c build without AMD_MEM_ENCRYPT,
> > which triggers a warning:
> > 
> > arch/x86/mm/mem_encrypt.c:69:13: warning: no previous prototype for
> > 	function 'mem_encrypt_init' [-Wmissing-prototypes]
> > 
> > Fix it by moving mem_encrypt_init() declaration outside of #ifdef
> > CONFIG_AMD_MEM_ENCRYPT.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Fixes: 20f07a044a76 ("x86/sev: Move common memory encryption code to mem_encrypt.c")
> > Acked-by: David Rientjes <rientjes@google.com>
> 
> The patch title, warning, and "Fixes" tag tend to give the impression
> this is fixing a real user-visible bug.  But the bug is theoretical, as
> it's not possible to enable X86_MEM_ENCRYPT without AMD_MEM_ENCRYPT,
> until patch 27.
> 
> IMO it would be preferable to just squash this change with patch 27.
> 
> Having it as a separate patch is also fine, but it shouldn't be
> described as a fix or use the Fixes tag.  It's more of a preparatory
> patch.

maintainer-tip.rst seems disagree with you:

   A Fixes tag should be added even for changes which do not need to be
   backported to stable kernels, i.e. when addressing a recently introduced
   issue which only affects tip or the current head of mainline.

I will leave it as is.

-- 
 Kirill A. Shutemov
