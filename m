Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70E95003D5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 03:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbiDNByr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 21:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239305AbiDNByo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 21:54:44 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70088.outbound.protection.outlook.com [40.107.7.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BC7222AD;
        Wed, 13 Apr 2022 18:52:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3jwqWLfkqhHIMnGITgCHI1seA8n//wN2BxKVhG826Vs3vtQk+ZeE9fV6FI+HQxYus0BlF72IlrJTMkXv+b9EdqK54xp+F3vpZp86aB5ujCm+VKYOlRGW9JGoVOd3cNCEpCLCbPCrnucFyaCTO2XqHHlhAprlpfy3Fodjz6FUtRCSRZQVxvEwvauymiD4rz2m5dC7oTVlsyIHXt4cDSpZmdfWi6R2nMt88kNBgDt9CiDPSnNzOJnKkd8QyB/f+QRhVKLxx2a0E/Sx57Tkv0sTB8pujwIELTrRypSGXFclN+FAiv+94ed9acIuVlgPWHS2gAXPkn1kf8dQvKglzJ66g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMddZRZnF9FLI9/DaZPBZLzxKhjHLDsU9V8AroAZMZM=;
 b=E/qAs8PSZCvNynm4y+U9+I8jHr6s7WCWdJyZy04l33xKFnMWNG1nRalsnQnkeqx3jNuDgKHONFEHdwYZg+d/i2kw4Hby3JZnGXc7jG040iKfWb9186Cu80/z10wEaS6jATkpby3rtyakFYACATenInbFaaizvE0cQegPqt1XaDfAvzHFFFoK42QZ+norR+MLdVBwjaqU8xzAlRO9I/uHIrr8YqS4Umhi5LK/svPcUoVH2w6vFLY0kswhIrppE0Nf5060nXF/avRbJoSnOkMZqbwXbX/WuupNtPlONk/E+5fO7QclXI4Q2BZkHeOkiOOVOVazM4M5NKe6PIWF0vkHWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMddZRZnF9FLI9/DaZPBZLzxKhjHLDsU9V8AroAZMZM=;
 b=QPkWiSerI5gRQR2k1ZZjt9AP2IsZ++JW/LRuqS6TAzSoeDbChT+/FlhGdLXXcQVasURSTiGVNM33gctbxO3YnszVwHHp1bdzcpUYDJ8tKJUDkAXXwJcM5tpcUQczEDWms8rxdttwb7+Us9RCqUPk8KxJuOhu6lY0Oah2OGzBUUc=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB4125.eurprd04.prod.outlook.com (2603:10a6:803:46::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 01:52:18 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5%6]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 01:52:18 +0000
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
Subject: RE: [EXT] Re: [PATCH v2] media: amphion: fix decoder's interlaced
 field
Thread-Topic: [EXT] Re: [PATCH v2] media: amphion: fix decoder's interlaced
 field
Thread-Index: AQHYTlzDTk+nMPblHEOtVFBEaJlTL6zuLgwAgAB5d7A=
Date:   Thu, 14 Apr 2022 01:52:18 +0000
Message-ID: <AM6PR04MB6341E52AF70FD61EC96DB58AE7EF9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220412110155.21427-1-ming.qian@nxp.com>
 <CAOMZO5DmvVJuBU-PzrJ+ru1C3sJPtHshmtxmcAZPTu-p56SAKg@mail.gmail.com>
In-Reply-To: <CAOMZO5DmvVJuBU-PzrJ+ru1C3sJPtHshmtxmcAZPTu-p56SAKg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 230125d4-2f46-4d15-a7c0-08da1db96846
x-ms-traffictypediagnostic: VI1PR04MB4125:EE_
x-microsoft-antispam-prvs: <VI1PR04MB4125B14D94DB7FAC9801154EE7EF9@VI1PR04MB4125.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qdk8KXqjgepppHQcGYw2VRoRzgdMnxKyLL2rGx3NiNBH6GgSgJIN2AiOvcAKVlNOABPNjNyAOrGT0FJYnxHiL//ZWuZrMS7HwVM63De2uB7VqT+j5Qxv80TqBEWKvUW3GRJtaypxUP1w1VRjGTIOHZzujptcM6lwyJUTMoBGIyKAcCj5YCceY5hKZXIhOk04kAX/N0Annne40mWDa/BStN+cNzKTH1XZQvhg42lmLCccqjc21dLDCJDB0KIZUsSM/62anAheta2bwEcwML+Bu7f0z/Csc1YqCnKBwi7lRYVZfDJY4FW8wAsPRhvCb1YL6iDpMsfrUM276vFat34lym9PL5vRt/aAirklOy9kPE6LMOlqCkl117eTVQlRPUuts0UGRFeIPELclqTkRxqTKzoHJsM8jnArJHLCLL7R4gxoxSKqDbYNYvZbyfs2PlhaYR3mkB6rluGPYnIWP1JcFz0c4sc5bVWGvsAHsAb7/DIfUeRY502W7uotdRCG8W5yENLoLtE2n7gbUXg65I4Zxsy8C5pdE0h4wEGeiN2brNPjbofaTp5DEcGz9g+FStwF+QEQZXsRLQjHKdlS2CJfaPfA8y/IBcuQtgji9WCsXYBlN8egB/s+HPb2HmHT63siwcgleqwDqgm3EBOcbkYTU5IVKWUMKM2gcsGSKXkawYA7X4mXlWS2dVbVmq8r+RSo8eL3WhHZFPIhM/1HY3axTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(6916009)(186003)(83380400001)(44832011)(54906003)(55016003)(316002)(38070700005)(122000001)(38100700002)(86362001)(66476007)(8676002)(64756008)(71200400001)(9686003)(76116006)(66946007)(66556008)(66446008)(4326008)(53546011)(2906002)(7696005)(6506007)(5660300002)(7416002)(4744005)(52536014)(8936002)(33656002)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFE2OWJ0OTdCdGd2azZxVjd2enFPdVUyZWpGNlNjN3dVWTUxRkt2N1NlV1Aw?=
 =?utf-8?B?UmcyUG44Ly9BdG44VndqM1dwZVg2M1ZQN0F2eWNYaC9uL0Nub2JwVXkyNFNq?=
 =?utf-8?B?TDBtdDR2QW5SU0pTNDB1bDF0Vys2S0x6cWUvamlsWENDQytWZXRpaUlydjFQ?=
 =?utf-8?B?dXF3Tm01ZVRQZmhnaG1aTzBrNmlscTV6SVkzTjIzV1lMd2dBZUtPdFAyUGc3?=
 =?utf-8?B?SFp4Z1gxNENmOFhJNmdUSzBTR0hmN0Vwd2Nla0hZa25Oei9Pb3ZHQkd3R0tL?=
 =?utf-8?B?UEVPZjhLays5blVCbGM0UmV0RGs1TnBKQ3dVcEN5dForUTI2VzFadVlWYkd1?=
 =?utf-8?B?MGtnVnpkdE9MSTFwUXA1QzdBdTZjQzF5ZWMwYlRjL1hOQk1pVWhVMmJwQ0ZV?=
 =?utf-8?B?UUtvUUFxcWZSamg5TXNPR0tLWXIrZFFBcVUvU1ptTmpVaWs0dTQ1bmh3Y1Zh?=
 =?utf-8?B?SmJBWjFXNzZmc01NRW1EU2R5Y2doUlZGczhDc3VkTWx6VHJvNEliMWdZaDk3?=
 =?utf-8?B?ZjE1SUZydmFHSTNSWldUU01lTXQ4OWJid3VYaUlOaE53SWlLWEhEUzU2NUE0?=
 =?utf-8?B?azFxTTRoZndqanFwVlA1K0dqOXlUNDBQdjBXcmpXL1hMLzRuMmFmMWxyS2lr?=
 =?utf-8?B?QzdSbE4zKzNMWGxGL1hVV080TnlXUUpJWUFjazR1WENuNGtkZVlqODg0S1By?=
 =?utf-8?B?a1Q0eGdmZHJwNGVYUUo4VEZwZU85bDVBM2hEeG9zOEQwdnNpL2JOdU9PY0xE?=
 =?utf-8?B?N21maW9ubGxHWjljR0ZvT2NFZXY0ZGZYczZ2bHZYc2hZTC9MaGZST1VZNUpY?=
 =?utf-8?B?Q3Z3LzJ2eDdNU3FtOVJ3ZmNzRG5KUk13Rk91N05wZS9zcTE4aGpCQ3BCelV5?=
 =?utf-8?B?MDdrVFRhSUNienB4c2hqOE1hS3NnMWJoaDZsN2pqTkk0RlhSNGtQLzZncUFX?=
 =?utf-8?B?MGZmQnVSSnhOVGt5MCszR0RwaUljc1JzeWZ5RnBEV3NGdldEdUk2QnZYMENr?=
 =?utf-8?B?bjMvYlUvbVRZS2QrTVlYaUJ0TjRQS0xDc1RDRjdoQldpc2k3N0NnM3pIY3VX?=
 =?utf-8?B?akFSTGxQdlFOVFJtMHo5UUZWRFA4YkxoQWVSVm1sSjc3UjhMeVErZnhNOFBQ?=
 =?utf-8?B?SFV1cUlQME1UbDRPNVZuTGdIR0lNM2V4VjBIeUFvcHc1NDRXcjAza0JoRlhX?=
 =?utf-8?B?RXo5SGkyYnN2WWF0dlFyVGdDSnA1eTgrNlJ1d29QMHpNZFA1UXpLL0kyMWVW?=
 =?utf-8?B?VjMyK2ZSZUVsVEN3SkVERHFEaGdDYkJSVCtwY0pmTm1pbUFMOWlOOTU0NmNR?=
 =?utf-8?B?dFRKYktEY3FOb0VHbitCUTlVUC80T0VGUzl0RUNtZVZ3MWc1SlVqMk94cDF3?=
 =?utf-8?B?bUNhaWpJYlFLaE5NbGNSaS9VRHBnTGY3bTk2ZU5IM3BncS80L0M5QUZpWVlQ?=
 =?utf-8?B?NElVODZUbXk5UkVQRDRZR0ZJWDFJeDFlY3BlRGtNbExYMmlZWUJjekFpWGZE?=
 =?utf-8?B?MlM4K213bk1wY3ZPT2lQTUVpTGNkYkFxa1lwdnc5RHNNeThER1hWVXQ2Mkdz?=
 =?utf-8?B?K0RlOXh0Z3d5d3VhTTlHZVJsUTI5RndRcnhocDN1akxhb1d1djhPRGp5TzlX?=
 =?utf-8?B?UUw2dmNERXE5a3pyZXdFa1hTN0hZMktpdS9NNWhPQWpyZ0UxQ2FEdW9aMCtH?=
 =?utf-8?B?aVh2OVlKWXRZVWoyK0M5WDhTVnZNMmNCMFJEOVRJLzZTdVlKQ3hNODBnK2pz?=
 =?utf-8?B?UE9SQ0dlNTZyMVNJbjJneThHVjdhZnRhSENOOTdLR09VNEhXSXZ5UWd0SkJI?=
 =?utf-8?B?VE1qOENJdENBMzNVMCtsSjRvVkRFVXY4QU9iT0JOSmlBdHN6Q1FWbVRXd0Vt?=
 =?utf-8?B?bnRqS2ROSDk3djFsUHRJRjRuMXJIMWpOUmR3MkYwUVZ5ZkNFVzJZWFBFVXlR?=
 =?utf-8?B?UGVObVdnRWRTL21Udi9HaGticVJqQmsrV0tZUmJyQUwvZVoxUTZBeFZoWml6?=
 =?utf-8?B?MGVTU3Roc0dadFcreGhCS3lBQk03YXZsOFBMRmZ5ZzAzcmNBZDVrZEg5UWhz?=
 =?utf-8?B?K1Y1T0RSeThhSlgvejluUGxVb1dTTXlOYXFiZ1d6U2I3T1JOdUVLejg0VWtM?=
 =?utf-8?B?Mzhzcm5oUzVEUkV0RVBLaXBtTU5zcTE3Nk04QXAzQ0tydzdqR2l3Z0gvNGZ5?=
 =?utf-8?B?TS9wRjJTY3FJQTh6aTIzWFVFZjVOY29wODVEUmJsbThZVDlVUlJqSVhtSnpl?=
 =?utf-8?B?dlpKZzhCNEZNNHIveGRRRzA5MzM0VUlTZVVTNjh5WkhCYjRUNS9IWUY5eDFS?=
 =?utf-8?B?UHRSb2tub1plNC9DZHJITXpjcS9tSjhmVzhqdFZHZFVWTkFwUklFQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 230125d4-2f46-4d15-a7c0-08da1db96846
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 01:52:18.0869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nF2fyQWfIkAgkIZnKmCC49ADOINJaPi3bV4X51ajU414jVXZYpBVdWf2DwLzdi84YaM7hMrnojtYoj/dNMcBQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBGYWJpbyBFc3RldmFtIFttYWlsdG86ZmVzdGV2YW1AZ21haWwuY29tXQ0KPiBTZW50
OiBUaHVyc2RheSwgQXByaWwgMTQsIDIwMjIgMjozNiBBTQ0KPiBUbzogTWluZyBRaWFuIDxtaW5n
LnFpYW5AbnhwLmNvbT4NCj4gQ2M6IE1hdXJvIENhcnZhbGhvIENoZWhhYiA8bWNoZWhhYkBrZXJu
ZWwub3JnPjsgU2hhd24gR3VvDQo+IDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgSGFucyBWZXJrdWls
IDxodmVya3VpbC1jaXNjb0B4czRhbGwubmw+OyBSb2IgSGVycmluZw0KPiA8cm9iaCtkdEBrZXJu
ZWwub3JnPjsgU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPjsgU2FzY2hhDQo+
IEhhdWVyIDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBu
eHAuY29tPjsgQWlzaGVuZw0KPiBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47IGxpbnV4LW1l
ZGlhIDxsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc+Ow0KPiBsaW51eC1rZXJuZWwgPGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBtb2RlcmF0ZWQgbGlzdDpBUk0vRlJFRVNDQUxFDQo+
IElNWCAvIE1YQyBBUk0gQVJDSElURUNUVVJFIDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc+DQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggdjJdIG1lZGlhOiBhbXBoaW9u
OiBmaXggZGVjb2RlcidzIGludGVybGFjZWQgZmllbGQNCj4gDQo+IENhdXRpb246IEVYVCBFbWFp
bA0KPiANCj4gSGkgTWluZywNCj4gDQo+IE9uIFR1ZSwgQXByIDEyLCAyMDIyIGF0IDg6MDIgQU0g
TWluZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGb3IgaW50ZXJs
YWNlZCBmcmFtZSwgdGhlIGFtcGhpb24gdnB1IHdpbGwgc3RvcmUgdGhlIHR3byBmaWVsZHMNCj4g
PiBzZXF1ZW50aWFsIGludG8gb25lIGJ1ZmZlciwgdG9wLWJvdHRvbSBvcmRlciBzbyB0aGUgZmll
bGQgc2hvdWxkIGJlDQo+ID4gc2V0IHRvIFY0TDJfRklFTERfU0VRX1RCLg0KPiA+IGZpeCB0aGUg
cHJldmlvdXMgYnVnIHRoYXQgc2V0IGl0IHRvIFY0TDJfRklFTERfU0VRX0JUIHdyb25nbHkuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaW5nIFFpYW4gPG1pbmcucWlhbkBueHAuY29tPg0KPiAN
Cj4gTWlzc2luZyBGaXhlcyB0YWc/DQpIaSBGYWJpbywNCiAgICBJJ20gc29ycnkgSSBtaXNzZWQg
aXQsIGFuZCB3b3VsZCB5b3UgcGxlYXNlIGdpdmUgYW4gZXhhbXBsZSBvZiB0aGUgZml4ZXMgdGFn
Pw0KTWluZw0K
