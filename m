Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12AB4BE484
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379094AbiBUPZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:25:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379090AbiBUPZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:25:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6640521817
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:24:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 019D8611ED
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27B8C340F3;
        Mon, 21 Feb 2022 15:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645457090;
        bh=Jh3WfvAvBXogRJ7ujyOvL/ueVXcl228Lr1D062RBQ/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KF6bzMsJwTram2lkBwsTL2ygkZflGTjMucCCbJAi8HWhz4U+9po4cD/OVHZSEl06y
         Tt+BgHtuCLBYJYDW1qOQsSnlCZd+/6vlXjD3yNEsbGNdlkOT5I3fF5fP3/6TByy5TO
         I+h0DHElB8lOfBaiKpK13WBSXSY4s1unbEGJFwe5yEBeuzBYL2RoHNCVeCdlpurT/r
         BBwdmYPNB/h6dr7+/+GxREDmBQHxWIpGZ0BosKAd24ILn5H2hL62kojvwTifM3JZIu
         B/Bjdol0NMCFoVbh8NykKWtXhrqkOElHEBVzVuGUT8ig3K4VU33SWL45CTfaCSZcbL
         lA+P33g6J2UZA==
Date:   Mon, 21 Feb 2022 15:24:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
Subject: Re: [PATCH 01/10] ASoC: codecs: va-macro: add runtime pm support
Message-ID: <YhOuvdsKu6zOg2p/@sirena.org.uk>
References: <20220221131037.8809-1-srinivas.kandagatla@linaro.org>
 <20220221131037.8809-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lzsBWC75ma9I+8BZ"
Content-Disposition: inline
In-Reply-To: <20220221131037.8809-2-srinivas.kandagatla@linaro.org>
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


--lzsBWC75ma9I+8BZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 21, 2022 at 01:10:28PM +0000, Srinivas Kandagatla wrote:

> +static int __maybe_unused va_macro_runtime_resume(struct device *dev)
> +{
> +	struct va_macro *va = dev_get_drvdata(dev);
> +
> +	clk_prepare_enable(va->clks[2].clk);

This magic number stuff is going to be excessively fragile, and the fact
that this is sometimes managed via the bulk APIs and sometimes not isn't
going to help either.  Either all the clocks should be managed here or
this should be pulled out of the array.

Also consider error checking.

--lzsBWC75ma9I+8BZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmITrrwACgkQJNaLcl1U
h9DUzQf/Xclajinqx6lEXYTioZTqh3OgffcF+xcHskvifhNxeZMgwPF15gkDNEQg
QKJu5aq74J7s22zdsH3Q7JzoUbSIpaU8+y0/86tKW3iMcFRWZVV2yNGhpkcFgUbl
eij0F8BPSwCXBo0zJbVJ3/0oHAlerYX0wiReicS5j36QDOGUuwqsfWie2aO9wSq1
pdmI3sgkpyE00u88xZHml6/FcSLSNprXPpShHFKLeRp2nSOxE9kYSePZ9G0Itk8/
kX+YLl62BHJKnKdjTaQO/hjllNRqeJvda61AdqTMD8+zqX3llEBYzZvIDQmR31Kr
r2aSKCOjUvzXhKLlEkMloAkkORyqcQ==
=ljEt
-----END PGP SIGNATURE-----

--lzsBWC75ma9I+8BZ--
