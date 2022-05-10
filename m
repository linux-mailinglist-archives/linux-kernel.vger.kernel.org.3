Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34251520AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 04:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbiEJCKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 22:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbiEJCKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 22:10:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7959E3190C
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 19:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652148372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1+7DKJlYnVWlLlv05GdYL70k7bNZ4ECrKaTftEIR5dg=;
        b=A/hn0IDYavP0NCsk3JG9gDugV13/IV1uULRRjcuGqTBYLmBmikZCpop9OHyGo/2NFxHbgD
        OI8gNCwgAGQoVbOo8VcONioYiZ053Nrr+/JE0CDR+2DF/8Sj9FFomxHXhCQCqGLr5jkRHo
        n81lWkM0aSCtevAqXqmX8Bf5VS5VpJg=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-8c5F1zBKMyaAFe2v_B3fyg-1; Mon, 09 May 2022 22:06:11 -0400
X-MC-Unique: 8c5F1zBKMyaAFe2v_B3fyg-1
Received: by mail-lj1-f198.google.com with SMTP id e3-20020a2e9303000000b00249765c005cso4661439ljh.17
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 19:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1+7DKJlYnVWlLlv05GdYL70k7bNZ4ECrKaTftEIR5dg=;
        b=pgcEyubzWeSWGX4mj7UpGDEnL9pCgfPNnyDJyUV2txGOYbOE+vd+hNg+nbq50fYS9z
         liw4lzCqvcy9T15mFyYJMvoPc05Iy7QDDF6bu47nMdv/KCUxPMk1LdZBpTYbm2Yx4oeP
         +OKT7sYHP6QvJ/6gynA+sbxfHioeCLo6E3SphsbMdXNtaAhtXDm+vRf1J4UMgCokcI2k
         +FHv/Twj3CdykTzhYO0vhsTYLv9qMPrYc9XyRBZ/W+c0T7e33NnDuRDmajPltcUcPDwk
         drWMG2gXPFOl7pzGxXXtUZ/65qvGvQ21tQskOZyxnx2lNDeRcQ8hr/xYfBS1OUIIkrGd
         HXTg==
X-Gm-Message-State: AOAM532JQxQHFPDHcIVNyeYAVwH1vh0HLFaxw1/lLkWOyZc2a8WT6jf+
        Pi93caSxtIffkjSiloC/iIO+DEm8VfBaWU/SOEmbN/MVAjMYh0xLWYygcncPcU6Gz8SWLyWf1Wf
        maWak0Zd7o7VGysojhMNC4jKFuvyHPUV2jyuC8uUl
X-Received: by 2002:a05:6512:1291:b0:473:b522:ef58 with SMTP id u17-20020a056512129100b00473b522ef58mr14663348lfs.190.1652148369341;
        Mon, 09 May 2022 19:06:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqm9wM4Q4M/oBxtLuElylO6DH3m6+GFVYHnDAHl4WJIlpMcpnYNKA34plV6IrXxJfBaTuguqI4UMAX70BJRQI=
X-Received: by 2002:a05:6512:1291:b0:473:b522:ef58 with SMTP id
 u17-20020a056512129100b00473b522ef58mr14663333lfs.190.1652148369130; Mon, 09
 May 2022 19:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220509131432.16568-1-tangbin@cmss.chinamobile.com>
In-Reply-To: <20220509131432.16568-1-tangbin@cmss.chinamobile.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 10 May 2022 10:05:58 +0800
Message-ID: <CACGkMEtVZ7MA5ZU8rogJYRvuD6D0Zm1Dg_LKXJ2NmPhJ6Smi-A@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: Remove unused case in virtio_skb_set_hash()
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     mst <mst@redhat.com>, davem <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 9, 2022 at 9:17 PM Tang Bin <tangbin@cmss.chinamobile.com> wrote:
>
> In this function, "VIRTIO_NET_HASH_REPORT_NONE" is included
> in "default", so it canbe removed.
>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/net/virtio_net.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 87838cbe3..b3e5d8637 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1172,7 +1172,6 @@ static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
>         case VIRTIO_NET_HASH_REPORT_IPv6_EX:
>                 rss_hash_type = PKT_HASH_TYPE_L3;
>                 break;
> -       case VIRTIO_NET_HASH_REPORT_NONE:
>         default:
>                 rss_hash_type = PKT_HASH_TYPE_NONE;

I wonder if we need to do things in the reverse. Warn for default and
only set NONE when it's NONE?

Thanks

>         }
> --
> 2.20.1.windows.1
>
>
>

