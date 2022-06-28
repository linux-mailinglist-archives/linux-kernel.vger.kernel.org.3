Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C978455D5C1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244792AbiF1Fye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 01:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbiF1Fyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:54:33 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90084.outbound.protection.outlook.com [40.107.9.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09E0275F3;
        Mon, 27 Jun 2022 22:54:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHG2INMkMgeQo7I96p8Eql2kzSWGDwlZnyPqG0loPqIwjIDIG/29FZapLSQQ8+pUVulInMQk4Xc0M6OyaQAGk3za3maQ+Qu6vpPEtLKfa4QKWfahBmnFCDelJDbzA5ELC4yYghDmLXoaBfjYAy6D6vF949igi4FDWd40DjncwReLevMKlOkEAxPsfQwLFdTpAxgkmF6o/DW0x1/ieo8ZTlPWKeUe97Lc2WIiBVVsWEZWN1j+tvDD7P/NQsAxNfUjsRNcjfr7+wbgrVCrKSFKZHffUvVUJDdO/EI76iCId68hJYhPJo+oGmhnAt0lQy2KEHfdtLsZgjd8NAYa5H1byQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmFLElqJ6k7+n6gsgB8fF57uS7RtlvICpDbasEPghmU=;
 b=QRx9GFvAvnuVwrkQr7EDX9ynodzNULRgY12yAtdP1s7K3Zy9R+2x8PAzZTVGt1LKzSmqY7Z7eKZXRgcXSJUbCYa1M183t5ACKWxNw4aTAj8Bm2n9qX6PauqJMQn9BcnpbbizJOGfKs3+TgfoVVSkV8Y+TYdf237F1cnR5kP4hUZgUp8izwwesWSq7MTVaHpjqnXZElQrgIYhSs10vSzfHzy+MXRyXYjKognqxyX0tS6KhLXUS6oqoOtCQLL9w6F9ymqlvPELcTX0zLwbX3meESOxmny26opZfEFkwmqgfYKk3Z+vbatLfupxfCRUHghOkAJCgQzjsMew18qoNrwd0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmFLElqJ6k7+n6gsgB8fF57uS7RtlvICpDbasEPghmU=;
 b=YUp6HhPWGFEr02uKgAnyew2D5MXvLdS64KWIj0CnmlMsXbI0O/BRWpn2jQtMmdgSThTJ3C2pxTs/X+syDXwU2Vk9LF3cFij5+YtuDBxuJUK4/LvVPG+zb736Hy5KEVACN+QmDq8tu7jm72S1kNx/jBJVhkIHVdyrnzmeWIJ+MRyDbYZepshH8zUKBP772/rXegX5ZDBZe0XSqLez2o434ZNBZxf4j65D40ZYMgLTGs4EiniaVALzr8iXIhydjAj/H8Qp4YsSxZ/R3OKWI410ABrP6FiMiBJsDc5fw88zWTg1SFZdc2O47p7X6rwnmJMosU9EqckSy2C/w2+8mYq91Q==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB3484.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:163::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 05:54:28 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::e10e:bd98:2143:4d44]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::e10e:bd98:2143:4d44%3]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 05:54:28 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Aaron Tomlin <atomlin@redhat.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
CC:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] module: Show the last unloaded module's taint flag(s)
Thread-Topic: [PATCH 2/2] module: Show the last unloaded module's taint
 flag(s)
Thread-Index: AQHYikTbUdkHh6fPnEGMFwf8xJyI+a1kUoOA
Date:   Tue, 28 Jun 2022 05:54:28 +0000
Message-ID: <4ddb64da-58f0-a4af-cf57-a870015a0077@csgroup.eu>
References: <20220627164052.2416485-1-atomlin@redhat.com>
 <20220627164052.2416485-2-atomlin@redhat.com>
In-Reply-To: <20220627164052.2416485-2-atomlin@redhat.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53a1b2c1-deb6-410e-15bf-08da58caaa22
x-ms-traffictypediagnostic: PR0P264MB3484:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ThcGAmk3e6auKEsxyAWVPhlMdeUgEsztqRjCTvjSJdcYxFbzcKqpAuPFMxJP89x5DaiNd8FfMtCSNWvoMy8ezKLV1UUQOz6+vddPNcP5LV4QpiPXf8InN1zYfmLrNLa+VfTKrKZaqVh9xlu4xL83/8QxiDUsuMe/gD9fEgPz3ci4oIo0LtxspLZRbC2vXXpZytuN3rCpI1387nBJSH1QqBO9IrlEmIpPncGuxLIVb8ywUDj65NSPRXLIM3V2EAAoLl5cV6Wg8TJu1bM6ISrRtbp7HGPuoDkY/Hc4b45vRCFQyDDDb3LlRC8CfMqm/g1Jg5R7lftoLI35cMy86zpL+bO4DaP6perNa2S0bbS//k2hy818amBjHBkxUM78173y0IXru8nZ+GThA+7SaWug/yMyrTOg7dmnQe3Lo0uOoOPdX/tcoHolEtsVIBW/AIX4BVpl+1Ti0tGGa4ft+w4G1nnLE1v3KE0PMTlXxGi4W51JizSNVdES7jJOWSPKZgaOUnyAyzfFV6X+S10Jka731Q+aFcy9y7mhEdnsIEa5/Pic+5NI3N0Wb934kxLm9zSvKxU7IX3DbtVqiPJjCG0s0p+3TSrmhPHh+IDd2oL8eU8ltkCfy96htsDFQaqQVXh+Qx41tiweEQd1w8Ri4/AyuFa0eHDJIzoQZpy0xR5eo0m/Zd7KP6EjR//PNOES8axPDWgZGuxv4hqG7EcuXp3wgTzXEDVev14g00souijNmJJCLnUKUV/6koUmW0c9drvL/eC6UG7xrVGIf6MUiqqeFb9j8tKhX97d+vy2kGMTIqWcnfaw33vy5zxqYz4zUT0N4gwmDPr2LKR27zjb7/HoGmd3R8lESGJXySlhHAopK8U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(110136005)(5660300002)(41300700001)(2616005)(38100700002)(36756003)(31686004)(54906003)(186003)(2906002)(316002)(66446008)(64756008)(66946007)(31696002)(76116006)(26005)(8676002)(91956017)(6506007)(86362001)(71200400001)(4326008)(83380400001)(44832011)(8936002)(66574015)(6486002)(66556008)(6512007)(38070700005)(66476007)(478600001)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGtyellFQXBuYWEzQnpIbFBqYXF1MmZla1p0aGg4ek9mcThWbkQ5TGVudUpR?=
 =?utf-8?B?L2Y0UnJyVXB3Y3ZOU3FJNEZId1Fka24yOU5ub2hnSUFFbi9lOGR0dzRKT1ZL?=
 =?utf-8?B?bnR3VE95alc2K0dtaXRvZ05VOCtJb1dTZjFEQ0pBbUQ3Q2R6bGczb0s2d21O?=
 =?utf-8?B?N056TmtpVzAyaHRPeDEwenZlTnN0dHpFVmVwa1JwWFVTdVBIYm9GOEU1ZFo4?=
 =?utf-8?B?Mjc3K2xkRUZ4Mm9ZKzRldXNpRURSaGlPK2ZzM1JFb0lLOXRQMEpwQTVoem9O?=
 =?utf-8?B?V1FLcUdTUVNWdGFUL3pEUjYvaVVhaDJ1bUNjc3ZJaU51eEpKZnlFTUp3L3RT?=
 =?utf-8?B?YU9oMG00czAwbldSNjhqR2VJZHBDbk5NT1lxTUxXNVdRcXlFYnAzR1lyRllh?=
 =?utf-8?B?T3pIYW1yTHEzUXZtd0xldWpaNit0OG9zYmlTeEJ0d2ZyYStZNDFHaXh1bCtT?=
 =?utf-8?B?SG03UVZLT3BCUE83bmtpVFk2U29oWTlaSCt1MTgwcGVvRmZsZDdFNHpjT1lP?=
 =?utf-8?B?R0ZDTVhhem5mNXhESUFXREg5VVRZRzZiTU5iZDhwMTlwUTR5eEtDRzRaS0hC?=
 =?utf-8?B?MmFsaUZmNWEyZTl2bmNCSndDL1BQVFNEeTlreFJ2UFRCb2FoYVhHUTZNN05P?=
 =?utf-8?B?TkdadHZ3eFpudnNWZFJBZWVtTmRjb1UyZTBCK3dTakRMM2hKcVk3bnhGQ3Z4?=
 =?utf-8?B?Zm43MFd2bEc0MzZnSUdkbExHbVFGN1Q3bFZRR0tZang3QUE5VEFzY1RTUTc2?=
 =?utf-8?B?bllQMzBzUkpDZnc2RkdPc0VYWlIybnlQSnhycWRzdThmZ1dWY2gxUm9OVEtq?=
 =?utf-8?B?TnVzZTRCOVFkU3Z4QnprUUVVRVROZTlRR0gvd3ZuWXJiZHhCQU1QU2FjZ3NQ?=
 =?utf-8?B?K1NTZDZtRGttZHY5VCtLVmxHVGpPSzloSFhmbHpaSG1sa3VtTlRXdVF5RmFK?=
 =?utf-8?B?dHpKRGtwZHNNMVp2bVhVZ1ZpOTM0N3NkVTZIeENtS2hsdmY5N0FjVzJ6dmRF?=
 =?utf-8?B?ci9LQmFUWjl4SXVuNlo3WCtDNFNwcCt1dUQ3aWp0aSs5UVZaRGxzZjdlT1JR?=
 =?utf-8?B?VHJOaUlONjk4SFhlSWFHVGJvdW9LZnVjV0cwbWpWVkgzTERoalBobk1tU2VC?=
 =?utf-8?B?ejRlamU2UDRzYUpCS2NjekRUdytMS1ZoMDZHOGpVRlVadmN2WmdtbmE5a3h4?=
 =?utf-8?B?dk51bURTNy9aRUlIdC9hdmh0SHhMT0lhOHFyc1F5dktCZXQzaUpvY0g0am13?=
 =?utf-8?B?Q2laYmYwSythdmd6dXNScTdiTTJJRVRNK29xdUViYm9ESSt1MnFMNm1OVS8w?=
 =?utf-8?B?V2VuNlp6TDBYTG00eDJoT0ZadFU5aFA5NW9uUlZIRW5CNytvRVFvSGt5d205?=
 =?utf-8?B?UmZFY09OY3Z0S3FDRmFNaVdrSDlCZDlUUy9rd0NVclBWU1crWU43cUNUclNB?=
 =?utf-8?B?K1FUeldwMC8zckJoUTE5bE1sQWRpbjFwR1Q1eEFSQS9Kc0FVWFl4bWNzV1gz?=
 =?utf-8?B?MHZScFFGcnlLZ0R1NmMvN3A2MVVKamVhcEtML1p2NGJMVEVXZXFYMGNyajB6?=
 =?utf-8?B?WkFhakNod21KUzkyTHJiQmJjbEc5VUQzNVFZSmx6dElRSjdxemZPSUhHZGNS?=
 =?utf-8?B?LzVQZEowMEFQZ3hRWkNSVXlMdGdiVFZXRVRHTDdPZkxiaFZaRjVqWXZCVTVK?=
 =?utf-8?B?ZGpUN1M2L3Y3VHNWVURPYzY3N01kTU1GMk5LbVIxR1FrcWwxVGJ4OHNIUXJv?=
 =?utf-8?B?em51QkZidk5ESHBXSmNRdm51c0JoNGNWdlEvMzJDcnMwRGZSN21OS3RyZ2Vp?=
 =?utf-8?B?Q1ZuOHoxNXkwSEs4TUluYWNHMGhhdFZwUnRUc1N1TmxmV05FNHRvSnk0azZl?=
 =?utf-8?B?S1o5S2lvd0ZoZ0tQUTNkcDcxclN2SXhBcVlYb25oSWhmVUw3NFJRamRrQlpt?=
 =?utf-8?B?WDBhTEV6NVk5VmlteDlTRm12c1Z1bEN4VGxjdEtFTWFiLzlRajB2Rldva2RX?=
 =?utf-8?B?RmF2WmtCa1J3bWY2REZNQnp2bzdDaFRNMDJVRW1oeEZOaEVsQVppUlFDN01Z?=
 =?utf-8?B?ZFg4TVJwNDJWSW05SjZiMzB3NDJremdpMnZ5b3VCOEhaSWgxcUxoamxyOGVJ?=
 =?utf-8?B?M08xcCtiazJVTEtkTEoxYTg3MUo0MFc5T3FJRHRicVRQdEVpREkvWkZZTWhJ?=
 =?utf-8?Q?Jim/Qy5CD4dCAHgmOjA4E80=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <611B49023B6F3D4AA0CE50A4CB573C70@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a1b2c1-deb6-410e-15bf-08da58caaa22
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 05:54:28.7188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ywu0Ni35q8zoEp2/aPDRmo+Fr4psHE/x8q75jaejJXTRjoEcMHFk4ZKL4AcLAFhowhk85G/4+7oiynUlh7c04kVZQh62BMUmiEayr+67uLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3484
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDI3LzA2LzIwMjIgw6AgMTg6NDAsIEFhcm9uIFRvbWxpbiBhIMOpY3JpdMKgOg0KPiBG
b3IgZGlhZ25vc3RpYyBwdXJwb3NlcywgdGhpcyBwYXRjaCwgaW4gYWRkaXRpb24gdG8ga2VlcGlu
ZyBhIHJlY29yZC9vcg0KPiB0cmFjayBvZiB0aGUgbGFzdCBrbm93biB1bmxvYWRlZCBtb2R1bGUs
IHdlIG5vdyB3aWxsIGluY2x1ZGUgdGhlDQo+IG1vZHVsZSdzIHRhaW50IGZsYWcocykgdG9vIGUu
ZzogIiBbbGFzdCB1bmxvYWRlZDogZnBnYV9tZ3JfbW9kKE9FKV0iDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBBYXJvbiBUb21saW4gPGF0b21saW5AcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAga2VybmVs
L21vZHVsZS9tYWluLmMgfCAxMCArKysrKysrKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvbW9k
dWxlL21haW4uYyBiL2tlcm5lbC9tb2R1bGUvbWFpbi5jDQo+IGluZGV4IGRjYjgzY2YxOGQ4NC4u
MGNhNmZkMzhiOTAzIDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvbW9kdWxlL21haW4uYw0KPiArKysg
Yi9rZXJuZWwvbW9kdWxlL21haW4uYw0KPiBAQCAtNTI0LDcgKzUyNCwxMiBAQCBzdGF0aWMgc3Ry
dWN0IG1vZHVsZV9hdHRyaWJ1dGUgbW9kaW5mb18jI2ZpZWxkID0geyAgICAgICAgICAgICAgICAg
ICAgXA0KPiAgIE1PRElORk9fQVRUUih2ZXJzaW9uKTsNCj4gICBNT0RJTkZPX0FUVFIoc3JjdmVy
c2lvbik7DQo+ICAgDQo+IC1zdGF0aWMgY2hhciBsYXN0X3VubG9hZGVkX21vZHVsZVtNT0RVTEVf
TkFNRV9MRU4rMV07DQo+ICsvKg0KPiArICogTWF4aW11bSBudW1iZXIgb2YgY2hhcmFjdGVycyB3
cml0dGVuIGJ5IG1vZHVsZV9mbGFncygpDQo+ICsgKiB3aXRob3V0IGEgbW9kdWxlJ3Mgc3RhdGUg
aW5mb3JtYXRpb24uDQo+ICsgKi8NCj4gKyNkZWZpbmUgTEFTVF9VTkxPQURFRF9NT0RVTEVfTkFN
RV9MRU4gKE1PRFVMRV9OQU1FX0xFTiArIE1PRFVMRV9GTEFHU19CVUZfU0laRSAtIDIgKyAxKQ0K
PiArc3RhdGljIGNoYXIgbGFzdF91bmxvYWRlZF9tb2R1bGVbTEFTVF9VTkxPQURFRF9NT0RVTEVf
TkFNRV9MRU5dOw0KPiAgIA0KPiAgICNpZmRlZiBDT05GSUdfTU9EVUxFX1VOTE9BRA0KPiAgIA0K
PiBAQCAtNjk0LDYgKzY5OSw3IEBAIFNZU0NBTExfREVGSU5FMihkZWxldGVfbW9kdWxlLCBjb25z
dCBjaGFyIF9fdXNlciAqLCBuYW1lX3VzZXIsDQo+ICAgew0KPiAgIAlzdHJ1Y3QgbW9kdWxlICpt
b2Q7DQo+ICAgCWNoYXIgbmFtZVtNT0RVTEVfTkFNRV9MRU5dOw0KPiArCWNoYXIgYnVmW0xBU1Rf
VU5MT0FERURfTU9EVUxFX05BTUVfTEVOXTsNCj4gICAJaW50IHJldCwgZm9yY2VkID0gMDsNCj4g
ICANCj4gICAJaWYgKCFjYXBhYmxlKENBUF9TWVNfTU9EVUxFKSB8fCBtb2R1bGVzX2Rpc2FibGVk
KQ0KPiBAQCAtNzUzLDggKzc1OSw4IEBAIFNZU0NBTExfREVGSU5FMihkZWxldGVfbW9kdWxlLCBj
b25zdCBjaGFyIF9fdXNlciAqLCBuYW1lX3VzZXIsDQo+ICAgDQo+ICAgCWFzeW5jX3N5bmNocm9u
aXplX2Z1bGwoKTsNCj4gICANCj4gLQkvKiBTdG9yZSB0aGUgbmFtZSBvZiB0aGUgbGFzdCB1bmxv
YWRlZCBtb2R1bGUgZm9yIGRpYWdub3N0aWMgcHVycG9zZXMgKi8NCj4gICAJc3RybGNweShsYXN0
X3VubG9hZGVkX21vZHVsZSwgbW9kLT5uYW1lLCBzaXplb2YobGFzdF91bmxvYWRlZF9tb2R1bGUp
KTsNCj4gKwlzdHJjYXQobGFzdF91bmxvYWRlZF9tb2R1bGUsIG1vZHVsZV9mbGFncyhtb2QsIGJ1
ZiwgZmFsc2UpKTsNCg0KWW91IHJlcGxhY2UgYSBib3VuZGVkIHN0cmluZyBjb3B5IGJ5IGFuIHVu
Ym91bmRlZCBzdHJpY3QgY29udGF0Lg0KDQpTaG91bGQgeW91IHVzZSBzdHJsY2F0KCkgaW5zdGVh
ZCA/DQoNCj4gICANCj4gICAJZnJlZV9tb2R1bGUobW9kKTsNCj4gICAJLyogc29tZW9uZSBjb3Vs
ZCB3YWl0IGZvciB0aGUgbW9kdWxlIGluIGFkZF91bmZvcm1lZF9tb2R1bGUoKSAqLw==
