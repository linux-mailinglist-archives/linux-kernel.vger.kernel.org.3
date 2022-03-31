Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83B34EDED1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 18:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239959AbiCaQaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 12:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbiCaQao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:30:44 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A383F15E8A6;
        Thu, 31 Mar 2022 09:28:56 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 6EEDF1F46FA4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648744135;
        bh=9kOol/pk8ITM0N6OoVh7frX+PTCftgS26qbZZUBc6BM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jw953xdZhMbAkbZPH6IqmynwoD7Eu2P0zbuD6vaBoXby+hJQWepQZXJLcmaFAWGrC
         iSbeNcH5m1VND0+q4p5lDJVXRBG6CILyc/Jx+niFK5wasHXCcTD7VjzITY1ORQrobK
         GN7J+NFezIAFbGf66sexgwcJGz5eVKpCb0vL0j7OPdZ4khBkXUcHF5/qOVBusOB1qb
         6EI6+WAeXZ7kLVhZbmRfAf5JMY6stxCXd3qBSrvRPIl4vV5PoCI7By9Wb25rW4V6PP
         F51UB6xPwPT/UMRa0ItGtCJKp+tvoxtY9Xx/PDurMLMlWD9k5Kat5Z4SQPXs3cvMBO
         oDt+FzQjhjjww==
Message-ID: <14e0615df2e1f6ccb178558b16b13f0ccdc782f5.camel@collabora.com>
Subject: Re: [PATCH v1 03/24] media: h264: Avoid wrapping long_term_frame_idx
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>, kernel@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 31 Mar 2022 12:28:44 -0400
In-Reply-To: <20220329083549.2msls7obppsspvgk@basti-XPS-13-9310>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
         <20220328195936.82552-4-nicolas.dufresne@collabora.com>
         <20220329083549.2msls7obppsspvgk@basti-XPS-13-9310>
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

Le mardi 29 mars 2022 =C3=A0 10:35 +0200, Sebastian Fricke a =C3=A9crit=C2=
=A0:
> On 28.03.2022 15:59, Nicolas Dufresne wrote:
> > For long term reference, frame_num is set to long_term_frame_idx which
>=20
> s/reference/references/
>=20
> > does not require wrapping. This if fixed by observation, no directly
>=20
> s/This if/This is/
>=20
> > related issue have been found yet.
> >=20
> > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
>=20
> > ---
> > drivers/media/v4l2-core/v4l2-h264.c | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-c=
ore/v4l2-h264.c
> > index 8d750ee69e74..aebed1cbe05a 100644
> > --- a/drivers/media/v4l2-core/v4l2-h264.c
> > +++ b/drivers/media/v4l2-core/v4l2-h264.c
> > @@ -57,8 +57,10 @@ v4l2_h264_init_reflist_builder(struct v4l2_h264_refl=
ist_builder *b,
> > 		 * '8.2.4.1 Decoding process for picture numbers' of the spec.
> > 		 * TODO: This logic will have to be adjusted when we start
> > 		 * supporting interlaced content.
>=20
> As you change the logic can't you remove the TODO comment now?

Not yet, as I'm not fixing it here. Its removed in:

[PATCH v1 05/24] media: h264: Store all fields into the unordered list

>=20
> > +		 * For long term reference, frame_num is set to
>=20
> s/reference/references/
>=20
> Greetings,
> Sebastian
>=20
> > +		 * long_term_frame_idx which requires no wrapping.
> > 		 */
> > -		if (dpb[i].frame_num > cur_frame_num)
> > +		if (!b->refs[i].longterm && dpb[i].frame_num > cur_frame_num)
> > 			b->refs[i].frame_num =3D (int)dpb[i].frame_num -
> > 					       max_frame_num;
> > 		else
> > --=20
> > 2.34.1
> >=20

