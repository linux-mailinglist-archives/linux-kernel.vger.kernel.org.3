Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C470494CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiATLZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:25:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51147 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230523AbiATLZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:25:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642677949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3JnRnkAUl6ydn4aYabatzx9NKCMlhuJGRaxEfTdkCPw=;
        b=BpsC1vz5p3eK5QkEd2JnqFeWMk8is9JNptf9Xu1q4IhDWmeikk4FUijbxTKfME42XzzCCs
        eiAmitzGeuAc6KQe6QLdik0QyJvscC09o9xNojXFBPGuiTcd60txcDoW+vXLnYfyIw0SYQ
        XZESjznKr34CoAFD/SqnjEdFr1nuBvQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-JzRGwpSvNrGIUdTjVsQ8nA-1; Thu, 20 Jan 2022 06:25:47 -0500
X-MC-Unique: JzRGwpSvNrGIUdTjVsQ8nA-1
Received: by mail-ed1-f72.google.com with SMTP id s9-20020aa7d789000000b004021d03e2dfso5600314edq.18
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 03:25:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3JnRnkAUl6ydn4aYabatzx9NKCMlhuJGRaxEfTdkCPw=;
        b=zMve2fmXj2KiYF/rG7+UD+Rg3sub27na/b19wGAWHl8yMmzu2vzJ/s2qUKY8sBwhyJ
         RTcQlK5VvGpOIOlWClmmk1gisRRJnhYUXm9jG+3Tjep7FWZtabRDDabNVT015sJuyt/q
         /NH1FlcaCbN2mnK6C/G2Bh0vfrtKErzHRVUDao5O6LiGeGzZWqI2b5BU+CTLzu7x4uDU
         gQICtcKhGQBBo0iDDtB3nkvkoLf4RWYHJP+0QZOFWm1px2ZLQ+MxMrglQkcLmOtsyQxB
         G/6jA3MJKA2ig4j3ogs5enPk8xu+wN4ac1Gp/5obJ/8ICfrcohyQPpRc/d5Yec+WmY2S
         Jj2A==
X-Gm-Message-State: AOAM530aL5hVzV/9KMolCAnmQcx5jtvYYuHhxztn4yTG3MysregGfC5L
        8tBpCxBYy4ZL8FbVB73Q6zaN0FF5Zw5wsSb8qZKimFCxQsJTfvP6Nk8h5WcLxWM1VdR6e9y8/n/
        gCCo63yB1niZ94wyWuCiJjiE8
X-Received: by 2002:a17:907:9618:: with SMTP id gb24mr28623941ejc.385.1642677946697;
        Thu, 20 Jan 2022 03:25:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRXCxE2hLOmRh02HFHNmkPepiNeZYVlbYK0NAeBVGZTQMTodp6TTTM4xCYRWls3p+5LgfQZA==
X-Received: by 2002:a17:907:9618:: with SMTP id gb24mr28623919ejc.385.1642677946463;
        Thu, 20 Jan 2022 03:25:46 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id v4sm1184714ede.42.2022.01.20.03.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 03:25:45 -0800 (PST)
Message-ID: <5bec947e-272b-cfa0-b9b6-4d0d2626153f@redhat.com>
Date:   Thu, 20 Jan 2022 12:25:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 1/2] i2c: designware: Add missing locks
Content-Language: en-US
To:     Jan Dabros <jsd@semihalf.com>, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, jarkko.nikula@linux.intel.com
Cc:     andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        wsa@kernel.org, rrangel@chromium.org, mw@semihalf.com,
        jaz@semihalf.com, upstream@semihalf.com
References: <20220120001621.705352-1-jsd@semihalf.com>
 <20220120001621.705352-2-jsd@semihalf.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220120001621.705352-2-jsd@semihalf.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/20/22 01:16, Jan Dabros wrote:
> All accesses to controller's registers should be protected on
> probe, disable and xfer paths. This is needed for i2c bus controllers
> that are shared with but not controller by kernel.
> 
> Signed-off-by: Jan Dabros <jsd@semihalf.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/i2c/busses/i2c-designware-common.c | 12 ++++++++++++
>  drivers/i2c/busses/i2c-designware-master.c |  6 ++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
> index bf2a4920638a..9f8574320eb2 100644
> --- a/drivers/i2c/busses/i2c-designware-common.c
> +++ b/drivers/i2c/busses/i2c-designware-common.c
> @@ -578,7 +578,12 @@ int i2c_dw_set_fifo_size(struct dw_i2c_dev *dev)
>  	 * Try to detect the FIFO depth if not set by interface driver,
>  	 * the depth could be from 2 to 256 from HW spec.
>  	 */
> +	ret = i2c_dw_acquire_lock(dev);
> +	if (ret)
> +		return ret;
> +
>  	ret = regmap_read(dev->map, DW_IC_COMP_PARAM_1, &param);
> +	i2c_dw_release_lock(dev);
>  	if (ret)
>  		return ret;
>  
> @@ -607,6 +612,11 @@ u32 i2c_dw_func(struct i2c_adapter *adap)
>  void i2c_dw_disable(struct dw_i2c_dev *dev)
>  {
>  	u32 dummy;
> +	int ret;
> +
> +	ret = i2c_dw_acquire_lock(dev);
> +	if (ret)
> +		return;
>  
>  	/* Disable controller */
>  	__i2c_dw_disable(dev);
> @@ -614,6 +624,8 @@ void i2c_dw_disable(struct dw_i2c_dev *dev)
>  	/* Disable all interrupts */
>  	regmap_write(dev->map, DW_IC_INTR_MASK, 0);
>  	regmap_read(dev->map, DW_IC_CLR_INTR, &dummy);
> +
> +	i2c_dw_release_lock(dev);
>  }
>  
>  void i2c_dw_disable_int(struct dw_i2c_dev *dev)
> diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
> index 9177463c2cbb..1a4b23556db3 100644
> --- a/drivers/i2c/busses/i2c-designware-master.c
> +++ b/drivers/i2c/busses/i2c-designware-master.c
> @@ -905,7 +905,13 @@ int i2c_dw_probe_master(struct dw_i2c_dev *dev)
>  		irq_flags = IRQF_SHARED | IRQF_COND_SUSPEND;
>  	}
>  
> +	ret = i2c_dw_acquire_lock(dev);
> +	if (ret)
> +		return ret;
> +
>  	i2c_dw_disable_int(dev);
> +	i2c_dw_release_lock(dev);
> +
>  	ret = devm_request_irq(dev->dev, dev->irq, i2c_dw_isr, irq_flags,
>  			       dev_name(dev->dev), dev);
>  	if (ret) {
> 

