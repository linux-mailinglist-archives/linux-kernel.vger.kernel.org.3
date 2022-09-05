Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC425ADB6B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 00:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbiIEW3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 18:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiIEW3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 18:29:34 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3457671;
        Mon,  5 Sep 2022 15:29:30 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id o126so604794pfb.6;
        Mon, 05 Sep 2022 15:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=iMJvakssBo0gAAjtWHWcJbCrEyCKBt0JafGAbkGlW1U=;
        b=QMjv2a4EnJEbvvZRJ0gsEmtN4cYNn84VO0z+lruGBVwMLIjJM5vwn055/txaqx05eP
         Bh+UgErE7Sv+MQ1pISaccCRAe+WkuTSLswcuAtDKcZC/KwbDtcACgIgbS4zGkQvXrkpw
         MMrmcIO0+QCbkuO6b7c3UeF53TNoHAZAIZdNTzPsV4a45X6Q9XkPohdLD7CFphMvCgFe
         /y4QWr3ab+7FgtyHPaQU2SYjUHjYB/Ya0uEcvw9JD2f+Z71f9hz5mayt8yLJ6cjXDin7
         qhM6x04savTNUYSI1+tdHw9zpMtogI1aHYE5jrd2KjOlghP6k3+AWB1SaOouf7nCMOzN
         DIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=iMJvakssBo0gAAjtWHWcJbCrEyCKBt0JafGAbkGlW1U=;
        b=o6uEtEOvVgVmLYxc82DDjhqdJQS+FxmtkuovHyXxmYrcZ09mBHsGfEV3ZxMaBFnFiB
         IbUnjVfgJbcgCtcJ726S/KYPjGXM9qs2hKBpEcy9vVUtFiMSSfnz2Qi6klTUt/4i7kjV
         RsygyurOWSSmHwEvtL3O7VsvWiHRSXeRsG4J+UL7bRKEsuFqHX5U7WCrFRGbNErTZt4D
         HlHp6GmMSnleSxwa+bCRQmKhksdS5Hh4pzp+4XdmeNgmnChsFeDdruC/JXJaXvRXeuLS
         3DA76BLim2+nj76w81GBMfeGGrM0I78lIJ8iYFwJRpnfKr1TxLYSLhTyltVEnBgE1sLF
         B/Cw==
X-Gm-Message-State: ACgBeo0Yp7enagBpE6uIJXlMXimuNwVDgfGZIt4EG1hQRpuBNYkDyce2
        lr4XmaC/PgTc4XZYcdS9LuvExS4i8kO4zw==
X-Google-Smtp-Source: AA6agR6DHYZ2KkZ1vnDwyE4qfkyx331LoWn5yv+MwP3LNEMUTBogD+IVgc4sOK8qt6eA36fqd4DrHw==
X-Received: by 2002:a63:a0d:0:b0:42c:2dee:b121 with SMTP id 13-20020a630a0d000000b0042c2deeb121mr33514782pgk.393.1662416970407;
        Mon, 05 Sep 2022 15:29:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q59-20020a17090a4fc100b0020087d7e778sm1425053pjh.37.2022.09.05.15.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 15:29:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 5 Sep 2022 15:29:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, robert.marko@sartura.hr,
        luka.perkov@sartura.hr, jdelvare@suse.com, dev@aboehler.at,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] hwmon: (tps23861) reduce count of i2c transactions
 for port_status
Message-ID: <20220905222928.GA3695028@roeck-us.net>
References: <20220905142806.110598-1-mr.nuke.me@gmail.com>
 <20220905142806.110598-2-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905142806.110598-2-mr.nuke.me@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 09:28:05AM -0500, Alexandru Gagniuc wrote:
> When reading the 'port_status' debugfs entry, some I2C registers were
> read more than once. This looks inefficient in an I2C trace.
> 
> To reduce I2C traffic, update tps23861_port_status_show() to only read
> each register once. Indexing the port number from 0 instead of 1 also
> allows simplifying things a bit, resulting in a negative line count.

"resulting in a negative line count"

That took me a while to understand. Please rephrase or drop.

> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/hwmon/tps23861.c | 75 ++++++++++++----------------------------
>  1 file changed, 22 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/hwmon/tps23861.c b/drivers/hwmon/tps23861.c
> index f7c59ff7ae8e..0dbd12060b50 100644
> --- a/drivers/hwmon/tps23861.c
> +++ b/drivers/hwmon/tps23861.c
> @@ -372,29 +372,12 @@ static const struct hwmon_chip_info tps23861_chip_info = {
>  	.info = tps23861_info,
>  };
>  
> -static char *tps23861_port_operating_mode(struct tps23861_data *data, int port)
> +static char *port_operating_mode_string(uint8_t mode_reg, unsigned int port)
>  {
> -	unsigned int regval;
> -	int mode;
> -
> -	regmap_read(data->regmap, OPERATING_MODE, &regval);
> +	unsigned int mode = ~0;
>  
> -	switch (port) {
> -	case 1:
> -		mode = FIELD_GET(OPERATING_MODE_PORT_1_MASK, regval);
> -		break;
> -	case 2:
> -		mode = FIELD_GET(OPERATING_MODE_PORT_2_MASK, regval);
> -		break;
> -	case 3:
> -		mode = FIELD_GET(OPERATING_MODE_PORT_3_MASK, regval);
> -		break;
> -	case 4:
> -		mode = FIELD_GET(OPERATING_MODE_PORT_4_MASK, regval);
> -		break;
> -	default:
> -		mode = -EINVAL;
> -	}
> +	if (port < TPS23861_NUM_PORTS)
> +		mode = (mode_reg >> (2 * port)) & OPERATING_MODE_PORT_1_MASK;
>  
>  	switch (mode) {
>  	case OPERATING_MODE_OFF:
> @@ -410,15 +393,9 @@ static char *tps23861_port_operating_mode(struct tps23861_data *data, int port)
>  	}
>  }
>  
> -static char *tps23861_port_detect_status(struct tps23861_data *data, int port)
> +static char *port_detect_status_string(uint8_t status_reg)
>  {
> -	unsigned int regval;
> -
> -	regmap_read(data->regmap,
> -		    PORT_1_STATUS + (port - 1),
> -		    &regval);
> -
> -	switch (FIELD_GET(PORT_STATUS_DETECT_MASK, regval)) {
> +	switch (FIELD_GET(PORT_STATUS_DETECT_MASK, status_reg)) {
>  	case PORT_DETECT_UNKNOWN:
>  		return "Unknown device";
>  	case PORT_DETECT_SHORT:
> @@ -448,15 +425,9 @@ static char *tps23861_port_detect_status(struct tps23861_data *data, int port)
>  	}
>  }
>  
> -static char *tps23861_port_class_status(struct tps23861_data *data, int port)
> +static char *port_class_status_string(uint8_t status_reg)
>  {
> -	unsigned int regval;
> -
> -	regmap_read(data->regmap,
> -		    PORT_1_STATUS + (port - 1),
> -		    &regval);
> -
> -	switch (FIELD_GET(PORT_STATUS_CLASS_MASK, regval)) {
> +	switch (FIELD_GET(PORT_STATUS_CLASS_MASK, status_reg)) {
>  	case PORT_CLASS_UNKNOWN:
>  		return "Unknown";
>  	case PORT_CLASS_RESERVED:
> @@ -479,16 +450,9 @@ static char *tps23861_port_class_status(struct tps23861_data *data, int port)
>  	}
>  }
>  
> -static char *tps23861_port_poe_plus_status(struct tps23861_data *data, int port)
> +static char *port_poe_plus_status_string(uint8_t poe_plus, unsigned int port)
>  {
> -	unsigned int regval;
> -
> -	regmap_read(data->regmap, POE_PLUS, &regval);
> -
> -	if (BIT(port + 3) & regval)
> -		return "Yes";
> -	else
> -		return "No";
> +	return (BIT(port + 4) & poe_plus) ? "Yes" : "No";
>  }
>  
>  static int tps23861_port_resistance(struct tps23861_data *data, int port)
> @@ -497,7 +461,7 @@ static int tps23861_port_resistance(struct tps23861_data *data, int port)
>  	__le16 regval;
>  
>  	regmap_bulk_read(data->regmap,
> -			 PORT_1_RESISTANCE_LSB + PORT_N_RESISTANCE_LSB_OFFSET * (port - 1),
> +			 PORT_1_RESISTANCE_LSB + PORT_N_RESISTANCE_LSB_OFFSET * port,
>  			 &regval,
>  			 2);
>  
> @@ -517,14 +481,19 @@ static int tps23861_port_resistance(struct tps23861_data *data, int port)
>  static int tps23861_port_status_show(struct seq_file *s, void *data)
>  {
>  	struct tps23861_data *priv = s->private;
> -	int i;
> +	unsigned int i, mode, poe_plus, status;
> +
> +	regmap_read(priv->regmap, OPERATING_MODE, &mode);
> +	regmap_read(priv->regmap, POE_PLUS, &poe_plus);
> +
> +	for (i = 0; i < TPS23861_NUM_PORTS; i++) {
> +		regmap_read(priv->regmap, PORT_1_STATUS + i, &status);
>  
> -	for (i = 1; i < TPS23861_NUM_PORTS + 1; i++) {
>  		seq_printf(s, "Port: \t\t%d\n", i);

This changes the port number output from 1..4 to 0..3.
Why ? I can understand the code change, but that doesn't mean
the output has to change as well.

Thanks,
Guenter

> -		seq_printf(s, "Operating mode: %s\n", tps23861_port_operating_mode(priv, i));
> -		seq_printf(s, "Detected: \t%s\n", tps23861_port_detect_status(priv, i));
> -		seq_printf(s, "Class: \t\t%s\n", tps23861_port_class_status(priv, i));
> -		seq_printf(s, "PoE Plus: \t%s\n", tps23861_port_poe_plus_status(priv, i));
> +		seq_printf(s, "Operating mode: %s\n", port_operating_mode_string(mode, i));
> +		seq_printf(s, "Detected: \t%s\n", port_detect_status_string(status));
> +		seq_printf(s, "Class: \t\t%s\n", port_class_status_string(status));
> +		seq_printf(s, "PoE Plus: \t%s\n", port_poe_plus_status_string(poe_plus, i));
>  		seq_printf(s, "Resistance: \t%d\n", tps23861_port_resistance(priv, i));
>  		seq_putc(s, '\n');
>  	}
