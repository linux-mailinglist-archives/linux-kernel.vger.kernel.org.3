Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71634FED34
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 04:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiDMC4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 22:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbiDMC4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 22:56:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A89150B08
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 19:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649818438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aypMv+ZPgdsPLn658L1nF7+IyBlpmCG4qqxgdXjWqDg=;
        b=Zjgb7V64raset1JteXXgw72x6fWXGwXsk9G0VO8hLWd8OpHNWN2HjpfOov09eJ+iV+4RS6
        UszvSEQFzKOWj3iR5Tk5RUY7MqxDb76MbkZq4f+RPDUwC9GB8v/akpuERDw8eJdeDVc5SH
        DnPH7u6km0RUDIQ5O/RoIzDRxedkzvY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-gZghLop7M5uBzUuQF4yfVQ-1; Tue, 12 Apr 2022 22:53:56 -0400
X-MC-Unique: gZghLop7M5uBzUuQF4yfVQ-1
Received: by mail-lf1-f72.google.com with SMTP id c40-20020a05651223a800b0046b94b75eaaso309061lfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 19:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aypMv+ZPgdsPLn658L1nF7+IyBlpmCG4qqxgdXjWqDg=;
        b=6yaZe0hgWoYPtBzueO34ydnDv0JXYDn6cuJd/GYL4yftq1QJz6Nh2klSjXI+un6ocJ
         pfSzhuf/slqN38bs06kyJbogFo6U+oovzRd5SGqsTmMK4NFLRzIJ0fhE7MXwKsioXR1Z
         bbCVLPSFdnSVzjClvm3ANr2wa6fxAYYXyPjsI3OUpyiokAx2MIIbKJ5Fg+AH4H/yuIFs
         EH47+pX319emfjrekWtsm0deoeDhWRhuozi2H3xRWyVZBpvqCdllKDrXPvsLErMoWrbK
         QAKz7A2CAmARVoUStk5OHfJoKQLRXV1foVjO6ouR1PkkWfTWzeCmDiN+E7ERfQnAle9X
         R2Gw==
X-Gm-Message-State: AOAM531EwBi5TzjDzgWtt95ikgWUhwslsrQqaTRn5E2nSKMZQEfzot2N
        2Mq2oqcLy0rENU3Au2+OlCLtHtZGWLzC8brvwi9gn3br4sjPqMIF0jyu2MEnSMnl/XTpUuqFsTb
        Ghqllz8votCI8uBRUZCDKgy0e0iQogT4wdnnNod2u
X-Received: by 2002:ac2:4189:0:b0:448:bc2b:e762 with SMTP id z9-20020ac24189000000b00448bc2be762mr27125048lfh.471.1649818435285;
        Tue, 12 Apr 2022 19:53:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3EpYX8EMZCFcND8kfaSkNRCake24Uu+62MAReL2MCHl6d5nFXjeR2zS/5extqCEfll6a/nkHj7E7qob8q+wQ=
X-Received: by 2002:ac2:4189:0:b0:448:bc2b:e762 with SMTP id
 z9-20020ac24189000000b00448bc2be762mr27125029lfh.471.1649818435001; Tue, 12
 Apr 2022 19:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220406083538.16274-1-jasowang@redhat.com> <20220406083538.16274-5-jasowang@redhat.com>
 <20220406075952-mutt-send-email-mst@kernel.org> <87wng2e527.fsf@redhat.com>
 <20220408150307.24b6b99f.pasic@linux.ibm.com> <20220410034556-mutt-send-email-mst@kernel.org>
 <CACGkMEtarZb6g3ij5=+As17+d9jtdAqNa1EzSuTXc7Pq_som0Q@mail.gmail.com>
 <877d7vbspu.fsf@redhat.com> <20220412020145.32e26e5a.pasic@linux.ibm.com> <87r1629rio.fsf@redhat.com>
In-Reply-To: <87r1629rio.fsf@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 13 Apr 2022 10:53:43 +0800
Message-ID: <CACGkMEuUXAUK-8GnBWgij5TOSN0ct_gmxnDQEcovRmTLK6bv4w@mail.gmail.com>
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 12:49 AM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Tue, Apr 12 2022, Halil Pasic <pasic@linux.ibm.com> wrote:
>
> > On Mon, 11 Apr 2022 16:27:41 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
>
> >> My main concern is that we would need to synchronize against a single
> >> interrupt that covers all kinds of I/O interrupts, not just a single
> >> device...
> >>
> >
> > Could we synchronize on struct airq_info's lock member? If we were
> > to grab all of these that might be involved...
>
> Hm, that could possibly narrow the sync down to a subset, which seems
> better. For devices still using classic interrupts, per-device sync
> would be easy.
>
> >
> > AFAIU for the synchronize implementation we need a lock or a set of locks
> > that contain all the possible vring_interrupt() calls with the queuues
> > that belong to the given device as a critical section. That way, one
> > has the acquire's and release's in place so that the vrign_interrupt()
> > either guaranteed to finish before the change of driver_ready is
> > guaranteed to be complete, or it is guaranteed to see the change.
> >
> > In any case, I guess we should first get clear on the first part. I.e.
> > when do we want to allow host->guest notifications.
>
> Also, whether we just care about vring interrupts, or general device
> interrupts (not sure if a config change interrupt may also trigger
> things we do not want to trigger?)

I think only vring interrupts, since the config interrupt hardening is
done via 22b7050a024d7 ("virtio: defer config changed notifications")

Thanks

>

