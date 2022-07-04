Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FDD565835
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbiGDODd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbiGDOD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:03:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 797C755A0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656943404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZtaBQODHPPVn6REl9k6DTx3SbqX1zxC4sBAevPzx3v0=;
        b=TfIMG9QHSLoJSeOxNBh8YDnvWnBZGkNV5kioNJlQlNEYp/l342xshZFg2+ROlLVAbu4B0C
        hkV1Vt8CQSZeUIRTK3tACZxF6IAE6yshO3YgCJv7YFrucyvhoYAUc/OLWJK1f8cWdaKoEN
        BdCXoCV5XZSF87WYpiJQ9Gi5G496+Rg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-0o3f8wjbPl-FNF25smz5Ow-1; Mon, 04 Jul 2022 10:03:23 -0400
X-MC-Unique: 0o3f8wjbPl-FNF25smz5Ow-1
Received: by mail-qt1-f199.google.com with SMTP id u2-20020ac80502000000b002f94701339eso6949750qtg.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 07:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZtaBQODHPPVn6REl9k6DTx3SbqX1zxC4sBAevPzx3v0=;
        b=wR9nTEudiJ/LvFC29OoWA+jKNgISMAAOVExmNZxDc+oB1btzQ22vwMQnSoYXcGPU5c
         eu9qoTdq3eA778KQiaKzczitdhtDZPNa0oco0+xgTlvtfWZkP0jtiCXKJj/WN9kg845A
         N/30+nlPEng8W1zEmpFiqzoAmQzwgExGzXqYqMoACdOaJf/K7OqwxDklmiaJmmALEOOE
         fLOjL9AT6Qg4a1rG3FOa7kBkc5MLn+ci1QBnMzViBq3fCLi3qk4iuUr31WJGgJ/ddyex
         Ez2BoDw/+il4a57BYIK0LOfaqTDNZYzzDGj4LA08jvKe6CVHcqEwCqcWNAA4OJ0OMi1z
         XCyA==
X-Gm-Message-State: AJIora/4RRcOu4iE/eHH3fgiZKdE7koRvFnAtgWVI+swK2DfT6hk6648
        hxh14XTLFlzNEEmCKQNkwRqwTETEooEuIu4ilIQGAXO7zEtOza/qYcTPakCUEmtDUp4kyv/UWVO
        5Rk1nF1P0PzNqpHY4tu7OuaT7
X-Received: by 2002:a05:620a:854:b0:6af:306c:faff with SMTP id u20-20020a05620a085400b006af306cfaffmr19558442qku.641.1656943402527;
        Mon, 04 Jul 2022 07:03:22 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uQcQaf/QdU2bbuYDjTc7wwIrgdx0iCMl526MN+QPFNIQaG9+Pq+FP7Bs45+Tr8HApzVnCbrg==
X-Received: by 2002:a05:620a:854:b0:6af:306c:faff with SMTP id u20-20020a05620a085400b006af306cfaffmr19558409qku.641.1656943402211;
        Mon, 04 Jul 2022 07:03:22 -0700 (PDT)
Received: from [10.0.0.96] ([24.225.241.171])
        by smtp.gmail.com with ESMTPSA id bm14-20020a05620a198e00b006b2849cdd37sm4188998qkb.113.2022.07.04.07.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 07:03:21 -0700 (PDT)
Message-ID: <fc255ca5-0171-1bae-18a1-4feb6cbf4b3c@redhat.com>
Date:   Mon, 4 Jul 2022 10:03:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] net: tipc: fix possible infoleak in tipc_mon_rcv()
Content-Language: en-US
To:     Hangyu Hua <hbh25y@gmail.com>, ying.xue@windriver.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20220628025921.14767-1-hbh25y@gmail.com>
From:   Jon Maloy <jmaloy@redhat.com>
In-Reply-To: <20220628025921.14767-1-hbh25y@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/27/22 22:59, Hangyu Hua wrote:
> dom_bef is use to cache current domain record only if current domain
> exists. But when current domain does not exist, dom_bef will still be used
> in mon_identify_lost_members. This may lead to an information leak.
>
> Fix this by adding a memset before using dom_bef.
>
> Fixes: 35c55c9877f8 ("tipc: add neighbor monitoring framework")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>   net/tipc/monitor.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/net/tipc/monitor.c b/net/tipc/monitor.c
> index 2f4d23238a7e..67084e5aa15c 100644
> --- a/net/tipc/monitor.c
> +++ b/net/tipc/monitor.c
> @@ -534,6 +534,7 @@ void tipc_mon_rcv(struct net *net, void *data, u16 dlen, u32 addr,
>   	state->peer_gen = new_gen;
>   
>   	/* Cache current domain record for later use */
> +	memset(&dom_bef, 0, sizeof(dom_bef));
>   	dom_bef.member_cnt = 0;
>   	dom = peer->domain;
>   	if (dom)
Acked-by: Jon Maloy <jmaloy@redhat.com>

