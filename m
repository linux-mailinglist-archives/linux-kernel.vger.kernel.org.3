Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA5E4AB450
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbiBGFtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243719AbiBGDR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 22:17:58 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70072.outbound.protection.outlook.com [40.107.7.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4746C061A73;
        Sun,  6 Feb 2022 19:17:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuFbOvYvVSw6DpsvyURh1XQLNf8nhbAHSd4doTJHVoAE1ZOF6cjXdnOJVGEPOv6j21jBk93cBwjy54HfY1sa77B/9MA+VtzJyvMfAorpGNSppIPH83ZRHm0XNEq+yXC9auyq+t2mEOqj1J/QdBfSEZTJgpO+nOuIrbcIgPTzv6ZQA9lHbD9NTIC2fI3ZgcbNTgng71bs+u0feeYjHs31o7uQ1gOmTS+ZrbrbJirO+euq4/SaW+HGRJrRHZ9xYXdG8BGJMD7gwt7Az+avF82y3TAijBxpDnZzmc3AEsmviXfJutq/8nhPJyAAoNvJrRMOoEIxQlmHuAQW/8c7ATzk/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJPuQG4ZX2N4GbdRLcQvL+s2ZZfuadzg8fMcAxJRIG0=;
 b=UI4qFGalzSr2ZcFD6tMBepqbXp0M68b0T0WGG20HFgpZxq0Igr2Dk1etNJIGMj8lNYl2OTEu4PLFrKWBI+8A4hJgyo7ll8gyYM61JO+f4yAcsAN3e9qIpd39aoUeQs0eKhKfB+3TiCaliYTwquVGS96S3C5igxhDLa/Bd1L19WYcKWSlRkNB/5IAef6ikTKDfKZ4AwLbMPVck96IfSPK/6NjIkPhKirpIeMqn3yMgjoEaaJNDfsvEYaluHgtD9k44dtNq5oJetfUXAALt057DIGbe37f8qMxkk5ub0/uEBaeMpg2Hu+FihH8tuL/T/EmZMda4IBRVpnRxkZjgow+Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJPuQG4ZX2N4GbdRLcQvL+s2ZZfuadzg8fMcAxJRIG0=;
 b=X9/D3hLeCpbNJTZTqoBXp0CewUsS8Ng5+au6H7sYCTZ4vJ+rNDfM/RkxEHTNjm9qd1JonNCQIyJemMwAxR7Fzw8wdLMcjneaFDGNv2mjWAQhWkTreNru6fO9siY98yI18dI6ibyVIY3feovUocBnZUHGLV3HS0An2dNvFE+2XQM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 03:17:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 03:17:53 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 0/7] mailbox: imx: misc fix and SECO MU support
Thread-Topic: [PATCH 0/7] mailbox: imx: misc fix and SECO MU support
Thread-Index: AQHYATQIs7ZYZ2fIskCG97pRhjbKp6x1GigAgAXA/YCADMSGcA==
Date:   Mon, 7 Feb 2022 03:17:52 +0000
Message-ID: <DU0PR04MB9417AE01FCECD9BABD530DAA882C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220104062547.2103016-1-peng.fan@oss.nxp.com>
 <DU0PR04MB941793A918C5E08C9A48BCAC88209@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CABb+yY2tFtwFvWGh5OtHYwfvkjv3z51CD3cyemq=4Vd-YnY6aQ@mail.gmail.com>
In-Reply-To: <CABb+yY2tFtwFvWGh5OtHYwfvkjv3z51CD3cyemq=4Vd-YnY6aQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ff3efb2-30de-4e84-3aa2-08d9e9e86da7
x-ms-traffictypediagnostic: AM9PR04MB8793:EE_
x-microsoft-antispam-prvs: <AM9PR04MB87934CAC3F5781B6FD8F642E882C9@AM9PR04MB8793.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S4628bCmFD0L3O2haASxpzT5HmuGdxn9B9voRiduXGFmT4m5a5v/ZEKRdNV9J1gcE4r92i97v4aLDV3bls7OJAT+41PeSA2zn1sb1W9TsHdFoN5dgPY7tREqZs7oy51N97hG5Sgz6Ojh3uOi3bQNc5F2YCmzl9R/ps/0GRBg3FyU/eSY19qBBOEHsrC4zfKcjuGzu64qVZu32MiLhqOi8uKaA1zDO2JCZuNUTUeLJJyOdndaa7dHOSjox2I+iJfQ/s4ztQ+72XdrWkHk+DcFfcxtSxM9E4ynYvlD8+bMcLcTYf2RTsLlktGTQ50old/SBRaoNaLUb5qBe+mdzK9mmGGWJ4UFNJqhAYVSznof42feXcIGNJKy1BfiBwt9JhsyZ2u50ZBT/jZ264i/RdX9KkIYeM0vs4AvDGEl2EabKOYhPkdnZLvXoGlqTJPMvq9HRzqYgUsdUqtvml08ONnXXZ6JvH7sSZJdalRQolhi08eXHbNmHkjFCkutaeqxSq4LY1W2phowCBKdjC5XEIgOxDg58cU6kuGY8G/7PVDRvB88TWDOF3vydg0xfiqKDR1zTsBgzjGtqC172jMbjZP8bn4F8bPSXcYoJNxKx0piO69uLNoHNjB9KWkaNwGMy2jP3JfmX+0btI5kTMZiRVqeWESS+1gUcjKHziYGDAx3EkJ8jGhBaE7PesasHE1265JhgaaNikIpOQr5i3/uSIB02A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(186003)(316002)(6506007)(54906003)(55016003)(6916009)(71200400001)(122000001)(38100700002)(2906002)(7696005)(9686003)(53546011)(33656002)(38070700005)(86362001)(66946007)(52536014)(44832011)(15650500001)(5660300002)(508600001)(83380400001)(8936002)(8676002)(4326008)(64756008)(76116006)(66476007)(66556008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnZlbngzS25jRkJIZWFtd29JRWdPYjRDbVdWbFFSNmdmY3lQM1NYNnB1cEQ3?=
 =?utf-8?B?QzVLSCswZlZKZXlpeFRMTzREZDJXSWRMcklOYk1PWGhWdm8waWEybTJyNWdS?=
 =?utf-8?B?b0R3SzI3MjlBSVJkL3JyUEZQY2lJdWRydnpIZlRrL3ZiNFJPRjZYdEVLL3dF?=
 =?utf-8?B?ZDVFU2NrRjd1eWlHeXU2ZmQxQ3E2SkNQSGZLUTZ2a0lWdS9QS1hFQkJ0WW00?=
 =?utf-8?B?U29COEZTSjkzT1VySEMyS0pmT2FmYUhEaTJBaWsyVUpJWnhiNkVvV2h6VEpj?=
 =?utf-8?B?cWRmZWEyOGd5ajhLRlFlMEtNVmdKTTNhWU0rYXkwVDgyYzMrS2hSNE5CLzJz?=
 =?utf-8?B?RFVQZFk5WnpZMUloOE1MSjRyN2JzdWhqc3doZk9yaWU4RHVlK3d5TU1iT0JF?=
 =?utf-8?B?QlRJYU82QnNyVUxwMDlLTlo0L0ttdGRQRktNcG9aZmJTY0pUWVZPK0VPWmFv?=
 =?utf-8?B?bXRuQ0ZGakJ1ZnFSMXBrZ2Nqc255K0xFSWdyK25XL3FkUEphVlJRSVJGTmhJ?=
 =?utf-8?B?R1pGRndQWDBuamFpeFhjWGo4UEExKzlFN3pNWEdRZGpIOS9mcWwwWWNBNUZH?=
 =?utf-8?B?K0w3bWJMcitxZlB5QjVwRFh3QmRBZ0NJN3Z5WWEzSG50RmZUYnh1aGlLWm9I?=
 =?utf-8?B?ZHYrS1VWdGQ1UVpFRVl5NXlvUTZ4bGVwdzM4c3hXNytkVlRpcTFFUDZQNUhI?=
 =?utf-8?B?RE1sRkd2ZmtmVEY5MXFFTnJvRmI5UWsxVlppNkVpYWNJcnQxL0tjcndkWjJM?=
 =?utf-8?B?emVpWmo2eUF0WHNUVVlUVXk0djVsbmxNVFV4OXFnN1pwRE1sNEdzTXhWL2xu?=
 =?utf-8?B?dUc5MEMrNjBTYmlWRTEwZUJlaEx4UHQ0bFFNR0paMnZmTFZaR25lQ2xPWGFi?=
 =?utf-8?B?VVBEZXV1VnhIYW9LWXpHWHcwNFUzYktlUFRpQW1RRnlKTEtlNDlxODZvT2NR?=
 =?utf-8?B?UWtQVkl1WDJTRlNWb2g0bE9YOTU3aU91N01QVnRLaFltUHpFTjVhWGoxRjVa?=
 =?utf-8?B?a2E4ZGdMRk1MN3NhczdaUHNvVXVGNzkrbUtuaHhlL2hwUVZmbGRUTmI5cnlF?=
 =?utf-8?B?VXdQK1Z5SXhyc2ZadWtndkRtcUIxOGlJZVEwRlJiWlZIK0VqQzlhZEM1WGR4?=
 =?utf-8?B?OEhDa2c2QkJ5OU13YkdtVUxhVzVnbTREU0J0RmM4eFdMbmF0aHBPOWF0dkQ0?=
 =?utf-8?B?UERjMktZbWFBSnpkV0hrTm1DZFRWSCtVdUVLTDFJb21Qc3NhYW9IR1l5Q2Zn?=
 =?utf-8?B?WUM5TlN2K3diY3B1SU5aVlQvMVBpTTgxOWNpZkErSkR4eC9naE5oT1hMazlF?=
 =?utf-8?B?ejNNc0QvZS91YlFMWHIrbllMcHVTQnVxUHg1enU1OFFXYXR6RUU2WWxOQVZu?=
 =?utf-8?B?M1M4ZUpBTjhHb1V5VmEwU2FlNXlOazVERk5UM1lXSnphUjI2SlNQRmIvUlR5?=
 =?utf-8?B?ekpZOWtETGNTR2ttNE5jeE1GcEpqWjZIdDFQaHNrNkR2MzQydUVSL1o1ZWlC?=
 =?utf-8?B?MGRCazBhajNEcnpWQjRVN010K2VKblJUQ1FHNGxvbWYrYWRxVTBmQUIydjIy?=
 =?utf-8?B?SDd6SEJBMDdPRzlGYWhibnhRZzN3dlhUUHRrVVVoS3lPSW5nVGwweE9IOWhr?=
 =?utf-8?B?NWFTWk5CdWRMQ1g3cThsYktiYmxWMXpkL1UyeCtGREpFbjdZOFZQOVJscnZY?=
 =?utf-8?B?VFdOZUJrY1ZSTktWazF2QldieStOVE8xRUNUOFpYd3VqRTZoS1JTNE5FeDhl?=
 =?utf-8?B?dFhRNit0eVJFVFd2d0pUY3pyK3hDVjhLaTB2cGVITGt0U1V5NUMwczBBR2Fq?=
 =?utf-8?B?R2F4K1B4QzhTZk0zRHluem9xWFNUSWgwQ1V6WDBleDNDQUswb0hvWEtVZ2xH?=
 =?utf-8?B?Mkp3WXF1MkZUK1lHQlpMLzRzaDNTa1REN3Q0dC9kZEpxSkJFMm5hRlU0UWVK?=
 =?utf-8?B?a3JnQk9SYWNjRHF3bll1RWFOR3EwTUlCZzJzbHE0QXZKbFBGbkZNOUpTeHdZ?=
 =?utf-8?B?ZnJBQVpyTUxuZ0VpTTY2Qy9RN1VtMTc5UU9wTFRaWVhZNTBJSGk1dkEyeE5J?=
 =?utf-8?B?b3pMc1RFb2d1SjBFdlVIRk9uY3YzTkJwdjF2bHZsWUJpRVM2b0J3cW9PWmxE?=
 =?utf-8?B?RlFRY0k4OWF2M0lmZ0kwWlN6Z3ZJbmpZYzJ3NFBsREM5dVdYTUF0OU5HVUNm?=
 =?utf-8?Q?Z6Nu7FacSeBBLk/oYWlHtXE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff3efb2-30de-4e84-3aa2-08d9e9e86da7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 03:17:52.9902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ICJfVr70cl5OZjqMO7hhm+2+XBe9SObMPxcA6v+OGPfPrEra3R1W+idQEw09qqixMBVkda1lobcghd4ibU0wxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8793
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDAvN10gbWFpbGJveDogaW14OiBtaXNjIGZpeCBhbmQgU0VD
TyBNVSBzdXBwb3J0DQo+IA0KPiBPbiBXZWQsIEphbiAyNiwgMjAyMiBhdCAyOjI4IEFNIFBlbmcg
RmFuIDxwZW5nLmZhbkBueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+ID4gU3ViamVjdDogW1BBVENI
IDAvN10gbWFpbGJveDogaW14OiBtaXNjIGZpeCBhbmQgU0VDTyBNVSBzdXBwb3J0DQo+ID4NCj4g
PiBQaW5nLi4NCj4gPg0KPiBUaGlzIGFkZHMgbmV3IGZlYXR1cmVzLCBzbyBpdCB3aWxsIGdvIGlu
IHRoZSBuZXh0IHJlbGVhc2UuDQo+IE1lYW53aGlsZSB5b3UgbWF5IHdhbnQgdG8gZml4IHRoZSBp
c3N1ZSBpbiAzLzcgcmVwb3J0ZWQgYnkgbGtwIHRlc3QgYm90Lg0KDQpKdXN0IHNlbnQgb3V0IFYy
LiBQYXRjaCAzLzcgaXMgZHJvcHBlZCBpbiB2MiBiZWNhdXNlIGl0IGJyZWFrcyBtb2R1bGUgYnVp
bGQgYXMNCnJlcG9ydGVkIGJ5IGxrcCB0ZXN0IGJvdC4gV2lsbCBzdWJtaXQgYSBzZXBhcmF0ZSBw
YXRjaCBmb3IgaXQgbGF0ZXIuDQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+IHRoYW5rcy4NCj4g
DQo+IA0KPiANCj4gDQo+ID4gVGhhbmtzLA0KPiA+IFBlbmcuDQo+ID4NCj4gPiA+DQo+ID4gPiBG
cm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiA+DQo+ID4gPiBUaGlzIHBhdGNo
c2V0IGluY2x1ZGVzIGEgZmV3IGZpeGVzIGZvciBsb3cgcG93ZXIgYW5kIGkuTVg4IFNFQ08gTVUN
Cj4gc3VwcG9ydA0KPiA+ID4NCj4gPiA+IEZyYW5jayBMRU5PUk1BTkQgKDEpOg0KPiA+ID4gICBt
YWlsYm94OiBpbXg6IGFkZCBpLk1YOCBTRUNPIE1VIHN1cHBvcnQNCj4gPiA+DQo+ID4gPiBQZW5n
IEZhbiAoMik6DQo+ID4gPiAgIGR0LWJpbmRpbmdzOiBtYWlsYm94OiBpbXgtbXU6IGFkZCBpLk1Y
OCBTRUNPIE1VIHN1cHBvcnQNCj4gPiA+ICAgbWFpbGJveDogaW14OiBpbnRyb2R1Y2UgcnhkYiBj
YWxsYmFjaw0KPiA+ID4NCj4gPiA+IFJhbmphbmkgVmFpZHlhbmF0aGFuICgyKToNCj4gPiA+ICAg
bWFpbGJveDogaW14OiBBZGQgc3VwcG9ydCBmb3IgaWRlbnRpZnlpbmcgU0NVIHdha2V1cCBzb3Vy
Y2UgZnJvbQ0KPiBzeXNmcw0KPiA+ID4gICBtYWlsYm94OiBpbXg6IGVubGFyZ2UgdGltZW91dCB3
aGlsZSByZWFkaW5nL3dyaXRpbmcgbWVzc2FnZXMgdG8NCj4gU0NGVw0KPiA+ID4NCj4gPiA+IFJv
YmluIEdvbmcgKDIpOg0KPiA+ID4gICBtYWlsYm94OiBpbXg6IGZpeCB3YWtldXAgZmFpbHVyZSBm
cm9tIGZyZWV6ZSBtb2RlDQo+ID4gPiAgIG1haWxib3g6IGlteDogZml4IGNyYXNoIGluIHJlc3Vt
ZSBvbiBpLm14OHVscA0KPiA+ID4NCj4gPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWls
Ym94L2ZzbCxtdS55YW1sICAgfCAgIDEgKw0KPiA+ID4gIGRyaXZlcnMvbWFpbGJveC9pbXgtbWFp
bGJveC5jICAgICAgICAgICAgICAgICB8IDI0OQ0KPiA+ID4gKysrKysrKysrKysrKysrKystDQo+
ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNDMgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkN
Cj4gPiA+DQo+ID4gPiAtLQ0KPiA+ID4gMi4yNS4xDQo+ID4NCg==
