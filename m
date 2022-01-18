Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC41492168
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 09:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344683AbiARIlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 03:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344657AbiARIlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 03:41:08 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AC2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 00:41:08 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id e195so23447973ybb.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 00:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RFkYsmyKXVxPgy1SNKAFnzRSO2aG6JX2VOeyMG/TA8Y=;
        b=XP8NwWLgL+XCYb0wC9m2BK/1T8Shj1KIZKM0l+yLNIJg2YkgI5EPN62q5BVBLToJLc
         Ulz0z+cLA1JJmL4x5lRXrMnuaq0cM9IzlaWPg+dEFWf5iSUWhNV0ErVnTCRfVKQWeMEn
         B9d3O8nIy1fm6PiQpekozB/aizCJ1rhaXrsAnY2sb43xGFPY8RtRACrusxpLgpoGAV3O
         Gs/Rg+/r85jjc086VJOoOJfY7TQlDC2yg2GWX6HY6+DR4a0teunNQylw+bgjIsYaxHNu
         +e22FNU2/edLcaSxfpAmAcFpVXPyz4s1/dBZWmyxziytmV/Dvca9qTfUgJWt1x0rdlP1
         2P7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RFkYsmyKXVxPgy1SNKAFnzRSO2aG6JX2VOeyMG/TA8Y=;
        b=7pV7PBHtWnSP1JCKbr3GCjMhtv7VGU9x/fjHoS1rBcwkmpCdadL7Ud+wilh6EFcYXO
         86rGyFKY5zd7JAsx8/lXMOTP0NgNeT2CzEzGGzSbEE0S3Ezzhm3R9b9G/OjXNeXCnpTS
         NdFQRzUv1kpsPKiGblgBSp2ghhaKioHHPQT4gKywL6hlH3dXWQvjASjhCkXkppS7T0OB
         GdkgK0ktElVTLGyBTz+72ZvAcbpazgd3/VdP0AiORH8pRequ0TAH/y+LRrAuSZr86H0r
         SQGG4X6WA0S03YFDLif8J7LbD7pvs38VT/6v/ugFr9h8/7sxniy9Crxg4vEGUzABTklo
         gCxA==
X-Gm-Message-State: AOAM533K/E5q5Yn0l9KlstQ6A8I5iV27msB1DZbTkIDzPcZAJUzjWANm
        ZjlGr9l7c6JAaQandsItl6JvI3wNBobNPWZO7hiXJQ==
X-Google-Smtp-Source: ABdhPJyrH1erOmQucbY+yL2P4kCN0PoStEu3D/B7MVpijeSb2GvJKCtvD40QfpN496HFdMwF/xY2AIxMstEKexTjiyY=
X-Received: by 2002:a25:b683:: with SMTP id s3mr30498921ybj.293.1642495267198;
 Tue, 18 Jan 2022 00:41:07 -0800 (PST)
MIME-Version: 1.0
References: <20220118070029.1157324-1-liu3101@purdue.edu>
In-Reply-To: <20220118070029.1157324-1-liu3101@purdue.edu>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 18 Jan 2022 00:40:56 -0800
Message-ID: <CANn89iJevGzP5r6sPXpX=pSxPJWZQHjKKYekZpFTG9xEq50pMg@mail.gmail.com>
Subject: Re: [PATCH net] net: fix information leakage in /proc/net/ptype
To:     Congyu Liu <liu3101@purdue.edu>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Yajun Deng <yajun.deng@linux.dev>,
        Willem de Bruijn <willemb@google.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, rsanger@wand.net.nz,
        Wang Hai <wanghai38@huawei.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        jiapeng.chong@linux.alibaba.com, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 11:01 PM Congyu Liu <liu3101@purdue.edu> wrote:
>
> In one net namespace, after creating a packet socket without binding
> it to a device, users in other net namespaces can observe the new
> `packet_type` added by this packet socket by reading `/proc/net/ptype`
> file. I believe this is minor information leakage as packet socket is
> namespace aware.
>
> Add a function pointer in `packet_type` to retrieve the net namespace
> of corresponding packet socket. In `ptype_seq_show`, if this
> function pointer is not NULL, use it to determine if certain ptype
> should be shown.
>
> Signed-off-by: Congyu Liu <liu3101@purdue.edu>
> ---
>  include/linux/netdevice.h |  1 +
>  net/core/net-procfs.c     |  3 ++-
>  net/packet/af_packet.c    | 18 ++++++++++++++++++
>  3 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 3213c7227b59..72d3601850c5 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2548,6 +2548,7 @@ struct packet_type {
>                                               struct net_device *);
>         bool                    (*id_match)(struct packet_type *ptype,
>                                             struct sock *sk);
> +       struct net              *(*get_net) (struct packet_type *ptype);
>         void                    *af_packet_priv;
>         struct list_head        list;
>  };

Patch looks fine, but the question is:

Can an af_packet socket created in netns A can be moved to netns B later ?

As the answer is probably no, it seems we could simply add a 'struct
net'  pointer
 in 'struct packet type', no need for a function.

Thanks.
