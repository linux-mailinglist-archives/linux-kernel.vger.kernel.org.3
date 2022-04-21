Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DA050A138
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387751AbiDUNx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387635AbiDUNx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D3E113FAE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650549065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9X5WXrysF88Ouj/slnEAN9ILrlD7gwjjZO9fEL4BbEQ=;
        b=GTSRfaAYaznYDSI/X9hE5BSC/oHMz9Mb02073TIcuR9Kk+ZHZ396fbTW+h1qW+BXJE+h1+
        QOk7JvSD0z0aLKEq1lvlJhq+9dzHjMoyGNHlkAru5thKNOL8YzOOKQJtHeqaqc4deDRwjs
        ogyr/tkr6PWKMoqyeHWbe6FRgYFYTyY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-o3C5JAX8MUKiF57CETMuVg-1; Thu, 21 Apr 2022 09:51:04 -0400
X-MC-Unique: o3C5JAX8MUKiF57CETMuVg-1
Received: by mail-ej1-f69.google.com with SMTP id mp18-20020a1709071b1200b006e7f314ecb3so2528015ejc.23
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9X5WXrysF88Ouj/slnEAN9ILrlD7gwjjZO9fEL4BbEQ=;
        b=cAIqeRqZ7xqFQnuXwZGsbsfHBKGKjPrmTPe8fornM1xoCvKdGDHbDKBjUyJ+6eQaO5
         WPor7/62LW7cF32NZDwizJfvSf/mu/k8aOC0mj/9L7tZsJMvsqxwUkEuNiUzZgMkUK5S
         1H7bXIjZs0Nc8dY00uZV/RagVeXdNM7l7WwqH4iI2JLKPBTBJQjUMnFxhVJw5d9/w+Nz
         u3Q8g35p7jlBzFtILv9yyxv8Pl8nC77o0q87gCpfjDUV6K+ktSG9HJNqn8TE1IAIJ4Ce
         GO/YlROXPQ6D+0IjN3PvpIgo73f1KIUamXCX74xeq9V7mN1iP6Wus84bcWPD+etTbUvx
         UMzA==
X-Gm-Message-State: AOAM532m47SjMZVyk+QBi2wSF20TBmb/TTrYnTcIJCz5Eee2zGGIUL1y
        MLOR9bI+WOiAbjMGsNpKDXdopy3DkagPVCo2DHhZKVQDrTJFrSaLC/StHVOgZn3Qehf+lkXADWX
        HcZe852M3fw7I/e4dFO2KjO5I
X-Received: by 2002:a05:6402:26cd:b0:423:b43d:8b09 with SMTP id x13-20020a05640226cd00b00423b43d8b09mr28005746edd.400.1650549062687;
        Thu, 21 Apr 2022 06:51:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTS+Y4ILLrJT3QP2BpwpnOM5BPXge8ufksj1+vy8uCme6m2CyXJ309d3wnCuvShf6eaPoQKg==
X-Received: by 2002:a05:6402:26cd:b0:423:b43d:8b09 with SMTP id x13-20020a05640226cd00b00423b43d8b09mr28005722edd.400.1650549062455;
        Thu, 21 Apr 2022 06:51:02 -0700 (PDT)
Received: from sgarzare-redhat ([217.171.75.76])
        by smtp.gmail.com with ESMTPSA id d7-20020a170906174700b006e80a7e3111sm8096281eje.17.2022.04.21.06.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 06:51:01 -0700 (PDT)
Date:   Thu, 21 Apr 2022 15:50:57 +0200
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
Subject: Re: [PATCH 1/5] hv_sock: Check hv_pkt_iter_first_raw()'s return value
Message-ID: <20220421135057.57whrntjdv25jqpl@sgarzare-redhat>
References: <20220420200720.434717-1-parri.andrea@gmail.com>
 <20220420200720.434717-2-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220420200720.434717-2-parri.andrea@gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 10:07:16PM +0200, Andrea Parri (Microsoft) wrote:
>The function returns NULL if the ring buffer doesn't contain enough
>readable bytes to constitute a packet descriptor.  The ring buffer's
>write_index is in memory which is shared with the Hyper-V host, an
>erroneous or malicious host could thus change its value and overturn
>the result of hvs_stream_has_data().
>
>Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
>---
> net/vmw_vsock/hyperv_transport.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index e111e13b66604..943352530936e 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -603,6 +603,8 @@ static ssize_t hvs_stream_dequeue(struct vsock_sock *vsk, struct msghdr *msg,
>
> 	if (need_refill) {
> 		hvs->recv_desc = hv_pkt_iter_first_raw(hvs->chan);
>+		if (!hvs->recv_desc)
>+			return -ENOBUFS;
> 		ret = hvs_update_recv_data(hvs);
> 		if (ret)
> 			return ret;
>-- 
>2.25.1
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

