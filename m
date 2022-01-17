Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CBA490743
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 12:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239183AbiAQLps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 06:45:48 -0500
Received: from mail-zr0che01on2099.outbound.protection.outlook.com ([40.107.24.99]:19105
        "EHLO CHE01-ZR0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239176AbiAQLpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 06:45:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTY3am89FkIDD1/PNm2MfI/VII5c9hHaehKYB/oquseHR80bBR9SOz7hfndeb/evHluKMzMmFkJkrWBcBuepi9TbMIittSrfFUzLOAMDMetymQKXe/Snmfc28ZmYb7amo/3qDpT4gRYmjMIqx6mm29mkLvQ4qUMyA/ku/Ss0UUQg9NdsxDBLHn0OX/QGnEjv0RYJYdE4uVKVDa9A2efCBjWPU4flIi0g7ByZOtoBEzG7WCfhXwk7CrcAcdcvJnrBfyDYoU5br1reWWGF3FgbuBLQ6sVvAY5A5CwOgZrYKu1t9kfpHijcvvqAQHz1zgR6/2ckN0mpnkpWACdP90zXBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmQFidm5L5UNTk9/NLeFGVq/hhTOC55+DZ77NEwQ0HA=;
 b=L5HWaflqrJRylXU2pQvq2LLiXXWipV2vd2W78HsixbUCz+xlkU9R6/R1UBXf+FxFNifXCmIvHrj0dzi3plT/7qQJ6doKNA8zC1WH0TCS7gsPNsTkxw1quq8UIM3YtyPzB8NpgilTtUJdrGqVvsGnyUAqWXOKVPpFHb4lPRFKllOYu3qaG1pevcwJik5Dkhua/k/9e+hBDcgORMWn43v7ajA3B+dHE5FqkYbXuDP1uCHbwNOf3QoSp2RMASgUrSBsjgwRInU7LPcv5+4OQwrhJXWJ+7szYWNOdSpxbH1cuU8w8vwguE1Nn5Ydnqk0WINw4oyMfL8YhJtD2Oxe3TCmQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmQFidm5L5UNTk9/NLeFGVq/hhTOC55+DZ77NEwQ0HA=;
 b=VdG5FYSPEGJvS8oqrIlAJWNYUcj+wb6DjBaXvmq3sQowRtRTP2v/5OkGW7nP4tqirt6t0xihtuFYWszvxeg8ID1pN7AkPbshqPavoO49EJZRyTux7f5StMSgrjeB8Nyx7qDdvzHNF4qcBjzL+sZuuz0Ln+VOGZgurT8i8i8P4sY=
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GVAP278MB0616.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Mon, 17 Jan 2022 11:45:45 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7067:aadd:1aa2:85ee]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7067:aadd:1aa2:85ee%8]) with mapi id 15.20.4888.013; Mon, 17 Jan 2022
 11:45:45 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski@canonical.com" 
        <krzysztof.kozlowski@canonical.com>
CC:     "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "biju.das.jz@bp.renesas.com" <biju.das.jz@bp.renesas.com>,
        "olof@lixom.net" <olof@lixom.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: Re: [PATCH v2 04/11] arm64: defconfig: enable pcieaer configuration
Thread-Topic: [PATCH v2 04/11] arm64: defconfig: enable pcieaer configuration
Thread-Index: AQHYCVE77D4xMHqxBECNxq/duJiOJ6xkS+kAgALQ+QA=
Date:   Mon, 17 Jan 2022 11:45:45 +0000
Message-ID: <28f9ff53dc1379fa6462bf54c5db556c3474c302.camel@toradex.com>
References: <20220114141507.395271-1-marcel@ziswiler.com>
         <20220114141507.395271-5-marcel@ziswiler.com>
         <a03f3240-0e68-1451-0d97-109c024f784a@canonical.com>
In-Reply-To: <a03f3240-0e68-1451-0d97-109c024f784a@canonical.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c75b7c5-fa20-49db-c6e6-08d9d9aee5c8
x-ms-traffictypediagnostic: GVAP278MB0616:EE_
x-microsoft-antispam-prvs: <GVAP278MB0616AF9988AC9D7A6F14C324FB579@GVAP278MB0616.CHEP278.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tPP3L+LPRiE0Oa0BYNpBdWPKTAgYCcGaS/xHuyyaH1x4mp/3lFMx9W8oN8GXwym2Yt7sSAlDBkoe9hzZ2oNogxSHr2ve4Il7vbu5HMh/mhPXiF7UCMGtc/k3HzFXqPH5ZF293PnobbQEj7dXgAsofTpHDbGJGdOHEjnVVCXyaTaBC2gHURiw9u0oxq6JbCCG2Z6Uzb0V4J/necxtIXpIgsnukdfkArUtPDmF3WmHFZp00Z5mV+VvTStlnZRti+7mc2vGkltaw4Q1t94XPrVn4vlOcZYnv9AiptrbDbRHPYAXo2QpXo9ekp28U0bLzVXdSFPEThE1cSiETwGT5pgNLEFXONtOHhznYID0W2Cd9kDaO3rJtlWzvpJZYOm8kC4WY8fvChhvXylyssUYGeClC8qni6do1QKZITdnXZYpwURRJWjgtTlZ/H98wZWSxXLrg4bz89/VaDmwI6pvwVGkBTnQ4YbDWFT9mGcW++BB2mqXZE9rBSJW9TORDANZDQnj0EZEN5hv6JUPNyXc4J2j9/BGxVYK3G15rKqkWVqxYfxV6K59Rn+ZrS/JzHhIpOZyXIhQCbM79eO/innTpio9fb4VprYnaFIGkVJeZ0kjrj5fLxHcOdhi5U/c01WQHHhkpWhmpHRUO0nwolyYvDqeH+/u/uGXV2WVsyuvg5xFmlmyd/a03SzscHWvUHkQfMS18r1HSNEUQmMTHcFsR9H+wQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39850400004)(376002)(136003)(86362001)(122000001)(6512007)(2906002)(38100700002)(4326008)(7416002)(76116006)(44832011)(5660300002)(6486002)(2616005)(4744005)(110136005)(38070700005)(316002)(83380400001)(71200400001)(26005)(186003)(66946007)(508600001)(6506007)(66476007)(8676002)(66556008)(64756008)(66446008)(53546011)(36756003)(8936002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0hndWlXaXJnNU8xb2loYUJQa25uTmdpaXllL251SGZIQkdBZDZLYVlmZDN4?=
 =?utf-8?B?QlEyT01yaCtxQUpsVTczbGJnVFE5UTI2THFxenlkTTNmeVJHdVlKak9HbU1W?=
 =?utf-8?B?SDJqOEI4QmZ4NlVZQ0x5MjJHd09uL0taMkpZemVFNzhYMzVlWjlnRjBWNWRW?=
 =?utf-8?B?b21EbURVRFczWi9UVWFiN1pxdDlFWkpFRVhhL3d4bTgyQnV3cE01Y0ZUZG9G?=
 =?utf-8?B?U05tVW9LZVp6V0JrejRGVGRNQnZORUlTdW1PTHdtaERIT2Z3SWh0dDZlQmZV?=
 =?utf-8?B?Y2R0OWlBUnZWNThRZHRKM0QvMm9zSXZBcG1ZUnluV04zMjNGUkNjWEJ6M29X?=
 =?utf-8?B?U3pkd2E4ZHZJcEZCQTJ1dUlWSDdZaFFCZVpDVXU0R3FPckRUT0tsYjF4ZGY2?=
 =?utf-8?B?Y1ZYUDMycWplVzNHc2VSMkRpT0R3WmR4blFic3RyVVN0NXVDSFNyaktYQm5H?=
 =?utf-8?B?cHd0bHB3Zno0cVpCbUI3cnFSM29jdEprVE00ZGJuaTdwbmMrUEhPS1F1ZmRZ?=
 =?utf-8?B?UVBLWlN2RFFzb21ZZmV5bXJCVEZyU0lpd2M5eHZxcmRzaGs3Z2RIbytDSDI2?=
 =?utf-8?B?UENsTGJRNzRBMUlTNnpyQ2dmcDRMcERxRDdZU2hPN0YrcTRpR0lEaUFkOUxj?=
 =?utf-8?B?TkIrOUdnU0tHL2hPZzU3MmdFMjdpamJSODJjRzdHdlRQeHNKZUd0ay83OHR5?=
 =?utf-8?B?QWh4cGtqR0lXL1k0L1Zxbjc5V2c4VzZVclp1Y1grWlNPakJRTmwzQ2IxYXNJ?=
 =?utf-8?B?RmtCVTdncFhJN1lwWEFGYVdBNkxjV2Z5ZkkrZ0UvVEhCNlJmVldEZjEvdis3?=
 =?utf-8?B?V2gvRnFRbGNpMnkwVWZZRVc0anBuK3dCQ3FoNTBmREJmOWRVYVlwZnNoN0FQ?=
 =?utf-8?B?dEtzdEtBUHZ2b0twUnlxVkZxK1J4RFNmV3dQL0I4ci9paEg5ODhuUERZRXox?=
 =?utf-8?B?WFErOU1xNkc0RlZaQUNwa0dBWFdUaXVtNUJXdktlcjNtdUYyNTNldGlCamhT?=
 =?utf-8?B?c29jM09hcWlwVkZPZmNqMG1rVTJsTHdmNTl2NVBaWmZ0V3JWQVFHV2xLSVZ6?=
 =?utf-8?B?QjJsYVlCTTBPYjA4ZFcwMzZrQTNkcTZxOFRuTGVKQ0xia0p4MnpNVERST3hH?=
 =?utf-8?B?NWYrcEZYSFF2U01YYjI2UXozcmI0UjFBOVNYUm5WWlVBNzhwbmtIbzQ4dFNX?=
 =?utf-8?B?UUdZK3JralpxNmttTDNqOGtINFJUa3JoUlQ3dnZvZ2d3M1NJWlZnbmN6eERq?=
 =?utf-8?B?YXJnZ0wyMUF4T2JJZDdLd2tMQXhtUVIyTUxNOVNRdVVhMUJQbVFLckNsT2Qv?=
 =?utf-8?B?Nk9sUHZuL0tCOXBxbm9WUTJVRm50SE0vN2NPb2p0Unh3ZWlrdVlxVkZKMktY?=
 =?utf-8?B?cmNXVnFOZFllWVdjUi9vaUIvSFZDTWdqTmZtYjZQNlNkeUFFS3ZmK1YyU2Fa?=
 =?utf-8?B?TmwrZXhlL01mb3I5akgzZkNTalZrRHA5TUJCUHg3Tm1sT2xsNmFBa2w2bXp6?=
 =?utf-8?B?MlMzM1RNbHRDUzFPeVhpYmkxOSs5YlVtbEhBM1kxUHZ3VGJlVCt6NUpGRnpn?=
 =?utf-8?B?RzFwYkNYWmd4R0E1VnFpNnBmdlRmUkt0NTJ1QjNTVW9KbTVXWVVjZkxtTmtW?=
 =?utf-8?B?Nmg1Q1VUait2NVFwYlZLdTM5TXc4WWZ5ZDczWEdON2lUTTlESU9IWHFkcUhh?=
 =?utf-8?B?NUIzbVFrclV2TjRMN29yak9mbGc0UDV0WHdYQzNVcGE3U2FjOUJ0Z1hUN0Yz?=
 =?utf-8?B?aE9JajRNM2N5akxFUkZYNFduYmZkVndLbTI3VlI1bUhydWlXZ2tpNnhFL1RR?=
 =?utf-8?B?VHhwd0UwZnJXdjYwQmhWNEkzN3FTUFcxQkFPK3c0Z3hrNjVDeVJDMGNTZ0xV?=
 =?utf-8?B?eUpqMHBVUndubzFON3o5RTZqSUcveUVCYWhRKytHdWRIUkQ1YzhQK0lUTkFp?=
 =?utf-8?B?QUVzeWF2dDVkT2NyZmtxRFJkb28rc2kvWmVCVEhYQUVmZ3ZWVzM0S0lGZ2kz?=
 =?utf-8?B?MVJOaERvajdhdHBxNGp6UFFvZElQNVpUOHpHNUptOFZkOHRwMmtTSlRzZDk5?=
 =?utf-8?B?aHhUZFo4aUo4T0VybUZLc0xQenF6eTdBK2sxN1VGVWJTTjNTUnc4cUY1UGVa?=
 =?utf-8?B?MXNRQUpITGMwSDNVU0tWOGRQajAxV0xZanhiNHh1Ti8wNENpcXNtcEJyTDhU?=
 =?utf-8?B?OWsxazNVSUdtYit0aklzdmljSjVVQkx0NVQ2VHhJck4vZm9uRmpYQmVEZTR1?=
 =?utf-8?Q?iErvAOSj/EfEau7CPZi+cGLZgdVBxKPVNGoxiDfyU0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A73403D35127AF4BA9FCCFFA267E8AFE@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c75b7c5-fa20-49db-c6e6-08d9d9aee5c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2022 11:45:45.1687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P3KIyMa7WqcEjRn0SgouBxYj8hrMMQo5ZFie3teqkdIjcabD88wiQ7sLyB5cAdDGxrEC8Kw4pgN1u9BsmQiYVRFBckDOjsc35ooxHFiaQos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0616
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIyLTAxLTE1IGF0IDE3OjQ1ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxNC8wMS8yMDIyIDE1OjE1LCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6DQo+ID4g
RnJvbTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+ID4g
DQo+ID4gRW5hYmxlIENPTkZJR19QQ0lFQUVSIHdoaWNoIGlzIHJlcXVpcmVkIGZvciBDT05GSUdf
QUNQSV9BUEVJX1BDSUVBRVIuDQo+ID4gQ29tbWl0IDhjOGZmNTViNGRhNyAoIlBDSS9BRVI6IERv
bid0IHNlbGVjdCBDT05GSUdfUENJRUFFUiBieSBkZWZhdWx0IikNCj4gPiBjaGFuZ2VkIGl0IHRv
IG5vIGxvbmdlciBiZWluZyBlbmFibGVkIGJ5IGRlZmF1bHQuDQo+ID4gDQo+ID4gU2lnbmVkLW9m
Zi1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+ID4g
DQo+ID4gLS0tDQo+ID4gDQo+ID4gQ2hhbmdlcyBpbiB2MjoNCj4gPiAtIE5ldyBwYXRjaCBmb2xs
b3dpbmcgZnVsbCBkZWZjb25maWcgYW5hbHlzaXMgYXMgcmVxdWVzdGVkIGJ5IEtyenlzenRvZi4N
Cj4gPiANCj4gDQo+IEdvb2QgZmluZGluZyEgVGhlIHF1ZXN0aW9uIGlzIHdoZXRoZXIgd2UgYWN0
dWFsbHkgbmVlZCBQQ0llIEFFUi4uLg0KDQpZZXMsIGhvd2V2ZXIsIHdoeSBlbHNlIHdvdWxkIHdl
IGhhdmUgZXhwbGljaXRseSBlbmFibGVkIENPTkZJR19BQ1BJX0FQRUlfUENJRUFFUj8NCg0KPiBC
ZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K
