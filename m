Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7485047E6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 15:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbiDQN3o convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 17 Apr 2022 09:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbiDQN3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 09:29:42 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C53842DD
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 06:27:06 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-170-nF3cRDBxPKCZQGK-HhuPow-1; Sun, 17 Apr 2022 14:27:03 +0100
X-MC-Unique: nF3cRDBxPKCZQGK-HhuPow-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Sun, 17 Apr 2022 14:27:00 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Sun, 17 Apr 2022 14:27:00 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Christophe de Dinechin <dinechin@redhat.com>
CC:     "trivial@kernel.org" <trivial@kernel.org>,
        Ben Segall <bsegall@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Ingo Molnar" <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        "Juri Lelli" <juri.lelli@redhat.com>
Subject: RE: [PATCH 1/3] sched/headers: Fix compilation error with GCC 12
Thread-Topic: [PATCH 1/3] sched/headers: Fix compilation error with GCC 12
Thread-Index: AQHYUBibLip3vnTtMkGRChiOLjIGKKz0GpLA
Date:   Sun, 17 Apr 2022 13:27:00 +0000
Message-ID: <13a0f55340174900b36caa90920d942a@AcuMS.aculab.com>
References: <20220414150855.2407137-1-dinechin@redhat.com>
 <20220414150855.2407137-2-dinechin@redhat.com>
 <Ylg73c83AJGwz9UN@hirez.programming.kicks-ass.net>
In-Reply-To: <Ylg73c83AJGwz9UN@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra
> Sent: 14 April 2022 16:21
...
> <snip tons of noise>
> 
..
> > -#define sched_class_highest (__end_sched_classes - 1)
> > +/*
> > + * sched_class_highests is really __end_sched_classes - 1, but written in a way
> > + * that makes it clear that it is within __begin_sched_classes[] and not outside
> > + * of __end_sched_classes[].
> > + */
> > +#define sched_class_highest (__begin_sched_classes + \
> > +			     (__end_sched_classes - __begin_sched_classes - 1))
> >  #define sched_class_lowest  (__begin_sched_classes - 1)
> >
> > +/* The + 1 below places the pointers within the range of their array */
> >  #define for_class_range(class, _from, _to) \
> > -	for (class = (_from); class != (_to); class--)
> > +	for (class = (_from); class + 1 != (_to) + 1; class--)

That is still technically broken because you are still calculating
the address of array[-1] - even though it is probably optimised out.

> Urgh, so now we get less readable code, just because GCC is being
> stupid?
> 
> What's wrong with negative array indexes? memory is memory, stuff works.

Consider segmented x86 where malloc() always returns {segment:0..segment:size).
Pointer arithmetic will only change the offset.
So &array[-1] is likely to be greater than &array[0].
So it has never been valid C to create pointers to before a data item.

OTOH I've NFI why gcc and clang have started generating warnings for
portability issues that really don't affect mainstream systems.

I'm just waiting for them to warn about memset(p, 0 sizeof *p) when
the structure contains pointers - because the NULL pointer doesn't
have to be the all-zero bit pattern.
The only reason (int)&(struct foo *)0->member is non-portable is because
NULL might not be 0.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

