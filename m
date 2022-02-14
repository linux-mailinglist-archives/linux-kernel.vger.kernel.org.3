Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777944B4F1F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352557AbiBNLo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:44:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbiBNLoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:44:06 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52996658E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:37:02 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-3-c-H2DoQROpmCBki-_qsGZA-1; Mon, 14 Feb 2022 11:36:59 +0000
X-MC-Unique: c-H2DoQROpmCBki-_qsGZA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Mon, 14 Feb 2022 11:36:58 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Mon, 14 Feb 2022 11:36:58 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Rasmus Villemoes' <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gary Guo <gary@garyguo.net>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        "Petr Mladek" <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Sergey Senozhatsky" <senozhatsky@chromium.org>
Subject: RE: [PATCH v4 12/20] vsprintf: add new `%pA` format specifier
Thread-Topic: [PATCH v4 12/20] vsprintf: add new `%pA` format specifier
Thread-Index: AQHYIZS6su9cmqy/q0KCzLw1maUsHKyS6n8w
Date:   Mon, 14 Feb 2022 11:36:58 +0000
Message-ID: <2a7dff8e0efb4142849802357284af51@AcuMS.aculab.com>
References: <20220212130410.6901-1-ojeda@kernel.org>
 <20220212130410.6901-13-ojeda@kernel.org>
 <YgosclY9ebD3t020@smile.fi.intel.com>
 <dc9054f2-5e2b-0ae2-1022-23421668dd05@rasmusvillemoes.dk>
In-Reply-To: <dc9054f2-5e2b-0ae2-1022-23421668dd05@rasmusvillemoes.dk>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUmFzbXVzIFZpbGxlbW9lcw0KPiBTZW50OiAxNCBGZWJydWFyeSAyMDIyIDEwOjUzDQo+
IA0KPiBPbiAxNC8wMi8yMDIyIDExLjE4LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+ID4gT24g
U2F0LCBGZWIgMTIsIDIwMjIgYXQgMDI6MDM6MzhQTSArMDEwMCwgTWlndWVsIE9qZWRhIHdyb3Rl
Og0KPiA+DQo+ID4+IEZyb206IEdhcnkgR3VvIDxnYXJ5QGdhcnlndW8ubmV0Pg0KPiA+DQo+ID4g
Tm90IHN1cmUgSSB1bmRlcnN0YW5kIHRoaXMuLi4NCj4gPg0KPiA+PiBUaGlzIHBhdGNoIGFkZHMg
YSBmb3JtYXQgc3BlY2lmaWVyIGAlcEFgIHRvIGB2c3ByaW50ZmAgd2hpY2ggZm9ybWF0cw0KPiA+
PiBhIHBvaW50ZXIgYXMgYGNvcmU6OmZtdDo6QXJndW1lbnRzYC4gRG9pbmcgc28gYWxsb3dzIHVz
IHRvIGRpcmVjdGx5DQo+ID4+IGZvcm1hdCB0byB0aGUgaW50ZXJuYWwgYnVmZmVyIG9mIGBwcmlu
dGZgLCBzbyB3ZSBkbyBub3QgaGF2ZSB0byB1c2UNCj4gPj4gYSB0ZW1wb3JhcnkgYnVmZmVyIG9u
IHRoZSBzdGFjayB0byBwcmUtYXNzZW1ibGUgdGhlIG1lc3NhZ2Ugb24NCj4gPj4gdGhlIFJ1c3Qg
c2lkZS4NCj4gPj4NCj4gPj4gVGhpcyBzcGVjaWZpZXIgaXMgaW50ZW5kZWQgb25seSB0byBiZSB1
c2VkIGZyb20gUnVzdCBhbmQgbm90IGZvciBDLCBzbw0KPiA+PiBgY2hlY2twYXRjaC5wbGAgaXMg
aW50ZW50aW9uYWxseSB1bmNoYW5nZWQgdG8gY2F0Y2ggYW55IG1pc3VzZS4NCj4gPj4NCj4gPj4g
Q28tZGV2ZWxvcGVkLWJ5OiBBbGV4IEdheW5vciA8YWxleC5nYXlub3JAZ21haWwuY29tPg0KPiA+
PiBTaWduZWQtb2ZmLWJ5OiBBbGV4IEdheW5vciA8YWxleC5nYXlub3JAZ21haWwuY29tPg0KPiA+
PiBDby1kZXZlbG9wZWQtYnk6IFdlZHNvbiBBbG1laWRhIEZpbGhvIDx3ZWRzb25hZkBnb29nbGUu
Y29tPg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBXZWRzb24gQWxtZWlkYSBGaWxobyA8d2Vkc29uYWZA
Z29vZ2xlLmNvbT4NCj4gPg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBHYXJ5IEd1byA8Z2FyeUBnYXJ5
Z3VvLm5ldD4NCj4gPg0KPiA+IC4uLnRvZ2V0aGVyIHdpdGggdGhpcyBpbiB0aGUgY3VycmVudCBT
b0IgY2hhaW4uDQo+ID4NCj4gPj4gQ28tZGV2ZWxvcGVkLWJ5OiBNaWd1ZWwgT2plZGEgPG9qZWRh
QGtlcm5lbC5vcmc+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IE1pZ3VlbCBPamVkYSA8b2plZGFAa2Vy
bmVsLm9yZz4NCj4gPg0KPiA+IEknbSB3b25kZXJpbmcgaWYgeW91IGNvbnNpZGVyZWQgdG8gdXNl
ICVwVi4NCj4gPg0KPiANCj4gSSB0aGluayB0aGUgcG9pbnQgaXMgZm9yIHZzbnByaW50ZigpIHRv
IGNhbGwgKGJhY2spIGludG8gUnVzdCBjb2RlLg0KDQpEb2Vzbid0IHRoYXQgc3RhbmQgYSByZWFz
b25hYmxlIGNoYW5jZSBvZiBibG93aW5nIHRoZSBrZXJuZWwgc3RhY2s/DQoNCnZzbnByaW50Zigp
IGlzIGxpa2VseSB0byBiZSBvbiB0aGUgJ3dvcnN0IGNhc2UnIHN0YWNrIHBhdGggYW55d2F5Lg0K
QW55dGhpbmcgdmFndWVseSBsaWtlIGEgcmVjdXJzaXZlIGNhbGwsIG9yIGFueXRoaW5nICdzdGFj
ayBleHBlbnNpdmUnDQppbnNpZGUgdnNucHJpbnRmKCkgc3RhbmRzIGEgcmVhbCBjaGFuY2Ugb2Yg
b3ZlcmZsb3dpbmcgdGhlIHN0YWNrLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

