Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D17C535E6B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350503AbiE0Kgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbiE0Kgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:36:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B249767F
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653647802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l2OTG3cehkDKC9XILcBu3L3NTinwiyGs3kvyt5+4+bQ=;
        b=ECPAwQ4d1vxbcNNOJiVSPngJpsyNws8Od78Bq1+9Wa2LvcTKmHnZZ7FZOlQc/38V5QHaYp
        xHVOr+9OEX5C+C60SUVQygemg7QacsTOrhKiGM2MyEbzjvV/tDCWjMiM7ByoAFeNow2InX
        UQgs839e2hyGKtzrKMzt/qlNDewnfHA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518--_uex93NOCqNl464x4qlTw-1; Fri, 27 May 2022 06:36:39 -0400
X-MC-Unique: -_uex93NOCqNl464x4qlTw-1
Received: by mail-qk1-f197.google.com with SMTP id s9-20020ae9f709000000b006a3e88115b7so3513510qkg.20
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l2OTG3cehkDKC9XILcBu3L3NTinwiyGs3kvyt5+4+bQ=;
        b=cn/OT9EfPLTgCGTi4y98GJhgWyN5CdSzWu39nxOmZrg/HPnQk/qw7HFXlYw0KiTg+H
         vL2DQfhSAnh48c+ZqZZsv1xx/lYP7egf+TSaTNK8+xQgYHiAvPXRfTfSaTQuZYiD7Zec
         04WFXmAqk/GgJzP3baxL2DgS/U9LapyiQWEszHKNBvaUlpV5DmhDad7pnPXl+zMA9+ac
         PbVY+m/mNfnFj+Z02rbUy8kp7+obOj0HWRiVE/IyeBVoB+3q0I4MUxZhcMowLJF9Z2MX
         t1JZHnbCFrsX39hxqqMmZ150o42VzsGUC7rffaXjb6AKCBSqQJ0/4eAA+GUJXyVfCmwY
         lZDg==
X-Gm-Message-State: AOAM5325mE/nfjRMDRaOpxntmNbwVA/RgcKsUalR7TizNS1Tfs5RUK+N
        UJ/zqfs/iXn/wp+Z9qzQkcw2Axc/EvUk33+hObrV1pGcov96WGWV+Ym5yLmvf9cZxHFb7rBsAXb
        7trlAL5VPa/tCgVVqueSOFR++
X-Received: by 2002:a05:622a:293:b0:2f9:3ab6:a462 with SMTP id z19-20020a05622a029300b002f93ab6a462mr18387285qtw.546.1653647799271;
        Fri, 27 May 2022 03:36:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCj+m03onZL8ESQWhknID+ES7qStMFrkjNlklugGOQyZkMOqq0rGwzKUL4uYoaC7qHSvuTtQ==
X-Received: by 2002:a05:622a:293:b0:2f9:3ab6:a462 with SMTP id z19-20020a05622a029300b002f93ab6a462mr18387263qtw.546.1653647799063;
        Fri, 27 May 2022 03:36:39 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it. [87.12.25.16])
        by smtp.gmail.com with ESMTPSA id m184-20020a37bcc1000000b006a323e60e29sm2557931qkf.135.2022.05.27.03.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 03:36:38 -0700 (PDT)
Date:   Fri, 27 May 2022 12:36:32 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, paulmck@kernel.org, maz@kernel.org,
        pasic@linux.ibm.com, cohuck@redhat.com, eperezma@redhat.com,
        lulu@redhat.com, xuanzhuo@linux.alibaba.com,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH V6 3/9] virtio: introduce config op to synchronize vring
 callbacks
Message-ID: <20220527103632.ujsefjwkddoaoxwi@sgarzare-redhat>
References: <20220527060120.20964-1-jasowang@redhat.com>
 <20220527060120.20964-4-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220527060120.20964-4-jasowang@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 02:01:14PM +0800, Jason Wang wrote:
>This patch introduces new virtio config op to vring
>callbacks. Transport specific method is required to make sure the
>write before this function is visible to the vring_interrupt() that is
>called after the return of this function. For the transport that
>doesn't provide synchronize_vqs(), use synchornize_rcu() which
>synchronize with IRQ implicitly as a fallback.
>
>Cc: Thomas Gleixner <tglx@linutronix.de>
>Cc: Peter Zijlstra <peterz@infradead.org>
>Cc: "Paul E. McKenney" <paulmck@kernel.org>
>Cc: Marc Zyngier <maz@kernel.org>
>Cc: Halil Pasic <pasic@linux.ibm.com>
>Cc: Cornelia Huck <cohuck@redhat.com>
>Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
>Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
>Cc: linux-s390@vger.kernel.org
>Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> include/linux/virtio_config.h | 25 +++++++++++++++++++++++++
> 1 file changed, 25 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

