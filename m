Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13590512B21
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243242AbiD1Fzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbiD1Fza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:55:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BD1D7C278
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 22:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651125134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VG8xe0Lj4eTE8PBjFl2duBm+bHnWsA2hI9mqEPY5x1M=;
        b=hbROdJuK/dex2novTUjm+kgshKmg/9kOoJmD/rQRVX3nFdNDxS1sMt0hMC16xd+IWfhQSG
        3GLz57tsR/iN5YmsrtqhksftUXVCAD2Q7mRiDPHV734Gza/CldW/kpOmEHzRq9lnJdMwo2
        UU8HaNpYqXeT6aIB6MMy0JuayR29EVs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-SylRQrP1OMe7M02ymwz1wQ-1; Thu, 28 Apr 2022 01:52:12 -0400
X-MC-Unique: SylRQrP1OMe7M02ymwz1wQ-1
Received: by mail-lj1-f200.google.com with SMTP id v1-20020a2e2f01000000b0024da499933dso1432833ljv.19
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 22:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VG8xe0Lj4eTE8PBjFl2duBm+bHnWsA2hI9mqEPY5x1M=;
        b=oQcvmN0Ru7qNgq206qi05OcL0bIxH6CGwnyaoLC3Qwh9/slMiLMAaGH/quneOhJKoy
         pwuDy8OWdMRhXUDUKg5CPQOcYST1KoEiu8ltcyKVM5rA3ic/uN89L9ulXkwgitU6r6h9
         wk4wULFuc7vAbQ2aDnLjokSr+KKuNfnI2AMTxnmOvT4tH5iNOJGrpQRV8zte+tVCI5lo
         5zkJNcndRYXgj7ZobT5GGjRo37re8tLzJ25VfZwOGrpGVXH6pkfR4hfyMjocEBIHKCXK
         2h79PJqb4sWBSmEy00XcuTCSq6Z5VVS79FTd2U+Bnj1X5I9jHPGJKC4dPBz4q9/NQ0Fn
         +4wA==
X-Gm-Message-State: AOAM532n/ksgjnG3nf7BYbHFMlDN+Emmfv6kf6Wa3CjhBDUbHzFzRY1S
        JFd/oWZIuAGXYHq+aiKVKFETWb/gALLLWZLgBVFvCq9QL0/DlM8udgDRJMGy75Hkd//B6g1ghsG
        cfcv7Obtn5fK8dGy1J0R5hCygGXe04ukXuA9tSTgl
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id b1-20020a0565120b8100b00448b342513cmr22834531lfv.257.1651125130907;
        Wed, 27 Apr 2022 22:52:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQ1RzrfWfSkhGClXkO34qKBaipySKvQusBGIxeNu+GZHGD2TZarCmX1ullRo8BzpxyDgwoENa2ajgmtrv0F3g=
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id
 b1-20020a0565120b8100b00448b342513cmr22834515lfv.257.1651125130719; Wed, 27
 Apr 2022 22:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220425233434-mutt-send-email-mst@kernel.org>
 <20220425233604-mutt-send-email-mst@kernel.org> <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org> <20220425235415-mutt-send-email-mst@kernel.org>
 <87o80n7soq.fsf@redhat.com> <20220426124243-mutt-send-email-mst@kernel.org>
 <87ilqu7u6w.fsf@redhat.com> <20220428044315.3945e660.pasic@linux.ibm.com>
 <CACGkMEudDf=XXhV2tV+xZ586AnDyrQEotGAiSQZ4k1CTAWHZJQ@mail.gmail.com> <20220428012156-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220428012156-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 28 Apr 2022 13:51:59 +0800
Message-ID: <CACGkMEsd+WHp=LN0BnnDKfzv+nbS2hjgVC-tdemZWuPTc60HBQ@mail.gmail.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 1:24 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Apr 28, 2022 at 11:04:41AM +0800, Jason Wang wrote:
> > > But my guess is that rwlock + some testing for the legacy indicator case
> > > just to double check if there is a heavy regression despite of our
> > > expectations to see none should do the trick.
> >
> > I suggest this, rwlock (for not airq) seems better than spinlock, but
> > at worst case it will cause cache line bouncing. But I wonder if it's
> > noticeable (anyhow it has been used for airq).
> >
> > Thanks
>
> Which existing rwlock does airq use right now? Can we take it to sync?

It's the rwlock in airq_info, it has already been used in this patch.

                write_lock(&info->lock);
                write_unlock(&info->lock);

But the problem is, it looks to me there could be a case that airq is
not used, (virtio_ccw_int_hander()). That's why the patch use a
spinlock, it could be optimized with using a rwlock as well.

Thanks

>
> --
> MST
>

