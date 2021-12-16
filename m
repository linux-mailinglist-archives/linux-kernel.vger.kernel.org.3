Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0F1476C1A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbhLPInW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:43:22 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:39004 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234961AbhLPInV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:43:21 -0500
X-UUID: 32a734418edb4157a932bece69bcb5f3-20211216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=H1udBS3aTyDbK3s3oJIROCs2v4Fm/yjfNUh4OxuNKz4=;
        b=Op0PfH90YkV6I0red8SHQ7d7qOIksVzSaWcqtILkTf78rahYIbNp/WHTpQSEdF/9Zo1KhuxszklzqVqAqpGHIaOV3tSq1+A2JMhPVvzAq57bs/t8UkciXXKedP4Ht23COIlLhWjYQ22TinZMMIK/4FiWyGS8hBIth+26nsmOmuI=;
X-UUID: 32a734418edb4157a932bece69bcb5f3-20211216
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1335092833; Thu, 16 Dec 2021 16:43:19 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 16 Dec 2021 16:43:18 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 16 Dec
 2021 16:43:18 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 16 Dec 2021 16:43:17 +0800
Message-ID: <09a2c51d7d71d0b6419b470224466efac4ab6afa.camel@mediatek.com>
Subject: Re: [PATCH 3/3] usb: mtu3: fix list_head check warning
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        "Yuwen Ng" <yuwen.ng@mediatek.com>
Date:   Thu, 16 Dec 2021 16:43:19 +0800
In-Reply-To: <YbdWiYU+LJHWd4wQ@kroah.com>
References: <20211209031424.17842-1-chunfeng.yun@mediatek.com>
         <20211209031424.17842-3-chunfeng.yun@mediatek.com>
         <YbdWiYU+LJHWd4wQ@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTEyLTEzIGF0IDE1OjE5ICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IE9uIFRodSwgRGVjIDA5LCAyMDIxIGF0IDExOjE0OjI0QU0gKzA4MDAsIENodW5mZW5n
IFl1biB3cm90ZToNCj4gPiBUaGlzIGlzIGNhdXNlZCBieSB1bmluaXRpYWxpemF0aW9uIG9mIGxp
c3RfaGVhZC4NCj4gPiANCj4gPiBCVUc6IEtBU0FOOiB1c2UtYWZ0ZXItZnJlZSBpbiBfX2xpc3Rf
ZGVsX2VudHJ5X3ZhbGlkKzB4MzQvMHhlNA0KPiA+IA0KPiA+IENhbGwgdHJhY2U6DQo+ID4gZHVt
cF9iYWNrdHJhY2UrMHgwLzB4Mjk4DQo+ID4gc2hvd19zdGFjaysweDI0LzB4MzQNCj4gPiBkdW1w
X3N0YWNrKzB4MTMwLzB4MWE4DQo+ID4gcHJpbnRfYWRkcmVzc19kZXNjcmlwdGlvbisweDg4LzB4
NTZjDQo+ID4gX19rYXNhbl9yZXBvcnQrMHgxYjgvMHgyYTANCj4gPiBrYXNhbl9yZXBvcnQrMHgx
NC8weDIwDQo+ID4gX19hc2FuX2xvYWQ4KzB4OWMvMHhhMA0KPiA+IF9fbGlzdF9kZWxfZW50cnlf
dmFsaWQrMHgzNC8weGU0DQo+ID4gbXR1M19yZXFfY29tcGxldGUrMHg0Yy8weDMwMCBbbXR1M10N
Cj4gPiBtdHUzX2dhZGdldF9zdG9wKzB4MTY4LzB4NDQ4IFttdHUzXQ0KPiA+IHVzYl9nYWRnZXRf
dW5yZWdpc3Rlcl9kcml2ZXIrMHgyMDQvMHgzYTANCj4gPiB1bnJlZ2lzdGVyX2dhZGdldF9pdGVt
KzB4NDQvMHhhNA0KPiA+IA0KPiA+IFJlcG9ydGVkLWJ5OiBZdXdlbiBOZyA8eXV3ZW4ubmdAbWVk
aWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVu
QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy91c2IvbXR1My9tdHUzX2dhZGdl
dC5jIHwgMSArDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gV2hh
dCBjb21taXQgZG9lcyB0aGlzIGZpeD8gIFNob3VsZCBpdCBnbyB0byBzdGFibGUga2VybmVscz8N
CkkgYWRkIGl0IGluIG5leHQgdmVyc2lvbiwgdGhhbmtzDQo+IA0KPiB0aGFua3MsDQo+IA0KPiBn
cmVnIGstaA0K

