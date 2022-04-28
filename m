Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E4E5134FA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbiD1NZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235653AbiD1NZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:25:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65AE9AC90A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651152130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1cpZ1xgascUOYLsGfspUdEEjFzPcacJad6qU8kZAaSk=;
        b=brGjntIC47r1V/XHG/aVvgms2bhLVyFKPPi9dTCazEo4K92om6js6mD0iNlyGa2nyvEjFc
        dpk2JBImwUMlnA/CLwQm6p9JJCCXRF3TriUr7YBjsQ1k2/SkV2eCi3/J+D45pstNfP3ve9
        n5gD/zRF4KpJwmcPKowd5C3wOipyIQY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-lxH0JixeNsS-yXPTbgLqfQ-1; Thu, 28 Apr 2022 09:22:08 -0400
X-MC-Unique: lxH0JixeNsS-yXPTbgLqfQ-1
Received: by mail-ej1-f72.google.com with SMTP id qb2-20020a1709077e8200b006f3dd7d3fc5so1251265ejc.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=1cpZ1xgascUOYLsGfspUdEEjFzPcacJad6qU8kZAaSk=;
        b=dOca8u5BtN2DZtwvqw4V9SWP1Ni8Wv1iaqWb4S1UGSCxL2jyrMaEN5JPY6sWQbvGgl
         V/wXLT4fD2TjP13bOlUb2dWhKy3iEroSSGaGBz6PQthyP/4FDfiBCGoqwKeJDHWLgcyS
         /6ZZMfgBscGvTYt7Zg3Ehr4/vXvMtNTfPTQSs5pTJ01Yxi8KbPKt896s1J0tRZXD7gR6
         t/0j3brThOwsKy0fSh2o4vQKAKTeKGmWBoDIkAFIKE0uhvrmN/70HFeBF8OFMGbzF/AY
         TQAy5z60Ek1r9ijt3CYKeZYm0Asfp3R00LELJL5iHMmz4ZQSLcbQtHlZxLefZsqHAPe2
         Bjvg==
X-Gm-Message-State: AOAM5305bYb0SalMsV9Wwh5aZkkaLkIcshkcwJhUycdNOj1B/fd6dTQk
        BeIT6P3wexRIwKGlJI+WxJ7bpRndpckG7nAo7ohtsIBNuRSSC3dkfgeMRLgVDrndiIXbDg+8csD
        SozMiuhlygT9MGb+h67ECkkY0
X-Received: by 2002:a17:907:7287:b0:6f3:8414:74f1 with SMTP id dt7-20020a170907728700b006f3841474f1mr23685446ejc.123.1651152127076;
        Thu, 28 Apr 2022 06:22:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGk1cJw5aGoIsTO0w7oT+T4JksqnriBA4J7QNSfj97lfUvKKiqr6njoNbuZoBq+Nes7aHiKw==
X-Received: by 2002:a17:907:7287:b0:6f3:8414:74f1 with SMTP id dt7-20020a170907728700b006f3841474f1mr23685372ejc.123.1651152126157;
        Thu, 28 Apr 2022 06:22:06 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id lz12-20020a170906fb0c00b006f3a36a9807sm5210784ejb.19.2022.04.28.06.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 06:22:05 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C131D2F596C; Thu, 28 Apr 2022 15:22:04 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     menglong8.dong@gmail.com, edumazet@google.com
Cc:     rostedt@goodmis.org, mingo@redhat.com, davem@davemloft.net,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, benbjiang@tencent.com, flyingpeng@tencent.com,
        imagedong@tencent.com, kafai@fb.com, talalahmad@google.com,
        keescook@chromium.org, mengensun@tencent.com,
        dongli.zhang@oracle.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: tcp: add skb drop reasons to
 route_req()
In-Reply-To: <20220428073340.224391-3-imagedong@tencent.com>
References: <20220428073340.224391-1-imagedong@tencent.com>
 <20220428073340.224391-3-imagedong@tencent.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 28 Apr 2022 15:22:04 +0200
Message-ID: <87fslxgx6r.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

menglong8.dong@gmail.com writes:

> From: Menglong Dong <imagedong@tencent.com>
>
> Add skb drop reasons to the route_req() in struct tcp_request_sock_ops.
> Following functions are involved:
>
>   tcp_v4_route_req()
>   tcp_v6_route_req()
>   subflow_v4_route_req()
>   subflow_v6_route_req()
>
> And the new reason SKB_DROP_REASON_SECURITY is added, which is used when
> skb is dropped by LSM.

Could we maybe pick a slightly less generic name? If I saw
"SKB_DROP_REASON_SECURITY" my first thought would be something related
to *network* security, like a firewall. Maybe just SKB_DROP_REASON_LSM?

-Toke

