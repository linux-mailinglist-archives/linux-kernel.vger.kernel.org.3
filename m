Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EF74B6BC9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237541AbiBOMMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:12:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiBOMME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:12:04 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B3DB7C43;
        Tue, 15 Feb 2022 04:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644927113; x=1676463113;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=zT4S6A5ModLhQpd7e86PbFMHrNsbDenFUKNBpKpWx9k=;
  b=KPngO8FNYHASWhRZmeCyzjnyeCiBxbrGCTv1xVLQKb8AGPGXiv29fmYP
   2kWP/Sm7jV7mAupakoWZb46eWTin9UAo4Uhlr9jp41O7R9ygThyj2MF6U
   7AJ9d7m1Iqq8iPESPA3j70Cahk8lrfSN31ItUrOOJZJb5S+y+XcXg715l
   ngqFfVIHm2MVMKA31krJ8caxv8l0djjPfrSq9HMBU+BnvrIK7zfowragV
   x3kj96QXmIMtnrTSoOToNUVh/iD9csKnqGutoSUyKzpeW/MSgbvvcHUql
   WO82ExMpOsMqxCjj8AvMYEGXPXPIftCTg5/xOe4Gz2PdamVJVfQ5CMUGL
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="336769396"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="336769396"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 04:11:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="528823662"
Received: from ylian16-mobl1.ccr.corp.intel.com (HELO localhost) ([10.252.20.230])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 04:11:50 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Dave Airlie <airlied@linux.ie>
Subject: Re: linux-next: build failure after merge of the drm-intel tree
In-Reply-To: <20220215121039.1d1ec3e6@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220215121039.1d1ec3e6@canb.auug.org.au>
Date:   Tue, 15 Feb 2022 14:11:47 +0200
Message-ID: <87r1845ny4.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2022, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> After merging the drm-intel tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/gpu/drm/i915/gvt/kvmgt.c: In function 'handle_edid_regs':
> drivers/gpu/drm/i915/gvt/kvmgt.c:595:38: error: implicit declaration of function 'drm_edid_block_valid' [-Werror=implicit-function-declaration]
>   595 |                                 if (!drm_edid_block_valid(
>       |                                      ^~~~~~~~~~~~~~~~~~~~
>
> Presumably caused by commit
>
>   14da21cc4671 ("drm/i915: axe lots of unnecessary includes from i915_drv.h")
>
> I am beginning to wonder if you guys run stuff through your CI before
> relasing to linux-next.  Especially important when removing #include
> statements from include files :-)

Thanks for the report. Apparently CI (and I) have VFIO=n, VFIO_MDEV=n,
and DRM_I915_GVT_KVMGT=n.

BR,
Jani.


>
> I have used the drm-intel tree from next-20220214 for today.

-- 
Jani Nikula, Intel Open Source Graphics Center
