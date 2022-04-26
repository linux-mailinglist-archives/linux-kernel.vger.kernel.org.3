Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A58C50EF05
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 05:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242262AbiDZDJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 23:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236154AbiDZDJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 23:09:17 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2118.outbound.protection.outlook.com [40.107.255.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A002DEB7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 20:06:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4jXxvINKFvt1pRq6Q05OHfkXyndeVZvbAwKB0hdeV0QHxuKXT8MKHwi2K6x2XdYBd6bj5OQ6HpsB0wZ7uVio35WfvIsbhxUaheqRaIgJZaXd860GVm6fD4uYPwzuuKsHCfKHYI9PRVpBsdNTKEDkuoqOYmnIf8ISZp1ES/M+ZSkF77aJKWxcIipoGyWJCfuGhepNuc4CpKB7hdC0+9Ddtmf8oiw75//I7HHJvYjJLvewcgpVcnndBikO+HykfLDLrGz7Gnvrk1sufgS80zIlvhcnQMJOzludkHII+k4e6KNhJEWOLySIU/kfaSALI/xiOV6U9xLxjp0Z9+uojNZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ilw3Q3pDBNqIvqQxAN1P23wVrCGTZ9kfMKw0RcrtUo=;
 b=StAFGWZI4joMHW5drv3lbscZFkXvomOQDx47Xi+RIqhPEkKL2hn2Rea6xxmoatr7LSFCbyeFIyWmB2PnU4Vs6jEMvnWskEZ7ySF46QpAhSAw9l8jbZWtzbs2NKM1VNzSBlWAb/G70OXJ8A0xCeZd1GOARrz8JxUjM37wt5q9KJwwpbQ63BCGM1lIq7flKk5zC2f0r51QO52Fcnm/Dz/43PQmKL0q120CuPRlPKNoneJjJ4DetZsWovPnWJDyja0Yy2SoZ4GxzMYtSuRoXePM8wSDjgsticnNtpuE003G/+qgOoWyNv/BentVQxeGdo2+Lwdok9w6BdguFk9nnuqAdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ilw3Q3pDBNqIvqQxAN1P23wVrCGTZ9kfMKw0RcrtUo=;
 b=hvKzKgMYn5Gxgd4YRhSoK/189AR4CWS+8HU0L1SL7d74hxHh7F3dwEbxt2BJdrw+9yQW9mf87vC0dWX5HyYMQFDso66pcGRsZyjY+OmA4KGuDD4DXxQeybwYutjWHrNAxS8h3U0ieYgQpKwqihuut1PxYgdF4kIKQQVnAZOj0AU=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by PS1PR0601MB3692.apcprd06.prod.outlook.com (2603:1096:300:77::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Tue, 26 Apr
 2022 03:06:07 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc%6]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 03:06:07 +0000
From:   =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>
Subject: [PATCH V2 0/2] Add complex scheduler level for arm64
Thread-Topic: [PATCH V2 0/2] Add complex scheduler level for arm64
Thread-Index: AQHYVj9eoepewNo3DkqqNT3OlOoJ+60Aoa0AgADjxTE=
Date:   Tue, 26 Apr 2022 03:06:07 +0000
Message-ID: <SL2PR06MB3082D393ADEC823426DEE7DFBDFB9@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1650628289-67716-1-git-send-email-wangqing@vivo.com>
 <20220425141926.00004d2e@Huawei.com>
In-Reply-To: <20220425141926.00004d2e@Huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 231b9f76-ff17-4d4c-bf3a-08da2731b55e
x-ms-traffictypediagnostic: PS1PR0601MB3692:EE_
x-microsoft-antispam-prvs: <PS1PR0601MB36921BE84B56894A95CAE336BDFB9@PS1PR0601MB3692.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BhLkSrQFFqkPFIZj6VPxMT4Sqyf6BvHqvlX2sSsU9vs5Tsohy2294r5IuN6A+4LBteJZiBZU6jZsLoi9/LLbYlZU0Fp1m5zrfYVsa3zarqpzNAt0t5HinN7RqZC0RGttDiVqYb6gXt0W81zBJQSkowM8mTUAiKgUHltramSrtVXeiV2RBAiSziB6WydaTTT2AcJsjWu5svwU3VmwD8c7U9HGkgXJKRNGCtcEiOfUf5UHAQEbhV0nSf0mc5jzrHF7y+5tcTMO5Avk989eZZDVovkajtGZTGTv2UfSfRC2l+zKRpxQxsmBfqyVKYxsehGAPDQ7e96taYjMgwhw5wCpzHXDmt+8dDyDbdVa7dqaz66NRzsaU8ImObwX3TVnfofi0kr1z2IHlP396GSV70F6OewADvfV4k//8rNITEAXezOO6/aDbPGXc6UncJVMxSbqJNUk8COAz6o/4CbEXLGvMDh7RNmBI8NLv5d8f6c61Ug1e6wsQ1V09xd4RYvDjHTXbGDghnEqk1wEz3TZZ9BTUlXh63YkqqrhepaKiq8w5AbKcc8E1sxFf7kqzVpI9Fq5nmXDcp/9VN9YIl2vputNDWzZO646EgvvZXmZDfBFKsvk/mhdOrhuONbeDhNWYctKk6dSAaJTXB2g7WduZPpO9daAUZ5YPaEP3Vys8J0+Gat4GLamc5OpngU2VHpgRNqKMYIdOBmm/DzgafY2fgACyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(83380400001)(5660300002)(122000001)(38070700005)(86362001)(71200400001)(6506007)(7696005)(9686003)(316002)(26005)(38100700002)(186003)(54906003)(508600001)(6916009)(52536014)(8936002)(7416002)(2906002)(91956017)(4326008)(8676002)(76116006)(66946007)(66476007)(66556008)(66446008)(64756008)(33656002)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amN5aVJNbTdJVzNmRUVpZlZKSWtoQy9UdU90Q1RnZUdtbmR1Mzh4bklHMmUz?=
 =?utf-8?B?bEtYV2phcGlOc2RSVjZ4V3p3RDhHaUxDQkdLUU55THY1cExSYzJDOStSaCs0?=
 =?utf-8?B?YU9NVEs1QWY0MHNUdjFGRG9yQkVGOUJ3OFhCVHBpLzJ4a2toVkF0QzdZODFO?=
 =?utf-8?B?b1B4eVB4ZGxyZWJ2bkJaenV5WE0zb2kwQ1pQMjdVMHZLeGt3QUxJd1pXNnNm?=
 =?utf-8?B?aU1IRXhadUdTZ2prS0EyK1VuN2NjUjhmODdsWjdPMlFoaDM2Q2Nhc3NJbTE0?=
 =?utf-8?B?N3llVzUxcERZWGNHZHllS1RwVUVIa3JBM05CY2dkSm15R0hyQ2xscStac2th?=
 =?utf-8?B?eW0zRHovNE4xMk5hMjZKUnBkQTQzQy9GV2p1S3JqeGZpL2ptSktIb2tRTFV3?=
 =?utf-8?B?V2J2Zjdaa2w5N2J6eWc3KzJ1NzNzSkh6cEF3Ty9EUEcyUS9uaExtQ25zRDRM?=
 =?utf-8?B?OUs0UnI1MW1NL2MrT1VNOURpLytnaW02bVltaHB5ZjZWR0J6d2ZPMzJCMm9S?=
 =?utf-8?B?RnRTUVQwWnhNNCtpYUVhT2V1OUdTM2dneUxrTWUrdzFNWklaNTNHanBBc1dY?=
 =?utf-8?B?V1ZvbFVCM0VaTjFCbE5NOFhjZG1tK2pkZjFvMHc1bUNvOXlBK3NQd3loT3Js?=
 =?utf-8?B?d1JsaDZlNmN2YVJUZHpJN0M2cFRLMjVEa1Z0MWdwdkpNM0IwOXhkUit5Vk1T?=
 =?utf-8?B?M2VoaHNWSCtxc3FCenU4MGhDNDR3alQrU2FtQ1FySmc3a2hPSldiNjl1MnVW?=
 =?utf-8?B?T1VBVC9kMDFEUUZPWHpVSVhjdTZhNk1saGxhSnN2SlJvd212QVFHbUZoOXBk?=
 =?utf-8?B?aGorT1cwL0VXMFZaaVcyZVlQWkNqYWNwM3QxdW0rL1luUjlRKzNCU3JhQXM3?=
 =?utf-8?B?dmhCRkhxRzZiM01nWTFOeVU0Q1crKzQ5ZG1JenduUU9na2JMbFJBamJ3NjlR?=
 =?utf-8?B?c1BvTGdWQVI5cEpnVVZPaFBrNkxpRlBZMEhPUkUyWmIyblZoaHZIenVMeldI?=
 =?utf-8?B?alhJQVdLdTdUTnlVTmY2eFpiUkNhYVBUM29zdndLZkI5a1ZhZWlyTzFVZ2hY?=
 =?utf-8?B?d2Zta2RPd3AxODJ6bng4aVFmOS9LM0dPSDUxSzc2bVU2d2RROHZGaVBlcmNY?=
 =?utf-8?B?NFZISit3RzNqaDZkN0o5UVk1eURkV2NwS3JBY3AxdFpNUG45OXVLMWs2aUZs?=
 =?utf-8?B?clowMGlVVVBRSXY4MHFNamZXaHpNVndRbjZBWi9GR0t0c0dhWjNEU0tCSG0y?=
 =?utf-8?B?dFhoRkFDUHY2OXhXZFd2L0lZSStZYm12YmtLWTBYN1JGQzhXVmdZV0NKYlFM?=
 =?utf-8?B?THliNjA1aktyK3lDU0hXeE4zdnV4NldKYUJmK1BVY0NYdUh3U1N1cDdxeXNa?=
 =?utf-8?B?dnZPQWVmdVdRK2k5U05BUU9qVWRITTh6N1FrWFdjYk42bXJST0J1RVAvTHNp?=
 =?utf-8?B?NUxOOWFTdFdiSmZNMkRWcGc2SmdFd09TQmN5MFh2dGZIbUlXV3lETitReGNJ?=
 =?utf-8?B?bnJQT1BOVG9HN1lIRDRuYVQvbVcvdUdTWlVNeEg1cmUvajJhUmpVSHBPWllt?=
 =?utf-8?B?SERTbjY1Z3dRYUNHa3NFV2lTazJkVXZtaWRDT29TT3loOXloMmZudjVWcWp2?=
 =?utf-8?B?dUZnZTkxMG1WNVU2bWRDSjl6WkMrdlUzNUlzeHY5cVpUTUQvK2I3VkMzVTgw?=
 =?utf-8?B?VE5MQUVDbVRvbDNaYjF1dkF1THB6cW9sRzBucHdwcTFGRXN1aU5iQWJHTzIy?=
 =?utf-8?B?RFFTQWdPRFBhNlprVXpwTDVvbTF5WnEyaWc4YlpUVDloRndWRzRtM2J6VElU?=
 =?utf-8?B?eVRRbVJaSjJTRlVaT1BxQzNRSHZ0Vy82Zm9pdThZc2JCSVo0alc3TTlWeGJH?=
 =?utf-8?B?cDVaWDdNZHJEcEJUWUI2N0NoeFZNZ0xEMmtJdVo0dWExQWZoL0x3OFd6K2ll?=
 =?utf-8?B?THNHandMdVBjdUsyZUJmOGloaGZjZ3ArMjVsYUw4YTUrWVl3TnBHVHduTmlr?=
 =?utf-8?B?TllHOUZUUUx6Z3lsRG4xUEJjL1JTUWhibjNpQWpoY0dDQTUrTXdBWXN6M08v?=
 =?utf-8?B?WnV6RHhWMjYvM3hYMDhhK1U3QjFybm42ZjczYTIzT081S2tWQ3AySW9Bemxu?=
 =?utf-8?B?b1FUT0JYSWxDMlh3N29sbjNkNnVRZU9sYmZaUVA3OG9rWGU1SHhiVVp3eVlT?=
 =?utf-8?B?VUNRYTJiL1Erd0x1QmZ5Q3c0TTJ2ckgvbHRZRXhwTEhzN3ZFOHBxM2sxTXRM?=
 =?utf-8?B?ODNtanlUM3BCVTdqMUVNRkJyQWtZUjkvRjlpYkNPcXQyTVRjZ3ZPc25Qbk4x?=
 =?utf-8?Q?fWrcXi6QnRO6uufuCR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 231b9f76-ff17-4d4c-bf3a-08da2731b55e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 03:06:07.5956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n61iYCS1eUD33tsoFPJgcab4pG0xy3Uu07BHEdoNN4l0JvQPLLaKm3/M1AlltEr2+tjCwnmvXoizRWQTV+9QOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR0601MB3692
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4+IEZyb206IFdhbmcgUWluZyA8d2FuZ3FpbmdAdml2by5jb20+Cj4+IAo+PiBUaGUgRFNVIGNs
dXN0ZXIgc3VwcG9ydHMgYmxvY2tzIHRoYXQgYXJlIGNhbGxlZCBjb21wbGV4ZXMKPj4gd2hpY2gg
Y29udGFpbiB1cCB0byB0d28gY29yZXMgb2YgdGhlIHNhbWUgdHlwZSBhbmQgc29tZSBzaGFyZWQg
bG9naWMsCj4+IHdoaWNoIHNoYXJpbmcgc29tZSBsb2dpYyBiZXR3ZWVuIHRoZSBjb3JlcyBjYW4g
bWFrZSBhIGNvbXBsZXggYXJlYSBlZmZpY2llbnQuCj4+Cj4KPkdpdmVuIHRoZSBjb21wbGV4IHNo
YXJlcyB0aGluZ3MgbGlrZSB0aGUgU1ZFIHVuaXRzIChjb3J0ZXggYTUxMCkuLi4KPgo+V2h5IG5v
dCBoYW5kbGUgdGhpcyBhcyBTTVQ/CgpTTVQgc2hvdWxkIHNoYXJlIGFsbCBjYWNoZSBsZXZlbHMu
IGJ1dCBjb21wbGV4cyBvbmx5IHNoYXJlIEwyKGFuZCBMMykKY2FjaGUgaGVyZS4KCj4KPlNlZW1z
IGxpa2UgYSBibHVycmVkIGJvdW5kYXJ5IGJldHdlZW4gc2VwYXJhdGUgY29yZXMgYW5kIFNNVCB0
aHJlYWRzLgo+SSB0aGluayB3ZSBuZWVkIHRvIGV4cHJlc3MgYW5kIHBvdGVudGlhbGx5IHRha2Ug
YWR2YW50YWdlIG9mIGtub3dsZWRnZQo+YWJvdXQgd2hhdCBsb2dpYyBpcyBiZWluZyBzaGFyZWQu
CgpMb2dpYyBzdWNoIGFzIGEgVmVjdG9yIFByb2Nlc3NpbmcgVW5pdCwgTDIgVHJhbnNsYXRpb24g
TG9va2FzaWRlIEJ1ZmZlcgooVExCKSAuLi4gYXJlIHNoYXJlZCwgSSBiZWxpZXZlIHRoaXMgd2ls
bCBpbXByb3ZlIGVmZmljaWVuY3kgZXZlbiBpZgpvbmx5IEwyIGNhY2hlIGlzIHNoYXJlZC4KClRo
YW5rcywKUWluZwoKPgo+Sm9uYXRoYW4KPgo+PiBDb21wbGV4IGFsc28gY2FuIGJlIGNvbnNpZGVy
ZWQgYXMgYSBzaGFyZWQgY2FjaGUgZ3JvdXAgc21hbGxlcgo+PiB0aGFuIGNsdXN0ZXIuCj4+IAo+
PiBUaGlzIHBhdGNoIGFkZHMgY29tcGxleCBsZXZlbCBmb3IgY29tcGxleHMgYnkgcGFyc2luZyBj
YWNoZSB0b3BvbG9neQo+PiBmb3JtIERULiBJdCB3aWxsIGRpcmVjdGx5IGJlbmVmaXQgYSBsb3Qg
b2Ygd29ya2xvYWQgd2hpY2ggbG92ZXMgbW9yZQo+PiByZXNvdXJjZXMgc3VjaCBhcyBtZW1vcnkg
YmFuZHdpZHRoLCBjYWNoZXMuCj4+IAo+PiBOb3RlIHRoaXMgcGF0Y2ggb25seSBoYW5kbGUgdGhl
IERUIGNhc2UuCj4+IAo+PiBWMjoKPj4gZml4IGNvbW1pdCBsb2cgYW5kIGxvb3AgbW9yZQo+PiAK
Pj4gd2FuZ3FpbmcgKDIpOgo+PsKgwqAgYXJjaF90b3BvbG9neTogc3VwcG9ydCBmb3IgZGVzY3Jp
YmluZyBjYWNoZSB0b3BvbG9neSBmcm9tIERUCj4+wqDCoCBhcm02NDogQWRkIGNvbXBsZXggc2No
ZWR1bGVyIGxldmVsIGZvciBhcm02NAo+PiAKPj7CoCBhcmNoL2FybTY0L0tjb25maWfCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHwgMTMgKysrKysrKysrKwo+PsKgIGFyY2gvYXJtNjQva2VybmVsL3Nt
cC5jwqDCoMKgwqDCoMKgIHwgNDggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0K
Pj7CoCBkcml2ZXJzL2Jhc2UvYXJjaF90b3BvbG9neS5jwqAgfCA0NyArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystCj4+wqAgaW5jbHVkZS9saW51eC9hcmNoX3RvcG9sb2d5LmggfMKg
IDMgKysrCj4+wqAgNCBmaWxlcyBjaGFuZ2VkLCAxMDkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKPj4gCg==
