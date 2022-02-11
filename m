Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECF84B2A92
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351609AbiBKQkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:40:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiBKQkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:40:08 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C03DFD
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:40:06 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-160-wZ1-VjIMOoK4So3RgiPxRg-1; Fri, 11 Feb 2022 16:40:03 +0000
X-MC-Unique: wZ1-VjIMOoK4So3RgiPxRg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Fri, 11 Feb 2022 16:40:01 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Fri, 11 Feb 2022 16:40:01 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Bill Wendling' <morbo@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] x86: use builtins to read eflags
Thread-Topic: [PATCH v4] x86: use builtins to read eflags
Thread-Index: AQHYHs4TBErQZHLpBUiy6+9ZW5FRHqyOjNCA
Date:   Fri, 11 Feb 2022 16:40:01 +0000
Message-ID: <cb2ff5da9b704a9792549a9433dc0ac8@AcuMS.aculab.com>
References: <20220204005742.1222997-1-morbo@google.com>
 <20220210223134.233757-1-morbo@google.com>
In-Reply-To: <20220210223134.233757-1-morbo@google.com>
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

RnJvbTogQmlsbCBXZW5kbGluZw0KPiBTZW50OiAxMCBGZWJydWFyeSAyMDIyIDIyOjMyDQo+IA0K
PiBHQ0MgYW5kIENsYW5nIGJvdGggaGF2ZSBidWlsdGlucyB0byByZWFkIGFuZCB3cml0ZSB0aGUg
RUZMQUdTIHJlZ2lzdGVyLg0KPiBUaGlzIGFsbG93cyB0aGUgY29tcGlsZXIgdG8gZGV0ZXJtaW5l
IHRoZSBiZXN0IHdheSB0byBnZW5lcmF0ZSB0aGlzDQo+IGNvZGUsIHdoaWNoIGNhbiBpbXByb3Zl
IGNvZGUgZ2VuZXJhdGlvbi4NCj4gDQo+IFRoaXMgaXNzdWUgYXJvc2UgZHVlIHRvIENsYW5nJ3Mg
aXNzdWUgd2l0aCB0aGUgIj1ybSIgY29uc3RyYWludC4gIENsYW5nDQo+IGNob29zZXMgdG8gYmUg
Y29uc2VydmF0aXZlIGluIHRoZXNlIHNpdHVhdGlvbnMsIGFuZCBzbyB1c2VzIG1lbW9yeQ0KPiBp
bnN0ZWFkIG9mIHJlZ2lzdGVycy4gVGhpcyBpcyBhIGtub3duIGlzc3VlLCB3aGljaCBpcyBjdXJy
ZW50bHkgYmVpbmcNCj4gYWRkcmVzc2VkLg0KPiANCj4gSG93ZXZlciwgdXNpbmcgYnVpbHRpbnMg
aXMgYmVuZWZpY2lhbCBpbiBnZW5lcmFsLCBiZWNhdXNlIGl0IHJlbW92ZXMgdGhlDQo+IGJ1cmRl
biBvZiBkZXRlcm1pbmluZyB3aGF0J3MgdGhlIHdheSB0byByZWFkIHRoZSBmbGFncyByZWdpc3Rl
ciBmcm9tIHRoZQ0KPiBwcm9ncmFtbWVyIGFuZCBwbGFjZXMgaXQgb24gdG8gdGhlIGNvbXBpbGVy
LCB3aGljaCBoYXMgdGhlIGluZm9ybWF0aW9uDQo+IG5lZWRlZCB0byBtYWtlIHRoYXQgZGVjaXNp
b24uDQoNCkV4Y2VwdCB0aGF0IG5laXRoZXIgZ2NjIG5vciBjbGFuZyBhdHRlbXB0IHRvIG1ha2Ug
dGhhdCBkZWNpc2lvbi4NClRoZXkgYWx3YXlzIGRvIHB1c2hmOyBwb3AgYXg7DQoNCi4uLg0KPiB2
NDogLSBDbGFuZyBub3cgbm8gbG9uZ2VyIGdlbmVyYXRlcyBzdGFjayBmcmFtZXMgd2hlbiB1c2lu
ZyB0aGVzZSBidWlsdGlucy4NCj4gICAgIC0gQ29ycmVjdGVkIG1pc3NwZWxsaW5ncy4NCg0KV2hp
bGUgY2xhbmcgJ2hlYWQnIGhhcyBiZWVuIGZpeGVkLCBpdCBzZWVtcyBhIGJpdCBwcmVtYXR1cmUg
dG8gc2F5DQppdCBpcyAnZml4ZWQnIGVub3VnaCBmb3IgYWxsIGNsYW5nIGJ1aWxkcyB0byB1c2Ug
dGhlIGJ1aWx0aW4uDQoNClNlZW1zIGJldHRlciB0byBjaGFuZ2UgaXQgKGJhY2spIHRvICI9ciIg
YW5kIGNvbW1lbnQgdGhhdCB0aGlzDQppcyBjdXJyZW50bHkgYXMgZ29vZCBhcyBfX2J1aWx0aW5f
aWEzMl9yZWFkZWZsYWdzX3U2NCgpIGFuZCB0aGF0DQpjbGFuZyBtYWtlcyBhICdwaWdzIGJyZWFr
ZmFzdCcgb2YgIj1ybSIgLSB3aGljaCBoYXMgb25seSBtYXJnaW5hbA0KYmVuZWZpdC4NCg0KQ2hh
bmdpbmcgdG8gX19idWlsdGluX2lhMzJfcmVhZGVmbGFnc191NjQoKSBtYXkgYmUgd29ydGggd2hp
bGUNCmlmL3doZW4gdGhlIGNvbXBpbGVycyB3aWxsIGdlbmVyYXRlIHB1c2hmOyBwb3AgbWVtOyBm
b3IgaXQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1s
ZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJh
dGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

