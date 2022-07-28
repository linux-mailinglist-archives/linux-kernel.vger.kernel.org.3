Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F79583FA9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 15:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbiG1NLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 09:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238962AbiG1NLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 09:11:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BB5E54CA4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 06:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659013871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Peb1snEEyClrr7SAXY+3h09rG7Cc4NL+stHh6RtUqlg=;
        b=DuhSR6etY/YvB2g5HBMSBwl8DK4fZbbY0RGr8OQ9Chq+O/e1vUhJbGCqXOQwVLBs6JRod5
        JJEaBqEnSqrQ9h1IwQi1yiFVPXKtOSJ2/UQY4oQPxi+TMwEf73CB6uzqfkvXe+9E9QrSOw
        SJBVSCsiWZjc7iiN5PqvQ9upStmpWQ4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-WOgNE187O0WT5WoJt8UJIw-1; Thu, 28 Jul 2022 09:11:09 -0400
X-MC-Unique: WOgNE187O0WT5WoJt8UJIw-1
Received: by mail-qk1-f197.google.com with SMTP id q20-20020a05620a0d9400b006b6540e8d79so1418344qkl.14
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 06:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Peb1snEEyClrr7SAXY+3h09rG7Cc4NL+stHh6RtUqlg=;
        b=zEBg61ITbiheDS5nUD6FPCxSJIkmLvhYJEtuoCNCUNSTpC6Br/F4Lq0NSnyRT8fg9c
         6eleKf9a5n5iDVELl/u8KSgOaQdjwntRJ3FBvXRHpQPhnIQXtaEw/CTAelWMU46Ivg29
         4c/KxVyx/MDVi09arCjGIDGCkDLgTGXQzxS4vR1fFgLuQTWUJT+mu82odxjFFVr8OaCr
         duc+dUWSWIR4SaegZTDfgEYMomL3pEH9WAej0zGtAQCiyZIQKMdaoQHTMOGavqrLevwR
         CbeL8hO9YkuuJTnPkUANEsyjL/5hZCTR2imEmPUxVzLuOqdX7WswGgdtNUomEdKjoBO2
         JjBw==
X-Gm-Message-State: AJIora8JGWPJKLY1kl30uLbTr77MUX4tUOd+SBjieWh/ls7psO2K6nGI
        n1OBILciNLUUVQTJXRjeuWL6PRLmqk+nWI7KeBIRscg9EYMXCQb+vY9jWCwaPuO8z+sUWqn12wX
        HJTkGC5OvMp1vJ99IqLnjQCxq
X-Received: by 2002:a05:622a:5c9:b0:31e:ebfa:f192 with SMTP id d9-20020a05622a05c900b0031eebfaf192mr22600194qtb.263.1659013869039;
        Thu, 28 Jul 2022 06:11:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uUGwnkUKAlkb5w7dfKwrYi+F9K3MAAR2oHcQcjWq9dcxCgUGRM2/5AUT0TVb6HvPZP43W81Q==
X-Received: by 2002:a05:622a:5c9:b0:31e:ebfa:f192 with SMTP id d9-20020a05622a05c900b0031eebfaf192mr22600156qtb.263.1659013868626;
        Thu, 28 Jul 2022 06:11:08 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-164.dyn.eolo.it. [146.241.104.164])
        by smtp.gmail.com with ESMTPSA id t14-20020a37ea0e000000b006b58fce19dasm529103qkj.20.2022.07.28.06.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 06:11:08 -0700 (PDT)
Message-ID: <e63e6fc511d9d515fcb8501f48f218192f36afd3.camel@redhat.com>
Subject: Re: [PATCH] dn_route: use time_is_before_jiffies(a) to replace
 "jiffies - a > 0"
From:   Paolo Abeni <pabeni@redhat.com>
To:     Yu Zhe <yuzhe@nfschina.com>, davem@davemloft.net, kuba@kernel.org
Cc:     linux-decnet-user@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        liqiong@nfschina.com
Date:   Thu, 28 Jul 2022 15:11:04 +0200
In-Reply-To: <20220727024600.18413-1-yuzhe@nfschina.com>
References: <20220727024600.18413-1-yuzhe@nfschina.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-07-27 at 10:46 +0800, Yu Zhe wrote:
> time_is_before_jiffies deals with timer wrapping correctly.
> 
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> ---
>  net/decnet/dn_route.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/decnet/dn_route.c b/net/decnet/dn_route.c
> index 552a53f1d5d0..0a4bed0bc2e3 100644
> --- a/net/decnet/dn_route.c
> +++ b/net/decnet/dn_route.c
> @@ -201,7 +201,7 @@ static void dn_dst_check_expire(struct timer_list *unused)
>  		}
>  		spin_unlock(&dn_rt_hash_table[i].lock);
>  
> -		if ((jiffies - now) > 0)
> +		if (time_is_before_jiffies(now))

Uhmm... it looks like the wrap-around condition can happen only in
theory: 'now' is initialized just before entering this loop, and we
will break as soon as jiffies increment. The wrap-around could happen
only if a single iteration of the loop takes more than LONG_MAX
jiffies.

If that happens, we have a completely different kind of much more
serious problem, I think ;)

So this change is mostly for core readability's sake. I personally find
more readable:

		if (jiffies != now)

Cheers,

Paolo

p.s. given the above I guess this is for the net-next tree, right?

