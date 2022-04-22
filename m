Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD4C50AD88
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 03:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443219AbiDVCBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 22:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390984AbiDVCA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:00:57 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2114.outbound.protection.outlook.com [40.107.255.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AB83C4B3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 18:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hb59wcP6iKhRnzjDVipGt+zjz3K5QQbSrhW3zuoarZLefxqJl1W91/EZoqcBYabvASbf1y5tDl0RZ8E77kpKPDSQrCZNmtZBzhit74fSZLo568re0aJcK8rSGTi82Qf7v5n3hELJkk2k9ym0/AJAr7iQ8qOGlTD8C5c4WoDhuvHZ2jh0SiPj4Tx4MuoAqtUsSgt/61QHFaNaA8Kh35IAgm5ViyBO9g4ajBJKn3ezJA1pZTV12bWi6QI+W7euNlQxBBBNRonUM0qos5SC0fvA4zqZqvO7pzlj7Say7+JDur0VsQKbwRBqYc2+rSTM1gbeAO5IGeF6eDG6Kh+MTQbokQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWYRGoCSG5BOE7gg96CmGroJq1TZV9F6ve9bclppBLE=;
 b=X5y9MSUuP3LFv4JHxDuR4FCreOuqoZBHFUGyj5hYbIpjWPUn9cFVKYYk1YPZncbD3l7VUDi6fFIyZQ705dMWdZz8vlmPjflpWYg+YbMtIDMKf4CUlXsrfgRxPWe+9oIpsaMsGlVNHqktf1hyl6gHKlQJW4M9vsauGx24U23UL4udYhJfWo5vuPtgzcfRLiyToAOqXpOyr0vtrPyBERnl0KZNdlUlEc8xRdi8ieE9UbKaAgceC/P73KhrTuWkty/bFCl2K+qjCWZBO9zs+WsQIo2aGrlggR7nRbgYMAsnZGfV9qw5/bkSwbH9kjErv0ohnr4GfDXxpU7b/JiwZF8Qvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWYRGoCSG5BOE7gg96CmGroJq1TZV9F6ve9bclppBLE=;
 b=aecDJm6Q1SDiMcPlduRUPOrRT+iZdsKO57Hc4R05t5NH8tGObTDHt64Atl6LWM1Q0ZObKtmoqK+LyU0XzJfU6W+tlZAfzVGrjZtl01pC9wXXpiTlSaW28tuCMjeH8NVM16TCdRBXhqMBiyAILHenNzFBdkYzzFMbJ8LQqNvpGZ0=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by KL1PR0601MB3815.apcprd06.prod.outlook.com (2603:1096:820:12::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 01:58:01 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc%6]) with mapi id 15.20.5186.014; Fri, 22 Apr 2022
 01:58:00 +0000
From:   =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
To:     Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH] arm64: make SCHED_CLUSTER depend on ACPI
Thread-Topic: [PATCH] arm64: make SCHED_CLUSTER depend on ACPI
Thread-Index: AQHYUJcVg/zIHO7ov0muY8aNRHi0BKz7NB/E
Date:   Fri, 22 Apr 2022 01:58:00 +0000
Message-ID: <SL2PR06MB3082B7CCDC47E2E9CAF64F08BDF79@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1650006268-3782-1-git-send-email-wangqing@vivo.com>
In-Reply-To: <1650006268-3782-1-git-send-email-wangqing@vivo.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fb13d4f-214e-4a01-dc05-08da24038798
x-ms-traffictypediagnostic: KL1PR0601MB3815:EE_
x-microsoft-antispam-prvs: <KL1PR0601MB3815BC6876FAC9425B0F00C8BDF79@KL1PR0601MB3815.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vKFcbZERXbPYxL++XrstqwXCjsWf6wzrbj28v8nDOJM8hvF8wVcStXNdw5Q42hphmOjmCilLlbS5GNTCRcr0+544No4GZj1cfAnENIN9dENwueNZkoukxYYynn02zE0KnWYktuoRPjI2kVol4CbGDI7+I2Cht/G+BeWlKdsDuPzB1bZNXDAQxsNkR+Y62h+4e/uO3by+bCxpzrtar56/5fOe/eN6L3Er9veNH6vkrBt/hWpi6R9rT8IxgJxnQ5lbc5c+FCfBy1g/KevoCy1lfItezfjGWXcSBU4SVBo3rPMjCm2hBN1vAMrb10odIFEOpSTcXClkJVA/1VWQ1NRU64IcdMj+MtSQ8TqWw0/5gya5UQOvZhBvcawyy08L81IDH/010LeY2AoC8Ea0mDQJnF+akoVWZu1CX1HB+G48cB01Xh8teuf5t4haNPJrRtMi1+2a1EOMLOG2HPOmQ4mpktmbJ+TEuG3QaX16cZ9JYTNWYeJTTdvJcH2efHvgSRa2WyXzrPTgDPMPNG0yZQINe9IsKTeTghwAHLDAFCt8+CfLbHaouRfOkMTghc1aAGgMDlTwiM2CeBDFxyojId3YYJg6IvrznUIUDqNozuwq73U+Fn3Rx20o1y8rdEQOm3sG1SNZIdwPA6nTIQXz0swxDbVbv/zMAEc6LoHr9nt4qx4exyD7uS9VXYWOvuyBZGLKL8I6CXC7K3Jf/XX3yoNHjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(85182001)(38100700002)(38070700005)(71200400001)(55016003)(33656002)(9686003)(5660300002)(4744005)(26005)(186003)(2906002)(86362001)(122000001)(6506007)(8936002)(52536014)(110136005)(76116006)(91956017)(316002)(7696005)(66476007)(64756008)(508600001)(66556008)(66446008)(8676002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWNEOStIdmhjTkM2bkttcDlFSDBpVmxyNWNVR1Bzd0hXRmRjRzJwUVVGaDg0?=
 =?utf-8?B?ZWxjT05KSmlCSjhsRlVibXlzejNCQzRSNjYxbG9BaWx4ZzB5Ymp4TlhpRjVa?=
 =?utf-8?B?U1ZEUjFSQzRNVVMvMVpHampvUmk3UzhzRG5pNFZEUTlDbFJZY29LNHZSdzJr?=
 =?utf-8?B?L09QZHM4SmlwSlNFeStzQU9EbWwyZWQrZlpmNEFWcUtKSDVDSHJvN3dTdXBo?=
 =?utf-8?B?VHQ5MXdTZG1JSlN2cDBTaEpIMGFvWloxTXM5b3Vzd3VMV3o2MjdVT0VNSGM1?=
 =?utf-8?B?dU83eUx5dU9aYlVQc0R2RElnUTMxTlM1b3hBUjAzOVdhZHBOb290bmtTeVFJ?=
 =?utf-8?B?SzJlYjFZWll0ZHhBR1NYQVRwQVhVNyt2b2VqanMyeU1kYUdwRmJsaHpRT2Zj?=
 =?utf-8?B?QSs3eGpPK0NEQ3NkSEx2aFdTbkZwRUdCQUEzN1ZzTjU0ZEc2bC9tZHp6bVR5?=
 =?utf-8?B?Uld5d2lZOUFVc3QraUtEcXZMOXRIRytzZnZJWmZzUTJWWklpTlh3Nzhyc3h3?=
 =?utf-8?B?L3J1Zk41KzArbUh4NXdWUDI0bmxlcy80Z2JHQmFHMkxSeFE1eEFxM3RGVFIz?=
 =?utf-8?B?MEFUdk12Tk9zMEJreWtNQmhLcDFMYjFBWUNLVlhCNE5xNkdBbVJLWlBUdEdB?=
 =?utf-8?B?WlRWaTRjblpvTnZVSXFFL1pzM2M0akQ5T0lQc0p5QktMQXVnWXQ3ZGkvWFJB?=
 =?utf-8?B?OGJ2MWZlRkJ2UXZQTitWSnB4ZEZVMHUybUgzQWsyOVFoZ2pzcWhzN29OcGk0?=
 =?utf-8?B?UlFKQ0YwcUdCeXBmN3Znc1lsMENVSS9ZYk9JVEI3QTlUVjdWdXE1Zy9JVk1p?=
 =?utf-8?B?UFpNWnlocTRrT3Q1QkRwSFQxME1xVVpDYWM0RnFwcGFJaHdScHFhTDc3RWpj?=
 =?utf-8?B?LzY0MmNtUzJOdFJsMUFMeDY3LzRveHVHc1NWQnBIZzdabmg5UXhHbkJDZUo0?=
 =?utf-8?B?SXIwOW1FSWZNY2Jucng0ZkU3RzNTajJpVHhHWXpQbHhIa1JnRXIxV3dnUHVt?=
 =?utf-8?B?cVdObTg4cVhGRDljWG0yTUoxbk9zaEFUaGhWNVd3YUV4Vmhaek00YnFGbEhW?=
 =?utf-8?B?Ky9IMGZIRkRWdzJtS0ZTRWtZV3E3S3VWL3JBYWJHcmpSK29KWE9NUHBWTjFD?=
 =?utf-8?B?aHdFQWswekFick42NCt0b2FwUkZoNUUvSnJkNjhkc0ZiSFlWOEN0YjA3NUJY?=
 =?utf-8?B?d0ZqZ2tOS00yYUQySEtRN3FVTTRPWnBUK0hZUmdlZFNzU2VmbWFOa2NRVEVw?=
 =?utf-8?B?KzZNOFczN1M4NC9UUlNQelVOWmZoMVNydXI4cGszdm5GcmtpS0ZtZE5SUXkz?=
 =?utf-8?B?YjZIZk51bkxOck9GcWNjTVlNVWlUUnJuRFd6V3ZCQ1h6NDNhejZRTTZrNFc4?=
 =?utf-8?B?T0xkek5vbm92KzhSZ2szMGUrUHFzNXFKeTd4M1pzU1hXQU1wNk1Rdm5sdlFY?=
 =?utf-8?B?bCtJRlB0MHBxNno4UFZmMkNkUkN3N1BMTXpYZ0dPYXJlY2NCT0JPV2dVVkFy?=
 =?utf-8?B?NGZybWtuWW9Pc09pbWxSakM5bVZza0RaQUVKTGhqMnpQRjVRMXhaV3lCMjdZ?=
 =?utf-8?B?ckxsQXhkUEN2d0xlTFg0RDl4dWJKMVR2elpkbkJaTE5kQ05XK0ZKWjhsNXRE?=
 =?utf-8?B?UVZWSE8wTC9JQ09VK0RBczdGZ0ZNcnRTM3Z0eGNGYk5KeGR4TWJvVkM2Q1pK?=
 =?utf-8?B?VjBiREY1UG9TbDF3RnNMN0ZzcFBrc1phQzA1eVFHanpCS1Q4ZU5GMGQwQitO?=
 =?utf-8?B?b2xHOEZZdnBmMSt2clNRRUR2aTY3bDR0SkFSdnZnc1E2UExrNlp4RjBGWEtX?=
 =?utf-8?B?UExHMVpLNFY5N1lWcktrSDd6S2ZwdmQrb1h5ZmZJdUh3cDhTelNKanRKVHly?=
 =?utf-8?B?a3FhM2xSTDU0NDZjc1c1NE9oWm5RYWFVWDJ0MGtqMDNaRm42bk5TUWtXNFZm?=
 =?utf-8?B?aXcyZzUrNG9yc0VpdlVwU0F4c2cxNlVCNmc5K1Bzby9vNkNzbWRsYUVUVHVH?=
 =?utf-8?B?S2MvT3EyYWtmSkt4V3RnYUEwYTdkNHJUQUF4TDBtSDQ3RkdPcldQeUNCSXFG?=
 =?utf-8?B?RDJ6WlVlcTVZa04wM3N4V3ZXODBMWkE5TERTRUQvTmFObnY5VFlDdjhzUEhX?=
 =?utf-8?B?RTM4RGxRT0s0a3lVSk1zM3pydEZ2NWxPMS9YeHVjRG84ZGhRRjVnSUZFR3hE?=
 =?utf-8?B?Ti9WZHFVa0dHcXg1THROTkhNUUpHQkxCeG9QNnFtOW13ZEZqd2lNTDIyOEYy?=
 =?utf-8?B?ODMzNWpUeEl3Z2lpN2V6b3N1eVk3OXU2S1BlQ1E0bFdnOFQ4U09XeFQ5TVkw?=
 =?utf-8?Q?MDm3yDPRwuhY67vcWD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb13d4f-214e-4a01-dc05-08da24038798
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 01:58:00.4321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z5Ekhn0Wa8aBSPwKLxJrdqDizwJT3UO03tzSorfr/DF8jHaJ2wY1hL/LCpfHyNkRceR8OWFzI/t619h6BamO7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB3815
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2F0YWxpbiwgV2lsbCwgVmluY2VudCwgRGlldG1hcjoKCldoYXQncyB5b3VyIG9waW5pb24g
b24gdGhpcyBwYXRjaCwgYW5kIEkgc2VudCBhbm90aGVyIHBhdGNoIAoiQWRkIGNvbXBsZXggc2No
ZWR1bGVyIGxldmVsIGZvciBhcm02NCIgeWVzdGVyZGF5LAoKQ2FuIHNvbWVvbmUgbWFrZSBzb21l
IGNvbW1lbnRzIHNvIHRoaW5ncyBjYW4gbW92ZSBmb3J3YXJkLgoKVGhhbmtzLApRaW5nCgo+Y2xz
IGlzIG1hZGUgdXAgb2Ygc2QgdGhyb3VnaCBjbHVzdGVyX3NpYmxpbmcsIHdoaWNoIGlzIHNldCBi
eSBjbHVzdGVyX2lkLAo+Y2x1c3Rlcl9pZCBpcyBvbmx5IHByb3ZpZGVkIGJ5IEFDUEksIERUIGp1
c3QgcHJvdmlkZSBwYWNrYWdlX2lkLgo+Cj5TbywgU0NIRURfQ0xVU1RFUiBkZXBlbmRzIG9uIEFD
UEkgYWN0dWFsbHkuCj4KPlNpZ25lZC1vZmYtYnk6IHdhbmdxaW5nIDwxMTExMjg5NkBiYmt0ZWwu
Y29tPgo+LS0tCj7CoGFyY2gvYXJtNjQvS2NvbmZpZyB8IDEgKwo+wqAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykKPgo+ZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvS2NvbmZpZyBiL2FyY2gv
YXJtNjQvS2NvbmZpZwo+aW5kZXggMjViMzNmZWVkODAwLi5lZGJlMDM1Y2IwZTMgMTAwNjQ0Cj4t
LS0gYS9hcmNoL2FybTY0L0tjb25maWcKPisrKyBiL2FyY2gvYXJtNjQvS2NvbmZpZwo+QEAgLTEx
OTksNiArMTE5OSw3IEBAIGNvbmZpZyBTQ0hFRF9NQwo+wqAKPsKgY29uZmlnIFNDSEVEX0NMVVNU
RVIKPsKgwqDCoMKgwqDCoMKgwqAgYm9vbCAiQ2x1c3RlciBzY2hlZHVsZXIgc3VwcG9ydCIKPivC
oMKgwqDCoMKgwqAgZGVwZW5kcyBvbiBBQ1BJCj7CoMKgwqDCoMKgwqDCoMKgIGhlbHAKPsKgwqDC
oMKgwqDCoMKgwqDCoMKgIENsdXN0ZXIgc2NoZWR1bGVyIHN1cHBvcnQgaW1wcm92ZXMgdGhlIENQ
VSBzY2hlZHVsZXIncyBkZWNpc2lvbgo+wqDCoMKgwqDCoMKgwqDCoMKgwqAgbWFraW5nIHdoZW4g
ZGVhbGluZyB3aXRoIG1hY2hpbmVzIHRoYXQgaGF2ZSBjbHVzdGVycyBvZiBDUFVzLgo+LS0gCj4y
LjcuNAo=
