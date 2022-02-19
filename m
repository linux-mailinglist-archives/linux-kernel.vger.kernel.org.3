Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D154BC8E0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 15:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242415AbiBSOhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 09:37:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiBSOhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 09:37:06 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02AFFCE;
        Sat, 19 Feb 2022 06:36:46 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id a28so20700253qvb.10;
        Sat, 19 Feb 2022 06:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eJqjyOIhNNP5ElgXr7KbFzQoArRxA1VwAEOgubQqZlQ=;
        b=fWLgJOHxP/va1qgufHu4ByMF2/8EjwtnvNlpllR+BMCYUFeEV/rtyGH7T3JgOpzbaH
         hnQr2IkKF8xMK8TgqYqRZdsdxKpKAV2uRjjFs2OrfpZs6uMXFgHsP2Jsl2NNQEJzdCjR
         htTBxHkmtR4V8Wq23jASVr0Su78cpljWRfAxPBGEKfBGVrRVhk5W5V6vKi+BT8B6Zlo0
         z8mBfyE3MulBwY2oMmzFJYA2hfyMnonDU3hHvX0FRVHmmmNBWwC8Q3lP/WYHGvvn2xzl
         mm5lKcuV/xVgDrAphqACzYTHolIqX2Bqs45nDE4kYmTx9w4BsAqa+Cu5FH57kAOsNlSy
         8Bzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=eJqjyOIhNNP5ElgXr7KbFzQoArRxA1VwAEOgubQqZlQ=;
        b=Zrphu94kq0wN8oL56PNjhui1/0GHSvZQS2XJ/d2wLycOxtwVpuoRSRJHxUuQ8ms7s+
         3MVz6CVMcZtOZxIzqkaJJ+s1UcomZ+UQag19rA6Aed3RwKimdtReincV9oYDnsuXbyMf
         oAv+GByLN2QgMjvTwzHV9zn0467sCvMegCd1JfeuLwtTzUv/MJgf7cHEw19tj4z+7qlj
         yqpTeYTR3tj97tediIWjSNceqvP2knbOSR7YwKa9zs6DK3N/q8X+opPJtkl2Bm7r5EpK
         GBsD0WcVskZgeL5HiJnAgeFTN0/ultY1vXn77VyhG1N00lL1r7sB5mUGrwj4cPwro6Ng
         ZceQ==
X-Gm-Message-State: AOAM530TII+EuNDA7GT40QqA4q7ugOEYq45DwgTT0TUqvhOeye8+gN7n
        0XVNQE1ejFoQNlhmOOFP+6E=
X-Google-Smtp-Source: ABdhPJyADH4YLK3IrWm2ecLRSrmqq//52LLPLDcQ2tlgVy+0VfTJEaOoXoyf4KS8vEfvw1+G9CqEOw==
X-Received: by 2002:a05:622a:11d2:b0:2d6:8a01:66ef with SMTP id n18-20020a05622a11d200b002d68a0166efmr10766015qtk.38.1645281405863;
        Sat, 19 Feb 2022 06:36:45 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e3sm4067457qto.25.2022.02.19.06.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 06:36:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 19 Feb 2022 06:36:43 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, joel@jms.id.au
Subject: Re: [PATCH 1/4] hwmon: (occ) Add sysfs entry for IPS (Idle Power
 Saver) status
Message-ID: <20220219143643.GA1031877@roeck-us.net>
References: <20220215151022.7498-1-eajames@linux.ibm.com>
 <20220215151022.7498-2-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215151022.7498-2-eajames@linux.ibm.com>
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

On Tue, Feb 15, 2022 at 09:10:19AM -0600, Eddie James wrote:
> BMC control applications need to check the Idle Power Saver status
> byte returned by the OCC poll response, so export it in sysfs with
> the other OCC-specific data.
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
> index 5020117be740..a88c66d36e38 100644
> --- a/drivers/hwmon/occ/common.h
> +++ b/drivers/hwmon/occ/common.h
> @@ -119,6 +119,7 @@ struct occ {
>  	u8 prev_stat;
>  	u8 prev_ext_stat;
>  	u8 prev_occs_present;
> +	u8 prev_ips_status;
>  };
>  
>  int occ_setup(struct occ *occ, const char *name);
> diff --git a/drivers/hwmon/occ/sysfs.c b/drivers/hwmon/occ/sysfs.c
> index 03b16abef67f..6dc69c9aa4c2 100644
> --- a/drivers/hwmon/occ/sysfs.c
> +++ b/drivers/hwmon/occ/sysfs.c
> @@ -63,6 +63,9 @@ static ssize_t occ_sysfs_show(struct device *dev,
>  		else
>  			val = 1;
>  		break;
> +	case 8:
> +		val = header->ips_status;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -88,6 +91,7 @@ static SENSOR_DEVICE_ATTR(occ_mem_throttle, 0444, occ_sysfs_show, NULL, 4);
>  static SENSOR_DEVICE_ATTR(occ_quick_pwr_drop, 0444, occ_sysfs_show, NULL, 5);
>  static SENSOR_DEVICE_ATTR(occ_state, 0444, occ_sysfs_show, NULL, 6);
>  static SENSOR_DEVICE_ATTR(occs_present, 0444, occ_sysfs_show, NULL, 7);
> +static SENSOR_DEVICE_ATTR(occ_ips_status, 0444, occ_sysfs_show, NULL, 8);
>  static DEVICE_ATTR_RO(occ_error);
>  
>  static struct attribute *occ_attributes[] = {
> @@ -99,6 +103,7 @@ static struct attribute *occ_attributes[] = {
>  	&sensor_dev_attr_occ_quick_pwr_drop.dev_attr.attr,
>  	&sensor_dev_attr_occ_state.dev_attr.attr,
>  	&sensor_dev_attr_occs_present.dev_attr.attr,
> +	&sensor_dev_attr_occ_ips_status.dev_attr.attr,
>  	&dev_attr_occ_error.attr,
>  	NULL
>  };
> @@ -162,6 +167,11 @@ void occ_sysfs_poll_done(struct occ *occ)
>  		sysfs_notify(&occ->bus_dev->kobj, NULL, name);
>  	}
>  
> +	if (header->ips_status != occ->prev_ips_status) {
> +		name = sensor_dev_attr_occ_ips_status.dev_attr.attr.name;
> +		sysfs_notify(&occ->bus_dev->kobj, NULL, name);
> +	}
> +
>  	if (occ->error && occ->error != occ->prev_error) {
>  		name = dev_attr_occ_error.attr.name;
>  		sysfs_notify(&occ->bus_dev->kobj, NULL, name);
> @@ -174,6 +184,7 @@ void occ_sysfs_poll_done(struct occ *occ)
>  	occ->prev_stat = header->status;
>  	occ->prev_ext_stat = header->ext_status;
>  	occ->prev_occs_present = header->occs_present;
> +	occ->prev_ips_status = header->ips_status;
>  }
>  
>  int occ_setup_sysfs(struct occ *occ)
