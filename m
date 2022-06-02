Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579BA53B17F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 04:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbiFBCIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 22:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbiFBCIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 22:08:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0B2C24A6B3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 19:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654135721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1XyspsvoSb3NtHUHpb5oeCcY1zxXsm6k93GfeTwfJEU=;
        b=frcb3Y+epIe9IA9wdWwwKjMt/R6wfKLKWckiiR4MDVhqwlZbhUlkEk06YzZ5tq0HHeZ0sf
        zcsfS7gD0KyccURAfyG/xiO8rl86I4j1SeRUfPpLnX4/hKEhffAEjdUiNx8Pg/oeb0AcbH
        GSyfBlvz7kVyyIzx3kY0ycJbfrKPdHo=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-Rq3di7ubNaW42j3vmV6-XA-1; Wed, 01 Jun 2022 22:08:31 -0400
X-MC-Unique: Rq3di7ubNaW42j3vmV6-XA-1
Received: by mail-pf1-f197.google.com with SMTP id y11-20020aa7804b000000b0051ba2c16046so1974640pfm.20
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 19:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1XyspsvoSb3NtHUHpb5oeCcY1zxXsm6k93GfeTwfJEU=;
        b=VDnMnV6qraLU9JQ4+64xj3rfZqbI8mw51gMKsKj+nPvETwBF1csUBbTDWvFa/Jv1TI
         QUqHKR7IADCH1b7Hbhk+IlEXhFBBT5pt/vIKiF5V6yfjrWtVni500CLjZK8BiTdpehDN
         8YRUcFkX+ol0Ww6xhiRzISdlwMbTTSZyWrh8VD42B+BggwIra+VwsyJO6NJcIINGFnvQ
         C/kBffiE0YaPBUosyXXkB65ztr1o7uBTQo49izfjqFBiPDj3ewzi9Xadv+vup7FQ7gBo
         6ShwQTYrLcnC4OnYoN0BN6piPw4o0WKaeZHaoS/Qg/nXgrPvDn3Q+DK9ZgpoUA24AHRA
         Qg3A==
X-Gm-Message-State: AOAM53024ojm6VqmtJhh7f0T6gOTpQcyi7kWB+qFxfJxMKiZsTSVGSyc
        9FGdoGhHqZTtsEbBa1e09NWajCB11OSiNs/F2QK5fnbHjjjvqeQYVlOmBGH/3Cz49FeUfFCd5oz
        zZBdRyAgjZPt4ioFvx9hznTdA
X-Received: by 2002:a17:902:9a92:b0:161:4e50:3b80 with SMTP id w18-20020a1709029a9200b001614e503b80mr2320135plp.149.1654135710286;
        Wed, 01 Jun 2022 19:08:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2dbDxajoyEelOLKZRvwOLRq9wik2EaSJcf1SAoEJF9TtruJ7MBPk0VF5bPP8b9BefjZkjUw==
X-Received: by 2002:a17:902:9a92:b0:161:4e50:3b80 with SMTP id w18-20020a1709029a9200b001614e503b80mr2320090plp.149.1654135709878;
        Wed, 01 Jun 2022 19:08:29 -0700 (PDT)
Received: from [10.72.13.239] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902e2d100b0015e9f45c1f4sm2167309plc.186.2022.06.01.19.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 19:08:29 -0700 (PDT)
Message-ID: <6a0b9961-40c6-9b22-2b79-608633f78814@redhat.com>
Date:   Thu, 2 Jun 2022 10:08:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v4 0/4] Implement vdpasim stop operation
Content-Language: en-US
To:     =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     martinh@xilinx.com, Stefano Garzarella <sgarzare@redhat.com>,
        martinpo@xilinx.com, lvivier@redhat.com, pabloc@xilinx.com,
        Parav Pandit <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zhang Min <zhang.min9@zte.com.cn>,
        Wu Zongyong <wuzongyong@linux.alibaba.com>, lulu@redhat.com,
        Zhu Lingshan <lingshan.zhu@intel.com>, Piotr.Uminski@intel.com,
        Si-Wei Liu <si-wei.liu@oracle.com>, ecree.xilinx@gmail.com,
        gautam.dawar@amd.com, habetsm.xilinx@gmail.com,
        tanuj.kamde@amd.com, hanand@xilinx.com, dinang@xilinx.com,
        Longpeng <longpeng2@huawei.com>
References: <20220526124338.36247-1-eperezma@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220526124338.36247-1-eperezma@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/5/26 20:43, Eugenio Pérez 写道:
> Implement stop operation for vdpa_sim devices, so vhost-vdpa will offer
> that backend feature and userspace can effectively stop the device.
>
> This is a must before get virtqueue indexes (base) for live migration,
> since the device could modify them after userland gets them. There are
> individual ways to perform that action for some devices
> (VHOST_NET_SET_BACKEND, VHOST_VSOCK_SET_RUNNING, ...) but there was no
> way to perform it for any vhost device (and, in particular, vhost-vdpa).
>
> After the return of ioctl with stop != 0, the device MUST finish any
> pending operations like in flight requests. It must also preserve all
> the necessary state (the virtqueue vring base plus the possible device
> specific states) that is required for restoring in the future. The
> device must not change its configuration after that point.


I think we probably need more accurate definition on the state as Parav 
suggested.

Besides this, we should also clarify when stop is allowed. E.g should we 
allow setting stop without DRIVER_OK?

Thanks


>
> After the return of ioctl with stop == 0, the device can continue
> processing buffers as long as typical conditions are met (vq is enabled,
> DRIVER_OK status bit is enabled, etc).
>
> In the future, we will provide features similar to VHOST_USER_GET_INFLIGHT_FD
> so the device can save pending operations.
>
> Comments are welcome.
>
> v4:
> * Replace VHOST_STOP to VHOST_VDPA_STOP in vhost ioctl switch case too.
>
> v3:
> * s/VHOST_STOP/VHOST_VDPA_STOP/
> * Add documentation and requirements of the ioctl above its definition.
>
> v2:
> * Replace raw _F_STOP with BIT_ULL(_F_STOP).
> * Fix obtaining of stop ioctl arg (it was not obtained but written).
> * Add stop to vdpa_sim_blk.
>
> Eugenio Pérez (4):
>    vdpa: Add stop operation
>    vhost-vdpa: introduce STOP backend feature bit
>    vhost-vdpa: uAPI to stop the device
>    vdpa_sim: Implement stop vdpa op
>
>   drivers/vdpa/vdpa_sim/vdpa_sim.c     | 21 +++++++++++++++++
>   drivers/vdpa/vdpa_sim/vdpa_sim.h     |  1 +
>   drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  3 +++
>   drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  3 +++
>   drivers/vhost/vdpa.c                 | 34 +++++++++++++++++++++++++++-
>   include/linux/vdpa.h                 |  6 +++++
>   include/uapi/linux/vhost.h           | 14 ++++++++++++
>   include/uapi/linux/vhost_types.h     |  2 ++
>   8 files changed, 83 insertions(+), 1 deletion(-)
>

