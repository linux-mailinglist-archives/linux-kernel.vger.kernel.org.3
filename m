Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0414F516A56
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 07:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383310AbiEBFnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 01:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiEBFmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 01:42:54 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3288722B22
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 22:39:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9QxIZZo9wautjlH3BkpfsKTByyCSjLSbl7De3VQqKfR+3F81SHjaS8TT/+Y2Xa34e9e4RQONRe7y2wUNbkmJE7py+GgZcFWV2OUc+RHB7nWBh5CDnrs2W3UvAE3B1cjbclq4X2dcv5+28qkMdP2F92fOUgxa4sL65Wt74enDYjSmnh8mdcSURBSkuOoVJjj6e09M3F9/ymABjsWpREhmirczPCQ1m4PtK1Gfjly0iITRRzFOkTtujKeQOq0WG2k3sqTXUSVaLBn6TyYvladO6o16M0gcZVaGVcQ/8zz5MM8X6x+DPwwMXpGLi49k/gohI6BS+/xkA/7QKWgMV7zzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yVuZRxBTQ0B288zOTbYg7fZ/XFPIffQAylFLWpZNjU=;
 b=IHO+k3+Yq0X3VkdGIePqeDhDx7G6NlkSEj/Zcgo+55l6ylGZJYvzQtfsRx+mSXAj375DYN1GFbKEeW0NnLSBDwmrInf5oUXivgW0gQSHp3n4iOxhTlCydPz3pXBaybf/NLOd4y0jGT+/GSg7ZxRXFJcJG2vGUq6kXfKBqHgHOLaeqc/y4U+xObJPB8EvaiHXm7yCYOdspGzp1eD0i6xYKZwPopdYmH0nVaD7FVMLxj+AdqlmQg8TZf/GjT17YbtBAiKkdNbhXKmUb/ZVigNMSqf+gDJWRCcLd/VWKKBeOjNRefF5Us6tuGsT2B2QNu9+FxxFvkCEm+d4OKnWr+P0rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yVuZRxBTQ0B288zOTbYg7fZ/XFPIffQAylFLWpZNjU=;
 b=ek+y95i1YYLKRn9iJyktG6G3SzaZhXLlBtNEuhz6uvGozIJoYXRFcmheU598I/KWS3Qk3P8xuXEjlkaRzYzWnxOdk4lmHVjSbYLOVAUr9hNUG+NVc+3Lsv/tROR5/azLm3aXVhyzWju8tfnOIhZnfKLgyII46kmFtG9PDo1opqiVzEMfrjXKJrip/OkJuGPK0DJ2uxceKth1rSdQcRGEzGF9xlFY3KAOU5/2sb4gR7higIbKEf8kcxhaCEtwhedtokGiV4dIJRq0tEQT5zsznawVAaCZsUaCDes1Dp7pSEB8iTBsM8AAfzqA+Q9msPt8zrYX5zlmAfcCCTOZn6aevg==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 BL0PR12MB2418.namprd12.prod.outlook.com (2603:10b6:207:4d::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Mon, 2 May 2022 05:39:24 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::ec12:70ec:e591:ab6]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::ec12:70ec:e591:ab6%4]) with mapi id 15.20.5206.024; Mon, 2 May 2022
 05:39:24 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>
Subject: RE: [PATCH 2/3] virtio_net: Add control VQ struct to carry vlan id
Thread-Topic: [PATCH 2/3] virtio_net: Add control VQ struct to carry vlan id
Thread-Index: AQHYTZ/hj5Spfna2WEePDBasFt5hh6zwTraAgBrj7jA=
Date:   Mon, 2 May 2022 05:39:24 +0000
Message-ID: <DM8PR12MB540018FAE7E58DFCE3FECAE3ABC19@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20220411122942.225717-1-elic@nvidia.com>
 <20220411122942.225717-3-elic@nvidia.com>
 <87985be4-8cb0-2292-d799-5a91fb32acda@redhat.com>
In-Reply-To: <87985be4-8cb0-2292-d799-5a91fb32acda@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3cfcac94-08b2-42fb-84b5-08da2bfe1dbe
x-ms-traffictypediagnostic: BL0PR12MB2418:EE_
x-microsoft-antispam-prvs: <BL0PR12MB24183A92028DA6D07A8A7697ABC19@BL0PR12MB2418.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wfbj/erNKhH2pBj0S12IgtFhYC+pYC/jwyi9vCtudKnDfXHQ7GZQh8CdwTRjbpKyEdnGShbwbaGHgMuNBRFzXFxOn11fVOeM7ajnRfHA8CLNVwNAN8+K3R2y5UylXGnY7rgNL/fx0TDr8Bt07rItMnW/LYzBKSpHku0xOw2+tkGd7/g30xoIhX2bVJKvYZWo7dgzGbwUs1sInKVMx07JgYsuQARwu/eH8Le6eLbmToHAjkqbGMER5QM2cZzKc5VN7c9+RCcED7bFamjw1fx0ncxXu7gK16cHP3/6sotrrs2Pi2Yf/AkbjFK9uZ5lIYS+xfGRWDHemrcy+DM3kTuwLk+mCMUY+L8Gfkt/+tzlm2JTJYl6k+ZsnJjj1H/teG+gBJXfL5RjjttH4MPgYnbfI7GtK1WXvx0wANWmsPdCKg2Oprswuov8uS4iZST8TEUBCzgdP5+jtnRSyThMsl8cLILGKTjBOKTQUamFW6ClrUtyH3YIvVTrNqhhy9mNsSAfTI6TQdp9O3hVgUWHw1R1eUingOnLCU2aRqe7n6WVa7JpSjebMQ14QwYi3EBaVqB4iwu5ImA0+rMWQdvpy2kyxPK7yfaKQCH2A9z+YBdE5K/dNtuoT/eqxfX03IQqX9MEySwxgBhkncAu5x4aDhh1K+zmYQTig3bjls+vKdmPR7fX3C40hdkLNqWpULoOhKdkr6GWH5fenL8d1mMdx/+v+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(66446008)(38100700002)(66556008)(38070700005)(110136005)(33656002)(508600001)(316002)(7696005)(64756008)(54906003)(83380400001)(2906002)(71200400001)(6506007)(26005)(66476007)(66946007)(9686003)(4326008)(186003)(8676002)(76116006)(8936002)(5660300002)(52536014)(55016003)(86362001)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnIrTUMzMjlmK1NMWFRtc1BvRm5VZ29wODNNVUdvUFRiMm9RVDkrRlRVV1JW?=
 =?utf-8?B?blU4Nm43Q3lFS003Kzd5QURkZ3d3WDcrMXRnaUl0dkVDd1ZmYnhsbmdOc1JW?=
 =?utf-8?B?Y1BLb1VtTU9BV0MxVkR2TFd6MDdsN0lTdWdoeDV1UkI1Mml5Y2JmUkhYWWVS?=
 =?utf-8?B?K2ZNMjlJQ3A3dlFrUlZSeGJXODlOc0xuYmlnVU5aczk4TE9va1dXS0ZKZWMr?=
 =?utf-8?B?WHcvSUJzcTlwN0RCMTNHS3V5b3dNWGpHUVB6OW5kaUxsZG12SDZwOFJpTHJp?=
 =?utf-8?B?Y1RjbU5BMmRNai8rdGR3MGQrUUEzdlE0MmZyVU1RZXBEOGc0L0JzMVBOMVVS?=
 =?utf-8?B?S2hPRmdpU2VhbXJlZHhRQjRKMGxFNjg2K3M4NTdyaTVuZ0o1QmUvcExkUnZB?=
 =?utf-8?B?V0FNN1ZmOGJZZ3VJaW4vd0t2SURQa3VQV0x6T2hvZ0NqZ2l3N2o3eUMwNGVy?=
 =?utf-8?B?UmhzNUtNUCtxbnpDV0dISURJVTJnNmxoQjR1ZzgxUnhVRGhmbmtCTHE4by8z?=
 =?utf-8?B?dW9hOHZJZnArZG1uOE1GY3lJTWljdHB3MHpQYnRCd3B3UVZRVzlDTU45SG5o?=
 =?utf-8?B?MDlHeUxtejNXZUN6UmVyM2ZMbGV4eDBwaDBNMGtpa1FGTUh5TVBHcHp5dGt2?=
 =?utf-8?B?WjZOZ0pycVAwQXRaZWpyZklibDRhWWtIekxoRXZnV2VwUjdBVDBzRGNyUnVr?=
 =?utf-8?B?ZXVKaWljK0FERWlkQ2t5NW1la25IVjRndDhCZDNOZFVPNVptbE5qcnNoc3Rs?=
 =?utf-8?B?SUY3YTc4clZmbEhjTFc3b0E0L2JPdGI4K05QdFJ5MGhaYU4wMXZDSklsV2dH?=
 =?utf-8?B?SVdRVFBYWHVmOVdWTElCa3JpMU0yeHcwTEJlY3A3MlpHUkc5Lyt4bUpGUGlS?=
 =?utf-8?B?RUYxV3JMemtYdUc3eDgvSjU3RGRXUzdJUHRES3lXSkFqS2dUdzRoTTRBK3NE?=
 =?utf-8?B?R1RIdUQ1OEoyU0hSTzMrTCs1ejg1WTQ0RXl5QnF3aVdnQnovSEVSZ3pad0Vj?=
 =?utf-8?B?bGEyZm11NXV3eUVyMHRGR01PK08vclZrajE1Rm1ibHpXT3k5eVRsbmxhZzR1?=
 =?utf-8?B?K1R6YWZjNXJsRlBnS0dRZ0htYnZUNkVmM1BBTjcwd2cxT0VUcG1mQjdKZm91?=
 =?utf-8?B?NjMxODdJai92cGVabU9xYlB6alNXOXIrYTFYRC94MU1ER3ZCOTJKblk1eStE?=
 =?utf-8?B?N05wbUswWkpHSGVsVS9UaklZaTV0TXdKeUFLL2RCYmY5YTNNd2tGYWNhMm5T?=
 =?utf-8?B?RGRtQW5TN1VLMWxVbzBmYVJDdXlETTRqM1l5aFZIWStINDVoZXFIeXZNQytm?=
 =?utf-8?B?V2x6TGkxMjZEU1p6TVRYaCtjclY2aXNvMzJQcGljT2pjanFPeitmVEk1R2Jq?=
 =?utf-8?B?UkYvK2tkL3cyQkxrY3A3QWpCSVJ0Y1crVlFBd0pvM3VXVGxKeGVxa3l3T1Bo?=
 =?utf-8?B?WG1wZUM0cUZFeFBPbENoNStLZTBYN2JkN2tiWHBmZjQ3eHlmS2lxV3JLQTRs?=
 =?utf-8?B?T3hqSkgrRERrZ2RQTElYS1gwSHJVdHYwdVMvaWZaRTZRNzZDQXl6MnpMUGxi?=
 =?utf-8?B?Vi9JVG1uQ25iLzV5L1U0VXFLaTZrL1JPZEw1MFJ1WnNEanRQZm5CSFhZQVVG?=
 =?utf-8?B?UEFKeUF0TVFVSnlqTWtKMjRPNjJLYXZvYXZvdWFFNDN2MVI4WmsyWnBaWml0?=
 =?utf-8?B?VURLcXFuSnIvWjR6YlNmWTRhcHNmdUtJbUh0Q1o0V0VoUVNrTWxSdExGaTVk?=
 =?utf-8?B?WUdPaEROZFJwR0RWQ2NaendieUNmMnNOV1pJdlY1QzRLTllHd3FHdzJRbTQv?=
 =?utf-8?B?dWZHbWtYMEJmVTU4U205ZjJOYmFjNjR5Y2plaWpEMGpCbnFpcmJlVVQ1TGxr?=
 =?utf-8?B?dEFVQWYrYXVrNUZMMGFZbEtBaUx2ZFNsTUVpVnFSZ2JTM3JMeTBCSk1ZRHdP?=
 =?utf-8?B?eVBNSnhPU0tNbG9Rd0wrUndxRFYzRGM3L0dIRXBTWWUyQ25zWHJ2RXBGTTAz?=
 =?utf-8?B?VHJmU3NmaEh0N2ZVZHpxTUZSN21ReHpqaUVLbDlvMmFRb3poU29PRG16TEUv?=
 =?utf-8?B?OGlQaE9mQTl6dDRWZXRjRXdKUXFrSjNmUzc3UGpFSkg2WndJMWZYend6RkQ1?=
 =?utf-8?B?WXROYkVXaUNJVzhQa3JlMTVOM2cwZlViODMrNmluRThYWjBxaHorak4rNTdY?=
 =?utf-8?B?VEtNZi9WTmZRQXI5MHhRbkFQb1NHOTNia09ZdXZOOFY0MzVxQ0dzQTNjTzJa?=
 =?utf-8?B?Z2cxUzY1V2FRbUl4YUs3WVJzeFdqeWx1T1RUT3FLZ0JNU1NDZ0ZIY1JKeWRH?=
 =?utf-8?Q?ARhogOuNyOrLgRcyQK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfcac94-08b2-42fb-84b5-08da2bfe1dbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2022 05:39:24.6746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m5Kjv4TNpNdM30FxrDE2Gwqw19de0Zdwk2a6+0t99Kw+3geW5mG4d+2a8FFOq0ht
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2418
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiBTZW50OiBGcmlkYXks
IEFwcmlsIDE1LCAyMDIyIDY6MDEgQU0NCj4gVG86IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29t
PjsgbXN0QHJlZGhhdC5jb20NCj4gQ2M6IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBzaS13ZWkubGl1QG9yYWNs
ZS5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzNdIHZpcnRpb19uZXQ6IEFkZCBjb250cm9s
IFZRIHN0cnVjdCB0byBjYXJyeSB2bGFuIGlkDQo+IA0KPiANCj4g5ZyoIDIwMjIvNC8xMSAyMDoy
OSwgRWxpIENvaGVuIOWGmemBkzoNCj4gPiBBZGQgc3RydWN0dXJlIHRvIGRlZmluZSB0aGUgcGF5
bG9hZCBvZiBjb250cm9sIFZRIG1lc3NhZ2VzIGNhcnJ5aW5nIHRoZQ0KPiA+IGNvbmZpZ3VyZWQg
dmxhbiBJRC4gSXQgd2lsbCBiZSB1c2VkIGluIHN1YnNlcXVlbnQgcGF0Y2hlcyBvZiB0aGlzDQo+
ID4gc2VyaWVzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRWxpIENvaGVuIDxlbGljQG52aWRp
YS5jb20+DQo+ID4gLS0tDQo+ID4gICBpbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX25ldC5oIHwg
MyArKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX25ldC5oIGIvaW5jbHVkZS91YXBp
L2xpbnV4L3ZpcnRpb19uZXQuaA0KPiA+IGluZGV4IDNmNTVhNDIxNWYxMS4uYjk0YTQwNWZhOGQy
IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fbmV0LmgNCj4gPiAr
KysgYi9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX25ldC5oDQo+ID4gQEAgLTI3MCw2ICsyNzAs
OSBAQCBzdHJ1Y3QgdmlydGlvX25ldF9jdHJsX21hYyB7DQo+ID4gICAjZGVmaW5lIFZJUlRJT19O
RVRfQ1RSTF9WTEFOICAgICAgIDINCj4gPiAgICAjZGVmaW5lIFZJUlRJT19ORVRfQ1RSTF9WTEFO
X0FERCAgICAgICAgICAgICAwDQo+ID4gICAgI2RlZmluZSBWSVJUSU9fTkVUX0NUUkxfVkxBTl9E
RUwgICAgICAgICAgICAgMQ0KPiA+ICtzdHJ1Y3QgdmlydGlvX25ldF9jdHJsX3ZsYW4gew0KPiA+
ICsJX192aXJ0aW8xNiBpZDsNCj4gPiArfTsNCj4gDQo+IA0KPiBJdCBsb29rcyB0byBtZSB0aGVy
ZSdzIG5vIG5lZWQgdG8gYm90aGVyIHVBUEkgYW5kIHdlIGNhbiBzaW1wbHkgdXNlDQo+IF9fdmly
dGlvMTYgaW4gcGF0Y2ggMz8NCj4gDQoNClN1cmUNCg0KPiBUaGFua3MNCj4gDQo+IA0KPiA+DQo+
ID4gICAvKg0KPiA+ICAgICogQ29udHJvbCBsaW5rIGFubm91bmNlIGFja25vd2xlZGdlbWVudA0K
DQo=
