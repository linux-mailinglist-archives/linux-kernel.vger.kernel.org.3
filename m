Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7544FB8C4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344954AbiDKKAC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Apr 2022 06:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344944AbiDKJ77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:59:59 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79D3641621
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:57:45 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-60-NdxDbdFkOjqgxG8xxJVvzQ-1; Mon, 11 Apr 2022 10:57:42 +0100
X-MC-Unique: NdxDbdFkOjqgxG8xxJVvzQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Mon, 11 Apr 2022 10:57:39 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Mon, 11 Apr 2022 10:57:39 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>
CC:     'Qais Yousef' <qais.yousef@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "parth@linux.ibm.com" <parth@linux.ibm.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "pkondeti@codeaurora.org" <pkondeti@codeaurora.org>,
        "Valentin.Schneider@arm.com" <Valentin.Schneider@arm.com>,
        "patrick.bellasi@matbug.net" <patrick.bellasi@matbug.net>,
        "pjt@google.com" <pjt@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "tj@kernel.org" <tj@kernel.org>,
        "qperret@google.com" <qperret@google.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        Wei Wang <wvw@google.com>
Subject: RE: Scheduling tasks on idle cpu
Thread-Topic: Scheduling tasks on idle cpu
Thread-Index: AdhNfEgLjonPVH3ESQeb3O9OCn/HMQAAZaqAAAMHdiA=
Date:   Mon, 11 Apr 2022 09:57:39 +0000
Message-ID: <d95654bac3244397bf4aae581f35834a@AcuMS.aculab.com>
References: <030aacb0c1304e43ab917924dcf4f138@AcuMS.aculab.com>
 <20220411052641.5370437f@rorschach.local.home>
In-Reply-To: <20220411052641.5370437f@rorschach.local.home>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt
> Sent: 11 April 2022 10:27
> 
> On Mon, 11 Apr 2022 08:26:33 +0000
> David Laight <David.Laight@ACULAB.COM> wrote:
> 
> > Does that actually happen?
> > I've seen the following:
> >   34533 [017]: sys_futex(uaddr: 1049104, op: 85, val: 1, utime: 1, uaddr2: 1049100, val3: 4000001)
> >   34533 [017]: sched_migrate_task: pid=34512 prio=120 orig_cpu=14 dest_cpu=17
> >   34533 [017]: sched_wakeup: pid=34512 prio=120 success=1 target_cpu=017
> > and pid 34512 doesn't get scheduled until pid 34533 finally sleeps.
> > This is in spite of there being 5 idle cpu.
> 
> What's the topology? I believe the scheduler will refrain from
> migrating tasks to idle CPUs that are on other NUMA nodes as much as
> possible. Were those other 5 idle CPUs on another node?

There are two physical cpu with 20 cores each (with hyperthreading).
16, 18, 34, 36 and 38 were idle.
So both 16 and 18 should be on the same NUMA node.
All the others are running the same RT thread code.

	David

> 
> -- Steve
> 
> 
> > cpu 14 is busy running a RT thread, but migrating to cpu 17 seems wrong.
> >
> > This is on a RHEL7 kernel, I've not replicated it on anything recent.
> > But I've very much like a RT thread to be able to schedule a non-RT
> > thread to run on an idle cpu.

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

