Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9BD55F57A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 07:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiF2FEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 01:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiF2FEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 01:04:35 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394CA1BEB8;
        Tue, 28 Jun 2022 22:04:35 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id m2so13028207plx.3;
        Tue, 28 Jun 2022 22:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DpQbdm8mVo0Cnr1RBfeY/BHefXNRXw+AH3vqcu9Wmaw=;
        b=CAZbm6kZodJBCf8QLgZIWr3SWWWPSoAsnaikWHxn+XUBJoROmx798LHarIw1AyeX/H
         yDI/M1OgQd4jeBISyj40zwwK5MxZiG/WYBDx71gpBRnQ371Gej7LQjQNIvGUxbZlh0Gh
         EwPoupsSYdx/dAwvnEyQJ1u8/n4oAOivsJAtobea7kGsPEI0Vl6K66srXjGuexURZIUD
         zvI9PCJb1G3pDJGoQMyrDcjcTpzbAVEOYWW8eTTyByrSSeTPqnUkMYYjkCN0vkZKSqkS
         VGlbHM6ezOiajPtkCpa15iNx5OmLmvyNQ5Dzycr+9+9lhQhaL4Ehj9L0PpHlc2nYPm1A
         N2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DpQbdm8mVo0Cnr1RBfeY/BHefXNRXw+AH3vqcu9Wmaw=;
        b=cNsNPJsL5HlGGxZ2Hh5rQFzvqxwTxnALMqZbjuCAao7nzkVoQloB/h8z7K197te4hO
         XkN1v7OtZ5lPpAzetDNGPeyFC0GzmF9xfxAmpLZv4GVVnkKjEX2wBhP8+nCUXDiY0iy3
         BFQFfJZYCs1yI51lW4b44cDTGtplwDX0NvrbH6Ig2C9Z65aTrixl0EX3em9/ctxxGmDJ
         ZEl1VKGyJEqw/vsgY07AtWnLEELhHZjuoe4b2SR9hbTWjN+GFyMB3BNyT5gCwgjVuPep
         o7IYjohdJkwvNep5cC33Ua9CgyEom91WTCydlH/aXvsYPl6O9zcdk3J+qrtA3gqsahxw
         VxJQ==
X-Gm-Message-State: AJIora/SAwyHGY6glQbwIMBB6pzefnnVcwHGwDRgw59tNVTOrqoRQH8r
        1n02tgO89Fz9YXjqG2T2zsU=
X-Google-Smtp-Source: AGRyM1vUJJFDubcmisPN/O1o0t0BKTQulx+vlOES0pIa2B4vZzbPsyS/bpw5zbwzvf9oEd+aPx+7Ug==
X-Received: by 2002:a17:903:25c5:b0:16a:30e:34b8 with SMTP id jc5-20020a17090325c500b0016a030e34b8mr7194604plb.170.1656479074502;
        Tue, 28 Jun 2022 22:04:34 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:ff79:92cc:7905:3272])
        by smtp.gmail.com with ESMTPSA id f93-20020a17090a706600b001e34b5ed5a7sm883810pjk.35.2022.06.28.22.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 22:04:32 -0700 (PDT)
Date:   Tue, 28 Jun 2022 22:04:30 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        linux-input@vger.kernel.org
Subject: Re: [RESEND PATCH v4 3/6] Input: edt-ft5x06 - set report rate by dts
 property
Message-ID: <YrvdXsMf/ygIx9du@google.com>
References: <20220621123937.1330389-1-dario.binacchi@amarulasolutions.com>
 <20220621123937.1330389-4-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621123937.1330389-4-dario.binacchi@amarulasolutions.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dario,

On Tue, Jun 21, 2022 at 02:39:34PM +0200, Dario Binacchi wrote:
> It allows to change the M06/M12 default scan rate on driver probing.
> 
> Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
> (no changes since v3)
> 
> Changes in v3:
> - Check the lower and upper limits of the report-rate-hz value
> - Convert the M06 report-rate-hz value
> 
>  drivers/input/touchscreen/edt-ft5x06.c | 30 ++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index 77f061af5c61..843e8b0522f7 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -1084,6 +1084,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
>  	struct input_dev *input;
>  	unsigned long irq_flags;
>  	int error;
> +	u32 report_rate;
>  	char fw_version[EDT_NAME_LEN];
>  
>  	dev_dbg(&client->dev, "probing for EDT FT5x06 I2C\n");
> @@ -1213,6 +1214,35 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
>  	edt_ft5x06_ts_get_defaults(&client->dev, tsdata);
>  	edt_ft5x06_ts_get_parameters(tsdata);
>  
> +	if (tsdata->reg_addr.reg_report_rate != NO_REGISTER &&
> +	    !of_property_read_u32(client->dev.of_node, "report-rate-hz",

Unless there is a strong reason to use of-specific version of properties
API, generic device property API is preferred. I changed this to
device_property_read_u32().


> +				  &report_rate)) {
> +		tsdata->report_rate = report_rate;
> +		if (tsdata->version == EDT_M06) {
> +			if (report_rate < 30)
> +				report_rate = 30;
> +			else if (report_rate > 140)
> +				report_rate = 140;

We have a nice macro clamp_val() for this.

> +		} else if (report_rate < 1) {
> +			report_rate = 1;
> +		} else if (report_rate > 255)
> +			report_rate = 255;

Same here. I made the change and applied.

> +
> +		if (report_rate != tsdata->report_rate)
> +			dev_warn(&client->dev,
> +				 "report-rate %dHz is unsupported, use %dHz\n",
> +				 tsdata->report_rate, report_rate);
> +
> +		if (tsdata->version == EDT_M06)
> +			report_rate /= 10;
> +
> +		tsdata->report_rate = report_rate;
> +
> +		edt_ft5x06_register_write(tsdata,
> +					  tsdata->reg_addr.reg_report_rate,
> +					  tsdata->report_rate);
> +	}
> +
>  	dev_dbg(&client->dev,
>  		"Model \"%s\", Rev. \"%s\", %dx%d sensors\n",
>  		tsdata->name, fw_version, tsdata->num_x, tsdata->num_y);
> -- 
> 2.32.0
> 

Thanks.

-- 
Dmitry
