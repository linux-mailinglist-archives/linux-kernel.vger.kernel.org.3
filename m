Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2B35765E1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbiGORVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235688AbiGORVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:21:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2BD7C187
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657905676; x=1689441676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hUJ/HOMYhff+1zyQR004AphFyjB6ihhUjjIgPU7Cmy8=;
  b=Bykx2U1uHF10w+0Ake/xDe7+NE64PxrkxPOHxiLrcTyLXXuSxJ+iQqhs
   VwFQmzUATeHKsr8y0eshLrcqxe5qc8BeDWGqErSpZXdZSXhDqnCGWApt/
   h3bNqqWsDDkJKUvJP+giIIC2PSPLGsREhNHaKY6hmP2teGwIUsLskmanU
   Kr6jz6p+mew9ILUwE9q4g/e1tcFXSKT530OMjz98BqgZg0nKWgXVFxHJa
   Wu4N0qnEP81bfmcQnXF3aTbvwWMS61plwQORH4++8Wg6WXEErcS3oE2T4
   fq3LDMSDR1u+PPia5ertNtX2n9cBS12CbE7A03GggSbHdmByphopjLkhZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="349810574"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="349810574"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 10:21:15 -0700
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="600565028"
Received: from kjhoig-mobl.amr.corp.intel.com (HELO desk) ([10.209.99.4])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 10:21:14 -0700
Date:   Fri, 15 Jul 2022 10:21:13 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        antonio.gomez.iglesias@linux.intel.com,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH v2] x86/bugs: Warn when "ibrs" mitigation is selected on
 Enhanced IBRS parts
Message-ID: <20220715172113.74t65hgxi2o32wv6@desk>
References: <0456b35fb9ef957d9a9138e0913fb1a3fd445dff.1657747493.git.pawan.kumar.gupta@linux.intel.com>
 <2a5eaf54583c2bfe0edc4fea64006656256cca17.1657814857.git.pawan.kumar.gupta@linux.intel.com>
 <YtD6V5i0rS3szVIX@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YtD6V5i0rS3szVIX@kroah.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 07:25:43AM +0200, Greg KH wrote:
> On Thu, Jul 14, 2022 at 04:15:35PM -0700, Pawan Gupta wrote:
> > IBRS mitigation for spectre_v2 forces write to MSR_IA32_SPEC_CTRL at
> > every kernel entry/exit. On Enhanced IBRS parts setting
> > MSR_IA32_SPEC_CTRL[IBRS] only once at boot is sufficient. MSR writes at
> > every kernel entry/exit incur unnecessary performance loss.
> > 
> > When Enhanced IBRS feature is present, print a warning about this
> > unnecessary performance loss.
> > 
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > ---
> > v1->v2: Instead of changing the mitigation, print a warning about the
> >         perf loss.
> > 
> > v1: https://lore.kernel.org/lkml/0456b35fb9ef957d9a9138e0913fb1a3fd445dff.1657747493.git.pawan.kumar.gupta@linux.intel.com/
> > 
> >  arch/x86/kernel/cpu/bugs.c | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>

Sorry, I CCed stable@ by mistake. This version just adds a warning, it
is not intended to be backported.

Thanks,
Pawan
