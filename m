Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34526579536
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbiGSI0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiGSI0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:26:40 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 922DA21F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:26:39 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-136-8aiBKALHMe-YeGLl3g-g9w-1; Tue, 19 Jul 2022 09:26:36 +0100
X-MC-Unique: 8aiBKALHMe-YeGLl3g-g9w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Tue, 19 Jul 2022 09:26:35 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Tue, 19 Jul 2022 09:26:35 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "Nuzman, Joseph" <joseph.nuzman@intel.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Gross, Jurgen" <jgross@suse.com>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Peter Collingbourne <pcc@google.com>
Subject: RE: [patch 00/38] x86/retbleed: Call depth tracking mitigation
Thread-Topic: [patch 00/38] x86/retbleed: Call depth tracking mitigation
Thread-Index: AQHYmwK9i03gNC/QIkePUsvbFv4MOq2FWkvA
Date:   Tue, 19 Jul 2022 08:26:35 +0000
Message-ID: <0e038c2795784b7eb4de52f77b67206a@AcuMS.aculab.com>
References: <20220716230344.239749011@linutronix.de> <87wncauslw.ffs@tglx>
 <87tu7euska.ffs@tglx>
 <CAHk-=wjpzVRU0Yr_0DJSB_bKHW3_74UucNpJBjxfHPo_R=PYNg@mail.gmail.com>
 <87o7xmup5t.ffs@tglx> <YtXOMPpmx8TcFtOX@worktop.programming.kicks-ass.net>
 <87lesqukm5.ffs@tglx> <2f7f899cb75b79b08b0662ff4d2cb877@overdrivepizza.com>
 <CABCJKudvSv9bAOrDLHki5XPYNJK6=PS-x8v=E08es8w4LJpxBw@mail.gmail.com>
 <87fsiyuhyz.ffs@tglx>
 <CAHk-=wjEDJ4+xg0CWR7CaCKnO6Nhzn+vjJy7CjaVmf9R+g_3ag@mail.gmail.com>
 <CAHk-=wj6U3UamfLLV+rPu1WmKG_w3p0Bg=YbQcG1DxHpmP40Ag@mail.gmail.com>
 <CAHk-=wiYHXeWnF8Ea5xb735ehJ8FbjTT6UCvHYjX=Ooc7Z5sOw@mail.gmail.com>
In-Reply-To: <CAHk-=wiYHXeWnF8Ea5xb735ehJ8FbjTT6UCvHYjX=Ooc7Z5sOw@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTkgSnVseSAyMDIyIDAxOjAyDQo+IA0KPiBP
biBNb24sIEp1bCAxOCwgMjAyMiBhdCA0OjUyIFBNIExpbnVzIFRvcnZhbGRzDQo+IDx0b3J2YWxk
c0BsaW51eC1mb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBIb25lc3RseSwgSSB0aGlu
ayB0aGF0IHdvdWxkIGJlIGEgYmV0dGVyIG1vZGVsIC0geWVzLCB5b3UgbG9zZSA4IGJpdHMNCj4g
PiBvZiBoYXNoLCBidXQgY29uc2lkZXJpbmcgdGhhdCBhcHBhcmVudGx5IHRoZSBjdXJyZW50IEtD
RkkgY29kZQ0KPiA+ICpndWFyYW50ZWVzKiB0aGF0IHRoZSBoYXNoIHBhdHRlcm4gd2lsbCBleGlz
dCBldmVuIG91dHNpZGUgdGhlIGFjdHVhbA0KPiA+IHRhcmdldCBwYXR0ZXJuLA0KPiANCj4gR2Fh
aCwgSSdtIGJlaW5nIHN0dXBpZCwuIFlvdSBzdGlsbCBnZXQgdGhlIHZhbHVlIGNvbGxpc2lvbiwg
c2luY2UgdGhlDQo+IGludDMgYnl0ZSBwYXR0ZXJuIHdvdWxkIGp1c3QgYmUgcGFydCBvZiB0aGUg
Y29tcGFyZSBwYXR0ZXJuLg0KPiANCj4gWW91J2QgaGF2ZSB0byB1c2Ugc29tZSBtdWx0aS1pbnN0
cnVjdGlvbiBjb21wYXJlIHRvIGF2b2lkIGhhdmluZyB0aGUNCj4gcGF0dGVybiBpbiB0aGUgaW5z
dHJ1Y3Rpb24gc3RyZWFtLiBQcm9iYWJseSB3aXRoIGFub3RoZXIgcmVnaXN0ZXIuDQo+IExpa2UN
Cj4gDQo+ICAgICAgICAgbW92bCAtRklYRURfT0ZGU0VUKCVlYXgpLCVyZHgNCj4gICAgICAgICBh
ZGRsICRBTlRJX1BBVFRFUk4sJXJkeA0KPiAgICAgICAgIGplIG9rDQo+IA0KPiBzbyB0aGF0IHRo
ZSAiY29tcGFyZSIgd291bGRuJ3QgdXNlIHRoZSBzYW1lIHBhdHRlcm4gdmFsdWUsIGJ1dCBiZSBh
bg0KPiBhZGQgd2l0aCB0aGUgbmVnYXRlZCBwYXR0ZXJuIHZhbHVlIGluc3RlYWQuDQo+IA0KPiBU
aGUgZXh0cmEgaW5zdHJ1Y3Rpb24gaXMgbGlrZWx5IGxlc3Mgb2YgYSBwcm9ibGVtIHRoYW4gdGhl
IGV4dHJhIHJlZ2lzdGVyIHVzZWQuDQoNClNob3VsZG4ndCBpdCBiZSB0ZXN0aW5nIHRoZSB2YWx1
ZSB0aGUgY2FsbGVyIHN1cHBsaWVkPw0KDQpUaGUgZXh0cmEgaW5zdHJ1Y3Rpb24gaXMgbGlrZWx5
IHRvIGJlIG9uZSBjbG9jayAtIEkgZG91YnQgaXQgd2lsbA0Kc2Vuc2libHkgcnVuIGluIHBhcmFs
bGVsIHdpdGggY29kZSBsYXRlciBpbiB0aGUgZnVuY3Rpb24uDQoNClRoZSBsYXJnZXIgY29zdHMg
YXJlIChwcm9iYWJseSkgcG9sbHV0aW5nIHRoZSBEJCB3aXRoIEkgYWRkcmVzc2VzDQooYWxyZWFk
eSBkb25lIGJ5IHRoZSBjYWxsZXIpIGFuZCB0aGUgbGlrZWx5IG1pc3ByZWRpY3RlZCAnamUgb2sn
Lg0KVW5sZXNzIHRoZSBmdW5jdGlvbiBoYXMgYmVlbiByZWNlbnRseSBjYWxsZWQgdGhlICdqZSBv
aycgZ2V0cw0Kc3RhdGljIHByZWRpY3Rpb24uDQpXaGlsZSB0cmFkaXRpb25hbGx5IHRoYXQgd291
bGQgcHJlZGljdCBhIGZvcndhcmRzIGJyYW5jaCAnbm90IHRha2VuJw0KSVNUUiBtb3JlIHJlY2Vu
dCBJbnRlbCBjcHUganVzdCB1c2UgdGhlIHByZWRpY3RvciBvdXRwdXQgLSBpZSByYW5kb20uDQpO
b3QgYXQgYWxsIHN1cmUgYWJvdXQgQU1EIGNwdSB0aG91Z2guDQoNCglEYXZpZA0KDQotDQpSZWdp
c3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9u
IEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

