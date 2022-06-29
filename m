Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3F955F97E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 09:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiF2HoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 03:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiF2HoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 03:44:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532132B187;
        Wed, 29 Jun 2022 00:44:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CC66B821E9;
        Wed, 29 Jun 2022 07:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB82EC3411E;
        Wed, 29 Jun 2022 07:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656488651;
        bh=6zi3Qj/QHuMf0hd2Y9nWbXp2LLhPD85M5emH9QGyf8c=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=jLkS4YIMQQ7uv66CPdCX/t1xKG3p83T20c3/VGGPwP/3spJFgino1L9GFUJUTNTgK
         CF+eq42Xwh3PGtUKvXvZrs8wM09MNHcQOEHBl/Ox3aXcfOnATJFLYd/4BVQVTYHmga
         eiyPV59JXruJ59xttSGmE72a8M9hfiXEIfL0IoXoSVhNqucxQlvqgupSkU9rG2NflR
         E6gwz1X81OSFIK8YvFmS5nb9J4WiXJNeAM/3NdytIojvD1SkhqtOPPQfiPCj8CICKM
         aiCJtv6jsc04s3fCfIYkmXzUpCv6l32BgprQIsiMjnVuxLSeUPdM31d3/nvb+Yu267
         ns0B5VZVUJfrw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220625130637.223180f2@jic23-huawei>
References: <20220625103853.2470346-1-marcus.folkesson@gmail.com> <20220625103853.2470346-4-marcus.folkesson@gmail.com> <20220625125652.2f988964@jic23-huawei> <20220625130637.223180f2@jic23-huawei>
Subject: Re: [PATCH v2 04/10] iio: adc: mcp3911: add support for interrupts
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Jonathan Cameron <jic23@kernel.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Date:   Wed, 29 Jun 2022 00:44:09 -0700
User-Agent: alot/0.10
Message-Id: <20220629074411.BB82EC3411E@smtp.kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Cameron (2022-06-25 05:06:37)
> > > @@ -362,6 +401,32 @@ static int mcp3911_probe(struct spi_device *spi)
> > > =20
> > >     mutex_init(&adc->lock);
> > > =20
> > > +   if (spi->irq > 0) {
> > > +           adc->trig =3D devm_iio_trigger_alloc(&spi->dev, "%s-dev%d=
",
> > > +                           indio_dev->name,
> > > +                           iio_device_id(indio_dev));
> > > +           if (!adc->trig)
> > > +                   goto clk_disable; =20
> > You definitely want to use devm managed cleanup for these.
> >=20
> > There is a patch set that adds these as standard functions, but I haven=
't
> > yet seen it being picked up for this cycle (reviews have been slow comi=
ng).
> >=20
> > https://lore.kernel.org/all/20220520075737.758761-1-u.kleine-koenig@pen=
gutronix.de/
>=20
> Ah, elsewhere in my unread email was a thread that says it's in clk-next =
so
> will be in the next merge window.  I haven't confirmed, but looks like St=
ephen
> put up an immutable branch so I could pull it into the IIO togreg branch =
if you
> want to transition directly to that new code. @Stephen, would you be fine
> with me pulling your clk-devm-enable branch into IIO (with the fix which
> got posted earlier in the week presumably also going on that branch when
> you push out?)

Yes that's fine. Thanks for the heads up.
