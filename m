Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F54547D30
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 03:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237293AbiFMBDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 21:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbiFMBDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 21:03:10 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70051.outbound.protection.outlook.com [40.107.7.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8039413D5F;
        Sun, 12 Jun 2022 18:03:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBBOd0dQtpDA4v9VnY7hlJAB7fdsKtpZKmRfeKVYMmvPqzwKSkJxdLAh8YKlkWwEvxCEvAuwwYk92NrUX7mAN8ny3H1Vuh5i2CQXak9T+eRjmrcgYr6qx5i+Jy2F0SWBGsJFfOV93VKebGeIqepMmZwR05qHICqeAq1X9umWV+nWCOZPl2584Ic2Sy39fw06dZd1lFEXR0C+ArHV7EsSiK30tVSG/puz6iT+Q2NtDrufydp3tNNe9dDZt8s/ttDrReFKLLavPdl4/BVI3NxOjezb3cnoHw12VFci96V74L7/4i/+nSAdfLeeuK2MtTPD10I+TkxX+/sYR0EsfXiXpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zzU1dL9pECBNpYPVfGgnPw0g8ai0Ho7lqGT8v3TEe0=;
 b=mbCTs6deLlP3gXtPMjCTtPGOxJserTIxs+lcnvj2lj5v9YNsPuew9i21ZjoSmileqo/KJJht1SSXt9UsTyuRIDXVGjlpdGyl9oybRpyvAnnPKeZYknK/LcrdQjvv+diyA6fKoLwKJBxgJaRHvs6GHFT51Y6tHOOalfii8iE1mIXdGeXHDUiKnnOJnHpRgGcJ2sNpi/4uy2U2ThdI077YIt8Y38TTb0sawaCaZKB2q/AjRJGnwRnwQxSsBtF741T9In0KMdNaenWEdaEXQw0wktMHdaImeGoB31ypU+gmnPlL8SRtKLdmy6Luo7yXpZyOFNpgMYI/f2eAxhY1M1pufA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zzU1dL9pECBNpYPVfGgnPw0g8ai0Ho7lqGT8v3TEe0=;
 b=mc31DRAMd7toNYf7HKOXdLqTTwxEUKhIGl2Gx0Pb5iEw7pqkYNwPCcYmfXobks92V3iu7LYWintYkFoav1IHfugoldhTNwuQyi67zWkLX1SDFFOAiz42gWgldIxNxRU5W0j5/qwU+b2a0A1UO3wL5wg9DxkxNjONQM7CL53m1Tw=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB3964.eurprd04.prod.outlook.com (2603:10a6:5:17::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19; Mon, 13 Jun
 2022 01:03:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%8]) with mapi id 15.20.5332.015; Mon, 13 Jun 2022
 01:03:05 +0000
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
Subject: RE: [PATCH 1/8] dt-bindings: soc: imx: add interconnect property for
 i.MX8MP media blk ctrl
Thread-Topic: [PATCH 1/8] dt-bindings: soc: imx: add interconnect property for
 i.MX8MP media blk ctrl
Thread-Index: AQHYdZwe8WxpsnubG0CeZaYVX6DmHa0/zA+AgAzKfkA=
Date:   Mon, 13 Jun 2022 01:03:04 +0000
Message-ID: <DU0PR04MB941724785E173EA71DEF3FE088AB9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220601094537.3390127-1-peng.fan@oss.nxp.com>
 <20220601094537.3390127-2-peng.fan@oss.nxp.com>
 <YpvRL4d2Sh9hvVMl@pendragon.ideasonboard.com>
In-Reply-To: <YpvRL4d2Sh9hvVMl@pendragon.ideasonboard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ee78305-3331-4ade-2cf3-08da4cd878d1
x-ms-traffictypediagnostic: DB7PR04MB3964:EE_
x-microsoft-antispam-prvs: <DB7PR04MB396494B1D00A432C44D1FAF288AB9@DB7PR04MB3964.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bu73eZWRjQDIO7+H+aaM8It7BHPhMUQzPRCwCcifn02KgPfUkSl1UdF2RH2qOO74PBIBMSEtjhmzjWZfG8Dfr3Q1XDKbB44xtwhuT4prQdNoTnlJCsnXKaZ5aBDRhJE0ZfKn2mBK99UDR0KtwPsiVQQkvi4YPmJO5gQWDomgGdqEi5qse78RgMUOjj3JsDqANuxHzYtCNuPlcSnMwH26AgShACKYlF57wh0Q3hggdWiRg9hGh4gV/6E1i0+S0uZnJzjlLF3JRj7IrQbP6ksReYhQVYDI+fCIVr9JwYksJZxWU2McDCjPxoAkmWj2JSsN9UXIIMoTVeMwkrc1bSQVd/5Sdx1WSS4P0ain69CiCxBRQ4y5f8/kQiF/RB9ub8cR5smfVXOLAIRLM3Jf2uYc8j/7wDIKZD4ruKGCQ0eOtWPDTJzCPt7LX7CPPCohwaS2u9eJSeoYpGNJGnr1z0dnjyjmg/+TpdGQ3OZqWqzibhNTJF/k4/ANI4b3EY4Pa/5TGBbqHxgEgI3oMr2O9wM9UsacG5PJQCS6eRXVop4UfpG+cV39vyHqFUWiOAcIylVdeYrxkZwwvymmi4RuX+OcoQl1tNThjviW+xvWKwOJh6lxydbJWlOQFJc7bYSzVuMJ3jHkr3UNvZ3ktCG4DhTiYoymD5cHbImkmrLoVrJak+fnJYCkW192+MCx/Yr6nuH7Vqt5+uQ6mMthkdqqLt9jQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(7416002)(66946007)(76116006)(8676002)(52536014)(64756008)(66446008)(4326008)(5660300002)(66556008)(66476007)(508600001)(8936002)(33656002)(44832011)(9686003)(71200400001)(26005)(38070700005)(316002)(2906002)(38100700002)(186003)(122000001)(83380400001)(54906003)(7696005)(110136005)(6506007)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K25KV0lRaDFkWDNaVkhSNG5FK0ljSmw5dGlneUJhZG1jRCtWVlkxN01hL2kz?=
 =?utf-8?B?djB4ZzQySzRFRzBjNldEeFVmTjV6USsyVTZmeS8wNmdqQjVvM3NYd2pTS3Az?=
 =?utf-8?B?dW5VMUZTbzMrZnZHaFo5RWhQMzZpV1M4bEY5ckVUSmtGK1BMOWNmU1JJbitB?=
 =?utf-8?B?MDNmN3A0MVhRQXRibTdrSk4vL0ZTWXRGNTh6eDZjOCsvQjU5bmRkVks5RnZo?=
 =?utf-8?B?b1RLaTkxODVPTFk3ckszTE00WnhRL0syU2s2ZFZTdWpOUCtDNVVUekd1R1M5?=
 =?utf-8?B?ODk5MTRIMHNBT0hnem9ZMDhsT3JFMVk5b0lWeGo5TnhTWWFCMWo5aThlakVZ?=
 =?utf-8?B?LzF5bGtOaldDRzFrL1kvZklHUTRJcUxCUG4zSVQ3WHU2MXRYNncvTzk1Mmlm?=
 =?utf-8?B?aDFacWR4c1FsZWdJQ0V5d3RvbUYyOFlpbS9raXpiRnJRVTlCTmN1djF5Njlz?=
 =?utf-8?B?S0w5cHFTN2hnYy8xRjR0KzgvQkVKVE1EL0dLaWJIa2VhbndsT2kzdTBOanZl?=
 =?utf-8?B?NDA0L21SbkYxUlhKdjJXYnBVdGdGWnJQTzNJRjJGdGk4U3hITjI4V1hJRisr?=
 =?utf-8?B?a1E1VCtXRVJJcFN3SExnZWR3SG5KT0ZUSEE2NVBsS05xeGN6bFNmRGZzMnQy?=
 =?utf-8?B?eEY4K3Z5S2VycnZUd3c5SzVNMVUwNGdGaVBtNklORk0rdzZHNVh2YzJJbVI0?=
 =?utf-8?B?TnljMk05dlJJcHFSa0VUM3VJYzI3UGR2a1VLdDhyaFR5Rlo0TW4xNDR2MkU2?=
 =?utf-8?B?R3J2RE9UbzVwZUJ5T2swWlFRL3ZXeTB3cDBuT2R0RkJFdmVFS2pjMTE0NmlS?=
 =?utf-8?B?WFMxWWlIM2dtMnBsYmJ5VDRwemg4eUpBWDRvQlh1MmpWUGVNUlpEUktsR1BR?=
 =?utf-8?B?dExiNGd3VVZQSDNyUFVPbWsreFVMQkpNckVIN0VPZmNISGpZTCs2L1ZlL0tQ?=
 =?utf-8?B?UkhESzJkMHBLKzFjcy8yV0VFVHdYalJmZmpLMzl5TTJvYXVjck9RTXZlZU5D?=
 =?utf-8?B?TmphRHorTTl3U3NybHBYeFlRcVkrQldmVzY0bnV4bXlvbDVlTU9kbFF4VzJx?=
 =?utf-8?B?MUxWMjBrd1habzNFalM1enRpclFpN3dzN0NXM2t5Y003aytiZnRPUjJPR2x2?=
 =?utf-8?B?UXdNNUxRL1ZBeXlHdjltVzZwWWJnR1NRSG1iMWw3dmgybzlTZi9VT1Nha09O?=
 =?utf-8?B?clVoYjNDNThCR2N1U0JZVWE2RmlZK25rT3YybFU4eGI5VE1zYTNZb1BpeE9B?=
 =?utf-8?B?Y2xxUmpMUkJoMVdUVGJsSGpWUVNhaEN0MjRFUVU0Y2srVnNpZ012TDlNdXBG?=
 =?utf-8?B?VWYrNytpaUpndEhlbGluRmp2U0RpUi9kUUpLNFZZUTBQY1BGVmlHM1hZL1kr?=
 =?utf-8?B?STFUaHdmN3NBbzhDV1FIdzJ2WHc0UFZPODJyU3ExOHNSUmVYd3I2WmpBTTR3?=
 =?utf-8?B?SUVDT0l4ci9iMDR5N25PdmszQXJIYjhEVHlacVFCU2g4MXdrWEpzUW9DdkxJ?=
 =?utf-8?B?TWVIeU5lSFVwcmY0cmEvWjkvb0JhbG15cmN5T2RuT25IM292aFZ4enlTWVNQ?=
 =?utf-8?B?VjMvamsyWnEvSDdCcDhYYzRueG5FUW9wcys1VkxkK1BBZ1NPVzJWb2taVmtM?=
 =?utf-8?B?eVAzcWtsbnZjMHVPZGc5ejZQZkJwVGs0aGxqMXlLZC82aVdYbUlPQm90VThT?=
 =?utf-8?B?Z2FTaCtKdGRmVmN1V3ZBbElqM1dveUd4MDY5WkkvSTUyanZCSGtuQXJoZm10?=
 =?utf-8?B?OGdTbWZGTHJzRTJhZDVWWHRGb0k2ekdVVFZiVXYrM1RuV2tRbWVmWW5UUXZE?=
 =?utf-8?B?VHNkQXVIZUUyZlIxR3I4N1hQaVBvOWdEN1k5OXR6OHpsYkhvTVZPOGVOWEJI?=
 =?utf-8?B?SlNuRTlTNzVIVDk2L1lBVkFRSks5RW5WQ3BmTS9YTFNPbTBaQ2Z2OU9VUXBJ?=
 =?utf-8?B?UWY4UUprYmlGWDF1aXZFbGNPdVFGZlQ3bm9GbGpZZjhJMWttK3cyQk83UE1E?=
 =?utf-8?B?ZHZLOVhVZVgrSHNxRTdKeC9sUXpKR09QbkUzbnZ4Y1JpZW1VbGEwWnZEMDl3?=
 =?utf-8?B?SnZQYXNpRVJWejczZktNb05QZUNNWjFFbXZWVGNvOWFIbDFRRnRQS1dWOHUz?=
 =?utf-8?B?YlFLeTk1ZDZMVFVraGM2Y1VReFJwbmgvTUZBTjRyTWZ6TEZHeUNhL0d1Y1hU?=
 =?utf-8?B?ZXc5MVRtRFVZNFNsY1lRaFM1WmNTV3c3YTFMOHFuOWZZSEIwNEN1Ujg3NG5w?=
 =?utf-8?B?b2xHQ1NkZ3Zya0Y0bkNsaDZQMnhjNDRxMFVSK1NXajJmSy9KVTA3UzNHWjcy?=
 =?utf-8?Q?FKGv8z6/wZEPdT4bBy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee78305-3331-4ade-2cf3-08da4cd878d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 01:03:04.9811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6uGZHdVOWjhbG0OWaT8T+cCNDhbydN/lDrRMBYtFQ0jnnVsuCgoucjn0UShgnDRLuZsRHVSz6ilbJIJoIE1PgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB3964
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvOF0gZHQtYmluZGluZ3M6IHNvYzogaW14OiBhZGQgaW50
ZXJjb25uZWN0IHByb3BlcnR5IGZvcg0KPiBpLk1YOE1QIG1lZGlhIGJsayBjdHJsDQo+IA0KPiBI
aSBQZW5nLA0KPiANCj4gVGhhbmsgeW91IGZvciB0aGUgcGF0Y2guDQo+IA0KPiBPbiBXZWQsIEp1
biAwMSwgMjAyMiBhdCAwNTo0NTozMFBNICswODAwLCBQZW5nIEZhbiAoT1NTKSB3cm90ZToNCj4g
PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPg0KPiA+IEFkZCBpbnRlcmNv
bm5lY3QgcHJvcGVydHkgZm9yIGkuTVg4TVAgbWVkaWFtaXggYmxrIGN0cmwNCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAu
Li4vc29jL2lteC9mc2wsaW14OG1wLW1lZGlhLWJsay1jdHJsLnlhbWwgICAgICAgICB8IDE0ICsr
KysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
c29jL2lteC9mc2wsaW14OG1wLW1lZGlhLWJsay1jdHJsLg0KPiA+IHlhbWwNCj4gPiBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvaW14L2ZzbCxpbXg4bXAtbWVkaWEtYmxr
LWN0cmwuDQo+ID4geWFtbCBpbmRleCAyMWQzZWU0ODYyOTUuLjcwNmJlZjM5Yjg3ZSAxMDA2NDQN
Cj4gPiAtLS0NCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvaW14
L2ZzbCxpbXg4bXAtbWVkaWEtYmxrLWN0cmwuDQo+ID4geWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvaW14L2ZzbCxpbXg4bXAtbWVkaWEtYmxrLWMN
Cj4gPiArKysgdHJsLnlhbWwNCj4gPiBAQCAtNjQsNiArNjQsMjAgQEAgcHJvcGVydGllczoNCj4g
PiAgICAgICAgLSBjb25zdDogaXNwDQo+ID4gICAgICAgIC0gY29uc3Q6IHBoeQ0KPiA+DQo+ID4g
KyAgaW50ZXJjb25uZWN0czoNCj4gPiArICAgIG1heEl0ZW1zOiA4DQo+ID4gKw0KPiA+ICsgIGlu
dGVyY29ubmVjdC1uYW1lczoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGNvbnN0OiBs
Y2RpZi1yZA0KPiA+ICsgICAgICAtIGNvbnN0OiBsY2RpZi13cg0KPiA+ICsgICAgICAtIGNvbnN0
OiBpc2kwDQo+ID4gKyAgICAgIC0gY29uc3Q6IGlzaTENCj4gPiArICAgICAgLSBjb25zdDogaXNp
Mg0KPiANCj4gSWYgSSB1bmRlcnN0YW5kIGNvcnJlY3RseSwgdGhlc2UgYXJlIGZvciB0aGUgMXgg
UkQgYW5kIDJ4IFdSIGNoYW5uZWxzIG9mIHRoZSBJU0kuDQo+IFdvdWxkIGl0IG1ha2Ugc2Vuc2Ug
dG8gbmFtZSB0aGltIGFjY29yZGluZ2x5LCBtYXliZSBpc2ktcmQsDQo+IGlzaS13cjAgYW5kIGlz
aS13cjEgPyBJJ20gbm90IHN1cmUgYWJvdXQgdGhlIG9yZGVyIHRob3VnaC4NCg0KRnJvbSB0aGUg
ZG9jIEkgZ2V0LCB0aGV5IGFyZSBpc2kwLzEvMiwgc28gSSB3b3VsZCBrZWVwIHRoZW0gYXMgaXQg
aXMuDQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+ID4gKyAgICAgIC0gY29uc3Q6IGlzcDANCj4g
PiArICAgICAgLSBjb25zdDogaXNwMQ0KPiA+ICsgICAgICAtIGNvbnN0OiBkd2UNCj4gPiArDQo+
ID4gIHJlcXVpcmVkOg0KPiA+ICAgIC0gY29tcGF0aWJsZQ0KPiA+ICAgIC0gcmVnDQo+IA0KPiAt
LQ0KPiBSZWdhcmRzLA0KPiANCj4gTGF1cmVudCBQaW5jaGFydA0K
