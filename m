Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1638B4A7774
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 19:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346449AbiBBSEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 13:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346425AbiBBSEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 13:04:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4FDC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 10:04:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F9FA61804
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 18:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F55C004E1;
        Wed,  2 Feb 2022 18:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643825080;
        bh=YseebR6ddjhKcx6iHU+3IYV3X/EAv2nfCEUhSRsuCxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=amJbffqB6DQ6l1wg754Byfm4s9afEFFHFwm9qA5XXFPIJX8p8mAibwM8fqrhK/M/+
         fASKMIi7xIuon5R7woWw73mVQ1asINR+fw5GE9AM1+M0YWdwvw62TZ+EZ2xdea+cAB
         uM6dLRapNSCtly7TngU8MBV/SKQoGV92UMhN5OoPKCZZDtXHBQXBKijVPBL3yYAz6l
         HDE/ty+p9tFkm50j0vtsjkTw+thZw+rKg+b2COJ+TNH//wZVDSwc4w+42wg2oUQEXe
         w+gq8lZOqkLBXDgviDogz0gvPPB+l0bdSwMAfpsqj2V7Y/3dtywyWKK68IvEgG13ku
         Ic1dczpbcGXiQ==
Date:   Wed, 2 Feb 2022 18:04:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [mtd:spi-mem-ecc 30/30] ld.lld: error: undefined symbol:
 nand_ecc_unregister_on_host_hw_engine
Message-ID: <YfrHs81VGzUggPC6@sirena.org.uk>
References: <202202011308.a6RlPiGp-lkp@intel.com>
 <20220202154504.7737deed@xps13>
 <YfqhJZ+BzfMrpN4Y@sirena.org.uk>
 <20220202163452.746d50ca@xps13>
 <YfquJwtbg/hF5WJF@sirena.org.uk>
 <20220202183500.7e4ef7cb@xps13>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7y4DHJEdfFNfRgCM"
Content-Disposition: inline
In-Reply-To: <20220202183500.7e4ef7cb@xps13>
X-Cookie: Quack!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7y4DHJEdfFNfRgCM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 02, 2022 at 06:35:00PM +0100, Miquel Raynal wrote:

> > depends on MTD=y if SPI_MXC=y

> In this case I believe we should also add

> depends on MTD=m if SPI_MXC=m ?

It doesn't specifically need MTD to be a module so just a straight
dependency should be fine I guess.

> Anyway, this would force building the ECC support (and MTD...) even
> though we don't need it in most cases.

> My idea was to give people the right to only select SPI_MXIC without
> really caring about MTD/ECC support at all because this is IMHO a
> valid use case. We would then save a few kiB of extra MTD fat.

Is that something that people actually do - does this controller get
used without the MTD functionality?  Most of these controllers seem to
be really bad generic SPI controllers that would rarely get used for
anything other than MTD devices, if this one is a useful generic
controller your approach makes more sense although I do worry about
people getting noticably worse performance if they don't build MTD in.

--7y4DHJEdfFNfRgCM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmH6x7IACgkQJNaLcl1U
h9DEGQf9He89Bi3wo07ovLF1dNgSvxJZahA8VFp/QkgSOtIr4HRih0rAJyEcsb/o
BFq3C1/FbFj6x2fTYYlWSNdaEpeqEOY1TBqi9qx7cYFV2dei4vgHn4pyTkqsAwkD
tPEsaerYkwGek/8XP2S+6BzCsGHpL1ELpXyOViGEUuo4CYhootJfQSyUFeDVKFDI
rJz3hXUDhZCrDNxkcYh07cw5q71tVTmTyNaQBMkAXl1FkCltvPNCgyaTClIfoqnp
KURHYU8wj78btu4lNfrGJZk+Riwj47BcgJa94gzawKoLlX+p2CMkaNWpjn8yBhIl
lCY66Ex4xpeOrMiy1MwOPA6EchqroA==
=G0jO
-----END PGP SIGNATURE-----

--7y4DHJEdfFNfRgCM--
