Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FBC5438AB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245303AbiFHQRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245301AbiFHQRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:17:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AAE4B421;
        Wed,  8 Jun 2022 09:17:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 327CD6183B;
        Wed,  8 Jun 2022 16:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39D8C34116;
        Wed,  8 Jun 2022 16:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654705029;
        bh=h2IyhMvbVxFctIhAi6hni9TmvDDM++uYJON5WLf5MaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WznJDM+7LMAOKoav+8bN+LzAQpofCOthUjlxEMlBN3VKK3hiSwJwAI1QcvGg6GRpk
         m+F4Fnqz8//CaomYv1+zMmfgUlqLEZYewUNEPZoOiW4k7dXgqq7v6jIgJnGzwq97mc
         penQHCrjnG53ujfEMGN9aSfFCpVwUL/UJbWFfHR6k7scbMRw0HyYpqAoUwfOHJHKFX
         8WkIs5fXNxJKX2YJOQqoFR/d/4o0iMf4oPq6e3CcKMgaV4cWOLbHR0RHTT+D1nN5QD
         vBT1P0LsIfyJRD21gjPoxF2lWstpbjIzUm5JCkGcloGKKDjXg4Ik0yZ/gAAN344a3S
         IVDAKL5MbdmrQ==
Date:   Wed, 8 Jun 2022 17:17:02 +0100
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
Message-ID: <YqDLflKTsYaupArl@sirena.org.uk>
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
 <20220607155324.118102-3-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AErNnAXCh3erohiz"
Content-Disposition: inline
In-Reply-To: <20220607155324.118102-3-aidanmacdonald.0x0@gmail.com>
X-Cookie: My NOSE is NUMB!
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AErNnAXCh3erohiz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 07, 2022 at 04:53:09PM +0100, Aidan MacDonald wrote:

> -	if (!chip->sub_reg_offsets || !chip->not_fixed_stride) {
> +	if (chip->get_irq_reg) {
> +		reg = chip->get_irq_reg(base_reg, i);
> +	} else if (!chip->sub_reg_offsets || !chip->not_fixed_stride) {

It seems like it would be cleaner and clearer to refactor things so that
we always have a get_irq_reg() with standard chips getting given a
default implementation which implements the current behaviour.

--AErNnAXCh3erohiz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKgy30ACgkQJNaLcl1U
h9D2LggAhh2vyqK62zKVg1txw1uk9BvjdGtNZuayo8ymlgu/wf9/DpigQx6vQd7t
E/BUEu07A6YSkWvaK/lkCg9dx3cYmU4qzesgWMwJw9IVOgfJvQOSBQY0jtGsiUUa
sqIxeL67xeWyESm0IMcFpuIG5xVowTVyeHrkW4XMPQo6vaLSRqDq4XNTHjUwOYZk
N312cuLTScImLhSwCfijmdRCcC8INBxS8PgVrnlBkHOtFrUN8Sm4iV1tXlH1cHlD
G5FzZPoe6SBdsuqTvTJfQBeTJmafw96/viByXtA+ZlhZKbsiBcVVWX2Heo5/qaaI
nahFe2tj7qLQWCqwRqOpLtihJsmX3w==
=kesQ
-----END PGP SIGNATURE-----

--AErNnAXCh3erohiz--
