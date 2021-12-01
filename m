Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB1046583B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 22:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344033AbhLAVTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 16:19:07 -0500
Received: from foss.arm.com ([217.140.110.172]:47694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232919AbhLAVTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 16:19:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2164F13D5;
        Wed,  1 Dec 2021 13:15:42 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00EF33F5A1;
        Wed,  1 Dec 2021 13:15:42 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id A119B68527A; Wed,  1 Dec 2021 21:15:40 +0000 (GMT)
Date:   Wed, 1 Dec 2021 21:15:40 +0000
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Zhou Qingyang <zhou1615@umn.edu>, David Airlie <airlied@linux.ie>,
        kjlu@umn.edu, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>
Subject: Re: [PATCH] drm/komeda: Fix an undefined behavior bug in
 komeda_plane_add()
Message-ID: <Yafl/A/dId/z+88j@e110455-lin.cambridge.arm.com>
References: <20211130142531.156863-1-zhou1615@umn.edu>
 <fadc42da-bf13-4c18-653b-8d80fd486940@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fadc42da-bf13-4c18-653b-8d80fd486940@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 03:44:03PM +0000, Steven Price wrote:
> On 30/11/2021 14:25, Zhou Qingyang wrote:
> > In komeda_plane_add(), komeda_get_layer_fourcc_list() is assigned to
> > formats and used in drm_universal_plane_init().
> > drm_universal_plane_init() passes formats to
> > __drm_universal_plane_init(). __drm_universal_plane_init() further
> > passes formats to memcpy() as src parameter, which could lead to an
> > undefined behavior bug on failure of komeda_get_layer_fourcc_list().
> > 
> > Fix this bug by adding a check of formats.
> > 
> > This bug was found by a static analyzer. The analysis employs
> > differential checking to identify inconsistent security operations
> > (e.g., checks or kfrees) between two code paths and confirms that the
> > inconsistent operations are not recovered in the current function or
> > the callers, so they constitute bugs.
> > 
> > Note that, as a bug found by static analysis, it can be a false
> > positive or hard to trigger. Multiple researchers have cross-reviewed
> > the bug.
> > 
> > Builds with CONFIG_DRM_KOMEDA=m show no new warnings,
> > and our static analyzer no longer warns about this code.
> > 
> > Fixes: 61f1c4a8ab75 ("drm/komeda: Attach komeda_dev to DRM-KMS")
> > Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> > ---
> >  drivers/gpu/drm/arm/display/komeda/komeda_plane.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> > index d63d83800a8a..dd3f17e970dd 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> > @@ -265,6 +265,10 @@ static int komeda_plane_add(struct komeda_kms_dev *kms,
> >  
> >  	formats = komeda_get_layer_fourcc_list(&mdev->fmt_tbl,
> >  					       layer->layer_type, &n_formats);
> > +	if (!formats) {
> > +		err = -ENOMEM;
> > +		goto cleanup;
> > +	}
> 
> If this executes it will cause undefined behaviour...
> 
> The cleanup code calls komeda_plane_destroy() which calls
> drm_plane_cleanup() which does (amongst other things) a
> list_del(&plane->head). But the plane hasn't been put on a list yet as
> that's done in drm_universal_plane_init().
> 
> So in this case we simple want to do:
> 
> if (!formats) {
> 	kfree(kplane);
> 	return -ENOMEM;
> }

Zhou has already posted v2 that contains this fix.

> 
> Note that without this 'fix' a NULL return from
> komeda_get_layer_fourcc_list() would leave n_formats==0, so while the
> NULL pointer is passed into memcpy() it is also passed a length of 0.
> Which I believe is safe.
> 
> However while looking at this function...
> 
> >  
> >  	err = drm_universal_plane_init(&kms->base, plane,
> >  			get_possible_crtcs(kms, c->pipeline),
> > 
> 
> This call to drm_universal_plane_init() can fail early before
> plane->head has been initialised. In which case the following:
> 
> > 	komeda_put_fourcc_list(formats);
> > 
> > 	if (err)
> > 		goto cleanup;
> 
> commits the exact same sin and would cause a similar NULL dereference in
> drm_plane_cleanup().

I will come up with a patch for this case and post it to the list tomorrow.

Best regards,
Liviu



> 
> Steve

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
