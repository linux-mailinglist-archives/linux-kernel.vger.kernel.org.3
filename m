Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0744D0728
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244928AbiCGTDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238153AbiCGTDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:03:43 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03D01EC6B;
        Mon,  7 Mar 2022 11:02:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xfrk56hLTAFPpXKNer24CIMlMeV/PCAlIZJkNFncCGLsVEJjZY1az6bxMAALcploRim+dWYiqpPx4bOM8Y6+aN8KgRoWGhx24TSVaKk+yrjSl7dQeVgkvp7VQn7iJ9Gcqg1pf+6ig2OZ6EyT7QDsQSi6K+aFEz11xgeiJoljISjvfnqO097I9DXC/h6jJyFVnV0dVn4H07Q1VA8pxI5wU6lKMUYfTIC9OS5/KC6elNnY1954LDGDho4wEt3+Ft1FeBxn2pxJv/YWWV6m1N65OnNkKMFQ4ww1lqdg2I41UQM4m2mICto3lcPKVSCeCt4juRuaP9r6CKFVlG0JsmyhuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkJdtk4iCtBIxMqgNfS1lwheaPtwYYGLVa9SKB3yXEM=;
 b=bQO7YosVTFGCUU47Hbbb8qPqER/9oF48urDt2DS7/LZMgn+52MHs+iOAr4k8IG18IDlX75w3FekS5WzAhmK50WXLD9h9mAIXgwj9l67ODQMPuxTaquSi2Az31eK04Yc5330iBSPh7rHddQo6aqjq1Og7UNwgwMge03h9nef5SiQqUj0Jelbo9Ls/ETuabYtGI51dvgYoR03JB4oEm1t8+BZUGyMgapcmoX2IE+RguMfnM+ufOBkcvLEuSvAWBXi0mvSNYW3toPfwB+FFo/wV4XaNpcFwQ4UkTi9ko8zAJEvmRArutib9hYUJhs3KYfq/EOwGspDveRcXj17sJeMUvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkJdtk4iCtBIxMqgNfS1lwheaPtwYYGLVa9SKB3yXEM=;
 b=lO5gWFgu3dWkOoP9Gar2oxL+mvOBm1VND0GKJEONHDXrnrnIElsK3Hjf1YuxBxKZDK+GPU/c+veLB8ICdgDlHN49Gtsjl7F4YqwAvKCO3K6iMOu/H58VAmA0WUwMHZ5rqKZj0iVknr15Nswy+cdQ6jpWxr8NJBaJEdgXAwJFduP5wnejfgQJ3YUkUSub9SO/jpFSf0esLztAlU6FNQQkcmoee9WDlrzjyGIa1zb8VDMECxlESKIXG7OCGCuh4VlxTDcGw6DFxIlpSitdk49jEsthf5WUEKEESgsV/tjLJx4YQGND15AdG1C2PGWLPtMCGf/zqW8j8gH4l9RdZ+WALg==
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by BYAPR12MB3368.namprd12.prod.outlook.com (2603:10b6:a03:dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Mon, 7 Mar
 2022 19:02:45 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::a57a:37e0:825a:d894]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::a57a:37e0:825a:d894%8]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 19:02:45 +0000
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
CC:     Krishna Reddy <vdumpa@nvidia.com>, Sachin Nikam <Snikam@nvidia.com>
Subject: RE: [Patch v4 4/4] memory: tegra: Add MC error logging on tegra186
 onward
Thread-Topic: [Patch v4 4/4] memory: tegra: Add MC error logging on tegra186
 onward
Thread-Index: AQHYLhHEvTV8LxjL40qENT0hHpzEZ6ysf6+AgAfOstA=
Date:   Mon, 7 Mar 2022 19:02:45 +0000
Message-ID: <SA0PR12MB43498678A94C61FB9D9ED3D2CA089@SA0PR12MB4349.namprd12.prod.outlook.com>
References: <1646210609-21943-1-git-send-email-amhetre@nvidia.com>
 <1646210609-21943-5-git-send-email-amhetre@nvidia.com>
 <72fafc84-4986-926f-67ae-155f4fced88b@canonical.com>
In-Reply-To: <72fafc84-4986-926f-67ae-155f4fced88b@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0027a461-b42f-47dd-48aa-08da006d107c
x-ms-traffictypediagnostic: BYAPR12MB3368:EE_
x-microsoft-antispam-prvs: <BYAPR12MB336821AA03281A8199EFA29ACA089@BYAPR12MB3368.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i9VRSgG9js/Fl4ygaxnS08bBxpWWIjUYkXIC3JLs+/9soN23N2zETtkPD6pUrMTS384FfMxrtGtydATZxa0RlmXjm97CxRTEN8nkIlYnV31RnU5rClu/XSsJqv1EBAEG6+LGzojKdig9VQOBcLd/safzUaReoGUJnhxGVAKSEYIPGxBOYxmVB42UxLppSH4pr+xYK3+ObDbbM9f9cRjKvHawoLTNJmtBYkx4rMyKc/Bjw1K5jJYixkrLxFvprOLjjiU4ETRCzyxie4O0JoLjt/jFdV4M99jmqWxsjF3YD48Lqsruc4Q+9mU6XNsviNNpD93T4eLz5m9Y3XOY2FgaBB+KEzERteJ3vxfRe20i6tvBBD+Uq6oXA3H07XDr0Ljgh3D06hOZtLqalYGjZladARKyqcWGuS3BaWQcXILmXQMX+i8uPTjq4v+ttc/dmlXtZd/M8hl0Mcmo7VHMkoC1WGM1qXheKpneqVXKMb+ZZZI7GJRwWbFgx+Ev1TmAbul1+3O0szO5J+RboMj6xU9FQp69XySUNJrFJslQlJxaUj6/0PPLm8nSg+ug77yLYLqvNyCqfj9xAb1+mySmksAhkTgI/kKdHwSk7J2lGqtAaLqNJVZk34xpmL4tQqmqOBsEeWM7+tat8uuapJREnwICsoidV3gjNRkgSijyZTJTy+nh9XdDwc/OjRRHsjJ3w0iajUiIiqgaIuVxjIvy2Ko1wg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(33656002)(53546011)(107886003)(55236004)(9686003)(316002)(38100700002)(54906003)(186003)(26005)(110136005)(52536014)(66946007)(122000001)(38070700005)(55016003)(71200400001)(2906002)(5660300002)(86362001)(4326008)(8936002)(6506007)(7696005)(508600001)(8676002)(66476007)(64756008)(66556008)(76116006)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFpSSVJFMFpJRUZVZzQvNnhCcTJsQkNOVkhJeFl3Zmc5a00yVzVmSWRjWVM5?=
 =?utf-8?B?MSs3M3pPSWRnOWl5SU9Sb3VIYzBUSlpvSWJrdWRtdkxDT3FBam5yQzA4aHlW?=
 =?utf-8?B?c242akI0YUJWS1ZlUjFQTkFpSis5K0dXT0R2SWdjZktLekdQYkJ1SHNFQTNO?=
 =?utf-8?B?NlhvQmh4MHZaRFRSNE5rQnBsMy9vQkNtajdpb3U4UTZBTE5QM2RNbkU1Ni9U?=
 =?utf-8?B?WU9sZ2NiOFFiZjFjOTljYmpiQ2g0Q3RXWDczMTlaN0hZT0t0RFdMcE5OejFJ?=
 =?utf-8?B?WjRYVFR4aUlFaW1zU2VjSTUxVGl0aFVKZkZNOE1sZFQ4UW5XMVYydTdnNDNx?=
 =?utf-8?B?YkFLUDBaYkR4aEFxZWZMNkM4QXllTm1hMGI2Yzl5SUs4OUxtTVArN2swNUFK?=
 =?utf-8?B?RmJvRm9kbU1qeW9Gek1pZHFMUWJ0WWcydUFieE1mWHkxeVZNRkFiK3FxOEdE?=
 =?utf-8?B?aytTUlhsOU5BeFFCcVB5LzJLc1M5QXJ6bm52akR5OStOd1N0WU5UQ0VjYmN3?=
 =?utf-8?B?dmpnM2F2L1MvNlRuclFIL3J1amdMUXkwQ0M4WHhIUE5lVzFiNTIwUDF1TDdS?=
 =?utf-8?B?WGQ0R3NnRXI1VVdYS041WWJQZGt0S3ZmdWd4YjRXTUJCSS9GSTAvdUZJNGdB?=
 =?utf-8?B?Uytlc2pjUG9zeitaYU1kLzJ5cWcrYkd1ZVFYS0dPZ2U2REtMSDhYUi9mRlUr?=
 =?utf-8?B?Wnd3NDFDVEU2TFZNTXJxUG1LaFB1YjNDZ05TTDhvNmc3UzdmdGtQUTdqNGFX?=
 =?utf-8?B?SWpnNk1JZ1JuS0U3dVlyNWRjbEQyNlU2bDl1dXlmRTc3eWpUNWNjaFRrM0t0?=
 =?utf-8?B?MWZGbjY2MnRwb01Deis0czhHQ2FXdWEyM1Rld3BMWXBHZ3FkVHROMUF6WC9s?=
 =?utf-8?B?NFZjRmltb3EzUDJFTXp2eGhLcFlMU3M2NlpkcDdaVGZ6aFdYWVNvM2F3QU55?=
 =?utf-8?B?Mmd2V3UrVWticXFYZGtCQmQwc1k4Ri9hVmhpMUI0Mldjb09Wa3l4MFFPYWtC?=
 =?utf-8?B?TTN5R1owc3RCYzMvejNmeUI0MkpaVG5ER1JpYjg5bGdDUlhkdGZhYjE1Zkh3?=
 =?utf-8?B?UGROMC9nYUZraHVjQTZ2TFhMQ1JqQnB6a0c5eXVQcEkvNm5VcktzQWZ6WGp0?=
 =?utf-8?B?aVZ6OG1sK1Q3UDZhakJyVWk3MEUzK0NhWCtSYWs2QURUbjBPZXpmanhjZW5Q?=
 =?utf-8?B?ZTRaeHFrKzdQNUZZNTlXMEhIS3N6NmZTYnp3R1hndklyRkJOdWJnbngreGVR?=
 =?utf-8?B?cUZzZ0tGVWx1VGt1QysyTDZBYm5mWExXMGdTbXE0QWFodjdPWEFFQmc3KytY?=
 =?utf-8?B?d1FRdStRSXBTd0pjSjR3akFCamRrN0NqcXJMNE9NV3FIczFObHJNYUNsalY1?=
 =?utf-8?B?TUJZK2VqT2V5NS9kZFpHSXJzcWphOXpnVkptSEErb0ZpekJhRmM5Y1VwelF5?=
 =?utf-8?B?RngzYXFpc08vY085Y2wvTkkxeEsxa1VVdk9HcDhxZUZtYndScElmRWpXa0lk?=
 =?utf-8?B?TWZGY21ZQzhHdzNRQ1Vsbk96S3IyYzdvaE9jdFNBWTFNdkNpZ1JVMk9KbnVi?=
 =?utf-8?B?WTBZM0R5RklwRzc0TWZuUXB3UzI0cXZEdzM0YjdFMFEvK3BpUWpFeU1vam9s?=
 =?utf-8?B?d0dtUFVLRWxwZ3MybVVkQ0g1SXZWYld4SXdXSFlTYkNaMjEyN0owY1dPalNk?=
 =?utf-8?B?b2J6NTNNVUpnY2hYWEFMQWhQUUxmUERwcURqemo1ZWpnUVFJdEluYVRuSWRi?=
 =?utf-8?B?ZCt1VmZDbUlvdVQrSk9obFVKcmtOdVEzVEdFOWdoRnZ3K2Vlems3akc3S1Zs?=
 =?utf-8?B?QnhRRmtNK2FVVE03WFgrRmN5VkNmVGYxWEZFZGNRdUIrem90RUNOQ2ZuUVlq?=
 =?utf-8?B?R3B5bmh0MTdRT1g2V0ZESVErOVRHcCtZNjQ4L21wc0N0VVZHTVc4Qy91Tmpv?=
 =?utf-8?B?T1daY2R1QUxta2ttYkxSejEvb2pCWEhsNkhyWGRiMTJjczR0L2VFTnQybUQ3?=
 =?utf-8?B?bTVpd1pnRGxxeitHYm53ckNwRE9Nd3lXWGJjaU1HYUhRQWRKOGk5WmxtdDFB?=
 =?utf-8?B?eGxLMlc1cVUrRVJhc1JBKzNUTW9FbmpPN09QUTczNDByZGtMMHRoRkZlWk1j?=
 =?utf-8?B?bG5XNlRna2ttL0hycnlHYlY1RjA2UFZVTWJiSDd1aFgwRGk0RUlSQkJmVmtQ?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0027a461-b42f-47dd-48aa-08da006d107c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 19:02:45.3410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: icRaXnH7pE0KPZxJeFAxL1eXjDAmzw7xyBMTe6/zQ4IQPMc+MofL0UBoHz4Ts1SIjR0luUBgtEjWJmshHPmmkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3368
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQGNhbm9uaWNhbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBN
YXJjaCAzLCAyMDIyIDE6MTQgQU0NCj4gVG86IEFzaGlzaCBNaGV0cmUgPGFtaGV0cmVAbnZpZGlh
LmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gdGhpZXJyeS5yZWRpbmdAZ21haWwuY29tOyBK
b25hdGhhbiBIdW50ZXIgPGpvbmF0aGFuaEBudmlkaWEuY29tPjsNCj4gZGlnZXR4QGdtYWlsLmNv
bTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7DQo+IGxpbnV4LXRlZ3JhQHZnZXIua2VybmVsLm9yZw0KPiBDYzogS3Jpc2huYSBSZWRkeSA8
dmR1bXBhQG52aWRpYS5jb20+OyBTYWNoaW4gTmlrYW0NCj4gPFNuaWthbUBudmlkaWEuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BhdGNoIHY0IDQvNF0gbWVtb3J5OiB0ZWdyYTogQWRkIE1DIGVycm9y
IGxvZ2dpbmcgb24gdGVncmExODYNCj4gb253YXJkDQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNl
IGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9uIDAyLzAz
LzIwMjIgMDk6NDMsIEFzaGlzaCBNaGV0cmUgd3JvdGU6DQo+ID4gQWRkIG5ldyBmdW5jdGlvbiAn
Z2V0X2ludF9jaGFubmVsJyBpbiB0ZWdyYV9tY19zb2Mgc3RydXR1cmUgd2hpY2ggaXMNCj4gPiBp
bXBsZW1lbnRlZCBieSB0ZWdyYSBTT0NzIHdoaWNoIHN1cHBvcnQgbXVsdGlwbGUgTUMgY2hhbm5l
bHMuIFRoaXMNCj4gPiBmdW5jdGlvbiByZXR1cm5zIHRoZSBjaGFubmVsIHdoaWNoIHNob3VsZCBi
ZSB1c2VkIHRvIGdldCB0aGUNCj4gPiBpbmZvcm1hdGlvbiBvZiBpbnRlcnJ1cHRzLg0KPiA+IFJl
bW92ZSBzdGF0aWMgZnJvbSB0ZWdyYTMwX21jX2hhbmRsZV9pcnEgYW5kIHVzZSBpdCBhcyBpbnRl
cnJ1cHQNCj4gPiBoYW5kbGVyIGZvciBNQyBpbnRlcnJ1cHRzIG9uIHRlZ3JhMTg2LCB0ZWdyYTE5
NCBhbmQgdGVncmEyMzQgdG8gbG9nIHRoZQ0KPiBlcnJvcnMuDQo+ID4gQWRkIGVycm9yIHNwZWNp
ZmljIE1DIHN0YXR1cyBhbmQgYWRkcmVzcyByZWdpc3RlciBiaXRzIGFuZCB1c2UgdGhlbSBvbg0K
PiA+IHRlZ3JhMTg2LCB0ZWdyYTE5NCBhbmQgdGVncmEyMzQuDQo+ID4gQWRkIGVycm9yIGxvZ2dp
bmcgZm9yIGdlbmVyYWxpemVkIGNhcnZlb3V0IGludGVycnVwdCBvbiB0ZWdyYTE4NiwNCj4gPiB0
ZWdyYTE5NCBhbmQgdGVncmEyMzQuDQo+ID4gQWRkIGVycm9yIGxvZ2dpbmcgZm9yIHJvdXRlIHNh
bml0eSBpbnRlcnJ1cHQgb24gdGVncmExOTQgYW4gdGVncmEyMzQuDQo+ID4gQWRkIHJlZ2lzdGVy
IGZvciBoaWdoZXIgYml0cyBvZiBlcnJvciBhZGRyZXNzIHdoaWNoIGlzIGF2YWlsYWJsZSBvbg0K
PiA+IHRlZ3JhMTk0IGFuZCB0ZWdyYTIzNC4NCj4gPiBBZGQgYSBib29sZWFuIHZhcmlhYmxlICdo
YXNfYWRkcl9oaV9yZWcnIGluIHRlZ3JhX21jX3NvYyBzdHJ1dHVyZQ0KPiA+IHdoaWNoIHdpbGwg
YmUgdHJ1ZSBpZiBzb2MgaGFzIHJlZ2lzdGVyIGZvciBoaWdoZXIgYml0cyBvZiBtZW1vcnkNCj4g
PiBjb250cm9sbGVyIGVycm9yIGFkZHJlc3MuIFNldCBpdCB0cnVlIGZvciB0ZWdyYTE5NCBhbmQg
dGVncmEyMzQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBc2hpc2ggTWhldHJlIDxhbWhldHJl
QG52aWRpYS5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbWVtb3J5L3RlZ3JhL21jLmMgICAg
ICAgfCAxMDINCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiA+
ICBkcml2ZXJzL21lbW9yeS90ZWdyYS9tYy5oICAgICAgIHwgIDM3ICsrKysrKysrKysrKysrLQ0K
PiA+ICBkcml2ZXJzL21lbW9yeS90ZWdyYS90ZWdyYTE4Ni5jIHwgIDQ1ICsrKysrKysrKysrKysr
KysrKw0KPiA+IGRyaXZlcnMvbWVtb3J5L3RlZ3JhL3RlZ3JhMTk0LmMgfCAgNDQgKysrKysrKysr
KysrKysrKysNCj4gPiBkcml2ZXJzL21lbW9yeS90ZWdyYS90ZWdyYTIzNC5jIHwgIDU5ICsrKysr
KysrKysrKysrKysrKysrKysrDQo+ID4gIGluY2x1ZGUvc29jL3RlZ3JhL21jLmggICAgICAgICAg
fCAgIDQgKysNCj4gPiAgNiBmaWxlcyBjaGFuZ2VkLCAyNzUgaW5zZXJ0aW9ucygrKSwgMTYgZGVs
ZXRpb25zKC0pDQo+ID4NCj4gDQo+ICguLi4pDQo+IA0KPiA+DQo+ID4gK3N0YXRpYyBpbnQgdGVn
cmExODZfbWNfZ2V0X2NoYW5uZWwoc3RydWN0IHRlZ3JhX21jICptYywgaW50DQo+ID4gKyptY19j
aGFubmVsKSB7DQo+ID4gKyAgICAgdTMyIGdfaW50c3RhdHVzOw0KPiA+ICsNCj4gPiArICAgICBn
X2ludHN0YXR1cyA9IG1jX2NoX3JlYWRsKG1jLCBNQ19CUk9BRENBU1RfQ0hBTk5FTCwNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1DX0dMT0JBTF9JTlRTVEFUVVMpOw0KPiA+
ICsNCj4gPiArICAgICBzd2l0Y2ggKGdfaW50c3RhdHVzICYgbWMtPnNvYy0+aW50X2NoYW5uZWxf
bWFzaykgew0KPiA+ICsgICAgIGNhc2UgQklUKDApOg0KPiA+ICsgICAgICAgICAgICAgKm1jX2No
YW5uZWwgPSAwOw0KPiA+ICsgICAgICAgICAgICAgYnJlYWs7DQo+ID4gKw0KPiA+ICsgICAgIGNh
c2UgQklUKDEpOg0KPiA+ICsgICAgICAgICAgICAgKm1jX2NoYW5uZWwgPSAxOw0KPiA+ICsgICAg
ICAgICAgICAgYnJlYWs7DQo+ID4gKw0KPiA+ICsgICAgIGNhc2UgQklUKDIpOg0KPiA+ICsgICAg
ICAgICAgICAgKm1jX2NoYW5uZWwgPSAyOw0KPiA+ICsgICAgICAgICAgICAgYnJlYWs7DQo+ID4g
Kw0KPiA+ICsgICAgIGNhc2UgQklUKDMpOg0KPiA+ICsgICAgICAgICAgICAgKm1jX2NoYW5uZWwg
PSAzOw0KPiA+ICsgICAgICAgICAgICAgYnJlYWs7DQo+ID4gKw0KPiA+ICsgICAgIGNhc2UgQklU
KDI0KToNCj4gPiArICAgICAgICAgICAgICptY19jaGFubmVsID0gTUNfQlJPQURDQVNUX0NIQU5O
RUw7DQo+ID4gKyAgICAgICAgICAgICBicmVhazsNCj4gPiArDQo+ID4gKyAgICAgZGVmYXVsdDoN
Cj4gPiArICAgICAgICAgICAgIHByX2VycigiVW5rbm93biBpbnRlcnJ1cHQgc291cmNlXG4iKTsN
Cj4gPiArICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ICsgICAgIH0NCj4gPiArDQo+
ID4gKyAgICAgcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gIGNvbnN0IHN0cnVjdCB0ZWdy
YV9tY19zb2MgdGVncmExODZfbWNfc29jID0gew0KPiA+ICAgICAgIC5udW1fY2xpZW50cyA9IEFS
UkFZX1NJWkUodGVncmExODZfbWNfY2xpZW50cyksDQo+ID4gICAgICAgLmNsaWVudHMgPSB0ZWdy
YTE4Nl9tY19jbGllbnRzLA0KPiA+ICAgICAgIC5udW1fYWRkcmVzc19iaXRzID0gNDAsDQo+ID4g
ICAgICAgLm51bV9jaGFubmVscyA9IDQsDQo+ID4gKyAgICAgLmNsaWVudF9pZF9tYXNrID0gMHhm
ZiwNCj4gPiArICAgICAuaW50bWFzayA9IE1DX0lOVF9ERUNFUlJfR0VORVJBTElaRURfQ0FSVkVP
VVQgfA0KPiBNQ19JTlRfREVDRVJSX01UUyB8DQo+ID4gKyAgICAgICAgICAgICAgICBNQ19JTlRf
U0VDRVJSX1NFQyB8IE1DX0lOVF9ERUNFUlJfVlBSIHwNCj4gPiArICAgICAgICAgICAgICAgIE1D
X0lOVF9TRUNVUklUWV9WSU9MQVRJT04gfCBNQ19JTlRfREVDRVJSX0VNRU0sDQo+ID4gICAgICAg
Lm9wcyA9ICZ0ZWdyYTE4Nl9tY19vcHMsDQo+ID4gKyAgICAgLmludF9jaGFubmVsX21hc2sgPSAw
eDEwMDAwMGYsDQo+ID4gKyAgICAgLmdldF9pbnRfY2hhbm5lbCA9IHRlZ3JhMTg2X21jX2dldF9j
aGFubmVsLA0KPiA+ICB9Ow0KPiA+ICAjZW5kaWYNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
ZW1vcnkvdGVncmEvdGVncmExOTQuYw0KPiA+IGIvZHJpdmVycy9tZW1vcnkvdGVncmEvdGVncmEx
OTQuYyBpbmRleCA5NDAwMTE3Li5iYzE2NTY3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWVt
b3J5L3RlZ3JhL3RlZ3JhMTk0LmMNCj4gPiArKysgYi9kcml2ZXJzL21lbW9yeS90ZWdyYS90ZWdy
YTE5NC5jDQo+ID4gQEAgLTEzNDMsMTAgKzEzNDMsNTQgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB0
ZWdyYV9tY19jbGllbnQNCj4gdGVncmExOTRfbWNfY2xpZW50c1tdID0gew0KPiA+ICAgICAgIH0s
DQo+ID4gIH07DQo+ID4NCj4gPiArc3RhdGljIGludCB0ZWdyYTE5NF9tY19nZXRfY2hhbm5lbChz
dHJ1Y3QgdGVncmFfbWMgKm1jLCBpbnQNCj4gPiArKm1jX2NoYW5uZWwpDQo+IA0KPiBMb29rcyBs
aWtlICdtYycgY291bGQgYmUgYSBwb2ludGVyIHRvIGNvbnN0Lg0KPiANCj4gPiArew0KPiA+ICsg
ICAgIHUzMiBnX2ludHN0YXR1czsNCj4gDQo+IFZhcmlhYmxlIG5hbWUganVzdCAic3RhdHVzIiBi
ZWNhdXNlIGl0IGxvb2tzIGxpa2Ugc29tZSBodW5nYXJpYW4tbm90YXRpb24tDQo+IHN0eWxlLi4u
DQo+IA0KPiBUaGUgc2FtZSBpbiBvdGhlciBwbGFjZXMgbGlrZSB0aGlzLg0KPiANCk9rYXksIEkg
d2lsbCB1cGRhdGUgdGhpcyBpbiBuZXh0IHZlcnNpb24uDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywN
Cj4gS3J6eXN6dG9mDQo=
