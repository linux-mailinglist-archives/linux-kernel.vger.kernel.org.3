Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA62E5373A4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 04:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbiE3Cu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 22:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiE3CuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 22:50:25 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA46E3E5FC;
        Sun, 29 May 2022 19:50:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7GVg5TZGLuHumdVHcZW8hsf0XSYnXlAvyuepJSZdX+lMA4z/BjtmfV0OUUp4Wwsbeloi4JT5H8JmM3rUtq4YELm30qlixvP4Zgw0M1K9AEKzi0+Ys+3dlb3j/X2gPOeDLTB+He8z/vIW1MBzNI9rO297JGE/e+j/fqUf4tAcNvUuQ6uOlSkxEEodE75JOW+nq/cr5KY6mx8zIr0YfqNEphaY24Q6SRwwZDBoNwpk0HT8+lSQURKhMYBPU4TEOOS8sjA099zM7bQ+8EPQVyYHOoNyCPm/hCmZlGLe02q7aaURHyjJMsDsLt7x6h7ZHuoRnBjM5Moy1/ZD1mJ7dKlsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIjsU6QqiSAmmB17A2Ae4ZpSAMM72na4xheZxv9qtIc=;
 b=ERMyrVyGIp4wMsb7fVGBCSqjSl4EH9E3RHckhJ0z1gEIBJUxNUMJIvYIsJoBvZDhABktxnST6Z79E/dHdP3V/REn8M4rt8Pq7EhI6S041X2B94hFWVZ0bbP+DjquMWYSo+LVi0K3JvLspImEvWHXSWUWmZlXQwVcZS3IutG2zrVvaUgfaLAdo+NTp3Pwn/1szbpsn6ulWuB79lQlQkPw/T3l6BLmTKmVgBvEPR+1icayA3e3r4DGYkUBz/x5f/Pso7DANltLwtQ2nlVyVr0BNKwuIZkApMSv7ajgzYvzuZ7RiYjx6/0GuG+O4uHn18wOnvntETHXzwsmKYoWDTKqvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIjsU6QqiSAmmB17A2Ae4ZpSAMM72na4xheZxv9qtIc=;
 b=HXIN1xbPZjr684QE6c0/xbRlIljISxZH0aJL96mEfLiaXFNdtncPcVC6J5cfkOK6k02oNnW/jnorZgBS4T6S2tptZzEFuwbwrna2zrJ9fo1jYaatASTmRStHIQFB864BZT0YOcHiKmWYK1YqdycgZ3CpuXr/oftjXJDl6xpAFKs=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAXPR04MB9203.eurprd04.prod.outlook.com (2603:10a6:102:222::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23; Mon, 30 May
 2022 02:50:20 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5293.018; Mon, 30 May 2022
 02:50:20 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Fabio Estevam <festevam@gmail.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v2] media: imx-jpeg: Leave a blank space before
 the configuration data
Thread-Topic: [EXT] Re: [PATCH v2] media: imx-jpeg: Leave a blank space before
 the configuration data
Thread-Index: AQHYcbQGiI9X6mRAiUe9cP8s2eccT60ykaiAgAAFGrCAAIUWgIADn/yA
Date:   Mon, 30 May 2022 02:50:20 +0000
Message-ID: <AM6PR04MB6341D7DAF3A7E2B14524FFF3E7DD9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220527102444.19683-1-ming.qian@nxp.com>
         <CAOMZO5D-gUdoTx3hLmZE2EeYfun-g2xLx6J4tNTSZd-yKCLgXA@mail.gmail.com>
         <AM6PR04MB6341CB4019E4F7077D3DCD54E7D89@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <02cbaf49474cbba446b6bdae77d5da950cce3e00.camel@ndufresne.ca>
In-Reply-To: <02cbaf49474cbba446b6bdae77d5da950cce3e00.camel@ndufresne.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67ea70d1-9a8a-4c5f-20e9-08da41e722ab
x-ms-traffictypediagnostic: PAXPR04MB9203:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <PAXPR04MB92037DE5C8219EEF8CD06200E7DD9@PAXPR04MB9203.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PhB3rHivDmLnye3Tw/SNghylAJtIbTMDHAz+5A3vNN4qIixh7KUg9/FYygcNzEjv0aXnobGbSFECmCmqUDfyQgXfQs1pRBIZsfMaUv+rnyZ3WpVw8xnbPJ3vKBeWpTIBfM52f6R2RFIJ4wLEl8MZNGUu+wA8SxRb/ZmhqNzIpADSyUZiovTvE7tuN3nL/6yFCCL+OXYH2RzjTt2bREFI+hmSPzw7LLeSik/PVU2QGrvhu40dZrb+y8bw+C7xeSO2BE9QE3fBGYGBeZsfVP8IhOJm0RCLISnIeCXLEBYE+VZrGV9yd1+epGv2RAJ5sEMDinwi22vXT8q+owqi3NEMGhkUvfOikSs/cGKdPTBhTidcgebDSWG1oDBA97T28okwsGIiZveMyhRfT2C8QIv/ox/Ifh5Pu/CwJexROpP6CKtugP0KAKJ5HAj7CbA35P1aF/BR81mefjk+dBfClA7RX2tJgplaQcxvhanmQgsJpBV3yd1uRHQbNV2eMWXFpkrXw7UbUaQIDlxb1zlaKOW9zQxQgfZoqEtI/giM7dPN0HbbRyxiP7dLpX2Xqw9QRjym6F8QC0Y95Dq37Je4B2+WqnpXoZTvjRCMbTZazt9K3rfgvMLF65xaO19qBPlbMoh/54/yx/2isRGI6S6y1vFLOGXM0ZEYnsIHhlPgtKpAtQ+7cTodCtsUtSRxj8Jv+Fulefgtzth2rXtVMhxKY2Qhfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66574015)(6506007)(26005)(508600001)(53546011)(38100700002)(186003)(54906003)(9686003)(316002)(110136005)(71200400001)(7696005)(122000001)(66446008)(86362001)(55016003)(52536014)(44832011)(66556008)(2906002)(76116006)(4326008)(83380400001)(64756008)(8936002)(33656002)(38070700005)(66946007)(66476007)(5660300002)(7416002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1RGVGJZRlJZQ0ZHTnM2elkrUkJLbFR0Smh3UEk1bFZ4OGdwUHpieTJPbVFW?=
 =?utf-8?B?V0Y4SlF3N0tWcFA4V2pwZGhFZktUZWY1VHV3cXkrU3Nnb21BSEdPRnNGQWM5?=
 =?utf-8?B?d0lqSk85UHJEeDdTeVhXOEw5eENSNUt3TWpHSzZGYjRlL3BoTHRrcU1ld3Nh?=
 =?utf-8?B?SitmMzduSmdMRnErWDVWV0hyLzZ5eGg4MGZFR1FkZ3M1bVg0eUFWQ0syUERs?=
 =?utf-8?B?cXp2Lzg3TVNsK1BDTGM4T1Q1RFFPVXQrVVNqQnY3V2VnYjNGdEZSbEcyLzZ6?=
 =?utf-8?B?K1k5U2o0RDFoK3U4dHpOUUpJcFM4YllGVmZRbyt0R05OejJiR2VQOVVpcjFs?=
 =?utf-8?B?dHVJUWF3SmkxeVJ5dG9FclQvOWUrQUx0NU8vWUZOOEthc0YxWmszbTlXUk1o?=
 =?utf-8?B?RlZPbmNhQzIxZHZNS1Z2ZUFpTTNCWko0SWNTdHVDOFB1Q2h2SU9qeTRMbEp0?=
 =?utf-8?B?eGV6YTRjbGR5T01kQWFXRnZGQVk5aVBIK2hHRVltM2JDaVdpUTFKakhLL1pJ?=
 =?utf-8?B?RzRxTzV3c0h4S1hQdCtQdDIyTVNIbDJGRnJBTVFyU0pKeE5hQkRjRG1BejJC?=
 =?utf-8?B?QkNJNloxYWtBSXA3NHp2TkNvakhRV0VaM1IreUtucWtuQkRKUDNUNTdKR3JY?=
 =?utf-8?B?N1F3OU1TaVJ4VGR4S2FYN2tZQUJtdjRjL0YraVZyQmVraDNOejZ1aHBaUVlD?=
 =?utf-8?B?NUtSaXFocjF2ZGs3SEJOcGFMTW8xWUg4cGVFRWs1ZlRaR0RPY0d5RDdUTU5t?=
 =?utf-8?B?WHowRXJiTURONTVtR0U2UVFXaExZSjdOMUJTMEdlUWNvZVNmRm1SZmM5NHdy?=
 =?utf-8?B?TzdSVWhZd0UzamdhMlRZY3BPZWE5MzRCSy9QcWRFYmlYbFJBdko3RStWK0NB?=
 =?utf-8?B?WW5aWWxDUU1MTWVaQXB4T0RuM0VqUlZxV2Q0b0pIZTA2Y1MzU1IzVmxObUZR?=
 =?utf-8?B?OXBVRTFJa0FTRmFmMER6LytsSzZ1U1p4MUNOOUl1ZllKMENwRWFjQnBBTUU5?=
 =?utf-8?B?YUU5dFB3bGUvSFFYY0pSeDdXYzhHNGNoWElJM0QzR2pyTVhHSHppS091QlZK?=
 =?utf-8?B?ZGJlRFphT1FqeTVJRWhMaTlRN0lOaTlNVnJseFB5RkRiL3ovU244OE5YWTE0?=
 =?utf-8?B?bkRsSkphSmVFTEFUQ3pEaXRQdjRuSURNK0Voc0VBWG9MOEZBQjFTaW9PdWND?=
 =?utf-8?B?akdMbldBSTNjU2V5MnViZk9HNEtNeXd3aEhVWmo2NllMRklVdkdVVWFMKzk5?=
 =?utf-8?B?VHJnYVdUVUtoZ0dmVHVtWmoyZFJGb2ZIT2crTjRIR0N4Z09PR0VZdmF0NVEy?=
 =?utf-8?B?Z3pFOERTaXlYdm5UTXR1bUJjK1QyS3VkM3p2VG0rRWJFalI1QjVqZXJxaVBD?=
 =?utf-8?B?NWtQRmVKUmhrV0w3bFYwSHVjWWk0RUZMcm1zWkpTaXhhTUFqZFZoVS9ka1p3?=
 =?utf-8?B?ck9XUFU2UFhPSU1Kb1ZncmMzQ3prRndlMTBMM3FrT1I0MzRQRWZOaUpaeWhq?=
 =?utf-8?B?T3JoZU1HaGd1dUhaek81Lzh3ZlduM2VNY3l6VWhndXhXcnBjOFBRV2drZWhW?=
 =?utf-8?B?S29CZ2dYclZONnFBSHVFcDJrRTY2Tkg5bThZcUZKOWdVYUg4alFuT1ZmMDVu?=
 =?utf-8?B?NllHS2NjamNYVVhzYkQ1Y2drR1pPY0dwNi9Wc1JaOWUrOGE1UmF1c3RIeTNZ?=
 =?utf-8?B?VlNLSlJaR2ZLVUMvTW9vOGVvU1F6ZllacUFibGhKVVVHak1hdEJVdDFuaGRl?=
 =?utf-8?B?YW0wVGdsV0ZCMitWRTJZUks3bWdoSWtjcGpham1PeHNadlM0c1ZORXIzU3RK?=
 =?utf-8?B?RGdSWGFiTkJUWnY2aWZYL3RRQTZ2ejhtUklIR0ZuYzVENVZsYWxqVElDQjls?=
 =?utf-8?B?eE1kZFBSRml0UGl2RWhhb1phTld2VEI5czFZU0h5NjV1bkh3REgzeFB4Tldy?=
 =?utf-8?B?Z2tjVEpaWU1SVDhmWlJrWExRMXR6eGx4U0xUWTVRak84akN0UjZoQmpqZmp3?=
 =?utf-8?B?UGRYNEhaY3dIdWhZUFdqa3FtUnV0dzV2bWF4SkEvcE52TXBZdG1TOWROY0RG?=
 =?utf-8?B?RldCVHRYampBMWhLaWFIbTBablc1WmRkNnpFRVp2cE14dGMvMVJuSy8yNkpR?=
 =?utf-8?B?SVlMUW9PQXZ3WmJGczFZNU9ScVNUUmpZNXF4NEdudE5mak1paGFvQnZJV1Ju?=
 =?utf-8?B?clV5UTVsNHgvZmk4MXpobG9KZUh3NGNNZkJqM0dwQ24zOFd6T0l0ZUJBNVJK?=
 =?utf-8?B?NHVYSG9xY2JJUE1PUC81d09SeUNGbnpJc2ZRMzlvd3NsTTZ6MHhQSmNralRK?=
 =?utf-8?B?SVhYTmdjbXdMVitZaC9oZ3ZaVHk1bXpjU0FJMkJselp2dmFoZ2gvdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ea70d1-9a8a-4c5f-20e9-08da41e722ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2022 02:50:20.0925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NJwn1xHFvFqyTmXta57veMn+CTElroVS4+9k1/3RFAAwuxPzUrXVPT9/tSo1PePd5ZnxxgZ0dqjM59n1OADozQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9203
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
MjAyMuW5tDXmnIgyOOaXpSAzOjI2DQo+IFRvOiBNaW5nIFFpYW4gPG1pbmcucWlhbkBueHAuY29t
PjsgRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBDYzogTWF1cm8gQ2FydmFs
aG8gQ2hlaGFiIDxtY2hlaGFiQGtlcm5lbC5vcmc+OyBNaXJlbGEgUmFidWxlYSAoT1NTKQ0KPiA8
bWlyZWxhLnJhYnVsZWFAb3NzLm54cC5jb20+OyBIYW5zIFZlcmt1aWwgPGh2ZXJrdWlsLWNpc2Nv
QHhzNGFsbC5ubD47DQo+IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz47IFNhc2NoYSBI
YXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT47DQo+IFNhc2NoYSBIYXVlciA8a2VybmVsQHBl
bmd1dHJvbml4LmRlPjsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+IGxpbnV4
LW1lZGlhIDxsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc+OyBsaW51eC1rZXJuZWwNCj4gPGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBvcGVuIGxpc3Q6T1BFTiBGSVJNV0FSRSBBTkQg
RkxBVFRFTkVEDQo+IERFVklDRSBUUkVFIEJJTkRJTkdTIDxkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZz47IG1vZGVyYXRlZA0KPiBsaXN0OkFSTS9GUkVFU0NBTEUgSU1YIC8gTVhDIEFSTSBBUkNI
SVRFQ1RVUkUNCj4gPGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz4NCj4gU3Vi
amVjdDogUmU6IFtFWFRdIFJlOiBbUEFUQ0ggdjJdIG1lZGlhOiBpbXgtanBlZzogTGVhdmUgYSBi
bGFuayBzcGFjZSBiZWZvcmUNCj4gdGhlIGNvbmZpZ3VyYXRpb24gZGF0YQ0KPiANCj4gQ2F1dGlv
bjogRVhUIEVtYWlsDQo+IA0KPiBMZSB2ZW5kcmVkaSAyNyBtYWkgMjAyMiDDoCAxMTozMyArMDAw
MCwgTWluZyBRaWFuIGEgw6ljcml0IDoNCj4gPiA+IEZyb206IEZhYmlvIEVzdGV2YW0gPGZlc3Rl
dmFtQGdtYWlsLmNvbT4NCj4gPiA+IFNlbnQ6IDIwMjLlubQ15pyIMjfml6UgMTk6MTINCj4gPiA+
IFRvOiBNaW5nIFFpYW4gPG1pbmcucWlhbkBueHAuY29tPg0KPiA+ID4gQ2M6IE1hdXJvIENhcnZh
bGhvIENoZWhhYiA8bWNoZWhhYkBrZXJuZWwub3JnPjsgTWlyZWxhIFJhYnVsZWEgKE9TUykNCj4g
PiA+IDxtaXJlbGEucmFidWxlYUBvc3MubnhwLmNvbT47IEhhbnMgVmVya3VpbA0KPiA+ID4gPGh2
ZXJrdWlsLWNpc2NvQHhzNGFsbC5ubD47IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz47
IFNhc2NoYQ0KPiA+ID4gSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+OyBTYXNjaGEgSGF1
ZXINCj4gPiA+IDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+OyBkbC1saW51eC1pbXggPGxpbnV4LWlt
eEBueHAuY29tPjsNCj4gPiA+IGxpbnV4LW1lZGlhIDxsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5v
cmc+OyBsaW51eC1rZXJuZWwNCj4gPiA+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsg
b3BlbiBsaXN0Ok9QRU4gRklSTVdBUkUgQU5EDQo+ID4gPiBGTEFUVEVORUQgREVWSUNFIFRSRUUg
QklORElOR1MgPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsNCj4gPiA+IG1vZGVyYXRlZCBs
aXN0OkFSTS9GUkVFU0NBTEUgSU1YIC8gTVhDIEFSTSBBUkNISVRFQ1RVUkUNCj4gPiA+IDxsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+DQo+ID4gPiBTdWJqZWN0OiBbRVhUXSBS
ZTogW1BBVENIIHYyXSBtZWRpYTogaW14LWpwZWc6IExlYXZlIGEgYmxhbmsgc3BhY2UNCj4gPiA+
IGJlZm9yZSB0aGUgY29uZmlndXJhdGlvbiBkYXRhDQo+ID4gPg0KPiA+ID4gQ2F1dGlvbjogRVhU
IEVtYWlsDQo+ID4gPg0KPiA+ID4gSGkgTWluZywNCj4gPiA+DQo+ID4gPiBPbiBGcmksIE1heSAy
NywgMjAyMiBhdCA3OjI1IEFNIE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+IHdyb3RlOg0K
PiA+ID4gPg0KPiA+ID4gPiBUaGVyZSBpcyBhIGhhcmR3YXJlIGJ1ZyB0aGF0IGl0IHdpbGwgbG9h
ZCB0aGUgZmlyc3QgMTI4IGJ5dGVzIG9mDQo+ID4gPiA+IGNvbmZpZ3VyYXRpb24gZGF0YSB0d2lj
ZSwgaXQgd2lsbCBsZWQgdG8gc29tZSBjb25maWd1cmUgZXJyb3IuDQo+ID4gPiA+IHNvIHNoaWZ0
IHRoZSBjb25maWd1cmF0aW9uIGRhdGEgMTI4IGJ5dGVzLCBhbmQgbWFrZSB0aGUgZmlyc3QgMTI4
DQo+ID4gPiA+IGJ5dGVzIGFsbCB6ZXJvLCB0aGVuIGhhcmR3YXJlIHdpbGwgbG9hZCB0aGUgMTI4
IHplcm8gdHdpY2UsIGFuZA0KPiA+ID4gPiBpZ25vcmUgdGhlbSBhcyBnYXJiYWdlLg0KPiA+ID4g
PiB0aGVuIHRoZSBjb25maWd1cmF0aW9uIGRhdGEgY2FuIGJlIGxvYWRlZCBjb3JyZWN0bHkNCj4g
PiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTWluZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNv
bT4NCj4gPiA+ID4gUmV2aWV3ZWQtYnk6IE1pcmVsYSBSYWJ1bGVhIDxtaXJlbGEucmFidWxlYUBu
eHAuY29tPg0KPiA+ID4gPiBSZXZpZXdlZC1ieTogVG9tbWFzbyBNZXJjaWFpDQo+ID4gPiA+IDx0
b21tYXNvLm1lcmNpYWlAYW1hcnVsYXNvbHV0aW9ucy5jb20+DQo+ID4gPg0KPiA+ID4gRml4ZXMg
dGFnPw0KPiA+DQo+ID4gSGkgRmFiaW8sDQo+ID4gICAgIEl0J3MgYSBoYXJkd2FyZSBpc3N1ZSwg
c28gSSdtIG5vdCBzdXJlIGlzIGl0IGEgZHJpdmVyIGlzc3VlIHRoYXQgSSBmaXggaXQuDQo+ID4g
ICAgIE9yIEkganVzdCBjaGVjayB3aGljaCBwYXRjaCBpbmNsdWRlcyB0aGUgY29kZSBJIGNoYW5n
ZWQsIGFuZCBhZGQNCj4gPiB0aGUgZml4IHRhZz8NCj4gDQo+IFlvdSBjYW4gdXNlIEZpeGVzIHRh
ZyBldmVuIHRob3VnaCB0aGVyZSB3YXMgbm8gc29mdHdhcmUgYnVnLiBUaGUgcG9pbnQgb2YgdGhl
DQo+IHRhZyBpcyB0byBoZWxwIGxvY2F0ZSBob3cgZmFyIHdlIGNhbiBiYWNrcG9ydCB0aGlzIHBh
dGNoIGluIG9yZGVyIHRvIGxldCBzdGFibGUNCj4ga2VybmVsIHVzZXJzIGJlbmVmaXQuDQo+IA0K
PiByZWdhcmRzLA0KPiBOaWNvbGFzDQo+IA0KDQpIaSBOaWNvbGFzLA0KICAgIFRoYW5rcyBmb3Ig
eW91ciBpbmZvcm1hdGlvbiwgSSdsbCBhZGQgYSBmaXggdGFnIGluIHYzLg0KTWluZy4NCg0KPiA+
DQo+ID4gTWluZw0KDQo=
