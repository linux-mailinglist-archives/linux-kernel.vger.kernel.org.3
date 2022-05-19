Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F0C52CE69
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbiESIez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiESIeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:34:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FBD574DCC
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652949287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RXQa/is57ndmeB4UOc268UZ9oUyQAZpGNBvHCtt4ZMQ=;
        b=XYEX3fcWt/be2EZlP1kdRbN/3G23998sXwwW8lUKYfyyGJe5+IAhW4OaC7YjVcwfPydArQ
        Bx4hsyB1CbS51dNiodDTaMuIajCbgt9t74+sei+iMQZ/LPWRA9qceFMRzO7B0uMKlAIx7C
        rVEPlqT+Qxf22LTq8oXVasr+MlpDIFE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-T1DmDaE8Mi-gbuybEfCHVA-1; Thu, 19 May 2022 04:34:45 -0400
X-MC-Unique: T1DmDaE8Mi-gbuybEfCHVA-1
Received: by mail-wr1-f69.google.com with SMTP id u11-20020a056000038b00b0020c9ea8b64fso1284455wrf.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RXQa/is57ndmeB4UOc268UZ9oUyQAZpGNBvHCtt4ZMQ=;
        b=s+X+GKeOsv0S3Pl6tnGFcTs94AkAMsiQurCkkTQIaJJ74hwRFEVoUkmqF2C+D943wP
         jX+v4W9YeYxEDgLwAZhUvqykaQzogikliUzLnl9x/Nvunw4C27vs+uaYj7HSEEydT08c
         fpqyxwcVFIefuTogSYsojnp3h/MjXcGJSErrmy/t/iv0osPsGbMxO2xokHfQQ0Dnvhn2
         VuFMOIiz1/sHwDxDH3fMBrDqZICog23bUh8F7P8QV+6kpTiSV5SXfUzDucgFS7oHxbof
         V3E62V1qUSBEDJD4mBhgHc7pHpNv08JfGgZ0rGWCx6lqHFJ5BlhrvFGzqOD8B2ham1Up
         P3kw==
X-Gm-Message-State: AOAM533mxPg6K/EvLXGQmpOgUVYDCkgM31BIPKYJZ0xeon4rVynGVQZK
        derb8HILkiPznWY1+8+NcolxEGTZNJL0IeWf9lxv0J5RoVPXnkZrMge72DoHdKOhVJMpWscx8vR
        9oY2EJDuyffAWZdFF9q1VTmut
X-Received: by 2002:a05:600c:4f03:b0:394:6499:21c7 with SMTP id l3-20020a05600c4f0300b00394649921c7mr2708650wmq.103.1652949284636;
        Thu, 19 May 2022 01:34:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAkq9/tyayvfVCMywTQMNAHfHo8x/Yw3YYtWkfOqMxHBW6hbphrtHFbnw12lWB4vdPFEW1PA==
X-Received: by 2002:a05:600c:4f03:b0:394:6499:21c7 with SMTP id l3-20020a05600c4f0300b00394649921c7mr2708636wmq.103.1652949284410;
        Thu, 19 May 2022 01:34:44 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it. [87.12.25.16])
        by smtp.gmail.com with ESMTPSA id n4-20020a1c2704000000b003942a244f3asm6212873wmn.19.2022.05.19.01.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 01:34:43 -0700 (PDT)
Date:   Thu, 19 May 2022 10:34:40 +0200
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
Subject: Re: [PATCH V5 9/9] virtio: use WARN_ON() to warn illegal status value
Message-ID: <20220519083440.luyv6lzcq3fiw27e@sgarzare-redhat>
References: <20220518035951.94220-1-jasowang@redhat.com>
 <20220518035951.94220-10-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220518035951.94220-10-jasowang@redhat.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 11:59:51AM +0800, Jason Wang wrote:
>We used to use BUG_ON() in virtio_device_ready() to detect illegal
>status value, this seems sub-optimal since the value is under the
>control of the device. Switch to use WARN_ON() instead.
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
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> include/linux/virtio_config.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

