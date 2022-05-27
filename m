Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590B4535DFD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350854AbiE0KPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237394AbiE0KP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:15:28 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20041.outbound.protection.outlook.com [40.107.2.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E743FED726;
        Fri, 27 May 2022 03:15:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S85k4QxW65VQMEk8/OxOETxRILak8zG/EXhr0sN6Uq5WVHxRkD4A1Ipun3dHkAnm2qfbCU3BMIjYRdRxc+qxNQTFsixfhUpTKNtXI5wSSod+d9CpahVCiiDlaEGMJphSZx0HoeV1C0bj6oScv0y+XuJeteDRPfU37BXEeYlcdwZEeE1jI3qAfwxKXnWjx/teHclL9M8C1+g6bchUzKTOMkccbEDQFP3XeQxr0uu71LBj3YJMhReeL+dln3zbk72Wt/UokJfdW9zQtT43qDxl30MozJv7QtZ9Wh/xl72ftePfURMSDs3xSohj7cfIKCyAH+VE80I0PhFBBw19ivH2FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mi2YzOQ+dtopiR20ZG7xP1mPYiQk6DhUmTRzZBUghuQ=;
 b=fc9cAB7GO3f2qvVht9qlXgIJUs4KyubeJ222N83oUcXSzj0suiJjtmClNqaaG3yztu7HqnqOG3bkX3yEgbhXUkac62c06qW7KYHa8X9J0UPuw7P/828S97ad51D/qTuB3t1JxtjidSVb4JiNYPC26ucFr3mSOajgfJRW8BXGvfVHs+l1CcUZ+VcI8jHlJ4Y1wj4K9zjINpp9Xpn9Qwv/ER4mqMA6r4ua7cCWcMHeGZS3BvQZR0UpR7NleYYlxzz6JtlKtyZriNbPxmbTKt+4AAV/w/nbbGDSLndD0UOVnDVc0c2UCeI7qsFBLflI7G2GUNjNoJ8xA5xp3uZ2tsF0Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mi2YzOQ+dtopiR20ZG7xP1mPYiQk6DhUmTRzZBUghuQ=;
 b=doRw1xolorYI/cqNZjL+KzmoWcG1TvmN0rcOKfviav+ZRvavIhuUHq4x4uKc1vZPNAKXzUXsNbp1/gnpDrf4W9Je5cSrKoKyJIjWCFKW5qydDn8kjIV+RPrRC0XDkitJPAb0eXAlXbJcV/PdOER1nUClGx+2N/yDknIr5X6iEHE=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAXPR04MB8686.eurprd04.prod.outlook.com (2603:10a6:102:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Fri, 27 May
 2022 10:15:23 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5293.015; Fri, 27 May 2022
 10:15:23 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
CC:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH] media: imx-jpeg: Leave a blank space before the
 configuration data
Thread-Topic: [EXT] Re: [PATCH] media: imx-jpeg: Leave a blank space before
 the configuration data
Thread-Index: AQHYcZ8+YUShuD0M/kuLAZGNf36Y9q0yd8YAgAAC8FCAAAS+gIAAAkkQ
Date:   Fri, 27 May 2022 10:15:23 +0000
Message-ID: <AM6PR04MB63419DC504C1B3A4E55038AAE7D89@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220527075437.16882-1-ming.qian@nxp.com>
 <20220527075437.16882-3-ming.qian@nxp.com>
 <20220527093824.GF11217@tom-ThinkPad-T14s-Gen-2i>
 <AM6PR04MB634165DE21CEE8B6780CB817E7D89@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <20220527100553.GA25548@tom-ThinkPad-T14s-Gen-2i>
In-Reply-To: <20220527100553.GA25548@tom-ThinkPad-T14s-Gen-2i>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1a9731e-ddb2-4712-6d5a-08da3fc9cfdb
x-ms-traffictypediagnostic: PAXPR04MB8686:EE_
x-microsoft-antispam-prvs: <PAXPR04MB86860BEBEB0490AE514DEB1FE7D89@PAXPR04MB8686.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bgxsMKqEhANM/0WDEngI5LBf3vfWyflW/UQ2rSkZxH4xd1jYEZhJQ73tcoLbYBD7GONqrxvHTHPRcDGFhQiIRlaN+/Jji+s9CXK9VRODAdRerf40gLeQaRqsffOhCTBHKjbLCEe1dmT/HPCKIsDS57WsOi+uutdMBstCuzxydaKROOo/7RlX45IMaX2fILIjqBy8Vh6Q/vgvmK5C5MDO3gmOUBYqwVcMMqCPzug9eDA+5iF215Ckv7IqutYyy4xiuoZ/Ok1qfgMH2QKK9tuOIgAzRxCTvXk+VoP5YZTDscPWe1HRyj5zNgMJ5+BqY4fERKtJ2kDQEVUdSAD6RgynMnlmMyTH5Sk12uZ7+Nj/9jWdHjvwyUQHsipmjvSYCS5f/6NbRIjX2/kHW1AEE1RnhKnKew98ex9+z/+dlwDFPeVbaFvETVYczPfqlpc4C5XaxS8xem0G6qlECThXfWjgIrlaGGZvKSIc5rhlchb7zgOjbGN55UL+xQCGyoue8ZGl4JJR5ZSd+bwEE/A/BRPnV4u/OTCdWLJ227dBmGd+5vSqtGQFKqvOfQVqvOSCoSCG9muRCvoJ2Yn2EjatamnfjhTSFAYNCtz4ax0sWTUYtgcyrNLOMkhNzdsQaIN0wVf5dinY526Dmp3QTuxsCU0ceiuf83038KPhVi3qFH133ukSg5mNMHgdhHCqrMTiJ+vby+wZEcX8bXMzpybamln0ORvQJ2xw208Hs4FHu8pbXrEjy6RyOb85VbvIMWmnkCkdWr8XPWx9xErJkoK+az5IztixlIgirHIbE2LKLGITrcU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(38100700002)(9686003)(186003)(86362001)(66946007)(26005)(76116006)(71200400001)(7696005)(38070700005)(6506007)(66476007)(122000001)(4326008)(8676002)(66446008)(64756008)(66556008)(53546011)(40140700001)(33656002)(5660300002)(316002)(966005)(55016003)(508600001)(52536014)(6916009)(54906003)(8936002)(83380400001)(7416002)(44832011)(45080400002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?QjVlR2RsZHgzTCs3RVNCTXFtRTEzNUgwMjE2UEY5STBEdG5kNmcxNTR2SlFr?=
 =?gb2312?B?TDN5cWJETVQrWE8vaEJsZkdkYlc4ZjNYMC9HR1RWMGFxTENnMGhrdzZsdWNq?=
 =?gb2312?B?eUU4eUZURXFQZUs5MmU0SmVUUjJpMUR2dmdjRnV1dmhNRzdKZm0zYnpld1A2?=
 =?gb2312?B?V2t0dnhWdjd3NHRxQnZDazVaaUFUdkJWUFdQeE9XS0NGcFFOd1FEa2JhR2VT?=
 =?gb2312?B?ZUgzajdLWk9CSTk1Y0hJTW9MQyt3N1VzbGZEU0Q3SW5qS2hnWWt5ZXZlR0Zi?=
 =?gb2312?B?VVZPbkdrNWcvMDZ2enVSQkQ0V1Jya0p5NlpGUTZOVUZxUGRXVVB4Z2M5SlZU?=
 =?gb2312?B?ZWZHS1M1ZjlpQVNIQ3BQUjMrV0Z1UzQwSlZLN1ZHb1RwLzJBeGpxaHh4S2dq?=
 =?gb2312?B?dG9ZRnU0MGJIRml4a25QdFY2RVpWYlZvNUZ2S2oxbHN2bDJKd3hoVVFFWW5E?=
 =?gb2312?B?a0hxWlBwWEwxVHJXVXpxUkRUY2FCZ3dickpXZFFTVmdUN1RabldFbkNrRlg5?=
 =?gb2312?B?V051VTRvVDNwUzQ3UGQzU0JNSkQyK2VneGtLQUxHVGdCVnByWnFyQmYrU1pI?=
 =?gb2312?B?WGNZTU92V2hSRGtySkxCN2NNdVJJTWlxb25DeG5oNGRTb0JWeDR5ei82YXlO?=
 =?gb2312?B?Wm5EZEM5aUNscjZQL1RsU0Z1MmFrdzAxMlhqQkI0bEZPaFFGYU5zVzBIVXRO?=
 =?gb2312?B?MmRNcjd3T3AwckRUUXRITGxuRDdDREhBTWpWWHhDcDVSNCtxU2tPOEM4MUtF?=
 =?gb2312?B?Q1hsdk9xcm5JVmwrWkVrNzk5L0lnVGx1VFBnZEp6TXpveUhzeWhtVnhqKzlm?=
 =?gb2312?B?bS93U0YzUWY1UDI4dS9ON0lRY2RXNEg5Ryt5em1zUmw4L011VTNrTS8zYWFW?=
 =?gb2312?B?MjROK0k1KzZnK2tkdlp0UU4yeWl1blU4bndxV3k1cjcrN25iZEk1MHhrV1R2?=
 =?gb2312?B?Z3NwTDk5RUpnSEs2RWZnVTVLbG1GTStPeUdZUCtpOWhiNnc3ZTcvZnRwdFRS?=
 =?gb2312?B?OEI0Q2M1VUhIYWpLdXlVeEpZZVRFVXNoeDFSQTkrSTErSEtWR2s2RHRsOVY5?=
 =?gb2312?B?TGtNRTM0d2l1cUJYNEJpaXFKOUdrbUpodDRidWZkZ1FtQUZqNnpkbzJMWTdQ?=
 =?gb2312?B?TUdzR08yTzNUcndGWFJFYUtQcGxqaW03SHI5WGlkNkY5cXVDQ3k2UGFtTkZI?=
 =?gb2312?B?ZVdSdlVEZm5LTmdCeVhDMno2a2dxaHlWQlpub09Hd1o0VmE1S0pGSDN2Y2J5?=
 =?gb2312?B?WmNDblR0R1ZQOFZtbmFWZWRtTnVpeHdUcG1WVTAwMVZlZEV3NTlUdUIzV2R2?=
 =?gb2312?B?NGdWWnE5U3AzVjFST0VEZ0VGTmZja0xOWlpiVGZHU3VkdytHTFhEaGZZOTkx?=
 =?gb2312?B?OHUvcHlDcjB3OVhpeFhLNDIvWHMyc1lmdGVqMktVNkR1RGxsV3dld0dNR2th?=
 =?gb2312?B?RXlsMmI3clQyYS9XZUh4UlNJaDh3aUREVUpRT0h5OHVZenBZZnhHdmpqek9U?=
 =?gb2312?B?ZFJkdld3Z1FMOFkxM1hhc2hCNUZkUVZEUHo3cWtzQjlQSHFWcVJ0UGppNStk?=
 =?gb2312?B?Q21zWmRJREROUWVubUllcDA5WSsvekVwRDdyMXZIZk5JUGkrRjRVTlZLM0J2?=
 =?gb2312?B?U3VqRjhxeFZRR3VCcmhNUmtlNlNuQzRHZUpCZHhsa0plaDV0NVhUQThDaFlo?=
 =?gb2312?B?TDcvbGZWMXhQV1Z1QXRnZnRWTzlDODJ3THNkOThwV0swVjRmTEVRTHpXakcr?=
 =?gb2312?B?TE9VQnhmVFB4TFFsOFozY2doNmZNV2xtMzJxYndOQW9PYUl5K2huZ2JyblRG?=
 =?gb2312?B?emZGQUIvVk4vK1c1dE9ESVJDZXJLdG0wRm56MGV3NWRiL1FiUGNLWmZ1VWhV?=
 =?gb2312?B?Z1RFWHMvSVQ4WkhDb3cxZmRFOTVJNTh0RENWb2V2R1lrektGcjlxU01WWUVD?=
 =?gb2312?B?djFqamVDSnRTQVFuWGU0dFRZcFFsN0JuTmFNN3lsQlprT3h3OHJ2Y3NQUGdk?=
 =?gb2312?B?UjRuRUIyMEdXdkpoMlZUczdhaHdlV2tKZm5sV1FOOE5FZWJSRHJ5L2xMZDhF?=
 =?gb2312?B?a1JHVmVkREwzZEExdEFBeFptYm81cGJDQTVpLzYxanNqWGVDc2JMQ3NiUzR5?=
 =?gb2312?B?UjY4U3dCS2pCRzdCU1lZbkFJL2Jud0tPVXBBK0I1Um5JZHFtRjVRdm9ZY24r?=
 =?gb2312?B?MEZ0a09MeG9UemRRUDRKdUdnTVVDWUE4SXo5bmxKai9tQXpYelh1aVdrVUJR?=
 =?gb2312?B?ZmtrU3JKNTNlR05VaXpFRDhsWVB3aVhrZHhGaWEzckdiZC82aCtzNVhCKzFt?=
 =?gb2312?B?MGtQcFBYOXJ0ajZ1cUJkcmhCNUpEWlZSNDdGSVFzRXpPSGxUK2g1UT09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a9731e-ddb2-4712-6d5a-08da3fc9cfdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2022 10:15:23.3962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yxFuSQRKj8CV3TyVQUGBSyiSddW9MaqSlIqRL8y6jzsxXn9o2dKypH7CNGdCfTMr8Ght+KtPYBHn6lTypD4z3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8686
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBUb21tYXNvIE1lcmNpYWkgPHRvbW1hc28ubWVyY2lhaUBhbWFydWxhc29sdXRpb25z
LmNvbT4NCj4gU2VudDogMjAyMsTqNdTCMjfI1SAxODowNg0KPiBUbzogTWluZyBRaWFuIDxtaW5n
LnFpYW5AbnhwLmNvbT4NCj4gQ2M6IG1jaGVoYWJAa2VybmVsLm9yZzsgTWlyZWxhIFJhYnVsZWEg
KE9TUykNCj4gPG1pcmVsYS5yYWJ1bGVhQG9zcy5ueHAuY29tPjsgaHZlcmt1aWwtY2lzY29AeHM0
YWxsLm5sOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBr
ZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwtbGludXgtaW14
IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW0VY
VF0gUmU6IFtQQVRDSF0gbWVkaWE6IGlteC1qcGVnOiBMZWF2ZSBhIGJsYW5rIHNwYWNlIGJlZm9y
ZSB0aGUNCj4gY29uZmlndXJhdGlvbiBkYXRhDQo+IA0KPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4g
DQo+IE9uIEZyaSwgTWF5IDI3LCAyMDIyIGF0IDA5OjUyOjQ4QU0gKzAwMDAsIE1pbmcgUWlhbiB3
cm90ZToNCj4gPiA+IEZyb206IFRvbW1hc28gTWVyY2lhaSA8dG9tbWFzby5tZXJjaWFpQGFtYXJ1
bGFzb2x1dGlvbnMuY29tPg0KPiA+ID4gU2VudDogMjAyMsTqNdTCMjfI1SAxNzozOA0KPiA+ID4g
VG86IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+DQo+ID4gPiBDYzogbWNoZWhhYkBrZXJu
ZWwub3JnOyBNaXJlbGEgUmFidWxlYSAoT1NTKQ0KPiA+ID4gPG1pcmVsYS5yYWJ1bGVhQG9zcy5u
eHAuY29tPjsgaHZlcmt1aWwtY2lzY29AeHM0YWxsLm5sOw0KPiA+ID4gc2hhd25ndW9Aa2VybmVs
Lm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiA+
ID4gZmVzdGV2YW1AZ21haWwuY29tOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsN
Cj4gPiA+IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsNCj4gPiA+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gPiA+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0hd
IG1lZGlhOiBpbXgtanBlZzogTGVhdmUgYSBibGFuayBzcGFjZQ0KPiA+ID4gYmVmb3JlIHRoZSBj
b25maWd1cmF0aW9uIGRhdGENCj4gPiA+DQo+ID4gPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gPiA+
DQo+ID4gPiBIaSBNaW5nLA0KPiA+ID4gSSB0aGluayBoYXZlIHNvbWUgY29tbWVudHMgb24gdGhl
IGNvZGUgZm9yIHRoaXMgd291bGQgYmUgbmljZSBmb3INCj4gPiA+IHRoZSBmdXR1cmUNCj4gPiA+
DQo+ID4gPiBPbiBGcmksIE1heSAyNywgMjAyMiBhdCAwMzo1NDozNVBNICswODAwLCBNaW5nIFFp
YW4gd3JvdGU6DQo+ID4gPiA+IFRoZXJlIGlzIGEgaGFyZHdhcmUgYnVnIHRoYXQgaXQgd2lsbCBs
b2FkIHRoZSBmaXJzdCAxMjggYnl0ZXMgb2YNCj4gPiA+ID4gY29uZmlndXJhdGlvbiBkYXRhIHR3
aWNlLCBpdCB3aWxsIGxlZCB0byBzb21lIGNvbmZpZ3VyZSBlcnJvci4NCj4gPiA+ID4gc28gc2hp
ZnQgdGhlIGNvbmZpZ3VyYXRpb24gZGF0YSAxMjggYnl0ZXMsIGFuZCBtYWtlIHRoZSBmaXJzdCAx
MjgNCj4gPiA+ID4gYnl0ZXMgYWxsIHplcm8sIHRoZW4gaGFyZHdhcmUgd2lsbCBsb2FkIHRoZSAx
MjggemVybyB0d2ljZSwNCj4gPiA+DQo+ID4gPiBGcm9tIHdoYXQgSSd2ZSB1bmRlcnN0b29kIHlv
dSBpbml0aWFsaXplIGNmZ19zdG0gd2l0aCB6ZXJvcyB0aGVuIHlvdQ0KPiA+ID4gc3RhcnQgdG8g
d3JpdGUgdGhlIGNvbmZpZ3VyYXRpb24gZnJvbSAweDgwICgxMjggYnl0ZXMpLCBhdm9pZGluZyB0
aGUgaHcNCj4gaXNzdWUgcmlnaHQ/DQo+ID4gPg0KPiA+DQo+IA0KPiBIaSBNaW5nLA0KPiANCj4g
PiBISSBUb21tYXNvLA0KPiA+ICAgICBZZXMsIHlvdSdyZSByaWdodCwgdGhlcmUgaXMgYSBoYXJk
d2FyZSBidWcuDQo+ID4gSSB3YW50IHRvIHdyaXRlIHRoZSBjb25maWd1cmF0aW9uIGRhdGEgZnJv
bSB0aGUgb2Zmc2V0IDB4ODAsIEFuZCBzZXQNCj4gPiB0aGUgZmlyc3QgMTI4IGJ5dGVzIHRvIHpl
cm8uDQo+ID4gVGhlbiB0aGUgaGFyZHdhcmUgYnVnIGNhbiBiZSBhdm9pZGVkLg0KPiANCj4gVGhh
bmtzIGZvciB5b3VyIGNsYXJpZmljYXRpb24hDQo+IFVuZm9ydHVuYXRlbHkgSSBjYW4ndCB0ZXN0
IHRoaXMgb24gYSByZWFsIGJvYXJkIGJ1dCB0aGUgaW1wbGVtZW50YXRpb24gbG9va3MNCj4gZ29v
ZCB0byBtZS4gT25seSB0aGluZyBpcyBtaXNzaW5nIEkgdGhpbmsgd2UgbmVlZCBzb21lIG5vdGVz
IHRvIGtlZXAgdHJhY2sgb2YNCj4gdGhpcyBrbm93biBpc3N1ZSAoZm9yIHRoZSBzYWtlIG9mIGNs
YXJpdHkganVzdCBhIG5vdGUgb24gd2h5IHdlIHN0YXJ0IHRvIHdyaXRlDQo+IGZyb20gMHg4MCkN
Cj4gDQo+IFJldmlld2VkLWJ5OiBUb21tYXNvIE1lcmNpYWkgPHRvbW1hc28ubWVyY2lhaUBhbWFy
dWxhc29sdXRpb25zLmNvbT4NCj4gDQo+IFRoYW5rcywNCj4gVG9tbWFzbw0KPiANCg0KSSdsbCBh
ZGQgc29tZSBjb21tZW50cyBpbiBjb2RlLCB0aGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbg0KDQo+
ID4NCj4gPiBNaW5nLg0KPiA+DQo+ID4NCj4gPiA+ID4gYW5kIGlnbm9yZSB0aGVtIGFzIGdhcmJh
Z2UuDQo+ID4gPiA+IHRoZW4gdGhlIGNvbmZpZ3VyYXRpb24gZGF0YSBjYW4gYmUgbG9hZGVkIGNv
cnJlY3RseQ0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNaW5nIFFpYW4gPG1pbmcu
cWlhbkBueHAuY29tPg0KPiA+ID4gPiBSZXZpZXdlZC1ieTogTWlyZWxhIFJhYnVsZWEgPG1pcmVs
YS5yYWJ1bGVhQG54cC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgZHJpdmVycy9tZWRpYS9w
bGF0Zm9ybS9ueHAvaW14LWpwZWcvbXhjLWpwZWcuYyB8IDMgKystDQo+ID4gPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+DQo+ID4gPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL254cC9pbXgtanBlZy9teGMtanBl
Zy5jDQo+ID4gPiA+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9ueHAvaW14LWpwZWcvbXhjLWpw
ZWcuYw0KPiA+ID4gPiBpbmRleCA3MzRlMWI2NWZiYzcuLmFkNDIxM2UwMjBmMyAxMDA2NDQNCj4g
PiA+ID4gLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9ueHAvaW14LWpwZWcvbXhjLWpwZWcu
Yw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL254cC9pbXgtanBlZy9teGMt
anBlZy5jDQo+ID4gPiA+IEBAIC01MTksNiArNTE5LDcgQEAgc3RhdGljIGJvb2wgbXhjX2pwZWdf
YWxsb2Nfc2xvdF9kYXRhKHN0cnVjdA0KPiA+ID4gbXhjX2pwZWdfZGV2ICpqcGVnLA0KPiA+ID4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEdGUF9BVE9NSUMpOw0KPiA+ID4g
PiAgICAgICBpZiAoIWNmZ19zdG0pDQo+ID4gPiA+ICAgICAgICAgICAgICAgZ290byBlcnI7DQo+
ID4gPiA+ICsgICAgIG1lbXNldChjZmdfc3RtLCAwLCBNWENfSlBFR19NQVhfQ0ZHX1NUUkVBTSk7
DQo+ID4gPiA+ICAgICAgIGpwZWctPnNsb3RfZGF0YVtzbG90XS5jZmdfc3RyZWFtX3ZhZGRyID0g
Y2ZnX3N0bTsNCj4gPiA+ID4NCj4gPiA+ID4gIHNraXBfYWxsb2M6DQo+ID4gPiA+IEBAIC03NTUs
NyArNzU2LDcgQEAgc3RhdGljIHVuc2lnbmVkIGludA0KPiA+ID4gPiBteGNfanBlZ19zZXR1cF9j
Zmdfc3RyZWFtKHZvaWQNCj4gPiA+ICpjZmdfc3RyZWFtX3ZhZGRyLA0KPiA+ID4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHUzMiBmb3VyY2MsDQo+ID4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdTE2IHcsIHUxNiBo
KSAgew0KPiA+ID4gPiAtICAgICB1bnNpZ25lZCBpbnQgb2Zmc2V0ID0gMDsNCj4gPiA+ID4gKyAg
ICAgdW5zaWduZWQgaW50IG9mZnNldCA9IDB4ODA7DQo+ID4gPiA+ICAgICAgIHU4ICpjZmcgPSAo
dTggKiljZmdfc3RyZWFtX3ZhZGRyOw0KPiA+ID4gPiAgICAgICBzdHJ1Y3QgbXhjX2pwZWdfc29m
ICpzb2Y7DQo+ID4gPiA+ICAgICAgIHN0cnVjdCBteGNfanBlZ19zb3MgKnNvczsNCj4gPiA+ID4g
LS0NCj4gPiA+ID4gMi4zNi4xDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gVGhhbmtzLA0KPiA+ID4g
VG9tbWFzbw0KPiA+ID4NCj4gPiA+IC0tDQo+ID4gPiBUb21tYXNvIE1lcmNpYWkNCj4gPiA+IEVt
YmVkZGVkIExpbnV4IEVuZ2luZWVyDQo+ID4gPiB0b21tYXNvLm1lcmNpYWlAYW1hcnVsYXNvbHV0
aW9ucy5jb20NCj4gPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gPiA+
DQo+ID4gPiBBbWFydWxhIFNvbHV0aW9ucyBTUkwNCj4gPiA+IFZpYSBMZSBDYW5ldmFyZSAzMCwg
MzExMDAgVHJldmlzbywgVmVuZXRvLCBJVCBULiArMzkgMDQyIDI0MyA1MzEwDQo+ID4gPiBpbmZv
QGFtYXJ1bGFzb2x1dGlvbnMuY29tDQo+ID4gPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnd3dw0KPiA+ID4gLmFtJTJGJmFt
cDtkYXRhPTA1JTdDMDElN0NtaW5nLnFpYW4lNDBueHAuY29tJTdDNzUxODBmMmEzOWINCj4gYjQz
N2JiMGI2DQo+ID4gPg0KPiAwOGRhM2ZjODdlNDIlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1
YzMwMTYzNSU3QzAlN0MwJTdDNjM3OA0KPiA5MjQyNzUNCj4gPiA+DQo+IDg2NDU3NTk0JTdDVW5r
bm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2kNCj4gVjJsdU16
SQ0KPiA+ID4NCj4gaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAlN0MlN0Ml
N0MmYW1wO3NkYXRhPVBEajc2DQo+IFB3aFNsDQo+ID4gPiBjT3lleHolMkJSN2xqa3d4JTJGRUc3
WVRCJTJCZmZJYno4YXRnRnMlM0QmYW1wO3Jlc2VydmVkPTANCj4gPiA+DQo+IGFydWxhc29sdXRp
b25zLmNvbSUyRiZhbXA7ZGF0YT0wNSU3QzAxJTdDbWluZy5xaWFuJTQwbnhwLmNvbSU3QzENCj4g
PiA+DQo+IGQxNWMzY2E1YmEyNDhhZTUzYmMwOGRhM2ZjNGE3NWIlN0M2ODZlYTFkM2JjMmI0YzZm
YTkyY2Q5OWM1YzMwMTYNCj4gPiA+DQo+IDM1JTdDMCU3QzAlN0M2Mzc4OTI0MTEwOTM2MDYwOTAl
N0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKDQo+ID4gPg0KPiBXSWpvaU1DNHdMakF3TURBaUxD
SlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlNw0KPiA+ID4NCj4g
QzMwMDAlN0MlN0MlN0MmYW1wO3NkYXRhPTIlMkZabG1haWRJWG1wdXJRQk5XNTZyb1FnYVduWTdJ
RWxQDQo+ID4gPiBPSnpoRmFabG93JTNEJmFtcDtyZXNlcnZlZD0wDQo+IA0KPiAtLQ0KPiBUb21t
YXNvIE1lcmNpYWkNCj4gRW1iZWRkZWQgTGludXggRW5naW5lZXINCj4gdG9tbWFzby5tZXJjaWFp
QGFtYXJ1bGFzb2x1dGlvbnMuY29tDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18NCj4gDQo+IEFtYXJ1bGEgU29sdXRpb25zIFNSTA0KPiBWaWEgTGUgQ2FuZXZhcmUgMzAsIDMx
MTAwIFRyZXZpc28sIFZlbmV0bywgSVQgVC4gKzM5IDA0MiAyNDMgNTMxMA0KPiBpbmZvQGFtYXJ1
bGFzb2x1dGlvbnMuY29tDQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0
bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGd3d3LmFtDQo+IGFydWxhc29sdXRpb25zLmNvbSUy
RiZhbXA7ZGF0YT0wNSU3QzAxJTdDbWluZy5xaWFuJTQwbnhwLmNvbSU3QzcNCj4gNTE4MGYyYTM5
YmI0MzdiYjBiNjA4ZGEzZmM4N2U0MiU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxDQo+
IDYzNSU3QzAlN0MwJTdDNjM3ODkyNDI3NTg2NDU3NTk0JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNk
OGUNCj4geUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dp
TENKWFZDSTZNbjAlM0QlDQo+IDdDMzAwMCU3QyU3QyU3QyZhbXA7c2RhdGE9TlclMkZHeVhTQnJw
a2Z6VyUyRnFkaDRxOUp5WjhyVFg4eDINCj4gTTdyJTJGTUppUkg3dFElM0QmYW1wO3Jlc2VydmVk
PTANCg==
