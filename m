Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB3750EF6E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 05:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243601AbiDZD6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 23:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbiDZD6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 23:58:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B21B411143
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 20:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650945316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k8DCgpThd7pILyojCaMETysh65rozf6ZoyV6RveS5yk=;
        b=EIqZucAHjCt/I2g/c1uGRO6CdI4GDv4sKjJ+JQzf6rnWc9axwpehLvNLqm31FVKIZr7ptu
        a97ejVktVJ3VRe95MKNdQatZf21y0NyaY2jOcBFOjOWQZDE3bbQ3EIXuz+j/JyOOhnmmRW
        aw5Zlu5NqI/6ghoVtXaBTGW5Prc1J/c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-XvzZh-U6P2GlMavG-YKRkA-1; Mon, 25 Apr 2022 23:55:15 -0400
X-MC-Unique: XvzZh-U6P2GlMavG-YKRkA-1
Received: by mail-wr1-f69.google.com with SMTP id k20-20020adfc714000000b001e305cd1597so3995388wrg.19
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 20:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=k8DCgpThd7pILyojCaMETysh65rozf6ZoyV6RveS5yk=;
        b=gI+vWRNXxDWhuSihLYEjt+ZrOR0LA8PRE9DH9yruTtxm5VtkB9DDtVLlkY6XoLByU+
         J+VWlY31v0oKuKbznYlfTXzOuwj5acqph9MMbiE6tPKrUJ1knfrbNEbGGNIxYOKMx0dj
         /Ouv73ZkYZG2QXGaXJeR1fAHBC/73s9l2schweAQgI1liMr0S/fkaIFC9zn6u75Dy3ca
         awl9zrfaLmx/Cp+27cA1uNvSUx/LJvqiyTj6yWZslVMkPKtvcWfDvdudkCo37BSsRFd4
         zBfUqZwbGWEEksm3UUoBsk8I4iIGniHoHzr53J4kKJcaP4j6lwbPI4gbta78+UkOJ5am
         xS7Q==
X-Gm-Message-State: AOAM533q+o4y8IDdGLLxG/fEASXqGogyjsi5KETWMjbFmv2j+FKUFLpP
        3vVqw3IoZLSVGqT79oWzcukwyAswL4C2u9bNgZ6NcW+cPDqIkuiYXqEwLPlf+veLJhIwwveS6gB
        xRk6nRtC4HyjcNmHz+dWlmYCa
X-Received: by 2002:a7b:cb83:0:b0:37e:bc50:3c6b with SMTP id m3-20020a7bcb83000000b0037ebc503c6bmr28978710wmi.67.1650945314219;
        Mon, 25 Apr 2022 20:55:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUZ0sdWxGZIAvoc1Bigfd+lXNXJtNCcFHGVd5kuF2nbZVjYpDciBMefaxxcg5uKysfxdjG4w==
X-Received: by 2002:a7b:cb83:0:b0:37e:bc50:3c6b with SMTP id m3-20020a7bcb83000000b0037ebc503c6bmr28978700wmi.67.1650945314032;
        Mon, 25 Apr 2022 20:55:14 -0700 (PDT)
Received: from redhat.com ([2.53.22.137])
        by smtp.gmail.com with ESMTPSA id q128-20020a1c4386000000b003915e19d47asm12952833wma.32.2022.04.25.20.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 20:55:13 -0700 (PDT)
Date:   Mon, 25 Apr 2022 23:55:09 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        eperezma@redhat.com, lulu@redhat.com, tglx@linutronix.de,
        peterz@infradead.org, paulmck@kernel.org, maz@kernel.org
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220425235415-mutt-send-email-mst@kernel.org>
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-7-jasowang@redhat.com>
 <20220425040512-mutt-send-email-mst@kernel.org>
 <87a6c98rwf.fsf@redhat.com>
 <20220425095742-mutt-send-email-mst@kernel.org>
 <20220426042911.544477f9.pasic@linux.ibm.com>
 <20220425233434-mutt-send-email-mst@kernel.org>
 <20220425233604-mutt-send-email-mst@kernel.org>
 <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220425235134-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 11:53:24PM -0400, Michael S. Tsirkin wrote:
> On Tue, Apr 26, 2022 at 11:42:45AM +0800, Jason Wang wrote:
> > 
> > 在 2022/4/26 11:38, Michael S. Tsirkin 写道:
> > > On Mon, Apr 25, 2022 at 11:35:41PM -0400, Michael S. Tsirkin wrote:
> > > > On Tue, Apr 26, 2022 at 04:29:11AM +0200, Halil Pasic wrote:
> > > > > On Mon, 25 Apr 2022 09:59:55 -0400
> > > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > 
> > > > > > On Mon, Apr 25, 2022 at 10:54:24AM +0200, Cornelia Huck wrote:
> > > > > > > On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > > > On Mon, Apr 25, 2022 at 10:44:15AM +0800, Jason Wang wrote:
> > > > > > > > > This patch tries to implement the synchronize_cbs() for ccw. For the
> > > > > > > > > vring_interrupt() that is called via virtio_airq_handler(), the
> > > > > > > > > synchronization is simply done via the airq_info's lock. For the
> > > > > > > > > vring_interrupt() that is called via virtio_ccw_int_handler(), a per
> > > > > > > > > device spinlock for irq is introduced ans used in the synchronization
> > > > > > > > > method.
> > > > > > > > > 
> > > > > > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > > > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > > > > > > Cc: Halil Pasic <pasic@linux.ibm.com>
> > > > > > > > > Cc: Cornelia Huck <cohuck@redhat.com>
> > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > 
> > > > > > > > This is the only one that is giving me pause. Halil, Cornelia,
> > > > > > > > should we be concerned about the performance impact here?
> > > > > > > > Any chance it can be tested?
> > > > > > > We can have a bunch of devices using the same airq structure, and the
> > > > > > > sync cb creates a choke point, same as registering/unregistering.
> > > > > > BTW can callbacks for multiple VQs run on multiple CPUs at the moment?
> > > > > I'm not sure I understand the question.
> > > > > 
> > > > > I do think we can have multiple CPUs that are executing some portion of
> > > > > virtio_ccw_int_handler(). So I guess the answer is yes. Connie what do you think?
> > > > > 
> > > > > On the other hand we could also end up serializing synchronize_cbs()
> > > > > calls for different devices if they happen to use the same airq_info. But
> > > > > this probably was not your question
> > > > 
> > > > I am less concerned about  synchronize_cbs being slow and more about
> > > > the slowdown in interrupt processing itself.
> > > > 
> > > > > > this patch serializes them on a spinlock.
> > > > > > 
> > > > > Those could then pile up on the newly introduced spinlock.
> > > > > 
> > > > > Regards,
> > > > > Halil
> > > > Hmm yea ... not good.
> > > Is there any other way to synchronize with all callbacks?
> > 
> > 
> > Maybe using rwlock as airq handler?
> > 
> > Thanks
> > 
> 
> rwlock is still a shared cacheline bouncing between CPUs and
> a bunch of ordering instructions.
> Maybe something per-cpu + some IPIs to run things on all CPUs instead?

... and I think classic and device interrupts are different enough
here ...

> > > 
> > > > -- 
> > > > MST

