Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183AB53E982
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241654AbiFFQNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241645AbiFFQNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:13:51 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2662C12E81D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:13:50 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id w2so26537273ybi.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 09:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vhMMjLzIwmcQWz+cd8hY1LS5SBvPZoNu1vdCQciJzuo=;
        b=BwTLKaOg1/1dfwnsB9C1ceKn3rjxgUh6zZzwudOhSCI/8LUJAlldzl67X+50ehAm+M
         /YXqPYWB40pSF7lyeVcP+k4cOhMwtzU4TXT3kuCgfNw0/enGvprVCLsmmfHLculQfzHG
         aHoMtQnecuGhfKl47bdKilOaSD+lqRcKUPUb61tfborArvtNd6HmHfT1+uK1T8OHj3/0
         M9tybThMQIhL2uxXBRYYSSpYta19b80YeVlpvujCzOVYYzKx4zMqLN4ohU52pX/7sfIt
         uTa76ldvVcZwq6OK8bFJIROD/yqUjhdoi8Zjnb8a+s8mm37MYZVrc/RqsEqOgZ+h49it
         oPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vhMMjLzIwmcQWz+cd8hY1LS5SBvPZoNu1vdCQciJzuo=;
        b=nkTywkZBnSe4IwshbMUgMLVFlwsVhBXui1gjiy8WM5idZaD/mlZKVHKI2edkHKEdqC
         B0ZY6L0b+EdSCsc/pQNCcMlADiqLSJWo9j5RIoKrA26od1aEQq0vuQaaph7zdqIRII/B
         yqCRrZBbM4JNn0xwTU6QUf82uFKsVOV6fek+Tne4DzW0SauIQlSBKPWBathrQF4iGlr0
         0BNjsaGlBg7RJid24hH8+ubSY0cAYziis+RREje7eFwwvk7skmao3H/Lswfw7dEenqvP
         eo2XX2tq+wD4EQ9Ckm7LDv/seYIvxEwH2aewKfvf82IcnPbZWHbuPcOXX2yNxJOi9KMQ
         MQTw==
X-Gm-Message-State: AOAM533psMcemwBjcs5W1dIxSMvpr4soaOgI165Ms4GkELeUsG2fBvBY
        L3xaeTH2Gf3AqWpCd4EhJ/8R21Rk7zF27bTSvCzBxQ==
X-Google-Smtp-Source: ABdhPJyVE2MJsCN4M3aPIFpAsyfEDo2aK8P4jqAsUKvZUGQvH8j3upXHEklWyam8uj6B5jvon5obChsahnUVLgf7Oys=
X-Received: by 2002:a25:aa32:0:b0:65c:af6a:3502 with SMTP id
 s47-20020a25aa32000000b0065caf6a3502mr25747583ybi.598.1654532028789; Mon, 06
 Jun 2022 09:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220606070804.40268-1-songmuchun@bytedance.com> <CANn89iJwuW6PykKE03wB24KATtk88tS4eSHH42i+dBFtaK8zsg@mail.gmail.com>
In-Reply-To: <CANn89iJwuW6PykKE03wB24KATtk88tS4eSHH42i+dBFtaK8zsg@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 6 Jun 2022 09:13:37 -0700
Message-ID: <CANn89iKeOfDNmy0zPWHctuUQMb4UTiGxza9j3QVMsjuXFmeuhQ@mail.gmail.com>
Subject: Re: [PATCH] tcp: use kvmalloc_array() to allocate table_perturb
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     David Miller <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 6, 2022 at 9:05 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Mon, Jun 6, 2022 at 12:08 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > In our server, there may be no high order (>= 6) memory since we reserve
> > lots of HugeTLB pages when booting.  Then the system panic.  So use
> > kvmalloc_array() to allocate table_perturb.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> Please add a Fixes: tag and CC original author ?
>
> Thanks.

Also using alloc_large_system_hash() might be a better option anyway,
spreading pages on multiple nodes on NUMA hosts.
