Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D6D52DC0F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbiESRzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243452AbiESRy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:54:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454A95A585
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:54:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB588B8277E
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D432AC385AA;
        Thu, 19 May 2022 17:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652982882;
        bh=I8tgd+WoWDMrJR4jZEp3jZktha7OhUuqZeTJmNYKX6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d/3aArFJ6c3CEjmZ1AHkWYwCGRmTO7nIwAUeFPSqz8UU8up3BaYwKv2fcjZzF1GDH
         O3mqj/q3qf/3JlbZTuGwgQXLoZcS/NBefZnBFF4dy69tTvRWSDiK/92ETRjY1xT7E7
         jC7oR03PmbhgBfky/0b0N/4dLhyrOYr21usdRmudB1jO8WZLpaYQ6+6aIGKfA7ANRj
         pkpR5JK/FqwO+nOVnvmSfAG2nUnr6K6HhDHc7Hb56hAttQhOzqXl3oQ7WYoSquc5OH
         LvPEopuwRSthF8B258lLQTEmECBZ+J1vavktEDH0+fq5P8repHA5c7b2c+hKBF/3ra
         v5lJEzGkpvvSg==
Date:   Thu, 19 May 2022 18:54:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH] ASoC: max98090: Remove unneeded check in
 max98090_put_enab_tlv()
Message-ID: <YoaEXWGEY4s14je+@sirena.org.uk>
References: <1652980212-21473-1-git-send-email-khoroshilov@ispras.ru>
 <YoZ+dmprwb5Ohto3@sirena.org.uk>
 <fd58c07c-488e-1c90-a755-194f714bbe45@ispras.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="25luxRjqlhvCfi1Q"
Content-Disposition: inline
In-Reply-To: <fd58c07c-488e-1c90-a755-194f714bbe45@ispras.ru>
X-Cookie: Some restrictions may apply.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--25luxRjqlhvCfi1Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 19, 2022 at 08:49:48PM +0300, Alexey Khoroshilov wrote:
> On 19.05.2022 20:29, Mark Brown wrote:
> > On Thu, May 19, 2022 at 08:10:12PM +0300, Alexey Khoroshilov wrote:

> >> -	if (sel < 0 || sel > mc->max)
> >> +	if (sel > mc->max)

> > The check needs to be moved, not removed.  The userspace ABI allows
> > passing in of negative values.

> Would (sel > mc->max) be enough in this case anyway?

Oh, the check won't be working properly - it's just that like I say the
fix is to move rather than remove it so it's operating on the signed
value.

--25luxRjqlhvCfi1Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKGhFwACgkQJNaLcl1U
h9CrFQf/Spd84BxyW43FtCv+kRymc8xAoxAjmgQI4n2HG3oXiv+WajOLPVB/AWmu
Ng/gUYtttDs+U2jQbWtkHjO0Q8Y2N6l1z+8+RGnJh//YX6dtSPQDtoS9aJ5w6JTd
SF9BM02u66EznHe/landjz+0N6cmY6H0QnVuuom1UCuixrB+5xiN1vIacLavIBJ+
yGHWfM/Jaj8CfwDlv5TBSu/wA0jYbFJzMOQ+B2zeQtcfTqFXvrwKP9miXTE7oQIM
xaJvVt/NnJTzgUn84dQPg/k4+kn6nBIubCoy01HhBaW+evcRbdoZ4FJsdKWMTKdL
SvQCgoxRRKWPo1bXaftaPcODCk0ziA==
=79Ws
-----END PGP SIGNATURE-----

--25luxRjqlhvCfi1Q--
