Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C494D57D0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 02:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345522AbiCKCAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 21:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbiCKCAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 21:00:09 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60080.outbound.protection.outlook.com [40.107.6.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F38B1A58C1;
        Thu, 10 Mar 2022 17:59:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFr3o2qvEgbdBS6rQDXZIZ6nJdmNjcURzKyMfie/4WyezWHi3fw+COwM7lLh1khOEQYcWrI7meVh/7xulrbZnWAsJxM87b8+tIop6ZQ4yBy8xd3QSXc/PE7AvqFeU0rsZcS5U47/1ycdEyjyi+UdjZROme1UnDUeQJo1vVM0b3dK/+cvgSzkY+qZxK1HBNU/fv3/XfmoiExslIoAvbmFDQQApuUBf6jiMAaQmV8ooty3NpaMYQS1YiViJtL+p1tx8rx60FQsFCcOotIdWKPIGLjNJQ959LLBdx4mrP63xhJ4ng9BlLFH17tS7SZ9LSQvSJfHGCouK3phWqaoF2p9Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGSR+Axw4DAkO38MhHb8YnOZ9ufAikKuOIyd4qJK5Dk=;
 b=daqkDwbZ1i0WMqkmezL1puERHxipdw3zr2hAsi2KT/jwnROoTlmmiUs35dI/jboyun7vVruYWKOam7M9OQP0Pql37W9rf2keXsvEQd2Fd2BILH1nJwRSi8tSuUASLFUfaMMZC66M38/eV6uh80Jj1SybOIGy9ygf07O0NExXLjTnn7sctSiJV88RKsfWsr2P+DMvkrfr7hvDNhIOdYyQYeYHsjyISdLiXxHGzcHdK7rjUX3sgy59ByifoVke2xxLfuBDtPRiQelSvYhECAowlH9NJHizo3CcBbj8kvzKI0ik+BwKVdUXf+9r4p6f/OXDE7dgxqkH6dAXUwJ47iDg7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGSR+Axw4DAkO38MhHb8YnOZ9ufAikKuOIyd4qJK5Dk=;
 b=TKBxs3zZatjigqHEzjvDQhABIcAVCeamA8LoLUSnVI+KUWTiM5Kg2wwQFkbmBCYkejf8D8FhWnjJXBkqFvltiVhGZ2NMBWyH4f2IAgGCyXF859mmLvZ2vCPT04p9SqmIZj/zODGHT140PO/ynZH90cAL9ljAfHGYbWtkxh+wVps=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7428.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Fri, 11 Mar
 2022 01:59:04 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7%8]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 01:59:04 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 1/6] dt-bindings: remoteproc: imx_rproc: support
 i.MX8QXP
Thread-Topic: [PATCH V2 1/6] dt-bindings: remoteproc: imx_rproc: support
 i.MX8QXP
Thread-Index: AQHYM5nNf5hegaKWGEO/rs75Ico5qay3TDuAgAIjgDA=
Date:   Fri, 11 Mar 2022 01:59:04 +0000
Message-ID: <DU0PR04MB94175B52A87625CD8A949F84880C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220309102118.8131-1-peng.fan@oss.nxp.com>
 <20220309102118.8131-2-peng.fan@oss.nxp.com>
 <b7ae988c-b420-83bc-0a4a-e82393d1549f@canonical.com>
In-Reply-To: <b7ae988c-b420-83bc-0a4a-e82393d1549f@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59d398c8-972a-4685-3b71-08da0302b87e
x-ms-traffictypediagnostic: AM8PR04MB7428:EE_
x-microsoft-antispam-prvs: <AM8PR04MB74285DDB3135755E96140DB5880C9@AM8PR04MB7428.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YHRxEnq3JNckdeusiw6sa/bkCeHThlB8ACVVHe02byorKiZFe3KMgCPcUfKr27G0B+zG1WMokGTL+fQvGPNJEHshtRqUDMYYEeFwMrtBMVJbG02uCwF8n6GHa1nADC1O7B8M6XBK3zi4Y2r6N4ctPqBMKdUyc4bkquSmaOZM2V3zAqHQMOE8uPWmzYfgXNsnFmyDxLcPC5752FExXdd7SjbLi8HHAPou9SoZRuGXOr6qfcd3258my5xL5CmJZA/5zJbZF+BduyppGlC763fQA5b8SV7ACChrvqLvnDlNl0seWaTl+8gPA7qmRO0DB/5HtAyVetmkUZtOELSmtAXGpofA7g90CbiXLD5aECWtgENK8yfOO9qr0ekXJVbSxtuOp8Wbr2KGOvDy1pTQCJ+2F9EF1W/CLBw10kVwMFUKzkxZ6JlRUzsJtZf9pu7lAVfhQ2jbYJSKcuNYvhEDRM/9uefe4N5IJqITMV1IB3G5N53J+2t7hYqjZPTitmsxDHdbuws9SgpBTBlbRinRe6D2kuGZC4LMHbsddkuhr/1gkUoPLHG8sZtXE7JreLiC/IrMRs/XErCQewWixFPxUxSd9DGQMmBnXsYq1X6dDMeWQ4JEhRvxy8utKJuudF0LBXUCfMXStvlM/IuSdPjGwAqDMKkRfliLgQah27AjP0uIlcNA0MN/Y5KVf+rCbnzFHbqz0gTMxZBp69PMqnR5clhKAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(86362001)(8676002)(38100700002)(26005)(76116006)(7416002)(66556008)(66946007)(66476007)(122000001)(54906003)(186003)(4326008)(9686003)(71200400001)(498600001)(66446008)(38070700005)(55016003)(83380400001)(6506007)(8936002)(64756008)(7696005)(52536014)(33656002)(5660300002)(44832011)(2906002)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkhKMWdXVkVMVG1PVks1N25ZU0VrNEFUQ3pKS2JBbFI5cFZraXhYNlNVTnBG?=
 =?utf-8?B?cWI0VHErWmFyWUlvVDRzNjZoYi9KUUI5SHI0Z2RPcm5yV2psUjh0RGQ5OXJT?=
 =?utf-8?B?Qi9SN2VrMjJDdVdWQXlDUXZ1MDVrVkcxTThuZzFMOHIwbFN2L2tvTHZ6Z0Uy?=
 =?utf-8?B?SVh5SDZweHE2YTZZU2cramFkR2RaaVNRZGhORFFadHJtb1ZOS2VNYS85M0Vy?=
 =?utf-8?B?QVFWbFA0NFEzWFVlenZpNkQ3WTNkZERkT3ZmS3dKLy9NOThpcmNRVFo0UWVL?=
 =?utf-8?B?bjJjY0VmbWFHV0p1SVI3a1J0SWd1NmxDRzZZcXZCZDNCNzNpTWpEWlE0Q2Ur?=
 =?utf-8?B?TzRmNDd2bUVJcGlwUmlOb01kUkJsdHVxcXNvamxsN0R1dDl5d3pyeFVraTR5?=
 =?utf-8?B?bjRmSC9aTDRYNkZ3T215b2tnSkNndjRzUTMzNzBKaGV1S0pXYUlPdnNVckpl?=
 =?utf-8?B?TjM0cTFwekRVZ2FqRlRWTTg1TUxnSmI4WTJVcHE4dkszZUx3bmdJb1NEaUdX?=
 =?utf-8?B?ZlQxZDQ1OTA2aHc3NE9lbWRBeisvQTl6NURQR1ZWeDYyUVZVTHNtWGlCYmE0?=
 =?utf-8?B?NGhiTXhMOU1jZS9Ib1ROYnFTTzlHaDNZd3hkRFJFUFNudU5EVDV6eXpCVjdz?=
 =?utf-8?B?WjJyVDVjL1F0MFhZa01JTUdlSDdhMkx4U2RLT2dqNUJFQlZZQ2Y4NkhJOUhE?=
 =?utf-8?B?UkNjVFZIVGlncEJnS0wrd2lyMWxUK3ZaSDlZSVhvVUJsSi8xeGdZbDdnUGtE?=
 =?utf-8?B?dVFnUWpVcENLcXkxWnpFc0tJNStycll0SVlGQ2U5Z0dIRnN6aXNXK1NYNUxI?=
 =?utf-8?B?N2FLbFlKaDM3Q3p0ZHp2RFJtNWRTbUVYU2VZTFkzMW1HNjJyeUYwQjFKTFJS?=
 =?utf-8?B?eUNKNE5DdUJZcXpJTmliMTJpVXFMQnJ1TWplQ3V3VnN1aWU4c3BpRmF2K1k1?=
 =?utf-8?B?UkhqTU9yMy9uVVVheUpqZHk3WTRqc2pyb3orb0crdlZJNm1YVXc5QUYyekRV?=
 =?utf-8?B?UUJHWmRaMlRsdVJ2aVFFOXB3endVZDRoK3hrRVhiRllYWjM2MEpIZmt1b0U5?=
 =?utf-8?B?b2YrMTZ3STdOM1FCcjFMdlJSZ1lRckdoNEZzUXg3ZUFMV3BsSFhWUGg4SGVC?=
 =?utf-8?B?MWV1Z053NnYxekw1SE5PNDdkZnVkK2lFbHR2Y210U1hrRy9zaHZORXhIL04w?=
 =?utf-8?B?Z0psaVNCQnNLUkxpeXg5aFNZZHNPUHJnWGZmcExKeXQvYWtmaWRBY3poNXpl?=
 =?utf-8?B?YjA3NjRVYldXb0tnbGNpQ2dReVdGTFJxMWxhR2NyWEswaTc5aU5mb3hXQ1Rr?=
 =?utf-8?B?YnBLbE5IeVc3eXFzTWoydHVxbjU3TVBRcmZpdzNNN3c2K2toRHR2Z3JGR09H?=
 =?utf-8?B?WXRmYU40aldaNHFJZEZ3cmJVTGFQNmFSQnpWak9TUGhLTFVwaEdqdE5TeXNH?=
 =?utf-8?B?K1FCLzhHWjFJOCtLSG5kek9JT3dpaENOTWJZVVZuM1ZpWnRSWlJ4WXp0TWJJ?=
 =?utf-8?B?WTc4NFczdEZyUlBTSjdJeWJiWHZYaU1QdFJERXFxZWNLR0xlYlZKbllIakxR?=
 =?utf-8?B?TGl3amk1VXlGV1dhaS9HdHgzVGE1citQL2VKSW5iNlJIZkVlQXc3K2k3TzZH?=
 =?utf-8?B?NzAyNzJ3Y0N6SmhlVTBOd1c3c29rMGlQUDNDbTlwU1g0YzVwRmxHN3Ivbmdm?=
 =?utf-8?B?dmtRMkFoUm42eTdNNkJwTTF2WThUL3BjbGxLU2s4WGZxWi9BLytkbnRWVmhu?=
 =?utf-8?B?dEw0UysrOGhLdlRsMVU1UmEwbmZ2SHIrblFRbng1bXVGSDNiKzk3Y0lrVXE0?=
 =?utf-8?B?elJFRG1VZVNhQ0w5akhXRzVGTHFXa0FHT1hZRkttbTJxQkdtaDBzdlRCK2di?=
 =?utf-8?B?MjVuM0t0VVIxMVVZbTVyNUJoc3VPZ2V3RysxcERnMDJwc1U2OFVrMTByZStl?=
 =?utf-8?B?RTN4YjFQQmRyeFM0RWxQRTBRU25sUzg0ZTZCckdrSjhOd25Cck1MYisyakFY?=
 =?utf-8?B?bkRubml6L2p3eTJnSFQrNWRJUEIvMzFwYzdjdXhFK2hiSEZvcWJxcFZ1QUMx?=
 =?utf-8?B?VStyM0tsQmF1THRSSTVUM0E1MXZTMVAvQ0pmRSt5blJ3N0FSTWF4VWJlM0Vm?=
 =?utf-8?B?bFUzWS82L0pWMEF5YUFFTTBMMXNZZGRtdVltd0pWVUJTQ3JZakJPZUNEVW05?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d398c8-972a-4685-3b71-08da0302b87e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 01:59:04.5507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: loa03BYwOwlvprZEBcPXi696YBjvtJJwgXVr/0V4sS2CTTCMR025d6O8+gORG8cxHTdyvgjdRbMsvJz1lMMcDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7428
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIDEvNl0gZHQtYmluZGluZ3M6IHJlbW90ZXByb2M6IGlt
eF9ycHJvYzogc3VwcG9ydA0KPiBpLk1YOFFYUA0KPiANCj4gT24gMDkvMDMvMjAyMiAxMToyMSwg
UGVuZyBGYW4gKE9TUykgd3JvdGU6DQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5j
b20+DQo+ID4NCj4gPiBBZGQgaS5NWDhRWFAgY29tcGF0aWJsZQ0KPiA+DQo+ID4gQWRkIGEgbmV3
IHByb3BlcnR5IHJzcmMtaWQocmVzb3VyY2UgaWQpIGZvciBTb0Mgd2hpY2ggc3VwcG9ydHMNCj4g
PiBTQ0ZXKFN5c3RlbSBDb250cm9sbGVyIEZpcm13YXJlKS4gU0NGVyBtYW5hZ2VzIHJlc291cmNl
cyB1c2luZw0KPiA+IHJlc291cmNlIGlkLCBoZXJlIHRoZSByc3JjLWlkIGlzIHVzZWQgdG8gY2hl
Y2sgd2hldGhlciByZW1vdGUgcHJvY2Vzcw0KPiA+IGlzIHVuZGVyIGNvbnRyb2wgb2YgTGludXgg
b3Igbm90Lg0KPiA+DQo+ID4gVG8gaS5NWDhRTS9RWFAsIHdoZW4gTTQgaXMgaW4gdGhlIHNhbWUg
aGFyZHdhcmUgcGFydGl0aW9uIHdpdGgNCj4gPiBDb3J0ZXgtQSBjb3JlcywgbmVlZCBwb3dlciB1
cCBNNCB0aHJvdWdoIFNDRlcsIHRoZW4gTTQgY291bGQgc3RhcnQuIFNvDQo+ID4gaW50cm9kdWNl
IHBvd2VyLWRvbWFpbnMgcHJvcGVydHkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZh
biA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL3JlbW90ZXBy
b2MvZnNsLGlteC1ycHJvYy55YW1sICAgICAgICB8IDE1DQo+ICsrKysrKysrKysrKysrKw0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdA0K
PiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3JlbW90ZXByb2MvZnNsLGlt
eC1ycHJvYy55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVt
b3RlcHJvYy9mc2wsaW14LXJwcm9jLnlhbWwNCj4gPiBpbmRleCBmYzE2ZDkwMzM1M2UuLmYyNWMy
MDNkZDJmOSAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvcmVtb3RlcHJvYy9mc2wsaW14LXJwcm9jLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvcmVtb3RlcHJvYy9mc2wsaW14LXJwcm9jLnlhbWwNCj4gPiBA
QCAtMTksNiArMTksNyBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgICAtIGZzbCxpbXg4bW0tY200
DQo+ID4gICAgICAgIC0gZnNsLGlteDhtbi1jbTcNCj4gPiAgICAgICAgLSBmc2wsaW14OG1wLWNt
Nw0KPiA+ICsgICAgICAtIGZzbCxpbXg4cXhwLWNtNA0KPiA+ICAgICAgICAtIGZzbCxpbXg4dWxw
LWNtMzMNCj4gPiAgICAgICAgLSBmc2wsaW14N2QtY200DQo+ID4gICAgICAgIC0gZnNsLGlteDd1
bHAtY200DQo+ID4gQEAgLTI3LDYgKzI4LDExIEBAIHByb3BlcnRpZXM6DQo+ID4gICAgY2xvY2tz
Og0KPiA+ICAgICAgbWF4SXRlbXM6IDENCj4gPg0KPiA+ICsgIGVudHJ5Og0KPiA+ICsgICAgJHJl
ZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+IA0KPiBEb2VzIG5v
dCBsb29rIGxpa2UgYSBnZW5lcmljIHByb3BlcnR5LCBzbyBwbGVhc2UgYWRkIHZlbmRvciBwcmVm
aXguDQo+IFN1ZmZpeCBhbHNvIHdvdWxkIGxvb2sgZ29vZCwgc286DQo+ICJmc2wsZW50cnktYWRk
cmVzcyINCg0KRml4IGluIG5leHQgdmVyc2lvbg0KDQo+IA0KPiA+ICsgICAgZGVzY3JpcHRpb246
IHwNCj4gPiArICAgICAgU3BlY2lmeSBjcHUgZW50cnkgYWRkcmVzcyBmb3IgU0NVIGVuYWJsZWQg
cHJvY2Vzc29yLg0KPiANCj4gcy9jcHUvQ1BVLw0KDQpGaXggaW4gbmV4dCB2ZXJzaW9uLg0KDQo+
IA0KPiA+ICsNCj4gPiAgICBzeXNjb246DQo+ID4gICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55
YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlDQo+ID4gICAgICBkZXNjcmlwdGlvbjoNCj4gPiBAQCAt
NTksNiArNjUsMTUgQEAgcHJvcGVydGllczoNCj4gPiAgICAgICAgSW5kaWNhdGUgd2hldGhlciBu
ZWVkIHRvIGxvYWQgdGhlIGRlZmF1bHQgZmlybXdhcmUgYW5kIHN0YXJ0IHRoZQ0KPiByZW1vdGUN
Cj4gPiAgICAgICAgcHJvY2Vzc29yIGF1dG9tYXRpY2FsbHkuDQo+ID4NCj4gPiArICBwb3dlci1k
b21haW5zOg0KPiA+ICsgICAgbWF4SXRlbXM6IDgNCj4gPiArDQo+ID4gKyAgcnNyYy1pZDoNCj4g
PiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBUaGlzIHByb3BlcnR5IGlzIHRvIHNwZWNp
ZnkgdGhlIHJlc291cmNlIGlkIG9mIHRoZSByZW1vdGUgcHJvY2Vzc29yDQo+IGluIFNvQw0KPiA+
ICsgICAgICB3aGljaCBzdXBwb3J0cyBTQ0ZXDQo+IA0KPiBOZWVkcyB0eXBlLCB2ZW5kb3IgcHJl
Zml4Lg0KDQpGaXggaW4gbmV4dCB2ZXJzaW9uLg0KDQpUaGFua3MsDQpQZW5nDQoNCj4gDQo+ID4g
KyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiAgcmVxdWlyZWQ6DQo+ID4gICAgLSBjb21wYXRp
YmxlDQo+ID4NCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K
