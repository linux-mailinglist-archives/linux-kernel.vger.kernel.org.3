Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BABD5ACDD4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237787AbiIEIe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238046AbiIEId5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:33:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AAC4B4B4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662366750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S4JK4m0m3+hN9/NjyD45TlkaSX2pzOEl0JORrLG6mzs=;
        b=Wq/8RWnz0VHlxBDOcuPpmFzo5zubo7vAug8I5a7s4FZcJ/3ZVFO+xaK3U1LcrDDpvxBZa4
        6oKSy9BMR8u2gJYon6ywrJAytMy1RmwG71IMWna5ubwVmFJV2oHLpVBlvUJHErw9hv0QMb
        ZP8mco1+R6oy5BV66UyYd1YKH7d4zHA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-316-niubkr0aP9aK22LARJxjkg-1; Mon, 05 Sep 2022 04:32:27 -0400
X-MC-Unique: niubkr0aP9aK22LARJxjkg-1
Received: by mail-pl1-f197.google.com with SMTP id c16-20020a170903235000b001768e9563d5so3302789plh.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 01:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=S4JK4m0m3+hN9/NjyD45TlkaSX2pzOEl0JORrLG6mzs=;
        b=UTWhFiOfMy95vAWIcSOm99AgVFmtU/c0SAF+6Ik4f3OiePj2jgoUp0+eu4QaDqkuLe
         6lO/E1TIT9OObYQmjjJ48WIxGrj+ZwRt6GuZy7ESv//b7mtnk2cDmKqNzZ8vY1nXazhi
         UF3eilrP3WJxw8aMz2HDu5P7+IwtvUR3gwYDm6DjO4FEGUEy6fkaSIRPexFYAbmqYd5l
         E6cgwBmyNn0EUsX/226A1qJzd8BcBdfE3ghpa5ZfnWlX0PdiO+L4sZKMQw/G5qBWU8wq
         www1LOmGGLuPq93E8HiBEsrmj2wP3hDeFSUndBgBjqLEXFkaGpOEB7G693+nNvbwKDX1
         3xOw==
X-Gm-Message-State: ACgBeo25nwsZeJROKm24BFM2C8UU2tgVIhBXByuSbtir/re//ibiKP8R
        NavW5jmzoqpqv4rzcnS6rUaDoW3niBTyeQUWDWJF4G6ZkYzKY928CR/eS8S+/bk8i3nhOWx8VRi
        /geL/fzK25CkitifF/jMSacmN
X-Received: by 2002:a17:90b:1d8b:b0:200:5367:5ecd with SMTP id pf11-20020a17090b1d8b00b0020053675ecdmr5847724pjb.165.1662366745416;
        Mon, 05 Sep 2022 01:32:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR55K+TMI7e0v4Qj3djAA88LyYePDornUMNHcPRaFDkQVGBJ3mgtkBq2b8FE5Hf5q95howCsPg==
X-Received: by 2002:a17:90b:1d8b:b0:200:5367:5ecd with SMTP id pf11-20020a17090b1d8b00b0020053675ecdmr5847703pjb.165.1662366745129;
        Mon, 05 Sep 2022 01:32:25 -0700 (PDT)
Received: from [10.72.13.239] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o20-20020aa79794000000b0052c7ff2ac74sm7345483pfp.17.2022.09.05.01.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 01:32:24 -0700 (PDT)
Message-ID: <10630d99-e0bd-c067-8766-19266b38d2fe@redhat.com>
Date:   Mon, 5 Sep 2022 16:32:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH] vhost-net: support VIRTIO_F_RING_RESET
Content-Language: en-US
To:     Kangjie Xu <kangjie.xu@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org
Cc:     mst@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        hengqi@linux.alibaba.com, xuanzhuo@linux.alibaba.com
References: <20220825085610.80315-1-kangjie.xu@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220825085610.80315-1-kangjie.xu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/8/25 16:56, Kangjie Xu 写道:
> Add VIRTIO_F_RING_RESET, which indicates that the driver can reset a
> queue individually.
>
> VIRTIO_F_RING_RESET feature is added to virtio-spec 1.2. The relevant
> information is in
>      oasis-tcs/virtio-spec#124
>      oasis-tcs/virtio-spec#139
>
> The implementation only adds the feature bit in supported features. It
> does not require any other changes because we reuse the existing vhost
> protocol.
>
> The virtqueue reset process can be concluded as two parts:
> 1. The driver can reset a virtqueue. When it is triggered, we use the
> set_backend to disable the virtqueue.
> 2. After the virtqueue is disabled, the driver may optionally re-enable
> it. The process is basically similar to when the device is started,
> except that the restart process does not need to set features and set
> mem table since they do not change. QEMU will send messages containing
> size, base, addr, kickfd and callfd of the virtqueue in order.
> Specifically, the host kernel will receive these messages in order:
>      a. VHOST_SET_VRING_NUM
>      b. VHOST_SET_VRING_BASE
>      c. VHOST_SET_VRING_ADDR
>      d. VHOST_SET_VRING_KICK
>      e. VHOST_SET_VRING_CALL
>      f. VHOST_NET_SET_BACKEND
> Finally, after we use set_backend to attach the virtqueue, the virtqueue
> will be enabled and start to work.
>
> Signed-off-by: Kangjie Xu <kangjie.xu@linux.alibaba.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>
> Test environment and method:
>      Host: 5.19.0-rc3
>      Qemu: QEMU emulator version 7.0.50 (With vq rset support)
>      Guest: 5.19.0-rc3 (With vq reset support)
>      Test Cmd: ethtool -g eth1; ethtool -G eth1 rx $1 tx $2; ethtool -g eth1;
>
>      The drvier can resize the virtio queue, then virtio queue reset function should
>      be triggered.
>
>      The default is split mode, modify Qemu virtio-net to add PACKED feature to
>      test packed mode.
>
> Guest Kernel Patch:
>      https://lore.kernel.org/bpf/20220801063902.129329-1-xuanzhuo@linux.alibaba.com/
>
> QEMU Patch:
>      https://lore.kernel.org/qemu-devel/cover.1661414345.git.kangjie.xu@linux.alibaba.com/
>
> Looking forward to your review and comments. Thanks.
>
>   drivers/vhost/net.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 68e4ecd1cc0e..8a34928d4fef 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -73,7 +73,8 @@ enum {
>   	VHOST_NET_FEATURES = VHOST_FEATURES |
>   			 (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
>   			 (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
> -			 (1ULL << VIRTIO_F_ACCESS_PLATFORM)
> +			 (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
> +			 (1ULL << VIRTIO_F_RING_RESET)
>   };
>   
>   enum {

