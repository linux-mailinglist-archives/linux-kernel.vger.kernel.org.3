Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5239D4FE01B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352481AbiDLMIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352907AbiDLMDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:03:44 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7D78233E;
        Tue, 12 Apr 2022 04:01:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEIfaEo7tElhUNqmkjbP0RCUl6n8m050yfOjSLA9Rf6InBZKqmexHy3Rrx43XKeB47Dfl3t7Ix+deEMuMqRtc21RCyaRnOt8V1kQ4lJCh4Sd30Mc9wDGABCwDQTsnkFJ0gBx8pCxn8SewEpL48pIGychNZ6YddR4oz/23Zxde0lFQEKa+p40kPt1F2o17L/2rP8NXiCJi9MiQpujBN1y46LGQXSZ1jy88UQ9KUQuOID93/+JcKw9QqFNvLUqcrcKsDAcgJYMNdwo7OqsRayURasjFhAcBT9UFcQENyHjugsM+pcVcNxpefkXKHqj3FxSAUgphxx5RwLNJEnMjwGPAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEGhE/6c6sFDgeIBXBYv40opXDiWE+w8lKXMJ/GT62o=;
 b=VLvp3THR7TnVwlIgASoGI6lO6TCKnvxlJQWRCEKZ/cWAI3aizJK4g1TpMUqrap7Sy2CcL+q4kMwLEI8FJvy/WeBtZ0IDuikCgfNzKoLtsM3HFzBS2oGMTG5EhgSveZnWXkDQGdmO/Y+IHH+YUmDra1FXtsQegANbTxpMExU6yvWyhytRchL19Z4Avkw844sPsuOs3zW4fZMxGYgbxc3OhLG2YicnBw9QWIKA6DOg70wfu6hcIRIOf/lZmFZdu2yZovf0xu70sdga4KOrgMp9WC2QsgUWxspjMIbBk/mfgSKKXbp3Dd4+jEM49MjgJF2Aa4eMPIUs4PKMqb7SuIngww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEGhE/6c6sFDgeIBXBYv40opXDiWE+w8lKXMJ/GT62o=;
 b=dGZwocpmhw/fyAfa59HY2DEqtqLxt9SaZcrX9zO79UjY4MnDQM6oM4iSw74OV3qd/XhGEkDLBfHoDbBbzqY6V6NA4wtMlFQQzx5cR7d/TvzdOHSEF/YxzKhPP0o+TMat80Q47TPWg16v3BzQxC+xcSDs6oqqr37E9M+7nreOvS4=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB6126.eurprd04.prod.outlook.com (2603:10a6:803:102::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Tue, 12 Apr
 2022 11:01:05 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5%6]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 11:01:04 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH] media: amphion: fix decoder's interlaced filed
Thread-Topic: [EXT] Re: [PATCH] media: amphion: fix decoder's interlaced filed
Thread-Index: AQHYTltfEl8/zbT+PUWsVWgt5yUYtKzsGu0AgAABcCA=
Date:   Tue, 12 Apr 2022 11:01:04 +0000
Message-ID: <AM6PR04MB63413CBBD923BF8F985E9CADE7ED9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220412105156.17091-1-ming.qian@nxp.com>
 <CAOMZO5DWPaSCmc9RivqmCQHu2QaiBs5Kirxjm7WezpnUSKwUag@mail.gmail.com>
In-Reply-To: <CAOMZO5DWPaSCmc9RivqmCQHu2QaiBs5Kirxjm7WezpnUSKwUag@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c21576bf-dc42-4af5-91eb-08da1c73bd52
x-ms-traffictypediagnostic: VI1PR04MB6126:EE_
x-microsoft-antispam-prvs: <VI1PR04MB6126D1B9499F8316624254B8E7ED9@VI1PR04MB6126.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m8qqFoVF1EDH2sz/Sl7NLswA0QADkLwuxs7cWPJl05W4J+fXLFlSkmeAvDJkevI0uDhBuf0ymgOpNuDIKeYKxpR55hB64FtztZkNOQboBYD//2Fm6ae9bnkWxVUSjB0sypWkJ5PxWHNCu/R1tg0DL7nCXW0CFuEt50JkTQXwJgTC6jQcAxEhVskNSqOpRq88f0Zm5jATzk6uysrcfctwepTQJhE0DnynALNhIuw/eSbXALvMxR+gMRZyfNp9857F1SgKvq0CQzFdiw84lLa84KZNhlfkRzwygLDwZZ6bDk0k/KNRrLZP0zY55RHXKSQvDVCAXA8+kA1z3EQHuJ/TRcYMFM15Tve9lLejuXcrQNDNH9w/vRrCZ+zAS22wWglbl1zkkfhA7bTm/DhRdXuzHwrluBeIk3a+h8WEIzQuUUS+ps5vP5HpwP2cysov8PNTuhPldG9q7sZCYXOj4mCTXRZ4Urovrmg5BOjAyruSYvC5ICWyKmv/Dxjos7tnu4+DhQgmZKP56iEFi8158/GO5lsYR+bWszhAXT67aTLbVba+i3sS6Lz9Ap6lQwq8+5FvxwgYbdyRk9+hsk+P3tlNxiTOH0wuHRGEWtzmMoABxQycTTWcn30vBzreiGlU48jeUNUary68p6ECgVXBBqniVIYIP5bO3Heykv09rLiBqsgP2Er/UOeF8lVipOQvecI0yTxrAxdzTXOJQK+XAeeqWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(83380400001)(44832011)(6916009)(316002)(2906002)(186003)(7416002)(508600001)(26005)(38100700002)(6506007)(64756008)(7696005)(9686003)(4744005)(76116006)(8676002)(5660300002)(86362001)(66556008)(52536014)(66946007)(66446008)(4326008)(66476007)(71200400001)(55016003)(122000001)(38070700005)(33656002)(53546011)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WS9JT1oxMFFzKzZ4d200Z29ZNVNHYTRFYzhQSXVmMngyMEhzcEltK1ZxRFJi?=
 =?utf-8?B?UTJMdGt5T2tPdFVnWUdnSkY4cXlnWTk1ZEhaa3p6VDkzTnd1d1ZhQnRETnkw?=
 =?utf-8?B?QnVVVlovRjlrUUFQNE4rSFVXcEdPeHF4TXpNRXhHUzFnVkJ6c1FTWVlNNTJR?=
 =?utf-8?B?bzZKQU1WMEUzU1poaXQrZGlEOVViOE9naGcrVEI1ckhvTGdsYmxqb1ZYcW1O?=
 =?utf-8?B?OG1jTDBtYTQ2Qmx6N0hHUFdWSVA2dERkOTAyVlgrQi9udjZhOEZhMDhnQjgr?=
 =?utf-8?B?ZWZZU29ublVKNlNTTWUxbmc5eGM5TnBEUGpHdEdGaU5wQnZMbUFEK0htbWpE?=
 =?utf-8?B?bmh2dkU3QXdCQUxWNzB6QzkwUElYZCsyZjg4aEtoc0swL0RQd21TS1UxS0JQ?=
 =?utf-8?B?ZDZabTQ5NFBQWHMxYVhSalRUMTlMaXIybm44RnVwZ2lkVHpZbDNQdHVneUlW?=
 =?utf-8?B?Uk5mbjhxdlVxY3NJZCtPVmQvN0hnZHBBU2hFak8zbHM1cWI1TnlVakluT0Vs?=
 =?utf-8?B?ektpenBhNWxWZllZZGRITWI1Y1RubHR3TDJEMlRHNlYzQy9SSVRYSmYwVEdC?=
 =?utf-8?B?TVNJOGx0aHZJeFkyc0l4TjBXNkN6RjR0clo2R1lGVEZ6UGNTZURIRkxRTGhG?=
 =?utf-8?B?bDRFcjV4ejUzaUQ2N1MvaU9GUXEvV0wzYU96QTJiTmRRcmtxV0doNE9mSGZI?=
 =?utf-8?B?cTNqN2JldUkrQmpnTmp5dDlzVk55U0ZaelduSzFhL09vUTU1bVBoZlpzM253?=
 =?utf-8?B?TEwwamxXN2JJNGkvUzRWQmNvTGEzMWZBdHoyMWljTjlSVVdoeDdzbWhCajM4?=
 =?utf-8?B?SlFWaHpBOExkV1FRejVrbjJyRnc5UWtWOC9QZUlMM1cvWG0rQ2dFQVJibjBW?=
 =?utf-8?B?R3U2cjFkK3htV3FET1JFRXphV09PTkl2cFhRRTRjUWVZMGxMakxQY3FlcEg3?=
 =?utf-8?B?ZVI4RW1iZDg0NmxJbTFERk5RTmRXd3hGckJ3VlIrQnBxZlA3NnZidkJ4bjl5?=
 =?utf-8?B?aU9tWDgrM2JWY1N4TlBLU1FsYURDNzdtRWJGS3VGOTF6RzlBTFBiZmo1dmZu?=
 =?utf-8?B?dnNJdmM1UjAxTngxWXUwMHJ2dERyeXVjUTZsU014UDFqVXBqREEwWHR1NDRz?=
 =?utf-8?B?dlhSeWJ3cjRCclRIYngxdW8vNWFWTWp6TDdUZTNSeFQxTndNMFVWbjFOTEor?=
 =?utf-8?B?SGZ1UUZiZkZydHpNcndXVkhUZGhOOExoZ3VZYmRCYzh3NjVBc2dSTHZvR0Vl?=
 =?utf-8?B?NUNiR1VXVWRkTlVkSEJ4V0t3dU9kRE9oM3BiV0Jvamk0c21EdG5WdkZNdUZj?=
 =?utf-8?B?OHRWU003V2RyWGx1UWJGb0RNdG56YmNqUmRrNGxjYncrNXo4bmd2Y3ZPOEFZ?=
 =?utf-8?B?YUNqQzk2cjlCdjhMRXI3S0dDWlhFSzhSdTZ1MDJneE9yUHVzWVBwRDg3ZGRy?=
 =?utf-8?B?QTNNRVlmSUZTLzBKKzJYZ25STnpZdGF1MHRTNmF5eHVwV3pnUVhMc1hDVlo3?=
 =?utf-8?B?dmpNeG1neTlSMW01YkYvRzh0em43a3N6dWxBTjFsUFRQaHFpSlVTRmJVckcx?=
 =?utf-8?B?ZEgwNERtMzB6Nkx2TEpxSy9mQTNmUk9iVWRVbGxxaU1KaEl6UXBsRkdtdHp2?=
 =?utf-8?B?VitENWpQVDlsWjc1OFV0Yy9vc3J5eDVoL0VJSG9LM0FVY25Qd1I0MnNsUm5k?=
 =?utf-8?B?ZFdQYmpYejE4UTJtaWVhTFpzQXE1TXBPSGx5emRtUytGOWJWQUE1OUZQZW8z?=
 =?utf-8?B?ZmFnZHUvQlZObEtaTzZaMnlDN09PRGR6YXdZU2k1VW9LeWFwZnl3ZlR5YTZZ?=
 =?utf-8?B?czFRUGlqNC9aRnRnczgxamIwYmpHUFgvQkhQbkNuNzYrR1F6N28rVytBby9p?=
 =?utf-8?B?eU1UUWtmbGZaaHFJb3pqbGgzVEhIUWw5R1FPcFN2ZTBzN3F2dHpZL3Bta1FY?=
 =?utf-8?B?SmxBTVNNNWxlaEwydnRyMXJtUHIyeEFCU3h0NUxQUzdIWm5lWFl2dmJJRFNn?=
 =?utf-8?B?OW00Nm9WKzJoaDAxSlZRT2J6OWZqLyt4TWdMVHBBSk9KUktRazVPSGE3NTJ1?=
 =?utf-8?B?Y0ZEM0lEMG51Mzltb2ZERzJtbjIvdi9nVnZpSEdqSGhqZ3ljODNORzVDZHRP?=
 =?utf-8?B?aGxzY0dMRE10N0FpMSt2UkdqSDZaRU1PSkpZc2JoRGpMWXJFeWlKOHJMOWlF?=
 =?utf-8?B?SlVqS2V3QXhyK2VqVHZ4d051R0FzNkZTUjBhZFF0eVNPczRIcmlGQUVJR3Bi?=
 =?utf-8?B?WE1BMTd4SHo3SEhpLzdEalh1Rk55amFWTFpVanBnL0F0TzRialJoWTlGQUpE?=
 =?utf-8?B?UTdSMlVNRy94WmlZNzZ0RVZxcGx1ZXZkUXVFaWlOekVhdzZRcWNpdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c21576bf-dc42-4af5-91eb-08da1c73bd52
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 11:01:04.8374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ntNP9DIX0lL7zPcDb59wdz22XXqLDqh/XahXwSwpRACbuy+xA47HziYvzdlJ8mqhn8wnXNnYgQuIDLT6bEzbKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6126
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmFiaW8sDQoNCiAgICBUaGFuayB5b3UgZm9yIHlvdXIgcmVtaW5kZXINCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGYWJpbyBFc3RldmFtIFttYWlsdG86ZmVzdGV2
YW1AZ21haWwuY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBBcHJpbCAxMiwgMjAyMiA2OjU1IFBNDQo+
IFRvOiBNaW5nIFFpYW4gPG1pbmcucWlhbkBueHAuY29tPg0KPiBDYzogTWF1cm8gQ2FydmFsaG8g
Q2hlaGFiIDxtY2hlaGFiQGtlcm5lbC5vcmc+OyBTaGF3biBHdW8NCj4gPHNoYXduZ3VvQGtlcm5l
bC5vcmc+OyBIYW5zIFZlcmt1aWwgPGh2ZXJrdWlsLWNpc2NvQHhzNGFsbC5ubD47IFJvYiBIZXJy
aW5nDQo+IDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0
cm9uaXguZGU+OyBTYXNjaGENCj4gSGF1ZXIgPGtlcm5lbEBwZW5ndXRyb25peC5kZT47IGRsLWxp
bnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBBaXNoZW5nDQo+IERvbmcgPGFpc2hlbmcuZG9u
Z0BueHAuY29tPjsgbGludXgtbWVkaWEgPGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZz47DQo+
IGxpbnV4LWtlcm5lbCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IG1vZGVyYXRlZCBs
aXN0OkFSTS9GUkVFU0NBTEUNCj4gSU1YIC8gTVhDIEFSTSBBUkNISVRFQ1RVUkUgPGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz4NCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRD
SF0gbWVkaWE6IGFtcGhpb246IGZpeCBkZWNvZGVyJ3MgaW50ZXJsYWNlZCBmaWxlZA0KPiANCj4g
Q2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBIaSBNaW5nLA0KPiANCj4gSW4gU3ViamVjdDogcy9m
aWxlZC9maWVsZA0KPiANCj4gT24gVHVlLCBBcHIgMTIsIDIwMjIgYXQgNzo1MiBBTSBNaW5nIFFp
YW4gPG1pbmcucWlhbkBueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZvciBpbnRlcmxhY2VkIGZy
YW1lLCB0aGUgYW1waGlvbiB2cHUgd2lsbCBzdG9yZSB0aGUgdHdvIGZpbGVkcw0KPiA+IHNlcXVl
bnRpYWwgaW50byBvbmUgYnVmZmVyLCB0b3AtYm90dG9tIG9yZGVyDQo+IA0KPiBzL2ZpbGVkcy9m
aWVsZHMNCj4gDQo+ID4gc28gdGhlIGZpbGVkIHNob3VsZCBiZSBzZXQgdG8gVjRMMl9GSUVMRF9T
RVFfVEIuDQo+IA0KPiBzL2ZpbGVkL2ZpZWxkDQo+IA0KPiA+IGZpeCB0aGUgcHJldmlvdXMgYnVn
IHRoYXQgc2V0dGluZyBpdCB0byBWNEwyX0ZJRUxEX1NFUV9CVCB3cm9uZ2x5Lg0KPiANCj4gcy9z
ZXR0aW5nL3NldA0KPiANCj4gRG8geW91IG5lZWQgdG8gcGFzcyBhIEZpeGVzIHRhZyB0b28/DQo=
