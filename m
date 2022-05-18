Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0082552BA3E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 14:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbiERMSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 08:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbiERMS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 08:18:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B4C4A92E
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 05:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652876306; x=1684412306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2nABVGMDBjJQn3wpWnl4igBSwF2dgP+uLdUJBkuxeuk=;
  b=XjW6WQDq6Y4lKf9wcAZa274Mu5i1HQFCg+d7K0Wc3JMIwrQQNW0/S8qq
   VlktU/plcCDcsz1t/nLIIzbiRBHjQ2DaAoUrF54b//NT68QVZzCRtdYqm
   ilrjPjnQ6d2eXfsqYjss8oYis6F642ug/dLBxG+Om+DEgybjVs1xNU3J3
   Q8vMSVWgt6kC8ovZQuz5FjXbAMezdQv8hit3xDOmGOuoVPZ0D096o9i/6
   q/GCWGtW7UR4+o9g2OsRe/EZDqlt6K2nkK0Ks5d5jer8Szw2hyb2BseKz
   oFbUvQr2nl6/IMuuXqjkAvhRHBKwv7WKob4nKbuFM0Z4hWAJok4f9KywL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="269224128"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="269224128"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 05:18:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="605860787"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 18 May 2022 05:18:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 7B24E109; Wed, 18 May 2022 15:18:22 +0300 (EEST)
Date:   Wed, 18 May 2022 15:18:22 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/tdx: Handle load_unaligned_zeropad() page-cross to a
 shared page
Message-ID: <20220518121822.znaw5pwdsdxbjrlg@black.fi.intel.com>
References: <20220517153021.11116-1-kirill.shutemov@linux.intel.com>
 <70df6e274d4a40e78f11ef93521edab6@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70df6e274d4a40e78f11ef93521edab6@AcuMS.aculab.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 08:39:45AM +0000, David Laight wrote:
> From: Kirill A. Shutemov
> > Sent: 17 May 2022 16:30
> > 
> > load_unaligned_zeropad() can lead to unwanted loads across page boundaries.
> > The unwanted loads are typically harmless. But, they might be made to
> > totally unrelated or even unmapped memory. load_unaligned_zeropad()
> > relies on exception fixup (#PF, #GP and now #VE) to recover from these
> > unwanted loads.
> > 
> > In TDX guest the second page can be shared page and VMM may configure it
> > to trigger #VE.
> > 
> > Kernel assumes that #VE on a shared page is MMIO access and tries to
> > decode instruction to handle it. In case of load_unaligned_zeropad() it
> > may result in confusion as it is not MMIO access.
> > 
> > Check fixup table before trying to handle MMIO.
> 
> Is it best to avoid that all happening by avoiding mapping
> 'normal memory' below anything that isn't normal memory.
> 
> Even on a normal system it is potentially possibly that the
> second page might be MMIO and reference a target that doesn't
> want to see non-word sized reads.
> (Or the first location might be a fifo and the read consumes
> some data.)
> 
> In that case the cpu won't fault the access, but the hardware
> access might have rather unexpected side effects.
> 
> Now the way MMIO pages are allocated probably makes that
> impossible - but load_unaligned_zeropad() relies on
> it not happening or not breaking anything.

Normally MMIO mappings comes from ioremap() and it does not land next to
normal pages in virtual memory. So I don't think there's high risk of MMIO
being a problem on normal machines.

What makes TDX (and other confidential computing platforms) different is
security model: host and VMM considered hostile and we need protect
against it. In TDX case, VMM can make any shared memory (such as DMA
buffers) to trigger #VE that kernel interprets as MMIO access. We need to
make sure host cannot exploit it.

-- 
 Kirill A. Shutemov
