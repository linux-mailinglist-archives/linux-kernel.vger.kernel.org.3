Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F9E547D4C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 03:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbiFMBRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 21:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiFMBRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 21:17:13 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10050.outbound.protection.outlook.com [40.107.1.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CFC252A4;
        Sun, 12 Jun 2022 18:17:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUQoc+j4HyRuwi18rbpcJ2d8wp8vfboYj93fMW62sbnY7qKQrxZ1Fqy4pVD3kr/oW6HYdI/qSR6eRFIgSz7tVQjrF7B54NQHoa6teM+YccdnsfUlhp1QnEFzXTpqfuz/GRsc26lQ5cz5qW9Tdq0OBgH7cyPgTTiYM8GAXyIBD42Odx7w92+y1eyxMt1WC6jSKA8jXzzTYe+vJH70w7zBM9x/mO4inUO//pWzGsF9KFNMPeAakehsRu2hwvNQ9YUn0xkhyvMcjDkjDnJ6NTofOA/SGvDob2pwBzNs0CKN+2pFwS2MIGoPfwK6cKdtw590+cahMQCLTmZy6QPqguno2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gBJCvnvla0pw9xL8Auuey534OnUHkSWNu6Ji1vtcgw=;
 b=ZLqWeJ0wqxb5+SoPHrDnEyIuqoh6RLxy9nLZ86cfEsNnuWmSf5F70CyFwtZiclNtIkqoOjZr/PvjzMdJdrIddnQkzB6ZojeBUeRk1EVeIopMfRm+SGDWEP8874Gkvx2+nRsBklxWxO+i9Wb3eon4oxtEC73fna2LBBbOquc6sYn5UBV7ZdEcej61vdE5SFBAzNQ4FKeYDcgALr5Ti3Z/sMGIh2D7zJY2/jTO2aentkeQQyepyzraCC6f4+pHTkbMHXbEsZ0rRM6LA7C82LdrTpmf6ARNPuvhfsBk8f4bA+h3IPHDsNTE/h9+YjCuOE7Lt+KKzYq1nGEngL/7GO/GGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gBJCvnvla0pw9xL8Auuey534OnUHkSWNu6Ji1vtcgw=;
 b=sOp0lMei6NlMOI21TmegJYmPbP+Lq+QiQqHXIo3Rp+x7NB0zOpP9bmSoo+NURejIvSYfVmpD+IA2jwzB2qQIPyV0QhUQiPMyMjRG21W7dFSqUARyYGZg2tHYNPCYz3M7PyEiIKQgTmvfrfIqbt5VomxXpXK16iXN+eXrYLURzgI=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8346.eurprd04.prod.outlook.com (2603:10a6:10:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Mon, 13 Jun
 2022 01:17:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%8]) with mapi id 15.20.5332.015; Mon, 13 Jun 2022
 01:17:09 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "djakov@kernel.org" <djakov@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>, Abel Vesa <abel.vesa@nxp.com>,
        "abailon@baylibre.com" <abailon@baylibre.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "marex@denx.de" <marex@denx.de>,
        "paul.elder@ideasonboard.com" <paul.elder@ideasonboard.com>,
        "Markus.Niebel@ew.tq-group.com" <Markus.Niebel@ew.tq-group.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 4/8] soc: imx: add icc paths for i.MX8MP media blk ctrl
Thread-Topic: [PATCH 4/8] soc: imx: add icc paths for i.MX8MP media blk ctrl
Thread-Index: AQHYdZwqPuj5ainDSECqAReSIBF/xa0/zXKAgAzKGfA=
Date:   Mon, 13 Jun 2022 01:17:08 +0000
Message-ID: <DU0PR04MB9417E9BF876A4F64579C935D88AB9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220601094537.3390127-1-peng.fan@oss.nxp.com>
 <20220601094537.3390127-5-peng.fan@oss.nxp.com>
 <YpvSWTZk5kb8d0Bn@pendragon.ideasonboard.com>
In-Reply-To: <YpvSWTZk5kb8d0Bn@pendragon.ideasonboard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9c76876-0a60-4c00-73c7-08da4cda6fec
x-ms-traffictypediagnostic: DB9PR04MB8346:EE_
x-microsoft-antispam-prvs: <DB9PR04MB83460B40CA050EFDEFA7E51B88AB9@DB9PR04MB8346.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CSnl9pu0oxfwmK7ljXZAAAQz1Sc4HmNboPhLg6svz7hM8zfdjLar7dbkqNBHyQI1Z5654Q9oILjuG19NOx0kQGWZV60m9GUwmJLIt11fHEP+nx6DOlzlOOUooubvrLq6pF8NShTZnh6180aZkoBMH5Uh1NimY95nv7ghKaLKyIT/PAQ0aSoEeAnCZz4IQKD6ooTdTiTkjNITAwQUmOHBvssX/cWVn924vzqgnixkO2xPXcvxa81pDVWS+8PvXpAbVinzTTSFDlJYvVGnOT0KIAVklfUszwTmaPR6WhvjhV1xjaqBoQaqkUIK9pYvkMGYhHWyr4CsI3PKOShXvaqVmPI/9RpS69LHZqZXY8sXix594n++oOy23N4ENjmzxaijv+PENM8oKvFbBJg+QZ7+3qRO2GMw8BQiOv7fDKHyhiYaTFku10Pr1HM3ccr+a/u/Qktr30iL5OQ7iL66BPMtm6Ne9rGPlT8R92+BWJHGtY76AsgBZwxguiEpBvv3h8y2mSZAAhmDL947VHGnjk8OYV2I2L9KaRxqHOOL+nqRKKUWB7Dz7LDannSz1oHTkulFLXE3NXTsu/1dq+FEurQyWutoZVckD/uGAFFjoMwQ+IxKsaYilsjrFTGsWclvfv5QmOMOfd8Z0b9otEM86QzqDslKb9gGZS9cTSd4cn8ShP0kpqejDkVazk6UuxMfJEw0INO0IkOR0XSN6Vzllo3Yjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(38070700005)(71200400001)(122000001)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(508600001)(76116006)(86362001)(4326008)(54906003)(110136005)(316002)(38100700002)(186003)(6506007)(7696005)(26005)(83380400001)(9686003)(44832011)(52536014)(5660300002)(33656002)(2906002)(7416002)(55016003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1MrWUo1Y1JTc3ZEZ0s2ek5UNFN4bVBoN0x5endtMVppUHd1VUs2Y0ttajBU?=
 =?utf-8?B?SHRtWU0zbU1sN3VVVEQ5QytZei9Gck1sdzdGUzU0ZnZKRFpJR2dUSWRJOFFs?=
 =?utf-8?B?R1pOQzArZFM3VWtjSVBrdGtuZjN3RnNYTXJBdXZNS1hYSTdmSnRYMmdDczgz?=
 =?utf-8?B?bzhkQWw5L0x5cUFVc0V3WkxPV1oxa1dyYXljbng5SUR4ZUk1QW04RGd4bkk4?=
 =?utf-8?B?bFhQa01yRjlFNTdtU2tMc01GODVvMjVZYmFkTmxLYkE5aDZhU3NUZlJ3ZWZ5?=
 =?utf-8?B?TXB3dGxOT3dyN3NLdXlUWDZmU2Y3RjdnWGdDN0M5c2ZiZjhkMEVhSG9KcTcr?=
 =?utf-8?B?Q0V6c1NqaXYxVzBsNW9RZEFic3NmSlNHMUQ5eWFJOHRkeU00S3pXMnQ0UE1j?=
 =?utf-8?B?S2s5REo3ZTZrTHNXNzVtOVloajZLZ1dvY0MyZCtVTm9wOEw4UlVGb1NtWUxJ?=
 =?utf-8?B?SDAyc3p5eFVqTHk0d0hUL3pVTFUvekljbzZjUXlxNjJJRkk0U09oSERtdXMx?=
 =?utf-8?B?UVE4OThRZ1B4VWExSjMzZmdFUU05MEF1WUozY2E5ODFMdm5TNmI0b0g0Zjl5?=
 =?utf-8?B?ZHFYNzFjamhNc2E5N1ExVFpCN1ZNUHh1REV4eTRMclFIQnpVRUhQa0Y0bGta?=
 =?utf-8?B?WHA2bkM5SUFtTW1FYzIrRGdNSktuaUFUWkNHSVlhSTFNTzhDcXQ4Y1lmbFQ2?=
 =?utf-8?B?VzZGRDdHeS9hVTB0d1BheUFuc2FZNGx5czIvbWNRdzAvVmdLUmtSSysydFV5?=
 =?utf-8?B?bjNsa0dFQUVwOEFLd3NVbnhUMGIzNzJSUUE3RGpoZWg2RVFUN2MycUdkM2Fu?=
 =?utf-8?B?eTlPb1N2bExPY0puQVhndzZSWlNqNEdydzZKMllMTUpJejNwa3poaGR0Zjdn?=
 =?utf-8?B?UkpTSEF1VkE4bll3UGRRamNIclMwU1JwbWd4c3NRZXBJUSthdzliL3hMRkVH?=
 =?utf-8?B?V2NyRTVoWkFXMmNXTTN3ejduQ2xvRVljVGJiZXI4b0xlYWJGcGVndXcweVQ2?=
 =?utf-8?B?dTcvdlF3RXlqZ0IzQnltYUx3T210MXpWVFp3bXQ0cVBHOXg4Q2JCVXlPMmEx?=
 =?utf-8?B?RUtmZWY1UUdJWDBPNFZHWWNtY0pURDhlWVErc3lYQndDNGRBdzJmdDN2OXlE?=
 =?utf-8?B?UThlN1c2V3FNZlhhL01RdzBTM0F1LzlndE5takpBdEJRbzhRVjlBQVh2aGFD?=
 =?utf-8?B?WjRhVHJQK0phRGxlRW43cTBkMXIzc2svNktTVjV0cXlRaEVBdC9UNEFneUFR?=
 =?utf-8?B?ZTZnN1U0TmxUeXRiYnZlR1NMeFRjYS95VGVlN2RBUGVyT0ZnNzQ0ZVllWmhH?=
 =?utf-8?B?dnpMWmdkYW9LaEJld2lCVzE1Qm8yQnB3Y3VqN0w0V1hlLzg5V0hSMW14N3RJ?=
 =?utf-8?B?Q1ZEaG5xR0pmYTNYNzk3OGp5dEZIV2M5Sm5ybEk4b0M5RDJiRjloVmtTZ0ZY?=
 =?utf-8?B?ZWFBOG9IV3dEN0R1eTlicWtOYnhsd1RVYWRTR1ltbERrbkxSVHpPOFhNbW15?=
 =?utf-8?B?QUJYQ1YyU1lTa1RCQkZ4QWNNM0hLazM3VVlRaFdqeTYyZGxJSVZFSXdnNEFh?=
 =?utf-8?B?UzBtYWUvTjNmWmZOUExXUW1FdzJYTDVtMmNObnJNSCtxdUpJbVJmQ1ZTTVVX?=
 =?utf-8?B?NGpUdEJIb0ZLSTV2K3Vyc1VveXJzSHpJU0dzcG8rWEsxSWdjK1BXYXNhbnpI?=
 =?utf-8?B?MGNDbTcxWE9KaGw2RFprTTVtbnVpdDU4eHFtKzNhSEZHNmNFWkpuVmtKa2F1?=
 =?utf-8?B?NGNtUldPbmxIMCtuTksrai9nQWg0N243ajh3RTMxZ2t3d3BkMzRJeGlIYSs4?=
 =?utf-8?B?VWN0SHhLSXQwVTZidFJ2emo1R29iSUpMeWZiQTR2RWxMUDhYZ1FWZ1VYcmhR?=
 =?utf-8?B?RmRDU24yVHcyc2MzK1NzM2NPQXBRN0pIQmNHY3UwNmpEendMamREazZqcVR5?=
 =?utf-8?B?ZHRES25lWlpYSWR0VmJVL25MaEVXWENtS05uV2NJWitDTnpEdk5KakpaL2Rh?=
 =?utf-8?B?ajNjZHZreXp6SWhJYmxPQVBmU3pSVUM2czc0dWVKczNjaW85eGdxVmtzaHZB?=
 =?utf-8?B?QTRXVldQTlhxcnMwemVaZ090eEQ5VUg5cEJTcytyemVRbUtVTEZYMWhxdWsr?=
 =?utf-8?B?dzhsRDhjOTZnczJ1Wm4xNnFxcWJWSkZCU2kzNThyT3FMT2J3Tm01YTN4dnB2?=
 =?utf-8?B?WlFURGtVL2haVWVSQ3V2RldVSktydWczUjAvcW5Vc3liQm1GMUlESVZGeXVD?=
 =?utf-8?B?QjFDNGFWQzdWcit0cXpzaW1iVlRCUGZBd3Fzc3dyWlFiT0tMTFU1WTJxOEM1?=
 =?utf-8?Q?ITUZRN45TdYLREPIQn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c76876-0a60-4c00-73c7-08da4cda6fec
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 01:17:09.0070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qu2cxdrHPTMev39lfQ1Iu1bLFAHVFqMoBFEbZUQ0uqnmP616djfZgbmL5xlWhlf9BtHs2xTi25WFikbBDhNDTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8346
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDQvOF0gc29jOiBpbXg6IGFkZCBpY2MgcGF0aHMgZm9yIGku
TVg4TVAgbWVkaWEgYmxrIGN0cmwNCj4gDQo+IEhpIFBlbmcsDQo+IA0KPiBUaGFuayB5b3UgZm9y
IHRoZSBwYXRjaC4NCj4gDQo+IE9uIFdlZCwgSnVuIDAxLCAyMDIyIGF0IDA1OjQ1OjMzUE0gKzA4
MDAsIFBlbmcgRmFuIChPU1MpIHdyb3RlOg0KPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBu
eHAuY29tPg0KPiA+DQo+ID4gQWRkIGludGVyY29ubmVjdCBwYXRocyBmb3IgaS5NWDhNUCBtZWRp
YSBibGsgY3RybA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54
cC5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDht
cC5kdHNpIHwgIDEgKw0KPiA+ICBkcml2ZXJzL3NvYy9pbXgvaW14OG0tYmxrLWN0cmwuYyAgICAg
ICAgICB8IDMxDQo+ICsrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdl
ZCwgMzIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhtcC5kdHNpDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4bXAuZHRzaQ0KPiA+IGluZGV4IGQ5NTQyZGZmZjgzZi4uMmExYzZmZjM3ZTAz
IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC5k
dHNpDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLmR0c2kN
Cj4gPiBAQCAtNCw2ICs0LDcgQEANCj4gPiAgICovDQo+ID4NCj4gPiAgI2luY2x1ZGUgPGR0LWJp
bmRpbmdzL2Nsb2NrL2lteDhtcC1jbG9jay5oPg0KPiA+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3Mv
aW50ZXJjb25uZWN0L2ZzbCxpbXg4bXAuaD4NCj4gPiAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3Bv
d2VyL2lteDhtcC1wb3dlci5oPg0KPiA+ICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvZ3Bpby9ncGlv
Lmg+DQo+ID4gICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnB1dC9pbnB1dC5oPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3NvYy9pbXgvaW14OG0tYmxrLWN0cmwuYw0KPiA+IGIvZHJpdmVycy9z
b2MvaW14L2lteDhtLWJsay1jdHJsLmMNCj4gPiBpbmRleCA3ZjQ5Mzg1ZWQyZjguLjQyM2NhYzBj
OWNiNiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3NvYy9pbXgvaW14OG0tYmxrLWN0cmwuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvc29jL2lteC9pbXg4bS1ibGstY3RybC5jDQo+ID4gQEAgLTUsNiAr
NSw3IEBADQo+ID4gICAqLw0KPiA+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4NCj4g
PiArI2luY2x1ZGUgPGxpbnV4L2ludGVyY29ubmVjdC5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgv
bW9kdWxlLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCj4gPiAgI2luY2x1
ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiA+IEBAIC0zNyw2ICszOCw4IEBAIHN0cnVj
dCBpbXg4bV9ibGtfY3RybF9kb21haW5fZGF0YSB7DQo+ID4gIAljb25zdCBjaGFyICpuYW1lOw0K
PiA+ICAJY29uc3QgY2hhciAqIGNvbnN0ICpjbGtfbmFtZXM7DQo+ID4gIAlpbnQgbnVtX2Nsa3M7
DQo+ID4gKwljb25zdCBjaGFyICogY29uc3QgKnBhdGhfbmFtZXM7DQo+ID4gKwlpbnQgbnVtX3Bh
dGhzOw0KPiA+ICAJY29uc3QgY2hhciAqZ3BjX25hbWU7DQo+ID4gIAl1MzIgcnN0X21hc2s7DQo+
ID4gIAl1MzIgY2xrX21hc2s7DQo+ID4gQEAgLTUyLDExICs1NSwxMyBAQCBzdHJ1Y3QgaW14OG1f
YmxrX2N0cmxfZG9tYWluX2RhdGEgeyAgfTsNCj4gPg0KPiA+ICAjZGVmaW5lIERPTUFJTl9NQVhf
Q0xLUyA0DQo+ID4gKyNkZWZpbmUgRE9NQUlOX01BWF9QQVRIUyA0DQo+ID4NCj4gPiAgc3RydWN0
IGlteDhtX2Jsa19jdHJsX2RvbWFpbiB7DQo+ID4gIAlzdHJ1Y3QgZ2VuZXJpY19wbV9kb21haW4g
Z2VucGQ7DQo+ID4gIAljb25zdCBzdHJ1Y3QgaW14OG1fYmxrX2N0cmxfZG9tYWluX2RhdGEgKmRh
dGE7DQo+ID4gIAlzdHJ1Y3QgY2xrX2J1bGtfZGF0YSBjbGtzW0RPTUFJTl9NQVhfQ0xLU107DQo+
ID4gKwlzdHJ1Y3QgaWNjX2J1bGtfZGF0YSBwYXRoc1tET01BSU5fTUFYX1BBVEhTXTsNCj4gPiAg
CXN0cnVjdCBkZXZpY2UgKnBvd2VyX2RldjsNCj4gPiAgCXN0cnVjdCBpbXg4bV9ibGtfY3RybCAq
YmM7DQo+ID4gIH07DQo+ID4gQEAgLTExNyw2ICsxMjIsMTAgQEAgc3RhdGljIGludCBpbXg4bV9i
bGtfY3RybF9wb3dlcl9vbihzdHJ1Y3QNCj4gZ2VuZXJpY19wbV9kb21haW4gKmdlbnBkKQ0KPiA+
ICAJaWYgKGRhdGEtPm1pcGlfcGh5X3JzdF9tYXNrKQ0KPiA+ICAJCXJlZ21hcF9zZXRfYml0cyhi
Yy0+cmVnbWFwLCBCTEtfTUlQSV9SRVNFVF9ESVYsDQo+ID4gZGF0YS0+bWlwaV9waHlfcnN0X21h
c2spOw0KPiA+DQo+ID4gKwlyZXQgPSBpY2NfYnVsa19zZXRfYncoZGF0YS0+bnVtX3BhdGhzLCBk
b21haW4tPnBhdGhzKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJZGV2X2VycihiYy0+ZGV2LCAi
ZmFpbGVkIHRvIHNldCBpY2MgYndcbiIpOw0KPiANCj4gRG9uJ3Qgd2UgbmVlZCB0byAicmVsZWFz
ZSIgdGhlIGJhbmR3aWR0aCBvbiBwb3dlciBvZmYgPw0KDQpJbiB0aGUgTlhQIEFURiwgdGhlIE5v
QyBzZXR0aW5ncyBhcmUgb25seSBjb25maWd1cmVkIGR1cmluZyBwb3dlciBvbi4NClNvIEkganVz
dCBmb2xsb3cgQVRGIGltcGxlbWVudGF0aW9uLg0KDQpQZXIgSUMgZGVzaWduIHRlYW0sIFNXIG9u
bHkgZ2V0IGEgdmFsdWUgd2hlbiBwb3dlciB1cC4gU28gSSB3b3VsZA0Kbm90IGRpdmVyZ2UgaGVy
ZS4NCg0KSWYgYmFuZHdpZHRoIGluIE5vQyByZWdpc3RlcnMgYXJlIHRha2VuIGludG8gY29udHJv
bCwgcmVsZWFzZSBpcyBuZWVkZWQuDQoNCj4gDQo+ID4gKw0KPiA+ICAJLyogZGlzYWJsZSB1cHN0
cmVhbSBjbG9ja3MgKi8NCj4gPiAgCWNsa19idWxrX2Rpc2FibGVfdW5wcmVwYXJlKGRhdGEtPm51
bV9jbGtzLCBkb21haW4tPmNsa3MpOw0KPiA+DQo+ID4gQEAgLTIyOCw2ICsyMzcsMTggQEAgc3Rh
dGljIGludCBpbXg4bV9ibGtfY3RybF9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KPiA+ICAJCWZvciAoaiA9IDA7IGogPCBkYXRhLT5udW1fY2xrczsgaisrKQ0KPiA+ICAJ
CQlkb21haW4tPmNsa3Nbal0uaWQgPSBkYXRhLT5jbGtfbmFtZXNbal07DQo+ID4NCj4gPiArCQlm
b3IgKGogPSAwOyBqIDwgZGF0YS0+bnVtX3BhdGhzOyBqKyspIHsNCj4gPiArCQkJZG9tYWluLT5w
YXRoc1tqXS5uYW1lID0gZGF0YS0+cGF0aF9uYW1lc1tqXTsNCj4gPiArCQkJZG9tYWluLT5wYXRo
c1tqXS5hdmdfYncgPSBJTlRfTUFYOw0KPiA+ICsJCQlkb21haW4tPnBhdGhzW2pdLnBlYWtfYncg
PSBJTlRfTUFYOw0KPiANCj4gVGhhdCdzIGhhcnNoIDotKSBJIHN1cHBvc2UgaXQncyBnb29kIGVu
b3VnaCB0byBzdGFydCB3aXRoLCBidXQgSSB3b25kZXIgaWYgd2UnbGwNCj4gbmVlZCBtb3JlIGNv
bnRyb2wgbGF0ZXIuDQoNClRoZSBjdXJyZW50IHNldHRpbmdzIGFyZSBvbmx5IGZvciBwcmlvcml0
eSwgZXh0X2NvbnRyb2wsIG1vZGUgc2V0dGluZ3MuIEFjdHVhbGx5DQpiYW5kd2lkdGggc2V0dGlu
Z3MgYXJlIG5vdCBwcm92aWRlZC4gVGhlIHZhbHVlIGhlcmUgaXMganVzdCB0byBtYWtlDQppY2Nf
YnVsa19zZXRfYncgY291bGQgY29uZmlndXJlIEhXLg0KDQpZZXMsIHRoZSB2YWx1ZXMgYXJlIG5v
dCB2ZXJ5IGdvb2QsIHdlIGNvdWxkIHN0ZXAgYnkgc3RlcCB0byBtb3ZlIG9uDQp0byBtYWtlIGJl
dHRlci4NCg0KPiANCj4gPiArCQl9DQo+ID4gKw0KPiA+ICsJCXJldCA9IGRldm1fb2ZfaWNjX2J1
bGtfZ2V0KGRldiwgZGF0YS0+bnVtX3BhdGhzLCBkb21haW4tPnBhdGhzKTsNCj4gPiArCQlpZiAo
cmV0KSB7DQo+ID4gKwkJCWRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJmYWlsZWQgdG8gZ2V0IG5v
YyBlbnRyaWVzXG4iKTsNCj4gPiArCQkJZ290byBjbGVhbnVwX3BkczsNCj4gPiArCQl9DQo+ID4g
Kw0KPiA+ICAJCXJldCA9IGRldm1fY2xrX2J1bGtfZ2V0KGRldiwgZGF0YS0+bnVtX2Nsa3MsIGRv
bWFpbi0+Y2xrcyk7DQo+ID4gIAkJaWYgKHJldCkgew0KPiA+ICAJCQlkZXZfZXJyX3Byb2JlKGRl
diwgcmV0LCAiZmFpbGVkIHRvIGdldCBjbG9ja1xuIik7IEBAIC02NDcsNg0KPiArNjY4LDgNCj4g
PiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlteDhtX2Jsa19jdHJsX2RvbWFpbl9kYXRhDQo+IGlt
eDhtcF9tZWRpYV9ibGtfY3RsX2RvbWFpbl9kYXRhWw0KPiA+ICAJCS5ncGNfbmFtZSA9ICJsY2Rp
ZjEiLA0KPiA+ICAJCS5yc3RfbWFzayA9IEJJVCg0KSB8IEJJVCg1KSB8IEJJVCgyMyksDQo+ID4g
IAkJLmNsa19tYXNrID0gQklUKDQpIHwgQklUKDUpIHwgQklUKDIzKSwNCj4gPiArCQkucGF0aF9u
YW1lcyA9IChjb25zdCBjaGFyICpbXSl7ImxjZGlmLXJkIiwgImxjZGlmLXdyIn0sDQo+ID4gKwkJ
Lm51bV9wYXRocyA9IDIsDQo+ID4gIAl9LA0KPiA+ICAJW0lNWDhNUF9NRURJQUJMS19QRF9JU0ld
ID0gew0KPiA+ICAJCS5uYW1lID0gIm1lZGlhYmxrLWlzaSIsDQo+ID4gQEAgLTY1NSw2ICs2Nzgs
OCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlteDhtX2Jsa19jdHJsX2RvbWFpbl9kYXRhDQo+IGlt
eDhtcF9tZWRpYV9ibGtfY3RsX2RvbWFpbl9kYXRhWw0KPiA+ICAJCS5ncGNfbmFtZSA9ICJpc2ki
LA0KPiA+ICAJCS5yc3RfbWFzayA9IEJJVCg2KSB8IEJJVCg3KSwNCj4gPiAgCQkuY2xrX21hc2sg
PSBCSVQoNikgfCBCSVQoNyksDQo+ID4gKwkJLnBhdGhfbmFtZXMgPSAoY29uc3QgY2hhciAqW10p
eyJpc2kwIiwgImlzaTEiLCAiaXNpMiJ9LA0KPiA+ICsJCS5udW1fcGF0aHMgPSAzLA0KPiA+ICAJ
fSwNCj4gPiAgCVtJTVg4TVBfTUVESUFCTEtfUERfTUlQSV9DU0kyXzJdID0gew0KPiA+ICAJCS5u
YW1lID0gIm1lZGlhYmxrLW1pcGktY3NpMi0yIiwNCj4gPiBAQCAtNjcyLDYgKzY5Nyw4IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgaW14OG1fYmxrX2N0cmxfZG9tYWluX2RhdGENCj4gaW14OG1wX21l
ZGlhX2Jsa19jdGxfZG9tYWluX2RhdGFbDQo+ID4gIAkJLmdwY19uYW1lID0gImxjZGlmMiIsDQo+
ID4gIAkJLnJzdF9tYXNrID0gQklUKDExKSB8IEJJVCgxMikgfCBCSVQoMjQpLA0KPiA+ICAJCS5j
bGtfbWFzayA9IEJJVCgxMSkgfCBCSVQoMTIpIHwgQklUKDI0KSwNCj4gPiArCQkucGF0aF9uYW1l
cyA9IChjb25zdCBjaGFyICpbXSl7ImxjZGlmLXJkIiwgImxjZGlmLXdyIn0sDQo+ID4gKwkJLm51
bV9wYXRocyA9IDIsDQo+ID4gIAl9LA0KPiA+ICAJW0lNWDhNUF9NRURJQUJMS19QRF9JU1BdID0g
ew0KPiA+ICAJCS5uYW1lID0gIm1lZGlhYmxrLWlzcCIsDQo+ID4gQEAgLTY4MCw2ICs3MDcsOCBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IGlteDhtX2Jsa19jdHJsX2RvbWFpbl9kYXRhDQo+IGlteDht
cF9tZWRpYV9ibGtfY3RsX2RvbWFpbl9kYXRhWw0KPiA+ICAJCS5ncGNfbmFtZSA9ICJpc3AiLA0K
PiA+ICAJCS5yc3RfbWFzayA9IEJJVCgxNikgfCBCSVQoMTcpIHwgQklUKDE4KSwNCj4gPiAgCQku
Y2xrX21hc2sgPSBCSVQoMTYpIHwgQklUKDE3KSB8IEJJVCgxOCksDQo+ID4gKwkJLnBhdGhfbmFt
ZXMgPSAoY29uc3QgY2hhciAqW10peyJpc3AwIiwgImlzcDEifSwNCj4gPiArCQkubnVtX3BhdGhz
ID0gMiwNCj4gDQo+IEFzIGZhciBhcyBJIHVuZGVyc3RhbmQsIHRoZXJlJ3MgYSBzaW5nbGUgcG93
ZXIgZG9tYWluIGZvciBib3RoIElTUCBpbnN0YW5jZXMgKEknbQ0KPiBub3QgZW50aXJlbHkgc3Vy
ZSB0aGlzIGlzIG9uIHB1cnBvc2Ugb3IgYSBkZXNpZ24gbWlzdGFrZSwgYnV0IHRoYXQncyBhbm90
aGVyDQo+IHN0b3J5KSwgYnV0IG9uZSBpbnRlcmNvbm5lY3QgcGF0aCBmb3IgZWFjaCBJU1AgaW5z
dGFuY2UuIFdvdWxkIHRoZXJlIGJlIGFueSB1c2UNCj4gY2FzZSBmb3IgY29udHJvbGxpbmcgdGhl
bSBzZXBhcmF0ZWx5ID8NCj4gSSBjYW4ndCByZWFsbHkgdGhpbmsgb2YgYW55IG15c2VsZi4NCg0K
SSBoYXZlIG5vIGlkZWEuIEkganVzdCBmb2xsb3cgdGhlIERvQyB0byBsaXN0IHRoZW0uDQoNClRo
YW5rcywNClBlbmcuDQoNCj4gDQo+ID4gIAl9LA0KPiA+ICAJW0lNWDhNUF9NRURJQUJMS19QRF9E
V0VdID0gew0KPiA+ICAJCS5uYW1lID0gIm1lZGlhYmxrLWR3ZSIsDQo+ID4gQEAgLTY4OCw2ICs3
MTcsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlteDhtX2Jsa19jdHJsX2RvbWFpbl9kYXRhDQo+
IGlteDhtcF9tZWRpYV9ibGtfY3RsX2RvbWFpbl9kYXRhWw0KPiA+ICAJCS5ncGNfbmFtZSA9ICJk
d2UiLA0KPiA+ICAJCS5yc3RfbWFzayA9IEJJVCgxOSkgfCBCSVQoMjApIHwgQklUKDIxKSwNCj4g
PiAgCQkuY2xrX21hc2sgPSBCSVQoMTkpIHwgQklUKDIwKSB8IEJJVCgyMSksDQo+ID4gKwkJLnBh
dGhfbmFtZXMgPSAoY29uc3QgY2hhciAqW10peyJkd2UifSwNCj4gPiArCQkubnVtX3BhdGhzID0g
MSwNCj4gPiAgCX0sDQo+ID4gIAlbSU1YOE1QX01FRElBQkxLX1BEX01JUElfRFNJXzJdID0gew0K
PiA+ICAJCS5uYW1lID0gIm1lZGlhYmxrLW1pcGktZHNpLTIiLA0KPiANCj4gLS0NCj4gUmVnYXJk
cywNCj4gDQo+IExhdXJlbnQgUGluY2hhcnQNCg==
