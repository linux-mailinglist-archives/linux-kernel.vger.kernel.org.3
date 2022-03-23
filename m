Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638C04E52FC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244254AbiCWNXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiCWNXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:23:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B5B47CDEA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648041736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=suvndhg5i90sE3alVpWaoy01Es5EJ/QlvWcm+elPd0I=;
        b=NEbEknhsaIXKoeZUiPegBXB2l55E6SkDGeiW9q9i6s7ei8B0HiH2bVjs/0YWmVLHiRzras
        V/QsttWDPEsuYr2TUUkFDQDosu3Weke7Yd35yQ14RuoIFNv2/gpcXVdjv9IsOJvJJ5rnxU
        1nBgMXd7sUJsyG4jObIfkjgV9MjmALc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-VhNlyeOmM_K12Wmkzll6EQ-1; Wed, 23 Mar 2022 09:22:11 -0400
X-MC-Unique: VhNlyeOmM_K12Wmkzll6EQ-1
Received: by mail-wr1-f69.google.com with SMTP id h11-20020a5d430b000000b001f01a35a86fso509440wrq.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=suvndhg5i90sE3alVpWaoy01Es5EJ/QlvWcm+elPd0I=;
        b=FOyAmwg1AXVFeNcqVdqWwROTBCLHF+TWrH5DEbL2LyzHPtP11b7jPg7XkX+QVv2P44
         J5rCrQUUmNHqqhNk0B7fTaF7FpJb9xByvi26GN+q2TSJnxkoBTD+065PAycI95UY9P4y
         xKLxYKSkOn7m7D5Yg1umToZNtuBhHmxRPzdTUk81RxmhthOCcpfDl6MXs9qKS2z2vjdW
         qFfjLID2KoyJ103swWJQfjQQsevbtJQGH/eLrMGq98du4H1SBuPXTAQclWx5Y6TCkW/H
         Eo2hc+ncbTfMo61IXa7uBMEdUddQoWm/LEuzyokTegTNvnlwGwIacOsEWKI9bmuRp3M7
         Zhmw==
X-Gm-Message-State: AOAM533xmbD7uGsf0aJAz5MoU1lh7TmJFLCaCeRxM6sJsCfjkhiHUzXR
        3m4I9Zp27+5qpEspc0llPlb7hmkqYY86bDpOvkoAETZuCtUsuq73wAEowjVvE5YILWyoJ5OU4Ue
        QDj9RVOauwIg19FYUaJgUXfSw
X-Received: by 2002:a05:6000:15c7:b0:205:87a2:87bc with SMTP id y7-20020a05600015c700b0020587a287bcmr2861197wry.260.1648041728540;
        Wed, 23 Mar 2022 06:22:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyp9kjUHrJnPA7iyjXS+pAxAeSdHIG+pVsNH4tY9VWV5thpBNO3b44rofEKgNXV0UAniIaJg==
X-Received: by 2002:a05:6000:15c7:b0:205:87a2:87bc with SMTP id y7-20020a05600015c700b0020587a287bcmr2861171wry.260.1648041728292;
        Wed, 23 Mar 2022 06:22:08 -0700 (PDT)
Received: from redhat.com ([2.55.151.118])
        by smtp.gmail.com with ESMTPSA id g17-20020a05600c4ed100b0038ca32d0f26sm4091594wmq.17.2022.03.23.06.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 06:22:06 -0700 (PDT)
Date:   Wed, 23 Mar 2022 09:22:02 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Arseny Krasnov <arseny.krasnov@kaspersky.com>,
        "David S. Miller" <davem@davemloft.net>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Asias He <asias@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net v2 0/3] vsock/virtio: enable VQs early on probe and
 finish the setup before using them
Message-ID: <20220323092118-mutt-send-email-mst@kernel.org>
References: <20220323084954.11769-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323084954.11769-1-sgarzare@redhat.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 09:49:51AM +0100, Stefano Garzarella wrote:
> The first patch fixes a virtio-spec violation. The other two patches
> complete the driver configuration before using the VQs in the probe.
> 
> The patch order should simplify backporting in stable branches.

Ok but I think the order is wrong. It should be 2-3-1,
otherwise bisect can pick just 1 and it will have
the issues previous reviw pointed out.



> v2:
> - patch 1 is not changed from v1
> - added 2 patches to complete the driver configuration before using the
>   VQs in the probe [MST]
> 
> v1: https://lore.kernel.org/netdev/20220322103823.83411-1-sgarzare@redhat.com/
> 
> Stefano Garzarella (3):
>   vsock/virtio: enable VQs early on probe
>   vsock/virtio: initialize vdev->priv before using VQs
>   vsock/virtio: read the negotiated features before using VQs
> 
>  net/vmw_vsock/virtio_transport.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> -- 
> 2.35.1

