Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1521535E65
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350481AbiE0Kfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbiE0Kfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:35:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB73C128158
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653647738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/zrleRNQCe5coayR0kaH9WedW9Vs8BA6BoXc0zZ1wCI=;
        b=BPUDe3A2qxGTVUWfvgoWs4QWrfSc69uBmjggfUqmNLr4QOC6CrVkjHkg4VDmx5is6v9e38
        uXhYx3LY/+llLGvxmiUw7/nBUSAOPDynjdz3xyQW54xQyIE9Jx+D5c/Swtl6Ag+AZaiUG1
        SNM9emd/9aoKZMXx6MaVAQmdDnxvUt4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-mzvO4ACxOJOT77PJI6rTWg-1; Fri, 27 May 2022 06:35:36 -0400
X-MC-Unique: mzvO4ACxOJOT77PJI6rTWg-1
Received: by mail-qv1-f72.google.com with SMTP id a1-20020a0ccdc1000000b004642891d824so965391qvn.16
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/zrleRNQCe5coayR0kaH9WedW9Vs8BA6BoXc0zZ1wCI=;
        b=Bw/04fp0YlyNBD4YsDRACNKqA0yUyAugLaEunI0JwUor4aor1VPUSlJCAzBDyDIzLU
         RO+aGv6l1/n7YOMWJinSVB/sB1NNZcXoxUP7QVcI38Dr4WTwEGxFTdrIPt7HS5TN0BXS
         GmfaHi5uzYmEyfFAJSu7enSnLiTbIJgaJsLiaUvdVZRAi/bwmz5r+QOEZ/0EXoU8AWXi
         WqdmIQFvffzbMcNpjka0TbkNASLsdSRcvZe/kyng2hMq8wSpp9nj/oHw0mktfj3w8mm6
         mSzMBdQo4ZLNHhgSfsVzbpcKLcNAhoEew4lyYVXoOX4Qc7fOVamSUdvz3TXqVksHMN1z
         cAxA==
X-Gm-Message-State: AOAM531FhkfOWwCcecxHFlh556PgdAZcoZtKjh/6Zf91M6bK8Mm1fHgk
        EG188LCOSpET8OGHyqrK7nVWpTdJ1klD13j3CNqchChwpStlLA0JpsJejzKDxCG3tkPbIjbX2mx
        6JAQZW3uUJ6GizP20iJ22NA4k
X-Received: by 2002:a05:622a:178f:b0:2f3:dd2e:6054 with SMTP id s15-20020a05622a178f00b002f3dd2e6054mr32734451qtk.554.1653647736321;
        Fri, 27 May 2022 03:35:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/DdJ7C1pNGSuqERmPyGufmFDtkXuN7ZZ9wXEOlVJRq4YbuWRCxS9DqSNdvMaM0Tg+oETAlQ==
X-Received: by 2002:a05:622a:178f:b0:2f3:dd2e:6054 with SMTP id s15-20020a05622a178f00b002f3dd2e6054mr32734439qtk.554.1653647736086;
        Fri, 27 May 2022 03:35:36 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it. [87.12.25.16])
        by smtp.gmail.com with ESMTPSA id c142-20020ae9ed94000000b006a33fc1113csm2498024qkg.23.2022.05.27.03.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 03:35:35 -0700 (PDT)
Date:   Fri, 27 May 2022 12:35:29 +0200
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
Subject: Re: [PATCH V6 9/9] virtio: use WARN_ON() to warning illegal status
 value
Message-ID: <20220527103529.kc6tpon3lohceskm@sgarzare-redhat>
References: <20220527060120.20964-1-jasowang@redhat.com>
 <20220527060120.20964-10-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220527060120.20964-10-jasowang@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 02:01:20PM +0800, Jason Wang wrote:
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

