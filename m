Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C35B511AE6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbiD0Nlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236450AbiD0Nls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:41:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2AF156765
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651066716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pASs2MCvHDKO6IuV9YUAJxKscoYhMe+WGgBrqsLgpeA=;
        b=fGWs2UipOXI0bq5z5BTx/krWoXgrYR4zEVGekhtofcbbdrdFhC+p3azkKTScqUpTZyR/pP
        gTyqtLzuDnTB8v/g7ZE4BHYs69NrR2f/JR4ylsmhnckUEuxocCx7C07xX+dTUUHWVDDk+O
        n6MCL6A6cmoSZhrPzNc3x5KVAOFeZ3w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-324-54HMfd3OMFmlmho_8I4FSw-1; Wed, 27 Apr 2022 09:38:35 -0400
X-MC-Unique: 54HMfd3OMFmlmho_8I4FSw-1
Received: by mail-wm1-f72.google.com with SMTP id h65-20020a1c2144000000b0038e9ce3b29cso2845090wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pASs2MCvHDKO6IuV9YUAJxKscoYhMe+WGgBrqsLgpeA=;
        b=klWoPqC3FWpXEr753BvBkAga7Twz4USGGFNaGPpwbVX884CBFerqi0t+vJCCduV+dE
         PMdWQYlUqUJIWRyI9k8r3Mvgw61NVmpsTepOm05w64+LGJ3lg/USU+ONOAKXnBEJgCd0
         C0L2vtz/t1MwtlGuwmP6pUvvIVOAaAII6RCcd8iTD8i4rQoYp/VxG8/iueQ8Qv2FGLN/
         zKUTV4MseLHdKUe6T/bqaL3C6oF9WCCgXnR67td3oxmpZN5mayUaIoR/navGmh0i5Vv6
         XQN8+NYVL/itge+npYGic8S1gv6XtXDMV3prsaIN5MmPMXWWwDMjcSBIOrIQuUWNVkes
         oUVQ==
X-Gm-Message-State: AOAM532OQdNnJwd/63W/vIfNJlqTtSWMhGfPEf1pvgJ9pJrbdCWqWJaD
        IKfxxFTgKwqFhoyl2kTEJbFTHR4XSUGpffs1fb+OjNA1cxtT2L1LOYqveDYUtjdawg0/WV55Fhr
        DIxO3/En2amjgExGC28lYhF4o
X-Received: by 2002:a1c:19c1:0:b0:393:a19f:8f95 with SMTP id 184-20020a1c19c1000000b00393a19f8f95mr25986330wmz.149.1651066714186;
        Wed, 27 Apr 2022 06:38:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyZHIKV3c3j9uqHgcGZ8eA8TvBTNFbmTsiNROeafQbnIh2surKm1WpizXdg1ibVysWg5ZlMw==
X-Received: by 2002:a1c:19c1:0:b0:393:a19f:8f95 with SMTP id 184-20020a1c19c1000000b00393a19f8f95mr25986295wmz.149.1651066713905;
        Wed, 27 Apr 2022 06:38:33 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-234.retail.telecomitalia.it. [87.11.6.234])
        by smtp.gmail.com with ESMTPSA id n38-20020a05600c502600b00393d946aef4sm1548556wmr.10.2022.04.27.06.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 06:38:32 -0700 (PDT)
Date:   Wed, 27 Apr 2022 15:38:29 +0200
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
Subject: Re: [PATCH v2 3/5] hv_sock: Add validation for untrusted Hyper-V
 values
Message-ID: <20220427133829.w5biauq2omc5xvuu@sgarzare-redhat>
References: <20220427131225.3785-1-parri.andrea@gmail.com>
 <20220427131225.3785-4-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220427131225.3785-4-parri.andrea@gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 03:12:23PM +0200, Andrea Parri (Microsoft) wrote:
>For additional robustness in the face of Hyper-V errors or malicious
>behavior, validate all values that originate from packets that Hyper-V
>has sent to the guest in the host-to-guest ring buffer.  Ensure that
>invalid values cannot cause data being copied out of the bounds of the
>source buffer in hvs_stream_dequeue().
>
>Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
>Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>---
> include/linux/hyperv.h           |  5 +++++
> net/vmw_vsock/hyperv_transport.c | 10 ++++++++--
> 2 files changed, 13 insertions(+), 2 deletions(-)
>
>diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
>index fe2e0179ed51e..55478a6810b60 100644
>--- a/include/linux/hyperv.h
>+++ b/include/linux/hyperv.h
>@@ -1663,6 +1663,11 @@ static inline u32 hv_pkt_datalen(const struct vmpacket_descriptor *desc)
> 	return (desc->len8 << 3) - (desc->offset8 << 3);
> }
>
>+/* Get packet length associated with descriptor */
>+static inline u32 hv_pkt_len(const struct vmpacket_descriptor *desc)
>+{
>+	return desc->len8 << 3;
>+}
>
> struct vmpacket_descriptor *
> hv_pkt_iter_first_raw(struct vmbus_channel *channel);
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index 8c37d07017fc4..fd98229e3db30 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -577,12 +577,18 @@ static bool hvs_dgram_allow(u32 cid, u32 port)
> static int hvs_update_recv_data(struct hvsock *hvs)
> {
> 	struct hvs_recv_buf *recv_buf;
>-	u32 payload_len;
>+	u32 pkt_len, payload_len;
>+
>+	pkt_len = hv_pkt_len(hvs->recv_desc);
>+
>+	if (pkt_len < HVS_HEADER_LEN)
>+		return -EIO;
>
> 	recv_buf = (struct hvs_recv_buf *)(hvs->recv_desc + 1);
> 	payload_len = recv_buf->hdr.data_size;
>
>-	if (payload_len > HVS_MTU_SIZE)
>+	if (payload_len > pkt_len - HVS_HEADER_LEN ||
>+	    payload_len > HVS_MTU_SIZE)
> 		return -EIO;
>
> 	if (payload_len == 0)
>-- 
>2.25.1
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

