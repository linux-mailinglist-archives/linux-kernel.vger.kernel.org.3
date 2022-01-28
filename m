Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4B54A041F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349038AbiA1XKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:10:19 -0500
Received: from mga17.intel.com ([192.55.52.151]:45590 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344400AbiA1XKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:10:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643411416; x=1674947416;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jOrlcko0k1147pqRHZRt0p4VwCWQTKMZanWLQynKTUs=;
  b=m4QB9awQDqUvVL41UANlDGUOQAixOkEpsuN2VsK4LsOaBLHRL1+wqdfU
   v2mJnCO4wwNS1Onj0kAynZVb6BNyFqe00MYwHTJbWpv4dEf2SO9zc7eQJ
   Np4ZV3UG0DPJ7pS/1wzDlkDH5ByDFSknRGNPBRMrB+hwYIBZ5YaLRFsPX
   598gjpaW3l/fNOUuZ8nQqltcPCFjRn7xsOjKMInfe+Ox24XvWxRYQBet5
   nTBGblL2hJ9sEZ1wwn2lg5mINYrRovvi1QL/leWUvtXVGY9yF6nGvKGyf
   DXOv5AeKPQdp+9RBJqWW4QBRRy8sLY5Z46CRkyqm9cGCTPQWQes3RTQWF
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="227882608"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="227882608"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 15:10:16 -0800
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="536325572"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 15:10:16 -0800
Date:   Fri, 28 Jan 2022 15:10:16 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 06/44] mm/pkeys: Add Kconfig options for PKS
Message-ID: <20220128231015.GK785175@iweiny-DESK2.sc.intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-7-ira.weiny@intel.com>
 <9c4a8275-236d-67b6-07f9-5e46f66396c0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c4a8275-236d-67b6-07f9-5e46f66396c0@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 02:54:26PM -0800, Dave Hansen wrote:
> On 1/27/22 09:54, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Protection Key Supervisor, PKS, is a feature used by kernel code only.
> > As such if no kernel users are configured the PKS code is unnecessary
> > overhead.

Indeed this was a bit weak sorry.  See below.

> > 
> > Define a Kconfig structure which allows kernel code to detect PKS
> > support by an architecture and then subsequently enable that support
> > within the architecture.
> > 
> > ARCH_HAS_SUPERVISOR_PKEYS indicates to kernel consumers that an
> > architecture supports pkeys.  PKS users can then select
> > ARCH_ENABLE_SUPERVISOR_PKEYS to turn on the support within the
> > architecture.
> > 
> > If ARCH_ENABLE_SUPERVISOR_PKEYS is not selected architectures avoid the
> > PKS overhead.
> > 
> > ARCH_ENABLE_SUPERVISOR_PKEYS remains off until the first kernel use case
> > sets it.
> 
> This is heavy on the "what" and weak on the "why".
> 
> Why isn't this an x86-specific Kconfig?  Why do we need two Kconfigs?
> Good old user pkeys only has one:
> 
> 	config ARCH_HAS_PKEYS
> 	        bool
> 
> and it's in arch-generic code because there are ppc and x86
> implementations *and* the pkey support touches generic code.
> 
> This might become evident later in the series, but it's clear as mud as
> it stands.

Sorry, I'll expand on this.

This issue is that because PKS users are in kernel only and are not part of the
architecture specific code there needs to be 2 mechanisms within the Kconfig
structure.  One to communicate an architectures support PKS such that the user
who needs it can depend on that config as well as a second to allow that user
to communicate back to the architecture to enable PKS.

Ira
