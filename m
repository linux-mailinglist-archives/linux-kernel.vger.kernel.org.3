Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B50536AC8
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 06:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355678AbiE1EsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 00:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiE1Er5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 00:47:57 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2584B119078;
        Fri, 27 May 2022 21:47:55 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id a13so5792441plh.6;
        Fri, 27 May 2022 21:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8S3M37uPbGO5rXRdk2trr9gknVg0n8BCoIibwzx5alQ=;
        b=l5wZoD2d2hMIkaaH2aX0czFxQDug4LQqhRdts1iA0j2JpU8T75lawgGdRB+QPJTWJe
         QW+o6D7sT4SWofy9VCH5JwSCHVvDRGoGYaymkXNKM3+ZJTAVZoae+0hGpD+iGDjwXv9V
         vhzlYQgAN49ym3CjMQtqSs9raVJg8pe5onLTFZbLtMr/IYyAZHj/D7dKwwmOV5wpwIP2
         Sq6OY8R0ysdQqucHUS9K/k+j659kGgJFt/Tf9DPxi8HuoNLQTFubu3tL50dTa7XQ6fq0
         006R3h3lZgz0WGBtxS6NegOSIlpCIINfYyEz2q4zDcrNrfG5ikCgNvT7nzvkkkV8kJEq
         k9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8S3M37uPbGO5rXRdk2trr9gknVg0n8BCoIibwzx5alQ=;
        b=dk2sB4OZxDXXrSXOlb2UhjdQlhP+3+irDgbctoR3elzB/pRhktd7CxNvJ3a3yagaas
         DHWKS0dfalhjE+NCM1Au2RNnT2K937rkcuATzjukxjZG3KczxTsnXEVlRw1tJfDocb6i
         6KXL3QBrqoGkMIzBj+j/n0WFVmTnoc50qF7H3MQWHDe4ERVDRjVNv45J5rP2k0b4RDhR
         QjuVUtsOG3gJAW92Oq4Qk+lGbDonN0MfpY2r+5j2F/kHx5NRc2DG6vLEB3QfQ0YxD7CI
         lp+sFyu6QfnmGKeySQNA/Z9Vv4UaydtIq57i19FIWoXsoIoMTBriCv1eXqjQMZA3Jdl8
         rrPA==
X-Gm-Message-State: AOAM532H7YufOi9Kq3b/FaQNrALVA/n/I7Xv69yCwznEtzK2eM3IAsdN
        ScvOBN5dfX6eI6r7AEN4wOU=
X-Google-Smtp-Source: ABdhPJwBJ74idShOOJxPq4uhVfdIOw1V+5HqA2+AAGDkBN6lNZf4/kaDirB/Y2JyC97hk4wdLjZBIw==
X-Received: by 2002:a17:902:76c4:b0:163:70e2:5a65 with SMTP id j4-20020a17090276c400b0016370e25a65mr13020891plt.119.1653713274391;
        Fri, 27 May 2022 21:47:54 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:331d:9bef:6841:67a4])
        by smtp.gmail.com with ESMTPSA id n8-20020a638f08000000b003f27f91135asm4341442pgd.76.2022.05.27.21.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 21:47:52 -0700 (PDT)
Date:   Fri, 27 May 2022 21:47:50 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, martink@posteo.de,
        geert+renesas@glider.be, john@metanate.com, hechtb@gmail.com
Subject: Re: [PATCH] Input: st1232 - Support power supply regulators
Message-ID: <YpGpdsAJicTqHbeY@google.com>
References: <20220524081216.8550-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524081216.8550-1-mike.looijmans@topic.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Tue, May 24, 2022 at 10:12:16AM +0200, Mike Looijmans wrote:
> Add support for the VDD and IOVDD power supply inputs. This allows the
> chip to share its supplies with other components (e.g. panel) and manage
> them.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
>  .../input/touchscreen/sitronix,st1232.yaml    |  6 +++
>  drivers/input/touchscreen/st1232.c            | 54 ++++++++++++++++---
>  2 files changed, 52 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
> index 1d8ca19fd37a..240be8d49232 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
> @@ -28,6 +28,12 @@ properties:
>      description: A phandle to the reset GPIO
>      maxItems: 1
>  
> +  vdd-supply:
> +    description: Power supply regulator for the chip
> +
> +  vddio-supply:
> +    description: Power supply regulator for the I2C bus
> +
>  required:
>    - compatible
>    - reg
> diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
> index e38ba3e4f183..d9c9f6f1f11a 100644
> --- a/drivers/input/touchscreen/st1232.c
> +++ b/drivers/input/touchscreen/st1232.c
> @@ -44,6 +44,11 @@
>  #define REG_XY_COORDINATES	0x12
>  #define ST_TS_MAX_FINGERS	10
>  
> +enum st1232_regulators {
> +	ST1232_REGULATOR_VDD,
> +	ST1232_REGULATOR_IOVDD,
> +};
> +
>  struct st_chip_info {
>  	bool	have_z;
>  	u16	max_area;
> @@ -56,6 +61,7 @@ struct st1232_ts_data {
>  	struct touchscreen_properties prop;
>  	struct dev_pm_qos_request low_latency_req;
>  	struct gpio_desc *reset_gpio;
> +	struct regulator_bulk_data regulators[2];
>  	const struct st_chip_info *chip_info;
>  	int read_buf_len;
>  	u8 *read_buf;
> @@ -197,17 +203,36 @@ static irqreturn_t st1232_ts_irq_handler(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static void st1232_ts_power(struct st1232_ts_data *ts, bool poweron)
> +static int st1232_ts_power_on(struct st1232_ts_data *ts)
> +{
> +	int err;
> +
> +	err = regulator_bulk_enable(ARRAY_SIZE(ts->regulators), ts->regulators);
> +	if (err)
> +		return err;

Does it really make sense to try and handle regulators when reset gpio
is not defined? Would it not be better to tie them to the presence of
reset gpio to make sure we implement proper power on sequence?

> +
> +	usleep_range(5000, 6000);
> +
> +	if (ts->reset_gpio)
> +		gpiod_set_value_cansleep(ts->reset_gpio, 0);
> +
> +	return 0;
> +}

Thanks.

-- 
Dmitry
