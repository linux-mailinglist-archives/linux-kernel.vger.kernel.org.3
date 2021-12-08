Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C433746D43A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbhLHNVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhLHNVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:21:38 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE71C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 05:18:06 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id m17so2182320qvx.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 05:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=aY8F8vGS5LQpVlvLyFz5CNctJWdRH4midCkCMB7qk0c=;
        b=QIw7F5rdIXU/HEQB8fpvA7ywYtw9ODFb7M+AjJ3SSTlC9Tq+jAREt2jWTyAAGXWtth
         9dchUlpusXkPsnEwfkXrFGVP4u7/WecEOwncLX6UWbrCNirSlwPhHLG5/h0tiAh48/18
         TNcRDlTCMIM+DFPRzOZFaC1A/LXhA9N3zNNmJ0yNCX5QiIJnVFwJ4zkQGnmdcKBXahil
         DAPpCjgNj23X5OMRptVgt/cc+K9Gz8bB7SJcDFebv8XHUlqU+DD90Zmqrjo1esV17QHH
         ypngE2ctwbiI+BWspfZhUze+KJLTcXV4OJmtPMQEXmTGD1KFvhcX38RiiZYobzK9uVx/
         A/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=aY8F8vGS5LQpVlvLyFz5CNctJWdRH4midCkCMB7qk0c=;
        b=ZorFqUeT0wWcGLEUrt1JeKXk4cmqSePnb0xPU6/r5xYCvlqQzPL+nkjqqy3r3+R3kI
         TFZWhrxXS7V1YciXTGSFr5i+NijrHPFaDcv+nJ//tCenkAa8tfOrRoWxwXkjL6PPB2Mz
         JzlZckQTRo3tQJGiOgUYe1z3w71CJ6KIR2Nd8rhbeVjwsSs0VF6PgY2RdmosM6tzL+40
         w4s3IOO9GclbYlRUeGfSQcg5CmN9rrCYzIOP8Wy+b5ogxzt9X32sFErYV6NNBYiFAO99
         M57qMTZTmDOsKNcIYSltUisIFQZCLdm+yT8Xq6uve7MhXJrys4YBCGw/0pzTiD16l/5d
         1ZkQ==
X-Gm-Message-State: AOAM532AK36UDyZVV4FqBOzitHtUhjh2lQWjKnA83UM4wikSJI8Sm9RH
        z8m3GaKc5AaLzQMh9s+VfQ==
X-Google-Smtp-Source: ABdhPJxlX0RIChvYM+4f3ro24q5AcEzLWV+II2R8WfXow3WzfHpEfX9bb/Myw67CL3kHQrlvPpoQ/g==
X-Received: by 2002:a05:6214:8c2:: with SMTP id da2mr7245439qvb.23.1638969485626;
        Wed, 08 Dec 2021 05:18:05 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id a17sm1419254qkp.108.2021.12.08.05.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 05:18:05 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:c45a:2d46:25a4:be1f])
        by serve.minyard.net (Postfix) with ESMTPSA id 4EC37180013;
        Wed,  8 Dec 2021 13:18:04 +0000 (UTC)
Date:   Wed, 8 Dec 2021 07:18:03 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Mian Yousaf Kaukab <ykaukab@suse.de>
Cc:     kamlakantp@marvell.com, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ipmi: ssif: initialize ssif_info->client early
Message-ID: <20211208131803.GW15676@minyard.net>
Reply-To: minyard@acm.org
References: <20211208093239.4432-1-ykaukab@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208093239.4432-1-ykaukab@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 10:32:39AM +0100, Mian Yousaf Kaukab wrote:
> During probe ssif_info->client is dereferenced in error path. However,
> it is set when some of the error checking has already been done. This
> causes following kernel crash if an error path is taken:
> 
> [   30.645593][  T674] ipmi_ssif 0-000e: ipmi_ssif: Not probing, Interface already present
> [   30.657616][  T674] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000088
> ...
> [   30.657723][  T674] pc : __dev_printk+0x28/0xa0
> [   30.657732][  T674] lr : _dev_err+0x7c/0xa0
> ...
> [   30.657772][  T674] Call trace:
> [   30.657775][  T674]  __dev_printk+0x28/0xa0
> [   30.657778][  T674]  _dev_err+0x7c/0xa0
> [   30.657781][  T674]  ssif_probe+0x548/0x900 [ipmi_ssif 62ce4b08badc1458fd896206d9ef69a3c31f3d3e]
> [   30.657791][  T674]  i2c_device_probe+0x37c/0x3c0
> ...
> 
> Initialize ssif_info->client before any error path can be taken. Clear
> i2c_client data in the error path to prevent the dangling pointer from
> leaking.

Sigh, I just sent some fixes up to Linus, so this was bound to happen :).
This is in my for-next tree, I'll send it up in a few days if everything
is ok.

Thanks,

-corey

> 
> Fixes: c4436c9149c5 ("ipmi_ssif: avoid registering duplicate ssif interface")
> Suggested-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> ---
>  drivers/char/ipmi/ipmi_ssif.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index 0c62e578749e..48aab77abebf 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -1659,6 +1659,9 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  		}
>  	}
>  
> +	ssif_info->client = client;
> +	i2c_set_clientdata(client, ssif_info);
> +
>  	rv = ssif_check_and_remove(client, ssif_info);
>  	/* If rv is 0 and addr source is not SI_ACPI, continue probing */
>  	if (!rv && ssif_info->addr_source == SI_ACPI) {
> @@ -1679,9 +1682,6 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  		ipmi_addr_src_to_str(ssif_info->addr_source),
>  		client->addr, client->adapter->name, slave_addr);
>  
> -	ssif_info->client = client;
> -	i2c_set_clientdata(client, ssif_info);
> -
>  	/* Now check for system interface capabilities */
>  	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
>  	msg[1] = IPMI_GET_SYSTEM_INTERFACE_CAPABILITIES_CMD;
> @@ -1881,6 +1881,7 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  
>  		dev_err(&ssif_info->client->dev,
>  			"Unable to start IPMI SSIF: %d\n", rv);
> +		i2c_set_clientdata(client, NULL);
>  		kfree(ssif_info);
>  	}
>  	kfree(resp);
> -- 
> 2.31.1
> 
