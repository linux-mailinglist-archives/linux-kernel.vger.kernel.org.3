Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4310E4C9A58
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 02:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238867AbiCBBXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 20:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238805AbiCBBXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 20:23:49 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040CE4B841
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 17:23:07 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2d07ae0b1bfso1064057b3.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 17:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZafyWrCRm6FANBOmjYAs3BX8tOsbMPnovvLplgzFND4=;
        b=cK/CT4+cjNdaqB/bq6onYRvRuaBZiEQDxJZG3nZzbEWSoC22iV0dPOwDBcGV9HX56D
         ND6Dj+1FAVJ3cyJqxC6tzp37/UegCdsU6f3uc8/xmd7dASF2LgPnKUagTPDKHP/8NHNt
         3BARM+d3uKUnKHohwayXHbVwzBTXlm1BpUQrQt3KRLGma2vsLHEwWwMc85X7sJMUZ7T1
         V94yzxg+1k1xKAlHHYEtYsLFkXDyZTJIaESXgLOgP0zOsJPOttKrGFC1hJafHCDD+vB1
         TbO/XqsMj+UevbYicLmvXG93/GnrSdajRVKMNZ2RI/vhaedDbO3UM1TeVmiVun/eh8fs
         RnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZafyWrCRm6FANBOmjYAs3BX8tOsbMPnovvLplgzFND4=;
        b=XzA/TNUSBhY/dXACz6BmMPOsgQ4sZji33afuyfcNDGa6t8wUl0y0db5smVsVBsnDnU
         jv6ju9OxWsJiLUA+fD3h2J/0EKp/ANgsnUyW13spNczdnrzbu/GPMnUGxPIX91tCwqlu
         5uWajSyNzhebUIjcJ2eSI7ASS9iyx2cBgBxnZKnHRQA0bk0+NiaCLaeqoAOH1Fux5o+b
         rmWSuvqXQO+ucUZuJGmVaZ5QLLINsch6thquqkuZuGbm6GQDERiDecXECX/CIoGk9qIi
         N6tXjWCOLxjLe+LZNs5KiqwZum9tvktor/bS6eqiq8jObG0G1B6ZgsYPTC+49vXXGAxk
         TxbQ==
X-Gm-Message-State: AOAM5304zg+hAbfvhn5gpTPEHX/BKghUwwBV/IxsrgVYzd+PbDxTGUFa
        R7k6X6llnb2Orc34imQc8jeqRY+LZV0t+RxfRseM6g==
X-Google-Smtp-Source: ABdhPJwu8VhHKIziIJ82Xtt68TP37xWYiasNx7hKoh62sy8WoW2FuyExQ5/AfbTQOYpOaJf6aCN7/8GJjrix3c7mR9Q=
X-Received: by 2002:a81:6a0a:0:b0:2d0:c144:4be4 with SMTP id
 f10-20020a816a0a000000b002d0c1444be4mr28608461ywc.332.1646184185795; Tue, 01
 Mar 2022 17:23:05 -0800 (PST)
MIME-Version: 1.0
References: <1646133431-8948-1-git-send-email-lena.wang@mediatek.com>
In-Reply-To: <1646133431-8948-1-git-send-email-lena.wang@mediatek.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 1 Mar 2022 17:22:54 -0800
Message-ID: <CANn89iLZUWpFC-kAfEbNwh4GDKM+975e_VugmWWT2DNK5K2mAQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: fix up skbs delta_truesize in UDP GRO frag_list
To:     lena wang <lena.wang@mediatek.com>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dongseok Yi <dseok.yi@samsung.com>, wsd_upstream@mediatek.com,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 3:23 AM lena wang <lena.wang@mediatek.com> wrote:
>
> The truesize for a UDP GRO packet is added by main skb and skbs in main
> skb's frag_list:
> skb_gro_receive_list
>         p->truesize += skb->truesize;
>
>
>
> Fixes: 53475c5dd856 ("net: fix use-after-free when UDP GRO with shared fraglist")
> Signed-off-by: lena wang <lena.wang@mediatek.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> ---
> change since v1:
> 1) add the fix tag.
> 2) add net subtree to the subject
> ---
> ---
>  net/core/skbuff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Eric Dumazet <edumazet@google.com>
