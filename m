Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAF6501771
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243551AbiDNPiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350508AbiDNOWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:22:25 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B2551C122
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:14:27 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-48-avZjpdW1Ouads2I4a0YvDg-1; Thu, 14 Apr 2022 15:14:24 +0100
X-MC-Unique: avZjpdW1Ouads2I4a0YvDg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Thu, 14 Apr 2022 15:14:22 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Thu, 14 Apr 2022 15:14:22 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Vincent Guittot' <vincent.guittot@linaro.org>
CC:     Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
Thread-Index: AdhNfEgLjonPVH3ESQeb3O9OCn/HMQAeBEWAABN1gYAAZKysEwAAL2fQAAKuEIAAB3al0A==
Date:   Thu, 14 Apr 2022 14:14:22 +0000
Message-ID: <5fc162f60ba84ab3a61992084d76c726@AcuMS.aculab.com>
References: <030aacb0c1304e43ab917924dcf4f138@AcuMS.aculab.com>
 <20220411233447.rcencjivkhyltyxm@airbuntu>
 <4ca5cd70904d47bea0df93f7c0979c66@AcuMS.aculab.com>
 <CAKfTPtBWUvvFMsSnfcKsOpHFdvxvSWpjfuLpjwwQrwhQc7+xuw@mail.gmail.com>
 <20220413235719.xs72pm2kgihia46g@airbuntu>
 <CAKfTPtBtzmgJNM=2ekmE0-HT+r=qLqBJ6R1cggkGCNHbb3FPdQ@mail.gmail.com>
 <2956e0e1bbfe4309a749ebb3c8736799@AcuMS.aculab.com>
 <CAKfTPtB0EniWa_Wqx9596Zm5ZyoB3CRWwkgcYgxYB=318eWsWQ@mail.gmail.com>
In-Reply-To: <CAKfTPtB0EniWa_Wqx9596Zm5ZyoB3CRWwkgcYgxYB=318eWsWQ@mail.gmail.com>
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

RnJvbTogVmluY2VudCBHdWl0dG90DQo+IFNlbnQ6IDE0IEFwcmlsIDIwMjIgMTE6MTcNCi4uLg0K
PiA+ID4gRGF2aWQgY2FuIHJlcnVuIGlzIHVzZSBjYXNlIGFmdGVyIGRpc2FibGluZyBzY2hlZF9m
ZWF0KFNJU19QUk9QKQ0KPiA+DQo+ID4gSG93IHdvdWxkIEkgZG8gdGhhdD8NCj4gDQo+IGVjaG8g
Tk9fU0lTX1BST1AgPiAvc3lzL2tlcm5lbC9kZWJ1Zy9zY2hlZC9mZWF0dXJlcw0KDQpUaGF0IG1h
eSBub3QgYmUgaW4gdGhlIGtlcm5lbCBJJ20gdXNpbmcuDQoNCiMgY2F0IC9zeXMva2VybmVsL2Rl
YnVnL3NjaGVkX2ZlYXR1cmVzDQpHRU5UTEVfRkFJUl9TTEVFUEVSUyBTVEFSVF9ERUJJVCBOT19O
RVhUX0JVRERZIExBU1RfQlVERFkgQ0FDSEVfSE9UX0JVRERZIFdBS0VVUF9QUkVFTVBUSU9OIEFS
Q0hfUE9XRVIgTk9fSFJUSUNLIE5PX0RPVUJMRV9USUNLIExCX0JJQVMgTk9OVEFTS19QT1dFUiBU
VFdVX1FVRVVFIFJUX1JVTlRJTUVfU0hBUkUgTk9fTEJfTUlOIE5VTUEgTlVNQV9GQVZPVVJfSElH
SEVSIE5PX05VTUFfUkVTSVNUX0xPV0VSDQoNCkkndmUgYmVlbiBsb29raW5nIGF0IGFub3RoZXIg
ZnRyYWNlIG91dHB1dC4NClRoZSBzY2hlZHVsZXIgZG9lcyBsaWtlIG1pZ3JhdGluZyB0aGUgcHJv
Y2VzcyB0byB0aGUgY3VycmVudCBjcHUuDQpJIGhhdmUgc2VlbiBpdCBtaWdyYXRlIGZyb20gb25l
IGlkbGUgY3B1IHRvIGFub3RoZXIgaWRsZSBjcHUuDQpJJ3ZlIG5vdCBzZWVuIGl0IG1pZ3JhdGUg
ZnJvbSBhbiBpZGxlIGNwdSB0byB0aGUgY3VycmVudCBjcHUuDQogIChCdXQgSSd2ZSBub3QgbG9v
a2VkIGhhcmQuKQ0KDQpUaGVzZSBhcmUgYWxsIHRoZSBtaWdyYXRlczoNCiAgICBUaU5HIHRhc2s6
MTItMTAwNSAgWzAyNl0gZC4uLiAxMTExMDgxLjc5NjU2MDogc2NoZWRfbWlncmF0ZV90YXNrOiBj
b21tPVJUUCBzb2NrZXRzIHBpZD05OTAgcHJpbz0xMjAgb3JpZ19jcHU9MTEgZGVzdF9jcHU9MTYN
CiAgICBUaU5HIHRhc2s6MzEtMTAyNiAgWzAwNV0gZC4uLiAxMTExMDgxLjgzNjU1Njogc2NoZWRf
bWlncmF0ZV90YXNrOiBjb21tPVJUUCBzb2NrZXRzIHBpZD05OTAgcHJpbz0xMjAgb3JpZ19jcHU9
MTYgZGVzdF9jcHU9MTENCiAgICBUaU5HIHRhc2s6MjgtMTAyMyAgWzAzM10gZC4uLiAxMTExMDgx
Ljg1NjU4OTogc2NoZWRfbWlncmF0ZV90YXNrOiBjb21tPVJUUCBzb2NrZXRzIHBpZD05OTAgcHJp
bz0xMjAgb3JpZ19jcHU9MTEgZGVzdF9jcHU9MzMNCiAgICBUaU5HIHRhc2s6MTEtMTAwNCAgWzAx
M10gZC4uLiAxMTExMDgxLjg1NjYwNjogc2NoZWRfbWlncmF0ZV90YXNrOiBjb21tPVJUUCBzb2Nr
ZXRzIHBpZD05OTAgcHJpbz0xMjAgb3JpZ19jcHU9MzMgZGVzdF9jcHU9MTMNCiAgICBUaU5HIHRh
c2s6MTktMTAxMiAgWzAwMl0gZC4uLiAxMTExMDgxLjg5NjU2NDogc2NoZWRfbWlncmF0ZV90YXNr
OiBjb21tPVJUUCBzb2NrZXRzIHBpZD05OTAgcHJpbz0xMjAgb3JpZ19jcHU9MTMgZGVzdF9jcHU9
MTANCiAgICBUaU5HIHRhc2s6MjYtMTAxOSAgWzAwOF0gZC4uLiAxMTExMDgxLjk1NjU1MTogc2No
ZWRfbWlncmF0ZV90YXNrOiBjb21tPVJUUCBzb2NrZXRzIHBpZD05OTAgcHJpbz0xMjAgb3JpZ19j
cHU9MTAgZGVzdF9jcHU9MTgNCiAgICBUaU5HIHRhc2s6MzQtMTAyOSAgWzAwMV0gZC4uLiAxMTEx
MDgyLjAxNjUyNzogc2NoZWRfbWlncmF0ZV90YXNrOiBjb21tPVJUUCBzb2NrZXRzIHBpZD05OTAg
cHJpbz0xMjAgb3JpZ19jcHU9MTggZGVzdF9jcHU9MQ0KICAgIFRpTkcgdGFzazoyMC0xMDEzICBb
MDIxXSBkLi4uIDExMTEwODIuMDE2NTg5OiBzY2hlZF9taWdyYXRlX3Rhc2s6IGNvbW09UlRQIHNv
Y2tldHMgcGlkPTk5MCBwcmlvPTEyMCBvcmlnX2NwdT0xIGRlc3RfY3B1PTIxDQogICAgVGlORyB0
YXNrOjMyLTEwMjcgIFswMDBdIGQuLi4gMTExMTA4Mi4wMzY0NTU6IHNjaGVkX21pZ3JhdGVfdGFz
azogY29tbT1SVFAgc29ja2V0cyBwaWQ9OTkwIHByaW89MTIwIG9yaWdfY3B1PTIxIGRlc3RfY3B1
PTINCiAgICBUaU5HIHRhc2s6MTUtMTAwOCAgWzAwNl0gZC4uLiAxMTExMDgyLjA1NjUzOTogc2No
ZWRfbWlncmF0ZV90YXNrOiBjb21tPVJUUCBzb2NrZXRzIHBpZD05OTAgcHJpbz0xMjAgb3JpZ19j
cHU9MiBkZXN0X2NwdT0xNA0KICAgIFRpTkcgdGFzazozNC0xMDI5ICBbMDAxXSBkLi4uIDExMTEw
ODIuMDc2NTM2OiBzY2hlZF9taWdyYXRlX3Rhc2s6IGNvbW09UlRQIHNvY2tldHMgcGlkPTk5MCBw
cmlvPTEyMCBvcmlnX2NwdT0xNCBkZXN0X2NwdT0xDQogICAgVGlORyB0YXNrOjIxLTEwMTQgIFsw
MDRdIGQuLi4gMTExMTA4Mi4wNzY1ODk6IHNjaGVkX21pZ3JhdGVfdGFzazogY29tbT1SVFAgc29j
a2V0cyBwaWQ9OTkwIHByaW89MTIwIG9yaWdfY3B1PTEgZGVzdF9jcHU9NA0KICAgIFRpTkcgdGFz
azoxMS0xMDA0ICBbMDEzXSBkLi4uIDExMTEwODIuMDk2NTI2OiBzY2hlZF9taWdyYXRlX3Rhc2s6
IGNvbW09UlRQIHNvY2tldHMgcGlkPTk5MCBwcmlvPTEyMCBvcmlnX2NwdT00IGRlc3RfY3B1PTEz
DQogICAgVGlORyB0YXNrOjI4LTEwMjMgIFswMzNdIGQuLi4gMTExMTA4Mi4wOTY1ODQ6IHNjaGVk
X21pZ3JhdGVfdGFzazogY29tbT1SVFAgc29ja2V0cyBwaWQ9OTkwIHByaW89MTIwIG9yaWdfY3B1
PTEzIGRlc3RfY3B1PTMzDQogICAgVGlORyB0YXNrOjI1LTEwMTggIFswMjldIGQuLi4gMTExMTA4
Mi4xMTY1NDk6IHNjaGVkX21pZ3JhdGVfdGFzazogY29tbT1SVFAgc29ja2V0cyBwaWQ9OTkwIHBy
aW89MTIwIG9yaWdfY3B1PTMzIGRlc3RfY3B1PTExDQogICAgVGlORyB0YXNrOjI3LTEwMjAgIFsw
MzJdIGQuLi4gMTExMTA4Mi4xNzY1MTk6IHNjaGVkX21pZ3JhdGVfdGFzazogY29tbT1SVFAgc29j
a2V0cyBwaWQ9OTkwIHByaW89MTIwIG9yaWdfY3B1PTExIGRlc3RfY3B1PTE2DQpUaGVyZSBhcmUg
YSBjb3VwbGUgb2YgcGxhY2VzIHdoZXJlIHRoZXJlIDIgd2FrZXVwcyBiZWZvcmUgdGhlIHNjaGVk
dWxlLg0KVGhlIHNjaGVkdWxlciBkZWZpbml0ZWx5IGRvZXNuJ3QgbGlrZSB3YWtpbmcgdXAgYSBw
cm9jZXNzIG9uIGFuIGV2ZW4gY3B1IGZyb20gb24gb2RkIG9uZS4NCkJ1dCB0aGVyZSBhcmUgYWxz
byB0aGUgMTMtPjMzIGFuZCAxLT4yMSBvbmVzLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBB
ZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMs
IE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

