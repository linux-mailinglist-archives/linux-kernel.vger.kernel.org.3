Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A2C4BC8E4
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 15:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242436AbiBSOhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 09:37:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242432AbiBSOhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 09:37:45 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D759A2634;
        Sat, 19 Feb 2022 06:37:26 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id f19so20712379qvb.6;
        Sat, 19 Feb 2022 06:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8Jbv5ijYuoQO+b4Csh0VrJcHfzneJl3ZvGEx9POCyEE=;
        b=VGPfW9u6tsskNwFIzx/HNa3/rn45v06Zr/n1fRAf4hMon/WwcLUFMDxlbm+4W3eVj6
         ezQUnwnAPLIxzRvtQhrYJsVfiRp154uIhHK9/xIcngB/mBKD4h5KP5rxGPzOzJ8TWFP/
         ifIxLYYfe3zGAazuELW2BCRsPOVcLBfFSuzV8LUOJfTGGK8TCHkDy2/OWXxT09LJjJYs
         IoKjbUxbSsuOiDN5tNrGTp9DltUm4gc1YLn99bPsghl80ZCO+w3QKJkxKXHu7PNmmbf9
         asSnwBUbj0grwsCRHvdVIi8CdLaYsNxag2+e67ZeMa+CHoaMVrTP0ETV3ic7od5P7Vnr
         3f6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=8Jbv5ijYuoQO+b4Csh0VrJcHfzneJl3ZvGEx9POCyEE=;
        b=EzpFvOwkGdwJhSST37eczUQiOTqcyVhQZhBMfzPjGY5PVwgq3UaTgXAVaZ409CBgAr
         dliMClIEzQoIgo9eleyVtOJKx2Hu3Rnb97ve/ZEeyfNFRaJnxu0/7fxTj1qhN3CRv1DC
         q3q+xMd20JeImnnwbfhjCD/OBcxJVv1qA6Ty6HVxEo2OFkOXYyo+waOa1NPQaWOoG/Tc
         HGd0+oHjOrrbhEtUkfENBonw7mB8bEDqhOpQuVXHSR4uvSS0xGtEpJpQoMnddYDDInVm
         gX84qU7V5GrwYtCZGbOM+fPs+UIy2MeEzaFInU2aunY1+3Vaboul2/XhiplJLkkw7L3a
         tdsw==
X-Gm-Message-State: AOAM530i1JhvwUIjNNymS1qBzCOliYhWygTP/fMAQVffcCGn6BvOkvJF
        5/AUtFZlv6HkvZe+7PKxl7E=
X-Google-Smtp-Source: ABdhPJxAvco/GJJ21yQUUJgv+EoBPNr2LfSgF/5D2x+rn2hR2ThweaOoDpTdraDRUxlUX/dBHSDRqA==
X-Received: by 2002:ac8:7dd1:0:b0:2de:600:a5ab with SMTP id c17-20020ac87dd1000000b002de0600a5abmr448907qte.532.1645281445972;
        Sat, 19 Feb 2022 06:37:25 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v9sm687989qkf.4.2022.02.19.06.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 06:37:25 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 19 Feb 2022 06:37:24 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, joel@jms.id.au
Subject: Re: [PATCH 3/4] hwmon: (occ) Add sysfs entries for additional
 extended status bits
Message-ID: <20220219143724.GA1031933@roeck-us.net>
References: <20220215151022.7498-1-eajames@linux.ibm.com>
 <20220215151022.7498-4-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215151022.7498-4-eajames@linux.ibm.com>
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

On Tue, Feb 15, 2022 at 09:10:21AM -0600, Eddie James wrote:
> Add sysfs entries for DVFS due to a VRM Vdd over-temperature condition,
> and add the GPU throttling condition bits (such that if bit 1 is set,
> GPU1 is throttling).
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/occ/sysfs.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/hwmon/occ/sysfs.c b/drivers/hwmon/occ/sysfs.c
> index 88f655887c95..b2f788a77746 100644
> --- a/drivers/hwmon/occ/sysfs.c
> +++ b/drivers/hwmon/occ/sysfs.c
> @@ -19,6 +19,8 @@
>  #define OCC_EXT_STAT_DVFS_POWER		BIT(6)
>  #define OCC_EXT_STAT_MEM_THROTTLE	BIT(5)
>  #define OCC_EXT_STAT_QUICK_DROP		BIT(4)
> +#define OCC_EXT_STAT_DVFS_VDD		BIT(3)
> +#define OCC_EXT_STAT_GPU_THROTTLE	GENMASK(2, 0)
>  
>  static ssize_t occ_sysfs_show(struct device *dev,
>  			      struct device_attribute *attr, char *buf)
> @@ -69,6 +71,12 @@ static ssize_t occ_sysfs_show(struct device *dev,
>  	case 9:
>  		val = header->mode;
>  		break;
> +	case 10:
> +		val = !!(header->ext_status & OCC_EXT_STAT_DVFS_VDD);
> +		break;
> +	case 11:
> +		val = header->ext_status & OCC_EXT_STAT_GPU_THROTTLE;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -96,6 +104,8 @@ static SENSOR_DEVICE_ATTR(occ_state, 0444, occ_sysfs_show, NULL, 6);
>  static SENSOR_DEVICE_ATTR(occs_present, 0444, occ_sysfs_show, NULL, 7);
>  static SENSOR_DEVICE_ATTR(occ_ips_status, 0444, occ_sysfs_show, NULL, 8);
>  static SENSOR_DEVICE_ATTR(occ_mode, 0444, occ_sysfs_show, NULL, 9);
> +static SENSOR_DEVICE_ATTR(occ_dvfs_vdd, 0444, occ_sysfs_show, NULL, 10);
> +static SENSOR_DEVICE_ATTR(occ_gpu_throttle, 0444, occ_sysfs_show, NULL, 11);
>  static DEVICE_ATTR_RO(occ_error);
>  
>  static struct attribute *occ_attributes[] = {
> @@ -109,6 +119,8 @@ static struct attribute *occ_attributes[] = {
>  	&sensor_dev_attr_occs_present.dev_attr.attr,
>  	&sensor_dev_attr_occ_ips_status.dev_attr.attr,
>  	&sensor_dev_attr_occ_mode.dev_attr.attr,
> +	&sensor_dev_attr_occ_dvfs_vdd.dev_attr.attr,
> +	&sensor_dev_attr_occ_gpu_throttle.dev_attr.attr,
>  	&dev_attr_occ_error.attr,
>  	NULL
>  };
> @@ -166,6 +178,18 @@ void occ_sysfs_poll_done(struct occ *occ)
>  		sysfs_notify(&occ->bus_dev->kobj, NULL, name);
>  	}
>  
> +	if ((header->ext_status & OCC_EXT_STAT_DVFS_VDD) !=
> +	    (occ->prev_ext_stat & OCC_EXT_STAT_DVFS_VDD)) {
> +		name = sensor_dev_attr_occ_dvfs_vdd.dev_attr.attr.name;
> +		sysfs_notify(&occ->bus_dev->kobj, NULL, name);
> +	}
> +
> +	if ((header->ext_status & OCC_EXT_STAT_GPU_THROTTLE) !=
> +	    (occ->prev_ext_stat & OCC_EXT_STAT_GPU_THROTTLE)) {
> +		name = sensor_dev_attr_occ_gpu_throttle.dev_attr.attr.name;
> +		sysfs_notify(&occ->bus_dev->kobj, NULL, name);
> +	}
> +
>  	if ((header->status & OCC_STAT_MASTER) &&
>  	    header->occs_present != occ->prev_occs_present) {
>  		name = sensor_dev_attr_occs_present.dev_attr.attr.name;
