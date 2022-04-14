Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CB8500403
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 04:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbiDNCLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 22:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiDNCLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 22:11:06 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20071.outbound.protection.outlook.com [40.107.2.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745F140E4C;
        Wed, 13 Apr 2022 19:08:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HD2uWGv/5EjOqx6hoHibi3K6JuwVXr2VloHhLpGDcqrdFNhRLg2EepMPqOv6GT5kf+HbVDCaMbLm4iO5yBjDNu6u/tOq1UPepLGedPVQhhNb/Ai73CvexUfQxGtJwIuixOXDnqF2/JVry13HUQupUjqouigmdVYLYapto8P3oXxswOQdKwqty4NsMG8jvBhtAh2FUw8sH5Z6LOb8XLFGAdjXgSAkyXeHeb6ewvbpmjuG8EAJDF2bvhQW9sNbyCskN5fIeRQ1fxf181PgG7Wte1umPD1aPSmjHX9p3C/C6jfyFts+1guQdEf5B8D3ya5HJoO+Ed92LpCo1Ry//b/ldA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53yAByBzNcFMMelDN2lfbWFx/EDorxm637qYrXzVpXs=;
 b=GG+LMIyMk6xyrMMMRXFWCe+v5KNfF7nUfaGGlVnMuLKHaO59iLfr9Qp8bN8iBoh9gfH3kdfZ+5cYmpuh3x//nXU6WyAOH2DRWFNjntUgt/6dAQWtuRnuZ+2se0uuLpT6N7HEIZJDJkXgrnU8oGII4GBHmF97IE9TrUke9TxFhB+c5bNHOVfvfHCENDbc+wlSc+pcVuZfV6ArLA+S8NvY7I31lz0R8suRTvjI/CzYX7AgwWmfJkhNGNsmdqlwaxF2F/MqIYiFueFp+h5z7cRCeYeCUxKiMuDqns2Q4y6DL90CGE9RHTThpeRcoiT/hlfuATCwcurZUghAAOlMm7zX7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53yAByBzNcFMMelDN2lfbWFx/EDorxm637qYrXzVpXs=;
 b=EzaCPjKSA0jd/BZd9GfDlPz8HpXROYyi0w83xHvedN6gsc+LpnJ2/yGEvvB6RCxfeMz4n1mxzbU0oncumc84XisDoYxp+h1nksh1ilwskhzyQHKAy3NFmzZ4MBqT5UsVYcc7wNkIvg2OG4nHzqDsi/7V62L+z+IxTVAKz0mE1FA=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM7PR04MB7192.eurprd04.prod.outlook.com (2603:10a6:20b:11e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 02:08:39 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5%6]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 02:08:39 +0000
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
Thread-Index: AQHYTlzDTk+nMPblHEOtVFBEaJlTL6zuLgwAgAB5d7CAAAJ7gIAAAcSg
Date:   Thu, 14 Apr 2022 02:08:38 +0000
Message-ID: <AM6PR04MB634124EADF6550B4B6371980E7EF9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220412110155.21427-1-ming.qian@nxp.com>
 <CAOMZO5DmvVJuBU-PzrJ+ru1C3sJPtHshmtxmcAZPTu-p56SAKg@mail.gmail.com>
 <AM6PR04MB6341E52AF70FD61EC96DB58AE7EF9@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <CAOMZO5BUPbmsBDf1yx3QnoexbyW4=vb2HNE733F0Xb1P7-VTHg@mail.gmail.com>
In-Reply-To: <CAOMZO5BUPbmsBDf1yx3QnoexbyW4=vb2HNE733F0Xb1P7-VTHg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2a18d44-ef97-407d-e7f7-08da1dbbb0ef
x-ms-traffictypediagnostic: AM7PR04MB7192:EE_
x-microsoft-antispam-prvs: <AM7PR04MB7192C3869AE65CF035CCB8FCE7EF9@AM7PR04MB7192.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pIQFxgdDgUAhDHdIovlRz0bvEf8V3Yq0wqPYeAjzOsWRQFo473j7baqT3A+KzyD4YHYBE1vzxrd5eOGi6nbgnFo2QEqT+Eg3mC/3n57CHsq/ZcC7cPHJ++QYhuDeOtMIVJziUMqHyJrw4/BQzqtZsUNSXExJ8BawjroJ5SJW9NLE3TT6R5Dhjg3UWXosyT4tEgS0MFlF5alFkmsMKA+GbHCSU9uKrV18V2Ch3Kco04rCVKY+9A4b51cw1YvlV99FIQRwP2kySBKq9Zi0C3FYKiQD213eIL5aCvygJysBPjjv5RILtXGGpCStve+Vbs/3N6fmnI6L9F8SMk0IpdVb7aWiyLygUYCpswmHeDuwPur2gAvbZhVge1JAjhSUuO83D7k0cTkphufmtlJNUN3GX/G5KHGs8vJqcDrLKaXqIHidYWODnJ3i8zP+NZv++E80rs4OOCSoPfuGid8elPOlFl1TtL+vF63yVZFwz6SVJUHpdYAlao6FNYMm4XD66yJNkWAfsy4K8ttyNAXHD2kcxlGQAmd5VfaHYUYN6tlP5vUlQaGE68VSWZgDomPNyqaqsT+FcF3LTH9P+U0bz4F6ZcoX61nCcUFnxv1jbSkPjBLrrcORRp2mPhzEJ/Ntbew8VPY32lFyTynSgpYTogmMUnpW8535AHby2CpiCisW+5UhfdFM2ozB/hwpdMlQDGm4Oom9phPSx7N38zslzokmig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(6506007)(33656002)(7696005)(7416002)(2906002)(508600001)(4744005)(44832011)(71200400001)(316002)(54906003)(6916009)(5660300002)(76116006)(8936002)(26005)(52536014)(4326008)(186003)(122000001)(66556008)(66476007)(55016003)(38100700002)(64756008)(66446008)(66946007)(8676002)(38070700005)(9686003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1BxdnRBTWRoWElPZDRodDhNVlBqbE1PcFNac2M3U2QxNWdJQ1BabFViRzlK?=
 =?utf-8?B?K1R6UzdGSWxmY0h2RG1veUFWSTJMY0lUSGNVU2t5S29rK08xOEM2RnFVenJM?=
 =?utf-8?B?TUlsa29WYkdqblYrVXM1ajl2bWN1MWJZSldKZXNXSTgwUGxZcS9WTVRJdURW?=
 =?utf-8?B?bUJhVzdFSVVzZkFKVlhBeVVBTjYvWHV6Q0ZNSTQwVVFEUTNZSW8ybllSQU14?=
 =?utf-8?B?d2FXRmx3UGU0R2tralhLRUV5eVV5NmpKeFJURW03U2ZiZmgrdzVBMk1ubG0z?=
 =?utf-8?B?dStWVkpXem1WUndyRTNVdW1kcWpKMUNEckJJTHhlZ2JlbzFTVnh5cDEwcWFY?=
 =?utf-8?B?cEtocWNXQ2c3U1l5L0k5QXJMRG0zWHBlV2w0UkRQb1NtWURBTmdxOEc1Zk8v?=
 =?utf-8?B?U1M3VkZNWjJkV3AzZEt2ZFQ4ODY3ZGhuczBZS1pHQ3p5S0hGcVRwSTRPVlZP?=
 =?utf-8?B?a1FYcktUQ2JZbTZuSWw1ZjdrS2g4dk1VZzNkMWJwR0FVOXlJTlRFTFQ4anph?=
 =?utf-8?B?OWZVdEV1YXF0ZzZzNGgrUGd2NnlWZTNWbXQ2MzVuN0IyUnNLZVhlUzJYN0c1?=
 =?utf-8?B?V2tNUjdnTUdHcUsxV2R6Z0dQWUxOSGpLOGZxbVBYRXlldWtpYmYzeEFjWkNL?=
 =?utf-8?B?NHRBaU4rbHVDTEx3dXMwTGJDL1hNS3lVSzZuOU12ZVNIRm41aFkyNGFkVkEz?=
 =?utf-8?B?UjlUZ2xmNUxudHJ1VCt1anNLOWx5MWNuc1RjTXR1bk1sTkpNNGkxNi9zbndN?=
 =?utf-8?B?QVZlMFR3aTBCcW9EY0htZFkrQWNURmhnWHVFWTYvNXF0aTF0dHpZSmNMTzFV?=
 =?utf-8?B?VkJBN2RQYTBocHRNMUNqRVBjKzV1QWhRY05Yd1ViaHFHL2h4NDZSM0JlN1pP?=
 =?utf-8?B?TVpKcFh0UWw2Sm9USUxUeTJRdGRIVG0zN3Q5TC9DV3p3YWFnNkVaRTRZa3JN?=
 =?utf-8?B?L2N2TFVwbG4wejJVRCsrWTF3Q0FEN243eE9aQm93a2QrTWRjZkd5UXA1YTdK?=
 =?utf-8?B?b3ZoVUxXbFI3WkllRE1acCttM0R2ZHRtNERCeS8rZHlvZjk4dnVEYjU3WVlF?=
 =?utf-8?B?YTFNaHRyWDNpRzc5VTB3WElUZHJ3V0JDSGhTVTdVYXRQQkRvdG5XS1hYNVNi?=
 =?utf-8?B?eHpQajY0WDJlRUYyTkRuWlI3cEhmb2JQeVpuS1VKK3p2VTc0bjhXWmQyQ1NG?=
 =?utf-8?B?K0FLZ3dKOWxsQjRUelF5THBJWkdBZ3ZOcTBTWkpGcGhvdnRYc2lKNlJPbk44?=
 =?utf-8?B?NDZ6WUhFTjJHbWRDei9UWGl0YWpmWnZlOER4WkpacEd2MlNTMUtuTTRkRW9L?=
 =?utf-8?B?c0l3REI0cGJhNmJCVy9zdUVYaGxCVUZUa3ZsQjdRNldvazdJOFh6cEJoZ1FX?=
 =?utf-8?B?cnMxZjlib0hiK3l0ZG85eHdaeHg3Yy81dU1kRHp6L0FMOVJFUnZBZUo0S3Fs?=
 =?utf-8?B?aWpxU2JpU1Vmd1JhVDFOQWFoVy83U1F1MUQ5ZGxsQWJVaUlkRHBwczR3MjdJ?=
 =?utf-8?B?dWdJVWw0RDh6QmorckNzS1F5LzVsM2lEd2E1MmNRWXk1bDNkcnNySTFzc0FT?=
 =?utf-8?B?eWlFZ1Q4UTVhMTRvUHd1MDRZT3BBSy9FU1BFNkRvSTlyR1hCT3VOcjFrUHJS?=
 =?utf-8?B?S1JwUytaWjVKV3NrU29NOWJHZExnalBid1cxR2grNllpL29ZYVlQNTJWc0NS?=
 =?utf-8?B?dEwxRjNSbDErazZMTytacHpKZkx6eFREVXYyVHZhTFdmK1ZkUkYrZ3JFN1dt?=
 =?utf-8?B?RHR4U1FacFBhWUIxYVkzZUNCclY1RFNrZkltWmt2UGlXZEtoelFKMTY4N0tv?=
 =?utf-8?B?clV0bFp0WXIrdWw4R0MzdkNzQVE1UjIwVk15QmZzSVF3UjRNMTRFbUtaNGdm?=
 =?utf-8?B?VDJBNWZNVlBZV2dVcWtVd3M0VUVrOUlmNnlSTGk5akpDOFdSWTdZYVE1Znl0?=
 =?utf-8?B?R1pMb0Y0MHQyanFaNG5OaVMxTWFubFZNcHl5UkNsWTZ6Tlh6ZEk5SHpnaGJn?=
 =?utf-8?B?SFBLM2RhTXh0YVdMRWxLd2pKT0IzaC9HVWZoQUJHZHVNNU1uOFJ2MGw1SytB?=
 =?utf-8?B?a0tRQ3pyb3lqYU94Q2loanp4VXA0MFVhb0p1bTFZbkxwRithUll2NEtqQzlJ?=
 =?utf-8?B?REZMYUV4R3BibTlBemRYemNwdENJNzJlNkhVQ3E2cTM3enIyRzk4VVhjSzlr?=
 =?utf-8?B?elZoWGJYNG5Wd2hMK2RRdzZ2eEYyV0RESXhmVXJ5dTFFVVBYWEY2Z245NFY1?=
 =?utf-8?B?UEJpR0VGK1UycUlMMzE2VTVzMXhQNktpK1dEcWlJK1ZCd0hzODYxakFtSWlo?=
 =?utf-8?B?R3NOVlVZT0c1ZHp2VithRHRGOHJkV0o5bUl3UEdwNDJzejBEZGVwUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a18d44-ef97-407d-e7f7-08da1dbbb0ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 02:08:38.9698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OzGGSHu43MXOB1DeiFe9OVuHaqS0V9WE9Sfj+2ZLCBdntjLNQuci0CmRMRRLIgEDvbi3NRn7AOQ4a8eZL3SNRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7192
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
OiBUaHVyc2RheSwgQXByaWwgMTQsIDIwMjIgMTA6MDAgQU0NCj4gVG86IE1pbmcgUWlhbiA8bWlu
Zy5xaWFuQG54cC5jb20+DQo+IENjOiBNYXVybyBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWJAa2Vy
bmVsLm9yZz47IFNoYXduIEd1bw0KPiA8c2hhd25ndW9Aa2VybmVsLm9yZz47IEhhbnMgVmVya3Vp
bCA8aHZlcmt1aWwtY2lzY29AeHM0YWxsLm5sPjsgUm9iIEhlcnJpbmcNCj4gPHJvYmgrZHRAa2Vy
bmVsLm9yZz47IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT47IFNhc2NoYQ0K
PiBIYXVlciA8a2VybmVsQHBlbmd1dHJvbml4LmRlPjsgZGwtbGludXgtaW14IDxsaW51eC1pbXhA
bnhwLmNvbT47IEFpc2hlbmcNCj4gRG9uZyA8YWlzaGVuZy5kb25nQG54cC5jb20+OyBsaW51eC1t
ZWRpYSA8bGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnPjsNCj4gbGludXgta2VybmVsIDxsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgbW9kZXJhdGVkIGxpc3Q6QVJNL0ZSRUVTQ0FMRQ0K
PiBJTVggLyBNWEMgQVJNIEFSQ0hJVEVDVFVSRSA8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnPg0KPiBTdWJqZWN0OiBSZTogW0VYVF0gUmU6IFtQQVRDSCB2Ml0gbWVkaWE6IGFt
cGhpb246IGZpeCBkZWNvZGVyJ3MgaW50ZXJsYWNlZCBmaWVsZA0KPiANCj4gQ2F1dGlvbjogRVhU
IEVtYWlsDQo+IA0KPiBIaSBNaW5nLA0KPiANCj4gT24gV2VkLCBBcHIgMTMsIDIwMjIgYXQgMTA6
NTIgUE0gTWluZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNvbT4gd3JvdGU6DQo+IA0KPiA+IEhpIEZh
YmlvLA0KPiA+ICAgICBJJ20gc29ycnkgSSBtaXNzZWQgaXQsIGFuZCB3b3VsZCB5b3UgcGxlYXNl
IGdpdmUgYW4gZXhhbXBsZSBvZiB0aGUgZml4ZXMNCj4gdGFnPw0KPiANCj4gWW91IHNob3VsZCBh
ZGQgdGhlIGZvbGxvd2luZyBsaW5lIGFib3ZlIHlvdXIgU2lnbmVkLW9mZi1ieSBsaW5lOg0KPiAN
Cj4gRml4ZXM6IDZkZThkNjI4ZGY2ZSAoIm1lZGlhOiBhbXBoaW9uOiBhZGQgdjRsMiBtMm0gdnB1
IGRlY29kZXIgc3RhdGVmdWwNCj4gZHJpdmVyIikNCj4gU2lnbmVkLW9mZi1ieTogTWluZyBRaWFu
IDxtaW5nLnFpYW5AbnhwLmNvbT4NCj4gDQo+IFRoZSBGaXhlcyBsaW5lIHNob3VsZCBiZSBpbiBh
IHNpbmdsZSBsaW5lLCBub3Qgc3BsaXR0ZXIgaW4gdHdvIGxpbmVzLg0KDQpIaSBGYWJpbywNCg0K
ICAgIFRoYW5rcyB2ZXJ5IG11Y2gsIEknbGwgYWRkIHRoaXMgZml4ZXMgdGFnLCBhbmQgSSB3aWxs
IHBheSBhdHRlbnRpb24gdG8gdGhpcyBpc3N1ZSBsYXRlci4NCg0KTWluZw0K
