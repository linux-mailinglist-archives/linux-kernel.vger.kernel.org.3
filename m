Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F61F546566
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348677AbiFJLT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 07:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239722AbiFJLT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:19:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1DB14B647
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 04:19:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11EF961FF1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:19:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D002AC34114;
        Fri, 10 Jun 2022 11:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654859995;
        bh=KAlRZ4yMKB09qBCMFkJ1IIuBOpieAqkFnbvKggFZq+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rL2wrxmwKdiCzXju301IYhEDbvkruwG2iJs3v42igxsYc4F8FUCOf6IMYiDkCqV3/
         lUod7HCj/jSfvHe9H3WltjxR5uigyhxyEBF3f2ttu08ZeKXrC9oDF0i7GsCmAgxG2S
         q14k2m/LGyJzFJll03bJBZFLNPJXoDClxaq24CZNkJOfPyQBVmR/jeVSuLAX+lOIKS
         sskzN0YG9WGHJQQ5uCm3lg8OGnAhH7GFB93Onpi75EH4AcvfopI2BW8bpf7ykY4/al
         OeKHU+BDBztOb6xodCF311Dno6U0bqPcVveagwySmLMHZI8csQ3rCYF9O6XySoEny5
         xQQtgIgS50oMQ==
Date:   Fri, 10 Jun 2022 12:19:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Alejandro Tafalla <atafalla@dnyon.com>,
        Will Deacon <will@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sysreg: Fix typo in Enum element regex
Message-ID: <YqMo1gGVgWQDBQjJ@sirena.org.uk>
References: <20220609204220.12112-1-atafalla@dnyon.com>
 <YqMLmMJ7v48me/5H@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Jxd/oy2jPK+b7V+i"
Content-Disposition: inline
In-Reply-To: <YqMLmMJ7v48me/5H@arm.com>
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


--Jxd/oy2jPK+b7V+i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 10, 2022 at 10:15:04AM +0100, Catalin Marinas wrote:
> On Thu, Jun 09, 2022 at 10:42:18PM +0200, Alejandro Tafalla wrote:

> > In the awk script, there was a typo with the comparison operator when
> > checking if the matched pattern is inside an Enum block.
> > This prevented the generation of the whole sysreg-defs.h header.

> > -/0b[01]+/ && block = "Enum" {
> > +/0b[01]+/ && block == "Enum" {

> This makes sense but I'm surprised that we haven't noticed it until now
> (maybe some awk versions treat it as a relational operator).

What Catlain said - if we weren't generating the full header contents
I'd expect things to fail to build normally, but it's entirely possible
this is just happening to work with some implementations and the patch
is clearly correct.

Reviewed-by: Mark Brown <broonie@kernel.org>

--Jxd/oy2jPK+b7V+i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKjKNUACgkQJNaLcl1U
h9AMIwf/eYpMYBHkr5v/mGTOxTIeRcCffY2jzjF8cFtIr8SYwAdSdYWaO609ZPgd
Dhi5lfCuq62uNTzyvimDMB7ZjuP9Y+s4fInm891igADTUS1p7L1IG8g1zjTWlmKc
Kr4mlLjHqahktGMvYevAYy3BJ8VHtF5IMfoot6r/SRfIpzsoIhb2oWG84DbT4axH
wsSnXGHuEz/UCV/q0GAhmY/iRByKwp4GlwG8sayByWLgxo50hu3B/B0pnmNgylBA
8Tdr4log1c9V2J9VwAFiXScdZn2HjveYl2JTPGg3lZiHBh16jobf1g8rqZim7dAa
HXmskkiEefM4JADNZowdp3nAqSv1mw==
=vlBZ
-----END PGP SIGNATURE-----

--Jxd/oy2jPK+b7V+i--
