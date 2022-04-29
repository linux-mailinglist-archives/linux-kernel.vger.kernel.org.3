Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B37514078
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 04:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354129AbiD2CGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 22:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiD2CGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 22:06:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 186B3BAB98
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 19:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651197764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dvj9G0/4wUIqSyOJTfvrlWtHyKpXimLlrMN8i333+hY=;
        b=RKG22wbD7Y11yaRV1jckzFWf0gqUNde7zf/9kaQVHXJVqkbn1UMsvvtNFUlkLNFO9L7FWW
        PXlJax8SAAccDXE6Ef/b8pa+h1KtwdhqdjX9FZmnCitD5K6o+rskNVX6FXdm8YYwSelDCk
        BOPSh3GC7t1pOajMGInhWVuDMFhjLYA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-fqYgiyJmO_2ZLYBgnH3-IA-1; Thu, 28 Apr 2022 22:02:22 -0400
X-MC-Unique: fqYgiyJmO_2ZLYBgnH3-IA-1
Received: by mail-lf1-f70.google.com with SMTP id bt27-20020a056512261b00b004720e026d4dso2703336lfb.16
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 19:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dvj9G0/4wUIqSyOJTfvrlWtHyKpXimLlrMN8i333+hY=;
        b=hRDtqSxiMjr0wg4Pt2NuAdNDXXpcIS73RrfZ5MM6DB5AYg63qdJOoNfhcbfyMQFmhy
         zrNyuHA0GpqG+E/FLOrK0/T/15ehcgbtEgP/WUsymwaaSrAeT7/lZOuVLw0t9YI8+YyO
         3VDnLZc2WURAaSvghv6u45GRYaD+f3Csdb34kOp2WUIWFwwCu6gpP5UHXAMW2bGihTcJ
         R9wCoJbo/ngyhBKuX7Ky6fZNWZ0wRPjtIjZfkHMJs5gIVHfgQOpOgAb9veBlcEOHbLGF
         VeLzXlU7Al+73qAQSdfFHiUaaVSbTa8e3y8Okdtp2hDmLTvfi1ggIhJ5giNWLrnidaBn
         pdqA==
X-Gm-Message-State: AOAM53076M0xXht/KFDW/v9vkfgZ42zd/Kon5ttHRBhG5oQGEaNMRBf7
        CiVwjSx6TgbtaGG5VBtIxD5W2r5eRKanockP7ypfukRRLJ0xjk9HN71jEeDYpEKQO/lUQ9jrx7k
        Y8fFtxWihOd+KKLlVX2evrAr6m7A+5IsokzhLQvyn
X-Received: by 2002:a05:6512:1526:b0:471:44fa:c367 with SMTP id bq38-20020a056512152600b0047144fac367mr25928157lfb.376.1651197741184;
        Thu, 28 Apr 2022 19:02:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRwhr5Cr2fURlu5+J1sQU4pjDclODzlVYVdEfWUhon2IrguY2W6JlRc8rJ3htPCEJZ1xLuCNvxsMLxtCZHwxg=
X-Received: by 2002:a05:6512:1526:b0:471:44fa:c367 with SMTP id
 bq38-20020a056512152600b0047144fac367mr25928142lfb.376.1651197740985; Thu, 28
 Apr 2022 19:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org> <20220425235415-mutt-send-email-mst@kernel.org>
 <87o80n7soq.fsf@redhat.com> <20220426124243-mutt-send-email-mst@kernel.org>
 <87ilqu7u6w.fsf@redhat.com> <20220428044315.3945e660.pasic@linux.ibm.com>
 <CACGkMEudDf=XXhV2tV+xZ586AnDyrQEotGAiSQZ4k1CTAWHZJQ@mail.gmail.com>
 <20220428012156-mutt-send-email-mst@kernel.org> <CACGkMEsd+WHp=LN0BnnDKfzv+nbS2hjgVC-tdemZWuPTc60HBQ@mail.gmail.com>
 <20220428015318-mutt-send-email-mst@kernel.org> <CACGkMEutdd=9c-2h5ijMkgUzEqNPtUCXAum7bm8W7a6m62i_Mg@mail.gmail.com>
 <87zgk5lkme.fsf@redhat.com>
In-Reply-To: <87zgk5lkme.fsf@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 29 Apr 2022 10:02:09 +0800
Message-ID: <CACGkMEtAXGdWKTSh90DH-=0YHhoSFxR43jwA8eROHqxUxdrVYQ@mail.gmail.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
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

On Thu, Apr 28, 2022 at 3:42 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Thu, Apr 28 2022, Jason Wang <jasowang@redhat.com> wrote:
>
> > On Thu, Apr 28, 2022 at 1:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >>
> >> On Thu, Apr 28, 2022 at 01:51:59PM +0800, Jason Wang wrote:
> >> > On Thu, Apr 28, 2022 at 1:24 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >> > >
> >> > > On Thu, Apr 28, 2022 at 11:04:41AM +0800, Jason Wang wrote:
> >> > > > > But my guess is that rwlock + some testing for the legacy indicator case
> >> > > > > just to double check if there is a heavy regression despite of our
> >> > > > > expectations to see none should do the trick.
> >> > > >
> >> > > > I suggest this, rwlock (for not airq) seems better than spinlock, but
> >> > > > at worst case it will cause cache line bouncing. But I wonder if it's
> >> > > > noticeable (anyhow it has been used for airq).
> >> > > >
> >> > > > Thanks
> >> > >
> >> > > Which existing rwlock does airq use right now? Can we take it to sync?
> >> >
> >> > It's the rwlock in airq_info, it has already been used in this patch.
> >> >
> >> >                 write_lock(&info->lock);
> >> >                 write_unlock(&info->lock);
> >> >
> >> > But the problem is, it looks to me there could be a case that airq is
> >> > not used, (virtio_ccw_int_hander()). That's why the patch use a
> >> > spinlock, it could be optimized with using a rwlock as well.
> >> >
> >> > Thanks
> >>
> >> Ah, right. So let's take that on the legacy path too and Halil promises
> >> to test to make sure performance isn't impacted too badly?
> >
> > I think what you meant is using a dedicated rwlock instead of trying
> > to reuse one of the airq_info locks.
> >
> > If this is true, it should be fine.
>
> FWIW, that approach makes sense to me as well.
>

Good to know that. Let me post a new version.

Thanks

