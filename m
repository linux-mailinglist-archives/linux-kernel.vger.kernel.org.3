Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6164EC841
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348202AbiC3P3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241839AbiC3P3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:29:52 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA991DEA86;
        Wed, 30 Mar 2022 08:28:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 0F1B61F45096
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648654086;
        bh=XqP59wNQgL49UoC/qJA6H4F54qe+92UN4Pm6NzrUT+Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=d4ZVJbLKFH8ofeoSJ7TaFRhX6JNUT7dGadFrW94uBDCcShCX53CjdxIm4zSZEGaRU
         P9rh6Slo86It4EDl3n7U8/mSQlMqc2mdw+eVuoDZ2TciPFCzHMzp5V4nAfGhI3J0oa
         ij0QR+GFV3qNvRFmUtCNMtHJOYBtb5D/4kHhbKywN5d8K12NCGPYi60O19yEE+M03V
         5XDrwpL5qHtJcfC6C4wZ5AV+7veBl9oxjiaKgnUqWCRH6q6fVDgv4t7e/mdzVcnLHd
         12rZNSGduPN8qGwp8bK14UsPNaFvGdgWt//pZESLlqezrSUIL6u1UcHbmu9VZTqRnR
         slNt9zFRegxXQ==
Message-ID: <835323cf7278da60998c3cf7a1e3fca08a3e14d6.camel@collabora.com>
Subject: Re: [PATCH v1 24/24] media: rkvdec-h264: Don't hardcode SPS/PPS
 parameters
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, Alex Bee <knaerzche@gmail.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Wed, 30 Mar 2022 11:27:51 -0400
In-Reply-To: <20220329072216.gqzcp6lowpfrweb7@basti-XPS-13-9310>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
         <20220328195936.82552-25-nicolas.dufresne@collabora.com>
         <20220329072216.gqzcp6lowpfrweb7@basti-XPS-13-9310>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 29 mars 2022 =C3=A0 09:22 +0200, Sebastian Fricke a =C3=A9crit=C2=
=A0:
> Hey Nicolas,
>=20
> The patch series doesn't seem to apply on the latest media tree master
> branch. Looking at your tree I can see that you have commit: ba2c670a
> "media: nxp: Restrict VIDEO_IMX_MIPI_CSIS to ARCH_MXC or COMPILE_TEST
> Laurent Pinchart authored 1 week ago "
>=20
> But the current head of the media tree is: 71e6d0608e4d
> "media: platform: Remove unnecessary print function dev_err()
> Yang Li authored 13 days ago"
>=20
> On 28.03.2022 15:59, Nicolas Dufresne wrote:
> > From: Alex Bee <knaerzche@gmail.com>
> >=20
> > Some SPS/PPS parameters are currently hardcoded in the driver
> > even though so do exist in the uapi which is stable by now.
>=20
> s/even though so/even though they/
> >=20
> > Use them instead of hardcoding them.
> >=20
> > Conformance tests have shown there is no difference, but it might
> > increase decoder performance.
>=20
> I think it would be great if we could add some performance metrics to
> the commit description to have a metric that following patches could
> compare themselves with.

Alex, can you extend on this one? I'm not sure how this can impact performa=
nce,
so I doubt any mitric will be significant. Can I just drop that part of the
comment ?
>=20
> Greetings,
> Sebastian
>=20
> >=20
> > Signed-off-by: Alex Bee <knaerzche@gmail.com>
> > ---
> > drivers/staging/media/rkvdec/rkvdec-h264.c | 13 +++++++------
> > 1 file changed, 7 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/stagi=
ng/media/rkvdec/rkvdec-h264.c
> > index 891c48bf6a51..91f65d78e453 100644
> > --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
> > +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
> > @@ -655,13 +655,14 @@ static void assemble_hw_pps(struct rkvdec_ctx *ct=
x,
> >=20
> > #define WRITE_PPS(value, field) set_ps_field(hw_ps->info, field, value)
> > 	/* write sps */
> > -	WRITE_PPS(0xf, SEQ_PARAMETER_SET_ID);
> > -	WRITE_PPS(0xff, PROFILE_IDC);
> > -	WRITE_PPS(1, CONSTRAINT_SET3_FLAG);
> > +	WRITE_PPS(sps->seq_parameter_set_id, SEQ_PARAMETER_SET_ID);
> > +	WRITE_PPS(sps->profile_idc, PROFILE_IDC);
> > +	WRITE_PPS((sps->constraint_set_flags & 1 << 3) ? 1 : 0, CONSTRAINT_SE=
T3_FLAG);
> > 	WRITE_PPS(sps->chroma_format_idc, CHROMA_FORMAT_IDC);
> > 	WRITE_PPS(sps->bit_depth_luma_minus8, BIT_DEPTH_LUMA);
> > 	WRITE_PPS(sps->bit_depth_chroma_minus8, BIT_DEPTH_CHROMA);
> > -	WRITE_PPS(0, QPPRIME_Y_ZERO_TRANSFORM_BYPASS_FLAG);
> > +	WRITE_PPS(!!(sps->flags & V4L2_H264_SPS_FLAG_QPPRIME_Y_ZERO_TRANSFORM=
_BYPASS),
> > +		  QPPRIME_Y_ZERO_TRANSFORM_BYPASS_FLAG);
> > 	WRITE_PPS(sps->log2_max_frame_num_minus4, LOG2_MAX_FRAME_NUM_MINUS4);
> > 	WRITE_PPS(sps->max_num_ref_frames, MAX_NUM_REF_FRAMES);
> > 	WRITE_PPS(sps->pic_order_cnt_type, PIC_ORDER_CNT_TYPE);
> > @@ -679,8 +680,8 @@ static void assemble_hw_pps(struct rkvdec_ctx *ctx,
> > 		  DIRECT_8X8_INFERENCE_FLAG);
> >=20
> > 	/* write pps */
> > -	WRITE_PPS(0xff, PIC_PARAMETER_SET_ID);
> > -	WRITE_PPS(0x1f, PPS_SEQ_PARAMETER_SET_ID);
> > +	WRITE_PPS(pps->pic_parameter_set_id, PIC_PARAMETER_SET_ID);
> > +	WRITE_PPS(pps->seq_parameter_set_id, PPS_SEQ_PARAMETER_SET_ID);
> > 	WRITE_PPS(!!(pps->flags & V4L2_H264_PPS_FLAG_ENTROPY_CODING_MODE),
> > 		  ENTROPY_CODING_MODE_FLAG);
> > 	WRITE_PPS(!!(pps->flags & V4L2_H264_PPS_FLAG_BOTTOM_FIELD_PIC_ORDER_IN=
_FRAME_PRESENT),
> > --=20
> > 2.34.1
> >=20

