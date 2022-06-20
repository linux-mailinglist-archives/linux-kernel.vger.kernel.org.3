Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88843551348
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238966AbiFTIth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240020AbiFTItd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:49:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BD2A12D09
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655714966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lSi9UTj5bNQNadCcaLjxqTxQzNSJdNW8P+mf6Ts+LLM=;
        b=cfqhyHgGFAE+UooIz5MHPI7hpdMG9DccUbzXjr8A9NNnKPZuzPWEUCPzutEoQ4O8C1+s8D
        i01pOrHPT2XpYOrFBVlgeHOajmVYr3uDBsxfs/m6+Gsfzrzq5MmPmyXBGoFezDahuxeK1d
        3vlcgXVjkzFR/iVd3cd/nNW8eNSFy2c=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-u0H2FErxN92_Xk8jEqEgOA-1; Mon, 20 Jun 2022 04:49:25 -0400
X-MC-Unique: u0H2FErxN92_Xk8jEqEgOA-1
Received: by mail-qv1-f69.google.com with SMTP id 7-20020a0562140d0700b0046bd3ff4a9dso11129176qvh.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lSi9UTj5bNQNadCcaLjxqTxQzNSJdNW8P+mf6Ts+LLM=;
        b=Sql3+2h3yRXWqVT1pNp1nwqDRkQQ/5Gm5OvJT2/qNLUTrvdQ9ylEcual81HF9dTtof
         JIgxUhrtuctlHzYXlRyueDTa6Vh8Y7cp2qY/ljFVb027Yv59ailAXbhIEBfXqEMqOeBa
         RT8TSwS5j+YAXKcS1aBvNUhkhRPyOUy/xRwQryNRsNousSQWR0+kF0PGFpKmTjphjean
         Y7GC7W+KO/mYrgy8FPvFsW/KDvO2qICBdVP063txXj6N6CW/M7DGJDBVGTYikUZHubez
         Wra4St4cn3EJKjFIJObYwO17MgxxxEUOPcl7nmGmiwYiusZrYjhEuTzaxr5JJAnbaujf
         X6FQ==
X-Gm-Message-State: AJIora83hT0Vhi/1SfJFler99EIsqopchvy3fvnFjWa42YiIj+jXfg4d
        FhNadXsmztKOPkoxy2jHn7s5UwYx/Wg0SF2EqxtS4aHO3pwzA7PsiLCzA3BK8vuHCxYJh9TvM+r
        4Oie88TzpG62nQw+q6+TkqUAg
X-Received: by 2002:a37:a5d3:0:b0:6a6:87cc:202c with SMTP id o202-20020a37a5d3000000b006a687cc202cmr14962947qke.732.1655714964739;
        Mon, 20 Jun 2022 01:49:24 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ukLXJ0hiAf3fLsl8d/IHt8LkeC8/B5yxiWUk2MoMKqvnjnha/BmfyLZXLNqtA0PTIQ1uB4tw==
X-Received: by 2002:a37:a5d3:0:b0:6a6:87cc:202c with SMTP id o202-20020a37a5d3000000b006a687cc202cmr14962939qke.732.1655714964530;
        Mon, 20 Jun 2022 01:49:24 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-40.retail.telecomitalia.it. [79.46.200.40])
        by smtp.gmail.com with ESMTPSA id h20-20020a05620a245400b006a6b374d8bbsm12929220qkn.69.2022.06.20.01.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 01:49:23 -0700 (PDT)
Date:   Mon, 20 Jun 2022 10:49:17 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Bo Liu <liubo03@inspur.com>
Cc:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: Remove unnecessary variable assignments
Message-ID: <20220620084917.uroobx2dptpade3t@sgarzare-redhat>
References: <20220617055952.5364-1-liubo03@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220617055952.5364-1-liubo03@inspur.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 01:59:52AM -0400, Bo Liu wrote:
>In function vp_modern_probe(), "mdev->pci_dev" is assigned to
>variable "pci_dev", variable "pci_dev" and "mdev->pci_dev" have
>the same value. There is no need to assign variable "pci_dev" to
>"mdev->pci_dev". So remove it.
>

I suggest rephrasing the description a bit.
Maybe into something like this:

     In function vp_modern_probe(), "pci_dev" is initialized with the
     value of "mdev->pci_dev", so assigning "pci_dev" to "mdev->pci_dev"
     is unnecessary since they store the same value.

Anyway, the patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>Signed-off-by: Bo Liu <liubo03@inspur.com>
>---
> drivers/virtio/virtio_pci_modern_dev.c | 2 --
> 1 file changed, 2 deletions(-)
>
>diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
>index b790f30b2b56..fa2a9445bb18 100644
>--- a/drivers/virtio/virtio_pci_modern_dev.c
>+++ b/drivers/virtio/virtio_pci_modern_dev.c
>@@ -220,8 +220,6 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
>
> 	check_offsets();
>
>-	mdev->pci_dev = pci_dev;
>-
> 	/* We only own devices >= 0x1000 and <= 0x107f: leave the rest. */
> 	if (pci_dev->device < 0x1000 || pci_dev->device > 0x107f)
> 		return -ENODEV;
>-- 
>2.27.0
>

