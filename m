Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1868580349
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 19:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236478AbiGYRF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 13:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiGYRF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 13:05:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 377E91AE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 10:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658768725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a3wUurCyqKCMfKdr4U9KFGd2QMH7GRY0ExQn3XqfuW8=;
        b=VZlPKnUZJUKnoonX12GuZB4EwcCNJ06py6m5HaMReanFQmlMwkNbfmk/t+VIVavJt8j+10
        w7nEeszlXxwtuX4TxiuLhEENmwjy9uRQp+BBKtGBCluthOgg1QNFs2TuIx+P2BD5slXAwE
        pO3o8PzvdsQ80XQo9a/P2iAhfCzK4B0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-259-y3ncKzm5Myy3Roxjqtj7nw-1; Mon, 25 Jul 2022 13:05:24 -0400
X-MC-Unique: y3ncKzm5Myy3Roxjqtj7nw-1
Received: by mail-wr1-f71.google.com with SMTP id h6-20020adfaa86000000b0021e47bcbc6dso1720329wrc.16
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 10:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a3wUurCyqKCMfKdr4U9KFGd2QMH7GRY0ExQn3XqfuW8=;
        b=V8/mjZObgTz4H5cq1/sWB208n0q7JVmW/aHyLAVA06hIj76LoR5c+v5iZ74+X2cnQ4
         YRjtfGzLYqyzvh4FhErYVvkpanCPTHaXLiXtTV4I9Mumys+vR3xp9a4cN5j1xYKsTpAl
         roi5eGzMoG9SEqIwBN631iFciaC5zTgO/QaKiNNVWdumbl+vEXR3UlTrIwbBX15e7kDj
         b2zVcCh5tsWrMTYjOuczn3ayDwCmBerx19eW2JT8voZrENsxyiBmvP/c14QKKCiAsemI
         vOIfo2kUpT742jj1tQCcFWnVzdm48Fp7d+PR9UHPkqZAOw3ExoWpAzoj/m0GpCkH03Qk
         W68w==
X-Gm-Message-State: AJIora8U5IlIVV2H2Fw5I0NfjzGrWgymiZegDhaZ1pnxfqw1yAIiuaFU
        BEGVlfcqXO+qZ8wC1ReCYxfkWZ/SP5D2PxrtCCqKR/sEEAmr/wr8B4gcaLw877dcg8WczByFGqt
        n/CSifMKNXM7EG1PXGU5CE8GK
X-Received: by 2002:a1c:2184:0:b0:3a3:30d7:7314 with SMTP id h126-20020a1c2184000000b003a330d77314mr8754218wmh.19.1658768722839;
        Mon, 25 Jul 2022 10:05:22 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1unsAlNhV9LUXlYCEzqZs7stqV1rAI2oMdWuUAHWtmFJPB7rYq8qd9v6QobCn8rwQ1jAkhw7Q==
X-Received: by 2002:a1c:2184:0:b0:3a3:30d7:7314 with SMTP id h126-20020a1c2184000000b003a330d77314mr8754192wmh.19.1658768722393;
        Mon, 25 Jul 2022 10:05:22 -0700 (PDT)
Received: from pc-4.home (2a01cb058918ce00dd1a5a4f9908f2d5.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dd1a:5a4f:9908:f2d5])
        by smtp.gmail.com with ESMTPSA id q15-20020a5d658f000000b0021e48faed68sm12054630wru.97.2022.07.25.10.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 10:05:21 -0700 (PDT)
Date:   Mon, 25 Jul 2022 19:05:19 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     Matthias May <matthias.may@westermo.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, nicolas.dichtel@6wind.com,
        eyal.birger@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2 net-next] geneve: fix TOS inheriting for ipv6
Message-ID: <20220725170519.GD18808@pc-4.home>
References: <20220724003741.57816-1-matthias.may@westermo.com>
 <20220724003741.57816-3-matthias.may@westermo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220724003741.57816-3-matthias.may@westermo.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 02:37:41AM +0200, Matthias May wrote:
> The current code uses the RT_TOS macro to cut off the 6 DSCP
> bits, down to the original 3 TOS bits.
> 
> Do not use this macro to get the prio for inheriting purposes.

Honestly, this patch is a bug fix and is suitable for the net tree
(with appropriate 'Fixes' tag).

Ideally, we'd also fix ip6_dst_lookup_tunnel() (used by bareudp
tunnels) and vxlan6_get_route().

Also, mlx5e_tc_tun_update_header_ipv6() and
mlx5e_tc_tun_create_header_ipv6() both call RT_TOS() inside
ip6_make_flowinfo() and certainly need to be fixed too.

> Signed-off-by: Matthias May <matthias.may@westermo.com>
> ---
>  drivers/net/geneve.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> index 4c380c06f178..e1a4480e6f17 100644
> --- a/drivers/net/geneve.c
> +++ b/drivers/net/geneve.c
> @@ -877,8 +877,7 @@ static struct dst_entry *geneve_get_v6_dst(struct sk_buff *skb,
>  		use_cache = false;
>  	}
>  
> -	fl6->flowlabel = ip6_make_flowinfo(RT_TOS(prio),
> -					   info->key.label);
> +	fl6->flowlabel = ip6_make_flowinfo(prio, info->key.label);
>  	dst_cache = (struct dst_cache *)&info->dst_cache;
>  	if (use_cache) {
>  		dst = dst_cache_get_ip6(dst_cache, &fl6->saddr);
> -- 
> 2.35.1
> 

