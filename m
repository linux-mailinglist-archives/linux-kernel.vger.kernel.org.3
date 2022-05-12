Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C3C525481
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 20:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352415AbiELSOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 14:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241392AbiELSN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 14:13:59 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343BE20D577
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 11:13:58 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id g28so11239365ybj.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 11:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cfuve+c5Cwa7UJ0vQNcacC+/40JGpfLbjA8g3t9eIqQ=;
        b=NZHWcKJjdxGhGeikxnkOyvDffaXBl4vKuicdYIsXaTBG2teHtca2Fd1CjL4dr0p4r/
         SvpxexJECOuPNbkgeXDSwdkXpodxbGttPU3Kaci3pcsdLf2jEwK61kGImtNXRXYPgqU3
         WNUD+ic2R0CXvMB+k4ApzwMxZsPVGQ+uaEWtCAsgw40To+8srzWnDv3luZ+MYVEXJiAS
         VtQrPHcUd0rrtZgelUdW8hafe8DlNNz9fEy1aKh5rJWDNceP9RwH/LBq2pLButUTjICb
         WupTbkYqQRJdPAfNOjruetejDsm8NzIcHVZcPBy+3V7amKui0xMwNj4JxDG8TqcegZvp
         Igiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cfuve+c5Cwa7UJ0vQNcacC+/40JGpfLbjA8g3t9eIqQ=;
        b=ZqBC5KLUaMQ2ObGte7w/w75mADNT51KzPd2IeEF9ZuXpY+nGNyiVltAIudoLq+HzpY
         DkPzPQdnhfjA29zb3yLi3JRgoBQ+ZclZhaN3gAJpdHnFVR1F/ECUH0ttGVagiHuCozye
         Q/LLuakCvp4tTw5weuzdO1gLPb+Ez9y01ii7TxFtI6OWT4soTuoOD9MW/1wrzRdXe2Ni
         H5XSuUYlcUYq06UNCs1Ns4Gveiwt39kdfV7/mGEwwQUnKDdqz+vb2lB8PYJwS+z6a86+
         bKlunS9Auh2wV+rg/obbKadZEyXCvkFEhRCqWo3713JhbHyA6auPBoUB8d5MQwuVniOJ
         LoHA==
X-Gm-Message-State: AOAM53112dpT6WsUVwvIkjYoeetDybPaTL9kLudpq6nNEn+LDAabZ2pf
        rkxU00GDjK6ucJpNC+LaktDgBiN6G304kM0H76NTVQ==
X-Google-Smtp-Source: ABdhPJz5a/C03+Ye4a57gqvTMVgbBIihW4avWA5q3KyzdtF9EIDzbqQSeka3lH0aMt0bRVYWn7CcyUoK6mImJaYRlsU=
X-Received: by 2002:a25:3157:0:b0:649:b216:bb4e with SMTP id
 x84-20020a253157000000b00649b216bb4emr1062269ybx.387.1652379237164; Thu, 12
 May 2022 11:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <93323bba-476e-f821-045c-9fe942143da9@gmail.com>
In-Reply-To: <93323bba-476e-f821-045c-9fe942143da9@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 12 May 2022 11:13:46 -0700
Message-ID: <CANn89iKjt1wpGk1dqqnYYx3r9UzEc3rwNtvBQ1O2dVToY_7rBQ@mail.gmail.com>
Subject: Re: BUG: TCP timewait sockets survive across namespace creation in net-next
To:     Leonard Crestez <cdleonard@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
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

On Thu, May 12, 2022 at 11:01 AM Leonard Crestez <cdleonard@gmail.com> wrote:
>
> Hello,
>
> It appears that in recent net-next versions it is possible for sockets
> in the timewait state to survive across namespace add/del. Timewait
> sockets are inserted into a global hash and only the sock_net value is
> compared when they are enumerated from interfaces like /proc/net/tcp and
> inet_diag. Old TW sockets are not cleared after namespace delete and
> namespaces are allocated from a slab and thus their pointers get reused
> a lot, when that happens timewait sockets from an old namespace will
> show up in the new one.
>
> This can be reproduced by establishing a TCP connection over a veth pair
> between two namespaces, closing and then recreating those namespaces.
> Old timewait sockets will be visible and it happens quite reliably,
> often on the first iteration. I can try to provide a script for this.
>
> I can't point to specific bugs outside of tests that explicitly
> enumerate timewait sockets but letting sk_net be a dangling pointer
> seems very dangerous. It also violates the idea of network namespaces
> being independent and isolated.
>
> This does not happen in 5.17, I bisected this behavior to commit
> 0dad4087a86a ("tcp/dccp: get rid of inet_twsk_purge()")
>

Thanks for the report.

I guess we will need to store the (struct net)->net_cookie to
disambiguate the case
where a new 'struct net' is reusing the same storage than an old one.
