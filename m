Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C461959731E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbiHQPcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237831AbiHQPcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 11:32:25 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211889D665;
        Wed, 17 Aug 2022 08:32:25 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id y4so651135plb.2;
        Wed, 17 Aug 2022 08:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=73FaRCn+5oc2kapfRzFRCxI6Oq2Jq2UUrBMElX+XfF8=;
        b=hhvO3kVzDwc4dR462vuO2pEWAoMgnGRvqovyIzNH5+EwaiROhSZNV34FWaoP9v/mXX
         NgwUVxvmqDft1kYBSmWVTRKMH2YKf4jzzmrTI58TqeCLUtfE7sNjCVxiz6QDX80d5XmB
         QjphJiOK/nCD48A1Co7Z7RYcDpvn7sDRPdzhWI0vK1CZU2C21R3kkCmEwGKCe3/qlfvd
         3l7baxZW4WIimBFktJBhPSFlagpJPQz93jHO4IgczIoa6sPTLU+xV1j5ziLHCw3Cy8+P
         OH4fayEGXoZ+tozWHNn3noIomkDyskyCl2+j619XLxadjWE/+q6qpAa0I1PW50d1c+9f
         81Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=73FaRCn+5oc2kapfRzFRCxI6Oq2Jq2UUrBMElX+XfF8=;
        b=lG9tXVotFEQV4x4iP7Nui1mg0orp5i6MgP1Xi7V5c5/tzyjBJ8wMqs9fOA/Qonc2VC
         +4pJWZuRe91UJqshRumvuA8HeKXVP743a55frXZd/WVtCkVEWn9MNQ/svcmygsNXwBr7
         asIw80UUKmhLLJcuv9d75nLr6RPeuicuSsM3oZZeSQfKPsn4dW5SuyVuki5gwUmCB57J
         oz2Fi+mK8gTOnnhHUsx3OQ0w4P8mQ4rfAxb5TbZCJ4a5Aayt30jMBxhULVUEP88EC6Yt
         +19n/wg/WPHYyn7ygsKaX/YBE5uDDPL+hiKxZZ6/kxFeTdA+5T8mKCaD/M1gjunnqxUV
         +VAw==
X-Gm-Message-State: ACgBeo2tEDJ6dtaiv3dqFsOC/k0mlhAcXub4Me+uNNZsqJswZffAUrlJ
        XGYf0KLDYYZTaIfPRcnHBZs=
X-Google-Smtp-Source: AA6agR6OPrub3jXiDSjK2BcseW8YYMQ/Q3GBA2/jx/K3qTIbemwaNa2dcsZDN7zREvtuoZSzH2Mhsg==
X-Received: by 2002:a17:903:11d2:b0:172:6ea1:b6e6 with SMTP id q18-20020a17090311d200b001726ea1b6e6mr15124903plh.72.1660750344621;
        Wed, 17 Aug 2022 08:32:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y23-20020a17090264d700b0016b81679c1fsm35925pli.216.2022.08.17.08.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 08:32:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 17 Aug 2022 08:32:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Jean Delvare <jdelvare@suse.com>, kernel@axis.com,
        =?iso-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (pmbus) Fix vout margin caching
Message-ID: <20220817153222.GA1333882@roeck-us.net>
References: <20220816144414.2358974-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816144414.2358974-1-vincent.whitchurch@axis.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 04:44:14PM +0200, Vincent Whitchurch wrote:
> The code currently uses a zero margin to mean not cached, but this
> results in the cache being bypassed if the (low) margin is set to zero,
> leading to lots of unnecessary SMBus transactions in that case.  Use a
> negative value instead.
> 
> Fixes: 07fb76273db89d93 ("hwmon: (pmbus) Introduce and use cached vout margins")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index f10bac8860fc..d06b04543fd8 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2861,7 +2861,7 @@ static int pmbus_regulator_get_low_margin(struct i2c_client *client, int page)
>  		.data = -1,
>  	};
>  
> -	if (!data->vout_low[page]) {
> +	if (data->vout_low[page] < 0) {
>  		if (pmbus_check_word_register(client, page, PMBUS_MFR_VOUT_MIN))
>  			s.data = _pmbus_read_word_data(client, page, 0xff,
>  						       PMBUS_MFR_VOUT_MIN);
> @@ -2887,7 +2887,7 @@ static int pmbus_regulator_get_high_margin(struct i2c_client *client, int page)
>  		.data = -1,
>  	};
>  
> -	if (!data->vout_high[page]) {
> +	if (data->vout_high[page] < 0) {
>  		if (pmbus_check_word_register(client, page, PMBUS_MFR_VOUT_MAX))
>  			s.data = _pmbus_read_word_data(client, page, 0xff,
>  						       PMBUS_MFR_VOUT_MAX);
> @@ -3320,6 +3320,7 @@ int pmbus_do_probe(struct i2c_client *client, struct pmbus_driver_info *info)
>  	struct pmbus_data *data;
>  	size_t groups_num = 0;
>  	int ret;
> +	int i;
>  	char *name;
>  
>  	if (!info)
> @@ -3353,6 +3354,11 @@ int pmbus_do_probe(struct i2c_client *client, struct pmbus_driver_info *info)
>  	data->currpage = -1;
>  	data->currphase = -1;
>  
> +	for (i = 0; i < ARRAY_SIZE(data->vout_low); i++) {
> +		data->vout_low[i] = -1;
> +		data->vout_high[i] = -1;
> +	}
> +
>  	ret = pmbus_init_common(client, data, info);
>  	if (ret < 0)
>  		return ret;
