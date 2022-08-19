Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EEB59A4CB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351072AbiHSRnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354697AbiHSRml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:42:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99891133A4C;
        Fri, 19 Aug 2022 10:01:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0882F617C7;
        Fri, 19 Aug 2022 17:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D991C433B5;
        Fri, 19 Aug 2022 17:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660928509;
        bh=O5aPB64MRuuVf6y9WVzczPShckhm/cZfEc0YAuq8dDs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JV4dbJxPPXjyoF+4bqMneL9I1M423zOu4WvyE3jhYcifaOCedSxsBTgyaTYgTOxjy
         3SPO5kfdFp6nMRtSPppgzAUvUJ807J8Hd8GO3T0u4QBEpJ2fL0GiW2h442+ehtoufK
         zp0wbi1+nfE5DmpGF7hIoF1XcvWBQK8FD2Ss2hSIZn7ot4fhNXqggtZ9BF+D+2UBFI
         RI06wl/iOljj/B6v5ds8pmXnbi4ke9l8hs51DlSisnxSFnCVZHSDS6ua0UTJeGQKpg
         Q7k9Vw8gtZ0XpH/RSt3lX14bwY5NCTXyF3m1z0krwx7ps2bbLwCiYxvS1bbPKDAUyS
         WZfZEtEaet5QA==
Date:   Fri, 19 Aug 2022 18:12:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: ad7292: Prevent regulator double disable
Message-ID: <20220819181225.3f6851d1@jic23-huawei>
In-Reply-To: <Yv9O+9sxU7gAv3vM@fedora>
References: <Yv9O+9sxU7gAv3vM@fedora>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2022 11:51:07 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The ad7292 tries to add an devm_action for disabling a regulator at
> device detach using devm_add_action_or_reset(). The
> devm_add_action_or_reset() does call the release function should adding
> action fail. The driver inspects the value returned by
> devm_add_action_or_reset() and manually calls regulator_disable() if
> adding the action has failed. This leads to double disable and messes
> the enable count for regulator.
> 
> Do not manually call disable if devm_add_action_or_reset() fails.
> 
> Fixes: 506d2e317a0a ("iio: adc: Add driver support for AD7292")
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
Good spot. Applied to the fixes-togreg branch of iio.git
and marked for stable.

Jonathan

> ---
> 
> The bug was found during browsing the code. I don't have the hardware to
> test this so reviewing and testing is highly appreciated.
> ---
>  drivers/iio/adc/ad7292.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7292.c b/drivers/iio/adc/ad7292.c
> index 92c68d467c50..a2f9fda25ff3 100644
> --- a/drivers/iio/adc/ad7292.c
> +++ b/drivers/iio/adc/ad7292.c
> @@ -287,10 +287,8 @@ static int ad7292_probe(struct spi_device *spi)
>  
>  		ret = devm_add_action_or_reset(&spi->dev,
>  					       ad7292_regulator_disable, st);
> -		if (ret) {
> -			regulator_disable(st->reg);
> +		if (ret)
>  			return ret;
> -		}
>  
>  		ret = regulator_get_voltage(st->reg);
>  		if (ret < 0)

