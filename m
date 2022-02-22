Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081194C0082
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbiBVRzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbiBVRzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:55:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7755106118
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 09:54:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71144B81BDA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 17:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6385BC340E8;
        Tue, 22 Feb 2022 17:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645552480;
        bh=jSNZ/uxg4Nydk28NmL8vUfhiupf4jKRJIK2seSF10cI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XGFwHTB84Cb+s32CsOV9C0ujYGvhg4Ob+4hfewnNeYw6fZ9wwjbwO+wWB7tow1RNc
         NH0bJS7d4U2OvgEFKiC30nXfn/udlMndecSOhE2SCaLomwvZfq4fiLN3RFNe5xTkkQ
         gRz3PH1Md3sE+3WXb7rdpvVNahuNXGvRgz9MJC6JZUvLARkICV05Uj84VRL+6gfTWw
         BkT1tOxe9U6Mv/3Zs6icqb6ZXDEW0w5FyJZK7QcShT0zAqaEH4RH6NPyQ96Y5KV3eU
         EisWuUufcUQHv3k9+PllGorjLYzooxO6k4IJ1qm/f/m1ushTyc/HZFzRqkuN4LYFfs
         izguohNcZRS8Q==
Date:   Tue, 22 Feb 2022 17:54:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
Subject: Re: [PATCH 09/16] ASoC: codecs: wcd934x: fix return value of
 wcd934x_rx_hph_mode_put
Message-ID: <YhUjW6B8LmoEWLRx@sirena.org.uk>
References: <20220222115933.9114-1-srinivas.kandagatla@linaro.org>
 <20220222115933.9114-10-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mpa+mWrNm0hr054s"
Content-Disposition: inline
In-Reply-To: <20220222115933.9114-10-srinivas.kandagatla@linaro.org>
X-Cookie: I smell a wumpus.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mpa+mWrNm0hr054s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 22, 2022 at 11:59:26AM +0000, Srinivas Kandagatla wrote:
> wcd934x_rx_hph_mode_put currently returns zero eventhough it changes the value.
> Fix this, so that change notifications are sent correctly.

> -	return 0;
> +	return 1;

This now has the opposite issue where it will unconditionally flag a
change even if none occurred, that's less bad but still an issue.  It
should check to see if the value written is different to that already
set and report that.

--mpa+mWrNm0hr054s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIVI1oACgkQJNaLcl1U
h9Do7Qf9EZHwn4KoVflO91QHGRDyRPg2k3SZvPgEuaYXy4SxFSPrrxosil+RBxW3
wIoS20OhKfHkF+jirulBOcN3Sw3hV8MEuvpVZRUt9LhfH0EpZKIOytnVd13JBMJK
CUDiZGRUaqKBy0XtSOQ5WxqHqQgXTNYflj8hn6vWkuKqOEC6q3GHLf6UDDBO1B77
7GAiVMvBvYSsn2BrchOzaseSnd0uxHkxTeoUO+w78LeyNPRhg07mjlml4iS+wb4d
YBOQLtM/87JOdVbfvEvzQZSO1vM+Zd/1+lT0xslve4B126/o1Lvw1BZxAtkB9Jhv
ermlPqh8YhuwDuzqhenDhlLLzadmuA==
=Xc7o
-----END PGP SIGNATURE-----

--mpa+mWrNm0hr054s--
