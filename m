Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54774560B51
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 22:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiF2U7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 16:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiF2U7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 16:59:45 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBB23E0FB;
        Wed, 29 Jun 2022 13:59:43 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id n16-20020a17090ade9000b001ed15b37424so673706pjv.3;
        Wed, 29 Jun 2022 13:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eUOSisXEX4azAU3P2OlTAghCWdgobOTU7QEXEJTTGYU=;
        b=gI5uLl/vensRtycqrZOMejg2JD1oVcPGklLyJmewMi5280Y8SMwkuHfLWY6swRW5Mq
         P8UpMxx58lFTlrkJQEfSb8HPylRAbZgAoNhiGCOv2JzirWYMsgUKhts2ZAArDs/oOJP0
         T5pucacjiaCVUCC8vyBpCHrRsctxRpE4EVh27fxNunbztKuVkbYoC9OFEwe7GIxlhnbe
         x59wellAJq7dRB0Wx8uZCJRSH74BL0YWRsCaHo09Iiv+E5U3hSgdWl475OqkJm7cW0AV
         XRq6otMoCjyK7Lk83VkKtqiibhkDRGfxwom6ShPFnz+kFGwH3T0bUE0DeAXLd+X+bfjT
         Y7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=eUOSisXEX4azAU3P2OlTAghCWdgobOTU7QEXEJTTGYU=;
        b=eQT+g46T952YTvuDGk3D8EwJf+zHwc5KYQz/36bR+LDToAOAiZsQZMyxBo6lAr7/KM
         Xs+gWfLhbqYS8YWBd1ptK97EmmhyXg7h/kAxWmbxoNzz+Rh/uq95nbMyVVpe4CjW+o4Q
         gjO7H8htvveCgRhiXbbPICLpnM3SYamu3EOimvzy7phvdQ34pCF/ep9bg+nrtvFOKNyX
         gLnU0HcyfMeZIQ8y1nIKq/tbnOvBk87sWiWBv0XVt14/KoxLPdZnNj+iLtz/iMPnXbyv
         0DHHdJ1oaTnvjqavvgx54xN1BXXN3bsjLYswtQdV+YgmcnBqSYt5j8Hb08luekat/gQJ
         6GAA==
X-Gm-Message-State: AJIora/R+uI3keNY+VNlMaBqdl2LVL23z0/iNX+O/4rBIJsNOK1Iz2BL
        6uDae5Jq8xY5TkaIO/AzgBM=
X-Google-Smtp-Source: AGRyM1taAozmHEZ5UkA1VhhEkfFP6/3/A6yUc2hJSYkOhgIyBcVf8sRgE8bxkWNAl/dIXZKtmKwMuQ==
X-Received: by 2002:a17:90a:ea0f:b0:1ec:989d:1013 with SMTP id w15-20020a17090aea0f00b001ec989d1013mr7788562pjy.140.1656536382871;
        Wed, 29 Jun 2022 13:59:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709027c0a00b0016a6caacaefsm11372727pll.103.2022.06.29.13.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 13:59:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 29 Jun 2022 13:59:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com
Subject: Re: [PATCH] hwmon: (occ) Prevent power cap command overwriting poll
 response
Message-ID: <20220629205939.GA3936194@roeck-us.net>
References: <20220628203029.51747-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628203029.51747-1-eajames@linux.ibm.com>
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

On Tue, Jun 28, 2022 at 03:30:29PM -0500, Eddie James wrote:
> Currently, the response to the power cap command overwrites the
> first eight bytes of the poll response, since the commands use
> the same buffer. This means that user's get the wrong data between
> the time of sending the power cap and the next poll response update.
> Fix this by specifying a different buffer for the power cap command
> response.
> 
> Fixes: 5b5513b88002 ("hwmon: Add On-Chip Controller (OCC) hwmon driver")
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/occ/common.c |  5 +++--
>  drivers/hwmon/occ/common.h |  3 ++-
>  drivers/hwmon/occ/p8_i2c.c | 13 +++++++------
>  drivers/hwmon/occ/p9_sbe.c |  7 +++----
>  4 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
> index ea070b91e5b9..157b73a3da29 100644
> --- a/drivers/hwmon/occ/common.c
> +++ b/drivers/hwmon/occ/common.c
> @@ -145,7 +145,7 @@ static int occ_poll(struct occ *occ)
>  	cmd[6] = 0;			/* checksum lsb */
>  
>  	/* mutex should already be locked if necessary */
> -	rc = occ->send_cmd(occ, cmd, sizeof(cmd));
> +	rc = occ->send_cmd(occ, cmd, sizeof(cmd), &occ->resp, sizeof(occ->resp));
>  	if (rc) {
>  		occ->last_error = rc;
>  		if (occ->error_count++ > OCC_ERROR_COUNT_THRESHOLD)
> @@ -182,6 +182,7 @@ static int occ_set_user_power_cap(struct occ *occ, u16 user_power_cap)
>  {
>  	int rc;
>  	u8 cmd[8];
> +	u8 resp[8];
>  	__be16 user_power_cap_be = cpu_to_be16(user_power_cap);
>  
>  	cmd[0] = 0;	/* sequence number */
> @@ -198,7 +199,7 @@ static int occ_set_user_power_cap(struct occ *occ, u16 user_power_cap)
>  	if (rc)
>  		return rc;
>  
> -	rc = occ->send_cmd(occ, cmd, sizeof(cmd));
> +	rc = occ->send_cmd(occ, cmd, sizeof(cmd), resp, sizeof(resp));
>  
>  	mutex_unlock(&occ->lock);
>  
> diff --git a/drivers/hwmon/occ/common.h b/drivers/hwmon/occ/common.h
> index 64d5ec7e169b..7ac4b2febce6 100644
> --- a/drivers/hwmon/occ/common.h
> +++ b/drivers/hwmon/occ/common.h
> @@ -96,7 +96,8 @@ struct occ {
>  
>  	int powr_sample_time_us;	/* average power sample time */
>  	u8 poll_cmd_data;		/* to perform OCC poll command */
> -	int (*send_cmd)(struct occ *occ, u8 *cmd, size_t len);
> +	int (*send_cmd)(struct occ *occ, u8 *cmd, size_t len, void *resp,
> +			size_t resp_len);
>  
>  	unsigned long next_update;
>  	struct mutex lock;		/* lock OCC access */
> diff --git a/drivers/hwmon/occ/p8_i2c.c b/drivers/hwmon/occ/p8_i2c.c
> index da39ea28df31..b221be1f35f3 100644
> --- a/drivers/hwmon/occ/p8_i2c.c
> +++ b/drivers/hwmon/occ/p8_i2c.c
> @@ -111,7 +111,8 @@ static int p8_i2c_occ_putscom_be(struct i2c_client *client, u32 address,
>  				      be32_to_cpu(data1));
>  }
>  
> -static int p8_i2c_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
> +static int p8_i2c_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len,
> +			       void *resp, size_t resp_len)
>  {
>  	int i, rc;
>  	unsigned long start;
> @@ -120,7 +121,7 @@ static int p8_i2c_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
>  	const long wait_time = msecs_to_jiffies(OCC_CMD_IN_PRG_WAIT_MS);
>  	struct p8_i2c_occ *ctx = to_p8_i2c_occ(occ);
>  	struct i2c_client *client = ctx->client;
> -	struct occ_response *resp = &occ->resp;
> +	struct occ_response *or = (struct occ_response *)resp;
>  
>  	start = jiffies;
>  
> @@ -151,7 +152,7 @@ static int p8_i2c_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
>  			return rc;
>  
>  		/* wait for OCC */
> -		if (resp->return_status == OCC_RESP_CMD_IN_PRG) {
> +		if (or->return_status == OCC_RESP_CMD_IN_PRG) {
>  			rc = -EALREADY;
>  
>  			if (time_after(jiffies, start + timeout))
> @@ -163,7 +164,7 @@ static int p8_i2c_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
>  	} while (rc);
>  
>  	/* check the OCC response */
> -	switch (resp->return_status) {
> +	switch (or->return_status) {
>  	case OCC_RESP_CMD_IN_PRG:
>  		rc = -ETIMEDOUT;
>  		break;
> @@ -192,8 +193,8 @@ static int p8_i2c_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
>  	if (rc < 0)
>  		return rc;
>  
> -	data_length = get_unaligned_be16(&resp->data_length);
> -	if (data_length > OCC_RESP_DATA_BYTES)
> +	data_length = get_unaligned_be16(&or->data_length);
> +	if ((data_length + 7) > resp_len)
>  		return -EMSGSIZE;
>  
>  	/* fetch the rest of the response data */
> diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
> index 01405ae2f9bd..c1e0a1d96cd4 100644
> --- a/drivers/hwmon/occ/p9_sbe.c
> +++ b/drivers/hwmon/occ/p9_sbe.c
> @@ -77,11 +77,10 @@ static bool p9_sbe_occ_save_ffdc(struct p9_sbe_occ *ctx, const void *resp,
>  	return notify;
>  }
>  
> -static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
> +static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len,
> +			       void *resp, size_t resp_len)
>  {
> -	struct occ_response *resp = &occ->resp;
>  	struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
> -	size_t resp_len = sizeof(*resp);
>  	int rc;
>  
>  	rc = fsi_occ_submit(ctx->sbe, cmd, len, resp, &resp_len);
> @@ -95,7 +94,7 @@ static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
>  		return rc;
>  	}
>  
> -	switch (resp->return_status) {
> +	switch (((struct occ_response *)resp)->return_status) {
>  	case OCC_RESP_CMD_IN_PRG:
>  		rc = -ETIMEDOUT;
>  		break;
