Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501AB535E60
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240583AbiE0Kev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiE0Kes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:34:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 472341053F1
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653647687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J1xQ8OiQHH9ksLcm4a9s84IyD29bInrw0vUd6yz8xCk=;
        b=AWRryVfY6HJn6AMJFvSSwvNFE/3shn7k4GiIQLhBwuik2v0QTUNHEe+TQXFTo229LAUYfD
        iq4IXDPUSQ4k7yTnhAFXfEOv4k65EkwIQFEijIJ+qBlg3muI1ZBO7vc9an+i0ajxsvvgDy
        iKPTJudh/VzGG2nkAdjXVdwUQHhqBk8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-HRTQFRngOnKjpBnDtietgg-1; Fri, 27 May 2022 06:34:45 -0400
X-MC-Unique: HRTQFRngOnKjpBnDtietgg-1
Received: by mail-qk1-f200.google.com with SMTP id bj2-20020a05620a190200b005084968bb24so3502778qkb.23
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J1xQ8OiQHH9ksLcm4a9s84IyD29bInrw0vUd6yz8xCk=;
        b=DaD6Olha+E3EVOGkCcF/ixWR7bWYVyseYDYvhQWWrGT+x8cPIlvvgIVb9fcKW1/K+G
         phkEHarF2I7rr31Ys/QjNi3u//xGTjSao3hXF2VeIGJrFBywdd348/Zb0MphTAY9IVQQ
         UxKSeEohn1aw7q4q7qwjHIz2GuaNlwXA6AO/h5gricCCNi/tWMasKTAkjTGm3DG6mUIl
         kKAh4Us1ayfltyNCu3j0aYtVk8O6kQQJiQv1jujKj1HawS8sZZqq24tyIBjWhdsphzet
         /tXs2oa+J2Iw0U/HvHCElI7pEITEKMkXfmktxrI/eSpNz0XTxq/EbSfJLJW2A6qgHoK8
         y1tQ==
X-Gm-Message-State: AOAM533582BOsYD9l9U+/NbqyWcF11KP26KNWW7iS2nuNGfSVJGsLaNp
        vantek3KBOHp4o5EjF9fOnwe5EaKkCTmUoU7kPwUaNHtV2UuHs0mEOKWBXH5Nb+LTRaq3yOVbwn
        S2DQiGEQQLObr2SfLgpY4M+D1
X-Received: by 2002:a05:620a:4042:b0:6a5:aded:fe52 with SMTP id i2-20020a05620a404200b006a5adedfe52mr5591557qko.365.1653647685391;
        Fri, 27 May 2022 03:34:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqxv+VTwgq+LPdZICQyGqh24jAfcU1fwHBx1WzLpbtJcUIqfLL3McbVD+9ZVGHmS3yYq9xJg==
X-Received: by 2002:a05:620a:4042:b0:6a5:aded:fe52 with SMTP id i2-20020a05620a404200b006a5adedfe52mr5591538qko.365.1653647685166;
        Fri, 27 May 2022 03:34:45 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it. [87.12.25.16])
        by smtp.gmail.com with ESMTPSA id h19-20020a05620a401300b006a10c8d5d96sm2802962qko.3.2022.05.27.03.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 03:34:44 -0700 (PDT)
Date:   Fri, 27 May 2022 12:34:36 +0200
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
Subject: Re: [PATCH V6 2/9] virtio: use virtio_reset_device() when possible
Message-ID: <20220527103436.erqkgeh34prlvssh@sgarzare-redhat>
References: <20220527060120.20964-1-jasowang@redhat.com>
 <20220527060120.20964-3-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220527060120.20964-3-jasowang@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 02:01:13PM +0800, Jason Wang wrote:
>This allows us to do common extension without duplicating code.
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
> drivers/virtio/virtio.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

Maybe I had already reviewed it :-), anyway:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

