Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC7A52CE63
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbiESIeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiESIeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:34:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73E3C73570
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652949252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e36VWZ5DWvtpQPTuTGZUg65mwhzA3Ro0bMqrlq/Fvz0=;
        b=W2nm9w/4IgBHXkvB20DHn3V4bgwdBXMNMuEejDdbCPLnRD6u6TaJV623I+2HQyEAlsU7XA
        yX2MwrN03ffLybS57a/B/h8D1oKmqQi1kfDgHX1da4J/eBUmpC+Rp9OnYm6ti/xFBmZhFR
        ZKkNfSfkBldzhFdBTsDs5uLfepSQmcE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-VBJBfPgeOySye37CB6kU2A-1; Thu, 19 May 2022 04:34:07 -0400
X-MC-Unique: VBJBfPgeOySye37CB6kU2A-1
Received: by mail-wr1-f70.google.com with SMTP id x4-20020a5d4444000000b0020d130e8a36so1289186wrr.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e36VWZ5DWvtpQPTuTGZUg65mwhzA3Ro0bMqrlq/Fvz0=;
        b=VL38nb2jwpo/VlhvA3rhB+xhslZGmLIAjEMnpAO4g3nyAYgdo9E/PDLMj2jR7jSFQ0
         rSu3AHw7HIFiFgLPPsVETfqIW5dps5UtMRxSzyVnQUy98oZk67snZHa/r2p/hcH+JvcJ
         mZ8e7Aj4SKmN6S+hKMLMMKdGGb0tr9X+MKTe+m1viF9bqXx+Ztx14Y6TA2iVKL+vCB/k
         DX5QPak9GHY44HBEXecwbEq2CIHlFTVOtt/LRXyV34ro1TxI+r58e1W0mDWLH2Yx1Ene
         ihlj3PaOXL6Xy2hEtYqDJHeGNkFaLyW6wt6sP0+tsEyWgDXKxwXQ2lSUJDuDEmB+ILCs
         mWVA==
X-Gm-Message-State: AOAM531t4PjXkxMDlAdMc2JDpgaIspupcCA0XeMMt2f+lmkK2fnXLkqQ
        o6FMR5hVszApwkbzZgHTSQAjubBGuIUnkxuCQQhUGm0brnW9QcE63GkfOTYOtTzPo18Duc5oe8T
        JrB8KHHs2ZRwA+bjdENrhsGPU
X-Received: by 2002:a5d:6a4e:0:b0:20d:83:f5bb with SMTP id t14-20020a5d6a4e000000b0020d0083f5bbmr2963253wrw.392.1652949245039;
        Thu, 19 May 2022 01:34:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz05m0Do5MtdQDqPk7YxffOwGGKVjHy6V0eWXG2QT+lHKjiwAFQdDwNmmaqWWjoSwfqFAMZew==
X-Received: by 2002:a5d:6a4e:0:b0:20d:83:f5bb with SMTP id t14-20020a5d6a4e000000b0020d0083f5bbmr2963236wrw.392.1652949244809;
        Thu, 19 May 2022 01:34:04 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it. [87.12.25.16])
        by smtp.gmail.com with ESMTPSA id m26-20020a7bce1a000000b003942a244f3fsm6669865wmc.24.2022.05.19.01.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 01:34:04 -0700 (PDT)
Date:   Thu, 19 May 2022 10:34:01 +0200
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
Subject: Re: [PATCH V5 3/9] virtio: introduce config op to synchronize vring
 callbacks
Message-ID: <20220519083401.ynmjdihi4hnjahlg@sgarzare-redhat>
References: <20220518035951.94220-1-jasowang@redhat.com>
 <20220518035951.94220-4-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220518035951.94220-4-jasowang@redhat.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 11:59:45AM +0800, Jason Wang wrote:
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

