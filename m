Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3266D5A1928
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243569AbiHYSxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243544AbiHYSxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:53:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D83B516C;
        Thu, 25 Aug 2022 11:53:15 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-13.nat.spd-mgts.ru [109.252.119.13])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 21A4B6601EAE;
        Thu, 25 Aug 2022 19:53:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661453594;
        bh=35eR4SmNOnxsneefZSjC8myV+5WcAzcuLRSjIAQ0igs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PmVU/LPHdSBzeOb0JFlglye4sv4VgCDZPPwdyiSWOXfs3Ty+Uh2TIoPGFO3ehQRYR
         exiL8ZpCMigtP0M2HpdH60t5c+o2s0BqmaXjTZbtI07EoYDHgUmn8VnQ7IgS9ls50B
         cYU7wrBCQ5bGh/yD6HFaVRo7Z2kcl7l4KJkMG6G3CI/s+1qMPa9+P1ilnQadS4Ck0N
         kvvKjzVBahduvk+xlkXv3hlXmb+9O2fW/vAs85ejGufbruMaB0Od5ngpWegXmqh8s7
         XoOCOIyVMqmpO30lTYNdspi48ssncO8pNfnPpFyCI/75rI6IbvgHaAhmBS8zgSzf63
         R4etMaDIM9Muw==
Message-ID: <793d9ca8-47af-2f3d-6079-e0bbb8e7d898@collabora.com>
Date:   Thu, 25 Aug 2022 21:53:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] iio: light: tsl2583: Fix module unloading
Content-Language: en-US
To:     Shreeya Patel <shreeya.patel@collabora.com>, jic23@kernel.org,
        lars@metafoo.de
Cc:     krisman@collabora.com, kernel@collabora.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220825092048.136973-1-shreeya.patel@collabora.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220825092048.136973-1-shreeya.patel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/25/22 12:20, Shreeya Patel wrote:
> tsl2583 uses devm_iio_device_register() function and
> calling iio_device_unregister() in remove breaks the
> module unloading.
> Fix this by removing call to iio_device_unregister()
> from tsl2583_remove().
> 
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>

Stable and fixes tags are missing

> ---
>  drivers/iio/light/tsl2583.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
> index 82662dab87c0..36c25f79e6a6 100644
> --- a/drivers/iio/light/tsl2583.c
> +++ b/drivers/iio/light/tsl2583.c
> @@ -878,8 +878,6 @@ static int tsl2583_remove(struct i2c_client *client)
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  	struct tsl2583_chip *chip = iio_priv(indio_dev);
>  
> -	iio_device_unregister(indio_dev);
> -
>  	pm_runtime_disable(&client->dev);
>  	pm_runtime_set_suspended(&client->dev);
>  

Driver removal sequence should be opposite to the registration order.
Could be better not to use the devm in this case.

-- 
Best regards,
Dmitry
