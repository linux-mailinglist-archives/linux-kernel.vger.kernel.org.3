Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB5947B2DC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 19:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240451AbhLTSaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 13:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbhLTSaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 13:30:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80021C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 10:30:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CB8EB80E28
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 18:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57046C36AEA;
        Mon, 20 Dec 2021 18:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640025019;
        bh=wnRZGhr/r/oJHJL61vyyNk0oYJYUQaMZIvGBf4zvo+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WAi0AWA0wN8e6lLUJs/sXyx++lDqDbsdiGmll6uai/+xHuSNqt/PMepdHoUbLkber
         h+0mKoeSyXlDaQj4FvT+7UGjwP7llLNwarnzEUrsnQhZVWXPgqOwF09XAn0KqikE/d
         J0IvC6EbEMC1uNn20Hxs1IjTVYuI3K0LXVar0XSmzeZKkCWgeBrF0IDgJzu+4xEGtT
         0l9mqY8hA5xhOvpGnIB+v7jWSuhs2MscIW+5DxsTbxL4dzad6boFGgzpmV8M/qiySM
         NXLinuzvb4y0s33jfZNgV272C1lmCx+XG4YuOfF6NqlZRY8CpNuyGdB49G/CaPqLxN
         KOOjPAzGgZuIQ==
Date:   Mon, 20 Dec 2021 18:30:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Michal Simek <michal.simek@xilinx.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: bcm: Use platform_get_irq() to get the
 interrupt
Message-ID: <YcDLtMc6QR1kezmE@sirena.org.uk>
References: <20211219181039.24812-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211219181039.24812-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FbpY6masRNdhN5aX"
Content-Disposition: inline
In-Reply-To: <20211219181039.24812-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Cookie: The worst is enemy of the bad.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FbpY6masRNdhN5aX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 19, 2021 at 06:10:39PM +0000, Lad Prabhakar wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.

This doesn't compile for at least x86_64 allmodconfig:

/mnt/kernel/sound/soc/bcm/bcm63xx-pcm-whistler.c: In function 'bcm63xx_soc_platform_probe':
/mnt/kernel/sound/soc/bcm/bcm63xx-pcm-whistler.c:395:11: error: implicit declaration of function 'irq_get_trigger_type' [-Werror=implicit-function-declaration]
  395 |           irq_get_trigger_type(ret), "i2s_dma", (void *)i2s_priv);
      |           ^~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

--FbpY6masRNdhN5aX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHAy7QACgkQJNaLcl1U
h9B8HggAhVFxJhvNQGCBqKTFplNumBkXJngY8gVvGpUD+3Swi9w1W0NUUXgHyWU8
dNSvmIaE4wMkLpMfFtc798MSbKmSVIa8vA+dZ7kmEVBa4mHuqUzggoIF6+mBqkJg
KgNXFNlws74EJdUnOcBH1L0e3eAm7XNSKVb2ajZNTj1+tUZT7i8KRBFQVT0K4dLO
K063q4v8izIXxQpPOtc3sENNr0KIh/keI0TlvuLNmH+0C0lOJezaD6yeiaJaC2v/
R5n8ggf6406QZMnniXYHjLPd7WfjNfDoxuRIQECJOyvpFznPsWlVm0ckZ/Qki5IT
u1vUaDc3+LsWEb21yQL7yosZ70Xdvg==
=/p0n
-----END PGP SIGNATURE-----

--FbpY6masRNdhN5aX--
