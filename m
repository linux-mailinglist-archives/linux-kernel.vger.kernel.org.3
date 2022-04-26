Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAAA50EF4A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 05:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243387AbiDZDjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 23:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243368AbiDZDiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 23:38:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A2EC3A189
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 20:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650944144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LOGur+nJHD6EjUHWFTErPA0LCESsEHkIqwkzyPulrMU=;
        b=XZpXwA5mA2Z4ZKdOPox9TECORwK4ba66cnQ/z7n38VkQiJ3LB42ZYdw53qKnHb2OYNTL2i
        tx/+vWQn4vRVdGd2heDjq+eTeWwrjetnmtp9SvC55Bv2bC1Ya/DDxvTwtb0CKwdYDhUceG
        KnGnf9nu6JQYjb+N7y6cIbmUZ/nkxuk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-102-W8xFAX-KNKq6YwIvxZQ7Zw-1; Mon, 25 Apr 2022 23:35:43 -0400
X-MC-Unique: W8xFAX-KNKq6YwIvxZQ7Zw-1
Received: by mail-wm1-f70.google.com with SMTP id v184-20020a1cacc1000000b00393e492a398so587832wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 20:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LOGur+nJHD6EjUHWFTErPA0LCESsEHkIqwkzyPulrMU=;
        b=jmacc7xyXptcuxj2pigQ10P+Np3c4ytaXhZAEMlVEU7Fu10Tp5+ewe0b3PBaF4U4zi
         4e0GDDMKk1v6uzS+LZdn21QTrQ6+B3bRkVpuM2qn3HA1n/6/JUbC+5C0OkFUmqCtLZNO
         +Q6VIKFireXk2U1Wb+0aID0cPGxl4lLgmV+0KiQsYWATMAjc5RxA+cOeWiulLvVa0xVx
         2noXLCs+I2+32ORRS+Lh83kiCDyNaxyMMvE2G0Qg8mnjyfpgJrbXwaG4bVw2wVy7IrrS
         IfV4Hc3tlccuxXKVt/PaHN11B5sRUv4dZcWjrUnWYB6AZTD4UtMOReHF5RTck9jQT824
         zoKQ==
X-Gm-Message-State: AOAM531qyO6XnR744y533kYAsAAkQEIZcmfHUbs3q+/frJj7WrYzovtK
        eXHxnro2Yo9VNuz4+2k9jdX1t9sPAdq3nAwzrGZvaMheL6/WXyyYog75HExH+ljjAV7iTa9dGqZ
        ulFivNjkRwRBNVGsbyE9upLks
X-Received: by 2002:a5d:6c6d:0:b0:20a:7614:bf77 with SMTP id r13-20020a5d6c6d000000b0020a7614bf77mr16739333wrz.662.1650944141898;
        Mon, 25 Apr 2022 20:35:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZLhLLaBSBNqef4UimQMgT4T8pjJMB2WmmpL3yCGfLiaW0wOyEqnTow6jGq31l8CkKDMmJvg==
X-Received: by 2002:a5d:6c6d:0:b0:20a:7614:bf77 with SMTP id r13-20020a5d6c6d000000b0020a7614bf77mr16739322wrz.662.1650944141728;
        Mon, 25 Apr 2022 20:35:41 -0700 (PDT)
Received: from redhat.com ([2.53.22.137])
        by smtp.gmail.com with ESMTPSA id l3-20020a05600002a300b0020aad7fd63bsm12013398wry.61.2022.04.25.20.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 20:35:41 -0700 (PDT)
Date:   Mon, 25 Apr 2022 23:35:37 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        eperezma@redhat.com, lulu@redhat.com, tglx@linutronix.de,
        peterz@infradead.org, paulmck@kernel.org, maz@kernel.org
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220425233434-mutt-send-email-mst@kernel.org>
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-7-jasowang@redhat.com>
 <20220425040512-mutt-send-email-mst@kernel.org>
 <87a6c98rwf.fsf@redhat.com>
 <20220425095742-mutt-send-email-mst@kernel.org>
 <20220426042911.544477f9.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426042911.544477f9.pasic@linux.ibm.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 04:29:11AM +0200, Halil Pasic wrote:
> On Mon, 25 Apr 2022 09:59:55 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Apr 25, 2022 at 10:54:24AM +0200, Cornelia Huck wrote:
> > > On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >   
> > > > On Mon, Apr 25, 2022 at 10:44:15AM +0800, Jason Wang wrote:  
> > > >> This patch tries to implement the synchronize_cbs() for ccw. For the
> > > >> vring_interrupt() that is called via virtio_airq_handler(), the
> > > >> synchronization is simply done via the airq_info's lock. For the
> > > >> vring_interrupt() that is called via virtio_ccw_int_handler(), a per
> > > >> device spinlock for irq is introduced ans used in the synchronization
> > > >> method.
> > > >> 
> > > >> Cc: Thomas Gleixner <tglx@linutronix.de>
> > > >> Cc: Peter Zijlstra <peterz@infradead.org>
> > > >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > >> Cc: Marc Zyngier <maz@kernel.org>
> > > >> Cc: Halil Pasic <pasic@linux.ibm.com>
> > > >> Cc: Cornelia Huck <cohuck@redhat.com>
> > > >> Signed-off-by: Jason Wang <jasowang@redhat.com>  
> > > >
> > > >
> > > > This is the only one that is giving me pause. Halil, Cornelia,
> > > > should we be concerned about the performance impact here?
> > > > Any chance it can be tested?  
> > > 
> > > We can have a bunch of devices using the same airq structure, and the
> > > sync cb creates a choke point, same as registering/unregistering.  
> > 
> > BTW can callbacks for multiple VQs run on multiple CPUs at the moment?
> 
> I'm not sure I understand the question.
> 
> I do think we can have multiple CPUs that are executing some portion of
> virtio_ccw_int_handler(). So I guess the answer is yes. Connie what do you think?
> 
> On the other hand we could also end up serializing synchronize_cbs()
> calls for different devices if they happen to use the same airq_info. But
> this probably was not your question


I am less concerned about  synchronize_cbs being slow and more about
the slowdown in interrupt processing itself.

> > this patch serializes them on a spinlock.
> >
> 
> Those could then pile up on the newly introduced spinlock.
> 
> Regards,
> Halil

Hmm yea ... not good.

-- 
MST

