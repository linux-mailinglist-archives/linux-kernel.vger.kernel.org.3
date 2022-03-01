Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEFF4C92C1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 19:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbiCASQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 13:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbiCASQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:16:08 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AD531211
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 10:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646158527; x=1677694527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2exBBjBLdIHC1K+wFc+04tbUBRcDoyFCQXB7El+ibuk=;
  b=CAySWsKr5miTj17W/lESFZQGvVV3nvlN/VNNvuTQiNuoL99chGqd1Y8I
   oqO1LykIOc890YsEv0aLxRQdcqJK4Jnawve1B+p6Uq368hF76kZIEBRtM
   yHX8URRauf07VJiiDE+MRT4It5VhMPp7TLsMfMMTQ2h8t3LBU5cMU03vc
   Vfsm6Pl1YGKJ7oF6NqHUyxT9yiiQxKxr8yO3ZKQs+Tv1ys79qZWeNPdnt
   UB0z61XzPZcPhB4hHUFguXlUfwrjNZlFo4ogU2ZIb37Zs+m0zAp4vl2lI
   WyMJvtGOeKNQho11SL7sMHojhLOwoTjuq5u9sfkLcHRmJrGb5SMZ4dz/R
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="236713345"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="236713345"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 10:15:26 -0800
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="639463469"
Received: from bklinvil-mobl.amr.corp.intel.com (HELO localhost) ([10.212.48.220])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 10:15:26 -0800
Date:   Tue, 1 Mar 2022 10:15:25 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 37/44] memremap_pages: Set PKS PKey in PTEs if
 PGMAP_PROTECTIONS is requested
Message-ID: <Yh5ivUp1dIFlih6L@iweiny-desk3>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-38-ira.weiny@intel.com>
 <CAPcyv4go5pqWdvR7w7kDjOKQywTUwZ=Tbn-LSmOyE-4GdhZsmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4go5pqWdvR7w7kDjOKQywTUwZ=Tbn-LSmOyE-4GdhZsmg@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 09:41:59AM -0800, Dan Williams wrote:
> On Thu, Jan 27, 2022 at 9:55 AM <ira.weiny@intel.com> wrote:
> >
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > When the user requests protections the dev_pagemap mappings need to have
> > a PKEY set.
> >
> > Define devmap_protection_adjust_pgprot() to add the PKey to the page
> > protections.  Call it when PGMAP_PROTECTIONS is requested when remapping
> > pages.
> >
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> 
> Does this patch have a reason to exist independent of the patch that
> introduced devmap_protection_enable()?
> 
> Otherwise looks ok.

Just easier to review this specific change.  For V8 I split the patches up
quite a bit to be much more direct to 1 change/patch.  I think it worked out
well and I don't plan to merge much in V9 because as you say this change looks
good.  :-D

Ira
