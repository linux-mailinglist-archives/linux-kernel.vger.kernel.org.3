Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CCC527D5C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240144AbiEPGF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbiEPGFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:05:53 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D32A201BF
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:05:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkHp51utOLsL3hzkzseX/LDcW1TmLF+bdUhvW3cxryxL+RQXMI0TiMuy0N2+szEt/THzNe3xyjNabGxUIfva7DxjGt7eheqkdfUYncV6Wz0ifHWdoY4gkHvlXDN0r/Im8FLyyG5to5Lk3KhdzemDKbRrPH6uZLX4aejILPhDzOi+I1SBuWvUImIBTZA+mDGoCTNWsy+pXWvRNhMYB7K+BDvnTayWgzT5JFBduIcrLygN5TplZUTwNlVRiROgzRxRd8qOsQUgKIVP41hyNQ5OSu/im9lTdyKUR6YJw6oxdQSVe8tIOv36B+RJjj1F3m4CK5kn5omGozLC7QH1DsjhCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=073h23ciSIhcLXxwyY1bwDhJK54wK+7wogsn+A65W6Y=;
 b=mkDF7XXfySbZTVz3znJtUbGDkhBlFn473FkvNbxyAjgc2BNmh+UHEo4xseTBuoRMNFednUG4Zv2S+7qanDlcxyJC+u5VfMkwykd4WWWGuBunzeBdwV2io4WqEhKwxusm/coLqeqgI5wwWJAwUP9yiaSCvWnLnEsVZhaxm1t/Ts6pTOylhDmteSOJlhh/uJmkdgsY6WaKkFzH5BvfaSCAZZ0VDgDMYCLUoKd1LVy9Z3Q4BfvVcgVlnyDhtEdzp7564SbDiQPSPcSLKpk2OssL7Qa21JSR2OunEMLMpYOBxKNj2Rwu8fnxxNOfXz06XrGr2Z0EZF2cZ84dRFBwRJCi2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=073h23ciSIhcLXxwyY1bwDhJK54wK+7wogsn+A65W6Y=;
 b=QBnGNBcwkpBOOpWZRXWnwxzbSqxDsLfUAWzRxAekwVhTf/Y9OtTYvDVfR48wL6ubIsBJiYC3BL0bpjU0UbziOK2U8OfEezFsnDeNdDpACrX+btazlElELz/DGqZR0OA7dCWRPIWm1/rdQwkY+zIsYLKGMPWFq9A0euER3Czq80Ny7HKvK1G0dNiF0dnKMRzmqw2kibIAIjerkHaaqbZEbolXBjqTDG6yClOo4MFBggvSkl3MP9+feJQVgxKPpF2bE1/4R2UBDIeTSakZGMb/ZFnHHd1gwxdhzjM5zWp94aJwsTAmh+KCFxcNgMwWmLX/LfsYGZHtw7aP1aft+LKzKA==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 DM8PR12MB5431.namprd12.prod.outlook.com (2603:10b6:8:34::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.15; Mon, 16 May 2022 06:05:47 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::a196:bbcc:de9d:50a5]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::a196:bbcc:de9d:50a5%9]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 06:05:47 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     Si-Wei Liu <si-wei.liu@oracle.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 3/3] vdpa/mlx5: Add support for reading descriptor
 statistics
Thread-Topic: [PATCH v5 3/3] vdpa/mlx5: Add support for reading descriptor
 statistics
Thread-Index: AQHYZGD+mTdLkMOt5EiSOG0Nlehiu60Z75gAgAHSc4CABUqc4A==
Date:   Mon, 16 May 2022 06:05:47 +0000
Message-ID: <DM8PR12MB5400CAAFEB2758FA313E9DF5ABCF9@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20220510112734.205669-1-elic@nvidia.com>
 <20220510112734.205669-4-elic@nvidia.com>
 <eda33c78-fd39-a5bb-9e9e-06b2c37d3fe5@oracle.com>
 <5d93dfcd-22cb-8e5a-1dcb-c6de6772b789@oracle.com>
In-Reply-To: <5d93dfcd-22cb-8e5a-1dcb-c6de6772b789@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6aae819c-e8e8-4db4-ea2a-08da37021f25
x-ms-traffictypediagnostic: DM8PR12MB5431:EE_
x-microsoft-antispam-prvs: <DM8PR12MB5431558F2B53BDAA2BD0A70BABCF9@DM8PR12MB5431.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QJIU+3SFZJn6uKzTXSm2X1wEfNYodcusupYrjXPqZARzpN4pRMXfXrHCFw2DuNvc7WHNoiKdgOe5oLvi7bns8Ul5lZSXDUA4yrDZWTYRiSYoWmwws1D/st6vEytJWmblrMGjVPHT/5zheKLiywBOo4jbuAbmTQQ0LDt7P1m0h3IDM2n6ahTPgDm3lEVWQwaT7VN3ORl0Be9KhJeXdoy+mnO3K1CIEsurVIXc2oU/ToZkBmNhDaCjFIjpiSg72IPmJ+PzZRY0IsPv48O4xa7Rib8KrNRYYbMXdm+9iwaWdeCg+dTCowHC7T71sGekL+0Qgcnlc42Zz3LYWAyKv90cQ0Uc3gDnBEcQq9fZeKhC+FXssUukbyh9mK0A9bgLD7aA66qOyfooL/nQG9hRuFwYWV//RTDlOMNfM0+zydXN+Ihu4XC8SRKU2S/6ZGzeQIYUu6BlaxQhVBN9ijSNYXjAep2Yrb3vXJLl6UGM2ljImM7NiMxCkCKpz0KUQJFEjxw76qBb7c0q3Didof6t7QwMfzgHfH3HxOtwXpeorA47NV1KILb2PjeMN2UOOhfU+qIMoHJIbalqMGNsLkL30Bah3ODdFFgwSMuz9xj1KrZyeCnOtU/cU9XwsmB+vJSWFh/EPeMvofal+G2tBb3eF3EhHRXTCnI0/pZnZS3u/b2Pb6FMJZwRtngXi+TjF7pflTYTWxCB+mHN4c5zE1h45Trldg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(76116006)(66946007)(66556008)(8676002)(66476007)(66446008)(33656002)(2906002)(26005)(9686003)(53546011)(64756008)(54906003)(110136005)(316002)(6506007)(71200400001)(186003)(122000001)(7696005)(8936002)(55016003)(83380400001)(52536014)(5660300002)(38070700005)(86362001)(38100700002)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTNtaVpKRTM1WHc5NWZTeUF5TWoyaFU3YjRkR2hlanFqdzhSVlNaekxmaGZl?=
 =?utf-8?B?bCtOMUNMVHJYemM0VldmOERaZVVkRXZDeE9rS1JNOEI4bWx1TnBzazJLMVU2?=
 =?utf-8?B?WlIyQmgwZEpVT2FsQ1AyWTVQZ0F0dkN2ZGtqQlZSQ3pSUVdPbDZKUlNzR1U0?=
 =?utf-8?B?Y2J6czJISkJScHFsZkxzMXlxc29Yb1VPR1dGYXhsUjVRZUdidlJpY2Jya0VQ?=
 =?utf-8?B?djVoQXNaZ1dWR1F6UTJud0xHdjBKcDF5Ly90aWNsTHNNSVltYjJiZVZXNkpu?=
 =?utf-8?B?Y0FHczVSZ3dTc0xZUFoxVmxqTVVUNXRSMkppNXRRTy9SSjhoSmdaSHBkano0?=
 =?utf-8?B?WUJPWHhoWkNObG9pcHhoNE5leDQzT0ZmYUdxYXZPbXhaQ1lodDMwc2l4Vkkx?=
 =?utf-8?B?VDlCb05CaDlVRlVqL0t4Zk84UC9FamxBYmw3MWkvMkh1UlA1R1BwYllRYnRZ?=
 =?utf-8?B?K1Iydzc5MXlXaHcramc5ZVpKdldzSzIrWk9sZklxUUJlOXJMSXdCNU1tNWlD?=
 =?utf-8?B?M1pteDV1YjFhVlN6U3VKNmw5QUY3MHVrUTZNU1lqbk9HRnBFZnBsZUNNT08w?=
 =?utf-8?B?dEZIeU1NUG1EeS9WZk95NlZzUXROc0VpUG5DajhvZWFvMmRTQ1gyWmpvbGVM?=
 =?utf-8?B?RWcxRHZGcjcxM1UxMnVlTWp0eWJzRmM2WUxWSTN5c0tvb1NJaVlDSnVFQ2p6?=
 =?utf-8?B?MU9LOFBRdVJ6MzJrdTA0cTIwY3VsTU93SHFsVjFVQkgzSmcrUnNkTTNJdWhi?=
 =?utf-8?B?YU1jQW5VVDNPY3lxVHQ5MTNnVUNCalJGa0JMYUlndjFjTXQwTDRWanlIcGJp?=
 =?utf-8?B?QTJ2cUtBRTAvRjJRTzZyajBGWHRDQjZnTEgyWkhuaVVjT2xESzlNUVRFL0dU?=
 =?utf-8?B?NjgvZU5wOG4wK1pZMTFKaWlMNzh6d3lhTjlGTlM1dnlJeE9nYmNWQTVMWVoy?=
 =?utf-8?B?MTVybm1BZ2duSHdDbFdIazVESDFHa0pEN3R3eXZody9DSnRCVHhIeHRPQ1VS?=
 =?utf-8?B?dllUeGg1YjJCNXJXOG5McUJTNVJ6ZHhEVUVIYnNGV0h3b1Z1UGtUN25aUmVF?=
 =?utf-8?B?cmNmVDN5alpOOU0xUitCYTdyb0VzSXhwcktsL3ppdjZKaTViQkZZb01WQjRN?=
 =?utf-8?B?Z2RQRGdWZ2l5ZVZQN254NHU3QU9hTUN1S01yK2p6QjBCSmF2dkhSelNCOXQ3?=
 =?utf-8?B?Zlg2L3RvWjRxQU5FZUVyMThwVjA0VHFzTVE0dld3R2RwdnV3ZTl3YW5RczNP?=
 =?utf-8?B?eXpzbkdHOTVlRlhySWltVi9rRklVUS85aHpKMVp1NUpXYXFwcFN6VC93ZU5G?=
 =?utf-8?B?RkMwK245THZRRHNpZ0RQMnlSOGM5K2RnMFVqU05HS3NuS3dYMmxOWC9HbnR6?=
 =?utf-8?B?YytRS2JhR3dNd2tDTUVlR0FJWlNqSlhuNGdVd2ttc3pGSUY5K1JZdmJ5TzFY?=
 =?utf-8?B?TXpWL1pMZGI1c0JnUGZqN2h2Mm9ORWZGUGJJS0NEWFhFNE1TMjJmWmluRndC?=
 =?utf-8?B?U3JyVHlPK21SL3pjWEdPcUREM0h5Vy9EMkJZNVJMQ1hUOXNYamdOQkRsR0JT?=
 =?utf-8?B?bEU0SmNUazNpMmNDU0lKaVZaa3FhOUFDbVNZM3dKUC9JVEtDZ3FzT0VRUWx4?=
 =?utf-8?B?Z210L2gyeEVOQzZTRVNyNEFrM3pSWnQ5U3dIb2FtV3VBT2RzU3ljOTY4WjJl?=
 =?utf-8?B?VDJaclVvaE1KU2Z5RWQzSnVWcy80MjdwbTlndGNVVFViaTg0WVVwcUMzT2tE?=
 =?utf-8?B?clpIb3ExR21MR3h1L0l4Z3hhVkFJOHpDSHl1KzNQRVJmdCtZS3RmSk1KaWF2?=
 =?utf-8?B?MytpdHA2aXNSZmtvSnJEL1JlZHZJakdzbFUxWENYa2F5Q3huRk1kazNKM2xz?=
 =?utf-8?B?NktzanlGWG9GOGt3ZTBXdFduR24yWWVvMGd4cFVNaEpNd3ZXeG00czZBcHFG?=
 =?utf-8?B?bVZEY2s1emV5RjhSVVpIejgrdlkvOEtwYU5sQ3F4NEhLUG1ieEIvdzRlWkRY?=
 =?utf-8?B?cHBkWVkzU3dEZmRsdVA1NlZwNEdlSXpMK1hiTENPY3BaV0xNaGRMWmVpZHZG?=
 =?utf-8?B?N0N0NlMzOUlGKzhKWEljWTRGclF3Qi9GRW9LUTV2cWFVYng1OTVEc3o3aWtt?=
 =?utf-8?B?NW9JVE5YREJ5cUxrd3c5QmV0VmxUZFpNSDNyVGhPMXU4VFVVbk9BenIyZ1R3?=
 =?utf-8?B?cElzMDV3RTVqRjNGTnlPV3l1RExlaGVQQ0JuN3l4UmdieFNhWXNZeXZocFBv?=
 =?utf-8?B?ZVhtZWQzSGRkQVhzQjlTeG1qSzJVcjlsY2pmVi9qcks1UmNRVDR5S3g0R3Zw?=
 =?utf-8?Q?B95O8RzMYfhjHlNyYF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aae819c-e8e8-4db4-ea2a-08da37021f25
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 06:05:47.7918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xdSHhLw65KRkFm8jKZKQQwqqBXF2ChFGfgLQmXi6XGU2onA9+upD1LQlZz3//B3k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5431
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+DQo+IFNlbnQ6IEZyaWRh
eSwgTWF5IDEzLCAyMDIyIDEyOjE1IEFNDQo+IFRvOiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNv
bT47IG1zdEByZWRoYXQuY29tOyBqYXNvd2FuZ0ByZWRoYXQuY29tDQo+IENjOiB2aXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDMvM10gdmRwYS9tbHg1OiBBZGQgc3VwcG9y
dCBmb3IgcmVhZGluZyBkZXNjcmlwdG9yIHN0YXRpc3RpY3MNCj4gDQo+IA0KPiBPbiA1LzExLzIw
MjIgMTA6MjUgQU0sIFNpLVdlaSBMaXUgd3JvdGU6DQo+ID4+DQo+ID4+ICsNCj4gPj4gK3N0YXRp
YyBpbnQgbWx4NV92ZHBhX2dldF92ZW5kb3JfdnFfc3RhdHMoc3RydWN0IHZkcGFfZGV2aWNlICp2
ZGV2LA0KPiA+PiB1MTYgaWR4LA0KPiA+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBzdHJ1Y3Qgc2tfYnVmZiAqbXNnLA0KPiA+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbmV0bGlua19leHRfYWNrICpleHRhY2spDQo+
ID4+ICt7DQo+ID4+ICvCoMKgwqAgc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2ID0gdG9fbXZk
ZXYodmRldik7DQo+ID4+ICvCoMKgwqAgc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYgPSB0b19t
bHg1X3ZkcGFfbmRldihtdmRldik7DQo+ID4+ICvCoMKgwqAgc3RydWN0IG1seDVfdmRwYV92aXJ0
cXVldWUgKm12cTsNCj4gPj4gK8KgwqDCoCBzdHJ1Y3QgbWx4NV9jb250cm9sX3ZxICpjdnE7DQo+
ID4+ICvCoMKgwqAgdTY0IHJlY2VpdmVkX2Rlc2M7DQo+ID4+ICvCoMKgwqAgdTY0IGNvbXBsZXRl
ZF9kZXNjOw0KPiA+PiArwqDCoMKgIGludCBlcnIgPSAwOw0KPiA+PiArwqDCoMKgIHUxNiBtYXhf
dnFwOw0KPiA+PiArDQo+ID4+ICvCoMKgwqAgbXV0ZXhfbG9jaygmbmRldi0+cmVzbG9jayk7DQo+
ID4gSSB3b25kZXIgaWYgd2UgY2FuIGNoYW5nZSB0aGlzIGxvY2sgdG8gci93IHNlbWFwaG9yZSB0
b28sIG90aGVyd2lzZSBpdA0KPiA+IGFsbW9zdCBkZWZlYXRzIHRoZSBtZXJpdCBvZiBjb252ZXJ0
aW5nIHZkcGFfZGV2X211dGV4IHRvIHRoZSBzYW1lLg0KPiA+IFRoaXMgY2hhbmdlIHdvdWxkIGJl
bmVmaXQgbXVsdGlwbGUgcGFyYWxsZWwgcmVhZGVycy4NCj4gSXQgbG9va3MgbGlrZSB0aGUgbGF0
ZWx5IHBvc3RlZCB2NiBzZXJpZXMgbWlzc2VkIHRoaXMgY2hhbmdlIHNvbWVob3c/DQoNClllcywg
SSBtaXNzZWQgdGhhdC4gSSB3aWxsIGFkZCBpdCBhcyBhbiBhZGRpdGlvbmFsIHBhdGNoLg0KDQoN
Cj4gDQo+IC1TaXdlaQ0K
