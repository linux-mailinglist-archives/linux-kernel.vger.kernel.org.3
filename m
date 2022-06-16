Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99D154E1EA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376743AbiFPN1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiFPN1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:27:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2449DEDA;
        Thu, 16 Jun 2022 06:27:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 751D6B8241A;
        Thu, 16 Jun 2022 13:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307CFC34114;
        Thu, 16 Jun 2022 13:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655386049;
        bh=g8aX8KHRrajIVWtUv/m2vLhGkwcpEqPjNJB44iCRIjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XxH5XNn/GflcHJla2KSo8uqZAf5OIfjaVv2jJ81t+sEJ2bwC0DGZeSN40U/RB6hSx
         vs4gJb8uOeiCtY/hvUN17LUZy60c9f5PdxLvgq0LLQAqrYIApMUg1LgZkcjihqUQRE
         BL+k8V/w6HyKYKMMH9Q6ucWZ1Q5wjFibGNgoTRg26gDwO1WkB3qKBEEriijAz/ejck
         lsRxqiEUOhv5kJsMIWUvFs3ocax5QDO1zYXoIoJx2SEXD/lT3yghkgly+uLN5sz8Jj
         aMpV6rhFqgrdSGzuYOhrh6SLCqCaYaJUvEUxppJ2SM+wEX9aG82VwIbvjeqX6k64Av
         Hm2+1nW78k6sg==
Date:   Thu, 16 Jun 2022 14:27:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: adc: stx104: Implement and utilize register
 structures
Message-ID: <YqsvvDnFuk0KEjpf@sirena.org.uk>
References: <cover.1654118389.git.william.gray@linaro.org>
 <a2dca9435f7f1f727c696a1faa0ab9e27927f9f3.1654118389.git.william.gray@linaro.org>
 <CAHp75VepZ8P_cqnN8qJ_Wb=xM0LW3y-a22tv1otDReFSqRDFYA@mail.gmail.com>
 <YqnIygHDSUbV5yws@fedora>
 <CAHp75Vcojz1d8uGcR5CMeSFcBDCxqzDbncU2Mp-LT4iDqw_+Pw@mail.gmail.com>
 <YqnOUlE1nEnCC44B@fedora>
 <CAHp75Vd91GMGUJurGKi2Ve_GM13uLpQFaeYG8Q48yFA6Aq2_ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="80ui2G9wDKtNFotX"
Content-Disposition: inline
In-Reply-To: <CAHp75Vd91GMGUJurGKi2Ve_GM13uLpQFaeYG8Q48yFA6Aq2_ow@mail.gmail.com>
X-Cookie: Pass with care.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--80ui2G9wDKtNFotX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 15, 2022 at 02:43:27PM +0200, Andy Shevchenko wrote:
> On Wed, Jun 15, 2022 at 2:19 PM William Breathitt Gray
> > On Wed, Jun 15, 2022 at 02:00:26PM +0200, Andy Shevchenko wrote:

> > > I just realized that this driver is for the old PC104 (like?) hardware
> > > that most likely uses IO ports, I don't remember if we have support
> > > for IO ports in regmap (MMIO -- yes for sure).

> > Hmm, I don't see IO ports mentioned in include/linux/regmap.h, so I
> > don't think the regmap API directly supports it (maybe someone familiar
> > with regmap knows). Although we do get a virtual mapping cookie via
> > ioport_map() in this driver, I don't know if we can pass that to the
> > regmap functions and have it actually work.

> The problem is with accessors which are inconsistent in regmap MMIO
> implementation. I think it should be converted to use
> ioreadXX()/iowriteXX() in all cases (currently only BE cases use
> them). Another variant is to provide read*_be() / write*_be() for all
> architectures, replace corresponding ops in regmap MMIO and introduce
> regmap IO with inX()/outX. The former seems to me the best option,
> while the latter is cleaner.

I don't know what driver this is, but yes someone would have to add
ioport support to use them with regmap.

--80ui2G9wDKtNFotX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKrL7wACgkQJNaLcl1U
h9CDMgf8D77XkxBr9XTpl8qt4wypS4p9F2jlJkZr83OC6+eHrQL1zY/cs7b3txF8
KBF1fO+KIvNEwqTO2m7vCG5ubYIdAx/54UWswMnN4bfxHu8wyC7QHnj3CkYzECrV
N1APoKVJ2HehY6ZufGcddB4YIyZmafkMThtiotn65A7EmvQuqR0ejBkpVVYhkA0Z
CWnOnSthGI0J6khqb2OmcS2YpJZReMDCi9vhDJ8Bw7VHbZMLCl/sa9OEu5FGyOFD
3VUkKBQdUh0nDRP02qBoRlnrBmlGAS+uDuuo7zDMcmkAAW9JHxFtKPOjLbZ4y52R
kpM1RcjkyWFAAj2kw6MC0pi7NFx6ZQ==
=Osmx
-----END PGP SIGNATURE-----

--80ui2G9wDKtNFotX--
