Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE7C51E2CB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 02:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443674AbiEGAq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 20:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240551AbiEGAqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 20:46:24 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A672268FB0
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 17:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651884160; x=1683420160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hXiz+xm4l3kN/XZE5ZdgqCkGTbSWgQTLTC07JK95VBA=;
  b=L5Y8djIYPz5G+xwqPE4Ob91n3us3MbquOv7MriMNIFiE4rdfMHv7HD+m
   ov+NElGepkqz7HVIHxP5ZgPQv0CnWeR3a5tWiTCGKfE/RmOYvsQDgQ7oP
   RWxGn3xLzlEsqhcgXUEA+244R3ylPRALtrOD3glavXTkv97tEW2NbSvNH
   b23vynbQf1SW3IksqI1lCxpGgyhYdQUmWJlzumYHVVs2XpAdr9Yp/MtPh
   BCyTN3AeM0znQzIwb0V5kKraKwW2XzrvMni/QqnyJy7Z5y2jhpv26x3ef
   Ka5XtiptwqKd0RUui5bsDUGYNgN1UaG7IGkWMw70C3hSkY6ZP5nTTyVAJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="248522021"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="248522021"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 17:42:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="735998813"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 06 May 2022 17:42:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id BDD169B; Sat,  7 May 2022 03:42:36 +0300 (EEST)
Date:   Sat, 7 May 2022 03:42:36 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] x86/tdx: Add Quote generation support
Message-ID: <20220507004236.5p5dyksftge7wwr3@black.fi.intel.com>
References: <20220501183500.2242828-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <243e918c523320ba3d216cbe22d24fe5ce33f370.camel@intel.com>
 <20220503012721.ok7fbvxmnvsr6qny@box.shutemov.name>
 <58d07b2d-cef5-17ed-9c57-e12fe5665e04@intel.com>
 <40ccd0f0-35a1-5aa7-9e51-25ab196d79e5@linux.intel.com>
 <2ed5c9cc316950a5a47ee714715b7980f358a140.camel@intel.com>
 <ab17102c-0cb7-87d3-3494-969866d64573@linux.intel.com>
 <d53696f85ada39a91a3685c61d177c582810772e.camel@intel.com>
 <d63d2774-c44d-27da-74b6-550935a196fd@intel.com>
 <dca06ffa36abe9989f0a7abaeafc83c1a7250651.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dca06ffa36abe9989f0a7abaeafc83c1a7250651.camel@intel.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 12:11:03PM +1200, Kai Huang wrote:
> Kirill, what's your opinion?

I said before that I think DMA API is the right tool here.

Speculation about future of DMA in TDX is irrelevant here. If semantics
change we will need to re-evaluate all users. VirtIO uses DMA API and it
is conceptually the same use-case: communicate with the host.

But vmap() + set_memory_decrypted() also works and Sathya already has code
for it. I'm fine with this.

Going a step below to manual MapGPA() is just wrong. We introduced
abstructions for a reason. Protocol of changing GPA status is not trivial.
We should not spread it across all kernel codebase.

-- 
 Kirill A. Shutemov
