Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCE85499CB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbiFMRWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241346AbiFMRWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:22:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2175B31206;
        Mon, 13 Jun 2022 05:37:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 812B8B80D5F;
        Mon, 13 Jun 2022 12:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE52AC34114;
        Mon, 13 Jun 2022 12:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655123839;
        bh=UMvOIPZylUDWOPgDJ/rl41H35ct9oHGP3/eHpRwcWOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WzXjo5MSmOk9g72+Nf19OcnSzaHjqiB72gyem2FudjwA4PJI8wgxZxF58TIuUyZXw
         r7hHelOpg55WPF5O1myAJKx/XwqxWjW4tfEZuGUT3YQTT+8ZsQllNHwAoFpDYhxUJ5
         +zHAd/O/gKOj2Ca2obgMr5fAoTk4i3FjFBvgqkIqGP09y2GGP0V35cUpmOKrzU7JC7
         3HjiZZ6iUJWxpI+/FtkT6QT59Xq+AvnCS239YV7MRNJA+gfSmUAS0f3DHwwBfdB+fg
         ROGveSAXpy8ONgbjKX6ROejQ4JJQxQ+MWqi/PPBvPEdjMiKNpEDDgU6PH8z1br52Yr
         GsaB8IbNBZBTw==
Date:   Mon, 13 Jun 2022 13:37:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jon Lin <jon.lin@rock-chips.com>
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: rockchip: Disable local irq when pio write out of
 interrupt service
Message-ID: <YqcveggUU7yaXuk1@sirena.org.uk>
References: <20220613092744.9726-1-jon.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YJipID2wFlKZ6wCT"
Content-Disposition: inline
In-Reply-To: <20220613092744.9726-1-jon.lin@rock-chips.com>
X-Cookie: innovate, v.:
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YJipID2wFlKZ6wCT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 13, 2022 at 05:27:44PM +0800, Jon Lin wrote:
> Avoid interrupt come and interrupt the pio_writer.
>=20
> +	spin_lock_irqsave(&rs->lock, flags);
> +	tx_free =3D rs->fifo_len - readl_relaxed(rs->regs + ROCKCHIP_SPI_TXFLR);
> +	words =3D min(rs->tx_left, tx_free);
>  	rs->tx_left -=3D words;
>  	for (; words; words--) {
>  		u32 txw;
> @@ -308,6 +313,7 @@ static void rockchip_spi_pio_writer(struct rockchip_s=
pi *rs)
>  		writel_relaxed(txw, rs->regs + ROCKCHIP_SPI_TXDR);
>  		rs->tx +=3D rs->n_bytes;
>  	}
> +	spin_unlock_irqrestore(&rs->lock, flags);

So this is effectively just disabling interrupts during PIO, there's no
other users of the lock which is rather heavyweight.  What's the actual
issue here?  We should also have something saying what's going on in the
code since right now the lock just looks redundant.

--YJipID2wFlKZ6wCT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKnL3kACgkQJNaLcl1U
h9DoiAf/b64OqEDIdLubTDZqH06s6sri2Q8Bq4h69DmbLEXUe2ciQ52gVQ7JQKaQ
ZXxCS8HlRTroirPGfdcwOByaUWEW9DIMO1nrqU0wRytXkeuVj/dfA+6jQBkKaUIy
cM7lgZdxMTZ5ezuXKvPmzFUaWQvgRGDI4wybCd++7eFgj+bx5l9g3YODTUfVmFVo
mQbqkP3l/ovLgVz11vw7aiqYLpQQ+dDDNMx7alWOayLxypGTGA03xF/3LlzbFG84
OAF0d2cTKHC9Ok7T6bCJzRufu6ZPrmnD85MiDEVoGGE3oAetE7xthoSgUxES0KAn
0bFz4uLtQdcxXeJSrCqeQtCjiNJ5gg==
=bWwU
-----END PGP SIGNATURE-----

--YJipID2wFlKZ6wCT--
