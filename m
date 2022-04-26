Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A88D50EF50
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 05:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbiDZDlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 23:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiDZDlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 23:41:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1415BECCC3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 20:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650944288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WIQnceDnTPqWEyvR+jRAACxbLqJerOV/+jqpfvLm6RA=;
        b=MLWYRgiSfQia2PCtCy8qMwi/YcSDMGYoHSKy5rxuTbAVYFLxeVYPBfX6VJfmK2oSYyBOJ4
        9+0LynSTzVyqgr37Pur4GOLWd0GZmX29YNHvQJcTp7lJiW9HD4ZFUHNZgLkLwST+ReC3QP
        P0ncMw/LXcY2ESMnFLsZjyquLd5QmYo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-Y3eliJzMN_-VxwB05UYHxw-1; Mon, 25 Apr 2022 23:38:06 -0400
X-MC-Unique: Y3eliJzMN_-VxwB05UYHxw-1
Received: by mail-wm1-f71.google.com with SMTP id i131-20020a1c3b89000000b00392b57fbdaaso617943wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 20:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WIQnceDnTPqWEyvR+jRAACxbLqJerOV/+jqpfvLm6RA=;
        b=gaB5cjEvyDq3cqgRqRnsY2SEctd9zFyix6ujdpoIj1ay1wfGwbP8ty7Y7rOeHMizif
         qTRQ8AdACWln2mqHnlqw64NxCcEff/8Ktv7eLZmHn6gUQUwLsZER2xYfs2ua1rHIrtSf
         YPcM+bXMYGaEvdHe/pwwHJZqfpyZGTmV3tlyTxRpvGkBsyv0x/N9aJl/99g2CJOQTtVI
         W/srxK4xkkBpYxpJ+NhAAaS+KykQtJJe9syfkY18yi1b8TbRPAcuby6EDbUwsjt/KcRF
         VbdLrtJHZ2sxsplKVoXdn/FiuHLNN5/UIlf5SSBsmMkSJTal4FnKpvQBdtzLiVUWjTzr
         4dnQ==
X-Gm-Message-State: AOAM531vAN9Xtt3kC7mY4lRnRG3/9x4rELPd1vgT23Ww6Pt+eOmFrYKa
        SbEFUUWPc0P2iAxUN2TnnHH+LHYxqWNmQA4z3ZMwzD3odGr+TLhEpkILib0B9XXLTtb0PPtKObe
        o2pZ7WtJhm96P9C0av8H9VLtn
X-Received: by 2002:a5d:6102:0:b0:20a:db89:724f with SMTP id v2-20020a5d6102000000b0020adb89724fmr6294043wrt.59.1650944285456;
        Mon, 25 Apr 2022 20:38:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDl85Otu4KZcKjc/hiNLN0xYTp11xKMZiuuo8GOT13qx2bgBE3K0mDwMLh4XIvvLqvOuFVPA==
X-Received: by 2002:a5d:6102:0:b0:20a:db89:724f with SMTP id v2-20020a5d6102000000b0020adb89724fmr6294031wrt.59.1650944285222;
        Mon, 25 Apr 2022 20:38:05 -0700 (PDT)
Received: from redhat.com ([2.53.22.137])
        by smtp.gmail.com with ESMTPSA id p3-20020a5d59a3000000b0020a83f00487sm14093629wrr.9.2022.04.25.20.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 20:38:04 -0700 (PDT)
Date:   Mon, 25 Apr 2022 23:38:00 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        eperezma@redhat.com, lulu@redhat.com, tglx@linutronix.de,
        peterz@infradead.org, paulmck@kernel.org, maz@kernel.org
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220425233604-mutt-send-email-mst@kernel.org>
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-7-jasowang@redhat.com>
 <20220425040512-mutt-send-email-mst@kernel.org>
 <87a6c98rwf.fsf@redhat.com>
 <20220425095742-mutt-send-email-mst@kernel.org>
 <20220426042911.544477f9.pasic@linux.ibm.com>
 <20220425233434-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425233434-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 11:35:41PM -0400, Michael S. Tsirkin wrote:
> On Tue, Apr 26, 2022 at 04:29:11AM +0200, Halil Pasic wrote:
> > On Mon, 25 Apr 2022 09:59:55 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > On Mon, Apr 25, 2022 at 10:54:24AM +0200, Cornelia Huck wrote:
> > > > On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > >   
> > > > > On Mon, Apr 25, 2022 at 10:44:15AM +0800, Jason Wang wrote:  
> > > > >> This patch tries to implement the synchronize_cbs() for ccw. For the
> > > > >> vring_interrupt() that is called via virtio_airq_handler(), the
> > > > >> synchronization is simply done via the airq_info's lock. For the
> > > > >> vring_interrupt() that is called via virtio_ccw_int_handler(), a per
> > > > >> device spinlock for irq is introduced ans used in the synchronization
> > > > >> method.
> > > > >> 
> > > > >> Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > >> Cc: Peter Zijlstra <peterz@infradead.org>
> > > > >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > >> Cc: Marc Zyngier <maz@kernel.org>
> > > > >> Cc: Halil Pasic <pasic@linux.ibm.com>
> > > > >> Cc: Cornelia Huck <cohuck@redhat.com>
> > > > >> Signed-off-by: Jason Wang <jasowang@redhat.com>  
> > > > >
> > > > >
> > > > > This is the only one that is giving me pause. Halil, Cornelia,
> > > > > should we be concerned about the performance impact here?
> > > > > Any chance it can be tested?  
> > > > 
> > > > We can have a bunch of devices using the same airq structure, and the
> > > > sync cb creates a choke point, same as registering/unregistering.  
> > > 
> > > BTW can callbacks for multiple VQs run on multiple CPUs at the moment?
> > 
> > I'm not sure I understand the question.
> > 
> > I do think we can have multiple CPUs that are executing some portion of
> > virtio_ccw_int_handler(). So I guess the answer is yes. Connie what do you think?
> > 
> > On the other hand we could also end up serializing synchronize_cbs()
> > calls for different devices if they happen to use the same airq_info. But
> > this probably was not your question
> 
> 
> I am less concerned about  synchronize_cbs being slow and more about
> the slowdown in interrupt processing itself.
> 
> > > this patch serializes them on a spinlock.
> > >
> > 
> > Those could then pile up on the newly introduced spinlock.
> > 
> > Regards,
> > Halil
> 
> Hmm yea ... not good.

Is there any other way to synchronize with all callbacks?

> -- 
> MST

