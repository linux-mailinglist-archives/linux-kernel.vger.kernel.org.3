Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0B64E4F31
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243271AbiCWJX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 05:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243186AbiCWJXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:23:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1942075E7D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 02:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648027309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nAs1YHlMpNVeBM3NTvl8o2J8QfBxr1UoRYr/a2zNDSI=;
        b=ij7dzQ3R2joDIncWWMgbv+xMznz5aR2TVsdEZitMmFeGDdyEVysODeVWeAXgEm5rV3lnQF
        sMfKlTTsqqK5fnjZwaILFRtz0jk561g7ouqB6h+tuLkqP10TmFV1J8Qn6x8Yc8ArJBX5Fq
        Ku79LIPv14utAaFVhdZecg21W2a+FmY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-Tf5nu8dzMECm4g1c8gSy3Q-1; Wed, 23 Mar 2022 05:21:47 -0400
X-MC-Unique: Tf5nu8dzMECm4g1c8gSy3Q-1
Received: by mail-lj1-f199.google.com with SMTP id t10-20020a2e2d0a000000b002496423e4adso347750ljt.16
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 02:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nAs1YHlMpNVeBM3NTvl8o2J8QfBxr1UoRYr/a2zNDSI=;
        b=Y7YP0ese04a7a1NevkDepVWk8OCoJJMP3CKfPo4Mjg/au7K9GJZyZcYrQRPnSPu64I
         yuad5YNiv82FRICzy8DdId/G6Wa7/SoZZzn3iWkgxzcFA4eUdHQ/rUTJgbz2vKygUEnQ
         hiBaIgHWk7w5ZkOuBaRfErbOWV/VFK1SCnd07vKsI/BO7KgLcmuc5cqkfjPrwPpmXAfi
         Xtqs8OURJrVlWTVamUpVRfoCCwq3zmPuQ6kprh+3NNDp5D4kxWKleWUYyeqmZOU8KIN9
         vC88odQE4tcmfW8qE6rHSYM8pHUnQeZQ6j6bPcHpFWnYCslsHQVJaRzwTgMacDfrE29k
         55iQ==
X-Gm-Message-State: AOAM531aCfK17XW5mSCSVzr9Ut6N/+kGdtHJ+9B/Zu9aeLFJ5qWMPfgI
        TaFBTYmD+k3/7ggTFmk4gIO7BMgSdDww2RzFUaJA0vyHKJD3J4PklDTIZYByNcSQmcVXbXcpu/G
        HaCoY7Hh7ruOHU29dJPRiXJJ7dkrN9F/Ue9zUaRW0
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id p21-20020a056512139500b00446d38279a5mr21038688lfa.210.1648027306110;
        Wed, 23 Mar 2022 02:21:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGnDD++CkvJ3d1W9q5s2ajSbWe58qQkyPqIuKEuj5wAXh+7QvBP7wfNAtvIkw3xZn3czapRyuVl2X0us7jZRs=
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr21038679lfa.210.1648027305935; Wed, 23
 Mar 2022 02:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220323031524.6555-1-jasowang@redhat.com> <20220323031524.6555-2-jasowang@redhat.com>
 <878rt1xcq2.wl-maz@kernel.org>
In-Reply-To: <878rt1xcq2.wl-maz@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 23 Mar 2022 17:21:34 +0800
Message-ID: <CACGkMEu-sQZO6-LBsLAzw4bqQpua1DXYLcAukjCtd43P3Ei4Ow@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "virtio_pci: harden MSI-X interrupts"
To:     Marc Zyngier <maz@kernel.org>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Keir Fraser <keirf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 5:05 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Wed, 23 Mar 2022 03:15:24 +0000,
> Jason Wang <jasowang@redhat.com> wrote:
> >
> > This reverts commit 9e35276a5344f74d4a3600fc4100b3dd251d5c56. Issue
> > were reported for the drivers that are using affinity managed IRQ
> > where manually toggling IRQ status is not expected. And we forget to
> > enable the interrupts in the restore path as well.
> >
> > In the future, we will rework on the interrupt hardening.
> >
> > Fixes: 9e35276a5344 ("virtio_pci: harden MSI-X interrupts")
> > Reported-by: Marc Zyngier <maz@kernel.org>
> > Reported-by: Stefano Garzarella <sgarzare@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> For this patch and the INTx one:
>
> Acked-by: Marc Zyngier <maz@kernel.org>
>
> Please keep me in the loop when you decide to rework this.

Ok.

Thanks

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
>

