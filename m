Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DA15112DD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359110AbiD0Hy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359086AbiD0HyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:54:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90387BC18;
        Wed, 27 Apr 2022 00:51:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91D0B61B4E;
        Wed, 27 Apr 2022 07:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB278C385A7;
        Wed, 27 Apr 2022 07:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651045869;
        bh=HRMVX/cZSeuQ1en3SRuormLVu+hlRpib0vf7W7Xrhmg=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=bljyRFBS7KrEI9o5IIH49DPpLQGySAW40Tw0U//0MMq1FD/UKz/Phfrknmr97pATk
         lVeyhoWpE8Mja4PThgMf+ASobPAC9HoasIVNV6lNLOkvxfjFx5ikbaB5B4SXs1FXA1
         vefJTVw+b5wXLjnbkft+WXiW3bhKekK4XbM1jM7LxAV72kK0ZTa01/3I1xEWj2Cv1N
         lRQpr1JIFkTRjy5BHNlV9NzRqi1nY0SR65nCxFtCWksjyiLsT8pUfprdCARYDzS5cf
         XxSeDRcpCrEFa55HW4KeoLQ/sP6LHsI9xD9YfA7DPpoAkQrIge1s4sylNlcv374BuD
         WWRKZFe4YT66A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220427074351.391580-1-juergh@protonmail.com>
References: <20220427074351.391580-1-juergh@protonmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@protonmail.com>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org
From:   Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH v2] crypto: inside-secure - Add MODULE_FIRMWARE macros
Message-ID: <165104586605.3327.5179101284332639573@kwain>
Date:   Wed, 27 Apr 2022 09:51:06 +0200
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Juerg Haefliger (2022-04-27 09:43:51)
> The safexcel module loads firmware so add MODULE_FIRMWARE macros to
> provide that information via modinfo.
>=20
> Signed-off-by: Juerg Haefliger <juergh@protonmail.com>

LGTM, thanks!

Acked-by: Antoine Tenart <atenart@kernel.org>

> ---
> v2:
>  Add legacy fallback firmware locations.
> ---
>  drivers/crypto/inside-secure/safexcel.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/ins=
ide-secure/safexcel.c
> index 9ff885d50edf..9b1a158aec29 100644
> --- a/drivers/crypto/inside-secure/safexcel.c
> +++ b/drivers/crypto/inside-secure/safexcel.c
> @@ -1997,3 +1997,12 @@ MODULE_AUTHOR("Igal Liberman <igall@marvell.com>");
>  MODULE_DESCRIPTION("Support for SafeXcel cryptographic engines: EIP97 & =
EIP197");
>  MODULE_LICENSE("GPL v2");
>  MODULE_IMPORT_NS(CRYPTO_INTERNAL);
> +
> +MODULE_FIRMWARE("ifpp.bin");
> +MODULE_FIRMWARE("ipue.bin");
> +MODULE_FIRMWARE("inside-secure/eip197b/ifpp.bin");
> +MODULE_FIRMWARE("inside-secure/eip197b/ipue.bin");
> +MODULE_FIRMWARE("inside-secure/eip197d/ifpp.bin");
> +MODULE_FIRMWARE("inside-secure/eip197d/ipue.bin");
> +MODULE_FIRMWARE("inside-secure/eip197_minifw/ifpp.bin");
> +MODULE_FIRMWARE("inside-secure/eip197_minifw/ipue.bin");
> --=20
> 2.32.0
>=20
