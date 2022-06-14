Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B050754B4D1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356861AbiFNPfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356753AbiFNPfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:35:50 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52BA37A3E;
        Tue, 14 Jun 2022 08:35:49 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u12so17911105eja.8;
        Tue, 14 Jun 2022 08:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A5Fku5sLsMLBrjsk6biwZng1HkUtjDTeaTUGHkpweZs=;
        b=U+HGkA2qmx3zfjxRaZLeGUSPNZADI3mCpF1NYELoe7SKNjRPbpiPu9TjXm/TNb/gpl
         IyRYSLnnlRlTNmdkxPxrVkdZMefn2/gkJyiwbouhgT3Nb+20jiVx9e6XhT3cKu4mhT8N
         vMwxMIaDeltXyEraLE9m+f5ujO7kx5bVSHHrJfQypgH4hkxsAtXvw/do7jrh9JtnblZ5
         rmdZ6+LwXZAoyRbznEFSG9n0/vqp4mDBAXJnyD4IDnVUIaHwdYTwlMyuAmgFIyft0xn5
         nSc/9wlxL9tgKXakuQqG2WBBHSlA9RYEleDMiMX5Hym1rywoDkap+Rvlvn+MdtAsved+
         6o2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A5Fku5sLsMLBrjsk6biwZng1HkUtjDTeaTUGHkpweZs=;
        b=0Gn3epyRChsrE6F5TeLweVfFqIDQD9ZO+1TkqN/DbGSiBDtoOE2Zp/vF1RFC2yjUz+
         4a9ILxQzFzuhOfm2PdG4Z18yCZJDcSQlkxELykZPZcY80Blr3JjJQisXIjY8+brh7r4B
         wQBzpGKFUJRnT/GelEOXk/CtcEWzM01ABRypJ4h5TkX32D0wKHsd8n3zS5u5qZDNw60o
         uePfYIkRQEz5hxnd0uVjsMJ+ppeXKrro9iYb1VN7y84JFgTIVMGEsySwEeH6zF/FzrNn
         rml1Ap0qghro1yRDPdlkG/3IYfCTg3VBi3J2Isfmsxz0uCA+Dm14ak86YCcBhgqPFUcF
         K/ig==
X-Gm-Message-State: AOAM5317ftNWHfooiRfZqVmvGAJdm+X1Ht5gr2KZxpoZ/OJtRPmeK6Co
        1TA14/mFJrHEO7U/oNZdECY=
X-Google-Smtp-Source: AGRyM1u5fBo0DEDNkKwjm7zXV/UDAWCSV7X38UhOY6nzVRIQzbVupo9YzFYydGSQDFosiPlFq2bYjA==
X-Received: by 2002:a17:906:20c6:b0:716:646d:c019 with SMTP id c6-20020a17090620c600b00716646dc019mr4738093ejc.529.1655220948357;
        Tue, 14 Jun 2022 08:35:48 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id i27-20020a50871b000000b0042dcbc3f302sm7227701edb.36.2022.06.14.08.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 08:35:47 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        samuel@sholland.org, nicolas.dufresne@collabora.com,
        andrzej.p@collabora.com, Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
Subject: Re: Re: [PATCH v8 09/17] media: uapi: HEVC: Define V4L2_CID_STATELESS_HEVC_SLICE_PARAMS as a dynamic array
Date:   Tue, 14 Jun 2022 17:35:46 +0200
Message-ID: <2830572.e9J7NaK4W3@kista>
In-Reply-To: <e16c48e0-39ab-80db-0d14-2b3f97079823@xs4all.nl>
References: <20220614083614.240641-1-benjamin.gaignard@collabora.com> <20220614083614.240641-10-benjamin.gaignard@collabora.com> <e16c48e0-39ab-80db-0d14-2b3f97079823@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 14. junij 2022 ob 15:50:23 CEST je Hans Verkuil napisal(a):
> On 6/14/22 10:36, Benjamin Gaignard wrote:
> > Make explicit that V4L2_CID_STATELESS_HEVC_SLICE_PARAMS control is
> > a dynamic array control type.
> > Some drivers may be able to receive multiple slices in one control
> > to improve decoding performance.
> > 
> > Define the max size of the dynamic that can driver can set in .dims = {}.
> > 
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > ---
> > version 7:
> > - Add Jernej patch to set array dims for Cedrus
> > 
> > version 6:
> > - Set V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag automatically when using
> >   V4L2_CID_STATELESS_HEVC_SLICE_PARAMS control.
> > - Add a define for max slices count
> > 
> >  Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 2 ++
> >  drivers/media/v4l2-core/v4l2-ctrls-defs.c                 | 1 +
> >  drivers/staging/media/sunxi/cedrus/cedrus.c               | 1 +
> >  include/media/hevc-ctrls.h                                | 5 +++++
> >  4 files changed, 9 insertions(+)
> > 
> > diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/
Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > index 06b967de140c..0796b1563daa 100644
> > --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > @@ -2986,6 +2986,8 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
> >      These bitstream parameters are defined according to :ref:`hevc`.
> >      They are described in section 7.4.7 "General slice segment header
> >      semantics" of the specification.
> > +    This control is a dynamically sized 1-dimensional array,
> > +    V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag must be set when using it.
> >  
> >  .. c:type:: v4l2_ctrl_hevc_slice_params
> >  
> > diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/
v4l2-core/v4l2-ctrls-defs.c
> > index 9f55503cd3d6..d594efbcbb93 100644
> > --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > @@ -1510,6 +1510,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum 
v4l2_ctrl_type *type,
> >  		break;
> >  	case V4L2_CID_STATELESS_HEVC_SLICE_PARAMS:
> >  		*type = V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS;
> > +		*flags |= V4L2_CTRL_FLAG_DYNAMIC_ARRAY;
> >  		break;
> >  	case V4L2_CID_STATELESS_HEVC_SCALING_MATRIX:
> >  		*type = V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX;
> > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/
media/sunxi/cedrus/cedrus.c
> > index 87be975a72b6..f3391c7c811c 100644
> > --- a/drivers/staging/media/sunxi/cedrus/cedrus.c
> > +++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
> > @@ -178,6 +178,7 @@ static const struct cedrus_control cedrus_controls[] = 
{
> >  	{
> >  		.cfg = {
> >  			.id	= 
V4L2_CID_STATELESS_HEVC_SLICE_PARAMS,
> > +			.dims   = { 1 },
> 
> So cedrus HW supports only a single SLICE_PARAMS struct? Perhaps add that
> as a comment.

Yes, for now. I have WIP patch which will remove this limitation.

Please corrrect me if I'm wrong, but this dimension represents maximum allowed 
array length? If so, this is a bit awkward for cases where there is really no 
limit. Like in this case. Cedrus can process only one slice which means that 
driver will have to loop over all submitted slices, one by one. Thus, there is 
no real limitation. It could be set to 10, 1000 or even more. Any suggestion 
for appropriate upper limit is appreciated.

Best regards,
Jernej

> 
> >  		},
> >  		.codec		= CEDRUS_CODEC_H265,
> >  	},
> > diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
> > index 0dbd5d681c28..140151609c96 100644
> > --- a/include/media/hevc-ctrls.h
> > +++ b/include/media/hevc-ctrls.h
> > @@ -311,9 +311,14 @@ struct v4l2_hevc_pred_weight_table {
> >  #define 
V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_LOOP_FILTER_ACROSS_SLICES_ENABLED (1ULL << 
8)
> >  #define V4L2_HEVC_SLICE_PARAMS_FLAG_DEPENDENT_SLICE_SEGMENT	(1ULL << 
9)
> >  
> > +#define V4L2_HEVC_SLICE_MAX_COUNT	600
> > +
> 
> I would drop this define. It is not used at the moment, and I think it
> is the driver that should set this through the dims field (as cedrus
> does above). It is likely to be limited by hardware anyway (just my guess).
> 
> If it is needed in the future, it can always be added.
> 
> Regards,
> 
> 	Hans
> 
> >  /**
> >   * v4l2_ctrl_hevc_slice_params - HEVC slice parameters
> >   *
> > + * This control is a dynamically sized 1-dimensional array,
> > + * V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag must be set when using it.
> > + *
> >   * @bit_size: size (in bits) of the current slice data
> >   * @data_bit_offset: offset (in bits) to the video data in the current 
slice data
> >   * @nal_unit_type: specifies the coding type of the slice (B, P or I)
> 
> 


