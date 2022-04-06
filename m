Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC8D4F6B36
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiDFUVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbiDFUVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:21:09 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B3C515AF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 10:50:05 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id s7so5664821qtk.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 10:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=nbgYNk5Esw76+oSTzku5Iq0RBseYj50R251OC+s1Zko=;
        b=oE77XjhZJdBZs73vBmWDSWOcpU+0g2TAF7dqKJsm0FrsMjk1RH5VR1BlQ5zyc+Ew0E
         YAyZ7/3GSXX52HLi4w0ZLcWVx8WEfp2H70UxOLZhb4x9Tw8uCMDrbM5d5FHn6SM8+gwO
         oJK9Mz7nWH9ol3Rrrfkwe3OikbspOO3ypvUVHlstZXQHmen/ZBRY15meUrtAA7c3OsiH
         QTmrE/4Q7sxCk3fFXjAd0HZnALSONcplj2n9nhPVNVpiCO2IvqkTQM6QBRqJh5D4ZlDw
         eJ5RkVM+Vz9/V7oOKSfMoNmKqTRPPtOn7EnIojoHf3XYwhNUGCPXlmEsvVhrbnUTWod8
         nu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=nbgYNk5Esw76+oSTzku5Iq0RBseYj50R251OC+s1Zko=;
        b=QRgHKWEq1yqW8eMDbFB3qkJUMKka9cXxNLtOnx84NBcNhgBUfnp+0pLaiDyVZPnSwf
         sgUiUBWUHYhsulEVT9IV/Q2mBI23JFotUy8ucYAH4n5yFv3Y3NBdXEAMfJtHLwEp0IOf
         SFsabpSHSEy7WL+DpgckS7Pjhrd2LiLM9yMYZXmRctxSg0syfp5KEodDq00fTGhDcgGL
         jeJwnljjjcUZZ3ewozavn+KLFOmAbMPmp0SaDOfg70NWBS1DMB9a46zn3QOefcxxyuhP
         5ITvRI9wwJz/jsY4UknN5HbL9EHUJVsRGct81NBbm/iwbrR/k5AB48x/LV/UoefLwWA6
         3ngg==
X-Gm-Message-State: AOAM530nfwGKwxoD5OMn2xvzBiRmMZcRK6brqK7usRSHIHcED5DoirD8
        a3LBYPwnomgaF9w3Sp4ACrCGGg==
X-Google-Smtp-Source: ABdhPJylSRQCASHDcc/QNJp7o7BwkgXxThlNUItggDkKtsHMdcE9vZQxW5pxT61gwxRLUSzl83zB0g==
X-Received: by 2002:ac8:5a8f:0:b0:2e1:df21:d86f with SMTP id c15-20020ac85a8f000000b002e1df21d86fmr8769717qtc.450.1649267404445;
        Wed, 06 Apr 2022 10:50:04 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id 78-20020a370551000000b0067e3a58c090sm10057930qkf.82.2022.04.06.10.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 10:50:04 -0700 (PDT)
Message-ID: <fd9917c2bdb41f361a1ecac2dfa8d85473c9f0f2.camel@ndufresne.ca>
Subject: Re: [RFC PATCH 0/8] media: hantro: Add 10-bit support
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Jernej =?UTF-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        gregkh@linuxfoundation.org, wens@csie.org, samuel@sholland.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Date:   Wed, 06 Apr 2022 13:50:02 -0400
In-Reply-To: <2820101.e9J7NaK4W3@jernej-laptop>
References: <20220227144926.3006585-1-jernej.skrabec@gmail.com>
         <4386971.LvFx2qVVIh@jernej-laptop>
         <bf938b83-2b57-95b3-4bcb-f967bbb46413@collabora.com>
         <2820101.e9J7NaK4W3@jernej-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 06 avril 2022 =C3=A0 19:21 +0200, Jernej =C5=A0krabec a =C3=A9c=
rit=C2=A0:
> Dne sreda, 06. april 2022 ob 08:54:07 CEST je Benjamin Gaignard napisal(a=
):
> > Le 05/04/2022 =C3=A0 20:40, Jernej =C5=A0krabec a =C3=A9crit :
> > > Hi Benjamin!
> > >=20
> > > Dne torek, 05. april 2022 ob 18:07:41 CEST je Benjamin Gaignard=20
> napisal(a):
> > > > Le 27/02/2022 =C3=A0 15:49, Jernej Skrabec a =C3=A9crit :
> > > > > First two patches add 10-bit formats to UAPI, third extends filte=
ring
> > > > > mechanism, fourth fixes incorrect assumption, fifth moves registe=
r
> > > > > configuration code to proper place, sixth and seventh enable 10-b=
it
> > > > > VP9 decoding on Allwinner H6 and last increases core frequency on
> > > > > Allwinner H6.
> > > > >=20
> > > > > I'm sending this as RFC to get some comments:
> > > > > 1. format definitions - are fourcc's ok? are comments/description=
s ok?
> > > > > 2. is extended filtering mechanism ok?
> > > > >=20
> > > > > I would also like if these patches are tested on some more HW.
> > > > > Additionally, can someone test tiled P010?
> > > > >=20
> > > > > Please take a look.
> > > >=20
> > > > Hi Jernej,
> > > >=20
> > > > I have create a branch to test this series with VP9 and HEVC:
> > > > https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/tree/=
10bit_
> > > > imx 8m Feel free to pick what I may need in it.
> > > >=20
> > > > That doesn't improve fluster scores, I think more dev are still nee=
ded in
> > > > GST before getting something fully functional.
> > > > Anyway I able to select P010 pixel format if the input is a 10bit
> > > > bitstream.>=20
> > > What kind of improvements do you expect? Actually, this series is des=
igned
> > > to change nothing for platforms, where 10-bit format is not added int=
o
> > > the list of supported formats. I think reasons are quite obvious. Fir=
st,
> > > not every device may support 10-bit output. Second, as you might alre=
ady
> > > figured it out, registers in this series are set only for legacy core=
s. I
> > > have no idea, what needs to be done for newer ones, since I don't hav=
e
> > > them. Anyway, I tested this with fluster and only one additional test
> > > passes, because it is the only one for 10-bit YUV420.
> >=20
> > In this series you will find that I have added the registers for the ne=
w
> > cores, fix hevc to be able to use 10-bit, and enable that in IMX8M.
>=20
> Your changes seems reasonable, but at this point I wouldn't bother with=
=20
> fluster. Instead, try to test with one specific bitstream or even a sampl=
e video=20
> file. I just tested with one random 10-bit VP9 video that I found when wo=
rking=20
> on this series. That way you avoid any corner cases which sometimes plaqu=
e=20
> fluster testing (reference bitstreams smaller than min. supported size).=
=20
> Anyway, re-check vendor lib if there is any other place to adjust somethi=
ng=20
> for 10-bit.

Just so we don't forget, there is a handful of 10bit tests that Daniel Alme=
ida
omitted when he added tests to fluster (though only 1 is 420). I will try a=
nd
fix that later on. There is otherwise 5G worth of 10bit tests available. In
fluster we decided to go for the same subset libvpx uses, otherwise no one =
would
ever want to download these tests.

https://storage.googleapis.com/downloads.webmproject.org/vp9/decoder-test-s=
treams/Profile_2_10bit.

About the "min supported", G2 VP9 scores is 157/303 here (in comparision rk=
vdec
is 225, and MTK VCODEC 275). At this failure level this has no longer anyth=
ing
to do with the size of the render. There is likely couple of bugs hidden in=
 the
driver for the corner cases tested by the suite. Also, to illustrate that t=
he
size isn't the only variable in the failures, we have a vp90-2-02-size-
64x34.webm that pass (the driver pretends that 64x64 is the minimum). I did=
n't
look at G2 output very closely, but on RKVDEC, in similar failures we have
perfect keyframe, and a single corrupted tile on the following decode. My b=
elief
is that there is bugs in the drivers to be found and fixed. In absence of v=
endor
support, or working reference it will be difficult / near impossible to fix=
, but
I'm documenting this so we stop thinking this is just "not supported".

cheers,
Nicolas
