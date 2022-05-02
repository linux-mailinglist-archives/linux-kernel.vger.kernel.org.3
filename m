Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05A25179E2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 00:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiEBWYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 18:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiEBWYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 18:24:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28EA2A1BE
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 15:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651530061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t+pDY+Ex4Ewd/QjNKkxD0rhZSfDGQ+G9GZjOekpOl0o=;
        b=VOi3PkH3pdqsXYDAtgEFrOLBzzXI0gfy0mVyJ3cEEvpScuDkTz8HFbsXqI6WnuCVI5xSUF
        cHbQ8Z1Ne4q/kUvAOXkQRxBKXVV3Fn96bHLKCtD5SDG1PDOhC+kp3rUxrJW8ZFVWlPbxwB
        k7z5wAbVBzMEez6JJbqAjHsG909sNsg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-xTGScj9FPb2bERSdWdTAQg-1; Mon, 02 May 2022 18:20:58 -0400
X-MC-Unique: xTGScj9FPb2bERSdWdTAQg-1
Received: by mail-wr1-f69.google.com with SMTP id e21-20020adfa455000000b0020ae075cf35so5794770wra.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 15:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t+pDY+Ex4Ewd/QjNKkxD0rhZSfDGQ+G9GZjOekpOl0o=;
        b=nC7SAziUV9QoM7kxF0UWFiGD6TM8pmNBk2Y6W9zQ3HudgjdZ4WGYqaYqA7jRmCNrFj
         rSzw/DgiEKfq7hJtN4ztxWYW+PXILve2Fyrbe1IS0Zpb91Oc7ET0WReMhsvwl5kCsIZF
         e1gpLf2Cn6X8OIMJuEWnTzkbAL65eUlz7ATA2472kyi+qbH5csHmpg1GzoxICg92bDGI
         pDB6tKoyIcBmcdAnhDPGowX0M768nLNpKFSHvX9QF/vjmewoCEcNQfv0+2MQssV4GPeU
         aS32Ai0jAy/f/dyzvz0i7j9bdYfVWbYTNMc71Pg2nFOlPi09pTqFTVLg7h4gcMLHHjkc
         dWzw==
X-Gm-Message-State: AOAM531ahEcrrXKmCIi7IuoEteAfrJioXiwxGHo6TFB853bByxYoe7tN
        FJCgj5UKtEscqSbAgZjp0RKRApOs1N83ExiTLy7PoqcyzluqIGnEp4vuDOgfobTXHvAI3tpGQ+0
        P8gu9HCg6SrUFSGN5nAte+tdj
X-Received: by 2002:a05:600c:4f06:b0:393:ef13:62c5 with SMTP id l6-20020a05600c4f0600b00393ef1362c5mr902013wmq.33.1651530056987;
        Mon, 02 May 2022 15:20:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuoQW8PNhRMhYZlNoJGzUoUBWE/Jea5rFAz7zLOoPbWOoUwrZafgD8evcGGLl1zeR1+/hnyg==
X-Received: by 2002:a05:600c:4f06:b0:393:ef13:62c5 with SMTP id l6-20020a05600c4f0600b00393ef1362c5mr901998wmq.33.1651530056770;
        Mon, 02 May 2022 15:20:56 -0700 (PDT)
Received: from redhat.com ([2.55.174.117])
        by smtp.gmail.com with ESMTPSA id w7-20020adf8bc7000000b0020c5253d8f9sm7963822wra.69.2022.05.02.15.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 15:20:56 -0700 (PDT)
Date:   Mon, 2 May 2022 18:20:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Vilas R K <vilas.r.k@intel.com>,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 0/2] vsock/virtio: add support for device
 suspend/resume
Message-ID: <20220502180554-mutt-send-email-mst@kernel.org>
References: <20220428132241.152679-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428132241.152679-1-sgarzare@redhat.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 03:22:39PM +0200, Stefano Garzarella wrote:
> Vilas reported that virtio-vsock no longer worked properly after
> suspend/resume (echo mem >/sys/power/state).
> It was impossible to connect to the host and vice versa.
> 
> Indeed, the support has never been implemented.
> 
> This series implement .freeze and .restore callbacks of struct virtio_driver
> to support device suspend/resume.
> 
> The first patch factors our the code to initialize and delete VQs.
> The second patch uses that code to support device suspend/resume.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Stefano Garzarella (2):
>   vsock/virtio: factor our the code to initialize and delete VQs
>   vsock/virtio: add support for device suspend/resume
> 
>  net/vmw_vsock/virtio_transport.c | 197 ++++++++++++++++++++-----------
>  1 file changed, 131 insertions(+), 66 deletions(-)
> 
> -- 
> 2.35.1

