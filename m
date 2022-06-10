Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49655546AC6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 18:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349369AbiFJQrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 12:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiFJQrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:47:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9DC5AA61;
        Fri, 10 Jun 2022 09:47:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41CF76209C;
        Fri, 10 Jun 2022 16:47:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA460C34114;
        Fri, 10 Jun 2022 16:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654879632;
        bh=unW26iVyYOILA6DuPNhMgkqz6zXnh/Dl4Z1P604q0XE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bI+jfQHqCN+w9/Ncpm9bvQdUzee34qzXjHDa2uywgpRCIPWxDvsPRkMd0meCY2srw
         ND7sExB1ciAap5ao9d4ObQk9k7DR/hSgmm29gA8DzwxH/bWW5s3dlU5kiX/Dx9S7/K
         VqJyZy2+GbnL9dBc3MlAU96zKaVlN7JIeF+X5lTy6NjLbj9UGDeycEEFBRkfynC8CN
         HoMT49tsk1Yjg8umLhbLIlLu7h02qM2/frdHi5mZv3ZK56ELOdLuB3arBYVnEU+NXX
         gKbAkHssmNXSL0Dz6vHjDhExTFyX9Vid7B8/c+KsFMs0ahtf4jEHOkRuzbUiKRmGK5
         rxf+aERRcPU1g==
Date:   Fri, 10 Jun 2022 17:47:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, gregkh@linuxfoundation.org,
        lgirdwood@gmail.com, lars@metafoo.de, rafael@kernel.org,
        quic_gurus@quicinc.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 02/17] regmap-irq: Add get_irq_reg to support unusual
 register layouts
Message-ID: <YqN1iTyyiRx4/CMf@sirena.org.uk>
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
 <20220607155324.118102-3-aidanmacdonald.0x0@gmail.com>
 <YqDLflKTsYaupArl@sirena.org.uk>
 <6YJcC5wyOg6x6Ny4Os8ujFbK2qB4alkU@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U+ynXLAMuojBXMSJ"
Content-Disposition: inline
In-Reply-To: <6YJcC5wyOg6x6Ny4Os8ujFbK2qB4alkU@localhost>
X-Cookie: Teachers have class.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U+ynXLAMuojBXMSJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 10, 2022 at 04:40:20PM +0100, Aidan MacDonald wrote:
> Mark Brown <broonie@kernel.org> writes:
> > On Tue, Jun 07, 2022 at 04:53:09PM +0100, Aidan MacDonald wrote:

> >> -	if (!chip->sub_reg_offsets || !chip->not_fixed_stride) {
> >> +	if (chip->get_irq_reg) {
> >> +		reg = chip->get_irq_reg(base_reg, i);
> >> +	} else if (!chip->sub_reg_offsets || !chip->not_fixed_stride) {

> > It seems like it would be cleaner and clearer to refactor things so that
> > we always have a get_irq_reg() with standard chips getting given a
> > default implementation which implements the current behaviour.

> I don't think that is a good way to clean things up. I only intended
> get_irq_reg() to be a quick hack to solve a problem; in my opinion it
> would be a poor abstraction to base the API around.

I'm not sure why you are proposing this change if you are so convinced
it's a bad idea.  If you want to propose a different rework go ahead,
but adding the new operation without any form of factoring out is an
issue.  At first glance your suggestion looked plausible.

--U+ynXLAMuojBXMSJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKjdYgACgkQJNaLcl1U
h9CDtwf/clBKHc7KCJ2ljj8ni+Y5o/BMRY1SoDObFay/XE+ilxSWGfKX6EgfFiWz
827Zd2fpD+hDEiUTcOZeovGH6TavbS9+6H4PscGRcTC3wYqGFFbUj+LDCt25t+Pc
+dkx10P5yUA6EsSQ40HwGVREKokYmbZ4+MxOXK3nu5p8KRGuKtTcMq2VgnhbR0ub
OIZL3uofaMioD/SuPX8ILI/T1DH71iIP192txH7nF3W0b2Cv7i17xq6um1i9JH5X
W4mmtDYS7aYF6K96WzV5knlILV88uFyKSPzH3PMS4eXHeR/MqM5/hcluVTZ1Yvo6
e3yquuxp8XZltPBuU3QID4j9daKkHw==
=Rx1o
-----END PGP SIGNATURE-----

--U+ynXLAMuojBXMSJ--
