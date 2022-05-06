Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D089551D3C9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346595AbiEFI6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344336AbiEFI6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:58:04 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2121.outbound.protection.outlook.com [40.107.117.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97A55D5CE
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 01:54:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrOt1Dv2Xy4ci0OEGTnH0CtNWfAYLDVJ6FTo2EBXUKMUAjqYF7mvGG7BQFha0rbGJ2YWpieN6mRTJtWbkuKlA/RIWldetr2LdVH+ZO2w6mmAX72P/uE9bBtfUuT1wD0+8MdRBhA1dBfW7F4gLzrHCQaj+Y039omqrWrM9QN1nEmFWehUIlQhXGoXQCjANQf7ZyO641hxt7GIuyXVCK9jlBsRluLdt84hWev9LnV5RIQ0YUg/plqe/JCGmfBS7mjL2O3vvWLQhbjcyufHXcx0mBzKtRZKIaQ35YIeRK2sdnwLqiEUXxzCNP7dQr/ODqCpDJN0lF2eUHF5Ttr3yDuWsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNDefu3ylQ80QCdzv+2gPmtWbSDiZesi1H0+oS5g7kY=;
 b=RVlJXakO3k7cTLYXBq3iTMiYRCPgbqa3BSDuH2KQY2ud20ettlbcslftsw7tHuIrnxlOqkhjMnriqPf53SZvnmaciSK0SVD5wvQnu1sPSMC8znJ5SM9hoFoWzLNtqsSpQhTmpSVIpOidKBdo3fTRxhMEg474H8b9pNYDy43WE0FpDH5zNBs7Yh3LKPAxiSUgRE5jKr2pZKGD3GOJAp71Tr4YQ1jx+QU0ymtiX3fgxr02yBqx2ltMrbDi7t7r1QCX+G5nhhYXsOYw9BK6ym/53h7Yll6qeGoL4BeQ1C1mqH7qET3UOfFYGs0wMv4Ep3K+t/8UWbpdk9SMbd3bCXzfTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNDefu3ylQ80QCdzv+2gPmtWbSDiZesi1H0+oS5g7kY=;
 b=eUq530igKXKqxulx0lo2cfhep0DpJyNVGq7DxycfAbCPkVH7Wk1h0ULT/PU6NDX6DQQwRdpt6dB44clf3MGo0GaGbxNRmCmsGHsrHmZIkD1xE6cIbPTbfNdPp8CyP8ImToWLy3K6EdC1MM8y4kRBr8MAopcqyUXAhh5MZ90B+Yw=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by HK0PR06MB3186.apcprd06.prod.outlook.com (2603:1096:203:87::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Fri, 6 May
 2022 08:54:19 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc%6]) with mapi id 15.20.5206.027; Fri, 6 May 2022
 08:54:18 +0000
From:   =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH V2] sched: Introduce util_est boost
Thread-Topic: [PATCH V2] sched: Introduce util_est boost
Thread-Index: AQHYWJouKp3/m7KKrEau2gkx10hTfq0RmOl2
Date:   Fri, 6 May 2022 08:54:18 +0000
Message-ID: <SL2PR06MB30828BC1E81109961707F3E9BDC59@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1650887211-94710-1-git-send-email-wangqing@vivo.com>
In-Reply-To: <1650887211-94710-1-git-send-email-wangqing@vivo.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 831606ab-43b2-401c-bab8-08da2f3e0182
x-ms-traffictypediagnostic: HK0PR06MB3186:EE_
x-microsoft-antispam-prvs: <HK0PR06MB3186C8139A24D30426319790BDC59@HK0PR06MB3186.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zsZBsxstcYzirpxkyHh0NNkWcPoVy18J5WAnYI8BxU1jrmE+ED63/BxxzFowEXn6TuqxU8dubumJwto3zfiU76ER+RWh6rKjb5/623HHnCQAyEN1fGKXzecp59v9e4RdaUnj8Y36v1xQLrV4NzPSnjYO3PS/1cUDVNKR8YpqszaZlJkDNT5D/F3zpGM2nNm/pwxbnSo8w0bC0rkLlJM3X/RqJlweZC/l+lMs9Z2RmN8DThCypvO5elMKc1WX9HguD7K0VBkC6c6epK+LTFZa/mRd4I3uCqtjx+XkYayzzmL7B92FY0pNwrKF1oPXJq0WJagFQj0zef2YmewswiATRm1QzZYGdxHNfYpQKl8D9820t0iyfBRMNh2oMt0BH8TAIBc6XkH3ieD8xHje0SIjoxC712XuHSqTsZ8Ub7huJEx0Q2+3lNwJMpVkw15qmN4vpbA2l/fF+6paO6wdBZfthvFqhLeoyx54nlu2K5xay/xNB5W7onJ37NMJ7GLgwgt1b/GmWkfJi2rQxIOSM/bq9OabXn6FIp1d3/fbkRvIcmaCVhD3UVg1h+qcAMr1uejwtbAFlHsRDaKLFR8mgSCdpc7GIg4xJKo/OBxmenJexKQwDDh7Pxhbhpwwd5QX4zQ9eFxTScTxZHJ0n5Aa+dUe37tDx6NipGgOStoe9Csij6Ho1KaLDQZ+s/o2i6fBcxVl1bs+xXT0xjY0yF+jpxZbNfWA6ZKqCKT57IiFBGoPeLw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(921005)(122000001)(52536014)(38100700002)(66946007)(38070700005)(66476007)(91956017)(8676002)(66446008)(64756008)(66556008)(76116006)(86362001)(8936002)(2906002)(7416002)(5660300002)(508600001)(7696005)(71200400001)(55016003)(9686003)(85182001)(186003)(6506007)(316002)(83380400001)(110136005)(33656002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OW1jYkl2Tk9ZNm5Qa1VRbUVoMkRCc2J3UFBTMnliaUdYeTg0NEhsMkdrQWJE?=
 =?utf-8?B?TWNyTC8rSG9HdkllUzluZmpXbEczQms1S3kxK0J3TlQwSFViLzEycnMzVUth?=
 =?utf-8?B?czJlbkpxc05MOTVIdnRZd2NIN2MxdzNreTdtV3hpSENUaURSbHRMeEFwYmpx?=
 =?utf-8?B?bU1uRC90ZmZnNFNqOXF2bEdKRW5KYmxtVjJPbXZReDViQWtBaHp4d3JDNVMz?=
 =?utf-8?B?KzNTU1FxdWgwQjJ5N1ZPVmpibnp3b3R4dDlkUHZXR1RROEtiYnZLRTNrNmZ3?=
 =?utf-8?B?NU9BSkdibThSNGhuU1lKNEFaNkZ5ZTJXU2V6VklBdXEzbUVFWXRnSUo4cjZT?=
 =?utf-8?B?cWRUZG5QYi9MNUxuZm5IUDdoRHN3UC9WR29UTkY4NDAxS2JkVEVyTkt3UEN0?=
 =?utf-8?B?MnpGZ2Q0ZDhsMlRPMlAwcVRmYTFDOTBSZ1RvNFhBL1Y3Znl6dHhheFdxbDNH?=
 =?utf-8?B?bFRJS01melJ2dTFtdUM5T3ZxelRtdGN6QUY2TEd1V09wK2NtUjR1MkRkalov?=
 =?utf-8?B?TEZxY1VxczNEUzZaaTU2ZGdUa2FoTGtxRjh2RDI2MEVOU1FGcEZQK3VzblZS?=
 =?utf-8?B?YnlJTXRiZUYyZ3ZpRGRZcTUxQ1l5dFFLSkZIZGZSdjdCcmNlNGZ4VFZoaG9k?=
 =?utf-8?B?MUtpbG15eHo3b1dNYTA5bFo4SlFrdFNJMWNndW81UWtkazZrS0ZreHJnM3dv?=
 =?utf-8?B?Y2dVcDdRVzZ3QzNPNjRNWjlrTGV4WFdZM2FmSTBuQjcyZHZWWWVuKzd5ajBW?=
 =?utf-8?B?bzljYVVQYVI3azI2KzhsQTR3S3pKczAraWNUMk9pcFRlWkUvKzQ2OTZKUnZM?=
 =?utf-8?B?NUJOQURvOGdPR2pRU1RjYm92YWZJaVVhN0dyWlAyejNvYUVQZ2plUkwxbGdz?=
 =?utf-8?B?NnE2QU1hanBvRGZ0WVkwVHRQOWU2V1JjN0F6WVJ0MlBKS0xYRDdtS2g2MnNn?=
 =?utf-8?B?WU90WjQrZGhZSGJDVkM3V2F1VEZSOFRYTXZMd21aU3RwL1ZQbHRYcDgzc1U3?=
 =?utf-8?B?YTFsU3QzYmFycTNQSTdtUUR1UUd1UkFzRUNUQzltRDAvL05xSlVOT1lvV1BB?=
 =?utf-8?B?WU5aclpCVjlSdzlYR1V4L3lJZk5LVU5NcXJRaUkxZmo4bzBXN3M3KzFxaHN4?=
 =?utf-8?B?N0h1RXVoazNqYWFybmJKa2dBZDdIZVB0UXdFZmJ0U0NvdVZWYTErbWE2YWVl?=
 =?utf-8?B?bTNySUg4Y0lOTUpGd2lqWmlzem5wdWp1cGg1K2pHWW0vNFpJYXFmNlZFbXlG?=
 =?utf-8?B?NjR4a1ZwenZWK2s0aVRCVEZmcXE3aUJwNG9aa3pDZGR5SmFlcnRlVGt1eC80?=
 =?utf-8?B?dFhjZUdEcHZTbC9IbVQrSDZrYXVaeWgwSkUxclNmQ3dNQlRLNWdGWWwrbnlo?=
 =?utf-8?B?R3Z3UGFrRlk4Zzc5S1p4Vk9VZEN4MzN2N1IweDQ4UVh6bVhLY3VGRVJxZVZ2?=
 =?utf-8?B?U1pVSWc4SXlXMS80SHN2eEZiekVhcG5reGJ4MjlBd0RBSUhmeGRJSDZZeERC?=
 =?utf-8?B?RU50MG9vUjQ2NDh1Q2ZSenJOMUVoS3l1OVV3bU5HNjNyL1I2Y2V0TEhwaDhQ?=
 =?utf-8?B?a1NaUll2dElQQnRUaC9IMmg1Y0xrTEtydGlxV1FVSThPTEloMElUUHpKdytZ?=
 =?utf-8?B?TzNGeXVlSXBDaFlHZVlwNW4ydVY4VHRUNlZRMk81MEloNTArYW8rWHRZSnUv?=
 =?utf-8?B?a3pXaXdjZmhFODN2L3drRTNsNkpyVkFxU3l2NmZUaXkwa21pdjA0VjI4NzZ5?=
 =?utf-8?B?VW5uTXQ0dHpTK1dZTDNROHBwNkxFVk14dTV3WVVXZGluZHlHblV1aXZFTk1M?=
 =?utf-8?B?L1dJVys3QkZKbXNLMGZheGpKWTRLeTZoOEU3MVpwMTZ1a011YlNpUmVRT3Jh?=
 =?utf-8?B?b2xEaHVWOHl3TDV5MjdnRGhGbVdZQm1lT2FTL2IybDA3UkZmd1JySmhocnJC?=
 =?utf-8?B?UXRDU2hHS1ZiblcyVWNmWnc3LzdNQmFrdktXMzlteWJoZnZZdndIeEl6Yis1?=
 =?utf-8?B?b0krK1BrU290ZGk5R0RHYzN0MFB1L0Q0TWdqUXlxNy9XdDdqL21DRWtKTmxt?=
 =?utf-8?B?SnNNNkdpS0xwV3YxWXdsSGVEWFUvVnV6ZUVlREtCUzdTSjdSalpOSDhxbkVp?=
 =?utf-8?B?U1doTGlyU0hRQ1BEZzUvem40YlBGVjRoelpFQXNMY2ZlREVWNGJpM2VRMS9s?=
 =?utf-8?B?cUlCTWJ0ZjI4ZzE5d1NMZi9BVFJackVNMytXMVFYOXpQQWgxR3lzUEMwR2gz?=
 =?utf-8?B?d1hXL2Ywa0E2bm5HbDhsMDBBcHhSZUYvc254WXBIenY0TGU3Y1NpbDFsQ3pl?=
 =?utf-8?Q?i7ZvlzpP9egajh/xEC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 831606ab-43b2-401c-bab8-08da2f3e0182
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2022 08:54:18.6012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ql0O+HDMBScAxEcYhxCuA2QtX+ouFDZZdky3jwreg2Ra1R1eNbhEkWapV9r+AXbb3xyTjlfx7lP+ccb6YTYx6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3186
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ClRoaXMgcGF0Y2ggaXMgdGhlIHNpbXBsZSBpbXBsZW1lbnRhdGlvbiBwYXJ0IG9mCiJJbXByb3Zp
bmcgcmVzcG9uc2l2ZW5lc3Mgb2YgaW50ZXJhY3RpdmUgQ0ZTIHRhc2tzIHVzaW5nIHV0aWxfZXN0
IiBieQpWaW5jZW50LiAKCkkgd291bGQgbGlrZSB0byBhc2sgZm9yIHlvdXIgY29tbWVudHMuCgpU
aGFua3MsClFpbmcKCgo+RnJvbTogV2FuZyBRaW5nIDx3YW5ncWluZ0B2aXZvLmNvbT4KPgo+VXRp
bF9hdmcgaXMgZ3JlYXRlciB0aGFuIHV0aWxfZXN0IG1lYW5zIHRoZXJlIGlzIGEgc3VkZGVuIGlu
Y3JlYXNlIGluCj50YXNrcyBhdCB0aGlzIHRpbWUsIHdlIHNob3VsZCBnaXZlIGl0IGFuIGluY3Jl
bWVudCB0byBtYWtlIGxvYWQgYmFsYW5jaW5nCj5mYXN0ZXIuCj4KPlNpZ25lZC1vZmYtYnk6IFdh
bmcgUWluZyA8d2FuZ3FpbmdAdml2by5jb20+Cj4tLS0KPnYyOgo+LSBtb2RpZnkgdGhlIHJldHVy
biB2YWx1ZSBpZiBVVElMX0VTVF9CT09TVCBpcyBmYWxzZQo+LS0tCj7CoGtlcm5lbC9zY2hlZC9m
YWlyLmPCoMKgwqDCoCB8IDggKysrKysrKy0KPsKga2VybmVsL3NjaGVkL2ZlYXR1cmVzLmggfCAx
ICsKPsKgMiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+
ZGlmZiAtLWdpdCBhL2tlcm5lbC9zY2hlZC9mYWlyLmMgYi9rZXJuZWwvc2NoZWQvZmFpci5jCj5p
bmRleCAyNjViZjdhNzVhMzcuLjJmY2RhNzk3MjA1NyAxMDA2NDQKPi0tLSBhL2tlcm5lbC9zY2hl
ZC9mYWlyLmMKPisrKyBiL2tlcm5lbC9zY2hlZC9mYWlyLmMKPkBAIC00MDM2LDcgKzQwMzYsMTMg
QEAgc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIF90YXNrX3V0aWxfZXN0KHN0cnVjdCB0YXNr
X3N0cnVjdCAqcCkKPsKgCj7CoHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyB0YXNrX3V0aWxf
ZXN0KHN0cnVjdCB0YXNrX3N0cnVjdCAqcCkKPsKgewo+LcKgwqDCoMKgwqDCoCByZXR1cm4gbWF4
KHRhc2tfdXRpbChwKSwgX3Rhc2tfdXRpbF9lc3QocCkpOwo+K8KgwqDCoMKgwqDCoCB1bnNpZ25l
ZCBsb25nIHV0aWxfYXZnID0gdGFza191dGlsKHApOwo+K8KgwqDCoMKgwqDCoCB1bnNpZ25lZCBs
b25nIHV0aWxfZXN0ID0gX3Rhc2tfdXRpbF9lc3QocCk7Cj4rCj4rwqDCoMKgwqDCoMKgIGlmIChz
Y2hlZF9mZWF0KFVUSUxfRVNUX0JPT1NUKSAmJiB1dGlsX2VzdCAmJiB1dGlsX2F2ZyA+IHV0aWxf
ZXN0KQo+K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHV0aWxfYXZnICsgKHV0
aWxfYXZnIC0gdXRpbF9lc3QpLzI7Cj4rwqDCoMKgwqDCoMKgIGVsc2UKPivCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJldHVybiBtYXgodXRpbF9hdmcsIHV0aWxfZXN0KTsKPsKgfQo+wqAK
PsKgI2lmZGVmIENPTkZJR19VQ0xBTVBfVEFTSwo+ZGlmZiAtLWdpdCBhL2tlcm5lbC9zY2hlZC9m
ZWF0dXJlcy5oIGIva2VybmVsL3NjaGVkL2ZlYXR1cmVzLmgKPmluZGV4IDFjZjQzNWJiY2Q5Yy4u
YzczYTg5OGU3ZTM4IDEwMDY0NAo+LS0tIGEva2VybmVsL3NjaGVkL2ZlYXR1cmVzLmgKPisrKyBi
L2tlcm5lbC9zY2hlZC9mZWF0dXJlcy5oCj5AQCAtOTUsNiArOTUsNyBAQCBTQ0hFRF9GRUFUKFdB
X0JJQVMsIHRydWUpCj7CoCAqLwo+wqBTQ0hFRF9GRUFUKFVUSUxfRVNULCB0cnVlKQo+wqBTQ0hF
RF9GRUFUKFVUSUxfRVNUX0ZBU1RVUCwgdHJ1ZSkKPitTQ0hFRF9GRUFUKFVUSUxfRVNUX0JPT1NU
LCBmYWxzZSkKPsKgCj7CoFNDSEVEX0ZFQVQoTEFURU5DWV9XQVJOLCBmYWxzZSkKPsKgCj4tLSAK
PjIuNy40Cg==
