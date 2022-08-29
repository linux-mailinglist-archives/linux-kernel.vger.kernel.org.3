Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E2E5A4AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiH2MBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiH2MBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:01:10 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5D6868A1;
        Mon, 29 Aug 2022 04:46:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmnmTzI7AG6YQvm8VQCIDRCy1SEpF6iSAvjmPHG5x9TdMindComGr45xtn2AnOQWAbe7E1ZCJOE0ycrygyZDM9TyNAFkPhXNkrDrK2h3e/q+MJIXoQPxDv/1wdZsgCdHqk4H1iafgXd0BXURiTLP4dpSJn+0cg/PVetwDKQL922nRQdt5s499vDxxJA4OxUNns9dXacLlKqaxbnSAcFGyE6uKKOufMR63X1ebVwIVj1iNVwetyJ6qsAU7F/0uVUmtW8yftDohrn3DHaE0PtUuQkF2JxWEaLo/UHBvV7DltD3FdxiGAOkkBSjtbS0jpdP7i/z5kiUmw5KVhiclUpVIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hukz6m3n05GKuFyVlXApm5zN5Ep7/LtvcalZKIcrC8=;
 b=dPZi9YKQKBnWsrKFLjgNGQsAWUJiMMBjJPoJ81OqYvwMMxS7TY6HTtK7ZLFbmMlCmxfwdmAnYzydLliZojBnpJSWxzdQZKPXXyJaASrFZcenQwae/Pp+CVHtDb+utrnOgw+ZtPE9F4yNIom4jHhU2ldgRNpLI7LhI+7uvsdkbBa/sfL0mQpNXYvO8OX9y6HNwhdSfppB03/LxZ9q2+vmCUdjPledRbKxi7BMBMh5SrCug8BsXRSZN9sBJMOQPxMyFTVGxs9o2vVJ9F65ulcNIfhaYnFob7HlL0vCbkDbPVmgh4PcsYjV+qj+6gtytQT/vJFI9b9+db6iDzA9KYANug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hukz6m3n05GKuFyVlXApm5zN5Ep7/LtvcalZKIcrC8=;
 b=rs6aKrWABZUp6g1X8XB7/4Y6PFJcPZ2oKxTZ+PiWhX1OUOE15c8XxyNVIA6zRDQwTKaehHrSbEKBzvBCx3YFK0d2s8wpPrtXyQtSqEW/+bVHiXTAPUcFYVx4VzXXWb5qDIrpn2YEo8krvjfHUNlphiQhwv9H8+Y75D+baR5/r21Eu9OEmG/4+0+7Uc9k/f3jD9YjxiSY0Uo9ws5mq3ksW8cWoPEyXl8/JADmG95+0l3Qthw/N1nkAU87NypIe4zRoqYtXdOlWuoP6CXDKDvO5Lf7LnL9RKT2JkMhj9b1X0QYdJmqXRJsKv2wx9c/gKv/CaBFX7ph24TGoDwAYjrAXw==
Received: from DM5PR12MB1628.namprd12.prod.outlook.com (2603:10b6:4:7::13) by
 BY5PR12MB3905.namprd12.prod.outlook.com (2603:10b6:a03:194::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 11:44:24 +0000
Received: from DM5PR12MB1628.namprd12.prod.outlook.com
 ([fe80::c509:a193:93c7:e525]) by DM5PR12MB1628.namprd12.prod.outlook.com
 ([fe80::c509:a193:93c7:e525%5]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 11:44:24 +0000
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
Subject: RE: [PATCH 2/2] arm64: tegra: Add user PWM support on Jetson Orin
Thread-Topic: [PATCH 2/2] arm64: tegra: Add user PWM support on Jetson Orin
Thread-Index: AQHYuUXr+xSdwS0t+ke3FPjrDb5ubK3BceuAgARUJfA=
Date:   Mon, 29 Aug 2022 11:44:23 +0000
Message-ID: <DM5PR12MB162825333C0ED3A87D886165AD769@DM5PR12MB1628.namprd12.prod.outlook.com>
References: <20220826121746.32003-1-spatra@nvidia.com>
 <20220826121746.32003-2-spatra@nvidia.com>
 <eebef02c-e9b9-2ab0-5178-7996cb62a116@linaro.org>
In-Reply-To: <eebef02c-e9b9-2ab0-5178-7996cb62a116@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90404f20-3022-47eb-17f3-08da89b3d1f5
x-ms-traffictypediagnostic: BY5PR12MB3905:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3J3ZkpAuuelEFywv8VaRSXwfQn2YRE+Re/dk6CqoEEhSE7SzNziKXmCeXIfkLsgZzFZ/+2oL+MkHVDzIxGuptZHXdomkc48aFQBGXVZBIANTnvEd3ZYjf9oNfHfDdHbJB9kDF2YZD9kpA9CRbkCj3ZGFJtnY4Ob8fW4qgSu/mLOkLIxlcm1iTyyp/n5R7/q+/tLxy95JuUKsqc0DC4TZ15sUsxHJ3TR/i4kLByT3r3TsN2f7stiLxbeMh0rqXP2Eh1BixUfR9aX0rzSbGccmDDru4xZL6eMQyAyErrl4oDsax7Oe9RcWsTLNCYZk+PldI+rG2On0nQA3qvY2VHr0p7Dib641DDGoP19k0twqM1lnNKOw/VDFWbMa2Oq/T7T0sNf/AVnKCrWmJd7Ik0od98AgkQIU00h3IPGgb1GrcRg4he8grjhTgxL8QCQilFhbvWjeDtJ02jJoE2ceBvW3kJzEE6Ql/j+kjEqIn9EdWgkFMOMJRJR6q1ebSJeYRsxpp3hAt22MOQTWDr0JH4OH5Tp/RGUBQwQ+o40/NOK00l2O4Jt3jA/D5bZ0Jg2Qqw9Fq0QUrdrkPIDq765HXpYskw6D8X0dxQm1t7RmmqnvaE9Gdkg1GezAztrdIVUiMAz6hdLs6oz00mJ9TeVyDORC6UQErP4RoNbwD3SgxVoehRaWboNL3hP+2W9fAwC8kT/fVRlMsjGpcfPplPUC3gkKOakGpxM29q1AymGqA8yQ0Nwjd3o0WarUF8V1dnnA2XYrIBLoyRKXAKh0knFibjVhPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1628.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(64756008)(8676002)(110136005)(66946007)(66556008)(66476007)(66446008)(4326008)(54906003)(71200400001)(316002)(76116006)(8936002)(86362001)(5660300002)(478600001)(52536014)(41300700001)(38070700005)(9686003)(6506007)(53546011)(122000001)(2906002)(26005)(107886003)(38100700002)(83380400001)(7696005)(55016003)(186003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0UvQ28wV1hEUkRmWHZzUVFKY2IyQlFWbXdvRDVqdjJqWm5GbDZkL3p1bnNi?=
 =?utf-8?B?QU5oeFdPYUFYdGJEYTdMUVBPSkxHdEdxendLVnNKTit0cTBJS1hFWmJTTDhX?=
 =?utf-8?B?eUl3TEpPZTJycHRvMEFadE1WVktYQ1pSYXg2WUV2dXVwdldvZlpqREJ1T2ox?=
 =?utf-8?B?VE8wK2lrZFZKa0ZXWWpLbjdqTkN4andSSFlUZXp2SGs3TU1hYXRTM29iUTJp?=
 =?utf-8?B?Vk1ySHNxcUliTXlsTGFSMGJWWEgwRmNYN0FHdWs4Um1nUkJOY3RUckVnZUZk?=
 =?utf-8?B?QnhhMGdtQ1pKUzVnczZrSHl2cnpRY2ZWQlRQcXdGeW5uR0JycXZYRVlKR0dZ?=
 =?utf-8?B?UlpPbk5pOW90eHpRTUNuQ0JUOHFKUzFGaXM4UmVrMXJUQnQ4TnVaNnVVaDVH?=
 =?utf-8?B?ZENrVXBad2xyK1gzQmUwNE9OYjJIRS82VUZNUXNlWlFhUGROSlhEVlc3dFg2?=
 =?utf-8?B?TTJxOEhneXlESSt3bjAvRGx2ZThtN21YTjgzRnprRHFhSjBBS1ZXMDB4VXg0?=
 =?utf-8?B?UHJKRC82clRQT0dTYmJvaG1ET3BCT1NkR1YzQTkxTkp1S0tnVmRNU2M0OWJx?=
 =?utf-8?B?SmxsQmplVVZ2aVhkOHBORE5YdXNQU1R5YTlCbDNzYWRlYytQUGVjK1JJYWRv?=
 =?utf-8?B?WGZnT3FxdWdrRkEzQkt1YzJHamxLZUhzZVVJdE55VFJKUTlEcXg1NVU3T2RG?=
 =?utf-8?B?Mzk3N0hhRjNrb2hhZmlLamFjekFVQjlWN01kK2x6SGFGd0FOMVdUZm1Yc0dx?=
 =?utf-8?B?SjFJZDNuWmw5eWNoZFNoblJkdENFSG1xOEdoc0Y4V0xJdTI0Y0ZjalBPV21n?=
 =?utf-8?B?YVkyemFuSnpvc1pXOG8yZzBYdU5jVUgxUFBzMU1oNDJTMFcrNEJ3TE9iemRL?=
 =?utf-8?B?ZTNzT09uZ0t3KzV2RzgwWURGRk8rOW5ZbG9oTEl3alIvTnM2WVpvK3Y2bGpx?=
 =?utf-8?B?dDcxSEVaMTRGQjRWU1JaSVBaK0NVTVdvdDRFZlNlZU9TWWxOT2MxY3RJaDRw?=
 =?utf-8?B?M3I2Z0IzcXpUK3lobGpZRUgwK0kvY2IxRktCWHFmKzVNVUpSVlJDMlhXYXlL?=
 =?utf-8?B?MnlUWDFFTGd1c1ZSeHNJTTUrNytIbC9xU0JLV2daLzNlejdpdG9FNWN0SzB2?=
 =?utf-8?B?MkVTUUVIaTV5b0N3S3dDTWlGVXVzKzNwREk0cmFiTUM2dnlPMzh5aWZpcjd5?=
 =?utf-8?B?dk9Ca0s5eFhHc21qekk4Zm1FWUdPMjRvemJWWVFiUXRZamEzdzNhZEE4MDI1?=
 =?utf-8?B?bkgyZ25pNzNNanozSlY3NHViVlVHL3FpUFIrWnN5dVNMR2gwZVM1L3ZKcE4z?=
 =?utf-8?B?KzJKZEIvMXp3dmF0VENnQmtNWUlFenJtUFpSMnYvVWplc3BUZ05vbituSEdK?=
 =?utf-8?B?TG1BSEVteXdNNUdYNG9vSEJ4bUFQM2xOMFNyZEhObGxZOXVMeWtnQlhkNVZC?=
 =?utf-8?B?WGtRYkdXdlZhcEJSZENTM28wazFSN3RnbXRyR0NDRCs3SzB6dmRmaGkyZDFo?=
 =?utf-8?B?VUZUWksrYjc5Rzh2M0t2cHF3QlYyMi93ZGxJY0tXZlA4VVRnV3ZxcHdkODVN?=
 =?utf-8?B?S2QxdTh3eTk2TFNxSkVTc3JROEVaRDF3d0RIeVk3Nk9uVW9sNE5KWm1XQlUz?=
 =?utf-8?B?ejUwUTdVVUc3eU9qS3R1OXVBUHJQYWQzcGt4em0yT0RGdXhWS2xXZmFPTjdY?=
 =?utf-8?B?NGZtbXlMMHQxd1pZWjN5eDdQSmJGeWZ6NEsyMS9EdUQwRWo5RE8vbTNZbVJ5?=
 =?utf-8?B?eGNBL2ttUDB3V084SVpWS3hkNkVSWW92TENHeEt4bUVFbzljSnB0RW85WnBV?=
 =?utf-8?B?NTM1SDFOcWpGWFJWeUxNdnVzeWtRME9SeXVUT3NRanhSUzB3TERmODZGb3Y3?=
 =?utf-8?B?a3ZiWHlXYUF6QnBweHpjaG4wVlFrV0trZktFL0E4R3R4QmljcXNjRDdyNnZY?=
 =?utf-8?B?TmcwMk9OUHF5N2VUVXFLTXVJa0Z3VGZabG0yMldVTkFQdCt2UkQ2NmRWYWRD?=
 =?utf-8?B?aWlTdUJPRlZsZ2RLdS9KYmV1cHVQZ280d2R5NjBpWjFuTk1pUTJmK1dJekRD?=
 =?utf-8?B?WTAzWmtFY2lmMEdWdE0xZFdGYlVxR255bElHNXg4dFFKTkx1YTdtZ043Tzla?=
 =?utf-8?Q?mnQ4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1628.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90404f20-3022-47eb-17f3-08da89b3d1f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 11:44:24.0373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ydWvOfqHu86lnmUxvm2r9Yt0k/VtL5TLDWRzNurcrFhbKej9XwPLkB/CD+1RuljA/d9OSImSj6j4IPm4A2xtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3905
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBGcmlkYXksIEF1
Z3VzdCAyNiwgMjAyMiAxMTowNSBQTQ0KPiBUbzogU2FuZGlwYW4gUGF0cmEgPHNwYXRyYUBudmlk
aWEuY29tPjsgdGhpZXJyeS5yZWRpbmdAZ21haWwuY29tOw0KPiBKb25hdGhhbiBIdW50ZXIgPGpv
bmF0aGFuaEBudmlkaWEuY29tPjsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBrcnp5c3p0b2Yua296
bG93c2tpK2R0QGxpbmFyby5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC0N
Cj4gdGVncmFAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
IENjOiBCaWJlayBCYXN1IDxiYmFzdUBudmlkaWEuY29tPjsgS3Jpc2huYSBZYXJsYWdhZGRhDQo+
IDxreWFybGFnYWRkYUBudmlkaWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gYXJt
NjQ6IHRlZ3JhOiBBZGQgdXNlciBQV00gc3VwcG9ydCBvbiBKZXRzb24NCj4gT3Jpbg0KPiANCj4g
RXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMN
Cj4gDQo+IA0KPiBPbiAyNi8wOC8yMDIyIDE1OjE3LCBTYW5kaXBhbiBQYXRyYSB3cm90ZToNCj4g
PiBFbmFibGUgaW4gZGV2aWNlIHRyZWUgYW5kIHVzZSBpdCB0byBkcml2ZSB0aGUgUFdNIGNvbnRy
b2xsZXJzIG9uDQo+ID4gNDAgcGluIGhlYWRlciBvZiBPcmluIGRldi1raXQuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBTYW5kaXBhbiBQYXRyYSA8c3BhdHJhQG52aWRpYS5jb20+DQo+ID4gLS0t
DQo+ID4gIC4uLi9hcm02NC9ib290L2R0cy9udmlkaWEvdGVncmEyMzQtcDM3MzctMDAwMC5kdHNp
IHwgMTQgKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMo
KykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL252aWRpYS90ZWdy
YTIzNC1wMzczNy0wMDAwLmR0c2kNCj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL252aWRpYS90ZWdy
YTIzNC1wMzczNy0wMDAwLmR0c2kNCj4gPiBpbmRleCBhODU5OTNjODVlNDUuLmU3Njg5NDU3NGQz
MiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL252aWRpYS90ZWdyYTIzNC1w
MzczNy0wMDAwLmR0c2kNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL252aWRpYS90ZWdy
YTIzNC1wMzczNy0wMDAwLmR0c2kNCj4gPiBAQCAtMiw0ICsyLDE4IEBADQo+ID4NCj4gPiAgLyB7
DQo+ID4gICAgICAgY29tcGF0aWJsZSA9ICJudmlkaWEscDM3MzctMDAwMCI7DQo+ID4gKw0KPiA+
ICsgICAgIGJ1c0AwIHsNCj4gPiArICAgICAgICAgICAgIHB3bUAzMjgwMDAwIHsNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiA+ICsgICAgICAgICAgICAgfTsN
Cj4gDQo+IE92ZXJyaWRpbmcgYnkgbm9kZSBwYXRoIGlzIGVycm9yLXByb25lLiBZb3Ugc2hvdWxk
IG92ZXJyaWRlIGJ5IGxhYmVsLg0KQUNLLg0KDQpUaGFua3MgJiBSZWdhcmRzLA0KU2FuZGlwYW4N
Cg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==
