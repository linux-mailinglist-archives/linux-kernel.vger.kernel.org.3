Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785FB4C0272
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 20:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbiBVTxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 14:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbiBVTwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:52:50 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8969CC4E30
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 11:52:24 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21MGu1co025490;
        Tue, 22 Feb 2022 11:52:17 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ecw9y2qa8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 11:52:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H19d24pi8/cI51dy2Kjezzw4T5JCcIjuaZAKzZAjOk6SULwgQEB55M4NxXlggiJy2/FOGAauEi2b40kUyXQk0selkYR3luFaURHuufPzjP6rXnio0/XNmhQRuV2HklgHFdgkW0yp2Gesu8NQNRpiJ8j+5+7GB5z+bdnU8I5mKHtD4LZ5YEYBE+nCTFRlC+YQjqTV085Ha3t1mNLAtwRoAu11u80dnRqis1X1YQRtvMe5A+hVxZ2DeH6nR9m8st6xqdB8T7fy8HXmYNIZitH39k3euQ8GT2ZChqFyUs/uZZxt/u2QqHwBHSu9JiVPqWfBXfaiLvCD1gjK/nNMcAMuCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMBWtlpzEUVJG+uCqA0roJ5x61DWwVVukzgfY6el8tc=;
 b=kJ9Y+ssMNzAQGLKonHZLdNCBilMBuUj3keFhQWQvqPZ2ugCHrWJK6M+UNzKkGFUZ68AQoYBz5YS1wXqXJfxqA8qK8LuaOTDLdZeJg6ER7WxXiUYLWTB9bIPafAiJ+ggkzhpkaOXj/ZcqDryYOzl0N8dJUehnt3UyF+nyV43Ck/jwEoR3iiHGSdeqClUIYTcpA6rLRlrwS+b4dTL/SWp6ghMgx9pnwqnN3RRfE3V7KDzAMhZJZvUVvIwG7/mLMMZa0FUx2PtwR2mmd1UfMg3havzIh5O1yVmzZETN+tX6qk5KhBMQ8aN/k7WgbM5sber4jynaxhTaInZWN9Jna3od8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMBWtlpzEUVJG+uCqA0roJ5x61DWwVVukzgfY6el8tc=;
 b=fuAhC9MDYwfJahrpyfV3+nQ7wXuqRIUNAPvXqXYJxPupCwHh6b7QhkbxSV1UtVFPW4TTKL/X3W7VXT2UOfYGztrRqIqJp9M698K8k6B0+O54DWy44EtVMv1JoLhmByWOGLlpJKvlaUkIg56QKacZVu9iwTNKo3t8LF2yFhjs9dI=
Received: from CO1PR18MB4732.namprd18.prod.outlook.com (2603:10b6:303:eb::13)
 by DM6PR18MB2441.namprd18.prod.outlook.com (2603:10b6:5:15f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Tue, 22 Feb
 2022 19:52:13 +0000
Received: from CO1PR18MB4732.namprd18.prod.outlook.com
 ([fe80::d0ca:ef26:60b8:7546]) by CO1PR18MB4732.namprd18.prod.outlook.com
 ([fe80::d0ca:ef26:60b8:7546%5]) with mapi id 15.20.5017.022; Tue, 22 Feb 2022
 19:52:13 +0000
From:   Radha Chintakuntla <radhac@marvell.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Satananda Burla <sburla@marvell.com>
Subject: RE: [EXT] Re: [PATCH 0/4] soc: Add support for Marvell OcteonTX2 SDP
 block
Thread-Topic: [EXT] Re: [PATCH 0/4] soc: Add support for Marvell OcteonTX2 SDP
 block
Thread-Index: AQHYHgZNBD1gpIqhuEWaau391usoLayM+uqAgABmLuCAEq3mMA==
Date:   Tue, 22 Feb 2022 19:52:13 +0000
Message-ID: <CO1PR18MB4732CEC2F6A92B710DA9458EC53B9@CO1PR18MB4732.namprd18.prod.outlook.com>
References: <20220209224210.153907-1-radhac@marvell.com>
 <CAK8P3a29uJF+dVVjuKmF=rRDJrM2ndbxRJPFt9ga-waQcECb+A@mail.gmail.com>
 <CO1PR18MB47325CFE16B698984D6A926DC52F9@CO1PR18MB4732.namprd18.prod.outlook.com>
In-Reply-To: <CO1PR18MB47325CFE16B698984D6A926DC52F9@CO1PR18MB4732.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 891b32e5-a243-489e-5920-08d9f63cd21c
x-ms-traffictypediagnostic: DM6PR18MB2441:EE_
x-microsoft-antispam-prvs: <DM6PR18MB2441967F9E08FBE4134369B6C53B9@DM6PR18MB2441.namprd18.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KL3yJ6tq0l0OoHYtnJWMIPvE4LkH4XkUGnW20dbh4RYDiQFC0xj2vcKDoeBKTLwOP3VZxI3OiwqYiRcfFIf+fpXVb3YDRXApZBxtWGH3ce+YzjgxZQwl5kHtEXgfohmB6FR7VVvMBnT+kLUWKPONJtP/flQ2r2nnKoXE9ogWnSoa3Fv/mpPuZNJ4zUZQcXhgjtCcS9TDrV1uDAjjR8YdsOOlr9iPwU1dZpNTk5jow4mz730PsSVdTYu4oRhGqIXqb+S0LtLVIRh1h2pdR/rk4Xzx52Y3QU5De7hKRD9ZUixgUL3U8x3s15tMAtxZG5Nn2Av0ti9PyIBjprWO9ykKyzbqoI9JqiLfI8hiqHl4JJG/XzbVdigDf0IknFBCgFEGQLg2mHhpvdyx9PzQ6vrb0ECMTYE8BHCgyczrB6r3STQ9rl0utNPTNCLXqyNcP7eoKen40KrlhFVkxeEswg4rscCJspVHB9Xbi0VweNPNHvucWxblzoKL7+6iA2NJz3vlKWbIBivyI6021/V6vzJ3EY6wTq48K1LXUzVLqFU/HIP/tBwiS3NPbxjt3KgpCYKLmlQjEUjUp62gGpiXzc00rCwRO37DbZvGPjsxn7sISkoDgkP+fQ4NawSwy8LgG1LsR+ZaK2wtIoyekjD+/ne/7ikR3OG3aAA+W88juO51DB30W491y+ONuERa6sjGCs5CMXlmIhoHmScW5gcbUiK+sQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4732.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(71200400001)(316002)(8676002)(83380400001)(76116006)(66946007)(4326008)(66556008)(107886003)(66476007)(64756008)(66446008)(5660300002)(2906002)(186003)(38100700002)(8936002)(122000001)(26005)(9686003)(52536014)(38070700005)(53546011)(54906003)(55016003)(6506007)(86362001)(6916009)(7696005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGJLNE9pZ3hSRXVPdEEwa2VFcEVZRXpMRWlTVXJ1dXNZN3RzZFhMdHhoRVpx?=
 =?utf-8?B?bkQ0cEl6cmticGh3VHJ2My94WEhQd0hveXJkc2pnSTVNb0RWNXZqUHVKRHJE?=
 =?utf-8?B?UjZleUhpN0hqQ3NPK1pRMG1td050MVN2aEx6YnREeG1hR0Z3Vm5JcGVvU1N0?=
 =?utf-8?B?LzVsZmgvdU5nUmRCSWtnRk5VUnpQeWdLRVBZemtRSnkwTXpXTmZsdEoyck96?=
 =?utf-8?B?OXhkajZ2V3B4elN6dXdDZDZydnM0WU9OUlpTbU1NNFZmRjBLbTRQUXhTbGln?=
 =?utf-8?B?clpFdUlRVy9DSitFajl4WThBTm1iM29DeURhUzFzcmVwbEZKWDd3bkJXWHpo?=
 =?utf-8?B?Y3dUcFZZMzdkVUZnL2ZmSzlJYWFYclJwRmJ5WXBxZk5rTlBWeXZrMWh0dW10?=
 =?utf-8?B?QnpCdlk5Rm9TTy95OSt0Wm0wNE1IYkVkQ0dNYVlMbTlYSitUUkRnYkhEbDRJ?=
 =?utf-8?B?cG5nRTVCcTk3MFQxcjJ5dWUrQ016ZkowczhRUm1CTER0c1pvUTVqb29YK0ZQ?=
 =?utf-8?B?S2F5VEUyYnBsUHNJVitJSHA0U09hZW0xREo5RW9TYlFEd0VSQTVEMEpNYmh5?=
 =?utf-8?B?TWdmWk5xdDZ6cGN5TExQMHllV0V6S3I1WU9MSHNvc24zdWRzSEhEUFVIVWtZ?=
 =?utf-8?B?RlNUY01uYi9kV1VPNXVpNG1FN28rWlpFbkxqSGkwcWg5ZW0zUVVDdFgrR1pn?=
 =?utf-8?B?SjlNaW9vQzJSY1JZZTVkcTlhK0xDU2lsUGc2cWtBTVRDWEZFUWE2Uk1jeC9j?=
 =?utf-8?B?bWNhQkZZMTFrcGJDZjRUM2RFWTdJelJ0bXEvRFNSWDlwaTFVdDErNXNocm9v?=
 =?utf-8?B?elFzSXk2NnprLzNNOVNQMlpQNmZFelZ3Ujl6SHZkRzhzSUlJNmFzVjVUSlZE?=
 =?utf-8?B?TVNkRktaazRJTE9pcmRGK2g4bE01V0hPNmM3TldSSXA2S3J0RWFVVGRKMHVR?=
 =?utf-8?B?SktuNUh1NzE1Q1lucFZNSmhKNU4zLzBHMzVLalRManYrYVJzLzA5a00rVHpT?=
 =?utf-8?B?TXdaQVZYU1BRY2NpWkZhUFRqUXVBYWhtbTUwQmNVSVoxMVJWeFduRDcwWDdZ?=
 =?utf-8?B?WFR4NlprSjNOMnE3OGhON1hPNnRSTmVZUDZBcUorZ0ZPNDNJNWZhMHF3VkJN?=
 =?utf-8?B?Q0xBMFZGYVowWHowcFVlYWVjZVBid3hZVURJdm14ck9MS0psT1VPaDJqTFVJ?=
 =?utf-8?B?YjdiZ0pTaEdSdzNCL3FxMzR0dmFOa3kzNURCbFFNRkp6RzB1YnZPeCtRYTZ3?=
 =?utf-8?B?QjdGcWV2eGlSSkE0NzZGWEpEeE1rSWt1TUpBNjlZcjl0NzJmRGc2Y2dsNXVa?=
 =?utf-8?B?eko4SXpBOG9CcGNjNnAvcVRHRzluS3VweFVBWU5RK0ZuY2Q1YWpkQ3h1b083?=
 =?utf-8?B?YUFUeW5LZFlrSzVTLzRYSUYzTUFOalp2Qm5UcVpzTzZoTUJKNnE4c2lId2s1?=
 =?utf-8?B?cWVUaUNyTnJEcXZVVitURytQZTVYY29LTHNPbW8zdjY5T2pNdWZjYnBOUEFM?=
 =?utf-8?B?ZXVRNEFmQ251WUZJMnlXSUs2VHdLWEc5bldJWXdoclduSFFFNDRuaWVGei9W?=
 =?utf-8?B?S0NIVEdKTkVzK3BDQUxHWE80eVU3SUdha1o0UTkyODVNZGV0Y04wc0RwcDAz?=
 =?utf-8?B?R2VaTE84RjJaOCt3bWk0cXV3bHo5ZnlMemhLcnVLSEVUVjlZRlBjRkk3TUlt?=
 =?utf-8?B?bjExTHVWMkRlOVZkejl4bHMxVGpVV0YzNDIvcllHUWNjMlVDMzRQOEV5ZnBT?=
 =?utf-8?B?Q3BKWVhUajU3V2F4K3ZDSGlBRE9ZRVhWK3V2RjBpTDU4SXNTSUx2QmRlRC8z?=
 =?utf-8?B?ZzhEL0NIVEJKdGdoSlhtaGtqZmNlZ0ZZV3l6KzJzQ2dsbi8yL2JJRVNLV0Zz?=
 =?utf-8?B?eWpNTGYxakJ2Smx5NmhYN0F1KzNCbG5Ub0pBNU03R2dISks3Y25YQkJVWnd2?=
 =?utf-8?B?SGlKREt0WVRTcDlWYmdiMndYS21yYTIzNWtMNzZMVnRQNld3UEVjeFpsZ0FF?=
 =?utf-8?B?MzBpRFltT04wbUxMeXZQZHM3dk1saGhRYzZVMEt3OFBCYW9SYUMxRWlrTlZh?=
 =?utf-8?B?UlZ0VXBGOUZsTHpBdDhtR2g1WEw2ajVsbG1Vcm1lL1BqOFluZDhTaE95aDJT?=
 =?utf-8?B?RnRPcGE1b1grbllqYTMxNFFDUzlrdFhvMU1jK2V5SkE4Y3d1VThZbGxEakpX?=
 =?utf-8?B?Nmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4732.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891b32e5-a243-489e-5920-08d9f63cd21c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 19:52:13.2229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qG2Y7O8Z+ajTchYuzIO+bYkrX12JRQwKaIT3AVqWIEyWIvcIs2lQSZaRMY/mEwV8bsXj6+L6UEGBf5UC33vX7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB2441
X-Proofpoint-GUID: tp24AiuQ_awZqer1QS_brHO6dlL3zK-s
X-Proofpoint-ORIG-GUID: tp24AiuQ_awZqer1QS_brHO6dlL3zK-s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_06,2022-02-21_02,2021-12-02_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWRoYSBDaGludGFrdW50bGEN
Cj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDEwLCAyMDIyIDI6NTUgUE0NCj4gVG86IEFybmQg
QmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+IENjOiBMaW51eCBBUk0gPGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47IExpbnVzIFdhbGxlaWoNCj4gPGxpbnVzLndhbGxlaWpA
bGluYXJvLm9yZz47IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LQ0KPiBrZXJuZWxA
dmdlci5rZXJuZWwub3JnPjsgU2F0YW5hbmRhIEJ1cmxhIDxzYnVybGFAbWFydmVsbC5jb20+DQo+
IFN1YmplY3Q6IFJFOiBbRVhUXSBSZTogW1BBVENIIDAvNF0gc29jOiBBZGQgc3VwcG9ydCBmb3Ig
TWFydmVsbCBPY3Rlb25UWDINCj4gU0RQIGJsb2NrDQo+IA0KPiANCj4gDQo+ID4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRl
Pg0KPiA+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSAxMCwgMjAyMiA4OjMwIEFNDQo+ID4gVG86
IFJhZGhhIENoaW50YWt1bnRsYSA8cmFkaGFjQG1hcnZlbGwuY29tPg0KPiA+IENjOiBMaW51eCBB
Uk0gPGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47IEFybmQgQmVyZ21hbm4N
Cj4gPiA8YXJuZEBhcm5kYi5kZT47IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJv
Lm9yZz47IExpbnV4DQo+ID4gS2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZz47IFNhdGFuYW5kYSBCdXJsYQ0KPiA+IDxzYnVybGFAbWFydmVsbC5jb20+DQo+
ID4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCAwLzRdIHNvYzogQWRkIHN1cHBvcnQgZm9yIE1h
cnZlbGwgT2N0ZW9uVFgyDQo+ID4gU0RQIGJsb2NrDQo+ID4NCj4gPiBFeHRlcm5hbCBFbWFpbA0K
PiA+DQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+IE9uIFdlZCwgRmViIDksIDIwMjIgYXQgMTE6NDIg
UE0gUmFkaGEgTW9oYW4gQ2hpbnRha3VudGxhDQo+ID4gPHJhZGhhY0BtYXJ2ZWxsLmNvbT4gd3Jv
dGU6DQo+ID4gPg0KPiA+ID4gVGhlIE1hcnZlbGwgT2N0ZW9uVFgyJ3MgU0RQIGJsb2NrIGlzIGEg
aW50ZXJmYWNlIGZvciBzZW5kaW5nIGFuZA0KPiA+ID4gcmVjZWl2aW5nIGV0aGVybmV0IHBhY2tl
dHMgb3ZlciB0aGUgUENJZSBpbnRlcmZhY2Ugd2hlbiBPY3Rlb25UWDIgaXMNCj4gPiA+IGluIFBD
SWUgZW5kcG9pbnQgbW9kZS4gSXQgaW50ZXJmYWNlcyB3aXRoIHRoZSBPY3Rlb25UWDIncyBOSVgg
YmxvY2sNCj4gPiBxdWV1ZXMuDQo+ID4NCj4gPiBIaSBSYWRoYSwNCj4gPg0KPiA+IEknbSBub3Qg
c3VyZSBkcml2ZXJzL3NvYy8gaXMgdGhlIHJpZ2h0IHBsYWNlIGZvciBpdC4gSSBoYXZlIG5vdCBk
b25lDQo+ID4gYW4gYWN0dWFsIHJldmlldyBzbyBmYXIsIGJ1dCBJIGhhdmUgc29tZSBoaWdoLWxl
dmVsIHF1ZXN0aW9ucyB0byBjbGFyaWZ5IGhvdw0KPiB0aGlzIGZpdHMgaW46DQo+ID4NCj4gPiBX
aGVuIHlvdSBzYXkgaXQgaXMgbWVhbnQgZm9yIHBhc3NpbmcgZXRoZXJuZXQgcGFja2V0cywgd2h5
IGlzIGl0IG5vdA0KPiA+IGFuIGV0aGVybmV0IGRyaXZlcj8NCj4gDQo+IFRoZSBTRFAgYmxvY2sg
c2l0cyBpbiBiZXR3ZWVuIHRoZSBQQ0kgRW5kcG9pbnQgY29udHJvbGxlciBhbmQgdGhlIE5ldHdv
cmsNCj4gYmxvY2sgKE5JWCkuIEl0IGRvZXMgYW4gaW1wbGljaXQgRE1BIGZyb20gYSByZW1vdGUg
aG9zdCB0byBPY3Rlb24gYW5kIGhhcw0KPiBxdWV1ZXMgdG8gZGlyZWN0IHRvIHRoZSBOSVggcXVl
dWVzLiBUaGUgaG9zdCBzaWRlIHdpbGwgaGF2ZSBhIG5ldGRldiBkcml2ZXINCj4gd2hpY2ggc2Vu
ZHMvcmVjZWl2ZXMgcGFja2V0cyBvbiB0aGUgU0RQIHF1ZXVlcyBzbyB0aGV5IG1ha2UgaXQgdG8g
dGhlIE5JWC4NCj4gU0RQIGRyaXZlciBkb2Vzbid0IGRvIGFueSBwYWNrZXQgdHJhbnNtaXQgb3Ig
cmVjZWl2ZSBieSBpdHNlbGYgc28gdGhhdCdzIHdoeSBpdA0KPiBpcyBub3QgYSBuZXRkZXYgZHJp
dmVyLg0KPiANCj4gPg0KPiA+IElmIHRoaXMgZHJpdmVzIHRoZSBQQ0llIGVuZHBvaW50IG1vZGUs
IGhvdyBkb2VzIGl0IGludGVyZmFjZSB3aXRoIHRoZQ0KPiA+IHBjaSBlbmRwb2ludCBmcmFtZXdv
cms/IEl0IGxvb2tzIGxpa2UgYSBub3JtYWwgUENJIGRyaXZlci4NCj4gVGhlIGJsb2NrIGRvZXMg
bm90IGRyaXZlIHRoZSBlbmRwb2ludCBtb2RlIGFzIHN1Y2guIFRoZSBkcml2ZXIgaXMganVzdA0K
PiBzZXR0aW5ncyB1cCB0aGUgY29ubmVjdGlvbiBiZXR3ZWVuIFNEUCBhbmQgTklYLiBJdCBkb2Vz
bid0IHRvdWNoIGFueSBvZiB0aGUNCj4gZW5kcG9pbnQgcmVnaXN0ZXJzIG9yIHNldHVwIHRoZSBl
bmRwb2ludCBjb25uZWN0aW9uLiBNb3N0IG9mIHRoYXQgaXMgZG9uZSBieQ0KPiBmaXJtd2FyZSB3
aGljaCBkZXRlY3RzIHRoZSBtb2RlIGFuZCBzZXRzIHVwIHRoZSBFUCBjb250cm9sbGVyLg0KPiA+
DQo+ID4gV2hhdCBoYXJkd2FyZSBkb2VzIHRoaXMgcnVuIG9uPyBJcyB0aGlzIG9ubHkgdXNhYmxl
IHdoZW4gYm90aCB0aGUgaG9zdA0KPiA+IHNpZGUgYW5kIHRoZSBlbmRwb2ludCBzaWRlIGFyZSBP
Y3RleG9uIFRYMiBtYWNoaW5lcyB3aXRoIHRoZWlyIHBhY2tldA0KPiA+IGVuZ2luZXMsIG9yIGNh
biBvbmUgb2YgdGhlIHR3byBiZSBhIGRpZmZlcmVudCBtYWNoaW5lIHRoYXQgaGFzIFBDSWUNCj4g
PiBob3N0IG9yIGVuZHBvaW50IGRldmljZSBzdXBwb3J0Pw0KPiBJdCBydW5zIG9uIE1hcnZlbGwg
T2N0ZW9uVFgyIHdoZW4gaXMgaW4gUENJZSBFbmRwb2ludC4gQnV0IHRoZSBob3N0IGNhbiBiZQ0K
PiBhbnl0aGluZyAtIHdlIGhhdmUgdGVzdGVkIG9uIHg4NiBhbmQgYXJtNjQgaG9zdHMgc28gZmFy
Lg0KPiBUaGUgaG9zdCBzaWRlIHdpbGwgaGF2ZSBhIG5ldGRldiBkcml2ZXIgdGhhdCB3aWxsIGdv
IGludG8gdGhlIGRyaXZlcnMvbmV0IGFyZWEuDQo+ID4NCkhpIEFybmQsDQpBbnkgbW9yZSBpbmZv
cm1hdGlvbiB5b3UgbmVlZCBvbiB0aGlzID8NCg0KUmVnYXJkcywNClJhZGhhDQo=
