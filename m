Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D684DD7CE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbiCRKQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbiCRKPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:15:51 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F9D122996
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=C36zEMNSdev/DAu0BCtj7AW7JfU0
        pw9J2U3bRNfcxa0=; b=xAm+A5eMID7H7nDHXTCWlD3uMBiSd/9+beKehSe9u6Lj
        ty8yB+DR8HWCUtEV2PD9RM/FWaQXKmQmv2osR1SbwLfReNUwOj1cyMyOsgn7wPi8
        xsXFSyU7gSuw/c1TgQyX+JY6xVrLo8fpxH6HVpFwu60mVw54lhvoDK3a5d+dIhQ=
Received: (qmail 3854432 invoked from network); 18 Mar 2022 11:14:06 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Mar 2022 11:14:06 +0100
X-UD-Smtp-Session: l3s3148p1@FwEaaHvahhBZD+8H
Date:   Fri, 18 Mar 2022 11:14:05 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Dung Nguyen <dung.nguyen.zy@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Mark Brown <broonie@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] memory: renesas-rpc-if: Fix HF/OSPI data transfer in
 Manual mode
Message-ID: <YjRbbbn9U9bff48m@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Dung Nguyen <dung.nguyen.zy@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <b409ea3fae4a6778fd6b44815ad17c9e8e10df87.1647512831.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OtcT9K0vzTCh0l+F"
Content-Disposition: inline
In-Reply-To: <b409ea3fae4a6778fd6b44815ad17c9e8e10df87.1647512831.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OtcT9K0vzTCh0l+F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Geert,

thank you for the patch!

> Lightly (read-only) tested on:
>   - Salvator-XS with R-Car M3-W ES1.0 with HyperFLASH,
>   - Falcon with R-Car V3U ES1.0 with QSPI.

I (also lightly) tested writing on the V3U and it seems to still work,
even with the problematic cases we needed to fix earlier.

>       Note: Alternatively, rpcif_manual_xfer() could bypass regmap and
>       use {read,write}[bwl]() directly, cfr. commit 0d37f69cacb33435
>       ("memory: renesas-rpc-if: Correct QSPI data transfer in Manual
>       mode") in the BSP.

As discuseed via IRC, I don't like bypassing regmap. I prefer your
solution here.

> @@ -171,18 +171,32 @@ static int rpcif_reg_read(void *context, unsigned int reg, unsigned int *val)

Before this function is a comment which needs to be updated (away from
SMENR_SPIDE to xfer_size).

> +		switch (rpc->xfer_size) {
> +		case 1:
>  			*val = readb(rpc->base + reg);
>  			return 0;
> -		} else if (spide == 0xC) {
> +
> +		case 2:
>  			*val = readw(rpc->base + reg);
>  			return 0;
> -		} else if (spide != 0xF) {
> +
> +		case 4:
> +		case 8:

I think it is more readable to add here:

  			*val = readl(rpc->base + reg);
  			return 0;

> +			break;

... and remove this break ...


> +
> +		default:
>  			return -EILSEQ;
>  		}
> +		break;

... and this one. Same for the write function. I am not strict on this
one, but I think this make following the logic easier.

Rest looks good. I like the additional checks!

All the best,

   Wolfram


--OtcT9K0vzTCh0l+F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmI0W2kACgkQFA3kzBSg
KbYjPBAAnH/w2JDoX3xlZOOeiOYsVAWlR7R19tb/2I8echT/IqHjega4sm1hq5bj
KWyrKP5f9aPR/GpFTSDIA1OByx/xQtqkjdCQYH2uMA3Svpc4j2tPb99m2irc6N35
PO1XXiHoszB7t7WQlVbgovRo1eqkMCGaPOuNjHS2mtQe40HTEG4/i9j5MSjPmD7H
vhXOth7tqgy30UTyTUkTvUAdaeRY5NBwN0IMqLmDPLs53YSbmiBD2NXYntBfJtNw
la7yyHCF2YU9cuvcES21D1nFLZx6BQrkqTXtkz0UYYz/RDAlX8P7IOE31Mxr6ChW
v4ni0aqD4NunTnHAZvft2noaXQ9uq74kYiFVpEbpKYox5ZfF1gpY1yXZOOKkxYZu
ISAMdLE9CPZJapvvqEsOADIcM81YPCwsUqa0Ui6gKN/mfo/aJ6B/zOXiLf2K10Gr
V2MLlLcPrA3AiHFc1KTJa/ANRITAlOuNxVhZF09enaTSr5FED+Yu7thW8s1WiMSu
QMH+NIxfKpY8aIAnOeMVQ62PefIeyk+wWX/mRA/1WzxTmMdNk6QP9uEsQPgRs1yC
vD9HxE8zEqwnpbdUeGlpzC51CGuTwctTGot/nfiA97oeQSAVxLi3JAWAApZRZ/mn
Zj30/lWOeAH8vBGhBeMmLfCX1B8bKX+2W683pyr4cHDKFo7TXT4=
=7DDp
-----END PGP SIGNATURE-----

--OtcT9K0vzTCh0l+F--
