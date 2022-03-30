Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5174EC5CF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346183AbiC3Nls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243595AbiC3Nlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:41:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E091EC49;
        Wed, 30 Mar 2022 06:39:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id A95011F44B1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648647597;
        bh=/nr41sQ73zO79g7UhTaH3UMxIMdg1ZngRWwuuw4My44=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Yxv8JWsjqd4Uj9CKTFfRdpuyYFfepOvhF8yKGn7sRP0N4PXMeoloJSJRLxYeJCCyX
         VydoV7PTNihglFY9bergPRGJghtv0uJjlpehTTjjMMFtpx3Uf6RQpLSC+7o7jPRtJV
         sT/eKnoQcXn0aKldhGSRiq7n1kZRsnVYsSU9Af1Jj3Ty1Y86MWU5sAKl+vIXKPIJln
         41C8G5rOMe1tnw+uVbluwHd+/HSDVDSVGMTmgew1ifVIILQ4lsws1EwSoftNq3YJMp
         Ap2XL1c43OYhj5QYRhwzS/lUDxEe3WnkXIo+mNfB0MrGRNVeIcHlWV1gdVugWZjvss
         svirAa1IlVdxg==
Message-ID: <ed16a4dcfb0859a284675ddad46ab536008a15c5.camel@collabora.com>
Subject: Re: [PATCH v1 19/24] media: rkvdec-h264: Add field decoding support
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Wed, 30 Mar 2022 09:39:44 -0400
In-Reply-To: <20220330051541.GE3293@kadam>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
         <20220328195936.82552-20-nicolas.dufresne@collabora.com>
         <20220329081321.GV3293@kadam>
         <f7e5b577bc48ba16befbed47ac96c363ce861f48.camel@collabora.com>
         <20220330051541.GE3293@kadam>
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

Le mercredi 30 mars 2022 =C3=A0 08:15 +0300, Dan Carpenter a =C3=A9crit=C2=
=A0:
> On Tue, Mar 29, 2022 at 04:54:55PM -0400, Nicolas Dufresne wrote:
> > Le mardi 29 mars 2022 =C3=A0 11:13 +0300, Dan Carpenter a =C3=A9crit=C2=
=A0:
> > > On Mon, Mar 28, 2022 at 03:59:31PM -0400, Nicolas Dufresne wrote:
> > > > @@ -738,23 +735,26 @@ static void lookup_ref_buf_idx(struct rkvdec_=
ctx *ctx,
> > > >  		struct vb2_queue *cap_q =3D &m2m_ctx->cap_q_ctx.q;
> > > >  		int buf_idx =3D -1;
> > > > =20
> > > > -		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)
> > > > +		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE) {
> > > >  			buf_idx =3D vb2_find_timestamp(cap_q,
> > > >  						     dpb[i].reference_ts, 0);
> > > > +			if (buf_idx < 0)
> > > > +				pr_debug("No buffer for reference_ts %llu",
> > > > +					 dpb[i].reference_ts);
> > >=20
> > > pr_debug() is too quiet.  Make it pr_err().  Set buf_idx to zero inst=
ead
> > > leaving it as an error code.
> >=20
> > Thanks for the suggestion, I'm just a bit uncomfortable using pr_err() =
for
> > something that is not a driver error, but userland error. Perhaps you c=
an
> > educate me on the policy in this regard, but malicous userland being ab=
le to
> > flood the logs very easily is my main concern here.
> >=20
> > About the negative idx, it is being used set dpb_valid later on. H.264 =
error
> > resilience requires that these frames should be marked as "unexisting" =
but still
> > occupy space in the DPB, this is more or less what I'm trying to implem=
ent here.
> > Setting it to 0 would basically mean to refer to DPB index 0, which is
> > relatively random pick. I believe your suggestion is not taking into
> > consideration what the code is doing, but it would fall in some poor-ma=
n
> > concealment which I would rather leave to the userland.
> >=20
>=20
> To be honest, I just saw that it was a negative idx and freaked out.  I
> didn't look at any context...
>=20
> You're right that we don't to allow the user to spam the dmesg.  Ideally
> we would return an error.  A second best solution is to do a pr_err_once(=
).

There is two schools in the context of video stream decoding. I'm not sayin=
g
this driver is quite there in term of visual corruption reporting, this is
something I expect we'll improve in the long term. But here's the two schoo=
ls:

- Freeze on the last non-corrupted image (Apple style)
- Display slightly distorted image with movement (the rest of the world)

In order to give users that choice, I must try decoding as much as I can
regardless if there is a missing a reference or not. That wasn't the goal i=
n
this MR, but in the long run we'll remember this and mark the buffer as
corrupted (using the ERROR but setting a payload size to the picture size).=
 This
leaves the users the option to drop or to keep the visually corrupted image=
. In
video streaming, corrupted stream could look relatively fine, this cannot b=
e
judge noticing 1 reference frame missing (it could be referenced in only 1
macro-block).

Educational bit behind, I think we should keep going and not "error out". A=
lso,
for debugging purpose, it is nicer if we can get a complete report of non-m=
emory
backed references. As a missing reference in 1 frame, may have implication =
in
later frame, or may cause other frames to be missed.

One thing I was thinking though, is that through using raw pr_debug() I'm n=
ot
giving much context to my trace, so it would be hard to associate it with t=
he
driver instance (m2m are multi-instance) it was running against. But I didn=
't
want to add a new tracing wrapper for that driver in this patchset as it wa=
s
already relatively large patchset. Though, these traces have been previous =
to
make the driver work (as long as you test with a single instance).

If its all right with everyone, I'd leave it like this for this round, we c=
an
dedicated a patchset on improve this driver tracing in the future.

>=20
> > > >  	for (j =3D 0; j < RKVDEC_NUM_REFLIST; j++) {
> > > > -		for (i =3D 0; i < h264_ctx->reflists.num_valid; i++) {
> > > > -			u8 dpb_valid =3D run->ref_buf_idx[i] >=3D 0;
> > > > -			u8 idx =3D 0;
> > > > +		for (i =3D 0; i < builder->num_valid; i++) {
> > > > +			struct v4l2_h264_reference *ref;
> > > > +			u8 dpb_valid;
> > > > +			u8 bottom;
> > >=20
> > > These would be better as type bool.
> >=20
> > I never used a bool for bit operations before, but I guess that can wor=
k, thanks
> > for the suggestion. As this deviates from the original code, I suppose =
I should
> > make this a separate patch ?
>=20
> I just saw the name and wondered why it was a u8.  bool does make more
> sense and works fine for the bitwise stuff.  But I don't really care at
> all.

I'll do that in v2, in same patch, looks minor enough. I think if using boo=
l
could guaranty that only 1 or 0 is  possible, it would be even better, but =
don't
think C works like this.

Thanks again for your comments.

>=20
> regards,
> dan carpenter
>=20

