Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A13E465E46
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 07:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345207AbhLBGcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 01:32:31 -0500
Received: from mail-vi1eur05on2078.outbound.protection.outlook.com ([40.107.21.78]:21601
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239178AbhLBGc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 01:32:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUpRIZW3yfBhtEW9Cr/cX4UxCWw3eoyDrobk/MIdXRHYmaC9862xBTpopGaop2YsO+ZZNMBwcMBDooH3D8nO7rPhhjWzodf38fx9LDW2vgvz2K9zIsQYvyWq9Lo1njbie611rnFk+g1ZkmGi71f78oh26vCDNmVXOtXyB6HQKwIctaHJz1YYck03cTlFHexp+/TA2qfVLT7ZXwQv/08nl4398rsoBfoPV8z88LXj/6nC4mEZSMSYZBnFduUYxBMbavqSUcTRCBgmJFGPSWFBU5aZOUMDccDNUqy2lLuwUqc8tlEGzuDGSdLGR1Gx6L5FedZ//mqPpcB0fGr0RnJnWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+7p9xDd2k/dHjts/f1DZ6SPc+3PeOiTq7Kojmh8rQQ=;
 b=hPr0fPxoOD72Ex5RLlmMiDt//64ho8WBbik845we+35vEOlZYLT01hbnIZngtThMRmn6ZpGvniqyf/O71daYIWCzDJR+VRd6IBjkvqpzCtIgVQjsDpEukEM/tQreReEZ3Xq0jPLg319cPklp+0l4SvBdZZMCt3OYymZ/wIZ+nAregeqeIsY07BPl/lTXaR1m9hl7QpPs4c+B0M6zPAZv08WGUac6uKe7nT+WFxm9FSztpxW3IkL+t6656BLhGglhDoXxW8/ZYIhOn4m2mIQO+xKHRMUenrlEF55kkL1M5XqhkCj2iy9AxINCShYKe9kfAEUTsHo2K5OatPIqhBc9aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+7p9xDd2k/dHjts/f1DZ6SPc+3PeOiTq7Kojmh8rQQ=;
 b=X4F3Jw+H6tO5XoN8ycs/wePY8/cZBX71FhPnk6lyl53ookZEG7yaxSs82xKQcewHJFsuz4d4K4xS5mPLupXsPAj8GGosJtb3S+AnawKnvkR5Yvf7XVavLJfN9mMc2xUlvm++lX4g0YANFhnqa7YLoGWCzub9C5xBAUxaGXspFtg=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2474.eurprd03.prod.outlook.com (2603:10a6:3:6a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Thu, 2 Dec 2021 06:29:02 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::544e:754:6241:aa7f]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::544e:754:6241:aa7f%6]) with mapi id 15.20.4734.024; Thu, 2 Dec 2021
 06:29:02 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "rostokus@gmail.com" <rostokus@gmail.com>,
        "fan.chen@mediatek.com" <fan.chen@mediatek.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        =?utf-8?B?c2hpbWkgPj4g5riF5rC0IOW0h+W8mA==?= 
        <shimizu394@lapis-tech.com>
Subject: Re: [RFC PATCH v3 3/9] power: supply: Support DT originated
 temperature-capacity tables
Thread-Topic: [RFC PATCH v3 3/9] power: supply: Support DT originated
 temperature-capacity tables
Thread-Index: AQHX2uUgAyZ64u/b2EuYwDXlo7neoqwIjSeAgABDOACADPMrgIAA2WoAgAIXggCAAqqSgIAAU2oAgALXoACAAEvtgA==
Date:   Thu, 2 Dec 2021 06:29:01 +0000
Message-ID: <78f44e65-e788-22a0-5141-fb86f08c5522@fi.rohmeurope.com>
References: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
 <6123f62ac44e6513a498d15034a4b6b22abe5f5b.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
 <CACRpkdbKeW+pJ8SZ0fPD+9kEtgHgi2A9U=f6XyKTHogKU-9F9g@mail.gmail.com>
 <7b34e88f-54f3-6d0a-293e-b2b411d1c5c2@fi.rohmeurope.com>
 <676253b9-ff69-7891-1f26-a8b5bb5a421b@fi.rohmeurope.com>
 <CACRpkdZXhw9+txdLv-k01nzH3+GvGivyAoCO1JCf2VyYK96CnQ@mail.gmail.com>
 <57f97c5f-aedb-7f7e-d269-90bd97bbba09@fi.rohmeurope.com>
 <CACRpkdZ9EEmWSb4mq7WJywma4dFCms+Z3BAKfntcsb9y_1THNQ@mail.gmail.com>
 <d14580b3-1647-5105-4770-2cd8751d9fe5@fi.rohmeurope.com>
 <CACRpkdYvi7__DJNWRRHgL=4QcA0XV2uXXbW+boVU8dy10rEuVw@mail.gmail.com>
In-Reply-To: <CACRpkdYvi7__DJNWRRHgL=4QcA0XV2uXXbW+boVU8dy10rEuVw@mail.gmail.com>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4b89141-401d-465c-37a9-08d9b55d07fb
x-ms-traffictypediagnostic: HE1PR0301MB2474:
x-microsoft-antispam-prvs: <HE1PR0301MB2474213A24632DF48933066AAD699@HE1PR0301MB2474.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uFs27fcZUE0ecd9krBt0rlqwqol/oam+vyb+pIENNoZzTkN04mCzGQooVuM+chegbqT0RzfvGnPVH/bjWy799YLv+i7Qa6m5dpFckpFnT35PVSml2ZFy7Ctq7AFJabx8nwqPss4kDGXTkrDF5i8Iatw2592w+eMwjdhPctQhb1STfLsHMlL+fLXNXa1ieWOWKxmTA7gg4IFOINZg2l8csUjs1Dmd1qeR2QZDnAjJmRzEGGdekPQZiqpB2FskFllrd7u37HJ1O+iSBsjmIcoSGQ7F+mriG3GoDllrpXJ4hsg4kflfZT82qognp6Bc9hGkNe6HyqrPaJiBqn0icN8CyZkmA1sXy/hx3iBegz0RH+HfRPJlYD9+C0kGFm1kLIEj4yu47tWfQuNX4j6i7yx8XA7S4a4wXrxgHkS+x+vycpFPS3QIQL0cdP7ZWv5H/hM0CMzZJfEHy1AK+a9c06wKWBBqHfQFFrfr1ivjS2cLhUV5eLfrwj1W+HvPONxn4LeCKpsrnrCIaHCTyE4f+ccAbMjkCMlpqKDWv7XeH57ydXszZpTv/+XHXAS0oNaAScLB6+LSQOc1YlynXNRQgzzgd9HVa7iW8pqbJEXL2cvR20LtjZTZvHbVH5Qt2YToC1FGMQsZ4NkeKXPFA55wLZqa72baMMBHSwAeToLQJYdhVyuZ4GbmS0RzfPizw30ydchTJzzDDAO11KD51DSsYlUhOrPSYG0/LiZJfs9zJvGy23zTSKHQP+Q+9hDNojK/btnYtcaP8+9kjISDS+whnOr53w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(71200400001)(38100700002)(6916009)(6512007)(2616005)(186003)(31696002)(31686004)(7416002)(26005)(66946007)(64756008)(53546011)(4326008)(8676002)(5660300002)(66556008)(316002)(8936002)(6506007)(6486002)(38070700005)(86362001)(508600001)(66476007)(2906002)(83380400001)(76116006)(54906003)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTM0US9GVDJEYStuSEJpVEtWRXhmOWppWXE1YjQ1ay9OR1FRUmp6YTYrOEVm?=
 =?utf-8?B?N05zbVhqbU9ZSlh0UnZCNFdOclcvQ0J2VUJwWUh5N0Fha3Y3MFZnN1N1bXRJ?=
 =?utf-8?B?dFJGOEkvSjRaZTZuYzlqZFN2YWgwNFZhbXhGQjNHNHJGRGsrbkdBSU1NY1Fn?=
 =?utf-8?B?VVV0MnovN1A3ZnJQUDNiZU1VT241d2ZsNlpGU3RzVkZmQ1QxbUdTRWZ5dWJz?=
 =?utf-8?B?YTVqazJEd3ZhcTkyK3orTUoyK0Q0anBKeitoU0hOa0lCOE1va3lqaTlZNXl1?=
 =?utf-8?B?Mkg5WnVPdXd4RE5uU2lxeGd1WCtMWGN1QlVORW5kVXd1ZXExd2ZMejdUS0E1?=
 =?utf-8?B?NzdlUXZFMmk4UGI5b3cyd2VBVi9WeGR5c3FndVZQVjJGVzdUNEJwOTU5RzJH?=
 =?utf-8?B?SFB1TjdaUk5CZVJOZ1l2cVdjTXNENkhrMnhsa2JrSnhFN0pITndRczhSZzZ4?=
 =?utf-8?B?dGtCcEtCY3FnMXFmTWhWNkhxN0RmR2VCMGZucUtUdTU3S3R3ZWwxMllHWUNm?=
 =?utf-8?B?Sk14WnprR3pLZEVqeTlCVHVtY2VCY0JGOG1mOTR4eGFMb1E4NmJPSmkweUlk?=
 =?utf-8?B?RzhUWVRvMlVEMEp6SWZDeEJVZUw1eGJXVFlmYmpUYnRvWG9pYVlwU2ZabzRJ?=
 =?utf-8?B?alc4WTFOU1VOcnptOUIyNmtLU0kvMlpRSlh4NFBVS2R2eTZFOXpSUS9HVHJS?=
 =?utf-8?B?V3NkKzRFY0RNeUU1akVpMGV5T0x0SHVBY0N4a2N4TVJObUx2empPMEVnekQ1?=
 =?utf-8?B?ZzNiYUE4NUZ0dlhjWjhQalAySnFveU5TNlhMc2ZRU3gyZmtieXhGMmxWY2tG?=
 =?utf-8?B?VTdtWUZVc1FkT0gxS01GbmtBMGR6dS96MVNyU3h6b0syeElmMFozaGZ4ZVFv?=
 =?utf-8?B?dHBhQkJaczgzb0dRdmoxY29qRk5TRlAzclNJSVZuZ2luSnFrZjdqd0h5R291?=
 =?utf-8?B?VjJEL1JINzhib0s4SStWN1BOQ0NiZlJQdHJYRWp0MGozNjFqY21oakkwOU9W?=
 =?utf-8?B?WjlFcDJrdWMvR2RIZEpIcUl2L2JTcFdCQlVwQ2pMallnR1M4RXVsZU9vQ2NX?=
 =?utf-8?B?aXZJSFd5STViRmZKMVVNT3NqZmpGby81Y0NRaFViVHVxcEc5U1p5ZkhOSzE4?=
 =?utf-8?B?WWwxV3pSL0RIYlR2QVJQM2c0ZXNFYXVRZFIvWDZMeVhFZkpmNysvMnFzM0dz?=
 =?utf-8?B?NlkySXNFTmI2S21NSWUybktxbW9BeGNYUUFHTnBPWjN6cUN4QWIzOFFaV1Yr?=
 =?utf-8?B?RlROZVUxdjJ6ZUprdVhyT3drdTVGMElzbUN4cnFuTXpqSENFWUFnREI1T2hI?=
 =?utf-8?B?OUFHandTS3hlWFo1eDhiUXc1enN0TjFpa2xZU082WDVEQmRJR3RuMHJRNVFo?=
 =?utf-8?B?MmlvM3RjMzl4c0VwTkJBcHhOdFQyMS9kMlpEdkxOQTF3MG9jaUZiRGdDMSti?=
 =?utf-8?B?YXRRb2gvTHhHaWR1OWFXcktrK1ZkVWoxRHVUcitzeFJaZHlHM09oekQxUm00?=
 =?utf-8?B?dEZaLzk3K1ZQTjJzZkNvaVpSN3JFY2MzeENBT2k2L2NSdjQ0V1IrUVJJT1I2?=
 =?utf-8?B?dWk3bm9mN0JxTUo3aXh3R0htQ1dtRmtFWHM0aW42V0NSV1FuNytxRWFnTU9J?=
 =?utf-8?B?UndkVUg0NDVrRTlXNks5Rk9qVEU2TGMwNzdMNDNzcWFaZ0ZrQ3ozZUhJM1Zs?=
 =?utf-8?B?dG40b3hqYy9QaTRyaVFRdkhuL3kvalMrNG1pNms0Zkc3bzNCN0R1Vy9Lb1R3?=
 =?utf-8?B?VTQyU09WN28xQVkzSnhJbU42SjBRcXdBM3lsZEJFMDlRb1RJSmpabTRnSzN2?=
 =?utf-8?B?VlJiWWpUNzNGS1hPWFpoQzV2NTNWdzVwS0grck9DakpHQVZyVDUxZE9VcE4w?=
 =?utf-8?B?YTJwOHM0ZXFqWVQxNTFGR2pPZy93OVljbkFzaFF4MmdiRm9xdThXZWlOSE0w?=
 =?utf-8?B?OCttM2haS0dGQm9vZXMzQUNLVlVVTUwyUXNJV3QydkVOYnlmMEtOTGhXNmpN?=
 =?utf-8?B?TWpWOUdWVUJuek90QlR1aHBEZmFHcGVqVGRHcGlwZVEyMjZ5aE85Z0ZqQmps?=
 =?utf-8?B?K0V4WlpmVTNxbVQvV3dZOWs5Mk92NnphNXlWdlZwR2tRSmJTdk1CMjFPQUln?=
 =?utf-8?B?UmZXVWNUTVRDWlluQitJSThrYmNSdllna3lrV2xYMGYyTEhZUW5JSDRJSEVE?=
 =?utf-8?B?UmVlWWwyT2dYL1RVSWovKzBySmU2OFAxTWxXN1lpRjBsMWZ5czFHWXAyNXpR?=
 =?utf-8?B?bjBvRDgyZDJ2OU9yTDJRRHN3SUJGc3FONktIblNSNE5FenNpVlI3V0s1eCsr?=
 =?utf-8?Q?zcToDBf/ydoR6pbj0/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8C2E7F45E7BE748AB4CEBEFDB79D702@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b89141-401d-465c-37a9-08d9b55d07fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 06:29:01.8447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1GsV55ypwfWmtCOSyIAnqQQvPTEOY1ks44Dtw5xbnMz7Q4CjzzhWB9pAMfFVS+2fmdP0mrfYzpL0sYUvkB/hE0SV2oiWyjh+MIs8kNCcoZ6k8bDlU05Ad3E0T4GhyQ2U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2474
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMi8yMSAwMzo1NywgTGludXMgV2FsbGVpaiB3cm90ZToNCj4gT24gVHVlLCBOb3YgMzAs
IDIwMjEgYXQgNzozMyBBTSBWYWl0dGluZW4sIE1hdHRpDQo+IDxNYXR0aS5WYWl0dGluZW5AZmku
cm9obWV1cm9wZS5jb20+IHdyb3RlOg0KPiANCj4+IFdlbGwsIEkgZG9uJ3Qga25vdyBob3cgY29u
c3RhbnQgc3VjaCBkZWdyYWRhdGlvbiBpcyBvdmVyIHRpbWUuIEkganVzdA0KPj4gZ3Vlc3MgaXQg
aXMgbm90IGNvbnN0YW50IGJ1dCBtaWdodCBiZSBwcm9wb3J0aW9uYWwgdG8gYWdlLWNvbXBlbnNh
dGVkDQo+PiBjYXBhY2l0eSByYXRoZXIgdGhhbiB0aGUgZGVzaWduZWQgY2FwYWNpdHkuIEl0J2Qg
YmUgbmljZSB0byB1c2UgY29ycmVjdA0KPj4gYXBwcm94aW1hdGlvbiBvZiByZWFsaXR5IGluIGRl
dmljZS10cmVlLi4uDQo+IA0KPiBJSVVDIHRoZSBkZWdyYWRhdGlvbiBvZiBhIGJhdHRlcnkgaXMg
cmVsYXRlZCB0byBudW1iZXIgb2YgZnVsbCBjaGFyZ2UgY3ljbGVzLA0KPiBpLmUuIHRoZSB0aW1l
cyB0aGF0IHRoZSBiYXR0ZXJ5IGhhcyBiZWVuIGVtcHRpZWQgYW5kIHJlY2hhcmdlZCBmdWxseS4N
Cj4gVGhpcyBpcyBvZiBjb3Vyc2UgbmV2ZXIgaGFwcGVuaW5nIGluIHByYWN0aWNlLCBzbyBlLmcu
IHR3byByZWNoYXJnZSBjeWNsZXMNCj4gZnJvbSA1MCUgdG8gMTAwJSBpcyBvbmUgZnVsbCBjaGFy
Z2UgY3ljbGUuIFNvIHlvdSBpbnRlZ3JhdGUgdGhpcw0KPiBvdmVyIHRpbWUgKG5lZWRzIHRvIGJl
IHNhdmVkIGluIGEgZmlsZSBzeXN0ZW0gb3IgZmxhc2ggaWYgdGhlIGJhdHRlcnkgZG9lcw0KPiBu
b3Qgc2F5IGl0IGl0c2VsZikuIA0KDQpZZXMuDQoNCj4gVGhpcyBtZWFzdXJlcyBob3cgbXVjaCB0
aGUgbGl0aGl1bSBpb25zIGhhdmUgbW92ZWQgYXJvdW5kIGluIHRoZQ0KPiBlbGVjdHJvbHl0ZSBh
bmQgdGh1cyBob3cgbXVjaCBjaGVtaWNhbCBpbnRlcmFjdGlvbiB0aGUgYmF0dGVyeSBoYXMNCj4g
c2Vlbi4NCj4gDQo+IFRoZW4gdGhlIHJlbGF0aW9uc2hpcCBiZXR3ZWVuIGNvbXBsZXRlIGNoYXJn
ZSBjeWNsZXMgYW5kIGNhcGFjaXR5DQo+IGRlZ3JhZGF0aW9uIGlzIGNlcnRhaW5seSBhbHNvIGdv
aW5nIHRvIGJlIHNvbWV0aGluZyBub25saW5lYXIgc28gaXQNCj4gbmVlZHMgbWFudWZhY3R1cmVy
IGRhdGEgZm9yIHRoZSBiYXR0ZXJ5Lg0KDQpSaWdodC4gQXMgZmFyIGFzIEkgdW5kZXJzdGFuZCwg
YXQgbGVhc3QgcGFydCBvZiB0aGUgJ2FnaW5nIGRlZ3JhZGF0aW9uJyANCmNvbWVzIGZyb20gdGhl
IGZhY3QgdGhhdCBiYXR0ZXJ5IG1hdGVyaWFscyBhcmUgJ3ZhcG9yaXppbmcnIHdoZW4gYmF0dGVy
eSANCmlzIGNoYXJnZWQuIEFuZCBhcyBmYXIgYXMgSSB1bmRlcnN0YW5kLCB0aGUgdGVtcGVyYXR1
cmUgaW4gd2hpY2ggDQpjaGFyZ2luZyBvY2N1cnMgaGFzIGEgYmlnIGltcGFjdCBvbiB0aGlzLiBF
ZywgaGlnaGVyIHRoZSB0ZW1wZXJhdHVyZSANCndoZXJlIHlvdSBkbyBjaGFyZ2luZywgd29yc2Ug
dGhlIGRlZ3JhZGF0aW9uLiBXaGljaCBtZWFucyB0aGF0IHRoZSBjeWNsZSANCmNvdW50IHNob3Vs
ZCBhY3R1YWxseSBiZSB3ZWlnaGVkIGJ5IHRoZSBjaGFyZ2luZyB0ZW1wZXJhdHVyZS4NCg0KQnV0
IHRoaXMga2luZCBvZiBtaXNzZWQgbXkgcG9pbnQgOikgSSB3YXMgdGhpbmtpbmcgb2YgaG93IHRv
IGdpdmUgdGhlIA0KYWJzb2x1dGUgKHVBaCkgdmFsdWUgb2YgY2FwYWNpdHkgZHJvcCBjYXVzZWQg
YnkgdGhlIHRlbXBlcmF0dXJlLiBNeSANCm9yaWdpbmFsIFJGQyBwYXRjaCBnYXZlIHRoaXMgYXMg
bGluZWFyIGNoYW5nZSBvZiBhYnNvbHV0ZSB1QWgncyBhdCBhIA0KdGVtcGVyYXR1cmUgcmFuZ2Uu
DQoNCkFzIHlvdSBwb2ludGVkLCB3ZSBzaG91bGQgbm90IGluY2x1ZGUgdGhlIGxpbmVhcml0eSBp
biB0aGUgRFQgbW9kZWwuIFNvIA0KdGhlIG5leHQgc3RlcCB3b3VsZCBiZSB0byBqdXN0IGdpdmUg
bWVhc3VyZWQgdmFsdWUgcGFpcnMgKHNob3VsZCBiZSBkb25lIA0KYnkgYmF0dGVyeSB2ZW5kb3Ig
b3IgY29tcHV0ZWQgYnkgc29tZSB0aGVvcmV0aWNhbCBiYXNpcykgb2YgYWJzb2x1dGUgDQp1QWgv
dGVtcGVyYXR1cmUgLSBhbmQgbGVhdmUgZml0dGluZyBvZiB0aGUgZGF0YSBwb2ludHMgdG8gYmUg
ZG9uZSBieSBTVy4NCg0KV2hhdCBJIHdhcyBub3cgY29uc2lkZXJpbmcgaXMgdGhhdCBtYXliZSB0
aGUgY2FwYWNpdHkgZHJvcCAoaW4gdUFocykgDQpjYXVzZWQgYnkgdGhlIHRlbXBlcmF0dXJlIGNo
YW5nZSAtIGlzIG5vdCB0aGUgc2FtZSBmb3IgbmV3IGFuZCBvbGQgDQpiYXR0ZXJ5LiBJdCBzb3Vu
ZHMgbW9yZSBsb2dpY2FsIHRvIG1lIHRoYXQgdGhlIGNhcGFjaXR5IGRyb3AgY2F1c2VkIGJ5IA0K
dGhlIHRlbXBlcmF0dXJlIGlzIHByb3BvcnRpb25hbCB0byB0aGUgbWF4aW11bSBjYXBhY2l0eSBi
YXR0ZXJ5IGlzIA0KaGF2aW5nIGF0IHRoYXQgcG9pbnQgb2YgaXQncyBsaWZlLiBFZywgaWYgbmV3
IGJhdHRlcnkgY2FuIGhvbGQgODAgdW5pdHMgDQpvZiBlbmVyZ3ksIGFuZCBkcm9wcyAyMCB1bml0
cyBvZiBlbmVyZ3kgd2hlbiB0ZW1wZXJhdHVyZSBjaGFuZ2VzIGZyb20gVDAgDQo9PiBUMSAtIGFu
IGJhZGx5IGFnZWQgYmF0dGVyeSB3aGljaCBub3cgb25seSBjYW4gaG9sZCA0MCB1bml0cyB3b3Vs
ZCANCmxvc2Ugb25seSAxMCB1bml0cyBhdCB0aGF0IHNhbWUgdGVtcGVyYXR1cmUgZHJvcCBUMCA9
PiBUMS4gSSB3YXMgDQp3b25kZXJpbmcgaWYgc3VjaCBhbiBhc3N1bXB0aW9uIGlzIGNsb3NlciB0
byB0aGUgdHJ1dGggdGhhbiBzYXlpbmcgdGhhdCANCmJvdCBvZiB0aGUgYmF0dGVyaWVzIHdvdWxk
IGxvc2Ugc2FtZSAyMCB1bml0cyAtIG1lYW5pbmcgdGhhdCB0aGUgbmV3IA0KYmF0dGVyeSB3b3Vs
ZCBsb3NlIDI1JSBvZiBlbmVyZ3kgYXQgdGVtcGVyYXR1cmUgZHJvcCBUMCA9PiBUMSBidXQgb2xk
IA0Kb25lIHdvdWxkIGxvc2UgNTAlIG9mIHRoZSBjYXBhY2l0eS4gSSBzb21laG93IHRoaW5rIGJv
dGggb2YgdGhlIA0KYmF0dGVyaWVzLCBvbGQgYW5kIG5ldywgd291bGQgbG9zZSBzYW1lICUgb2Yg
Y2FwYWNpdHkgYXQgdGhlIHRlbXBlcmF0dXJlIA0KY2hhbmdlLg0KDQpTbywgaWYgdGhpcyBhc3N1
bXB0aW9uIGlzIGNvcnJlY3QsIHRoZW4gd2Ugc2hvdWxkIGdpdmUgdGhlIHRlbXBlcmF0dXJlIA0K
aW1wYWN0IGFzIHByb3BvcnRpb24gb2YgdGhlIGZ1bGwgY2FwYWNpdHkgdGFraW5nIHRoZSBhZ2lu
ZyBpbnRvIGFjY291bnQuIA0KU28gaWYgd2UgaGFwcGVuIHRvIGtub3cgdGhlIGFnaW5nIGltcGFj
dCB0byB0aGUgY2FwYWNpdHksIHRoZW4gc29mdHdhcmUgDQpzaG91bGQgdXNlIGFnaW5nIGNvbXBl
bnNhdGlvbiBwcmlvciBjb21wdXRpbmcgdGhlIHRlbXBlcmF0dXJlIGltcGFjdC4gSWYgDQphZ2lu
ZyBpbmZvcm1hdGlvbiBvciBpbXBhY3QgaXMgbm90IGtub3duLCB0aGVuIGRlc2lnbmVkIGNhcGFj
aXR5IGNhbiBiZSANCnVzZWQgYXMgYSBmYWxsLWJhY2ssIGV2ZW4gdGhvdWdoIGl0IG1lYW5zIHdl
IHdpbGwgcHJvYmFibHkgYmUgc29tZXdoYXQgDQpvZmYgZm9yIG9sZCBiYXR0ZXJpZXMuDQoNCk15
IHByb2JsZW0gaGVyZSBpcyB0aGF0IEkganVzdCBhc3N1bWUgdGhlIGltcGFjdCBvZiB0ZW1wZXJh
dHVyZSBpcyANCnByb3BvcnRpb25hbCB0byB0aGUgZnVsbC1jYXBhY2l0eSB3aGljaCB0YWtlcyB0
aGUgYWdpbmcgaW50byBhY2NvdW50LiANCktub3dpbmcgaG93IHRoaXMgcmVhbGx5IGlzIHdvdWxk
IGJlIGNvb2wgc28gd2UgY291bGQgZ2V0IHRoZSB0ZW1wZXJhdHVyZSANCmltcGFjdCBtb2RlbGxl
ZCBjb3JyZWN0bHkgaW4gRFQuDQoNCj4+IEJ5IHRoZSB3YXksIEkgd2FzIHJlYWRpbmcgdGhlIGFi
ODUwMCBmdWVsLWdhdWdlIGRyaXZlciBhcyB5b3Ugc3VnZ2VzdGVkLg0KPj4gU28sIGlmIEkgYW0g
Y29ycmVjdCwgeW91IHVzZWQgdGhlIGJhdHRlcnkgaW50ZXJuYWwgcmVzaXN0YW5jZSArIGN1cnJl
bnQNCj4+IHRvIGNvbXB1dGUgdGhlIHZvbHRhZ2UtZHJvcCBjYXVzZWQgYnkgYmF0dGVyeSBpbnRl
cm5hbCByZXNpc3RhbmNlLiBUaGlzDQo+PiBmb3Igc3VyZSBpbXByb3ZlcyB0aGUgYWNjdXJhY3kg
d2hlbiB3ZSBhc3N1bWUgVkJBVCBjYW4gYmUgdXNlZCBhcyBPQ1YuDQo+IA0KPiBZZXMgdGhpcyBp
cyBob3cgaXQgaXMgZG9uZS4gV2l0aCBhIGZldyBtZWFzdXJlbWVudHMgYXZlcmFnZWQgdG8NCj4g
aXJvbiBvdXQgdGhlIG5vaXNlLg0KPiANCj4+IEVwaWxvZ3VlOg0KPj4gSW4gZ2VuZXJhbCwgSSBz
ZWUgYnVuY2ggb2YgcG93ZXItc3VwcGx5IGRyaXZlcnMgc2NoZWR1bGluZyB3b3JrIGZvcg0KPj4g
cnVubmluZyBzb21lIGJhdHRlcnktbWVhc3VyZW1lbnRzLiBTb21lIGRvIHRoaXMgcGVyaW9kaWNh
bGx5IChJIHRoaW5rDQo+PiB0aGUgYWI4NTAwIGRpZCB0aGlzIGFsdGhvdWdoIEkgbG9zdCB0aGUg
dHJhY2sgd2hlbiBJIHRyaWVkIHRvIHNlZSBpbg0KPj4gd2hpY2ggY2FzZSB0aGUgcGVyaW9kaWMg
d29yayB3YXMgbm90IHNjaGVkdWxlZCAtIGFuZCBtYXliZSBmb3INCj4+IGZ1ZWwtZ2F1Z2luZykg
b3IgYWZ0ZXIgYW4gSVJRIGlzIHRyaWdnZXJlZCAoZm9yIGV4YW1wbGUgdG8gc2VlIGlmIGNoYW5n
ZQ0KPj4gaW5kaWNhdGlvbiBzaG91bGQgYmUgc2VudCkuDQo+IA0KPiBZZXMgdGhlcmUgaXMgc29t
ZSB0aWdodCBjb21tdW5pdHkgb2YgZWxlY3Ryb25pYyBlbmdpbmVlcnMgd2hvIHJlYWQgdGhlDQo+
IHJpZ2h0IGFydGljbGVzIGFuZCBkZXNpZ24gdGhlc2UgdGhpbmdzLiBXZSBkb24ndCBrbm93IHRo
ZW0gOigNCg0KUmlnaHQuIEJ5IHRoZSB3YXksIEkgaGVhcmQgdGhhIHRoZSBUSSBoYXMgcGF0ZW50
IHByb3RlY3Rpbmcgc29tZSB0eXBlIG9mIA0KYmF0dGVyeSBpbnRlcm5hbCByZXNpc3RhbmNlIHVz
YWdlIGhlcmUuIE9UT0gsIFJPSE0gaGFzIHBhdGVudCBvdmVyIHNvbWUgDQpvZiB0aGUgVkRST1Ag
dmFsdWUgdGFibGUgc3R1ZmYuIE9jY2FzaW9uYWxseSBpdCBmZWVscyBsaWtlIHRoZSBpY2UgaXMg
DQpnZXR0aW5nIHRoaW5uZXIgYXQgZWFjaCBzdGVwIGhlcmUuIDovDQoNCkJlc3QgUmVnYXJkcw0K
CU1hdHRpIFZhaXR0aW5lbg0KDQotLSANClRoZSBMaW51eCBLZXJuZWwgZ3V5IGF0IFJPSE0gU2Vt
aWNvbmR1Y3RvcnMNCg0KTWF0dGkgVmFpdHRpbmVuLCBMaW51eCBkZXZpY2UgZHJpdmVycw0KUk9I
TSBTZW1pY29uZHVjdG9ycywgRmlubGFuZCBTV0RDDQpLaXZpaGFyanVubGVua2tpIDFFDQo5MDIy
MCBPVUxVDQpGSU5MQU5EDQoNCn5+IHRoaXMgeWVhciBpcyB0aGUgeWVhciBvZiBhIHNpZ25hdHVy
ZSB3cml0ZXJzIGJsb2NrIH5+DQo=
