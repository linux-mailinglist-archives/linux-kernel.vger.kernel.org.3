Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FFC599BA9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348899AbiHSMIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347538AbiHSMIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:08:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C80D10097B
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:07:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7FB1B82790
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 12:07:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506AFC433D6;
        Fri, 19 Aug 2022 12:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660910873;
        bh=GKR6cf+ldrZjNesplWeFBQHuH0NOM2NdOJNlvYtu2FM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kc/HTRt+na3qz4LFA7uQNqhkqEf6BM+S592CcyZVRVU0MCOYfWxy3MAPVaDRhjZyM
         9OTrCogWUWBrIZVVrLB1+EHMc3Uao2Ww8r6/Kr6y2ti4OaFFOozaFTPn2BkrIRhtpy
         HvKsNJtBAuxQGXyvsSRU/s0RZZsnwgZqsKENhYqGnT9KOKj4SsweYT9+DYU6lETgfI
         MbcF6fU386fwY7HG+/Rd/wvkcB425qlAmhraKmUqK5lOKE+oe8/88D28D4sPz34xmq
         jh6X49HuCAej5B7yQ6Yuu8OCzJNegKIA9cDNwSXLimZa44UqY5qdGUpK3oE97pdiXc
         PaYJgh64WjYQg==
Date:   Fri, 19 Aug 2022 13:07:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     Marc Zyngier <maz@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux@rasmusvillemoes.dk>" <linux@rasmusvillemoes.dk>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] regmap: introduce value tracing for regmap bulk
 operations
Message-ID: <Yv99E0mrPI0qG66I@sirena.org.uk>
References: <20220816181451.5628-1-ddrokosov@sberdevices.ru>
 <20220818121515.6azkxyqetnunwsc6@CAB-WSD-L081021.sigma.sbrf.ru>
 <87mtc1wtjz.wl-maz@kernel.org>
 <Yv5eMcmNOmyLmd++@sirena.org.uk>
 <20220818174441.arh7otvrkzg5uk3s@CAB-WSD-L081021.sigma.sbrf.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YR63lD1u5B2qJWoJ"
Content-Disposition: inline
In-Reply-To: <20220818174441.arh7otvrkzg5uk3s@CAB-WSD-L081021.sigma.sbrf.ru>
X-Cookie: Price does not include taxes.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YR63lD1u5B2qJWoJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 18, 2022 at 05:44:23PM +0000, Dmitry Rokosov wrote:
> On Thu, Aug 18, 2022 at 04:43:45PM +0100, Mark Brown wrote:

> > At the minute we don't put the actual data for the bulk transfers into
> > the trace so the information simply isn't there.

> What do you think about the patch? Can we use the separate trace event
> class, or do we have to add these tracepoints to some existing class, like
> regmap_block?

I didn't realise that was even a question, but then there seems to be
some discussion I've not seen given the CCing going on.  The biggest
issue is do we even want the overhead but I'll need to find time to look
at this properly.

--YR63lD1u5B2qJWoJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL/fRMACgkQJNaLcl1U
h9DY0gf+I1M0xYDoLL6v/aKBEP8Gxj/kQw0umt9tfn7r8KbNZL4Zkrh8JaH5WAZj
tW5rpR1JRRm5e9FzdGJ8f+hDx3vF33BGIe6lJPXwBTRKU1YfMRisN+XFYT8onrqG
a6PBksOY6PdKm2OhgW4680GNKLi5zFyUk+FDzidBzLn5am50YNYzmhvtrKbczMq/
WTgD9xpkTxxBfWbZsWb8Tq4IBYSTXSKDPv+O0zd0yYXmj5daxLgZdPGjopwqEgi0
sOtXLs1NTsI2oSXrMSL9gAJ5yWM2i864v9rJrWMnOBkBGio3GMRL+xNFSwOmeGcq
+ZcOyOyGz494B73VcSyt2Rfq+qoLew==
=WIkd
-----END PGP SIGNATURE-----

--YR63lD1u5B2qJWoJ--
