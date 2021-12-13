Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26D24721ED
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbhLMHtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:49:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22390 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232554AbhLMHtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:49:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639381748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ajmFbDRx9BLe176bpdQggywBMmHI+LQFi36+JDBB49U=;
        b=GubAAYSVly5HxpYNqmXDo1MSbZoNzceDDzp1yzTU4/gk1qsRtm74RZ3zHpsoWlh08nKhBj
        szWKC0zqSIbNmN5g+ZJzIKjlUpS5IHsXl1B6vwcZsgkspQ+tpQMXpNZ6zX2osKGKNoxVjl
        4C0uB1bJ4TMX5RQi4CmuoV9I2d/qtJU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-NXHwBvE6NxiXPtSlQgkg0Q-1; Mon, 13 Dec 2021 02:49:06 -0500
X-MC-Unique: NXHwBvE6NxiXPtSlQgkg0Q-1
Received: by mail-lj1-f199.google.com with SMTP id w16-20020a05651c103000b00218c9d46faeso4202530ljm.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 23:49:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ajmFbDRx9BLe176bpdQggywBMmHI+LQFi36+JDBB49U=;
        b=JRjxc2wYAeIX/2VKRyO6TekakhlbNpgrgETlf9wmE4909bEQOOEA613j158TMfBU0+
         /UdsGvy8SSqckBW/SM+6DXp301dnYX7THijTCLs0nnehiXLw8NnXrHc81WR8SFq8E1JX
         KwrsecabMWIJFGQvipRaiWBuI5K6qS6+gqSpNDqVqXRXLW6X83jRHjshfNXYjFuzNRPx
         xGdeBvuoj1IObSnML5bK1rPUGiw2l0f6JpHf+/qj+5uirY/JdM1qU0GRTZf/Dw3lI9es
         XIvHqu51/zTXmPrHYjU6HZHXb7SiR/QX3a8Qr3Pxu85H8JxJ4WlU4cKhxUZLvwhieeVa
         i6fw==
X-Gm-Message-State: AOAM530eJ0vCvHuDDXcpSSFShkUnHno4/TgCQ09MOpAMWzJKpK4cOpba
        1JufDNlhK1zkEwiZzVra1fgqD/zpK4sAaHvuilzYYc+haKMygvso4z/GPHG59v0fhpPyGVmKJPF
        HhesJ2fGVCTiTrynoc8MotD/I2Vd7vkNSYy6MjFHI
X-Received: by 2002:a2e:b88d:: with SMTP id r13mr28041717ljp.362.1639381745242;
        Sun, 12 Dec 2021 23:49:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6Kho2IY5dIkx4dw7D65wn0As3tEagQCBwgaJDxLSQvZQN2qrKmtB5zWAMksvRMGbAAVFtrQQetSAmODA5C8k=
X-Received: by 2002:a2e:b88d:: with SMTP id r13mr28041706ljp.362.1639381745081;
 Sun, 12 Dec 2021 23:49:05 -0800 (PST)
MIME-Version: 1.0
References: <20211213045012.12757-1-mengensun@tencent.com>
In-Reply-To: <20211213045012.12757-1-mengensun@tencent.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 13 Dec 2021 15:48:53 +0800
Message-ID: <CACGkMEtLso8QjvmjTQ=S_bbGxu11O_scRa8GT7z6MXfJbfzfRg@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: make copy len check in xdp_linearize_page
To:     mengensun8801@gmail.com
Cc:     davem <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        mengensun <mengensun@tencent.com>,
        MengLong Dong <imagedong@tencent.com>,
        ZhengXiong Jiang <mungerjiang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 12:50 PM <mengensun8801@gmail.com> wrote:
>
> From: mengensun <mengensun@tencent.com>
>
> xdp_linearize_page asume ring elem size is smaller then page size
> when copy the first ring elem, but, there may be a elem size bigger
> then page size.
>
> add_recvbuf_mergeable may add a hole to ring elem, the hole size is
> not sure, according EWMA.

The logic is to try to avoid dropping packets in this case, so I
wonder if it's better to "fix" the add_recvbuf_mergeable().

Or another idea is to switch to use XDP generic here where we can use
skb_linearize() which should be more robust and we can drop the
xdp_linearize_page() logic completely.

Thanks

>
> so, fix it by check copy len,if checked failed, just dropped the
> whole frame, not make the memory dirty after the page.
>
> Signed-off-by: mengensun <mengensun@tencent.com>
> Reviewed-by: MengLong Dong <imagedong@tencent.com>
> Reviewed-by: ZhengXiong Jiang <mungerjiang@tencent.com>
> ---
>  drivers/net/virtio_net.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 36a4b7c195d5..844bdbd67ff7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -662,8 +662,12 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
>                                        int page_off,
>                                        unsigned int *len)
>  {
> -       struct page *page = alloc_page(GFP_ATOMIC);
> +       struct page *page;
>
> +       if (*len > PAGE_SIZE - page_off)
> +               return NULL;
> +
> +       page = alloc_page(GFP_ATOMIC);
>         if (!page)
>                 return NULL;
>
> --
> 2.27.0
>

