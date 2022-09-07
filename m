Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A08C5B0988
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiIGQDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiIGQCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:02:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A5BBC807
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662566473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bb3nI/bWVmCMagHckP0ncEAEW5knUD+/s554XzBSy8Q=;
        b=VEtbDaHVhRvR6Rn9GhrruBXhgiAKQlv/lk/gswCvGAgq7NE0SdNGXQHQeEzp6kvF3Wtazi
        K1VfMj5vAl2ZvOmJJvNiBpuU7zKE+dPlMc9osNKvc2nRBNLjllu3raJ2y0O4iERVWuZIgO
        q9JbHz1tXhSwOz9ThZcvyiZuCrwuKao=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-a7GJOrclMuCKOM8r999P8w-1; Wed, 07 Sep 2022 12:01:12 -0400
X-MC-Unique: a7GJOrclMuCKOM8r999P8w-1
Received: by mail-pl1-f199.google.com with SMTP id m5-20020a170902f64500b0016d313f3ce7so10215551plg.23
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 09:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date;
        bh=Bb3nI/bWVmCMagHckP0ncEAEW5knUD+/s554XzBSy8Q=;
        b=C/mtSLsHWHmOUWFX65yhW0r/rFGljxuu1eBG/MQaq07QLvbpJAeRd3c59h2WQKClKh
         QItNNL7pMEk5hxWgl577ADq3RRvhkGDou9pNLZmhOzHAZeuhOlnd+KoZRQFVgQm262Qd
         Dusst/0IkyuvZ0y7jToW1YaqrbSB+Bg0rFjsilqkzui+4oGLb7dPkQMQOPQEXyz6QyBJ
         5c3qlGKXDvlnn3OzK5mPcWg1NooubUWElNYS8Rvdq+FiHFdDHhx4SoqcX1JOnmMg9YkS
         RfJrvrz1sXMuSZsgEZDKYcht9JXhE0mYAB0yOR0im1pkhdOaBcs35sQQE5R9Sg9jN35E
         RXIg==
X-Gm-Message-State: ACgBeo1+lpQY5CYcyLFimbbRQ2g5dvVxBS/yUvlJOIbihX7cGQafXytL
        FwRdPtJ4tv2GznxmP7xlBsVANRuSDRn4Zu50StSNUNLODkgPqu50xwu5qDz4QVPljYz9gvE7xld
        x+2pDUW0FcyawP5zrnvWvyTUf
X-Received: by 2002:a17:90b:33d1:b0:1fd:6e9f:548c with SMTP id lk17-20020a17090b33d100b001fd6e9f548cmr32245245pjb.137.1662566471356;
        Wed, 07 Sep 2022 09:01:11 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5w0TlpQTaZ2Ko9XfCN734oiu46xXdNWpFa388ApWyERn/Hez/P1sLI6h/zK1eILUvChXyCsQ==
X-Received: by 2002:a17:90b:33d1:b0:1fd:6e9f:548c with SMTP id lk17-20020a17090b33d100b001fd6e9f548cmr32245213pjb.137.1662566471018;
        Wed, 07 Sep 2022 09:01:11 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:4f2f:926a:23dd:8588])
        by smtp.gmail.com with ESMTPSA id mh16-20020a17090b4ad000b001f8aee0d826sm14786150pjb.53.2022.09.07.09.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 09:01:10 -0700 (PDT)
Date:   Thu, 08 Sep 2022 01:00:37 +0900 (JST)
Message-Id: <20220908.010037.1643964170435041362.syoshida@redhat.com>
To:     mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc,
        sven@narfation.org
Cc:     b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
        syoshida@redhat.com
Subject: Re: [PATCH] batman-adv: Fix hang up with small MTU hard-interface
From:   Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <20220820032516.200446-1-syoshida@redhat.com>
References: <20220820032516.200446-1-syoshida@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 28.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?

On Sat, 20 Aug 2022 12:25:16 +0900, Shigeru Yoshida wrote:
> The system hangs up when batman-adv soft-interface is created on
> hard-interface with small MTU.  For example, the following commands
> create batman-adv soft-interface on dummy interface with zero MTU:
> 
>   # ip link add name dummy0 type dummy
>   # ip link set mtu 0 dev dummy0
>   # ip link set up dev dummy0
>   # ip link add name bat0 type batadv
>   # ip link set dev dummy0 master bat0
> 
> These commands cause the system hang up with the following messages:
> 
>   [   90.578925][ T6689] batman_adv: bat0: Adding interface: dummy0
>   [   90.580884][ T6689] batman_adv: bat0: The MTU of interface dummy0 is too small (0) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1560 would solve the problem.
>   [   90.586264][ T6689] batman_adv: bat0: Interface activated: dummy0
>   [   90.590061][ T6689] batman_adv: bat0: Forced to purge local tt entries to fit new maximum fragment MTU (-320)
>   [   90.595517][ T6689] batman_adv: bat0: Forced to purge local tt entries to fit new maximum fragment MTU (-320)
>   [   90.598499][ T6689] batman_adv: bat0: Forced to purge local tt entries to fit new maximum fragment MTU (-320)
> 
> This patch fixes this issue by returning error when enabling
> hard-interface with small MTU size.
> 
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  net/batman-adv/hard-interface.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
> index b8f8da7ee3de..dce5557800e9 100644
> --- a/net/batman-adv/hard-interface.c
> +++ b/net/batman-adv/hard-interface.c
> @@ -700,6 +700,9 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
>  	int max_header_len = batadv_max_header_len();
>  	int ret;
>  
> +	if (hard_iface->net_dev->mtu < ETH_MIN_MTU + max_header_len)
> +		return -EINVAL;
> +
>  	if (hard_iface->if_status != BATADV_IF_NOT_IN_USE)
>  		goto out;
>  
> -- 
> 2.37.2
> 

