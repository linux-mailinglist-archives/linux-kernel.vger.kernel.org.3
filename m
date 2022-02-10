Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664D34B08F8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238084AbiBJI4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:56:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238072AbiBJI4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:56:48 -0500
Received: from mickerik.phytec.de (mickerik.phytec.de [195.145.39.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3C4E7A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 00:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1644483406; x=1647075406;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Lm/71IsbS9y6EkUe+Y9v0qP4rN1NNtNxnb7fv+nNAZc=;
        b=KJ0YIKCk0oagzbeTQwQFSZAGnNl6QaM1iAKwKQWxmLipVakL3eFL31EIZ4BdCuFE
        MkQ6gX8edNZKeNRZ1MYfxuzwfGLsuunW+YXnfxc5qwi7VvN1obq8ZLW4ylcSdoIB
        pFYh8xUJ8UnYPRGQjLED3Xefbvbf6sVrugTXlhgp5QU=;
X-AuditID: c39127d2-93d2170000002a63-56-6204d34ecc47
Received: from Diagnostix.phytec.de (Diagnostix.phytec.de [172.16.0.119])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 26.95.10851.E43D4026; Thu, 10 Feb 2022 09:56:46 +0100 (CET)
Received: from Berlix.phytec.de (172.16.0.117) by Diagnostix.phytec.de
 (172.16.0.119) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 10 Feb
 2022 09:56:45 +0100
Received: from Berlix.phytec.de ([fe80::2d82:c2a2:5905:87c2]) by
 berlix.phytec.de ([fe80::2d82:c2a2:5905:87c2%3]) with mapi id 15.01.2375.018;
 Thu, 10 Feb 2022 09:56:45 +0100
From:   Yunus Bas <Y.Bas@phytec.de>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
CC:     "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH RESEND] Input: tsc200x-core - Add axis inversion and
 swapping support
Thread-Topic: [PATCH RESEND] Input: tsc200x-core - Add axis inversion and
 swapping support
Thread-Index: AQHYHhoGdjqo+NoqVUG1vJQEGDjbHayMa0qA
Date:   Thu, 10 Feb 2022 08:56:45 +0000
Message-ID: <2d9c2dec1b3e78f60f0a42b1f20966d9fad62d63.camel@phytec.de>
References: <20220209223933.1672782-1-y.bas@phytec.de>
         <YgRkXLZpPBpHF2QY@google.com>
In-Reply-To: <YgRkXLZpPBpHF2QY@google.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.0.116]
Content-Type: text/plain; charset="utf-8"
Content-ID: <396C4E59B2B414449BC3D5B9FBC2043D@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWyRoChXNfvMkuSwaTHLBaHF71gtLj56Rur
        xeVdc9gsbk+czGhx5+tzFgdWj52z7rJ7tBx5y+rR/9fA4/MmuQCWKC6blNSczLLUIn27BK6M
        tdsqC/7xVzRtO8rUwHiCv4uRk0NCwESis/cbO4gtJLCOSWL1l4guRi4g+xmjxPmzzcwQziZG
        id5z94AcDg42AUWJK7fyQRpEBKwlDuzrYAOxmQV+MEo8OeUBYgsLREssvLGdGaImRqKv6yGU
        bSTx+Mw9RhCbRUBV4smHq0wgNq+Am8SrZdvZII4Il1i5eA8riM0poCWx+skjFhCbUUBWYsOG
        88wQu8QlNj37zgrxgIDEkj0QcQkBUYmXj/9BxRUk2no6mUBOZhbQlFi/Sx+i1UJi8vd+Vghb
        UWJK90N2iBMEJU7OfMIygVF8FpINsxC6ZyHpnoWkexaS7gWMrKsYhXIzk7NTizKz9QoyKktS
        k/VSUjcxAiPy8ET1SzsY++Z4HGJk4mA8xCjBwawkwnuqnjlJiDclsbIqtSg/vqg0J7X4EKM0
        B4uSOO/9HqZEIYH0xJLU7NTUgtQimCwTB6dUA2Pfj/+mf5cq6moKRC6QOh+9Z3IHY1eOqt6K
        byqWe6bzXgmKPsQqUj/xi+Rs6dOirxV2y7BJN9UwHtjY3i+veZxrhbdUHo9WhK/3h9tPT2tb
        SlZxTLJhXLP1wUp3pzeecdXqN5Rq+Fpk13SuXR+QvlRrxRfbQFk+W/ezpVy1JuZJ/L4ym3/p
        KrEUZyQaajEXFScCALJ4ySC2AgAA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRG1pdHJ5LA0KDQpBbSBNaXR0d29jaCwgZGVtIDA5LjAyLjIwMjIgdW0gMTc6MDMgLTA4MDAg
c2NocmllYiBEbWl0cnkgVG9yb2tob3Y6DQo+IE9uIFdlZCwgRmViIDA5LCAyMDIyIGF0IDExOjM5
OjMzUE0gKzAxMDAsIFl1bnVzIEJhcyB3cm90ZToNCj4gPiBTaW5jZSBDb21taXQgZWQ3Yzk4NzBj
OWJjICgiSW5wdXQ6IG9mX3RvdWNoc2NyZWVuIC0gYWRkIHN1cHBvcnQgZm9yDQo+ID4gaW52ZXJ0
ZWQgLyBzd2FwcGVkIGF4ZXMiKSwgdGhlIG9mX3RvdWNoc2NyZWVuIGludGVyZmFjZSBzdXBwb3J0
cw0KPiA+IGF4aXMNCj4gPiBpbnZlcnRpbmcgYW5kIHN3YXBwaW5nIHRocm91Z2ggRGV2aWNldHJl
ZSBwcm9wZXJ0aWVzLiBNYWtlIHVzZSBvZg0KPiA+IHRoaXMNCj4gPiBmZWF0dXJlLg0KPiA+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IFl1bnVzIEJhcyA8eS5iYXNAcGh5dGVjLmRlPg0KPiANCj4gQXBw
bGllZCwgdGhhbmsgeW91LCBob3dldmVyIEkgYmVsaWV2ZSB3ZSBhbHNvIG5lZWQgdG8gYWRqdXN0
DQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnB1dC90b3VjaHNjcmVlbi90
aSx0c2MyMDA1LnlhbWxpDQo+IHRvDQo+IGFsbG93IHRoZXNlIHByb3BlcnRpZXMuDQoNClRoYW5r
IHlvdSBmb3IgdGhlIG5vdGUuIEkgd2lsbCB1cGRhdGUgdGhlIGRvY3VtZW50YXRpb24gQVNBUCBh
bmQgc2VuZCBhDQp2Mi4NCg0KUmVnYXJkcw0KWXVudXMNCg0KPiANCj4gVGhhbmtzLg0KPiANCg0K
LS0gDQotU29mdHdhcmUgRW50d2lja2x1bmctDQpQSFlURUMgTWVzc3RlY2huaWsgR21iSA0KUm9i
ZXJ0LUtvY2gtU3RyLiAzOQ0KNTUxMjkgTWFpbnoNCkdlcm1hbnkNClRlbC46ICs0OSAoMCk2MTMx
IDkyMjEtNDY2DQpXZWI6IHd3dy5waHl0ZWMuZGUNCg0KU2llIGZpbmRlbiB1bnMgYXVjaCBhdWY6
IEZhY2Vib29rLCBMaW5rZWRJbiwgWGluZywgWW91VHViZQ0KDQpQSFlURUMgTWVzc3RlY2huaWsg
R21iSCB8IFJvYmVydC1Lb2NoLVN0ci4gMzkgfCA1NTEyOSBNYWlueiwgR2VybWFueQ0KR2VzY2jD
pGZ0c2bDvGhyZXI6IERpcGwuLUluZy4gTWljaGFlbCBNaXRlemtpLCBEaXBsLi1JbmcuIEJvZG8g
SHViZXIgfA0KSGFuZGVsc3JlZ2lzdGVyIE1haW56IEhSQiA0NjU2IHwgRmluYW56YW10IE1haW56
IHwgU3QuTnIuIDI2NjUwMDYwOCwgREUNCjE0OTA1OTg1NQ0KVGhpcyBFLU1haWwgbWF5IGNvbnRh
aW4gY29uZmlkZW50aWFsIG9yIHByaXZpbGVnZWQgaW5mb3JtYXRpb24uIElmIHlvdQ0KYXJlIG5v
dCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50IChvciBoYXZlIHJlY2VpdmVkIHRoaXMgRS1NYWlsIGlu
IGVycm9yKQ0KcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkZXN0cm95
IHRoaXMgRS1NYWlsLiBBbnkNCnVuYXV0aG9yaXplZCBjb3B5aW5nLCBkaXNjbG9zdXJlIG9yIGRp
c3RyaWJ1dGlvbiBvZiB0aGUgbWF0ZXJpYWwgaW4NCnRoaXMgRS1NYWlsIGlzIHN0cmljdGx5IGZv
cmJpZGRlbi4NCg==
