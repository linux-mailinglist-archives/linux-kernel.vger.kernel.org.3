Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054E44D988D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242225AbiCOKOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347031AbiCOKOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:14:31 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2129.outbound.protection.outlook.com [40.107.215.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CAA13E0C;
        Tue, 15 Mar 2022 03:13:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foFO9kmvz6isyf0JpY4kQYlvpm6PpdotoHE6XweTihbe21J9rjfg0NXGmjCMxlTfth11W4U3QPqMB89WgnF88RQulFVyECgyQTBZJJ0edpZqjrtxL+8+Qnk/2x4a1ks3z47u3r13Pzk5rjVtDMWEO5swQQLEJCkZLJ6gTR0BGbBFRsEEliTsjeEMYnTxThgMJ4hV6vQ/+ztg7IJuo662mg0auG0wCph270bluDTIOrhJy4qpLbWxQT9M43I9W/FO5jbbWg/wrXBtAuI4zDB07ehCMJIpI8uRi2z/GBa5bKgPvKceELt503r/MDXfTSV56GfkcYmfQfiRft15hYh4mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7zlsIkbqcOBSFySwZSRC3hgRZZ6jWKV838YpuSNqK0=;
 b=WVG+73r/Lx7jpMsb4kN7snhCTo5nc2aWIRAQ6zFj+SesfBZLfM79UOaOb43a2W+F14eRaqoBbzYwjEaGj2fB60X7TrqXfKVbs2izJrgPMnFYmCn25+bvfPKE+OT4W63IzcWbSWmJs2hcmsvL+StM+jiDA+pXFU+dO+3MJlgn0U9WG9Jjz3j5Te/pnPBj5RK7N2mX3grNds9Uon748A1lDLt4sgyLK7pu+AgPS0IH22VFLSVDT4dJzajiy3SWCniE1dEz+3xjY2yMOGtPeoWDROYjdSP59cx8atqZ5ihMWJ7Hzxgbhb8gyBCsMH8CKltVLftxP2fjDloQX4K6/yi7OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7zlsIkbqcOBSFySwZSRC3hgRZZ6jWKV838YpuSNqK0=;
 b=tV020jlV50zVMlcACM1VjGDzx7xztX+ofl93ob0g2IxVKQ8rjziAM5E6VU7l+LJMGVvaH6obcqYcoAI3O8asJ5mprxLV6TY0S9nnb5R4CM7RIjSs84vy5yv6IZbY+kFdGnZSEqvgUvKPvBqyZvgzY0FsmKRAyiFy6ApHDLMn4HI=
Received: from TYZPR06MB5074.apcprd06.prod.outlook.com (2603:1096:400:1c6::11)
 by TY0PR06MB5187.apcprd06.prod.outlook.com (2603:1096:400:21d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Tue, 15 Mar
 2022 10:13:13 +0000
Received: from TYZPR06MB5074.apcprd06.prod.outlook.com
 ([fe80::ccc2:4496:1d7a:5aaa]) by TYZPR06MB5074.apcprd06.prod.outlook.com
 ([fe80::ccc2:4496:1d7a:5aaa%8]) with mapi id 15.20.5061.026; Tue, 15 Mar 2022
 10:13:12 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-power@fi.rohmeurope.com" <linux-power@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 28/30] mfd: bd9576: fix typos in comments
Thread-Topic: [PATCH 28/30] mfd: bd9576: fix typos in comments
Thread-Index: AQHYN5o2Di+IhQ02306czUzNfEBtPazAO1kA
Date:   Tue, 15 Mar 2022 10:13:12 +0000
Message-ID: <010e3c87-66b6-ea96-5d0b-3f86d034f039@fi.rohmeurope.com>
References: <20220314115354.144023-1-Julia.Lawall@inria.fr>
 <20220314115354.144023-29-Julia.Lawall@inria.fr>
In-Reply-To: <20220314115354.144023-29-Julia.Lawall@inria.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eaa2a412-5524-4aa9-22b4-08da066c69ef
x-ms-traffictypediagnostic: TY0PR06MB5187:EE_
x-microsoft-antispam-prvs: <TY0PR06MB518701D6848C0801358E65B8AD109@TY0PR06MB5187.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nXCN3beBH1CqFvF/JQy9X2EMlvK2wtxjHjvgeCis/O+I4KhG6KAHeikMZCms+PbMuTnqtWfkO14PiuEq0mbtAkKTd3ANqAUc/Rh2ojt1Mgmk64bZSF3RnHA+Cz3hMLZO3E6+DGSuf3Ap3UPm5qM8fxX9YduZ5h2RPJAAzpCBN1NbL42GZHxqSnvPOWVda0lSnOxbCQ2JmXduRdvpOqd1v/hPyueCBp4U8HtABeH2N9Zm7aHxSGWbpnC3ANh+O8Rgm5+56d9xMYAgb0gHicXPM1nqvjgp1/UAZEtM+kYXfmxDZjruHTF0ip+dU10KjvC2w+HpAWVDby4WyTOPY4AmTCcJOUSt9bOMgMAPHyX9oGaczz03dvahD+RH3KO/xp7HhMKezBr+4sqI7pQX5HGtMpudx8fugmKZvsGvmrmhOCIWJM5NUmF9RzO+tbYxpBUNZ9aY1BP2of3GDqeZM8XsvuW7pM53Ml7hsQjvSjWmpG4zNqO29QUCzbcuRrIuscUH77sVRLV+R7imwB7/Cr33i3UEOwhPQIWUTHzdat7rgP4kdGgI+itS77vovCMjzc1aNWr2uUIuxEhLwot6kjIVdan1tQzmQHYbZDz9Wv5hqtIx/Yasw/6Gx1f7rwr+a1KvnyUJUzE9xJIYWuSXX8fiALbd2Uj3kVec5utI+gjUBrYiDMLDjM09GrInz78Zf+R1Ti3Hb3w66oeyLzqxf+Rwg+NE0UJ1NTZxtDbFBq13A5Syl7irMkkt8frwx7coHibEakMJtwilVpsuCMuM3GPXZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5074.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(53546011)(54906003)(38070700005)(6916009)(6506007)(6512007)(508600001)(2616005)(316002)(31696002)(186003)(26005)(86362001)(71200400001)(8676002)(8936002)(4744005)(2906002)(38100700002)(5660300002)(91956017)(66946007)(76116006)(83380400001)(4326008)(66556008)(64756008)(31686004)(66476007)(66446008)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzdBc2w5OTBkdndqaStVTTBXYUhOV3Z1Y3grU3NXc2d0MjBrZks2bGR3elFK?=
 =?utf-8?B?SmUrOVJoaEtxTGcxNFJYV3FneTBBM1VSQlVPQ3pGZjN3amU0YWd4Nmp3R2xR?=
 =?utf-8?B?UmcxN3BBNyt0QUtQUGFzc0tGNk1tT2tmUmpaeExxS0E1dm1KcjI0QW44MGM2?=
 =?utf-8?B?TVBCTnRoMXhjN1ppMXlJQyt4V1JKbE4rbms1OVk2elNOR3R5YjQ5aEJVa041?=
 =?utf-8?B?OWVRYW9KdjVZb05zVU5WNE92SkE0VTgvWHRyWE4zY0J0cWV3enNHU24xQmxv?=
 =?utf-8?B?KzB0YkxmelR3Y3MzTDd5ZUN2WkNPRXc5eUxlZ2lKNkRhbElQck9DS3NON0V5?=
 =?utf-8?B?TGFjNUhUZmJVdndidit5NTI1ZS9nVGRzVFA3TFpWME95N05nL3JhWTNBdk94?=
 =?utf-8?B?Z1FoaUY2Y05rT2I1Y1hvbHhVbk5EaUpUcUlpKzdmWjFscGdlR1ZhbkJsdjJH?=
 =?utf-8?B?aFFxbVpQWDQ4RTE0bTMyd3pNUXdWTDNYc0kyT2tvbU9VdFRaUzNhWjJPODUv?=
 =?utf-8?B?L1Z5WTVvSElTbmllaXp5Q2xyS3pFYTZKVEdFbVk0VGlucjFvWFQySEtjSmRP?=
 =?utf-8?B?QmM3ZEx4dXkxWmlHbTNjNHFFUGpTRDFrdHlTd2dTdm53WVUrK0VvcTI1K1dJ?=
 =?utf-8?B?WmEvSFRheHpCbGNyRWpqOXBnN2V0dU92dy9aR01wZ1pZa1FtbjhoUDZreVBF?=
 =?utf-8?B?RGRUK2Q0bFlEaURuQkRGZ2pscWloREl6K2pYRmg3S1ZFVy80YzYvZVpWeEhz?=
 =?utf-8?B?bytFTVZKb3lOeEtnWlJIb2FJcVljd1pDRitnaUdFanhZcW9LMGN5ZHYycXlX?=
 =?utf-8?B?WUN4ZTcxRitabUpydGIvMm90NjYzdjNkTU9kODVEblRTZ3YzTVF1VVREeWlZ?=
 =?utf-8?B?TVJsV1NFMzQ3QlYyT2N1cXAzRjh3dThGSWJNSnlWQjFiNm1aWmZLbis2dkxH?=
 =?utf-8?B?V0RRUzJOS3VIbDd5YVdLejBGcmJNVkZFdGt3M1lTNzMxejZrczlxU2JGMmNh?=
 =?utf-8?B?T3FnMnJyY1k5NnloS0xJd3I2S3dzRHZRZHJ3elBkT2V5UlJ6SDFtMWZLbldx?=
 =?utf-8?B?MnlxUlI5ZmI2ZmdjUm1uOEZkUnM1NkVlSG5WczJnbDQ0RTVFWlJ4bklWbCtj?=
 =?utf-8?B?VEh0UkRxOGlBZ2ZOVUJ4UnFsYlZLRk96U29CVkNJMDRlVTE4TVQrYkpPcDYv?=
 =?utf-8?B?UWR5aU9ab3dXanc4L0g1V3dnNkkwQnNvWTdpY1I5Q3YwS1BzU2QwN0szNHN6?=
 =?utf-8?B?RkNCRGNrTDFWb1U2SFd3ZGdPVGthZWRDa2JxY0ZOMHV6RU9EaFFmMm5ONkJi?=
 =?utf-8?B?LzdoNTBKMjFnTnh1czJkcytiK1pBdThiNnBpa2U1TEl3a1kyeHlKZ2xvcGlC?=
 =?utf-8?B?Zm40aG9sNjNETlJVREtyTGpDMFZUaWtmU2VPd0grQXBJLzUybHNVZVYyUTh3?=
 =?utf-8?B?R3FVRVBrZVRDQlBFOUV0alNRODAzNUI1Z1J4ZHFPUENmZ09raDlZSHZxZjJ5?=
 =?utf-8?B?ajNES3JoWGlST1FvS0dLc0ZYbkhsZzE0ZFJRdGdTUkVacmtnQ0xva2NRWGt6?=
 =?utf-8?B?ODRwK0lXOHJYVm5Id2NLcUFZT3VaRE10OHNjdEMvRWREQk5udnh1aC9rK2x2?=
 =?utf-8?B?MWZKbnM3ZzBHWWNNZ0ZYZEROR1Q2U2dGeTdBN2ZVdTNaVTlHeXdaRmxDTlVC?=
 =?utf-8?B?M3c4bWtCM3RFK0JQbHUreERMb3luMWVCMTg0K2h6L2FSajVGaUt5bzlrQlYr?=
 =?utf-8?B?bHZvTU16VUp3STE1ZzJ5ZXpMYmdMVDdZOURlajVURitzN2tRQnVPelVMWFd5?=
 =?utf-8?B?czNVeE1BSnJ6Ri9QU1UvRk16Ull5ZHhHd2p1cnVIODAyU25hNnpTRkJtS1BO?=
 =?utf-8?B?NzU0UWxKWHpyK2VHYjFRK1VMRHNsQU5SbnFyczRwYXY2YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0DFAE31E89CB74286BC49E8B25A48D0@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5074.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa2a412-5524-4aa9-22b4-08da066c69ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 10:13:12.9079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sgcLbgFtDtomcwRM+ZoJ1j36xHxXpZQd/AZ24ch5b16I5fYSP8AqZYonqktsbqHJKuO2hcQUw1ZyLxeAYX/hs22oGnCOFgzieiDSmPEFBQ7dwoJ201zcrzTnDImhsx0Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5187
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIQ0KDQpPbiAzLzE0LzIyIDEzOjUzLCBKdWxpYSBMYXdhbGwgd3JvdGU6DQo+IFZhcmlv
dXMgc3BlbGxpbmcgbWlzdGFrZXMgaW4gY29tbWVudHMuDQo+IERldGVjdGVkIHdpdGggdGhlIGhl
bHAgb2YgQ29jY2luZWxsZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEp1bGlhIExhd2FsbCA8SnVs
aWEuTGF3YWxsQGlucmlhLmZyPg0KUmV2aWV3ZWQtYnk6IE1hdHRpIFZhaXR0aW5lbiA8bWF0dGku
dmFpdHRpbmVuQGZpLnJvaG1ldXJvcGUuY29tPg0KDQo+IA0KPiAtLS0NCj4gICBkcml2ZXJzL21m
ZC9yb2htLWJkOTU3Ni5jIHwgICAgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWZkL3JvaG0t
YmQ5NTc2LmMgYi9kcml2ZXJzL21mZC9yb2htLWJkOTU3Ni5jDQo+IGluZGV4IDY2NjFhMjdkNjlh
OC4uZjM3Y2Q0ZjI3YWViIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21mZC9yb2htLWJkOTU3Ni5j
DQo+ICsrKyBiL2RyaXZlcnMvbWZkL3JvaG0tYmQ5NTc2LmMNCj4gQEAgLTIzLDcgKzIzLDcgQEAg
ZW51bSB7DQo+ICAgfTsNCj4gICANCj4gICAvKg0KPiAtICogRHVlIHRvIHRoZSBCRDk1NzZNVUYg
bmFzdHkgSVJRIGJlaGFpb3VyIHdlIGRvbid0IGFsd2F5cyBwb3B1bGF0ZSBJUlFzLg0KPiArICog
RHVlIHRvIHRoZSBCRDk1NzZNVUYgbmFzdHkgSVJRIGJlaGF2aW91ciB3ZSBkb24ndCBhbHdheXMg
cG9wdWxhdGUgSVJRcy4NCj4gICAgKiBUaGVzZSB3aWxsIGJlIGFkZGVkIHRvIHJlZ3VsYXRvciBy
ZXNvdXJjZXMgb25seSBpZiBJUlEgaW5mb3JtYXRpb24gZm9yIHRoZQ0KPiAgICAqIFBNSUMgaXMg
cG9wdWxhdGVkIGluIGRldmljZS10cmVlLg0KPiAgICAqLw0KPiANCg0KDQotLSANClRoZSBMaW51
eCBLZXJuZWwgZ3V5IGF0IFJPSE0gU2VtaWNvbmR1Y3RvcnMNCg0KTWF0dGkgVmFpdHRpbmVuLCBM
aW51eCBkZXZpY2UgZHJpdmVycw0KUk9ITSBTZW1pY29uZHVjdG9ycywgRmlubGFuZCBTV0RDDQpL
aXZpaGFyanVubGVua2tpIDFFDQo5MDIyMCBPVUxVDQpGSU5MQU5EDQoNCn5+IHRoaXMgeWVhciBp
cyB0aGUgeWVhciBvZiBhIHNpZ25hdHVyZSB3cml0ZXJzIGJsb2NrIH5+DQo=
