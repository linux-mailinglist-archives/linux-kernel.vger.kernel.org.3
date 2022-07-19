Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50899579FD4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 15:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238114AbiGSNjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 09:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237501AbiGSNj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:39:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05970B0F85
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:53:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D08DDB81B85
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:53:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD485C341C6;
        Tue, 19 Jul 2022 12:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658235224;
        bh=8GSuYHR9Qba2Ob7biqKhoqBr5wEldhKqsC6JuGbn2uw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TXYaysPxTpT5ToI4B3n9AYxlFG5Wpt0llImc+yvZ3iu9IDhb2pbzr9y2Fk1xn4cfR
         gcILP/Ojd64yF6OJUcsIaFHoVbYb/yEq6aVVEvJCZj+kXJzES8vE+2/1t1ItWVvwYt
         9LxGnBuoaNEmDjTp4D359zZyLMBv/qSoEl+8QpHDPpc46qMWpVzW0CzIkxXTVj9JMC
         sXa2HhT/1i8KFIBHsVczIA+0tSPBQ+kx2ahGld4CWjgeJ6a2bI+W1ITt7gnn14Gk/N
         UrmGdKFUUO4BAkEmI/DyeacX4YMRjqd582J4GclUdZx+YD6R1rQbxJqTKYmVIh6Hk5
         lzoXCJRbW7GHw==
Date:   Tue, 19 Jul 2022 13:53:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH] regmap: support regmap_field_write() on non-readable
 fields
Message-ID: <YtapU3/mbFzRgMip@sirena.org.uk>
References: <20220719121446.375095-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7fCRvdoT1wNEUdmZ"
Content-Disposition: inline
In-Reply-To: <20220719121446.375095-1-krzysztof.kozlowski@linaro.org>
X-Cookie: We have ears, earther...FOUR OF THEM!
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7fCRvdoT1wNEUdmZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 19, 2022 at 02:14:46PM +0200, Krzysztof Kozlowski wrote:

> Extend regmap_field_write() and regmap_field_force_write() to check if
> register is readable and only then perform an update.  In the other
> case, it is expected that mask of field covers entire register thus a
> full write is allowed.

The other possible assumption there would be that the other bits are
write as zero - that's not 100% safe but does make sense if for example
the fields are being used to capture acknowledgement flags moving
around.  That's not incompatible with doing this of course, we can
always relax things later.

--7fCRvdoT1wNEUdmZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLWqVIACgkQJNaLcl1U
h9CfEAf/ZHrQEcIff8+xgeY6KhDcnRpVAc0HN1c/HRq+Q/9ywMn2WcfYonHIIO/+
QpFUFx2cEcLqtA7b0jtX3dF2cpkbP977xC6h682tm4Zg+egmQzmWuBM+/JOrv9k5
HBmT1r0OqxXbOVXsBpSVhgt3NVfNix3wFhK/g55B/OhPYZYOleWnlrd1cH3lvgRG
26ZapN6kSFH19xrar9R1FlvLxMFPVnOhAoHS7gZbSLz3/y5TweL/18JJ7ZhgGJ3j
5mQO1g67XEtbG8MBICOM0/eSDv3ipKXQAGsOUN9oc5ClKVGzFvJdJkGvc6KDlfsj
edqv12q4Q5xnipS70jCFgZzZ2MJFoA==
=CW/A
-----END PGP SIGNATURE-----

--7fCRvdoT1wNEUdmZ--
