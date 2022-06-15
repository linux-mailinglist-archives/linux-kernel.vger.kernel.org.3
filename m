Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308B054D50C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 01:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354614AbiFOXQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 19:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350128AbiFOXQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 19:16:17 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8933191C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 16:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655334975; x=1686870975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SlGHtNPXQRbBwaQnkDauPKWst1GUmdwoPcIp08rhA1M=;
  b=e2dNgIzXeHd8SA6jz+XhWJy8FDdBqsOO7eC3igozg8xoYxcUvwKW8B10
   PZEaSEaza1AKE7I4GDzAngVE9TmPuz9Gjva9nHLOA1I4wAZ1vUM2dmqda
   BnRkDTp427JBRphdT32EB0vZeaOLFEVjzoSAJLAsRs43ePaOeAELya1od
   u5czdgH8oLaOA+mAYuO3AY2iUBDdzezTg8rf+MMvTVFXh5kKt9jlG9XZg
   nbxJwnBS3gOQSuGTFJFeHf0qfLIICx7wBZwn4roDjuaTRiY6x7RJmuFTT
   4GRtBi3SInZO/Uy6y7lTHM39Wk/fVMadlSFVquAUB8mMiVvMeC8P0rRuO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="262142144"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="262142144"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 16:16:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="641254735"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jun 2022 16:16:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id D9A4E109; Thu, 16 Jun 2022 02:16:15 +0300 (EEST)
Date:   Thu, 16 Jun 2022 02:16:15 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCHv4 3/3] x86/tdx: Handle load_unaligned_zeropad()
 page-cross to a shared page
Message-ID: <20220615231615.w57gatnfc2c55cvs@black.fi.intel.com>
References: <20220614120135.14812-1-kirill.shutemov@linux.intel.com>
 <20220614120135.14812-4-kirill.shutemov@linux.intel.com>
 <2a6e0dbb-89e3-9735-de20-132992d699b4@intel.com>
 <20220615223251.bm4q24pnwkv37w2q@black.fi.intel.com>
 <184456a7-fd03-c3c6-3d4f-4f770e2e8b31@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <184456a7-fd03-c3c6-3d4f-4f770e2e8b31@intel.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 03:36:02PM -0700, Dave Hansen wrote:
> On 6/15/22 15:32, Kirill A. Shutemov wrote:
> >>>         /*
> >>>          * Reject EPT violation #VEs that split pages.
> >>>          *
> >>>          * MMIO accesses are supposed to be naturally aligned and therefore
> >>>          * never cross page boundaries. Seeing split page accesses indicates
> >>>          * a bug or a load_unaligned_zeropad() that stepped into an MMIO page.
> >>>          *
> >>>          * load_unaligned_zeropad() will recover using exception fixups.
> >>>          */
> > Looks good, thanks.
> 
> I've got that snippet and a few other things staged here:
> 
> > https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git/log/?h=testme
> 
> Could you take a quick look through before I push them somewhere for real?

Looks good to me. Could you fold in the off-by-one fix? 

-- 
 Kirill A. Shutemov
