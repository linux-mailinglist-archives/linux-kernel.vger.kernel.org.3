Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3385534292
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 19:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238461AbiEYRz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 13:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237324AbiEYRz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 13:55:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65550E012;
        Wed, 25 May 2022 10:55:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D743B81E95;
        Wed, 25 May 2022 17:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE34BC385B8;
        Wed, 25 May 2022 17:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653501322;
        bh=JQT1FQkqijFrYs4Q5gXkVwd/6EItAgBP5Qqc1g0WVt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=adkySraLTQOiDVOQjecG2dUr5S6OEQQPD7G1lYfAYgWxjS13MaYz1HvXts2EpE44d
         edzL8KOgtKksDncP5Mjp4s09UN6lJr2Rdi66+r1FJzt9cn4eKIXi0iwRYRBwlg3Be+
         FwHg1sQVKUGpA1phHL9BpYqXUJ5/JxTNjcfqKkmydc1U0THsuBbUguHseU8Q5wPLtZ
         0AA+q2s4fmmF46x9Oa3s2p+TBRQZDgoaJWGOek4AaUqFwNK1UulNm5x1DkeL6ZBtA/
         lKpsDYXcJX1q0IZcFiy+q4v+uLl4sZlzifexvxFVgWtjVxJjWXOLRoUQKt8ci/XNzA
         cPF2+FFBSniGQ==
Date:   Wed, 25 May 2022 18:55:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: fsi: Fix spurious timeout
Message-ID: <Yo5thr6nAgNEqJTn@sirena.org.uk>
References: <20220525165852.33167-1-eajames@linux.ibm.com>
 <20220525165852.33167-2-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mrFfS6EXyohewE7W"
Content-Disposition: inline
In-Reply-To: <20220525165852.33167-2-eajames@linux.ibm.com>
X-Cookie: The revolution will not be televised.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mrFfS6EXyohewE7W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 25, 2022 at 11:58:51AM -0500, Eddie James wrote:

>  I have one concern still, that if the kernel is very busy, it may
>  schedule other work for the entire timeout period between assigning
>  "end" and checking if timed out in the do/while loop... Is it worth
>  worrying about this case?

I'm not sure we can entirely avoid there being a gap, but with it being
a busy loop you'd have to be very unlucky to hit that case.  If you come
up with a fix that'd be nice.

--mrFfS6EXyohewE7W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKObYUACgkQJNaLcl1U
h9D8vAf+P7OpuDaqfvgm3ycOW3LdYGgtTETWfRNzmyKpwwUsSPJ719zIRw7VZzEH
ux1xJToX4RtwLF5+vBtDKXcVlwoD3AVP3LbfTbzAbIsvU0DZpeeFZvFKYxsQ7YuD
EgbYigYf5LP7UlK22dAPT3bRAYURz2bDK/FKJePk6N1nOm5YP0NA9gn7T1BIbKIm
e8a2pfbqXVpcH9syKautZYrMEs5of247mBB+o4pvzp8WhJsjVcgSfbn5xhclSHDG
54EX7xzTGNYEV8kXP5QjP7RofcdDyVPfDa+6AbadPyM1yU3F3yiIWHEzPgvd4bpc
MRCwycH3ZqYXyPh5NpDppPyvy8iQ6Q==
=rjry
-----END PGP SIGNATURE-----

--mrFfS6EXyohewE7W--
