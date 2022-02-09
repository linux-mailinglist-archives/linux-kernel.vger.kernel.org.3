Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255594AF0B7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbiBIMEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiBIMDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:03:32 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3748E016CFE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 03:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644406245; x=1675942245;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zpFWCTe09P0oV77Zfr2nNWQUjupkUrfoWW1+kTet9Pg=;
  b=b4d76U0rkmdxYYZKuMyYKWPhMDKi5fF8EJmUX+dI2MLmlhu2hSNzXq+A
   LqpmQGtwWj6gbuKq/d9qFVxHqkai0KT9ddfYbBnUo+rn2kNZcf3sbc+RG
   aSvYeMupJEgPPO4qV2ykoQPYcv7MO+MpuXlYGpl+9Ugbd7g/aPXSupCG0
   5XOhDYvXkQXMNGHw9WnAqjE6cNwOo6qsgNnjxsFXUQG/fdk63jtMyGS9B
   5e3Y0UAiNmNNtAJUezLubhg/4X1Pydhw1vSPOZergi/A5NSSRBsk3B4I1
   irBfiOR9UW44FXbuUXS+JlZ/OGfVahwsngsJxLCDmtCt2oSHGBMCe7xTL
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="229832351"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="229832351"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 03:30:45 -0800
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="485209240"
Received: from ravicha1-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.255.88.114])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 03:30:39 -0800
Date:   Thu, 10 Feb 2022 00:30:33 +1300
From:   Kai Huang <kai.huang@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 00/29] TDX Guest: TDX core support
Message-Id: <20220210003033.e57c2925b69bab5cfabf7292@intel.com>
In-Reply-To: <YgOgog9Pb886lfsv@zn.tnic>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
        <20220209235613.652f5720cd196331d7a220ec@intel.com>
        <YgOgog9Pb886lfsv@zn.tnic>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2022 12:08:18 +0100 Borislav Petkov wrote:
> On Wed, Feb 09, 2022 at 11:56:13PM +1300, Kai Huang wrote:
> > TDX host support basically does detection of SEAM, TDX KeyIDs, P-SEAMLDR and
> > initialize the TDX module, so likely TDX host support will introduce couple of
> > new files to do above things respectively,
> 
> Why a couple of new files? How much code is that?

This is the fine names and code size of current internal version that I have:

 .../admin-guide/kernel-parameters.txt         |   6 +
 Documentation/x86/index.rst                   |   1 +
 Documentation/x86/intel-tdx.rst               | 259 +++++++
 arch/x86/Kconfig                              |  14 +
 arch/x86/include/asm/seam.h                   | 213 ++++++
 arch/x86/include/asm/tdx_host.h               |  20 +
 arch/x86/kernel/asm-offsets_64.c              |  18 +
 arch/x86/kernel/cpu/Makefile                  |   1 +
 arch/x86/kernel/cpu/intel.c                   |   6 +
 arch/x86/kernel/cpu/tdx/Makefile              |   1 +
 arch/x86/kernel/cpu/tdx/p-seamldr.c           | 109 +++
 arch/x86/kernel/cpu/tdx/p-seamldr.h           |  14 +
 arch/x86/kernel/cpu/tdx/seam.c                | 105 +++
 arch/x86/kernel/cpu/tdx/seamcall.S            |  80 ++
 arch/x86/kernel/cpu/tdx/tdmr.c                | 581 ++++++++++++++
 arch/x86/kernel/cpu/tdx/tdmr.h                |  28 +
 arch/x86/kernel/cpu/tdx/tdx.c                 | 707 ++++++++++++++++++
 arch/x86/kernel/cpu/tdx/tdx_arch.h            |  88 +++
 arch/x86/kernel/cpu/tdx/tdx_seamcall.h        | 138 ++++
 19 files changed, 2389 insertions(+)
 create mode 100644 Documentation/x86/intel-tdx.rst
 create mode 100644 arch/x86/include/asm/seam.h
 create mode 100644 arch/x86/include/asm/tdx_host.h
 create mode 100644 arch/x86/kernel/cpu/tdx/Makefile
 create mode 100644 arch/x86/kernel/cpu/tdx/p-seamldr.c
 create mode 100644 arch/x86/kernel/cpu/tdx/p-seamldr.h
 create mode 100644 arch/x86/kernel/cpu/tdx/seam.c
 create mode 100644 arch/x86/kernel/cpu/tdx/seamcall.S
 create mode 100644 arch/x86/kernel/cpu/tdx/tdmr.c
 create mode 100644 arch/x86/kernel/cpu/tdx/tdmr.h
 create mode 100644 arch/x86/kernel/cpu/tdx/tdx.c
 create mode 100644 arch/x86/kernel/cpu/tdx/tdx_arch.h
 create mode 100644 arch/x86/kernel/cpu/tdx/tdx_seamcall.h

Because SEAM, P-SEAMLDR can logically be independent, so I feel it's better to
have separate C files for them.  TDMR (TD Memory Region, which is the structure
defined by TDX architecture to manage usable TDX memory) is split out as a
separate file as the logic to deal with it requires non-trival LOC too.

> 
> > and the majority of the code could be self-contained under some
> > directory (currently under arch/x86/kernel/cpu/tdx/, but can be
> > changed of course). Could we have some suggestions on how to organize?
> 
> So we slowly try to move stuff away from arch/x86/kernel/ as that is a
> dumping ground for everything and everything there is "kernel" so that
> part of the path is kinda redundant.
> 
> That's why, for example, we stuck the entry code under arch/x86/entry/.
> 
> I'm thinking long term we probably should stick all confidentail
> computing stuff under its own folder:
> 
> arch/x86/coco/
> 
> for example. The "coco" being COnfidential COmputing, for lack of a
> better idea.
> 
> And there you'll have
> 
> arch/x86/coco/tdx and
> arch/x86/coco/sev
> 
> where to we'll start migrating the AMD stuff eventually too.

Thanks for the information.  However, for now does it make sense to also put
TDX host files under arch/x86/kernel/, or maybe arch/x86/kernel/tdx_host/?

As suggested by Thomas, host SEAMCALL can share TDX guest's __tdx_module_call()
implementation.  Kirill will have a arch/x86/kernel/tdxcall.S which implements
the core body of __tdx_module_call() and is supposed to be included by the new
assembly file to implement the host SEAMCALL function.  From this perspective,
it seems more reasonable to just put all TDX host files under arch/x86/kernel/?

Thanks in advance.
