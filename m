Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6A150087A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240983AbiDNIiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241015AbiDNIhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:37:38 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8B7562A1F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:35:11 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-319-DUXdtwJLPIq4rCnsMoqOfQ-1; Thu, 14 Apr 2022 09:35:08 +0100
X-MC-Unique: DUXdtwJLPIq4rCnsMoqOfQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Thu, 14 Apr 2022 09:35:07 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Thu, 14 Apr 2022 09:35:07 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Vincent Guittot' <vincent.guittot@linaro.org>,
        Qais Yousef <qais.yousef@arm.com>
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
Subject: RE: Scheduling tasks on idle cpu
Thread-Topic: Scheduling tasks on idle cpu
Thread-Index: AdhNfEgLjonPVH3ESQeb3O9OCn/HMQAeBEWAABN1gYAAZKysEwAAL2fQ
Date:   Thu, 14 Apr 2022 08:35:07 +0000
Message-ID: <2956e0e1bbfe4309a749ebb3c8736799@AcuMS.aculab.com>
References: <030aacb0c1304e43ab917924dcf4f138@AcuMS.aculab.com>
 <20220411233447.rcencjivkhyltyxm@airbuntu>
 <4ca5cd70904d47bea0df93f7c0979c66@AcuMS.aculab.com>
 <CAKfTPtBWUvvFMsSnfcKsOpHFdvxvSWpjfuLpjwwQrwhQc7+xuw@mail.gmail.com>
 <20220413235719.xs72pm2kgihia46g@airbuntu>
 <CAKfTPtBtzmgJNM=2ekmE0-HT+r=qLqBJ6R1cggkGCNHbb3FPdQ@mail.gmail.com>
In-Reply-To: <CAKfTPtBtzmgJNM=2ekmE0-HT+r=qLqBJ6R1cggkGCNHbb3FPdQ@mail.gmail.com>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVmluY2VudCBHdWl0dG90DQo+IFNlbnQ6IDE0IEFwcmlsIDIwMjIgMDg6NTQNCj4gDQo+
IE9uIFRodSwgMTQgQXByIDIwMjIgYXQgMDE6NTcsIFFhaXMgWW91c2VmIDxxYWlzLnlvdXNlZkBh
cm0uY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIDA0LzEyLzIyIDExOjA3LCBWaW5jZW50IEd1aXR0
b3Qgd3JvdGU6DQo+ID4gPiBPbiBUdWUsIDEyIEFwciAyMDIyIGF0IDEwOjM5LCBEYXZpZCBMYWln
aHQgPERhdmlkLkxhaWdodEBhY3VsYWIuY29tPiB3cm90ZToNCj4gPiA+ID4gWWVzIEkgd2FudCB0
aGUgQ0ZTIHNjaGVkdWxlciB0byBwaWNrIGFuIGlkbGUgY3B1IGluIHByZWZlcmVuY2UNCj4gPiA+
ID4gdG8gYW4gYWN0aXZlIFJUIG9uZS4NCj4gPiA+DQo+ID4gPiBXaGVuIHRhc2sgMzQ1MTIgd2Fr
ZXMgdXAsIHNjaGVkdWxlciBjaGVja3MgaWYgcHJldiBvciB0aGlzIGNwdSBhcmUNCj4gPiA+IGlk
bGUgd2hpY2ggaXMgbm90IHRoZSBjYXNlIGZvciB5b3UuIFRoZW4sIGl0IGNvbXBhcmVzIHRoZSBs
b2FkIG9mIHByZXYNCj4gPiA+IGFuZCB0aGlzX2NwdSBhbmQgc2VlbXMgdG8gc2VsZWN0IHRoaXNf
Y3B1IChjcHUxNykuDQo+ID4gPg0KPiA+ID4gT25jZSBjcHUxNyBzZWxlY3RlZCwgaXQgd2lsbCB0
cnkgdG8gZmluZCBhbiBpZGxlIGNwdSB3aGljaCBzaGFyZXMgTExDDQo+ID4gPiBidXQgaXQgc2Vl
bXMgdGhhdCB0aGUgc2NoZWR1bGVyIGRpZG4ndCBmaW5kIG9uZSBhbmQgZmluYWxseSBrZWVwcyB0
YXNrDQo+ID4gPiAzNDUxMiBvbiB0aGlzX2NwdS4NCj4gPiA+DQo+ID4gPiBOb3RlIHRoYXQgZHVy
aW5nIHRoZSBuZXh0IHRpY2ssIGEgbG9hZCBiYWxhbmNlIHdpbGwgYmUgdHJpZ2dlciBpZg0KPiA+
ID4gdGhpc19jcHUgc3RpbGwgaGF2ZSBib3RoIFJUIGFuZCB0YXNrIDM0NTEyLA0KPiA+DQo+ID4g
RGF2aWQgc2FpZCB0aGVyZSBhcmUgaWRsZSBjcHVzDQo+ID4NCj4gPiAgICAgICAgICIgIFRoZXJl
IGFyZSB0d28gcGh5c2ljYWwgY3B1IHdpdGggMjAgY29yZXMgZWFjaCAod2l0aCBoeXBlcnRocmVh
ZGluZykuDQo+ID4gICAgICAgICAxNiwgMTgsIDM0LCAzNiBhbmQgMzggd2VyZSBpZGxlLiBTbyBi
b3RoIDE2IGFuZCAxOCBzaG91bGQgYmUgb24gdGhlDQo+ID4gICAgICAgICBzYW1lIE5VTUEgbm9k
ZS4gQWxsIHRoZSBvdGhlcnMgYXJlIHJ1bm5pbmcgdGhlIHNhbWUgUlQgdGhyZWFkIGNvZGUuICAi
DQo+ID4NCj4gPiBFeGNlcHQgZm9yIHRoZSBwb3NzaWJpbGl0eSBvZiB0aGVtIGJlY29taW5nIGlk
bGUganVzdCBhZnRlciB0aGUgdGFzayBoYXMgd29rZW4NCj4gPiB1cCwgc2hvdWxkbid0IG9uZSBv
ZiB0aGVtIGhhdmUgYmVlbiBwaWNrZWQ/DQo+IA0KPiB3ZSBkb24ndCBsb29wIG9uIGFsbCBjcHVz
IGluIHRoZSBMTEMgdG8gZmluZCBhbiBpZGxlIG9uZSBidXQgY29tcHV0ZSBhDQo+IHJlYXNvbmFi
bGUgbnVtYmVyIG9mIGl0ZXJhdGlvbiBiYXNlZCBvbiB0aGUgYXZnX2lkbGUNCg0KSXMgdGhlcmUg
YSB3YXkgdG8gZHVtcCB0aGUga2VybmVsIE5VTUEvTExDIHRhYmxlcz8NClRoaXMgbWlnaHQgYmUg
cmVsZXZhbnQgKHdpdGggZXZlcnl0aGluZyBpZGxlKToNCiMgY2F0IC9wcm9jL3NjaGVkc3RhdA0K
dmVyc2lvbiAxNQ0KdGltZXN0YW1wIDUzODg5ODkxOTMNCmNwdTAgMCAwIDAgMCAwIDAgMTE3MjI2
MDQxMzg0NTgyIDI1MDUzMTU2NTM1NCAyMDYyNzY4NzMNCmRvbWFpbjAgMDAsMDAxMDAwMDEgMCAw
IDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAg
MCAwIDAgMCAwIDANCmRvbWFpbjEgNTUsNTU1NTU1NTUgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAg
MCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDANCmRvbWFpbjIg
ZmYsZmZmZmZmZmYgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAw
IDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDANCmNwdTEgMCAwIDAgMCAwIDAgMTE1OTc4NjYxMjg4
NzE4IDI1MTczNjkzMzgxNCAyOTcwOTMyODANCmRvbWFpbjAgMDAsMDAyMDAwMDIgMCAwIDAgMCAw
IDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAg
MCAwIDANCmRvbWFpbjEgYWEsYWFhYWFhYWEgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAg
MCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDANCmRvbWFpbjIgZmYsZmZm
ZmZmZmYgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAw
IDAgMCAwIDAgMCAwIDAgMCAwIDANCkFsbCB0aGUgbGF0ZXIgY3B1IGZvbGxvdyB0aGUgc2FtZSBw
YXR0ZXJuIChkb21haW4wIHNoaWZ0cyBsZWZ0IGV2ZXJ5IGNwdSkuDQoNCkkgY291bGQgaW50ZXJw
cmV0IHRoYXQgYXMgbWVhbmluZzoNCmNwdSBuIGFuZCAobiArIDIwKSBhcmUgdGhlIGh5cGVydGhy
ZWFkaW5nIHBhaXJzLg0KRXZlbiBudW1iZXJlZCBjcHUgYXJlIG9uIG9uZSBjaGlwLCBvZGQgbnVt
YmVyZWQgb24gdGhlIG90aGVyLg0KDQpUaGUgbWlncmF0ZSB3YXM6DQogIDM0NTMzIFswMTddOiBz
Y2hlZF9taWdyYXRlX3Rhc2s6IHBpZD0zNDUxMiBwcmlvPTEyMCBvcmlnX2NwdT0xNCBkZXN0X2Nw
dT0xNw0KQWxsIHRoZSBpZGxlIGNwdSB3ZXJlIGV2ZW4uDQoNCj4gRGF2aWQgY2FuIHJlcnVuIGlz
IHVzZSBjYXNlIGFmdGVyIGRpc2FibGluZyBzY2hlZF9mZWF0KFNJU19QUk9QKQ0KDQpIb3cgd291
bGQgSSBkbyB0aGF0Pw0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRl
LCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpS
ZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

