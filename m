Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481F1574402
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 06:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbiGNE6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 00:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbiGNE6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 00:58:09 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862E127CD9;
        Wed, 13 Jul 2022 21:47:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maUBB7hLh1PFgTlFsjiakX+Up+Oh4A2uHDWlolbuUhBSeonc8GdB1MJRKjGhCSe6cZEmZrbjDHYwJ4GkSpnEbPAX1VfQ0omY9K1qlthFu6pqcNgSx8b5Vk4DlKleSi3Xwubnd3Zi9GEjFhE0D+eV7GUOH/Fm7jUhcscH9UMLRAxf3B1R9U9AzrOYSjIDcIoQbTJ55IKyI67jj7k/UTeUtfg8ZrVly70L+t1+uoUjGpRZbkoNt59i645NkKnr15aaXbCNVmu8XAhPXlAQdE5fOztcvKhHxfsiq+3Vd+fcuiVdoNy1J5xVCISaDGtsIeTBXBfrduOBNOB6lYz9RyYpKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPDHW+lbyg0MjR6Xs3YIGYfQVRQCbiYBlpxCR6QMTrs=;
 b=oeoCrvPPfI8ZhMZemY0ZvjJv3Re4lYVf/Q2CDxTLVI3AizT/e00CN2MbPxJiPDDcWyFI1c/I5PWMrRyymyVfsuK7/bd2Sp1MWvxdhBnAnP/qJ6S/XHDjAPvThfvycbvZlVNPjkNbfw75gwo72ZmhKX1OaK5+jPy7AuvoKqOyB35l6k8PKX4GjeuL1c1r6An+FEVLyPH5hLMyDuEqnXlgxjHXaWp73PDdkRwFuTTSx1Px5qfw+DmUF/yeniRKHuhPBTSqP7UmyJGF/6Wlw61yv4CvDvtstkNmc4b5g+xtRz4IDtL45P+WbwjzZMthlWOASIB7WbfKLpCMoISLcpSQfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPDHW+lbyg0MjR6Xs3YIGYfQVRQCbiYBlpxCR6QMTrs=;
 b=bqEUVBkczSTq1KcOghWIhm6sqTnrfV9tdB5iBUOw+rFD3wfcrp6JM/DL2bGjncfOmYA8rvt2ta2zTeCB4kqeOJuxr0ZGvjfbL/ml4HXPXn/jOsQiCLAg+zrKoiXliiXeAFn8U4wuW3b6QOFy+8t0HZPTzyHMAnHdQHkpSRv0GG0UrQECJ11wsH+tKclCI7pWFoZ3GQGOzG9S01BqeAAydClO34fcFWTIjayMPoyAICmioLeYqXutKcJ79uxsKioeXXQGlJhbfDCtaLpl1aNs+qI5PDM1yXh46Oq6+oChA3D1hq148Qb68FdTqFk4lonbYwV4djqCZK+bIi5OHKBnjw==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 14 Jul
 2022 04:47:27 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::6cdd:89c7:38f5:35b3]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::6cdd:89c7:38f5:35b3%8]) with mapi id 15.20.5417.025; Thu, 14 Jul 2022
 04:47:26 +0000
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "thanu.rangarajan@arm.com" <thanu.rangarajan@arm.com>,
        "Michael.Williams@arm.com" <Michael.Williams@arm.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>
Subject: RE: [RESEND PATCH v3 1/2] perf: coresight_pmu: Add support for ARM
 CoreSight PMU driver
Thread-Topic: [RESEND PATCH v3 1/2] perf: coresight_pmu: Add support for ARM
 CoreSight PMU driver
Thread-Index: AQHYhTLreZhiUX+onkijjgrrTcbLR61y2R2AgAGFGbCABrKBAIAAPJAAgAIbXzA=
Date:   Thu, 14 Jul 2022 04:47:26 +0000
Message-ID: <SJ0PR12MB567612C18D20A0C0243F0D23A0889@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20220621055035.31766-1-bwicaksono@nvidia.com>
 <20220621055035.31766-2-bwicaksono@nvidia.com>
 <73dafe08-d1f1-90b6-995e-7d38e9e1dce7@arm.com>
 <SJ0PR12MB567600F730B47F3A1007775AA0829@SJ0PR12MB5676.namprd12.prod.outlook.com>
 <20220712163638.GA2945984@p14s>
 <632f5c80-2be3-ace5-6b0d-ee0c9e5560ff@arm.com>
In-Reply-To: <632f5c80-2be3-ace5-6b0d-ee0c9e5560ff@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0449056-bbbd-4bbc-db15-08da6553f380
x-ms-traffictypediagnostic: MN2PR12MB4470:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VSqBOtP2qqsQuA4FPVCXuNvvM6Vm1lu1KRc3/6GfVBrFp1ZVnI9Fn2n2gT2WwlQN6iHUTB9iXWPp92CxA+sBVm90dRLnez8EawThv/iYbRJ7UNvMPIrg55mbF2UeIpDtCaJ3spAZhV3kIS1RxQ352U3bnGozJUXFu3kLxtkYYu9kN3Imialf1D1WidHpzcfm5JMmi7PiOhFJY6qdjU/H5lYUdUAkLjp+JeGIMw2gQQtZGhNuQePMnntAXLA4FRTiT2hNzB3EbuSgluve325WvQOMkLzFUtDFEXjJsB72ARzwpjK5XI+CPcuZY+0/MCIzOlfZmgv23hTB/M+el3ljPq/uP+TKF35MaSkPmHh+VTLL3t1SfC/AEP+7rQZ46qIWfnVgH+5lhC+YUwQQ9A7JE+yQ14btgOlsPvfDq75qDKWonYrBT3WKWqPUOIBGpMsMgToRvieTO/du1tLMdnOhlJVWQtrRtBAICHmqLgQdZO1sUfuZKPlcLkvgRgjrMuwD4dTRv1GxHwx3lj3KNMHW6FU7huV1mM+AXNh/DhNTzfnZTVNb9JK7ZVvE1hTAlkGTN4HIJ78fcrj5i9UAvvsUZVw21xlXOvp1Sh97RcMX4vcx3v42z3IFE0V8+lU+h3g1ivFm4F9VnWFcprcaPnaOPoO30Yc78l4xF3WcyhSwPqR7UTF8fbkjG4GXRQku0ZQQInVeyjQeF6kvm06+HPWoRRRh45izqdDYTuEs4qy0Wcv2WnXExvIZD/XezOCOGhToE5nUAfAkXF1u2hRItIGffJk8lPNr7AQ2NCoFYS6N0hlpcDpsgHnBu5xNk7CGkFEVc6ikciHOklanjATt0UfcwCDkCYQCtWVDRUnkKv9AkWSLmKoHW8w1cdahI30uv6ljo4hxGJgTGQEjRevoNBbB/wB+dLgVQtCHeZ1qRXfHaRhagXAXb569vGNW5C5rceCQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(478600001)(110136005)(6506007)(966005)(7696005)(33656002)(76116006)(38070700005)(2906002)(26005)(9686003)(316002)(55016003)(186003)(54906003)(53546011)(71200400001)(4326008)(64756008)(5660300002)(52536014)(38100700002)(66946007)(86362001)(41300700001)(66556008)(83380400001)(7416002)(66446008)(122000001)(8936002)(66476007)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OU05aTZWNmdVWDlwZWlHNVplQlF6SDg3MDdobENiMXNLTEpVVFFib0JGc1Bn?=
 =?utf-8?B?WFBUSVpZUjJCNmNNT2U2UkF2c3BKdzltTy8rdGtOSGJoWkgrSWFWQWg1bDFW?=
 =?utf-8?B?WHRxcGxkQ1M5OC9XMEE5U2ZITzRCc1hPSXZHcWI5NERnNVBBT1h4VmdqMFhq?=
 =?utf-8?B?TVFOdmFSdWNQaStnTlpxVWFMTnN2MW9WdGpzT1F2OEZmd2xPVVRVUjlvS3Nu?=
 =?utf-8?B?dGdDRWF6RzJ1YXJ2VWxmUFNsdUc2R0NLSE95YVpsZmxVaEI0WFp1ekdocU04?=
 =?utf-8?B?bUxQUHh4MnJDUWJXMmRTR21JdEpxNlBpTUJyN0Rqd1NsTEJjeUpYMXl4N21u?=
 =?utf-8?B?aXZ2dEhWc1Jja1ltVXpzSCtyaDBKeFNmVklOalpMdEVyT3RHc3BCWDJaUVlt?=
 =?utf-8?B?bndwVDVZQklGWFFQbkRVNGROQmdIbzNmUVhLRnJqVVRKL3FWSENBMDEyZVdB?=
 =?utf-8?B?WklpNm5YNlpqcmJBcUw4TDg3QVBvVVFMRzFXejhTa3dJSUU5cmdhZXdFL1A4?=
 =?utf-8?B?NVJUcngranUzd04zUkR4RzRxdTgvOFp0aDJ4cVpLK2VnSkExVHJET2RwUDlU?=
 =?utf-8?B?TGRZRUZzWUFtTHByeFNUVnpOSnJmMnA1U3pHa3hEUFNDeFZ6NFI2RVA1WGx3?=
 =?utf-8?B?VVlLZWp5bXE2SDJ0Rmk3YVBGdmVFdVJBTnQrK0NjaHFEb1BlcW12OXJEc2Zi?=
 =?utf-8?B?Ynp6R2Q1VXZaSTFBak9LUEtiSnBHNVVZdUtjVlFNWEF0V09XUlhTR0RzSURp?=
 =?utf-8?B?S244Y1JmaXF4bk01bG1pTkZoNE0vWnZ6UjdLMlRrVjNuRlB2Y1BhZnA0MFFl?=
 =?utf-8?B?eHpZd2Z5cjZMQ0tCdCt2dHRlODRPZFYxL29qRHhXMXZ3VGtRRW9ibkYzc0xj?=
 =?utf-8?B?blduWStsS1RBYzl2bjczSG5IK1U0cklZLzVMbWFxcDIya2J4YWRqdHBlRUQv?=
 =?utf-8?B?N1c5RUpXMkZUbEVaWm9La1NPQ3d3cWVXdkswbFVqS0ZlUE1uTlEyVThMNCt0?=
 =?utf-8?B?TU5QRk9PQ21qVkszM3JLR05NUkVCQll0MkJEaER5Znp1VlVlVEpCTlZBdVVI?=
 =?utf-8?B?M1lqSGZkUGcxK1V1cVVoR0ZDUE9CTlJ2RWswNVJ0TGUvZE1vMXB3UWNBUVU5?=
 =?utf-8?B?YjdVWjdWaDM1elFIUGErbjFBSVkxeFdEMmVWYlhsTTBLaUpHeTR3ZmhwU3Mw?=
 =?utf-8?B?V3NJQUk0bHBiVjlLL3BuQjFhWDNXVFJFaWlRdXd3Q2FTcE5rZkp5OFJ0UGJX?=
 =?utf-8?B?ZGRLUk92dVIySnJNWHlldHhmM2E2OFdhVUgxOEVBWVNhU1oxNkxWeFZGcVZt?=
 =?utf-8?B?QjNDVlhZdHltNmdvQXlwNERyTWIxLzBjVUppYjJqczdmOGRWN3VnS0VZV3Vn?=
 =?utf-8?B?NTg1QVRUWWJ6WmtLS2xnU2VmWUFOVEN4MVRMZGt3clcwMENwdmRpUE5Wam5y?=
 =?utf-8?B?TnVCZEMvMnliTktad1dNN0R6YjRHS2ZIcW5MT0krUlh2d3dFcHE5Y1laSkdw?=
 =?utf-8?B?UDF3K3V1dS90cGVYZ0RManZqZ0FDTjIxeWJ5Z3BqcndsclpOTy9vQ05QNlNz?=
 =?utf-8?B?MFhjYUZ2UEYzUU52cTBhOHhUK3dqdHZCWjJLMUpneEx6aHRGTGtWNDZSeHZo?=
 =?utf-8?B?Wi9lYUtvYVRaam5KdW1IVTVMcTNsenJSZXpmMVhQZnpwclk0UXFxMVV4UGFF?=
 =?utf-8?B?a3F0WllmSktORzFHaHEycGNpZ0IzRUU0WFlJeTljanA1MkxSakhOZ0E3dHUy?=
 =?utf-8?B?RlBuZE1xSzRUTFpxV2VUVmNrT2dBd3BrUklZdjNSVDEwMVRtaXlqVko5VXVF?=
 =?utf-8?B?d1BSMTBHRDVPRUlPQzdRWHA1bzlBWW44cWY5RDI2dzdQUVJNaGhSVkF6cjc4?=
 =?utf-8?B?a1E0VFR5d0ZzNitBSDYvcS9rQ0lvam1zeFZPQnAweDRkM3VWMjFlZDIyMVJ0?=
 =?utf-8?B?ZHFJU2tTOGZmY1pyK3loVjR6NlRmZmh4ck52MGQvT0NzbnZWZ3IrcjZPOGha?=
 =?utf-8?B?cVV6aDJMcVIveTd6cU5tSUhOcTR6MTdWY0RrYTR1R3RTMlZUZERpOWZYNWtE?=
 =?utf-8?B?ZklxK3pEQ0NxZ2RpbnN1S0cweWYvNG5aUG5HbXF1SmNGZkduUlhnb3FHbnNS?=
 =?utf-8?Q?XpKQAsfFmXrFQajnnNXLYmdqS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0449056-bbbd-4bbc-db15-08da6553f380
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 04:47:26.8033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0eZMzF23GMiPniH5m8yEhqh2sHZIU4JGdzLqTWqFPitzsRLumKPoa0bQ6NCAhSA8iYmKcd0RXUQ6mRZURnbShg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4gTXVycGh5IDxy
b2Jpbi5tdXJwaHlAYXJtLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDEzLCAyMDIyIDM6
MTMgQU0NCj4gVG86IE1hdGhpZXUgUG9pcmllciA8bWF0aGlldS5wb2lyaWVyQGxpbmFyby5vcmc+
OyBCZXNhciBXaWNha3Nvbm8NCj4gPGJ3aWNha3Nvbm9AbnZpZGlhLmNvbT4NCj4gQ2M6IFN1enVr
aSBLIFBvdWxvc2UgPHN1enVraS5wb3Vsb3NlQGFybS5jb20+OyBjYXRhbGluLm1hcmluYXNAYXJt
LmNvbTsNCj4gd2lsbEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgbGludXgtYXJt
LQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtDQo+IHRlZ3JhQHZnZXIua2VybmVsLm9yZzsgc3VkZWVwLmhvbGxhQGFybS5j
b207DQo+IHRoYW51LnJhbmdhcmFqYW5AYXJtLmNvbTsgTWljaGFlbC5XaWxsaWFtc0Bhcm0uY29t
OyBUaGllcnJ5IFJlZGluZw0KPiA8dHJlZGluZ0BudmlkaWEuY29tPjsgSm9uYXRoYW4gSHVudGVy
IDxqb25hdGhhbmhAbnZpZGlhLmNvbT47IFZpa3JhbQ0KPiBTZXRoaSA8dnNldGhpQG52aWRpYS5j
b20+OyBtaWtlLmxlYWNoQGxpbmFyby5vcmc7IGxlby55YW5AbGluYXJvLm9yZw0KPiBTdWJqZWN0
OiBSZTogW1JFU0VORCBQQVRDSCB2MyAxLzJdIHBlcmY6IGNvcmVzaWdodF9wbXU6IEFkZCBzdXBw
b3J0IGZvcg0KPiBBUk0gQ29yZVNpZ2h0IFBNVSBkcml2ZXINCj4gDQo+IEV4dGVybmFsIGVtYWls
OiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gT24g
MjAyMi0wNy0xMiAxNzozNiwgTWF0aGlldSBQb2lyaWVyIHdyb3RlOg0KPiBbLi4uXQ0KPiA+Pj4g
SWYgd2UgaGF2ZSBkZWNpZWQgdG8gY2FsbCB0aGlzIGFybV9zeXN0ZW1fcG11LCAod2hpY2ggSSBh
bSBwZXJmZWN0bHkNCj4gPj4+IGhhcHB5IHdpdGgpLCBjb3VsZCB3ZSBwbGVhc2Ugc3RpY2sgdG8g
dGhhdCBuYW1lIGZvciBmdW5jdGlvbnMgdGhhdCB3ZQ0KPiA+Pj4gZXhwb3J0ID8NCj4gPj4+DQo+
ID4+PiBlLmcsDQo+ID4+Pg0KPiBzL2NvcmVzaWdodF9wbXVfc3lzZnNfZXZlbnRfc2hvdy9hcm1f
c3lzdGVtX3BtdV9ldmVudF9zaG93KCkvDQo+ID4+Pg0KPiA+Pg0KPiA+PiBKdXN0IHdhbnQgdG8g
Y29uZmlybSwgaXMgaXQganVzdCB0aGUgcHVibGljIGZ1bmN0aW9ucyBvciBkbyB3ZSBuZWVkIHRv
DQo+IHJlcGxhY2UNCj4gPj4gYWxsIHRoYXQgaGFzICJjb3Jlc2lnaHQiIG5hbWluZyA/IEluY2x1
ZGluZyB0aGUgc3RhdGljIGZ1bmN0aW9ucywgc3RydWN0cywNCj4gZmlsZW5hbWUuDQo+ID4NCj4g
PiBJIHRoaW5rIGFsbCByZWZlcmVuY2VzIHRvICJjb3Jlc2lnaHQiIHNob3VsZCBiZSBjaGFuZ2Vk
IHRvDQo+ICJhcm1fc3lzdGVtX3BtdSIsDQo+ID4gaW5jbHVkaW5nIGZpbGVuYW1lcy4gIFRoYXQg
d2F5IHRoZXJlIGlzIG5vIGRvdWJ0IHRoaXMgSVAgYmxvY2sgaXMgbm90DQo+ID4gcmVsYXRlZCwg
YW5kIGRvZXMgbm90IGludGVyb3BlcmF0ZSwgd2l0aCB0aGUgYW55IG9mIHRoZSAiY29yZXNpZ2h0
IiBJUA0KPiBibG9ja3MNCj4gPiBhbHJlYWR5IHN1cHBvcnRlZFsxXSBpbiB0aGUga2VybmVsLg0K
PiA+DQo+ID4gSSBoYXZlIGxvb2tlZCBhdCB0aGUgZG9jdW1lbnRhdGlvblsyXSBpbiB0aGUgY292
ZXIgbGV0dGVyIGFuZCBJIGFncmVlDQo+ID4gd2l0aCBhbiBlYXJsaWVyIGNvbW1lbnQgZnJvbSBT
dWRlZXAgdGhhdCB0aGlzIElQIGhhcyB2ZXJ5IGxpdHRsZSB0byBkbyB3aXRoDQo+IGFueQ0KPiA+
IG9mIHRoZSBvdGhlciBDb3JlU2lnaHQgSVAgYmxvY2tzIGZvdW5kIGluIHRoZSBDb3JlU2lnaHQg
ZnJhbWV3b3JrWzFdLg0KPiBVc2luZyB0aGUNCj4gPiAiY29yZXNpZ2h0IiBuYW1pbmcgY29udmVu
dGlvbiBpbiB0aGlzIGRyaXZlciB3b3VsZCBiZSBfZXh0cmVtZWx5Xw0KPiBjb25mdXNpbmcsDQo+
ID4gZXNwZWNpYWxseSB3aGVuIGl0IGNvbWVzIHRvIGV4cG9ydGVkIGZ1bmN0aW9ucy4NCj4gDQo+
IEJ1dCBjb252ZXJzZWx5LCBob3cgaXMgaXQgbm90IGNvbmZ1c2luZyB0byBtYWtlIHVwIGNvbXBs
ZXRlbHkgZGlmZmVyZW50DQo+IG5hbWVzIGZvciB0aGluZ3MgdGhhbiB3aGF0IHRoZXkncmUgYWN0
dWFsbHkgY2FsbGVkPyBUaGUgQ29yZVNpZ2h0DQo+IFBlcmZvcm1hbmNlIE1vbml0b3JpbmcgVW5p
dCBpcyBhIHBhcnQgb2YgdGhlIEFybSBDb3JlU2lnaHQgYXJjaGl0ZWN0dXJlLA0KPiBpdCBzYXlz
IGl0IHJpZ2h0IHRoZXJlIG9uIHBhZ2UgMS4gV2hhdCBpZiBJIGluc3RpbmN0aXZlbHkgYXNzb2Np
YXRlIHRoZQ0KPiBuYW1lIE1hdGhpZXUgd2l0aCBzb21lb25lIG1vcmUgZmFtaWxpYXIgdG8gbWUs
IHNvIHRvIGF2b2lkIGNvbmZ1c2lvbiBJJ2QNCj4gcHJlZmVyIHRvIGNhbGwgeW91IFN0ZXZlPyBJ
cyB0aGF0IE9LPw0KPiANCg0KV2hhdCBpcyB0aGUgbmFtaW5nIGNvbnZlbnRpb24gZm9yIG1vZHVs
ZXMgdW5kZXIgZHJpdmVycy9wZXJmID8NCkluIG15IG9ic2VydmF0aW9uLCB0aGUgbmFtZXMgdGhl
cmUgY29ycmVzcG9uZCB0byB0aGUgcGFydCBtb25pdG9yZWQgYnkNCnRoZSBQTVUuIFRoZSBjb25m
dXNpb24gb24gdXNpbmcgImNvcmVzaWdodF9wbXUiIG5hbWluZyBjb3VsZCBiZSB0aGF0DQpwZW9w
bGUgbWF5IHRoaW5rIHRoZSBQTVUgbW9uaXRvcnMgY29yZXNpZ2h0IHN5c3RlbSwgaS5lIHRoZSB0
cmFjZSBzeXN0ZW0gdW5kZXIgaHd0cmFjaW5nLg0KSG93ZXZlciwgdGhlIGRyaXZlciBpbiB0aGlz
IHBhdGNoIGlzIGZvciBhIG5ldyBQTVUgc3RhbmRhcmQgdGhhdCBtb25pdG9ycyB1bmNvcmUNCnBh
cnRzLiBVbmNvcmUgd2FzIGNvbnNpZGVyZWQgYXMgdGVybWlub2xvZ3kgZnJvbSBJbnRlbCwgc28g
InN5c3RlbSIgd2FzIHBpY2tlZCBpbnN0ZWFkLg0KUGxlYXNlIHNlZSB0aGlzIHRocmVhZCBmb3Ig
cmVmZXJlbmNlOg0KICBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1hcm0ta2VybmVsLzIw
MjIwNTEwMTExMzE4LkdEMjc1NTdAd2lsbGllLXRoZS10cnVjay8NCg0KPiBBcyBpdCBoYXBwZW5z
LCBTdGV2ZSwgSSBkbyBhY3R1YWxseSBhZ3JlZSB3aXRoIHlvdSB0aGF0ICJjb3Jlc2lnaHRfIiBp
cw0KPiBhIGJhZCBwcmVmaXggaGVyZSwgYnV0IG9ubHkgZm9yIHRoZSByZWFzb24gdGhhdCBpdCdz
IHRvbyBnZW5lcmFsLiBUQkggSQ0KPiB0aGluayB0aGF0J3MgdHJ1ZSBvZiB0aGUgZXhpc3Rpbmcg
TGludXggc3Vic3lzdGVtIHRvbywgYnV0IHRoYXQgZGFtYWdlDQo+IGlzIGFscmVhZHkgZG9uZSwg
YW5kIEknZCBjb25jdXIgdGhhdCB0aGVyZSdzIGxpdHRsZSB2YWx1ZSBpbiB0cnlpbmcgdG8NCj4g
dW5waWNrIHRoYXQgbm93LCBkZXNwaXRlIHRoZSBjbGVhciBleGlzdGVuY2Ugb2YgcHJvZHVjdHMg
bGlrZSBDb3JlU2lnaHQNCj4gREFQIGFuZCBDb3JlU2lnaHQgRUxBIHdoaWNoIGRvbid0IGhhdmUg
YWxsIHRoYXQgbXVjaCB0byBkbyB3aXRoIHByb2dyYW0NCj4gdHJhY2UgZWl0aGVyLg0KPiANCj4g
SG93ZXZlciwgaGluZHNpZ2h0IGFuZCBpbmVydGlhIGFyZSBoYXJkbHkgZ29vZCByZWFzb25zIHRv
IGRvdWJsZSBkb3duIG9uDQo+IHBvb3IgZGVjaXNpb25zLCBzbyBpZiBJIHdhcyBnb2luZyB0byB2
b3RlIGZvciBhbnl0aGluZyBoZXJlIGl0IHdvdWxkIGJlDQo+ICJjc3BtdV8iLCB3aGljaCBpcyBh
Ym91dCBhcw0KPiBvYnZpb3VzbHktcmVsYXRlZC10by10aGUtdGhpbmctaXQtYWN0dWFsbHktaXMg
YXMgd2UgY2FuIGdldCB3aGlsZSBhbHNvDQo+IGJlaW5nIHBsZWFzYW50bHkgY29uY2lzZS4NCj4g
DQo+IFsgQW5kIG5vLCB0aGlzIGlzbid0IGJpa2VzaGVkZGluZy4gTmFtaW5nIHRoaW5ncyByaWdo
dCBpcyAqaW1wb3J0YW50KiBdDQo+IA0KDQpJIGFncmVlIGhhdmluZyB0aGUgY29ycmVjdCBuYW1l
IGlzIGltcG9ydGFudCwgZXNwZWNpYWxseSBhdCB0aGlzIGVhcmx5IHN0YWdlLg0KQSBkaXJlY3Rp
b24gb2Ygd2hhdCB0aGUgbmFtaW5nIHNob3VsZCBkZXNjcmliZSB3b3VsZCBiZSB2ZXJ5IGhlbHBm
dWwgaGVyZS4NCg0KPiBDaGVlcnMsDQo+IFJvYmluLg0KPiANCj4gPg0KPiA+IFRoYW5rcywNCj4g
PiBTdGV2ZQ0KPiA+DQo+ID4gWzFdLiBkcml2ZXJzL2h3dHJhY2luZy9jb3Jlc2lnaHQvDQo+ID4g
WzJdLiBodHRwczovL2RldmVsb3Blci5hcm0uY29tL2RvY3VtZW50YXRpb24vaWhpMDA5MS9sYXRl
c3QNCg==
