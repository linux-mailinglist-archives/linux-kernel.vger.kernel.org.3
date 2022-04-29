Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F17514080
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 04:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354023AbiD2CMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 22:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiD2CMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 22:12:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 109F5BCB4E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 19:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651198135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n1hFr6Yi4j7w9u2wUwkc3nSsLkNRf93uROLqf4bH3hw=;
        b=XrAWqQcUqVRHuoWFEXtsyN2wqQLGUojpVIGmyzSJYRajgr/rMOj6qPNQGvFCT6H9o1rKnE
        Os2HKhLAv22RD3jmzT2WoGN4Y/hDxQdGbiPX6TpC41nOTl9MonLG8UTKUWJS6FjkT44XTM
        HdQc8SXtfVv3q64djRoGKyGf/sGbgWg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-wjqR35dDM3SuYcXvfoLYZQ-1; Thu, 28 Apr 2022 22:08:53 -0400
X-MC-Unique: wjqR35dDM3SuYcXvfoLYZQ-1
Received: by mail-lf1-f72.google.com with SMTP id v27-20020ac2561b000000b004723bc15e64so1376314lfd.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 19:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n1hFr6Yi4j7w9u2wUwkc3nSsLkNRf93uROLqf4bH3hw=;
        b=CwaUofFosXXknZK3d8ta4VchFxCRUWKcU9V8jJU2yviV1MUR3v9X2rmuhE10Q6CSTP
         LQ7O+Nf1AcjKIqNgSd4hEHjQOPgjfnSI+OPjiQhIYrz1VZT3SxjoDMr/tHUfuDZvB4/N
         5BBHZyMqJEwkwgah0poYfsUqEYIluksLNR1/Csn21gz6k94qScTxe9krgYrCeZk4LIr7
         sqTRrabgH/c3ZylELfmbpYzURBs7i4ByqmWpvOdtXgv0w8E7tgy/ws4ueD7zqgQEhcxk
         ZJa5O/cZBGd69OBfRPYfLVa0yWD6O8J5dS6P3PTujgunII8QzBkVRBg2UrRD9R7wxHc5
         FLnA==
X-Gm-Message-State: AOAM530fcT497ZMtL9Q1ZOXlNMik8GFR+zmLfsH5AxKI1HizlM3dmpAJ
        sm0QxjaXUZvixoW4BL+64Xrku1c/o59Wxik4GUEeLG723JgRXhIM/c+T113Upruq/4hLiLBhayz
        5suyUL3+fmZK1MET+ZgrvTxMuoySFLW6pdam2DAdW
X-Received: by 2002:a05:651c:892:b0:249:9e23:15 with SMTP id d18-20020a05651c089200b002499e230015mr23697089ljq.492.1651198131735;
        Thu, 28 Apr 2022 19:08:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxg9jpPQWsuBYVjm9WMW0PBgw9VuFnAduhGEOWG/ZXQHEFn6JmM4VwclH4MDqex/tZ+M8KTzTqL1c5etuwsVIY=
X-Received: by 2002:a05:651c:892:b0:249:9e23:15 with SMTP id
 d18-20020a05651c089200b002499e230015mr23697078ljq.492.1651198131581; Thu, 28
 Apr 2022 19:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220425024418.8415-1-jasowang@redhat.com> <20220425024418.8415-4-jasowang@redhat.com>
 <87r15hlgel.fsf@redhat.com>
In-Reply-To: <87r15hlgel.fsf@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 29 Apr 2022 10:08:40 +0800
Message-ID: <CACGkMEsrSHtD9iO1qHjMGgwG5YwYVpX+7OKZaN9Oq29tPpGZYg@mail.gmail.com>
Subject: Re: [PATCH V3 3/9] virtio: introduce config op to synchronize vring callbacks
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     mst <mst@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 5:13 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Mon, Apr 25 2022, Jason Wang <jasowang@redhat.com> wrote:
>
> > This patch introduces new virtio config op to vring
> > callbacks. Transport specific method is required to make sure the
> > write before this function is visible to the vring_interrupt() that is
>
> Which kind of writes? I.e., what is the scope?

Any writes before synchronize_cbs(). Is something like the following better?

The function guarantees that all memory operations before it are
visible to the vring_interrupt() that is called after it.

>
> > called after the return of this function. For the transport that
> > doesn't provide synchronize_vqs(), use synchornize_rcu() which
>
> Typo: synchronize_rcu()

Will fix it.

Thanks

>
> > synchronize with IRQ implicitly as a fallback.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Halil Pasic <pasic@linux.ibm.com>
> > Cc: Cornelia Huck <cohuck@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  include/linux/virtio_config.h | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > index b341dd62aa4d..14fe89ff99c7 100644
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -57,6 +57,10 @@ struct virtio_shm_region {
> >   *           include a NULL entry for vqs unused by driver
> >   *   Returns 0 on success or error status
> >   * @del_vqs: free virtqueues found by find_vqs().
> > + * @synchronize_cbs: synchronize with the virtqueue callbacks (optional)
> > + *      Make sure the writes commited before this method is visible to
> > + *      vring_interrupt() which is called after this method.
>
> Same here, I think the description needs to be a bit more explicit about
> which writes we care about here.
>
> > + *      vdev: the virtio_device
> >   * @get_features: get the array of feature bits for this device.
> >   *   vdev: the virtio_device
> >   *   Returns the first 64 feature bits (all we currently need).
> > @@ -89,6 +93,7 @@ struct virtio_config_ops {
> >                       const char * const names[], const bool *ctx,
> >                       struct irq_affinity *desc);
> >       void (*del_vqs)(struct virtio_device *);
> > +     void (*synchronize_cbs)(struct virtio_device *);
> >       u64 (*get_features)(struct virtio_device *vdev);
> >       int (*finalize_features)(struct virtio_device *vdev);
> >       const char *(*bus_name)(struct virtio_device *vdev);
>

