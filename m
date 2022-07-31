Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939B5585FB7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 18:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237441AbiGaQGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 12:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiGaQGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 12:06:17 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A59465ED;
        Sun, 31 Jul 2022 09:06:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BD791CE0E1D;
        Sun, 31 Jul 2022 16:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC5AC433D6;
        Sun, 31 Jul 2022 16:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659283573;
        bh=+vFal/LdjoTbxx9yuRtd76JF9XeHOgnLz0ofopDkgjY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n+NtQI8dIHBRrBniVbydhInrIWc8jzuZeCvJx3TRJ7Lak2rAR3f3QFB87GH18hqQN
         yx7sZJRvciMBzi0WfQRypIJUnxwHVKmcZ450fN6G0oM/fnZ6UMUylrbBJ1lV5XMQjV
         m2K+B9ZGtzcUNqFR3cree68ndppApja/mRLtJKB7RRwJ6kKjEhVKlE4YBEeC4rEBwg
         vyTFSnVUlsQyb//sAoiInBgGW6J9DAgph3ri+vxWiETewmxkb88p8oz9v5jpUcIGdn
         CtQTEkBrD/MFq+JSqg+70KenALSwtQFHbqCRbH0tIOEGhCFo4rYP3dh1LZLM2ysKVd
         EJmpQ0di9i8mg==
Date:   Sun, 31 Jul 2022 17:16:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] iio: pressure: bmp280: Add support for BMP380
 sensor family
Message-ID: <20220731171624.3d4bb241@jic23-huawei>
In-Reply-To: <50841287411a4e459487cc94a05bc6de66be4acf.1658597501.git.ang.iglesiasg@gmail.com>
References: <cover.1658597501.git.ang.iglesiasg@gmail.com>
        <50841287411a4e459487cc94a05bc6de66be4acf.1658597501.git.ang.iglesiasg@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jul 2022 19:39:44 +0200
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> Adds compatibility with the new generation of this sensor, the BMP380
> 
> Includes basic sensor initialization to do pressure and temp
> measurements and allows tuning oversampling settings for each channel.
> 
> The compensation algorithms are adapted from the device datasheet and
> the repository https://github.com/BoschSensortec/BMP3-Sensor-API
> 
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

Hi Angel,

A comment below. Follows on from comment on previous patch rather than being a
suggestion to change anything in here (beyond what has already been raised by others!)

Jonathan

> +static int bmp380_read_calib(struct bmp280_data *data, unsigned int chip)
> +{
> +	struct bmp380_calib *calib = &data->calib.bmp380;
> +	int ret;
> +	u8 *buf;
> +
> +	buf = kmalloc(BMP380_CALIB_REG_COUNT, GFP_KERNEL);

Ah. The complexity in here explains somewhat why you did it with u8 in the previous
patch.  Probably still better to have a __be16 buffer for that one though
even though we can't do that here.

> +	if (!buf)
> +		return -ENOMEM;
> +
> +	/* Read temperature calibration values. */
> +	ret = regmap_bulk_read(data->regmap, BMP380_REG_CALIB_TEMP_START, buf,
> +			       BMP380_CALIB_REG_COUNT);
> +	if (ret < 0) {
> +		dev_err(data->dev,
> +			"failed to read temperature calibration parameters\n");
> +		kfree(buf);
> +		return ret;
> +	}
> +
> +	/* Toss the temperature calibration data into the entropy pool */
> +	add_device_randomness(buf, BMP380_CALIB_REG_COUNT);
> +
> +	/* Parse calibration data */
> +	calib->T1 = get_unaligned_le16(&buf[BMP380_T1]);
> +	calib->T2 = get_unaligned_le16(&buf[BMP380_T2]);
> +	calib->T3 = buf[BMP380_T3];
> +	calib->P1 = get_unaligned_le16(&buf[BMP380_P1]);
> +	calib->P2 = get_unaligned_le16(&buf[BMP380_P2]);
> +	calib->P3 = buf[BMP380_P3];
> +	calib->P4 = buf[BMP380_P4];
> +	calib->P5 = get_unaligned_le16(&buf[BMP380_P5]);
> +	calib->P6 = get_unaligned_le16(&buf[BMP380_P6]);
> +	calib->P7 = buf[BMP380_P7];
> +	calib->P8 = buf[BMP380_P8];
> +	calib->P9 = get_unaligned_le16(&buf[BMP380_P9]);
> +	calib->P10 = buf[BMP380_P10];
> +	calib->P11 = buf[BMP380_P11];
> +
> +	kfree(buf);
> +	return 0;
> +}
> +
