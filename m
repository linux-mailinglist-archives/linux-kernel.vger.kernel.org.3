Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4800E4BC8E2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 15:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242423AbiBSOh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 09:37:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiBSOh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 09:37:27 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69531015;
        Sat, 19 Feb 2022 06:37:06 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id e22so20698454qvf.9;
        Sat, 19 Feb 2022 06:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qu4vgE6l4+fCHgzqUTK1n+V0tOOt2U/i/WB2d7HAJM8=;
        b=POn9NtNx05lLsUVmllFJkVnJ4jIJJp7jz0a4/IJuZxwcPtAhXJghkILAKbbeRzcIiw
         443yZEcbOSLw4WcXBQWqhzzkqdlsRPUUK0p9vkPyvMRM/pr+N3xOKVtr1xNHtQZvYx2K
         DrQ+XiSVfiHUhmW1Vnp2NEA7SvWw25G5ThJ8Q8P1lNmZaSxBmcJQhkQ4orCHW+1mesKm
         Xh4unFmk/7VjfS4bNNVwZ4+M6EqmgVZyeq2yvl7AQERipUCb9B3SSKO7BGpmFwKHyxtM
         z8qunr0EArEbj6eg2yyAF67ftbVnH/aQ4YjOots7eF4lO7OX3gz/eZWasQ75vlen2au1
         /+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Qu4vgE6l4+fCHgzqUTK1n+V0tOOt2U/i/WB2d7HAJM8=;
        b=nlRyF5GTv93r5Xs7rAKfEzC2uRQBETlHZco9pu9jYJQyLyQU/UKGmqTD5WvzNcQEW1
         GJB4Zg4WvfZBsxyFkimWa9tC78wW6lCpGqOkMcFpBoTMtZlr7yZt/InsQW+RA6M7yb72
         TsTGviYUIoycUFe7x2Ca5qiv3z677AGd8nFq2B42RNXlfv5bPljDXwZWgHX+G/Nu3Cae
         rrM29S0GljGTXjA9LkXGzgYsYVX7zt1qDYxbZkvaeN2PzqESlbLouB0cJCkrXCktIeHi
         8aKszm9JqxHPceaydYOkuyUn6+ThOxh2hwTd+G+Yx9xdm5vE5sBbBI7U0Ij4cwtwuf7s
         6cBg==
X-Gm-Message-State: AOAM532Bj8AtXFgl8k89PCggsKAe0pGUszoKFzVSOrGjvtEtWGug6eRG
        jSFZFcJPITURGosR+NCrwbyitW4WQ7CfKg==
X-Google-Smtp-Source: ABdhPJyCJrgC0GRcdPjG4gOx4Q8paMKlYkgQjKfNRvmC7nMWPob+OjGQuiV7TVTxpA6LPX+PgVj4ig==
X-Received: by 2002:ac8:5888:0:b0:2c7:42b9:b19f with SMTP id t8-20020ac85888000000b002c742b9b19fmr11102176qta.125.1645281425923;
        Sat, 19 Feb 2022 06:37:05 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c23sm32742qko.107.2022.02.19.06.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 06:37:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 19 Feb 2022 06:37:04 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, joel@jms.id.au
Subject: Re: [PATCH 2/4] hwmon: (occ) Add sysfs entry for OCC mode
Message-ID: <20220219143704.GA1031904@roeck-us.net>
References: <20220215151022.7498-1-eajames@linux.ibm.com>
 <20220215151022.7498-3-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215151022.7498-3-eajames@linux.ibm.com>
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

On Tue, Feb 15, 2022 at 09:10:20AM -0600, Eddie James wrote:
> BMC control applications need to check the OCC mode returned by the
> OCC poll response, so export it in sysfs with the other OCC-specific
> data.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/occ/common.h |  1 +
>  drivers/hwmon/occ/sysfs.c  | 11 +++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/hwmon/occ/common.h b/drivers/hwmon/occ/common.h
> index a88c66d36e38..2dd4a4d240c0 100644
> --- a/drivers/hwmon/occ/common.h
> +++ b/drivers/hwmon/occ/common.h
> @@ -120,6 +120,7 @@ struct occ {
>  	u8 prev_ext_stat;
>  	u8 prev_occs_present;
>  	u8 prev_ips_status;
> +	u8 prev_mode;
>  };
>  
>  int occ_setup(struct occ *occ, const char *name);
> diff --git a/drivers/hwmon/occ/sysfs.c b/drivers/hwmon/occ/sysfs.c
> index 6dc69c9aa4c2..88f655887c95 100644
> --- a/drivers/hwmon/occ/sysfs.c
> +++ b/drivers/hwmon/occ/sysfs.c
> @@ -66,6 +66,9 @@ static ssize_t occ_sysfs_show(struct device *dev,
>  	case 8:
>  		val = header->ips_status;
>  		break;
> +	case 9:
> +		val = header->mode;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -92,6 +95,7 @@ static SENSOR_DEVICE_ATTR(occ_quick_pwr_drop, 0444, occ_sysfs_show, NULL, 5);
>  static SENSOR_DEVICE_ATTR(occ_state, 0444, occ_sysfs_show, NULL, 6);
>  static SENSOR_DEVICE_ATTR(occs_present, 0444, occ_sysfs_show, NULL, 7);
>  static SENSOR_DEVICE_ATTR(occ_ips_status, 0444, occ_sysfs_show, NULL, 8);
> +static SENSOR_DEVICE_ATTR(occ_mode, 0444, occ_sysfs_show, NULL, 9);
>  static DEVICE_ATTR_RO(occ_error);
>  
>  static struct attribute *occ_attributes[] = {
> @@ -104,6 +108,7 @@ static struct attribute *occ_attributes[] = {
>  	&sensor_dev_attr_occ_state.dev_attr.attr,
>  	&sensor_dev_attr_occs_present.dev_attr.attr,
>  	&sensor_dev_attr_occ_ips_status.dev_attr.attr,
> +	&sensor_dev_attr_occ_mode.dev_attr.attr,
>  	&dev_attr_occ_error.attr,
>  	NULL
>  };
> @@ -172,6 +177,11 @@ void occ_sysfs_poll_done(struct occ *occ)
>  		sysfs_notify(&occ->bus_dev->kobj, NULL, name);
>  	}
>  
> +	if (header->mode != occ->prev_mode) {
> +		name = sensor_dev_attr_occ_mode.dev_attr.attr.name;
> +		sysfs_notify(&occ->bus_dev->kobj, NULL, name);
> +	}
> +
>  	if (occ->error && occ->error != occ->prev_error) {
>  		name = dev_attr_occ_error.attr.name;
>  		sysfs_notify(&occ->bus_dev->kobj, NULL, name);
> @@ -185,6 +195,7 @@ void occ_sysfs_poll_done(struct occ *occ)
>  	occ->prev_ext_stat = header->ext_status;
>  	occ->prev_occs_present = header->occs_present;
>  	occ->prev_ips_status = header->ips_status;
> +	occ->prev_mode = header->mode;
>  }
>  
>  int occ_setup_sysfs(struct occ *occ)
