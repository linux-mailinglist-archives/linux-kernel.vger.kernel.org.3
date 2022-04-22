Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D186150AD16
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 03:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443017AbiDVBPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 21:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239067AbiDVBPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 21:15:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1933DA46;
        Thu, 21 Apr 2022 18:12:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58ADD61F33;
        Fri, 22 Apr 2022 01:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A23C385A5;
        Fri, 22 Apr 2022 01:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650589936;
        bh=zhQgvXCryollAplHlU4CKPjqUdfvQEM7EDyQVK1DhIc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=rQPURcUAVq92GVenBMBppahlnmUWPwxc80arUjdr3sv5Tx2hLiTyCPRrk+3m52I/X
         jUsxHNHoH5J+GzjUSlV8MSS+OjZ1UvT40k0c4eMMNhqYA6/D+Y3aAr9DwhllCS0PBA
         dT3QF81FGHmhb9r7j2/BFVbJh1hlYf7ZMHYfcNSPY1hubzidTzi3oDloePxkxU4mYR
         8WPFXWvTCy3SgX4DmopI8jSDSGaDX2+A6AhWFk79AGh48APuVmc5U63YgCOECVI+FQ
         oxXO2saDQVfLbYD/cxHPOZOxd65Vbdul7nAfqBmupkFRZGYXKhJM0xCO3/EbkOUQnV
         Mp+OjkdRqT4cQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220413071318.244912-1-codrin.ciubotariu@microchip.com>
References: <20220413071318.244912-1-codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH] clk: at91: generated: consider range when calculating best rate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 21 Apr 2022 18:12:14 -0700
User-Agent: alot/0.10
Message-Id: <20220422011216.A4A23C385A5@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Codrin Ciubotariu (2022-04-13 00:13:18)
> clk_generated_best_diff() helps in finding the parent and the divisor to
> compute a rate closest to the required one. However, it doesn't take into
> account the request's range for the new rate. Make sure the new rate
> is within the required range.
>=20
> Fixes: 8a8f4bf0c480 ("clk: at91: clk-generated: create function to find b=
est_diff")
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---

Is this fixing anything real or it's just a thing that you noticed and
sent a patch to fix?

>  drivers/clk/at91/clk-generated.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-gene=
rated.c
> index 23cc8297ec4c..d429ba52a719 100644
> --- a/drivers/clk/at91/clk-generated.c
> +++ b/drivers/clk/at91/clk-generated.c
> @@ -117,6 +117,10 @@ static void clk_generated_best_diff(struct clk_rate_=
request *req,
>                 tmp_rate =3D parent_rate;
>         else
>                 tmp_rate =3D parent_rate / div;
> +
> +       if (tmp_rate < req->min_rate || tmp_rate > req->max_rate)
> +               return;
> +
>         tmp_diff =3D abs(req->rate - tmp_rate);
> =20
>         if (*best_diff < 0 || *best_diff >=3D tmp_diff) {
