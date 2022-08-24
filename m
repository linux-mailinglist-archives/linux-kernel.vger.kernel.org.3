Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF4459FE62
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbiHXPbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239577AbiHXPa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:30:57 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B75A1901E
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:30:56 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id AAA2732009A3;
        Wed, 24 Aug 2022 11:30:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 24 Aug 2022 11:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1661355054; x=1661441454; bh=UWEjBSdwLo
        HCpeWHAdeX0Lnymfed3xOveR1DLx5HrYc=; b=ULHgHtn5NHKNfL2UkspRLKeOkb
        C3ZbnLl18NGByg2tqztaYDv0YsHYf9LV49igzKNItHRPBx+jJ3NejeWJK1Xe8JVb
        v2CAg6cL1qaKWTcKxIIqxralQgJq4BiaVoNH/gDZdlNSM0c7pcvGrXDOJsfKbsCF
        ivdwC24HfLpeAr5NKeywdXln+yGNOcwwOjs9n1rVpsgNS7IP9clUSwhU8br5tjxx
        uX/MGYhiel+05y9K9zuuEs4ad8DvUBpx+lovA2ix82IqLziS81vBworp/6RgTDFd
        p272BCeB63+q0x1/hTVG8u4TARUHy5lmNmkZWZBryTkc2N9YvO30HtdFQTJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1661355054; x=1661441454; bh=UWEjBSdwLoHCpeWHAdeX0Lnymfed
        3xOveR1DLx5HrYc=; b=VWzW6GMlx8eKa5TW1KStIfs0N4R5dOJlE/nh4T2hoFHI
        4QFQ23yX5ojZmgXtjuLBRfrilDTz6UuRW8eTOeMxwwswdYslzWcWnzBD7Ho2yhv1
        dM/pZEUQKLktdPVTj+s3SfhEo1NZuIs80seMCqTpjSOVVzkQJ69KW5i7UDwnyb2Q
        +z3As3q6RIVzAorbIYPsJ6bra+cIWPTAnqaCQYi/2N1hCIDN2jrQgJNEIxGae9MP
        K/XSI9dgKBAnJlPXONkU4ZJ42bT5NloSQ6yDEBRm1gcvQJj7yUiSFD8YgN20diQS
        dOppc/bQ/joy197h44yiip91Xjtxsr14w4Vvlts5rw==
X-ME-Sender: <xms:LUQGY_MRs5cssNyB3ytj7-9tMKpuf_8SbM_h8LrpWG7lyYIBZzwotg>
    <xme:LUQGY58SWQfFOlX3ipsFg9GfAwn7-bOhBE9AxTyu37qdeSQS_o4N1luTxXImUasYE
    fDmlJZ_jQYQTvq3nns>
X-ME-Received: <xmr:LUQGY-QfnCur25s8h30J1lIKR3V_o-OqJBpaf1N7Siizmfkc0WbygoOLg8Gx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejuddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejveefheefkeeiffegveelveetgffffeektdefuefhtedtgeejhefggedu
    ffffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:LUQGYzvYMzkv_wS3yvHVWv1_-LYHb0DZw1X41OwCeo2-1VE9sgHTUQ>
    <xmx:LUQGY3fX_6vLZg88v5LOWATwzGv8FYsPwgKHCfFQu7dQC8K1FcwWPg>
    <xmx:LUQGY_1DHmwst_u3iws3Zogo69eAWG-0lJv7Q5Dsz7tPNopLU6VRJQ>
    <xmx:LkQGY_1PcZ04syCJj8_5KZEpzwFGg-8JMX6VaESkmxIkD8dlMJpTFg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Aug 2022 11:30:53 -0400 (EDT)
Date:   Wed, 24 Aug 2022 17:30:51 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Charles Mirabile <cmirabil@redhat.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Serge Schneider <serge@raspberrypi.org>,
        Nicolas Saenz Julienne <nicolassaenzj@gmail.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        rh-kdlp@googlegroups.com, Joel Slebodnick <jslebodn@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH v10 0/6] Raspberry Pi Sense HAT driver
Message-ID: <20220824153051.bx6kfcih76kh3exc@houat>
References: <20220823174158.45579-1-cmirabil@redhat.com>
 <fc54a7a3-c67b-79ab-5e87-d468695e5553@i2se.com>
 <CABe3_aFJ0gkLDFB9k5FEn1SmupbLEKxAn8y=WTt-Rc0xUEK4Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qnkn4bktoy4h2gpu"
Content-Disposition: inline
In-Reply-To: <CABe3_aFJ0gkLDFB9k5FEn1SmupbLEKxAn8y=WTt-Rc0xUEK4Dw@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qnkn4bktoy4h2gpu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 24, 2022 at 08:06:59AM -0400, Charles Mirabile wrote:
> On Tue, Aug 23, 2022 at 5:30 PM Stefan Wahren <stefan.wahren@i2se.com> wr=
ote:
> > >    drivers/auxdisplay: sensehat: Raspberry Pi Sense HAT display driver
> > We don't have an Ack for this display driver. Maybe we should ask Maxime
> > Ripard and Noralf Tr=F8nnes especially Pavel Machek had concerns about =
the
> > right subsystem?
>
> I just looked back at the comments from Pavel on v9. I had meant to
> reply to him, and I actually drafted something but it got lost in the
> shuffle and I never sent it (also my bad).
>
> The driver is an fbdev in the raspberry pi tree, and that is where we
> started when upstreaming, but right from the outset we were told that
> it couldn't be an fbdev since that subsystem is being deprecated
> the replacement is the DRM subsystem

Indeed

> but (as Matthias Brugger suggests) that is probably overkill for an
> 8x8 display. Does that settle the subsystem question?

If you were aiming for an fbdev driver, a KMS driver these days would be
notably simpler.

We've added simpler and simpler devices, such as the SSD1306 recently,
so I can't see anything wrong with using KMS either.

Maxime

--qnkn4bktoy4h2gpu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYwZEKwAKCRDj7w1vZxhR
xeP5AP49OPG5mL6W0tELzpbzif+x+BpthcKKwThVhaPXEL3JcwD+PBhrC2xNONxU
yrmVGBo/7cUtnUmAjR/2f1Ih0jR0Kws=
=QqBo
-----END PGP SIGNATURE-----

--qnkn4bktoy4h2gpu--
