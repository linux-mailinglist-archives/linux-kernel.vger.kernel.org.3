Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4162B5459C7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 03:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbiFJB7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 21:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiFJB7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 21:59:14 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70079.outbound.protection.outlook.com [40.107.7.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E3F1CE7AE;
        Thu,  9 Jun 2022 18:59:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPHb5cUl/DSpYkXjlkws0QJVGOW61fQpMdVbIo8eRnNk3mzbssUL3ULMfkokh7j8PmARU6hNvYTCy41K5ZpOyfDW0B0PTF8Ls3pchGGpDOuYjqF0QWm6UE0PE1HvOZAQAYQtfDnk1JwdTW+wkbxIl5AHaynu6L4aQFU317aBDYtnvUX7LvwQ8cueHcEALFumLHsE+/gMZB10EpwO8vsVJCP+YfR372TLtE1nI9s8iIQEGFXHYrPFn3S7UWJuvPoToXaaqaOyGJvhXFlnD1PJWJsi+GReDVavMKMvHS13ZULBHX+e9qS6/UGY+wGM8jnQsFALKZiPzzHqNFL0G5ZeIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6b32jZpkHOFA2HhxcVkxaiowPqMcYXgkdyHZKnG3no=;
 b=PVUmMuOciZ1z1ssNAvpz7tZuoLhqCQVS05sgudXG8ZzdnBlHMYg3FovAXB2N9LrYf2WzC5PyzxLeV5CCT7aIm5KVZk3IlSjUI0Rp3T1WsQkgiasWcRGxSdXWLVNs77bItvpJT0/t0AkxqEg4n3WnlD2wRhZrdSRR4m1d/gYKkykoaJLPaBKoHRvb903xiUPmJzbAKkXW3HyKH+p0BAnMdUzChfNr5SgfuOGs8Q+RA0h9JiAEQZwNgbbGZ5t1uwc66AQS3AaAbhSN3ULQD+QiyN+YJHibZOECpOdkGS3JyJ5dTX6EFBF7tCWCF37/rt43GuZf9DpGgh9dXPd77iYRxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6b32jZpkHOFA2HhxcVkxaiowPqMcYXgkdyHZKnG3no=;
 b=DfJeyIqNTRn04/EKy7RQ06GNZaT8V7rMDGzJZnNznZzboF82+H11SNIDz3jHfWF72H7sCILQqsVi80AayBYS0LAYg+a1q39bEZ9Z2LuKRBNut7Ul6mx8NSEebPNzXm4B8VEpPo5nuex3ho1TSKbDz0XinT/n7RhM13t1TUORV7I=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB8PR04MB6811.eurprd04.prod.outlook.com (2603:10a6:10:fa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 01:59:10 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5332.014; Fri, 10 Jun 2022
 01:59:10 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH] media: imx-jpeg: Disable slot interrupt when
 frame done
Thread-Topic: [EXT] Re: [PATCH] media: imx-jpeg: Disable slot interrupt when
 frame done
Thread-Index: AQHYej+Btcwur4Gmv0msDjYjbiM9bq1G4m6AgAEEKoA=
Date:   Fri, 10 Jun 2022 01:59:10 +0000
Message-ID: <AM6PR04MB6341DC7B7FFB745576B7A444E7A69@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220607072315.23209-1-ming.qian@nxp.com>
 <ca006530-b20b-f97c-af68-5f0191478f96@xs4all.nl>
In-Reply-To: <ca006530-b20b-f97c-af68-5f0191478f96@xs4all.nl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a796994b-4cb9-4500-2203-08da4a84cf78
x-ms-traffictypediagnostic: DB8PR04MB6811:EE_
x-microsoft-antispam-prvs: <DB8PR04MB6811592428DFD5BD376F9635E7A69@DB8PR04MB6811.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KdCEnky9VxvaLjcJLFXqfXWbPPHD8zJb0mfx/KiDM7r1YJlrnC170llhOlHYR4J3tSaxqjJbLv9zOWorghaMsjZSRqGKLdghBig0NehcA9cJ8Le4kkh3hWT1+iQ0YPpK650vH5INBwYO3bwGk5yogQBBJnBqGvBHxcbPdAzUsnAfCjiK2YEGdoVsQaTdxMwSIUTZ0T4QY0Gwr29GdQaAHAw/aj+UZ6WTxuiSVgDas7GxjA6Nw34iIB6ex/C1zCRPRR3+xNo1gl07DBvpmO120K352sVz53wAnqgn4klr2NYOh3i6jdoufGcUl6hLrF9Z9ALhPeTmouIJ3RxgOH+YE8OQzAZlO55OY5E7quiDcWLaPsry7w6klLsbY/pMCOvZeqnD1DiZR387DL8vxxCIJ1B7JkbWxnz7lAmF25yF0Loe9YLITSOYy2Sl6WMtJ9OQpBbm7iqyQDKFYIdhTX2IIWynzCgF66EX20kC2DLB1uhFHNUN70diXwA8tnwEycWuoaWj3Edt4+OrLBQysskBMw6RsaLWY+evTFGJh6PI5xGZ9VG0Fen2DpaGYKsick7Mw8u5C5Ru4LEqY0b3pwaEslZCA/2cuXVktHs2tziAmTcMrSaCVEQgZog1yh4oPSfw2A3aXAKQbfosZonmEKTw3MBJw+R1EggQ6A9lzmGfBUbRA6K6t7AFm7qkeN1Vidh1MhY9WL4l4Ch1TU+078k/sQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(6506007)(7696005)(54906003)(186003)(8936002)(110136005)(33656002)(52536014)(316002)(122000001)(53546011)(38100700002)(83380400001)(5660300002)(71200400001)(44832011)(38070700005)(7416002)(86362001)(55016003)(508600001)(9686003)(4326008)(64756008)(8676002)(66446008)(26005)(66476007)(76116006)(66556008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXFwVjg0c0xmRkpmZWdtaHAvdHAxYk1hTVc2eXFENmNtajlEaGV2WTJweFBi?=
 =?utf-8?B?QUFSMGJjWkloNThPNS95RmxjNGhNZndOMkRadzQ5aEtPdk1GNkRtMFdpeWla?=
 =?utf-8?B?NWs3RGdYY3JhTnAvS1J4TEM5djBHNXB2MXhFUW5xWFIvb05jMFRsVjUxZWJn?=
 =?utf-8?B?YWNGdlhBaWlZR0xTR2ZrOFBnVmVxeWU5b2VQTyt5M0pubEVpZ0VQY1ZLWWhM?=
 =?utf-8?B?cFAwdWhxUm9MY0luWXpGcXFPRjlZQWd6UUNzb1p1N3grUlh6bDVmdW9LOXBU?=
 =?utf-8?B?TG1EM3hnbG1LTE13NStxMUZqd3l1TWQ0eTdTeWlHUEQxVkhwaU1VTldSaUlz?=
 =?utf-8?B?MGplVzlsZzFHNVBjWGEwRE0va25QT3FBUVZpZ0ZoZWl0OVE5cWtFb0FFZHhO?=
 =?utf-8?B?QmozVkM0MWhraHhObTBjZUZJSVB5bFkyMU5DNnpvZUhOd24rVjUydTJHWGw4?=
 =?utf-8?B?TFN4Y1RjNVdLQVZ5MjFNMEFUUm9MeW5iZjZvT0dCNEw5NmxiUnVHTW1UTnB2?=
 =?utf-8?B?ckRxckRlNDNMNTFyTVRJeVhJNG9iK04xNTVYZVE2ZS8zbUI4V0VDM25sT1NL?=
 =?utf-8?B?SDloODZ6TTArR3dvYjlDOXorbm1KaS8yaXRSRHZFbzN4cXI2MjF4RERaRnA1?=
 =?utf-8?B?dEZ3cnVmSTdYUDNqaFdJSkp1UjcxdWtPYTAxc3djVFNFWEErWkowR3BUOWRL?=
 =?utf-8?B?SFNDMWVNbStKMDhka2U5NVg2U1FvWDQ4VUlUdCtaTHJjZUZyeUNPd0FCanBi?=
 =?utf-8?B?YzdJNzZFbFNwSTN3VVdTUjZacFVqS2YrbHhUaUp0TmdqbEpKOE84b0U4NEow?=
 =?utf-8?B?Njhub1I5dlBDNkUwTGxEbTBzc1g4SHNOOHVWK2QwUy91SEFpcGpRUDVaRm4y?=
 =?utf-8?B?TUJMMWtYbjg4NjhMNStnMkJSRlp3bXFMa1JEM2lhNTE5U3RMdytuM2lRcER3?=
 =?utf-8?B?K25Oem5wTi9iQkNnTi9MYW5tUGVVaG5taytJTUhXcGhjRUVIb2tvSjdBWStj?=
 =?utf-8?B?RjZHVUxqYkZoM0tXLzlLVEFTemZOanludXdnbzBseVZHMkY1Z2dwUW5KVkho?=
 =?utf-8?B?N25tdXpsdENHVDVPS3cxWWNFRUJ4TDh4cGhqOUt3UjAzZWRXN2RZY2x5NERH?=
 =?utf-8?B?blZTS3duamtNVXhsNEFqb3ZKV3dOUUUwTlVUUE1nK0hybkhrNEpLemtwWDdr?=
 =?utf-8?B?QjZUTWhYQlh3dGxRb0s5ZzZyYm1TVEdVTXlqOGRhRTdqRE9HVllaWXVCYUR5?=
 =?utf-8?B?QmdvdHJrNlBNWmhrY1VuWHYrVFp1MVlBczRaNnlreEQrWmUyaTJVbTJrTkhn?=
 =?utf-8?B?R29Md2w5ODJZbHMrR3o3ZnRNUTRXUnFGODk4ZVJwMXp2azB3WTFua2hZMXp2?=
 =?utf-8?B?dTFwSTBaM1hCVXQvN3ZsdWJ0OXAveXR3WkxvNCtFT0pYQmJyYXEvQzJaSHlI?=
 =?utf-8?B?SGNWMU9yNVBrK2NWcDcyTU9HWlVUS3N1aEJNVGw3Z3lkNU9hVGw4UlBSVktl?=
 =?utf-8?B?a2s4UnJyUlo0UGhJUFc5c0dpRXV1NzVXQkFnKzMrcFhiM3dXMWZUTVdFWnI4?=
 =?utf-8?B?aDBaa0VuQ3AxRkVlb1ltTnFia2pUNjRLdFRPcWl2MjE4VzJ2aFFlSkNHVGpG?=
 =?utf-8?B?R1lJUlVjdGlsQUpSSk1tYjF3cWpuUyt0aDc3eWRuaWVVZUFiRFlVbCtvNkRT?=
 =?utf-8?B?eTRnVGpUOUlJMlR2aXNLTUNvK3lFMkZNdGhlKzFwMDlBaklSQjUwZTh4WHc1?=
 =?utf-8?B?ZjJUWE45M0g4T0lLSWJPY0gyazZFYUU1N3RFZml0Mzg5VUhLcko3Q2hCZWxS?=
 =?utf-8?B?V09velRHcFZiUkk1NElvdjZ4Um1DdXNnemppN1JrSU5aQURCMVFObmc0cFlP?=
 =?utf-8?B?bkdXM1BqWGxRcEp3TmlRV2NzN1JNeW1ZRER2UE53OXJYV2NLV0FkOWlyZEpx?=
 =?utf-8?B?QXVqazYzU05oZGppTjFtZjRaT2pnVzZsanRyaXUxNkpqZnVtc25YckIxcTBS?=
 =?utf-8?B?M3VnV3JSemsydG9Dcnl4VEVLUjVxYjY0Qk96YmdreGdQMXJtNW1teU13K0hF?=
 =?utf-8?B?Z2xBMFlsNTAvUzZ6bWFSTVg0VFlBVTIvTFRJUmsvVnZHeVExcmxvcFNoQ3p5?=
 =?utf-8?B?eStOV2g5NnNOd1JJRDRnOFRqOHZNZTNkSE5jNnp0cnZtTTJKQUc0SFhmcXVL?=
 =?utf-8?B?eE9vZHU0MHc0bUg2WmxMZEU1Y0FpK1RQdGIxdFNEVFk5dGIxcjZaaXFzcjJV?=
 =?utf-8?B?Sms0dlM3bGJ0a3JFcFcvVHVzS3R2Mk8vSHlIclZZUUh2cWVmdDA4U2ZRbVM3?=
 =?utf-8?Q?NeBPcHaWB40ew5pCkr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a796994b-4cb9-4500-2203-08da4a84cf78
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 01:59:10.2772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3OdcD4Lb5R7dOwRyDkbs55h4qlaOP1n2VbK66tMX6My37tcnznet8a8QzzNSs1iP7fRVGbdd2PDRQhJEDEhSFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6811
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBIYW5zIFZlcmt1aWwgPGh2ZXJrdWlsLWNpc2NvQHhzNGFsbC5ubD4NCj4gU2VudDog
MjAyMuW5tDbmnIg55pelIDE4OjI3DQo+IFRvOiBNaW5nIFFpYW4gPG1pbmcucWlhbkBueHAuY29t
PjsgbWNoZWhhYkBrZXJuZWwub3JnOyBNaXJlbGEgUmFidWxlYQ0KPiAoT1NTKSA8bWlyZWxhLnJh
YnVsZWFAb3NzLm54cC5jb20+DQo+IENjOiBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBl
bmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGZlc3RldmFtQGdtYWlsLmNv
bTsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+IGxpbnV4LW1lZGlhQHZnZXIu
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBT
dWJqZWN0OiBbRVhUXSBSZTogW1BBVENIXSBtZWRpYTogaW14LWpwZWc6IERpc2FibGUgc2xvdCBp
bnRlcnJ1cHQgd2hlbiBmcmFtZQ0KPiBkb25lDQo+IA0KPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4g
DQo+IEhpIE1pbmcgUWlhbiwNCj4gDQo+IE9uIDYvNy8yMiAwOToyMywgTWluZyBRaWFuIHdyb3Rl
Og0KPiA+IFRoZSBpbnRlcnJ1cHQgU1RNQlVGX0hBTEYgbWF5IGJlIHRyaWdnZXJlZCBhZnRlciBm
cmFtZSBkb25lLg0KPiA+IEl0IG1heSBsZWQgdG8gc3lzdGVtIGhhbmcgaWYgZHJpdmVyIHRyeSB0
byBhY2Nlc3MgdGhlIHJlZ2lzdGVyIGFmdGVyDQo+ID4gcG93ZXIgb2ZmLg0KPiA+DQo+ID4gRGlz
YWJsZSB0aGUgc2xvdCBpbnRlcnJ1cHQgd2hlbiBmcmFtZSBkb25lLg0KPiA+DQo+ID4gRml4ZXM6
IDJkYjE2YzZlZDcyY2UgKCJtZWRpYTogaW14LWpwZWc6IEFkZCBWNEwyIGRyaXZlciBmb3IgaS5N
WDggSlBFRw0KPiA+IEVuY29kZXIvRGVjb2RlciIpDQo+ID4gU2lnbmVkLW9mZi1ieTogTWluZyBR
aWFuIDxtaW5nLnFpYW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tZWRpYS9wbGF0
Zm9ybS9ueHAvaW14LWpwZWcvbXhjLWpwZWctaHcuYyB8ICA1ICsrKysrDQo+ID4gZHJpdmVycy9t
ZWRpYS9wbGF0Zm9ybS9ueHAvaW14LWpwZWcvbXhjLWpwZWctaHcuaCB8ICAxICsNCj4gPiAgZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9ueHAvaW14LWpwZWcvbXhjLWpwZWcuYyAgICB8IDExICsrLS0t
LS0tLS0tDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9u
cygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbnhwL2lt
eC1qcGVnL214Yy1qcGVnLWh3LmMNCj4gPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbnhwL2lt
eC1qcGVnL214Yy1qcGVnLWh3LmMNCj4gPiBpbmRleCBjNDgyMjI4MjYyYTMuLjk0MThmY2Y3NDBh
OCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL254cC9pbXgtanBlZy9t
eGMtanBlZy1ody5jDQo+ID4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9ueHAvaW14LWpw
ZWcvbXhjLWpwZWctaHcuYw0KPiA+IEBAIC03OSw2ICs3OSwxMSBAQCB2b2lkIG14Y19qcGVnX2Vu
YWJsZV9pcnEodm9pZCBfX2lvbWVtICpyZWcsIGludA0KPiBzbG90KQ0KPiA+ICAgICAgIHdyaXRl
bCgweEZGRkZGRkZGLCByZWcgKyBNWENfU0xPVF9PRkZTRVQoc2xvdCwgU0xPVF9JUlFfRU4pKTsg
IH0NCj4gPg0KPiA+ICt2b2lkIG14Y19qcGVnX2Rpc2FibGVfaXJxKHZvaWQgX19pb21lbSAqcmVn
LCBpbnQgc2xvdCkgew0KPiA+ICsgICAgIHdyaXRlbCgweDAsIHJlZyArIE1YQ19TTE9UX09GRlNF
VChzbG90LCBTTE9UX0lSUV9FTikpOyB9DQo+ID4gKw0KPiA+ICB2b2lkIG14Y19qcGVnX3N3X3Jl
c2V0KHZvaWQgX19pb21lbSAqcmVnKSAgew0KPiA+ICAgICAgIC8qDQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbnhwL2lteC1qcGVnL214Yy1qcGVnLWh3LmgNCj4gPiBi
L2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbnhwL2lteC1qcGVnL214Yy1qcGVnLWh3LmgNCj4gPiBp
bmRleCAwNzY1NTUwMmY0YmQuLmVjZjNiNjU2MmJhMiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L21lZGlhL3BsYXRmb3JtL254cC9pbXgtanBlZy9teGMtanBlZy1ody5oDQo+ID4gKysrIGIvZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9ueHAvaW14LWpwZWcvbXhjLWpwZWctaHcuaA0KPiA+IEBAIC0x
MjYsNiArMTI2LDcgQEAgdTMyIG14Y19qcGVnX2dldF9vZmZzZXQodm9pZCBfX2lvbWVtICpyZWcs
IGludA0KPiA+IHNsb3QpOyAgdm9pZCBteGNfanBlZ19lbmFibGVfc2xvdCh2b2lkIF9faW9tZW0g
KnJlZywgaW50IHNsb3QpOyAgdm9pZA0KPiA+IG14Y19qcGVnX3NldF9sX2VuZGlhbih2b2lkIF9f
aW9tZW0gKnJlZywgaW50IGxlKTsgIHZvaWQNCj4gPiBteGNfanBlZ19lbmFibGVfaXJxKHZvaWQg
X19pb21lbSAqcmVnLCBpbnQgc2xvdCk7DQo+ID4gK3ZvaWQgbXhjX2pwZWdfZGlzYWJsZV9pcnEo
dm9pZCBfX2lvbWVtICpyZWcsIGludCBzbG90KTsNCj4gPiAgaW50IG14Y19qcGVnX3NldF9pbnB1
dCh2b2lkIF9faW9tZW0gKnJlZywgdTMyIGluX2J1ZiwgdTMyIGJ1ZnNpemUpOw0KPiA+IGludCBt
eGNfanBlZ19zZXRfb3V0cHV0KHZvaWQgX19pb21lbSAqcmVnLCB1MTYgb3V0X3BpdGNoLCB1MzIg
b3V0X2J1ZiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgdTE2IHcsIHUxNiBoKTsNCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9ueHAvaW14LWpwZWcvbXhjLWpwZWcu
Yw0KPiA+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9ueHAvaW14LWpwZWcvbXhjLWpwZWcuYw0K
PiA+IGluZGV4IDk2NTAyMWQzYzdlZi4uYjFmNDg4MzUzOThlIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvbWVkaWEvcGxhdGZvcm0vbnhwL2lteC1qcGVnL214Yy1qcGVnLmMNCj4gPiArKysgYi9k
cml2ZXJzL21lZGlhL3BsYXRmb3JtL254cC9pbXgtanBlZy9teGMtanBlZy5jDQo+ID4gQEAgLTU5
MiwxNSArNTkyLDcgQEAgc3RhdGljIGlycXJldHVybl90IG14Y19qcGVnX2RlY19pcnEoaW50IGly
cSwgdm9pZA0KPiAqcHJpdikNCj4gPiAgICAgICBkZXZfZGJnKGRldiwgIklycSAlZCBvbiBzbG90
ICVkLlxuIiwgaXJxLCBzbG90KTsNCj4gPg0KPiA+ICAgICAgIGN0eCA9IHY0bDJfbTJtX2dldF9j
dXJyX3ByaXYoanBlZy0+bTJtX2Rldik7DQo+ID4gLSAgICAgaWYgKCFjdHgpIHsNCj4gPiAtICAg
ICAgICAgICAgIGRldl9lcnIoZGV2LA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAiSW5zdGFu
Y2UgcmVsZWFzZWQgYmVmb3JlIHRoZSBlbmQgb2YNCj4gdHJhbnNhY3Rpb24uXG4iKTsNCj4gPiAt
ICAgICAgICAgICAgIC8qIHNvZnQgcmVzZXQgb25seSByZXNldHMgaW50ZXJuYWwgc3RhdGUsIG5v
dCByZWdpc3RlcnMgKi8NCj4gPiAtICAgICAgICAgICAgIG14Y19qcGVnX3N3X3Jlc2V0KHJlZyk7
DQo+ID4gLSAgICAgICAgICAgICAvKiBjbGVhciBhbGwgaW50ZXJydXB0cyAqLw0KPiA+IC0gICAg
ICAgICAgICAgd3JpdGVsKDB4RkZGRkZGRkYsIHJlZyArIE1YQ19TTE9UX09GRlNFVChzbG90LA0K
PiBTTE9UX1NUQVRVUykpOw0KPiA+IC0gICAgICAgICAgICAgZ290byBqb2JfdW5sb2NrOw0KPiA+
IC0gICAgIH0NCj4gPiArICAgICBXQVJOX09OKCFjdHgpOw0KPiANCj4gVGhpcyBsb29rcyB2ZXJ5
IHNjYXJ5LCBzaW5jZSBpZiB0aGlzIGhhcHBlbnMsDQo+IA0KPiA+DQo+ID4gICAgICAgaWYgKHNs
b3QgIT0gY3R4LT5zbG90KSB7DQo+IA0KPiB0aGVuIGl0IHdpbGwgY3Jhc2ggaGVyZSB3aGVuIGl0
IGF0dGVtcHRzIHRvIGFjY2VzcyBjdHguDQo+IA0KPiBTaG91bGRuJ3QgdGhpcyBiZSBiZXR0ZXI/
DQo+IA0KPiAgICAgICAgIGlmIChXQVJOX09OKCFjdHgpKQ0KPiAgICAgICAgICAgICAgICAgZ290
byBqb2JfdW5sb2NrOw0KPiANCj4gSXQncyBjZXJ0YWlubHkgYSBsb3QgbW9yZSByb2J1c3QuDQoN
ClllcywgeW91J3JlIHJpZ2h0LCBJJ2xsIG1ha2UgdGhlIHYyIHBhdGNoLg0KVGhhbmtzIGZvciB5
b3VyIGNvbW1lbnRzDQoNCk1pbmcNCj4gDQo+IFJlZ2FyZHMsDQo+IA0KPiAgICAgICAgIEhhbnMN
Cj4gDQo+ID4gICAgICAgICAgICAgICAvKiBUT0RPIGludmVzdGlnYXRlIHdoZW4gYWRkaW5nIG11
bHRpLWluc3RhbmNlIHN1cHBvcnQNCj4gPiAqLyBAQCAtNjczLDYgKzY2NSw3IEBAIHN0YXRpYyBp
cnFyZXR1cm5fdCBteGNfanBlZ19kZWNfaXJxKGludCBpcnEsIHZvaWQNCj4gKnByaXYpDQo+ID4g
ICAgICAgYnVmX3N0YXRlID0gVkIyX0JVRl9TVEFURV9ET05FOw0KPiA+DQo+ID4gIGJ1ZmZlcnNf
ZG9uZToNCj4gPiArICAgICBteGNfanBlZ19kaXNhYmxlX2lycShyZWcsIGN0eC0+c2xvdCk7DQo+
ID4gICAgICAganBlZy0+c2xvdF9kYXRhW3Nsb3RdLnVzZWQgPSBmYWxzZTsgLyogdW51c2VkLCBi
dXQgZG9uJ3QgZnJlZSAqLw0KPiA+ICAgICAgIG14Y19qcGVnX2NoZWNrX2FuZF9zZXRfbGFzdF9i
dWZmZXIoY3R4LCBzcmNfYnVmLCBkc3RfYnVmKTsNCj4gPiAgICAgICB2NGwyX20ybV9zcmNfYnVm
X3JlbW92ZShjdHgtPmZoLm0ybV9jdHgpOw0K
