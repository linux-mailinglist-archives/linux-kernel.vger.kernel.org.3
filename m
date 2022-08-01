Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CF05873ED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 00:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbiHAW1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 18:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbiHAW10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 18:27:26 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222C64504A;
        Mon,  1 Aug 2022 15:27:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJ6aVi76x7GdXr2LpkZfdKM1c4eXZFA9H7aInNBXUBykj40XV3iS33A3YqSfEkRcEAG37D5FhVbtD7u4wqdBUmk/udy//XdSvfmLKIu1g7x+L35vXiHqdxQbDYz57bQbQZfH13nEvPVgRoRqySbzLFmAQmGcJQoMmDnxp9wLOtuHv68ONItu12s+8KhxMRgCLRf0PtE++upGeivSi9NBelvvhelSC8JIBIKkbTGJ0v5ioXh6kpC/6F41Cw9KBIMibfJRAHJC47+G/ldoE328PdGusF9fH7IT0fByoCR1TECq15vBuPNGUgWub8iIopA3JM2MMYbgTJq0dxVIKytkaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMUrrH/rLb1K2yjwMGgkgrxX20cndF13RGPFUKwd2Tg=;
 b=Pw4miuQLiZ5kNeLkvvy9M9JBLAp+lWyB8pXFYr+kIVnyFeWLS07bm8yfCGwwQlD2mDhEmOQidRokE7UzO2ws+MbRIvBryxWFIaXSaUbB1a0+MOUfOKpWKnBz/QnnuR+2W4Qqq6r6Xlyklh6ODisfY9Mqjtmx7Xj6tCv6pg6yf127nZjtzXSMKsyhmXfP+hEMrPEHKPvJvrVZ7TOo1n0+l7LjMgC/EDKLyssSLQ/sS9PhXJ6LMWzGo1zzUVsj4EkCCsi30ngfs+bRoFrz/qFEId11Pc1RJCtg75/qNC+GpKRoNbWmoHDyUevmRExJt1WkbPakFFiGIwlqu37evwfvmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMUrrH/rLb1K2yjwMGgkgrxX20cndF13RGPFUKwd2Tg=;
 b=MDGNwjV4v/lRs+Glo/PAyOnECsp795hLhPHMSrnd0DG65to9HRiTWW9ijOZm56EAkaMvsqOngGKBJq6eFnoJINw/odpzpzNArN9FlWkh8xeD7Gf0ZyNcXgfy0oQ9a7Xv2ma19NxMr8dgOO2oyCysY/CyIdveN4Zph/D36LTtZfLStPTVdovWhnidk36trtIWVKGeLrYPafbTF39/I7SQsu63+NaTqH8BXG+1CSDVT4TAFC6PWDVMHtZ1w20N+PymgYpCoUtvk1QpPdZ/hOx+TuH4GIylQ7GAQ7c4BE4IWykowk8ecphGx39+NYxLVdRhyaC7B/kqmig1B2UD46eWEg==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by CY4PR1201MB0006.namprd12.prod.outlook.com (2603:10b6:903:d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Mon, 1 Aug
 2022 22:27:21 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::585e:ba1d:bc54:151f]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::585e:ba1d:bc54:151f%7]) with mapi id 15.20.5482.015; Mon, 1 Aug 2022
 22:27:20 +0000
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
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
Thread-Index: AQHYhTLreZhiUX+onkijjgrrTcbLR61y2R2AgAGFGbCABrKBAIAAPJAAgAIbXzCAC1LxAIAAaRgAgBG2+UA=
Date:   Mon, 1 Aug 2022 22:27:20 +0000
Message-ID: <SJ0PR12MB56761FF81566AE17DC10A2ACA09A9@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20220621055035.31766-1-bwicaksono@nvidia.com>
 <20220621055035.31766-2-bwicaksono@nvidia.com>
 <73dafe08-d1f1-90b6-995e-7d38e9e1dce7@arm.com>
 <SJ0PR12MB567600F730B47F3A1007775AA0829@SJ0PR12MB5676.namprd12.prod.outlook.com>
 <20220712163638.GA2945984@p14s>
 <632f5c80-2be3-ace5-6b0d-ee0c9e5560ff@arm.com>
 <SJ0PR12MB567612C18D20A0C0243F0D23A0889@SJ0PR12MB5676.namprd12.prod.outlook.com>
 <9d36f053-f929-204b-fb47-60c685b06717@arm.com>
 <CANLsYkz6yAMU-PHpjjBr6WwpJ3tKvGew0+Y_sZHfQgwJDptskA@mail.gmail.com>
In-Reply-To: <CANLsYkz6yAMU-PHpjjBr6WwpJ3tKvGew0+Y_sZHfQgwJDptskA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0508950a-706c-4ace-56f7-08da740cffb9
x-ms-traffictypediagnostic: CY4PR1201MB0006:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wf2RdYN4AdltMTVxeEIBvXKSX/eOdbwS9lEjn/gmBhA4gt3qtEurtwq39yVszeWzvhVJb3n5UXI6l/SUuIn/i2eK/7fOkcWtlZiUsvPkGrwFraKpZO+xl+AAaI4QZAomFxdXtZrpBaTweh+gNQt30w7stoQQmaTqI8elVQku6E0DPWpvG3CehiCu2aYh6PgJMaH/GiWRH/uvJOL3ce0cHZJ4hK4zfnEzEppHmuT5W+Hnxekn+/fH5Omu4n81A4YC3TixQBPKyU9aPXFLZpHvE1Y05mlZTBlDxtErrJmh5HHM6t78OgiU101aXQFCROcyqyIDtXmgMxKlH3KT1YO+Ve7fcYmhZnf/L4MuaqrdrnFSruLUHdnBJq7Wg59ZnRf7xzSzeEJOerE/z3uEZlxt1UOT2X2ix4UybSc0feyGOtbBQbg+u61gjOPXQibvU3RdTUOMDAdqpwpj9D2IfmcOINZJVVIfoHIDMZLX3fdeI2fjwjQIY7Y39kAlGkh1PWtfHTkhtghYUEI4LZjzG9ajps8jtlLrAkbASOjCmZ5FRAsJNAoFq7ljVK+0DY1Bxc9ysRrFGP7M/taRVq3zvG/v7cUdw3EadKqJaB7GWArcE+dccuPU7BFDAfw2v4OaUoLIsOYC2sieZNckK5txfiNuNtqRG+YLiVTK8foSB9YFuAqpU/xm4AoCIyKAOMweVg+KI2ynVKZwnrB0RA5y/jPDO8GBF5mDl5gTSiqhwij3H8RSN9AjbSSyTqmTkmW21fYljDSDKWQh+Otu+JpNMAE6y/kAgWAPRI/Iokdl1GcFcfVYuMQMEfzURYM1nPxo/lZmZv1cXHCtrFpHgekh8IA6UhnuyLqItyguTADiDQ3zGQlon3U1Y6gZ80eJVVKaE25TBNIKzIjVgmatW28fg9wk8g/d/B5fRc3CtJtwEey0fkM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(83380400001)(86362001)(186003)(9686003)(26005)(38070700005)(38100700002)(122000001)(52536014)(55016003)(8936002)(33656002)(76116006)(8676002)(66556008)(64756008)(66446008)(4326008)(66476007)(2906002)(66946007)(7416002)(5660300002)(71200400001)(53546011)(7696005)(6506007)(54906003)(41300700001)(110136005)(966005)(316002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1dJU0pxMDNpTzV5WUcxV1RVdkFQSWhLTURNVHE5Z2h2ZDFkZk5tS3lNN0VG?=
 =?utf-8?B?VTZQYUNkNmVJN0VmR2t3b1Z0dC9WZCtQN3dSTVU1azgrdUw2V05NOG1JaFN0?=
 =?utf-8?B?Tk56UnFGSUM5cUNCaXlRMXlhYmdSc1BXWVdTdVdNdjg3ZEsyME92M0svQlE5?=
 =?utf-8?B?MEkyNGlCR0xleEo0a2c5SldXVGdsMnB6MDl0YTJwMFpXZlhnWGxTMG1hejkz?=
 =?utf-8?B?Z1F6ektMOUtBd24rNlVJc1c5Z3B0dGFQd2JEZlRrYVRGVGRZRkc2RitUVGg2?=
 =?utf-8?B?cUZoZVFmUG5lK3k4MHNkR2hvUndhdk1FdCs3TzlBMFFROFNhZVpqNmZMTWJK?=
 =?utf-8?B?ZHFCbVFTQVpuUGw0U2VVM2lZKzAwYlg3bEx6Y2hVcGpEczY4OHZPSHN1bzU0?=
 =?utf-8?B?V29JamlLdkJLOEdVNmlwZytwTFRVT3NLZjJyWFQ2ODdWK1FMTm1QSTRGUW9F?=
 =?utf-8?B?MDl3LzRzZTc2a3h2SURVdzFXQ0drTnAvaGxSempvUU83UDNCdVFvZUJCTG1i?=
 =?utf-8?B?c3B4dzJWNWJBOE13K2htbERnNC9lSXhaRUV3VmZtSjVBUWVPS21FNmtkWUFw?=
 =?utf-8?B?T0V3cDI2UUgydXVsbk9INVhrbnFjZmgvaGxJWjMzcFIwdU9OK0hYTXIrY09W?=
 =?utf-8?B?TlVIeTRSajB6cVZxVnhLQnFiUXRHZVFXZytFekNUcnpHRG5LTmtQMFlaOUFz?=
 =?utf-8?B?b2wyRWhDQmcrd3VNUExJeXBnWUNLeUdUSnpmWUNZZjNDZXNaMWpMT1NyRUY1?=
 =?utf-8?B?Y1VtcFptcHZwWXJ5RzRaaGNyNUVhZWQ5NkdJWTNnaXFvS1ZUYXZMY2tGM0JF?=
 =?utf-8?B?T0ZkSXBVQ01FUE8wZWF1TmZKdjkzRHlMRjQ0RS9sdXhIcU55ZGY4dzhsa0Zi?=
 =?utf-8?B?UGNYR2o0Uk9JaEpveWhKNXRyaWhnaUJDdWNXRHZPZ0RVOTdwUFlJcTFhNHg0?=
 =?utf-8?B?dldFL3YrR05DUGFDZ2h3ZGl3VVlUNE9sNkdMZkg4c1lDWnFpWmVpblFDQU0x?=
 =?utf-8?B?MmpYd2pQU0tFcDJxZzN6THB6WjRiZlY0eFZQaTlZU3k4dFJLTHNoNHluYy8x?=
 =?utf-8?B?ell6MzNibCtpamdweUpsQjlLQTRaeUpCQUpFdmszenU1TG1KVjNKMnFPMDF5?=
 =?utf-8?B?ckEyTnpJdjU1aUptbWRROEpQS2FZczUxcVEyNXJSNjVYdC9vWGlyUXdBY0Jy?=
 =?utf-8?B?R05MOTB1WXpWU1BvcHBmYTlrR05BNmZDWGQzNW1SejlmOU1aTDJuZk8vaTlz?=
 =?utf-8?B?a3lYRUdPMFVzaUtZbGVLay95Z3RxRzlqaWlobDREUW1EcjFKYm42UGdKYjNm?=
 =?utf-8?B?dzB0ZHN1cUl4bnRZZWZiVG1BMTNhQit0aktuUjJuQS9oSEQ1WUlkdlVEckFV?=
 =?utf-8?B?dDZMTE9uMmwwN3RIV3FxZGhBUmkxb2RkSmJsMy90UmFFYW1qSjJldFk3ZlFW?=
 =?utf-8?B?VG5jVmJHMG9uQmJXU2lpNlZINy90bzQyUEtTUGtDTHErb2MwSzErS1I5MkZW?=
 =?utf-8?B?Skl2S0luUjFUQUdOeCtleU9PUFBTQm83c2V3MHBVTFR6OTJVcmdqSDBRN25p?=
 =?utf-8?B?TFE2K1VwSm9mQ2M4YSt5MlhNLzlyRnJCTTVEclcyY2RQRHFDYXZJTENKQzhF?=
 =?utf-8?B?RDIwRERRL1dIV05DTUpQR1ZNZzN5cXVlNSt1Y3Y0ZW5MWDVPOFQ3TU5CT3I1?=
 =?utf-8?B?MzFwNjZFZFBkSWpHNlh4Y2hkLytJbHJNYmp0OHFyZDgvVlFRQmFjVmdUZ21y?=
 =?utf-8?B?N1RNTXk2Znl3K1JGYTBMZVMya2MyeExjbWhXSDY3aTFhUHFVQUhpYkxJNW12?=
 =?utf-8?B?VDN6ZHo0TTNaM2pReUtLNUhKTTk4akZOMmcwZWJSNUEzSklwd1ZlZFc1dC9v?=
 =?utf-8?B?QjhMQktzVVZJaC9uYU9MVkIvMS9yekVaNEJHOXA5ckIwVE9WanByb2ZhWG83?=
 =?utf-8?B?QzFVN1hSNnQxeklkV29yZy9TQkVmbmtMMVA1MFA4VUYzUEdINHIxUXppb1M5?=
 =?utf-8?B?S0xta3dlN2lrSlF2VDFhTXlxM3JxK21DaGR6MEY3b2FrbHVscHEzdTRnSWxW?=
 =?utf-8?B?bS9GbXpFWml6R0tHa2sxV2xmKzdNQ0RGZjBMVGp2UXBDWVJOTXlhZGxjQ2Rn?=
 =?utf-8?Q?SICKglD3ebvu0skQLo7ihZlI8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0508950a-706c-4ace-56f7-08da740cffb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 22:27:20.4799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h65djtH9ITykSWfkCjiNwa5YAZP2K1JbDOJ3wSQGbRuOhzPR8uaXTe1/aTqcAjY5eNSPJO6mCL36wiGPagKTMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0006
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXRoaWV1IFBvaXJp
ZXIgPG1hdGhpZXUucG9pcmllckBsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgSnVseSAy
MSwgMjAyMiAxMDozNiBBTQ0KPiBUbzogU3V6dWtpIEsgUG91bG9zZSA8c3V6dWtpLnBvdWxvc2VA
YXJtLmNvbT4NCj4gQ2M6IEJlc2FyIFdpY2Frc29ubyA8YndpY2Frc29ub0BudmlkaWEuY29tPjsg
Um9iaW4gTXVycGh5DQo+IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT47IGNhdGFsaW4ubWFyaW5hc0Bh
cm0uY29tOyB3aWxsQGtlcm5lbC5vcmc7DQo+IG1hcmsucnV0bGFuZEBhcm0uY29tOyBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC10ZWdyYUB2Z2VyLmtlcm5lbC5vcmc7DQo+IHN1ZGVlcC5ob2xsYUBhcm0u
Y29tOyB0aGFudS5yYW5nYXJhamFuQGFybS5jb207DQo+IE1pY2hhZWwuV2lsbGlhbXNAYXJtLmNv
bTsgVGhpZXJyeSBSZWRpbmcgPHRyZWRpbmdAbnZpZGlhLmNvbT47IEpvbmF0aGFuDQo+IEh1bnRl
ciA8am9uYXRoYW5oQG52aWRpYS5jb20+OyBWaWtyYW0gU2V0aGkgPHZzZXRoaUBudmlkaWEuY29t
PjsNCj4gbWlrZS5sZWFjaEBsaW5hcm8ub3JnOyBsZW8ueWFuQGxpbmFyby5vcmcNCj4gU3ViamVj
dDogUmU6IFtSRVNFTkQgUEFUQ0ggdjMgMS8yXSBwZXJmOiBjb3Jlc2lnaHRfcG11OiBBZGQgc3Vw
cG9ydCBmb3INCj4gQVJNIENvcmVTaWdodCBQTVUgZHJpdmVyDQo+IA0KPiBFeHRlcm5hbCBlbWFp
bDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9u
IFRodSwgMjEgSnVsIDIwMjIgYXQgMDM6MTksIFN1enVraSBLIFBvdWxvc2UgPHN1enVraS5wb3Vs
b3NlQGFybS5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gSGkNCj4gPg0KPiA+IE9uIDE0LzA3LzIw
MjIgMDU6NDcsIEJlc2FyIFdpY2Frc29ubyB3cm90ZToNCj4gPiA+DQo+ID4gPg0KPiA+ID4+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPj4gRnJvbTogUm9iaW4gTXVycGh5IDxyb2Jp
bi5tdXJwaHlAYXJtLmNvbT4NCj4gPiA+PiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMTMsIDIwMjIg
MzoxMyBBTQ0KPiA+ID4+IFRvOiBNYXRoaWV1IFBvaXJpZXIgPG1hdGhpZXUucG9pcmllckBsaW5h
cm8ub3JnPjsgQmVzYXIgV2ljYWtzb25vDQo+ID4gPj4gPGJ3aWNha3Nvbm9AbnZpZGlhLmNvbT4N
Cj4gPiA+PiBDYzogU3V6dWtpIEsgUG91bG9zZSA8c3V6dWtpLnBvdWxvc2VAYXJtLmNvbT47DQo+
IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOw0KPiA+ID4+IHdpbGxAa2VybmVsLm9yZzsgbWFyay5y
dXRsYW5kQGFybS5jb207IGxpbnV4LWFybS0NCj4gPiA+PiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+ID4gPj4gdGVncmFA
dmdlci5rZXJuZWwub3JnOyBzdWRlZXAuaG9sbGFAYXJtLmNvbTsNCj4gPiA+PiB0aGFudS5yYW5n
YXJhamFuQGFybS5jb207IE1pY2hhZWwuV2lsbGlhbXNAYXJtLmNvbTsgVGhpZXJyeQ0KPiBSZWRp
bmcNCj4gPiA+PiA8dHJlZGluZ0BudmlkaWEuY29tPjsgSm9uYXRoYW4gSHVudGVyIDxqb25hdGhh
bmhAbnZpZGlhLmNvbT47DQo+IFZpa3JhbQ0KPiA+ID4+IFNldGhpIDx2c2V0aGlAbnZpZGlhLmNv
bT47IG1pa2UubGVhY2hAbGluYXJvLm9yZzsgbGVvLnlhbkBsaW5hcm8ub3JnDQo+ID4gPj4gU3Vi
amVjdDogUmU6IFtSRVNFTkQgUEFUQ0ggdjMgMS8yXSBwZXJmOiBjb3Jlc2lnaHRfcG11OiBBZGQg
c3VwcG9ydA0KPiBmb3INCj4gPiA+PiBBUk0gQ29yZVNpZ2h0IFBNVSBkcml2ZXINCj4gPiA+Pg0K
PiA+ID4+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFj
aG1lbnRzDQo+ID4gPj4NCj4gPiA+Pg0KPiA+ID4+IE9uIDIwMjItMDctMTIgMTc6MzYsIE1hdGhp
ZXUgUG9pcmllciB3cm90ZToNCj4gPiA+PiBbLi4uXQ0KPiA+ID4+Pj4+IElmIHdlIGhhdmUgZGVj
aWVkIHRvIGNhbGwgdGhpcyBhcm1fc3lzdGVtX3BtdSwgKHdoaWNoIEkgYW0NCj4gcGVyZmVjdGx5
DQo+ID4gPj4+Pj4gaGFwcHkgd2l0aCksIGNvdWxkIHdlIHBsZWFzZSBzdGljayB0byB0aGF0IG5h
bWUgZm9yIGZ1bmN0aW9ucyB0aGF0DQo+IHdlDQo+ID4gPj4+Pj4gZXhwb3J0ID8NCj4gPiA+Pj4+
Pg0KPiA+ID4+Pj4+IGUuZywNCj4gPiA+Pj4+Pg0KPiA+ID4+DQo+IHMvY29yZXNpZ2h0X3BtdV9z
eXNmc19ldmVudF9zaG93L2FybV9zeXN0ZW1fcG11X2V2ZW50X3Nob3coKS8NCj4gPiA+Pj4+Pg0K
PiA+ID4+Pj4NCj4gPiA+Pj4+IEp1c3Qgd2FudCB0byBjb25maXJtLCBpcyBpdCBqdXN0IHRoZSBw
dWJsaWMgZnVuY3Rpb25zIG9yIGRvIHdlIG5lZWQgdG8NCj4gPiA+PiByZXBsYWNlDQo+ID4gPj4+
PiBhbGwgdGhhdCBoYXMgImNvcmVzaWdodCIgbmFtaW5nID8gSW5jbHVkaW5nIHRoZSBzdGF0aWMg
ZnVuY3Rpb25zLCBzdHJ1Y3RzLA0KPiA+ID4+IGZpbGVuYW1lLg0KPiA+ID4+Pg0KPiA+ID4+PiBJ
IHRoaW5rIGFsbCByZWZlcmVuY2VzIHRvICJjb3Jlc2lnaHQiIHNob3VsZCBiZSBjaGFuZ2VkIHRv
DQo+ID4gPj4gImFybV9zeXN0ZW1fcG11IiwNCj4gPiA+Pj4gaW5jbHVkaW5nIGZpbGVuYW1lcy4g
IFRoYXQgd2F5IHRoZXJlIGlzIG5vIGRvdWJ0IHRoaXMgSVAgYmxvY2sgaXMgbm90DQo+ID4gPj4+
IHJlbGF0ZWQsIGFuZCBkb2VzIG5vdCBpbnRlcm9wZXJhdGUsIHdpdGggdGhlIGFueSBvZiB0aGUg
ImNvcmVzaWdodCIgSVANCj4gPiA+PiBibG9ja3MNCj4gPiA+Pj4gYWxyZWFkeSBzdXBwb3J0ZWRb
MV0gaW4gdGhlIGtlcm5lbC4NCj4gPiA+Pj4NCj4gPiA+Pj4gSSBoYXZlIGxvb2tlZCBhdCB0aGUg
ZG9jdW1lbnRhdGlvblsyXSBpbiB0aGUgY292ZXIgbGV0dGVyIGFuZCBJIGFncmVlDQo+ID4gPj4+
IHdpdGggYW4gZWFybGllciBjb21tZW50IGZyb20gU3VkZWVwIHRoYXQgdGhpcyBJUCBoYXMgdmVy
eSBsaXR0bGUgdG8gZG8NCj4gd2l0aA0KPiA+ID4+IGFueQ0KPiA+ID4+PiBvZiB0aGUgb3RoZXIg
Q29yZVNpZ2h0IElQIGJsb2NrcyBmb3VuZCBpbiB0aGUgQ29yZVNpZ2h0IGZyYW1ld29ya1sxXS4N
Cj4gPiA+PiBVc2luZyB0aGUNCj4gPiA+Pj4gImNvcmVzaWdodCIgbmFtaW5nIGNvbnZlbnRpb24g
aW4gdGhpcyBkcml2ZXIgd291bGQgYmUgX2V4dHJlbWVseV8NCj4gPiA+PiBjb25mdXNpbmcsDQo+
ID4gPj4+IGVzcGVjaWFsbHkgd2hlbiBpdCBjb21lcyB0byBleHBvcnRlZCBmdW5jdGlvbnMuDQo+
ID4gPj4NCj4gPiA+PiBCdXQgY29udmVyc2VseSwgaG93IGlzIGl0IG5vdCBjb25mdXNpbmcgdG8g
bWFrZSB1cCBjb21wbGV0ZWx5IGRpZmZlcmVudA0KPiA+ID4+IG5hbWVzIGZvciB0aGluZ3MgdGhh
biB3aGF0IHRoZXkncmUgYWN0dWFsbHkgY2FsbGVkPyBUaGUgQ29yZVNpZ2h0DQo+ID4gPj4gUGVy
Zm9ybWFuY2UgTW9uaXRvcmluZyBVbml0IGlzIGEgcGFydCBvZiB0aGUgQXJtIENvcmVTaWdodA0K
PiBhcmNoaXRlY3R1cmUsDQo+ID4gPj4gaXQgc2F5cyBpdCByaWdodCB0aGVyZSBvbiBwYWdlIDEu
IFdoYXQgaWYgSSBpbnN0aW5jdGl2ZWx5IGFzc29jaWF0ZSB0aGUNCj4gPiA+PiBuYW1lIE1hdGhp
ZXUgd2l0aCBzb21lb25lIG1vcmUgZmFtaWxpYXIgdG8gbWUsIHNvIHRvIGF2b2lkIGNvbmZ1c2lv
bg0KPiBJJ2QNCj4gPiA+PiBwcmVmZXIgdG8gY2FsbCB5b3UgU3RldmU/IElzIHRoYXQgT0s/DQo+
ID4gPj4NCj4gPiA+DQo+ID4gPiBXaGF0IGlzIHRoZSBuYW1pbmcgY29udmVudGlvbiBmb3IgbW9k
dWxlcyB1bmRlciBkcml2ZXJzL3BlcmYgPw0KPiA+ID4gSW4gbXkgb2JzZXJ2YXRpb24sIHRoZSBu
YW1lcyB0aGVyZSBjb3JyZXNwb25kIHRvIHRoZSBwYXJ0IG1vbml0b3JlZCBieQ0KPiA+ID4gdGhl
IFBNVS4gVGhlIGNvbmZ1c2lvbiBvbiB1c2luZyAiY29yZXNpZ2h0X3BtdSIgbmFtaW5nIGNvdWxk
IGJlIHRoYXQNCj4gPiA+IHBlb3BsZSBtYXkgdGhpbmsgdGhlIFBNVSBtb25pdG9ycyBjb3Jlc2ln
aHQgc3lzdGVtLCBpLmUgdGhlIHRyYWNlDQo+IHN5c3RlbSB1bmRlciBod3RyYWNpbmcuDQo+ID4g
PiBIb3dldmVyLCB0aGUgZHJpdmVyIGluIHRoaXMgcGF0Y2ggaXMgZm9yIGEgbmV3IFBNVSBzdGFu
ZGFyZCB0aGF0DQo+IG1vbml0b3JzIHVuY29yZQ0KPiA+ID4gcGFydHMuIFVuY29yZSB3YXMgY29u
c2lkZXJlZCBhcyB0ZXJtaW5vbG9neSBmcm9tIEludGVsLCBzbyAic3lzdGVtIiB3YXMNCj4gcGlj
a2VkIGluc3RlYWQuDQo+ID4gPiBQbGVhc2Ugc2VlIHRoaXMgdGhyZWFkIGZvciByZWZlcmVuY2U6
DQo+ID4gPiAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1hcm0tDQo+IGtlcm5lbC8y
MDIyMDUxMDExMTMxOC5HRDI3NTU3QHdpbGxpZS10aGUtdHJ1Y2svDQo+ID4NCj4gPiBJIHRoaW5r
IHdlIGFsbCB1bmRlcnN0YW5kIHRoZSBzdGF0ZSBvZiBhZmZhaXJzLg0KPiA+DQo+ID4gLSBXZSBo
YXZlIGFuIGFyY2hpdGVjdXRyZSBzcGVjaWZpY2F0aW9uIGZvciBQTVVzLCBBcm0gQ29yZVNpZ2h0
IFBNVQ0KPiA+IEFyY2hpdGVjdXRyZSwgd2hpY2ggaGFzIGFic29sdXRlbHkgbm8gcmVsYXRpb25z
aGlwIHdpdGggOg0KPiA+DQo+ID4gICAgIGVpdGhlciBDb3JlU2lnaHQgU2VsZi1Ib3N0ZWQgVHJh
Y2luZyAoaGFuZGxlZCBieSAiY29yZXNpZ2h0Ig0KPiA+IHN1YnN5c3RlbSBpbiB0aGUga2VybmVs
IHVuZGVyIGRyaXZlcnMvaHd0cmFjaW5nL2NvcmVzaWdodC8sIHdpdGggYSB1c2VyDQo+ID4gdmlz
aWJsZSBwbXUgYXMgImNzX2V0bSIpDQo+ID4NCj4gPiAgICAgb3IgdGhlIENvcmVTaWdodCBBcmNo
aXRlY3R1cmUgKGV4Y2VwdCBmb3IgdGhlIG5hbWUpLiBUaGlzIGlzIG9mIGxlc3MNCj4gPiBzaWdu
aWZpY2FuY2UgaW4gZ2VuZXJhbC4gQnV0IGhhcyBhIHNpZ25pZmljYW50IGltcGFjdCBvbiB0aGUg
Im5hbWUiDQo+ID4gdXNlcnMgbWlnaHQgZXhwZWN0IGZvciB0aGUgZHJpdmVyL0tjb25maWcgZXRj
Lg0KPiA+DQo+ID4gLSBXZSB3YW50IHRvIGJlIGFibGUgdG8gbWFrZSBpdCBlYXNpZXIgZm9yIHRo
ZSB1c2Vycy9kZXZlbG9wZXJzIHRvDQo+ID4gY2hvb3NlIHdoYXQgdGhleSB3YW50IHdpdGhvdXQg
Y2F1c2luZyBjb25mdXNpb24uDQo+ID4NCj4gPiBGb3IgYW4gZW5kLXVzZXI6IEhhdmluZyB0aGUg
UE1VIGluc3RhbmNlIG5hbWVkIGFmdGVyIHRoZSAiU3lzdGVtIElQIg0KPiA+IChhcyBpbXBsZW1l
bWVudGVkIGluIHRoZSBkcml2ZXIgc29sdmVzIHRoZSBwcm9ibGVtIGFuZCBmYWxsaW5nIGJhY2sg
dG8NCj4gPiBhcm1fc3lzdGVtX3BtdSBpcyBhIGdvb2QgZW5vdWdoIGNob2ljZS4gU28gbGV0IHVz
IHN0aWNrIHdpdGggdGhhdCkNCj4gPg0KPiA+IEtjb25maWc6IE1heSBiZSB3ZSBjYW4gY2hvb3Nl
DQo+ID4gQ09ORklHX0FSTV9DT1JFU0lHSFRfUE1VX0FSQ0hfUE1VDQo+ID4gb3IgZXZlbg0KPiA+
IENPTkZJR19BUk1fQ09SRVNJR0hUX1BNVV9BUkNIX1NZU1RFTV9QTVUNCj4gPg0KPiA+IHdpdGgg
YXBwcm9wcmlhdGUgaGVscCB0ZXh0IHRvIGVuc3VyZSB0aGVyZSBpcyBlbm91Z2ggc3RyZXNzIGFi
b3V0IHdoYXQNCj4gPiB0aGlzIGlzIGFuZCB3aGF0IHRoaXMgaXMgbm90IHdvdWxkIGJlIHN1ZmZp
Y2llbnQuDQo+ID4NCg0KQ09ORklHX0FSTV9DT1JFU0lHSFRfUE1VX0FSQ0hfU1lTVEVNX1BNVSBz
b3VuZHMgZ29vZCB0byBtZS4NCg0KPiA+IE5vdyB0aGUgcmVtYWluaW5nIGNvbnRlbnRpb24gaXMg
YWJvdXQgdGhlIG5hbWUgb2YgdGhlICJzdWJzeXN0ZW0iIGFuZA0KPiA+IGFsc28gdGhlIGRpci9m
aWxlcy4gIFRoaXMgbWF5IHNvdW5kIGluc2lnbmlmaWNhbnQuIEJ1dCBpdCBpcyBhbHNvDQo+ID4g
aW1wb3J0YW50IHRvIGdldCB0aGlzIHJpZ2h0LiBlLmcuLCBoZWxwcyB0aGUgcmV2aWV3ZXJzIHVu
YW1iaWd1b3VzbHkNCj4gPiBpZGVudGlmeSB0aGUgY2hhbmdlIG9yIG1haW50YWluZXJzIGFjY2Vw
dGluZyBwdWxsIHJlcXVlc3RzIChyZW1lbWJlcg0KPiA+IHRoZXNlIHR3byBQTVVzIChjc19ldG0g
YW5kIHRoaXMgb25lKSBnbyB2aWEgZGlmZmVyZW50IHRyZWVzLikuIE5vdA0KPiA+IGV2ZXJ5b25l
IHdobyBkZWFscyB3aXRoIHRoaXMgaW4gdGhlIGNvbW11bml0eSBtYXkgYmUgYXdhcmUgb2YgaG93
DQo+ID4gdGhlc2UgYXJlIGRpZmZlcmVudC4NCj4gPg0KPiA+IFdlIGNvdWxkIGNob29zZSBhcm1f
Y3NwbXVfIG9yIHNpbXBseSBjc3BtdS4gR2l2ZW4gdGhhdCBvbmx5IHRoZQ0KPiA+ICJub3JtYWwi
IHVzZXJzIGNhcmUgYWJvdXQgdGhlICJhc3NvY2lhdGlvbiIgd2l0aCB0aGUgImFyY2hpdGVjdHVy
ZSINCj4gPiBhbmQgbW9yZSBhZHZhbmNlZCB1c2VycyAoZS5nLCBkZXZlbG9wZXJzKSBjYW4gZWFz
aWx5IG1hcCAiS2NvbmZpZyINCj4gPiB0byBkcml2ZXIgZmlsZXMsIG1heSBiZSB3ZSBjb3VsZCBl
dmVuIHN0aWNrIHRvIHRoZSAiYXJtX3N5c3BtdSINCj4gPiAoZnJvbSAiYXJtIHN5c3RlbSBwbXUi
KSA/DQo+ID4NCj4gDQo+ICsxIG9uICJhcm1fc3lzcG11Ig0KPiANCg0KSSBhbSBmaW5lIHRvbyB3
aXRoIGFybV9zeXNwbXUuDQoNCklmIHRoZXJlIGlzIG5vIG9iamVjdGlvbiwgSSBhbSBnb2luZyB0
byBwb3N0IG5ldyB1cGRhdGUgYnkgZW5kIG9mIHRoaXMgd2Vlaw0Kb3IgZWFybHkgbmV4dCB3ZWVr
Lg0KDQpUaGFua3MsDQpCZXNhcg0KDQo+ID4gU3V6dWtpDQo+ID4NCj4gPg0KPiA+ID4NCj4gPiA+
PiBBcyBpdCBoYXBwZW5zLCBTdGV2ZSwgSSBkbyBhY3R1YWxseSBhZ3JlZSB3aXRoIHlvdSB0aGF0
ICJjb3Jlc2lnaHRfIiBpcw0KPiA+ID4+IGEgYmFkIHByZWZpeCBoZXJlLCBidXQgb25seSBmb3Ig
dGhlIHJlYXNvbiB0aGF0IGl0J3MgdG9vIGdlbmVyYWwuIFRCSCBJDQo+ID4gPj4gdGhpbmsgdGhh
dCdzIHRydWUgb2YgdGhlIGV4aXN0aW5nIExpbnV4IHN1YnN5c3RlbSB0b28sIGJ1dCB0aGF0IGRh
bWFnZQ0KPiA+ID4+IGlzIGFscmVhZHkgZG9uZSwgYW5kIEknZCBjb25jdXIgdGhhdCB0aGVyZSdz
IGxpdHRsZSB2YWx1ZSBpbiB0cnlpbmcgdG8NCj4gPiA+PiB1bnBpY2sgdGhhdCBub3csIGRlc3Bp
dGUgdGhlIGNsZWFyIGV4aXN0ZW5jZSBvZiBwcm9kdWN0cyBsaWtlIENvcmVTaWdodA0KPiA+ID4+
IERBUCBhbmQgQ29yZVNpZ2h0IEVMQSB3aGljaCBkb24ndCBoYXZlIGFsbCB0aGF0IG11Y2ggdG8g
ZG8gd2l0aA0KPiBwcm9ncmFtDQo+ID4gPj4gdHJhY2UgZWl0aGVyLg0KPiA+ID4+DQo+ID4gPj4g
SG93ZXZlciwgaGluZHNpZ2h0IGFuZCBpbmVydGlhIGFyZSBoYXJkbHkgZ29vZCByZWFzb25zIHRv
IGRvdWJsZSBkb3duDQo+IG9uDQo+ID4gPj4gcG9vciBkZWNpc2lvbnMsIHNvIGlmIEkgd2FzIGdv
aW5nIHRvIHZvdGUgZm9yIGFueXRoaW5nIGhlcmUgaXQgd291bGQgYmUNCj4gPiA+PiAiY3NwbXVf
Iiwgd2hpY2ggaXMgYWJvdXQgYXMNCj4gPiA+PiBvYnZpb3VzbHktcmVsYXRlZC10by10aGUtdGhp
bmctaXQtYWN0dWFsbHktaXMgYXMgd2UgY2FuIGdldCB3aGlsZSBhbHNvDQo+ID4gPj4gYmVpbmcg
cGxlYXNhbnRseSBjb25jaXNlLg0KPiA+ID4+DQo+ID4gPj4gWyBBbmQgbm8sIHRoaXMgaXNuJ3Qg
YmlrZXNoZWRkaW5nLiBOYW1pbmcgdGhpbmdzIHJpZ2h0IGlzICppbXBvcnRhbnQqIF0NCj4gPiA+
Pg0KPiA+ID4NCj4gPiA+IEkgYWdyZWUgaGF2aW5nIHRoZSBjb3JyZWN0IG5hbWUgaXMgaW1wb3J0
YW50LCBlc3BlY2lhbGx5IGF0IHRoaXMgZWFybHkgc3RhZ2UuDQo+ID4gPiBBIGRpcmVjdGlvbiBv
ZiB3aGF0IHRoZSBuYW1pbmcgc2hvdWxkIGRlc2NyaWJlIHdvdWxkIGJlIHZlcnkgaGVscGZ1bA0K
PiBoZXJlLg0KPiA+ID4NCj4gPiA+PiBDaGVlcnMsDQo+ID4gPj4gUm9iaW4uDQo+ID4gPj4NCj4g
PiA+Pj4NCj4gPiA+Pj4gVGhhbmtzLA0KPiA+ID4+PiBTdGV2ZQ0KPiA+ID4+Pg0KPiA+ID4+PiBb
MV0uIGRyaXZlcnMvaHd0cmFjaW5nL2NvcmVzaWdodC8NCj4gPiA+Pj4gWzJdLiBodHRwczovL2Rl
dmVsb3Blci5hcm0uY29tL2RvY3VtZW50YXRpb24vaWhpMDA5MS9sYXRlc3QNCj4gPg0K
