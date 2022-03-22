Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B6C4E3FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbiCVNiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235764AbiCVNiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:38:12 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2074.outbound.protection.outlook.com [40.107.114.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC6A7EA12;
        Tue, 22 Mar 2022 06:36:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcRX4JsPG9NhrYykvAJQepOsskVKveV90ilFOeKa+/IWg2LeYVQkbLu326336naNz3fTuyF+qFEzAB3hJ6CzAz+pGqJWPpdNxUhaq5Vovucml9hbspLwvosnFptGPlPaktBO4ebUIK4AWb33+AxRelzYFDR9ESFlHTym5XbRXSm0I3UKsEs5yhzoUlFGyfzIXYtetAio0cTPgToD3pyp2P6RCLERo3sYm2SmT+FEL8wcEQG54RY0zR7mEjJLVg40xJC7/9AIVDkdq+mDppgZHZ55YhQXro5q6GywUqffdRFBkg5rLKFrFBanE9ooQ9nYoxU0KzvvsbBKJA7yeM5d6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNBX6oeX1hyWHYKJNj9LakDUpHqrDLJqReNMyIJqlVo=;
 b=a4IOli1CGHF1w9VK9j2r9eD65SjEuW9aDBVhJm3BbVCSLaLorh0YQjvnxAaQx0eRJFIV4EFn6caeYPBp9/o/etAZGbev3sfewTSc8BfxdpZWNlA4DjVOhgoEdAmeArPB3Kq7hQg+FpW5bC48D2byPpI+dHSudnr7067xH/F302pgwWhFi10e3OZ/PRSsPwEbO3sCX15KVCAiaEItffuWHECORs6ytjuTn0DvN1UAhiFxIOPodAsdXW09AxUe+hfOeRtrPg9Ok7Ss6lGcl0cKD+6fMLtBaE1c8W2QUDKApiuXzW0uAi8bugF3d/AFJlV610CZJJ2Zw+XoXRcKy6lpUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNBX6oeX1hyWHYKJNj9LakDUpHqrDLJqReNMyIJqlVo=;
 b=XZhX1go+bk1alfOJzThLGBdbRHhpVvzAN+0I9OoOZna7qBiaUD2K/tq2HBwN9wz/5vXWI21EwsjfZJtZ2cFTvdjoiq/XxKCDAPLkgq5IgrU/3TOH3bnNDwQ9rqP8CJl53mqnXppcAMi36KTXCdy6yjSZoldvBEq2tIqMEFA3vLE=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSBPR01MB5238.jpnprd01.prod.outlook.com (2603:1096:604:7f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.16; Tue, 22 Mar
 2022 13:36:42 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::cdeb:f61:5132:905d]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::cdeb:f61:5132:905d%8]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 13:36:42 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     liqiong <liqiong@nfschina.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "yuzhe@nfschina.com" <yuzhe@nfschina.com>,
        "renyu@nfschina.com" <renyu@nfschina.com>
Subject: Re: [PATCH] mm: remove unnecessary (void*) conversions.
Thread-Topic: [PATCH] mm: remove unnecessary (void*) conversions.
Thread-Index: AQHYPeaFVobErUFm40quouxogrZDM6zLZ+yA
Date:   Tue, 22 Mar 2022 13:36:42 +0000
Message-ID: <20220322133641.GA208386@hori.linux.bs1.fc.nec.co.jp>
References: <20220322121338.27428-1-liqiong@nfschina.com>
In-Reply-To: <20220322121338.27428-1-liqiong@nfschina.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7595f9d4-7890-486c-9459-08da0c090017
x-ms-traffictypediagnostic: OSBPR01MB5238:EE_
x-microsoft-antispam-prvs: <OSBPR01MB52384471CB8561301BD128CAE7179@OSBPR01MB5238.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SXg+3fK5OCAmmVjvugGgaDp1EDBMaMSQVjhl84QxBUD8JpEyNj1AC4PndeVi9V8VNMRILlA6+zeFUPzKH2Dr+NKYcPVVYLonptVXsWfZHPAFrkPDvnBCm/HNCcmu8KgNTjSatKlXXUsMoZ4HCxWlX2YyZhiYXcAu2d+2MnXGZudAAxQv2+WEGt1BoXAFn7uq83yBAMaRA/T0Rc+6+/XCZvR0IW4l6DRNiGoNqFoDXSL1TdybGhYz0UxDl31upuv6Ae/g8z6Yudl6tAFZ8E90RV0GFyRSAgJCpr8QBdwLQeFT7xVGb0zjU9YEU2lQKlMopsFR2mJpNhA39uUw9xP2C4iR5+KC/TJ9gO1apwx6jHWSFlkZZp4XqUIME6A7c1tJmt57pKxM4Xz7CBDpsANREL9vUL3lsIxqi8Ol/5tJ5AB33+U7+UF7njI4jgM3KxAi4PxETrQL/kqOOG6draVaWRC0N9IUJSHZuHi2f53t4xF8SRoGb+nthGTeLWfgz/SK7pKH1/NwwYZb56+thiy+FRd3fi3EYf+U1lbpg0N1I7QrQsOsnDPtMmZ4nwf7Jc5o6/gU8LIJ9jru5Dm1WWuEuxfw6e4lMJwH5Inj/3FBh+G+KFBMVHEcL6CZGyjm8yLPbhgm/O1fFw6TSxmi2SvBR0yOGt1xI/siMWbHoZArKM2+iII56A2HVdGNHoQNRaKYcIfEHdwD5+uxV4/ngoWnVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(122000001)(83380400001)(316002)(54906003)(38100700002)(6916009)(82960400001)(508600001)(6486002)(66946007)(66476007)(66556008)(76116006)(85182001)(8676002)(71200400001)(4326008)(66446008)(64756008)(26005)(38070700005)(1076003)(186003)(6512007)(55236004)(2906002)(9686003)(5660300002)(8936002)(6506007)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0FoVU8yN1RWMEprUnV5SHdnWURNbmlKYjhlQktMejBZRDEyQ2JHYjFFaUpB?=
 =?utf-8?B?S0JUZ05MWnlDRFJCdjJoSHpxVXMyRTlYQThxMUxvc2YremcyVmNIN2wwdWZZ?=
 =?utf-8?B?NHlaQU9Db2JtVkxvYUtYL3ptM0l3Qm5UUVhLY3prazlmVnczNVZMY29acTZ5?=
 =?utf-8?B?djAycEdPeEJVUzh6UlpHWWRjem5oRXZLZkg0dUhmRXV6dVA1NlIyWUhObkdC?=
 =?utf-8?B?RklacmVSbEFUUDcyL3RKRGxWWmFLQjB4RW1Jb1Y3S2VEblhuU0Y0Rkg3UytE?=
 =?utf-8?B?eVk5NHRaRk1PU0VINGJ3eWFxc1ZqYWRjVTZQRFBqL0ZVNkN1Q0NsU0hOVk4r?=
 =?utf-8?B?clZodXlqZE5RWDlXSHkybi9GZ2UyWGVVS0FHSDlPbXJBclljRUwwK0Y5Z0dq?=
 =?utf-8?B?bTN3dWU3OG9pOUYvckZieG1ha0JGNkVwZ3ZSM3dzbUd5aGhxVjdTZTg4NmJy?=
 =?utf-8?B?NUt2ZEVRS1p1QjhKd3IzK0NqL3A4S2ZnTE1PUUlsOUxkQjhOdFJpdjBCaXdk?=
 =?utf-8?B?VS9kSGxnb2h2djh6VXBxTzVYTm9HL3ZueWdPL21XVy96ZGZta3VOb0pGVkkv?=
 =?utf-8?B?YWZGMmVwM2ZHaytaVDl0c2xHRG9kRGJHaEwvL2RYalJ4b1N5Z2pNUGVQbVJo?=
 =?utf-8?B?U3NkMTFFYTdzZXhSdll6aFVBZVRKMk9qZ2hNTFc4MnBkZ3VPMXYyY1k4TkRi?=
 =?utf-8?B?c09GajBxa1EyME5JWlFrVVZJMEIvaWRpUGRpbUg1TGRNNnpvVmhZU21kQkxP?=
 =?utf-8?B?WGpmL1N4VmVHb1hmNjE0a0syQzNnV1BwQTJJWEJKTm0rdC9pcENxTndzbjZw?=
 =?utf-8?B?Y0tKb3Z6bVB5U0tOTVRFSmQ3VDhnc3o1QmxBMlBsRGV3ZFFIU2VjNGFwdnFP?=
 =?utf-8?B?K2pROFFDdnJUaEw5R1kvQnFMMmwzYkxmTnVqdUprc01FRjZwQ2o0czIrdkVL?=
 =?utf-8?B?N2NHdytJQ2VYbmN2WjNuMVpqU0VuK0lrc1pHbHIxWWMzSnl4V0JmY2p2eDhE?=
 =?utf-8?B?am1maC9oeVNVWGY1d2pZbWRTeWpuaU9kdk9KS3lBQmdyTS9MbXB2dDhZMGV4?=
 =?utf-8?B?UVN1N3JwbGRRM3F3UXpSekl6Q05ReC9qdU53bWVIc2JpV29MdTlaV2hVZGxD?=
 =?utf-8?B?K21QWDQ5WEUySDRKbGlzRTN2WUxiMlNQaUN6VmVRcVAwTlZoc2hWOUoxRE9L?=
 =?utf-8?B?dVgyUEt6RXd4NUJuZ2FqM2JiUkdBZ3d6c2JWQzNta0dxcUFueHZiaDA0QXps?=
 =?utf-8?B?WWpKeGZRL3c5MlVCc1ZtOVJKOStiM0diQkE2c2tNSTUvTWdnaDE3Ym0wejRB?=
 =?utf-8?B?YzQ2aE1YS0lIdjM3cFBSL2Uvc3ZrMlEyTlk5N1k3TUFoVkpyaDk3YktpOHBD?=
 =?utf-8?B?VEZvS0hUcFJvUXdSU0Q0b2pHL09xNlhibWtJWmhBN1hxcFdVdVdnSXE0NW4w?=
 =?utf-8?B?OGMwYVI0akhoUDZtT1p5cGJ1UEVEUllwKzZvVlhDTGVNWk9KL2xMci9EOGUx?=
 =?utf-8?B?Rjl0R0lJUnZDMCt1ZHozNlNXQlI2QzRXVFN3SS93UUIwdTFQR3ZLNkJkV1ph?=
 =?utf-8?B?ZEdDZWl3cUFSTGx5aU1PRUh3eXhoazBVa3VQRldYa0xNN1B2ci9zMmltZEFo?=
 =?utf-8?B?VzZkODlsOExFb0VBZ1pvWnh6bDVwZGhrc0QwcW1xejl3NWNEeG1pVTZ0VC9v?=
 =?utf-8?B?aS8wV2ZNNGtrc3F4QlJnQnVPaGx4WW9ONm80SVF1NnNqRGhxR0RnOURwSlJP?=
 =?utf-8?B?WUFaMjJjNjU5T3dNR05sN21vYWU3OUVpRWpEMUZ1UjNqUVY1b0gyOUFKNmJV?=
 =?utf-8?B?UUlPTHZ2OGo3QUtXMld1QTFrb005czk4ODFUTGdEVVYrb0c4aVA2SWt2VWpo?=
 =?utf-8?B?YTVVOEJtYXIwZFBPUGVsS2puMk9adnZiR2xzOE5EY1ZjcGxuMVVoNW1tKzRs?=
 =?utf-8?B?SFpXajBRRDAxdXNTMVFWYlRVci80QTQ0MlE3Wml1czlmSzVVWUF5YnIwT0Vl?=
 =?utf-8?B?M0tTQ2VPdVhnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DECAC0A16101C488DC2C9520FBEF4A9@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7595f9d4-7890-486c-9459-08da0c090017
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 13:36:42.1349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GWe2zqEjP/LVafXn3q4SDVTLuefSRpWz98Vmrp4yKnZQI3FdYHzrbKe2wCQ97yF0b61HZEa+MRA+5gbv5SErxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5238
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBNYXIgMjIsIDIwMjIgYXQgMDg6MTM6MzhQTSArMDgwMCwgbGlxaW9uZyB3cm90ZToN
Cj4gTm8gbmVlZCBjYXN0ICh2b2lkKikgdG8gKHN0cnVjdCBod3Bfd2FsayopLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogbGlxaW9uZyA8bGlxaW9uZ0BuZnNjaGluYS5jb20+DQoNClRoYW5rIHlvdSBm
b3Igc2VuZGluZyB0aGUgcGF0Y2gsIGxvb2tzIGdvb2QgdG8gbWUuDQoNCkFja2VkLWJ5OiBOYW95
YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KDQo+IC0tLQ0KPiAgbW0vbWVt
b3J5LWZhaWx1cmUuYyB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tbS9tZW1vcnktZmFpbHVyZS5j
IGIvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiBpbmRleCA5N2E5ZWQ4Zjg3YTkuLjRlZDBkY2YwMzY1
OSAxMDA2NDQNCj4gLS0tIGEvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiArKysgYi9tbS9tZW1vcnkt
ZmFpbHVyZS5jDQo+IEBAIC02MzAsNyArNjMwLDcgQEAgc3RhdGljIGludCBjaGVja19od3BvaXNv
bmVkX3BtZF9lbnRyeShwbWRfdCAqcG1kcCwgdW5zaWduZWQgbG9uZyBhZGRyLA0KPiAgc3RhdGlj
IGludCBod3BvaXNvbl9wdGVfcmFuZ2UocG1kX3QgKnBtZHAsIHVuc2lnbmVkIGxvbmcgYWRkciwN
Cj4gIAkJCSAgICAgIHVuc2lnbmVkIGxvbmcgZW5kLCBzdHJ1Y3QgbW1fd2FsayAqd2FsaykNCj4g
IHsNCj4gLQlzdHJ1Y3QgaHdwX3dhbGsgKmh3cCA9IChzdHJ1Y3QgaHdwX3dhbGsgKil3YWxrLT5w
cml2YXRlOw0KPiArCXN0cnVjdCBod3Bfd2FsayAqaHdwID0gd2Fsay0+cHJpdmF0ZTsNCj4gIAlp
bnQgcmV0ID0gMDsNCj4gIAlwdGVfdCAqcHRlcCwgKm1hcHBlZF9wdGU7DQo+ICAJc3BpbmxvY2tf
dCAqcHRsOw0KPiBAQCAtNjY0LDcgKzY2NCw3IEBAIHN0YXRpYyBpbnQgaHdwb2lzb25faHVnZXRs
Yl9yYW5nZShwdGVfdCAqcHRlcCwgdW5zaWduZWQgbG9uZyBobWFzaywNCj4gIAkJCSAgICB1bnNp
Z25lZCBsb25nIGFkZHIsIHVuc2lnbmVkIGxvbmcgZW5kLA0KPiAgCQkJICAgIHN0cnVjdCBtbV93
YWxrICp3YWxrKQ0KPiAgew0KPiAtCXN0cnVjdCBod3Bfd2FsayAqaHdwID0gKHN0cnVjdCBod3Bf
d2FsayAqKXdhbGstPnByaXZhdGU7DQo+ICsJc3RydWN0IGh3cF93YWxrICpod3AgPSB3YWxrLT5w
cml2YXRlOw0KPiAgCXB0ZV90IHB0ZSA9IGh1Z2VfcHRlcF9nZXQocHRlcCk7DQo+ICAJc3RydWN0
IGhzdGF0ZSAqaCA9IGhzdGF0ZV92bWEod2Fsay0+dm1hKTsNCj4gIA0KPiAtLSANCj4gMi4xMS4w
