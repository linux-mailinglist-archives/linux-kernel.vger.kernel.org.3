Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2015310F6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbiEWNTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235970AbiEWNTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:19:31 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0A7E1FA68
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:19:30 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-317-xygOjhI6PEOklHKxx9crOw-1; Mon, 23 May 2022 14:19:27 +0100
X-MC-Unique: xygOjhI6PEOklHKxx9crOw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Mon, 23 May 2022 14:19:26 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Mon, 23 May 2022 14:19:26 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Vincent Guittot' <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
CC:     Chris Hyser <chris.hyser@oracle.com>,
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
        "parth@linux.ibm.com" <parth@linux.ibm.com>,
        "qais.yousef@arm.com" <qais.yousef@arm.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "patrick.bellasi@matbug.net" <patrick.bellasi@matbug.net>,
        "pjt@google.com" <pjt@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "tj@kernel.org" <tj@kernel.org>,
        "qperret@google.com" <qperret@google.com>,
        "joshdon@google.com" <joshdon@google.com>,
        "len.brown@intel.com" <len.brown@intel.com>
Subject: RE: [PATCH v2 0/7] Add latency_nice priority
Thread-Topic: [PATCH v2 0/7] Add latency_nice priority
Thread-Index: AQHYbqP4zaEzexIx1U6fvq8Kco/Wm60scgmw
Date:   Mon, 23 May 2022 13:19:26 +0000
Message-ID: <d4467cd50d884b438dc8c2993669bed0@AcuMS.aculab.com>
References: <20220512163534.2572-1-vincent.guittot@linaro.org>
 <f1f50c52673aa1873b4a4d3b6b15250d4bf390f9.camel@linux.intel.com>
 <CAKfTPtBEHyP202duKwJi+GVNTMza+L_PuK3hmUxcjKnODOuRjw@mail.gmail.com>
 <9c0f9158-2d0c-dba9-1505-79ba4e642684@oracle.com>
 <aa8746fbb27849ee34ddb0ff028d0a1ee064c506.camel@linux.intel.com>
 <CAKfTPtAotgr+C1zXyWDSZt59NFX7Twb7gQLMcSv5hm6ywM85+Q@mail.gmail.com>
In-Reply-To: <CAKfTPtAotgr+C1zXyWDSZt59NFX7Twb7gQLMcSv5hm6ywM85+Q@mail.gmail.com>
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
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gPiA+IG1lZGlhIHBsYXliYWNrICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IC0xNSB0byAtMTENCg0KSXNuJ3QgdGhhdCB3aGF0IHRoZSBSVCBzY2hlZHVsZXIgaXMgZm9yLi4u
Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJv
YWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24g
Tm86IDEzOTczODYgKFdhbGVzKQ0K

