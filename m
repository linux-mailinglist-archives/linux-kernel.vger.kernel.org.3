Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E3047B4A4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 22:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbhLTVDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 16:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhLTVDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 16:03:13 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFB6C061574;
        Mon, 20 Dec 2021 13:03:13 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id be32so17613284oib.11;
        Mon, 20 Dec 2021 13:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d0EHoym5IC+t/qKMmsUTt4d7U7D/y3iCG5mxuWttzRU=;
        b=iTO1/0e2oe6Hd4OoH8wVEgbHSUGUUjmvl523TmqR365zaCRM0z6MYGzx7JPgWLzi3G
         MSPifjVWGpLQVER5WjS8d264MdPUE+pXawgNnoGXIN75yk5DF/gFFN43CNcpuJrXejqy
         n5qZpAt2noI7PF8gXG8ZCX/TY5j2KSRS2NhJvaGM60UTaAPF9epGUqe6m3iucgwmunDS
         U3EWLnE0qu6arPxYHLxmtg8/gMlQKkGxCgPO2p/i6xHvYR5uhfBcgEYfxXTNT6ld9aq8
         bcMGPK39AM0cYCVfLIPkvsLMGJI7ptgYQKHbd8Jlm9YxNraE3I1CcgeJIMHU15OfpcGb
         naCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=d0EHoym5IC+t/qKMmsUTt4d7U7D/y3iCG5mxuWttzRU=;
        b=CZP/pt2AHWBEBu3+0NEuEFd0QlRb1SFEjaXw6EDLcKEAZDF5qdz4KeXsobnUpzmPV5
         0erJmybOFOSVH8fwqO5pnGi2S5wT+/o4I38agFf7fYE4U38h731pAUNlR9E1dg/R1Aq2
         3NfVAoX3M6/tK40ggRV5d7tOaK6rL3P7eN1c7R6hjX8F0LBBrpK21ZtgFijF6gjFSSad
         qH4J/I03ui6G+Ef2f/cB4ZPuml6c7CQdg/C8A5TLskxrImzsoO1H6PYKPBaSjXi3R+lS
         yVfbCJGyCjkwvWZiNFUH0YLhiknR4/EjEDnxTaZFkO1UtzWA9WhURYJpxrhDLroYeurK
         SX8g==
X-Gm-Message-State: AOAM531eulGjFoAolypubcz+ccT77/nxiFxOpfDe0cY+Y/1y9VElLnK1
        3vOq9aQQ10BMPMR8WLRYv7U=
X-Google-Smtp-Source: ABdhPJz46MDuaRscwO0z1pSXL1cGIaE5XtiuhnkDZnpFGGF05vZgvAufYRPEiClW3/hvCYub2nnbPw==
X-Received: by 2002:aca:1a04:: with SMTP id a4mr656965oia.153.1640034192906;
        Mon, 20 Dec 2021 13:03:12 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s6sm3826196ois.3.2021.12.20.13.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 13:03:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 20 Dec 2021 13:03:11 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arseny Demidov <arsdemal@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>, rahul.tanwar@linux.intel.com,
        andriy.shevchenko@intel.com, Arseny Demidov <a.demidov@yadro.com>
Subject: Re: [PATCH v1 1/1] hwmon : (mr75203) fix wrong power-up delay value
Message-ID: <20211220210311.GA194769@roeck-us.net>
References: <20211219102239.1112-1-a.demidov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211219102239.1112-1-a.demidov@yadro.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 19, 2021 at 01:22:39PM +0300, Arseny Demidov wrote:
> In the file mr75203.c we have a macro named POWER_DELAY_CYCLE_256,
> the correct value should be 0x100. The register ip_tmr is expressed
> in units of IP clk cycles, in accordance with the datasheet.
> Typical power-up delays for Temperature Sensor are 256 cycles i.e. 0x100.
> 
> Fixes: 9d823351a337 ("hwmon: Add hardware monitoring driver for Moortec MR75203 PVT controller")
> Signed-off-by: Arseny Demidov <a.demidov@yadro.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/mr75203.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
> index 868243dba1ee..1ba1e3145969 100644
> --- a/drivers/hwmon/mr75203.c
> +++ b/drivers/hwmon/mr75203.c
> @@ -93,7 +93,7 @@
>  #define VM_CH_REQ	BIT(21)
>  
>  #define IP_TMR			0x05
> -#define POWER_DELAY_CYCLE_256	0x80
> +#define POWER_DELAY_CYCLE_256	0x100
>  #define POWER_DELAY_CYCLE_64	0x40
>  
>  #define PVT_POLL_DELAY_US	20
