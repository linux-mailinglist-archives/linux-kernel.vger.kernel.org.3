Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4737A58DD55
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 19:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244787AbiHIRjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 13:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiHIRjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:39:07 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10C1255BE;
        Tue,  9 Aug 2022 10:39:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpG/tDgtmVDEp28CAzIwZT0+rCzEle66/2EBj9XBid9a9cSLhzV7byJT+KI80QB9WCn70mcxYgbgMi9KeX1legsiIRBEdTlHf+FM9CrEAmjDtMfJsvWJ1s3V34I/iO2hbli/ybNtT6ryMXxOqLWyV4CXclUDaCEDqDp+2PAkCmIHnyFQThIPFAVKWH9DzhCo2dVmXyGspUmDvCFAtnxeo1T1m0FlxtEsfzgy8FhZ9ITAqGRy8L9Eoyvd5AN5GK0kPuov7hPL5+PC44lysl0ndLRctffEznbnVI+pqUQw9QKgxbMAoJSIrcBa1Bsyvc/HbZcWh6ud1aMDoEjpEYu8NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLV14mj0/0mXeefnwoAow5rwLx59edsoQh5dISG5MWU=;
 b=Ch+SppnA5XxIuZfbg/gndoLvDRgjE2ixyIu4hFtoJ+o/ZP6ywXBDvbOD305BXBeMIVCdotDruDUUzdU2jxH3HCXWzaZrzW82dDn316cy5J+HOkBa2SZZjMDQx/mZp/18X4O4dwQzq2NOo2KiKTPC7Bfrdb/d7SIYePjLUnQeVJ5AZDv2YES1CslNAFTqMtVBx35BzhG9wNGjzZz4Nx5g9IITGRIhPInq48as6/jvm5caIJ2Ci2VM8LC7TugsTvcY5tY9diO7vYggSf+U9eGMkiGhZ0kdUMBxYlAMOYTu9uUCNZTUYo2rqGjHTwOhxHVYegr5NwQTENFazL2CbeQo1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLV14mj0/0mXeefnwoAow5rwLx59edsoQh5dISG5MWU=;
 b=oqC9/MmvgP2L+T4NnHe29YDzfgY17HmJPRXYm9ptyV1mRFJkqeJOHcqTkMLrHmFEHpdO7GzX7seacVUMlbnLGiPTg3iONVFhkZeClj/xc+dKI0lzgBHHfxH7KP8UyePSbqEs6bNJe831gO7AXWChvfo1G39ULzvy45zawsJ408xAgCGn9CfNdnKpHSwExrZMMxTWiOEcpLbJmDapMyAc4J0CpDMliY9MwHKj68REdr+b8ngofjD45aPXIOQJjjy3TwKgSlpKkx4+XNMqO7av6a02hR41aDa9nlo5HNcuCwZKTobbbPDIFh+LCJEyZbxDK76kLZqMVegBWs0hsYTdnQ==
Received: from BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21)
 by DM4PR12MB5183.namprd12.prod.outlook.com (2603:10b6:5:396::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 9 Aug
 2022 17:39:04 +0000
Received: from BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::f93a:de47:47ae:d930]) by BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::f93a:de47:47ae:d930%9]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 17:39:03 +0000
From:   Liming Sun <limings@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Woods <davwoods@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] mmc: sdhci-of-dwcmshc: add ACPI match data for
 BlueField-3 SoC
Thread-Topic: [PATCH v2] mmc: sdhci-of-dwcmshc: add ACPI match data for
 BlueField-3 SoC
Thread-Index: AQHYqqA4vWEEm0Tz50mTPfHMbMWVj62kq8EAgAIshBA=
Date:   Tue, 9 Aug 2022 17:39:03 +0000
Message-ID: <BN9PR12MB506817B7C4BBAD6112D1124BD3629@BN9PR12MB5068.namprd12.prod.outlook.com>
References: <3a50873fdbf69f4a95b931a5d05cade04c1dacd0.1659099154.git.limings@nvidia.com>
 <20220807205630.251939-1-limings@nvidia.com>
 <2b720211-a472-19ac-a281-9284e9d63e03@intel.com>
In-Reply-To: <2b720211-a472-19ac-a281-9284e9d63e03@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c1a4314-5c18-4bf0-1364-08da7a2e0d7a
x-ms-traffictypediagnostic: DM4PR12MB5183:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: He+eUX2UYw/sGtTIJIno8SU8aSPSQlx9sKEC6Gg/GvGO7cwZ7neCLAdSYcGuV6f5omsqAhp+n6fetZ6PjDRmNQK3Nnwuy0dEPxJ0crVWm0JHZxxOtWYs1WyqvptBXFW40gbNlczigsJb4Z0G7w2aiheNe6Re4pqmydQr8/mm/uSh7MlojWVihm4ua82NSFNCAcb+ihzvQkCsONwVqZk3beoH8fq9Sqcmw0znwHTZ5uewz1VHeDeNB0sn2xW+ooyAb8DFeS7S6qTN+3CARnjmzv2odxL9rKgbgy9W4QfdYqmoA9teYlNGjrCEL8dxDxXSDIHPrQTmbz6pG+eCgYk/IxVMZ9c2RN8AkAQk+Ou6QT7xzb4gmgpuqk/JAekjj3b6zRl2ZJz2+DSm43/oogwaF3wx4j55FaQOCpxd+My/icaj/P9KST4XIVh2UpZjJBPxdHn+H1on8kD7q97EPF02jTUa23a02mUXdWta7eVPDhz4IbT11s4xlEPwLLedbJpTTdRTCdXjXcOf+EpN36u9DEnOtPc1zvevNI8Bhf2/PiFoM7Nx5C3XYMZQAVBPxpffS8mMYfP55Bvwj5eZQtenimypCEnwi91h9z+AQJhqVo4hFbrqumovyg9HWX4XhJt4PH4cMWGFooS5FDvOi8urNHyEt9xcv+wGsuw7CXL80yT+yIhPPInk/s1yhLF0/3PEMbIt4Tc0R0cEw5IzuuKRD610+ETr3yxCLt6ZlE/Fb+iZvRRvmKlug7A4Qx2SlZ/br1QZbP3aeUTU+8p+j6T3thuHOEtV1TzHxSJY8SyJcW76cCjirFqpDYKBesZQTQXXe7TN291qUuLH7UMr3MlJ/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5068.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(71200400001)(478600001)(41300700001)(55016003)(2906002)(33656002)(86362001)(54906003)(110136005)(316002)(186003)(38070700005)(38100700002)(9686003)(26005)(53546011)(6506007)(7696005)(83380400001)(8936002)(52536014)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(8676002)(4326008)(5660300002)(122000001)(133343001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0tnNVJuaElzeEJSRllUd0hCRkkwM0Mvc1dQdXFTUlhBd1ZaUmE1WThqVlpS?=
 =?utf-8?B?ZExIY0tMQ2VWcWVLVU5EMnUwU2JrNk9BYmxhZ2lGZGo5UjNUd2Y2clduaFVq?=
 =?utf-8?B?c1ZZQVRobHFqVnJtRkxSKzVNbjRFK2JUQkJrQ0h4aGZ6SmU0U1VPcW1aeDlM?=
 =?utf-8?B?clRnUDA1UUJhWEcxN3ZLNEg1RjFjQW93MWFvMmZtSC9MU253aDJQOG1GdkM0?=
 =?utf-8?B?L0RyOWNxaTNJbmcvWEt2VDBTY0FkNklyNW1DeWlSTFpNVExSbXR6ZmJ4TEM4?=
 =?utf-8?B?RXphTzRtd2xQOU1sUFlSYVcrdVVRL2REZ0g0elRRa1E0Nnk2Rk13MzRmOG1u?=
 =?utf-8?B?aE5JaG43Q2lNa0RsbFRDTFczemhzYkNNbG9yaFpVVzJvQ0tLY0FBSGhheFFa?=
 =?utf-8?B?NWxUUUJQUDlWaFUvRXZpS0tVRUhqUXNybWJoMWxHNkVhOGNSc0pBN01McW5I?=
 =?utf-8?B?aTNCNEtCRDVScjBmSzRmenI0ZldacVg5SnJ0Z3NIWDBLWUJZd1hIekczdUJC?=
 =?utf-8?B?UlM4cDNCdzlGbE00S3NPK3VvRnlUS1JLZUxEc3RiNVpxN1pDcVJMcFBWc291?=
 =?utf-8?B?dnZ4dWZWQ1pSRU5VaUw2RDlpNCt6YlE1UmxEcitNVG5EYS9ZOGFYNHlUdUI3?=
 =?utf-8?B?L3hOWHdMbHZEMVRxc1FoZGVpWWRraEdZNWpITGM1ejVwdVUyZVRLbkFkODlq?=
 =?utf-8?B?R3luMlgvQVZDRG5ZMjhjUXk5a2ZWY3BsVFVoYzRWbDE3dm5kRnBBTEhOTUJP?=
 =?utf-8?B?VUNRWGZiTXF6bStyNUZsM2pwVG5EUDViSWZZaTVtdllMcHJhaEZHWWlZc1J0?=
 =?utf-8?B?ckI1Q1hGVEFKalVQSUZrbHZjWDB4dGRNTDhGTzZjQW15cVpsTGhKNmZlWHVt?=
 =?utf-8?B?SmxEeVBsUHYzYnloTGtGVW1ZR1EvMFhkdmRqZGRKdkVLeUxkZlFzM0Q4ay90?=
 =?utf-8?B?TWlJU2ppaVE2aEJpS1FZY3RGR3lWWDA3M1IzZHZ5ZzhPc1AvVHI0aW9ZL3dC?=
 =?utf-8?B?SzFUWGVFWDFtWEZKZ1ZLd09BSHMvUjFtTWZrMXZ6d09RS3E4QlRLQmFYbkNR?=
 =?utf-8?B?UUp6SjZZM1cyY0tqejNsNjBzd0Q2Mlc1dWxhaDh5M3NnYUJCTXZjYTAwYVFz?=
 =?utf-8?B?QUdqR1pMTjVUUHNFNmZOTHdobXFjWUVrM2tlTkxVVFRjNno5UnMvZFdYZ0Zr?=
 =?utf-8?B?dGZVUm5nQlR3MTZlS0N3bWMwZ3lVUkxxVys2WVZGdGhENnBrWnFIV09MaHFY?=
 =?utf-8?B?cXo1eU5SVnNGV0tjTXdxQ1BBMHRQWGVTcmRuRG1OVlhWZEJOTkFLeXJxWWJI?=
 =?utf-8?B?bWQ2WVFCSGFiWWZFeXNxMnlxU3pUcWVEdnVoUkpqc1RnV012a1FnNGxWZVpL?=
 =?utf-8?B?WkhuWkw1N09hM3lhZFNXdlBJMXp0eTJJd09wTWNwc2haN0RrSFRXS0FnR3Zs?=
 =?utf-8?B?TUZnU1pCMVdDcitMamRaYXdzSFBGVE93VXFSdzRDT0tkQzVqU0x4WGU2OFJF?=
 =?utf-8?B?eHRYOCtOQlZSaVMzeXNBanB1N1VrUjVVdXBPR24vSFJ0Zjg3THEvUWl3UDFi?=
 =?utf-8?B?bzMwUGh6ZUFKeW1HOVVYRlBubTNXSG8ybVVjRWpRVVlUU3FvVlRodXV0eG5S?=
 =?utf-8?B?R2t5L0liWkViYlUvbXBQTXFxaHNzTExlcDFOZDBJMUpDV09IYVpVUHhRNUQ4?=
 =?utf-8?B?S1J3UVdueWJjQnN6bGl6K0RackZGaDBtSlJ2eHZ2emNQV0RHOFBNckhzRlFP?=
 =?utf-8?B?UkVBYlZCd05UV3Y1TVJlYmxNN2VHc0E3KzFaSlhJSXg1YkVraTh0SlJUK05u?=
 =?utf-8?B?ZTBSVk41a2kwalFtbHE2dkVzNDBabG5TQUk1bzNlZGxSL3IzVmNLV0tWMlhy?=
 =?utf-8?B?aE5JMVNrMDZ2SFk4WExkNy9xNTBrQ05yaU8zMEx4dEVBT1BSOUEyTXZtV2pq?=
 =?utf-8?B?RHdKMXFFKzVzN2ZOVlZrZjJ6V3RGUy82OVFEK09TVitXWm5RK2FoeWpFOWdh?=
 =?utf-8?B?QUVKZjFtTzJJL1p3dFRpL1NnY2VHVGd1TDM1MDNTN282aXZHbjcrRng0RkQx?=
 =?utf-8?B?dFFLRXZudEZVQTNkTVV1eTFHbmFOS0dXV3FaTjhtWWYzRnFHUGxYRWtRdnRL?=
 =?utf-8?Q?qi4FLdEy1vyzn/yPZzh/TWybY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5068.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1a4314-5c18-4bf0-1364-08da7a2e0d7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 17:39:03.9222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j5OA53rzvl5TUomzwhlcTX5s86ps/H9I3RHxjdLuoZhp65daq9943lYBXIeHwwh/5lCx5DvGh1aQ2k7mR3moAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5183
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzLiBEb25lIGFuZCByZWJhc2VkIHRvIG1tYyAnbmV4dCcgaW4gcGF0Y2ggdjMuDQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWRyaWFuIEh1bnRlciA8YWRyaWFu
Lmh1bnRlckBpbnRlbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgQXVndXN0IDgsIDIwMjIgNDoyNiBB
TQ0KPiBUbzogTGltaW5nIFN1biA8bGltaW5nc0BudmlkaWEuY29tPjsgVWxmIEhhbnNzb24gPHVs
Zi5oYW5zc29uQGxpbmFyby5vcmc+Ow0KPiBEYXZpZCBXb29kcyA8ZGF2d29vZHNAbnZpZGlhLmNv
bT47IFNoYXduIExpbiA8c2hhd24ubGluQHJvY2stDQo+IGNoaXBzLmNvbT4NCj4gQ2M6IGxpbnV4
LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2Ml0gbW1jOiBzZGhjaS1vZi1kd2Ntc2hjOiBhZGQgQUNQSSBtYXRj
aCBkYXRhIGZvcg0KPiBCbHVlRmllbGQtMyBTb0MNCj4gDQo+IE9uIDcvMDgvMjIgMjM6NTYsIExp
bWluZyBTdW4gd3JvdGU6DQo+ID4gQ29tbWl0IDA4ZjNkZmY3OTlkNDMgaW50cm9kdWNlcyB0aGUg
b2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKCkNCj4gPiBjaGVja2luZyBmb3Igc29tZSBjaGlwIGJ1
dCBicmVha3MgdGhlIEJsdWVGaWVsZC0zIGZpcm13YXJlIHdoaWNoDQo+ID4gdXNlcyBBQ1BJIGlu
c3RlYWQuIFRoaXMgY29tbWl0IGFkZHMgdGhlIEFDUEkgbWF0Y2ggZGF0YSBhbmQNCj4gPiBxdWly
a3MvcXVpcmtzMiB0byByZS1lbmFibGUgdGhlIHN1cHBvcnQgb2YgQmx1ZUZpZWxkLTMgU29DLg0K
PiA+DQo+ID4gUmV2aWV3ZWQtYnk6IERhdmlkIFdvb2RzIDxkYXZ3b29kc0BudmlkaWEuY29tPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IExpbWluZyBTdW4gPGxpbWluZ3NAbnZpZGlhLmNvbT4NCj4gDQo+
IFBsZWFzZSByZS1iYXNlIHRoaXMgcGF0Y2ggYmVjYXVzZSBpdCBkb2VzIG5vdCBhcHBseSB0bw0K
PiBsYXRlc3QgbW1jICJuZXh0IiBicmFuY2guDQo+IA0KPiA+IC0tLQ0KPiA+IHYxLT52MjoNCj4g
PiAgICAgRml4ZXMgYW4gYWNwaSB3YXJuaW5nDQo+ID4gICAgIFJlcG9ydGVkLWJ5OiBrZXJuZWwg
dGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gPiB2MTogSW5pdGlhbCB2ZXJzaW9uLg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWR3Y21zaGMuYyB8IDE2ICsrKysr
KysrKysrKysrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1v
Zi1kd2Ntc2hjLmMNCj4gYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWR3Y21zaGMuYw0KPiA+
IGluZGV4IGJhYzg3NGFiMGIzMy4uYTBjNzNkZGFhYWE0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvbW1jL2hvc3Qvc2RoY2ktb2YtZHdjbXNoYy5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvaG9z
dC9zZGhjaS1vZi1kd2Ntc2hjLmMNCj4gPiBAQCAtMjc5LDYgKzI3OSwxNSBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IHNkaGNpX3BsdGZtX2RhdGENCj4gc2RoY2lfZHdjbXNoY19wZGF0YSA9IHsNCj4g
PiAgCS5xdWlya3MyID0gU0RIQ0lfUVVJUksyX1BSRVNFVF9WQUxVRV9CUk9LRU4sDQo+ID4gIH07
DQo+ID4NCj4gPiArI2lmZGVmIENPTkZJR19BQ1BJDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
c2RoY2lfcGx0Zm1fZGF0YSBzZGhjaV9kd2Ntc2hjX2JmM19wZGF0YSA9IHsNCj4gPiArCS5vcHMg
PSAmc2RoY2lfZHdjbXNoY19vcHMsDQo+ID4gKwkucXVpcmtzID0gU0RIQ0lfUVVJUktfQ0FQX0NM
T0NLX0JBU0VfQlJPS0VOLA0KPiA+ICsJLnF1aXJrczIgPSBTREhDSV9RVUlSSzJfUFJFU0VUX1ZB
TFVFX0JST0tFTiB8DQo+ID4gKwkJICAgU0RIQ0lfUVVJUksyX0FDTUQyM19CUk9LRU4sDQo+ID4g
K307DQo+ID4gKyNlbmRpZg0KPiA+ICsNCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBzZGhjaV9w
bHRmbV9kYXRhIHNkaGNpX2R3Y21zaGNfcmszNTY4X3BkYXRhID0gew0KPiA+ICAJLm9wcyA9ICZz
ZGhjaV9kd2Ntc2hjX3JrMzU2OF9vcHMsDQo+ID4gIAkucXVpcmtzID0gU0RIQ0lfUVVJUktfQ0FQ
X0NMT0NLX0JBU0VfQlJPS0VOIHwNCj4gPiBAQCAtMzM2LDcgKzM0NSwxMCBAQCBNT0RVTEVfREVW
SUNFX1RBQkxFKG9mLA0KPiBzZGhjaV9kd2Ntc2hjX2R0X2lkcyk7DQo+ID4NCj4gPiAgI2lmZGVm
IENPTkZJR19BQ1BJDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYWNwaV9kZXZpY2VfaWQgc2Ro
Y2lfZHdjbXNoY19hY3BpX2lkc1tdID0gew0KPiA+IC0JeyAuaWQgPSAiTUxOWEJGMzAiIH0sDQo+
ID4gKwl7DQo+ID4gKwkJLmlkID0gIk1MTlhCRjMwIiwNCj4gPiArCQkuZHJpdmVyX2RhdGEgPSAo
a2VybmVsX3Vsb25nX3QpJnNkaGNpX2R3Y21zaGNfYmYzX3BkYXRhLA0KPiA+ICsJfSwNCj4gPiAg
CXt9DQo+ID4gIH07DQo+ID4gICNlbmRpZg0KPiA+IEBAIC0zNTIsNyArMzY0LDcgQEAgc3RhdGlj
IGludCBkd2Ntc2hjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ID4g
IAlpbnQgZXJyOw0KPiA+ICAJdTMyIGV4dHJhOw0KPiA+DQo+ID4gLQlwbHRmbV9kYXRhID0gb2Zf
ZGV2aWNlX2dldF9tYXRjaF9kYXRhKCZwZGV2LT5kZXYpOw0KPiA+ICsJcGx0Zm1fZGF0YSA9IGRl
dmljZV9nZXRfbWF0Y2hfZGF0YSgmcGRldi0+ZGV2KTsNCj4gPiAgCWlmICghcGx0Zm1fZGF0YSkg
ew0KPiA+ICAJCWRldl9lcnIoJnBkZXYtPmRldiwgIkVycm9yOiBObyBkZXZpY2UgbWF0Y2ggZGF0
YSBmb3VuZFxuIik7DQo+ID4gIAkJcmV0dXJuIC1FTk9ERVY7DQoNCg==
