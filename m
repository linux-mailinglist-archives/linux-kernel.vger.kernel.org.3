Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCB54E531F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244239AbiCWN13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbiCWN1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:27:25 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED76522F0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:25:55 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2e5827a76f4so16900567b3.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z7oawa2AY57m2xBNWTaEFL3ZAO7yqhBtsuz3WE96h5o=;
        b=WG6b+izbQ6vRlRg1kHzR8Hso6XWGHQmvm5bR3JDsIjTSzHbcoRHVDgcrB66VsgSaOJ
         yY4VzstDQy6L07tda/xDjSBOMNQi6c/sPgZoSuHk5bc+jgqZvZuabgJu2eet8XbwH6Ht
         HqtTVWvnVmxiHdZDM4TpXGbjowiNYP1TCoSCbuVxWjfChWUXprL0MoKXfhUNB3W/I40n
         264gV6ZCFTG9YCmhl7YZSP4YLo3Nim1fbc4X6k1mB8KL2np0QCrySr8K0y/ITB3ZgwQf
         sG8LX1dHNH0slb4ntL76PAGQXlWelY/NS7o8RjNg5Am19uFyHADjCOcVLbuL6Ev6RDb7
         QX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z7oawa2AY57m2xBNWTaEFL3ZAO7yqhBtsuz3WE96h5o=;
        b=t10KkZYUvhMp2l+8WFOlBqCqBR/Ws2VYaeP51LxmY3xna0Ry2aUSy2g61xEUr+DOCU
         MP0hIoSQwbm6WBYmz6uEVV9ryEpGYpsg/8CdWJwyzEUI5g5b1VjwCu0axp9vnu79Uzge
         7xugla92n4sMJgp9K+OVA06xE8LjrWB9MHaJbcKAh9ynIUfR7B8mzZwS2EVDhthgVqQd
         UxCMjMC7t7QtFpF2BX6Wp6j2nSamjBjOBYlAEezNobMZ6ALDa5ExgTm+67dI28xP/1qC
         0aWE9IFJWuqREPu54LLznKF28YyDDRU8kjoTC9dZhMbdfR0yD8mVHWkmOvAo/iF/YkEW
         sZbw==
X-Gm-Message-State: AOAM532O0pZlBuIpJuWb6F9HEmURn8JlxQ9toLLIN0/fUjyDimJdyajJ
        vCEs75bt4VN2FVj16NtpLjfbqU8IHGj2ciAXt3l8+w==
X-Google-Smtp-Source: ABdhPJyXBZTLE+SdHvEM6HOhfR6sCqIa8iHPqXFGCtKCw6kEG9clABgN7+k7eLGXEtgng7QDuYBXenveLsJk9y/tWLU=
X-Received: by 2002:a81:784b:0:b0:2e5:9f35:a90f with SMTP id
 t72-20020a81784b000000b002e59f35a90fmr35657587ywc.278.1648041954053; Wed, 23
 Mar 2022 06:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <0f6d4f89-c08d-b985-075e-a763fec87fc4@163.com>
In-Reply-To: <0f6d4f89-c08d-b985-075e-a763fec87fc4@163.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 23 Mar 2022 06:25:43 -0700
Message-ID: <CANn89iKs0W=_HixT7_2R0xBrwEMEvin1-JHijjDNeMOqLKLmpg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: consume packet after do time wait process
To:     Jianguo Wu <wujianguo106@163.com>
Cc:     Menglong Dong <menglong8.dong@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 6:05 AM Jianguo Wu <wujianguo106@163.com> wrote:
>
> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>
> Using consume_skb() instead of kfree_skb_reason() after do normally
> time wait process to be drop monitor friendly.
>
> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
> ---
>

1) net-next is closed.

2) This seems pretty much random to me, we definitely reach this point
with packets that are dropped.

These are classified as drops.

You know, TCP can handle reordered packets, spurious retransmits, and
stuff like that, we do not want to hide this,
otherwise we would have used consume_skb() for all packets.

After all, TCP handles all incoming packets 'normally'.

If you really care, I suggest you change (when net-next reopens in two
weeks) the @reason to more precisely describe what is happening.
