Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA595660D8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 04:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiGECAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 22:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGECAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 22:00:15 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2299260F1;
        Mon,  4 Jul 2022 19:00:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSbSn06JGUXlUI/70FO8ywxAZdKv4ElyP77g0LW+O1p8ARzaFlp/1W+dSuHlX8FDx8HREJII3h+CG4ESRKsO/f55S11J3IKEXj22f7W3NMst+AbjfEk1Qyl+28CzVCUCAJyq9oWiAM4k67VkSEBAH+x11rAFyQvggbg8rjusihceLtFNt60Y/pD0m31kXFf8LuLq+/za9TjbArPR8397wnLpHUSK0k8QuZ6yKi8DXGHHLg6eSDpk7mk7MMh/yTcNcLUFumPXehVyg4xDXR9a+xN3YwuFJpTOHG4LOtteN5ghd+cOj7bQ2jMrGCf66GlqUC6IUhF/hoOcusB1Ua5HxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfSNWDoDwGASRR11zj5ERGb4FvZK45M8HZAyJJXcsXg=;
 b=JWD2Hh+k+YBHBgGbzgSNv5gxvASCiQdw8IBMi1IWxbC8OCiOqksXmg+aIuWa7s9tmVYJn7FJP8ATXDlEcU4Ne6Fkw8pX71FXqLG5UnoHJ0eumU0/kCu/WdFPoawrDmXx8jJ1GOeZM8Pfpogjmkci/xfuMHzPPkQ615jDa41Sf/k/Iclnh9fBE2UWuvhQn7bD5nysE4Wl7vLWPmjrtzlULFbI6C3MNR3A7+fdHHaaSNei88FDAZCZKIlp5113zKUJKOYl8uANvUNHpQD5XBqCL7wYA3ZM6Uipk8o2o5K6V+Yy4DNQJ6GP4jHDVITqd4taikNEnipzp4MajkjA7ABesg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfSNWDoDwGASRR11zj5ERGb4FvZK45M8HZAyJJXcsXg=;
 b=RtwHgMY5p4qfpEi0gRHGmJkhsUwvv3qWoLYfrqLfpOsVK33/VllzUOBwXU11QhhYppXqnnX0QgrFbmUtpAdtkTbljXM9P1zaF3CY6NFtvxPDAGAucOltCPrfgt3LfcN8aVlqjH+k3C+KDn1HY5ZQ/V7MwO3PUuWle+qQ5i6DKgw=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR0402MB3437.eurprd04.prod.outlook.com (2603:10a6:803:7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Tue, 5 Jul
 2022 02:00:10 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b%5]) with mapi id 15.20.5395.020; Tue, 5 Jul 2022
 02:00:10 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH] media: amphion: only insert the first sequence
 startcode for vc1l format
Thread-Topic: [EXT] Re: [PATCH] media: amphion: only insert the first sequence
 startcode for vc1l format
Thread-Index: AQHYiq7J1t29u6ewlE+hUMTTkjT24K1uamyAgACj+3A=
Date:   Tue, 5 Jul 2022 02:00:10 +0000
Message-ID: <AM6PR04MB6341F4EB028CAE9B61C85157E7819@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220628052017.26979-1-ming.qian@nxp.com>
 <6e54af5243d324c5df1c9ec18d4b091fbd52150f.camel@ndufresne.ca>
In-Reply-To: <6e54af5243d324c5df1c9ec18d4b091fbd52150f.camel@ndufresne.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8dca70cb-d5de-465a-ae33-08da5e2a17bb
x-ms-traffictypediagnostic: VI1PR0402MB3437:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sKYjG0IPgcTn6+wTPJlRNAJB/LnHGA4m58yvMhrqWaNDMOY3ULp91ja4XJPCC3AripB47yUWOlr2xEjMk8YdR59fazGO3Fxm4tPiaOYsgRi5TTxMsaNO05WPQ4xXlaVrabxfWKs/MKoJN4yZqxw0r/7WDgEzKdYNfqf8BLCHsQqpMLgODAtR7A+0dC9r6e/AzC304ezhcKEi500JZivM+SKnSVELaxDkTWk6Drrr2rAvH1Hl+qkaytbVLYYy2HHfhySlNjFlpF7lgf76lCWuy/VABDTt4GFsKDNSkY8Y0QLZDH+fXim5DnbQWfbZg+h6HtZP3lhyMbi5NW5sLNVzz/BsH15kcT+FCYGNQWztpJ+q4dU246+WaN61WeKFhsuAdyaxZIwevw8gN7BTGW9CN7RtK9/0iT/lid5ET1ZhtpE2ghHYXizMBldA8f6qLK2IytiFPPg9hFIjznw/J2MCoPwCiUUj8BoLfGZEJ2z+9NKm+N8Gmrw8yQimQRGZYvhKmoMzA2NaE50gjRc/4imIx3TZyOAtjcenDdTtAH0I/W0guQmW4J4aPcG9fBvO09EXtu1Xm3gbO2krUMYu38GewIcrEGTsiJooaH5pialGP1wWEAJxwUlXzYipADcDFr3Sdl5D4EHjldlrOIhRNA1wyTM1Qm+19w25L3Q7sr+4Y9CxqLCYzjvCjWZDzQQq1Ej2rjBXgluJQhVOya29RpMKsWayCk/mrSnbLPFHqkDQYFK/68tJ5YSXzmwda4pW4qn1R2k5b2XOZQcqHeV8iwklgD2iKfE7FJjHf6HInsWSUQ61qYkOse7l2NkS3a1PVxYui/rq9uTydfhikRAAlYxkLwh2+GPGbkNcMvI9ypeJpZo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(5660300002)(33656002)(2906002)(38070700005)(478600001)(55016003)(44832011)(122000001)(186003)(66574015)(83380400001)(7416002)(110136005)(4326008)(8676002)(66556008)(76116006)(66446008)(66946007)(64756008)(66476007)(52536014)(86362001)(38100700002)(8936002)(7696005)(316002)(54906003)(53546011)(71200400001)(41300700001)(9686003)(26005)(6506007)(32563001)(357404004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RG1zQjA2YkdLMnpldHZVcS9uVFovTzBBdDhIQUNQdXI5dzRBN2ltczhMVHpD?=
 =?utf-8?B?Y1BHY2Vxc1Z6akx1andpYVJaKzgzaEZidjlJSlFXejJ6ZjVPQjdSRzNsMGc4?=
 =?utf-8?B?cHdYZE1lU2N3ekl6UTlnbDJTYUdWc0ZvK3FyN0hDVnArdm9pYVNQcUVZZlpw?=
 =?utf-8?B?TFdGdWo4NVRtSHhxVTVLdFl0QnhJN1lnWmQvK25hWVpKL1o3VlVtT0lwREdV?=
 =?utf-8?B?WTk0dFVnWlBHMlQ0N1ZncThJOXRoWXF5TnE5T2taM2RlS2k2UmxGV016VFpX?=
 =?utf-8?B?YVZUS24wOTZhcGVJbCsxNWV0OGltMWFvTXZKS3NHV3d3R0xRQXBYUy9DMjJu?=
 =?utf-8?B?ZXlEVUkwV1RNRU9VMlBBbVBuM3FISVVscE8zTmU3WlIybUhzbThoSzIvRFhR?=
 =?utf-8?B?U3dDdnRNVTlwSlIyTGN0NnUzMkQ0cFYyQnM5ZXlYb2R1SWR1YkdhRHl1aW5w?=
 =?utf-8?B?SDNUWUJBRlJJVnJUN1IzYjE3U1U3aDJwS3ZBbHFqSDZDMlV5WkxLY1ZIdkxx?=
 =?utf-8?B?NFhLbGE4QW9QejJBU1pVZit2WTh5c1ZvSVA3V1Vpay9OZlBzdlhQWUJIS0VU?=
 =?utf-8?B?N3A2V1RCOW0zUTRRVWp5N1NBMjV2bDNhaE53RWxXTHFpUStwdTcyNE5BYTVR?=
 =?utf-8?B?SnVLTS9rSkZNUUQyVUw1TlRhVE4wT2lXVEs4QkV0ODhrR2dSYmRUNzcwS3RB?=
 =?utf-8?B?QU1sWGw2Rjk5WlV6cExUYndXVDJzTjhkR04vZDUyL0hXejBiOUxzeUJ0SzUr?=
 =?utf-8?B?ZHdNcTFYT0VzMUhWVnhnYmxQNzFSaGxvT2pvNlhaZjh1UXBkRGpFWllRSGR0?=
 =?utf-8?B?eDEyNnFmVi9lanpsMkU3dVpkZTU0VzBrZGlPd3hoQzJNMFFwdVo1aTZpcjRq?=
 =?utf-8?B?dHRXbjNYbmhxNjc4MC85Qy85UjdaRDZNUUpVRmM3bXZMN2xWZXhpYTFiMnlL?=
 =?utf-8?B?QjdQd05BekI2anFvdXNYUGxzdXFLL2ZXNjczRmU0NGwwb3lBb2FSNW5Hc2Ir?=
 =?utf-8?B?dHpvZ0tjVmpKaGZ3bFFGWjJobTJETGVTc3hqK1RKZFBBVGxFWnJaeVEydUty?=
 =?utf-8?B?OW93SFhsWnNxZnhaN2tpb05mVmdKYTM0UEtud1dhL3NQVHNaQUNOVDdYbDRq?=
 =?utf-8?B?aDNEK0s5aGRqSzlqdVFhT0U3WGg0VHorL2dibTA2TlI3Z1p0K2VtelVlNW5V?=
 =?utf-8?B?dnFxdU1RUFFQK1dTUHppR2RTR2JSMnBBVVZOMnNaQVk3RldzbllwVlh6d1V2?=
 =?utf-8?B?Z0VmNktnWEdta21GZU5Gd2t2U09DVDdXVVlLQVFjQnFjZmQ3R25MMXdUUDZC?=
 =?utf-8?B?REkwaE5BbUlYVWFTSTFidXJwMnV0b3dyK0RLdHVwRWtMWWhxc0dnNHA5aFBz?=
 =?utf-8?B?NU4zZTZRenVjVjVKSGx1OENwZFIrUjZ0MjdBY21LVnoycDROZ25xaGtPR1d6?=
 =?utf-8?B?YVE5dFU5L0FJeGxreVp0MWdHMXZ4UU4wUEdCem13VC93RzRneGRyeFlaMTJR?=
 =?utf-8?B?ZjJkbjd2K1JEL294eTVCamZyS3ZLL3BLUEczWk5DT20wSTF5M3RobHFXTVkx?=
 =?utf-8?B?a0E1MmJVQzhGbHVWK0pyVkFCdERYVkFCYlJwbE9zYzBEejBhVmNGUHNhaHZF?=
 =?utf-8?B?cHhoOG1MU2tsSzVBL2llUklMTEFWQ3MyVWdVc0dKRzBhUmtmcHlBWGRNQXpD?=
 =?utf-8?B?UmhqQ3pXMGhDQldja1VUMjRwbDFuWnE0aEJmV2R0YzJydkxqL1hmY0pjTXhm?=
 =?utf-8?B?cHhvOTRDR3hlNzhDbXZxNWJjeUZhbGc1aUtDWGFNcGQ3d1FwOS9SU2V0MWZ6?=
 =?utf-8?B?WUdrUXB6Wlo5eG1GZ1dyNkkvMk9tZWdUbitZNEFLcE1Zek5IN1RFSWZVQjYz?=
 =?utf-8?B?ckZlWlpNclY0bHc3bW81TnhWalh5U3BMcWFuZjM3OXN6K3JGYmpHU2EwamtL?=
 =?utf-8?B?bVRyWFlURmtqRDZnZWIzOFRidEhwOWZHSFRwd1hOMXpkWWkvRXRDdUsxQlpz?=
 =?utf-8?B?WnN6L2QybTl1Uk04Tlp0aFp3MmJMbmxFRVg1YWU0Z3BQZUIxUVB4a3ZrWDNy?=
 =?utf-8?B?V2REZW9zRS9mTmF0WFgvYXcvZUtnMW5pYmdlVk5PU0ZUS21LelBsdWdVb1Nh?=
 =?utf-8?Q?fe4E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dca70cb-d5de-465a-ae33-08da5e2a17bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 02:00:10.5847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gJeBC4oEERAV88yTcqkSYgh670w+PPHtZ0cQgW0VmPRTBBkuykIMUpsYywtlhhvowPIaUTEzQs7sBCiiD+RV5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3437
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzQG5kdWZyZXNuZS5jYT4NCj4gU2VudDog
MjAyMuW5tDfmnIg15pelIDA6MDYNCj4gVG86IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+
OyBtY2hlaGFiQGtlcm5lbC5vcmc7DQo+IGh2ZXJrdWlsLWNpc2NvQHhzNGFsbC5ubA0KPiBDYzog
c2hhd25ndW9Aa2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJv
bml4LmRlOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwt
bGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT47IGxpbnV4LW1lZGlhQHZnZXIua2VybmVs
Lm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0hdIG1lZGlhOiBh
bXBoaW9uOiBvbmx5IGluc2VydCB0aGUgZmlyc3Qgc2VxdWVuY2UNCj4gc3RhcnRjb2RlIGZvciB2
YzFsIGZvcm1hdA0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBIaSBNaW5nLA0KPiAN
Cj4gTGUgbWFyZGkgMjgganVpbiAyMDIyIMOgIDEzOjIwICswODAwLCBNaW5nIFFpYW4gYSDDqWNy
aXQgOg0KPiA+IEZvciBzb21lIGZvcm1hdHMsIHRoZSBhbXBoaW9uIHZwdSByZXF1aXJlcyBzdGFy
dGNvZGUgYmVmb3JlIHNlcXVlbmNlDQo+ID4gYW5kIGZyYW1lLCBzdWNoIGFzIHZjMSwgdnA4Lg0K
PiANCj4gSSdtIG5vdCBzdXJlIHdoeSBWUDggaXMgYmVpbmcgbWVudGlvbmVkIGhlcmUuIFRoZXJl
IGlzIG5vIHNwZWNpZmllZCBzYXJ0Y29kZQ0KPiBmb3IgVlA4LCBhbmQgbm8gc3BsaXQgb2YgaGVh
ZGVycyBlaXRoZXIuDQo+IA0KDQpIaSBOaWNvbGFzLA0KICAgIFRoaXMgcGF0Y2ggaGFzIG5vdGhp
bmcgdG8gZG8gd2l0aCB2cDgsIGFuZCBpbmRlZWQgdGhlcmUgaXMgbm8gc3BlY2lmaWVkIHN0YXJ0
Y29kZSBmb3IgVlA4Lg0KQnV0IGFtcGhpb24gdnB1IHJlcXVpcmVzIGRyaXZlciB0byBoZWxwIGlu
c2VydCBzb21lIGN1c3RvbSBzdGFydGNvZGUgZm9yIHZwOCBhbmQgdmMxLg0KSXQncyBjdXN0b20g
YmVoYXZpb3IuDQoNCiAgICBJJ20gc29ycnkgdGhhdCBteSBkZXNjcmlwdGlvbiBpbmNsdWRlIHNv
bWUgY29uZnVzaW9uDQoNCk1pbmcNCg0KPiA+DQo+ID4gQnV0IGZvciBWNEwyX1BJWF9GTVRfVkMx
X0FOTkVYX0wsIG9ubHkgdGhlIGZpcnN0IHNlcXVlbmNlIHN0YXJ0Y29kZSBpcw0KPiA+IG5lZWRl
ZCwgdGhlIGV4dHJhIHN0YXJ0Y29kZSB3aWxsIGNhdXNlIGRlY29kaW5nIGVycm9yLg0KPiA+IFNv
IGFmdGVyIHNlZWssIHdlIGRvbid0IG5lZWQgdG8gaW5zZXJ0IHRoZSBzZXF1ZW5jZSBzdGFydGNv
ZGUuDQo+ID4NCj4gPiBJbiBvdGhlciB3b3JkcywgZm9yIFY0TDJfUElYX0ZNVF9WQzFfQU5ORVhf
TCwgdGhlIHZwdSBkb2Vzbid0IHN1cHBvcnQNCj4gPiBkeW5hbWljIHJlc29sdXRpb24gY2hhbmdl
Lg0KPiA+DQo+ID4gRml4ZXM6IDE0NWU5MzYzODBlZGIgKCJtZWRpYTogYW1waGlvbjogaW1wbGVt
ZW50IG1hbG9uZSBkZWNvZGVyIHJwYw0KPiA+IGludGVyZmFjZSIpDQo+ID4gU2lnbmVkLW9mZi1i
eTogTWluZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9t
ZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZkZWMuYyAgICAgICB8IDEgKw0KPiA+ICBkcml2ZXJzL21l
ZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1LmggICAgICAgIHwgMSArDQo+ID4gIGRyaXZlcnMvbWVk
aWEvcGxhdGZvcm0vYW1waGlvbi92cHVfbWFsb25lLmMgfCAyICsrDQo+ID4gIGRyaXZlcnMvbWVk
aWEvcGxhdGZvcm0vYW1waGlvbi92cHVfcnBjLmggICAgfCA3ICsrKysrKy0NCj4gPiAgNCBmaWxl
cyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZkZWMuYw0KPiA+IGIvZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZkZWMuYw0KPiA+IGluZGV4IDA5ZDRmMjc5NzBl
Yy4uNTEyMThhNDFhNWFjIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0v
YW1waGlvbi92ZGVjLmMNCj4gPiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24v
dmRlYy5jDQo+ID4gQEAgLTczMSw2ICs3MzEsNyBAQCBzdGF0aWMgdm9pZCB2ZGVjX3N0b3BfZG9u
ZShzdHJ1Y3QgdnB1X2luc3QgKmluc3QpDQo+ID4gICAgICAgdmRlYy0+ZW9zX3JlY2VpdmVkID0g
MDsNCj4gPiAgICAgICB2ZGVjLT5pc19zb3VyY2VfY2hhbmdlZCA9IGZhbHNlOw0KPiA+ICAgICAg
IHZkZWMtPnNvdXJjZV9jaGFuZ2UgPSAwOw0KPiA+ICsgICAgIGluc3QtPnRvdGFsX2lucHV0X2Nv
dW50ID0gMDsNCj4gPiAgICAgICB2cHVfaW5zdF91bmxvY2soaW5zdCk7DQo+ID4gIH0NCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1LmgNCj4g
PiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHUuaA0KPiA+IGluZGV4IGU1NmI5
NmE3ZTVkMy4uZjkxNGRlNmVkODFlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxh
dGZvcm0vYW1waGlvbi92cHUuaA0KPiA+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1w
aGlvbi92cHUuaA0KPiA+IEBAIC0yNTgsNiArMjU4LDcgQEAgc3RydWN0IHZwdV9pbnN0IHsNCj4g
PiAgICAgICBzdHJ1Y3QgdnB1X2Zvcm1hdCBjYXBfZm9ybWF0Ow0KPiA+ICAgICAgIHUzMiBtaW5f
YnVmZmVyX2NhcDsNCj4gPiAgICAgICB1MzIgbWluX2J1ZmZlcl9vdXQ7DQo+ID4gKyAgICAgdTMy
IHRvdGFsX2lucHV0X2NvdW50Ow0KPiA+DQo+ID4gICAgICAgc3RydWN0IHY0bDJfcmVjdCBjcm9w
Ow0KPiA+ICAgICAgIHUzMiBjb2xvcnNwYWNlOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21l
ZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X21hbG9uZS5jDQo+ID4gYi9kcml2ZXJzL21lZGlhL3Bs
YXRmb3JtL2FtcGhpb24vdnB1X21hbG9uZS5jDQo+ID4gaW5kZXggYzYyYjQ5ZTg1MDYwLi5mNGE0
ODhiZjk4ODAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9u
L3ZwdV9tYWxvbmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92
cHVfbWFsb25lLmMNCj4gPiBAQCAtMTMxNCw2ICsxMzE0LDggQEAgc3RhdGljIGludA0KPiB2cHVf
bWFsb25lX2luc2VydF9zY29kZV92YzFfbF9zZXEoc3RydWN0IG1hbG9uZV9zY29kZV90ICpzY29k
ZSkNCj4gPiAgICAgICBpbnQgc2l6ZSA9IDA7DQo+ID4gICAgICAgdTggcmN2X3NlcWhkcltNQUxP
TkVfVkMxX1JDVl9TRVFfSEVBREVSX0xFTl07DQo+ID4NCj4gPiArICAgICBpZiAoc2NvZGUtPmlu
c3QtPnRvdGFsX2lucHV0X2NvdW50KQ0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4g
ICAgICAgc2NvZGUtPm5lZWRfZGF0YSA9IDA7DQo+ID4NCj4gPiAgICAgICByZXQgPSB2cHVfbWFs
b25lX2luc2VydF9zY29kZV9zZXEoc2NvZGUsDQo+ID4gTUFMT05FX0NPREVDX0lEX1ZDMV9TSU1Q
TEUsIHNpemVvZihyY3Zfc2VxaGRyKSk7IGRpZmYgLS1naXQNCj4gPiBhL2RyaXZlcnMvbWVkaWEv
cGxhdGZvcm0vYW1waGlvbi92cHVfcnBjLmgNCj4gPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0v
YW1waGlvbi92cHVfcnBjLmgNCj4gPiBpbmRleCAyNTExOWU1ZTgwN2UuLjdlYjZmMDFlNmFiNSAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X3JwYy5o
DQo+ID4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV9ycGMuaA0KPiA+
IEBAIC0zMTIsMTEgKzMxMiwxNiBAQCBzdGF0aWMgaW5saW5lIGludCB2cHVfaWZhY2VfaW5wdXRf
ZnJhbWUoc3RydWN0DQo+IHZwdV9pbnN0ICppbnN0LA0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc3RydWN0IHZiMl9idWZmZXIgKnZiKSAgew0KPiA+ICAgICAgIHN0
cnVjdCB2cHVfaWZhY2Vfb3BzICpvcHMgPSB2cHVfY29yZV9nZXRfaWZhY2UoaW5zdC0+Y29yZSk7
DQo+ID4gKyAgICAgaW50IHJldDsNCj4gPg0KPiA+ICAgICAgIGlmICghb3BzIHx8ICFvcHMtPmlu
cHV0X2ZyYW1lKQ0KPiA+ICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4NCj4gPiAt
ICAgICByZXR1cm4gb3BzLT5pbnB1dF9mcmFtZShpbnN0LT5jb3JlLT5pZmFjZSwgaW5zdCwgdmIp
Ow0KPiA+ICsgICAgIHJldCA9IG9wcy0+aW5wdXRfZnJhbWUoaW5zdC0+Y29yZS0+aWZhY2UsIGlu
c3QsIHZiKTsNCj4gPiArICAgICBpZiAocmV0IDwgMCkNCj4gPiArICAgICAgICAgICAgIHJldHVy
biByZXQ7DQo+ID4gKyAgICAgaW5zdC0+dG90YWxfaW5wdXRfY291bnQrKzsNCj4gPiArICAgICBy
ZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIGlubGluZSBpbnQgdnB1X2lmYWNl
X2NvbmZpZ19tZW1vcnlfcmVzb3VyY2Uoc3RydWN0IHZwdV9pbnN0ICppbnN0LA0KDQo=
