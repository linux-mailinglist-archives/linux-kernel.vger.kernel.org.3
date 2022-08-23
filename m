Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C3B59E774
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244995AbiHWQgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245443AbiHWQgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:36:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDB8BCB2;
        Tue, 23 Aug 2022 06:06:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD603614D1;
        Tue, 23 Aug 2022 13:06:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50939C433D6;
        Tue, 23 Aug 2022 13:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661259995;
        bh=H8h0RHLn6+JPT0ZVlwXJ4vwSe51HEfutMbaRAkltf4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eTC4CsZPJhQPvAAqMNaRmhc+GWcLHArz3Ok0OJBhL/Qt3r11I5bcFchOdk5TCZBuK
         cTi3PShOjAfQEmiDdM9EoYeK/R3rFYXmMk8alFomd38l5Z4w9V00ekY/CLVg5wtPUG
         cd1fexliwWx6meFgLre6v8tCdtsotGNZwRWBb6DKBMPLpvIzJK6gx7dPJ1/BUksyUL
         AvbvTQ86Y74Y6gMx7gvvDccar5p/ga6ag/SoBSgQCOucWgOzCV+qIaje4Ay17H1401
         EsRDWlNTETXDCcNa0tlYnQS4NE4lLq6aupAwRCMFiCDFU0yiTi4VJkKAUYLh1c8XvL
         /69x1Wd2TRaDA==
Date:   Tue, 23 Aug 2022 14:06:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andrew Halaney <ahalaney@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: qcom-rpmh: Implement get_optimum_mode(), not
 set_load()
Message-ID: <YwTQ1i5s5cwowRss@sirena.org.uk>
References: <20220726102024.1.Icc838fe7bf0ef54a014ab2fee8af311654f5342a@changeid>
 <20220822193153.zn2oxljmd76awqot@halaneylaptop>
 <CAD=FV=V_V-M1fJmeWH_=wG4GB9GERL9ToAZTwAjX9i-6k6QkWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X6FF6FFLRgFUYXaS"
Content-Disposition: inline
In-Reply-To: <CAD=FV=V_V-M1fJmeWH_=wG4GB9GERL9ToAZTwAjX9i-6k6QkWA@mail.gmail.com>
X-Cookie: You can't take damsel here now.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X6FF6FFLRgFUYXaS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 22, 2022 at 01:13:55PM -0700, Doug Anderson wrote:

> I guess at this point I'll wait for Mark to give his suggestion for
> what to do. Options I'm aware of:

> a) ${SUBJECT} patch was written as a cleanup as per Mark's request and
> we could just revert it.

> b) We could make it so that failures to get the input/output voltages
> doesn't count as an error when going through the get_optimum_mode()
> path.

We could push the checks for a valid voltage down into the drivers, a
lot of things aren't particularly sensitive to the output voltage here
and are much more sensitive to the current draw.  Depending on people's
attitudes to DT stability for Qualcomm platforms we could also fix the
affected DTs as well, though that doesn't stop us handling this in the
core too.

--X6FF6FFLRgFUYXaS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmME0NUACgkQJNaLcl1U
h9A/qAf+L08yi+AfUUOKiU+RzeDrbdpo0B+MwdqVLYM65myh59wA/z7dIUHNWslx
QSLK+T8ppVRnu/qedfMqhWKigjP69HkVs8aVDVNx5InAXyYL9fWpS+sIq9PTrYpO
crrASb+hFdboUdcrIbMq6xVSD0C9u5R98AgjTbAuGoYrRosXjWtViQVivCiBn3fm
cNeDwOU5CEoouqAAvtjpjjbUbkIn6SZdTt95yIhWvUQuU7nOShmngfCQ+uQAbt0s
hW4jcN4RS4Q1wPzDC0ccZl44BI2U0UvhMH/otFKXvjPnTU8DFH0tgBTTldmbPjd7
wOKME+0yd4AvtUjLkUauv4iJuVESKQ==
=QS7l
-----END PGP SIGNATURE-----

--X6FF6FFLRgFUYXaS--
