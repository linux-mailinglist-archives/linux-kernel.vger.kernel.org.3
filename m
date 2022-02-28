Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27554C7063
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237487AbiB1PP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbiB1PPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:15:25 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71D9583B1;
        Mon, 28 Feb 2022 07:14:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGVYGRLlcsVisz6cC14dA1Wzibq/L30J8nN/bJWvLVg+/nzkQK7Y3OjdFgBfNvBNEhcQqb4Jcsi+SjS5QWcCL/AqqdNJrqQOkiUVWdMkolxDWUbd3PevmStM2Iv4rmRSwN2Zfd0agybS7YkiAAxHB0vM+Ie0GuzW3jBSy4KzJjd6Jv9z0sK9p5jW+fB2+KOvqsW5jT5LURTJZLVJt+GaDr6KuZ4Uu5SwIS+5A35slY84+S/MrSGvsEq3J0O003ynE65YCsWmfsQAuS8XnK2xmHJvA7OdCf7QuDqnWVfe+RpxITjCIuQVh035Djy/YGJcdHOaPNTQKBtSA79M3Vq6/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MzqHJME814Lah2Zk5lHvTVQvLBenuwvUCCNObHFudg=;
 b=kxfEiOpLsvOoOGnhPwQK8nG6JMcyqwmn27ELe31nDYft5QgVQ3vePqZtV7ykV+b2DAPcugOQHeNHKBdfIsAxg33OJN0mgd7Z0aLPwMfSMPWfQjhz6MuFUuHLoV7R/Q5Oc7ZhX4+vdduyC7qlbAn4G/qnm5+CoeoiQnb1vnboozg7zTeYVtVUl6BD85Gu3lgJfjS8Sth9vK0kkDLjTQ9mIR2VFc2yBNahNX870jTxiR+FMTJMm9G6ar4rPLe2Ke21eBZ9+3OHmJ0i2C+cCYZNwESGsIZcm8Ck2ElKsukYvHQLwwkVm1gMOXHNgeeA1g0UJzywQRcyrT8CJgDVcbgmIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MzqHJME814Lah2Zk5lHvTVQvLBenuwvUCCNObHFudg=;
 b=s1/VjxIysRH0gZv1JY/3SdOCV8jmFMVtb2fEXBeFNQI6+SP6dh20WMR+k/6jT53YGAY7avmwF7ts2HjW9uWWOB2bhGIwwLP1nL5mCYTGbFISoWBfWvvKo3nWgQoS8hrNJdJ/QQWADWhJUJS84C7g8QzBRIZ++m69xTavmVk20i2++s3PvVnEYzcKiX4dNgwRWoWelTKjRlcwIf7rBQmbLvWQMDvhYpOcUOS54qNSNjmSaIyfFyFFX2aHRgYONXks8m8iMMWQRttMZGXIhABNfm7DHsXonxQglqKGapYSLWEkA29cvVfo8uySoiy4zzs51iW/94gsZsy024t8vQlJcA==
Received: from DM5PR12MB1850.namprd12.prod.outlook.com (2603:10b6:3:108::23)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 15:14:44 +0000
Received: from DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::94d8:5850:e33d:b133]) by DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::94d8:5850:e33d:b133%4]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 15:14:44 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] gpio: tegra186: Add IRQ per bank for Tegra241
Thread-Topic: [PATCH] gpio: tegra186: Add IRQ per bank for Tegra241
Thread-Index: AQHYLIqUywKMcWUkJEOF+NONTmhSVKypDWGAgAAEqzA=
Date:   Mon, 28 Feb 2022 15:14:44 +0000
Message-ID: <DM5PR12MB18503C30FAB6E755221B0B73C0019@DM5PR12MB1850.namprd12.prod.outlook.com>
References: <20220228100317.59885-1-akhilrajeev@nvidia.com>
 <CAHp75VdUb7cDJY8MNHVDmgtBqkAZ5CskyVsA=7v=q9b8Tm=wHg@mail.gmail.com>
In-Reply-To: <CAHp75VdUb7cDJY8MNHVDmgtBqkAZ5CskyVsA=7v=q9b8Tm=wHg@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb906fc2-350f-4452-7d8d-08d9facd0d4d
x-ms-traffictypediagnostic: MN2PR12MB4223:EE_
x-microsoft-antispam-prvs: <MN2PR12MB4223A8472E6F7225B8FFEDDAC0019@MN2PR12MB4223.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OzZzDw/aHLRHalO1oChnNDWprqcfKOzt6J8FMIVomb1DvTFvjq9gh2Z3KYy5h95eGd36NsWkr0QNPZj5/PdvY2s9IRMlV9Ze9xxjWxOSBej6tXrgrZ1mt+p83YIkLwvi8VKvKLQ7Ixh/f1leyNnviGWCN2jf8d5T5FhkMX4zO4Pkl6xgcf3lVCZAzEaatk//R9TJIyxLx++d9mDymLIl+iyzRjITFtmvsM6UTBJNrgSg927XV/jnw8QGTgoOj6I2bzovOqQMKF2EZzBn8OWAGnKWnKL19NBO2Qy7FTStO/YCYMYM59VCZNjjXqawKElF3PDa0KANsbsXqYglRVR37k7CdqQdB9r+nBzh8bb5eg5mz9iCvB8kUdbNLpPRLK8aB6irTyA0ImRl2M8uPSoIbgiwQmUgpiprIo7oCssdxh+xPM9OPVvSi4aLo/gmbXh1hUdak13dd2R7TVnldUiCKxdE6lGapw2trdBbs7GCtTX/i1cK9Tg+tvC+4PSq+QfHxvclh2xJifO/Ws3GWq/+bYIQ32kKNZWVJyGCNN3PtMaMeC5TuSzT+gCbDbIIJFPGtuiMsSy3g+oiye+TJllpUWs6jEhpztdVXVITR28Pnej0OEQjJtGUG07AfgKBSYJhgQlUR/CLkuRu77BBLAnB9NC3Z2D9J+1g51P5NOINaAgQNtlhTF+gQObnIGK6UcXN3OX7ftfnrWRJ0+FtwZztiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1850.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(4744005)(71200400001)(86362001)(33656002)(316002)(53546011)(55236004)(7696005)(6506007)(9686003)(6916009)(26005)(186003)(54906003)(15650500001)(83380400001)(122000001)(66556008)(4326008)(66446008)(66476007)(64756008)(8676002)(2906002)(38100700002)(508600001)(52536014)(66946007)(76116006)(5660300002)(38070700005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjZZTytYOWpiRWlwWVFCdEZKU0FRMGx3ZGxWZ1lZeUlBRENXTHpQYy9HTFZ1?=
 =?utf-8?B?YkNuQUpVYm5BZ01Ba09zOS9pUm9vUHJXdG9TYytSbHZOTlJzRDVpTmZLdXIz?=
 =?utf-8?B?b2piTWdydUpkWVF4Z01jcGFORUpqWmtrMHNuS2t0WTBlTlFPVnN0RlRmRExF?=
 =?utf-8?B?RVQ0MTUxWXh4WDdmeTM5QW5NRFFCSnpLUjZEYkxhcFkrdXJwcDMwVUZhZ3Rl?=
 =?utf-8?B?S1ErSHVLWXhpc1I5eTRIb3pBbmRJRG9wMDVocTFiVG5YdnQxK2d0RzVDOGkr?=
 =?utf-8?B?THRoRi9UTUt4cTVRMTl6MkxBYldvRTREYno1eXhWMjVIcUI4QjFpbUFrdjdS?=
 =?utf-8?B?RzhuSmluZVYvVFNxNHVGekt1Nm9OaG9FaWVGNFdTSllCcWpqTDVPSW92bkNU?=
 =?utf-8?B?aFdtTXdYekc5cTBWVWNUeHhCSVFUWkNUOWI3SjR1ZVFSTTFld0VJVVB2ZVdX?=
 =?utf-8?B?b1ZDS21oSStncEVWcmJGdDNDaXJ2SHhjRFN2ZWhxL1dpQjVnZHVBdWt0VEhE?=
 =?utf-8?B?dkMrMkQxb0NSeEZ2anBkQTVJdEdzM2d2bm1HcFNpVHVzRFBwUjRjdUhpM3hl?=
 =?utf-8?B?cmZ1b1N2NjJZYlVXd3hzS3ZuL2FvY0orbm0yS1lzNHBRY0pHV3BqczJFRm80?=
 =?utf-8?B?UFlBaXlqY2RDMDVYc2kxbURVc0p6eE5zSEJGVzFWb0VkM0tCckxFZ1Zrb0tP?=
 =?utf-8?B?blVhMTVNNmRKQlMrUVB0eGJqWlY1dUluajRtSVp0R04wNGd5VTNmTUw4cDFk?=
 =?utf-8?B?QTJkaUR5eEZtaTk5TGpuNEloMWtWOGZlbWJYUFRIOGdUWnM4bTNzdGxvR1Fu?=
 =?utf-8?B?cHFad1d5UnZpaEFBZERtUzdjV0FBRW8xK1pBeTQ5MXJ0V2c2SmpMUEo1b2V1?=
 =?utf-8?B?andnclo2Y2Z0RER6Sk9GYVVzaHRVU1F6N0I0NEFGQVIwbkJRVU9aeDZlMmto?=
 =?utf-8?B?R2lieHo3T20xOXZwZWYrU0c5UWJKbWU0Z0xkaExnT2RyL1FZeW9wVWNFT29p?=
 =?utf-8?B?MWo5dllVU2tkOVVxQWNRckpnRDNuc3FEcnJxejhkd2lzMEhWZVl5T0M5Wkth?=
 =?utf-8?B?dVRVQU1jSDhDRVNSdlZWbHBZMkRyT2VVV0FEak9rN2trL2Z1eDh5ektDQ1JP?=
 =?utf-8?B?S1pIMHorU3NlK1ZIYW1Xb2VKL1pFTW9DZ291SEtyb2t2T1dnK0FUTE9FOGZn?=
 =?utf-8?B?RjdOdkpZdWxFYnNtcWpHaWVab05HcXAyQmZBRmpTMlVDWlR5bjlrU1g3MVpv?=
 =?utf-8?B?ZXYybWlzSXNkYWlXOVBkVnpCS2l2Y2xWa3ZnaFRITUJqMnYyM2UxU0MxY3o5?=
 =?utf-8?B?NzdLUmszc3kySklRSFVWNEpTRE9DYXFvRXBtNitHZWRqRmtWeTdOWGVUYVQ3?=
 =?utf-8?B?UUlHamlwMU1DSHBITVh3YWJVNUhPNHRZdU1SaERmQlhxYi8zaFI2U2NYYXhL?=
 =?utf-8?B?Rll0dnlLaWdDQWlpRGowaUI5VENwdlo4VlhIbmwrcUdNUGxaYXpKc0hldkxG?=
 =?utf-8?B?R21xdDd0Q05FUVZrQ0g0eTlmUEx2ZkI2M1F2UnlVZFZFbUFoREdUamwzc3NL?=
 =?utf-8?B?YXZoWURMdmE4Y1RRanV5QjJpZkwwNEx4cGFaWWgzZVo3NWlaUlhiMUpTaUhC?=
 =?utf-8?B?R2tGcjVCaWdXTjZDQzBmai8yTzRyZnNnem9UTlVsL21oUEJOdE9tNENmWlRx?=
 =?utf-8?B?YXViK1BPSWFXWHZybkI1QWoxZ1IySlUzVHNwdFIvZUpySm43Q0xERjRzNzY4?=
 =?utf-8?B?cEpCVGVBSDJLeWRmU1QzUjBLTWRWVENwY0RiVVBnMmJQMEhucmlPczRkVzhv?=
 =?utf-8?B?VVE2MVhkSERGOW9tY21ja2NTTE1iZ3FPMXJBSFpxeE1pZjJzOEhjbDZNRC9q?=
 =?utf-8?B?U0U4NlJwY1ZYQ2hCWGRWeXd5bU41OUVUdEhGZVgyN2xmZWxDRXZybTBvdVZY?=
 =?utf-8?B?OXpiSmdXRVU3NlM3alVTQzQ5cHhydnJlMmI1TkhYRDZlOEo4OHdJMDg3Umh1?=
 =?utf-8?B?cGZrVWN2elQ5blQxZTMyRmRJOG5wdWpCZXZUS2FvM1VqNHpHTUV2YlBpdGcv?=
 =?utf-8?B?bC9pbVRLdVdJY1Ntd1l5VnMwV3FvS3BkUlAvYWxtOHJHREQrZk02K09aOVZ6?=
 =?utf-8?B?SW5xSytEamJ2d1ZyWU1TaGVzb3BQV1VqRkRtUzdmL0dGbS9uNGV3N2xOeU15?=
 =?utf-8?Q?99tUAcPQHaVD8EvW6t1n2D0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1850.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb906fc2-350f-4452-7d8d-08d9facd0d4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 15:14:44.7276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rNn2halps2pJum55nke2RFU37UwrJQB8Ke55chqOWvJ1nGx3TF1cl7rV3z8UkMchtDsWFEICaL+y87Dd8doLbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBNb24sIEZlYiAyOCwgMjAyMiBhdCAxMjo1MSBQTSBBa2hpbCBSIDxha2hpbHJhamVldkBu
dmlkaWEuY29tPiB3cm90ZToNCj4gPg0KPiA+IEFkZCB0aGUgbnVtYmVyIG9mIGludGVycnVwdHMg
cGVyIGJhbmsgZm9yIFRlZ3JhMjQxIChHcmFjZSkuDQo+IA0KPiBJcyBpdCBhIGZpeD8gVGhlbiBh
ZGQgYSBGaXhlcyB0YWcsIHBsZWFzZS4gT3RoZXJ3aXNlLCBob3cgZGlkIGl0IHdvcmsgYmVmb3Jl
Pw0KPiBFbGFib3JhdGUgdGhhdCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgdG8gZXhwbGFpbiB3aHkg
aXQncyBub3QgYSBmaXguDQpZZXMuIFRoaXMgaXMgYSBmaXguIFdvdWxkIGFkZCB0aGUgdGFnLiBU
aGlzIHByb3BlcnR5IHdhcyBtaXNzZWQgdG8gYmUgYWRkZWQNCmluIGEgcHJldmlvdXMgY29tbWl0
Lg0KDQpUaGFua3MsDQpBa2hpbA0K
