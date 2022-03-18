Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E84A4DD394
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 04:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiCRDbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 23:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiCRDbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 23:31:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671E08F9A2;
        Thu, 17 Mar 2022 20:29:53 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KKTxK6Vd1zfZ34;
        Fri, 18 Mar 2022 11:28:21 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 11:29:51 +0800
Received: from dggpemm500015.china.huawei.com (7.185.36.181) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 11:29:51 +0800
Received: from dggpemm500015.china.huawei.com ([7.185.36.181]) by
 dggpemm500015.china.huawei.com ([7.185.36.181]) with mapi id 15.01.2308.021;
 Fri, 18 Mar 2022 11:29:51 +0800
From:   "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
CC:     "chengjian (D)" <cj.chengjian@huawei.com>,
        "liwei (GF)" <liwei391@huawei.com>,
        "antoniu.miclaus@analog.com" <antoniu.miclaus@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIDIvMl0gaWlvOmZpbHRlcjphZG12ODgxODogRml4IG1p?=
 =?gb2312?B?c3NpbmcgY2xrX2Rpc2FibGVfdW5wcmVwYXJlKCkgaW4gYWRtdjg4MThfY2xr?=
 =?gb2312?Q?=5Fsetup?=
Thread-Topic: [PATCH 2/2] iio:filter:admv8818: Fix missing
 clk_disable_unprepare() in admv8818_clk_setup
Thread-Index: AQHYOnLPy2RAllgaYUGUm5x4tyvPl6zEecaQ
Date:   Fri, 18 Mar 2022 03:29:50 +0000
Message-ID: <ecbd85c40bce45078658a63bbd8b0a50@huawei.com>
References: <20220318025914.2614812-1-bobo.shaobowang@huawei.com>
 <20220318025914.2614812-3-bobo.shaobowang@huawei.com>
In-Reply-To: <20220318025914.2614812-3-bobo.shaobowang@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.177.133]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,MISSING_HEADERS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQotLS0tLdPKvP7Urbz+LS0tLS0NCreivP7IyzogV2FuZ3NoYW9ibyAoYm9ibykgDQq3osvNyrG8
5DogMjAyMsTqM9TCMTjI1SAxMDo1OQ0Ks63LzTogY2hlbmdqaWFuIChEKSA8Y2ouY2hlbmdqaWFu
QGh1YXdlaS5jb20+OyBsaXdlaSAoR0YpIDxsaXdlaTM5MUBodWF3ZWkuY29tPjsgV2FuZ3NoYW9i
byAoYm9ibykgPGJvYm8uc2hhb2Jvd2FuZ0BodWF3ZWkuY29tPjsgYW50b25pdS5taWNsYXVzQGFu
YWxvZy5jb207IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGppYzIzQGtlcm5lbC5vcmc7IEpvbmF0aGFuIENhbWVyb24gPGpvbmF0aGFuLmNh
bWVyb25AaHVhd2VpLmNvbT4NCtb3zOI6IFtQQVRDSCAyLzJdIGlpbzpmaWx0ZXI6YWRtdjg4MTg6
IEZpeCBtaXNzaW5nIGNsa19kaXNhYmxlX3VucHJlcGFyZSgpIGluIGFkbXY4ODE4X2Nsa19zZXR1
cA0KDQpGaXggbWlzc2luZyBjbGtfZGlzYWJsZV91bnByZXBhcmUoKSBiZWZvcmUgcmV0dXJuIGZy
b20gYWRtdjg4MThfY2xrX3NldHVwIGluIHRoZSBlcnJvciBoYW5kbGluZyBjYXNlcy4NCg0KRml4
ZXM6IGYzNGZlODg4YWQwNSAoImlpbzpmaWx0ZXI6YWRtdjg4MTg6IGFkZCBzdXBwb3J0IGZvciBB
RE1WODgxOCIpDQpTaWduZWQtb2ZmLWJ5OiBXYW5nIFNoYW9CbyA8Ym9iby5zaGFvYm93YW5nQGh1
YXdlaS5jb20+DQotLS0NCiBkcml2ZXJzL2lpby9maWx0ZXIvYWRtdjg4MTguYyB8IDE0ICsrKysr
KysrKysrLS0tDQogMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9maWx0ZXIvYWRtdjg4MTguYyBiL2RyaXZl
cnMvaWlvL2ZpbHRlci9hZG12ODgxOC5jIGluZGV4IDY4ZGU0NWZlMjFiNC4uYWNiNDM2ZWZkOGI1
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9paW8vZmlsdGVyL2FkbXY4ODE4LmMNCisrKyBiL2RyaXZl
cnMvaWlvL2ZpbHRlci9hZG12ODgxOC5jDQpAQCAtNTkwLDE0ICs1OTAsMjIgQEAgc3RhdGljIGlu
dCBhZG12ODgxOF9jbGtfc2V0dXAoc3RydWN0IGFkbXY4ODE4X3N0YXRlICpzdCkNCiANCiAJcmV0
ID0gZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0KCZzcGktPmRldiwgYWRtdjg4MThfY2xrX2Rpc2Fi
bGUsIHN0KTsNCiAJaWYgKHJldCkNCi0JCXJldHVybiByZXQ7DQorCQlnb3RvIG91dF9jbGtfZGlz
YWJsZTsNCg0KYWRtdjg4MThfY2xrX2Rpc2FibGUoKSB3b3VsZCBkbyBjbGtfZGlzYWJsZV91bnBy
ZXBhcmUoKSwgc28gY2xrX2Rpc2FibGVfdW5wcmVwYXJlKCkgaXMgbm90IG5lZWRlZCBhZnRlcg0K
ZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0KCksdGhlcmUgaXMgbm8gcHJvYmxlbSBpbiB0aGlzIGZ1
bmN0aW9uLg0KDQp0aGlzIHBhdGNoIGlzIG5vdCBuZWVkZWQgYW55bW9yZS4NCg0KLS0gd2FuZ3No
YW9ibw0K
