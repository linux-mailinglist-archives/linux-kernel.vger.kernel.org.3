Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E3847A75A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 10:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhLTJkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 04:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhLTJkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 04:40:51 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2E4C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 01:40:50 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a9so18749570wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 01:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=/teqifaKzeH8UYPm59TO0I2d45cw2lmw9JO9bR+H4mI=;
        b=j0h5yYgDQFQ/HC62jpTXP67hKBOSxtAaOVYd+RSO5POuYh3SavcH6aGSY/YklWwLRb
         QJQGkrwmK7hJc1Lz1LYgyNbDo7+oIgWIXIYXCpDs3KfhH2MZo2o69xPhc1R0XLnEJNWa
         6hm4YnuyZgebSnaQCcyOcwAdbKHxoNTXCNgg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=/teqifaKzeH8UYPm59TO0I2d45cw2lmw9JO9bR+H4mI=;
        b=neCATaLVcSH7rA9zSKcMz8BfI9PastVhHz4GsHrCUcaYZValZqHeUu2F5SsbUCXdWV
         0CTyZna2YNu/ocuyzRlpV+pp6ZQ2RDtm+ZVY0VrkQM01W2biN5ulLV04E1Y2buwVJGds
         r3u/TOSmECZ4CnpoHekrU2zXZ/iy2n45kXKWnvAQ74J6w/UlGXMuOnTBDJHXaQlAXruO
         7BQksMajhxIB8ZmgZd70THyOb2SVJJyt/XcPUM2ENv3Vtc8nE07GrC+ClStysy1Djm6o
         cp4lVDCaBySFS1Ug0oYRy+fFT+vrtKEjLeFnsMFIWDPcCns10zW0GNKhsHbQ5tHrr9Dv
         b1WA==
X-Gm-Message-State: AOAM533MIr4/pb5MGEFB7Ul8Xd5sT2SPiCAwAOXLihOLNuUYdztyM11D
        2K2/T4A+7OC8yO3iLi9sPgyvkw==
X-Google-Smtp-Source: ABdhPJyht4jB7Rh3dmx83lp86mmNZjHLE5oziFtv62A9+tIk6B/blbQ58E3W3KNjJAQMVssvjE2gkg==
X-Received: by 2002:a05:6000:23a:: with SMTP id l26mr11798285wrz.666.1639993249547;
        Mon, 20 Dec 2021 01:40:49 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b16sm7352006wmq.41.2021.12.20.01.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 01:40:48 -0800 (PST)
Date:   Mon, 20 Dec 2021 10:40:47 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Brian Starkey <brian.starkey@arm.com>
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, liviu.dudau@arm.com,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, nd@arm.com
Subject: Re: [PATCH] drm: mali-dp: potential dereference of null pointer
Message-ID: <YcBPn6ZTLbobErXj@phenom.ffwll.local>
Mail-Followup-To: Brian Starkey <brian.starkey@arm.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>, liviu.dudau@arm.com,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, nd@arm.com
References: <20211214100837.46912-1-jiasheng@iscas.ac.cn>
 <20211214110202.unexcdiya3qhsvzc@000377403353>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214110202.unexcdiya3qhsvzc@000377403353>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 11:02:02AM +0000, Brian Starkey wrote:
> Hi,
> 
> On Tue, Dec 14, 2021 at 06:08:37PM +0800, Jiasheng Jiang wrote:
> > The return value of kzalloc() needs to be checked.
> > To avoid use of null pointer '&state->base' in case of the
> > failure of alloc.
> > 
> > Fixes: 99665d072183 ("drm: mali-dp: add malidp_crtc_state struct")
> > Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> > ---
> 
> You can add my r-b to this one too. Thanks!

Are you (or someone else from arm) also pushing these? Otherwise they'll
get lost.
-Daniel

> 
> >  drivers/gpu/drm/arm/malidp_crtc.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/arm/malidp_crtc.c b/drivers/gpu/drm/arm/malidp_crtc.c
> > index 494075ddbef6..b5928b52e279 100644
> > --- a/drivers/gpu/drm/arm/malidp_crtc.c
> > +++ b/drivers/gpu/drm/arm/malidp_crtc.c
> > @@ -487,7 +487,10 @@ static void malidp_crtc_reset(struct drm_crtc *crtc)
> >  	if (crtc->state)
> >  		malidp_crtc_destroy_state(crtc, crtc->state);
> >  
> > -	__drm_atomic_helper_crtc_reset(crtc, &state->base);
> > +	if (state)
> > +		__drm_atomic_helper_crtc_reset(crtc, &state->base);
> > +	else
> > +		__drm_atomic_helper_crtc_reset(crtc, NULL);
> >  }
> >  
> >  static int malidp_crtc_enable_vblank(struct drm_crtc *crtc)
> > -- 
> > 2.25.1
> > 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
