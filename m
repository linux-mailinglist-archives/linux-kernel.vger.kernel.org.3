Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC3650EF91
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 06:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243920AbiDZELM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 00:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243880AbiDZELC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 00:11:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71D98167EB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 21:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650946074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AuGMiVQ54UHeSvg8sdwlcgbUOg1bzj5/F3tz+KJ+Q24=;
        b=E81ve1K6nSzXW0qyCp9KTTqaKVQl0gUrDeKWHWVc7nJebgr4G4ggRFtUM+P61cv7i7m19n
        aqWYQ0qg0IIJ3jdrnWkBU2PpG6MuyFbzVkhIYJYInMqbbdiOQwkvFCwafQBfx9h88yVRn3
        yZ37nUsNxlG2dqp001b+4QStDpfB2Tg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-509-83D199Z8P8e1XelT_xdyTw-1; Tue, 26 Apr 2022 00:07:53 -0400
X-MC-Unique: 83D199Z8P8e1XelT_xdyTw-1
Received: by mail-lj1-f197.google.com with SMTP id u19-20020a2e8553000000b0024f222a942aso42244ljj.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 21:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AuGMiVQ54UHeSvg8sdwlcgbUOg1bzj5/F3tz+KJ+Q24=;
        b=ji8Jl4veWDt5LFau8VD9+Fur2KGzBD3OL1DpQN5IXd81ZW+4wu33y7Oh8WTEqJf6n4
         WcLrNFH3rhK9VTnie1IeMPEVGXGlY6bleJFuasJHdEDEhiQ3yeLr5QfDpX6WB657HPAT
         Hl1nQc//Slg/j3De5PYmNo7ktvqx42WY0C/UVEKHVC8W9sfXYGJdhDHFlC+Gi8EHelIz
         QQwhDUWx5jU8jbA2DpGmkb4GoH9JPvrDFtPDiyA6Ox5QjlNkiuN/mMKVpoOHz2kHoX0f
         fjbB7c2/UUJIK3kiUuQljgMeAEsW8SRJwvo+EWI7NMXHhMEY5UB/aSInu2i+16W1hyrM
         9ruw==
X-Gm-Message-State: AOAM531WlUZxqXZoB+k/6eapN7lDfQ7ND4ttcLdLS4IMsm8S2W/nqyH1
        SQwjmuFk+Vh4RYo+ZbRKEuFdVUrfy4a9ithO3dc84vwT7W+vd4WCSJN6jo+remiwyTLcN48xOai
        A+SrYZD3ppXBXd5hQnsYSntDOuh7FAcb6UVOOFECE
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id b1-20020a0565120b8100b00448b342513cmr15264136lfv.257.1650946071294;
        Mon, 25 Apr 2022 21:07:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8cMRgeJdLRR9nm75CnO2Nx0KqwdQSMGUUkDvsKw8o5celdKNAmeZb54EkxXEys10n8QzGyW2l09PAXlsiqFA=
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id
 b1-20020a0565120b8100b00448b342513cmr15264132lfv.257.1650946071111; Mon, 25
 Apr 2022 21:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220425024418.8415-1-jasowang@redhat.com> <20220425024418.8415-7-jasowang@redhat.com>
 <20220425040512-mutt-send-email-mst@kernel.org> <87a6c98rwf.fsf@redhat.com>
 <20220425095742-mutt-send-email-mst@kernel.org> <20220426042911.544477f9.pasic@linux.ibm.com>
 <20220425233434-mutt-send-email-mst@kernel.org> <20220425233604-mutt-send-email-mst@kernel.org>
 <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com> <20220425235134-mutt-send-email-mst@kernel.org>
 <20220425235415-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220425235415-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 26 Apr 2022 12:07:39 +0800
Message-ID: <CACGkMEve+3ugK-Kgao3_2wbjb=fbF7AO2uEuArGjKgEAQcGdiQ@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 11:55 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Apr 25, 2022 at 11:53:24PM -0400, Michael S. Tsirkin wrote:
> > On Tue, Apr 26, 2022 at 11:42:45AM +0800, Jason Wang wrote:
> > >
> > > =E5=9C=A8 2022/4/26 11:38, Michael S. Tsirkin =E5=86=99=E9=81=93:
> > > > On Mon, Apr 25, 2022 at 11:35:41PM -0400, Michael S. Tsirkin wrote:
> > > > > On Tue, Apr 26, 2022 at 04:29:11AM +0200, Halil Pasic wrote:
> > > > > > On Mon, 25 Apr 2022 09:59:55 -0400
> > > > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > >
> > > > > > > On Mon, Apr 25, 2022 at 10:54:24AM +0200, Cornelia Huck wrote=
:
> > > > > > > > On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat.com> =
wrote:
> > > > > > > > > On Mon, Apr 25, 2022 at 10:44:15AM +0800, Jason Wang wrot=
e:
> > > > > > > > > > This patch tries to implement the synchronize_cbs() for=
 ccw. For the
> > > > > > > > > > vring_interrupt() that is called via virtio_airq_handle=
r(), the
> > > > > > > > > > synchronization is simply done via the airq_info's lock=
. For the
> > > > > > > > > > vring_interrupt() that is called via virtio_ccw_int_han=
dler(), a per
> > > > > > > > > > device spinlock for irq is introduced ans used in the s=
ynchronization
> > > > > > > > > > method.
> > > > > > > > > >
> > > > > > > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > > > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > > > > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > > > > > > > Cc: Halil Pasic <pasic@linux.ibm.com>
> > > > > > > > > > Cc: Cornelia Huck <cohuck@redhat.com>
> > > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > >
> > > > > > > > > This is the only one that is giving me pause. Halil, Corn=
elia,
> > > > > > > > > should we be concerned about the performance impact here?
> > > > > > > > > Any chance it can be tested?
> > > > > > > > We can have a bunch of devices using the same airq structur=
e, and the
> > > > > > > > sync cb creates a choke point, same as registering/unregist=
ering.
> > > > > > > BTW can callbacks for multiple VQs run on multiple CPUs at th=
e moment?
> > > > > > I'm not sure I understand the question.
> > > > > >
> > > > > > I do think we can have multiple CPUs that are executing some po=
rtion of
> > > > > > virtio_ccw_int_handler(). So I guess the answer is yes. Connie =
what do you think?
> > > > > >
> > > > > > On the other hand we could also end up serializing synchronize_=
cbs()
> > > > > > calls for different devices if they happen to use the same airq=
_info. But
> > > > > > this probably was not your question
> > > > >
> > > > > I am less concerned about  synchronize_cbs being slow and more ab=
out
> > > > > the slowdown in interrupt processing itself.
> > > > >
> > > > > > > this patch serializes them on a spinlock.
> > > > > > >
> > > > > > Those could then pile up on the newly introduced spinlock.
> > > > > >
> > > > > > Regards,
> > > > > > Halil
> > > > > Hmm yea ... not good.
> > > > Is there any other way to synchronize with all callbacks?
> > >
> > >
> > > Maybe using rwlock as airq handler?
> > >
> > > Thanks
> > >
> >
> > rwlock is still a shared cacheline bouncing between CPUs and
> > a bunch of ordering instructions.

Yes, but it should be faster than spinlocks anyhow.

> > Maybe something per-cpu + some IPIs to run things on all CPUs instead?

Is this something like a customized version of synchronzie_rcu_expedited()?

>
> ... and I think classic and device interrupts are different enough
> here ...

Yes.

Thanks

>
> > > >
> > > > > --
> > > > > MST
>

