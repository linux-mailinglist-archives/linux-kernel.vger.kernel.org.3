Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7BD512D39
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245633AbiD1Hpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245623AbiD1Hph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:45:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED123220CB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651131743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ma9q9NfHZgQzwDwsNAsEAp8GMR2Aw0rkaNjfoUxgzjA=;
        b=bbnUx8vCLxZavRb8dh9qpexUYtFNKzlqF/mJwPEAvuoUA3XCHKlit4xPwiN3JdlILInwkp
        NoFuIpMmJpOFVZBmP7E5D0ymLuUwju+/htBaWA5LIUdfnQWSx+HSRrqDO9gYnxQdabIHtQ
        9fhOybV0rcu9xltDCKe8JI+WL2TkxRM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-313-A4wupFJ8M4u7aoDXIuCY9w-1; Thu, 28 Apr 2022 03:42:19 -0400
X-MC-Unique: A4wupFJ8M4u7aoDXIuCY9w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48213185A7BA;
        Thu, 28 Apr 2022 07:42:19 +0000 (UTC)
Received: from localhost (unknown [10.39.193.199])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EF41341136EF;
        Thu, 28 Apr 2022 07:42:18 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
In-Reply-To: <CACGkMEutdd=9c-2h5ijMkgUzEqNPtUCXAum7bm8W7a6m62i_Mg@mail.gmail.com>
Organization: Red Hat GmbH
References: <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org>
 <20220425235415-mutt-send-email-mst@kernel.org>
 <87o80n7soq.fsf@redhat.com>
 <20220426124243-mutt-send-email-mst@kernel.org>
 <87ilqu7u6w.fsf@redhat.com> <20220428044315.3945e660.pasic@linux.ibm.com>
 <CACGkMEudDf=XXhV2tV+xZ586AnDyrQEotGAiSQZ4k1CTAWHZJQ@mail.gmail.com>
 <20220428012156-mutt-send-email-mst@kernel.org>
 <CACGkMEsd+WHp=LN0BnnDKfzv+nbS2hjgVC-tdemZWuPTc60HBQ@mail.gmail.com>
 <20220428015318-mutt-send-email-mst@kernel.org>
 <CACGkMEutdd=9c-2h5ijMkgUzEqNPtUCXAum7bm8W7a6m62i_Mg@mail.gmail.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Thu, 28 Apr 2022 09:42:17 +0200
Message-ID: <87zgk5lkme.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28 2022, Jason Wang <jasowang@redhat.com> wrote:

> On Thu, Apr 28, 2022 at 1:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Thu, Apr 28, 2022 at 01:51:59PM +0800, Jason Wang wrote:
>> > On Thu, Apr 28, 2022 at 1:24 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>> > >
>> > > On Thu, Apr 28, 2022 at 11:04:41AM +0800, Jason Wang wrote:
>> > > > > But my guess is that rwlock + some testing for the legacy indicator case
>> > > > > just to double check if there is a heavy regression despite of our
>> > > > > expectations to see none should do the trick.
>> > > >
>> > > > I suggest this, rwlock (for not airq) seems better than spinlock, but
>> > > > at worst case it will cause cache line bouncing. But I wonder if it's
>> > > > noticeable (anyhow it has been used for airq).
>> > > >
>> > > > Thanks
>> > >
>> > > Which existing rwlock does airq use right now? Can we take it to sync?
>> >
>> > It's the rwlock in airq_info, it has already been used in this patch.
>> >
>> >                 write_lock(&info->lock);
>> >                 write_unlock(&info->lock);
>> >
>> > But the problem is, it looks to me there could be a case that airq is
>> > not used, (virtio_ccw_int_hander()). That's why the patch use a
>> > spinlock, it could be optimized with using a rwlock as well.
>> >
>> > Thanks
>>
>> Ah, right. So let's take that on the legacy path too and Halil promises
>> to test to make sure performance isn't impacted too badly?
>
> I think what you meant is using a dedicated rwlock instead of trying
> to reuse one of the airq_info locks.
>
> If this is true, it should be fine.

FWIW, that approach makes sense to me as well.

