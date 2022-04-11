Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987EA4FB5F0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343762AbiDKI2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238349AbiDKI2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:28:52 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90D561FCE6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:26:38 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-37-z9nUKmF_MNqmKFW9IuprOA-1; Mon, 11 Apr 2022 09:26:36 +0100
X-MC-Unique: z9nUKmF_MNqmKFW9IuprOA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Mon, 11 Apr 2022 09:26:33 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Mon, 11 Apr 2022 09:26:33 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Qais Yousef' <qais.yousef@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
CC:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
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
Subject: Scheduling tasks on idle cpu
Thread-Topic: Scheduling tasks on idle cpu
Thread-Index: AdhNfEgLjonPVH3ESQeb3O9OCn/HMQ==
Date:   Mon, 11 Apr 2022 08:26:33 +0000
Message-ID: <030aacb0c1304e43ab917924dcf4f138@AcuMS.aculab.com>
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
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUWFpcyBZb3VzZWYNCj4gU2VudDogMDkgQXByaWwgMjAyMiAxODowOQ0KLi4uDQo+IFJU
IHNjaGVkdWxlciB3aWxsIHB1c2gvcHVsbCB0YXNrcyB0byBlbnN1cmUgdGhlIHRhc2sgd2lsbCBn
ZXQgdG8gcnVuIEFTQVAgaWYNCj4gdGhlcmUncyBhbm90aGVyIGNwdSBhdCBsb3dlciBwcmlvcml0
eSBpcyBhdmFpbGFibGUNCg0KRG9lcyB0aGF0IGFjdHVhbGx5IGhhcHBlbj8NCkkndmUgc2VlbiB0
aGUgZm9sbG93aW5nOg0KICAzNDUzMyBbMDE3XTogc3lzX2Z1dGV4KHVhZGRyOiAxMDQ5MTA0LCBv
cDogODUsIHZhbDogMSwgdXRpbWU6IDEsIHVhZGRyMjogMTA0OTEwMCwgdmFsMzogNDAwMDAwMSkN
CiAgMzQ1MzMgWzAxN106IHNjaGVkX21pZ3JhdGVfdGFzazogcGlkPTM0NTEyIHByaW89MTIwIG9y
aWdfY3B1PTE0IGRlc3RfY3B1PTE3DQogIDM0NTMzIFswMTddOiBzY2hlZF93YWtldXA6IHBpZD0z
NDUxMiBwcmlvPTEyMCBzdWNjZXNzPTEgdGFyZ2V0X2NwdT0wMTcNCmFuZCBwaWQgMzQ1MTIgZG9l
c24ndCBnZXQgc2NoZWR1bGVkIHVudGlsIHBpZCAzNDUzMyBmaW5hbGx5IHNsZWVwcy4NClRoaXMg
aXMgaW4gc3BpdGUgb2YgdGhlcmUgYmVpbmcgNSBpZGxlIGNwdS4NCmNwdSAxNCBpcyBidXN5IHJ1
bm5pbmcgYSBSVCB0aHJlYWQsIGJ1dCBtaWdyYXRpbmcgdG8gY3B1IDE3IHNlZW1zIHdyb25nLg0K
DQpUaGlzIGlzIG9uIGEgUkhFTDcga2VybmVsLCBJJ3ZlIG5vdCByZXBsaWNhdGVkIGl0IG9uIGFu
eXRoaW5nIHJlY2VudC4NCkJ1dCBJJ3ZlIHZlcnkgbXVjaCBsaWtlIGEgUlQgdGhyZWFkIHRvIGJl
IGFibGUgdG8gc2NoZWR1bGUgYSBub24tUlQNCnRocmVhZCB0byBydW4gb24gYW4gaWRsZSBjcHUu
DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9h
ZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBO
bzogMTM5NzM4NiAoV2FsZXMpDQo=

