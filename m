Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4490B50F0F5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245169AbiDZGdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245102AbiDZGdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:33:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D69EF13F7E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650954609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V7VQIxc2enYPlbUgW2+LE7wrg1Lnj3sGptBhnMeOEwQ=;
        b=G6uZqiyZPZ5Pn0vFV15w9tBPFiV/2W76moZRXlGPxagnulzHa4GkWzKLEJM7UNtfJd9P0+
        RexIK25zPG3lV39v0sjoWIwhKz9WPRCdLntwd8e3incW2bC/gC0Yi4fT9JUQN+xCLPdcbZ
        DA9PBoOOBlKOtj6XSPt+SFo0dnnhRgY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-KdkKx96RPAa0OCX2X6Civw-1; Tue, 26 Apr 2022 02:30:07 -0400
X-MC-Unique: KdkKx96RPAa0OCX2X6Civw-1
Received: by mail-wm1-f72.google.com with SMTP id r186-20020a1c44c3000000b00393f52ed5ceso10722wma.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=V7VQIxc2enYPlbUgW2+LE7wrg1Lnj3sGptBhnMeOEwQ=;
        b=fjM9KDhazEU07Oisdq1Kb2Nwq70wB5is4a7JU+0cN/86QYSES9IZtGKjBdOPoK36Xu
         SGzPIZQ2FUQhMJOXJIyNQs/S6LO1CNMoDNx4A+L1JitxH4Xhfcr/RH5ElekabpgU+DGl
         GgTvWEIt8SjbWfuQRMXVeqHnLiQKMIqdZuo72H3lWkJYgWzTpWsdl6SO4+Wg7sfZ/HDQ
         abZ+J8eMY5hFkgUWbuXBSlllSSo6lGLlU2UvKrYrPlP1jiMSfryKpH7O/gdaOMVzBf7j
         0H4e4Dx5M1fF6ooYntXkXydkrz9waFAbU7jYXVEMIlEHZ+TArDqfsjS5h5w3koKxIaWS
         l8Kw==
X-Gm-Message-State: AOAM531odHxl3CeFYe9TmO8n5EGJXeAE8luB+ibNhm3cq8PJ/d0EPk6y
        UQIB54xfbGXpyOZV7GXBGqCQrYkXEW2Z2vgg83m3lLe3mOxdf3RLqcWm/J4HIVqw1pHT4/3GX9b
        kWHV3IPPxL8LH+eMFkoRve+V6
X-Received: by 2002:adf:db46:0:b0:20a:c903:4711 with SMTP id f6-20020adfdb46000000b0020ac9034711mr15430195wrj.625.1650954605944;
        Mon, 25 Apr 2022 23:30:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNRarFYV3D7gCGqSQ56FDt3rR3NZYRd0yD8ep+RHjYur6XMku/TQPdgMHlcQhhlsKNogy/Pg==
X-Received: by 2002:adf:db46:0:b0:20a:c903:4711 with SMTP id f6-20020adfdb46000000b0020ac9034711mr15430177wrj.625.1650954605766;
        Mon, 25 Apr 2022 23:30:05 -0700 (PDT)
Received: from redhat.com ([2.53.22.137])
        by smtp.gmail.com with ESMTPSA id l5-20020adfa385000000b0020adb3ae75dsm4701707wrb.3.2022.04.25.23.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 23:30:04 -0700 (PDT)
Date:   Tue, 26 Apr 2022 02:30:00 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
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
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220426022420-mutt-send-email-mst@kernel.org>
References: <20220425040512-mutt-send-email-mst@kernel.org>
 <87a6c98rwf.fsf@redhat.com>
 <20220425095742-mutt-send-email-mst@kernel.org>
 <20220426042911.544477f9.pasic@linux.ibm.com>
 <20220425233434-mutt-send-email-mst@kernel.org>
 <20220425233604-mutt-send-email-mst@kernel.org>
 <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org>
 <20220425235415-mutt-send-email-mst@kernel.org>
 <CACGkMEve+3ugK-Kgao3_2wbjb=fbF7AO2uEuArGjKgEAQcGdiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEve+3ugK-Kgao3_2wbjb=fbF7AO2uEuArGjKgEAQcGdiQ@mail.gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 12:07:39PM +0800, Jason Wang wrote:
> On Tue, Apr 26, 2022 at 11:55 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Apr 25, 2022 at 11:53:24PM -0400, Michael S. Tsirkin wrote:
> > > On Tue, Apr 26, 2022 at 11:42:45AM +0800, Jason Wang wrote:
> > > >
> > > > 在 2022/4/26 11:38, Michael S. Tsirkin 写道:
> > > > > On Mon, Apr 25, 2022 at 11:35:41PM -0400, Michael S. Tsirkin wrote:
> > > > > > On Tue, Apr 26, 2022 at 04:29:11AM +0200, Halil Pasic wrote:
> > > > > > > On Mon, 25 Apr 2022 09:59:55 -0400
> > > > > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > >
> > > > > > > > On Mon, Apr 25, 2022 at 10:54:24AM +0200, Cornelia Huck wrote:
> > > > > > > > > On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > > > > > On Mon, Apr 25, 2022 at 10:44:15AM +0800, Jason Wang wrote:
> > > > > > > > > > > This patch tries to implement the synchronize_cbs() for ccw. For the
> > > > > > > > > > > vring_interrupt() that is called via virtio_airq_handler(), the
> > > > > > > > > > > synchronization is simply done via the airq_info's lock. For the
> > > > > > > > > > > vring_interrupt() that is called via virtio_ccw_int_handler(), a per
> > > > > > > > > > > device spinlock for irq is introduced ans used in the synchronization
> > > > > > > > > > > method.
> > > > > > > > > > >
> > > > > > > > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > > > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > > > > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > > > > > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > > > > > > > > Cc: Halil Pasic <pasic@linux.ibm.com>
> > > > > > > > > > > Cc: Cornelia Huck <cohuck@redhat.com>
> > > > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > > >
> > > > > > > > > > This is the only one that is giving me pause. Halil, Cornelia,
> > > > > > > > > > should we be concerned about the performance impact here?
> > > > > > > > > > Any chance it can be tested?
> > > > > > > > > We can have a bunch of devices using the same airq structure, and the
> > > > > > > > > sync cb creates a choke point, same as registering/unregistering.
> > > > > > > > BTW can callbacks for multiple VQs run on multiple CPUs at the moment?
> > > > > > > I'm not sure I understand the question.
> > > > > > >
> > > > > > > I do think we can have multiple CPUs that are executing some portion of
> > > > > > > virtio_ccw_int_handler(). So I guess the answer is yes. Connie what do you think?
> > > > > > >
> > > > > > > On the other hand we could also end up serializing synchronize_cbs()
> > > > > > > calls for different devices if they happen to use the same airq_info. But
> > > > > > > this probably was not your question
> > > > > >
> > > > > > I am less concerned about  synchronize_cbs being slow and more about
> > > > > > the slowdown in interrupt processing itself.
> > > > > >
> > > > > > > > this patch serializes them on a spinlock.
> > > > > > > >
> > > > > > > Those could then pile up on the newly introduced spinlock.
> > > > > > >
> > > > > > > Regards,
> > > > > > > Halil
> > > > > > Hmm yea ... not good.
> > > > > Is there any other way to synchronize with all callbacks?
> > > >
> > > >
> > > > Maybe using rwlock as airq handler?
> > > >
> > > > Thanks
> > > >
> > >
> > > rwlock is still a shared cacheline bouncing between CPUs and
> > > a bunch of ordering instructions.
> 
> Yes, but it should be faster than spinlocks anyhow.
> 
> > > Maybe something per-cpu + some IPIs to run things on all CPUs instead?
> 
> Is this something like a customized version of synchronzie_rcu_expedited()?

With interrupts running in an RCU read size critical section?
Quite possibly that is also an option.
This will need a bunch of documentation since this is not
a standard use of RCU, and probably get a confirmation
from RCU maintainers that whatever assumptions we make
are guaranteed to hold down the road.

> >
> > ... and I think classic and device interrupts are different enough
> > here ...
> 
> Yes.
> 
> Thanks
> 
> >
> > > > >
> > > > > > --
> > > > > > MST
> >

