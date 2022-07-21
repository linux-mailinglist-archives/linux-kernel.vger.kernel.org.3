Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328E757D66B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 00:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbiGUWBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 18:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbiGUWBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 18:01:19 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 148451759B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 15:01:17 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-146-vVf4_H80MfeFo66gwMM5tg-1; Thu, 21 Jul 2022 23:01:15 +0100
X-MC-Unique: vVf4_H80MfeFo66gwMM5tg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Thu, 21 Jul 2022 23:01:12 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Thu, 21 Jul 2022 23:01:12 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Sami Tolvanen <samitolvanen@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joao Moreira <joao@overdrivepizza.com>,
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
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Collingbourne <pcc@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: RE: [patch 00/38] x86/retbleed: Call depth tracking mitigation
Thread-Topic: [patch 00/38] x86/retbleed: Call depth tracking mitigation
Thread-Index: AQHYnSyhi03gNC/QIkePUsvbFv4MOq2JW8MQ
Date:   Thu, 21 Jul 2022 22:01:12 +0000
Message-ID: <d0597f7096344b10bfcd95a0ffdbad17@AcuMS.aculab.com>
References: <CABCJKudvSv9bAOrDLHki5XPYNJK6=PS-x8v=E08es8w4LJpxBw@mail.gmail.com>
 <87fsiyuhyz.ffs@tglx>
 <CAHk-=wjEDJ4+xg0CWR7CaCKnO6Nhzn+vjJy7CjaVmf9R+g_3ag@mail.gmail.com>
 <CAHk-=wj6U3UamfLLV+rPu1WmKG_w3p0Bg=YbQcG1DxHpmP40Ag@mail.gmail.com>
 <YtXzgWnbTQH48JGR@worktop.programming.kicks-ass.net>
 <CAHk-=wiJNViWKCCrDPByGWmVVXuEKhRGykx4q8diXSxEqGfOMw@mail.gmail.com>
 <CAHk-=wjmUeB=_s6jcBUNoAT4GHv-aF1Mzqa6G1X4k+dcHDs1Mg@mail.gmail.com>
 <Ytbnlms90+LBLbrY@google.com>
 <Ythv7NqofIAHp3bf@worktop.programming.kicks-ass.net>
 <Ytl2vg15Hc0fh8Dl@worktop.programming.kicks-ass.net>
 <YtmTK93vHWQUFinE@worktop.programming.kicks-ass.net>
 <CAHk-=whLGENEkjME_v_3P1SwhwjzH4GK2RLA3fn=yQNuyKLBkg@mail.gmail.com>
In-Reply-To: <CAHk-=whLGENEkjME_v_3P1SwhwjzH4GK2RLA3fn=yQNuyKLBkg@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjEgSnVseSAyMDIyIDE5OjA3DQouLi4NCj4g
IChiKSBzaW5jZSB5b3UgaGF2ZSB0aGF0IHIxMCB1c2UgYW55d2F5LCB3aHkgY2FuJ3QgeW91IGp1
c3QgZ2VuZXJhdGUgdGhlIHNpbXBsZXINCj4gDQo+ICAgICAgICAgbW92bCAkLUlNTSwlcjEwZA0K
PiAgICAgICAgIGFkZGwgLTQoJWNhbGxkZXN0KSwlcjEwZA0KPiANCj4gICAgICBpbnN0ZWFkPyBZ
b3Ugb25seSBuZWVkIFpGIGFueXdheS4NCj4gDQo+ICAgICAgTWF5YmUgeW91IG5lZWQgdG8gYWRk
IHNvbWUgInIxMCBpcyBjbG9iYmVyZWQiIHRoaW5nLCBJIGRvbid0IGtub3cuDQo+IA0KPiBCdXQg
YWdhaW46IEkgZG9uJ3Qga25vdyBsbHZtLCBzbyB0aGUgYWJvdmUgaXMgYmFzaWNhbGx5IG1lIGp1
c3QgZG9pbmcNCj4gdGhlICJwYXR0ZXJuIG1hdGNoaW5nIG1vbmtleSIgdGhpbmcuDQo+IA0KPiAg
ICAgICAgICAgICAgTGludXMNCg0KU2luY2U6ICJJZiB0aGUgY2FsbGVlIGlzIGEgdmFyaWFkaWMg
ZnVuY3Rpb24sIHRoZW4gdGhlIG51bWJlciBvZiBmbG9hdGluZw0KcG9pbnQgYXJndW1lbnRzIHBh
c3NlZCB0byB0aGUgZnVuY3Rpb24gaW4gdmVjdG9yIHJlZ2lzdGVycyBtdXN0IGJlIHByb3ZpZGVk
DQpieSB0aGUgY2FsbGVyIGluIHRoZSBBTCByZWdpc3Rlci4iDQoNCkFuZCB0aGF0IHRoYXQgbmV2
ZXIgaGFwcGVucyBpbiB0aGUga2VybmVsIHlvdSBjYW4gdXNlICVlYXggaW5zdGVhZA0Kb2YgJXIx
MGQuDQoNCkV2ZW4gaW4gdXNlcnNwYWNlICVhbCBjYW4gYmUgc2V0IG5vbi16ZXJvIGFmdGVyIHRo
ZSBzaWduYXR1cmUgY2hlY2suDQoNCklmIHlvdSBhcmUgd2lsbGluZyB0byBjdXQgdGhlIHNpZ25h
dHVyZSBkb3duIHRvIDI2IGJpdHMgYW5kDQp0aGVuIGVuc3VyZSB0aGF0IG9uZSBvZiB0aGUgYnl0
ZXMgb2YgLUlNTSAob3IgfklNTSBpZiB5b3UNCnVzZSB4b3IpIGlzIDB4Y2MgYW5kIGp1bXAgYmFj
ayB0byB0aGF0IG9uIGVycm9yIHRoZSBjaGVjaw0KYmVjb21lczoNCgltb3ZsCSQtSU1NLCVlYXgN
CjE6CWFkZGwJLTQoJWNhbGxkZXN0KSwlZWF4DQoJam56CTFiLTEJLy8gb3IgLTIsIC0zLCAtNA0K
CWFkZAkkbnVtX2ZwX2FyZ3MsJWVheAkvLyBJZiBuZWVkZWQgbm9uLXplcm8NCgljYWxsCSVjYWxs
ZGVzdA0KDQpJIHRoaW5rIHRoYXQgYWRkcyAxMCBieXRlcyB0byB0aGUgY2FsbCBzaXRlLg0KQWx0
aG91Z2ggd2l0aCByZXRwb2xpbmUgdGh1bmtzIChhbmQgbm8gZnAgdmFyYXJncyBjYWxscykNCmFs
bCBidXQgdGhlIGluaXRpYWwgbW92bCBjYW4gZ28gaW50byB0aGUgdGh1bmsuDQoNCglEYXZpZA0K
DQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFy
bSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAo
V2FsZXMpDQo=

