Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C8C4E8CBC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 05:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbiC1EBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 00:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiC1EBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 00:01:15 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022D5433A3;
        Sun, 27 Mar 2022 20:59:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id DAC9B1F42E3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648439973;
        bh=p5kFKkno7W8Otr+MEWs2MZhZGWjZxlAPNrorp3vcRNg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=My6E3QlN7FcjxmfTvX/c1wcXd90XrxliEgJQI9mTs+dDK4g532bhf6jeJU4cHhpeS
         bDhiVMHbh6agyEwnuI4LY6+5D3nmDjZAtAq4n8K6+nW5xk8kjN84QwhyWW2tHqYLrg
         D3uUGaJKkaWSqWcsxWx6o5F/RLQPjsHxLA/aC3D1EkJnUkhnjB0l6Ua+yzCqW58mhq
         TxfuHpglNpHqReT9r8Z4AJ+38k4i43K6eJ51tVoUzQue6IDPk5/g/foRRJtP0KqlbB
         UyOv/2pFB6XA/O20XhG5+54r6iJ7FJoyeauSdzO/JrzS3v88vWjnj2WxGC9uAhwj35
         OYq/mbx5Dos/w==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        Zhigang.Shi@liteon.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, alvaro.soliverez@collabora.com
Subject: Re: [PATCH 3/3] iio: light: Add support for ltrf216a sensor
Organization: Collabora
References: <20220325103014.6597-1-shreeya.patel@collabora.com>
        <20220325103014.6597-4-shreeya.patel@collabora.com>
Date:   Sun, 27 Mar 2022 23:59:28 -0400
In-Reply-To: <20220325103014.6597-4-shreeya.patel@collabora.com> (Shreeya
        Patel's message of "Fri, 25 Mar 2022 16:00:14 +0530")
Message-ID: <878rsusp5r.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shreeya Patel <shreeya.patel@collabora.com> writes:

> From: Zhigang Shi <Zhigang.Shi@liteon.com>
>
> Add initial support for ltrf216a ambient light sensor.
>
> Datasheet :-
> https://gitlab.steamos.cloud/shreeya/iio/-/blob/main/LTR-F216A-QT.pdf
> +	struct ltrf216a_data *data = iio_priv(indio_dev);
> +
> +	ret = i2c_smbus_write_byte_data(data->client, LTRF216A_MAIN_CTRL, 0);
> +	if (ret < 0)
> +		dev_err(&data->client->dev, "Error writing LTRF216A_MAIN_CTRL\n");
> +
> +	return ret;
> +}
> +
> +static int ltrf216a_set_it_time(struct ltrf216a_data *data, int itime)

ltrf216a_set_int_time instad of it_time?  although, ltr501 also uses
"it" instead of "int" on the function name..

> +
> +static int ltrf216a_get_lux(struct ltrf216a_data *data)
> +{
> +	int greendata, cleardata, lux;
> +
> +	greendata = ltrf216a_read_data(data, LTRF216A_ALS_DATA_0);
> +	cleardata = ltrf216a_read_data(data, LTRF216A_CLEAR_DATA_0);
> +
> +	if (greendata < 0 || cleardata < 0)
> +		lux = 0;
> +	else
> +		lux = greendata * 8 * WIN_FAC / data->als_gain_fac / data->int_time_fac / 10;

This could be rewritten to avoid most of the divisions.

But it also doesn't fit the calculation shown in page 20 on the
datasheet.

I suspect that 8 was calculated from a specific Window Factor (~1.77),
which is specific to one device, but I'm not sure.  The datasheet
formula is:

lux = (ALS_DATA_X * 0.45 * window_factor) / (gain * int_time)

Shouldn't WIN_FAC be a configurable parameter, instead of constant?

-- 
Gabriel Krisman Bertazi
