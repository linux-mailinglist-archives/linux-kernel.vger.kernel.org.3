Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B8E46E10F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 03:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhLIC6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 21:58:13 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:54893 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhLIC6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 21:58:12 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1B92sXKS1032755, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1B92sXKS1032755
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 9 Dec 2021 10:54:33 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 10:54:33 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 9 Dec 2021 10:54:33 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::38af:5429:2b43:3b95]) by
 RTEXMBS01.realtek.com.tw ([fe80::38af:5429:2b43:3b95%5]) with mapi id
 15.01.2308.015; Thu, 9 Dec 2021 10:54:33 +0800
From:   Ricky WU <ricky_wu@realtek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tommyhebb@gmail.com" <tommyhebb@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: rtsx: improve rw performance
Thread-Topic: [PATCH] mmc: rtsx: improve rw performance
Thread-Index: AQHX6DEYTJKGBpnS2UOXrkrK9OF1RqwgTsWAgAUMTOCAAorBAIABmDNg
Date:   Thu, 9 Dec 2021 02:54:33 +0000
Message-ID: <a0326e747a09429a867727762074276e@realtek.com>
References: <5a38e5eb9fdc4b53ba4a11602e2cef0d@realtek.com>
 <CAPDyKFrC1JGCAAQZOOKe4VZS7g2Sg4MZKXr9WyMPeYDdQ3ht8g@mail.gmail.com>
 <b55390bd4a9942f3b37bd5bb8245ab25@realtek.com>
 <CAPDyKFpAACVTNcf5ckAVqn53envxDaG6x=RvNq=hGW7mEn+9MA@mail.gmail.com>
In-Reply-To: <CAPDyKFpAACVTNcf5ckAVqn53envxDaG6x=RvNq=hGW7mEn+9MA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.88.113]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzEyLzgg5LiL5Y2IIDExOjM3OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVbGYgSGFuc3NvbiA8dWxmLmhh
bnNzb25AbGluYXJvLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciA4LCAyMDIxIDY6
MjcgUE0NCj4gVG86IFJpY2t5IFdVIDxyaWNreV93dUByZWFsdGVrLmNvbT4NCj4gQ2M6IGdyZWdr
aEBsaW51eGZvdW5kYXRpb24ub3JnOyB0b21teWhlYmJAZ21haWwuY29tOw0KPiBsaW51eC1tbWNA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0hdIG1tYzogcnRzeDogaW1wcm92ZSBydyBwZXJmb3JtYW5jZQ0KPiANCj4gT24g
TW9uLCA2IERlYyAyMDIxIGF0IDEzOjA5LCBSaWNreSBXVSA8cmlja3lfd3VAcmVhbHRlay5jb20+
IHdyb3RlOg0KPiA+DQo+ID4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPiA+IEZyb206IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPiA+ID4g
U2VudDogRnJpZGF5LCBEZWNlbWJlciAzLCAyMDIxIDEwOjMzIFBNDQo+ID4gPiBUbzogUmlja3kg
V1UgPHJpY2t5X3d1QHJlYWx0ZWsuY29tPg0KPiA+ID4gQ2M6IGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnOyB0b21teWhlYmJAZ21haWwuY29tOw0KPiA+ID4gbGludXgtbW1jQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gbW1jOiBydHN4OiBpbXByb3ZlIHJ3IHBlcmZvcm1hbmNlDQo+ID4gPg0KPiA+ID4gT24g
RnJpLCAzIERlYyAyMDIxIGF0IDExOjQzLCBSaWNreSBXVSA8cmlja3lfd3VAcmVhbHRlay5jb20+
IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBzZF9jaGVja19zZXEoKSB0byBkaXN0aW5ndWlzaCBz
ZXF1ZW50aWFsIHJ3IG9yIG5vcm1hbCBydyBpZiB0aGlzDQo+ID4gPiA+IGRhdGEgaXMgc2VxdWVu
dGlhbCBjYWxsIHRvIHNkX3J3X3NlcXVlbnRpYWwoKQ0KPiA+ID4NCj4gPiA+IENhbiB5b3UgcGxl
YXNlIGV4dGVuZCB0aGlzIGNvbW1pdCBtZXNzYWdlPyBUaGlzIGRvZXNuJ3QgYW5zd2VyIHdoeQ0K
PiA+ID4gb3Igd2hhdCB0aGlzIGNoYW5nZSByZWFsbHkgZG9lcywgcGxlYXNlIHRyeSB0byBkbyB0
aGF0LCBhcyB0byBoZWxwIG1lIHRvDQo+IHJldmlldyB0aGlzLg0KPiA+ID4NCj4gPg0KPiA+IFRo
aXMgcGF0Y2ggaXMgZm9yIGltcHJvdmluZyBzZXF1ZW50aWFsIHJlYWQvd3JpdGUgcGVyZm9ybWFu
Y2UuDQo+IA0KPiBJIHdvdWxkIG5vdCB1c2UgdGhlIHRlcm0gInNlcXVlbnRpYWwiLCBidXQgcmF0
aGVyICJtdWx0aS1ibG9jayByZWFkL3dyaXRlcyIuDQo+IA0KPiA+IEJlZm9yZSB0aGlzLCB3aGV0
aGVyIENNRCBpcyBtdXRpLVJXIG9yIHNpbmdsZS1SVyB0aGUgZHJpdmVyIGRvIHRoZSBzYW1lDQo+
IGZsb3cuDQo+ID4gVGhpcyBwYXRjaCBkaXN0aW5ndWlzaGVzIHRoZSB0d28gYW5kIGRvIGRpZmZl
cmVudCBmbG93IHRvIGdldCBtb3JlDQo+ID4gcGVyZm9ybWFuY2Ugb24gc2VxdWVudGlhbCBSVy4N
Cj4gDQo+IEFscmlnaHQsIHRoYW5rcyBmb3IgY2xhcmlmeWluZy4NCj4gDQo+IFNvIHRvIGJlIGNs
ZWFyLCBwbGVhc2UgdXBkYXRlIHRoZSBjb21taXQgbWVzc2FnZSB0byBzYXkgdGhhdCBpdCdzIGlt
cHJvdmluZw0KPiBwZXJmb3JtYW5jZSBmb3IgbXVsdGktYmxvY2sgcmVhZC93cml0ZS4gVGhlbiBw
bGVhc2UgYWRkIGFsc28gc29tZQ0KPiBpbmZvcm1hdGlvbiBhYm91dCBob3cgdGhhdCBpcyBhY2hp
ZXZlZC4NCj4gDQo+IE1vcmVvdmVyLCBwbGVhc2UgcmVuYW1lIHRoZSBmdW5jdGlvbnMgaW4gdGhl
IGNvZGUgYWNjb3JkaW5nIHRvIHRoaXMgYXMgd2VsbCwgYXMNCj4gdG8gbWFrZSBpdCBtb3JlIGNs
ZWFyLiBGb3IgZXhhbXBsZSwgdXNlIHNkX3J3X211bHRpKCkgKGFuZA0KPiBzZF9yd19zaW5nbGUo
KSBpZiB0aGF0IGlzIG5lZWRlZCksIHJhdGhlciB0aGFuIHNkX3J3X3NlcXVlbnRpYWwoKS4NCj4g
DQo+ID4gc2RfY2hlY2tfc2VxKCkgdG8gZGlzdGluZ3Vpc2ggc2VxdWVudGlhbCBSVyAoQ01EIDE4
LzI1KSBvciBub3JtYWwgUlcNCj4gPiAoQ01EIDE3LzI0KSBpZiB0aGUgZGF0YSBpcyBzZXF1ZW50
aWFsIGNhbGwgdG8gc2Rfcndfc2VxdWVudGlhbCgpDQo+IA0KPiBJIHdpbGwgd2FpdCBmb3IgYSB2
MiBmcm9tIHlvdSwgdGhlbiBJIHdpbGwgZ2l2ZSBpdCBhbm90aGVyIHRyeSB0byByZXZpZXcuDQo+
IA0KDQpPaywgSSB3aWxsIGRvIHRoZSB2MiBwYXRjaC4NCkFuZCBJIG5lZWQgdG8gY2xhcmlmeSwg
dGhpcyBwYXRjaCBpcyBpbXByb3ZpbmcgcGVyZm9ybWFuY2UgDQp0aGF0IHRoZSBDTUQgaXMgbXVs
dGktYmxvY2sgYW5kIHRoZSBkYXRlIGlzIHNlcXVlbnRpYWwuIA0KSSB3aWxsIGNoYW5nZSB0aGUg
ZnVuY3Rpb24gbmFtZSBmb3IgbW9yZSBjbGFyaXR5Lg0KDQo+IFsuLi5dDQo+IA0KPiBLaW5kIHJl
Z2FyZHMNCj4gVWZmZQ0KPiAtLS0tLS1QbGVhc2UgY29uc2lkZXIgdGhlIGVudmlyb25tZW50IGJl
Zm9yZSBwcmludGluZyB0aGlzIGUtbWFpbC4NCg==
