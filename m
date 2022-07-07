Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACC8569B97
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 09:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbiGGHac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 03:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiGGHaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 03:30:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 512F91263B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 00:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657179028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cbmLgCmTysRy8uiXuxZ5jhXX1Rk2OR8KTMlastRWZ0Y=;
        b=gsMJjNqz4RxDTbauLB/3Jh4o5IDPL4F/dsLmBc9JmoR3e9zSb+kjs5hawEwlFuTAzswSjF
        DbbYE2+HPZzw08j91NKZEkb9uhDgYPTTu9FEuGEuaaegBennn+O6tj64y2XUJKmelKymxn
        xw+glUWsVVG1ED4/nWntzzg84ZuVhak=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-jUnkMlYvPC2GZC0S-eZMzQ-1; Thu, 07 Jul 2022 03:30:27 -0400
X-MC-Unique: jUnkMlYvPC2GZC0S-eZMzQ-1
Received: by mail-wr1-f70.google.com with SMTP id m7-20020adfa3c7000000b0021d7ae39d1dso941079wrb.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 00:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=cbmLgCmTysRy8uiXuxZ5jhXX1Rk2OR8KTMlastRWZ0Y=;
        b=LgOl84eVdrq6OKB8X+XK5nGmWsDQrlPzXEHpCZkNLsR85/ujbspWXZPMTMubpc4AJN
         DHJgI78x3KLc4tsDDcOYDmuM6uCsfXlGiOQ9zM1ZpKCR2BCVV8rs72kD69r/fsKhIkbY
         yYZNdH94qa89gl8aHlX2gxDqI4KGC6vAfVsZ09OqanLeI50clpvrI1pL7q3gODfOzwvd
         NPoaoKM+muNaywTzhfbgD/Q0QvoYnGotBm0VOpbjkKueQM0qWowLbW9khbA2Z3m5aoJV
         xgzl70G/eNfARIIEI2UseK5ko6SUwXxaVgilYMJuo8R/lAESsS/+Snwp3giSks49KteW
         UZjQ==
X-Gm-Message-State: AJIora81JajkcKaJr5mpBsHjvrCdmIWE3lSRwPbLQuq42yzfMUw7nGBD
        16FYnJSaEQgAMO5lYQ5pvfTCC2vb/CAAekwuSU+LHAyeQSTJrZ2Dbw9WdVtqECGWxKECMMPFkk0
        sd/7ZR0+59v+Shg9+YqDnuf0+
X-Received: by 2002:a5d:6d0a:0:b0:21d:6f28:5ead with SMTP id e10-20020a5d6d0a000000b0021d6f285eadmr13900880wrq.95.1657179025874;
        Thu, 07 Jul 2022 00:30:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1seYbB1t0jf8+m8X4AxKyZNme7pt0Y06tR2WH42ONzW+bn03fpq5uQ+FvQAPGqPA7KRlSoeBw==
X-Received: by 2002:a5d:6d0a:0:b0:21d:6f28:5ead with SMTP id e10-20020a5d6d0a000000b0021d6f285eadmr13900855wrq.95.1657179025614;
        Thu, 07 Jul 2022 00:30:25 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-106-148.dyn.eolo.it. [146.241.106.148])
        by smtp.gmail.com with ESMTPSA id p9-20020a5d4e09000000b0021d8190e9cfsm2014707wrt.40.2022.07.07.00.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 00:30:25 -0700 (PDT)
Message-ID: <e454f6de32de3be092260d19da24f58635eb6e49.camel@redhat.com>
Subject: Re: [PATCH net v3] net: ethernet: ti: am65-cpsw: Fix devlink port
 register sequence
From:   Paolo Abeni <pabeni@redhat.com>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, davem@davemloft.net,
        kuba@kernel.org, linux@armlinux.org.uk
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, vigneshr@ti.com, grygorii.strashko@ti.com
Date:   Thu, 07 Jul 2022 09:30:24 +0200
In-Reply-To: <20220706070208.12207-1-s-vadapalli@ti.com>
References: <20220706070208.12207-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-07-06 at 12:32 +0530, Siddharth Vadapalli wrote:
> Renaming interfaces using udevd depends on the interface being registered
> before its netdev is registered. Otherwise, udevd reads an empty
> phys_port_name value, resulting in the interface not being renamed.
> 
> Fix this by registering the interface before registering its netdev
> by invoking am65_cpsw_nuss_register_devlink() before invoking
> register_netdev() for the interface.
> 
> Move the function call to devlink_port_type_eth_set(), invoking it after
> register_netdev() is invoked, to ensure that netlink notification for the
> port state change is generated after the netdev is completely initialized.
> 
> Fixes: 58356eb31d60 ("net: ti: am65-cpsw-nuss: Add devlink support")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> Changelog:
> v2 -> v3:
> 1. Add error handling to unregister devlink.
> 
> v1-> v2:
> 1. Add Fixes tag in commit message.
> 2. Update patch subject to include "net".
> 3. Invoke devlink_port_type_eth_set() after register_netdev() is called.
> 4. Update commit message describing the cause for moving the call to
>    devlink_port_type_eth_set().
> 
> v2: https://lore.kernel.org/r/20220704073040.7542-1-s-vadapalli@ti.com/
> v1: https://lore.kernel.org/r/20220623044337.6179-1-s-vadapalli@ti.com/
> 
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index fb92d4c1547d..f4a6b590a1e3 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -2467,7 +2467,6 @@ static int am65_cpsw_nuss_register_devlink(struct am65_cpsw_common *common)
>  				port->port_id, ret);
>  			goto dl_port_unreg;
>  		}
> -		devlink_port_type_eth_set(dl_port, port->ndev);
>  	}
>  	devlink_register(common->devlink);
>  	return ret;
> @@ -2511,6 +2510,7 @@ static void am65_cpsw_unregister_devlink(struct am65_cpsw_common *common)
>  static int am65_cpsw_nuss_register_ndevs(struct am65_cpsw_common *common)
>  {
>  	struct device *dev = common->dev;
> +	struct devlink_port *dl_port;
>  	struct am65_cpsw_port *port;
>  	int ret = 0, i;
>  
> @@ -2527,6 +2527,10 @@ static int am65_cpsw_nuss_register_ndevs(struct am65_cpsw_common *common)
>  		return ret;
>  	}
>  
> +	ret = am65_cpsw_nuss_register_devlink(common);
> +	if (ret)
> +		return ret;
> +
>  	for (i = 0; i < common->port_num; i++) {
>  		port = &common->ports[i];
>  
> @@ -2539,25 +2543,24 @@ static int am65_cpsw_nuss_register_ndevs(struct am65_cpsw_common *common)
>  				i, ret);
>  			goto err_cleanup_ndev;
>  		}
> +
> +		dl_port = &port->devlink_port;
> +		devlink_port_type_eth_set(dl_port, port->ndev);
>  	}
>  
>  	ret = am65_cpsw_register_notifiers(common);
>  	if (ret)
>  		goto err_cleanup_ndev;
>  
> -	ret = am65_cpsw_nuss_register_devlink(common);
> -	if (ret)
> -		goto clean_unregister_notifiers;
> -
>  	/* can't auto unregister ndev using devm_add_action() due to
>  	 * devres release sequence in DD core for DMA
>  	 */
>  
>  	return 0;
> -clean_unregister_notifiers:
> -	am65_cpsw_unregister_notifiers(common);
> +
>  err_cleanup_ndev:
>  	am65_cpsw_nuss_cleanup_ndev(common);
> +	am65_cpsw_unregister_devlink(common);

It looks strange that there is no error path leading to
am65_cpsw_unregister_devlink() only.

Why we don't need to call it when/if devm_request_irq() fails? 

Not strictly related to this patch, but it looks like there is another
suspect cleanup point: if a 'register_netdev()' call fails, the cleanup
code will still call unregister_netdev() on the relevant device and the
later ones, hitting a WARN_ON(1) in unregister_netdevice_many().

Thanks!

Paolo

