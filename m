Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923AD490384
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237965AbiAQION (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:14:13 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:59660 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230028AbiAQIOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:14:12 -0500
X-UUID: 51f31bc786b24f499ee097c30bf01df9-20220117
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject; bh=MLngfimllDjAWxvbO5d7nuFB2Pcu+gxeE6ZEyPxU+7k=;
        b=oJ1ut0EVW/7ybuC1pUxz7bcqzFDICJKPtXNBizQ6zeD63gwOARw7E/b8t18dTk6SwbHE7Amb6bAahQP/WaSALqi7A2ZXrMWhNjYKuU8si6OPF1KJtQemAvXxjw0DmEmOnJimoAUEgLZQfGU0+5JPRMpCuvkygkmkaA/IwxyB0yQ=;
X-UUID: 51f31bc786b24f499ee097c30bf01df9-20220117
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 698620270; Mon, 17 Jan 2022 16:14:01 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 17 Jan 2022 16:14:00 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Jan 2022 16:14:00 +0800
Subject: Re: [PATCH 2/3] mmc: core: Add support for SDIO async interrupt
To:     Axe Yang <axe.yang@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
References: <20220117071220.17330-1-axe.yang@mediatek.com>
 <20220117071220.17330-3-axe.yang@mediatek.com>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
Message-ID: <60f3d381-1af4-d002-e179-9550672dae5b@mediatek.com>
Date:   Mon, 17 Jan 2022 16:14:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220117071220.17330-3-axe.yang@mediatek.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8xNy8yMiAzOjEyIFBNLCBBeGUgWWFuZyB3cm90ZToNCj4gSWYgY2FwLXNkaW8tYXN5bmMt
aXJxIGZsYWcgaXMgc2V0IGluIGhvc3QgZHRzIG5vZGUsIHBhcnNlIEVBSQ0KPiBpbmZvcm1hdGlv
biBmcm9tIFNESU8gQ0NDUiBpbnRlcnJ1cHQgZXh0ZXJuc2lvbiBzZWdtZW50LiBJZiBhc3luYw0K
PiBpbnRlcnJ1cHQgaXMgc3VwcG9ydGVkIGJ5IFNESU8gY2FyZCB0aGVuIHNlbmQgY29tbWFuZCB0
byBjYXJkIHRvDQo+IGVuYWJsZSBpdCBhbmQgc2V0IGVuYWJsZV9hc3luY19pcnEgZmxhZyBpbiBz
ZGlvX2NjY3Igc3RydWN0dXJlIHRvIDEuDQo+IFRoZSBwYXJzZSBmbG93IGlzIGltcGxlbWVudGVk
IGluIHNkaW9fcmVhZF9jY2NyKCkuDQo+IA0KPiBBY2tlZC1ieTogQW5nZWxvR2lvYWNjaGlubyBE
ZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogQXhlIFlhbmcgPGF4ZS55YW5nQG1lZGlhdGVrLmNvbT4NCg0KW2RlbGV0ZWQu
Li5dDQoNCkl0IHNlZW1zIHRoZSBwcmVmaXggIltQQVRDSCB2M10iIGRpZG4ndCBhcHBsaWVkIHRv
IHN1YmplY3Qgb2YgZWFjaCBwYXRjaCANCmluIHYzIHNlcmllcy4gUGxlYXNlIHJlbWVtYmVyIHRv
IGtlZXAgdGhlIHZlcnNpb24gYWxpZ25lZCBpbiB0aGUgc2FtZSANCnBhdGNoIHNldC4gVXNlICJn
aXQgZm9ybWF0LXBhdGNoIC0tc3ViamVjdC1wcmVmaXg9W1BBVENIIHYzXSIgdG8gaGVscCANCnlv
dSB0byBrZWVwIHRoZSB2ZXJzaW9uIG51bWJlciBhbGlnbmVkIGlzIHN1Z2dlc3RlZC4NCg0KVGhh
bmtzIQ0KTWFjcGF1bCBMaW4=

