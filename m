Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF7E57C2CA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 05:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiGUDgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 23:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiGUDg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 23:36:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A708F77A7B;
        Wed, 20 Jul 2022 20:36:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVMnbEP7KgLtH+i6MtKIdmwn7wj6sK9uAMaZ5JneaEAq/ei9ORunAkkx0q3HQzYfvZow33YkIonm5IT1MhTLIstgzqTgEyd9UashKH2mksRt0YL+J2H24UI4apxHh08D7ZP69EnKZB6ceHveIh+GUWMGyA3ZITJzEsEijhE6cSK5yuGiEDg1i3OdiUVoG3mxnKI7EWgg3u6syY8uhLwTUlN5r6Vq/eakXrGI5zaMMj1gqZW83a3uOOpYUWvh7eWZZK281sn/4ADafhOqZtP6UM+uc0bkT1UW9el0So3p2XSgpqPjYx1Pzk3CXeAS5/pW9PUDNfFfrVNbgeFrOQabSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cMHEJM0x3LVJd+AMzLxNY0hwzP1z//OC97pv1P7k0g=;
 b=VsqfTXyTdUrBqRS81Af26yuMqLSMXARvkJudPCRo00ylmUI66vU8NWBX1I00ZZhlopPvKLe+mJiF9Is8yHMwHytebOd+PaMUlG3asIQu6jN5LLzjzR5hiaTyxHqdbkgAVoal/2/iMy872l88at0DQS2G6Z1wzXlygKgdxje0vMsHJ2j+XilXOJdGRsd1UPaaVZuzDXJiXoR4M1zCpx6QyDoqhoHu49vJF6GBoWYzWNsjJxCJpro6wwWwC15RL845M6g1i7GNTPdkeolIsK2NsOLnkHhCQNCH9yM+Z797LOBfF7GlwkVqJnA/T9R4ouUIvSec5kjVx3S9D8jqQnr55Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cMHEJM0x3LVJd+AMzLxNY0hwzP1z//OC97pv1P7k0g=;
 b=XtiXcgLTCOLeJRhBscgJsxCDIy56dGqugIrptsR9/fSUDq3I/nSH1ryh+4qtinehObH3VpS9UpknvCI27nGjKRIH3GqB+2RHAgLh5wZOLQYGJw2WRILd0eUtBtirUS++AxWqCdbHbbk06r1J3VSCe4X40mgCuLcsRg8z3XdQAKM9IF5St2yi+YRK29YTLpD1dQsSqhhrA9E/v9Y5JEKz11ftocLiSPlw1EHntXZcJsqNbk3xYOHWjFLPcGCe+6AGqpsdQA/f5fVObSvn0bDT0jSkQLcJZvaWux4H0yKdf6v9N4erDBLxhNRcbzj20KObAAsOA4L3lxXYX3XMfr7qQA==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by CY4PR12MB1301.namprd12.prod.outlook.com (2603:10b6:903:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Thu, 21 Jul
 2022 03:36:25 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::6cdd:89c7:38f5:35b3]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::6cdd:89c7:38f5:35b3%9]) with mapi id 15.20.5438.023; Thu, 21 Jul 2022
 03:36:25 +0000
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     "will@kernel.org" <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
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
Thread-Index: AQHYhTLreZhiUX+onkijjgrrTcbLR61y2R2AgAGFGbCABrKBAIAAPJAAgAIbXzCACtTusA==
Date:   Thu, 21 Jul 2022 03:36:25 +0000
Message-ID: <SJ0PR12MB567647259CBB7565ED2DD3BAA0919@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20220621055035.31766-1-bwicaksono@nvidia.com>
 <20220621055035.31766-2-bwicaksono@nvidia.com>
 <73dafe08-d1f1-90b6-995e-7d38e9e1dce7@arm.com>
 <SJ0PR12MB567600F730B47F3A1007775AA0829@SJ0PR12MB5676.namprd12.prod.outlook.com>
 <20220712163638.GA2945984@p14s>
 <632f5c80-2be3-ace5-6b0d-ee0c9e5560ff@arm.com>
 <SJ0PR12MB567612C18D20A0C0243F0D23A0889@SJ0PR12MB5676.namprd12.prod.outlook.com>
In-Reply-To: <SJ0PR12MB567612C18D20A0C0243F0D23A0889@SJ0PR12MB5676.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9b41911-2874-4343-3361-08da6aca3070
x-ms-traffictypediagnostic: CY4PR12MB1301:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: abdozzwump03p17V1bFh87dytGYwJwBskLr+/DV6b0DlcG9zyDzJVaPtyUQJWhSZibrtdc6+3xKC/zHAb3Nu+Cz6rscMbz8PTNThVOcOelREqqWo1c1/QLDCiXvrFJYFIe7pJBoNyFmrh9ktTQvyNqQnBpWEMMVowEdCTFZvo1iAmLg6HKrUh6FYLORndIfsnKDAuufQ/0sQuPJPKeLppC2wDt0Fxc5TH+l93Jy1NsC2wIz9aaUQyMQYcgKSXrNzHFFwSTYlYm982HIpD6vjl+pvF7pAj45W0HbEPgBxaFNI4K+nr75x8kf6tUS/HDQihwYGXyp4aA0oFtcw0EVMn6clVI6YTiw9Ux4h0jlV8+mYt7imbvTV8QWaW5tqIRA01BqLFfFa7APo9sx2bmxG9ymLlg8qeZYm9rUOw1y8D2WsLMotUviY9MpeGmn+WQMhnvuqcMDgkSE0ND4PUX5P8McU7PQ6eITwtMi8/hyIXudGClcRZMMBgWvNez9vd2Km2F41j7XTFUAlo4bKLAG23EVBBjznGsPpougtK53syoKkstwMkD6xrqpCxIj5aQkcaFH8psNYQJvZUEOB92857FgRvO0scY3CAa1RdBy8DX863qIJb44nfANS0VfgILce/JlDNnAKssGBFamz5DAlruDq3AvpW4000OwLl2+yKoMEbNX6FigBay/qLGxZy+INWYd/ulRLyCimRpAsIY5XL5EmJRptAPmkmYnCCnrx6zinx8LypVtGzpIqx8t6wcZ0oZwKllNzl22RFVqN4bNpF/wvDINfbdt0G9YuxppfuWNeSUjoddrmcOwT+q0kRc82TnWaVwT5rw9FA4nq0Y7rNNi/cLxybTCDUh3mwAZqCzJ+Lm/qt91EUIpuOUKg7ZKrSy76sB7/x+5pw/+aCkI9SK1mK04W79mNJP1Yv50ypr0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(66556008)(66946007)(66476007)(66446008)(8676002)(83380400001)(76116006)(478600001)(33656002)(64756008)(5660300002)(38100700002)(52536014)(8936002)(4326008)(2906002)(71200400001)(26005)(41300700001)(186003)(316002)(54906003)(122000001)(110136005)(38070700005)(55016003)(7416002)(7696005)(966005)(86362001)(53546011)(9686003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0d2Zy9mNjRGZnBvSGhrbWNlbXJvc0hINlB1alNxUG9KaHBwdkZoTlpjaWVM?=
 =?utf-8?B?aHdCeGc5TURTdjNkZFlSTW5KMmF2ZWJsUXduYUxhaFNzQzZ5TW55b1JyL0tF?=
 =?utf-8?B?dXhRSlJmcUpTNnl6c1NsQzFPc3VYY1g2WE1pejkyVWVzeUdjWm4ycXhjNCtN?=
 =?utf-8?B?TXlHcmtlTDRpMkpqZVpFZjJORnc5Mlk0ckdRcHE4WG5iTUk5Zk9QSXJUZGUw?=
 =?utf-8?B?c3BFUEFFdnlERVluNnV6QUJmY1MyRXdEWWxhUzhHaktHL2RFNkloMk14SWJW?=
 =?utf-8?B?RWFkb0p5ZGo1WVZLZGl0TVcvVDRKYXIwcXhKTzczSHEwWVRRR29qWEk4Z2lz?=
 =?utf-8?B?eDJvU25Sd1FOc012ZWpUczYzTGJESnAyZDlsaE5hc2xmSjc4QkhjTVhXRWds?=
 =?utf-8?B?QVRDdFNhV1Q1ZEZUTFZEYlg3aWRxQTdoSFFhRHpSV1R0bW03ZnJIa2dpaEhR?=
 =?utf-8?B?NkpLTndIVHBVRTVFVmo3dFUwRlU3ZytvSW9TeXJObTVQN0tnblRreHF2KzVS?=
 =?utf-8?B?ckM1b0t1M2VXdlNXdmFyaDdIelJFYUJoZHVJc0ovVHRodlQzWnA3WndHWGdq?=
 =?utf-8?B?WjNyVHZEUCtMczBBajIzdTBzc0Qxa3pJT0pkVFRxSWR4MUMyNWkrVTZodnVS?=
 =?utf-8?B?bXBzZ3hINEFFcXdwWGFtT0UxUUFSbi8zVVVUUkZhWkhNcFdxTDZRQ1U5dVd2?=
 =?utf-8?B?N1ZtcUgwaGMyNFQvVzErSStUQ3VlSEkzdEp2ZExBTFdmS1hucTZOdUZmNUQ0?=
 =?utf-8?B?cUxZbkpiK2lSVXk4dGxBYnBXU2N1TFBzbU5ZbXNDSXk0K1pRdXpkQWIxWTBp?=
 =?utf-8?B?ZHFkdEhZZmZZeW52ZXBhcHBJcGt3emFLY1o4VEJnb2E1UGZ6OTRyT0NYUTJI?=
 =?utf-8?B?REpRVjdOZmxzZGxEWGxaZ0R0ZDJmZW9WQUZhMWk5Qk42cmtKL3ZRcW9DUVho?=
 =?utf-8?B?cHAyVGZzalUwSGtwd2pWMnBlWVM0ZFhkN25NT0xZK0duMEhSV3hUb3EyMjhL?=
 =?utf-8?B?Q3dwMzZWRU1TQWxxdi9xOUpOVlJWYlVMeVV2eXVUYXI1MDFkbXRvTHBLaG5m?=
 =?utf-8?B?Nlh3ZC9OVWJtcFY1MnlwaGNJYVJRRFZRcGxIUmMvNkJkYzdkd1ZSVk5SQjNE?=
 =?utf-8?B?b2YreFlRN0R4N0hrVFc4UXcvUWlwTkQrZnA3STA0cGIyc2EyaE1KNG5RRWdX?=
 =?utf-8?B?OW9aQ3M5NURSRXR4MllXNW9ITEVVek1qekZmYW00YzhFbTM0akpHc2VYbGxT?=
 =?utf-8?B?K2FkVUp2Y0VxOXJCREkvSnc1Zng0ZXVjMy9lRGZ0REZ4dEFKa3JrY2NicWh3?=
 =?utf-8?B?bmNiNHVCa0llOHJ3eTJyUnFFeUVGVUNYeHFvYThFUUVrYVZwdWgvcnFkaXVo?=
 =?utf-8?B?aGFBcFVCK3phTG43YVpydDB6Uk5iSGZ3V1BDS3A1dzBaQnNaRlptamNXSHlV?=
 =?utf-8?B?RWIySXhuZ2ZFempyRjZkS2tJZnZ6ODU2ZFNHSGJBWTNXYjE5b3ZObkVNbGFE?=
 =?utf-8?B?T0tQb3NmUytieXQrMXRrcmR6K3pha0h2ZEs1cjRnTE1ZczY3ai93aG9aVENX?=
 =?utf-8?B?YjV1cnorWHN2UGFUWUxhb1BlNWdOTmlnSkpTcFNsT052U1VqR2VrVE9Dc2VC?=
 =?utf-8?B?elhTL2tCVWZIY2RHeDl5QVkraDFYak5CWkdaZ0lROUJmYlJGaXJPNDlnSkg3?=
 =?utf-8?B?YkErejVFalFPdFpLa2pybUxVTzNlbDlBNlZpNkdrSE1Yb1JEWThMMkJhblJy?=
 =?utf-8?B?aTlkRkZkbW9wMThvMmtYQkk1YWJsV2tpMi9SWHhVd0l3bjhTcHppM1dheXFQ?=
 =?utf-8?B?V2MzNWZsZ0VIZFFTZ1hUY1RKM2VMZDBrSkFGcmczcUJHQ0dUYWFWUTRBVTlF?=
 =?utf-8?B?MHE3OExHdnR0dERUbU0wd1IyNlR1RE15bTZReUNBUE5TRFk5aHlKRjJ0UWtN?=
 =?utf-8?B?c1l0T2NFT1VVOG9IcHkyUkFrNnZhUFdDZEdWNkFCeitHdlhSMWFjY1NJa1pF?=
 =?utf-8?B?QktOZ2VXaG1aRUFWWGduZ1lXQ1JsSW5vZ2VQTjd0Q3NlQlU2UFFRa0xHbkVv?=
 =?utf-8?B?ckp0ZUVsM1RHc05wb3ZjVE0rdi9XcUJlaTIwMzh3SSttZ05SeEJLVGl4K2RL?=
 =?utf-8?Q?xSN0mYwuN1iQAVTVPQl06Jn9l?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b41911-2874-4343-3361-08da6aca3070
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 03:36:25.4787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sZ98uKTTodmcv+QrEzy3rnu3YtikUWqopzLwlh9IvqpcXP6ULAapK+51Itc8WEQ9UzqvsCv16T8xqQOmgvhQRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1301
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmV2aWV3ZXJzLA0KDQpXZSBzdGlsbCBoYXZlIGRpc2FncmVlbWVudCBvbiB0aGUgbmFtaW5n
LCBob3cgZG8gd2UgcmVzb2x2ZSBpdCBhbmQgbW92ZSBmb3J3YXJkID8NCg0KVGhhbmtzLA0KQmVz
YXINCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCZXNhciBXaWNha3Nv
bm8NCj4gU2VudDogVGh1cnNkYXksIEp1bHkgMTQsIDIwMjIgMTE6NDcgQU0NCj4gVG86IFJvYmlu
IE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+OyBNYXRoaWV1IFBvaXJpZXINCj4gPG1hdGhp
ZXUucG9pcmllckBsaW5hcm8ub3JnPg0KPiBDYzogU3V6dWtpIEsgUG91bG9zZSA8c3V6dWtpLnBv
dWxvc2VAYXJtLmNvbT47IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOw0KPiB3aWxsQGtlcm5lbC5v
cmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gdGVncmFA
dmdlci5rZXJuZWwub3JnOyBzdWRlZXAuaG9sbGFAYXJtLmNvbTsNCj4gdGhhbnUucmFuZ2FyYWph
bkBhcm0uY29tOyBNaWNoYWVsLldpbGxpYW1zQGFybS5jb207IFRoaWVycnkgUmVkaW5nDQo+IDx0
cmVkaW5nQG52aWRpYS5jb20+OyBKb25hdGhhbiBIdW50ZXIgPGpvbmF0aGFuaEBudmlkaWEuY29t
PjsgVmlrcmFtDQo+IFNldGhpIDx2c2V0aGlAbnZpZGlhLmNvbT47IG1pa2UubGVhY2hAbGluYXJv
Lm9yZzsgbGVvLnlhbkBsaW5hcm8ub3JnDQo+IFN1YmplY3Q6IFJFOiBbUkVTRU5EIFBBVENIIHYz
IDEvMl0gcGVyZjogY29yZXNpZ2h0X3BtdTogQWRkIHN1cHBvcnQgZm9yDQo+IEFSTSBDb3JlU2ln
aHQgUE1VIGRyaXZlcg0KPiANCj4gDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4gRnJvbTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4NCj4gPiBTZW50
OiBXZWRuZXNkYXksIEp1bHkgMTMsIDIwMjIgMzoxMyBBTQ0KPiA+IFRvOiBNYXRoaWV1IFBvaXJp
ZXIgPG1hdGhpZXUucG9pcmllckBsaW5hcm8ub3JnPjsgQmVzYXIgV2ljYWtzb25vDQo+ID4gPGJ3
aWNha3Nvbm9AbnZpZGlhLmNvbT4NCj4gPiBDYzogU3V6dWtpIEsgUG91bG9zZSA8c3V6dWtpLnBv
dWxvc2VAYXJtLmNvbT47DQo+IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOw0KPiA+IHdpbGxAa2Vy
bmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207IGxpbnV4LWFybS0NCj4gPiBrZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+
ID4gdGVncmFAdmdlci5rZXJuZWwub3JnOyBzdWRlZXAuaG9sbGFAYXJtLmNvbTsNCj4gPiB0aGFu
dS5yYW5nYXJhamFuQGFybS5jb207IE1pY2hhZWwuV2lsbGlhbXNAYXJtLmNvbTsgVGhpZXJyeSBS
ZWRpbmcNCj4gPiA8dHJlZGluZ0BudmlkaWEuY29tPjsgSm9uYXRoYW4gSHVudGVyIDxqb25hdGhh
bmhAbnZpZGlhLmNvbT47IFZpa3JhbQ0KPiA+IFNldGhpIDx2c2V0aGlAbnZpZGlhLmNvbT47IG1p
a2UubGVhY2hAbGluYXJvLm9yZzsgbGVvLnlhbkBsaW5hcm8ub3JnDQo+ID4gU3ViamVjdDogUmU6
IFtSRVNFTkQgUEFUQ0ggdjMgMS8yXSBwZXJmOiBjb3Jlc2lnaHRfcG11OiBBZGQgc3VwcG9ydCBm
b3INCj4gPiBBUk0gQ29yZVNpZ2h0IFBNVSBkcml2ZXINCj4gPg0KPiA+IEV4dGVybmFsIGVtYWls
OiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+ID4NCj4gPg0KPiA+
IE9uIDIwMjItMDctMTIgMTc6MzYsIE1hdGhpZXUgUG9pcmllciB3cm90ZToNCj4gPiBbLi4uXQ0K
PiA+ID4+PiBJZiB3ZSBoYXZlIGRlY2llZCB0byBjYWxsIHRoaXMgYXJtX3N5c3RlbV9wbXUsICh3
aGljaCBJIGFtIHBlcmZlY3RseQ0KPiA+ID4+PiBoYXBweSB3aXRoKSwgY291bGQgd2UgcGxlYXNl
IHN0aWNrIHRvIHRoYXQgbmFtZSBmb3IgZnVuY3Rpb25zIHRoYXQgd2UNCj4gPiA+Pj4gZXhwb3J0
ID8NCj4gPiA+Pj4NCj4gPiA+Pj4gZS5nLA0KPiA+ID4+Pg0KPiA+IHMvY29yZXNpZ2h0X3BtdV9z
eXNmc19ldmVudF9zaG93L2FybV9zeXN0ZW1fcG11X2V2ZW50X3Nob3coKS8NCj4gPiA+Pj4NCj4g
PiA+Pg0KPiA+ID4+IEp1c3Qgd2FudCB0byBjb25maXJtLCBpcyBpdCBqdXN0IHRoZSBwdWJsaWMg
ZnVuY3Rpb25zIG9yIGRvIHdlIG5lZWQgdG8NCj4gPiByZXBsYWNlDQo+ID4gPj4gYWxsIHRoYXQg
aGFzICJjb3Jlc2lnaHQiIG5hbWluZyA/IEluY2x1ZGluZyB0aGUgc3RhdGljIGZ1bmN0aW9ucywg
c3RydWN0cywNCj4gPiBmaWxlbmFtZS4NCj4gPiA+DQo+ID4gPiBJIHRoaW5rIGFsbCByZWZlcmVu
Y2VzIHRvICJjb3Jlc2lnaHQiIHNob3VsZCBiZSBjaGFuZ2VkIHRvDQo+ID4gImFybV9zeXN0ZW1f
cG11IiwNCj4gPiA+IGluY2x1ZGluZyBmaWxlbmFtZXMuICBUaGF0IHdheSB0aGVyZSBpcyBubyBk
b3VidCB0aGlzIElQIGJsb2NrIGlzIG5vdA0KPiA+ID4gcmVsYXRlZCwgYW5kIGRvZXMgbm90IGlu
dGVyb3BlcmF0ZSwgd2l0aCB0aGUgYW55IG9mIHRoZSAiY29yZXNpZ2h0IiBJUA0KPiA+IGJsb2Nr
cw0KPiA+ID4gYWxyZWFkeSBzdXBwb3J0ZWRbMV0gaW4gdGhlIGtlcm5lbC4NCj4gPiA+DQo+ID4g
PiBJIGhhdmUgbG9va2VkIGF0IHRoZSBkb2N1bWVudGF0aW9uWzJdIGluIHRoZSBjb3ZlciBsZXR0
ZXIgYW5kIEkgYWdyZWUNCj4gPiA+IHdpdGggYW4gZWFybGllciBjb21tZW50IGZyb20gU3VkZWVw
IHRoYXQgdGhpcyBJUCBoYXMgdmVyeSBsaXR0bGUgdG8gZG8NCj4gd2l0aA0KPiA+IGFueQ0KPiA+
ID4gb2YgdGhlIG90aGVyIENvcmVTaWdodCBJUCBibG9ja3MgZm91bmQgaW4gdGhlIENvcmVTaWdo
dCBmcmFtZXdvcmtbMV0uDQo+ID4gVXNpbmcgdGhlDQo+ID4gPiAiY29yZXNpZ2h0IiBuYW1pbmcg
Y29udmVudGlvbiBpbiB0aGlzIGRyaXZlciB3b3VsZCBiZSBfZXh0cmVtZWx5Xw0KPiA+IGNvbmZ1
c2luZywNCj4gPiA+IGVzcGVjaWFsbHkgd2hlbiBpdCBjb21lcyB0byBleHBvcnRlZCBmdW5jdGlv
bnMuDQo+ID4NCj4gPiBCdXQgY29udmVyc2VseSwgaG93IGlzIGl0IG5vdCBjb25mdXNpbmcgdG8g
bWFrZSB1cCBjb21wbGV0ZWx5IGRpZmZlcmVudA0KPiA+IG5hbWVzIGZvciB0aGluZ3MgdGhhbiB3
aGF0IHRoZXkncmUgYWN0dWFsbHkgY2FsbGVkPyBUaGUgQ29yZVNpZ2h0DQo+ID4gUGVyZm9ybWFu
Y2UgTW9uaXRvcmluZyBVbml0IGlzIGEgcGFydCBvZiB0aGUgQXJtIENvcmVTaWdodCBhcmNoaXRl
Y3R1cmUsDQo+ID4gaXQgc2F5cyBpdCByaWdodCB0aGVyZSBvbiBwYWdlIDEuIFdoYXQgaWYgSSBp
bnN0aW5jdGl2ZWx5IGFzc29jaWF0ZSB0aGUNCj4gPiBuYW1lIE1hdGhpZXUgd2l0aCBzb21lb25l
IG1vcmUgZmFtaWxpYXIgdG8gbWUsIHNvIHRvIGF2b2lkIGNvbmZ1c2lvbiBJJ2QNCj4gPiBwcmVm
ZXIgdG8gY2FsbCB5b3UgU3RldmU/IElzIHRoYXQgT0s/DQo+ID4NCj4gDQo+IFdoYXQgaXMgdGhl
IG5hbWluZyBjb252ZW50aW9uIGZvciBtb2R1bGVzIHVuZGVyIGRyaXZlcnMvcGVyZiA/DQo+IElu
IG15IG9ic2VydmF0aW9uLCB0aGUgbmFtZXMgdGhlcmUgY29ycmVzcG9uZCB0byB0aGUgcGFydCBt
b25pdG9yZWQgYnkNCj4gdGhlIFBNVS4gVGhlIGNvbmZ1c2lvbiBvbiB1c2luZyAiY29yZXNpZ2h0
X3BtdSIgbmFtaW5nIGNvdWxkIGJlIHRoYXQNCj4gcGVvcGxlIG1heSB0aGluayB0aGUgUE1VIG1v
bml0b3JzIGNvcmVzaWdodCBzeXN0ZW0sIGkuZSB0aGUgdHJhY2Ugc3lzdGVtDQo+IHVuZGVyIGh3
dHJhY2luZy4NCj4gSG93ZXZlciwgdGhlIGRyaXZlciBpbiB0aGlzIHBhdGNoIGlzIGZvciBhIG5l
dyBQTVUgc3RhbmRhcmQgdGhhdCBtb25pdG9ycw0KPiB1bmNvcmUNCj4gcGFydHMuIFVuY29yZSB3
YXMgY29uc2lkZXJlZCBhcyB0ZXJtaW5vbG9neSBmcm9tIEludGVsLCBzbyAic3lzdGVtIiB3YXMN
Cj4gcGlja2VkIGluc3RlYWQuDQo+IFBsZWFzZSBzZWUgdGhpcyB0aHJlYWQgZm9yIHJlZmVyZW5j
ZToNCj4gICBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1hcm0ta2VybmVsLzIwMjIwNTEw
MTExMzE4LkdEMjc1NTdAd2lsbGllLQ0KPiB0aGUtdHJ1Y2svDQo+IA0KPiA+IEFzIGl0IGhhcHBl
bnMsIFN0ZXZlLCBJIGRvIGFjdHVhbGx5IGFncmVlIHdpdGggeW91IHRoYXQgImNvcmVzaWdodF8i
IGlzDQo+ID4gYSBiYWQgcHJlZml4IGhlcmUsIGJ1dCBvbmx5IGZvciB0aGUgcmVhc29uIHRoYXQg
aXQncyB0b28gZ2VuZXJhbC4gVEJIIEkNCj4gPiB0aGluayB0aGF0J3MgdHJ1ZSBvZiB0aGUgZXhp
c3RpbmcgTGludXggc3Vic3lzdGVtIHRvbywgYnV0IHRoYXQgZGFtYWdlDQo+ID4gaXMgYWxyZWFk
eSBkb25lLCBhbmQgSSdkIGNvbmN1ciB0aGF0IHRoZXJlJ3MgbGl0dGxlIHZhbHVlIGluIHRyeWlu
ZyB0bw0KPiA+IHVucGljayB0aGF0IG5vdywgZGVzcGl0ZSB0aGUgY2xlYXIgZXhpc3RlbmNlIG9m
IHByb2R1Y3RzIGxpa2UgQ29yZVNpZ2h0DQo+ID4gREFQIGFuZCBDb3JlU2lnaHQgRUxBIHdoaWNo
IGRvbid0IGhhdmUgYWxsIHRoYXQgbXVjaCB0byBkbyB3aXRoIHByb2dyYW0NCj4gPiB0cmFjZSBl
aXRoZXIuDQo+ID4NCj4gPiBIb3dldmVyLCBoaW5kc2lnaHQgYW5kIGluZXJ0aWEgYXJlIGhhcmRs
eSBnb29kIHJlYXNvbnMgdG8gZG91YmxlIGRvd24gb24NCj4gPiBwb29yIGRlY2lzaW9ucywgc28g
aWYgSSB3YXMgZ29pbmcgdG8gdm90ZSBmb3IgYW55dGhpbmcgaGVyZSBpdCB3b3VsZCBiZQ0KPiA+
ICJjc3BtdV8iLCB3aGljaCBpcyBhYm91dCBhcw0KPiA+IG9idmlvdXNseS1yZWxhdGVkLXRvLXRo
ZS10aGluZy1pdC1hY3R1YWxseS1pcyBhcyB3ZSBjYW4gZ2V0IHdoaWxlIGFsc28NCj4gPiBiZWlu
ZyBwbGVhc2FudGx5IGNvbmNpc2UuDQo+ID4NCj4gPiBbIEFuZCBubywgdGhpcyBpc24ndCBiaWtl
c2hlZGRpbmcuIE5hbWluZyB0aGluZ3MgcmlnaHQgaXMgKmltcG9ydGFudCogXQ0KPiA+DQo+IA0K
PiBJIGFncmVlIGhhdmluZyB0aGUgY29ycmVjdCBuYW1lIGlzIGltcG9ydGFudCwgZXNwZWNpYWxs
eSBhdCB0aGlzIGVhcmx5IHN0YWdlLg0KPiBBIGRpcmVjdGlvbiBvZiB3aGF0IHRoZSBuYW1pbmcg
c2hvdWxkIGRlc2NyaWJlIHdvdWxkIGJlIHZlcnkgaGVscGZ1bCBoZXJlLg0KPiANCj4gPiBDaGVl
cnMsDQo+ID4gUm9iaW4uDQo+ID4NCj4gPiA+DQo+ID4gPiBUaGFua3MsDQo+ID4gPiBTdGV2ZQ0K
PiA+ID4NCj4gPiA+IFsxXS4gZHJpdmVycy9od3RyYWNpbmcvY29yZXNpZ2h0Lw0KPiA+ID4gWzJd
LiBodHRwczovL2RldmVsb3Blci5hcm0uY29tL2RvY3VtZW50YXRpb24vaWhpMDA5MS9sYXRlc3QN
Cg==
