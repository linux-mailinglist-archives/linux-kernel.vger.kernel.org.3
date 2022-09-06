Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C3E5AE619
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239762AbiIFK7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239797AbiIFK6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:58:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8926719B3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 03:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662461921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+0i0KE3XTFGMOugy8WjJQSlLzmOSM4MIpTEpD6UmFME=;
        b=gSrUwFEBBTrDc9aCguOMISLuD4DZf60X2SSczrYPSdKItLDquDnhigVuCdWgMXM45D51DM
        LTcP6BErO9fGqYMzWlIQyK0R9IbnU1lgef6yEQGMKZMZXCrXCfDxrO7zY3L1ugixczikhg
        3ZaOBpfHJ4aXhAlAsponNYB2pDjnrKg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-460-ZPyXf5zHNsWJTk7cpmiB2w-1; Tue, 06 Sep 2022 06:58:40 -0400
X-MC-Unique: ZPyXf5zHNsWJTk7cpmiB2w-1
Received: by mail-ed1-f72.google.com with SMTP id c14-20020a05640227ce00b0043e5df12e2cso7422498ede.15
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 03:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=+0i0KE3XTFGMOugy8WjJQSlLzmOSM4MIpTEpD6UmFME=;
        b=4MlnyycdDck2BGgvHa20HdkMWZ8NHCj9BZ2XEt/Fygi4f5LRj1UplsbnCnj64greqO
         mdH+Rmsndy794+UOkb3aypl6MkdLk5uaKzAza4X/nayf3olEh9P4Vs4VKPvovUOZ5/M6
         2ANzleqIDM1Lukjh7WUfeTMOCy0t1sVQezjNnoM2pGU1dw7CNMv0tmU1w852s5Cgo1oh
         C8StmXCKJ6rChTzlyy71JSvnvA6o/dUNLvTj8glsiNvfeyFc0rTzSUdx8CCWfL0Mu2go
         rJjvflDzqWFi1rcFdBDZtMsXgzouwlcki9FfttBAZyfEJQGj6nhlCy/LQaKxzHxTNGSh
         0Htw==
X-Gm-Message-State: ACgBeo0OvHy/X5p/QaZb6Vf9GPAQV2jBfqYNQBYE0KqPPcyWMd6BI2tN
        Mp6vK02uA0MPmUDvES8kVAbsToDROw+KOTlZhSbUT2/0Ii9ps3XgFVWL2eUUd7xDypTSqjlYqu3
        7LqIUYEAbXjV7Nk8poX1SDRiU
X-Received: by 2002:aa7:cb13:0:b0:448:3759:8c57 with SMTP id s19-20020aa7cb13000000b0044837598c57mr37696957edt.8.1662461918968;
        Tue, 06 Sep 2022 03:58:38 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7CeyMVILqKWtWY67rp5QKv0h1PSPP4WQMwbXvISz7gKxlfNS4o/vele1usXUc0TW/l8/02Dg==
X-Received: by 2002:aa7:cb13:0:b0:448:3759:8c57 with SMTP id s19-20020aa7cb13000000b0044837598c57mr37696947edt.8.1662461918761;
        Tue, 06 Sep 2022 03:58:38 -0700 (PDT)
Received: from redhat.com ([2.52.135.118])
        by smtp.gmail.com with ESMTPSA id kv12-20020a17090778cc00b0073d7b876621sm6398731ejc.205.2022.09.06.03.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 03:58:38 -0700 (PDT)
Date:   Tue, 6 Sep 2022 06:58:32 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bobby Eshleman <bobby.eshleman@gmail.com>
Cc:     Bobby Eshleman <bobbyeshleman@gmail.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] vsock: add netdev to vhost/virtio vsock
Message-ID: <20220906065523-mutt-send-email-mst@kernel.org>
References: <cover.1660362668.git.bobby.eshleman@bytedance.com>
 <5a93c5aad99d79f028d349cb7e3c128c65d5d7e2.1660362668.git.bobby.eshleman@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a93c5aad99d79f028d349cb7e3c128c65d5d7e2.1660362668.git.bobby.eshleman@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 10:56:06AM -0700, Bobby Eshleman wrote:
> In order to support usage of qdisc on vsock traffic, this commit
> introduces a struct net_device to vhost and virtio vsock.
> 
> Two new devices are created, vhost-vsock for vhost and virtio-vsock
> for virtio. The devices are attached to the respective transports.
> 
> To bypass the usage of the device, the user may "down" the associated
> network interface using common tools. For example, "ip link set dev
> virtio-vsock down" lets vsock bypass the net_device and qdisc entirely,
> simply using the FIFO logic of the prior implementation.
> 
> For both hosts and guests, there is one device for all G2H vsock sockets
> and one device for all H2G vsock sockets. This makes sense for guests
> because the driver only supports a single vsock channel (one pair of
> TX/RX virtqueues), so one device and qdisc fits. For hosts, this may not
> seem ideal for some workloads. However, it is possible to use a
> multi-queue qdisc, where a given queue is responsible for a range of
> sockets. This seems to be a better solution than having one device per
> socket, which may yield a very large number of devices and qdiscs, all
> of which are dynamically being created and destroyed. Because of this
> dynamism, it would also require a complex policy management daemon, as
> devices would constantly be spun up and down as sockets were created and
> destroyed. To avoid this, one device and qdisc also applies to all H2G
> sockets.
> 
> Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>


I've been thinking about this generally. vsock currently
assumes reliability, but with qdisc can't we get
packet drops e.g. depending on the queueing?

What prevents user from configuring such a discipline?
One thing people like about vsock is that it's very hard
to break H2G communication even with misconfigured
networking.

-- 
MST

