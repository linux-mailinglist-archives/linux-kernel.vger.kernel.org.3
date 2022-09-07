Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F095AFC2D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiIGGLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIGGLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:11:45 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3599321F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:11:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTwSpW+XfPN7NupJykR6qyqSGRVCJUM8R+gyI+CaTDfsSRq5LiKW5E1qFXJi/uHXqDd8pEESlFzRt7mzlxKXsQYEZFbO2D3Ny+2SIWSGBX8QvKbwDoObRZ+lSadj2nHMWiWq4p0uPDNVY8mgUlFAkZGy0Eg9lLO80lQH7K58p6C3SXbVzOjz0CW7+aCSfKdWoQ9bPv0wol3FG9D/ZinROKYR1ZmBxdItoZLRxcm9cOuBltBCw4YjdFZxo97yqr4PYXrWKBqDrcPaSOmgV9e062k3DS/IAr3K/MJ1QK1dj8knjJaTpF9/libdlwf/m/uU1ZA++5TFDEKrTVdzLjktoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Ye/c1Yxh3ic4TzHVHLOecmnhFYk5Z4LTbNtRADCARE=;
 b=VEYS+yp2a3ZX/SfD7xEsPQAM4w1Q49kdAj35KPekSFkIBMnFtzbffETH9HBIViuyIQhRXSLDPyLGL3ac7sllQ8uacjp1bAMZj2EJYzq36Egc0bNpDqexVQhqVkBiZt5YVwi3WmOjgPTyKfmbqwk2A+avHF3uSvjz1njIwCEaIHZwN9SsC0fhlQkKQ6BPsdx7zUmeHOubQVqe9maoGoSRld7Mw2cgsibXtEj4dY1yTTYXAD3ipnOQnQ2I/X17Cs/yhFh7SDjCNKITZhkvEQ3Mr7XSQw1DhsMalsjvKsNbTMXikhfab6asVjfuEULt0XCHjt7Oikd5sCgL4nab9m4oAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ye/c1Yxh3ic4TzHVHLOecmnhFYk5Z4LTbNtRADCARE=;
 b=t4NTfr1xnRRmOhlBfBULjFoQMc30q/zVW1AJmu4cPU2k/CZ9xtI3DF26rfGqQHA0JGGLvV0Bug22xF1RlPPRGRKBUm56TF2smFgERW2TDnrp7qLSHsANmydEU/0eaeBJghfF/eZnYK386etr8jUVSCxHJZEYgFUPqjojiT4/MpW99tIIahpWvZBq2UpeIN4ZIhOT7NR1mEwkK4NoWhfYnEE5Pw+U2H6bt/fI4wRjozJK8SZlmEiAHM6IY+KzOsyeBgeQ+xmMwxXZ5mA1Y7dXqFKcL86Dur+6muc+tg1yra6Dg9ErpmzkRjakY1veSPgZ/9C+t+vpgoYmtlXp6i9SaA==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 CY5PR12MB6431.namprd12.prod.outlook.com (2603:10b6:930:39::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.17; Wed, 7 Sep 2022 06:11:41 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::c42a:c673:1e4a:f357]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::c42a:c673:1e4a:f357%5]) with mapi id 15.20.5612.012; Wed, 7 Sep 2022
 06:11:41 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] vdpa: conditionally fill max max queue pair for stats
Thread-Topic: [PATCH] vdpa: conditionally fill max max queue pair for stats
Thread-Index: AQHYwn9Fx1nXRznSXUKkLYwaO1Myaq3Te6Iw
Date:   Wed, 7 Sep 2022 06:11:40 +0000
Message-ID: <DM8PR12MB540034620ADF0AE749C2D099AB419@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20220907060110.4511-1-jasowang@redhat.com>
In-Reply-To: <20220907060110.4511-1-jasowang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|CY5PR12MB6431:EE_
x-ms-office365-filtering-correlation-id: 2d36024a-505f-437f-a14d-08da9097d4b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CW1oFUW81Kfem+FKqIvFmdRPnbb2ae8CQwzcxf5Xx7nwnIMUuZJngcEllFItCPAqDXRv6sTBYltTMYOwEiW0X3SWol7TFXnzOdcHW5ubji8LkKPxytjwLvYzGnbEhz03QAwKSftr8eA9clEo94+FXWEBX+dxiPKB8WGfVuZbBhJd3NKADfUtLvMfhTMyo6nawFryAgL1gVXoWgm0ic+wZb3SceqNzSZ0+f5IhzWNMbokMaDYEu5nsB4LwwnFQkGtNTGZ6a6214VcFTI4UNPkGRJJxUCoy4Cx4iAGJDpOE9oTuEmDx9WWa0g+Z5Ec4UeT8i19ImoCs35wWpijh7JgQAbmnWPhZ/SPsGr17eoeeuY6wGmZP+SLju+xAHVJjHzv1dBzxG77ZX03AsXQZQ+503ippksgah4Mlg4CRvl9B90b1prIO8KKG6C80Ubu8dGq9sJnveUSaaF8gZ0wc7bgQ1I1eEHXezIVJvAUraZKX2nv/C3zay24hmsMqYn1JnXUNuJLd/emTJ9+R2lLwN+khjA4hfBA877JJc1Af5x8rdq9S8RHoMnWHKU6W2tFxTSpy7ZxngYwK9gpazWbm78BrFUNKEjnbuxJT0JvcBWEKB1C0EK3+9k9ZOKIaVCWvNXPvqR9xCTXz5zxQo3Z0KMN5j47Ciq9o9eax2JnYYcCTnVOgR3jjDGqwTd5DTtetHrVdKQh81tSZed2IhGd7zBPiTa8Qm1QrI514lxCcUjGYtBHeifA/0SqzslxCpquLNfwKn4a368Lj3JU9gi3TFa80w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(83380400001)(76116006)(66556008)(66446008)(8676002)(66946007)(8936002)(66476007)(64756008)(5660300002)(52536014)(7696005)(53546011)(6506007)(478600001)(26005)(41300700001)(71200400001)(33656002)(186003)(316002)(86362001)(110136005)(55016003)(38070700005)(122000001)(38100700002)(9686003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVRDWkVreXFBdnpHUHZhc0NaTnB1TUs4Y2VKcVhCVlRnbk42THpJVlI2QzFp?=
 =?utf-8?B?dnJTN0VMZng0eGs0ZlovTFdnZ2xiVlR3UitKbTdUY3N3ampWMGNvM042OVFx?=
 =?utf-8?B?d3JsZk1TOXFFOEZXNkVRZFQ0NWllZGUwaFErS1d4T3V3N0g5NGhCTWNXWkFN?=
 =?utf-8?B?TFNJTXNBVlJsaGJob2l4RU9jcnJ5QzhGZW14RVhZZWVjZFNiNkFLWnB0SVFX?=
 =?utf-8?B?dmEvcGtwd25EWVZXcU9pcHZaSS83STB1b011UnJsU0YzeFFNYnFBODVVMlpS?=
 =?utf-8?B?R2VZWmFsZmxsRGZFZmJvVFJjV28xYk5GUjhWaU1ibTZodTgxWElPaHd4UkFT?=
 =?utf-8?B?SXN5ZVJESFoxbGRmaUkxS29xRjQ5WHdCalFleEoyR2hoQ1M0bDdjblpFbVRR?=
 =?utf-8?B?dklkckZwVTJyaFhnRzhlcHU2cVlCQ0YwWW5oejI1Vy9uaUo1c2JEeVNiUHNh?=
 =?utf-8?B?UlRqaVZ6ZXE3SXJ0VUcyTXVWdSs0OHcxdHlaUVFJSEpLbVRSd2ZSakMzQWd5?=
 =?utf-8?B?NFd2MzVDRFpPVnUxVm1WbzVZamdSb3hvTzVuYnJPWFVLbzEvVGxrQTZLb21J?=
 =?utf-8?B?WlNnS3NXWUxxc0J0aitaSlNZTVVadXNiQUtwMzE1VklmSi9nRFZwQTJnK0dQ?=
 =?utf-8?B?SUVSeEJyTUM2Q3NpeGdMU0JHYi9Ndkw1RDlRWkZzYnZCcUphL2xEbW5WNE9S?=
 =?utf-8?B?cHRTY1hqME5Sd2U3WHRzSDR5YWVseU1rMld6akEzYk01eXIxVVV1UXVCYVVu?=
 =?utf-8?B?emxJYU5va3E1WWFKRUR6QkZQWHZqNDNCR0lIM3JXUUhoejhFcjNndkZ6YzE4?=
 =?utf-8?B?LzNXM0lCMS8rUGlLME50Y3Q2WFB5MVo0eGg2ZnFMZnUzQTBiRXc0Z1p3MHpq?=
 =?utf-8?B?VHkxS29QRHJJL3V1WWcraHJVcFUvRk1sNTJSd0NKbmFXcThDU011VGNoWWQ5?=
 =?utf-8?B?WjFjVThvME52Z0ZxSGE5KzRYR25YUlpuWURYRklJWXNoOVozQ2FVdFlWdWNM?=
 =?utf-8?B?c2RQY20yQ0c0enVramZFOWdWZXV4L1NPVjZKbHgydFhhZDQ1UjI0NVQyVDdt?=
 =?utf-8?B?cUZKL3cxODR1dDh3d1dmSldPOVNLelNTZHZQVFQ3TzM3RGNaUEwyV2x5VVll?=
 =?utf-8?B?MWY2Tm8vZTVqYTFvYUl1RnFhY3EwQlR5a0t3eFlxbnJMMHJ6WnBuK3ROV3p3?=
 =?utf-8?B?akUvbHdvS3pZUnBQdENwdEgvNEU5MkN6Y1RmaEJVVElrZjVJNTUxclgwMlZQ?=
 =?utf-8?B?VE1BRGNlSjB4a0RSYlg0NlpCVmRDN21OblkwTGtsYnRwcFpJT1ZPaktiWk5z?=
 =?utf-8?B?MjRyMktQcHkzQUI2TU1mSi80SE91YStEYWQwZWVYVVBzcGFFUUllYVRDakZt?=
 =?utf-8?B?U04yQUpJVi8yanhmVXU3L1BZbWxuUTNuY09vNTlWWWgza3Z3bmlaRHhBRUs0?=
 =?utf-8?B?ZXZLZnFMTkNoMzFIdlN4Tjl3NGFTemkvZi8yeXJGVjl4VDRxTERCc21aVmJI?=
 =?utf-8?B?WjVTSi9jaTJPU0FTejl2ZnI1MEhnQkltbS9FZkpZeVpNZ1hxNlFDaU5MUDRj?=
 =?utf-8?B?RWJQc3dlb09vK0R5dnFtK29YamlYN0tmczVyM3IrRGZqMkJIZ3ptSzRwVUJZ?=
 =?utf-8?B?NDRiMEIzQ1B0RElRQmNPOEJ1NGU1bmdIT2Z4MGdpTE5pWUR1Wi92YXVzYVNq?=
 =?utf-8?B?VmIzSmNsMFJ0TVUwZVRUS3FOU2tmNnlJL21ZOGJxL01VM3ZZNmU2c1g1cXR6?=
 =?utf-8?B?YWV5ZkNZUjQvRmRaV24wN3FzVktQVmdJL3EvY0hsS0cyUjNzaHZzQXh0STlK?=
 =?utf-8?B?QndFRFpHK2RGdk1iS3puRXoyaC82UStzVzNHNG1ET0RSNXdSUGhoWHc0L0NM?=
 =?utf-8?B?TklaUGMzSU1KQURQcWJoUjRqcllNQ3BubS9iWTBqcUwvSUxncmkrdlRweUV5?=
 =?utf-8?B?bWNNR0xjMlgzK2JJRkp6YzRmNkxrZ2UycjlBTjJ3MHZrdVRDT29iUmxheHBL?=
 =?utf-8?B?dnB3RzNzYkV0NHlndktjWElha0lNNjZyaEZXYXI4eFZsT0gvSTdoU3dYYjR6?=
 =?utf-8?B?T2pVWTBXa3F3WkhHU0Nib05GZlR5THlzTUx3SS8wbjRrdm1sQ3NXT00xVWdt?=
 =?utf-8?Q?lv/g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d36024a-505f-437f-a14d-08da9097d4b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 06:11:40.9430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eWtEhhi6cfgJuIRCadyJNrXLBgggoGOk1zj0iwWtlsDaNqu0WPwV28sCi5OS0Q2C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6431
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIDcgU2VwdGVtYmVyIDIwMjIgOTowMQ0KPiBUbzogbXN0QHJlZGhhdC5jb207IGphc293YW5n
QHJlZGhhdC5jb207IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPjsNCj4gdmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogW1BBVENIXSB2ZHBhOiBjb25kaXRpb25hbGx5IGZpbGwgbWF4IG1heCBx
dWV1ZSBwYWlyIGZvciBzdGF0cw0KPiANCj4gRm9yIHRoZSBkZXZpY2Ugd2l0aG91dCBtdWx0aXF1
ZXVlIGZlYXR1cmUsIHdlIHdpbGwgcmVhZCAwIGFzDQo+IG1heF92aXJ0cXVldWVfcGFpcnMgZnJv
bSB0aGUgY29uZmlnLg0KSWYgdGhpcyBpcyB0aGUgY2FzZSBmb3Igb3RoZXIgdmRwYSB2ZW5kb3Ig
ZHJpdmVycywgc2hvdWxkbid0IHdlIGZpeCBpdCB0aGVyZT8gQWZ0ZXIgYWxsLA0KY29uZmlnLT5t
YXhfdmlydHF1ZXVlX3BhaXJzIHNob3VsZCBhbHdheXMgc2hvdyB2YWxpZCB2YWx1ZXMuDQoNCj4g
U28gaWYgd2UgZmlsbA0KPiBWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFYX1ZRUCB3aXRoIHRoZSB2
YWx1ZSB3ZSByZWFkIGZyb20gdGhlDQo+IGNvbmZpZw0KPiB3ZSB3aWxsIGNvbmZ1c2UgdGhlIHVz
ZXIuDQo+IA0KPiBGaXhpbmcgdGhpcyBieSBvbmx5IGZpbGxpbmcgdGhlIHZhbHVlIHdoZW4gbXVs
dGlxdWV1ZSBpcyBvZmZlcmVkIGJ5DQo+IHRoZSBkZXZpY2Ugc28gdXNlcnNwYWNlIGNhbiBhc3N1
bWUgMSB3aGVuIHRoZSBhdHRyIGlzIG5vdCBwcm92aWRlZC4NCj4gDQo+IEZpeGVzOiAxM2IwMGIx
MzU2NjVjKCJ2ZHBhOiBBZGQgc3VwcG9ydCBmb3IgcXVlcnlpbmcgdmVuZG9yIHN0YXRpc3RpY3Mi
KQ0KPiBDYzogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy92ZHBhL3Zk
cGEuYyB8IDkgKysrKy0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA1
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhLmMgYi9k
cml2ZXJzL3ZkcGEvdmRwYS5jDQo+IGluZGV4IGMwNmMwMjcwNDQ2MS4uYmMzMjgxOTcyNjNmIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYS5jDQo+ICsrKyBiL2RyaXZlcnMvdmRwYS92
ZHBhLmMNCj4gQEAgLTg5NCw3ICs4OTQsNiBAQCBzdGF0aWMgaW50IHZkcGFfZmlsbF9zdGF0c19y
ZWMoc3RydWN0IHZkcGFfZGV2aWNlDQo+ICp2ZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqbXNnLA0KPiAg
ew0KPiAgCXN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZyBjb25maWcgPSB7fTsNCj4gIAl1NjQgZmVh
dHVyZXM7DQo+IC0JdTE2IG1heF92cXA7DQo+ICAJdTggc3RhdHVzOw0KPiAgCWludCBlcnI7DQo+
IA0KPiBAQCAtOTA1LDE1ICs5MDQsMTUgQEAgc3RhdGljIGludCB2ZHBhX2ZpbGxfc3RhdHNfcmVj
KHN0cnVjdCB2ZHBhX2RldmljZQ0KPiAqdmRldiwgc3RydWN0IHNrX2J1ZmYgKm1zZywNCj4gIAl9
DQo+ICAJdmRwYV9nZXRfY29uZmlnX3VubG9ja2VkKHZkZXYsIDAsICZjb25maWcsIHNpemVvZihj
b25maWcpKTsNCj4gDQo+IC0JbWF4X3ZxcCA9IF9fdmlydGlvMTZfdG9fY3B1KHRydWUsIGNvbmZp
Zy5tYXhfdmlydHF1ZXVlX3BhaXJzKTsNCj4gLQlpZiAobmxhX3B1dF91MTYobXNnLCBWRFBBX0FU
VFJfREVWX05FVF9DRkdfTUFYX1ZRUCwNCj4gbWF4X3ZxcCkpDQo+IC0JCXJldHVybiAtRU1TR1NJ
WkU7DQo+IC0NCj4gIAlmZWF0dXJlcyA9IHZkZXYtPmNvbmZpZy0+Z2V0X2RyaXZlcl9mZWF0dXJl
cyh2ZGV2KTsNCj4gIAlpZiAobmxhX3B1dF91NjRfNjRiaXQobXNnLA0KPiBWRFBBX0FUVFJfREVW
X05FR09USUFURURfRkVBVFVSRVMsDQo+ICAJCQkgICAgICBmZWF0dXJlcywgVkRQQV9BVFRSX1BB
RCkpDQo+ICAJCXJldHVybiAtRU1TR1NJWkU7DQo+IA0KPiArCWVyciA9IHZkcGFfZGV2X25ldF9t
cV9jb25maWdfZmlsbCh2ZGV2LCBtc2csIGZlYXR1cmVzLCAmY29uZmlnKTsNCj4gKwlpZiAoZXJy
KQ0KPiArCQlyZXR1cm4gZXJyOw0KPiArDQoNClNvIHRoYXQgbWVhbnMgdGhhdCB5b3UgY2FuJ3Qg
cmVhZCBzdGF0aXN0aWNzIHdoZW4gTVEgaXMgbm90IHN1cHBvcnRlZC4gSXMgdGhpcyB3b3J0aCBz
YWNyaWZpY2luZz8NCg0KPiAgCWlmIChubGFfcHV0X3UzMihtc2csIFZEUEFfQVRUUl9ERVZfUVVF
VUVfSU5ERVgsIGluZGV4KSkNCj4gIAkJcmV0dXJuIC1FTVNHU0laRTsNCj4gDQo+IC0tDQo+IDIu
MjUuMQ0KDQo=
