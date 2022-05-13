Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DC95261C7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380235AbiEMMZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380170AbiEMMZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:25:25 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5F02A1FD1;
        Fri, 13 May 2022 05:25:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XayQoPk9ArexFnWcho7UPUSqQ4AcWCxkNV2qM1wLIpkBivlDNHpAvcM8e7DgN6W1Eukm+nf8O9qnh3Gel/fuWjKF213aMM4R/U1uIlh6tRhetXm+i7xWxh778bnxSe5YjfAyNtMLzzt9LuFXTbtTWy7SsPQIF7VixYzt/x9J27wl197jO3epBedScOrIhLr00UQpcp1f02iq8XyJ1FEfQT88EvGK+MgI9ZyB9P9jAmuCUhw/73TGB/TguX7HT2xns9m6IsY+Hf2JoNwTkA17u7e0yTqpQM2rR2Cg+idfyIePWzpKu7kyqZwb7bFfFMnGIEP6vZ3FQOOF+s/Wtl/BVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uh1f7CI/uElnPe3gx/kbNzkRBmgynrdIXwUkdCUpPsY=;
 b=cgf5GnjAvuQwrC9y7WcPS+q5vSWZwBYwYak3EHwXy0rS8BDJhXDJJgoJoK8jpBXTSXJ5v2I9ojP7qviV5M0X/cf8lxBXpMsqmAJqwrsleGVyIEsRVn2xiRPGivopVpj89xGWLOqRJQ5H/L2zKkKsHvgf7+OMbuV6YPl0SuDzZxeDR5NpNh1eML99tZqIxXAPMUQq1sh5RAA5jFGyx7oy8XvRLCPI0htXUXCnw4/1LeI4Qb2PDFr3sgk+1pyFtNt/QX/oyjwTd+wKJWvFkZ6FCHZDdvhA8xpI2P6zsZewjm+XCFW7Dw04Cis7T54wQG5ytcuK/SgBf+Bad9aK7nWETg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uh1f7CI/uElnPe3gx/kbNzkRBmgynrdIXwUkdCUpPsY=;
 b=eDg0tasF6sQw/Yw2ACUF/YcnKKK1HjthnP7G9RpsU4Y7OTeaChwUDfpEkm0yBto+MAd+dcMix2LU/V7xbIryxRIeb6MYegrSkE8XMQJ39BcMpePL6JMNiCNQS1yTiM8XJEMJ5BjS+vPoYGy5B4BBpO+RscRJtoNP0L7eh7GeeITdbpY3CO44JqPhIzQBgCEQcboTCfA32L8UH+o6mQ8ZwuEv6mbbiCtZ9Nyrk6NFj2RQkFgtR2JYCDq0e7SjmYkBSvKfRira6x++rwk3UuAjhM/WoFicb71mzhAtVLx+vj6G3BqUlaYGMm71P/2UKDr4cINJOLykGyJ+8FhZRTQ4RA==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by DM5PR12MB2408.namprd12.prod.outlook.com (2603:10b6:4:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Fri, 13 May
 2022 12:25:17 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::7526:b8f5:b10:1c4c]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::7526:b8f5:b10:1c4c%7]) with mapi id 15.20.5227.021; Fri, 13 May 2022
 12:25:16 +0000
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
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
Thread-Index: AQHYYzu4AtKVUSpJ7k+AnLFkxMXOCq0WR+MAgAAJZ4CAAaSUAIAAAZKAgAFo4YCAAHu4EIAC4DlA
Date:   Fri, 13 May 2022 12:25:16 +0000
Message-ID: <SJ0PR12MB567658E8F744F151278D9431A0CA9@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20220509002810.12412-1-bwicaksono@nvidia.com>
 <20220509092843.GB26264@willie-the-truck>
 <2e5e09f9-b71b-d936-e291-db8f94554b18@arm.com>
 <20220510110742.ievkihggndpms3fn@bogus>
 <20220510111318.GD27557@willie-the-truck>
 <6fcc2358-b029-fa01-cf06-aa040f53cf83@arm.com>
 <SJ0PR12MB56760A681243DE07AB7BD73CA0C89@SJ0PR12MB5676.namprd12.prod.outlook.com>
In-Reply-To: <SJ0PR12MB56760A681243DE07AB7BD73CA0C89@SJ0PR12MB5676.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c79645e3-1f51-47c6-6a4d-08da34dba328
x-ms-traffictypediagnostic: DM5PR12MB2408:EE_
x-microsoft-antispam-prvs: <DM5PR12MB2408768A32933520263B891BA0CA9@DM5PR12MB2408.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FbSxam5BBx7D/9u1GPcTVypCDd2pgvyGU68rFuY9elHqYvV1FwenmsAyXMIgl69gXw/uvyRaeCA3xhbzEYwRQwJEN6SIdQs5s9OmefIs7l91V3Yhoi9cPV0Nr50o5o8O0poiHM3dCpLBNyI/d1RIFM1+WUrH8OA+SgYj2kg8tb1VUbIFHb47sZsos8J2vd9VnuA0SM7nyCaa1p7fq+1CJFqXlHB4L08I3qrQ1JALAmLkMyB3Y+nvplQ3z8yDmkdSPgEbEcRG9+WwFt2CSHW/gRBiPMDtBVbKfAJs4PbyKKGwcFVJzG+mBUpCofFB9WQbr3+ddiWYr4vK4CKlXmcNtXorO/6WZdUi3F9WzVyEaGLHEk4Pz4tTZt3dvlViztZIkwkkA3nQeQiQCnVOqLP0bs72SIBOV7P6HQODw58UPdSN+/bW6PpiWBHVIlFhcHmEziZMzV957sv217kTcKPE9qXnl16J70OIJG5imIt80zoaES4WT50TE1PAOu2FiuKAr7RVdNH3LU6yA/Qpc4m3KpV2ZG+D4knLtD96eOpAahsXI8zSzTe8JssfZWZwbcrGZR0E1dgOfSoL+56QLrIqwoHn0icLYRt4QYICiNEZlB+Zw6BoQM6t8klw+onZWWZjxc9rk/R3sn5lSN9KFelwBkaOsAzSdih5ompEsqFjypWrpztHxfDk9pJeK9pZdVMmWuEHxo8pvuGzTlygnold+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38070700005)(7416002)(5660300002)(52536014)(122000001)(64756008)(66446008)(8676002)(2906002)(66476007)(66946007)(66556008)(76116006)(4326008)(26005)(33656002)(7696005)(316002)(55016003)(54906003)(86362001)(71200400001)(53546011)(8936002)(110136005)(83380400001)(186003)(9686003)(6506007)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUJ1bGhWT3dCSC9HbnNqQUlhUnQxa1VCUE55SFpMcGdnTVpWd2w0QjJaVGRG?=
 =?utf-8?B?SnBjanVON1FDbjRTVjFYQ0xmTHVOalhDNlNzS3lvc1dRUGo3QlFlbVJEWTBW?=
 =?utf-8?B?djE4VW12K2NOekMzb0dSa00yUGZYcUVCTkNjRnkvNHFBbG41VmphZEFDOUh3?=
 =?utf-8?B?TS9xeHUxQS9zMEFKU2dndGp3NFNXYjMwRUovVTF6ZjFpNXBnejhCSXhVVWZs?=
 =?utf-8?B?Nk1DN2djaXNNbFU1R25pRmlHWkZ2U2NZTTRlN3BGTHNUT0ZwVkMrZGorVEhF?=
 =?utf-8?B?ZW5pM09pVkczazdJRE8yTm9MNCtkNExoUFl6VFBlUXk5UzY5c2kxcVM4T1hw?=
 =?utf-8?B?aFJQdFdLeDlmV011UlhwZVhTQUxoaWJ5MGUrc1VjVlFYT3FTeDdjWlNvZ1Mw?=
 =?utf-8?B?V1ZXd09ycll2MzluTjBpWGxHUERJR1dPSjRJTG83REF6TUFKUWwyVWFrK1A0?=
 =?utf-8?B?b3VCSU5ScHRwVlh2M2ozQUd0OEU5aFBIbXZFNENqZzBabGxZeVN6Mjd5cmlY?=
 =?utf-8?B?NWhLRk1wZmNZSStWTGVWQzBNYjY5T1l0ODdJZXM4Yk1JbkN4dU5LZ0IrYVQx?=
 =?utf-8?B?M2Z6YzRmTFJGOU9GeVo0dExBR0xUcFg0UVNpNG9renAyVC92VVl3TFlkaEkw?=
 =?utf-8?B?V3cvVnN1Y3EzaXB5V2NuWFJRT3BtNHFUUFJUdnNUVEwxaDlqWUdSVGZ6eHdU?=
 =?utf-8?B?cWE2ZEFNTm5qdTluVEVBdDllMzZENnRQWDdaM0RxODFwRy92djUzaG1Gcm9T?=
 =?utf-8?B?RHNMOHBIRWxvNnBPT2d0dFJkSmlWQVF2eTQzSVdYdnlEUHRyUVVORmV4VWpm?=
 =?utf-8?B?SThFWnFDejdRZUJMM1VDUWFwVDMyaUM0QXJwNXMwTnIrNGh0RkFkdE95Rkwv?=
 =?utf-8?B?NDZCRzZYVTBwVVpGNUNVVGg0QUdxSi9HWGV3K0lFclFpYmt5ZlpYV1dFSTdr?=
 =?utf-8?B?b3JLdEJrL0hSM2Z6eDB0NFRnSUJoUFFsMzVseGNIalp6dVJvZVBHVlpsZ2Zh?=
 =?utf-8?B?akVKNW9raGFsNFBoYVlzcDJhY0M1Vk5OMzUzOHZrZGpmVkdsSXQ3SDJ0Zmk4?=
 =?utf-8?B?bkhxN2o5WmdnTkxGSHdPd0dBTTA5NFdPTWp5Tjc4TFJUc2dmYS9GWENEaExp?=
 =?utf-8?B?Y00rN0ZocHdhZXplR0lkWVViSmtheGhMNHNDOE05aVRNQm93UStHdmxiZnJa?=
 =?utf-8?B?WE9JOUFqMXRzWHg2NXo5cXRjelZrTUdZYis2ZkF6ODRLdEZ3OEd3RUpERXN4?=
 =?utf-8?B?cUdlb2xaRGZCYW1aNjRLMzQvdjJ4MXIxamM2T0hXMXdYdGx3a1RYOHNnb3p0?=
 =?utf-8?B?NXA1R1hsRmREUDBNTDBsOFZoaEpkZDQ5dndHV29hNERDcjlOaWtRMGxaaThG?=
 =?utf-8?B?K2RNUmdGV0pWK3VUZExiTWFRYkwyTlZFRCtKYVhjY2JtYThkNll4OHF3aEZo?=
 =?utf-8?B?VGtrdzU4QVJxN1BZV3FXWUU0Nld2MEJWVlltUW9Vc1VNRHh6NjlucEtGTUhy?=
 =?utf-8?B?YlNpOUFPVkpzUDJSUUd3bzl0aEJUbi9EdWtMcElYQzNQVi9nWTdQZVBvSGJC?=
 =?utf-8?B?c3B5QmdKRHJVWDNsNGZWQ3pUdktzdHJ6OUg2bTV0aE9EdXRoLzlhclcrSDkx?=
 =?utf-8?B?V0d5dUVpUS9MUng5YzhwMzMvdlpvOHJDREp4YmZzTm9SOHB5TlprZTFTUnJv?=
 =?utf-8?B?aVpUeUFVQlo1aUE5QnZNRHZJaThkOWpUUXFTTWswWmdsZUlWMjFmLzhWTXNa?=
 =?utf-8?B?ZVh4Ui8wbmJuRE1YbUR1c1J0UlFBZUcvRmU0TWtNeUtTQllkSitZbThrU2hO?=
 =?utf-8?B?OVRva1ZZQXgyNlFiaE5qUWxnQVhTaDR2ajBJTjEzelZBUGFjU2hLcTJVQ2NB?=
 =?utf-8?B?RkFFaURKa3labkVHL0VmMUZnSUlBK1U3bStHZHZSaGJNNURNN0NzQXM5QitY?=
 =?utf-8?B?dTZ1RVB4aFdQTUNFR3plTGlqYS91V2tFWGRSU1lXQXl0WE1WT3VrNTN1MUU0?=
 =?utf-8?B?WXVwbXBmSTZ5ZHMxVFZIbnN1a0lGb2xjWFJTNXRkQjBVd3Q4akF0dHNaVXNL?=
 =?utf-8?B?MjZ1eGhwWEt3bHM5VXRRbzJGSWRmd3FIRnZpS1JyL1N4SWVGUExBT214S2Jx?=
 =?utf-8?B?bW4vQmQvVmlxNmYrOTNHMHZZNkdqMXBtUERaMUJVdUpoSlV4VEcydVFWc3hB?=
 =?utf-8?B?YlFBdnJlT1R0N25qRUxWdkQ1THJnRnZtZVJiSmI3L09nTFdtMmJBS043Ui84?=
 =?utf-8?B?QStSaGxuRXc4U0VFYTRkUTZweks1UXZWcEhoWndlM2ZRaUEwZldpOTMxYVBv?=
 =?utf-8?B?S2tYWEtUWi9wRjFNd3h4Tmo2SzZXaHNtakFSdUVCN3Q3ZDUwZGxTUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c79645e3-1f51-47c6-6a4d-08da34dba328
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 12:25:16.5851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RMY1gQ2RMZffNyVox7mISU0uDo+5WOXy6/9OZk9EuYqgQrzqFI+FOhQRey3Qi5nvHmFuxQqWqB07qAQyKvyujA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2408
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmVzYXIgV2ljYWtzb25v
DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDExLCAyMDIyIDExOjQ1IEFNDQo+IFRvOiBTdXp1a2kg
SyBQb3Vsb3NlIDxzdXp1a2kucG91bG9zZUBhcm0uY29tPjsgV2lsbCBEZWFjb24NCj4gPHdpbGxA
a2VybmVsLm9yZz47IFN1ZGVlcCBIb2xsYSA8c3VkZWVwLmhvbGxhQGFybS5jb20+DQo+IENjOiBj
YXRhbGluLm1hcmluYXNAYXJtLmNvbTsgbWFyay5ydXRsYW5kQGFybS5jb207IGxpbnV4LWFybS0N
Cj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LQ0KPiB0ZWdyYUB2Z2VyLmtlcm5lbC5vcmc7IHRoYW51LnJhbmdhcmFqYW5AYXJt
LmNvbTsNCj4gTWljaGFlbC5XaWxsaWFtc0Bhcm0uY29tOyBUaGllcnJ5IFJlZGluZyA8dHJlZGlu
Z0BudmlkaWEuY29tPjsgSm9uYXRoYW4NCj4gSHVudGVyIDxqb25hdGhhbmhAbnZpZGlhLmNvbT47
IFZpa3JhbSBTZXRoaSA8dnNldGhpQG52aWRpYS5jb20+Ow0KPiBNYXRoaWV1IFBvaXJpZXIgPG1h
dGhpZXUucG9pcmllckBsaW5hcm8ub3JnPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIDAvMl0gcGVy
ZjogQVJNIENvcmVTaWdodCBQTVUgc3VwcG9ydA0KPiANCj4gDQo+IA0KPiA+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogU3V6dWtpIEsgUG91bG9zZSA8c3V6dWtpLnBvdWxv
c2VAYXJtLmNvbT4NCj4gPiBTZW50OiBXZWRuZXNkYXksIE1heSAxMSwgMjAyMiAzOjQ1IEFNDQo+
ID4gVG86IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+OyBTdWRlZXAgSG9sbGENCj4gPHN1
ZGVlcC5ob2xsYUBhcm0uY29tPg0KPiA+IENjOiBCZXNhciBXaWNha3Nvbm8gPGJ3aWNha3Nvbm9A
bnZpZGlhLmNvbT47DQo+IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOw0KPiA+IG1hcmsucnV0bGFu
ZEBhcm0uY29tOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0K
PiA+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXRlZ3JhQHZnZXIua2VybmVsLm9yZzsN
Cj4gPiB0aGFudS5yYW5nYXJhamFuQGFybS5jb207IE1pY2hhZWwuV2lsbGlhbXNAYXJtLmNvbTsg
VGhpZXJyeSBSZWRpbmcNCj4gPiA8dHJlZGluZ0BudmlkaWEuY29tPjsgSm9uYXRoYW4gSHVudGVy
IDxqb25hdGhhbmhAbnZpZGlhLmNvbT47IFZpa3JhbQ0KPiA+IFNldGhpIDx2c2V0aGlAbnZpZGlh
LmNvbT47IE1hdGhpZXUgUG9pcmllciA8bWF0aGlldS5wb2lyaWVyQGxpbmFyby5vcmc+DQo+ID4g
U3ViamVjdDogUmU6IFtQQVRDSCAwLzJdIHBlcmY6IEFSTSBDb3JlU2lnaHQgUE1VIHN1cHBvcnQN
Cj4gPg0KPiA+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0
dGFjaG1lbnRzDQo+ID4NCj4gPg0KPiA+IE9uIDEwLzA1LzIwMjIgMTI6MTMsIFdpbGwgRGVhY29u
IHdyb3RlOg0KPiA+ID4gT24gVHVlLCBNYXkgMTAsIDIwMjIgYXQgMTI6MDc6NDJQTSArMDEwMCwg
U3VkZWVwIEhvbGxhIHdyb3RlOg0KPiA+ID4+IE9uIE1vbiwgTWF5IDA5LCAyMDIyIGF0IDExOjAy
OjIzQU0gKzAxMDAsIFN1enVraSBLIFBvdWxvc2Ugd3JvdGU6DQo+ID4gPj4+IENjOiBNaWtlIFdp
bGxpYW1zLCBNYXRoaWV1IFBvaXJpZXINCj4gPiA+Pj4gT24gMDkvMDUvMjAyMiAxMDoyOCwgV2ls
bCBEZWFjb24gd3JvdGU6DQo+ID4gPj4+PiBPbiBTdW4sIE1heSAwOCwgMjAyMiBhdCAwNzoyODow
OFBNIC0wNTAwLCBCZXNhciBXaWNha3Nvbm8gd3JvdGU6DQo+ID4gPj4+Pj4gICAgYXJjaC9hcm02
NC9jb25maWdzL2RlZmNvbmZpZyAgICAgICAgICAgICAgICAgIHwgICAgMSArDQo+ID4gPj4+Pj4g
ICAgZHJpdmVycy9wZXJmL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgMiAr
DQo+ID4gPj4+Pj4gICAgZHJpdmVycy9wZXJmL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgICAgMSArDQo+ID4gPj4+Pj4gICAgZHJpdmVycy9wZXJmL2NvcmVzaWdodF9wbXUvS2Nv
bmZpZyAgICAgICAgICAgIHwgICAxMCArDQo+ID4gPj4+Pj4gICAgZHJpdmVycy9wZXJmL2NvcmVz
aWdodF9wbXUvTWFrZWZpbGUgICAgICAgICAgIHwgICAgNyArDQo+ID4gPj4+Pj4gICAgLi4uL3Bl
cmYvY29yZXNpZ2h0X3BtdS9hcm1fY29yZXNpZ2h0X3BtdS5jICAgIHwgMTMxNw0KPiA+ICsrKysr
KysrKysrKysrKysrDQo+ID4gPj4+Pj4gICAgLi4uL3BlcmYvY29yZXNpZ2h0X3BtdS9hcm1fY29y
ZXNpZ2h0X3BtdS5oICAgIHwgIDE0NyArKw0KPiA+ID4+Pj4+ICAgIC4uLi9jb3Jlc2lnaHRfcG11
L2FybV9jb3Jlc2lnaHRfcG11X252aWRpYS5jICB8ICAzMDAgKysrKw0KPiA+ID4+Pj4+ICAgIC4u
Li9jb3Jlc2lnaHRfcG11L2FybV9jb3Jlc2lnaHRfcG11X252aWRpYS5oICB8ICAgMTcgKw0KPiA+
ID4+Pj4+ICAgIDkgZmlsZXMgY2hhbmdlZCwgMTgwMiBpbnNlcnRpb25zKCspDQo+ID4gPj4+Pg0K
PiA+ID4+Pj4gSG93IGRvZXMgdGhpcyBpbnRlcmFjdCB3aXRoIGFsbCB0aGUgc3R1ZmYgd2UgaGF2
ZSB1bmRlcg0KPiA+ID4+Pj4gZHJpdmVycy9od3RyYWNpbmcvY29yZXNpZ2h0Lz8NCj4gPiA+Pj4N
Cj4gPiA+Pj4gQWJzb2x1dGVseSB6ZXJvLCBleGNlcHQgZm9yIHRoZSBuYW1lLiBUaGUgc3RhbmRh
cmQNCj4gPiA+Pj4gaXMgbmFtZWQgIkNvcmVTaWdodCBQTVUiIHdoaWNoIGlzIGEgYml0IHVuZm9y
dHVuYXRlLA0KPiA+ID4+PiBnaXZlbiB0aGUgb25seSBsaW5rLCBBRkFJVSwgd2l0aCB0aGUgIkNv
cmVTaWdodCIgYXJjaGl0ZWN0dXJlDQo+ID4gPj4+IGlzIHRoZSBMb2NrIEFjY2VzcyBSZWdpc3Rl
cihMQVIpLiBGb3IgcmVmZXJlbmNlLCB0aGUNCj4gPiA+Pj4gZHJpdmVycy9od3RyYWNpbmcvY29y
ZXNpZ2h0LyBpcyBwdXJlbHkgIkNvcmVTaWdodCIgc2VsZi1ob3N0ZWQNCj4gPiA+Pj4gdHJhY2lu
ZyBhbmQgdGhlIFBNVSBpcyBjYWxsZWQgImNzX2V0bSIgKGV4cGFuZHMgdG8gY29yZXNpZ2h0IGV0
bSkuDQo+ID4gPj4+IE90aGVyd2lzZSB0aGUgc3RhbmRhcmQgZG9lc24ndCBoYXZlIGFueXRoaW5n
IHRvIGRvIHdpdGggd2hhdA0KPiA+ID4+PiBleGlzdHMgYWxyZWFkeSBpbiB0aGUga2VybmVsLg0K
PiA+ID4NCj4gPiA+IFRoYXQncy4uLiBhIHBvb3IgbmFtaW5nIGNob2ljZSEgQnV0IGdvb2QsIGlm
IGl0J3MgZW50aXJlbHkgc2VwYXJhdGUgdGhlbiBJDQo+ID4gPiBkb24ndCBoYXZlIHRvIHdvcnJ5
IGFib3V0IHRoYXQuIEp1c3Qgd2FudGVkIHRvIG1ha2Ugc3VyZSB3ZSdyZSBub3QNCj4gZ29pbmcN
Cj4gPiB0bw0KPiA+ID4gZ2V0IHRhbmdsZWQgdXAgaW4gdGhpbmdzIGxpa2UgUk9NIHRhYmxlcyBh
bmQgQ29yZXNpZ2h0IHBvd2VyIGRvbWFpbnMgZm9yDQo+ID4gPiB0aGVzZSB0aGluZ3MuDQo+ID4g
Pg0KPiA+ID4+PiBPbmUgcG90ZW50aWFsIHJlY29tbWVuZGF0aW9uIGZvciB0aGUgbmFtZSBpcywg
IkFybSBQTVUiICAoVGhlDQo+IEFDUEkNCj4gPiB0YWJsZSBpcw0KPiA+ID4+PiBuYW1lZCBBcm0g
UE1VIFRhYmxlKS4gQnV0IHRoZW4gdGhhdCBjb3VsZCBiZSBjbGFzaGluZyB3aXRoIHRoZQ0KPiA+
IGFybXY4X3BtdQ0KPiA+ID4+PiA6LSguDQo+ID4gPj4+DQo+ID4gPj4+IFNvbWUgb2YgdGhlIG90
aGVyIG9wdGlvbnMgYXJlIDoNCj4gPiA+Pj4NCj4gPiA+Pj4gIkFybSBHZW5lcmljIFBNVSINCj4g
PiA+Pj4gIkFybSBVbmNvcmUgUE1VIg0KPiA+ID4+DQo+ID4gPj4gSSB3YXNuJ3Qgc3VyZSBvbiB0
aGlzIGlmIHRoZXJlIGlzIGFueSByZXN0cmljdGlvbiBvbiB1c2FnZSBvZiB0aGlzIG9uIEFybQ0K
PiA+ID4+IGFuZCBoZW5jZSBkaWRuJ3QgbWFrZSB0aGUgc3VnZ2VzdGlvbi4gQnV0IGlmIGFsbG93
ZWQsIHRoaXMgd291bGQgYmUgbXkNCj4gPiA+PiBjaG9pY2UgdG9vLg0KPiA+ID4NCj4gPiA+IFdl
J2QgdGFrZW4gdG8gY2FsbGluZyB0aGVtICJTeXN0ZW0iIFBNVVMgaW4gdGhlIHBhc3QsIHNvIG1h
eWJlIGp1c3QNCj4gc3RpY2sNCj4gPiA+IHdpdGggdGhhdD8gSSB0aGluayAiVW5jb3JlIiBpcyBJ
bnRlbCB0ZXJtaW5vbG9neSBzbyBpdCdzIHByb2JhYmx5IGJlc3QgdG8NCj4gPg0KPiA+IEkgdGhv
dWdodCBhYm91dCB0aGF0LCBidXQgdGhlcmUgYXJlIHNvbWUgSVBzIG5hbWVkICJTeXN0ZW0gUHJv
ZmlsZXJzIg0KPiA+IChlLmcuLCBvbiBKdW5vIGJvYXJkKSB3aGljaCBjb3VsZCBiZSBlYXNpbHkg
Y29uZnVzZWQuIEJ1dCBJIGhvcGUgdGhlaXINCj4gPiBwb3B1bGF0aW9uIGluIHRoZSBuYW1lIHNw
YWNlIGlzIG11Y2ggbGVzcy4gU28sIEkgYW0gaGFwcHkgd2l0aCB0aGF0DQo+ID4gY2hvaWNlLiBU
aGUgb25seSBvdGhlciBjb25jZXJuIGlzLCBpdCBkb2Vzbid0IGluZGljYXRlIGl0IHN1cHBvcnRz
IFBNVXMNCj4gPiB0aGF0IGFyZSBjb21wbGlhbnQgdG8gYSBnaXZlbiBBcm0gU3RhbmRhcmQuIGku
ZS4sIHBlb3BsZSBjb3VsZCB0aGluayBvZg0KPiA+IHRoaXMgYXMgYSAic2luZ2xlIHR5cGUiIG9m
IFBNVS4NCj4gPiBTbywgSSBhbSB3b25kZXJpbmcgaWYgc29tZXRoaW5nIGxpa2UgIkFybSBTdGFu
ZGFyZCBQTVUiIG1ha2VzIGFueQ0KPiBzZW5zZSA/DQo+ID4NCj4gPiBBbHNvLCBJIGhvcGUgdGhl
IGRyaXZlcnMgd291bGQgY2hvb3NlIGEgbmFtZSBpbmRpY2F0aW5nIHRoZSAidHlwZSIgIC0NCj4g
PiA8dmVuZG9yPl88dHlwZT5fcG11IChlLmcuLCBudmlkaWFfcGNpZV9wbXUsIGFybV9zbW11djNf
cG11IGV0YykNCj4gPiB3aGlsZQ0KPiA+IHJlZ2lzdGVyaW5nIHRoZWlyIFBNVS4gVGhhdCB3YXkg
aXQgaXMgY2xlYXJlciBmb3IgdGhlIFBNVSB3aGlsZSB0aGUNCj4gPiBiYXNlIGRldmljZSBjb3Vs
ZCBiZSBhcm1fc3lzdGVtX3BtdV8wIGV0Yy4NCj4gDQo+IEZyb20gdGhlIG90aGVyIFBNVSBkcml2
ZXJzLCB0aGUgcmVnaXN0ZXJlZCBuYW1lIG1heSBoYXZlIGFkZGl0aW9uYWwNCj4gcHJvcGVydGll
cw0KPiBzcGVjaWZpYyB0byB0aGUgaW1wbGVtZW50YXRpb24sIGUuZy4gc29ja2V0LCBjbHVzdGVy
IGlkLCBpbnN0YW5jZSBudW1iZXIsDQo+IG1lbW9yeQ0KPiBhZGRyZXNzLCBjYWNoZSBsZXZlbC4g
U2luY2UgdGhpcyBpcyBhIHNoYXJlZCBkcml2ZXIsIG15IGluaXRpYWwgdGhvdWdodCBpcyB0bw0K
PiByZWdpc3Rlcg0KPiBhIGRlZmF1bHQgYXJtX2NvcmVzaWdodF9wbXU8QVBNVCBub2RlIGlkPiBu
YW1pbmcgZm9ybWF0IGZvcg0KPiBjb25zaXN0ZW5jeSBhbmQNCj4gImlkZW50aWZpZXIiIHN5c2Zz
IG5vZGUgdG8gZGlzdGluZ3Vpc2ggdGhlIFBNVXMuIElmIGFuIGltcGxlbWVudGF0aW9uIG5lZWRz
DQo+IHRvDQo+IGV4cG9zZSBtb3JlIGRldGFpbHMgYWJvdXQgdGhlIFBNVSwgaXQgY2FuIGJlIGNv
bW11bmljYXRlZCB2aWEgYWRkaXRpb25hbA0KPiBzeXNmcyBhdHRyaWJ1dGVzLg0KDQpIaSBXaWxs
IGFuZCBTdXp1a2ksDQoNClNoYWxsIHdlIGdvIGFoZWFkIHdpdGggImFybV9zeXN0ZW1fcG11IiBm
b3IgdGhlIGRldmljZSBuYW1lID8NCg0KPiANCj4gUmVnYXJkcywNCj4gQmVzYXINCg==
