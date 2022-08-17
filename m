Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A559059733F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237909AbiHQPlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbiHQPlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 11:41:12 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEBA883E5;
        Wed, 17 Aug 2022 08:41:11 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c2so3951689plo.3;
        Wed, 17 Aug 2022 08:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=//hM187uU1jIsnzsJQUuCUh/1TSYrgFOX6cDWgG4Ji4=;
        b=QfZK2LMzqz+Op9YY+CHw+q2ARD4vwF8goGqGFtNGzRCU0FIQ/mubstB/m5PPm4zoUD
         HVSFZo40bjk9yqJqvFHKkuqW/gi2onEz6JFHpV+NOoTDMAEO0bTKjWsLXxU8nu9TXGDa
         G4diSfYUAJMfAvFQCRiN8I5fagaSe6GetJ0uEGEfA9BEsF+dyrNNacVfTX8JWMOLYQnX
         b0c9mdtU81yeLnvf3n5hoa/EyzLHWIO/RaM0a7tVYldwt0/vEccU8cSG8jOewqGkcnhw
         8k/wFobjDR2fCn8Bl7XP6tW2jjbQdbaBM/EZQluAS8tYm+mpjxjpv04t5WXrMoDMqLbs
         hJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=//hM187uU1jIsnzsJQUuCUh/1TSYrgFOX6cDWgG4Ji4=;
        b=pMn7+L2ppT049rczBHFxAB70UwsKF1GqV9AKGvoIY9zJ8Ti01ZMCEfkEfWH4mbfiU/
         YfbtGqnAR7y2E6Py8OSgvKeXP8BVpa/SGKhD7Ca8SrLfcedSBKJG0YHK+KRSyclU0l4K
         J0EG2u++1Toj/9MMHSUQU4JjgB6vZ0OZ4PbdGpc+bhkiDbTKZKMe3oj3y2rc0qdLZns5
         yle4pRsjniOwyCQqCjisVyG/lAzAAWYG14LqUUzpERzL9nLIRFUxOg7JQ0rNnddW7DE3
         D+jWnsLdg4hRtvZpXVnREc36HrJQe4l0iz4rAO/4WweduUh9+v8VuS6s475ksIfUcVa6
         mTPg==
X-Gm-Message-State: ACgBeo1vDJ2Yr+KzRO5Yo86rSeKCh+IUo06BOGu7zTH1B2I7q0RDmNP7
        PSld2Z6WixO4H7CVAADYSe38WA3XY4A=
X-Google-Smtp-Source: AA6agR6xJov5jyp1OYE8dRNM1g8gUNraX8zrEgGOpNqh5gxHlP6ZyQVKLkipVKg+OO8wmSvUUAJ3/A==
X-Received: by 2002:a17:902:ce8e:b0:16f:8f2b:b16f with SMTP id f14-20020a170902ce8e00b0016f8f2bb16fmr26618976plg.167.1660750870779;
        Wed, 17 Aug 2022 08:41:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id mi4-20020a17090b4b4400b001f52fa1704csm6519779pjb.3.2022.08.17.08.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 08:41:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 17 Aug 2022 08:41:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: corsair-psu: add reporting of rail mode via
 debugfs
Message-ID: <20220817154108.GA1409194@roeck-us.net>
References: <YvS9PZKr0xqFqJny@monster.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvS9PZKr0xqFqJny@monster.localdomain>
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

On Thu, Aug 11, 2022 at 08:26:37AM +0000, Wilken Gottwalt wrote:
> Add reporting if the PSU is running in single or multi rail mode via
> ocpmode debugfs entry. Also update the documentation and driver comments
> accordingly.
> 
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> Changes in v3:
>   - added more explanations in the driver
> 
> Changes in v2:
>   - fixed spelling issues in commit message
> ---
>  Documentation/hwmon/corsair-psu.rst |  5 +++--
>  drivers/hwmon/corsair-psu.c         | 29 ++++++++++++++++++++++++++++-
>  2 files changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/hwmon/corsair-psu.rst b/Documentation/hwmon/corsair-psu.rst
> index e8378e7a1d8c..c3a76305c587 100644
> --- a/Documentation/hwmon/corsair-psu.rst
> +++ b/Documentation/hwmon/corsair-psu.rst
> @@ -86,8 +86,9 @@ Debugfs entries
>  ---------------
>  
>  =======================	========================================================
> -uptime			Current uptime of the psu
> +ocpmode                 Single or multi rail mode of the PCIe power connectors
> +product                 Product name of the psu
> +uptime			Session uptime of the psu
>  uptime_total		Total uptime of the psu
>  vendor			Vendor name of the psu
> -product			Product name of the psu
>  =======================	========================================================
> diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> index 14389fd7afb8..c99e4c6afc2d 100644
> --- a/drivers/hwmon/corsair-psu.c
> +++ b/drivers/hwmon/corsair-psu.c
> @@ -55,6 +55,7 @@
>  #define SECONDS_PER_DAY		(SECONDS_PER_HOUR * 24)
>  #define RAIL_COUNT		3 /* 3v3 + 5v + 12v */
>  #define TEMP_COUNT		2
> +#define OCP_MULTI_RAIL		0x02
>  
>  #define PSU_CMD_SELECT_RAIL	0x00 /* expects length 2 */
>  #define PSU_CMD_RAIL_VOLTS_HCRIT 0x40 /* the rest of the commands expect length 3 */
> @@ -71,9 +72,10 @@
>  #define PSU_CMD_RAIL_WATTS	0x96
>  #define PSU_CMD_VEND_STR	0x99
>  #define PSU_CMD_PROD_STR	0x9A
> -#define PSU_CMD_TOTAL_WATTS	0xEE
>  #define PSU_CMD_TOTAL_UPTIME	0xD1
>  #define PSU_CMD_UPTIME		0xD2
> +#define PSU_CMD_OCPMODE		0xD8
> +#define PSU_CMD_TOTAL_WATTS	0xEE
>  #define PSU_CMD_INIT		0xFE
>  
>  #define L_IN_VOLTS		"v_in"
> @@ -268,6 +270,7 @@ static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8 rail, l
>  		break;
>  	case PSU_CMD_TOTAL_UPTIME:
>  	case PSU_CMD_UPTIME:
> +	case PSU_CMD_OCPMODE:
>  		*val = tmp;
>  		break;
>  	default:
> @@ -660,6 +663,29 @@ static int product_show(struct seq_file *seqf, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(product);
>  
> +static int ocpmode_show(struct seq_file *seqf, void *unused)
> +{
> +	struct corsairpsu_data *priv = seqf->private;
> +	long val;
> +	int ret;
> +
> +	/*
> +	 * The rail mode is switchable on the fly. The RAW interface can be used for this. But it
> +	 * will not be included here, because I consider it somewhat dangerous for the health of the
> +	 * PSU. The returned value can be a bogus one, if the PSU is in the process of switching and
> +	 * getting of the value itself can also fail during this. Because of this every other value
> +	 * than OCP_MULTI_RAIL can be considered as "single rail".
> +	 */
> +	ret = corsairpsu_get_value(priv, PSU_CMD_OCPMODE, 0, &val);
> +	if (ret < 0)
> +		seq_puts(seqf, "N/A\n");
> +	else
> +		seq_printf(seqf, "%s\n", (val == OCP_MULTI_RAIL) ? "multi rail" : "single rail");
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(ocpmode);
> +
>  static void corsairpsu_debugfs_init(struct corsairpsu_data *priv)
>  {
>  	char name[32];
> @@ -671,6 +697,7 @@ static void corsairpsu_debugfs_init(struct corsairpsu_data *priv)
>  	debugfs_create_file("uptime_total", 0444, priv->debugfs, priv, &uptime_total_fops);
>  	debugfs_create_file("vendor", 0444, priv->debugfs, priv, &vendor_fops);
>  	debugfs_create_file("product", 0444, priv->debugfs, priv, &product_fops);
> +	debugfs_create_file("ocpmode", 0444, priv->debugfs, priv, &ocpmode_fops);
>  }
>  
>  #else
