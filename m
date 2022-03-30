Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9324EC7DF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347898AbiC3PK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344931AbiC3PKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:10:54 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177D42626;
        Wed, 30 Mar 2022 08:09:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 9A5FA1F45009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648652946;
        bh=Aosf9iB98FFVsCqRLj8GCfiWN6JEp+BHf9h03wTbGIk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YEdcao7wVc60/I8iiFZkfK5uufA4e1CsJmD1gv6g6tMXS/FHE7+PgXex4f8nDkcxY
         4MM0HHbYOc+w0w9ga5u2cvx9lv2loTBden6mFEi+az0BWrzFI1FivbCQ8v7S4ourMW
         XgjUyg8kudAUZls+wdDSRtrf2oRnm9LjfX6IcL2L2rKc2G0TeJKfK9YrG/EbQmziCa
         sv3qplD09yb1czeXTEml6W/5L4dsCdo7/tLhL3cOQJ1nDOV8geXki2IgnaWlGkARJ0
         2La002wbVNT4kXOI/lTPSQOcFm7w22qMvXf8uEwUjeUArEBxHxTf8u8ji09gtT6+Ko
         0Fvp3ycIMdNNA==
Message-ID: <00437ee75b96b457e2d53322883580b011d6e8a8.camel@collabora.com>
Subject: Re: [PATCH v1 21/24] media: hantro: Stop using H.264 parameter
 pic_num
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Wed, 30 Mar 2022 11:08:55 -0400
In-Reply-To: <20220330074250.jqyljbr53fgeci6q@basti-XPS-13-9310>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
         <20220328195936.82552-22-nicolas.dufresne@collabora.com>
         <20220330074250.jqyljbr53fgeci6q@basti-XPS-13-9310>
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

Le mercredi 30 mars 2022 =C3=A0 09:42 +0200, Sebastian Fricke a =C3=A9crit=
=C2=A0:
> Hey Nicolas,
>=20
> The term pic_num is now only present in the following files:
> ```
> =E2=9D=AF rg 'pic_num'
> staging/media/rkvdec/rkvdec-h264.c
> 766:	 * Assign an invalid pic_num if DPB entry at that position is inacti=
ve.
> 768:	 * reference picture with pic_num 0, triggering output picture

I should probably translate this one, since the HW uses frame_num, not pic_=
num.

>=20
> media/platform/amphion/vpu_windsor.c
> 485:	u32 pic_num;

Amphion Windsor is a stateful driver, I cannot comment on the user of pic_n=
um
for that type of driver.

>=20
> media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
> 97:	unsigned short pic_num;
> 346:		dst_entry->pic_num =3D src_entry->pic_num;

This is being sent to the firmware, so its a difficult change to make witho=
ut
testing it first. I do have HW to test this, but would prefer doing so in a
seperate patchset. Note that MTK does not support field decoding, so pic_nu=
m =3D=3D
frame_num. So whatever it does here is likely correct.

>=20
> media/v4l2-core/v4l2-h264.c
> 143:	 * but with frame_num (wrapped). As for frame the pic_num and frame_=
num
> 306:		/* this is pic_num for frame and frame_num (wrapped) for field,
> 307:		 * but for frame pic_num is equal to frame_num (wrapped).
> ```
>=20
> In v4l2-h264 and rkvdec-h264 it is only present as comment and the term
> is not part of the specification.
> In vpu_windsor it is actually never used.
> And for the mediatek driver the same might apply.
> It might be worth it to get rid of that term all together while you are
> at it.

Amphion Windsor is a stateful driver, I'd leave it to the maintainer to cle=
anup
unused variables if there is. In general the term is not invalid, its just =
that
the value can be trivially deduced from frame_num and the value depends on =
the
current picture parity, which makes it an unstable identifier.

>=20
> On 28.03.2022 15:59, Nicolas Dufresne wrote:
> > The hardware expects FrameNumWrap or long_term_frame_idx. Picture
> > numbers are per field, and are mostly used during the memory
> > management process, which is done in userland. This fixes two
> > ITU conformance tests:
> >=20
> >  - MR6_BT_B
> >  - MR8_BT_B
> >=20
> > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
>=20
> Greetings,
> Sebastian
> > ---
> > drivers/staging/media/hantro/hantro_h264.c | 2 --
> > 1 file changed, 2 deletions(-)
> >=20
> > diff --git a/drivers/staging/media/hantro/hantro_h264.c b/drivers/stagi=
ng/media/hantro/hantro_h264.c
> > index 0b4d2491be3b..228629fb3cdf 100644
> > --- a/drivers/staging/media/hantro/hantro_h264.c
> > +++ b/drivers/staging/media/hantro/hantro_h264.c
> > @@ -354,8 +354,6 @@ u16 hantro_h264_get_ref_nbr(struct hantro_ctx *ctx,=
 unsigned int dpb_idx)
> >=20
> > 	if (!(dpb->flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE))
> > 		return 0;
> > -	if (dpb->flags & V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM)
> > -		return dpb->pic_num;
> > 	return dpb->frame_num;
> > }
> >=20
> > --=20
> > 2.34.1
> >=20

