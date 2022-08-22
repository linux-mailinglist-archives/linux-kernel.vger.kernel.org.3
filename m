Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A187459BF32
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbiHVMDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 08:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiHVMD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:03:28 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D885A477
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 05:03:26 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z20so13524294edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 05:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=5bsRy8NmbqAJ5Fg8qdrRQ5r91QFBlNcy6cH/Qzqv7m8=;
        b=asgePyz0CxZM9KLikVoyogbZcYggCpzQYNR4oxwrlvgcOmJZqmREcmlXxTyJjbceBg
         N8h65kpi9teX2/SJ7pI63oq1itQUgwoAbGyeLADZBAGsE0Ge/IL3ikb6ps615xJT+JXd
         jztDQOyUsDiBv7628AnPBPS3kZuwvsJ4HnkGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=5bsRy8NmbqAJ5Fg8qdrRQ5r91QFBlNcy6cH/Qzqv7m8=;
        b=AtMb+kbB67uCmzxum2xdpSLgZvlDpzLD8P2ebKbBLsywI8WfYOEtQewTWd5A4+tOU1
         +GVUKidr3KBtWznGZ9IBt8ktvflNI8zh65SAJVe8EugMUZ9EzKyZfQUHcb2lswrY2Tds
         lfMg1MuHYzPWdIR0XTtb/o4CtcuD4SMDUTHEbLGyw+fbkm1vj2mpiSSCZ8E/w8vciFf1
         R9jxShDVydRzhfDJ3D5Qf4UmTbGLMLTh3/qkhZxzEYjcLGpJPwqajHXRPEqy/i6CMOm/
         LLbWZQKOQ9lEPEE3MWh3clU2/jRLXANLvwgCGwgi/sCccrleTP7v6FtS/GxtPhLlt8cU
         TDOA==
X-Gm-Message-State: ACgBeo1MpXG7ge7q7V/1QNu2GsMGlEuY9kMroxNPk6n2RPgiNr/VYLHl
        XEowW8S6nPHn/GCG1NahQdZ2Zg==
X-Google-Smtp-Source: AA6agR7DzGqJD0yEZSf2uStXMrGk/irCyGL6RLzZ4ikIqfI80SKc0OuyH4itNpIQs0qxTPg93rcXKg==
X-Received: by 2002:a05:6402:3227:b0:446:e48c:1251 with SMTP id g39-20020a056402322700b00446e48c1251mr1872833eda.186.1661169804974;
        Mon, 22 Aug 2022 05:03:24 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-57-252.cust.vodafonedsl.it. [188.217.57.252])
        by smtp.gmail.com with ESMTPSA id bd11-20020a056402206b00b00445f3ba4674sm8084493edb.63.2022.08.22.05.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 05:03:24 -0700 (PDT)
Date:   Mon, 22 Aug 2022 14:03:22 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Ming Qian <ming.qian@nxp.com>
Cc:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH v4 2/4] media: amphion: tell and handle
 contiguous and non contiguous format
Message-ID: <20220822120322.GD17530@tom-ThinkPad-T14s-Gen-2i>
References: <cover.1660027440.git.ming.qian@nxp.com>
 <4af9766eb664a02d1c5884cb48fadef24dec142f.1660027440.git.ming.qian@nxp.com>
 <20220822111655.GA17530@tom-ThinkPad-T14s-Gen-2i>
 <AM6PR04MB6341A3B117F6FDB818DAB5E6E7719@AM6PR04MB6341.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB6341A3B117F6FDB818DAB5E6E7719@AM6PR04MB6341.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,

On Mon, Aug 22, 2022 at 11:56:11AM +0000, Ming Qian wrote:
> >Hi Ming,
> >Sorry for delay. I'm on vacation last week :)
> >
> >On Tue, Aug 09, 2022 at 02:50:39PM +0800, Ming Qian wrote:
> >> Driver should tell the number of memory planes and component planes.
> >> the amphion vpu support non contiguous planes, but for compatibility
> >> with other device that only support contiguous planes.
> >> driver can add support for contiguous planes in the same time.
> >> Then the mem_planes can be different from the comp_planes.
> >> driver need to handle buffer according mem_planes and comp_planes.
> >>
> >> So driver can support NV12 and NV12M.
> >>
> >> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> >> ---
> >>  drivers/media/platform/amphion/vdec.c        | 187 ++++++++++---------
> >>  drivers/media/platform/amphion/venc.c        |  33 ++--
> >>  drivers/media/platform/amphion/vpu.h         |   4 +-
> >>  drivers/media/platform/amphion/vpu_dbg.c     |   8 +-
> >>  drivers/media/platform/amphion/vpu_helpers.c |  48 ++++-
> >>  drivers/media/platform/amphion/vpu_helpers.h |   2 +
> >>  drivers/media/platform/amphion/vpu_malone.c  |   3 +-
> >>  drivers/media/platform/amphion/vpu_v4l2.c    | 168 ++++++++++++-----
> >>  drivers/media/platform/amphion/vpu_v4l2.h    |   3 +-
> >>  drivers/media/platform/amphion/vpu_windsor.c |   8 +-
> >>  10 files changed, 299 insertions(+), 165 deletions(-)
> >>
> 
> [snip]
> 
> >> +const struct vpu_format *vpu_helper_find_sibling(struct vpu_inst
> >> +*inst, u32 type, u32 pixelfmt) {
> >> +     const struct vpu_format *fmt;
> >> +     const struct vpu_format *sibling;
> >> +
> >> +     fmt = vpu_helper_find_format(inst, type, pixelfmt);
> >> +     if (!fmt)
> >> +             return NULL;
> >> +     if (!fmt->sibling)
> >> +             return NULL;
> >> +     sibling = vpu_helper_find_format(inst, type, fmt->sibling);
> >> +     if (!sibling)
> >> +             return NULL;
> >> +     if (sibling->sibling != fmt->pixfmt)
> >> +             return NULL;
> >> +     if (sibling->comp_planes != fmt->comp_planes)
> >> +             return NULL;
> >> +     return sibling;
> >> +}
> >
> >I think we can limit the use of "if" statement here. What about this?
> >
> >const struct vpu_format *vpu_helper_find_sibling(struct vpu_inst *inst, u32
> >type, u32 pixelfmt) {
> >        const struct vpu_format *fmt;
> >        const struct vpu_format *sibling;
> >
> >        fmt = vpu_helper_find_format(inst, type, pixelfmt);
> >        if (!fmt || !fmt->sibling)
> >                return NULL;
> >
> >        sibling = vpu_helper_find_format(inst, type, fmt->sibling);
> >        if (!sibling || (sibling->sibling != fmt->pixfmt) ||
> >                (sibling->comp_planes != fmt->comp_planes))
> >                return NULL;
> >
> >        return sibling;
> >}
> >
> 
> OK, I'll apply this change in v5
> 
> >> +
> >> +bool vpu_helper_match_format(struct vpu_inst *inst, u32 type, u32
> >> +fmta, u32 fmtb) {
> >> +     const struct vpu_format *sibling;
> >> +
> >> +     if (fmta == fmtb)
> >> +             return true;
> >> +
> >> +     sibling = vpu_helper_find_sibling(inst, type, fmta);
> >> +     if (sibling && sibling->pixfmt == fmtb)
> >> +             return true;
> >> +     return false;
> >> +}
> >> +
> 
> [snip]
> 
> >> --- a/drivers/media/platform/amphion/vpu_malone.c
> >> +++ b/drivers/media/platform/amphion/vpu_malone.c
> >> @@ -583,7 +583,8 @@ bool vpu_malone_check_fmt(enum vpu_core_type
> >type, u32 pixelfmt)
> >>       if (!vpu_imx8q_check_fmt(type, pixelfmt))
> >>               return false;
> >>
> >> -     if (pixelfmt == V4L2_PIX_FMT_NV12M_8L128 || pixelfmt ==
> >V4L2_PIX_FMT_NV12M_10BE_8L128)
> >> +     if (pixelfmt == V4L2_PIX_FMT_NV12_8L128 || pixelfmt ==
> >V4L2_PIX_FMT_NV12_10BE_8L128 ||
> >> +         pixelfmt == V4L2_PIX_FMT_NV12M_8L128 || pixelfmt ==
> >> + V4L2_PIX_FMT_NV12M_10BE_8L128)
> >
> >^Here are we using spaces instead of tab or I'm wrong?
> >
> 
> It's following the rule of checkpatch.pl
> 
> >>               return true;
> >>       if (vpu_malone_format_remap(pixelfmt) == MALONE_FMT_NULL)
> >>               return false;
> 
> [snip]
> 
> >> +static int vpu_calc_fmt_sizeimage(struct vpu_inst *inst, struct
> >> +vpu_format *fmt) {
> >>       u32 stride = 1;
> >> -     u32 bytesperline;
> >> -     u32 sizeimage;
> >> -     const struct vpu_format *fmt;
> >> -     const struct vpu_core_resources *res;
> >>       int i;
> >>
> >> -     fmt = vpu_helper_find_format(inst, type, pixmp->pixelformat);
> >> -     if (!fmt) {
> >> -             fmt = vpu_helper_enum_format(inst, type, 0);
> >> -             if (!fmt)
> >> -                     return NULL;
> >> -             pixmp->pixelformat = fmt->pixfmt;
> >> +     if (!(fmt->flags & V4L2_FMT_FLAG_COMPRESSED)) {
> >> +             const struct vpu_core_resources *res =
> >> + vpu_get_resource(inst);
> >> +
> >> +             if (res)
> >> +                     stride = res->stride;
> >
> >If res=NULL stride=1 it is ok? Or we need to return some error?
> >
> 
> If res is NULL, it means there is no additional alignment constraints
> So it's ok to set stride to 1 in this case.
> 
> >>       }
> >>
> >> -     res = vpu_get_resource(inst);
> >> -     if (res)
> >> -             stride = res->stride;
> >> -     if (pixmp->width)
> >> -             pixmp->width = vpu_helper_valid_frame_width(inst,
> >pixmp->width);
> >> -     if (pixmp->height)
> >> -             pixmp->height = vpu_helper_valid_frame_height(inst,
> >pixmp->height);
> >> +     for (i = 0; i < fmt->comp_planes; i++) {
> >> +             fmt->sizeimage[i] = vpu_helper_get_plane_size(fmt->pixfmt,
> >> +
> >fmt->width,
> >> +
> >fmt->height,
> >> +                                                           i,
> >> +                                                           stride,
> >> +
> >fmt->field != V4L2_FIELD_NONE ? 1 : 0,
> >> +
> >&fmt->bytesperline[i]);
> >> +             fmt->sizeimage[i] = max_t(u32, fmt->sizeimage[i], PAGE_SIZE);
> >> +             if (fmt->flags & V4L2_FMT_FLAG_COMPRESSED) {
> >> +                     fmt->sizeimage[i] = clamp_val(fmt->sizeimage[i],
> >SZ_128K, SZ_8M);
> >> +                     fmt->bytesperline[i] = 0;
> >> +             }
> >> +     }
> >> +
> >> +     return 0;
> >> +}
> >> +
> >> +u32 vpu_get_fmt_plane_size(struct vpu_format *fmt, u32 plane_no) {
> >> +     u32 size;
> >> +     int i;
> >> +
> >> +     if (plane_no >= fmt->mem_planes)
> >> +             return 0;
> >> +
> >> +     if (fmt->comp_planes == fmt->mem_planes)
> >> +             return fmt->sizeimage[plane_no];
> >> +     if (plane_no < fmt->mem_planes - 1)
> >> +             return fmt->sizeimage[plane_no];
> >
> >I like a space here but is my personal opinion :)
> >
> 
> OK, I'll add a space line here in v5
> 
> [snip]

Thanks for clarifications.

Regards,
Tommaso

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
