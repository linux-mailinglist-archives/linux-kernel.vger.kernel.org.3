Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A962C5ACC73
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiIEHU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbiIEHTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:19:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0386C41D3C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662362130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hzFuvUdPT4weoAmQZYG6aUVzxxQfH1SK+qmfNddDCPs=;
        b=MbXoihDZEWlXBDxvmYAT6jeHPLKGH6S6hlP+PrW6j9YWUdKjWPWxIDO1kd3MVq51F3O3ao
        N/9xjW9grmq+4t0RP5pymeKqt2f6XD9PpEbnB3cBuRgDB/zKdYBNhW7l8wu/JBhdSosUV7
        Simn13Ercldk4glWGjrkJW0liiGejMY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-493-_1PZJXQ2PV-yn8dJuAFGVQ-1; Mon, 05 Sep 2022 03:15:29 -0400
X-MC-Unique: _1PZJXQ2PV-yn8dJuAFGVQ-1
Received: by mail-wm1-f70.google.com with SMTP id ay27-20020a05600c1e1b00b003a5bff0df8dso6039601wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 00:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=hzFuvUdPT4weoAmQZYG6aUVzxxQfH1SK+qmfNddDCPs=;
        b=Qo02wfwf40/EKagcXOMeXaOYSD/GsKG5p3ju3ULMK21LlaAr83J32yRzCfzP3AjDBK
         I/5vo46dAV5tba2dfeP4igCj4xICY61Qpd4Be0dLF7bAARlIpJzhPtzunG98fW/Nblsf
         tKuqn1BBg33qQf2VNXm5uDvFZJB8cf8bWiQ2S7dyFXt7dHFMZirZwft8RgMDWvocH/Rl
         5FA1rOsYfdlwBP2vwaWpDQ81+P/jRBd6GZPHJif6C2Kl3D1hDcg7hFTxlaG4GBcgg1bM
         tNIkQAdHm7ULqb1IKDm9gNI2/b8Firi+lBD3dt6ptlg+uLJ0M1LglghXEOsxSxWEJlwq
         F4ig==
X-Gm-Message-State: ACgBeo2aMt0o+L0lUBblhvtwcdfiMdB6TTA44Cuu462Kvh76AjQ214vt
        R+5FlnNoZ9TI4HedXpHOsBeDJUGHPmGWjcuwYsOCgc/30/QVlw1+aJmXCzM1CWvNYT5QaMEPEvV
        hogqfPyI3z5zjiYMbfMV8njJR
X-Received: by 2002:a7b:c844:0:b0:3a9:70d2:bf23 with SMTP id c4-20020a7bc844000000b003a970d2bf23mr9738276wml.165.1662362128131;
        Mon, 05 Sep 2022 00:15:28 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7EtktGfU9VLNtKjgqj6Ye1h1XLW2E8fwnYaZd3O3gu/FYxDv2bAYX99j93n4GzCIeqkxwzdw==
X-Received: by 2002:a7b:c844:0:b0:3a9:70d2:bf23 with SMTP id c4-20020a7bc844000000b003a970d2bf23mr9738258wml.165.1662362127953;
        Mon, 05 Sep 2022 00:15:27 -0700 (PDT)
Received: from redhat.com ([2.52.135.118])
        by smtp.gmail.com with ESMTPSA id az19-20020a05600c601300b003a342933727sm17118233wmb.3.2022.09.05.00.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 00:15:27 -0700 (PDT)
Date:   Mon, 5 Sep 2022 03:15:24 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, gautam.dawar@xilinx.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] virtio-net: add cond_resched() to the command
 waiting loop
Message-ID: <20220905031405-mutt-send-email-mst@kernel.org>
References: <20220905045341.66191-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905045341.66191-1-jasowang@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 12:53:41PM +0800, Jason Wang wrote:
> Adding cond_resched() to the command waiting loop for a better
> co-operation with the scheduler. This allows to give CPU a breath to
> run other task(workqueue) instead of busy looping when preemption is
> not allowed.
> 
> What's more important. This is a must for some vDPA parent to work
> since control virtqueue is emulated via a workqueue for those parents.
> 
> Fixes: bda324fd037a ("vdpasim: control virtqueue support")

That's a weird commit to fix. so it fixes the simulator?

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/net/virtio_net.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index ece00b84e3a7..169368365d6a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2000,8 +2000,10 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
>  	 * into the hypervisor, so the request should be handled immediately.
>  	 */
>  	while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> -	       !virtqueue_is_broken(vi->cvq))
> +	       !virtqueue_is_broken(vi->cvq)) {
> +		cond_resched();
>  		cpu_relax();
> +	}

with cond_resched do we still need cpu_relax?

>  	return vi->ctrl->status == VIRTIO_NET_OK;
>  }
> -- 
> 2.25.1

