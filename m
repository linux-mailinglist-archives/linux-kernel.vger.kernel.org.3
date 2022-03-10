Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36BC4D4850
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 14:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242519AbiCJNp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 08:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241878AbiCJNp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 08:45:57 -0500
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-eopbgr40069.outbound.protection.outlook.com [40.107.4.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F82214EF59;
        Thu, 10 Mar 2022 05:44:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVp0Bid+uoTjmQ9K01IpqVTiKsyYk+Mm2nWU73oCRxyrQVT5y9BT9huQHK/F//lDLLVO0td7BRPCWytG1ccCZnHIVQ8Ey/8S8hNPcJU5FLg5baf0DqYjAiz6ZdATAZZhGuS9A431Otv9DRYkcWX0QfgQCoZOtkbOfJEDjAJXwZgRH9ut6djSnx0VGUaRw2cQucqenrJp+OHlf3jfU3M8qfZ1d+ZDhAi3xAqi4ugSAX1s1+Yh20tdIepvFkuJJXeTq4wny14Jpss9sU4BupfL1EER3lg3rSJKDnwktZ4CSIQAU0H/rCVJHCqwvDU03J5p/Iv+5ekNMd8rSqv9wNrYZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5rQCl849uWtqNffU8whWXmsnqfEhInvGyqDFZIO5x0=;
 b=GcN/CAN2tvCKTihZnhriyvDr5fh0+oH9c70R3AMppW2XbDbDFl2995H73NKXcm6z+OiW0DH/W9iZWY9QcflZWLg/3WTz1DKCYwQkh11mi5u3ZkzTofrtZJvhvdTMLt3oivjEEwUi4445Eal//jfOVZ9LQCG+yK2RV1OGy57AJVLnhI7kpV+9zj2vfCOupNaMzXaCRAXcJMixwVsdcyjx/jaoyyNtnXkHPotRNLdqTXXr1DaIpUKUsi7gfC13nkaxNhsMGea6XbcAdkSYgiP6uOm35X3FpxWRMUw47Ig8lJJHQUCD8nwIwx5vVpRYxR9nu0V4jiTh1qyXzlpzWoBnlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5rQCl849uWtqNffU8whWXmsnqfEhInvGyqDFZIO5x0=;
 b=Za1sIh9ZyhBetMSuMP5ZQL7kVgGz9WPV+ddRccpVH4XptVexW3UgOL3pw0yJu/J07VUxUiGsCtOo5pmgl6OujBXNVy3HDV3fIiUQHArDhvFjAAZp9/SF0SPWgOb7JYIfGjrgVrvXVGUP1ySkzkML8tfnmpkhHUIgAqV8wMZPuR0=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB8PR04MB7036.eurprd04.prod.outlook.com (2603:10a6:10:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 13:44:51 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 13:44:51 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        David Laight <David.Laight@ACULAB.COM>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: =?utf-8?B?5Zue5aSNOiBbRVhUXSBSRTogW1BBVENIXSBtZWRpYTogYW1waGlvbjogZml4?=
 =?utf-8?B?IHNvbWUgZXJyb3IgcmVsYXRlZCB3aXRoIHVuZGVmaW5lZCByZWZlcmVuY2Ug?=
 =?utf-8?B?dG8gX19kaXZkaTM=?=
Thread-Topic: [EXT] RE: [PATCH] media: amphion: fix some error related with
 undefined reference to __divdi3
Thread-Index: AQHYM3L1b6GUtwI3e0GOXsa95t9Coay3C94AgAFAbMCAADGjgIAAI9Ng
Date:   Thu, 10 Mar 2022 13:44:50 +0000
Message-ID: <AM6PR04MB634123A8D9F9F60567C979D4E70B9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220309050221.971-1-ming.qian@nxp.com>
 <ab877a4470324d20b558538b52f69391@AcuMS.aculab.com>
 <AM6PR04MB63417FD1C3EE77BBE1649B47E70B9@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <3021738c-06e4-6760-5a70-5b3dc57f1e96@arm.com>
In-Reply-To: <3021738c-06e4-6760-5a70-5b3dc57f1e96@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c7ff4b3-2a92-46ca-62f0-08da029c2687
x-ms-traffictypediagnostic: DB8PR04MB7036:EE_
x-microsoft-antispam-prvs: <DB8PR04MB703646D1C9DD5418DDDE66F4E70B9@DB8PR04MB7036.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QO0tAz+DZBiJN/je6IvPZVsXJs3whHHM19u9z+j6vnd+fFO6KbBOG6OrEkLWydXizLehcYlOMvUDuyualGJAia3I4PdSeV+PZyN4wV6z3F1mE8CSCRjaeWRCOXLBzOFIyVjn41JIgeLHMRtV3ooXloiibuZ2oxiD6C2HTuCysTG/blpGp9T2dQN8o+LO4QNbrQUsIrDjfjkq4hNAGz38QKzzjB9VxZa8sa88XVV62YP4G2CLif2FbKEMgwc+IQ31flXwEuymNkZ5VZDQB0izwTo9VhcqV3Xf3tVERFI2j5wLDSjpz3XfHA1R2OP5MGPuyfgv3EpzXgMny43llxOyIklbzqienVdbQ18wAPVDYaC8oTcc4FPZKuNl6UJmcvuCQ8T/mV8Gi9otS7ScB+8uI64MzAShAqCBQ56Mb+dvN2vmB62PJGKB8S1Q6ZnvzFeQ/MnfGMkat5rewhaKK4AMaouwsM6bJNVjx615wJrvV2YXrDub+smHe+OOSKRnyd6IM3yBHgle7HmWwaRaFtlEjPXjbDfTFi0Mi3MnxY7O25poQV3ImcekFAYMYUGJ8Wx+8deCW+c3ThwGdE/ppOhbUyyYE+EVrLB+bLlvW0DRTe1mm9+Tu6gD1oB6vVo0aZ+gfNbSKcI4iQMLszwaxqi+m2FPZTcjuO+mgHJaEuranEDcxjDfBPTfawEFh8Jp+b8QIAIQuDgyj3cgngBjEhdABg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(4326008)(33656002)(224303003)(5660300002)(7416002)(86362001)(66446008)(64756008)(66476007)(66556008)(76116006)(66946007)(52536014)(44832011)(8936002)(38070700005)(498600001)(110136005)(186003)(26005)(54906003)(38100700002)(7696005)(9686003)(122000001)(55016003)(71200400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0sxMG92WUVmNlJhMmYvaElKVlZQdVdONkN4ZDVjYUE4YjZuNGMwMVRETVg3?=
 =?utf-8?B?MFkzb0NZVXBjOWFtR0ZsczNycUZNdW5NaVB2bElrdWVQbitKZVI4ZVpmK3E5?=
 =?utf-8?B?eUhVdU41K2xnMDZTcGNpY3l2QTVhNEZ0Qy9ITThLeHp1dTQycWJzZ2FFQzNh?=
 =?utf-8?B?NmMzU083c1k1YkZITzhTdzhMalJoTmRWMVhuZlppUEJRVVRvSGt4dWZQQWFZ?=
 =?utf-8?B?RmFIZFNXczFLeW04Vk8vYzQrNXRJMzJjTTYxRit6eUpqaHNHUWltT3RteUl1?=
 =?utf-8?B?MTUyNUhDajYzcmFWYzZmbWZydXJXQVhoQUZ0WWRpY1NFVnMzOVlYeE84OTdT?=
 =?utf-8?B?cGx4bCs3a3phVCtsNHJMKytSUE9YY2JUcnViQmdRZm1YZU9hemk0bkw5OFZK?=
 =?utf-8?B?NWRYZXNjRzZFRzgzUHUwYS9Mc0tTRkZsSHM0bEZwMm5SekU5bkc4bEIrTjdB?=
 =?utf-8?B?SlhDUnVLVUs5QlBiaHY4MGIyNkJ3YTJyNjVJRkJKalVFNzBJTVdkcTRTWlBO?=
 =?utf-8?B?T2hpR2dDbk5qbVdlbHV2dFlxUXE0RUhyYWpyUG1tY1pFNFhiN3prcFdtelN3?=
 =?utf-8?B?ckRENmwrUlpldHNPcDU3OTBFcUFQVTNHYjZuV2VQSlhMZEkrQ3NnbnREdHB6?=
 =?utf-8?B?bkRzUkhwdmwyU2xDVEdScDRXdXYxU1hqK1pUV3lwWk1WUFFmNTRjYWltcis5?=
 =?utf-8?B?Z2RScEc5TWpDTTRJL3hJajRndTg4MG1PWFNaK2xRcXZTTTY1NXBmVnQxRC9k?=
 =?utf-8?B?VS9YTEdEczluSU9GRkYxZmxxU1hxK2d4aHB4Zkk1M3JjYkltZThlalVHTDk3?=
 =?utf-8?B?QkVTOE53QVRTNTV1a2U5TldBblRmQitmcEV0ZE9qMXUwVE01ZVdma1JmNGdG?=
 =?utf-8?B?OWk4eUNDeXh0T2N5dTFMREdsUW5CTXZsS0hFdktEZlBEaDcvUVFkV1NUc1g0?=
 =?utf-8?B?Q1dXUlNqWC9KUHpXdlVwQ2plbnE2c3NpampPb2o5OXliaCtWdVBLcjY5U0Nv?=
 =?utf-8?B?eEpmUnZvT2o5SG80M2NsVThOdnI2eHR1UWRIam01eTRpaW03YmErK082cGZv?=
 =?utf-8?B?TER5ODF4TTI0bTZoMGFKbGh2N3RRbWViQjNDVEpoeVlUM2xXYWRVUzRnbWNw?=
 =?utf-8?B?ODAwSXMzVU1IeUNpVDBSSFpua0htS1NJeGJOWGFzUXphdGlSMlV6Z1pWOG9W?=
 =?utf-8?B?ckhldzhCUDZEWXBlWGFUdTBmUU9HVnVEUEtEN2E0dktWa0dabGVObTZ2ZXdY?=
 =?utf-8?B?NUJ5Vy9tdlFRQ1RZVkpjc3gvTE9aWnRRRGI4NzI1eFNtNG1KN3JhWEE1UGJD?=
 =?utf-8?B?MWZPbENzeWZ1S0NncU9hNHBVTlZPRnVYaFk3MGs2cUVqK2MrSzllMElBYVZj?=
 =?utf-8?B?a3M3WVphNWNjMk9qSlBRUi9vTk1NeWw4MmJKK0tkZzUra0NnMTcyUWxlUFNT?=
 =?utf-8?B?a0tMUmMxV3ZBSjBVb2F0cTZGZ21hbHhUVm50MmZJMXpoOWx0ZXdpalQrb0U5?=
 =?utf-8?B?bGIzZHJvcjV0T05LMVdVVTVyUFg2K1pETlFtM1BaaHBCcGtiVTRKSDNkZ2pw?=
 =?utf-8?B?VkxuQWFzcFl0aDBCWjVIRzRjd25DR1FuRC9wSm9FVkZVZmc3OC9kQzlxeFo1?=
 =?utf-8?B?ZEVHZlJPQ0NOT3RVb3lvWDYreUpLYWRHbXFWNkdxTU83S0tqbEZzWUZYaVl2?=
 =?utf-8?B?RHUzSjNtMUF3WjNnWUtocnpINlhpRkF1a1hkZEt2RjJuOSt0K3oxRWxnTGRE?=
 =?utf-8?B?SEE5blplZjgrSmJpek53NXJBMlBZTTdLWXRXZ1dzckNqcVB5b1Z2U1RKdXhZ?=
 =?utf-8?B?ZkxHZUtibHpDaDRpZ0pLMGFDUFVQRHd6VCtJZCt3UWwxbURFL1ZrVHFWS1hR?=
 =?utf-8?B?MjVOenpkdVFpbHdCRTJMdGhJNmFtQU1zaldqSWpCL1FXTHlwU2h2cVpBN1dX?=
 =?utf-8?Q?kS3M8vRWALE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c7ff4b3-2a92-46ca-62f0-08da029c2687
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 13:44:51.0125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6DJv67cy14phA1FlOw9ozUR51Knmh17ftYvlOYExGqAY7GcQDXEqd4paPrXUkfuB+e45jgoqM3BVagAHzkS1+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7036
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+Pg0KPiA+PiBGcm9tOiBNaW5nIFFpYW4NCj4gPj4+IFNlbnQ6IDA5IE1hcmNoIDIwMjIgMDU6
MDINCj4gPj4gLi4uDQo+ID4+PiAzLiB1c2UgJ3ZhbCA+PiAxJyBpbnN0ZWFkIG9mICcgdmFsIC8g
MicNCj4gPj4NCj4gPj4gVGhlIGNvbXBpbGVyIHNob3VsZCBkbyB0aGF0IGFueXdheS4NCj4gPj4N
Cj4gPj4gRXNwZWNpYWxseSBmb3IgdW5zaWduZWQgdmFsdWVzLg0KPiA+PiBBbmQgaXQgaGFzIHRo
ZSB3cm9uZyAoZGlmZmVyZW50KSByb3VuZGluZyBmb3IgbmVnYXRpdmUgdmFsdWVzLg0KPiA+Pg0K
PiA+PiAgICAgICAgICBEYXZpZA0KPiA+Pg0KPiA+DQo+ID4gSGkgRGF2aWQsDQo+ID4gICAgICBZ
ZXMsIHlvdSBhcmUgcmlnaHQsIGlmIHRoZSB2YWx1ZSBpcyBuZWdhdGl2ZSwgdGhlIGJlaGF2aW9y
IGlzIHdyb25nLg0KPiA+ICAgICAgQnV0IGhlcmUsIHRoZSB2YWx1ZSB0eXBlIGlzIHUzMiwgc28g
SSB0aGluayBpdCdzIE9LLg0KPiANCj4gV2VsbCwgaXQgZGVwZW5kcyBvbiB0aGUgc2VtYW50aWMg
aW50ZW50LCByZWFsbHkuIElmIHlvdSdyZSBwYWNraW5nIGEgYml0ZmllbGQNCj4gd2hpY2ggZW5j
b2RlcyBiaXRzIDMxOjEgb2Ygc29tZSB2YWx1ZSB0aGVuIGEgc2hpZnQgaXMgdGhlIG1vc3QgYXBw
cm9wcmlhdGUNCj4gb3BlcmF0aW9uLiBIb3dldmVyIGlmIHlvdSdyZSBsaXRlcmFsbHkgY2FsY3Vs
YXRpbmcgaGFsZiBvZiBhIHZhbHVlIGZvciwgc2F5LCBhIDUwJQ0KPiB0aHJlc2hvbGQgbGV2ZWws
IG9yIHRoZSBudW1iZXIgb2YgMTYtYml0IHdvcmRzIHJlcHJlc2VudGVkIGJ5IGEgYnl0ZSBsZW5n
dGgsDQo+IHRoZW4gc2VtYW50aWNhbGx5IGl0J3MgYSBkaXZpc2lvbiwgc28gaXQgc2hvdWxkIHVz
ZSB0aGUgZGl2aWRlIG9wZXJhdG9yIHJhdGhlcg0KPiB0aGFuIG9iZnVzY2F0aW5nIGl0IGJlaGlu
ZCBhIHNoaWZ0LiBDb25zdGFudCBkaXZpc2lvbiBpcyBzb21ldGhpbmcgdGhhdCBldmVuDQo+IHRo
ZSBtb3N0IGJhc2ljIG9wdGltaXNpbmcgY29tcGlsZXIgc2hvdWxkIGhhbmRsZSB3aXRoIGVhc2Uu
DQo+DQpIaSBSb2JpbiwNCg0KICAgIFRoYW5rcyBmb3IgdGhlIGRldGFpbGVkIGV4cGxhbmF0aW9u
LCBhbmQgSSBhZ3JlZSB3aXRoIHlvdSwgSSB3aWxsIHVzZSAiIC8gMiIgaW4gdGhlIHYyIHBhdGNo
IGFzIGl0J3MgaW5kZWVkIGNhbGN1bGF0aW5nIGhhbGYgb2YgYSB2YWx1ZS4NCiANCg0KPiBPbmUg
bW9yZSB0aGluZyB0aGF0J3Mgbm90IHRoZSBmYXVsdCBvZiB0aGlzIHBhdGNoLCBidXQgc3Rvb2Qg
b3V0IGluIHRoZQ0KPiBjb250ZXh0Og0KPiANCj4gQEAgLTE1NjYsNyArMTU2OCw3IEBAIHN0YXRp
YyBib29sIHZwdV9tYWxvbmVfY2hlY2tfcmVhZHkoc3RydWN0DQo+IHZwdV9zaGFyZWRfYWRkciAq
c2hhcmVkLCB1MzIgaW5zdGFuY2UpDQo+ICAgICAgICAgdTMyIHdwdHIgPSBkZXNjLT53cHRyOw0K
PiAgICAgICAgIHUzMiB1c2VkID0gKHdwdHIgKyBzaXplIC0gcnB0cikgJSBzaXplOw0KPiANCj4g
LSAgICAgICBpZiAoIXNpemUgfHwgdXNlZCA8IHNpemUgLyAyKQ0KPiArICAgICAgIGlmICghc2l6
ZSB8fCB1c2VkIDwgKHNpemUgPj4gMSkpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsN
Cj4gDQo+ICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiANCj4gVGhhdCdzIG5vdCBzYWZlOiBpZiAi
c2l6ZSIgaXMgMCB0aGVuIHRoZSB1bmRlZmluZWQgYmVoYXZpb3VyIGhhcyBhbHJlYWR5DQo+IGhh
cHBlbmVkIGJlZm9yZSB0aGUgIiFzaXplIiBjaGVjayBpcyByZWFjaGVkLiBJZiAic2l6ZSIgcmVh
bGx5IGNhbiBiZSAwLCB0aGVuIGl0DQo+IG5lZWRzIHRvIGJlIGNoZWNrZWQgKmJlZm9yZSogaXQg
aXMgdXNlZCBhcyBhIGRpdmlzb3IgdG8gY2FsY3VsYXRlICJ1c2VkIi4NCj4gDQo+IFJvYmluLg0K
DQpZZXMsIGl0J3MgcHJvYmxlbSwgYW5kIERhbiBoYXMgYWxzbyBwb2ludGVkIGl0LCBJICdsbCBm
aXggaXQgaW4gYW5vdGhlciBwYXRjaC4NCg0KTWluZw0K
