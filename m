Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237514787E6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbhLQJkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 04:40:18 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:52142 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231424AbhLQJkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:40:17 -0500
X-UUID: 739e4f17ed6344d8b57e2ec7e346b916-20211217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=LFuvPDvVS7YXcoMdMdzOjSmOP3E+q15kLCf4Y2V8vIc=;
        b=lJ/qNDefG158NJQf/f+jeyZEKB5aSq8cpoZp2DZReS47XgS+St4mbcqMEH19a312jzSPdILwyyyKhpnoj3m6Zbq394Y6ldalfCYE0E4IMaP7bbixgsYGF++2jn67dYJdT+TVUheFT8w6HfwxjXH4nSNc02RqeqfG6G1N1FVgJj4=;
X-UUID: 739e4f17ed6344d8b57e2ec7e346b916-20211217
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1906484326; Fri, 17 Dec 2021 17:40:15 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Dec 2021 17:40:14 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 17 Dec 2021 17:40:13 +0800
Message-ID: <609eb0eea02b2304f427d4f2e9c26de9f2149f06.camel@mediatek.com>
Subject: Re: [PATCH] usb: xhci: skip re-check pending port event if
 hibernated
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Jun Li <lijun.kernel@gmail.com>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Yun-Chien Yu <yun-chien.yu@mediatek.com>
Date:   Fri, 17 Dec 2021 17:40:15 +0800
In-Reply-To: <e7a6e45e-68ce-54a5-9632-80244dd1e4c7@linux.intel.com>
References: <20211209072218.21651-1-chunfeng.yun@mediatek.com>
         <c448da77-f2f3-8b79-fc4b-b9dcff727c6e@linux.intel.com>
         <CAKgpwJXxtLwOjxjg3vFHiqS92j6rx_b1+C-bRwDnp+PBvXCMTg@mail.gmail.com>
         <e7a6e45e-68ce-54a5-9632-80244dd1e4c7@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTEyLTE0IGF0IDEyOjA1ICswMjAwLCBNYXRoaWFzIE55bWFuIHdyb3RlOg0K
PiBPbiAxNC4xMi4yMDIxIDEwLjAwLCBKdW4gTGkgd3JvdGU6DQo+ID4gTWF0aGlhcyBOeW1hbiA8
bWF0aGlhcy5ueW1hbkBsaW51eC5pbnRlbC5jb20+IOS6jjIwMjHlubQxMuaciDEx5pel5ZGo5YWt
DQo+ID4gMDE6NTblhpnpgZPvvJoNCj4gPiA+IA0KPiA+ID4gT24gOS4xMi4yMDIxIDkuMjIsIENo
dW5mZW5nIFl1biB3cm90ZToNCj4gPiA+ID4gV2hlbiB4SENJIGNvbnRyb2xsZXIgaGliZXJuYXRl
ZCwgdGhlIHJvb3QgaHViIGxvc3QgcG93ZXIsIGlmDQo+ID4gPiA+IGNvbnRyb2xsZXINCj4gPiA+
ID4gc3VwcG9ydCBQb3J0IFBvd2VyIENvbnRyb2wgKFBQQyksIFBQIGlzIG5vdCBzZXQgYXQNCj4g
PiA+ID4geGhjaV9yZXN1bWUoKSBhbmQNCj4gPiA+ID4gc2V0IGJ5IGh1Yl9yZXNldF9yZXN1bWUo
KSBsYXRlciwgc28gbm8gbmVlZCBjaGVjayBwZW5kaW5nIHBvcnQNCj4gPiA+ID4gZXZlbnQuDQo+
ID4gPiA+IElmIFBQQyBpcyBub3Qgc3VwcG9ydGVkLCBkZXZpY2UgaXMgZGlzY29ubmVjZWQsIHNl
ZW1zIGRvIG5vdA0KPiA+ID4gPiBzZW5kIG91dA0KPiA+ID4gPiBVMyBMRlBTIHdha2Ugc2lnbmFs
LCBubyBuZWVkIHJlLWNoZWNrIGFnYWluIGFuZCBkcm9wIDEyMG1zDQo+ID4gPiA+IGRlbGF5IHRv
DQo+ID4gPiA+IHNhdmUgcmVzdW1lIHRpbWUuDQo+ID4gPiA+IA0KPiA+ID4gPiBSZXBvcnRlZC1i
eTogWXVuLUNoaWVuIFl1IDx5dW4tY2hpZW4ueXVAbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4g
PiA+IC0tLQ0KPiA+ID4gDQo+ID4gPiBUaGFua3MsIGFkZGluZw0KPiA+IA0KPiA+IEhpIE1hdGhp
YXMsIENodW5mZW5nDQo+ID4gDQo+ID4gSSBoYXZlIGEgcXVlc3Rpb24gb24gdGhpcywgaWYgdGhl
cmUgaXMgbm8gYW55IHVzYiBkZXZpY2VzIGNvbm5lY3RlZA0KPiA+IGJlZm9yZSBzdXNwZW5kLCBk
byB3ZSBuZWVkIHRoaXMgMTIwbXMgZGVsYXkgdG8gY2hlY2sgYWdhaW4/DQo+ID4gU28gZG8gd2Ug
bmVlZCBvbmUgbW9yZSBjb25kaXRpb24gdG8gbGltaXQgdGhpcyBsaWtlPw0KPiA+IGlmICghcGVu
ZGluZ19wb3J0ZXZlbnQgJiYgIWhpYmVybmF0ZWQgJiYgeGhjaV9oYXNfY2hpbGRfZGV2aWNlKCkp
DQo+IA0KPiBUaGUgMTIwbXMgZGVsYXkgd2FzIGFkZGVkIHRvIG1ha2Ugc3VyZSB3ZSBjYXRjaCB0
aGUgc2Vjb25kIHdha2UNCj4gc2lnbmFsDQo+IGZyb20gYSBkZXZpY2UgaW4gY2FzZSBob3N0IG1p
c3NlZCB0aGUgZmlyc3QgVTMgZXhpdCBMRlBTIHdha2V1cA0KPiBzaWduYWwuDQo+IA0KPiBFdmVu
IGlmIG5vIGRldmljZXMgYXJlIGNvbm5lY3RlZCB0aGlzIG1pZ2h0IGJlIGhlbHBmdWwgaWYgYSBk
ZXZpY2UgaXMNCj4gY29ubmVjdGVkIHdoaWxlIGhvc3QgaXMgc3VzcGVuZGVkLg0KPiBJIGhhdmVu
J3QgY2hlY2tlZCBhbnkgdGltaW5nIGZvciB0aGUgbGluayB0cmFpbmluZyBkdXJpbmcNCj4gZW51
bWVyYXRpb24sDQo+IGJ1dCBpdCBhbHNvIHVzZXMgTEZQUyBzaWduYWxsaW5nLCBhbmQgY29ubmVj
dGVkIGRldmljZSBpc24ndCB2aXNpYmxlDQo+IHRvDQo+IGRyaXZlciB1bnRpbCBsaW5rIGlzIHN1
Y2Nlc3NmdWxseSB0cmFpbmVkLg0KRm9yIHhoY2ktbXRrLCByb290aHViIGNhbid0IGRldGVjdCBk
ZXZpY2UgdW50aWwgcm9vdCBodWIgc2V0IFBvcnRQb3dlciwNCnNlZW1zIGFsc28gdGhlIHNhbWUg
Zm9yIG90aGVyIHhoY2kgY29udHJvbGxlcnMgdGhhdCBzdXBwb3J0IFBvcnQgUG93ZXINCkNvbnRy
b2wuDQo+IA0KPiBTbyB0aGUgb3JpZ2luYWwgMTIwbXMgZGVsYXkgcGF0Y2ggbWlnaHQgYXMgYSBw
b3NpdGl2ZSBzaWRlIGVmZmVjdA0KPiBlbnN1cmUNCj4gZHJpdmVyIGRvZXNuJ3Qgc3VzcGVuZCBo
b3N0IG1pZCBkZXZpY2UgZW51bWVyYXRpb24uDQp0aGlzIGlzIGluIHJlc3VtZT8NCg0KPiANCj4g
Q291bGQgYmUgbG9va2VkIGludG8gbW9yZSwgYnV0IEkgZG9uJ3QgdGhpbmsgd2Ugc2hvdWxkIHRo
aXMgcGF0Y2ggYnkNCj4gQ2h1bmZlbmcNCj4gDQo+IFRoYW5rcw0KPiBNYXRoaWFzDQo=

