Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D736753FD64
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242950AbiFGLVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243160AbiFGLUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:20:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E56F6D393
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 04:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654600720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KveuBdGtFJ9vmpEfG9GqwQPGCYjA8kI0FyjUNOuLN+o=;
        b=Gcmei67XKfnfLK30/0BGET0qJqZ3/yKNNJMTRg5AhG90u3vz8Tqv6Iv9F3JOSjhof3MQQR
        dGGajz8h7VqYeIyLMsSm8EiDwoNyuHWyH5zeVnvHgkt3k5Hz8WMqChNRZytIOQTF/Y2x++
        /VBdbjyaHpKCNz042K5dx/I+RY92/6Y=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-1yld1TuAObWyZUZPieyhYQ-1; Tue, 07 Jun 2022 07:18:39 -0400
X-MC-Unique: 1yld1TuAObWyZUZPieyhYQ-1
Received: by mail-qt1-f197.google.com with SMTP id f22-20020ac859d6000000b00304bf4dba7fso13687740qtf.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 04:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=KveuBdGtFJ9vmpEfG9GqwQPGCYjA8kI0FyjUNOuLN+o=;
        b=fbY5sMpD096OjeG0ruTre3vh6jkwJBywfsltWDK10OQnLiA/+UGBuYRMKansQjot5j
         /MMxNv6lf+MMdFyUN9zCoH4IUicrz8MbWVvnMbb7Lmp8mlc2mSG2rtgZIVh8vr8CvL8k
         FPqWDRPv8bKo2BJzbeoEKrpOBqaLohij8JhfBXfjHrEgJCZnW3XP085oWQ1ZXGkCVoW3
         LqoYNeGnkf3lBrn1c2lST8Yk2ZtNsbh8wDh9MWw8hot57wOdBV8aOc5XUePDwNzM3FyR
         7RqEuEH4X5/S4DanYstbZBs5GNcloKA0tDEc/AZUED3HyNG2BiCH4JHxRnwT49+Qwg6G
         okxA==
X-Gm-Message-State: AOAM532DhgosIQ2nre1to7rRs2DjpilkbhvQllEnvmS+ujo2jDFYPPbq
        tHIIgh0j7OPYI7yVzLiHRxU9S9G3aUHOGMk06yekl28mH3SPDjRwV+Ras1Uda0i5vNmwBn8MUS7
        51H5WpPMAg3X2Cjp7wKnT3Ytc
X-Received: by 2002:ac8:5989:0:b0:304:fcb8:f3c1 with SMTP id e9-20020ac85989000000b00304fcb8f3c1mr853574qte.520.1654600718461;
        Tue, 07 Jun 2022 04:18:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqmTf47d0DplaahPzB82zvXlTqHsG3V3+k02H/FTJ7wL51qaKESs/0TO5rP9+tJeHmOGicQQ==
X-Received: by 2002:ac8:5989:0:b0:304:fcb8:f3c1 with SMTP id e9-20020ac85989000000b00304fcb8f3c1mr853553qte.520.1654600718172;
        Tue, 07 Jun 2022 04:18:38 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-112-184.dyn.eolo.it. [146.241.112.184])
        by smtp.gmail.com with ESMTPSA id z12-20020ac8454c000000b00304ee715045sm2969857qtn.15.2022.06.07.04.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 04:18:37 -0700 (PDT)
Message-ID: <52e02030f7b2c0052472f127dae91fb9f5312b85.camel@redhat.com>
Subject: Re: [PATCH 2/3] net: xfrm: unexport __init-annotated
 xfrm4_protocol_init()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Ahern <dsahern@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Date:   Tue, 07 Jun 2022 13:18:32 +0200
In-Reply-To: <20220606045355.4160711-3-masahiroy@kernel.org>
References: <20220606045355.4160711-1-masahiroy@kernel.org>
         <20220606045355.4160711-3-masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-06-06 at 13:53 +0900, Masahiro Yamada wrote:
> EXPORT_SYMBOL and __init is a bad combination because the .init.text
> section is freed up after the initialization. Hence, modules cannot
> use symbols annotated __init. The access to a freed symbol may end up
> with kernel panic.
> 
> modpost used to detect it, but it has been broken for a decade.
> 
> Recently, I fixed modpost so it started to warn it again, then this
> showed up in linux-next builds.
> 
> There are two ways to fix it:
> 
>   - Remove __init
>   - Remove EXPORT_SYMBOL
> 
> I chose the latter for this case because the only in-tree call-site,
> net/ipv4/xfrm4_policy.c is never compiled as modular.
> (CONFIG_XFRM is boolean)
> 
> Fixes: 2f32b51b609f ("xfrm: Introduce xfrm_input_afinfo to access the the callbacks properly")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

@Steffen: are you ok if we take this one in the -net tree directly?
Otherwise a repost would probably be the better option, with this patch
stand-alone targeting the ipsec tree and the other 2 targeting -net.

Thanks!

Paolo

