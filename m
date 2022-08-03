Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F673589093
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 18:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbiHCQd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 12:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiHCQdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 12:33:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BECC4F;
        Wed,  3 Aug 2022 09:33:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05EBF6178B;
        Wed,  3 Aug 2022 16:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6D8C433C1;
        Wed,  3 Aug 2022 16:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659544433;
        bh=CuJl7K+ULUyNotBl4eCYknRBtYhjRyXh7WvZZzQXG5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ixtcecZlnHKBKnRVf8Sk04KI61vXJMfWWPuRqj9ap1kQ7u7YJ+c69PgkSmAaoOI7P
         7zMKJaczsO5MtqnlnKNrz5w1lt5X+ckj2fGdbFVNkR1B1El7nuvW0h/Ldma3VPMDrC
         hDETvFRV+EnhIYsEnaNGHwaPGqQ9RVxmmpiui3kpknQsdvqsEuRHzMJEEemBgQr/Le
         CqNK4U5yJo0Nji5Jw+Bi3shMLcQl/SpfH6ApRLgu5uwhRA6EGt9enSWhXI0x0+JVkK
         M9NLrzRVVw2sErpCytExvrl1LCSxlJLfCr8deDRGt9lAWkfc5NCv8v8Psu7iYTHV/B
         09nnbgONPxtow==
Date:   Wed, 3 Aug 2022 17:33:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: bitbang: Fix lsb-first Rx
Message-ID: <YuqjbFy3f0EtsokI@sirena.org.uk>
References: <28324d8622da80461cce35a82859b003d6f6c4b0.1659538737.git.robin.murphy@arm.com>
 <YuqOBYJSP8Pm7Bz5@sirena.org.uk>
 <ae7e7d7b-bf90-7f23-8a27-e6358b3ff4f6@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xEEbTT8in6DVr0bb"
Content-Disposition: inline
In-Reply-To: <ae7e7d7b-bf90-7f23-8a27-e6358b3ff4f6@arm.com>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xEEbTT8in6DVr0bb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 03, 2022 at 04:22:13PM +0100, Robin Murphy wrote:
> On 2022-08-03 16:02, Mark Brown wrote:

> > So if this never worked we presumably have some systems out there which
> > somehow rely on the old behaviour that we need to fix somehow - copying

> Hmm, I can't imagine anyone's relying too critically on data transfer
> corruption :/

Unless it happens to get corrupted into what is actually wanted - it
wouldn't be the first time I've seen driver code bodge around some issue
in the core.  Doesn't seem super likely here given the nature of the bug
but it's alway worth checking.

--xEEbTT8in6DVr0bb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLqo2sACgkQJNaLcl1U
h9CoNQf+LvbnLRz53t5D95A41XEOX2URzbQ95wICfR/VpAEwz0rqXoaOMeWNCrEK
hh9HwWdA7bNuOBMa/GQ9lBWYIvhS1ZqxrOfoCwGuMHGg2G/UmmHj9jpaSPfbJnd6
ZeB9lsDIJJXEkDNpqIsiN7cOjJkf8jwRYilNWtRDC0H4BcUwuaKtYjdWInouq0ol
+kfCsbq2V0sWYYGSkRvka6yfZPmulNSfvAdfpRWxiMPreOPZwaY3IfTQqJSmp6of
fycbiuoE63EVgvtJYjg1WhlVeqwip4MQW/6asNSbflX/gJU08ad4DueL/D8XyiUg
YR1tRYJkawI+HGJj2fQ3U7qzKiA10Q==
=uYU6
-----END PGP SIGNATURE-----

--xEEbTT8in6DVr0bb--
