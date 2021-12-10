Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8B5470C48
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243313AbhLJVP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:15:27 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:56214 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243257AbhLJVP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:15:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5106ACE2D3E;
        Fri, 10 Dec 2021 21:11:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AC3C00446;
        Fri, 10 Dec 2021 21:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639170707;
        bh=ehvkwSBzHebalBRfzUXM/eqWv9XlwQOJTFk2risiuEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sIQZ5/gEbAn+zUpjcHSkFy+JKmxCIFY0DiXKcVGDGvgmpL4vPhx0pWsjIQUh0SY8k
         XWmzxMxPkYeSoUybJHis6k1wM7ubHJQMS38fduK4sggs7YC/JAsa54tEBFN2vk9jzn
         syv1e+75/NlIYS3rB0v4Bd4lifdAgKJexb/QtlKqgD5HM2sL/VnZXkdfyxl6QWlzhw
         /d5fW9vbqVSUF7O44AO3rMkbX9fh5m9dk5VNquV0e8kD2vJkvjNhDXGvPbFzPbxj31
         2Apwjj93B6CSgXuNC6tfLzeMPHbvQa5Boz4DcxXctzH9knSL+RhGbxx7KCSD8+UMf1
         bVI71x//VOTGw==
Date:   Fri, 10 Dec 2021 21:11:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     David Collins <quic_collinsd@quicinc.com>
Cc:     "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, swboyd@chromium.org,
        subbaram@codeaurora.org, Das Srinagesh <gurus@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 1/6] dt-bindings: regulator: Add
 "regulator-min-dropout-voltage-microvolt"
Message-ID: <YbPCjbnH6cXQqy6S@sirena.org.uk>
References: <1637314953-4215-1-git-send-email-quic_c_skakit@quicinc.com>
 <1637314953-4215-2-git-send-email-quic_c_skakit@quicinc.com>
 <YZ+o9sQpECZSrieN@sirena.org.uk>
 <d828f2a1-03e8-d6ee-4ab7-39bf677093b7@quicinc.com>
 <Ya5VhkggWdjYyTHL@sirena.org.uk>
 <6a44cb99-6894-c9ce-4f1e-5dee0939598c@quicinc.com>
 <Ya97cnuwM+MuNMg3@sirena.org.uk>
 <23a47965-4ea9-5f6c-7e3c-27f5bd35f5b7@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aY21D3MOZ+5AaGhF"
Content-Disposition: inline
In-Reply-To: <23a47965-4ea9-5f6c-7e3c-27f5bd35f5b7@quicinc.com>
X-Cookie: One picture is worth 128K words.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aY21D3MOZ+5AaGhF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 08, 2021 at 04:56:48PM -0800, David Collins wrote:
> On 12/7/21 7:19 AM, Mark Brown wrote:
> > On Tue, Dec 07, 2021 at 08:36:11PM +0530, Satya Priya Kakitapalli (Temp) wrote:

> > that regulator.  We absolutely can and do expect this to be board
> > independent, it's a function of the design of the regulator.  Sharing
> > the input supply has no impact on this, the input voltage that the
> > regulator needs just get fed into the requiremnts on the supply voltage.

> The PM8008 LDOs are low noise LDOs intended to supply noise sensitive
> camera sensor hardware.  They can maintain output regulation with a
> fixed headroom voltage.  However, in order to guarantee high PSRR, the
> headroom voltage must be scaled according to the peak load expected from
> the each LDO on a given board.  Thus, we included support for a DT
> property to specify the headroom per LDO to meet noise requirements
> across boards.

Interesting...  how much extra headroom are we talking about here?  I'd
be unsurprised to see this usually just quoted as part of the standard
headroom requirement and this smells like the sort of thing that's going
to be frequently misused.  If the gains are something worth writing home
about I'd think we should consider if it's better to support this
dynamically at runtime based on load information and provide options for
configuring the peak load information through DT instead for static
configurations.  That would fit in with the stuff we have for managing
modes on DCDCs (which isn't really deployed but is there) and the API we
have for allowing client drivers to indicate their load requirements at
runtime that fits in with that.  That'd allow us to only boost the
headroom when it's really needed.

--aY21D3MOZ+5AaGhF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGzwo0ACgkQJNaLcl1U
h9D5JAf/UH1JxBePimL0+Pp8KDDhkWrq3f8g7S6s1mh2CgcxSnjDVAhmWiFYh22A
CdS7eEDRRbw9pDfERbScBSjw2NCFKRerD46BS+G/voolysHPatVwe6U/XmayvbJ6
A8Qkj07rDum73b1g1TmrYA+59rYMgtEFke5167sCmqhfo2XjldWcj89kAmr6+3ej
YKmkEn5j9ulNqSskq49pY5QdSRAGxnaziUfuLjnbHwuTFQ3Ce59hdYJcmqny8CJp
gP5pFW4q5Kj4vXHsP+d/Y16qnheo/jaxN4t4z+e8dF+Fdbtg9NIAV58BbsUurGab
QZHp2ThzZotfK5DdkG17CEvYx5OnDg==
=3Eej
-----END PGP SIGNATURE-----

--aY21D3MOZ+5AaGhF--
