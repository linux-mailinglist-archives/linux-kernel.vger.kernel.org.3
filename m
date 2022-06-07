Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17CC53F723
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237642AbiFGH0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbiFGH0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:26:30 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60060.outbound.protection.outlook.com [40.107.6.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4B8C5D99;
        Tue,  7 Jun 2022 00:26:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aO5Cv6QpQo8M98erHm6ep32z1fFIhQUw6YEelvEDL3sANrDjZlKTfch+D5zmZxrOJM8gtLMekerHopqSUnRxR3WRoNebFI0pnyokmxEbcj8ep5D+Z0pAJVBuqZnJj37XvXnw6nPI9Os9wCLF0iR3uguRpcmwj89Q+NthQSQK+Ft+IQuviR7wktREivQyRbhm24k3vf9C05mSMqLgxoUu3y2SSfUqkQF/iS0zfdiJRHLoNYJkhUUHdYWC/cB+OWkAw5JrQ9IFUx5Dz3kLKQ+O7ww7lD+OFgIZuNwQowFCTl/G5EMJ11Oc0+oP11sVvM6H0s+JL8LfqSxd8ZRo1ASwYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIL9Ap7xeFYyLa+jTjfwZMrVvC1Ak7Hug0AnHV/qoHk=;
 b=D1hpY6rcEtx3xJe5x7B3Fxpa9gwrREYwSKq/X5iqFBxiBzB3itfwNigvVxsRtkTUGBeaU5q2fOr65t89XkQRKYncRNv3b1jy1HrVsCJFTF+jrpKqy/ePf3kLr6C6VeVD8N4+aEULZJHJMDZmQ0Oxt2Xewwtpwap0ScV7iiaQoZo8sXDr4RySLmiVq5EiCA5XXd668a1fBRh7SHyo3SLo4WJB00k/RfHOSUPkK6LmWXHo8LoP17JOihdML0uxhWFB5+DGagtCQMpoeKd+/sWyc8ZdzK/vEDaTN/ousBqjF1K+7/u7pyioMSksdfMJA/MF49kpgYMWB7izi6KWBvhGnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIL9Ap7xeFYyLa+jTjfwZMrVvC1Ak7Hug0AnHV/qoHk=;
 b=ZCeZN12TPASvtL+BoPjQxKS+OBARfLVo2tdayAwYIUTAFG/Zh2I0j9f3ObTi5DfaJK/jpwQ7RdjtM2r7DP+uDmBf3zYBHrYrlF3ivufYLCBraArIPQETQaP6HZY/Q6oKLgsdXk054lUCycghRTQABnf2Qi526UzGGVFSCCxgh08=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM0PR04MB5972.eurprd04.prod.outlook.com (2603:10a6:208:120::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 07:26:26 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 07:26:26 +0000
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
Thread-Index: AQHYc/mclVqKJ6jFKUC3eH0lZl8KFq1BDqAAgACkeoCAAHgdgIABDidwgABdxZA=
Date:   Tue, 7 Jun 2022 07:26:26 +0000
Message-ID: <AM6PR04MB634176422AB8537CF140A5ADE7A59@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220530074756.14585-1-ming.qian@nxp.com>
 <69817804-a618-32ba-06ca-3ec38ff1f124@oss.nxp.com>
 <AM6PR04MB63411F7904814E87116A5BEAE7A29@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <9b2acc8d-9755-9853-1dcb-cc9971a6ee1a@oss.nxp.com>
 <AM6PR04MB63411FDF5208C591AC9D010BE7A59@AM6PR04MB6341.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB63411FDF5208C591AC9D010BE7A59@AM6PR04MB6341.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a134ba9b-529c-40c3-4e47-08da4857084a
x-ms-traffictypediagnostic: AM0PR04MB5972:EE_
x-microsoft-antispam-prvs: <AM0PR04MB5972B2B9DA616B5687C0BE57E7A59@AM0PR04MB5972.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QZudnYOYuxb5DqcHq2RVjn3wNOMwr0CmNlFGwLU+AUiOqqnx0WL6Iss8KoRMIEwJhvkSXo438aMQQiTa0ISSyr2JqBxIMAbzfqg5qEir4RNxfFEM4PqynY5gIkYyKNx4q1zFJLAoIZOvTS/nX7ndGor1Te4TRg4c0Hd4wS+dVIRVJrXLAhGiV41m4bpSoUf+sQbWR5u30fig6vevV3VYl5zZW/83EffCZ3K9NujrcVc1AtQboUhm+Bs6yQQ80Xq3W5ahK7cO81DiIIdugggjRKk6kPOv969cAGSIeSHqDj6smrTHfLKpuR+VVhCGQ1C84ZjBiZkpS/dm1n2khVBy9eE5m6ykLGC1S1kTnUGk0sSLxPQ/SRzeOre3+HvWilL05QpfNp1VljgGHF9kU7/QoDfyqBFYbOnwDIerbpe7LRtnekjIWMmBbP20ZIBQvtcyghwrLEV0/Ly7wiMgKYQt6n1Qnsw821f13rYKzbKkWPM61m3yADqK4DpFJG1e1bSB1aQyV7AsB12I35joL7tIO4TeASO4uUnZq8sT4IL0V2AMKAuqT4xHusCh7sOm5jxs1kMEAjPJI+IDu+nmNwwKXUtDsEX+Y02hOGaUSYMRl38beLuIl1uQt28DWywesjHxOjh+1QLgCJY6MZ+bP3kIs1OZTALkTDIkptt23oSNIIx9o+9HkTljruXoMTRCgHYEyMiAWwmLVbHbe5sr+tv1ZBFUd5QQyLvtUZmJeJCgX1TjP4H2ZUbCw7CHnw6p1AnVFVIfMkaovUDWvW3ME+nDIn/VH/cR1cSOi6z43LxDgNQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(966005)(7416002)(71200400001)(52536014)(4326008)(122000001)(316002)(8676002)(33656002)(66446008)(38070700005)(6506007)(44832011)(64756008)(86362001)(2906002)(5660300002)(66556008)(66946007)(8936002)(76116006)(66476007)(110136005)(26005)(9686003)(2940100002)(186003)(508600001)(53546011)(55016003)(7696005)(38100700002)(54906003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vmh0Rm51dytQYW1wY1FWaGUyc1M1NGk0ZGNBRWczK2Z0dTBWR0huZmFOYjYy?=
 =?utf-8?B?R3E5ODNnNHNEL3Foa3J4NGo2bnhrSTFUR3VuNU1FVTJydVB0QllQN3MwKzdn?=
 =?utf-8?B?TFN3ZGRFb05JNHNKOWk0WUtVZHdUSFVGUnhQMDZCeEZ5MlhLeDA2aTFuNHhy?=
 =?utf-8?B?NHRzUnc2aW9jY1lNYnRvclJlbHJ5UmtCWEg5Qmh0ekFJOU1LdmRaMmdac0E3?=
 =?utf-8?B?b1BscU56TVZsa2NQWXZ6amZ6S0dYcG5vbGticGg1dHhZZG1Sdjh2MnlXWkpN?=
 =?utf-8?B?eUtKR2hCSk5kYVBiVU1ZcUdSemtNY2IyZnIvSGVxSUZoUFRXTHF6OTZJL2FS?=
 =?utf-8?B?SHVKSElsZVE1ank1RGhmSkd4QUNkVXU3c2VlTWlUcnRmTitFcjhUbHZxVzNC?=
 =?utf-8?B?eWdrelpHSEcyTnpxdVo1eUlOK1kyK1ZncVBHdE1Td2VaNTBSNklJWGlGdmN3?=
 =?utf-8?B?ZXFHa3prZ1Q2cDBRTWRlWU5Yb1ZHNXhrelhJRHN5UjhXeWgxRGFsN0FoQmE1?=
 =?utf-8?B?dmNXTk9neElWUmowOWs0WEY0bTJwVS9kZk1oa0tyR2hMSEpzbDZlMG5rMEo1?=
 =?utf-8?B?TDhpbmNObDFBRFYvU1ZIeVhsSXR1dHI3YkpjSENDR1J5MmpZbmZNa1haTEpM?=
 =?utf-8?B?YjlJUVBKOGg5RERueGF2aUVPemV0NUxhcmluaVpTOFc5aHA1ZnViNVRKSUVn?=
 =?utf-8?B?R1ZaWTlRejlBUTQ1dW1LaSs5Sk8vMmlMbGFuZlRxS1VGdGplQURWTkp5TzI0?=
 =?utf-8?B?Rk5rS0JaR2pzL1lVMUlrYlBuTUluZXdBSUNnL2dXV1J4NVpmNm82aTJwenR3?=
 =?utf-8?B?eVhSRk5tRm1RaDVPQ0NEaS9Xb3lJMEpZOEVaYmwyZ2daSUpUYUJKc1RaQTdz?=
 =?utf-8?B?YkQ1NytaVGR5bjJwUnU4Z0FRSW9JamI3VCs1TUtzMUhRWVRTN2xYRjVWbHY5?=
 =?utf-8?B?Wi85T0QrRXJlYnlCVTcwcDhzaTdBdnJ1b0c1ai9kby9vR2crdnFmd0xLbWhR?=
 =?utf-8?B?RmJpL2FhY2c3c094YjhCVXFPSTc4ZTdNY0VxZjhpREhCZ3RkU09jVTNvdGha?=
 =?utf-8?B?aUlhVFVRWkFqMUxNdXl6US9kKy9GUUU4OXhtRmN0T3dIWWJSUFZ2WGViK3U3?=
 =?utf-8?B?NmFRaHVEYjdMeWhZWEwzSnF4Qk1Ndk5pclJTeUdrR1hpQUwvbEtrL2dDdnUr?=
 =?utf-8?B?TXp5dzVRNGVPQ0FQTWNsVFg1UVpmQ2NKT25GbWd2T2hENWsxbUZDbmJTQzQx?=
 =?utf-8?B?QkYzckdmWDljamFBV01uc2gzT01Od1RHRVNsbkFmTUk3Tll2dDM2OVlMQldy?=
 =?utf-8?B?TkNGWDUveHN4OFh5TFp0QVlTRktjZ1VoWmdFSHM1L1JSQ2d5RE5PWmJBT29s?=
 =?utf-8?B?dFRtZmVmSE00YjhiZ3hGbklzNjFESlM1V1pmZXcxMHE3SGRMU0Z4UkxjRmRU?=
 =?utf-8?B?TG1VWHlpelZzblhhdEVManc4bHlhZ016bE5FcGd0MUNiUFF3QVRWdXR0cFpV?=
 =?utf-8?B?UUFZUXJMdWIvZVhPSkJ1SVpjWElqTW1yZEJVdHFJeWxndVUxUmZYSzJpTVZ4?=
 =?utf-8?B?bitreGd6UDBZYnVUMWJRSjJtMmpsb3BaSDRCblROVVRwVUN5d3JJQ1ZuVlcy?=
 =?utf-8?B?cDViaVJQazh0MDd1bHN3WlVUcUJlbjlHVDJ1cXVXM1dJVUV3S3pvVVZZdmNm?=
 =?utf-8?B?MFNzeHQ3UGhzcHpKZUFLUHFNdGl0R3FYUDVhSTA1MGlyVElnOThaT29qRDFx?=
 =?utf-8?B?WnFhdGNZSE9wYTkvcHp5U3ZBWWNIWkxzWlFSckJleW1QbXo1V3pWR0ZGYUVk?=
 =?utf-8?B?SXV0Q3ZZb2NDYWl2dklicjNJYUQ2cGFjaU5zcDltc012Q1lQWEF6WDZDUWNC?=
 =?utf-8?B?UlorVi9GVXM3Ry8xWFhRZU0va1hFK1Z2ZVRTYWhOa0dPcGEyM2ZGQnJoQ1kr?=
 =?utf-8?B?ZW1wVUlDRjRyY0pNQUo4TDkybVhSY2U2YU9JcHhpdjV1MGplNjFBMnVUVHhH?=
 =?utf-8?B?eStJSmh4S2Y4ZHBmV0lSWFByWFNsRTdWVjBNT01NdUMvQ0MwUEJNOE9rc000?=
 =?utf-8?B?OVJiSmZqb0l0UEp4S0ZwSzdFdVZjeW5SZU02dWhVYkdlNEZWeWV0VHBrM3Iy?=
 =?utf-8?B?TUlQRVQ2VnQ0YlhFanBWbCtabHYrek5SRHpISFJOY2hYWWxTK0FTbkVTQkc3?=
 =?utf-8?B?V2c3bVM0K3k2eW9ycmhrWHZrWW1mendGTWdGUHlwZ09RUndHTGlLSUxtbDdU?=
 =?utf-8?B?Z0RyeDhwTUJQK3Z5RGE3TVBpSUt6OEpVNThkQXNXL20yQjd0OGU1RDEvcnZ6?=
 =?utf-8?B?T3JQVXdQK1BlbFVqQmhFamkxU0d3YkE2YlVndndCNEhWYVZOUTkvQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a134ba9b-529c-40c3-4e47-08da4857084a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 07:26:26.4476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0iJ2Nb6mM/ff8xUEWMMhzmFkpE0O5SqsnRJFpMUWEse2uKiVY7Ful1qLUSCxoWBZpK9nvt9HBvzQdEsFGmRL0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5972
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBjYW4gYmUgc3VwZXJzZWRlZCBub3cuDQpJdCB3YXMgcmVwbGFjZWQgYnkgYW5v
dGhlciBwYXRjaCBodHRwczovL3BhdGNod29yay5saW51eHR2Lm9yZy9wcm9qZWN0L2xpbnV4LW1l
ZGlhL3BhdGNoLzIwMjIwNjA3MDcyMzE1LjIzMjA5LTEtbWluZy5xaWFuQG54cC5jb20vDQoNCg0K
PiBGcm9tOiBNaW5nIFFpYW4NCj4gU2VudDogMjAyMuW5tDbmnIg35pelIDk6NDkNCj4gVG86IE1p
cmVsYSBSYWJ1bGVhIChPU1MpIDxtaXJlbGEucmFidWxlYUBvc3MubnhwLmNvbT47DQo+IG1jaGVo
YWJAa2VybmVsLm9yZzsgaHZlcmt1aWwtY2lzY29AeHM0YWxsLm5sDQo+IENjOiBzaGF3bmd1b0Br
ZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7
DQo+IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47
DQo+IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHYyXSBtZWRpYTogaW14LWpw
ZWc6IERpc2FibGUgc29tZSB1bnVzZWQgaW50ZXJydXB0DQo+IA0KPiA+IEZyb206IE1pcmVsYSBS
YWJ1bGVhIChPU1MpIDxtaXJlbGEucmFidWxlYUBvc3MubnhwLmNvbT4NCj4gPiBTZW50OiAyMDIy
5bm0NuaciDbml6UgMTc6NDENCj4gPiBUbzogTWluZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNvbT47
IG1jaGVoYWJAa2VybmVsLm9yZzsNCj4gPiBodmVya3VpbC1jaXNjb0B4czRhbGwubmwNCj4gPiBD
Yzogc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4gPiBrZXJu
ZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwtbGludXgtaW14DQo+ID4g
PGxpbnV4LWlteEBueHAuY29tPjsgbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnOw0KPiA+IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0K
PiA+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjJdIG1lZGlhOiBpbXgtanBlZzogRGlzYWJsZSBzb21lIHVudXNlZCBpbnRlcnJ1
cHQNCj4gPg0KPiA+DQo+ID4NCj4gPiBPbiAwNi4wNi4yMDIyIDA1OjMzLCBNaW5nIFFpYW4gd3Jv
dGU6DQo+ID4gPj4gRnJvbTogTWlyZWxhIFJhYnVsZWEgKE9TUykgPG1pcmVsYS5yYWJ1bGVhQG9z
cy5ueHAuY29tPg0KPiA+ID4+IFNlbnQ6IDIwMjLlubQ25pyINuaXpSAwOjQzDQo+ID4gPj4gVG86
IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+OyBtY2hlaGFiQGtlcm5lbC5vcmc7DQo+ID4g
Pj4gaHZlcmt1aWwtY2lzY29AeHM0YWxsLm5sDQo+ID4gPj4gQ2M6IHNoYXduZ3VvQGtlcm5lbC5v
cmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+ID4gPj4ga2VybmVsQHBlbmd1dHJvbml4LmRl
OyBmZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4LWlteA0KPiA+ID4+IDxsaW51eC1pbXhAbnhw
LmNvbT47IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+PiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+PiBsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gPiA+PiBTdWJqZWN0OiBSZTogW1BB
VENIIHYyXSBtZWRpYTogaW14LWpwZWc6IERpc2FibGUgc29tZSB1bnVzZWQNCj4gPiA+PiBpbnRl
cnJ1cHQNCj4gPiA+Pg0KPiA+ID4+IEhpIE1pbmcsDQo+ID4gPj4NCj4gPiA+PiBPbiAzMC4wNS4y
MDIyIDEwOjQ3LCBNaW5nIFFpYW4gd3JvdGU6DQo+ID4gPj4+IFRoZSBpbnRlcnJ1cHQgU1RNQlVG
X0hBTEYgbWF5IGJlIHRyaWdnZXJlZCBhZnRlciBmcmFtZSBkb25lLg0KPiA+ID4+PiBJdCBtYXkg
bGVkIHRvIHN5c3RlbSBoYW5nIGlmIGRyaXZlciB0cnkgdG8gYWNjZXNzIHRoZSByZWdpc3Rlcg0K
PiA+ID4+PiBhZnRlciBwb3dlciBvZmYuDQo+ID4gPj4+IEFuZCBpbnRlcnJ1cHQgU1RNQlVGX0hB
TEYgYW5kIFNUTUJVRl9SVE5EIGhhdmUgbm8gb3RoZXIgZWZmZWN0Lg0KPiA+ID4+PiBTbyBkaXNh
YmxlIHRoZW0gYW5kIHRoZSB1bnVzZWQgaW50ZXJydXB0cy4NCj4gPiA+Pj4NCj4gPiA+Pj4gRml4
ZXM6IDJkYjE2YzZlZDcyY2UgKCJtZWRpYTogaW14LWpwZWc6IEFkZCBWNEwyIGRyaXZlciBmb3Ig
aS5NWDgNCj4gPiA+Pj4gSlBFRw0KPiA+ID4+PiBFbmNvZGVyL0RlY29kZXIiKQ0KPiA+ID4+PiBT
aWduZWQtb2ZmLWJ5OiBNaW5nIFFpYW4gPG1pbmcucWlhbkBueHAuY29tPg0KPiA+ID4+PiAtLS0N
Cj4gPiA+Pj4gdjINCj4gPiA+Pj4gLSBhZGQgRml4ZXMgdGFnDQo+ID4gPj4+ICAgIGRyaXZlcnMv
bWVkaWEvcGxhdGZvcm0vbnhwL2lteC1qcGVnL214Yy1qcGVnLWh3LmMgfCAyICstDQo+ID4gPj4+
ICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4+
Pg0KPiA+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9ueHAvaW14LWpw
ZWcvbXhjLWpwZWctaHcuYw0KPiA+ID4+PiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbnhwL2lt
eC1qcGVnL214Yy1qcGVnLWh3LmMNCj4gPiA+Pj4gaW5kZXggYzQ4MjIyODI2MmEzLi4yNThmYmVl
N2FiNjYgMTAwNjQ0DQo+ID4gPj4+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbnhwL2lt
eC1qcGVnL214Yy1qcGVnLWh3LmMNCj4gPiA+Pj4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9y
bS9ueHAvaW14LWpwZWcvbXhjLWpwZWctaHcuYw0KPiA+ID4+PiBAQCAtNzYsNyArNzYsNyBAQCB2
b2lkIHByaW50X3dyYXBwZXJfaW5mbyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQNCj4gPiA+Pj4g
X19pb21lbSAqcmVnKQ0KPiA+ID4+Pg0KPiA+ID4+PiAgICB2b2lkIG14Y19qcGVnX2VuYWJsZV9p
cnEodm9pZCBfX2lvbWVtICpyZWcsIGludCBzbG90KQ0KPiA+ID4+PiAgICB7DQo+ID4gPj4+IC0J
d3JpdGVsKDB4RkZGRkZGRkYsIHJlZyArIE1YQ19TTE9UX09GRlNFVChzbG90LCBTTE9UX0lSUV9F
TikpOw0KPiA+ID4+PiArCXdyaXRlbCgweEYwQywgcmVnICsgTVhDX1NMT1RfT0ZGU0VUKHNsb3Qs
IFNMT1RfSVJRX0VOKSk7DQo+ID4gPj4NCj4gPiA+PiBUaGVyZSBpcyBhbm90aGVyIHdheSwgbGVz
cyBhZ2dyZXNzaXZlLCB0byBnbyBhcm91bmQgdGhpcywgZGlzYWJsZQ0KPiA+ID4+IGFsbCB0aGUg
aW50ZXJydXB0cyBvbmNlIEZSTURPTkUgaXMgcmVjZWl2ZWQgKG9yIHNvbWUgb3RoZXIgZXJyb3IN
Cj4gPiA+PiBjb25kaXRpb24pLCBpbnRlcnJ1cHRzIHdpbGwgZ2V0IHJlLWVuYWJsZWQgYXQgdGhl
IG5leHQgZGV2aWNlX3J1bi4NCj4gPiA+PiBJIGNoZWNrZWQgdGhpcyB3b3JrcywgaW4NCj4gPiA+
PiBteGNfanBlZ19kZWNfaXJxOg0KPiA+ID4+IGJ1ZmZlcnNfZG9uZToNCj4gPiA+PiAJd3JpdGVs
KDB4MCwgcmVnICsgTVhDX1NMT1RfT0ZGU0VUKHNsb3QsIFNMT1RfSVJRX0VOKSk7DQo+ID4gPj4N
Cj4gPiA+DQo+ID4gPiBIaSBNaXJlbGEsDQo+ID4gPg0KPiA+ID4gWWVzLCBJIHRoaW5rIGl0IHNo
b3VsZCB3b3JrIGlmIHdlIGRpc2FibGUgc2xvdCBpbnRlcnJ1cHQgd2hlbiBmcmFtZSBkb25lLg0K
PiA+ID4gQW5kIHdoaWNoIHNvbHV0aW9uIGRvIHlvdSBwcmVmZXI/DQo+ID4NCj4gPiBIaSBNaW5n
LCBJIGRvbid0IGhhdmUgYSBzdHJvbmcgcHJlZmVyZW5jZSwgYnV0IGp1c3QgaW4gY2FzZSB3ZSBk
ZWNpZGUNCj4gPiB0byBsYXRlciB1c2Ugc29tZSBvZiB0aGVzZSBpbnRlcnJ1cHRzLCBJIHdvdWxk
IHN1Z2dlc3QgdG8gZ28gd2l0aCB0aGUNCj4gPiBkaXNhYmxpbmcgYWZ0ZXIgRlJNRE9ORS4NCj4g
Pg0KPiA+IFBsZWFzZSBkbyBub3QgZm9yZ2V0IHRvIGNsZWFuIHRoZSBvdGhlciBjb2RlIHJlbGF0
ZWQgdG8gIkluc3RhbmNlDQo+ID4gcmVsZWFzZWQgYmVmb3JlIHRoZSBlbmQgb2YgdHJhbnNhY3Rp
b24iLg0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IE1pcmVsYQ0KPiA+DQo+IA0KPiBPSywgSSdsbCBt
YWtlIGFub3RoZXIgcGF0Y2ggdGhhdCBkaXNhYmxlIHNsb3QgaW50ZXJydXB0IHdoZW4gZnJhbWUg
ZG9uZSwgYW5kDQo+IGNsZWFuIHRoZSBjb2RlLg0KPiANCj4gPiA+DQo+ID4gPiBNaW5nDQo+ID4g
Pg0KPiA+ID4+IEVpdGhlciB3YXksIEkgd291bGQgYWxzbyByZXBsYWNlIHRoaXM6DQo+ID4gPj4g
CWlmICghY3R4KSB7DQo+ID4gPj4gCQlkZXZfZXJyKGRldiwNCj4gPiA+PiAJCQkiSW5zdGFuY2Ug
cmVsZWFzZWQgYmVmb3JlIHRoZSBlbmQgb2YgdHJhbnNhY3Rpb24uXG4iKTsNCj4gPiA+PiAJCS8q
IHNvZnQgcmVzZXQgb25seSByZXNldHMgaW50ZXJuYWwgc3RhdGUsIG5vdCByZWdpc3RlcnMgKi8N
Cj4gPiA+PiAJCW14Y19qcGVnX3N3X3Jlc2V0KHJlZyk7DQo+ID4gPj4gCQkvKiBjbGVhciBhbGwg
aW50ZXJydXB0cyAqLw0KPiA+ID4+IAkJd3JpdGVsKDB4RkZGRkZGRkYsIHJlZyArIE1YQ19TTE9U
X09GRlNFVChzbG90LA0KPiBTTE9UX1NUQVRVUykpOw0KPiA+ID4+IAkJZ290byBqb2JfdW5sb2Nr
Ow0KPiA+ID4+IAl9DQo+ID4gPj4NCj4gPiA+PiBXaXRoIHNvbWV0aGluZyBsaWtlOg0KPiA+ID4+
IEJVR19PTighY3R4KQ0KPiA+ID4+DQo+ID4gPj4gVGhlIGluaXRpYWwgaW50ZW50IG9mIHRoaXMg
Y29kZSB3YXMgdG8gY29wZSB3aXRoIHRoZSBzYW1lIHByb2JsZW0sDQo+ID4gPj4gU1RNQlVGX0hB
TEYgaW50ZXJydXB0IHJlY2VpdmVkIGFmdGVyIEZSTURPTkUsIHdoaWNoIGNvdWxkIG5vdCBiZQ0K
PiA+ID4+IGNsZWFyZWQsIGJ1dCBpdCB3YXMgbm90IGRvbmUgcmlnaHQsIEkgY2FuIHNlZSB0aGUg
aGFuZyBpbiBzb21lIHJhcmUNCj4gPiA+PiBjYXNlcy4gV2Ugc2hvdWxkIG5vdCBydW4gaW50byBp
dCBhbnltb3JlLCB3aXRoIGludGVycnVwdHMgZGlzYWJsZWQsDQo+ID4gPj4gZWl0aGVyIHRoZSB3
YXkgeW91IHByb3Bvc2VkLCBvciBtaW5lLg0KPiA+ID4+DQo+ID4gPj4gUmVnYXJkcywNCj4gPiA+
PiBNaXJlbGENCj4gPiA+Pg0KPiA+ID4+PiAgICB9DQo+ID4gPj4+DQo+ID4gPj4+ICAgIHZvaWQg
bXhjX2pwZWdfc3dfcmVzZXQodm9pZCBfX2lvbWVtICpyZWcpDQo=
