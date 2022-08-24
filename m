Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E9859F03B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 02:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiHXAga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 20:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiHXAg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 20:36:26 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2073.outbound.protection.outlook.com [40.107.114.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0376E897
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 17:36:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVIvDpFTN+E/7SZHZq8VyzLKB2DlAZTSTPqT1xka5yJ/E/OQ38OXX0EIyWwLLQT2hCdzcnevk18Gv1aOElb1FgrZyfsBGvMiE9/5FcimhuVON7toHOm3pP1US2Tz4G1pFtLTzs28lDGJCbCreL1IzG1zsMvKp114WtZalyWGqxjFTQUXoUNx9TkFgoVIEUZSSKi0ZMn5WN3413Aa4MmzZPRTsvDBRMkyy8g5Q/95aMIPijSRYm+MTN/Ez0tofmghJxaH7Nv2E2l35LKOIc6Y9czROse6t0y+jHYvEjCYhqzUqI/UKqdgE0Slcwr2IUp2T/ln3vW5WGNbHlL3zIFNYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQI/FnwMT0gazALIRm2EBw/9C5sGIhstTGtpfxa1z0k=;
 b=EdmwpBZoSET1od4gk8lc+ma/I98F5GW8HvcFcwoZWgUzNA5esfEmWOg4EqSkuC5tKz0ORXTKKSv/W7d5VRKCd8mStsH69Bd/eNmd3DQ6YxQhKCOJlv/2xlrYZ/Fh/NeyWcCJvotaf0Em7KJm6tTR///pYXmkrNBh22SPdAFYPdhvhSUoyMJhBL0Uqz1Xye4ayFvzhB6P4uD5/o9lsJ4ZXdFlUwaZBIk5VMswjPOWtUFdnD+RCHRUAMuFVYsSdR5le6YWa6xO2OK8nvnslg09htBclxAOM/q83Ep06yN7LgBIc99+mM2emadYAK5uYyJhEbYJbNvA8XyN8r8X9uuaZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQI/FnwMT0gazALIRm2EBw/9C5sGIhstTGtpfxa1z0k=;
 b=EfM533d9FIXnavLb1yoJxotBDHtzVBi+D5e9bzNgKq99v2xLJciG4/BsqA6yJRnK5Y8zvhn7mJNldGb31l37u+/Tr1tNh548myUf/ITmbEHizCm2v2+rKYYjtJfs47MaFUIaDhp+ShakVQzmdQKn1MK8A2L0+FILSOHsJXCcJ/A=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSBPR01MB2871.jpnprd01.prod.outlook.com (2603:1096:604:1a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 00:36:22 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a%6]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 00:36:22 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] mm, hwpoison: fix possible use-after-free in
 mf_dax_kill_procs()
Thread-Topic: [PATCH v2 4/6] mm, hwpoison: fix possible use-after-free in
 mf_dax_kill_procs()
Thread-Index: AQHYtp/boXf1kMZ4skKbcQTJzvLWTq29NdCA
Date:   Wed, 24 Aug 2022 00:36:22 +0000
Message-ID: <20220824003621.GA811648@hori.linux.bs1.fc.nec.co.jp>
References: <20220823032346.4260-1-linmiaohe@huawei.com>
 <20220823032346.4260-5-linmiaohe@huawei.com>
In-Reply-To: <20220823032346.4260-5-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4329fb68-20c4-4647-fca2-08da8568ab24
x-ms-traffictypediagnostic: OSBPR01MB2871:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nuqdUGxfPHq+UilFlguUzcYrUdpMP5DiA6gUHwaRqW9Itj8Vo91je3+7sblUx3XXVz4yoIcADc5pk449gIDVACgrfPLUsYTO3K9wdr+wX8NzxE/m3Tpw0my+wV0gdiIj+gGosQkYAApFfoymb9Y8idiL2I1qNxYwpkhaAfmOusWm29x0z7lCsBWS7AZPB+YW5Gl3dxr97WWpsmHjMQmU4gtA1W1mrptwuLqlbI0GGWuV7TXcCiOJazNZXjbaSVV/Uf3tjvyiF666l2byEJQbLNgo6sPEGVc5OusT3t+IU760Wt6B0v4rHjQKS9p413DjAx9PIanV6cn8FWP8ukiGjj4ZteO0/3yn6GhdsVXx10qTNGPf3v+94fwp4Jcvq6Wu84CkhtTAq9VQweXnCb6ZGieuK5HISWnJEs5FZeEtiX+5bu9x4Xp0MiaLYVIjLSs/7uUpLCRokIBKYSa4YMvB1gHnj+01NRgbH3Pk6OUM/yLr8GB1mBNRlRP5M28W3wMw0Rsij/g6O4A4JNLs3y47kHEGMJT0womdfK3miRwihEm4FMvz1XKGkOYfwLGuNOQfNPkkUigcwaizlQXLvvtdd2WegmZl0LEybwZO4gztKRZS1HkaD+Rihc+5/kgq1ZEK8PTsoIiodBhzS8+pWOiBiN0D5AQ9A1b3PyMqqmmWv1jyBO1ZeBcJOL5pqyzQIZZQbpLZC1KCrosN0IbQY4OBj0Ehd+/FO31jE3OzxFHCSJnwmSksl667MjkAxYrniMV5EwOc2+nz0fa8CNeJqEGH3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(38100700002)(122000001)(38070700005)(86362001)(82960400001)(33656002)(186003)(1076003)(83380400001)(85182001)(2906002)(316002)(54906003)(6916009)(5660300002)(478600001)(66446008)(4326008)(8676002)(76116006)(64756008)(66946007)(66556008)(66476007)(6506007)(41300700001)(8936002)(26005)(9686003)(6512007)(6486002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUFRM1ZuK2I1NWk2YmcrNFlxVXoyOGNlRjlIemNCc2wweEdEL0VPNEpZTVNT?=
 =?utf-8?B?YlBQR2xLTkVCL2QzaEhUTEt3SFdYR2doYTZ4dFVpTTFkWUF3MEl1UDAxZFov?=
 =?utf-8?B?Ym9EaTBsa1pQSmRmQXN0OEZUcGxyS1hFQUxIcWZtV2RORllYTXdqNGpTaThu?=
 =?utf-8?B?bnN1RnFvd2tYYVFMdW1lWlVXY3VGaURVRzg1TFJYYnE2cVBuQVFEZXZSNER1?=
 =?utf-8?B?WUZQR3FyMTFReXlJSW5ZZzF6SnBVZnZVQzBXc2VVOGM5NWxEbzQ3WG02TjlG?=
 =?utf-8?B?SkdwNDRzaUFmTTBxak80eTB5R2p2RHNueS9RKzhqWWl6N3hjRXF3YVVvdlBw?=
 =?utf-8?B?N1VVODlsWUxhbUVDU0pxeUVNUGV4ZXJvWlZYbEp3OFc2azExbkVpRkovYVN5?=
 =?utf-8?B?VzNuMkFjZFJOOExZV1czdkJ0U2VjY0VpVDg2dFZYRmtKdlc3K1lRSUFqaUZX?=
 =?utf-8?B?VmxmMk5UaFpIdXlOOG44dGZUbzAvUFpSK01xdVVlcXNnNTIrMVEzUm1WQjd6?=
 =?utf-8?B?b2hCeXBMam9oQjJUcXFRaTJrcXp3TVdJRFMzVE9ucHEreU5QMkQ2d3hwOTQ4?=
 =?utf-8?B?T0diRFdzYnlXRkNzVnUrcHpFVis5VTZxbGJIMDVQNGRvSGQxbFdXODBPMk5i?=
 =?utf-8?B?QklHbCtUUjJjZ0ZYemRwK25LbDhaUDVZSDExaEVFOEQ1YVFBTi9zWHdRV09l?=
 =?utf-8?B?TWVvdTNvZWVYU0pKdEM5czFHR1k4Z05DUUlWMTFQTzNJSCtnNE1XWSszY0pW?=
 =?utf-8?B?TVNDdTlWeWdQN3ZtY1Y2V3JMNXJJWTl4b1F6bW9Mc0hRKy82NXVJY0FJclZY?=
 =?utf-8?B?MXlyQTNHcHU1MTNIMzFrblpJVXJGaHNPb2NQdkk4UUpNdFRrR0krOTJVTDRE?=
 =?utf-8?B?SUNvMEExaWZGN0tibmJUaEdzVkZRSmU1Wjd3VXRJVmNKbVJxOTF0Nm1SUWJV?=
 =?utf-8?B?N1JYV2lmalFXWUZrVEQyNWIzSVRkMjY4UnZnb2FNb2ptbzV2c2Rpdk4yZ0ZK?=
 =?utf-8?B?L2ZvK0hMYzB2cDg5c0srZEFKM2dpMndDT2w4UlN2Ym5Qb2laOXlhRTJGYWRm?=
 =?utf-8?B?RWlORVUrNUw2cklWNldPemU4RlM2c3JYZmZPcXptSThjckczZndRNzJFY0RR?=
 =?utf-8?B?VWE3WnNQZGxYaHVFenFDbThXQkxNUEY2elRCc2RsMnp2MlRhRW51dExRTzFp?=
 =?utf-8?B?MWZxSXNxT2Q5Q1N1U0FCbkQ2OFoyQlZvZzZFWDVaWkFKQTdkVGlIQWtDZjNI?=
 =?utf-8?B?dEx5Yitac1E2Zk5ka1hPUlpIYVdxSzBYS0Jzcit0L0NzV1Vvc3VBVlNOek1R?=
 =?utf-8?B?L3hpVGF3ODBMK1BlNDlHWmxsN2ZENUlOWUpKaEhzamQyZC90b2d4VDJtY3ZY?=
 =?utf-8?B?UEw2T2pjTDBKTXlMN3JoalhQdG9yN25MYkxMSUZlVTdFdnJod0NsT2RIWGds?=
 =?utf-8?B?d2Z3dlI5QWxWR2Z5TWlmZGd1K1NiMnJDZDhtMDZQS2loUjd1TUJmY05NYkNi?=
 =?utf-8?B?RHFINFR2Y01MZTBWVlpVNjloQVhNdndjNWFGTk1jaUxqRnA4NWdsMDVscnE0?=
 =?utf-8?B?WHBmOUZUdXprbkZSV21hcGxONmtPSE1RY0Zqa1k1M2c2QlI3Tll6ZVJ6ZGZD?=
 =?utf-8?B?a1kzTUlFVXNRVHZLUWwvMm9HWnhieHZ6Q2d0bUNRV3VBNmc1c24xeWZSRDI0?=
 =?utf-8?B?Wi9JMGluRStKZmw1QzQ3ZGNGZkZSWlZpcWkyb2ptSHBMWHljTWhMa0xLYzI5?=
 =?utf-8?B?SWJ2d0lhNHNRSEJsOU45U3Rwd0xiVnJ0ekprbjhmSFRJVUtnUjFpZnhkNU83?=
 =?utf-8?B?VFZmT2k0cFovV2Q5TkJLRGc2UDBMS1FWa0U5ZG9EWVdtVC9GUGthMHVyMUVF?=
 =?utf-8?B?TjlYa1pZQzJhd1Btd091ODF1QjdWYVNuSXFITXpWQUxvOFc3NjhpeGhZRkJY?=
 =?utf-8?B?VFNLeG9xUmMvcnZiWnNkVHplSU8yRFpBYmFVTHRBK3VwbkFKa01Yc0xDUjZj?=
 =?utf-8?B?cGpvQzVzaUxDVzhWVXJEUWpTaDdhTXNsNWg4U1J3S1BTYXVkdjk3L0xLcUZB?=
 =?utf-8?B?blhnMHVPbnhKcG8zY0M0cEpCa0J2SVVmQ3pHOU9RclFjN1ZKMmlKdGxkV3Ri?=
 =?utf-8?B?NytqQ0N4c2c5bi9JM2JCRHFlSFBDaGMzWlo2N2NXVVJXb3RnWkVCYlZqT2p4?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <243BBEC7E3F2AB4BB95309D7198FC231@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4329fb68-20c4-4647-fca2-08da8568ab24
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 00:36:22.0611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fzevAWyKG7aWVnGUW/3Huy7mpNFErSpLzEJfW7vOpnK/+xEwyq8dhwRyc8q7F2FPHYZMEr8q10kJqCDr032LAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2871
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBdWcgMjMsIDIwMjIgYXQgMTE6MjM6NDRBTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gQWZ0ZXIga2lsbF9wcm9jcygpLCB0ayB3aWxsIGJlIGZyZWVkIHdpdGhvdXQgYmVpbmcg
cmVtb3ZlZCBmcm9tIHRoZSB0b19raWxsDQo+IGxpc3QuIEluIHRoZSBuZXh0IGl0ZXJhdGlvbiwg
dGhlIGZyZWVkIGxpc3QgZW50cnkgaW4gdGhlIHRvX2tpbGwgbGlzdCB3aWxsDQo+IGJlIGFjY2Vz
c2VkLCB0aHVzIGxlYWRpbmcgdG8gdXNlLWFmdGVyLWZyZWUgaXNzdWUuIEFkZGluZyBsaXN0X2Rl
bCgpIGluDQo+IGtpbGxfcHJvY3MoKSB0byBmaXggdGhlIGlzc3VlLg0KPiANCj4gRml4ZXM6IGMz
NmUyMDI0OTU3MSAoIm1tOiBpbnRyb2R1Y2UgbWZfZGF4X2tpbGxfcHJvY3MoKSBmb3IgZnNkYXgg
Y2FzZSIpDQo+IFNpZ25lZC1vZmYtYnk6IE1pYW9oZSBMaW4gPGxpbm1pYW9oZUBodWF3ZWkuY29t
Pg0KDQpUaGFuayB5b3UgZm9yIHRoZSB1cGRhdGUuDQoNCkFja2VkLWJ5OiBOYW95YSBIb3JpZ3Vj
aGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KDQo+IC0tLQ0KPiAgbW0vbWVtb3J5LWZhaWx1
cmUuYyB8IDMgKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbW0vbWVtb3J5LWZhaWx1cmUuYyBiL21tL21lbW9y
eS1mYWlsdXJlLmMNCj4gaW5kZXggMWQ3OWU2OTNmMWI5Li5mODI2MmY1NzdiYWYgMTAwNjQ0DQo+
IC0tLSBhL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gKysrIGIvbW0vbWVtb3J5LWZhaWx1cmUuYw0K
PiBAQCAtNDEzLDcgKzQxMyw3IEBAIHN0YXRpYyB2b2lkIGtpbGxfcHJvY3Moc3RydWN0IGxpc3Rf
aGVhZCAqdG9fa2lsbCwgaW50IGZvcmNla2lsbCwgYm9vbCBmYWlsLA0KPiAgew0KPiAgCXN0cnVj
dCB0b19raWxsICp0aywgKm5leHQ7DQo+ICANCj4gLQlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUg
KHRrLCBuZXh0LCB0b19raWxsLCBuZCkgew0KPiArCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZSh0
aywgbmV4dCwgdG9fa2lsbCwgbmQpIHsNCj4gIAkJaWYgKGZvcmNla2lsbCkgew0KPiAgCQkJLyoN
Cj4gIAkJCSAqIEluIGNhc2Ugc29tZXRoaW5nIHdlbnQgd3Jvbmcgd2l0aCBtdW5tYXBwaW5nDQo+
IEBAIC00MzcsNiArNDM3LDcgQEAgc3RhdGljIHZvaWQga2lsbF9wcm9jcyhzdHJ1Y3QgbGlzdF9o
ZWFkICp0b19raWxsLCBpbnQgZm9yY2VraWxsLCBib29sIGZhaWwsDQo+ICAJCQkJcHJfZXJyKCIl
I2x4OiBDYW5ub3Qgc2VuZCBhZHZpc29yeSBtYWNoaW5lIGNoZWNrIHNpZ25hbCB0byAlczolZFxu
IiwNCj4gIAkJCQkgICAgICAgcGZuLCB0ay0+dHNrLT5jb21tLCB0ay0+dHNrLT5waWQpOw0KPiAg
CQl9DQo+ICsJCWxpc3RfZGVsKCZ0ay0+bmQpOw0KPiAgCQlwdXRfdGFza19zdHJ1Y3QodGstPnRz
ayk7DQo+ICAJCWtmcmVlKHRrKTsNCj4gIAl9DQo+IC0tIA0KPiAyLjIzLjA=
