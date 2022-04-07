Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52254F72B6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 05:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239917AbiDGDN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 23:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239693AbiDGDNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 23:13:55 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2129.outbound.protection.outlook.com [40.107.215.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79AA25C70
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 20:11:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Haz62buzYGrC8n/snQ5i1JVl0Mz5iWdNmXXFYxFVEldu2/LpTUIT6eNPRYIies5wRliVIC3NHgMQ3Qx8iGXl2uvATeg6YHu7vnU/BfUcGbf/U8riCR68TEGGvO9c8XXkt5wlnuzJKM1jXWGKNr47bs1k03fTJchEOQFq7dsc9MJ2hQvaFnJjZeN2VLY8oax9wBqRkFayaVeScCS/GdI4kt71McsrIFZjL9/n+SBgsig3nuwur8kZO5etQFKxS08v40SHiRS6hY3WPEILgtIkCdIhdYfhbs0YiDixttUan7m1vtcVKr6WZOaOaIbIJb2GFhKbJEv2oA8WqHoZ3KrLEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQUdkgELu77sHJzfrYVy1qJLM0szYeXcZRYPEqAariQ=;
 b=RqtKFKGiVYrOEbVt9DbEX/PY8eVAdK2/LUHi7RAjfdXuT2jUTgj/JXiwoVRJcZYPuykTdTF/FmSeuhtPlc+d1O3jHCwsQAlEgqGuIOPi9sxKLrpes73dnJLdx7ZeN6OZnImGMBv9tuzBk4/DRxXZUiC8vskgtyt6634G29sq+cef7MkHRHJowMPGndoQG5abZuUo1Z3+vrN7gfcoZQOHjVrEthp87Z04CUkk2vZfwdQydI8BYf0LXFoSlz6N8iqkQZF1rLMivZe3XuQxGCFHHtUWPAUxOnD1/cKNp2B0QohTVP27S3MSH79gQs4tv61lbXxjKFXjoQzlg3UounOfZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQUdkgELu77sHJzfrYVy1qJLM0szYeXcZRYPEqAariQ=;
 b=RWf+wmvKg9+oDxd390dP8BODQkSmodSf1QLiQ+o2XL8FYL6cmbu37yqcGOMIGWx1WHBkyyeSsLEuz1DM69d2GyMTP9z/2AAR+7pcL1ZRBXwzFWTWS2CpQLRBN1pBb2IXBt8hCf2swqQjac6I1ergW7s/N4iwMKr3mR/JvMRIhnQ=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SG2PR06MB3696.apcprd06.prod.outlook.com (2603:1096:4:d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Thu, 7 Apr
 2022 03:11:52 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc%6]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 03:11:52 +0000
From:   =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        wangqing <11112896@bbktel.com>
Subject: [PATCH] arch_topology: support parsing cache topology from DT
Thread-Topic: [PATCH] arch_topology: support parsing cache topology from DT
Thread-Index: AQHYSZdCGkQ2mLDvVU6wfMdXkcz1WqziuauAgAEIO/I=
Date:   Thu, 7 Apr 2022 03:11:51 +0000
Message-ID: <SL2PR06MB3082F70F1F4CE661288103C1BDE69@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1649236680-4340-1-git-send-email-wangqing@vivo.com>
 <20220406110655.iimv6s4godvgfwoq@bogus>
In-Reply-To: <20220406110655.iimv6s4godvgfwoq@bogus>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efbc7a09-64cf-4fdb-639f-08da18445cd7
x-ms-traffictypediagnostic: SG2PR06MB3696:EE_
x-microsoft-antispam-prvs: <SG2PR06MB369601866404803464360F11BDE69@SG2PR06MB3696.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XeOslb2EjYV7Huixa7FeCp7PPHALcXo4lU5L7v7OqVRaAHcbwTjyUygwqPck46miAYVwIF/Tun3jHPepQw1ErJs2AzQIK6dtW+lNp/AkvpgHQVUTmhFlVVWIOzIJ4xS2m3PCPbyTPVJ2hFYEzg/V17SGjbc50MfJysViFXY0rXO+RsUKriKzQkevH39S0eY/U6jQZAVNsHc87WlLmEgr00V3F5N2b/gDPB49wazsxHnTBAtA0E70alqolIrdTkUei/gt1i5PvgcC7xk5tj10nslx1MbhiH28Ez6cWdWtVEbNutuuUEkqU6Eljg37vH1rkxDTidI4b8Z5F1UUk/hXFB6iuHU7h7UijT8jF3E9WgmpvIssHbH2YFRInbtKLJCJKnjnpTDtp3OCsnLVc2U3tegxwVFMCCD5ToJfVmb5BSGhvwHc8bEUx+FQzdh7iGK+QLHm8Kr8usJMdSQNKuDjCFMCsVmS0ZYMD6ti4fch1sNw3ervCim9Vrnb3ugm8FjPEOFqYY8lJFQEubsOoh286IWomeWd41A1CqOIUJ2D28jnL78GlA5jCmkKSk0MyLt+9G+69ZbkLfrCOgdrz4T5hPbdXAEYtPqz5f9XFKAo8En3I2ApsGeBT0W+8XsWqNbMSjsSc8pNuK47hkq4DbrGoloh9UTzRBVRpDevQ3ZHDSBz9FaGpg8ojUA7dcVjCBkl/7rYogr09KabldP59NcTHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(6506007)(91956017)(54906003)(71200400001)(5660300002)(7696005)(83380400001)(76116006)(85182001)(66946007)(66476007)(6916009)(66446008)(64756008)(4326008)(8676002)(66556008)(316002)(508600001)(38070700005)(38100700002)(55016003)(86362001)(9686003)(52536014)(8936002)(122000001)(33656002)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3R6c2JjSndXVnBDMlpvTjJQekxHM3dUekdkR1U0aHlxY0dDUzI4S2hjSVRF?=
 =?utf-8?B?WThXQ0ZMT0tuL3JjZURBTk9GdHc5TEJuZTl4NkppMDRkdmNXUzNIQk9XMHNT?=
 =?utf-8?B?NXZUUWxuQ3pYKzBoSTVHbWFVOCtlV2JyZ1RxVXEyZTFSZVVWZW1kWWJKVUN4?=
 =?utf-8?B?c2pLK0pjSzVBQm5MMWFsM1ZjeVhPeTNhdUtjSHlPUzJseDZmZlBtY0hqMksw?=
 =?utf-8?B?Mk91YlU3UldERkZxcjhXYzVnWlIyaWczTzVCbnZVT2VZNlgrN2F4TDd1R2l4?=
 =?utf-8?B?WXFReE0yR3hTTy83d2VORnRNci9tT1p0Z0RLdjFZRVpxTE9XdEhpSEs2UlFF?=
 =?utf-8?B?V2FjaDBMQjQwUldnYXdXVUNhRGFOTTNqSjFrSHErL3ZDZFhQcmlyR1ZndzVs?=
 =?utf-8?B?VDVIQXZVZnVDejR6Um51cTRjVHUrVnRqQVJSbmtTZjhMcUdhQkdDNkpBdlQx?=
 =?utf-8?B?MzlQcXA0YVVtcjlEc3NiT0lTN2JGSGZ5OHZYQm1KNEE0Q095SmtuR2J3UUt5?=
 =?utf-8?B?elpac2I3akU2dGZoeGJkRGxlK1dkL0Q3VkZvc1JFTFI3emZFTTVrVWxZRnNW?=
 =?utf-8?B?d2pBWGxONGpPY2FSdlBKNGw2c1NnU0IwK2NPUjVLRXdSMHRZZ2tRM1Jhc0U0?=
 =?utf-8?B?OWRtNThKcmtFcjc5MW51dTZXSzNRcGRYNlJxVGt5WmdzMk54S0k2a010RlBE?=
 =?utf-8?B?Q1pYa0lBemI2TzJ0SXFWOXhHVkFCYzIvUERvUHJTSWVCMmcwZGRyRDZ0RkxN?=
 =?utf-8?B?cWtqcXp6VXhRUEhEYk9SYjJSRzNHRzlpVXFLbHhuWHJJdllsL254VTVPL1Zs?=
 =?utf-8?B?QzQ1RzFVZnFwNGxOb2ZvOVA1QTVING1GZ0QvekRCTmR0VVZQODFJNmV1SjhU?=
 =?utf-8?B?UXg4cWhLKy9DeFhBeFp0ZHRkclhKUU00alR0V2JicFYrWlR4dVQvM1B1eWhi?=
 =?utf-8?B?UHdncjlBS3BHRU1zUVlqOHYyNkUyMThKNVUzL1hqcEEwNHFsLzVkV0lYMUFz?=
 =?utf-8?B?OC9iNW9aejg3KzZxcXVvU2NubUxadEhpdG1ZS0dxU2ZzTkoxV1BLSEMyLzJ1?=
 =?utf-8?B?Q3lXY2hEVjJhL2wyR1ZnVGdTWTJPQno5ay80cCtEaVdNWkFsVVhqUStaK1Z1?=
 =?utf-8?B?WkZJNGE5R2hQZm5tMFk1M1JGaEo2TDlLaUNBdE96aE9rY1V1VWRwWkVqcGFZ?=
 =?utf-8?B?dG1uTGp6U1JITVVTWExEbklWRHpuNzNaeFgwSlJWUHlsQUc1cFpVbGxQek9n?=
 =?utf-8?B?NUxydFIrQ3gwaC9majk2M1h4bXlIVFNWeDErMjBGYnNQN1pwL3pUbHlocGtY?=
 =?utf-8?B?TG5ENXdPY2VRcUVWVzlPY0tDV0Q4TFBpejRWNzNreHBLL09mM2tpQ3hLalp0?=
 =?utf-8?B?blBlMVNLSm9YcmZvNC9ZbzRsck9JVSs3cnhBb1dVczJHbitnSDBEL0lQR3FP?=
 =?utf-8?B?b0p4SC9hMFlqSTVhc1gwMktJK2Irc3ZRU3ZHZFNMRHdWZ0lVeW8vYitsUkVQ?=
 =?utf-8?B?TTdzTzRTdW44elVvSkNsN1NwN0lQUFNPVG10bXZ6ZVY5T2NIQXB4anNVeUh4?=
 =?utf-8?B?RnRGYnBWa001cjNBc0lKTmFjK2VqMldpbCtMYW5McUFHTHRobm9INDk5UVNj?=
 =?utf-8?B?T2Y0WXJQMFQ3NU5OTDFKdGcyaG1WcG5jYWJzQWI0WGRmQ0NIdXd6ZENYUFdn?=
 =?utf-8?B?SXBqMHhNWjZzYXBVb1lYY2xoSXhjYTJDV1gySjMzMHE0MkhXVGpCbFFUNnU2?=
 =?utf-8?B?NzZFaitPMXQra3E2ZWhHWjFkaFFxaDhjdGxHWmZPNEJRRzNlZS9UNFRJcEx6?=
 =?utf-8?B?bXRLUmRqTmxpQ1pvQTZvS3V2cE83aXdCS21LYStBY3BGY3hrWlJSNjNTQndU?=
 =?utf-8?B?MXZoNldOZzhpZ2VmOXU3bVBWbkhmSVJ6cENPN0FRNmwrWnFXWEtNa0Y3WXk1?=
 =?utf-8?B?WVRxR21oekJRWjdxWnE2TkduWE5wTm1UWktRcDJDQkZLZzQ2Yis3L1AwWVky?=
 =?utf-8?B?SGt6OVRHVjI0SHpuUktoMlF4b2YrZHBjb0tERGIvWjRRMXVUU1pvNWJPT3Vx?=
 =?utf-8?B?QzlNdXpnRlhjdlpGZkVwVk5HYjNEUzNXVXl6RjZCbWhhMVJCcDdwbVdlbHZE?=
 =?utf-8?B?bSt6OXo0ais5OXlrSVJDNmNDdG9hV1IwanFJL3BaNGhIWGpMQnBBS1ZJK2Fw?=
 =?utf-8?B?endUR1JvS3hLSStVMnpuL1YydXdaWW1MeVZxbCtjZ3ZGSVpsWnYrOXpIOVhP?=
 =?utf-8?B?a2V3YjNWZHkxWStKYzlST2l3eWdkaVFEYysreUJiaGdZemdMK1MwU0RSRjdj?=
 =?utf-8?Q?6i8hm52rWsE1Jy6ajH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efbc7a09-64cf-4fdb-639f-08da18445cd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 03:11:52.0027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: evFwMZKwxcnFozgcl2nohJMsRSDtnMnVY48rdhelMABRcF++6BSpW9mNzjt8BxsYv2gPCkOQf4b4W4qSURMObQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3696
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4+IEZyb206IHdhbmdxaW5nIDwxMTExMjg5NkBiYmt0ZWwuY29tPgo+PiAKPj4gV2hlbiBBQ1BJ
IGlzIG5vdCBlbmFibGVkLCB3ZSBjYW4gcGFyc2UgY2FjaGUgdG9wb2xvcHkgZnJvbSBEVDoKPj4g
KsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjcHUwOiBjcHVAMDAwIHsKPj4gKsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmV4dC1sZXZlbC1jYWNoZSA9IDwmTDJfMT47
Cj4+ICrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEwyXzE6IGwyLWNh
Y2hlIHsKPj4gKsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgY29tcGF0aWJsZSA9ICJjYWNoZSI7Cj4+ICrCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZXh0LWxldmVsLWNhY2hlID0g
PCZMM18xPjsKPj4gKsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9
Owo+PiAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBMM18xOiBsMy1j
YWNoZSB7Cj4+ICrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAiY2FjaGUiOwo+PiAqwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH07Cj4+ICrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fTsKPj4gKgo+PiAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNwdTE6IGNwdUAwMDEgewo+PiAq
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZXh0LWxldmVsLWNhY2hl
ID0gPCZMMl8xPjsKPj4gKsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Owo+PiAqwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNwdTI6IGNwdUAwMDIgewo+PiAqwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBMMl8yOiBsMi1jYWNoZSB7Cj4+ICrCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAi
Y2FjaGUiOwo+PiAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgbmV4dC1sZXZlbC1jYWNoZSA9IDwmTDNfMT47Cj4+ICrCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH07Cj4+ICrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfTsKPj4gKgo+PiAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNwdTM6IGNwdUAwMDMgewo+
PiAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZXh0LWxldmVsLWNh
Y2hlID0gPCZMMl8yPjsKPj4gKsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Owo+PiBjYWNoZV90
b3BvbG9neSBob2xkIHRoZSBwb2ludGVyIGRlc2NyaWJpbmcgIm5leHQtbGV2ZWwtY2FjaGUiLCAK
Pj4gaXQgY2FuIGRlc2NyaWJlIHRoZSBjYWNoZSB0b3BvbG9neSBvZiBldmVyeSBsZXZlbC4KPj4g
Cj4+IEV4cGFuZCB0aGUgdXNlIG9mIGxsY19zaWJsaW5nIHdoZW4gQUNQSSBpcyBub3QgZW5hYmxl
ZC4KPj4KPgo+WW91IHNlZW0gdG8gaGF2ZSBwb3N0ZWQgdGhpcyBwYXRjaCBhcyBwYXJ0IG9mIHRo
ZSBzZXJpZXMgZmlyc3QuIE9uZSBwYXRjaAo+d2FzIHJlamVjdGVkIGFuZCB0aGVuIHlvdSBwb3N0
IHRoaXMgd2l0aG91dCBhbnkgaGlzdG9yeS4gSXQgY29uZnVzZXMgaWYgeW91Cj5kb24ndCBwcm92
aWRlIGFsbCB0aGUgYmFja2dyb3VuZC9oaXN0b3J5LgoKWWVzLCB0aGUgc2VyaWVzIGNvbnRhaW5z
IHNldmVyYWwgcGFydHMsIHRoZSBzY2hlZF9kb21haW4gcGFydCB3YXMgcmVqZWN0ZWQKdGVtcG9y
YXJ5LiBCdXQgaXQgaGFzIG5vdGhpbmcgdG8gZG8gd2l0aCB0aGlzIHBhdGNoLCB0aGF0J3Mgd2h5
IEkgdG9vayBpdCBhcGFydC4KVGhlIGJhY2tncm91bmQgZG9lc24ndCBtYXR0ZXIsIGxldCdzIGZv
Y3VzIG9uIHRoaXMgcGF0Y2ggaXRzZWxmLgoKPgo+SGF2aW5nIHNhaWQgdGhhdCwgTkFDSyBmb3Ig
dGhpcyBwYXRjaCBhcyBpdCBzdGFuZHMuIFdlIGhhdmUKPmRyaXZlcnMvYmFzZS9jYWNoZWluZm8u
YyB3aGljaCBoYXMgYWxsIHRoZSBwYXJzaW5nIG9mIGNhY2hlIGluZm9ybWF0aW9uLgo+SUlSQyB3
ZSBhbHJlYWR5IGNvbnNpZGVyIExMQyBidXQgaGlnaGxpZ2h0IGlmIGFueXRoaW5nIGlzIHBhcnRp
Y3VsYXJseQo+bWlzc2luZy4gSSBhbSB1bmFibGUgdG8gZm9sbG93L3VuZGVyc3RhbmQgd2l0aCB5
b3UgY29tbWl0IG1lc3NhZ2UuIAoKY2FjaGVpbmZvLmMganVzdCBkZXNjcmliZXMgdGhlIHByb3Bl
cnRpZXMgb2YgdGhlIGNhY2hlLCBJdCBjYW4ndCBkZXNjcmliZQp0aGUgY2FjaGUgdG9wb2xvZ3ks
IHNvbWUgbGlrZSBjcHVpbmZvIGFuZCBjcHUgdG9wb2xvZ3kuCgpsbGNfc2libGluZyBpcyBub3Qg
dXNlZCBhdCBhbGwgaWYgQUNQSSBpcyBub3QgZW5hYmxlZCwgYmVjYXVzZSBsbGNfaWQKYWx3YXlz
IGJlIC0xLCBhbmQgY3B1X2NvcmVncm91cF9tYXNrKCkgYWx3YXlzIHJldHVybiB0aGUgY29yZV9z
aWJsaW5nLgoKV2h5IG5vdCBnZXQgdGhlIGNhY2hlIHRvcG9sb2d5IGZyb20gRFQgaWYgdGhlIGFy
Y2ggc3VwcG9ydCBHRU5FUklDX0FSQ0hfVE9QT0xPR1kuCgpUaGFua3MsCldhbmcKCj4KPi0tIAo+
UmVnYXJkcywKPlN1ZGVlcA==
