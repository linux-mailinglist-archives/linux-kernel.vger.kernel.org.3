Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9F94B2BAE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352052AbiBKRYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:24:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbiBKRYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:24:44 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C13CEB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:24:43 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id v186so27030827ybg.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1f5nHZJ9uVD6/I7NM/ovxfltUAK5E77rKDDs7ab4Xic=;
        b=hdu4UcvLhoPoj1+nnYpidzG5ybt+SATEc36EIA2F0rim60MDWLZbsC80UkLLFmgXby
         6I7VzLYSiW5Hapfkc4bxg/0zMn3VeyGHa9/SvKDExmKANfuJfsNd6je7gRTcEAM/wO2E
         5k/ztc0BzeVqRc/H/3YbHOxS3vgNm34Mbjg/TDoA/kaFo5G8eyLRjuaGUtF9h0KcMX9m
         fEuLqzzSDlJ0RCRESc6rqHoVWILYakTV0dwZXWrP4312DRfINDk2pgn0Fu7FKQ3rF7x0
         25wJIFy+QCKBFG07xvaYmccVexj7YtoX+pqqDBPrxZ6At0yiOQT+AwCoJmqV3vTfAtPA
         QcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1f5nHZJ9uVD6/I7NM/ovxfltUAK5E77rKDDs7ab4Xic=;
        b=YEbduahd9FyhJoRvc5NYTjPjeNyjrsrUqnXciyXuGsAFaLQHNyGHD/kVdJ6p+vuOYl
         GyyWoz1mWUC/HvDq7yxmTeu6fNUxtfc1ZS1/rrnMO9RCh+V6r56Z22j1/IyhTJenFIYD
         WAJieFIPMVGqflwUmAz0h726jVqJSSxwQBETuhiy9gP5htX2smKw2d8WsfOO79r8aWvC
         8c4brSRYsP+N+oVXEyytZ+T7L/dOoCKm6V58sLSXf0IQlnSRypRk1xfKl7cWyxnDujTF
         gsVN8Yp/T3/8adS8pz+/Z7Nl+h0BLQD0xkELMKCTWuJpQ4HQ5gGzzPFSJjACNwozzHCK
         CtIA==
X-Gm-Message-State: AOAM532yBHZtJVJFTEqfKXOl3ONM816d2bENcfU/hTmRSxnFbCqn19uB
        JwvM4uhM37Z9zCRBq36hQINPVBuvCr1WkqiqwJgKAg==
X-Google-Smtp-Source: ABdhPJxmj9cstWH2lKAb2aiO3OuQbmZ8A5jPVYo/c8dto0k13vNXhpRUa1YxFuZZi/PUuAIxg/HTlYAJuXQSAWRKgDo=
X-Received: by 2002:a25:8885:: with SMTP id d5mr2268605ybl.383.1644600281921;
 Fri, 11 Feb 2022 09:24:41 -0800 (PST)
MIME-Version: 1.0
References: <20220211164026.409225-1-ribalda@chromium.org>
In-Reply-To: <20220211164026.409225-1-ribalda@chromium.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 11 Feb 2022 09:24:30 -0800
Message-ID: <CANn89i+2idhm3wpGO79RHdCYMfYuKURvBaWmoXmYxBwj5z59yg@mail.gmail.com>
Subject: Re: [PATCH] net: Fix build when CONFIG_INET is not enabled
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
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

On Fri, Feb 11, 2022 at 8:40 AM Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> If the kernel is configured with CONFIG_NET, but without CONFIG_INET we
> get the following error when building:
>
> sock.c:(.text+0x4c17): undefined reference to `__sk_defer_free_flush'
>
> Lets move __sk_defer_free_flush to sock.c
>

deja vu ?

commit 48cec899e357cfb92d022a9c0df6bbe72a7f6951
Author: Gal Pressman <gal@nvidia.com>
Date:   Thu Jan 20 14:34:40 2022 +0200

    tcp: Add a stub for sk_defer_free_flush()

    When compiling the kernel with CONFIG_INET disabled, the
    sk_defer_free_flush() should be defined as a nop.

    This resolves the following compilation error:
      ld: net/core/sock.o: in function `sk_defer_free_flush':
      ./include/net/tcp.h:1378: undefined reference to `__sk_defer_free_flush'

    Fixes: 79074a72d335 ("net: Flush deferred skb free on socket destroy")
    Reported-by: kernel test robot <lkp@intel.com>
    Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
    Signed-off-by: Gal Pressman <gal@nvidia.com>
    Reviewed-by: Eric Dumazet <edumazet@google.com>
    Link: https://lore.kernel.org/r/20220120123440.9088-1-gal@nvidia.com
    Signed-off-by: Jakub Kicinski <kuba@kernel.org>
