Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6805714B6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbiGLIeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiGLIeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:34:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD5E02A942
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657614860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ciMX/RuHI1AVXWq2Q5hVAjhC6awxZbzM0WmTsHePMI=;
        b=a8WGqyUrUQGnd3PhkaS83mEtCvmeDW1GaTrW7RzIrC4AdFlTs9c+y1U0jIAW+YlbXzMWxi
        7dY/dlP1qrSAKaMdjzmDZhE9iXpzAOOhMuN17zvwcu7izHmdotTZ4zNigo/Yqyg4Vgygiv
        GugA4luEVmpuV7SGPCg4L9YTL8F6fOo=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-yMCRXVwANzakiASlNp-VLA-1; Tue, 12 Jul 2022 04:34:18 -0400
X-MC-Unique: yMCRXVwANzakiASlNp-VLA-1
Received: by mail-pg1-f197.google.com with SMTP id s129-20020a632c87000000b00411564fe1feso2998323pgs.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:34:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4ciMX/RuHI1AVXWq2Q5hVAjhC6awxZbzM0WmTsHePMI=;
        b=x52AJCUai17iGYzReuboGCMcK3gJafSuzzMuafpUqImSu0q0CGW+5eow5Ud2eeHVd0
         3YlznaK8z8SQj98lWcoM6gQRG8GlcZ8hnICiJDBwEhDPDBmJN4fmGLq5DHP2X/RnlEtn
         mWPW95lHzg81iHn6Na9Z17TQ//AJ873Z2Nm2B6voCBCpwE3hnhjYEbPzh4dEqDA8AfvD
         R5uuGDxE2n93c8XWiESCDtfIaOHaEt8OZVw7OM1zoNJ2nMRXXbB+wYLnC/8p+5yKyXP6
         pv4+zZqNjCaXL4Y9BZ0+wWcsL3n6huWDQG2jbjKgx0iz9JNTNAXSAhUCjLMvE9TUBU59
         i/IA==
X-Gm-Message-State: AJIora9afdKCy4NdR5fGF8cy11J2Lhe1ugfZZZRTJgEj2plFjlc/zMOn
        nbSWLS6UUr6BqFJWRppYnpu8P3p1PUBBv6cYk992krDVUtC5eVTgBccoTo7IFGjJtY3CoFiflue
        X1uTkJCRKoVyx+g0sNmaTqUZX
X-Received: by 2002:a63:5a44:0:b0:412:7bee:d757 with SMTP id k4-20020a635a44000000b004127beed757mr20003580pgm.419.1657614857272;
        Tue, 12 Jul 2022 01:34:17 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vYVO3vSLUIZSmWIXfePtiHngDbFb1xsmaDaTzi6lizNFpTYFpmBmlun2e6WoeX3mI/D12AUg==
X-Received: by 2002:a63:5a44:0:b0:412:7bee:d757 with SMTP id k4-20020a635a44000000b004127beed757mr20003566pgm.419.1657614857037;
        Tue, 12 Jul 2022 01:34:17 -0700 (PDT)
Received: from [10.72.12.111] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id iw11-20020a170903044b00b0016a0bf0ce32sm6145115plb.70.2022.07.12.01.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 01:34:16 -0700 (PDT)
Message-ID: <a94ec2f5-8728-d62a-072e-407fbe59eb61@redhat.com>
Date:   Tue, 12 Jul 2022 16:34:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 0/6] virtio_test: add support for vhost-vdpa
Content-Language: en-US
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>
References: <20220704171701.127665-1-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220704171701.127665-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/7/5 01:16, Stefano Garzarella 写道:
> The first 3 patches fix various problems I have encountered with
> virtio_test (they may go without this series, but I included to allow you
> to test the series).
>
> Patch 4 is in preparation of patch 5, moving the feature negotiation when
> we initialize the device.
>
> Patch 5 add the support of vhost-vdpa in virtio_test
>
> Patch 6 add vdpa_test.ko based on vdpa_sim_test.c, so we can reuse most of
> the code coming from the vdpa_sim framework.
>
> I tested in this way:
>
>    $ modprobe vdpa_sim
>    $ modprobe vhost-vdpa
>
>    # load the vdpasim_test device
>    $ insmod vdpa_test.ko
>
>    # create a new vdpasim_test device
>    $ vdpa dev add mgmtdev vdpasim_test name dev0


I wonder what's the benefit of using a dedicated test device other than 
networking? (already a loopback device anyhow).

Thanks


>
>    # run the test using the /dev/vhost-vdpa-0 device
>    $ ./virtio_test --vdpa /dev/vhost-vdpa-0
>    spurious wakeups: 0x0 started=0x100000 completed=0x100000
>
> Comments and suggestions are welcome :-)
>
> Thanks,
> Stefano
>
> Stefano Garzarella (6):
>    tools/virtio: fix build
>    vhost_test: add $(srctree) on the included path
>    virtio_test: call __virtio_unbreak_device
>    tools/virtio: move feature negotiation in vdev_info_init()
>    virtio_test: support vhost-vdpa device
>    vdpasim: add vdpa_sim_test module
>
>   tools/virtio/linux/kernel.h           |   2 +-
>   tools/virtio/linux/virtio.h           |   2 +
>   tools/virtio/linux/vringh.h           |   1 +
>   drivers/vdpa/vdpa_sim/vdpa_sim_test.c | 203 ++++++++++++++++++++++++++
>   tools/virtio/vdpa_test/vdpa_test.c    |   1 +
>   tools/virtio/virtio_test.c            | 131 ++++++++++++++---
>   tools/virtio/Makefile                 |  32 +++-
>   tools/virtio/vdpa_test/Makefile       |   3 +
>   tools/virtio/vhost_test/Makefile      |   2 +-
>   9 files changed, 350 insertions(+), 27 deletions(-)
>   create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim_test.c
>   create mode 100644 tools/virtio/vdpa_test/vdpa_test.c
>   create mode 100644 tools/virtio/vdpa_test/Makefile
>

