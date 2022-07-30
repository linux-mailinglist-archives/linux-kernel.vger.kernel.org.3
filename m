Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB1B5858F4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 09:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiG3Hc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 03:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiG3Hcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 03:32:53 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2185.outbound.protection.outlook.com [40.92.62.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED655DECB;
        Sat, 30 Jul 2022 00:32:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCvIeecFjQh/TN5OudD0qFVJEUewjU+/JQWle0zbRzokJ2YqV43cFzgKWwndz4O25cpO2n/vwkMRHDfya3MuK3rJZWXV6w7ZWSR3VwPB5gTUP38PqZzsaUh3mwLuv1dcBDUKOJ3NtUQo8mM3Qm1XJRu0/e0eaFZ2vU5D62cDl+8ahqagyGbBKhJSdB3UTCyAMRhKSx8HplktFYxws1kAv6i2sGMVyLiBjtm99GqzPmXK4kFCV84NrIGEnzGw9ERP2qIzH1CSxOwrWvGT7mug8JbHLAgMT3HTIv1FJusMN0sq+3GqnncQ/abg4zD0usDY3sSRhAbGbZYGGrRuIZjbOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYXb61KHQL6ZPApaXhmiIARpkkFFGwMPAAIk1+tx9Ko=;
 b=npwmLnFRr0PMi0g4poodggbYAhMQG9olv3fjkEZG11bSIH8IA80MOC8XAVsOtrMQukyfLTfnhO/CshAgPUZI30wAPqXvErwJu+nFZGjPQdu3Fnnyk///BGpeDRs3vZBJefrOMPOdXKwTckCf6Lbh+BvqwcQzGLFWnzSlq2SzZL2boOu+hcGkHLnCDvfMEdKK7ckZOdBBkPPhiKJ5HT95u8X6SBXG36xvBHUxpD3r5DguLZzGTlDQVHz9tMXDxdEROKpyN3OtJYW417hAZZiSySxqMSo8c8ZlfdGVw9bB5JamErU/473YMhHrcFu9ONTpilhdj9cIrW/981YpjdMduA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYXb61KHQL6ZPApaXhmiIARpkkFFGwMPAAIk1+tx9Ko=;
 b=ew4oDu8M6lbDKPviIPXhWRwALKTjkMnozrCPekv+pKyFKRSeYe2sIxsuZDOXIHNcYGBj9IxP2ZrXrO4fro3fzlL1KebTzY1hHxmwo0phgP38fv/+Jm/1q51MAS//n4chIPpFFC2gFJR8uOHG3kxf5r9mpvtlvYZrjP4NSnGF10RUM3ba3Z50M2c/B7udJvndwhAwtMkxBJLBxJYk4ASaob9CTO+7WZjg/Led0vH2SzWKCou/854z069Jt10ofWdgqcVZgasiUn0qZU/aVOIi/a7tdB0pbbWAMRt7cq57JxP1cV+Ftb/f2VN9pF2xNzvlOP/F3RE8o+KvjF1U0+125A==
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:113::14)
 by SYCP282MB0301.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:8c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Sat, 30 Jul
 2022 07:32:47 +0000
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::c50a:2b12:1fb:254c]) by MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::c50a:2b12:1fb:254c%3]) with mapi id 15.20.5482.014; Sat, 30 Jul 2022
 07:32:47 +0000
From:   =?gb2312?B?zLcg08DB1g==?= <yonglin.tan@outlook.com>
To:     Johan Hovold <johan@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBVU0I6IHNlcmlhbDogb3B0aW9uOiBhZGQgUXVlY3Rl?=
 =?gb2312?Q?l_EM060K_modem?=
Thread-Topic: [PATCH] USB: serial: option: add Quectel EM060K modem
Thread-Index: AQHYm2KhAS3C3XZt+EKChgLsF2Qvi62NO3AAgAlYx8A=
Date:   Sat, 30 Jul 2022 07:32:47 +0000
Message-ID: <MEYP282MB237488A1AB2C7A9B4DA7B880FD989@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
References: <MEYP282MB23740DC78FB0DE954C59D3DEFD8F9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
 <Yt0FnnVh47y8aMtn@hovoldconsulting.com>
In-Reply-To: <Yt0FnnVh47y8aMtn@hovoldconsulting.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [x5/DkSoM56HjMrkpe2FyeVra4L8C/uBB]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e73aad36-e73a-4830-dc7b-08da71fdb362
x-ms-traffictypediagnostic: SYCP282MB0301:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1bvI7kUcG4qDqI44i6AhN/3v+m+DR21u+NxUqSWbFI39Nk4bd0zzxFf/mQWtoybKU7jQvsQqDcApsU9/1uw5OoMy4aolJ78GfhTjCqYYn+u6uw/Yy1ZavDDKrNMrnLtlNh3mNWeh53dPREwVzel2NbJcP1sDEeM/JP40aj5SIUcHtWIoZhjaLn2amx9bEcshK+0UkfaYEDH8CZeDYiF/YvF3kraJmDjaD/oHIyenEGeOASh4M0FcNwa2lDj2DBRBoBkzL9KRYveWlYrtS7nN6j9ByCUR5fmgrIEwFeEfqEZiQMN4vrdBSnytsqeOEBkFeYcBQC71x6nu8ixyt5o241VXkHtKC6M4xQy8oF0cDCfTzsfFVqrxfuUsCDF4A1RGiw9Vadow4T3ceL+EJvWYHzpmB2mOxhGyQyTbvdpXBdNSknk6XaG8RN09HLkdTfTUGReTjhiIbu77moQ7sqmeWTTL5qPABSgx1J/ngrSJenXJ5Vc99diYcp4IgHeHxc2lAP98AZ/RZg5AKhrHawViOH/i0LJPQNq41JgxpZVjYO5DZlTcVGzzRQtVb8ypTahICBZBMIAZU1QgFBg3v5rq2mH8yWLCS4RTIlH4RkvWzsZwIfVbP5egW0G3OH22Z0P5
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Y3BGR21LazdFWkRET0hUS1czSFNnYmVndUhUamFQNnBNY25zMzZpbExBY3ls?=
 =?gb2312?B?VHFUZ3A0Vmx6ZStYZmVyNU1HaE9PREt5bEhBOW9yWU5kRi9wMUNDTjI0L1RR?=
 =?gb2312?B?SnpTbC9IS011RlQ4eEVTZSsxUmxlbEllU3k3ejd2L1IwR3J3S1hjV3dlcU55?=
 =?gb2312?B?YjhmeFJ3Uno4OVE1NU4xSFlrL1dWNkk2ZGxCWkl2dDc1MmFPUHFaaVd0MEJo?=
 =?gb2312?B?bVJsK1NOM0g5SXZQYkpkTGRraEJSVTJ1QTlDZWc5Ym9IRlkvWDlzbzZkRXpr?=
 =?gb2312?B?VE0xK2VNaGM0cU5aM3c5OE50MEVVMnFPaXd4U3BrZjV5NVV1bUV5dnRPSnU0?=
 =?gb2312?B?bVJEYnRFMy96M0lFb0VURzRES2YwWFd5Q3RXWHFpN2JOQ2VzUTRaQUhkN0Jm?=
 =?gb2312?B?aWRnSHBiSFNiWXpmVnhuQXRMZnRZVDZ6MmJjWEMwaTYxZ3RRWkQ5YW94Q1Nm?=
 =?gb2312?B?Y3ZmcEloZEhuL1cxSGczeXpmWUdEaExLV3dHdjVVanFVZ3MrZTAwY1dUeVlH?=
 =?gb2312?B?WDVrTUwvU2RhR0RHVXNnd1lydU5KRjdaUzg5SFVhNnRhRkNSWnN1WXRrOC9X?=
 =?gb2312?B?M1hPM00xRlg3Lzk0OGpnMjBjNXBhVDRUM2JHYW4waFYwcVNUbHhSamZ1bm5x?=
 =?gb2312?B?VjErbUJOL3lTZjlOaE1GVUdmLzFiRE8waWtQUFRTOW9iYUVJcXZqUnBlVDZk?=
 =?gb2312?B?cCtEMnhsZzQ0SXBVWGpCRHA4Zll6Tmt6bllyL0h5TVhnNS8zMnVRUVUvOU0w?=
 =?gb2312?B?OXR4UjYrVjlOdnl0cm9JeExwd0haTDRyMlVrTHdWZi8wRnNMeXNJQ1p3R080?=
 =?gb2312?B?VEpiUTFZOTVWZTI2c3UySHVlMmIyallhcTREVm1JU1hUUklDRE8veGthSHJR?=
 =?gb2312?B?NTN3a2d1WTZ1ZG40a3dFRVhlcVhSMTFMS3ZBOEhNMHhiZTZnaS8rSzAyRXdQ?=
 =?gb2312?B?K2ZOL1dVcnZrMXo2Y0l6UTZOZkp6MnFLSVZTbW1hQ3RBb0VVTllYQy9wcHF1?=
 =?gb2312?B?NS9jcHMxSVdHWnJqRVpWNWtDRUlPaHJRY1QxNUdMMDNqNHZSUFFQL09HS1Ix?=
 =?gb2312?B?bk9KSkY0WXhnQTY1UHE5UE56OC9VU2JBNEQvMkVZSGd4ZFBGdFNUSlhTbzBK?=
 =?gb2312?B?OElFbHRydWZ1ZDdaNkY2NXoxeFRnZC8zNllWdGJSMktUOHp1Q3hHRFcyMity?=
 =?gb2312?B?Q2NxL2k1dVUyU1RiUHpSb003MVZXZVJlRjJUeXVxTVFUTTQzRkxKeUE1dU1w?=
 =?gb2312?B?a1ZFVGRleVVRaWxESW5yeEk0eWVVZ0ppajBoWm5wd2xiZ2R6NUJWUE1jUHB6?=
 =?gb2312?B?cG5uTUdTN21hdGtZd0NWUklMK1hWS2pXVGhqWUYvcmZhNDB4RVNpMkZGSG52?=
 =?gb2312?B?V1UxUzFmNUtOd0dFekpnVVl1d3lvQTB2Rll5d3d2MDViNHVGVjFBdlJlNng5?=
 =?gb2312?B?ZXkrNU15TFdHVVFmbkR6L0hMbzAvK1dtbnpZa1VQZU9MbHRoME5YREdWQVZW?=
 =?gb2312?B?U0h1WEUxc21udkRWYmFjeEw5Mk1IYkcyRDlENllQTnZmN2pINStqaEVPb3Zo?=
 =?gb2312?B?OFNKN0lYLzFoZmRrVytsbGFEZVlOckJOSlpoOEhZV1p5YVZDeDRmTXZYYXp2?=
 =?gb2312?B?emtBNndYS0RMNVNrOFhscEpFZ1RhVEtFczZQbjBtKzlNVjdLbi9EdDdCSmhp?=
 =?gb2312?B?VmViS3M3a29jMkY5N3dyckNSeUx4bHRsTW95Y3BNYWdxUHM5Tm53S1V3PT0=?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e73aad36-e73a-4830-dc7b-08da71fdb362
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2022 07:32:47.6299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYCP282MB0301
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBKb2hhbiwNCg0KVGhlIGxhc3QgaW50ZXJmYWNlIGlzIHVzZWQgZm9yIFF1YWxjb21tIFdX
QU4gbW9kdWxlJ3MgUURTUyhRdWFsY29tbSBEZWJ1ZyBTdWItU3lzdGVtKSBwb3J0LiBVc2VycyB1
c2UgdGhlIFFEU1MgaW50ZXJmYWNlIHRvIGFjcXVpcmUgTW9kZW0gc3Vic3lzdGVtIGxvZy4gSXQg
aXMgdXNlZCB0byB3b3JrIHdpdGggRElBRyBwb3J0LiBUaGVyZWZvcmUsIHdlIGRvbid0IGhhdmUg
dG8gYmluZCB0aGlzIGludGVyZmFjZSB3aXRoIGFueSBkcml2ZXIuDQoNCg0KLS0tLS3Tyrz+1K28
/i0tLS0tDQq3orz+yMs6IEpvaGFuIEhvdm9sZCA8am9oYW5Aa2VybmVsLm9yZz4gDQq3osvNyrG8
5DogMjAyMsTqN9TCMjTI1SAxNjo0MQ0KytW8/sjLOiBZb25nbGluIFRhbiA8eW9uZ2xpbi50YW5A
b3V0bG9vay5jb20+DQqzrcvNOiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgbGludXgtdXNi
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K1vfM4jogUmU6
IFtQQVRDSF0gVVNCOiBzZXJpYWw6IG9wdGlvbjogYWRkIFF1ZWN0ZWwgRU0wNjBLIG1vZGVtDQoN
Ck9uIFR1ZSwgSnVsIDE5LCAyMDIyIGF0IDA3OjI4OjAwUE0gKzA4MDAsIFlvbmdsaW4gVGFuIHdy
b3RlOg0KPiBBZGQgdXNiIHByb2R1Y3QgaWQgZW50cnkgZm9yIHRoZSBRdWVjdGVsIEVNMDYwSyBt
b2R1bGUuDQo+IA0KPiAiTUJJTSBtb2RlIjogRElBRyArIE5NRUEgKyBBVCArIE1PREVNICsgTUJJ
TQ0KPiANCj4gVDogIEJ1cz0wMSBMZXY9MDEgUHJudD0wMSBQb3J0PTAwIENudD0wMSBEZXYjPSAg
OCBTcGQ9NDgwICBNeENoPSAwDQo+IEQ6ICBWZXI9IDIuMDAgQ2xzPTAwKD5pZmMgKSBTdWI9MDAg
UHJvdD0wMCBNeFBTPTY0ICNDZmdzPSAgMQ0KPiBQOiAgVmVuZG9yPTJjN2MgUHJvZElEPTAzMGIg
UmV2PSA1LjA0DQo+IFM6ICBNYW51ZmFjdHVyZXI9UXVlY3RlbA0KPiBTOiAgUHJvZHVjdD1FTTA2
MEstR0wNCj4gUzogIFNlcmlhbE51bWJlcj04OWZiNTdkYg0KPiBDOiogI0lmcz0gNyBDZmcjPSAx
IEF0cj1hMCBNeFB3cj01MDBtQQ0KPiBBOiAgRmlyc3RJZiM9IDggSWZDb3VudD0gMiBDbHM9MDIo
Y29tbS4pIFN1Yj0wZSBQcm90PTAwDQo+IEk6KiBJZiM9IDAgQWx0PSAwICNFUHM9IDIgQ2xzPWZm
KHZlbmQuKSBTdWI9ZmYgUHJvdD0zMCBEcml2ZXI9b3B0aW9uDQo+IEU6ICBBZD0wMShPKSBBdHI9
MDIoQnVsaykgTXhQUz0gNTEyIEl2bD0wbXMNCj4gRTogIEFkPTgxKEkpIEF0cj0wMihCdWxrKSBN
eFBTPSA1MTIgSXZsPTBtcw0KPiBJOiogSWYjPSAxIEFsdD0gMCAjRVBzPSAzIENscz1mZih2ZW5k
LikgU3ViPTAwIFByb3Q9NDAgRHJpdmVyPW9wdGlvbg0KPiBFOiAgQWQ9ODMoSSkgQXRyPTAzKElu
dC4pIE14UFM9ICAxMCBJdmw9MzJtcw0KPiBFOiAgQWQ9ODIoSSkgQXRyPTAyKEJ1bGspIE14UFM9
IDUxMiBJdmw9MG1zDQo+IEU6ICBBZD0wMihPKSBBdHI9MDIoQnVsaykgTXhQUz0gNTEyIEl2bD0w
bXMNCj4gSToqIElmIz0gMiBBbHQ9IDAgI0VQcz0gMyBDbHM9ZmYodmVuZC4pIFN1Yj1mZiBQcm90
PTQwIERyaXZlcj1vcHRpb24NCj4gRTogIEFkPTg1KEkpIEF0cj0wMyhJbnQuKSBNeFBTPSAgMTAg
SXZsPTMybXMNCj4gRTogIEFkPTg0KEkpIEF0cj0wMihCdWxrKSBNeFBTPSA1MTIgSXZsPTBtcw0K
PiBFOiAgQWQ9MDMoTykgQXRyPTAyKEJ1bGspIE14UFM9IDUxMiBJdmw9MG1zDQo+IEk6KiBJZiM9
IDMgQWx0PSAwICNFUHM9IDMgQ2xzPWZmKHZlbmQuKSBTdWI9ZmYgUHJvdD00MCBEcml2ZXI9b3B0
aW9uDQo+IEU6ICBBZD04NyhJKSBBdHI9MDMoSW50LikgTXhQUz0gIDEwIEl2bD0zMm1zDQo+IEU6
ICBBZD04NihJKSBBdHI9MDIoQnVsaykgTXhQUz0gNTEyIEl2bD0wbXMNCj4gRTogIEFkPTA0KE8p
IEF0cj0wMihCdWxrKSBNeFBTPSA1MTIgSXZsPTBtcw0KPiBJOiogSWYjPSA4IEFsdD0gMCAjRVBz
PSAxIENscz0wMihjb21tLikgU3ViPTBlIFByb3Q9MDAgRHJpdmVyPWNkY19tYmltDQo+IEU6ICBB
ZD04OChJKSBBdHI9MDMoSW50LikgTXhQUz0gIDY0IEl2bD0zMm1zDQo+IEk6ICBJZiM9IDkgQWx0
PSAwICNFUHM9IDAgQ2xzPTBhKGRhdGEgKSBTdWI9MDAgUHJvdD0wMiBEcml2ZXI9Y2RjX21iaW0N
Cj4gSToqIElmIz0gOSBBbHQ9IDEgI0VQcz0gMiBDbHM9MGEoZGF0YSApIFN1Yj0wMCBQcm90PTAy
IERyaXZlcj1jZGNfbWJpbQ0KPiBFOiAgQWQ9OGUoSSkgQXRyPTAyKEJ1bGspIE14UFM9IDUxMiBJ
dmw9MG1zDQo+IEU6ICBBZD0wZihPKSBBdHI9MDIoQnVsaykgTXhQUz0gNTEyIEl2bD0wbXMNCj4g
SToqIElmIz0xMiBBbHQ9IDAgI0VQcz0gMSBDbHM9ZmYodmVuZC4pIFN1Yj1mZiBQcm90PTcwIERy
aXZlcj0obm9uZSkNCj4gRTogIEFkPTg5KEkpIEF0cj0wMihCdWxrKSBNeFBTPSA1MTIgSXZsPTBt
cw0KDQpXaGF0J3MgdGhpcyBsYXN0IGludGVyZmFjZSB1c2VkIGZvcj8NCg0KSm9oYW4NCg==
