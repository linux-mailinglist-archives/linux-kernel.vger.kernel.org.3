Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9589351FA96
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiEIK7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiEIK67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:58:59 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EC0275D1;
        Mon,  9 May 2022 03:55:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMNPi2GkHyzAXDD9C+EkMaK3tgjeK2PsrcrDv341SZ90+pM8NsMZNgtWCErtSqH7l2ZKsHimfR9Aye2Tqm2qoEjRBBV3FQsHAFORRvBK6wgYsT5f1plkh39Kf9u9cPK2IUdC8XE4b/9+EAS/aDSa6vbXxV4MtJediYn7XYKt02oWfVXs74I9ThCDmf1qZPwnlqMgBV+C+X/0uIedyHS++mw1UZETJl5ldabvBkqYRE3uA2bZMh2k4MqgYjb99RkAuUAWBo5QwmguVbyZ0wCOACKfV3sf7/+8dPvrLpJ1M3DlfwKmF5/H/LnL+KrnNTqstbMeGd53YaeVgSqLUJaIFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvVggZC2j8/mIYPqXWF+hYg88SIDq1oEV9wskdFALlU=;
 b=PeZXCE2zOflcfG45mr3XtA9b7NgkH77BVzuYOqLHYs17P/fl7nAtpin/J/ZSpSwMALGCX3xYO1xv/7u4EGoKryciHaDyJSUOAyUfBrVyKVZHYPUB/49PNDspBCLklsXk27VLydfXKh7b/MFB2nHTIuUeAY3+fvw4aVlHKM2Nc3i0GJWxy2X9NspVLauM0ex2DzpsCVUJwdrsp6TzwxBj7yT8CeA8W5Ks1F5Cy48G6nU8Xbn2QVYSfkVw0jhGtYA7lTFAeW0BOw9ReyoOUP2GUQYR6FCdhrGRAHtk3EFhdtUHKzbiMZsuZwPzvr/hk/5gzMs2isEJfwnZtVssws6LXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvVggZC2j8/mIYPqXWF+hYg88SIDq1oEV9wskdFALlU=;
 b=nmf5mRPhCGotkVvpFTEzb5Wr08IvHKJRFbenbXtF6gjpKWV1NlZFXK9sqJEFbvgbU5sJRbn+nx5HX+OaIqFwTUrAod8PPgRofJZ5M9ASbVgrv+TPiXZyZCzGDAX1xu2uqsJIZRCaoUJyAtyY/U8MYVZK4fwo8fmf+UwgjcJ6b4M=
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11)
 by DBBPR04MB7771.eurprd04.prod.outlook.com (2603:10a6:10:1e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 10:55:02 +0000
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::1d57:4a64:1c30:a00f]) by DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::1d57:4a64:1c30:a00f%6]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 10:55:02 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCH V4 3/4] arm64: dts: freescale: add i.MX93 11x11 EVK basic
 support
Thread-Topic: [PATCH V4 3/4] arm64: dts: freescale: add i.MX93 11x11 EVK basic
 support
Thread-Index: AQHYY3ZBuKXJjmos1kO4VQI5TYCaJq0WXjIg
Date:   Mon, 9 May 2022 10:55:01 +0000
Message-ID: <DB9PR04MB847748A8FEAA598E791560EC80C69@DB9PR04MB8477.eurprd04.prod.outlook.com>
References: <20220509072911.3268668-1-peng.fan@oss.nxp.com>
 <20220509072911.3268668-4-peng.fan@oss.nxp.com>
In-Reply-To: <20220509072911.3268668-4-peng.fan@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed87b242-a4a8-4eb0-0d95-08da31aa5e5f
x-ms-traffictypediagnostic: DBBPR04MB7771:EE_
x-microsoft-antispam-prvs: <DBBPR04MB77712ADCF4589D1A059908E880C69@DBBPR04MB7771.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zxq5ARurJZQLnqvZGELhJDI+Qk6qngLM17YFXPn/xYrkIbh+wFCT321ZYpCNA4pqdbz8QTS6QBUwRwO3D/9S5nK0K4Tgmzn15NUFbJK6c845pG8RtHsrno2p9mpgoIiR0vgqAX96I+FYfXXIopt9ejO1O6rJLQ+W03KsfPsUQtOcrjAVwz7xuVNtMaDasdFLizb/xN0OwCkp3ppw4OL06Lagb8I+qcy5MvTSyPEarPb0UAiIm18ZwOVx7S3SQyRx6lrxNgM0RHaaDhTBiamLY/GNSI/FSK5KvLPv5yciiH4sLllyvwTwFa2eKiqJ/hkgxz42/viPZlW2/XuA+PZiKDxL52i49xS2swiNJB6ojUtmtq7oIegHiDy7Jk82/IQ+qs5eG5xPvGoAg1oO4LQ6J9jD5h5HLHZhM8Sa/weX380rOjJEzk/ZTaPnZ8K8zowondTxuWi9Mc+Myp/e/R0PLanNOzJkzfMcpdTQlTQXZFv1x2oSrV8GP91KSu5AbPF7YWRq7brfHgv2uWVj2XENamt80M/IIEO+ZHgFs7jCPUAvF1ms0lUxVIhf33prciXrd55XUVv1q0Wed8jGS7Ie/EptdznDcm7OGyjiKgpBm8W1EbzbYUwrbukcRz+8l08Bi+zNuJit2/BzKc0K32qodGPA2gMzEnlE7YXtiBiNqOCjJmWYyyAaaPzJRAhZ0eOjvPBxJiXCATQeecPCpSGy5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(7696005)(6506007)(26005)(44832011)(4744005)(71200400001)(122000001)(5660300002)(33656002)(186003)(2906002)(8676002)(508600001)(52536014)(8936002)(38070700005)(38100700002)(316002)(55016003)(76116006)(66446008)(64756008)(66476007)(86362001)(66946007)(4326008)(54906003)(110136005)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGdoL1NPcUNRNUE0SnVyQndJUU1mZDJtQ3RTZ3NUK0dMYk9mSEF0WGxXYm0y?=
 =?utf-8?B?c3ZITEpaWkRlV01FK1k4bXFjaWNRNUxIV01pMUJxc2NGVXZlR2JRT1JHNzJX?=
 =?utf-8?B?NVFwaTI5OSsraG8ycTFOd0dVcUVXNVJDb0l2UEllR0EvcklaQVk4T2tTZVF4?=
 =?utf-8?B?LzBybUJVT1hEcm91Q0NHMUlnL2M0azFoT0UvRU5EdzhGVGRjWVZXaUpmeHQx?=
 =?utf-8?B?YXUySDBwMWNUKzVYdTJLcHQzaGpGbW5IWHNwRlcwRnFZa0toRjFPZXh4VFR6?=
 =?utf-8?B?V054TTdqb2F2WVNoVHRFdmVRRWtqRTFJVDVoakhmNXpLZjlEWGN3WGtST0Zq?=
 =?utf-8?B?Wis2clh3bkdDTGRKbjFpaXpyRUpSQWJWbUg0YmJxOGhoVFJZUWM1My9Ualhn?=
 =?utf-8?B?L25TWDZ3Q3RWUHdXY25xZVUxQWhGbDFMNDRiWUZSUDlBZlZpcXRHQmlXSTJC?=
 =?utf-8?B?NHRnUFp4akpqN0lsQVdCYXAzQ01mN1phYzZRMk9YOXlWUlkydFJVZGJuTTZm?=
 =?utf-8?B?YTVzeC9ndXQzU2RKb3o5SjNxOGpGdG1BV1hMcGRFamJ1eks4NmlrSGV0cjNi?=
 =?utf-8?B?bDM1MGdJYmlaSXdBd0hScmJFRG45Z01BRVpYaUpFdUNnSVZuUEw4elQrRjQr?=
 =?utf-8?B?K01WQTVMd0VjQitjUkNwTUwydjdlK3Rxa2tKdUtqRlMyWXpPaHFpTHJyWnM3?=
 =?utf-8?B?RFJ6M0ZERW5zUTVYU01TNDlCWndCeUh0SlhxOHEzZkJHS1BrRVJ0MUV3dWph?=
 =?utf-8?B?RGh1bm5MU0l2ZDlOWWxwQTRaQTM1TDNKUTRJdXQzSGJPMDQ5MTVaRk03ek9i?=
 =?utf-8?B?L3BLdEtkNUNSTDJCbktjeitVWFVLU1dkaFlyZUF6QUFQejdmSTZOWEFpamZz?=
 =?utf-8?B?cTdGcGE4TkdmdTFEOVMvOWs5VGg5YjZmVDZJczB4MGxzck5Zd2UrKzlCbzc0?=
 =?utf-8?B?K2hRVStuME1qNzBNc2FtV3JqbTVWcEJ4YUtuVjZzY0FJUC9CcnlpTUVIRDdH?=
 =?utf-8?B?OXZVbWNwV0piUFowbDdNUS9MK3VYNE5VaHI3N3ZxY0xPZVZBR3c4WmFlaVRl?=
 =?utf-8?B?RFpYMXlsbUVmOUU0NnMvOVcwRUJzZHZ0Y29PdW40STZBM3hLVXgwSUs5Sngv?=
 =?utf-8?B?bmFmRU1wSE1WakhhTUU2d0xFeXpaZm1rMC8wYkh5M3FpL3h4dFNFYnFva3Ru?=
 =?utf-8?B?YWRWRmdXalh3SG96c0JrWHd6Uk8xSEdJdHVHdVluQ1NBeUllb2dvWDRWZjJz?=
 =?utf-8?B?WkMzQUpZUExhZFpIYllNZUEzaGpSeEMvNXE2dTlBRzRjbXJhZkdabzlrRFky?=
 =?utf-8?B?NnJUKy93dDU1L1J6QXdBK1k2RlRGU05iSW1jNjNzNlZxL2hvOHl3ZGZpd2Fj?=
 =?utf-8?B?L0RMWW1HRnN3aUQ0elZVekl1cnNDN2w1N2NwbGFSc296NmkzTTZ6cElROGpz?=
 =?utf-8?B?bnRBQlNsekxXRHRvdnFjeHhtNEx0ZUtlSEwvaTZtcG1yN01BZFBYUE5xY0Ra?=
 =?utf-8?B?RGM1dDNYbnYwN1ZWRTZtTHdYeXh4T2RLZ2crYnEydXc1VWlvTmZ4ODd5TU5v?=
 =?utf-8?B?bDMveTFpTVpSbWhkVEYvV2lESTZiaEdReTFxUFVwUWVUdUlGcmJ4N29JbUdq?=
 =?utf-8?B?RGhlQm5mMXZuUGsveXplTGRvYjQxMkE4eElhZTRVNW9QMUJYWCt4YVpRNE43?=
 =?utf-8?B?b01iR3BMOFRxcmgycGtQTDBJQmRoclFSME1PdVBPcVhsWER1eW9YNU14dm5t?=
 =?utf-8?B?WXRnK2pTSVdnK0k3R0lOTHFzTjRPdUczclpZWFlhM3lnR0NjNGlhd3VzSXd0?=
 =?utf-8?B?WWF5bEJTVXp6RkRVNFhpZkVuSTY1MThZWlNFd2xHQnJTMnZvTkp4a3EzeVhJ?=
 =?utf-8?B?akdkZ2lTVno3cUtiWEtuUkFYeC9MMGQ5NFMwTHBRWU1pM3hPMGYxdU56NVF0?=
 =?utf-8?B?L3crUVpyVEJiYTNFVGlqa2JFTzV2aFdvYkhqaHdrRHZhU2t3bnJYRVkzNVYv?=
 =?utf-8?B?bW5NRXVUR08yYmFVWG54Q2tVOVJQRHcwNk1WeXJlUzlrYnJudWJ3ekVJZ1BD?=
 =?utf-8?B?Y0ZEWlNDOUI5eU5FMDFsSGJtdUNGQjc4MnNyR2NsYmFTa3JrK29hQURkdlV2?=
 =?utf-8?B?NnNMUUswdy9JVlo1YllFSHV4bnBEcmFDZzZ1Ukc3OWU2dXMvOTJaSFJyV0lo?=
 =?utf-8?B?SmxQa0lPUmt5OHFHUkR0R3dKc2x5QXd3azNyM2VPVlpoS2dEMnR5MFBMaWF6?=
 =?utf-8?B?N1JWUGo0ZXhyYSt6R2FhM1RjaWs3M2xBK0pDY1JJbi9XQjJ5bDJVOFBUdnps?=
 =?utf-8?B?STBMVVB4THFQRWM2VDl3a2lXS05zZXp5b3J3dEM2Q2NiVWtUKy9FUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed87b242-a4a8-4eb0-0d95-08da31aa5e5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 10:55:02.3679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: reKIqrZ2lkzBP8Nn1Lux3dbG/ny+QtveGpxVdYUP5rYHHYjKVggszFrRd1NLACPGWHCbmzZpMHlGo/OMLYSF+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7771
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiAoT1NTKSA8cGVuZy5mYW5Ab3NzLm54cC5jb20+DQo+IFNlbnQ6IE1v
bmRheSwgTWF5IDksIDIwMjIgMzoyOSBQTQ0KPiANCj4gRW5hYmxlIGxwdWFydCAmIFNESEMgZm9y
IGNvbnNvbGUgYW5kIHJvb3Rmcw0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcu
ZmFuQG54cC5jb20+DQoNCkxvb2tzIGdvb2QgdG8gbWUuIA0KT25seSBhIG1pbm9yIGNvbW1lbnQg
YmVsb3csIG90aGVyd2lzZQ0KUmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25n
QG54cC5jb20+DQoNClsuLi5dIA0KDQo+ICsNCj4gKyZpb211eGMgew0KPiArCXN0YXR1cyA9ICJv
a2F5IjsNCg0KSXMgdGhpcyBsaW5lIHJlYWxseSBuZWNlc3Nhcnk/DQoNClJlZ2FyZHMNCkFpc2hl
bmcNCg==
