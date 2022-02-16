Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923174B83F9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbiBPJTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:19:53 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbiBPJTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:19:51 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067C622B734;
        Wed, 16 Feb 2022 01:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645003180; x=1676539180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=W7JJ5S6ygKVdkRCpl3XvCOgtF+37zc1PmPKZVKrCQZU=;
  b=SM4I48fhFcBsp6WHVm9Qw257/kyt/ywPBOdJ1NSjHcAmL1KnNEVouwYX
   HPT6kw7yCrowW4aDQZ5uwl9yvEiEQbLjSfDpxQRz/coVjks48k9TtaH58
   hsgkjVax3wxRskDlOtETwINDsdcwXJ2P+BECeMY4i2lv0jLSHEN69daU1
   RuA2caXsVTobK/77EKGmfOD20qcUFBy0Fl/iVMwZz5cbj/150b9xdkafE
   DzXAfSUn9XHp68v5HoKChzOxrcdsZG+AjuYWiw3XeCa/40eA0Snl2iG4g
   iJ3ceCWMexAUKuADQjileioLkwTuJZI6Ak7BBdfligI/e6CTCeSp7JLF0
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="250297486"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="250297486"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 01:19:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="498578877"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.151])
  by orsmga006.jf.intel.com with SMTP; 16 Feb 2022 01:19:34 -0800
Received: by stinkbox (sSMTP sendmail emulation); Wed, 16 Feb 2022 11:19:33 +0200
Date:   Wed, 16 Feb 2022 11:19:33 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        tvrtko.ursulin@linux.intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        christian.koenig@amd.com, linaro-mm-sig@lists.linaro.org,
        rodrigo.vivi@intel.com, sumit.semwal@linaro.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gt: fix unsigned integer to signed assignment
Message-ID: <YgzBpX2SKCh4cb19@intel.com>
References: <20220216083849.91239-1-jiapeng.chong@linux.alibaba.com>
 <87h78z5gmp.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h78z5gmp.fsf@intel.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 11:02:06AM +0200, Jani Nikula wrote:
> On Wed, 16 Feb 2022, Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:
> > Eliminate the follow smatch warning:
> >
> > drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:4640
> > guc_create_virtual() warn: assigning (-2) to unsigned variable
> > 've->base.instance'.
> >
> > drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:4641
> > guc_create_virtual() warn: assigning (-2) to unsigned variable
> > 've->base.uabi_instance'.
> >
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> 
> The report seems to be valid, but I don't think this is the fix.
> 
> Where do we even check for invalid instance/uabi_instance in code?

The whole thing seems rather poorly documented as there's a matching
uabi struct with __u16's and the negative values are defined right
there in the uapi header as well.

> 
> BR,
> Jani.
> 
> 
> > ---
> >  drivers/gpu/drm/i915/gt/intel_engine_types.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/gt/intel_engine_types.h b/drivers/gpu/drm/i915/gt/intel_engine_types.h
> > index 36365bdbe1ee..dc7cc06c68e7 100644
> > --- a/drivers/gpu/drm/i915/gt/intel_engine_types.h
> > +++ b/drivers/gpu/drm/i915/gt/intel_engine_types.h
> > @@ -328,10 +328,10 @@ struct intel_engine_cs {
> >  	intel_engine_mask_t logical_mask;
> >  
> >  	u8 class;
> > -	u8 instance;
> > +	s8 instance;
> >  
> >  	u16 uabi_class;
> > -	u16 uabi_instance;
> > +	s16 uabi_instance;
> >  
> >  	u32 uabi_capabilities;
> >  	u32 context_size;
> 
> -- 
> Jani Nikula, Intel Open Source Graphics Center

-- 
Ville Syrjälä
Intel
