Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AE94D9F68
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 16:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349866AbiCOPzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbiCOPzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:55:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A8B6551
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 08:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647359630; x=1678895630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LVRCX0EQ30zWj1FtfHS0UtBgJd7k0IXdfU/D+Vm6e6I=;
  b=gq+ay1ET7VAQ4iCg4TaV/dRYH2JXP459AOOs0Yi9rPaHgefiIvLYj3zs
   Ic5L02qpJ2bGuonPPx84n+hvJb447lhN7U4AuHHzHdpN9UVvJ695y3ibC
   T+hvcQnBa32X7wGLv3kDaRxU0f469zC7W52EmC7ONk2n49HU+epvyHFpP
   xardtqX7kSOvnXn60J0+pFio0qo8CBPxXIylmJ+TKX6MWSg95ynFWUtU/
   zPWT5FwHZLiDHDLMAgPuIs8XgMbCh/5sOSkOcs/GN7yAKIulefFgDGXkZ
   YnwighFXGqTUidbY2EVr70LNfd8GkN0TfZmMJ+Wahp9KmOvJODM6MhB7Y
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="238509252"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="238509252"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 08:53:50 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="512657426"
Received: from jpgabald-mobl.amr.corp.intel.com (HELO localhost) ([10.212.75.31])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 08:53:50 -0700
Date:   Tue, 15 Mar 2022 08:53:49 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] x86/pkeys: Standardize on u8 for pkey type
Message-ID: <YjC2jcn7kJKdHrf3@iweiny-desk3>
References: <20220311005742.1060992-1-ira.weiny@intel.com>
 <20220311005742.1060992-6-ira.weiny@intel.com>
 <42e0aa73-04c8-a4c2-2d64-80812634b627@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42e0aa73-04c8-a4c2-2d64-80812634b627@intel.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 04:49:12PM -0700, Dave Hansen wrote:
> On 3/10/22 16:57, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The number of pkeys supported on x86 and powerpc are much smaller than a
> > u16 value can hold.  It is desirable to standardize on the type for
> > pkeys.  powerpc currently supports the most pkeys at 32.  u8 is plenty
> > large for that.
> > 
> > Standardize on the pkey types by changing u16 to u8.
> 
> How widely was this intended to "standardize" things?  Looks like it may
> have missed a few spots.

Sorry I think the commit message is misleading you.  The justification of u8 as
the proper type is that no arch has a need for more than 255 pkeys.

This specific patch was intended to only change x86.  Per that goal I don't see
any other places in x86 which uses u16 after this patch.

$ git grep u16 arch/x86 | grep key
arch/x86/events/intel/uncore_discovery.c:	const u16 *type_id = key;
arch/x86/include/asm/intel_pconfig.h:	u16 keyid;
arch/x86/include/asm/mmu.h:	u16 pkey_allocation_map;
arch/x86/include/asm/pkeys.h:	u16 all_pkeys_mask = ((1U << arch_max_pkey()) - 1);

> 
> Also if we're worried about the type needing to change or with the wrong
> type being used, I guess we could just to a pkey_t typedef.

I'm not 'worried' about it.  But I do think it makes the code cleaner and more
self documenting.

Ira
