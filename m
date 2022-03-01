Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8A34C8BCC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 13:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbiCAMkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 07:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiCAMkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:40:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D5E2983B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 04:39:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DD51612AE
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C16C340EE;
        Tue,  1 Mar 2022 12:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646138397;
        bh=hv62MHfq4rzzCEl2fTmyE2lMMF0TTQx9kHnlP0mZ57Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hCkTo8BNi0iiE3Mh2y/NkqcWKbhqtCehGr0gcy3/Ip1/62ExDHQWn726l5rzSAa9Y
         C3rzMpEH6DeQ1/AYJ2dF/hMRRnWiytpnIWliRwxTHII7NIuVtmsTU2cvouHe7JE7TV
         2IDQQKw10mgW2PggXEDAM+Srdev+vDTDpAKSBAfWc5Bm8sMgvdV6V+FmoEftpKfwgg
         jwaYdK/BF9wueTa8Vl3FBOQhJx0K3moy0yExuvVxw6h3dyjpCTl+ucjjo5h0rddDSZ
         /9UARZPdb4NWMkxlUCAfrxgDU60pWKE6g4sZOiLeLU9wHPraEFFgWCVk3nCPsmWLV1
         wqaN0q/nZ/JSA==
Date:   Tue, 1 Mar 2022 12:39:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        tangmeng@uniontech.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] ASoC: amd: Fix an ignored error return from
 platform_get_irq_byname()
Message-ID: <Yh4UGGuspsc/gAyY@sirena.org.uk>
References: <20220301064920.37788-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uxmg+A5/E9EeDZt4"
Content-Disposition: inline
In-Reply-To: <20220301064920.37788-1-yang.lee@linux.alibaba.com>
X-Cookie: You have a message from the operator.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uxmg+A5/E9EeDZt4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 01, 2022 at 02:49:20PM +0800, Yang Li wrote:

> -	adata->i2s_irq = platform_get_irq_byname(pdev, "acp_dai_irq");
> -	if (adata->i2s_irq < 0)
> +	adata->i2s_irq = ret = platform_get_irq_byname(pdev, "acp_dai_irq");
> +	if (ret < 0)
>  		return -ENODEV;

If an error code is being returned we should report that error code
rather than squashing it down to -ENODEV.

--uxmg+A5/E9EeDZt4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIeFBcACgkQJNaLcl1U
h9CFbgf/UYP8faM7a5tWC5+cSxh/9F9ahjHk7TXhiiQvjPIoYkrlThUWycOcaTSX
HJieKH2i6j9k3IjeZZcz37jTDi7xrczrqDXCe4KKEd8yx3+Ez7fnVdZIf71ffzKI
mZfaVT4VxwwImIaJRoDnHbx1a607Yj1AjiJz6fCA+s9LpXq8bF/cGd9TDtbdLm25
ya7GoTU3S/tasM1nU30vcvqXc0hBbZtwvt6I99WM24B5V1dxyUw0SUO4lXj59hSe
HipddydH6lpW/GojwROrEyaxawBNaB0W6GXhXkaXOFHw+nUzrILNp+Okjgf1HUS7
w8ZY4LHBFQ70HxHCzWC5/CRChrVCCw==
=rnGn
-----END PGP SIGNATURE-----

--uxmg+A5/E9EeDZt4--
