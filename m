Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDD952CE5B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbiESIc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiESIc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:32:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F45771A33
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652949144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4zGkqLBS/TAgxZK9Jmx8vQw2RK+jMADwG0s4JnBJWNc=;
        b=JAJOTCK5kPxCCG/z1wnfZIWQ73ywZKnEXmPfEOHNnazGaD+yGS+vfA8SFlP3H/xZC+KbLf
        RXe8diBTVuDOKOLCPzKc3B6EmebfYUHRiMoucgat1KoJxXFzpYLyOE978oHVNdgTUEjFAy
        aoqwGgNvbSfHBfvX5eVZfGMNCp7l6LU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-3NRaX_l4PnK-hAhDQw8q4g-1; Thu, 19 May 2022 04:32:21 -0400
X-MC-Unique: 3NRaX_l4PnK-hAhDQw8q4g-1
Received: by mail-wr1-f70.google.com with SMTP id u17-20020a056000161100b0020cda98f292so1285041wrb.21
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4zGkqLBS/TAgxZK9Jmx8vQw2RK+jMADwG0s4JnBJWNc=;
        b=bvFm0PO4FPH44bFMiFfRebqgoJAGxz38cjH9M69StKmmtXQAK+7rTlGDaR3NEXWUhX
         8pbZNwCoaqS4bipvku86OAvJKsnEqBC8CFJ4MEfXNCHM/HDzFbgnJof/3OhrxgqNnxX2
         FDT62WZQyDL0stjEhLw2DF2UXerLKbYfdV+jnKD30bepP7uGfSLAVS6Mz7TibNh9nn8y
         GVnRwfzUxKsSVpsAYgbrPSgc5TZH41SHVEEPQVCIibuksrB4tFo9VJ1EdrU6NO419n56
         uvN1qJniGVPnIFRre10cKPjW40PhJvbS/pFbzXkY2Of983UCk3QUKUOH1ASIEHj9M/jr
         g+jw==
X-Gm-Message-State: AOAM532EUVVm2xI+oB6AqheRpMcGVaVGYOqbn+W22dNLFEm/cYoOVYL3
        Nc025EdRnNynOZfXnkIUfiEz9VHx6m6SxkF29X5vKoLC2vow8GguooX1mTw1+tDHE136+Fpy62j
        6QS+CDHqsb3dEKfk8G7dvIFvQ
X-Received: by 2002:a05:6000:2c2:b0:20c:c6e1:e881 with SMTP id o2-20020a05600002c200b0020cc6e1e881mr2965134wry.333.1652949139810;
        Thu, 19 May 2022 01:32:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyio4JEWQmgkioPkbNgTt2e70V8qT0vr7F8BBMxVMH/FsBBAQUG715vLlB3cyn0DlqD+bNL7Q==
X-Received: by 2002:a05:6000:2c2:b0:20c:c6e1:e881 with SMTP id o2-20020a05600002c200b0020cc6e1e881mr2965117wry.333.1652949139611;
        Thu, 19 May 2022 01:32:19 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it. [87.12.25.16])
        by smtp.gmail.com with ESMTPSA id l6-20020adfa386000000b0020cfed0bb7fsm4441801wrb.53.2022.05.19.01.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 01:32:18 -0700 (PDT)
Date:   Thu, 19 May 2022 10:32:13 +0200
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
Subject: Re: [PATCH V5 2/9] virtio: use virtio_reset_device() when possible
Message-ID: <20220519083213.jwzr272vvkh6ogq4@sgarzare-redhat>
References: <20220518035951.94220-1-jasowang@redhat.com>
 <20220518035951.94220-3-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220518035951.94220-3-jasowang@redhat.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 11:59:44AM +0800, Jason Wang wrote:
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

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

