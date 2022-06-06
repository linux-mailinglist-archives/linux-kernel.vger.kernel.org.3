Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F7453DFB9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 04:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352195AbiFFCdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 22:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiFFCds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 22:33:48 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B611122;
        Sun,  5 Jun 2022 19:33:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKr3C5QKNW5doUcnvP0sSdylvMwJRwXhun07p/GptlrGTxQIBxSenxzfv6d9Ychf0TWYdh3jVRBikP56nTEeO1sAhl8w3n3b8uOwCDUnRmFI8C8yL4Oi6O07EgacutguUeieSMdjrVwkOJKCUqVo8zqEaerFyiJ4GT5IXMz4TAiOKZBaJt5oACWZuGUaw5sXrcH249RhNmG3KT9y3IfAbv9qP2xQMYsOrztuWNgAkyWQAop/FJcmdAQvSKynTHh1n2TYl68iixjV7OBhmO1qZxU9uzc9ZJP0i60eFaSG+80gr638CP2Xgz6PktDlBChQKKloahCgrEE9/C2IF6GJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06ZmERcGxuOgxDb5X0niP/I6t/iuJl8xlYfSLfGuM8A=;
 b=P4u8NfW9Vxx3hqKP6dlMWgDdZtVpC7RTF7QCLYZL8bXp0pl+Zuiszlw520K/+hp53d37sifGuTEIx1A4Wj5UnNGAYPWSVIz5GX1lCdzhC7jUovDMTtxscZzUu36BUiScEZRHj4nXQKBW3anIEZNnm5+DLAohphfb7hx88Dxl8wno3McPTppqz6KPV/HO4XgGJktURO1OnzBEZOwLZ05WpfrvNpU6iD1V4tQLwycXkNQjQlde0ycOSuMcDszmQ0SVOGu2dQKGd+UAG3Wcr6IRAteU3tWMGLLsrpnojDrPqu8BIdxBbt2LRQGD8FyRis1xsxRUmf7mBtj4hurrbnWp6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06ZmERcGxuOgxDb5X0niP/I6t/iuJl8xlYfSLfGuM8A=;
 b=PfYUuJg5rGgL0JB2vm8mFZMWZgNJyge3lHcxpqFTkIiiH1Tzqof7fLJeqX7rBylgHRUBcUVWrCOGJkaHJo4IRcokiGZJy/J43YWC1v5lgdQs10bRIsPcanE3kW/eryfzwFWHO3J/bFcz73OHh4yC8pyA4oNSXfzKFVmE0b71Q/0=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR0402MB2736.eurprd04.prod.outlook.com (2603:10a6:800:b1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 02:33:43 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 02:33:43 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
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
Subject: RE: [PATCH v2] media: imx-jpeg: Disable some unused interrupt
Thread-Topic: [PATCH v2] media: imx-jpeg: Disable some unused interrupt
Thread-Index: AQHYc/mclVqKJ6jFKUC3eH0lZl8KFq1BDqAAgACkeoA=
Date:   Mon, 6 Jun 2022 02:33:42 +0000
Message-ID: <AM6PR04MB63411F7904814E87116A5BEAE7A29@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220530074756.14585-1-ming.qian@nxp.com>
 <69817804-a618-32ba-06ca-3ec38ff1f124@oss.nxp.com>
In-Reply-To: <69817804-a618-32ba-06ca-3ec38ff1f124@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac271b69-cfbb-48cc-1a0f-08da4764f943
x-ms-traffictypediagnostic: VI1PR0402MB2736:EE_
x-microsoft-antispam-prvs: <VI1PR0402MB27361F85A4520ED780C16303E7A29@VI1PR0402MB2736.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: agrCVZwxT0A4e5TVYwmzt4orxWbhp8k6N6pnn+HpgQKDZXkq/GGBzo08kL1H2CredPZ94h1c8CEtTYq4dir5zFMx92Il16GipGvylSKkHnLZA05tcpU9Nvd03VWYbE/LFlxpagoKZqeeErb9mVccxd8+o9UxFakKnLlqcOPEHSQysFm/dLvIBDmP7Qy2IbFnnCsyCePqIIj4924Tfd6q0qoMRNXOYHn5KfDV9gHPgda4XgDLCO83Vl63yqApdW0deR5VYUupZLZhdZCnIptG1ligM/FX6D+IewGJtHMvbO8jppQTIuUc12ZztkwjejN63azAodnaUFGBnHUJHnQZEZ0L6fcwexmF1++rqEzoIJ15GnMq1DIdDjFf+FcsCDLTeZ+JzAigZRSohP/xfiQ/Ey0qdCWszEUwa+tUtgtPX9+uYhcFvb8ES2y/e8woa1OfPn/jEW6LW11uHBZQ9/A5Q04SOTJBGdntWbazApnSrsqWXHDxq2/oZYfon3hSknKjjYch14mrnEAOPvRHGwN0ulZo4pLQAIehADCNVg6wytyRCA0MWRxYVrYPbt9pA3qXv3eMnRYVdh8PUOhpLHEl2oM1dcb/JpoYH3sNLlb9M8GIY5ZkdoiWdmG9bvdFnMloa2nV5IZyEuALdPmr1/qhk7NWcaXfFSRoAJCfuy7hlCdsYCKxueG/hAjLV1WzmmpIlqXQHKVqcsHR4eDh81/e8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(8936002)(38100700002)(5660300002)(4326008)(8676002)(76116006)(44832011)(7416002)(66556008)(66476007)(66446008)(64756008)(66946007)(7696005)(122000001)(6506007)(26005)(316002)(110136005)(54906003)(9686003)(33656002)(38070700005)(83380400001)(53546011)(186003)(55016003)(2906002)(52536014)(508600001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M01WRW9GeGhZNTJzVEJ3OFRCK2prQjhZdWM5Q3pPZEp3Y090b0h5N0l0VWFQ?=
 =?utf-8?B?M1RtdzNUVHMwRXdZaXNqRVBqaU53citiSysxY01WWldNUTBvWFBsRlYwOHda?=
 =?utf-8?B?cFBBV2dXc2l6bGJRMHZwaDZCK2VSc0cwbWhIY1FXZmNOWStENDdPS2JVb2Iv?=
 =?utf-8?B?d2hla3JNUGQvU0dvbmdOUzM0V0Z3eDkybUxhd2lzT0JWS2xWK2xaa0w1ZGFu?=
 =?utf-8?B?NE9CNlQyRXJaUHhRTU04NzB4QXFWbktZRFAxQi9sSXE5d1pnd0F0aUFFMGRI?=
 =?utf-8?B?dEk0YzVrUUZ3ekZOWGJRNXpIdnFmQ0F6cW9ucjNFQzloYjJwelBiQ2FDbWFF?=
 =?utf-8?B?SFVpZ3NUVUY4YTU4Zi92NHhjTzhoVFJQTHRMNE43aVU5dzkzdEtTdWtaWG01?=
 =?utf-8?B?bWJMNURaQkpnMnhRT20rTjU2RXN6YXNQN1J4SjcrY09vTFB5cGRBMmpUSG0z?=
 =?utf-8?B?ZlF6U1pyVGZCMXVnLzd2VmhadWVralVOOHVvVUZMd3RWNXhSbDNpNm5HL21R?=
 =?utf-8?B?QmJMait2dThuMnZrdU50elVGMGxabHhiak05TStMOEI2R3IrbGtZZWxQTGlC?=
 =?utf-8?B?UHBGNE1RaFJOZk9iOUVaOE5rV3ByRjRUUW5DbXhOaTdSWDBZYlpoNHIxQ2M5?=
 =?utf-8?B?UUQ1cE93STlGY29wOFNqMHMrdGFtUy9KSUhiejg3WWMzQm00ck52WkxxRFEv?=
 =?utf-8?B?c0EyY0tIdkZTZUFZR0VKYis3MTVJclUvelhJZkZ5dS8wR05FRHZhSlFzYytH?=
 =?utf-8?B?dVlZQ3A4ZGM2QnJ1YUptZHhyWmJYMllKeEdmckQyL21GbmltMXB3R1NHM0NG?=
 =?utf-8?B?L2NFaDNJbnoyRUZrLzZWMktTS1dGT0FFcFl2ZkpEVUJxREU2OEhVYkhlUTVF?=
 =?utf-8?B?RVd2c1BFVEhMUW9PYUpsYmJMaXBFQjUxNVFoa2psUXlJN2ZMM1JMOHBHS2Vi?=
 =?utf-8?B?Y1Q2a0llU1hqNDVZdnlhc3oyR01uUk9CZENzY0Y4ak9Ea3dxZmFWQkhnZ1Ry?=
 =?utf-8?B?QnI5ZjRNOFAyQjdsRnlBMkZqWWtqVCtnL3VLdEJqazdsakZqWTZySmJzRk9J?=
 =?utf-8?B?eFpJVVIvV21NNTNTbHU4bEpDWWN1UHNlOXNUODBXVVF2UlZna0NKUTYyN2ZQ?=
 =?utf-8?B?Ym1HREJ4aDlacVZGRk9kSFlQcWFxSFhYU0RWOTFVRDFKaWY5cEpzendtR1JB?=
 =?utf-8?B?dG1OY0c3c0lJYzFDcU1YMHVKcFpoMUtzUWwvL3dhQ29vcDZ6ZVg1Zml2enJI?=
 =?utf-8?B?T3FGN1JqVllHTXluVE93NWZPWVdKeU9FM0dhUVoyajdvanBWS0dWek02OXo3?=
 =?utf-8?B?Vmc3WU4vTnhjQmh0cXlmbXltbkUwUFVvZVNRYUc1ZTh6MjdFWEpKa0JZazE3?=
 =?utf-8?B?RlBDK0N3VHJ3Wi9MZlFYSW45bitxSWVxRmlTcjBLdmNaV2k3Mm1YWWV3ZCtn?=
 =?utf-8?B?dS9pc0ZOM0R6TkhKb2RQaTQwU09xakQrL0d5SDlNaXFocWZnSnZPL2NpMENt?=
 =?utf-8?B?bXNmRlViWHBieitJck5yMFBDOXZHSTZVQW84cElUUnR5aGthN2EydDNvdlRM?=
 =?utf-8?B?ZWsyWkpEbE9IRlJRVmQrZmFGZDNsYkJvNFphYllOd2FvRDdnQkhvTnkvUUEr?=
 =?utf-8?B?Q3B6aE5TQWYzZ3Bta21pNkoycWlRQ1cyRW4xaWJsRDVvN1UyaW9UbDNrSk5K?=
 =?utf-8?B?U3U1a3BLTUsrVXZURjZabVpUb2RxOVBGTVROM2l1T2pQWXA5WlIyaG5FMVhi?=
 =?utf-8?B?QXRRK2dGVlEyTnRBOWQyTC9vRTNEeTNQOE9ZVzlEUTZzNTdtdnZzdkNzSUc5?=
 =?utf-8?B?M3JYTEwwWTU2VDJWZ01QZGtsaHl1cDRBUkwyNGtBMXJ4V0t4SGhZeEZWdVhv?=
 =?utf-8?B?TWkxOE9WWEVxY1BwWVk0N0xrK1pXRE9jSXN6SWxwczdIN2N6d2krUGFiNFNB?=
 =?utf-8?B?Q2ZYZXY5Wlh5Z3d5MXB6aWR4OFRwamhIYVVWRnJ2UHNuMjZVcitiQ2ZocEwv?=
 =?utf-8?B?akJpTzJrMUxRVkNMaDQyYVdhUDVwYURyKzRSVlpkY3dacUtod0JDMTZiVnhw?=
 =?utf-8?B?UVNBclcvclVuL2RpekN5RitJMXdnT3Awd2RsMGROelJ6TXJlUW8zUlpvY3BV?=
 =?utf-8?B?eHpjT1RKYm5CL252OEE2WWwxS25hSkhrWWtNTHA4anptVTkvRGJ3cTJucGxx?=
 =?utf-8?B?WUtRV2s2VVpWSnJhd1gveU1yRnRwdlk2dVA3bzB4Smx4dmlha25GcmhWeHdj?=
 =?utf-8?B?ZmZWN0IxcjM5SWRma05GeFhvSU1xOFFSZEFjTWltSWhVMXlPMlNlWVY5UVR1?=
 =?utf-8?Q?AHNRSRTrmt+Ohh30AB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac271b69-cfbb-48cc-1a0f-08da4764f943
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2022 02:33:42.9947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JYY2rADFtFtvRqtqkthIkhXd703tPDdbF6i8Oqr38CkRH8/dnQxbru23LbWDk2/LyOFVlW0LMzh6zl7CmkFQuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2736
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBNaXJlbGEgUmFidWxlYSAoT1NTKSA8bWlyZWxhLnJhYnVsZWFAb3NzLm54cC5jb20+
DQo+IFNlbnQ6IDIwMjLlubQ25pyINuaXpSAwOjQzDQo+IFRvOiBNaW5nIFFpYW4gPG1pbmcucWlh
bkBueHAuY29tPjsgbWNoZWhhYkBrZXJuZWwub3JnOw0KPiBodmVya3VpbC1jaXNjb0B4czRhbGwu
bmwNCj4gQ2M6IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtl
cm5lbEBwZW5ndXRyb25peC5kZTsNCj4gZmVzdGV2YW1AZ21haWwuY29tOyBkbC1saW51eC1pbXgg
PGxpbnV4LWlteEBueHAuY29tPjsNCj4gbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjJdIG1lZGlhOiBpbXgtanBlZzogRGlzYWJsZSBzb21lIHVudXNlZCBpbnRlcnJ1cHQNCj4g
DQo+IEhpIE1pbmcsDQo+IA0KPiBPbiAzMC4wNS4yMDIyIDEwOjQ3LCBNaW5nIFFpYW4gd3JvdGU6
DQo+ID4gVGhlIGludGVycnVwdCBTVE1CVUZfSEFMRiBtYXkgYmUgdHJpZ2dlcmVkIGFmdGVyIGZy
YW1lIGRvbmUuDQo+ID4gSXQgbWF5IGxlZCB0byBzeXN0ZW0gaGFuZyBpZiBkcml2ZXIgdHJ5IHRv
IGFjY2VzcyB0aGUgcmVnaXN0ZXIgYWZ0ZXINCj4gPiBwb3dlciBvZmYuDQo+ID4gQW5kIGludGVy
cnVwdCBTVE1CVUZfSEFMRiBhbmQgU1RNQlVGX1JUTkQgaGF2ZSBubyBvdGhlciBlZmZlY3QuDQo+
ID4gU28gZGlzYWJsZSB0aGVtIGFuZCB0aGUgdW51c2VkIGludGVycnVwdHMuDQo+ID4NCj4gPiBG
aXhlczogMmRiMTZjNmVkNzJjZSAoIm1lZGlhOiBpbXgtanBlZzogQWRkIFY0TDIgZHJpdmVyIGZv
ciBpLk1YOCBKUEVHDQo+ID4gRW5jb2Rlci9EZWNvZGVyIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBN
aW5nIFFpYW4gPG1pbmcucWlhbkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+IHYyDQo+ID4gLSBhZGQg
Rml4ZXMgdGFnDQo+ID4gICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL254cC9pbXgtanBlZy9teGMt
anBlZy1ody5jIHwgMiArLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9y
bS9ueHAvaW14LWpwZWcvbXhjLWpwZWctaHcuYw0KPiA+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9y
bS9ueHAvaW14LWpwZWcvbXhjLWpwZWctaHcuYw0KPiA+IGluZGV4IGM0ODIyMjgyNjJhMy4uMjU4
ZmJlZTdhYjY2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbnhwL2lt
eC1qcGVnL214Yy1qcGVnLWh3LmMNCj4gPiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL254
cC9pbXgtanBlZy9teGMtanBlZy1ody5jDQo+ID4gQEAgLTc2LDcgKzc2LDcgQEAgdm9pZCBwcmlu
dF93cmFwcGVyX2luZm8oc3RydWN0IGRldmljZSAqZGV2LCB2b2lkDQo+ID4gX19pb21lbSAqcmVn
KQ0KPiA+DQo+ID4gICB2b2lkIG14Y19qcGVnX2VuYWJsZV9pcnEodm9pZCBfX2lvbWVtICpyZWcs
IGludCBzbG90KQ0KPiA+ICAgew0KPiA+IC0Jd3JpdGVsKDB4RkZGRkZGRkYsIHJlZyArIE1YQ19T
TE9UX09GRlNFVChzbG90LCBTTE9UX0lSUV9FTikpOw0KPiA+ICsJd3JpdGVsKDB4RjBDLCByZWcg
KyBNWENfU0xPVF9PRkZTRVQoc2xvdCwgU0xPVF9JUlFfRU4pKTsNCj4gDQo+IFRoZXJlIGlzIGFu
b3RoZXIgd2F5LCBsZXNzIGFnZ3Jlc3NpdmUsIHRvIGdvIGFyb3VuZCB0aGlzLCBkaXNhYmxlIGFs
bCB0aGUNCj4gaW50ZXJydXB0cyBvbmNlIEZSTURPTkUgaXMgcmVjZWl2ZWQgKG9yIHNvbWUgb3Ro
ZXIgZXJyb3IgY29uZGl0aW9uKSwNCj4gaW50ZXJydXB0cyB3aWxsIGdldCByZS1lbmFibGVkIGF0
IHRoZSBuZXh0IGRldmljZV9ydW4uIEkgY2hlY2tlZCB0aGlzIHdvcmtzLCBpbg0KPiBteGNfanBl
Z19kZWNfaXJxOg0KPiBidWZmZXJzX2RvbmU6DQo+IAl3cml0ZWwoMHgwLCByZWcgKyBNWENfU0xP
VF9PRkZTRVQoc2xvdCwgU0xPVF9JUlFfRU4pKTsNCj4gDQoNCkhpIE1pcmVsYSwNCg0KWWVzLCBJ
IHRoaW5rIGl0IHNob3VsZCB3b3JrIGlmIHdlIGRpc2FibGUgc2xvdCBpbnRlcnJ1cHQgd2hlbiBm
cmFtZSBkb25lLg0KQW5kIHdoaWNoIHNvbHV0aW9uIGRvIHlvdSBwcmVmZXI/DQoNCk1pbmcNCg0K
PiBFaXRoZXIgd2F5LCBJIHdvdWxkIGFsc28gcmVwbGFjZSB0aGlzOg0KPiAJaWYgKCFjdHgpIHsN
Cj4gCQlkZXZfZXJyKGRldiwNCj4gCQkJIkluc3RhbmNlIHJlbGVhc2VkIGJlZm9yZSB0aGUgZW5k
IG9mIHRyYW5zYWN0aW9uLlxuIik7DQo+IAkJLyogc29mdCByZXNldCBvbmx5IHJlc2V0cyBpbnRl
cm5hbCBzdGF0ZSwgbm90IHJlZ2lzdGVycyAqLw0KPiAJCW14Y19qcGVnX3N3X3Jlc2V0KHJlZyk7
DQo+IAkJLyogY2xlYXIgYWxsIGludGVycnVwdHMgKi8NCj4gCQl3cml0ZWwoMHhGRkZGRkZGRiwg
cmVnICsgTVhDX1NMT1RfT0ZGU0VUKHNsb3QsIFNMT1RfU1RBVFVTKSk7DQo+IAkJZ290byBqb2Jf
dW5sb2NrOw0KPiAJfQ0KPiANCj4gV2l0aCBzb21ldGhpbmcgbGlrZToNCj4gQlVHX09OKCFjdHgp
DQo+IA0KPiBUaGUgaW5pdGlhbCBpbnRlbnQgb2YgdGhpcyBjb2RlIHdhcyB0byBjb3BlIHdpdGgg
dGhlIHNhbWUgcHJvYmxlbSwNCj4gU1RNQlVGX0hBTEYgaW50ZXJydXB0IHJlY2VpdmVkIGFmdGVy
IEZSTURPTkUsIHdoaWNoIGNvdWxkIG5vdCBiZSBjbGVhcmVkLA0KPiBidXQgaXQgd2FzIG5vdCBk
b25lIHJpZ2h0LCBJIGNhbiBzZWUgdGhlIGhhbmcgaW4gc29tZSByYXJlIGNhc2VzLiBXZSBzaG91
bGQgbm90DQo+IHJ1biBpbnRvIGl0IGFueW1vcmUsIHdpdGggaW50ZXJydXB0cyBkaXNhYmxlZCwg
ZWl0aGVyIHRoZSB3YXkgeW91IHByb3Bvc2VkLCBvcg0KPiBtaW5lLg0KPiANCj4gUmVnYXJkcywN
Cj4gTWlyZWxhDQo+IA0KPiA+ICAgfQ0KPiA+DQo+ID4gICB2b2lkIG14Y19qcGVnX3N3X3Jlc2V0
KHZvaWQgX19pb21lbSAqcmVnKQ0K
