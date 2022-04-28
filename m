Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D986B513640
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240900AbiD1OIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242726AbiD1OIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:08:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57B6FB7170
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651154673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D6uYppXcp7ESP0Xumz4URTyeufDj8tNhnc7swxqgC1E=;
        b=jJBxeEBRsUZhFBEX3zJTQ9yCZ89BE1ZJLXXiWXOHlrOLeV/A3XMcspfubjQbSroht1h2p2
        PBmm9ytv+Oi/6Wkvn3vFzlkDQILQ0T7nKRT5Bhwxg3I5QzTpWiX0+wnqolRqpnOrcGnI3l
        R2ySwSNLkv9ghkA2nNOSBv4nPiCnNao=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-tyNO-FdMMMqfwDO_v8rUNw-1; Thu, 28 Apr 2022 10:04:32 -0400
X-MC-Unique: tyNO-FdMMMqfwDO_v8rUNw-1
Received: by mail-wm1-f72.google.com with SMTP id i131-20020a1c3b89000000b00393fbb0718bso3270836wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=D6uYppXcp7ESP0Xumz4URTyeufDj8tNhnc7swxqgC1E=;
        b=SBcGsZsSwDOA7NY2qL7vesfmyInZsfZ8OWhYBzn8ChsHBVgu+kPHniWeIZmLKA0Lbv
         bopR8fCGj7RK2IcXKz5DWoRfpCbZafxB9AfFa27h0yzCi0zXIe4CkUJm4V8BAWgjUOUa
         MPaJYMXzPrVa37snnGNZ7v1/onfpImDAHrq00D6WL6AuJoVrotHhhoPj3PHaOmo9RAjX
         B9yfPRAWKxKoinzTdziojwgDHdY+3lTqL75FhLtE/HgRTXD3XewQDe9Ga2d3N9hNyrLy
         SrzzxJqC8tEWqrlAeHKa0PkhmvuFUJOI+lBe3ZWBDtK8GTMkh3U1a2NMA2Ftt2cB3att
         MljA==
X-Gm-Message-State: AOAM531GN+mVzbfJAStUuedo2rZ0tA1S20zHdEYF5xG84sEWLOkmuCwW
        E9V3Ef1yxH1JcXLlC4vkUttUTxbWwQ8XuDnedJuP9goKZKTYavigct7+wuf5LmjW2MxjgvntGhn
        VyU6yg456W449vDraQm0U4URy
X-Received: by 2002:a1c:19c1:0:b0:393:a19f:8f95 with SMTP id 184-20020a1c19c1000000b00393a19f8f95mr30925938wmz.149.1651154670761;
        Thu, 28 Apr 2022 07:04:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyf4r64TTH2QiE11UokGxQO67mu7TV1m+PDm/5OgbSaBOzhZy5vETLi5pQhWzbu7edUMN3tVg==
X-Received: by 2002:a1c:19c1:0:b0:393:a19f:8f95 with SMTP id 184-20020a1c19c1000000b00393a19f8f95mr30925912wmz.149.1651154670453;
        Thu, 28 Apr 2022 07:04:30 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-96-13.dyn.eolo.it. [146.241.96.13])
        by smtp.gmail.com with ESMTPSA id n38-20020a05600c502600b00393d946aef4sm4064594wmr.10.2022.04.28.07.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 07:04:29 -0700 (PDT)
Message-ID: <353b5206205cc71d25998c9601a052dade081b94.camel@redhat.com>
Subject: Re: [PATCH net-next 00/11] UDP/IPv6 refactoring
From:   Paolo Abeni <pabeni@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 28 Apr 2022 16:04:28 +0200
In-Reply-To: <cover.1651071843.git.asml.silence@gmail.com>
References: <cover.1651071843.git.asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-04-28 at 11:56 +0100, Pavel Begunkov wrote:
> Refactor UDP/IPv6 and especially udpv6_sendmsg() paths. The end result looks
> cleaner than it was before and the series also removes a bunch of instructions
> and other overhead from the hot path positively affecting performance.
> 
> It was a part of a larger series, there were some perf numbers for it, see
> https://lore.kernel.org/netdev/cover.1648981570.git.asml.silence@gmail.com/
> 
> Pavel Begunkov (11):
>   ipv6: optimise ipcm6 cookie init
>   udp/ipv6: refactor udpv6_sendmsg udplite checks
>   udp/ipv6: move pending section of udpv6_sendmsg
>   udp/ipv6: prioritise the ip6 path over ip4 checks
>   udp/ipv6: optimise udpv6_sendmsg() daddr checks
>   udp/ipv6: optimise out daddr reassignment
>   udp/ipv6: clean up udpv6_sendmsg's saddr init
>   ipv6: partially inline fl6_update_dst()
>   ipv6: refactor opts push in __ip6_make_skb()
>   ipv6: improve opt-less __ip6_make_skb()
>   ipv6: clean up ip6_setup_cork
> 
>  include/net/ipv6.h    |  24 +++----
>  net/ipv6/datagram.c   |   4 +-
>  net/ipv6/exthdrs.c    |  15 ++--
>  net/ipv6/ip6_output.c |  53 +++++++-------
>  net/ipv6/raw.c        |   8 +--
>  net/ipv6/udp.c        | 158 ++++++++++++++++++++----------------------
>  net/l2tp/l2tp_ip6.c   |   8 +--
>  7 files changed, 122 insertions(+), 148 deletions(-)

Just a general comment here: IMHO the above diffstat is quite
significant and some patches looks completely non trivial to me.

I think we need a quite significant performance gain to justify the
above, could you please share your performace data, comprising the
testing scenario?

Thanks!

Paolo

