Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48776526D86
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 01:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiEMXb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 19:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiEMXbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 19:31:55 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC6530BCFD
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 16:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652484167; x=1684020167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KyCPdSxq6CFmcl2pjIuOEIvI0ilyCrZM3eYSgEPizRA=;
  b=Xue7+2qe/l0+NRfQOz/51GXcktB4EWOCG3KiI/y1l3jHtk0cpF+iW3oH
   Q3psj6eb74Fuax6hlNYDz7mt4EveTp+TvTb06TlsXDefY63MsUmUsVFy6
   l0sXaK5B0v8djl4AQaYtzuo3i2+993/2j6Ez36KRv1rIDHLX1DcU3jn3a
   /N8mBDx+V0R/r7kXApChYqnSsytezuyeGBNcplV2i/biYGKmCDY47ILFe
   50ba7+SKe8tWYLNQXV8yyfxXoG1l4lLEpGkd6f2SH8fY0nd6jijgMHSTI
   AIS892DUGvjALFyPmvRJrYQCVbFWlxvvFvIrcg+rngluV/APl2uLVRzjB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="268023276"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="268023276"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 16:22:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="815595889"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 13 May 2022 16:22:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id EBD60A8; Sat, 14 May 2022 02:22:42 +0300 (EEST)
Date:   Sat, 14 May 2022 02:22:42 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 08/10] x86/mm: Make LAM_U48 and mappings above 47-bits
 mutually exclusive
Message-ID: <20220513232242.7ac7herw7iyfkd2h@black.fi.intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-10-kirill.shutemov@linux.intel.com>
 <875ymax480.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875ymax480.ffs@tglx>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 03:36:31PM +0200, Thomas Gleixner wrote:
> On Wed, May 11 2022 at 05:27, Kirill A. Shutemov wrote:
> > LAM_U48 steals bits above 47-bit for tags and makes it impossible for
> > userspace to use full address space on 5-level paging machine.
> 
> > Make these features mutually exclusive: whichever gets enabled first
> > blocks the othe one.
> 
> So this patch prevents a mapping above 47bit when LAM48 is enabled, but
> I fail to spot how an already existing mapping above 47bit would prevent
> LAM48 from being enabled.
> 
> Maybe I'm missing something which makes this magically mutually
> exclusive.

It is in 09/10. See lam_u48_allowed()

-- 
 Kirill A. Shutemov
