Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20F35AFE6B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiIGIDa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Sep 2022 04:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiIGIDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:03:06 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDE9AA3E5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:02:46 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-214-KBGl940hPP6SS3ocEhJz7A-1; Wed, 07 Sep 2022 09:02:44 +0100
X-MC-Unique: KBGl940hPP6SS3ocEhJz7A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 7 Sep
 2022 09:02:42 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Wed, 7 Sep 2022 09:02:42 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Yury Norov <yury.norov@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Valentin Schneider" <vschneid@redhat.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Subject: RE: [PATCH v2 1/5] smp: don't declare nr_cpu_ids if NR_CPUS == 1
Thread-Topic: [PATCH v2 1/5] smp: don't declare nr_cpu_ids if NR_CPUS == 1
Thread-Index: AQHYwgUQ3MtxNG+XS02hQI5PBTGTbq3TmwJA
Date:   Wed, 7 Sep 2022 08:02:42 +0000
Message-ID: <61fb5bada0be421abddc871908f8a3dd@AcuMS.aculab.com>
References: <20220905230820.3295223-1-yury.norov@gmail.com>
 <20220905230820.3295223-2-yury.norov@gmail.com>
 <YxcKoaVGD+sTBjjG@hirez.programming.kicks-ass.net>
 <YxdT5w9Qd5SxK1wl@yury-laptop>
 <Yxda9/XP85D1sR39@hirez.programming.kicks-ass.net>
In-Reply-To: <Yxda9/XP85D1sR39@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra
> Sent: 06 September 2022 15:37
...
> It was suggested the other day we remove a whole bunch of SMP=n code and
> unconditionally use SMP code, even if its pointless on UP just to make
> the source simpler.

All the world isn't x86.

There are some small embedded systems which are definitely UP
and where you don't want any of the SMP 'bloat'.
Architectures like NiosII will only ever be SMP.

There certainly have recently been (and probably still are)
small ppc cpu for embedded systems that are UP.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

