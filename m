Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268EB4B2E4D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348334AbiBKUQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:16:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiBKUQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:16:31 -0500
Received: from CAN01-QB1-obe.outbound.protection.outlook.com (mail-eopbgr660052.outbound.protection.outlook.com [40.107.66.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635D5CF5;
        Fri, 11 Feb 2022 12:16:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3V+j3Y+br/0YtprB6eG2nN9QvVHlVQr8+aLrTfnzuSyCsfhL2uvwP7/FiOC4TxZJfeRAx4QdfwWCR9TYbVMEt5/6bEprZfRb2fxS866cvMFbptDYP1RMutiNrTFhVBAzuz/Xu9omtaaDjZ+nHrgQXGCw8o+PyFYvAQIC7HJHVLU5C3tnunD+bt72dRQWJz3gpP89w/d8WP7HLTfENuXmvG74VtLNRWdkkBD5t7x0IJs2pow+yurOsWl2EbXe0twnsmqZhgVPsNoMsMX5vVKrNFhdqrWyzl3QO7E/IP7lFisCToKovUNR6fMh/IPVUzG1c8zICn6yoTluGTkkOk7JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHS6+J2cC8wIvumlR4a+68LLx6WJb2A1Hc2WgbvDpxk=;
 b=bpzgBhjclQAvdOwKuFJkKRREr++Zyf4buHi0D9B8uzpOHLsWKHxFh6RRP5CdBLcehpx5qQDBwvbzzg/uftV2eZDQniIzgk6yxKYs6LAAi9ZdHzsh8Z8/r2NyRNBuxVKt7ynDr7Yv+20ttk5utWxnMZThmO0AAW4SkYD+KctPBUajjsoIdB/S5EdC5Cr11inOThkkqig/heWDr3wha9QFg8iRi/B8hrLB3bCpArr1CNGQdL6qVHT24YAMZqh7iNGmSilbHM7LtSpDwNxcKfOY6yfycWtP4n75JlqeMGWVRC9UnnW+9m6qZ0CRoxOoZrZlmyjdM8dEYFw+NElPcA/CJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dimonoff.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHS6+J2cC8wIvumlR4a+68LLx6WJb2A1Hc2WgbvDpxk=;
 b=u/GdVvN2OOJgjkMJ5/pBjHz8tMZx4k/JgP3f6ZZ8bIBxy6HHr8kSE7GV1OtYj9xLi+eiJtJ71GGjWzLBaYEDzJXDouReVzfCLavKVSsW42ESKiAMuaVGEx3TcZbyYTjiAfastNuSMIsYlSfq/LkD7Kuly5XZiDVrP7A9AwSUujk=
Received: from YQXPR01MB5200.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2e::20)
 by YT2PR01MB8869.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 11 Feb
 2022 20:16:27 +0000
Received: from YQXPR01MB5200.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c1af:9bb:87bc:c1d5]) by YQXPR01MB5200.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c1af:9bb:87bc:c1d5%9]) with mapi id 15.20.4975.015; Fri, 11 Feb 2022
 20:16:27 +0000
From:   Hugo Villeneuve <hvilleneuve@dimonoff.com>
To:     "hugo@hugovil.com" <hugo@hugovil.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/10] dt-bindings: rtc: pcf2127: add PCF2131 INT_A and
 INT_B support
Thread-Topic: [PATCH 10/10] dt-bindings: rtc: pcf2127: add PCF2131 INT_A and
 INT_B support
Thread-Index: AQHYEiY4fSVueFYTTEiOdXEQPuj2qKyKo6wAgALOowCAAAWUAIAABlMAgAFl/IA=
Date:   Fri, 11 Feb 2022 20:16:27 +0000
Message-ID: <7be3f9541eaed7e17e334267e49665f442b1b458.camel@dimonoff.com>
References: <20220125200009.900660-1-hugo@hugovil.com>
         <20220125200009.900660-11-hugo@hugovil.com>
         <YgMy/CYL8lmf6Y+J@robh.at.kernel.org>
         <20220210171234.4e317c8a5d5f91f358382b07@hugovil.com>
         <YgWSgGTKR63g+S9e@piout.net>
         <20220210175510.c99eb77c6367d4df5d8bb9a2@hugovil.com>
In-Reply-To: <20220210175510.c99eb77c6367d4df5d8bb9a2@hugovil.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dimonoff.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 105682ac-b7fc-455c-c542-08d9ed9b627b
x-ms-traffictypediagnostic: YT2PR01MB8869:EE_
x-microsoft-antispam-prvs: <YT2PR01MB88697E2B1B0179E6072375CBC4309@YT2PR01MB8869.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lHxMLjilIxyv7ue61OrCS7dU/luqVu+peZpF4K2+noR6UhjQ9OVOF9AmYR79woBKkc3OiQs6aN5mxv43F6KjQdkGMZ3hEP8GHaFUkOj6gk88SMkxMrwBifTgUL45pf5RQj0I//jT8kAO/YT7nbL32cfHsgBM9K0bryEA7Ofg/xoxdyYR6nXfEuz+07b3JQdjpHzHJOST5ZZsZDb/4VUoYpx02p5UvHH4q2gfiQ9ek69cRxTv2OaUSrFLgbtVP84ynBL8hgCaevLtcaP+6+Idoe7QE+zJQwPWYwRiXZJTdGfVStIFch6I3xHvl31u14n6wbh0CbJWhZmnD3MY4lu96lvDPy/JtgmbL0buSAXVsWCH7syhGCHb8FxMz3bdc/0tMJfb3LTLWV9w2WFqZcihUztiGgqbTHCPf/917NbW4i0NcXFKkyHCKrKw+V7igO6fmqnpSeUUzanbS5yxRFMrn92OBw8YnMySK4ODfDVv7kNWs5DDJvJ9W9l9ermURGyZaLtrvkG8jfXUFqCi3J0d693UnAyVAsV5AX+cHSHe4CYHtmAVgH5goiAsg55CxK8uPl3ja1pu8ZRd+aYsnitw7Up9NzCE7Fuk3Mfmd8T4MXOkqcsmoSpJLD88A1p1Mq1gRLkFgaX0552c5nwfuNjddvIV4WnwqBfnXRdZbCdjP7sOYTZngc5kT8CK7tZgmiTR/Djajqae1krHiklb3SefwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB5200.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(346002)(376002)(39830400003)(366004)(396003)(186003)(2616005)(5660300002)(26005)(2906002)(36756003)(508600001)(38070700005)(6486002)(122000001)(38100700002)(6512007)(110136005)(76116006)(4326008)(86362001)(64756008)(316002)(66946007)(71200400001)(6506007)(66446008)(8676002)(66476007)(8936002)(54906003)(66556008)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHRZcU9ETkd4VGFHci91UGpZbXJmd2xpN1QyK2xMdGFEQm4zUlM2Y2hTWmlF?=
 =?utf-8?B?cTFCOEZGUUVQdGp0cHFSSVRYWHRkSmJBNTZBNDBqZVZEY0g5dTFQOEU4QU5Y?=
 =?utf-8?B?QVVmejhNSS9YRzZhelF4RzRTSkt3N1hnZ0tBL1plOEh3MDZ4d0IyclRwcjJW?=
 =?utf-8?B?ekFqS09TcHFqNkg5YjUxSVFHT3VlbE85dEdldHMrM0JNd2F2V1FtNmtkcE5Q?=
 =?utf-8?B?Z0JrdDNNcXF1YTJ0aVBJQVZRajNvS1pLWDFBYmY3cjNoUnY1d0E4MXFlWG5H?=
 =?utf-8?B?RHl0VjlCaDlzZzJXMkFvOUNjUWMyWitYYkNHOGZ0Mzc3cHp0QUcyY0hrNE1J?=
 =?utf-8?B?dXFOaFdGelJMcXVrS2cwM0pVdlVUUFliYmhRcWZvanpaMHRERUd5Smsrc3F4?=
 =?utf-8?B?YjlmNnFQdUlPMEVONmZNK1B4anlTamtGSEVtQncxdk5Ybkg2V0ovQSs5c3Nj?=
 =?utf-8?B?eTZmd3FtY0FvWTgwQ1dTM2NGUlBIQkdrc0FRRFBFNEdlUElwTElvNkVjeWZE?=
 =?utf-8?B?cWJVSGpNdlU2bzV0SDJuUzlKd3BxWE1TY0Iva2pYaGN6UmIybDZ6OTZYbTM2?=
 =?utf-8?B?dFdiVlpJQzl2SE85Y1BwOUtNLzFRL2dyc2E5MDUvMEpQNi8wSEtZWmw0Z1o3?=
 =?utf-8?B?dkFRYnBpUGlaWVJ0RFdZUEFLZlJrSnJmTXVaUFNuUU9PMW0zQnZEdW03emxq?=
 =?utf-8?B?Sjh6eG55WTF0bWFvUkp1RGxPNm1wbldpLytlL09nbGhWbkRvL1VSSUV0ZDRH?=
 =?utf-8?B?ZUFGdXo1bWphU2x1RTM3aVBmNXk2TUxPdUVmNmNJaVRYTVUydHN3NkkycTBY?=
 =?utf-8?B?UkYvTjJkSDhTVmM4NThnd2dwNUxvN2dhaGZaQ0pRcU44bHA1YVpPMGp3NTFP?=
 =?utf-8?B?V1FaQ2hTakJ1UGNQOVVTMThGbGtnckdlOE1NdlN4aUV4dTNSNVNpd3ZITG9K?=
 =?utf-8?B?TXRuTEdWTkgvd0tYRFZOWE94aUVjNkczUFRSdkt4Q3M4S0NGN2cyVHU2ZDR4?=
 =?utf-8?B?RHppbkF1QVJTYWRUQUZOU2QxbzFTMzJqVDZKZE5EK21JRXZGc0wrM055N1J1?=
 =?utf-8?B?dWV1ai9MeGJZMkNZUVBEZGNYTlpLa3Vnakl3U1RiTytOeWFMY2w1TDRHdldj?=
 =?utf-8?B?L1MyWk1WZnpCUGd3R0ZvU2NLWG9TQ2lUb0NzNUlTYUVTQTRnMElISXNwUWJO?=
 =?utf-8?B?Q21rdGdGU0I3czUwTURIRm5KNkpLRlVEaW1DbnNrS25SVFB5NTUrS0JtNUM4?=
 =?utf-8?B?SGFTWVBFWVEyZU5iL0pHeXhOdnZXaUxJV08xZFlUUXRibUpTNnVsVmQrQXhM?=
 =?utf-8?B?Skx5VWRRR1pKUGFxdk9GUDBzR0NsS1dvazJNVk0wdHhQMU5YV0JYdGZPN0JN?=
 =?utf-8?B?Wkw3RUlzdVdya200RERwemZrd1dsNklhd2NBSlpnUDJVaDlOR3dzcVMvMU9r?=
 =?utf-8?B?K3hld2w5MHB1UTBFZGg2WU9yRk5uaWpRK2F6THFmNVJJdDBsdEl4UVBWQnov?=
 =?utf-8?B?ZUpKWjh5K2c0TzJSY252N1JLMzNCbmRLcE5pUURoQmJJU2x0a29xVTJBQlBO?=
 =?utf-8?B?dlNHNXBPSzFuTDVNS2JScW9MSElXUllyWS9jMHl4NTNRRWhhRXBSNi9UYVJn?=
 =?utf-8?B?NDNsSmszVFlrMXR0dTdTbFVHNWxMTXk0aHIzSzgyaWEvLzh0S2hDN05XNXor?=
 =?utf-8?B?WHM2bGlZdGlXbDFsYWFFbXk3VHN5K3pZVnpyZkNyUzBjSWlWSWEwdVVYZk5F?=
 =?utf-8?B?ZzZSMks0OGlqcU11ZEMrOGNvVUdzM3dZRUlIU2xMb3RZdDdXZEVPdFFPT0sr?=
 =?utf-8?B?dzhRc09LdDE1bEVDcWRpQkdHTHp0UUJhMkNhT1hYUHFRQWpBNGhFRjQySjJy?=
 =?utf-8?B?ckx1Q1hReHlDSWliMkdVOXJWeFhKQVlmcGlid1ZJQ0htNWl5WUtFb3JEWGp0?=
 =?utf-8?B?U01Cd3lnaEs3aXF1VzRlWjlUbVlZRDNIaXNFbm5PVEd5aEJZUXBGektERU1C?=
 =?utf-8?B?UUVrRUhRdzQ5S1NBaW9MUDNCR3laaVliWjNwUzRXMEFkdGVKc25BcmpTQXp6?=
 =?utf-8?B?MFBqSTY4c3Y5eHREd3BLamhkL3ZiOVZyUTVYaW1zU2Q5c3NDUGcwL3dURmRt?=
 =?utf-8?B?alNmYkllTlhUbTJtSUVRM3htRkVBSFd1QkZ5MkVmV05GcmxvR0VXSnVNTm9F?=
 =?utf-8?B?Z05qTWlCcU5zaDBOQXlnVVFET1c3a3BzNU9uK3FxamhLTC92SEQyOVljY3VW?=
 =?utf-8?Q?JphMogj/a4tudiE5MKM4b0A85U9uq46IA+/ymCrVBA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DADB399E8789240AA0D94F32FEFA70A@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dimonoff.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB5200.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 105682ac-b7fc-455c-c542-08d9ed9b627b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 20:16:27.6690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c4063547-e5e6-4866-a386-58c3965da102
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z9LenMGfDrEzK2jP+0Xtic4afw9GQ/uea762HmNLu6gWIv3yiR/V0q2PZDQFRGpoGUiDqDcTncYVnocGSONtUX7ymz6Qm7LjIJA8zuoR1vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8869
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTAyLTEwIGF0IDE3OjU1IC0wNTAwLCBIdWdvIFZpbGxlbmV1dmUgd3JvdGU6
DQo+IE9uIFRodSwgMTAgRmViIDIwMjIgMjM6MzI6MzIgKzAxMDANCj4gQWxleGFuZHJlIEJlbGxv
bmkgPGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4uY29tPiB3cm90ZToNCj4gDQo+ID4gT24gMTAv
MDIvMjAyMiAxNzoxMjozNC0wNTAwLCBIdWdvIFZpbGxlbmV1dmUgd3JvdGU6DQo+ID4gPiBPbiBU
dWUsIDggRmViIDIwMjIgMjE6MjA6MjggLTA2MDANCj4gPiA+IFJvYiBIZXJyaW5nIDxyb2JoQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiA+IE9uIFR1ZSwgSmFuIDI1LCAyMDIyIGF0
IDAzOjAwOjA5UE0gLTA1MDAsIEh1Z28gVmlsbGVuZXV2ZQ0KPiA+ID4gPiB3cm90ZToNCj4gPiA+
ID4gPiBGcm9tOiBIdWdvIFZpbGxlbmV1dmUgPGh2aWxsZW5ldXZlQGRpbW9ub2ZmLmNvbT4NCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBUaGUgUENGMjEzMSBoYXMgdHdvIG91dHB1dCBpbnRlcnJ1cHQg
cGlucywgbmFtZWQgSU5UX0EgYW5kDQo+ID4gPiA+ID4gSU5UX0IuDQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gQWRkIHByb3BlcnRpZXMgdG8gaWRlbnRpZnkgb250byB3aGljaCBwaW4gd2Ugd2FudCB0
aGUgYWxhcm0NCj4gPiA+ID4gPiBpbnRlcnJ1cHQNCj4gPiA+ID4gPiB0byBiZSByb3V0ZWQuIEl0
IGNhbiBiZSBlaXRoZXIgb25lLCBvciBib3RoLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoZXNl
IHByb3BlcnRpZXMgYXJlIGF1dG9tYXRpY2FsbHkgc2V0IHRvIGZhbHNlIGZvciB2YXJpYW50cw0K
PiA+ID4gPiA+IG90aGVyDQo+ID4gPiA+ID4gdGhhbiBQQ0YyMTMxIChleDogUENGMjEyNykuDQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSHVnbyBWaWxsZW5ldXZlIDxodmls
bGVuZXV2ZUBkaW1vbm9mZi5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gwqAuLi4vZGV2
aWNldHJlZS9iaW5kaW5ncy9ydGMvbnhwLHBjZjIxMjcueWFtbMKgIHwgMjMNCj4gPiA+ID4gPiAr
KysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0
aW9ucygrKQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGRpZmYgLS1naXQNCj4gPiA+ID4gPiBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ydGMvbnhwLHBjZjIxMjcueWFtbA0KPiA+
ID4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3J0Yy9ueHAscGNmMjEy
Ny55YW1sDQo+ID4gPiA+ID4gaW5kZXggNTdlYjBhNThhZmEzLi44MzY1NmRkMmY5N2YgMTAwNjQ0
DQo+ID4gPiA+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3J0Yy9u
eHAscGNmMjEyNy55YW1sDQo+ID4gPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3J0Yy9ueHAscGNmMjEyNy55YW1sDQo+ID4gPiA+ID4gQEAgLTI0LDYgKzI0LDE2
IEBAIHByb3BlcnRpZXM6DQo+ID4gPiA+ID4gwqDCoCBpbnRlcnJ1cHRzOg0KPiA+ID4gPiA+IMKg
wqDCoMKgIG1heEl0ZW1zOiAxDQo+ID4gPiA+ID4gwqANCj4gPiA+ID4gPiArwqAgYWxhcm0tb3V0
cHV0LWE6DQo+ID4gPiA+IA0KPiA+ID4gPiBueHAsYWxhcm0tb3V0cHV0LWENCj4gPiA+IA0KPiA+
ID4gT2ssIHRoaXMgd2lsbCBiZSBmaXhlZCBmb3IgVjIuDQo+ID4gPiANCj4gPiANCj4gPiBBY3R1
YWxseSwgdGhpcyBwcm9wZXJ0eSBoYXMgdG8gYmUgbWFkZSBtb3JlIGdlbmVyaWMgYW5kIHRob3Vn
aHQNCj4gPiBvdXQuDQo+ID4gVGhlcmUgYXJlIG11bHRpcGxlIFJUQ3MgdGhhdCBoYXZlIG11bHRp
cGxlIGludGVycnVwdCBwaW5zIHdoZXJlIG9uZQ0KPiA+IG9mDQo+ID4gdGhlIHBpbiBjYW4gYmUg
dXNlZCBmb3IgZGlmZmVyZW50IGludGVycnVwdCBvciBjbG9jayBvdXRwdXQuDQoNCkhpLA0KdGhl
IG9ubHkgZXhhbXBsZSBJIGNvdWxkIGZpbmQgb2Ygc3VjaCBhIGRldmljZSBpcyBpbiBydGMtcGNm
ODUzNjMuYy4NClRoaXMgZGV2aWNlIGFsc28gaGFzIHR3byBpbnRlcnJ1cHQgcGlucywgSU5UIEEv
QiwgbGlrZSB0aGUgUENGMjEzMS4NCkhvd2V2ZXIsIGluIHRoZSBwY2Y4NTM2MyBkcml2ZXIsIHBp
biBJTlQgQiBpcyBzaW1wbHkgaWdub3JlZCwgYW5kIGFsbA0KaW50ZXJydXB0cyBhcmUgY29uZmln
dXJlZCB0byBnbyBvbiBJTlQgQS4NCg0KRm9yIHRoZSBtb21lbnQsIEkgd2lsbCBzaW1wbHkgbW9k
aWZ5IG15IFBDRjIxMzEgcGF0Y2hlcyBzZXJpZSB0byBtaW1pYw0KdGhlIHNhbWUgYmVoYXZpb3Ig
aW4gVjIuIFRoaXMgc2ltcGxpZmllcyB0aGluZ3MgYSBsb3QsIGFuZCBzdXBwb3J0IGZvcg0KSU5U
IEIgcGluIGNvdWxkIGJlIGFkZGVkIGF0IGEgbGF0ZXIgc3RhZ2UgKGFuZCBhbHNvIHRvIHBjZjg1
MzYzKSBpZg0KYW55b25lIG5lZWRzIGl0IChJIGRvbid0KS4NCg0KSHVnby4NCg0KPiA+IFdpdGgg
eW91ciBiaW5kaW5nLCB0aGVyZSBpcyBubyB3YXkgdG8gc2VwYXJhdGUgd2hpY2ggaW50ZXJydXB0
IGlzDQo+ID4gZ29pbmcNCj4gPiB0byB3aGljaCBwaW4gYW5kIHNvIHRoZXJlIGlzIG5vIHdheSB0
byBnZXQgdGhlIGFsYXJtIGFuZCBCTEYgb3IgdGhlDQo+ID4gd2F0Y2hkb2cgb24gZGlmZmVyZW50
IHBpbnMgYW5kIHdlIGNlcnRhaW5seSBkb24ndCB3YW50IHRvIGhhdmUgYQ0KPiA+IHByb3BlcnR5
IHBlciBpbnRlcnJ1cHQgdHlwZS4NCj4gDQo+IEhpLA0KPiBjYW4geW91IHBsZWFzZSBzdWdnZXN0
IGhvdyB5b3Ugd291bGQgcHJlZmVyIGl0IHRvIGJlIGRvbmU/DQo+IA0KPiA+IEFsc28sIHRoZSBk
b2N1bWVudGF0aW9uIGlzIG1pc3NpbmcgdGhlIGZhY3QgdGhhdCB0aGUgZHJpdmVyIG1ha2VzDQo+
ID4gaGF2aW5nDQo+ID4gb25lIG9mIHRoZSBwcm9wZXJ0eSBtYW5kYXRvcnkuDQo+IA0KPiBJIHdp
bGwgYWRkIGl0Lg0KPiANCj4gVGhhbmsgeW91LCBIdWdvLg0KPiANCg0K
