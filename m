Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445C654473B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239512AbiFIJTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241776AbiFIJT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:19:27 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E9E1F2FE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 02:19:26 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m39-20020a05600c3b2700b0039c511ebbacso5590650wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 02:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f/iBGt4xN7zzCFQSjNLwi4Ry+Kpyk/3pfrO2M9cm4OQ=;
        b=iuL3C0TadnvQ/K14iUfaUoZbhV2yRA+ewm1TptnZf8FjVkH2jA3YFNACeR+uxyeoc1
         S4b8x3fuYzWpMPSVr5L7V0up1RJ7KDmA0ZjN98Ov+EajgfD4IGrPMe5e0sU6uRY7VMus
         gmG7Fjbj3h13widN8jJRdUhxiRmAFVfblP5iWwQmB3HojvJva8WVnkZ9ALha6vKK8tl6
         Ect8ifuxuthfEzJwXbn1vIVrqFtJPGZQgV6OM5LajtL++cWYdgL4HPymBqscHTifNZPg
         4gtcf2kQ7xL72MjEFi/XZxoR5CznRHUdsDjxP+Gd87CTOE/QTzPSqfCg4BrIyZ7BW1xe
         qCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f/iBGt4xN7zzCFQSjNLwi4Ry+Kpyk/3pfrO2M9cm4OQ=;
        b=v1ze2B2YKxe06phsbRSXm2JpVDcnF0LEo5mbHQi9ksMsoAYoShnltdfYL6E2kEP5Vq
         n8zLHi6kg7w7BKQ5Mw2RFmpXNGoktUEXAhoKyguKYQqN2DVpJrPAjipGg2JbtwalX3qx
         VXkYQaTq2VX3PiucCP2WurjQgTiunABQ39wGgOH7VQxxRxczh7UBsjIU7ozmhVTHWAlH
         upf/APYs0g6HpLvfYamyiZk4H82yFQn97ZsSU2L1STdXkrpNdZbFbBUo1u+la2b3RoKT
         Dfn1APrDa6QYEUjGU+bgaL3Byj1JgG/L0XLgk34Cfca0tVl1SWT1gaV4bbOqLCrr8kRZ
         hJBQ==
X-Gm-Message-State: AOAM5313NhrQ+Yq83KI+4n5mBAlV1tzJnzR2DdLoEi0v+DwUzDQWPaHn
        9qHY4oUa2O0bWCjXgXF8NTKsdw==
X-Google-Smtp-Source: ABdhPJwFZrOR/0oGzmAtsFR27TnfBD5OvFlRRibuQc57qR4bFY2nupml8YcXoSl2/M2wBwLsfNyzCg==
X-Received: by 2002:a1c:cc07:0:b0:397:b2f:ac59 with SMTP id h7-20020a1ccc07000000b003970b2fac59mr2303142wmb.157.1654766365179;
        Thu, 09 Jun 2022 02:19:25 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id u12-20020adfdb8c000000b002119c1a03e4sm22758115wri.31.2022.06.09.02.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 02:19:24 -0700 (PDT)
Date:   Thu, 9 Jun 2022 10:19:22 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [RESEND PATCH v3] drm/cma-helper: Describe what a "contiguous
 chunk" actually means
Message-ID: <20220609091922.6gn2nlysrpndfu4n@maple.lan>
References: <20220608135821.1153346-1-daniel.thompson@linaro.org>
 <YqDCTrlPmDZQei8Q@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqDCTrlPmDZQei8Q@phenom.ffwll.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 05:37:50PM +0200, Daniel Vetter wrote:
> On Wed, Jun 08, 2022 at 02:58:21PM +0100, Daniel Thompson wrote:
> > Since it's inception in 2012 it has been understood that the DRM GEM CMA
> > helpers do not depend on CMA as the backend allocator. In fact the first
> > bug fix to ensure the cma-helpers work correctly with an IOMMU backend
> > appeared in 2014. However currently the documentation for
> > drm_gem_cma_create() talks about "a contiguous chunk of memory" without
> > making clear which address space it will be a contiguous part of.
> > Additionally the CMA introduction is actively misleading because it only
> > contemplates the CMA backend.
> > 
> > This matters because when the device accesses the bus through an IOMMU
> > (and don't use the CMA backend) then the allocated memory is contiguous
> > only in the IOVA space. This is a significant difference compared to the
> > CMA backend and the behaviour can be a surprise even to someone who does
> > a reasonable level of code browsing (but doesn't find all the relevant
> > function pointers ;-) ).
> > 
> > Improve the kernel doc comments accordingly.
> > 
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> > 
> > Notes:
> >     Am I Cc:ing the correct reviewers/maintainers with this patch? There
> >     has been no negative feedback but I've been rebasing and re-posting it
> >     for three kernel cycles now. Do I need to queue it somewhere special or
> >     get it in front of someone specific?
> 
> Occasionally stuff falls through a few too many cracks, that's all. We
> have tons of committers for drm-misc (and Lucas is one of them), but
> sometimes they shy away from pushing themselves and others see the r-b and
> assume it's already handled, and then it doesn't move :-/

No worries. Arguably I should have asked this question a little earlier
anyway.


Thanks for pushing it.


Daniel.
