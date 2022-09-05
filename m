Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D6E5AC8B5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 04:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbiIECJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 22:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbiIECJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 22:09:10 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF0B240B6
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 19:09:09 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-2-7NjNYhKRNBaGAOpuBbpbWA-1; Mon, 05 Sep 2022 03:09:03 +0100
X-MC-Unique: 7NjNYhKRNBaGAOpuBbpbWA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Mon, 5 Sep
 2022 03:09:02 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Mon, 5 Sep 2022 03:09:02 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: RE: [PATCH v2 08/59] x86/build: Ensure proper function alignment
Thread-Topic: [PATCH v2 08/59] x86/build: Ensure proper function alignment
Thread-Index: AQHYvtigk9/omh2Ah06qF4OX3TKQBa3QGeEQ
Date:   Mon, 5 Sep 2022 02:09:02 +0000
Message-ID: <5e8527ee9b314ab1883ba4b7887d29e4@AcuMS.aculab.com>
References: <20220902130625.217071627@infradead.org>
 <20220902130947.190618587@infradead.org>
In-Reply-To: <20220902130947.190618587@infradead.org>
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
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUGV0ZXIgWmlqbHN0cmENCj4gU2VudDogMDIgU2VwdGVtYmVyIDIwMjIgMTQ6MDcNCj4g
DQo+IEZyb206IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KPiANCj4gVGhl
IEludGVsIEFyY2hpdGVjdHVyZXMgT3B0aW1pemF0aW9uIFJlZmVyZW5jZSBNYW51YWwgZXhwbGFp
bnMgdGhhdA0KPiBmdW5jdGlvbnMgc2hvdWxkIGJlIGFsaWduZWQgYXQgMTYgYnl0ZXMgYmVjYXVz
ZSBmb3IgYSBsb3Qgb2YgKEludGVsKQ0KPiB1YXJjaHMgdGhlIEktZmV0Y2ggd2lkdGggaXMgMTYg
Ynl0ZXMuIFRoZSBBTUQgU29mdHdhcmUgT3B0aW1pemF0aW9uDQo+IEd1aWRlIChmb3IgcmVjZW50
IGNoaXBzKSBtZW50aW9ucyBhIDMyIGJ5dGUgSS1mZXRjaCB3aW5kb3cgYnV0IGEgMTYNCj4gYnl0
ZSBkZWNvZGUgd2luZG93Lg0KPiANCj4gRm9sbG93IHRoaXMgYWR2aWNlIGFuZCBhbGlnbiBmdW5j
dGlvbnMgdG8gMTYgYnl0ZXMgdG8gb3B0aW1pemUNCj4gaW5zdHJ1Y3Rpb24gZGVsaXZlcnkgdG8g
ZGVjb2RlIGFuZCByZWR1Y2UgZnJvbnQtZW5kIGJvdHRsZW5lY2tzLg0KDQpQZXJmb3JtYW5jZSBm
aWd1cmVzPw0KDQpJSVJDIHRoZSBzYW1lIGRvY3VtZW50IHdpbGwgc3VnZ2VzdCBhbGlnbmluZyBh
bGwganVtcCBsYWJlbHMuDQpUaGF0IGlzIHByZXR0eSBtdWNoIGtub3duIHRvIGJlIGhhcm1mdWwg
YmVjYXVzZSBvZiB0aGUgYmxvYXQNCml0IGdlbmVyYXRlcy4NCg0KQWxzbyB0aGluZ3MgbGlrZSBD
RkkgYW5kIEVOREJSQSBoYXZlIGEgaGFiaXQgb2YgbWFraW5nIHRoZQ0KZW50cnkgcG9pbnQgdW5h
bGlnbmVkIHVubGVzcyB5b3UgY2FuIHBhZCB0byAxNm4reCB2YWx1ZXMuDQoNCglEYXZpZA0KDQot
DQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwg
TWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2Fs
ZXMpDQo=

