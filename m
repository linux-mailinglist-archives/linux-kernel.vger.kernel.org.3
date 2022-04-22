Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722F150BB00
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449089AbiDVPB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449087AbiDVPBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:01:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428055C863;
        Fri, 22 Apr 2022 07:58:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 5174D1F469E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650639531;
        bh=cDXZe4OsLnfJb6uXnoVjoCNRGca1emiFVgfmuE+pviw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SvQbaqD7Ute1lFCnt+obs1Au6a2i/MxKRAsRuzBzr7U14D9twWL85dIN5AxLfqDTL
         9nyAqb4nbA4mqNZtPIvC03dAgaQAIybHq/14oKlLH2IfI7duv5YS+M7ze23bIp/JeU
         FP4McD4PKWIVc9YoGSoEQ0YzrmKMe9FkVAeUUWuSE8k8jKB8XP/0A5irthafm1f6aQ
         NVFs2GUGm0F22GMuBN7YZVRl8HsmlFhuquaYJ0ingHWNSD6uqg3jMJ4aG2MT8RILuq
         fJpz0NzAUzFtDyV6cc6I4aucGz0mDEFzdMB92dgCm9R5RS3+MAybVRl/h/O6pyA6JV
         f++oSyvU5FG6Q==
Message-ID: <04819e457ee0135e5d0b337dccfaba69b2d46610.camel@collabora.com>
Subject: Re: [PATCH v3 09/24] media: v4l2: Trace calculated p/b0/b1 initial
 reflist
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org
Date:   Fri, 22 Apr 2022 10:58:39 -0400
In-Reply-To: <d7451087-45f1-9691-2289-999eb16ca8a0@xs4all.nl>
References: <20220405204426.259074-1-nicolas.dufresne@collabora.com>
         <20220405204426.259074-10-nicolas.dufresne@collabora.com>
         <d7451087-45f1-9691-2289-999eb16ca8a0@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 22 avril 2022 =C3=A0 09:26 +0200, Hans Verkuil a =C3=A9crit=C2=
=A0:
> On 05/04/2022 22:44, Nicolas Dufresne wrote:
> > Add debug print statements to print the content of P & B reference
> > lists, to verify that the ordering of the generated reference lists is
> > correct. This is especially important for the field decoding mode,
> > where sorting is more complex.
> >=20
> > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > Tested-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> > Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> > ---
> >  drivers/media/v4l2-core/v4l2-h264.c | 86 +++++++++++++++++++++++++++++
> >  1 file changed, 86 insertions(+)
> >=20
> > diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-c=
ore/v4l2-h264.c
> > index 38d8dbda0045..bcf9b7774560 100644
> > --- a/drivers/media/v4l2-core/v4l2-h264.c
> > +++ b/drivers/media/v4l2-core/v4l2-h264.c
> > @@ -241,6 +241,87 @@ static int v4l2_h264_b1_ref_list_cmp(const void *p=
tra, const void *ptrb,
> >  	return poca < pocb ? -1 : 1;
> >  }
> > =20
> > +static char ref_type_to_char (u8 ref_type)
>=20
> Spurious space before (.
>=20
> Odd that checkpatch didn't catch that.
>=20
> > +{
> > +	switch (ref_type) {
> > +	case V4L2_H264_FRAME_REF:
> > +		return 'f';
> > +	case V4L2_H264_TOP_FIELD_REF:
> > +		return 't';
> > +	case V4L2_H264_BOTTOM_FIELD_REF:
> > +		return 'b';
> > +	}
> > +
> > +	return '?';
> > +}
> > +
> > +static const char *format_ref_list_p(const struct v4l2_h264_reflist_bu=
ilder *builder,
> > +				     struct v4l2_h264_reference *reflist,
> > +				     char *out_str, const int len)
> > +{
> > +	int n =3D 0, i;
> > +
> > +	n +=3D snprintf(out_str + n, len - n, "|");
> > +
> > +	for (i =3D 0; i < builder->num_valid; i++) {
> > +		/* this is pic_num for frame and frame_num (wrapped) for field,
> > +		 * but for frame pic_num is equal to frame_num (wrapped).
> > +		 */
> > +		int frame_num =3D builder->refs[reflist[i].index].frame_num;
> > +		bool longterm =3D builder->refs[reflist[i].index].longterm;
> > +
> > +		n +=3D scnprintf(out_str + n, len - n, "%i%c%c|",
> > +			       frame_num, longterm ? 'l' : 's',
> > +			       ref_type_to_char (reflist[i].fields));
> > +	}
> > +
> > +	return out_str;
> > +}
> > +
> > +static void print_ref_list_p(const struct v4l2_h264_reflist_builder *b=
uilder,
> > +			     struct v4l2_h264_reference *reflist)
> > +{
> > +	char buf[1024];
> > +
> > +	pr_debug("ref_pic_list_p (cur_poc %u%c) %s\n",
> > +		 builder->cur_pic_order_count,
> > +		 ref_type_to_char(builder->cur_pic_fields),
> > +		 format_ref_list_p(builder, reflist, buf, sizeof(buf)));
> > +}
> > +
> > +static const char *format_ref_list_b(const struct v4l2_h264_reflist_bu=
ilder *builder,
> > +				     struct v4l2_h264_reference *reflist,
> > +				     char *out_str, const int len)
> > +{
> > +	int n =3D 0, i;
> > +
> > +	n +=3D snprintf(out_str + n, len - n, "|");
> > +
> > +	for (i =3D 0; i < builder->num_valid; i++) {
> > +		int frame_num =3D builder->refs[reflist[i].index].frame_num;
> > +		u32 poc =3D v4l2_h264_get_poc(builder, reflist + i);
> > +		bool longterm =3D builder->refs[reflist[i].index].longterm;
> > +
> > +		n +=3D scnprintf(out_str + n, len - n, "%i%c%c|",
> > +			       longterm ? frame_num : poc,
> > +			       longterm ? 'l' : 's',
> > +			       ref_type_to_char(reflist[i].fields));
> > +	}
> > +
> > +	return out_str;
> > +}
> > +
> > +static void print_ref_list_b(const struct v4l2_h264_reflist_builder *b=
uilder,
> > +			     struct v4l2_h264_reference *reflist, u8 list_num)
> > +{
> > +	char buf[1024];
>=20
> I really don't like placing 1024 bytes on the stack. Can you find another=
 way
> of doing this? Perhaps using pr_cont or writing each format_ref_list item
> on a separate line.

Thanks, I was strongly discourage of using pr_cont (which was my first
approach). Rationales are well covered on LKLM and in the pr_cont documenta=
tion,
so I won't say more then its not visually thread safe.

I would like to decline the second proposition, as having the lists spread =
out
on up to 32 lines will make the trace very hard to use. What I may suggest,=
 as I
would really prefer keeping this trace useful, is to use an allocation inst=
ead.
The performance does not matter, and I explicitly call this function inside=
 the
pr_debug call so it can be compiled out.

My last resort otherwise would be to use 32 %s formaters, and pass each of =
the
possible 32 entry (or empty string "") manually.

let me know what you believe is acceptable for you,
Nicolas

>=20
> Regards,
>=20
> 	Hans
>=20
> > +
> > +	pr_debug("ref_pic_list_b%u (cur_poc %u%c) %s",
> > +		 list_num, builder->cur_pic_order_count,
> > +		 ref_type_to_char (builder->cur_pic_fields),
> > +		 format_ref_list_b(builder, reflist, buf, sizeof(buf)));
> > +}
> > +
> >  /**
> >   * v4l2_h264_build_p_ref_list() - Build the P reference list
> >   *
> > @@ -261,6 +342,8 @@ v4l2_h264_build_p_ref_list(const struct v4l2_h264_r=
eflist_builder *builder,
> >  	       sizeof(builder->unordered_reflist[0]) * builder->num_valid);
> >  	sort_r(reflist, builder->num_valid, sizeof(*reflist),
> >  	       v4l2_h264_p_ref_list_cmp, NULL, builder);
> > +
> > +	print_ref_list_p(builder, reflist);
> >  }
> >  EXPORT_SYMBOL_GPL(v4l2_h264_build_p_ref_list);
> > =20
> > @@ -296,6 +379,9 @@ v4l2_h264_build_b_ref_lists(const struct v4l2_h264_=
reflist_builder *builder,
> >  	if (builder->num_valid > 1 &&
> >  	    !memcmp(b1_reflist, b0_reflist, builder->num_valid))
> >  		swap(b1_reflist[0], b1_reflist[1]);
> > +
> > +	print_ref_list_b(builder, b0_reflist, 0);
> > +	print_ref_list_b(builder, b1_reflist, 1);
> >  }
> >  EXPORT_SYMBOL_GPL(v4l2_h264_build_b_ref_lists);
> > =20
>=20

