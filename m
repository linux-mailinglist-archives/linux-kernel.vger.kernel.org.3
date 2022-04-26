Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC9A50EE08
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 03:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240788AbiDZBUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 21:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiDZBUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 21:20:30 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE031002D0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 18:17:23 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 355EE2C0654;
        Tue, 26 Apr 2022 01:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1650935840;
        bh=WyGkMWM/IN0eUW63LpFB7ALD7XlTCMGRwyMoAjCcpZo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=IoxWT/pr9LT2AgRmkHEkAZmx6f2BEqmFL2Q+KGcyARZYM/XxzxeVodt1FmReN6BTj
         qJHOvod7KBc9S8oyLxH7ffLKJIop9EJ/aV2LjnWqds84yMNCw+MndgYfC5vGu6hXkU
         f5180LP8QIyxa6+VzRnsEJpCRqHpyT/RluJOX73qteq53gniJiNLhyEPAd6bKzVyIi
         4kv0zPO/f3loz4zYMDrXwgULXf50d2pz23SAQRqvAKDPR9Js2WXK2QDJuRdU4ilRXt
         LSv68GRisw4yGjkL6gpQCVClAFTV1LRZjimYvmOWiUwDRvJLXB9/xLIqNe0nZo9AvR
         5kiQbtTO+eETw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B626748200001>; Tue, 26 Apr 2022 13:17:20 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 26 Apr 2022 13:17:19 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Tue, 26 Apr 2022 13:17:19 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>
CC:     "jason@lakedaemon.net" <jason@lakedaemon.net>,
        Joshua Scott <Joshua.Scott@alliedtelesis.co.nz>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: mvebu: Enable MBUS error propagation
Thread-Topic: [PATCH] ARM: mvebu: Enable MBUS error propagation
Thread-Index: AQHVoqqJx9twrZNTn0+9dczHY+j8Sqff+80AgyWuXKeB+2bPKIAE90KA
Date:   Tue, 26 Apr 2022 01:17:19 +0000
Message-ID: <c0c19d40-58b3-af51-40e9-0b44578c04f5@alliedtelesis.co.nz>
References: <20191124093529.32399-1-chris.packham@alliedtelesis.co.nz>
 <8736cqb63d.fsf@FE-laptop>
 <0285a09b2b1b7ae2ccc268a37e4357c95d270ac9.camel@alliedtelesis.co.nz>
 <20210603125525.nkswvixbabkgq5or@pali>
 <e75b74fa-b393-fede-1a19-fd43dbb7aba4@alliedtelesis.co.nz>
 <20220422092700.3j7boazeubccdhcr@pali>
In-Reply-To: <20220422092700.3j7boazeubccdhcr@pali>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D925441BA830A49AE0E869DFA5FCA87@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=C7GXNjH+ c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=z0gMJWrwH1QA:10 a=NEAV23lmAAAA:8 a=62ntRvTiAAAA:8 a=YfCOm-DyAAAA:8 a=gBHFopuxQ95XasnusvEA:9 a=QEXdDO2ut3YA:10 a=N53muDpBR4cA:10 a=pToNdpNmrtiFLRE6bQ9Z:22 a=zQLMK8awuJ6_Hvp-_9Ux:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAyMi8wNC8yMiAyMToyNywgUGFsaSBSb2jDoXIgd3JvdGU6DQo+IE9uIFRodXJzZGF5IDAz
IEp1bmUgMjAyMSAyMTowMzo1NSBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4gT24gNC8wNi8yMSAx
Mjo1NSBhbSwgUGFsaSBSb2jDoXIgd3JvdGU6DQo+Pj4gT24gV2VkbmVzZGF5IDA4IEphbnVhcnkg
MjAyMCAxOTo0MjoxMiBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4+PiBIaSBHcmVnb3J5LA0KPj4+
Pg0KPj4+PiBPbiBXZWQsIDIwMjAtMDEtMDggYXQgMTE6MjIgKzAxMDAsIEdyZWdvcnkgQ0xFTUVO
VCB3cm90ZToNCj4+Pj4+IEhlbGxvIENocmlzLA0KPj4+Pj4NCj4+Pj4+PiBVLWJvb3QgZGlzYWJs
ZXMgTUJVUyBlcnJvciBwcm9wYWdhdGlvbiBmb3IgQXJtYWRhLTM4NS4gVGhlIGVmZmVjdCBvZg0K
Pj4+Pj4+IHRoaXMgb24gdGhlIGtlcm5lbCBpcyB0aGF0IGFueSBhY2Nlc3MgdG8gYSBtYXBwZWQg
YnV0IGluYWNjZXNzaWJsZQ0KPj4+Pj4+IGFkZHJlc3MgY2F1c2VzIHRoZSBzeXN0ZW0gdG8gaGFu
Zy4NCj4+Pj4+Pg0KPj4+Pj4+IEJ5IGVuYWJsaW5nIE1CVVMgZXJyb3IgcHJvcGFnYXRpb24gdGhl
IGtlcm5lbCBjYW4gcmFpc2UgYSBCdXMgRXJyb3IgYW5kDQo+Pj4+Pj4gcGFuaWMgdG8gcmVzdGFy
dCB0aGUgc3lzdGVtLg0KPj4+Pj4gVW5sZXNzIEkgbWlzcyBpdCwgaXQgc2VlbXMgdGhhdCBub2Jv
ZHkgY29tbWVudCB0aGlzIHBhdGNoOiBzb3JyeSBmb3IgdGhlDQo+Pj4+PiBkZWxheS4NCj4+Pj4+
DQo+Pj4+IFRoYW5rcyBmb3IgdGhlIHJlc3BvbnNlLg0KPj4+Pg0KPj4+Pj4+IFNpZ25lZC1vZmYt
Ynk6IENocmlzIFBhY2toYW0gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4NCj4+
Pj4+PiAtLS0NCj4+Pj4+Pg0KPj4+Pj4+IE5vdGVzOg0KPj4+Pj4+ICAgICAgIFdlJ3ZlIGVuY291
bnRlcmVkIGFuIGlzc3VlIHdoZXJlIHJvZ3VlIGFjY2Vzc2VzIHRvIFBDSS1lIHNwYWNlIGNhdXNl
IGFuDQo+Pj4+Pj4gICAgICAgQXJtYWRhLTM4NSBzeXN0ZW0gdG8gbG9ja3VwLiBXZSd2ZSBmb3Vu
ZCB0aGF0IGVuYWJsaW5nIE1CVVMgZXJyb3INCj4+Pj4+PiAgICAgICBwcm9wYWdhdGlvbiBsZXRz
IHVzIGdldCBhIGJ1cyBlcnJvciB3aGljaCBhdCBsZWFzdCBnaXZlcyB1cyBhIHBhbmljIHRvDQo+
Pj4+Pj4gICAgICAgaGVscCBpZGVudGlmeSB3aGF0IHdhcyBhY2Nlc3NlZC4NCj4+Pj4+PiAgICAg
ICANCj4+Pj4+PiAgICAgICBVLWJvb3QgY2xlYXJzIHRoZSBJTyBFcnIgUHJvcCBFbmFibGUgQml0
WzFdIGJ1dCBzbyBmYXIgbm8tb25lIHNlZW1zIHRvDQo+Pj4+Pj4gICAgICAga25vdyB3aHkuDQo+
Pj4+Pj4gICAgICAgDQo+Pj4+Pj4gICAgICAgSSB3YXNuJ3Qgc3VyZSB3aGVyZSB0byBwdXQgdGhp
cyBjb2RlLiBUaGVyZSBpcyBzaW1pbGFyIGNvZGUgZm9yIGtpcndvb2QNCj4+Pj4+PiAgICAgICBp
biB0aGUgZXF1aXZhbGVudCBkdF9pbml0IGZ1bmN0aW9uLiBPbiBBcm1hZGEtWFAgdGhlIHJlZ2lz
dGVyIGlzIHBhcnQgb2YNCj4+Pj4+PiAgICAgICB0aGUgQ29yZSBDb2hlcmVuY3kgRmFicmljIGJs
b2NrIChmb3IgQTM4NSBpdCdzIGRvY3VtZW50ZWQgYXMgcGFydCBvZiB0aGUNCj4+Pj4+PiAgICAg
ICBDQ0YgYmxvY2spLg0KPj4+Pj4gV2hhdCBhYm91dCBhZGRpbmcgYSBuZXcgc2V0IG9mIHJlZ2lz
dGVyIHRvIHRoZSBtdmVidSBtYnVzIGRyaXZlcj8NCj4+Pj4+DQo+Pj4+IEFmdGVyIG1vcmUgdGVz
dGluZyB3ZSBmb3VuZCB0aGF0IHNvbWUgcHJldmlvdXNseSAiZ29vZCIgYm9hcmRzIHN0YXJ0ZWQN
Cj4+Pj4gdGhyb3dpbmcgdXAgcGFuaWNzIHdpdGggdGhpcyBjaGFuZ2UuIEkgdGhpbmsgdGhhdCB0
aGlzIG1pZ2h0IHJlcXVpcmUNCj4+Pj4gaGFuZGxpbmcgc29tZSBvZiB0aGUgUENJLWUgaW50ZXJy
dXB0cyAoZm9yIGNvcnJlY3RhYmxlIGVycm9ycykgdmlhIHRoZQ0KPj4+PiBFREFDIHN1YnN5c3Rl
bS4NCj4+Pj4NCj4+Pj4gV2UncmUgc3RpbGwgd29ya2luZyB3aXRoIE1hcnZlbGwgdG8gdHJhY2sg
ZG93biBleGFjdGx5IHdoeSB0aGlzIGlzDQo+Pj4+IGhhcHBlbmluZyBvbiBvdXIgc3lzdGVtLg0K
Pj4+IEhlbGxvIENocmlzISBIYXZlIHlvdSBzb21laG93IHNvbHZlZCB0aGlzIGlzc3VlPyBPciBk
byB5b3UgaGF2ZSBzb21lDQo+Pj4gY29udGFjdHMgaW4gTWFydmVsbCBmb3IgQTM4NSBQQ0llIHN1
YnN5c3RlbT8NCj4+IFRoZSBwcm9ibGVtIHNlZW1lZCB0byBiZSBhIHNwZWNpZmljIENQVSBFcnJh
dHVtIGZvciB0aGUgQTM4NSB3aGljaCBJDQo+PiBicm91Z2h0IGludG8gdXBzdHJlYW0gdS1ib290
WzFdLg0KPiBIZWxsbyBDaHJpcywgY291bGQgeW91IHBvaW50IG1lIHRvIHRoaXMgQ1BVIEVycmF0
dW0/IFdoYXQgaXMgaXRzIG51bWJlcg0KPiBvciBzb21lIG90aGVyIGlkZW50aWZpZXI/IEJlY2F1
c2UgSSdtIHVuYWJsZSB0byBmaW5kIGFueSBzdWNoIGVycmF0dW0gaW4NCj4gdGhlIGxpc3QgZm9y
IEEzODUgZXJyYXR1bXMuDQoNCkkgaGF2ZW4ndCBzZWVuIHRoZSBhY3R1YWwgZXJyYXRhIGVpdGhl
ci4gTXkgY29tbWVudCBpcyBiYXNlZCBvbiB0aGUgDQpmb2xsb3dpbmcgY2hhbmdlIGZyb20gb25l
IG9mIE1hcnZlbGwncyB1LWJvb3QgZm9ya3MNCg0KaHR0cHM6Ly9naXRodWIuY29tL01hcnZlbGxF
bWJlZGRlZFByb2Nlc3NvcnMvdS1ib290LW1hcnZlbGwvY29tbWl0LzIwY2QyNzA0MDcyNTEyZGUx
NzZlMDQ4OTcwZjI4ODNkYjkwMTY3NGINCg0KSXQganVzdCBzYXlzICJFUlJBVEEjIFRCRCIuIFBl
cmhhcHMgdGhleSBqdXN0IGhhdmVuJ3QgcHVibGlzaGVkIGEgbmV3IA0KZG9jdW1lbnQgKGxhdGVz
dCBJIGNhbiBmaW5kIGlzIFJldiBEIGZyb20gMjAxNikgb3IgdGhleSBkZWNpZGVkIGl0IHdhcyBh
IA0KU1cgYnVnIGFuZCBkaWRuJ3QgYXNzaWduIGl0IGFuIG9mZmljaWFsIGVycmF0YSBudW1iZXIu
DQoNCj4+IEJ1dCBldmVuIHRoZW4gd2UgaGFkIHRvIHVwZGF0ZSBvdXIgYmFzZQ0KPj4gdS1ib290
IHZlcnNpb24gZnJvbSAyMDE2LjExIHRvIDIwMTkuMTAgc28gdGhlcmUgbWF5IGhhdmUgYmVlbiBt
b3JlIGdvaW5nDQo+PiBvbiB0aGFuIGp1c3QgdGhhdCBvbmUgY2hhbmdlLg0KPj4NCj4+IFsxXSAt
DQo+PiBodHRwczovL3NjYW5tYWlsLnRydXN0d2F2ZS5jb20vP2M9MjA5ODgmZD04ZlRpNGgyTWpQ
VktTZ2tlZ09EbXRMdHVCY0llaVoyaFhHbDlEdWxIN0EmdT1odHRwcyUzYSUyZiUyZnNvdXJjZSUy
ZWRlbnglMmVkZSUyZnUtYm9vdCUyZnUtYm9vdCUyZi0lMmZjb21taXQlMmZhZDkxZmRmZmYwYmQ2
ZWE0NzFhZmU4MzhlMGY2ZDU4ZWQ4OTg2OTRlDQo+Pg0KPj4+Pj4gSW4gdGhpcyBjYXNlIGl0IHdp
bGwgYmUgY2FsbGVkIGV2ZW4gZWFybGllciBhbGxvd2luZyB0byBzZWUgYnVzIGVycm9yDQo+Pj4+
PiBlYXJsaWVyLg0KPj4+Pj4NCj4+Pj4+IEluIGFueSBjYXNlLCB5b3Ugc2hvdWxkIHNlcGFyYXRl
IHRoZSBkZXZpY2UgdHJlZSBjaGFuZ2UgZnJvbSB0aGUgY29kZQ0KPj4+Pj4gY2hhbmdlIGFuZCBh
dCBsZWFzdCBwcm92aWRlIDIgcGF0Y2hlcy4NCj4+Pj4gQWdyZWVkLiBJZi93aGVuIHNvbWV0aGlu
ZyBzb2xpZCBldmVudHVhdGVzIHdlJ2xsIGRvIGl0IGFzIGEgcHJvcGVyDQo+Pj4+IHNlcmllcy4N
Cj4+Pj4NCj4+Pj4+IEdyZWdvcnkNCj4+Pj4+DQo+Pj4+Pj4gICAgICAgDQo+Pj4+Pj4gICAgICAg
LS0NCj4+Pj4+PiAgICAgICBbMV0gLSBodHRwczovL3NjYW5tYWlsLnRydXN0d2F2ZS5jb20vP2M9
MjA5ODgmZD04ZlRpNGgyTWpQVktTZ2tlZ09EbXRMdHVCY0llaVoyaFhHbC1YNzVKNUEmdT1odHRw
cyUzYSUyZiUyZmdpdGxhYiUyZWRlbnglMmVkZSUyZnUtYm9vdCUyZnUtYm9vdCUyZmJsb2IlMmZt
YXN0ZXIlMmZhcmNoJTJmYXJtJTJmbWFjaC1tdmVidSUyZmNwdSUyZWMlMjNMNDg5DQo+PiBeXl4g
c29ycnksIGFzIGEgcmVzdWx0IG9mIGEgcmVhc29uYWJseSBoaWdoIHByb2ZpbGUgY3liZXIgYXR0
YWNrIG9uIGENCj4+IGxvY2FsIGluc3RpdHV0aW9uIFVSTHMgaW4gb3VyIGluY29taW5nIG1haWwg
YXJlIGludGVyY2VwdGVkLg0KPj4+Pj4+ICAgIGFyY2gvYXJtL2Jvb3QvZHRzL2FybWFkYS0zOHgu
ZHRzaSB8ICA1ICsrKysrDQo+Pj4+Pj4gICAgYXJjaC9hcm0vbWFjaC1tdmVidS9ib2FyZC12Ny5j
ICAgIHwgMjcgKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4+Pj4gICAgMiBmaWxlcyBj
aGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspDQo+Pj4+Pj4NCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vYm9vdC9kdHMvYXJtYWRhLTM4eC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXJtYWRh
LTM4eC5kdHNpDQo+Pj4+Pj4gaW5kZXggM2Y0YmI0NGQ4NWYwLi4zMjE0YzY3NDMzZWIgMTAwNjQ0
DQo+Pj4+Pj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvYXJtYWRhLTM4eC5kdHNpDQo+Pj4+Pj4g
KysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXJtYWRhLTM4eC5kdHNpDQo+Pj4+Pj4gQEAgLTM4Niw2
ICszODYsMTEgQEANCj4+Pj4+PiAgICAJCQkJICAgICAgPDB4MjAyNTAgMHg4PjsNCj4+Pj4+PiAg
ICAJCQl9Ow0KPj4+Pj4+ICAgIA0KPj4+Pj4+ICsJCQlpb2VycmM6IGlvLWVyci1jb250cm9sQDIw
MjAwIHsNCj4+Pj4+PiArCQkJCWNvbXBhdGlibGUgPSAibWFydmVsbCxpby1lcnItY29udHJvbCI7
DQo+Pj4+Pj4gKwkJCQlyZWcgPSA8MHgyMDIwMCAweDQ+Ow0KPj4+Pj4+ICsJCQl9Ow0KPj4+Pj4+
ICsNCj4+Pj4+PiAgICAJCQltcGljOiBpbnRlcnJ1cHQtY29udHJvbGxlckAyMGEwMCB7DQo+Pj4+
Pj4gICAgCQkJCWNvbXBhdGlibGUgPSAibWFydmVsbCxtcGljIjsNCj4+Pj4+PiAgICAJCQkJcmVn
ID0gPDB4MjBhMDAgMHgyZDA+LCA8MHgyMTA3MCAweDU4PjsNCj4+Pj4+PiBkaWZmIC0tZ2l0IGEv
YXJjaC9hcm0vbWFjaC1tdmVidS9ib2FyZC12Ny5jIGIvYXJjaC9hcm0vbWFjaC1tdmVidS9ib2Fy
ZC12Ny5jDQo+Pj4+Pj4gaW5kZXggZDJkZjVlZjkzODJiLi5mYjc3MTgzODZlZjkgMTAwNjQ0DQo+
Pj4+Pj4gLS0tIGEvYXJjaC9hcm0vbWFjaC1tdmVidS9ib2FyZC12Ny5jDQo+Pj4+Pj4gKysrIGIv
YXJjaC9hcm0vbWFjaC1tdmVidS9ib2FyZC12Ny5jDQo+Pj4+Pj4gQEAgLTEzOCwxMCArMTM4LDM2
IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBpMmNfcXVpcmsodm9pZCkNCj4+Pj4+PiAgICAJfQ0KPj4+
Pj4+ICAgIH0NCj4+Pj4+PiAgICANCj4+Pj4+PiArI2RlZmluZSBNQlVTX0VSUl9QUk9QX0VOIEJJ
VCg4KQ0KPj4+Pj4+ICsNCj4+Pj4+PiArLyoNCj4+Pj4+PiArICogVS1ib290IGRpc2FibGVzIE1C
VVMgZXJyb3IgcHJvcGFnYXRpb24uIFJlLWVuYWJsZSBpdCBzbyB3ZQ0KPj4+Pj4+ICsgKiBjYW4g
aGFuZGxlIHRoZW0gYXMgQnVzIEVycm9ycy4NCj4+Pj4+PiArICovDQo+Pj4+Pj4gK3N0YXRpYyB2
b2lkIF9faW5pdCBlbmFibGVfbWJ1c19lcnJvcl9wcm9wYWdhdGlvbih2b2lkKQ0KPj4+Pj4+ICt7
DQo+Pj4+Pj4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0NCj4+Pj4+PiArCQlvZl9maW5kX2Nv
bXBhdGlibGVfbm9kZShOVUxMLCBOVUxMLCAibWFydmVsbCxpby1lcnItY29udHJvbCIpOw0KPj4+
Pj4+ICsNCj4+Pj4+PiArCWlmIChucCkgew0KPj4+Pj4+ICsJCXZvaWQgX19pb21lbSAqcmVnOw0K
Pj4+Pj4+ICsNCj4+Pj4+PiArCQlyZWcgPSBvZl9pb21hcChucCwgMCk7DQo+Pj4+Pj4gKwkJaWYg
KHJlZykgew0KPj4+Pj4+ICsJCQl1MzIgdmFsOw0KPj4+Pj4+ICsNCj4+Pj4+PiArCQkJdmFsID0g
cmVhZGxfcmVsYXhlZChyZWcpOw0KPj4+Pj4+ICsJCQl3cml0ZWxfcmVsYXhlZCh2YWwgfCBNQlVT
X0VSUl9QUk9QX0VOLCByZWcpOw0KPj4+Pj4+ICsJCX0NCj4+Pj4+PiArCQlvZl9ub2RlX3B1dChu
cCk7DQo+Pj4+Pj4gKwl9DQo+Pj4+Pj4gK30NCj4+Pj4+PiArDQo+Pj4+Pj4gICAgc3RhdGljIHZv
aWQgX19pbml0IG12ZWJ1X2R0X2luaXQodm9pZCkNCj4+Pj4+PiAgICB7DQo+Pj4+Pj4gICAgCWlm
IChvZl9tYWNoaW5lX2lzX2NvbXBhdGlibGUoIm1hcnZlbGwsYXJtYWRheHAiKSkNCj4+Pj4+PiAg
ICAJCWkyY19xdWlyaygpOw0KPj4+Pj4+ICsJZW5hYmxlX21idXNfZXJyb3JfcHJvcGFnYXRpb24o
KTsNCj4+Pj4+PiAgICB9DQo+Pj4+Pj4gICAgDQo+Pj4+Pj4gICAgc3RhdGljIHZvaWQgX19pbml0
IGFybWFkYV8zNzBfeHBfZHRfZml4dXAodm9pZCkNCj4+Pj4+PiBAQCAtMTkxLDYgKzIxNyw3IEBA
IERUX01BQ0hJTkVfU1RBUlQoQVJNQURBXzM4WF9EVCwgIk1hcnZlbGwgQXJtYWRhIDM4MC8zODUg
KERldmljZSBUcmVlKSIpDQo+Pj4+Pj4gICAgCS5sMmNfYXV4X3ZhbAk9IDAsDQo+Pj4+Pj4gICAg
CS5sMmNfYXV4X21hc2sJPSB+MCwNCj4+Pj4+PiAgICAJLmluaXRfaXJxICAgICAgID0gbXZlYnVf
aW5pdF9pcnEsDQo+Pj4+Pj4gKwkuaW5pdF9tYWNoaW5lCT0gbXZlYnVfZHRfaW5pdCwNCj4+Pj4+
PiAgICAJLnJlc3RhcnQJPSBtdmVidV9yZXN0YXJ0LA0KPj4+Pj4+ICAgIAkuZHRfY29tcGF0CT0g
YXJtYWRhXzM4eF9kdF9jb21wYXQsDQo+Pj4+Pj4gICAgTUFDSElORV9FTkQNCj4+Pj4+PiAtLSAN
Cj4+Pj4+PiAyLjI0LjANCj4+Pj4+Pg==
