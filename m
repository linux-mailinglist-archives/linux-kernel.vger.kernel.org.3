Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85625526D0B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 00:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384847AbiEMWs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 18:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349751AbiEMWsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 18:48:23 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608E7515AB
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 15:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652482102; x=1684018102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1cfR5hfccC3vnCWnbdp0zOpiSAhh/23Oja5qGIjqHtc=;
  b=Gt0UC8WGf1UoHLxc2sJn34yHlkeVvNO8WaqiNTG9p81+Fn73hj850gQv
   1ccIM/OZyruwWCGzC8BiZCOQKih0A8miDjs9E8XKjtOrwBwrj5vNBk3Fr
   VGNmUuK3g1aQUej+QJfTqCnM0E7cOpAd8V2es7N63qBf9NKqvg3/RMw5d
   6uqjXX6R7JIJdJxqedONFrQNndiFWoJRzRkFRy2OHwakCMPppxVdFH1BI
   XfQSCEXkROnx/yshnF/cWh2cQEK2I8m8aaCRCnlk7ykyi9t0DTF2lE+ve
   tHqAKRE+YTksQ0YiplW3ZauJ7W8anbO9sp8qG8g/2rWeUkeAFy+SDCx9t
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="295689745"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="295689745"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 15:48:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="567396586"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 13 May 2022 15:48:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id C6F2AA8; Sat, 14 May 2022 01:48:16 +0300 (EEST)
Date:   Sat, 14 May 2022 01:48:16 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFCv2 00/10] Linear Address Masking enabling
Message-ID: <20220513224816.g3uhtiq5xqgql2fs@black.fi.intel.com>
References: <20220511064943.GR76023@worktop.programming.kicks-ass.net>
 <20bada85-9203-57f4-2502-57a6fd11f3ea@intel.com>
 <875ymav8ul.ffs@tglx>
 <55176b79-90af-4a47-dc06-9f5f2f2c123d@intel.com>
 <CAMe9rOqb6ZnAZYe4uAWDt-vmhhP=z_+uZwi5fBURqyUWxCX9Cg@mail.gmail.com>
 <87o802tjd7.ffs@tglx>
 <CAMe9rOpXOLEMcir9zMq_UJe08Y-kM+9zok6gDicqAhPySV+3NA@mail.gmail.com>
 <67aef839-0757-37b1-a42d-154c0116cbf5@intel.com>
 <878rr6te6b.ffs@tglx>
 <ee786113-2173-b78b-774d-9d61d08b069b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee786113-2173-b78b-774d-9d61d08b069b@intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 08:05:26PM -0700, Dave Hansen wrote:
> On 5/12/22 18:27, Thomas Gleixner wrote:
> > On Thu, May 12 2022 at 17:46, Dave Hansen wrote:
> >> On 5/12/22 17:08, H.J. Lu wrote:
> >> If I had to take a shot at this today, I think I'd opt for:
> >>
> >> 	mask = sys_enable_masking(bits=6, flags=FUZZY_NR_BITS);
> >>
> >> although I'm not super confident about the "fuzzy" flag.  I also don't
> >> think I'd totally hate the "blind" interface where the kernel just gets
> >> to pick unilaterally and takes zero input from userspace.
> > That's the only sane choice and you can make it simple for userspace:
> > 
> >        ret = prctl(GET_XXX_MASK, &mask);
> > 
> > and then let it decide based on @ret and @mask whether to use it or not.
> > 
> > But of course nobody thought about this as a generic feature and so we
> > have the ARM64 TBI muck as a precedence.
> 
> Well, not quite *nobody*:
> 
>  https://lore.kernel.org/linux-arm-kernel/7a34470c-73f0-26ac-e63d-161191d4b1e4@intel.com/

In the first RFC I tried to get ARM TBI interface generic. I resurrect it
if it fits better:

https://lore.kernel.org/all/20210205151631.43511-2-kirill.shutemov@linux.intel.com/


-- 
 Kirill A. Shutemov
