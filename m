Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB00591FFA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 16:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238880AbiHNOEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 10:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiHNOEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 10:04:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8239260F;
        Sun, 14 Aug 2022 07:04:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BD90601C5;
        Sun, 14 Aug 2022 14:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01197C433D6;
        Sun, 14 Aug 2022 14:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660485885;
        bh=Ly4O0mOylSo1e7bqqPQz8OkjRFjE9+N+Pi2tqeszdVs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IhSUvjJSY0EH+ADokfbq1kq4yEhlNsCMNMUa+AWc++XxuWiT8mX4++apsCN4eS89V
         7JiYEzebDW31JM+MJuNH7XNUOuL7/ynYQ/5MXKjtEr+z62f2euYdzih7fPOf/+V5lj
         PvKb5VeO6CEXMqbmrBPAaeCtjrtmGr6EsndDdnbpmNUeTothXTVM7FpzbWF/Y1UQal
         u1gx/I+5CVCsP4kzpPWdClf0ymiz6GInqCsQLEyjXIp7w1mK8zoT0aeFi+1rgkh3ss
         lVWdFXG+80UQyAvrSQOiOgP1E+vbes/88LmBnQY3Zi2oPn/BW8p1mvnFO6iYM+onRd
         flYQbbW/sq5xQ==
Date:   Sun, 14 Aug 2022 15:15:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] iio: pressure: bmp280: Add support for BMP380
 sensor family
Message-ID: <20220814151512.097c7779@jic23-huawei>
In-Reply-To: <462251c4bca30b53f06307043ad52d859eb8d5c1.1659872590.git.ang.iglesiasg@gmail.com>
References: <cover.1659872590.git.ang.iglesiasg@gmail.com>
        <462251c4bca30b53f06307043ad52d859eb8d5c1.1659872590.git.ang.iglesiasg@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  7 Aug 2022 13:55:52 +0200
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

One additional comment from me inline.

Thanks,

Jonathan


>  	}
> @@ -1124,6 +1471,13 @@ int bmp280_common_probe(struct device *dev,
>  		return -EINVAL;
>  	}
>  
> +	/* BMP3xx requires soft-reset as part of initialization */
> +	if (chip_id == BMP380_CHIP_ID) {

I'd prefer this to be based on a flag in chip_info so that we can
trivially add it to future devices by just setting that flag for the
chip_info added for the new device.

> +		ret = bmp380_cmd(data, BMP380_CMD_SOFT_RESET);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	ret = data->chip_info->chip_config(data);
>  	if (ret < 0)
>  		return ret;

