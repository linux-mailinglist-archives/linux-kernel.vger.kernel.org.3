Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBC65614A6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbiF3IS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbiF3IRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:17:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5726141629
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656576993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9jQDOxPmZUEOQ7g2mPWsfKdX0JS35yD+fdLvr8u/egY=;
        b=RYflAR9jGJB5VmvklNAMdZwzRz41QsdHY5TICugD6a2XeNXfLPZz+yeizDVHid83tZuGxq
        NHi1MrBf15McsLmRfCJqTHRXr+nA448LUjzQYSrlKZ/p58TCHsbAJk88fcVbgQ8nYjEIIV
        iBvqfLdYgZv8KkuC0BEhUF+F5naDqHk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-hgoHEMo0Oq6FuF5wWr6-dQ-1; Thu, 30 Jun 2022 04:16:32 -0400
X-MC-Unique: hgoHEMo0Oq6FuF5wWr6-dQ-1
Received: by mail-qv1-f69.google.com with SMTP id s11-20020a0562140cab00b0046e7d2b24b3so17767789qvs.16
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=9jQDOxPmZUEOQ7g2mPWsfKdX0JS35yD+fdLvr8u/egY=;
        b=aJg3g24Jb0fWBjhn0kzwbMXOYR9O4XgOK8stM6Y11yrQr+4sEAQCyK7fb6iNnMQ9EM
         ab3kOZvtfPQAuIKJabPbL0SHHh4Y0j94A/gI6SVIWBo36ZulOh9doOE/1EBSPAGNvEdn
         VaI8WooKtyvJuJa3+FHki8kPk4EBUiHQ4mQEjKe6KNw02uhaGLD5DP+2J6lQaeZ2rxDY
         QOzOEFbzKRu6/qxdMSXTMjYL6qXdJpJjE0CADaWY4+yZFOaMruQ1CJI/KlsHCDu3IuRb
         cUxjsSlHCLISSTSUZLMW8CIrkPsVC8zlem40c6eTlg7tkugOmZkWcX+lWFXKX4hYncM6
         719Q==
X-Gm-Message-State: AJIora9lrT9fa756jbtB1y2J/kF/HLE4Wda3dj6Qg9CZwpa4MpAkeofu
        MOPWAsMbfDEx6n/YFYn6VHl2rnOXY3AdjwikUaUn/K7D7W/bi/f81m9J1R/Y2b9RSv5GXZcuBUZ
        MrXLj0zO7v1KSw+eHD71DypC4
X-Received: by 2002:a05:622a:1106:b0:31d:299d:cba7 with SMTP id e6-20020a05622a110600b0031d299dcba7mr3967979qty.18.1656576991706;
        Thu, 30 Jun 2022 01:16:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tHQawgYEugKqjrLct36lTuuHSrHlAz0iskezKrMBcO/B2G0XMevzrpV9LNANYfrZzg1W4Z0Q==
X-Received: by 2002:a05:622a:1106:b0:31d:299d:cba7 with SMTP id e6-20020a05622a110600b0031d299dcba7mr3967952qty.18.1656576991340;
        Thu, 30 Jun 2022 01:16:31 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-106-148.dyn.eolo.it. [146.241.106.148])
        by smtp.gmail.com with ESMTPSA id w20-20020a05620a445400b006af37b005bdsm8426207qkp.128.2022.06.30.01.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 01:16:30 -0700 (PDT)
Message-ID: <e6114817650d7c27f4c1e75eaa63058846d71418.camel@redhat.com>
Subject: Re: [PATCH net] net: macsec: Retrieve MACSec-XPN attributes before
 offloading
From:   Paolo Abeni <pabeni@redhat.com>
To:     Carlos Fernandez <carlos.escuin@gmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, mayflowerera@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Carlos Fernandez <carlos.fernandez@technica-engineering.de>
Date:   Thu, 30 Jun 2022 10:16:27 +0200
In-Reply-To: <20220628111617.28001-1-carlos.fernandez@technica-engineering.de>
References: <20220524114134.366696-1-carlos.fernandez@technica-engineering.de>
         <20220628111617.28001-1-carlos.fernandez@technica-engineering.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 2022-06-28 at 13:16 +0200, Carlos Fernandez wrote:
> When MACsec offloading is used with XPN, before mdo_add_rxsa
> and mdo_add_txsa functions are called, the key salt is not
> copied to the macsec context struct. Offloaded phys will need
> this data when performing offloading.
> 
> Fix by copying salt and id to context struct before calling the
> offloading functions.
> 
> Fixes: 48ef50fa866a ("macsec: Netlink support of XPN cipher suites")
> Signed-off-by: Carlos Fernandez <carlos.fernandez@technica-engineering.de>

This does not pass the checkpatch validation:

https://patchwork.kernel.org/project/netdevbpf/patch/20220628111617.28001-1-carlos.fernandez@technica-engineering.de/

The required 'From: ' tag is still missing.

Please really add it and re-post. Please additionally check your patch
status after the submission via the patchwork UI:

https://patchwork.kernel.org/user/todo/netdevbpf/

so you can detect this kind of issues earlier.

Thanks!

Paolo 
> ---
>  drivers/net/macsec.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> index 832f09ac075e..4f2bd3d722c3 100644
> --- a/drivers/net/macsec.c
> +++ b/drivers/net/macsec.c
> @@ -1804,6 +1804,14 @@ static int macsec_add_rxsa(struct sk_buff *skb, struct genl_info *info)
>  
>  	rx_sa->sc = rx_sc;
>  
> +	if (secy->xpn) {
> +		rx_sa->ssci = nla_get_ssci(tb_sa[MACSEC_SA_ATTR_SSCI]);
> +		nla_memcpy(rx_sa->key.salt.bytes, tb_sa[MACSEC_SA_ATTR_SALT],
> +			   MACSEC_SALT_LEN);
> +	}
> +
> +	nla_memcpy(rx_sa->key.id, tb_sa[MACSEC_SA_ATTR_KEYID], MACSEC_KEYID_LEN);
> +
>  	/* If h/w offloading is available, propagate to the device */
>  	if (macsec_is_offloaded(netdev_priv(dev))) {
>  		const struct macsec_ops *ops;
> @@ -1826,13 +1834,6 @@ static int macsec_add_rxsa(struct sk_buff *skb, struct genl_info *info)
>  			goto cleanup;
>  	}
>  
> -	if (secy->xpn) {
> -		rx_sa->ssci = nla_get_ssci(tb_sa[MACSEC_SA_ATTR_SSCI]);
> -		nla_memcpy(rx_sa->key.salt.bytes, tb_sa[MACSEC_SA_ATTR_SALT],
> -			   MACSEC_SALT_LEN);
> -	}
> -
> -	nla_memcpy(rx_sa->key.id, tb_sa[MACSEC_SA_ATTR_KEYID], MACSEC_KEYID_LEN);
>  	rcu_assign_pointer(rx_sc->sa[assoc_num], rx_sa);
>  
>  	rtnl_unlock();
> @@ -2046,6 +2047,14 @@ static int macsec_add_txsa(struct sk_buff *skb, struct genl_info *info)
>  	if (assoc_num == tx_sc->encoding_sa && tx_sa->active)
>  		secy->operational = true;
>  
> +	if (secy->xpn) {
> +		tx_sa->ssci = nla_get_ssci(tb_sa[MACSEC_SA_ATTR_SSCI]);
> +		nla_memcpy(tx_sa->key.salt.bytes, tb_sa[MACSEC_SA_ATTR_SALT],
> +			   MACSEC_SALT_LEN);
> +	}
> +
> +	nla_memcpy(tx_sa->key.id, tb_sa[MACSEC_SA_ATTR_KEYID], MACSEC_KEYID_LEN);
> +
>  	/* If h/w offloading is available, propagate to the device */
>  	if (macsec_is_offloaded(netdev_priv(dev))) {
>  		const struct macsec_ops *ops;
> @@ -2068,13 +2077,6 @@ static int macsec_add_txsa(struct sk_buff *skb, struct genl_info *info)
>  			goto cleanup;
>  	}
>  
> -	if (secy->xpn) {
> -		tx_sa->ssci = nla_get_ssci(tb_sa[MACSEC_SA_ATTR_SSCI]);
> -		nla_memcpy(tx_sa->key.salt.bytes, tb_sa[MACSEC_SA_ATTR_SALT],
> -			   MACSEC_SALT_LEN);
> -	}
> -
> -	nla_memcpy(tx_sa->key.id, tb_sa[MACSEC_SA_ATTR_KEYID], MACSEC_KEYID_LEN);
>  	rcu_assign_pointer(tx_sc->sa[assoc_num], tx_sa);
>  
>  	rtnl_unlock();
> 

