Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFE9525C2A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377682AbiEMHNh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 May 2022 03:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377749AbiEMHNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:13:22 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4662C2764D7
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 00:13:03 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-262-8Q2dzFlkPrWfG967RYkOmQ-1; Fri, 13 May 2022 08:13:00 +0100
X-MC-Unique: 8Q2dzFlkPrWfG967RYkOmQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Fri, 13 May 2022 08:12:58 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Fri, 13 May 2022 08:12:58 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Vincent Guittot' <vincent.guittot@linaro.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "parth@linux.ibm.com" <parth@linux.ibm.com>
CC:     "qais.yousef@arm.com" <qais.yousef@arm.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "patrick.bellasi@matbug.net" <patrick.bellasi@matbug.net>,
        "pjt@google.com" <pjt@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "tj@kernel.org" <tj@kernel.org>,
        "qperret@google.com" <qperret@google.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "joshdon@google.com" <joshdon@google.com>
Subject: RE: [PATCH v2 0/7]  Add latency_nice priority
Thread-Topic: [PATCH v2 0/7]  Add latency_nice priority
Thread-Index: AQHYZh5XK94BxNwzWEGhSwuL8QragK0cYdBQ
Date:   Fri, 13 May 2022 07:12:58 +0000
Message-ID: <86066641739c4897b0001153e598a261@AcuMS.aculab.com>
References: <20220512163534.2572-1-vincent.guittot@linaro.org>
In-Reply-To: <20220512163534.2572-1-vincent.guittot@linaro.org>
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Guittot
> Sent: 12 May 2022 17:35
> 
> This patchset restarts the work about adding a latency nice priority to
> describe the latency tolerance of cfs tasks.
> 
> The patches [1-4] have been done by Parth:
> https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com/
> 
> I have just rebased and moved the set of latency priority outside the
> priority update. I have removed the reviewed tag because the patches
> are 2 years old.
> 
> The patches [5-7] use latency nice priority to decide if a cfs task can
> preempt the current running task. Patch 5 gives some tests results with
> cyclictests and hackbench to highlight the benefit of latency nice
> priority for short interactive task or long intensive tasks.

I'd have thought the best way to reduce latency would be to look
harder for an idle cpu before trying to preempt the current task.

By far the worst case latency for a cfs task is waking it from an
rt task.
AFAICT the cpu selection algorithm is something like:
1) if the cpu it last ran on is idle, schedule it there.
2) if one of a small subset of cpu is idle run it there.
3) schedule on the current cpu after the rt thread exits.

Then there is the additional behaviour:
An rt thread (almost) always starts on the cpu it ran on last,
any running cfs thread is put on the q for that cpu.

This makes it very difficult to start a background cfs thread
from an active rt thread.
Quite often it won't migrate to an idle cpu until the timer
tick scheduler rebalance happens.

I think the search for an idle cpu is also limited when woken
by a cfs thread.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

