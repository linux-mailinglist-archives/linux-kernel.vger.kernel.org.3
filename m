Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD28F480307
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 18:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhL0RvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 12:51:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:17548 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229973AbhL0RvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 12:51:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640627466; x=1672163466;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iPDSX7fY/NKEUf5rzPU4pa5rtlpdbe9mM+k8gcJXJUc=;
  b=CV36Phx2Ib634vGIUJVp9NNyfdVMsJ9sYOIJO4C3VGqsznBdhnoXFeNb
   T0Y1vDW23099iTx84nR3pWpFREbLin7/38oAldp7l7u3Y35MSy086jWvL
   OfOM3REsuxdtyakKD3jnUgHiMuCejWznT2XmLR3cAq9pilHhRjzwJHKsg
   IGq6qMuzV2F5VmelUqCAi/kJE5NsFWVjEz1lEAtyXxUm8pUD3meUmtjhI
   fL8V+wbvWoorhqMgND0crqnSwuq1FKauRt75hQ2xvSx84diDfRWc1mb2j
   xOwj31B2kcMWouHD4QVbiZmaouaOhe4gtzKL/dmwKA4f4lIYMEFR1gYaX
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="221249268"
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; 
   d="scan'208";a="221249268"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 09:51:06 -0800
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; 
   d="scan'208";a="686353442"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 09:51:05 -0800
Date:   Mon, 27 Dec 2021 09:50:58 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 10/11] tools/objtool: Check for use of the ENQCMD
 instruction in the kernel
Message-ID: <Ycn9AqoxPuKxHLZi@otcwcpicx3.sc.intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
 <20211217220136.2762116-11-fenghua.yu@intel.com>
 <20211217225706.32ahbyf5yeuzrhre@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217225706.32ahbyf5yeuzrhre@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Josh,

On Fri, Dec 17, 2021 at 02:57:06PM -0800, Josh Poimboeuf wrote:
> On Fri, Dec 17, 2021 at 10:01:35PM +0000, Fenghua Yu wrote:
> > The ENQCMD implicitly accesses the PASID_MSR to fill in the pasid field
> > of the descriptor being submitted to an accelerator. But there is no
> > precise (and stable across kernel changes) point at which the PASID_MSR
> > is updated from the value for one task to the next.
> > 
> > Kernel code that uses accelerators must always use the ENQCMDS instruction
> > which does not access the PASID_MSR.
> > 
> > Check for use of the ENQCMD instruction in the kernel and warn on its
> > usage.
> > 
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > ---
> > v2:
> > - Simplify handling ENQCMD (PeterZ and Josh)
> 
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

Thank you!

-Fenghua
