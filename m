Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32D353743E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 07:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbiE3FPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 01:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiE3FPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 01:15:43 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70040.outbound.protection.outlook.com [40.107.7.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA02BB84D;
        Sun, 29 May 2022 22:15:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTfPF8qVkbhbo3Rhq59kAv9SkKK0UWWuUxXmOTKB/i04rya0CeELX9I2kBb+0C3iyertki2ml+zlyqYkrw743Gr/NdfYTjpNMWKv9HFyYME9qZs3FWTbbpSqjaMwVBwdCQN9E9kibMcHvr8h6k9plOPLwlqEK9u199kCQ2osPZ+Nk0vYcLg92DchqYP2z3hCJbjHJ8Pl4xzHEoIoOd0agptnkqHvXSf3wK+M3++nWT1l4VlIUsWTN6h0jbS0UnZnLqm5L4XAKX8WjmTLQbxpGxL4LW6ordMw4cOnEQCmXSoNvGgyxaVMkIf8+VB6wx7AYkdoxgpWFHoe/XzGVIJ88A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kETcEO9fOSGKi5M4NWMTcwSvauRMnxBFbeoln91JME=;
 b=QUHwMSTxgT6jo/xaehy8AC8WtjjKKBT8hQxHZZJzLLn8UiTLYvAwmHU9zHit97gtCC6nO+TwmV1KjNG52Dsa/c2eQUdj4EXgbOhpM1P+CqkibRJ2w1isGCwI7oXxwEiabgCr6oeUGBstwm1cppVm08ZqInmUBUV/jdFskLYNaOmlFT7snbDDRw9I6+N4xS2YpmUXGBXWMX85c38GShTg9ABZB2/+djYBR5vS//KvrKI+m+qzECPWr+ftSlsmNSrb8fVP0pc33p0aliAXDWDMhoy1LxNrxBpBwb5nz0QIMgaq3PxhpFrZp4YLGtABANoeNFEFrKehRmp4/Task13V0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kETcEO9fOSGKi5M4NWMTcwSvauRMnxBFbeoln91JME=;
 b=CCdVim8++266ksZc+mNBX6ZSqf2+fccA8wc6G7ag5Nbn1YgBt5eHwF2biAVungpmOjYeVLWZEw7XxgkO91eGHDcxh9VwQvGzQlXglQ25ltLReV55u93uae5I2NNX7Yk9buH149RDuf2aHODP9qyHQItTCQ9iAgl92Dje/u9TxJ8=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DBBPR04MB6299.eurprd04.prod.outlook.com (2603:10a6:10:ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Mon, 30 May
 2022 05:15:37 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5293.018; Mon, 30 May 2022
 05:15:37 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Kees Cook <keescook@chromium.org>
CC:     Shijie Qin <shijie.qin@nxp.com>, Eagle Zhou <eagle.zhou@nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [EXT] [PATCH] media: amphion: Replace zero-length array with
 flexible-array member
Thread-Topic: [EXT] [PATCH] media: amphion: Replace zero-length array with
 flexible-array member
Thread-Index: AQHYchDqai45myp5JEWPEFVOGiCbc6025EBw
Date:   Mon, 30 May 2022 05:15:37 +0000
Message-ID: <AM6PR04MB634164FBE17910C3B00FBEF4E7DD9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220527212953.797574-1-keescook@chromium.org>
In-Reply-To: <20220527212953.797574-1-keescook@chromium.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6dc45332-c7ca-4354-2e85-08da41fb6e78
x-ms-traffictypediagnostic: DBBPR04MB6299:EE_
x-microsoft-antispam-prvs: <DBBPR04MB6299F1100D11D447C1B44033E7DD9@DBBPR04MB6299.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lZf6YpmBSoRg/dRK2wRddUE0afvn3OSGhYCKophDAtrBzshJaY7/1iQp3286Q0XNH2yTbS5AaZwtBfiEExgmHRLZuQF3t8qkHFphB1fSgwodSGsFoqnPSItzW92IxyZY1k1G4B4CJY6y8AtDAgPlU+r/kt9lMYTqWRvZmVa0jST+PdwM5i9mlD9qpGG1ExozFlbhBk/SLaGRdoaTG1GIshIv0FnOJ4HZj6pw9uGqfZ1q3pdSj8DHcEWH3+CzDAH4DIlXFmIlNycHObCqCCN978L03RwyPJK6Z+mDPOko5ZTXvrd0y6rFO/X5EaQkn2v7jBeWcK+dTjKJV7EiwCaIFGmFkkTlOgxoThnRGMdKksWJ8+5ZGNxCw1gC8dRh6PJMd1gpRF5uBbjRlFy//e+yfscZRd9N7dK11M364RLfiLc5igN1HwVY2cd09bzwfeqjJ5p1aClMpzk0ZELDUojSC0HY7aCnwQR8rZpGPxnjR/qlO1gMvrWpPXqR+de9O3uWq3LxPqhlQ58gUZcLdJWXUHZBpfyl/JNGRYCBda9c9IsJOzmstLpsyir5atCZ28aFSwh/tbaVRQFc504EdJY03kWdnoMvM9RrgUjSJ1WwXx5jMCi3bmuZPMK7ihFoBYxZ0AwLT9wW3G4U3BSApO+Ot4y7Ul3GkdQwkAk0CRQEPFuYRt4HommI+a8Kx3e3WNBvo7qihtSpk6nfu89HmhihgLNnF6x6wszAMvTuxuUA1DtlYGKx5GPVVc6XkBlkqqypKz4uZi9RmkK18qNPn5ScOllX9gj333C8aBxoyxBvB8M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(52536014)(66446008)(8676002)(64756008)(66556008)(44832011)(66476007)(76116006)(38100700002)(8936002)(66946007)(5660300002)(86362001)(186003)(508600001)(33656002)(966005)(45080400002)(71200400001)(9686003)(26005)(53546011)(6916009)(54906003)(6506007)(7696005)(316002)(2906002)(55016003)(83380400001)(122000001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?U25Cd3Y0RExTVlZEUFRsL04xcjlqUFN3L0Zrby9xZ3czaldzMG84Q054L0w2?=
 =?gb2312?B?eHI0YnNPVjM5ZzRTYTFOMHM0ZFBjZHFqL2h2Sm1iVm9pNFdwUThVWTJvSjY3?=
 =?gb2312?B?aERnQ0FRMGVTbnlZQW10QVRQTW4wbnJUZWFOY2gwMHpPTEZadFk2a3Q3Nlpu?=
 =?gb2312?B?M0RVY1JJd1ZCSzlObzVLa1NqaWhvRFl1TldaSW9JQ244K0lTSUNRZ2dQVEFp?=
 =?gb2312?B?eXJUV1dFeXd3bHZMcTdLY1RqUzJMUGdvaUpHQ00vak1aYnBBTXdtd0hiZzBa?=
 =?gb2312?B?R1A3RzUvMHcrOWpjVGRucnlMSGNEMW1MWDlQMEJPN1JuMy9sbzF1YUZNRGE2?=
 =?gb2312?B?Y1VPT0w3YnpPRTZ6VElKR0dHMjJZRDIxSHJ6RE1aWnpTazd2ZU83aW4zdnlx?=
 =?gb2312?B?anJDNWNsUllUcGxrSktzM3ZZZGFZQmJOM2UxQk9ZZVBkZ3RmUWg1S29qMFhJ?=
 =?gb2312?B?bnNiUndFRDZINkxFWDBONkttUXIybmF3VWNpYW1lSDhWaTcwM0NTaWhPdmlH?=
 =?gb2312?B?b2xacFhyQmpha0NVUWFSdDZYWmNXbWFqS1hPc1VXWDQ1alF5OENWWExMRnpk?=
 =?gb2312?B?R21iRm8vQ2xUVzhPT3BWWmxBTURLT0dlOWRzQm9ib2lKTnJ0VyswdFhRc3BK?=
 =?gb2312?B?YUVRRnkyMWthcm1oNEk4YTFLeVB1V3J4NzFkQVBCTnRUWnd6OUx4QWZlYU12?=
 =?gb2312?B?L1ZkMGx6SGIxd0lhSTRZT1hDZi9MdlBQQzRsWXp5QUF1WWNZdndtMU9oYnpQ?=
 =?gb2312?B?cXY1RVFlWCtpNkRmbFd3ZmwxNzJPYi9CcHo3dEdubVZQTCtxVGwwMTMyekRF?=
 =?gb2312?B?Sm1mR3pOcTljd1p2ODBlejJKbk8ycHFxQm1jSTRCbDZJV0JvbkxpL0pOdWpO?=
 =?gb2312?B?VG9xcUpJZmU1eGpwWXA2UUdzYXM1MW81UVVYek5xV0ZUbWc5S1lMMUtCc0Rp?=
 =?gb2312?B?aDZ3NHpuTkVyWXprNEJ4dXF1Q1BwdWlyUnlNSzFxME1mTml1OXJBdGQ0WkNj?=
 =?gb2312?B?cmRNM0JWY1RNOU9Oa1RqYnp4OUI1djV6Y2NhWG5DY212Z0VrUXNGQnhHak11?=
 =?gb2312?B?Tmo2V1V3bzd3bzMrKzg5M3JYbitHTGNnT1RiVjRDekp5SlF1Y1FScXlEUDFn?=
 =?gb2312?B?Q05xb21hRmw2RzJEMEQrc25Nc0w3dE04ZW5WY0RjODhRbHZON1l6THVIbG9l?=
 =?gb2312?B?d1ZwNEowMngvVVF1K2xtTkwvZzFhTG9vOVdVcThFZTNGTW1kdWphdmNaMWp0?=
 =?gb2312?B?V1IyWjBkeEh6UHk3WW9ab0dVL0RFUlJudmh4aTVlS1BQb2syNkttdWkyUHZj?=
 =?gb2312?B?ZXRSaWRyT0p2eEF3UnJPV3RJdjdmd0lheThJMkZGQTFHMHNCTkkrTFJPQUR5?=
 =?gb2312?B?dGhPcHowRDV4bHB0WlZaOWhZalRNZS9zcTBvaHBIblk5RVU0MERIeVFORWNi?=
 =?gb2312?B?dFowUEo2a1hQa2xVSWNzVmVjUDdmNHU1OHM1a3R1RnlNeXpjaWtQcGxOQ2tY?=
 =?gb2312?B?d0xUbnoyN3c0aER1WjU3WVNSQThkTnhDeTV6ZWYxemdvOGV1RWxDTCtMZTNm?=
 =?gb2312?B?c3g0SU1OZjhtM1VRTll5V0xybTIyU3FkeTE3TGI5VmxVUEJyUm55M0pSMkJM?=
 =?gb2312?B?YmJPNk1oc0EzS09jdkM5ZmRZcmFmVmFBaEovS2s3eUJMZGVRNzJJdm5HNlhr?=
 =?gb2312?B?SkFxY2RNaERLWFVYdi9YQ0l3byttQU1HWmhjTTNBUU1DNE5ia1o0RU5jeFpv?=
 =?gb2312?B?bDZwNXpUZ0dkZzJsSVY0aXRpMUlKamxhVldnK3BaLzQvZUxMS1p3ZXkrV2kx?=
 =?gb2312?B?RFhncWhNaTI4UjJxTWNna0JBMHNIOGEwM2VERnU4aEhpMzdIZW9JeGhtbTNB?=
 =?gb2312?B?dkdPTWd6TXVGR2lvVXVGR3B5RmxVd3dVeDRtcDRlck1sQkNLUzJwd2Q5UzJi?=
 =?gb2312?B?Y0p6bERxOCtuSWF5SkRPemszWEk5b2xYOStRa1VYT1duK0QrdzVZaDdlZGwz?=
 =?gb2312?B?VyszME1IUkFyT1g5OFMwbXVrQkY0bEV4UkhRNVpCZlZQS2tvcTY4aHdlVVR4?=
 =?gb2312?B?aWVhRFJXN1BRUHBrRkw2SDE0VStxczd0Yzlzc3pZSzlOeno5RDBHT0FzWndt?=
 =?gb2312?B?NkpURjBxUERFNVkxdmNpOHFyV0pQWUtDZXA1TzlBWXdCZnlSck5VT0pvTmFS?=
 =?gb2312?B?NDZnUjFRc1pjTXpXRDlWM1RjalNMUTloU0JHaDVHMmtkOWZsVkFmcDRDZVpS?=
 =?gb2312?B?dG9HUFpQdVNuQnJvVVViNHB1a2tCSCttUk4wRkp4VVZWcVlFTUJqeE1qUXRS?=
 =?gb2312?B?cDNSOVBZUEhsYjU3NExWd2dYajRGZ2Jpc2JoVDUrRlhOZlNQYmZ5QT09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc45332-c7ca-4354-2e85-08da41fb6e78
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2022 05:15:37.1844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JVrbPe4OwgMLnPQf4t5Vv+5e7UDFlzECrV8DYbwLZ3AwcTHVnwEVBZHICsFnG4urbDwWV+WlKW0QKiPKe7iZ6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6299
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4NCj4gU2VudDogMjAyMsTq
NdTCMjjI1SA1OjMwDQo+IFRvOiBNaW5nIFFpYW4gPG1pbmcucWlhbkBueHAuY29tPg0KPiBDYzog
S2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+OyBTaGlqaWUgUWluIDxzaGlqaWUucWlu
QG54cC5jb20+Ow0KPiBFYWdsZSBaaG91IDxlYWdsZS56aG91QG54cC5jb20+OyBNYXVybyBDYXJ2
YWxobyBDaGVoYWINCj4gPG1jaGVoYWJAa2VybmVsLm9yZz47IEd1c3Rhdm8gQSAuIFIgLiBTaWx2
YSA8Z3VzdGF2b2Fyc0BrZXJuZWwub3JnPjsNCj4gbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3Jn
OyBIYW5zIFZlcmt1aWwgPGh2ZXJrdWlsLWNpc2NvQHhzNGFsbC5ubD47IE5pY29sYXMNCj4gRHVm
cmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAY29sbGFib3JhLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7DQo+IGxpbnV4LWhhcmRlbmluZ0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVj
dDogW0VYVF0gW1BBVENIXSBtZWRpYTogYW1waGlvbjogUmVwbGFjZSB6ZXJvLWxlbmd0aCBhcnJh
eSB3aXRoDQo+IGZsZXhpYmxlLWFycmF5IG1lbWJlcg0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWls
DQo+IA0KPiBUaGVyZSBpcyBhIHJlZ3VsYXIgbmVlZCBpbiB0aGUga2VybmVsIHRvIHByb3ZpZGUg
YSB3YXkgdG8gZGVjbGFyZSBoYXZpbmcgYQ0KPiBkeW5hbWljYWxseSBzaXplZCBzZXQgb2YgdHJh
aWxpbmcgZWxlbWVudHMgaW4gYSBzdHJ1Y3R1cmUuDQo+IEtlcm5lbCBjb2RlIHNob3VsZCBhbHdh
eXMgdXNlIKGwZmxleGlibGUgYXJyYXkgbWVtYmVyc6GxWzFdIGZvciB0aGVzZSBjYXNlcy4NCj4g
VGhlIG9sZGVyIHN0eWxlIG9mIG9uZS1lbGVtZW50IG9yIHplcm8tbGVuZ3RoIGFycmF5cyBzaG91
bGQgbm8gbG9uZ2VyIGJlDQo+IHVzZWRbMl1bM10uDQo+IA0KPiBbMV0NCj4gaHR0cHM6Ly9ldXIw
MS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGZW4u
d2lraQ0KPiBwZWRpYS5vcmclMkZ3aWtpJTJGRmxleGlibGVfYXJyYXlfbWVtYmVyJmFtcDtkYXRh
PTA1JTdDMDElN0NtaW5nLnENCj4gaWFuJTQwbnhwLmNvbSU3QzhmNGUwMDA5OTkxMTRmNzc2ODI5
MDhkYTQwMjgwYmQ1JTdDNjg2ZWExZDNiYzINCj4gYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3
QzAlN0M2Mzc4OTI4Mzc5ODQ5NzMyNDAlN0NVbmtub3duDQo+ICU3Q1RXRnBiR1pzYjNkOGV5SldJ
am9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXDQo+IHdpTENKWFZD
STZNbjAlM0QlN0MzMDAwJTdDJTdDJTdDJmFtcDtzZGF0YT1EakZJd0pDNDVwQXFkQ1A1RUUNCj4g
UUU3bjVGOEdINDVOZFdyUW9YdW5ORWhaWSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiBbMl0NCj4gaHR0
cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNB
JTJGJTJGd3d3LmtlDQo+IHJuZWwub3JnJTJGZG9jJTJGaHRtbCUyRmxhdGVzdCUyRnByb2Nlc3Ml
MkZkZXByZWNhdGVkLmh0bWwlMjN6ZXJvLWxlbg0KPiBndGgtYW5kLW9uZS1lbGVtZW50LWFycmF5
cyZhbXA7ZGF0YT0wNSU3QzAxJTdDbWluZy5xaWFuJTQwbnhwLmNvbSUNCj4gN0M4ZjRlMDAwOTk5
MTE0Zjc3NjgyOTA4ZGE0MDI4MGJkNSU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjDQo+IDMw
MTYzNSU3QzAlN0MwJTdDNjM3ODkyODM3OTg0OTczMjQwJTdDVW5rbm93biU3Q1RXRnBiR1pzYjMN
Cj4gZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dp
TENKWFZDSTZNbjAlDQo+IDNEJTdDMzAwMCU3QyU3QyU3QyZhbXA7c2RhdGE9eEt2TTRxaWd0Rklm
dkJ6TkRrYTQ0dXFUVWZsb1RuTm1DDQo+IHhQVkFobGs1dGMlM0QmYW1wO3Jlc2VydmVkPTANCj4g
WzNdDQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3Vy
bD1odHRwcyUzQSUyRiUyRmdpdGh1Yi4NCj4gY29tJTJGS1NQUCUyRmxpbnV4JTJGaXNzdWVzJTJG
NzgmYW1wO2RhdGE9MDUlN0MwMSU3Q21pbmcucWlhbiU0DQo+IDBueHAuY29tJTdDOGY0ZTAwMDk5
OTExNGY3NzY4MjkwOGRhNDAyODBiZDUlN0M2ODZlYTFkM2JjMmI0YzZmYQ0KPiA5MmNkOTljNWMz
MDE2MzUlN0MwJTdDMCU3QzYzNzg5MjgzNzk4NDk3MzI0MCU3Q1Vua25vd24lN0NUDQo+IFdGcGJH
WnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3
aUxDSg0KPiBYVkNJNk1uMCUzRCU3QzMwMDAlN0MlN0MlN0MmYW1wO3NkYXRhPXV6RXpXMUFFdHlX
R3NtSkNISiUyRg0KPiBEZk1xYTRsQ3NKam1WZno3S1J1Z3pPaG8lM0QmYW1wO3Jlc2VydmVkPTAN
Cj4gDQo+IEZpeGVzOiA5ZjU5OWYzNTFlODYgKCJtZWRpYTogYW1waGlvbjogYWRkIHZwdSBjb3Jl
IGRyaXZlciIpDQo+IENjOiBNaW5nIFFpYW4gPG1pbmcucWlhbkBueHAuY29tPg0KPiBDYzogU2hp
amllIFFpbiA8c2hpamllLnFpbkBueHAuY29tPg0KPiBDYzogWmhvdSBQZW5nIDxlYWdsZS56aG91
QG54cC5jb20+DQo+IENjOiBNYXVybyBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWJAa2VybmVsLm9y
Zz4NCj4gQ2M6IEd1c3Rhdm8gQS4gUi4gU2lsdmEgPGd1c3Rhdm9hcnNAa2VybmVsLm9yZz4NCj4g
Q2M6IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBLZWVzIENv
b2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4NCg0KUmV2aWV3ZWQtYnk6IG1pbmdfcWlhbiA8bWlu
Zy5xaWFuQG54cC5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhp
b24vdnB1X2RiZy5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9h
bXBoaW9uL3ZwdV9kYmcuYw0KPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHVf
ZGJnLmMNCj4gaW5kZXggZGE2MmJkNzE4ZmI4Li5mNzJjOGE1MDZiMjIgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHVfZGJnLmMNCj4gKysrIGIvZHJpdmVy
cy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV9kYmcuYw0KPiBAQCAtMjcsNyArMjcsNyBAQCBz
dHJ1Y3QgcHJpbnRfYnVmX2Rlc2Mgew0KPiAgICAgICAgIHUzMiBieXRlczsNCj4gICAgICAgICB1
MzIgcmVhZDsNCj4gICAgICAgICB1MzIgd3JpdGU7DQo+IC0gICAgICAgY2hhciBidWZmZXJbMF07
DQo+ICsgICAgICAgY2hhciBidWZmZXJbXTsNCj4gIH07DQo+IA0KPiAgc3RhdGljIGNoYXIgKnZi
Ml9zdGF0X25hbWVbXSA9IHsNCj4gLS0NCj4gMi4zMi4wDQoNCg==
