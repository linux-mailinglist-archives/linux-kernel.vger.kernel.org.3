Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7545693EB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbiGFVJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbiGFVJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:09:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F7311446;
        Wed,  6 Jul 2022 14:09:43 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-232.nat.spd-mgts.ru [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D316B66019AA;
        Wed,  6 Jul 2022 22:09:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657141781;
        bh=zU7+vGNULbAoKugsQooNwRb5lIpQX1+E+hN6Rxf1NZ4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=l8hWnXn7GJlmYRkYtHUCZISwiiZBf3GyRtDfd8e9dD+UYgiW5v83DnfbdeubY5idQ
         Fp39UW9NFi931zqyujyYmk5wL0j5tz/S9Q3L0yLwyXKR9kooNvmujpojwVRXtK9dwC
         ly9loAn1xgY65t4LrrtmwJRVd/V82wW//88jtxVEigM35zUyBu+5xVfJwveVv+1GHx
         YLTeqfAzcLNJQwmNL0MaUChUPj2oHpdaw3bhhW0NaKz99O0/2oZr7kQ2QV63IZwvD3
         qVoRketyk3hYyIMeFMHyZSW8BNVPSCXkV2GVZ5S+ALEO3h2kMuekkvO8qfn81VXiQC
         ZJLPZ8HpVWnog==
Message-ID: <60b6965b-7a14-8b7c-c9b9-c463fc0ad88c@collabora.com>
Date:   Thu, 7 Jul 2022 00:09:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 2/2] iio: light: Add support for ltrf216a sensor
Content-Language: en-US
To:     Shreeya Patel <shreeya.patel@collabora.com>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, Zhigang.Shi@liteon.com,
        krisman@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com, andy.shevchenko@gmail.com,
        digetx@gmail.com, kernel test robot <lkp@intel.com>
References: <20220615135130.227236-1-shreeya.patel@collabora.com>
 <20220615135130.227236-3-shreeya.patel@collabora.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220615135130.227236-3-shreeya.patel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 16:51, Shreeya Patel wrote:
> +static int ltrf216a_probe(struct i2c_client *client)
> +{
> +	struct ltrf216a_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	mutex_init(&data->lock);
> +
> +	indio_dev->info = &ltrf216a_info;
> +	indio_dev->name = LTRF216A_DRV_NAME;
> +	indio_dev->channels = ltrf216a_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ltrf216a_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	/* reset sensor, chip fails to respond to this, so ignore any errors */
> +	ltrf216a_reset(indio_dev);

Shouldn't SW resetting be done after enabling sensor? Perhaps that's why
it fails to respond?

-- 
Best regards,
Dmitry
