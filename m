Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDCB58A97C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 12:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240286AbiHEKab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 06:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbiHEKa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 06:30:27 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CFC11162;
        Fri,  5 Aug 2022 03:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659695425; x=1691231425;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wl1d0jKvHZGC5Yd449Qnm7zhaueS05JbKcyoWYVXVmY=;
  b=bbrpUbb8y1QXXHc7mCfBAWTto4uppwcrIBl65z/zdCydf0EzIYppnquY
   D1Z6mMtelnbty6hlvnZndsMjBy3Xxjd97O6PAcPIsqRwuk6ZddtJuvZzo
   4GFVMx+Vd+WrqXh7uVqx2IJEQMzqxNzttuzhfBluyOuoCF2rUuQ+JLFDH
   LDO1MNhez+igrivBABGToEpcsoyOq3iPgWoD7OpAkXOV0HXzMyz3iJcsu
   +6UhPEuFBu5qx8FGuI3RrwibylVatp7uJ3EdMiHCTWQ8tl0Aarq4b1NHZ
   iZQKtCxJtVFkqnMTyxn2gz2phKQb6BYG8sGZJ0UwpMcBhgfEGm5FyfcGu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="288932143"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="288932143"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 03:30:25 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="631968756"
Received: from maurocar-mobl2.ger.corp.intel.com (HELO maurocar-mobl2) ([10.252.33.203])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 03:30:22 -0700
Date:   Fri, 5 Aug 2022 12:30:18 +0200
From:   Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Andi Shyti <andi.shyti@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Chris Wilson <chris.p.wilson@intel.com>,
        linux-doc@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        intel-gfx@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH v3 3/3] drm/i915/gt: document TLB cache
 invalidation functions
Message-ID: <20220805123018.1143f2c3@maurocar-mobl2>
In-Reply-To: <7156b3bd-69d7-de53-dd2b-96e82a8cf0f7@linux.intel.com>
References: <cover.1659598090.git.mchehab@kernel.org>
        <cc68d62a1979ea859b447b94413e100472331f57.1659598090.git.mchehab@kernel.org>
        <0698c5a5-3bf2-daa4-e10e-2715f9b0d080@infradead.org>
        <Yuzd9Ysc3BDQHuSW@alfio.lan>
        <7156b3bd-69d7-de53-dd2b-96e82a8cf0f7@linux.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2022 10:24:25 +0100
Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com> wrote:

> On 05/08/2022 10:08, Andi Shyti wrote:
> > Hi Randy,
> >   
> >>> +/**
> >>> + * intel_gt_invalidate_tlb_full - do full TLB cache invalidation
> >>> + * @gt: GT structure  
> >>
> >> In multiple places (here and below) it would be nice to know what a
> >> GT structure is. I looked thru multiple C and header files yesterday
> >> and didn't find any comments about it.
> >>
> >> Just saying that @gt is a GT structure isn't very helpful, other
> >> than making kernel-doc shut up.  
> > 
> > the 'gt' belongs to the drivers/gpu/drm/i915/gt/ subsystem and
> > it's widely used a throughout i915.
> > 
> > I think it's inappropriate to describe it just here. On the other
> > hand I agree that a better documentation is required for the GT
> > itself where other parts can point to.  

GT is actually a well-understood term for GPU developers. It is an alias
for:

	https://en.wikipedia.org/wiki/Intel_Graphics_Technology

It is basically the "core" of the GPU, where the engine units sit.

I agree with Andi: terms like this should likely be defined on a glossary
at i915.rst file.

> Yeah agreed there is no point of copy pasting some explanation all over 
> the place. Could we just do s/GT structure/struct intel_gt/, or "pointer 
> to struct intel_gt to operate on", would that be good enough?

IMO, it won't make any difference. kerneldoc already says that the
parameter has struct intel_gt type on its output:

	.. c:function:: void intel_gt_fini_tlb (struct intel_gt *gt)

	   free TLB-specific vars

	**Parameters**

	``struct intel_gt *gt``
	  GT structure
	
	**Description**

	Frees any resources needed by TLB cache invalidation logic.

This struct somewhat is similar to struct device. This is a container
struct that has the common data needed to control the GT hardware.

Almost all functions that work with GT needs it. There's not much sense
to describe it everywhere. What makes sense is to have struct intel_gt
documented at intel_gt_types.h, letting the build system to generate 
hiperlinks to it.

This is easier said than done...

Regards,
Mauro
