Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2DE5AE374
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239593AbiIFIue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbiIFIuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:50:09 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A510DE86;
        Tue,  6 Sep 2022 01:47:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neF2hyG7X9cIi/z1hykExUHVh1lBUgfVOHbRPzbJ5LZbUXfWzVDd3SYnh8gw6Ddar/vk7pHKrZnJPnNTzHly1hIBO/vuWTHXSYj7ozHp6jpcyeTocfqiyZb25JIBRQ+OcyZA36aMjJEDYuXu7xOT+RrNU0Ict0ZtPpwRZex9gGHOp9TymBhgE9B4tHZSnCdo7xWT/VNorDNrFxKjXj4OryNfE8+wJ4nCMJbA82s05/Ex4gqwPHGMyZuKVFOdn2X06zH160lxX2OwJEN9oDG2tGJDh+OMkJ2NtwhHJC/RZZ7KGer28o2ReeehhlDcgC0aXH6j6ZBf0oCKqfYMWRCFeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CF3oNkgLaEn8HtPtG6JVNmva55WgGiv3zG7mQl4VqrM=;
 b=exk9BHzQB4tXv9Gj0ZXQZuxzxOoaPWIC3Bf1uex/nASrX5hcMVLbgQZEm/FJRme0RGsgq2yFh20x/pHhMr35Rt4tGYLzKxKjEbCvRGx7wWWUNPbSEHIPtDHDiv+zRBB1kXhlFVu/4UWgyaePYEQ0U5USu7W+pw321xTSquem8PsKsk6vbLxKVSjeUHw9QER5FjCYDkUeAubXQL0/W8qsRsIQet/5QVXL/RQ8awOOJvgNTUdm/oe6dQrzg+wZGnHQPFxZc3GF52z0Fxf3Sas+csoS7WpFY6vFn9xvPWQ3Pn0c8dxJhWLgteYjcy2OaJGTswSP2p6rxo6rdy+CVgOX6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CF3oNkgLaEn8HtPtG6JVNmva55WgGiv3zG7mQl4VqrM=;
 b=e17TRNIGhKOkegY6cIvjl5rS+w2TbhbgdgyBSIyqaldllcZhzcfnIfL8KnFEoMu8OZ4WwOo6i61QicrQNC6kwRKCRtAXUc43hYrnwzESZ+ASAxkGOc06/hd+vZNDlnPlRySyteDaVliTQHMoKDZm6pOMM4NM8FCMWd0uCSLgGZg1uQspQFq+zVuqyNWsx0c0AYmVMf6mYywRWWcEeyCS4hHkvp7ntUZ93sPTxFunEvimhpV63zssuviDm4ig6PltDVgTSJWk2/xNVMtwFlPzx/WUT6vq5Psj0EBwgI+h9Z7gOYQNJIwXYro6bVymQ/EhIatjbBXojB9R18XNiG+sSw==
Received: from DM5PR12MB1628.namprd12.prod.outlook.com (2603:10b6:4:7::13) by
 BL1PR12MB5971.namprd12.prod.outlook.com (2603:10b6:208:39a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Tue, 6 Sep
 2022 08:47:51 +0000
Received: from DM5PR12MB1628.namprd12.prod.outlook.com
 ([fe80::a454:b4a3:1f88:2df8]) by DM5PR12MB1628.namprd12.prod.outlook.com
 ([fe80::a454:b4a3:1f88:2df8%4]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 08:47:50 +0000
From:   Sandipan Patra <spatra@nvidia.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bibek Basu <bbasu@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: RE: [PATCH 1/2] arm64: tegra: Add PWM controllers on Tegra234
Thread-Topic: [PATCH 1/2] arm64: tegra: Add PWM controllers on Tegra234
Thread-Index: AQHYu5y8uDVLbZAtaE2qDZcXtS8lqa3HNIgAgArRHQA=
Date:   Tue, 6 Sep 2022 08:47:50 +0000
Message-ID: <DM5PR12MB1628DCF5CBEF7FA49EDE7DE9AD7E9@DM5PR12MB1628.namprd12.prod.outlook.com>
References: <20220829114432.19566-1-spatra@nvidia.com>
 <4dfbf55b-744d-b0b6-0afd-530a45becba0@linaro.org>
In-Reply-To: <4dfbf55b-744d-b0b6-0afd-530a45becba0@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 731267e6-4d82-4f63-d8e7-08da8fe47b3e
x-ms-traffictypediagnostic: BL1PR12MB5971:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BjjgVkEc/t0TTbWhWZDIngloffuOU5OX0/N29qrSWIm1s8OuFJsj2az8dRV0UYrJEz9/KtBhzGKorcTRUXMqkZ8XIo3WB+Y7NwSbXmsPIUAli79GCSlhDZMZqimtap38IUWjGjCCJFx/f7pYkG01aCun3gZwh1GPCouSTWtchvzwrNT7HejOPNY1cpe3J0u4+EYtqjCB/NlKJAwiAZdciqvbTVnzDYTiyRDP7v5NhSY8U2TPFPtFe3LI7LvYo/ZqN8jBgTeuSEkEJiMA7dJE1RKEiEvSXZ0DntqPE2WGZe66HfN24T3xceu/OqPkDipgLIyyNTynDfpNPJZvVDuPaGZQCpPtMBYIcQxfb64QccoHnaFC6NwPD4/91Jb40ZRjO/gFox44r1vfp5MU2xdw5ryT/voIsjSvCrGY2IH5XdeFCrwsZfzwDNh4BeHMzsuoHTEU9qiTzZSiT1FMvgLg9ID30Sw8u7g8oTzwi/SsZQkjGaE2/ny3nFoBcffoFPdKr1V7SRVAP0t2AwsNuMjgAl8qqDfSoJbr4/zE9vLqEplbk3FmoyTfJi6YtIDIVRzJvqQ86ibjtdtpxwpF/Dm1HuZ3bOf+wJNgLM6PtZBDo31ce3MReFp2iCTRpQ0buZRlr4t/8cWxCZYtr/kMX09dJ2GcqmCDL1UQFwzAd/U7YLaSOWQPf7pvV7Vvp9L3cv0cRE6I+7F9okJ1Rx6LFNPUmBAxPZyApx61/s2irbBBLzLJgLpQ6Rm2eNAaHstUpr8hOtT2H+bQZhz59hcGdnx/pw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1628.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(478600001)(55016003)(186003)(64756008)(66446008)(66946007)(4326008)(8676002)(83380400001)(66556008)(66476007)(76116006)(6506007)(7696005)(107886003)(9686003)(71200400001)(41300700001)(26005)(33656002)(53546011)(122000001)(38070700005)(86362001)(54906003)(8936002)(2906002)(5660300002)(52536014)(38100700002)(110136005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sy9nV3VvMzdXdnFzMStsYlRrSCt2OS9wcjBoZ015bXVFbFo4Y2xLL0xEZVRD?=
 =?utf-8?B?cXdUSC9QQ1dOWmRVM3JReDhrTjBLVmg2ZDRadnhpakRpL0dsVFJzUDI5enRZ?=
 =?utf-8?B?VjcxQW9udEpUelVRV3NMRkUxenBBbGg0VHZOUFNjYytFT1B4cThNMjRBZUJt?=
 =?utf-8?B?Uy9TbXJoSkNsV2NZcDUvcXI4eVdJZ21ITTh3VmxUYUQyczhWWFhDR0J5OFFQ?=
 =?utf-8?B?K212c2NjU3NBME9zdno2VzBzQ0doUCtVbU1vVnRpR014SnFrREh0SGlmTmRC?=
 =?utf-8?B?WEtORHRuK3VTV1J1YjYvaWlJYzk2S3VpcmlOUnRIRzRseXl0UTFSTjVhR2lk?=
 =?utf-8?B?RTZBdldEZWdRTStPK2FtcHZ5Y3VHa285NjhtTWJKOUlFeFhrQXR4dm1oSDdY?=
 =?utf-8?B?YVU2N0M5MW5iZVNPb2hJTHNJU3Q4Rnh6U2RnZkJLNDltTUc1QUgxeVhNNHdD?=
 =?utf-8?B?MVArSC9UczVJU2ZYSWM3KzhvaFo0UVF4K0pqNVhIemZ1TE1LckFaZXpHdFhC?=
 =?utf-8?B?U3gybzlvMkh6ZW9qRWRoNzJxSFNKU1VxdDA5YmVHSWJZQlozREp5T1NOOTJ0?=
 =?utf-8?B?aEtCL0o4NzFSNlFDeVB1dENKSVF6UkVUa3FYa2dOSDBIZXN6QTA1eWJBcEZJ?=
 =?utf-8?B?bllUNVZXL0pQTmo2ZklBSXZlNTJ2QzNZRFVuT1p2VFpENjEzMnJkOXNtSHE0?=
 =?utf-8?B?dFJrakppcHRBc2FpUTh2a2Rnbjd4SnN4d3FZT3FKMlRFbG9qcklQV2NIQnho?=
 =?utf-8?B?dHFadXNPTVkzSDR1b3FleEhwSlZnTlVlN2JpbUU2NG1PbHlBMkM3c29TUy9R?=
 =?utf-8?B?YUkyTmFTajhFTzZZTHZIeElOVERyMitGSGxKaTR5KzdSVjVvcVFxaWpVaDhZ?=
 =?utf-8?B?NUhHM2V3WjFJRHIrRXFHTnIxZ1BiajgrNnljNHVLM2I0TFlkbXZ4NnVFZVBF?=
 =?utf-8?B?dCs4NDFveFo0Zk0ybjFmQkxRcm4yVVVTZWpSMVpkZmROVnRnRjdsMFpyNHhp?=
 =?utf-8?B?ZFJQN2E5OU1uTC9iZEZpc0FJRW1IWG5INXVIaDBBdnhzb0I3ZjRUd1cybllB?=
 =?utf-8?B?UDlUR3ZSYzBBc3NwdFliVGdhZWNCNzFjQ1o2YU52RWs1dFFpOHlSWHd0TXFv?=
 =?utf-8?B?L2ZUOEdXd25NUGd3MTNlbW94WkZ4bzVGSzlTRVpob2NNUnNTTHVGaGFtTFJU?=
 =?utf-8?B?M29DN3ZMSlFxRWVtVXl0ZHNyeWk4ZFNGaTdQV0xhNURZWmpxZGZLMm8wMzA1?=
 =?utf-8?B?aldsdTlSaXdiVmgzYWVBc0QvSU1mSEQxaHlTbEdwankzbDh6R0QzMHlSOGFh?=
 =?utf-8?B?SFJKRXpHR1IwMmlzWkRlMjFTYlhnbkp5Q2FCMHoxYmlzZ0xZNGNQYUlEd0l6?=
 =?utf-8?B?OG1icUZKUFQwcGVDYTRKdytZNE5BM29NNE1HWjU1c0lCWGQvUUJMaWF3OGtx?=
 =?utf-8?B?bnRVUGVvT2xkOURmZFprckcwT1UwbFBzaFVFb1VzMW8waEpEUGJFbFljcUNj?=
 =?utf-8?B?NVZPYnlsd29IbE9aY1RPbklXQ2tOM0tRNExSaElrenppY0tSajN0bktHVUZo?=
 =?utf-8?B?bUwwVlV6M29xTS8xcXVlY3hkZEhocFErNmU4WXB4Sk56MG1xS3MzQjBEOFFO?=
 =?utf-8?B?UVlOT0J5SytyL1FCbFYvVUxBclNZT2lISnVKczh1WkIyVG5rclIzSk9IQUdF?=
 =?utf-8?B?Wjd2QnUxTTJhNldGSVdWMUFWZndqQWp5RnkvRG9iNkdzSXdDd0hJVzh1TUhB?=
 =?utf-8?B?TjN2Z25UNy8rUnVCLzY5WmRlQURjZU5sdDZsVE05SGordHdjZnRZd1RUYjEy?=
 =?utf-8?B?OTBzN01wcGltVDNnc0lkM1FwdE03SUtsK1lwV3VoTElybXhyL24wWTRWUFgy?=
 =?utf-8?B?bFBCNWZOV0dTWDdubVMrc0NuYlN5RzdhWlQ5Z1lNR1hxK0J5YXl2L0MxL3I0?=
 =?utf-8?B?SWFoRFc3ZTNZUDlqUlladjJnYmlrWDc2NVk0SGIxSHd6M0J2Mld6ZzBYSUEz?=
 =?utf-8?B?MWhyMklLMVRpRUtIT2FvNXprRE9YbGV1MXAwQ0lkR3I0QS9kYlVCRFZKNGE4?=
 =?utf-8?B?Q29KV0loN2tkVWd2NTJmNDZiUGd1OEl5NlFLb0s1SmxQZUxWT0xXN1paZFhK?=
 =?utf-8?Q?1QPk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1628.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 731267e6-4d82-4f63-d8e7-08da8fe47b3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 08:47:50.9065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JHNfLrY/wkMtJdYubfpUESb2SlDwsgGpkVQAxT7RgBufYghRfYNRjhV89HWcSa6MjaFOTRMLHrEWWPWXsVAiZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5971
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQogPiA+ICsgICAgICAgICAgICAgcHdtMjogcHdtQDMyOTAwMDAgew0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm52aWRpYSx0ZWdyYTE5NC1w
d20iLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIm52aWRpYSx0ZWdy
YTE4Ni1wd20iOw0KPiANCj4gVGhpcyBkb2VzIG5vdCBtYXRjaCBiaW5kaW5ncy4gRWl0aGVyIERU
UyBvciBiaW5kaW5ncyBuZWVkIHRvIGJlIGZpeGVkLg0KDQpUaGFua3MgZm9yIHJldmlld2luZyB0
aGUgcGF0Y2hlcy4NCg0KVGVncmEyMzQgdXNlcyBzYW1lIGNvbXBhdGlibGUgYXMgVGVncmExOTQu
DQpBbmQgYWxzbyB3ZSBjYW4gY2xlYXIgIm52aWRpYSx0ZWdyYTE4Ni1wd20iIGZyb20gdGhlIFRl
Z3JhMjM0IHB3bSBjb21wYXRpYmxlIGxpc3QuDQpJIHdpbGwgdXBkYXRlIGJpbmRpbmcgZG9jIGFu
ZCBwdXNoIG5ldyBwYXRjaC4NCg0KDQpUaGFua3MgJiBSZWdhcmRzLA0KU2FuZGlwYW4NCg0KDQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxvd3Nr
aSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBBdWd1
c3QgMzAsIDIwMjIgMzoyMCBQTQ0KPiBUbzogU2FuZGlwYW4gUGF0cmEgPHNwYXRyYUBudmlkaWEu
Y29tPjsgdGhpZXJyeS5yZWRpbmdAZ21haWwuY29tOw0KPiBKb25hdGhhbiBIdW50ZXIgPGpvbmF0
aGFuaEBudmlkaWEuY29tPjsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBrcnp5c3p0b2Yua296bG93
c2tpK2R0QGxpbmFyby5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4g
dGVncmFAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENj
OiBCaWJlayBCYXN1IDxiYmFzdUBudmlkaWEuY29tPjsgS3Jpc2huYSBZYXJsYWdhZGRhDQo+IDxr
eWFybGFnYWRkYUBudmlkaWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gYXJtNjQ6
IHRlZ3JhOiBBZGQgUFdNIGNvbnRyb2xsZXJzIG9uIFRlZ3JhMjM0DQo+IA0KPiBFeHRlcm5hbCBl
bWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+
IE9uIDI5LzA4LzIwMjIgMTQ6NDQsIFNhbmRpcGFuIFBhdHJhIHdyb3RlOg0KPiA+IFRlZ3JhMjM0
IGhhcyBlaWdodCBzaW5nbGUtY2hhbm5lbCBQV00gY29udHJvbGxlcnMsIG9uZSBvZiB0aGVtIGlu
IHRoZQ0KPiA+IEFPTiBibG9jay4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNhbmRpcGFuIFBh
dHJhIDxzcGF0cmFAbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9ib290L2R0
cy9udmlkaWEvdGVncmEyMzQuZHRzaSB8IDg0DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4NCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9udmlkaWEvdGVncmEyMzQuZHRzaQ0KPiA+IGIvYXJj
aC9hcm02NC9ib290L2R0cy9udmlkaWEvdGVncmEyMzQuZHRzaQ0KPiA+IGluZGV4IDgxYTBmNTk5
Njg1Zi4uYzJkYzY1MWYwODQyIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
bnZpZGlhL3RlZ3JhMjM0LmR0c2kNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL252aWRp
YS90ZWdyYTIzNC5kdHNpDQo+ID4gQEAgLTg0MCw2ICs4NDAsOTAgQEANCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgI3B3bS1jZWxscyA9IDwyPjsNCj4gPiAgICAgICAgICAgICAgIH07DQo+ID4N
Cj4gPiArICAgICAgICAgICAgIHB3bTI6IHB3bUAzMjkwMDAwIHsNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgY29tcGF0aWJsZSA9ICJudmlkaWEsdGVncmExOTQtcHdtIiwNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICJudmlkaWEsdGVncmExODYtcHdtIjsNCj4gDQo+
IFRoaXMgZG9lcyBub3QgbWF0Y2ggYmluZGluZ3MuIEVpdGhlciBEVFMgb3IgYmluZGluZ3MgbmVl
ZCB0byBiZSBmaXhlZC4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=
