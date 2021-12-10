Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D3846F858
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbhLJBWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:22:43 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:33242 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231239AbhLJBWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:22:43 -0500
X-UUID: fcf511dbb203486ca24fb41565892b98-20211210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=mhsm8jCjmfVJ/4gC6JOmYGvhXbLLDDj8f2KrlI9H3IU=;
        b=lImAdM4xESUIaVHW1FZtOcW+g1qxAX1dPiqLHbyMOtOCBIMkwTVnH6MlyVXe5KDHESFcRg+RfYqpU0XG3kijSXBUaBMTXEQ42Z8j0gbn/W7/C/2EMScjLkWpVuuuQ/yvwRpzuatgQrdOyrHnmlR2kZuqv7UxG+8Y06NbcqwamyY=;
X-UUID: fcf511dbb203486ca24fb41565892b98-20211210
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 955272763; Fri, 10 Dec 2021 09:19:06 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 10 Dec 2021 09:19:05 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 10 Dec 2021 09:19:04 +0800
Message-ID: <2cdc5d2997b4d37f891bf60f476135b1cdfaa810.camel@mediatek.com>
Subject: Re: [PATCH 3/3] usb: mtu3: fix list_head check warning
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        "Yuwen Ng" <yuwen.ng@mediatek.com>
Date:   Fri, 10 Dec 2021 09:19:05 +0800
In-Reply-To: <b77c0732-460f-cf30-c759-d51d37763894@omp.ru>
References: <20211209031424.17842-1-chunfeng.yun@mediatek.com>
         <20211209031424.17842-3-chunfeng.yun@mediatek.com>
         <b77c0732-460f-cf30-c759-d51d37763894@omp.ru>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTEyLTA5IGF0IDEyOjEwICswMzAwLCBTZXJnZXkgU2h0eWx5b3Ygd3JvdGU6
DQo+IEhlbGxvIQ0KPiANCj4gT24gMDkuMTIuMjAyMSA2OjE0LCBDaHVuZmVuZyBZdW4gd3JvdGU6
DQo+IA0KPiA+IFRoaXMgaXMgY2F1c2VkIGJ5IHVuaW5pdGlhbGl6YXRpb24gb2YgbGlzdF9oZWFk
Lg0KPiANCj4gICAgIE5vIHN1Y2ggd29yZCwgc3VnZ2VzdGluZyB0byByZXBsYWNlIHdpdGggIm5v
dCBpbml0aWFsaXppbmciLiA6LSkNCldpbGwgZml4IGl0LCB0aGFua3MNCg0KPiANCj4gPiBCVUc6
IEtBU0FOOiB1c2UtYWZ0ZXItZnJlZSBpbiBfX2xpc3RfZGVsX2VudHJ5X3ZhbGlkKzB4MzQvMHhl
NA0KPiA+IA0KPiA+IENhbGwgdHJhY2U6DQo+ID4gZHVtcF9iYWNrdHJhY2UrMHgwLzB4Mjk4DQo+
ID4gc2hvd19zdGFjaysweDI0LzB4MzQNCj4gPiBkdW1wX3N0YWNrKzB4MTMwLzB4MWE4DQo+ID4g
cHJpbnRfYWRkcmVzc19kZXNjcmlwdGlvbisweDg4LzB4NTZjDQo+ID4gX19rYXNhbl9yZXBvcnQr
MHgxYjgvMHgyYTANCj4gPiBrYXNhbl9yZXBvcnQrMHgxNC8weDIwDQo+ID4gX19hc2FuX2xvYWQ4
KzB4OWMvMHhhMA0KPiA+IF9fbGlzdF9kZWxfZW50cnlfdmFsaWQrMHgzNC8weGU0DQo+ID4gbXR1
M19yZXFfY29tcGxldGUrMHg0Yy8weDMwMCBbbXR1M10NCj4gPiBtdHUzX2dhZGdldF9zdG9wKzB4
MTY4LzB4NDQ4IFttdHUzXQ0KPiA+IHVzYl9nYWRnZXRfdW5yZWdpc3Rlcl9kcml2ZXIrMHgyMDQv
MHgzYTANCj4gPiB1bnJlZ2lzdGVyX2dhZGdldF9pdGVtKzB4NDQvMHhhNA0KPiA+IA0KPiA+IFJl
cG9ydGVkLWJ5OiBZdXdlbiBOZyA8eXV3ZW4ubmdAbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCj4gDQo+IFsu
Li5dDQo+IA0KPiBNQlIsIFNlcmdleQ0K

