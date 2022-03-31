Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12454EDAB5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbiCaNmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbiCaNmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:42:17 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328321BD997;
        Thu, 31 Mar 2022 06:40:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id E26221F468C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648734029;
        bh=JMI9DF713E6Bedui+fXfewEWfQB3MYjowcqT1ROwzdk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IbswILxvo7LGIbjTS6A4Z+mCEy/8t0Es14/FObmIQ6gNSGCv74NdFU7OEtIanJIwk
         camY8wbfbpR6kRV8QHHlpAoBGxXfkbhMZGWzv9fWzfR+HCXuSc4Vt1ISlFcqgFk4TV
         xSX6vQI1PQo+TR/BjD1Fu8vGapdIRi3iJQhaRHvfTZAlAjkO5Vc0YlnNC+geZJMB09
         lMiDqcC5/iLHH9C25CTekZjlVTFf+HMCLEu5k+HJ2AUem9+8lxCc8XEQeUoYc/mEV8
         gS4t2aAMSN5ONp+v4KqzLp5EutpwgLW6IKmv94L/GYmfW3DlcNiMp31RSy3I5aui7o
         o/hvSz1iZPf8Q==
Message-ID: <ce1cbeab5e4a8a8338f2567f05af3226305410c7.camel@collabora.com>
Subject: Re: [PATCH v1 19/24] media: rkvdec-h264: Add field decoding support
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Thu, 31 Mar 2022 09:40:18 -0400
In-Reply-To: <20220330151658.GV12805@kadam>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
         <20220328195936.82552-20-nicolas.dufresne@collabora.com>
         <20220329081321.GV3293@kadam>
         <f7e5b577bc48ba16befbed47ac96c363ce861f48.camel@collabora.com>
         <20220330051541.GE3293@kadam>
         <ed16a4dcfb0859a284675ddad46ab536008a15c5.camel@collabora.com>
         <20220330151658.GV12805@kadam>
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

Le mercredi 30 mars 2022 =C3=A0 18:16 +0300, Dan Carpenter a =C3=A9crit=C2=
=A0:
> Yeah.  I'm aboslutely fine with whatever you do.  Some of the questions
> you're asking occurred to me too but I don't have the answers.
>=20
> > > > > > +		for (i =3D 0; i < builder->num_valid; i++) {
> > > > > > +			struct v4l2_h264_reference *ref;
> > > > > > +			u8 dpb_valid;
> > > > > > +			u8 bottom;
> > > > >=20
> > > > > These would be better as type bool.
> > > >=20
> > > > I never used a bool for bit operations before, but I guess that can=
 work, thanks
> > > > for the suggestion. As this deviates from the original code, I supp=
ose I should
> > > > make this a separate patch ?
> > >=20
> > > I just saw the name and wondered why it was a u8.  bool does make mor=
e
> > > sense and works fine for the bitwise stuff.  But I don't really care =
at
> > > all.
> >=20
> > I'll do that in v2, in same patch, looks minor enough. I think if using=
 bool
> > could guaranty that only 1 or 0 is  possible, it would be even better, =
but don't
> > think C works like this.
>=20
> I'm not sure I understand.  If you assign "bool x =3D <any non-zero>;"
> then x is set to true.  Do you want a static checker warning for if
> <any non-zero> can be something other than one or zero?  The problem is
> that people sometimes deliberately do stuff like "bool x =3D var & 0xf0;"=
.
> Smatch will complain if you assign a negative value to x.
>=20
> test.c:8 test() warn: assigning (-3) to unsigned variable 'x'
>=20
> It's supposed to print a warning if you used it to save error codes like:
>=20
> 	x =3D some_kernel_function();
>=20
> But it does not.  :/  Something to investigate.

That would be an amazing catch, you might have seen a lot of:

  x =3D !!(var & 0xf0)

For branches, it does no matter, but if you use x it like this dpb_valid
variable is used, not having 0 or 1 can lead to very surprising results. In=
 the
end its used like this

  set_reg(reg0, val | (x << N))

So using bool type can hint the analyzer that 0 or 1 was likely expected, w=
hile
currently an u8 would be ambiguous and lead to false positive if we were to
warn.

>=20
> regards,
> dan carpenter
>=20

