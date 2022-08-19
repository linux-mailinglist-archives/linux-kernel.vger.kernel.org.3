Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B059059A8C9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 00:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243108AbiHSWsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 18:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242959AbiHSWst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 18:48:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F01753AD
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 15:48:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23B8E61831
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 22:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFFEC433B5;
        Fri, 19 Aug 2022 22:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660949327;
        bh=gJJMr+uLwUVCPzts92iC8fkEyz8iwbsHjS9H2CKktno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SSxNMzplA2gu4/xhcncDwTntKN9odHWKv95YC8+mNoUC5/3g6X5a23RegRJeNi6Ae
         bQfRD7nZsqSn/MtcxQnhRtJtLVpD93A0rnd+ONj1o7+RoOQyPyg7WHv+bu66WDZupE
         WRn+wKzi3wq96SMg9f/LyxBmM9lN0FrY62EIDgRK5uHQnB1zOnETtyiq56KujueYI+
         i2J46Bs1SDx5ch5Ec0geLQU87AtRdDtifjlszVQfzuFtJ4aRhdLCOtkcGWYAYdJlcV
         zkiYOva1IbPpnNh/3cCymf8Q+3dqDz61VGy+XgyKj5tN56MDKMdwsOC2Hk6/D/YA2A
         ErCT/L78dsLwQ==
Date:   Fri, 19 Aug 2022 23:48:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        bmasney@redhat.com, dianders@chromium.org
Subject: Re: [PATCH] regulator: core: Clean up on enable failure
Message-ID: <YwATSglfJEgG6V73@sirena.org.uk>
References: <20220819194336.382740-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="P7YyzzYVLd5ZYWMp"
Content-Disposition: inline
In-Reply-To: <20220819194336.382740-1-ahalaney@redhat.com>
X-Cookie: Process promptly.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--P7YyzzYVLd5ZYWMp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 19, 2022 at 02:43:36PM -0500, Andrew Halaney wrote:

> -	if (regulator->uA_load && regulator->enable_count == 1)
> -		return drms_uA_update(rdev);
> +	if (regulator->uA_load && regulator->enable_count == 1) {
> +		ret = drms_uA_update(rdev);

I am vaugely surprised and a bit concerned that drms_uA_update() can
fail...

--P7YyzzYVLd5ZYWMp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMAE0oACgkQJNaLcl1U
h9A1PQf/SxzOvIgno1rey/F4HXQL7HDaiadmoJVdsBE+O8gVCb7rcCSeZTbYAmfz
bYvnjFbeL7EOxKdN9+fsKQGcRMtZik6hrXO3BICTE8IsdgwgzDROL8US6+B9fNTa
GSI1QysdkGUfaHbtUxw2xfAqz2fZuc21yBbsT3jDo1iJsAM0evCH04aYj3xE0h6G
gBkTeHuMexyvJY+h1onqQ+ZL8Vx5G41K1m38bTbkV2loc/YCpkdNWmxEmdTxA19u
LUzhE4JVuIISCoPDMcy6xLC4yQWqgi87oibEMOj1fSyT6NwkoeSx5zcersyviWuG
4zIG8LKxrK7l0Pla3vZjHN/+R6vbAg==
=9N9/
-----END PGP SIGNATURE-----

--P7YyzzYVLd5ZYWMp--
