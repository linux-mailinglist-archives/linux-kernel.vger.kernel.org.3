Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A98F4EB333
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 20:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240435AbiC2SPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 14:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbiC2SPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 14:15:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329B439BB4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 11:14:01 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648577638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K56BsfoBgMn9W+rnuLsv0bm5grEALntNroa6Yc82KdQ=;
        b=ZunERedBvlyrIkmrxBOXq+SFQ8oPAJgIiSTJSupnoMy84lsSq8+Y2ithnhrH89ev3RuYLd
        on4YdUn5/atLStXdp46m8hsxV++A3QYBwbS5ZZ1u/pUbMcaUe08ao8nRJKuZruOCClE7/b
        s3wNIGzjDFF9ojCSNct1rQQ4GYfogIrQPuQ4dD+1WHoiI4MPyxvIwZjPR0cx8CDhUnNIcP
        +wiD1x8SnNtfwssRGq9F2ST0x1KxfN+vEp9aJfdnG828YtchAykyspeoOMkiZx7eQ9y6gG
        SbrRF1hqYi8kGkBiMcG39wlAxjJcQvbi0bu0GOFo/KIWqucqNk3/UqFn3zcutQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648577638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K56BsfoBgMn9W+rnuLsv0bm5grEALntNroa6Yc82KdQ=;
        b=aAtoPleLjBNdBeKI37H4sj56tIZfUR4WxK9DqSTju6swEfqZnVAHT4B/GXVkAxEykVGOB3
        gVyYaZS/2js+eTBg==
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Keir Fraser <keirf@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re:
In-Reply-To: <20220329100859-mutt-send-email-mst@kernel.org>
References: <Yj1hkpyUqJE9sQ2p@redhat.com>
 <CACGkMEunsuWhn+aB2dM7noU257M9JV6jDjkQXLyOA+GjEoz_iw@mail.gmail.com>
 <20220325050947-mutt-send-email-mst@kernel.org>
 <CACGkMEvioAVMmB+ab2xXB2YPECtwi1J55u8mRRk9-JAjFSZ8vg@mail.gmail.com>
 <20220325060659-mutt-send-email-mst@kernel.org>
 <CACGkMEu4mRfNbJXJtAFzhyd55fD7phUDKnVtYW0aqRnQmT_bYw@mail.gmail.com>
 <20220328015757-mutt-send-email-mst@kernel.org>
 <CACGkMEu+fax6YYwhfbc1yoSxv6o1FTQyrOheVTmUfqGvmbAEfA@mail.gmail.com>
 <20220328062452-mutt-send-email-mst@kernel.org> <87fsn1f96e.ffs@tglx>
 <20220329100859-mutt-send-email-mst@kernel.org>
Date:   Tue, 29 Mar 2022 20:13:57 +0200
Message-ID: <87v8vweie2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29 2022 at 10:37, Michael S. Tsirkin wrote:
> On Tue, Mar 29, 2022 at 10:35:21AM +0200, Thomas Gleixner wrote:
> We are trying to fix the driver since at the moment it does not
> have the dev->ok flag at all.
>
> And I suspect virtio is not alone in that.
> So it would have been nice if there was a standard flag
> replacing the driver-specific dev->ok above, and ideally
> would also handle the case of an interrupt triggering
> too early by deferring the interrupt until the flag is set.
>
> And in fact, it does kind of exist: IRQF_NO_AUTOEN, and you would call
> enable_irq instead of dev->ok = true, except
> - it doesn't work with affinity managed IRQs
> - it does not work with shared IRQs
>
> So using dev->ok as you propose above seems better at this point.

Unless there is a big enough amount of drivers which could make use of a
generic mechanism for that.

>> If any driver does this in the wrong order, then the driver is
>> broken.
> 
> I agree, however:
> $ git grep synchronize_irq `git grep -l request_irq drivers/net/`|wc -l
> 113
> $ git grep -l request_irq drivers/net/|wc -l
> 397
>
> I suspect there are more drivers which in theory need the
> synchronize_irq dance but in practice do not execute it.

That really depends on when the driver requests the interrupt, when
it actually enables the interrupt in the device itself and how the
interrupt service routine works.

So just doing that grep dance does not tell much. You really have to do
a case by case analysis.

Thanks,

        tglx

