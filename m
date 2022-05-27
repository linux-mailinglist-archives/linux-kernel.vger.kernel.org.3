Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657E9535E1F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240363AbiE0KZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbiE0KYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:24:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1BBC61295
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653647092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RuZAGr8LTLPKnTTHGsBiC03ZUbAgIARZMp0A9eFeOjI=;
        b=AgtAoF5WAvyzXOOo4dJZ1X7Nj4dH7s+lV78LPLfyswQ2EhRZyJrxReq1tefzsZvDCj3efw
        ZaOeyYrLAmHKu0G2EhBNUr/OuKcdqY5wDUy5gXvz9oxErIDpw/08bd2FnGsEj8E0MJ4bo6
        2zsEMcC87jceDSI0HCJGeFlMNdMDyg0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-G6-QNRVWMCqKYG4hVtw6jw-1; Fri, 27 May 2022 06:24:51 -0400
X-MC-Unique: G6-QNRVWMCqKYG4hVtw6jw-1
Received: by mail-ed1-f70.google.com with SMTP id v22-20020a056402185600b0042d5f95eb4aso259768edy.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RuZAGr8LTLPKnTTHGsBiC03ZUbAgIARZMp0A9eFeOjI=;
        b=GoTRRNLh0UJA1cAAu8DmTgnDOIf8hhLibi3rAjn7uVFGK8YMWegFegEFbVNIfdZg4h
         xJwp0tC6Nl+6QEZqmxecULJgp9ACB/m6IaAB6+7NZeOXFcyjldCjwtIjYA8YnOFMQAQS
         VLPTEl8Zm4kx5ZaBl+XWA4Dt6iSWGXGW8Fp4wjKNvR2UckHR7lbsY8vsb3JYYCzh86D2
         1sb7Ufh5854OEwo2SpwIQniHZgyysnB+J6G0tIMvsAA7Yg03QrQanyAeSmlQs3WmvAth
         CnCVjeWWjAEYoRMGaW5mISeFK5E7+B/OzTm+OWVEEBvwP8gulUj4+YXJrs5Y/FHHIZWd
         fFyw==
X-Gm-Message-State: AOAM533zZtH3Zt26il8VwELynUYbXKD0XCvcnxulKXXdzzumzM4Rb6Kq
        qfD6ED1O8D2ts9+K/JFDwvNWQdPS1K8SKBaD3fZK+ORIZbMKkUXfJASDIhSxmbN6BA/vPv2nkTs
        y2rmwBHUgWnB4Ylx65dWsmRJm
X-Received: by 2002:a17:907:3e25:b0:6fe:fd4a:5b5e with SMTP id hp37-20020a1709073e2500b006fefd4a5b5emr18454141ejc.280.1653647090568;
        Fri, 27 May 2022 03:24:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJjM8P8YDg2O9DcJdsHXxNVHJ5AXZbqaTJsUQOXz6/iICApS8FSDyg1JXujhJcyMt6rzYLbg==
X-Received: by 2002:a17:907:3e25:b0:6fe:fd4a:5b5e with SMTP id hp37-20020a1709073e2500b006fefd4a5b5emr18454129ejc.280.1653647090340;
        Fri, 27 May 2022 03:24:50 -0700 (PDT)
Received: from redhat.com ([2.55.130.213])
        by smtp.gmail.com with ESMTPSA id e13-20020a50a68d000000b0042ab4e20543sm1908597edc.48.2022.05.27.03.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 03:24:49 -0700 (PDT)
Date:   Fri, 27 May 2022 06:24:46 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bo Liu <liubo03@inspur.com>
Cc:     david@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_balloon: check virtqueue_add_outbuf() return value
Message-ID: <20220527062346-mutt-send-email-mst@kernel.org>
References: <20220527013401.2196-1-liubo03@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527013401.2196-1-liubo03@inspur.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 09:34:01PM -0400, Bo Liu wrote:
> virtqueue_add_outbuf() can fail, when it fails, there is no need
> to call the funciont virtqueue_kick().
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Sorry don't get it.
What's the point of this patch really?

> ---
>  drivers/virtio/virtio_balloon.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index b9737da6c4dd..0d7da4d95e1e 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -153,16 +153,18 @@ static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
>  {
>  	struct scatterlist sg;
>  	unsigned int len;
> +	int err;
>  
>  	sg_init_one(&sg, vb->pfns, sizeof(vb->pfns[0]) * vb->num_pfns);
>  
>  	/* We should always be able to add one buffer to an empty queue. */
> -	virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
> -	virtqueue_kick(vq);
> -
> -	/* When host has read buffer, this completes via balloon_ack */
> -	wait_event(vb->acked, virtqueue_get_buf(vq, &len));
> +	err = virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
> +	if (!err) {
> +		virtqueue_kick(vq);
>  
> +		/* When host has read buffer, this completes via balloon_ack */
> +		wait_event(vb->acked, virtqueue_get_buf(vq, &len));
> +	}
>  }
>  
>  static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_info,
> @@ -382,6 +384,7 @@ static void stats_handle_request(struct virtio_balloon *vb)
>  	struct virtqueue *vq;
>  	struct scatterlist sg;
>  	unsigned int len, num_stats;
> +	int err;
>  
>  	num_stats = update_balloon_stats(vb);
>  
> @@ -389,8 +392,9 @@ static void stats_handle_request(struct virtio_balloon *vb)
>  	if (!virtqueue_get_buf(vq, &len))
>  		return;
>  	sg_init_one(&sg, vb->stats, sizeof(vb->stats[0]) * num_stats);
> -	virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
> -	virtqueue_kick(vq);
> +	err = virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
> +	if (!err)
> +		virtqueue_kick(vq);
>  }
>  
>  static inline s64 towards_target(struct virtio_balloon *vb)
> -- 
> 2.27.0

