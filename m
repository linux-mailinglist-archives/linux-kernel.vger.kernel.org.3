Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B67153AB8E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 19:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356243AbiFARIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 13:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244187AbiFARII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 13:08:08 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418BC52524;
        Wed,  1 Jun 2022 10:08:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id BFCB01F44545
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654103285;
        bh=lDyn2UbNzkXVPb/r+aeas5dM5cMmLSiPAoFFx/mTR58=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hKGgtAuVB/nM+RjHwYL+SUADwNRxvkeD0OOE0Xkh3764zMjQ92J/2r2cDWOvtwLtA
         WT/s4wQRkJt96DwrP9M7yZYgRt4y71zelr1LfexyI+jRaI6gHdb0E1sTnrvEZABY5y
         21N9XIkghcREUOPPp8B5HQWamxjyZW6fwx4Umsf4j1J0onpoJ1kzyFEDRxc6qbeOc8
         BlN8zlc1nksMAVK0rAfAaXPyTaZbuz4d0lNd2+R1znGqe4JtrpIu1aq3nhnbGD9dyT
         IC+uoGmLlLBbxzAUP1c1gII+oYMo3SjMcZF4s2zHjYT63c+q0AHHdrIUoEWsdYj1Pc
         dO4VROiQlm04A==
Message-ID: <763308daa3304ef3cf011b4ca7b9c5c006627c90.camel@collabora.com>
Subject: Re: [PATCH v6 11/17] media: uapi: Add
 V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS control
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Jernej =?UTF-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        samuel@sholland.org, andrzej.p@collabora.com,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
Date:   Wed, 01 Jun 2022 13:07:54 -0400
In-Reply-To: <11988268.O9o76ZdvQC@jernej-laptop>
References: <20220527143134.3360174-1-benjamin.gaignard@collabora.com>
         <2102878.irdbgypaU6@kista>
         <95261aa18425e8f5571888a41ee03d9dfd2814b9.camel@collabora.com>
         <11988268.O9o76ZdvQC@jernej-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
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

Le mercredi 01 juin 2022 =C3=A0 18:35 +0200, Jernej =C5=A0krabec a =C3=A9cr=
it=C2=A0:
> > I believe its defined following "Table A.8 =E2=80=93 General tier and l=
evel limits".
> > With the assumption there will never be a level 7 (which I think is fai=
r).
> > If anyone saw other reasons for this limit, let me know.
> >=20
> > This is a worse case scenario, this is quite unlikely in practice, so w=
hile
> > performance might be a disaster if your craft a stream for that case, I
> > don't think it will ever happen in real life.
>=20
> But do we really need to cover worst case scenario? In theory, one driver=
 can=20
> set limit to (for example) max 100 slices and if there is a frame with 60=
0=20
> slices, userspace app would submit 6 decode requests. Basically the same =
way=20
> it's done today. While not as performant, it would be good compromise bet=
ween=20
> resources and speed.

The limit here is to prevent userland from tricking the kernel into doing v=
ery
big allocation. But with dynamic array, you'll allocate just the right amou=
nt.

Nicolas

