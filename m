Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02D7553F83
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 02:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354962AbiFVA01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 20:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiFVA0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 20:26:25 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC31613CD1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 17:26:23 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id p14so8903501pfh.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 17:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HyU/ygfmhVGS6xWpbOKn6OEJd/jV8t0D8U8VB3gM6Kc=;
        b=mu03dInaeeI1tZbMR/CyJpnvw/YpqTdifEfhYjta2Ux2P8SHkCgTnUvgBBaXS9beN/
         jEtnM402ZNaDRKyZASY9xm3pAJDsGbb2jSN9UBCMKejyU4khd4diNZGlhzLol0FAN/2W
         qJscIAx0Rdb9l/yG8FsrhSSHyHN1fXSn0ZnG1o1SenOHwHOruWN6KHa+/e77SdHx9xGs
         eN97reRP+LVbK2hp5Hkm5jIAdjT7qn1HYpWBcUS1iHLQywz86vCq4sdR28d+Xg6Al6xK
         tcVbVNfE3v57Tbmv/2NXtnyMAh/CIeStnv/Tig3OoiNguQjwRAq/cHna06ZLOIXpLcFU
         2JJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=HyU/ygfmhVGS6xWpbOKn6OEJd/jV8t0D8U8VB3gM6Kc=;
        b=QTjpAW+0agFCj8Bxby+E3ejCTkP1WblzRT3951R8lCjN9hwQMf1L9nV7rj9EfOEh/P
         Y4nv81KHeodMXuKq5K6UNMx5Gge40juzTtiqITrX/saoyAu5wKzj1xb6FAJ3lPu4mIzU
         7RnNSa/zT6JSsXnfUrt9gLFMpq5tP+r6YjV8ZcZZf3llj0bu4L3HHgBg+/PrzVhj6l7b
         rz2BOXlXGWgJ2ah6jkM/2qWRjBK3F38h2Z2Tk8lwLix0aCjMj+uwesTADNnB+0SJ9QCe
         Xz1SGCsnK1gmAe3r+hQeCrX7tPMlmwuuIabkVacaHDIKApfD9h15jEy6fMH0pS0gJAYx
         kAIQ==
X-Gm-Message-State: AJIora/5xeLu4z3k6DIi1/LMWb2rmbEwjNc/n+/KIQ3r3Q63y40Flc0+
        HdcK3Lolhfc3NKxzsrkh0dQ=
X-Google-Smtp-Source: AGRyM1vzMGSpH7ukgiGn6qy8/xQjQhGjh5W38HhIBxIummnj04mvjrykHH7ZnKq8goM7KGK1USKZ+g==
X-Received: by 2002:a65:6e04:0:b0:40d:26eb:8225 with SMTP id bd4-20020a656e04000000b0040d26eb8225mr562426pgb.138.1655857583046;
        Tue, 21 Jun 2022 17:26:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i6-20020a626d06000000b0051c09cdd71fsm11870070pfc.72.2022.06.21.17.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 17:26:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 21 Jun 2022 17:26:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Melissa Wen <mwen@igalia.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "Dhillon, Jasdeep" <Jasdeep.Dhillon@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH] drm/amd/display: Add missing hard-float compile flags
 for PPC64 builds
Message-ID: <20220622002619.GA3475450@roeck-us.net>
References: <20220618232737.2036722-1-linux@roeck-us.net>
 <CADnq5_N1p53Orbjxfxd7Cwos0p8OVz1TbRm0rFaUnxQJwah61g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_N1p53Orbjxfxd7Cwos0p8OVz1TbRm0rFaUnxQJwah61g@mail.gmail.com>
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

On Mon, Jun 20, 2022 at 05:51:04PM -0400, Alex Deucher wrote:
> On Sat, Jun 18, 2022 at 7:27 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > ppc:allmodconfig builds fail with the following error.
> >
> > powerpc64-linux-ld:
> >         drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o
> >                 uses hard float,
> >         drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.o
> >                 uses soft float
> > powerpc64-linux-ld:
> >         failed to merge target specific data of file
> >         drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.o
> > powerpc64-linux-ld:
> >         drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o
> >                 uses hard float,
> >         drivers/gpu/drm/amd/amdgpu/../display/dc/dcn315/dcn315_resource.o
> >                 uses soft float
> > powerpc64-linux-ld:
> >         failed to merge target specific data of
> >         file drivers/gpu/drm/amd/amdgpu/../display/dc/dcn315/dcn315_resource.o
> > powerpc64-linux-ld:
> >         drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o
> >                 uses hard float,
> >         drivers/gpu/drm/amd/amdgpu/../display/dc/dcn316/dcn316_resource.o
> >                 uses soft float
> > powerpc64-linux-ld:
> >         failed to merge target specific data of file
> >         drivers/gpu/drm/amd/amdgpu/../display/dc/dcn316/dcn316_resource.o
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
> >  drivers/gpu/drm/amd/display/dc/dcn31/Makefile  | 4 ++++
> >  drivers/gpu/drm/amd/display/dc/dcn315/Makefile | 4 ++++
> >  drivers/gpu/drm/amd/display/dc/dcn316/Makefile | 4 ++++
> >  3 files changed, 12 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
> > index ec041e3cda30..74be02114ae4 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
> > @@ -15,6 +15,10 @@ DCN31 = dcn31_resource.o dcn31_hubbub.o dcn31_hwseq.o dcn31_init.o dcn31_hubp.o
> >         dcn31_apg.o dcn31_hpo_dp_stream_encoder.o dcn31_hpo_dp_link_encoder.o \
> >         dcn31_afmt.o dcn31_vpg.o
> >
> > +ifdef CONFIG_PPC64
> > +CFLAGS_$(AMDDALPATH)/dc/dcn31/dcn31_resource.o := -mhard-float -maltivec
> > +endif
> 
> This stuff was all moved as part of the FP rework in:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=26f4712aedbdf4b9f5e3888a50a2a4b130ee4a9b
> @Siqueira, Rodrigo
> , @Melissa Wen, @Dhillon, Jasdeep  can you take a look to understand
> why this is necessary?  If we add back the PPC flags, I think we need
> to add back the x86 ones as well.
> 

For my part I have no idea. All I can see is that powerpc:allmodconfig
builds fail with the above errors. I have not seen any build errors with
other architectures.

Guenter

> Alex
> 
> > +
> >  AMD_DAL_DCN31 = $(addprefix $(AMDDALPATH)/dc/dcn31/,$(DCN31))
> >
> >  AMD_DISPLAY_FILES += $(AMD_DAL_DCN31)
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/Makefile b/drivers/gpu/drm/amd/display/dc/dcn315/Makefile
> > index 59381d24800b..1395c1ced8c5 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn315/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn315/Makefile
> > @@ -25,6 +25,10 @@
> >
> >  DCN315 = dcn315_resource.o
> >
> > +ifdef CONFIG_PPC64
> > +CFLAGS_$(AMDDALPATH)/dc/dcn315/dcn315_resource.o := -mhard-float -maltivec
> > +endif
> > +
> >  AMD_DAL_DCN315 = $(addprefix $(AMDDALPATH)/dc/dcn315/,$(DCN315))
> >
> >  AMD_DISPLAY_FILES += $(AMD_DAL_DCN315)
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/Makefile b/drivers/gpu/drm/amd/display/dc/dcn316/Makefile
> > index 819d44a9439b..c3d2dd78f1e2 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn316/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn316/Makefile
> > @@ -25,6 +25,10 @@
> >
> >  DCN316 = dcn316_resource.o
> >
> > +ifdef CONFIG_PPC64
> > +CFLAGS_$(AMDDALPATH)/dc/dcn316/dcn316_resource.o := -mhard-float -maltivec
> > +endif
> > +
> >  AMD_DAL_DCN316 = $(addprefix $(AMDDALPATH)/dc/dcn316/,$(DCN316))
> >
> >  AMD_DISPLAY_FILES += $(AMD_DAL_DCN316)
> > --
> > 2.35.1
> >
