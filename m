Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EFB5228F8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 03:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240350AbiEKB3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 21:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbiEKB3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 21:29:40 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F55246D99;
        Tue, 10 May 2022 18:29:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qfq/mD1PyoChKPd+Q+68K8GIe6+5zijpqzVEI0yHrdwFvB1rq6u30hOoMz4S6N6Hj+HlEeKkzEegKrU340aHamEzxgxkgvLhsfldD3elKsAm9WGFl3/O2utKHu2XX6RfMdVpkS8J5XDBSFymGL1k9mvNU60JmK/ohTnkJHOfQ6fkxsjoXuLLXcyNake+eq67/gP+Cr1kJDybl59iXn/lizc73yPSIsHk5N8WNFGtdTkgnkEDM+FXNBk46mfuC+1HKRy5nHuko1r+f5Ea8CgSYqn64KJejfWnAeFgL101zWIuvMeTNIOmCk6OHzSaO/e2N8/z4ZiaOzZIm+Ge8C27xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y71ArA3dJxGZxeqNSfm4Zj9yILky+tgjp9a6G1Biy8I=;
 b=KK3amHUedRcw6mfzc9VffMVV4T1bajBBktVWMeMVbRZj8mcZfNEn6fMsTPPmIPI6zcgHagnvay4J92/DYxi0yuOjkzhDHO+pvFOK1klPvCCcqbOWGZPQwOD4JbiA4m++eVGMLpzb1Qof2VPf+reR+QGhEGziNctuPlWIkc1zDLBPwIhneuuG12PqIm3RMKCEAe+5gLyUEFmPlQSB5AEWjClWXisvDG4R7UyN5Lc04+87Xn/LckSGfwkTq5gxrQ5GbHYppV5Evr3B3anW7HJ1GznsbO0CA3OETZAKIVb1D6kwIdprHbNRMw7r4acKJ+ciXCKx3mcMY/A662UiLkifAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y71ArA3dJxGZxeqNSfm4Zj9yILky+tgjp9a6G1Biy8I=;
 b=E5+24lvyZejipoW0p0pN7COIKcFm/JFnEEmP27fGD5sfBIK5TftyZkUGB/7sqcyC5jKhvuDztzrl2/wiwsmUs8FOMpC0BpAbqA7u8qmpMOT6CfbwA42baYsRGuLS3EUQfSpT+0BibL86LnmC4AMI8aGatIBzy43ROa431o4GkJJdA/ZOAPJf/PnfVNsujvAoyIvcOsYe4zHxScMoWCMzZrEBxc+V5skYoVNJAH8OFF1c+lD/DYEjRMN0vqsNRE7Hdjb+pmuHtYLwv7p2OPRxXRe8DB3EFS8u7XHLKpt89wNXbF4V1ZrMVSBB+vq0UKVBPbmLy2+CF6yRVn9pHjl6Ag==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by PH7PR12MB5736.namprd12.prod.outlook.com (2603:10b6:510:1e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 01:29:37 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::7526:b8f5:b10:1c4c]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::7526:b8f5:b10:1c4c%7]) with mapi id 15.20.5227.021; Wed, 11 May 2022
 01:29:37 +0000
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "thanu.rangarajan@arm.com" <thanu.rangarajan@arm.com>,
        "Michael.Williams@arm.com" <Michael.Williams@arm.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: RE: [PATCH 0/2] perf: ARM CoreSight PMU support
Thread-Topic: [PATCH 0/2] perf: ARM CoreSight PMU support
Thread-Index: AQHYYzu4AtKVUSpJ7k+AnLFkxMXOCq0WR+MAgAAJZ4CAAaSUAIAAAZKAgAB864CAAGCy8A==
Date:   Wed, 11 May 2022 01:29:36 +0000
Message-ID: <SJ0PR12MB5676E68453A977F1220FF7AFA0C89@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20220509002810.12412-1-bwicaksono@nvidia.com>
 <20220509092843.GB26264@willie-the-truck>
 <2e5e09f9-b71b-d936-e291-db8f94554b18@arm.com>
 <20220510110742.ievkihggndpms3fn@bogus>
 <20220510111318.GD27557@willie-the-truck>
 <20220510184025.iwgknfqe5ygz4jwn@bogus>
In-Reply-To: <20220510184025.iwgknfqe5ygz4jwn@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ee0b64d-d6e2-45d9-9e38-08da32edb60e
x-ms-traffictypediagnostic: PH7PR12MB5736:EE_
x-microsoft-antispam-prvs: <PH7PR12MB57367FACC28249849C7184CCA0C89@PH7PR12MB5736.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uhtxMm7FzoCg7jwGmEcNYCTNpb0tLuprpZkE4cWd2t4WKhehsYwKw2i7kJzTYtNVmf4Qfuaz/z4O+fw3vPeEeqHjCf31Hj5yh4DeOMkfglEnVNGtQsNsY2ZrYK92WDL4ZC37zkNL096Ddc8vpqa8KfoPvZ0eiqqyOtOjtaDZVQRTn/aCATVKFsAr2VZoy5FuLPVKqDYPADbJhzkCHcPutUtdxXbASGxL2zYVQaEJDDspcr/qLr2GGdkqUeIQcZbMIhzsdxuG6AJnCECoS8d90wVuDL/JgKJcQSLbIGPyxIfu6sDNxrO1DiGLYJFIOIEpI7W9kLT0mojD3BJ+W5yJb0MqRkfg4zMHcpXIUdXWB1cQM6Vbo5/653qiLMibX/24PKKFSAhWM8D5VgZy6fW3bAOaReE6U2hpGTB5kgTY/x8e3YGHDKgcJYadYBMUHejMDoE7kEqSFgHH7g3JNBtne6s4XaIpmXTTjqLPrOL3t7tYxZErRHbwRlVNkQAu6g0cF09oE5gY2ppHbOypf8MnXd8AYdvORWmvLtlQLHrRUmhNVoKMsQjN5CctGLxqOWvIyBLTDhOR5yUYWt1DYJvZX8sUXTVnoeXZAH2fWmrntAX0offmfYY39j9ylYF8w1XHexjw6sGjMHTJ7zJnH2enXEyDyOLAFUxPMBcnRrgdk5msumX4lINDIzpZABff1K3HET23ojSB6ACYqUXJ/g8Onw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(33656002)(71200400001)(66556008)(76116006)(64756008)(66446008)(86362001)(66476007)(66946007)(8936002)(52536014)(53546011)(4326008)(8676002)(7416002)(6916009)(54906003)(83380400001)(5660300002)(508600001)(316002)(38100700002)(38070700005)(2906002)(55016003)(122000001)(7696005)(6506007)(26005)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXpTbUYybTZ1YWxLR2ZmaE1DVDFYaWFFVjgzS1ROZmh2c2tyalZqa2NhbUNW?=
 =?utf-8?B?SDdZTkZMZE13SHZxOVowbHd0VmRMVTRFcW5SK21RVFJoM0tXSXNKNUdaUW9p?=
 =?utf-8?B?blpkYThmeFRheEdGOGluZG1mZ2hjVTVONDREdXNaK2s5VXg2SmlmcDVPcmhG?=
 =?utf-8?B?eGtFSStZdTA0TFlaYzJLeVlvbUV4T2tZNEJQTjQ5c2hCd1dJZ0hrdE9ZOXhU?=
 =?utf-8?B?WTFjbmNlUnZpcnpGZFBMWVAzRmRFU01qU1dKOEhFRFdSYlBDRFRTZitMOWJX?=
 =?utf-8?B?ZGIyZUd1eFFXVFBRSEx2RmpNSnRQYWZoNHlESlZmekRXRE5JdmREL294UHVU?=
 =?utf-8?B?dEVsM2lHYkNySTZDL1J1YjczOG53MjN4Vms5a2FERm8rMEdPbU5RbmozR2hT?=
 =?utf-8?B?d3lWZi9ZcDBieVAyaU4zQktlWlJIOVZrVm5ob0Zuc2FUUVVPeTR2T3FMbk1I?=
 =?utf-8?B?Rm84eGJYM0VGa281Nkl5STF5cmFzdW1EQnFGdTArWHFFZjZOcVZ0OENRcjg5?=
 =?utf-8?B?dWVXYW9HTHgwTk9GSk9MZUdpakFRVS9CclpMdUJHb05RVS82WXRZTldCSk1s?=
 =?utf-8?B?UXgveFJ0eFdrc1BVZndERGFCQXBZVWFaOUlRNDR0L0F4SlltazdqcFJWWEM0?=
 =?utf-8?B?MVdCSjlCK0U5UWNYVjJtZVBZYTd5bWtyV0VVYytJVWRQSWRpRXNORktoNDVN?=
 =?utf-8?B?akhra0FJa1ZvUHNaQnFPNEhKekx3aGNEZ0tES0cvMVoyYmlFQkRzRXFLcmZy?=
 =?utf-8?B?Ulp4WTZ2N2JMMi9JUUEySEdyVHJFRHZKVndCQmt5UjVrbm5EcXBRRG5KRFJP?=
 =?utf-8?B?cXpFVjltTVVPcHU3NEM4QXNyYXE1R3hJVFNHNTJtNlFxY2JFWHNBOXpUUytJ?=
 =?utf-8?B?L3BYTHQvK2dldWo0R3FXemoxa2dLWTlXU3lzSk50cTUxNVRiRlFUZmxCbG1j?=
 =?utf-8?B?NnFDR3FmNWl2V29oaUgzN1c5TkFOQzlXNk5rS1dIK3ovYndwNnAwS3pzTTdw?=
 =?utf-8?B?NHJyTVZFWWhsUC83ZkJ3VEdrWnEzQ3RpSG9CeXBIS3NOaURMYlM4aUtsMjJK?=
 =?utf-8?B?ZmFVQzg0Q1RLWnc3TlNSS1BjL01odWZDM096SmFvSllGQWppVENZRUVKRHFr?=
 =?utf-8?B?Vk84MGdjRHdCdkczWlYxcVBPUlEyTDkrVzZTd3MvWnFEd2l4aSsrSG1uUEI5?=
 =?utf-8?B?OGo1NXJZamMvTVdhV3ZzcE8wMHJSSG5qUnlacDdLaHhxZzhJL2s2MzdDb003?=
 =?utf-8?B?eE9RNGZaMUZnUVh6TFRtSjZpUEFROUdFckcvL2N5aUZZdWZXR00zalBXT05n?=
 =?utf-8?B?WGsrRko0SEg0bXVkbEF0dkJOMlhNUVM1akprQmZHN21PZFcvRllvK2ZhZ2FQ?=
 =?utf-8?B?aEYrMXAyS1N4V2hPVmtkSkpwdms0Zk9kdzVSRzR5bklvSGg5VWprUXRPYTc3?=
 =?utf-8?B?aTcxV3laMytPL0FQTGw5eWNjbWdrZC9sY3FTSlJsT1M0emgvSkw3MTF2MkdX?=
 =?utf-8?B?YjdQanAzYVk2Y3JIamdEQXRUMVJ6SWJXam5qbWM0NnRFRnRrM0pMaHozV3JN?=
 =?utf-8?B?QkpqTkpyN3hWOEhkZDlMZFdvRmw2dkxlclA2OXV4Ynp4cURIakhiVElvM2NY?=
 =?utf-8?B?UEYyUi95UFV3NEI2Nit2NW0vU014RXBDdXMxbDdmSllRYWp2eVRaRUdBMW9h?=
 =?utf-8?B?cEdPL0NscGJ2S0ZlUVRwZHh4WmdEUmdNU3ROdFEwbm56M3dEaGRPcEFPTEJq?=
 =?utf-8?B?aE9oM25Ya3p2UVI1TTVtY0dwTml0MEowYVVXWGFJRDNZWVBncDZqWDlZc2FI?=
 =?utf-8?B?SWFyQTlHQjA0TmF3U21RajF4Y1pra1I3Ykd4bFQrVHBGQTlIcWNSMUNYRitv?=
 =?utf-8?B?bUNHVVJiczZKak9JYTdFaWFpMC9NM3FMN1JqNE1mMnVoa3pQWjNiZGtaUlVH?=
 =?utf-8?B?OVZJb1Flc3I0MUtiUWdnRHQ1L0NNeEl6bGwxNnU1SUtaUnhKdXhEQ01TYUtm?=
 =?utf-8?B?R0kzSU5xTGJLYVYrckVIMmpUeGhDdWtiY1NyRzhFdHBBWnljdXhkbzhENjVJ?=
 =?utf-8?B?NzN1cGxIS1YzeE1lZGhzZHJ3VnNSd3V0dzVQWFZSeGlZQ3prNG5xUUNLTERa?=
 =?utf-8?B?bkduVGdoRHQ4aEZ2MXhkNGRtZlAxQUtMZ01DcEdqd0VMTm1RbWpBZm1reFZI?=
 =?utf-8?B?MFlEODhRWk03MjdDUjFnbk1VMWxvVDN6Zzh3ZnVuenErZWV0MldFaDQxQllS?=
 =?utf-8?B?ZmEza3pGa1lYQXlmd21aMXJQME9KR085U1JNY0NHOENEUUsveElNN2hIUytX?=
 =?utf-8?B?dEZkcDh2bUlXbS9uUFJqaFNjOVlKU2lNNnZLaGMveU9NQ0FZbzVzQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee0b64d-d6e2-45d9-9e38-08da32edb60e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 01:29:36.9084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tis/x0Bcncya9t+NkmfoiLn7xLqujqQIesOgluxiuI4rhy444WU6+E3LcV+/Iu5wiEGe0IGoRr1zfdoRrV9Nhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5736
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3VkZWVwIEhvbGxhIDxz
dWRlZXAuaG9sbGFAYXJtLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTWF5IDEwLCAyMDIyIDE6NDAg
UE0NCj4gVG86IEJlc2FyIFdpY2Frc29ubyA8YndpY2Frc29ub0BudmlkaWEuY29tPg0KPiBDYzog
U3V6dWtpIEsgUG91bG9zZSA8c3V6dWtpLnBvdWxvc2VAYXJtLmNvbT47IFdpbGwgRGVhY29uDQo+
IDx3aWxsQGtlcm5lbC5vcmc+OyBTdWRlZXAgSG9sbGEgPHN1ZGVlcC5ob2xsYUBhcm0uY29tPjsN
Cj4gY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IG1hcmsucnV0bGFuZEBhcm0uY29tOyBsaW51eC1h
cm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC0NCj4gdGVncmFAdmdlci5rZXJuZWwub3JnOyB0aGFudS5yYW5nYXJhamFu
QGFybS5jb207DQo+IE1pY2hhZWwuV2lsbGlhbXNAYXJtLmNvbTsgVGhpZXJyeSBSZWRpbmcgPHRy
ZWRpbmdAbnZpZGlhLmNvbT47IEpvbmF0aGFuDQo+IEh1bnRlciA8am9uYXRoYW5oQG52aWRpYS5j
b20+OyBWaWtyYW0gU2V0aGkgPHZzZXRoaUBudmlkaWEuY29tPjsNCj4gTWF0aGlldSBQb2lyaWVy
IDxtYXRoaWV1LnBvaXJpZXJAbGluYXJvLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwLzJd
IHBlcmY6IEFSTSBDb3JlU2lnaHQgUE1VIHN1cHBvcnQNCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBV
c2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gT24gVHVl
LCBNYXkgMTAsIDIwMjIgYXQgMTI6MTM6MTlQTSArMDEwMCwgV2lsbCBEZWFjb24gd3JvdGU6DQo+
ID4gT24gVHVlLCBNYXkgMTAsIDIwMjIgYXQgMTI6MDc6NDJQTSArMDEwMCwgU3VkZWVwIEhvbGxh
IHdyb3RlOg0KPiA+ID4gT24gTW9uLCBNYXkgMDksIDIwMjIgYXQgMTE6MDI6MjNBTSArMDEwMCwg
U3V6dWtpIEsgUG91bG9zZSB3cm90ZToNCj4gPiA+ID4gQ2M6IE1pa2UgV2lsbGlhbXMsIE1hdGhp
ZXUgUG9pcmllcg0KPiA+ID4gPiBPbiAwOS8wNS8yMDIyIDEwOjI4LCBXaWxsIERlYWNvbiB3cm90
ZToNCj4gPiA+ID4gPiBPbiBTdW4sIE1heSAwOCwgMjAyMiBhdCAwNzoyODowOFBNIC0wNTAwLCBC
ZXNhciBXaWNha3Nvbm8gd3JvdGU6DQo+ID4gPiA+ID4gPiAgIGFyY2gvYXJtNjQvY29uZmlncy9k
ZWZjb25maWcgICAgICAgICAgICAgICAgICB8ICAgIDEgKw0KPiA+ID4gPiA+ID4gICBkcml2ZXJz
L3BlcmYvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAyICsNCj4gPiA+ID4g
PiA+ICAgZHJpdmVycy9wZXJmL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAg
MSArDQo+ID4gPiA+ID4gPiAgIGRyaXZlcnMvcGVyZi9jb3Jlc2lnaHRfcG11L0tjb25maWcgICAg
ICAgICAgICB8ICAgMTAgKw0KPiA+ID4gPiA+ID4gICBkcml2ZXJzL3BlcmYvY29yZXNpZ2h0X3Bt
dS9NYWtlZmlsZSAgICAgICAgICAgfCAgICA3ICsNCj4gPiA+ID4gPiA+ICAgLi4uL3BlcmYvY29y
ZXNpZ2h0X3BtdS9hcm1fY29yZXNpZ2h0X3BtdS5jICAgIHwgMTMxNw0KPiArKysrKysrKysrKysr
KysrKw0KPiA+ID4gPiA+ID4gICAuLi4vcGVyZi9jb3Jlc2lnaHRfcG11L2FybV9jb3Jlc2lnaHRf
cG11LmggICAgfCAgMTQ3ICsrDQo+ID4gPiA+ID4gPiAgIC4uLi9jb3Jlc2lnaHRfcG11L2FybV9j
b3Jlc2lnaHRfcG11X252aWRpYS5jICB8ICAzMDAgKysrKw0KPiA+ID4gPiA+ID4gICAuLi4vY29y
ZXNpZ2h0X3BtdS9hcm1fY29yZXNpZ2h0X3BtdV9udmlkaWEuaCAgfCAgIDE3ICsNCj4gPiA+ID4g
PiA+ICAgOSBmaWxlcyBjaGFuZ2VkLCAxODAyIGluc2VydGlvbnMoKykNCj4gPiA+ID4gPg0KPiA+
ID4gPiA+IEhvdyBkb2VzIHRoaXMgaW50ZXJhY3Qgd2l0aCBhbGwgdGhlIHN0dWZmIHdlIGhhdmUg
dW5kZXINCj4gPiA+ID4gPiBkcml2ZXJzL2h3dHJhY2luZy9jb3Jlc2lnaHQvPw0KPiA+ID4gPg0K
PiA+ID4gPiBBYnNvbHV0ZWx5IHplcm8sIGV4Y2VwdCBmb3IgdGhlIG5hbWUuIFRoZSBzdGFuZGFy
ZA0KPiA+ID4gPiBpcyBuYW1lZCAiQ29yZVNpZ2h0IFBNVSIgd2hpY2ggaXMgYSBiaXQgdW5mb3J0
dW5hdGUsDQo+ID4gPiA+IGdpdmVuIHRoZSBvbmx5IGxpbmssIEFGQUlVLCB3aXRoIHRoZSAiQ29y
ZVNpZ2h0IiBhcmNoaXRlY3R1cmUNCj4gPiA+ID4gaXMgdGhlIExvY2sgQWNjZXNzIFJlZ2lzdGVy
KExBUikuIEZvciByZWZlcmVuY2UsIHRoZQ0KPiA+ID4gPiBkcml2ZXJzL2h3dHJhY2luZy9jb3Jl
c2lnaHQvIGlzIHB1cmVseSAiQ29yZVNpZ2h0IiBzZWxmLWhvc3RlZA0KPiA+ID4gPiB0cmFjaW5n
IGFuZCB0aGUgUE1VIGlzIGNhbGxlZCAiY3NfZXRtIiAoZXhwYW5kcyB0byBjb3Jlc2lnaHQgZXRt
KS4NCj4gPiA+ID4gT3RoZXJ3aXNlIHRoZSBzdGFuZGFyZCBkb2Vzbid0IGhhdmUgYW55dGhpbmcg
dG8gZG8gd2l0aCB3aGF0DQo+ID4gPiA+IGV4aXN0cyBhbHJlYWR5IGluIHRoZSBrZXJuZWwuDQo+
ID4NCj4gPiBUaGF0J3MuLi4gYSBwb29yIG5hbWluZyBjaG9pY2UhIEJ1dCBnb29kLCBpZiBpdCdz
IGVudGlyZWx5IHNlcGFyYXRlIHRoZW4gSQ0KPiA+IGRvbid0IGhhdmUgdG8gd29ycnkgYWJvdXQg
dGhhdC4gSnVzdCB3YW50ZWQgdG8gbWFrZSBzdXJlIHdlJ3JlIG5vdCBnb2luZw0KPiB0bw0KPiA+
IGdldCB0YW5nbGVkIHVwIGluIHRoaW5ncyBsaWtlIFJPTSB0YWJsZXMgYW5kIENvcmVzaWdodCBw
b3dlciBkb21haW5zIGZvcg0KPiA+IHRoZXNlIHRoaW5ncy4NCj4gPg0KPiANCj4gT0ssIG5vdyB0
aGF0IHRyaWdnZXJlZCBhbm90aGVyIHF1ZXN0aW9uL3Rob3VnaHQuDQo+IA0KPiAxLiBEbyB5b3Ug
bmVlZCB0byBkbyBhY3RpdmUgcG93ZXIgbWFuYWdlbWVudCBmb3IgdGhlc2UgUE1VcyA/IE9yIGxp
a2UNCj4gICAgQ1BVIFBNVXMsIGRvIHlvdSByZWplY3QgZW50ZXJpbmcgbG93IHBvd2VyIHN0YXRl
cyBpZiB0aGVyZSBpcyBhY3RpdmUNCj4gICAgc2Vzc2lvbiBpbiBwcm9ncmVzcy4gSWYgdGhlcmUg
aXMgYWN0aXZlIHNlc3Npb24sIHJ1bnRpbWUgUE0gd29uJ3QgZ2V0DQo+ICAgIHRyaWdnZXJlZCBi
dXQgaWYgdGhlcmUgaXMgc3lzdGVtIHdpZGUgc3VzcGVuZCwgaG93IGlzIHRoYXQgZGVhbHQgd2l0
aCA/DQo+IA0KDQpMb29raW5nIGF0IHRoZSBvdGhlciB1bmNvcmUvc3lzdGVtIFBNVXMsIG5vbmUg
b2YgdGhlIGRyaXZlcnMgc3VwcG9ydCBQTSBvcHMuDQpOVklESUEgc3lzdGVtIFBNVSBhbHNvIGRv
ZXMgbm90IGdldCBwb3dlciBnYXRlZCBhbmQgc3lzdGVtIHN1c3BlbmQgaXMgbm90DQpzdXBwb3J0
ZWQuIEJ1dCBqdXN0IGxpa2Ugb3RoZXIgdW5jb3JlIFBNVSBkcml2ZXIsIHRoaXMgZHJpdmVyIHN1
cHBvcnRzIENQVSBob3RwbHVnLg0KSWYgUE0gaXMgbmVlZGVkLCB0aGUgcmVxdWlyZWQgaW5mbyBz
aG91bGQgaGF2ZSBiZWVuIGV4cHJlc3NlZCBpbiBBQ1BJLg0KDQo+IDIuIEFzc3VtaW5nIHlvdSBu
ZWVkIHNvbWUgc29ydCBvZiBQTSwgYW5kIHNpbmNlIHRoaXMgaXMgc3RhdGljIHRhYmxlKHdoaWNo
DQo+ICAgIEkgcmVhbGx5IGRvbid0IGxpa2UvcHJlZmVyIGJ1dCBpdCBpcyBvdXQgdGhlcmUg8J+Z
gSksIGhvdyBkbyB5b3UgcGxhbiB0bw0KPiAgICBnZXQgdGhlIHBvd2VyIGRvbWFpbiByZWxhdGVk
IGluZm9ybWF0aW9uLg0KPiANCg0KSSBndWVzcyB0aGUgQVBNVCBzcGVjIGluIHNlY3Rpb24gMi4y
IG1heSBjb3ZlciB0aGlzLiBJZiBhIFBNVSBpbXBsZW1lbnRhdGlvbiBoYXMNCnByb3BlcnRpZXMg
YmV5b25kIHdoYXQgaXMgZGVmaW5lZCBpbiB0aGUgc3BlYywgdGhlc2UgcHJvcGVydGllcyBjYW4g
YmUgZGVzY3JpYmVkIGluIERTRFQuDQpUaGUgZHJpdmVyIGRvZXNu4oCZdCB0YWtlIGNhcmUgb2Yg
dGhpcyBjdXJyZW50bHksIHNvIHRoaXMgaXMgYSByb29tIGZvciBmdXR1cmUgaW1wcm92ZW1lbnQu
DQoNClJlZ2FyZHMsDQpCZXNhcg0KDQo+IC0tDQo+IFJlZ2FyZHMsDQo+IFN1ZGVlcA0K
