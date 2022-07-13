Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC2457369A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiGMMvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiGMMvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:51:02 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854FE31386
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:51:01 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-31c9b70c382so111473107b3.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b0grnpTAwlaIA0e8SLaBby96qs6xR+aChbOJ/uTi3A4=;
        b=EfRefKrOjKXxikCldDewqAT41aS64zCoD7Zz54Wva9PBRRaY7EUDUG/CwDUw8iczrm
         nmofFIXfZ2pOSJ9kSkrCctyGWSOWymWPdyXxt59R5qd3nYqCJKr3W+QhCTyoPa8TtoTX
         mMbZb1Yfen1/Y1CmuLGmSdwEzZfLhSXCMMjwH67jdx0PFGcPrLfvuamPad18PGUhSgUI
         BVajtjA/H9aEbYqdbR2A2APH/wdxhyUYluLt4RtygDQwuLoxBs8nLyJzXNo0PHru0u5Z
         uZN8K195CmE5aTb/XFkrL7fty+QKyousat4seQ55WDQR8MlKdf6Bfe3QANIqfRgJvZmP
         VBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b0grnpTAwlaIA0e8SLaBby96qs6xR+aChbOJ/uTi3A4=;
        b=ROgCFpjtQYFsyk4JnYOya5wWpJkWTrMvwQUGkgXa7asvpyJV9xyMZqpJsLymYLouMV
         8dMnmbn7xT/LHyemaw/qNTWeqH2cICGp+Pa0c7o1a7REoFkgGaE+T6U7HW0QgbaNGCrp
         3aSS/K4+b1C/WHrl9dEETdnTReoUn0Bsv2NkxOlvCyFStmpeSNmr2galwliZlrkr2yTe
         k6/frUlA9q3UFgaEpYonjdOzHcwXLALrIK7kFoUBqKuaUiC5C0rBSYqYyqElH2iETQSb
         WIGb5TlGsj63HcxhqSmGpwWIXeRWvWF8GO45VKyrm50hy2EbOaOwPPY4mJX/ZZlRnqwC
         tlyQ==
X-Gm-Message-State: AJIora9lfO+G7JHT3ggyW7w6HKsnmgiCFBf63kc5y3GrKjo6Ady+2HnD
        Ee+PRdyyLg4/MswvkJ3WHzJwRHcDLuDiHANsjzgUIw==
X-Google-Smtp-Source: AGRyM1uCxrl4b8/cqlwBnDIW63xTxY1B1jCHgyPVGm1mF5cpMxB2nJWl+tZXIfab3jt/MY0dwr1W/SfDW6exFcdycyQ=
X-Received: by 2002:a0d:dd09:0:b0:31c:e3b9:7442 with SMTP id
 g9-20020a0ddd09000000b0031ce3b97442mr4030906ywe.47.1657716660533; Wed, 13 Jul
 2022 05:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220712181456.3398-1-olek2@wp.pl>
In-Reply-To: <20220712181456.3398-1-olek2@wp.pl>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 13 Jul 2022 14:50:48 +0200
Message-ID: <CANn89iLbFYaV9MhYMHAzZOKM=ZKaAPOAuuXec_t9G5s4ypnY6A@mail.gmail.com>
Subject: Re: [PATCH net-next] net: lantiq_xrx200: use skb cache
To:     Aleksander Jan Bajkowski <olek2@wp.pl>
Cc:     hauke@hauke-m.de, David Miller <davem@davemloft.net>,
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

On Tue, Jul 12, 2022 at 8:15 PM Aleksander Jan Bajkowski <olek2@wp.pl> wrote:
>
> napi_build_skb() reuses NAPI skbuff_head cache in order to save some
> cycles on freeing/allocating skbuff_heads on every new Rx or completed
> Tx.
> Use napi_consume_skb() to feed the cache with skbuff_heads of completed
> Tx. The budget parameter is added to indicate NAPI context, as a value
> of zero can be passed in the case of netpoll.
>
> NAT performance results on BT Home Hub 5A (kernel 5.15.45, mtu 1500):
>
> Fast path (Software Flow Offload):
>         Up      Down
> Before  702.4   719.3
> After   707.3   739.9
>
> Slow path:
>         Up      Down
> Before  91.8    184.1
> After   92.0    185.7
>
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>  drivers/net/ethernet/lantiq_xrx200.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/lantiq_xrx200.c b/drivers/net/ethernet/lantiq_xrx200.c
> index 5edb68a8aab1..83e07404803f 100644
> --- a/drivers/net/ethernet/lantiq_xrx200.c
> +++ b/drivers/net/ethernet/lantiq_xrx200.c
> @@ -238,7 +238,7 @@ static int xrx200_hw_receive(struct xrx200_chan *ch)
>                 return ret;
>         }
>
> -       skb = build_skb(buf, priv->rx_skb_size);
> +       skb = napi_build_skb(buf, priv->rx_skb_size);

If you are changing this code path, what about adding proper error recovery ?

skb can be NULL at this point :/


>         skb_reserve(skb, NET_SKB_PAD);
>         skb_put(skb, len);
>
> @@ -321,7 +321,7 @@ static int xrx200_tx_housekeeping(struct napi_struct *napi, int budget)
>                         pkts++;
>                         bytes += skb->len;
>                         ch->skb[ch->tx_free] = NULL;
> -                       consume_skb(skb);
> +                       napi_consume_skb(skb, budget);
>                         memset(&ch->dma.desc_base[ch->tx_free], 0,
>                                sizeof(struct ltq_dma_desc));
>                         ch->tx_free++;
> --
> 2.30.2
>
