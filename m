Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563EB4BFF53
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbiBVQxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbiBVQxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:53:10 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE733298A;
        Tue, 22 Feb 2022 08:52:45 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id q4so270414qki.11;
        Tue, 22 Feb 2022 08:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qDlxs6btPVbIiuFqjfw9xhRirAx7l7nHCBZbNvwfBDs=;
        b=nE+XsWJssq97lkRRt7D+sTYGnLt7E4ELsnHWX+ShfxXLLvlsxv8lef2XtGsnDl8OsO
         bwKwVYwUDrLMFxh58g2T8atqrHQn2/BMO/3KzJMpT/kcZCwkqH5neBceKrYHorY+oWGA
         rIoObq0LGSEiPsL1pFFP0dM1wU0qoIAcra2tcpH+DOQ8YaiGFcc3sdW194KMh5xCB5zs
         NjC+kMDJ+VcUUHDX0K+Lbk4tYuog4XfPpKaMO7wTrqF//uSOr9SWFPMgz4/Kf8mMlSj7
         6gMt4uwji1H3BU3of+SY4Pnbao8G2TNQqxMa++PWBO1Xq6+YavxSz+I6nee8KXbOyh0S
         FQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=qDlxs6btPVbIiuFqjfw9xhRirAx7l7nHCBZbNvwfBDs=;
        b=oYE+gAAeMhuprqd+Hb+6Zy8TrYUYozPrMgyvKIXUlYKAhOauAdVnGHBt9pjymTdj3o
         pvkqzKgjI8FwMPCW4saDJgX6vMqfeoEYJBXsGTELpisyc6tvbZhyk1QuLWIaF1eCOd1P
         dbzt8FJm0mBU++vtRAwlWcAUzu2y2Y5ZqyYWS71Q584MgXkTdCblg5gQrEvet5Xvl2AX
         E8fnBjvBrTJKsRfC6l8nfzZlehKj/zE1OchaFYCKKSTnk/1y2bSPI3pQ1SGQ7BwCrsM7
         QzdAgFnOhzWgcsXzVgmvPzWzkDD/WEcNUgO3E9OZBM1tFGkg7+SQf0YPAgsYbX1PVY87
         wpsA==
X-Gm-Message-State: AOAM532svskU9zcC8VW+BksLIhEtmakWVeqUeaYAl3NzHkE631Cagyyq
        jBw/GaqGbIrUvCf0mdLe+YZMeDMFk7Ktqw==
X-Google-Smtp-Source: ABdhPJweq1FpYWzA483hwO+mF9xFyUsaiCB1YFavrqC4ucP7urMXgKaCMGUTukL7z432qmS2r5El9w==
X-Received: by 2002:a05:620a:56b:b0:62c:eff4:fe8d with SMTP id p11-20020a05620a056b00b0062ceff4fe8dmr11606218qkp.459.1645548764393;
        Tue, 22 Feb 2022 08:52:44 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z23sm80873qtn.40.2022.02.22.08.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 08:52:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 22 Feb 2022 08:52:42 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, joel@jms.id.au
Subject: Re: [PATCH 4/4] hwmon: (occ) Add soft minimum power cap attribute
Message-ID: <20220222165242.GA255329@roeck-us.net>
References: <20220215151022.7498-1-eajames@linux.ibm.com>
 <20220215151022.7498-5-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215151022.7498-5-eajames@linux.ibm.com>
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

On Tue, Feb 15, 2022 at 09:10:22AM -0600, Eddie James wrote:
> Export the power caps data for the soft minimum power cap through hwmon.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/occ/common.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
> index 0cb4a0a6cbc1..f00cd59f1d19 100644
> --- a/drivers/hwmon/occ/common.c
> +++ b/drivers/hwmon/occ/common.c
> @@ -674,6 +674,9 @@ static ssize_t occ_show_caps_3(struct device *dev,
>  	case 7:
>  		val = caps->user_source;
>  		break;
> +	case 8:
> +		val = get_unaligned_be16(&caps->soft_min) * 1000000ULL;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -835,12 +838,13 @@ static int occ_setup_sensor_attrs(struct occ *occ)
>  	case 1:
>  		num_attrs += (sensors->caps.num_sensors * 7);
>  		break;
> -	case 3:
> -		show_caps = occ_show_caps_3;
> -		fallthrough;
>  	case 2:
>  		num_attrs += (sensors->caps.num_sensors * 8);
>  		break;
> +	case 3:
> +		show_caps = occ_show_caps_3;
> +		num_attrs += (sensors->caps.num_sensors * 9);
> +		break;
>  	default:
>  		sensors->caps.num_sensors = 0;
>  	}
> @@ -1047,6 +1051,15 @@ static int occ_setup_sensor_attrs(struct occ *occ)
>  			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
>  						     show_caps, NULL, 7, 0);
>  			attr++;
> +
> +			if (sensors->caps.version > 2) {
> +				snprintf(attr->name, sizeof(attr->name),
> +					 "power%d_cap_min_soft", s);
> +				attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
> +							     show_caps, NULL,
> +							     8, 0);
> +				attr++;
> +			}
>  		}
>  	}
>  
