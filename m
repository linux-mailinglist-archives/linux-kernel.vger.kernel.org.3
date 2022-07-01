Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3CD5627F2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 03:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiGABAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 21:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbiGABAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 21:00:47 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5125C599D6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 18:00:46 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id go6so1156803pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 18:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V0zM+5bGzrkuoT/FKu7bEUEOWBFCnfKhcSbWomk53qM=;
        b=admCY/5SeVAW7JF20wM5exEz/XP8A8JZMf56qXi/BvZ/2TzamG0oewPdsY/dof8rZt
         QtBTb80R8GTBeghWwTMNXB1kZ/9L4C/U3ie+lv4Nmc730oSOBoFsLTgET87olma0YXDl
         bgUJ5ybAaruQbmdtzc9cfmvtAZKXR3LCKVBpbZe+F3gmflagoSjDTC1FmEZg6Iicm2IP
         6t9iUJCBMnEL9qPZ2Ke3p0wLZTdFHwYfgbfN0BX/e7mdw2V9E7VTPYOTSZRlD6O8+fpq
         m0se6R/bavZys/jzlg+i246xcW99nqDeM+NeqVrqekQpJ4kRwff9J8W/s5IYeiGXKyFS
         F7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=V0zM+5bGzrkuoT/FKu7bEUEOWBFCnfKhcSbWomk53qM=;
        b=IduoI5Q4KfwufCA97uAUK0Cds+m3GJy6vYjdkaG86C/au6FiEmPnSYH2LypWg3BDZD
         ++16mbdOeMuZGbHmeZt08mgrwhsrL7bKJOjSqtF0ThLAQ66zD6y4bSA+vllHbQ5NuBWx
         HlG6Z2K3ly5OViOByUGqTgc8g1lY0HVdHbMtDcbg9f6TAYGTd4xwL4Ebi78BGuBtCXDo
         v9jcXDrOR+68VR1L7ikPIyHPaf4YeR8tnSV3WGXPUpUXtt5Af87tOL6sv6Q0v5obJSj1
         khOrj/H13BwBjFBDl37dadS1zQFwTOuD3t9I3iPaQfoTXZt29QajemGUNYofyHauJBn+
         OlNA==
X-Gm-Message-State: AJIora+HW1XqF8M1OE/eMRRlSYfEq2EmPlPAlnFAiGDrHBPOfC5ERQyo
        9bNpPM9XdZc8xgl96EdPH0U=
X-Google-Smtp-Source: AGRyM1uO7TZZ/gV2+Eab2pQbAFkv30F/jNtzZp3FwVfoJmAfJx+ZClZ40J+Pl2oaBeYCOh5B8AqXeA==
X-Received: by 2002:a17:902:d1cd:b0:169:f061:7341 with SMTP id g13-20020a170902d1cd00b00169f0617341mr18532874plb.16.1656637245831;
        Thu, 30 Jun 2022 18:00:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w20-20020a1709029a9400b0015e8d4eb231sm14131141plp.123.2022.06.30.18.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 18:00:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 30 Jun 2022 18:00:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH] drm/amd/display: Add missing hard-float compile flags
 for PPC64 builds
Message-ID: <20220701010042.GH3104033@roeck-us.net>
References: <20220618232737.2036722-1-linux@roeck-us.net>
 <584fc348-7a60-26a2-af61-9edc4f4830e4@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <584fc348-7a60-26a2-af61-9edc4f4830e4@amd.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 05:01:01PM -0400, Rodrigo Siqueira Jordao wrote:
> 
> 
> On 2022-06-18 19:27, Guenter Roeck wrote:
> > ppc:allmodconfig builds fail with the following error.
> > 
> > powerpc64-linux-ld:
> > 	drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o
> > 		uses hard float,
> > 	drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.o
> > 		uses soft float
> > powerpc64-linux-ld:
> > 	failed to merge target specific data of file
> > 	drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.o
> > powerpc64-linux-ld:
> > 	drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o
> > 		uses hard float,
> > 	drivers/gpu/drm/amd/amdgpu/../display/dc/dcn315/dcn315_resource.o
> > 		uses soft float
> > powerpc64-linux-ld:
> > 	failed to merge target specific data of
> > 	file drivers/gpu/drm/amd/amdgpu/../display/dc/dcn315/dcn315_resource.o
> > powerpc64-linux-ld:
> > 	drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o
> > 		uses hard float,
> > 	drivers/gpu/drm/amd/amdgpu/../display/dc/dcn316/dcn316_resource.o
> > 		uses soft float
> > powerpc64-linux-ld:
> > 	failed to merge target specific data of file
> > 	drivers/gpu/drm/amd/amdgpu/../display/dc/dcn316/dcn316_resource.o
> > 
> > The problem was introduced with commit 41b7a347bf14 ("powerpc: Book3S
> > 64-bit outline-only KASAN support") which adds support for KASAN. This
> > commit in turn enables DRM_AMD_DC_DCN because KCOV_INSTRUMENT_ALL and
> > KCOV_ENABLE_COMPARISONS are no longer enabled. As result, new files are
> > compiled which lack the selection of hard-float.
> > 
> > Fixes: 41b7a347bf14 ("powerpc: Book3S 64-bit outline-only KASAN support")
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Daniel Axtens <dja@axtens.net>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >   drivers/gpu/drm/amd/display/dc/dcn31/Makefile  | 4 ++++
> >   drivers/gpu/drm/amd/display/dc/dcn315/Makefile | 4 ++++
> >   drivers/gpu/drm/amd/display/dc/dcn316/Makefile | 4 ++++
> >   3 files changed, 12 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
> > index ec041e3cda30..74be02114ae4 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
> > @@ -15,6 +15,10 @@ DCN31 = dcn31_resource.o dcn31_hubbub.o dcn31_hwseq.o dcn31_init.o dcn31_hubp.o
> >   	dcn31_apg.o dcn31_hpo_dp_stream_encoder.o dcn31_hpo_dp_link_encoder.o \
> >   	dcn31_afmt.o dcn31_vpg.o
> > +ifdef CONFIG_PPC64
> > +CFLAGS_$(AMDDALPATH)/dc/dcn31/dcn31_resource.o := -mhard-float -maltivec
> > +endif
> > +
> >   AMD_DAL_DCN31 = $(addprefix $(AMDDALPATH)/dc/dcn31/,$(DCN31))
> >   AMD_DISPLAY_FILES += $(AMD_DAL_DCN31)
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/Makefile b/drivers/gpu/drm/amd/display/dc/dcn315/Makefile
> > index 59381d24800b..1395c1ced8c5 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn315/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn315/Makefile
> > @@ -25,6 +25,10 @@
> >   DCN315 = dcn315_resource.o
> > +ifdef CONFIG_PPC64
> > +CFLAGS_$(AMDDALPATH)/dc/dcn315/dcn315_resource.o := -mhard-float -maltivec
> > +endif
> > +
> >   AMD_DAL_DCN315 = $(addprefix $(AMDDALPATH)/dc/dcn315/,$(DCN315))
> >   AMD_DISPLAY_FILES += $(AMD_DAL_DCN315)
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/Makefile b/drivers/gpu/drm/amd/display/dc/dcn316/Makefile
> > index 819d44a9439b..c3d2dd78f1e2 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn316/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn316/Makefile
> > @@ -25,6 +25,10 @@
> >   DCN316 = dcn316_resource.o
> > +ifdef CONFIG_PPC64
> > +CFLAGS_$(AMDDALPATH)/dc/dcn316/dcn316_resource.o := -mhard-float -maltivec
> > +endif
> > +
> >   AMD_DAL_DCN316 = $(addprefix $(AMDDALPATH)/dc/dcn316/,$(DCN316))
> >   AMD_DISPLAY_FILES += $(AMD_DAL_DCN316)
> 
> Hi,
> 
> I don't want to re-introduce those FPU flags for DCN31/DCN314/DCN316 since
> we fully isolate FPU operations for those ASICs inside the DML folder.

FWIW, I don't think that matters from a linking perspective since the hard-float
and the soft-float objects are linked together, and the linker bails out on
that because the ABIs are not compatible. You only get a warning on that unless
you build with -Werror, which is the case for allmodconfig builds.

Guenter
