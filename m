Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397035286EB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237054AbiEPOZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiEPOZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:25:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E75133B017
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 07:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652711113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NRq6KGsNxCSeCY6JCFk9olYgNVlaBKaEOFZvjnnTK1U=;
        b=XK73I8G4aUZi3v0B8XPjG6J/HNnGpwdCsask0nj5M7NJYNtQaYTcGwrkwjfzdSloRiTVUV
        L5Cl5T9K83AkCy9BGWcZt6yiZTGJxEIT431jm3X7DD8X86EoYtHenKujIfi2l5MSauJ/kg
        R7LcMxYJaYbY1mQbBK9CRsGQVytygiQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-4bR05ZlXMsauNWq3tYpE0A-1; Mon, 16 May 2022 10:25:09 -0400
X-MC-Unique: 4bR05ZlXMsauNWq3tYpE0A-1
Received: by mail-ed1-f70.google.com with SMTP id w5-20020a056402128500b0042aa2647eb6so3421143edv.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 07:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NRq6KGsNxCSeCY6JCFk9olYgNVlaBKaEOFZvjnnTK1U=;
        b=JV8vA0lNW38lPLk4icfe6+alk1jiYTCV3UoDn9iQLE9zNt1Ni1vptV+dvzO0xtFNgT
         O7mUvK+tK9/m50JD3xRRRmNHNLgPoauNymxXGMtldc7Y1OKVop8BZywiPRuUUPS2bt0r
         aS5depVKMfW3uGxr5/8TrG6rwoevm6eOyJmtHC5awbU+Idlm+Y55eRHQwLtUuYGsd2KC
         ywZd9rzzWe70ATqqS7fXNdBLlsZdbz2M3KeK1gqVOhpZ3I5eq+bK5uljS01NfcZ6JamP
         ttFQJqWhLAcqmdtXHXRVMin4+LPqz15+BYGuO+xegfiMXwcpEsngYyMVvMIgjY3HfsDR
         LN8A==
X-Gm-Message-State: AOAM532x/qKLbUvGPUzWqOcMX6BwDGOhyTOjVuUVQERdaRB5pgSGDeEz
        RtfvK6QFZkx+bT05SpUNzD19fOd7/mK/mHZhLdHzzKdht2SF4sLInqL8zgBtaaTBxdVjewvvi0L
        4mb36brOFuf7+EVz0t/hwWJBW
X-Received: by 2002:a17:906:99c4:b0:6f4:56d2:4bbd with SMTP id s4-20020a17090699c400b006f456d24bbdmr15954521ejn.754.1652711108642;
        Mon, 16 May 2022 07:25:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJye6mqKhXV1EBhqjD51FQ3FfI+pLSVF1VgsllzZALr294dHvcZwWeRpUm7YaMfxxw1HWuVGpg==
X-Received: by 2002:a17:906:99c4:b0:6f4:56d2:4bbd with SMTP id s4-20020a17090699c400b006f456d24bbdmr15954503ejn.754.1652711108454;
        Mon, 16 May 2022 07:25:08 -0700 (PDT)
Received: from redhat.com ([2.55.141.66])
        by smtp.gmail.com with ESMTPSA id gz21-20020a170907a05500b006f4512e7bc8sm3773846ejc.60.2022.05.16.07.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 07:25:07 -0700 (PDT)
Date:   Mon, 16 May 2022 10:25:01 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>, eperezma <eperezma@redhat.com>,
        Cindy Lu <lulu@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH V4 0/9] rework on the IRQ hardening of virtio
Message-ID: <20220516102425-mutt-send-email-mst@kernel.org>
References: <20220507071954.14455-1-jasowang@redhat.com>
 <875ymd3fd1.fsf@redhat.com>
 <CACGkMEvfkUpsY4LRTuH7w18DZdq+w3=Ef6b-0sG0XvzVUVKdzg@mail.gmail.com>
 <20220511160147.46cbf2fb.pasic@linux.ibm.com>
 <CACGkMEtaN6tZrwp3rsxu4Hn1Rev2P06X3BaR4X1cqDxnRdPCKg@mail.gmail.com>
 <20220516132006.29d28fbe.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516132006.29d28fbe.pasic@linux.ibm.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 01:20:06PM +0200, Halil Pasic wrote:
> On Thu, 12 May 2022 11:31:08 +0800
> Jason Wang <jasowang@redhat.com> wrote:
> 
> > > > It looks to me we need to use write_lock_irq()/write_unlock_irq() to
> > > > do the synchronization.
> > > >
> > > > And we probably need to keep the
> > > > read_lock_irqsave()/read_lock_irqrestore() logic since I can see the
> > > > virtio_ccw_int_handler() to be called from process context (e.g from
> > > > the io_subchannel_quiesce()).
> > > >  
> > >
> > > Sounds correct.  
> > 
> > As Cornelia and Vineeth pointed out, all the paths the vring_interrupt
> > is called with irq disabled.
> > 
> > So I will use spin_lock()/spin_unlock() in the next version.
> 
> Can we do some sort of an assertion that if the kernel is built with
> the corresponding debug features will make sure this assumption holds
> (and warn if it does not)? That assertion would also document the fact.

Lockdep will do this automatically if you get it wrong, just like it
did here.

> If an assertion is not possible, I think we should at least place a
> strategic comment that documents our assumption.

That can't hurt.

> Regards,
> Halil
> 
> > 
> > Thanks

