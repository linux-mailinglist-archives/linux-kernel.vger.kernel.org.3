Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3CC52624B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380421AbiEMMtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359455AbiEMMtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:49:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4593A703;
        Fri, 13 May 2022 05:49:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E2F161F8C;
        Fri, 13 May 2022 12:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AD9C34100;
        Fri, 13 May 2022 12:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652446139;
        bh=N6Gs27VquaPY/jfyx7p+uW0mYzfGY1yrIjK7gsqoh7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aElnBzI2wZCSK/U/Wnscmm/Sf1R+M1wGzU0SZHNmsLcyeDhrq6q7+ygyC0z9PfHR5
         N/ajNj3N6eZZfZ+EylMuobL3/Y77JbKMylxyKVAO5DnQMabg8vlXq614hAoTU0zLlP
         OwxUFo7FINvs9ZH8/v/9RcNsiTStBmfaPbsDNWYzSFyQqCJ8+C/75GEEudBLaGfq4J
         bnunuVr6Fks8yOQ82W/lBrSSdtVf3jiVDNx4x+cTtr61rJzRf4F5t1QVXaCdkXm3XX
         ZH1pPSQmTMHTphNJscauUHBAScWkKa5e5mlFYP/mp6JtlmMiYdidrd9ND6ZcmCSi7H
         WxgHFkTrgee9g==
Date:   Fri, 13 May 2022 13:48:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Will Deacon <will@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        iommu@lists.linux-foundation.org, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] driver core: Extend deferred probe timeout on driver
 registration
Message-ID: <Yn5Ts1+56rBip8Mc@sirena.org.uk>
References: <20220429220933.1350374-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZVbyQANSq1izx04U"
Content-Disposition: inline
In-Reply-To: <20220429220933.1350374-1-saravanak@google.com>
X-Cookie: You have taken yourself too seriously.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZVbyQANSq1izx04U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 29, 2022 at 03:09:32PM -0700, Saravana Kannan wrote:
> The deferred probe timer that's used for this currently starts at
> late_initcall and runs for driver_deferred_probe_timeout seconds. The
> assumption being that all available drivers would be loaded and
> registered before the timer expires. This means, the
> driver_deferred_probe_timeout has to be pretty large for it to cover the
> worst case. But if we set the default value for it to cover the worst
> case, it would significantly slow down the average case. For this
> reason, the default value is set to 0.

This makes sense to me.

Reviewed-by: Mark Brown <broonie@kernel.org>

--ZVbyQANSq1izx04U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ+U7MACgkQJNaLcl1U
h9AJrQf+O34uAf+WJTRmMJA0R5+muU/Q3+PYEKAnTQ3EJ1R3EpYCuFYr1FlCDe3g
OIg2rZyCYxhlgQ/k1CRFZbdK+R94KNZ5rv47uV1Kt8aC1uY7Rizh+e04jjgYSIOc
TVn7quNTCXOPaNwuz95cURa8W7X4GFXDkdppjmpcYeMaaNsOU4z3Pw9drORQTArc
Vb8M63Rn2/hazrGdt7xRTUU+/UvyOu3R63NeqkBcvvVo+tLXgOFaRsciYs+xMI6t
Lg347Izlc1kBmpHhg5e/tAl5zEj3cZgc6a6gTg69f7i90AnxZw64vwFiv9grHK5S
HLh2BNII8I1elceOYfqYDh3c1Apcww==
=vDHz
-----END PGP SIGNATURE-----

--ZVbyQANSq1izx04U--
