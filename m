Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095F5511AA9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbiD0Nlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiD0Nl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:41:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E372517F4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651066694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PSHs414nLmIXHY0MNvy/DxlhGuFhzSSXxRrlOw3+ock=;
        b=P7UMyqTHZqHn+C6d8cdjWUvXJUvnKX5H7RoESpCXE7cW/HAamHYpVIh5iNVs9+cBEsW+5S
        j+/8CQKqxzUNlecJoHvTxxD5GpaFnjCUA7ZfLbiWWP5SeQ1xbRBcNqpIfthIGLd4TxDbZZ
        OSYD4nbqVBPglj68mAmTUntjq2InB5c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-465-_3d3e2YLMa2ljb_Kg_sQPQ-1; Wed, 27 Apr 2022 09:38:13 -0400
X-MC-Unique: _3d3e2YLMa2ljb_Kg_sQPQ-1
Received: by mail-wr1-f69.google.com with SMTP id s8-20020adf9788000000b0020adb01dc25so756834wrb.20
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PSHs414nLmIXHY0MNvy/DxlhGuFhzSSXxRrlOw3+ock=;
        b=ZRDltwgRe3W/szx0oQ3ExxvK+96TRLeVfyMhnFja+G2RrRtUhYcKsM4ORyjgb5AQZX
         PHONR5KhgFshLra6gfonaiDk19XoZ6Ev+lepDuZkEde/X7sfKXGWiZrKhEozfeStXgS9
         RFW0Vf4gDn9QRei+BuCV81kS0zzygSc8Fq2cfRv+I4v+4I257Igve4Xo6fc1wZKrUbpw
         EW4W7d1v6U/h18goqupFa2bhyLYN6q/0G7sZgyVQRwU4DBqrV1qb9TjQwvmwcLW47I3g
         paizmG815nfSJW8bDXnMa108f+rcvTmsWvk76kBA0wRCeYaGdTh1EAeoobi5vxzPL4Nh
         CkZA==
X-Gm-Message-State: AOAM530ZaeV/Cpz7/nAUBa9/DweKJLTZbAc9boFESIkm53ecPXr/qP+W
        nShIZC3pcB1TZc0KHdd27mQLZUxbXGK7GHlWve5Lb65Ma4DZ8nhV36chPxSD9WkthrQVimRt1fR
        FiSIIznS2ihPbRkrL8xkcFKfs
X-Received: by 2002:a5d:40ca:0:b0:20a:cf97:f1b4 with SMTP id b10-20020a5d40ca000000b0020acf97f1b4mr18244190wrq.121.1651066692509;
        Wed, 27 Apr 2022 06:38:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzosLJXqvRwF4U/eGOveNg83nSH/OQqj2msqvMJzBqQTXR97GmklzXkcLwfNLij7D2eSiit9g==
X-Received: by 2002:a5d:40ca:0:b0:20a:cf97:f1b4 with SMTP id b10-20020a5d40ca000000b0020acf97f1b4mr18244166wrq.121.1651066692307;
        Wed, 27 Apr 2022 06:38:12 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-234.retail.telecomitalia.it. [87.11.6.234])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c2c4700b0038eb7d8df69sm1565757wmg.11.2022.04.27.06.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 06:38:11 -0700 (PDT)
Date:   Wed, 27 Apr 2022 15:38:08 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] hv_sock: Copy packets sent by Hyper-V out of the
 ring buffer
Message-ID: <20220427133808.elbrvtvl6xplx62n@sgarzare-redhat>
References: <20220427131225.3785-1-parri.andrea@gmail.com>
 <20220427131225.3785-3-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220427131225.3785-3-parri.andrea@gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 03:12:22PM +0200, Andrea Parri (Microsoft) wrote:
>Pointers to VMbus packets sent by Hyper-V are used by the hv_sock driver
>within the guest VM.  Hyper-V can send packets with erroneous values or
>modify packet fields after they are processed by the guest.  To defend
>against these scenarios, copy the incoming packet after validating its
>length and offset fields using hv_pkt_iter_{first,next}().  Use
>HVS_PKT_LEN(HVS_MTU_SIZE) to initialize the buffer which holds the
>copies of the incoming packets.  In this way, the packet can no longer
>be modified by the host.
>
>Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
>Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>---
> net/vmw_vsock/hyperv_transport.c | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index 943352530936e..8c37d07017fc4 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -78,6 +78,9 @@ struct hvs_send_buf {
> 					 ALIGN((payload_len), 8) + \
> 					 VMBUS_PKT_TRAILER_SIZE)
>
>+/* Upper bound on the size of a VMbus packet for hv_sock */
>+#define HVS_MAX_PKT_SIZE	HVS_PKT_LEN(HVS_MTU_SIZE)
>+
> union hvs_service_id {
> 	guid_t	srv_id;
>
>@@ -378,6 +381,8 @@ static void hvs_open_connection(struct vmbus_channel *chan)
> 		rcvbuf = ALIGN(rcvbuf, HV_HYP_PAGE_SIZE);
> 	}
>
>+	chan->max_pkt_size = HVS_MAX_PKT_SIZE;
>+
> 	ret = vmbus_open(chan, sndbuf, rcvbuf, NULL, 0, hvs_channel_cb,
> 			 conn_from_host ? new : sk);
> 	if (ret != 0) {
>@@ -602,7 +607,7 @@ static ssize_t hvs_stream_dequeue(struct vsock_sock *vsk, struct msghdr *msg,
> 		return -EOPNOTSUPP;
>
> 	if (need_refill) {
>-		hvs->recv_desc = hv_pkt_iter_first_raw(hvs->chan);
>+		hvs->recv_desc = hv_pkt_iter_first(hvs->chan);
> 		if (!hvs->recv_desc)
> 			return -ENOBUFS;
> 		ret = hvs_update_recv_data(hvs);
>@@ -618,7 +623,7 @@ static ssize_t hvs_stream_dequeue(struct vsock_sock *vsk, struct msghdr *msg,
>
> 	hvs->recv_data_len -= to_read;
> 	if (hvs->recv_data_len == 0) {
>-		hvs->recv_desc = hv_pkt_iter_next_raw(hvs->chan, hvs->recv_desc);
>+		hvs->recv_desc = hv_pkt_iter_next(hvs->chan, hvs->recv_desc);
> 		if (hvs->recv_desc) {
> 			ret = hvs_update_recv_data(hvs);
> 			if (ret)
>-- 
>2.25.1
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

