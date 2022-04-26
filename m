Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454CB50EF6C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 05:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243590AbiDZD4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 23:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243538AbiDZD4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 23:56:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1396B127A60
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 20:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650945207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U56zSxUw/A+PjopBzCaVhOCjovFUkZ0LYAX7dUOgfDQ=;
        b=cFaXXfuzHkh1AgC8OZF/zBOr/T+2XsnumbC8bUMqfnCQJ/sMbaNMbnvKgz/p2pGixxdeKc
        mCx7L6JuUxJ11l4gIPvD5CN0ZMzWHrPlgkbnLAL4juFlTbS1tf9pl+K7mQyAV/a8/++z5Q
        +BSYiwlsI3MZxgawscg5G1qhZjISYlw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-__SLvj55M8yhna3cD5A0cA-1; Mon, 25 Apr 2022 23:53:25 -0400
X-MC-Unique: __SLvj55M8yhna3cD5A0cA-1
Received: by mail-wm1-f70.google.com with SMTP id d13-20020a05600c3acd00b0038ff865c043so610681wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 20:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=U56zSxUw/A+PjopBzCaVhOCjovFUkZ0LYAX7dUOgfDQ=;
        b=4pYcgAGGZnOktGhcAOMiYpmjdys49ZZeXRYZp56D7SS91pg7/Zq9bhMwW4vCAmfF06
         4cxPKe6F6vkYp6njs4I44b9T185FI16iilj2T9vxuvh78wgUEhEK2FlAYyOnLxcdjAMJ
         /ZqMge3Oy1mB+HzqwWq/2iyxd7papdMjwMukrEkKP454lYOQ18ltuggckI2Zs9YXDiM1
         MLCxosFgilOqu63lbdPZRhsz60byJE6AOJirvz71NZdUSQFzjvdByRibAS7VnGTUVrew
         5DVPaoL0L7MYUzLzgOp+stsq+8sdK0Wshvy7UdlI4hUJj18oNiX4zr6wNaxNsu0/NEmI
         JPZQ==
X-Gm-Message-State: AOAM533owy5wjlKer+OhdaXAGAciHV/+uB9vXBm9HbirKw+sOx+Xy+SE
        kJVbI/Sof6kQyzAcDrNlqA8BhEgbTvNlO4/FDK95ohe3EbwYwAxwYjVErjekF4Ab09JIxl5J9i6
        RSmznCfBwwJi4piqtjyEwr8yM
X-Received: by 2002:a05:600c:651:b0:381:3d7b:40e0 with SMTP id p17-20020a05600c065100b003813d7b40e0mr28427289wmm.17.1650945204341;
        Mon, 25 Apr 2022 20:53:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxofEkhZ9h2B7Wu29O8xUY779/GKPNSvhJI1vPU3mEtBK3l2xYcVadO+u++va5nxtAPdGEXXQ==
X-Received: by 2002:a05:600c:651:b0:381:3d7b:40e0 with SMTP id p17-20020a05600c065100b003813d7b40e0mr28427277wmm.17.1650945204148;
        Mon, 25 Apr 2022 20:53:24 -0700 (PDT)
Received: from redhat.com ([2.53.22.137])
        by smtp.gmail.com with ESMTPSA id bg20-20020a05600c3c9400b0037fa5c422c8sm13535917wmb.48.2022.04.25.20.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 20:53:23 -0700 (PDT)
Date:   Mon, 25 Apr 2022 23:53:19 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        eperezma@redhat.com, lulu@redhat.com, tglx@linutronix.de,
        peterz@infradead.org, paulmck@kernel.org, maz@kernel.org
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220425235134-mutt-send-email-mst@kernel.org>
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-7-jasowang@redhat.com>
 <20220425040512-mutt-send-email-mst@kernel.org>
 <87a6c98rwf.fsf@redhat.com>
 <20220425095742-mutt-send-email-mst@kernel.org>
 <20220426042911.544477f9.pasic@linux.ibm.com>
 <20220425233434-mutt-send-email-mst@kernel.org>
 <20220425233604-mutt-send-email-mst@kernel.org>
 <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 11:42:45AM +0800, Jason Wang wrote:
> 
> 在 2022/4/26 11:38, Michael S. Tsirkin 写道:
> > On Mon, Apr 25, 2022 at 11:35:41PM -0400, Michael S. Tsirkin wrote:
> > > On Tue, Apr 26, 2022 at 04:29:11AM +0200, Halil Pasic wrote:
> > > > On Mon, 25 Apr 2022 09:59:55 -0400
> > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > 
> > > > > On Mon, Apr 25, 2022 at 10:54:24AM +0200, Cornelia Huck wrote:
> > > > > > On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > > On Mon, Apr 25, 2022 at 10:44:15AM +0800, Jason Wang wrote:
> > > > > > > > This patch tries to implement the synchronize_cbs() for ccw. For the
> > > > > > > > vring_interrupt() that is called via virtio_airq_handler(), the
> > > > > > > > synchronization is simply done via the airq_info's lock. For the
> > > > > > > > vring_interrupt() that is called via virtio_ccw_int_handler(), a per
> > > > > > > > device spinlock for irq is introduced ans used in the synchronization
> > > > > > > > method.
> > > > > > > > 
> > > > > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > > > > > Cc: Halil Pasic <pasic@linux.ibm.com>
> > > > > > > > Cc: Cornelia Huck <cohuck@redhat.com>
> > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > 
> > > > > > > This is the only one that is giving me pause. Halil, Cornelia,
> > > > > > > should we be concerned about the performance impact here?
> > > > > > > Any chance it can be tested?
> > > > > > We can have a bunch of devices using the same airq structure, and the
> > > > > > sync cb creates a choke point, same as registering/unregistering.
> > > > > BTW can callbacks for multiple VQs run on multiple CPUs at the moment?
> > > > I'm not sure I understand the question.
> > > > 
> > > > I do think we can have multiple CPUs that are executing some portion of
> > > > virtio_ccw_int_handler(). So I guess the answer is yes. Connie what do you think?
> > > > 
> > > > On the other hand we could also end up serializing synchronize_cbs()
> > > > calls for different devices if they happen to use the same airq_info. But
> > > > this probably was not your question
> > > 
> > > I am less concerned about  synchronize_cbs being slow and more about
> > > the slowdown in interrupt processing itself.
> > > 
> > > > > this patch serializes them on a spinlock.
> > > > > 
> > > > Those could then pile up on the newly introduced spinlock.
> > > > 
> > > > Regards,
> > > > Halil
> > > Hmm yea ... not good.
> > Is there any other way to synchronize with all callbacks?
> 
> 
> Maybe using rwlock as airq handler?
> 
> Thanks
> 

rwlock is still a shared cacheline bouncing between CPUs and
a bunch of ordering instructions.
Maybe something per-cpu + some IPIs to run things on all CPUs instead?

> > 
> > > -- 
> > > MST

