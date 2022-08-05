Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE7358AA18
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 13:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240621AbiHEL1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 07:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiHEL07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 07:26:59 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAAFB7F7;
        Fri,  5 Aug 2022 04:26:58 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 73so2414923pgb.9;
        Fri, 05 Aug 2022 04:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=h0vfsUXhYyx5NsCjne4pHPj1thXsLPLYDU+f3JnnSpc=;
        b=Lq7ZNZGuSTYZW399JxsA9taOK8X47BjyiQjcVXE0umjONWyeJggt2IRwcyXkvX6JU3
         PwEX0sSTkcnZdOFdmNyyGt/OmCEmgD+8GATMGOgA/Q/g4bp8ksOqUcHuc7q8M5+sDQqd
         7dg1EhDTMrTP64fvzd+9unSx+cFZgG8jOTGpRm8FgIyNg4r4in07JRV91AjCODKx2r1C
         DzzsyfJ7RiRd1ejvvhqbsa6D1Lwp+KQLfmblWYeAVjlHtl2cG8IHb+J7zTUSCmlizZcK
         59OWyJHLANHQIfWW2acol0Efw9sXL/CHEXKJXlufSgOKv58ip6ehQX7XmOP5WpUD0O1l
         +hbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=h0vfsUXhYyx5NsCjne4pHPj1thXsLPLYDU+f3JnnSpc=;
        b=fN/arRnhyzDSeYWS+5LWlD7bpnX02/M/5fUuA2UfsKUpYxydwDkO8erkttM9nNnBmu
         wCDjMwRn9kjtyKQ7RYO1rv4AcM9wItM2B14q/3XJmi/mET4OPHbasRJqq//UZ1Dix4EF
         JvGkXVyUY/TzIn1kfBli96pBEn4EsQ+N5qpNiU2aKRpHyGPfwkHbrXLs2nC6MlCnG/lO
         mKLwPHQoIPUE+/VEV8dnSsJOD7u/r9gTBXos93aqAsMqz7QaFgVBLKkZFkslvWZqg1qg
         3b5ub9VEIMQP6KKaV4oBfqG/UHM8yyi6m22i1FbwOClkKyW7Cb+1tTqSz1fAD1AEPCG6
         HRNg==
X-Gm-Message-State: ACgBeo35RGGVVtEbtemrKmwJmAkwxFTxVZ45MFVmhJFtVhg6DvpkXuhS
        Q7uidw4r/aVlTNhstFwion2lo0tSGy0=
X-Google-Smtp-Source: AA6agR6SrmgywOYuyFVYpwmc428DSyMrDuvhhoTyeXsgbf74y1xPR92Ng6zhtacIG2IUSaSP4H1Fmw==
X-Received: by 2002:a63:c5:0:b0:40d:d290:24ef with SMTP id 188-20020a6300c5000000b0040dd29024efmr5388502pga.141.1659698818232;
        Fri, 05 Aug 2022 04:26:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902650a00b0016f14abb9b2sm2773176plk.125.2022.08.05.04.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 04:26:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 5 Aug 2022 04:26:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: Re: [PATCH v4 3/7] usb: typec: tcpci_rt1711h: Add regulator support
 when source vbus
Message-ID: <20220805112618.GB1011279@roeck-us.net>
References: <20220805071714.150882-1-gene.chen.richtek@gmail.com>
 <20220805071714.150882-4-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805071714.150882-4-gene.chen.richtek@gmail.com>
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

On Fri, Aug 05, 2022 at 03:17:09PM +0800, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Add regulator support when source vbus
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/usb/typec/tcpm/tcpci_rt1711h.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index f2f1fb0..fb19d7b 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -14,6 +14,7 @@
>  #include <linux/usb/tcpci.h>
>  #include <linux/usb/tcpm.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  
>  #define RT1711H_VID		0x29CF
>  #define RT1711H_PID		0x1711
> @@ -41,6 +42,8 @@ struct rt1711h_chip {
>  	struct tcpci_data data;
>  	struct tcpci *tcpci;
>  	struct device *dev;
> +	struct regulator *vbus;
> +	bool src_en;
>  };
>  
>  static int rt1711h_read16(struct rt1711h_chip *chip, unsigned int reg, u16 *val)
> @@ -104,6 +107,26 @@ static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
>  
>  	/* dcSRC.DRP : 33% */
>  	return rt1711h_write16(chip, RT1711H_RTCTRL16, 330);
> +

Nit: unnecessary empty line

Otherwise

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> +}
> +
> +static int rt1711h_set_vbus(struct tcpci *tcpci, struct tcpci_data *tdata,
> +			    bool src, bool snk)
> +{
> +	struct rt1711h_chip *chip = tdata_to_rt1711h(tdata);
> +	int ret;
> +
> +	if (chip->src_en == src)
> +		return 0;
> +
> +	if (src)
> +		ret = regulator_enable(chip->vbus);
> +	else
> +		ret = regulator_disable(chip->vbus);
> +
> +	if (!ret)
> +		chip->src_en = src;
> +	return ret;
>  }
>  
>  static int rt1711h_set_vconn(struct tcpci *tcpci, struct tcpci_data *tdata,
> @@ -247,7 +270,12 @@ static int rt1711h_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  
> +	chip->vbus = devm_regulator_get(&client->dev, "vbus");
> +	if (IS_ERR(chip->vbus))
> +		return PTR_ERR(chip->vbus);
> +
>  	chip->data.init = rt1711h_init;
> +	chip->data.set_vbus = rt1711h_set_vbus;
>  	chip->data.set_vconn = rt1711h_set_vconn;
>  	chip->data.start_drp_toggling = rt1711h_start_drp_toggling;
>  	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
> -- 
> 2.7.4
> 
