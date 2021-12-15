Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4552647644A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhLOVJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:09:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:13063 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229468AbhLOVJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:09:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639602590; x=1671138590;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=k0cpiTf2b3sof3q8ZCR+A4XSzZbGc/TK16t1qQbQikc=;
  b=l/dKxoRdGDAO0B4bLvkpwcZO6DlNnR12h1tNbhV1Au52zT058A7lqIIY
   Tjc4nJhOlJcQ7C0ohDGZHMPpZLtFCY/befIydKPIk4fgc9tGkMJVfT9Ix
   1zsGZnGTlwV+tIFrQ3Ar9pAp9yQR2bymgPY2r0IXofgPhWdxXEpmzo0pN
   2E/Rs7++VrgUIEJU8GDsKeXEDfaXXe2lQSFH/kydEiq1n06m4bxLDTxm6
   7FnKK4RL04YnC0GWOPPRQZuDM1sc+NUxrfLfmvCKRWovVoyW7gDDRkTqH
   XVlRdxomtUUQnIRCSZULAmhCdmbWYmYapgO1TabC7aXIS35CJffe9QKGf
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="300112941"
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="300112941"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 13:09:49 -0800
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="610885273"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 13:09:49 -0800
Date:   Wed, 15 Dec 2021 13:09:49 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 6/7] drm/amdgpu: Ensure kunmap is called on error
Message-ID: <20211215210949.GW3538886@iweiny-DESK2.sc.intel.com>
References: <20211210232404.4098157-1-ira.weiny@intel.com>
 <20211210232404.4098157-7-ira.weiny@intel.com>
 <5bbd3c48-1388-9469-8b6f-deed64406d7d@amd.com>
 <20211214033725.GR3538886@iweiny-DESK2.sc.intel.com>
 <c3b173ea-6509-ebbe-b5f9-eeb29f1ce57e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3b173ea-6509-ebbe-b5f9-eeb29f1ce57e@amd.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 08:09:29AM +0100, Christian König wrote:
> Am 14.12.21 um 04:37 schrieb Ira Weiny:
> > On Mon, Dec 13, 2021 at 09:37:32PM +0100, Christian König wrote:
> > > Am 11.12.21 um 00:24 schrieb ira.weiny@intel.com:
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > > > The default case leaves the buffer object mapped in error.
> > > > 
> > > > Add amdgpu_bo_kunmap() to that case to ensure the mapping is cleaned up.
> > > Mhm, good catch. But why do you want to do this in the first place?
> > I'm not sure I understand the question.
> > 
> > Any mapping of memory should be paired with an unmapping when no longer needed.
> > And this is supported by the call to amdgpu_bo_kunmap() in the other
> > non-default cases.
> > 
> > Do you believe the mapping is not needed?
> 
> No, the unmapping is not needed here. See the function amdgpu_bo_kmap(), it
> either creates the mapping or return the cached pointer.

Ah I missed that.  Thanks.

> 
> A call to amdgpu_bo_kunmap() is only done in a few places where we know that
> the created mapping most likely won't be needed any more. If that's not done
> the mapping is automatically destroyed when the BO is moved or freed up.
> 
> I mean good bug fix, but you seem to see this as some kind of prerequisite
> to some follow up work converting TTM to use kmap_local() which most likely
> won't work in the first place.

Sure.  I see now that it is more complicated than I thought but I never thought
of this as a strict prerequisite.  Just something I found while trying to
figure out how this works.

How much of a speed up is it to maintain the ttm_bo_map_kmap map type?  Could
this all be done with vmap and just remove the kmap stuff?

Ira

> 
> Regards,
> Christian.
> 
> > 
> > Ira
> > 
> > > Christian.
> > > 
> > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > > > ---
> > > > NOTE: It seems like this function could use a fair bit of refactoring
> > > > but this is the easiest way to fix the actual bug.
> > > > ---
> > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 1 +
> > > >    1 file changed, 1 insertion(+)
> > > > nice
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> > > > index 6f8de11a17f1..b3ffd0f6b35f 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> > > > @@ -889,6 +889,7 @@ static int amdgpu_uvd_cs_msg(struct amdgpu_uvd_cs_ctx *ctx,
> > > >    		return 0;
> > > >    	default:
> > > > +		amdgpu_bo_kunmap(bo);
> > > >    		DRM_ERROR("Illegal UVD message type (%d)!\n", msg_type);
> > > >    	}
> 
