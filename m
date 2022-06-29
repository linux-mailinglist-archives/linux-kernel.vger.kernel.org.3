Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D065600ED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbiF2NI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 09:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbiF2NIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:08:53 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20050.outbound.protection.outlook.com [40.107.2.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E606205C7;
        Wed, 29 Jun 2022 06:08:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2GxGy1nEp+rvuC8ab8Z8HM8AL7D68mkg50eVITYiN6qe3o8PO8DRWMqYaHXN9izuQatJXCjfNf/fZOk/iALeTvKc+mG/0/SZ/IGRlAtVI2ksUehE3YcihRYNTdUmcxscctZbg86f8cwHurEk71lTxfAEtebXUul9XGErC4I/9yjAnEykRvm3rks++lXwMbLmuIpzhJR/WbG69LRsN8hVZLgnYGoRSDGebWCHaAfesqBEM7iaQnZfx/VTEu97KgZELs0wXIJib6ajuFP4vgWqW6sGxKpcOmGNqot6wkG9Hp6tMial9YvBOBaoAKo+HSAzPPxudUuwjXqON76lG1cWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rp4B16WVh6GoJ7ROA0Y9b+UF1JghX0HdZBG/Nz90xEI=;
 b=fQsRuKwq7OZ6ErLVyvhB21xlsdDWE/GKQJ7L3maSyoyX1vZCK+KFGR+Dd6o3n0q9GcHKmRgGAg4IKmNyWdbx8kBkcGj1YpZwYeal48vM+l4a7JHxyiE1D+Leq5E/D4g0FzYVCD0BogxlUXFvWWl6Nnkh1fBVM43a6bCTRIQaLrsfRX+hLjtVRNj6lLqW1Uj2gSMduf7v6IrAjWZnyMIwuneD1PI+CioLy46EfFxCR7/esPscdBjES2m+Igc7JXkILZ1m/FeHWrpAPAaBnXkT0RN0di7ILw2ajWncNlw0iRtXQEffLDTNJJAJS1l2iOWarqMXv9RpYMx6shoqj+4zfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rp4B16WVh6GoJ7ROA0Y9b+UF1JghX0HdZBG/Nz90xEI=;
 b=L79e+Afq0UWrCw8NjUNsOvyvuFSdH+xGCSNHxFohRbUR/D2Jvk5vD5mKDvDWmVOpwrG7JetHPGltD3MJJnWMRTrbGtUaEImzCXnm2najwrqyzwOt3cJ5bdOKlk97XjbhtVmQCIWH5tdSTCCzKPROMO0XwYuQ5vdxjyzDhdyLhIk=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB4048.eurprd04.prod.outlook.com (2603:10a6:803:44::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 13:08:08 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b%5]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 13:08:07 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "mchehab@kernel.org" <mchehab@kernel.org>
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
Thread-Index: AQHYiq7J1t29u6ewlE+hUMTTkjT24K1mTPsAgAAKsKCAAAQegIAAATPQ
Date:   Wed, 29 Jun 2022 13:08:07 +0000
Message-ID: <AM6PR04MB634164BB9F5AD2AFD962187DE7BB9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220628052017.26979-1-ming.qian@nxp.com>
 <26a83f6a-05a1-f67b-2de5-bd67ea50843d@xs4all.nl>
 <AM6PR04MB6341531BD31885A7BA3126BBE7BB9@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <7f19f803-4af4-f90d-48d5-63fc0fc780a5@xs4all.nl>
In-Reply-To: <7f19f803-4af4-f90d-48d5-63fc0fc780a5@xs4all.nl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d4072cf-0e47-4cd4-9240-08da59d06932
x-ms-traffictypediagnostic: VI1PR04MB4048:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ywkl0koIP3wvbwR0uSdMTPiJirN64o+4N2XXcjYBBSuKPq0T2sf4X/WLBREBksgFcigWs644vE5USSldWdWcXzoXtaxEfYGZAkp5zdLOUZKmI+BssIrNymVHBTXpConvhTkS0UA2DkcLp9x9HaONxyedzikFk/dbePNR+zdPt5yylND4fi37YNYB8RxSB/Qdcxct0DjSwYowUnhWaLe4rlWtA5OChZyC812Uur7wisMS/MA9bdqxdfx1oEhXry//E+TdombLXkmE8E3n/SiqM3kvNKcuxp+N381sBzUVvU+x/6WH5IUuOj7df22llY5GQ+oihmioTDxH3HzUrl22yBp4T3R+6Sxt5DiGZ49Z4rEaB74A+p8e3gKV4kpdpCwDzkNG1WXTglW8IELnN7H8EVJRL7Jr6C/4DJ1TgDWgsgMPIkua+0ivsKqbkUU9XXj+WqoVEo/xkm3un/roQsZkY0U+fKQ1URs0kAbY+0Ey6ibTW6JEmRwjDzT9GnY7vk/7ggswNbXYMmW5LzS158GtA3RisyNYuZV2jjWRzigy7ujVvu+E+zS3121sd/8R3lt1+ZNcwu5T2Ff9jf0dBTHr5j/DTppVHrnlG0ihqzy7ZyifssePxXmxW6yVhiL5RUvvkSA1NyuFm9ZkvLAeINEj2iHxT6TikXsdX72MsVR8UgVrMOGxhjGWkZJIw8g2CTM8O+3/Ustd4pF3G61K0EXI7MxhjA94FXklfrpzzL4ReDEUQSSyFAP1ffb8lFUYVNbVycnxscbvfeZVMQyxHyzKsgfFcZSfuJ37JAlNS2n3iCBUQf/4AeYQ4k4hMdxmm04XMHriaZdioEPI/zxSn1EQcvds/pmqIIArZ668Tchdt8g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(66446008)(53546011)(6506007)(110136005)(41300700001)(2906002)(38070700005)(55016003)(7696005)(122000001)(64756008)(54906003)(38100700002)(66556008)(66476007)(83380400001)(86362001)(66946007)(316002)(9686003)(8676002)(33656002)(186003)(26005)(7416002)(76116006)(5660300002)(8936002)(44832011)(478600001)(71200400001)(52536014)(4326008)(32563001)(357404004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2hVdVdyQWJ4OHplNGhQL1BYM1F5QStod053Z0hvWUM3V3BSVWxRdWNxaVE2?=
 =?utf-8?B?Z3VOVDVIWHJSbG5aVWZKVzE4ZCtDNVlDdTAxMkk3NEtiOXZyNFFVR2d1RDVS?=
 =?utf-8?B?aXlrTWxnYWtjYlMzY0hxYTNWT0RNSWZjMVIyTkJrQ2hNWXZUeFI5QWhDQmZB?=
 =?utf-8?B?OXZmeHQ2NUE3dFc3bkVvNVBJUDBMMElOMFUvM1llZitpWFlZNjZDZ0FtRnly?=
 =?utf-8?B?ZDZ5bnM4ZmF1UmphWXVnQy9UK2dYN1VtNVp0Y1RXbC9zVll6ZFZqWmhYbVIw?=
 =?utf-8?B?a3JTRDMycFh4bmlOVHp1MEEvUkdkTGZMdnBwUFNaSk52Wk5YdTZ2K09OK1pZ?=
 =?utf-8?B?WHQvTHBQSHRPSHlxUXZUWno1Rm55bGVVRG4rRDJsQVF2VU1JYUFZSzNGd2ds?=
 =?utf-8?B?UUdRajZ3eEd4U2E2YnBucDdrdXd4S3lZMkNTaGNGMUxlaGQvbTg1cUI1bDZS?=
 =?utf-8?B?SWtmTmJhTXA1TW1pV0dBNEFtRzc5SWRrOEpEcTdlclN3TEl1U2FqM0YvY3Bh?=
 =?utf-8?B?M2lxWTdXMFQ0ZmpkcjJyVWlkTjFuY3JEMkxRUWc1Y2lGK0tGcWFac2NlQUFI?=
 =?utf-8?B?Zkl1Q0t5NjNLQkVNMEpjRExSMENIY25tMmRDNnkrc0h0UG9wQVVkR1A2VDM3?=
 =?utf-8?B?WEZmQTlRYkpSUS82Z2JJZmdDVENkWjd0bDhXQ1VSMFFpV1Y4dlh3ZnVHMEJL?=
 =?utf-8?B?QXZGWFduYkdVVnBuaDNTU0ZRM1o4dmJGbWRZUUtvWEpWbVpoRjRiUXBGZjFI?=
 =?utf-8?B?aTdZaDNsV01HVTZWb1RpWGFGWEFURXByM3RjakthM2dDMFM1Z3dsa3I3Q29V?=
 =?utf-8?B?dVpKbmdDeXk0T29OOTRtUHE1R3dwb00zeXV4WEpMT1NOS1paNldwR3NqWngz?=
 =?utf-8?B?b0NlS2twckg5YU9SclFjclV6dUtmalZ6NmRSazNSN1ZHRDRTN0krWk5RdUht?=
 =?utf-8?B?UDNkTFNkVVBJeEJZdkZwRXd3MmZBelBOWFRvRXQ2WWVuTmJLV1hocWNqSGRa?=
 =?utf-8?B?K0lNb3dKdVJqZU9BMTBDVTBBK3laS3NpTCtpc01tWGtqSkRYWTcrWUZ1Y01s?=
 =?utf-8?B?eTNSczRUTGl3RFJBYTNTNmN3K1E5Zk5SaEgyNVo1THNsWUNjTm16RFBOaFR1?=
 =?utf-8?B?YTdOa2ZDZ05oR1VCRDNpL3JqUHhEOXowRDQrRUF1VU9OYTd4QWdtdmlYK1ZN?=
 =?utf-8?B?QWdNMVRENTBIc2N0SUc1UGlKYjg4L1J2MVM5SUpnWFRXTlZpU2tqU2s4Sjdv?=
 =?utf-8?B?TzcvQ1B6K200RTlLMlU2S1N6ZFUxTG1hV0svaXVRcUZrMkl5c2NGVTJYU2w5?=
 =?utf-8?B?aVhobjZBYXJ3WlYzNW5RTzV0bUpSVDg2blN3RjJYZ1h5Z0lUT1plMmFaQzNG?=
 =?utf-8?B?QlpwMXovVytzWlkrbE1lUWhIa2JQRUJhc1lPV2NrTFdoTlc4QlRLY0FqRkNO?=
 =?utf-8?B?eUR6Z3RkR2xqRUQwTXM3VVhiSmlBL2k1RkIvSUVLTGNEbTA0R0VEYlF4WGRW?=
 =?utf-8?B?ZnVrK29XK1Y3cmpMMlVEU3lPZTB1UTFQT3FqdmNkQ3BwUytvZFVkbThuYmNB?=
 =?utf-8?B?SGc0QWdjRzVUb3k4RlVzcEl3dzBHNE9pVkxRVmVyd3Q5ZmkzaDVkclFBRXhj?=
 =?utf-8?B?bG1pY2hZMHh5ZTFCSkJjajBVenI1anAzZjArcno2OS9QYlJ3N3FTOXVaN0Qv?=
 =?utf-8?B?dU0rNFV0czFZRWszQ3E3dnZ1RlAwb2xEUnF2NVV5UFdjZW5jWU5zZkE0ZEFX?=
 =?utf-8?B?M1l3eitlNlRqT2lmS3FHdC9Cd2grdVhrandzU3g1d3hqd0ZkVDljcUw4WEt5?=
 =?utf-8?B?bUx3TURpeFhveWhhSlI4RnFUTTVkK1JsOVB4UjhPQjNZNklsbTdKSk5Qdzcv?=
 =?utf-8?B?SGlpRWpLdWk3NUpYczJRbDdQTFJMbzJpVFBEdkxtODNodTYySkp6NG1yYzYv?=
 =?utf-8?B?aGYrRjQvSWxVZVdwdGF1OC9RbXk2NGxNVlJuUURLT3BGZGVTSzdBYWFZdUNT?=
 =?utf-8?B?RzhRUkZUU3JKdXUxLzQvV005dm1HQ2lYWWY4QjhvVTBTQm5lNHRxUlNlVXRp?=
 =?utf-8?B?bjJvdTJRWVFETld5VkhGQlQ4dnJ2eDhrMTVBb2lsNjVMbmRmTXdRcUZxNjNy?=
 =?utf-8?Q?4U04=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4072cf-0e47-4cd4-9240-08da59d06932
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 13:08:07.8713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U1lh1OyXZNTREAvZC/bcS1+kmUjJi1p23GArtY8BAq0UZedhRH6REkV8FPPvsgE0b9KmP8svVGlBT0ZacPa0Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4048
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBIYW5zIFZlcmt1aWwgPGh2ZXJrdWlsLWNpc2NvQHhzNGFsbC5ubD4NCj4gU2VudDog
V2VkbmVzZGF5LCBKdW5lIDI5LCAyMDIyIDk6MDMgUE0NCj4gVG86IE1pbmcgUWlhbiA8bWluZy5x
aWFuQG54cC5jb20+OyBtY2hlaGFiQGtlcm5lbC5vcmcNCj4gQ2M6IHNoYXduZ3VvQGtlcm5lbC5v
cmc7IHJvYmgrZHRAa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4ga2VybmVs
QHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4LWlteCA8bGludXgt
DQo+IGlteEBueHAuY29tPjsgbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcNCj4gU3ViamVjdDogUmU6IFtFWFRdIFJlOiBbUEFUQ0hdIG1lZGlhOiBhbXBoaW9uOiBvbmx5
IGluc2VydCB0aGUgZmlyc3QNCj4gc2VxdWVuY2Ugc3RhcnRjb2RlIGZvciB2YzFsIGZvcm1hdA0K
PiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBPbiAyOS8wNi8yMDIyIDE0OjUzLCBNaW5n
IFFpYW4gd3JvdGU6DQo+ID4+IEZyb206IEhhbnMgVmVya3VpbCA8aHZlcmt1aWwtY2lzY29AeHM0
YWxsLm5sPg0KPiA+PiBTZW50OiBXZWRuZXNkYXksIEp1bmUgMjksIDIwMjIgODoxMCBQTQ0KPiA+
PiBUbzogTWluZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNvbT47IG1jaGVoYWJAa2VybmVsLm9yZw0K
PiA+PiBDYzogc2hhd25ndW9Aa2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBzLmhh
dWVyQHBlbmd1dHJvbml4LmRlOw0KPiA+PiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFt
QGdtYWlsLmNvbTsgZGwtbGludXgtaW14IDxsaW51eC0NCj4gPj4gaW14QG54cC5jb20+OyBsaW51
eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+PiBTdWJqZWN0OiBb
RVhUXSBSZTogW1BBVENIXSBtZWRpYTogYW1waGlvbjogb25seSBpbnNlcnQgdGhlIGZpcnN0DQo+
ID4+IHNlcXVlbmNlIHN0YXJ0Y29kZSBmb3IgdmMxbCBmb3JtYXQNCj4gPj4NCj4gPj4gQ2F1dGlv
bjogRVhUIEVtYWlsDQo+ID4+DQo+ID4+IE9uIDI4LzA2LzIwMjIgMDc6MjAsIE1pbmcgUWlhbiB3
cm90ZToNCj4gPj4+IEZvciBzb21lIGZvcm1hdHMsIHRoZSBhbXBoaW9uIHZwdSByZXF1aXJlcyBz
dGFydGNvZGUgYmVmb3JlIHNlcXVlbmNlDQo+ID4+PiBhbmQgZnJhbWUsIHN1Y2ggYXMgdmMxLCB2
cDguDQo+ID4+Pg0KPiA+Pj4gQnV0IGZvciBWNEwyX1BJWF9GTVRfVkMxX0FOTkVYX0wsIG9ubHkg
dGhlIGZpcnN0IHNlcXVlbmNlIHN0YXJ0Y29kZQ0KPiA+Pj4gaXMgbmVlZGVkLCB0aGUgZXh0cmEg
c3RhcnRjb2RlIHdpbGwgY2F1c2UgZGVjb2RpbmcgZXJyb3IuDQo+ID4+PiBTbyBhZnRlciBzZWVr
LCB3ZSBkb24ndCBuZWVkIHRvIGluc2VydCB0aGUgc2VxdWVuY2Ugc3RhcnRjb2RlLg0KPiA+Pj4N
Cj4gPj4+IEluIG90aGVyIHdvcmRzLCBmb3IgVjRMMl9QSVhfRk1UX1ZDMV9BTk5FWF9MLCB0aGUg
dnB1IGRvZXNuJ3QNCj4gPj4gc3VwcG9ydA0KPiA+Pj4gZHluYW1pYyByZXNvbHV0aW9uIGNoYW5n
ZS4NCj4gPj4NCj4gPj4gU2hvdWxkbid0IFY0TDJfRk1UX0ZMQUdfRFlOX1JFU09MVVRJT04gYmUg
cmVtb3ZlZCBmcm9tIHRoYXQNCj4gZm9ybWF0DQo+ID4+IHNpbmNlIGl0IGRvZXNuJ3Qgc3VwcG9y
dCB0aGlzIGZlYXR1cmU/DQo+ID4+DQo+ID4+IFJlZ2FyZHMsDQo+ID4+DQo+ID4+ICAgICAgICAg
SGFucw0KPiA+Pg0KPiA+DQo+ID4gSSBoYXZlIGEgcXVlc3Rpb24sIGZvciBmb3JtYXQgVkMxTCwg
IHRoZSBWNEwyX0VWRU5UX1NPVVJDRV9DSEFOR0UNCj4gPiBldmVudCBzdGlsbCBtYXkgYmUgc2Vu
dCBhdCB0aGUgYmVnaW5uaW5nLCBJZiB0aGUgcGFyYW1ldGVycyBwYXJzZWQgZnJvbSB0aGUNCj4g
Zmlyc3Qgc2VxdWVuY2UgaGVhZGVyIGFyZSBkaWZmZXJlbnQgZnJvbSB0aG9zZSBwcmV2aW91c2x5
IGVzdGFibGlzaGVkLg0KPiA+DQo+ID4gU28gc2hvdWxkIEkgcmVtb3ZlIHRoZSBWNEwyX0ZNVF9G
TEFHX0RZTl9SRVNPTFVUSU9OIGZsYWcgb3Igbm90Pw0KPiANCj4gWWVzLiBUaGF0IGZsYWcgb25s
eSBhcHBsaWVzIGlmIHJlc29sdXRpb24gY2hhbmdlcyBjYW4gaGFwcGVuIGFmdGVyIHRoZSBmaXJz
dA0KPiBmcmFtZSB3YXMgZGVjb2RlZC4gSXQgZG9lcyBub3QgYXBwbHkgdG8gdGhlIGluaXRpYWwg
cmVzb2x1dGlvbiBjaGFuZ2Ugd2hpY2gNCj4gaGFwcGVucyBiZWZvcmUgZGVjb2RpbmcgdGhlIGZp
cnN0IGZyYW1lIChpLmUuIGFmdGVyIHJlYWRpbmcgdGhlIGhlYWRlcihzKSBhdA0KPiB0aGUgc3Rh
cnQpLg0KDQpHb3QgaXQsIEknbGwgcmVtb3ZlIGl0IGluIFYyIHBhdGNoDQoNCj4gDQo+IFJlZ2Fy
ZHMsDQo+IA0KPiAgICAgICAgIEhhbnMNCj4gDQo+ID4NCj4gPiBNaW5nDQo+ID4NCj4gPj4+DQo+
ID4+PiBGaXhlczogMTQ1ZTkzNjM4MGVkYiAoIm1lZGlhOiBhbXBoaW9uOiBpbXBsZW1lbnQgbWFs
b25lIGRlY29kZXINCj4gcnBjDQo+ID4+PiBpbnRlcmZhY2UiKQ0KPiA+Pj4gU2lnbmVkLW9mZi1i
eTogTWluZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gIGRyaXZl
cnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92ZGVjLmMgICAgICAgfCAxICsNCj4gPj4+ICBkcml2
ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1LmggICAgICAgIHwgMSArDQo+ID4+PiAgZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV9tYWxvbmUuYyB8IDIgKysNCj4gPj4+ICBk
cml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X3JwYy5oICAgIHwgNyArKysrKystDQo+
ID4+PiAgNCBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92
ZGVjLmMNCj4gPj4+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZkZWMuYw0KPiA+
Pj4gaW5kZXggMDlkNGYyNzk3MGVjLi41MTIxOGE0MWE1YWMgMTAwNjQ0DQo+ID4+PiAtLS0gYS9k
cml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdmRlYy5jDQo+ID4+PiArKysgYi9kcml2ZXJz
L21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdmRlYy5jDQo+ID4+PiBAQCAtNzMxLDYgKzczMSw3IEBA
IHN0YXRpYyB2b2lkIHZkZWNfc3RvcF9kb25lKHN0cnVjdCB2cHVfaW5zdCAqaW5zdCkNCj4gPj4+
ICAgICAgIHZkZWMtPmVvc19yZWNlaXZlZCA9IDA7DQo+ID4+PiAgICAgICB2ZGVjLT5pc19zb3Vy
Y2VfY2hhbmdlZCA9IGZhbHNlOw0KPiA+Pj4gICAgICAgdmRlYy0+c291cmNlX2NoYW5nZSA9IDA7
DQo+ID4+PiArICAgICBpbnN0LT50b3RhbF9pbnB1dF9jb3VudCA9IDA7DQo+ID4+PiAgICAgICB2
cHVfaW5zdF91bmxvY2soaW5zdCk7DQo+ID4+PiAgfQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1LmgNCj4gPj4+IGIvZHJpdmVycy9t
ZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdS5oDQo+ID4+PiBpbmRleCBlNTZiOTZhN2U1ZDMuLmY5
MTRkZTZlZDgxZSAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1w
aGlvbi92cHUuaA0KPiA+Pj4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3Zw
dS5oDQo+ID4+PiBAQCAtMjU4LDYgKzI1OCw3IEBAIHN0cnVjdCB2cHVfaW5zdCB7DQo+ID4+PiAg
ICAgICBzdHJ1Y3QgdnB1X2Zvcm1hdCBjYXBfZm9ybWF0Ow0KPiA+Pj4gICAgICAgdTMyIG1pbl9i
dWZmZXJfY2FwOw0KPiA+Pj4gICAgICAgdTMyIG1pbl9idWZmZXJfb3V0Ow0KPiA+Pj4gKyAgICAg
dTMyIHRvdGFsX2lucHV0X2NvdW50Ow0KPiA+Pj4NCj4gPj4+ICAgICAgIHN0cnVjdCB2NGwyX3Jl
Y3QgY3JvcDsNCj4gPj4+ICAgICAgIHUzMiBjb2xvcnNwYWNlOw0KPiA+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHVfbWFsb25lLmMNCj4gPj4+IGIvZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV9tYWxvbmUuYw0KPiA+Pj4gaW5kZXggYzYy
YjQ5ZTg1MDYwLi5mNGE0ODhiZjk4ODAgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL21lZGlh
L3BsYXRmb3JtL2FtcGhpb24vdnB1X21hbG9uZS5jDQo+ID4+PiArKysgYi9kcml2ZXJzL21lZGlh
L3BsYXRmb3JtL2FtcGhpb24vdnB1X21hbG9uZS5jDQo+ID4+PiBAQCAtMTMxNCw2ICsxMzE0LDgg
QEAgc3RhdGljIGludA0KPiA+PiB2cHVfbWFsb25lX2luc2VydF9zY29kZV92YzFfbF9zZXEoc3Ry
dWN0IG1hbG9uZV9zY29kZV90ICpzY29kZSkNCj4gPj4+ICAgICAgIGludCBzaXplID0gMDsNCj4g
Pj4+ICAgICAgIHU4IHJjdl9zZXFoZHJbTUFMT05FX1ZDMV9SQ1ZfU0VRX0hFQURFUl9MRU5dOw0K
PiA+Pj4NCj4gPj4+ICsgICAgIGlmIChzY29kZS0+aW5zdC0+dG90YWxfaW5wdXRfY291bnQpDQo+
ID4+PiArICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+Pj4gICAgICAgc2NvZGUtPm5lZWRfZGF0
YSA9IDA7DQo+ID4+Pg0KPiA+Pj4gICAgICAgcmV0ID0gdnB1X21hbG9uZV9pbnNlcnRfc2NvZGVf
c2VxKHNjb2RlLA0KPiA+Pj4gTUFMT05FX0NPREVDX0lEX1ZDMV9TSU1QTEUsIHNpemVvZihyY3Zf
c2VxaGRyKSk7IGRpZmYgLS1naXQNCj4gPj4+IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBo
aW9uL3ZwdV9ycGMuaA0KPiA+Pj4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1
X3JwYy5oDQo+ID4+PiBpbmRleCAyNTExOWU1ZTgwN2UuLjdlYjZmMDFlNmFiNSAxMDA2NDQNCj4g
Pj4+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHVfcnBjLmgNCj4gPj4+
ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHVfcnBjLmgNCj4gPj4+IEBA
IC0zMTIsMTEgKzMxMiwxNiBAQCBzdGF0aWMgaW5saW5lIGludCB2cHVfaWZhY2VfaW5wdXRfZnJh
bWUoc3RydWN0DQo+ID4+IHZwdV9pbnN0ICppbnN0LA0KPiA+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmIyX2J1ZmZlciAqdmIpICB7DQo+ID4+PiAgICAg
ICBzdHJ1Y3QgdnB1X2lmYWNlX29wcyAqb3BzID0gdnB1X2NvcmVfZ2V0X2lmYWNlKGluc3QtPmNv
cmUpOw0KPiA+Pj4gKyAgICAgaW50IHJldDsNCj4gPj4+DQo+ID4+PiAgICAgICBpZiAoIW9wcyB8
fCAhb3BzLT5pbnB1dF9mcmFtZSkNCj4gPj4+ICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7
DQo+ID4+Pg0KPiA+Pj4gLSAgICAgcmV0dXJuIG9wcy0+aW5wdXRfZnJhbWUoaW5zdC0+Y29yZS0+
aWZhY2UsIGluc3QsIHZiKTsNCj4gPj4+ICsgICAgIHJldCA9IG9wcy0+aW5wdXRfZnJhbWUoaW5z
dC0+Y29yZS0+aWZhY2UsIGluc3QsIHZiKTsNCj4gPj4+ICsgICAgIGlmIChyZXQgPCAwKQ0KPiA+
Pj4gKyAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+Pj4gKyAgICAgaW5zdC0+dG90YWxfaW5w
dXRfY291bnQrKzsNCj4gPj4+ICsgICAgIHJldHVybiByZXQ7DQo+ID4+PiAgfQ0KPiA+Pj4NCj4g
Pj4+ICBzdGF0aWMgaW5saW5lIGludCB2cHVfaWZhY2VfY29uZmlnX21lbW9yeV9yZXNvdXJjZShz
dHJ1Y3QgdnB1X2luc3QNCj4gPj4+ICppbnN0LA0KPiA+DQoNCg==
