Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A534758CEE6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 22:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbiHHUKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 16:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiHHUKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 16:10:13 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6701F7;
        Mon,  8 Aug 2022 13:10:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVwmELxNiVdN4f2OkJ4gb+PMK/4mF/cWiwozTAyNYgXmoIGlOIllobUdOXAMQunXAOjqRLfniuR0wd3Xa1NhzJlodUinlU39qdaJnAhyedcOQmLqBgWX3YsJeMxS0FMCo/EM6bNiAkeUaPI1Gh7zgrpgYT5ak/YIMqklYX+UqLLRvMjRLdP0s/XG0phj6Wvt95/SKFH9BNkBykXg5K5ZgIy00OtmjB3HxbWtkLusjfJmLoGAyzOvvRIj3w3w0HAtkrypBOzvqLL+UTZ78tn4yJlape2NpgEODmPN2YaMCzpD+DUg9RJpHE7rG1j3tzxJkenTN/PHcCzDvFM3kgIuag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZ9es/oXNwTytY+HZvhV9GG04AGNT+Raulfd0Pmj16o=;
 b=Fo81Uj41lWL3xXIilpSGNsa9HJOcYrXlbrtSsivL71iszdzRvD0yVCHAmMBF0xwAXTwINIuVFK3m2CHUK+0MM8V4yOJJdomCqdIg4HrtSm9+DvMHPnRvWHtMEMGnQFVHtRE9TjFI3B+4WMEzhzcnhdZJLRrtfqIXzP1Ls1XE8uNiCg8kEx5NguXZzlYnnRpWmIEPoRd7eBFNyeEsRcdzEyrqRyXfWZ14P1a5XbrkJLmpA98ivy/ClnvkGJxR4SG/vyAgS1Fg+a6kNTc+kl+04EnVqF3tgWcKJ1Mljvu7Lca6P8uVVr5sfJzv70EKKNSg/tx1zh3JW0MDK2AMDREjjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZ9es/oXNwTytY+HZvhV9GG04AGNT+Raulfd0Pmj16o=;
 b=mCYKRhGv69PHaDwY+BFDXh8p6TrfahdNHS1BPLIOvDy54Z8ZSNJSY5GmVNggL4LHFltrD+cMwXfdBBrbYvKj6YeVQxgKIo/2Tpt5rnMNuuS+kqer5qpUICtuOjPP4aNkcA9p7E+hpigcJHlrscAzKuRX+RvcklTSY38JgVz6Of/toDOT0K/YDpBBiW8wQpHe4vv5N4qKwEO1bIOTGsft7yDjKw1gkUTuJKWCd9/NLUkGlqUy0nlKWCHDhf4hPqBOaRVU+Zaip1MHvFm1QoWqIJ20PTaqwVvqeVTutDMxcl+ufbEjv8YOXSzuTe0gM+8+Z+7pygzrBmm39LkjRkJFOQ==
Received: from DM6PR12MB3164.namprd12.prod.outlook.com (2603:10b6:5:188::30)
 by MN2PR12MB4655.namprd12.prod.outlook.com (2603:10b6:208:1b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Mon, 8 Aug
 2022 20:10:09 +0000
Received: from DM6PR12MB3164.namprd12.prod.outlook.com
 ([fe80::593c:21e4:1120:47a]) by DM6PR12MB3164.namprd12.prod.outlook.com
 ([fe80::593c:21e4:1120:47a%2]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 20:10:09 +0000
From:   Petlozu Pravareshwar <petlozup@nvidia.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dmitry.osipenko@collabora.com" <dmitry.osipenko@collabora.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "Kartik ." <kkartik@nvidia.com>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        Sandipan Patra <spatra@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] soc/tegra: pmc: Add IO Pad table for tegra234
Thread-Topic: [PATCH] soc/tegra: pmc: Add IO Pad table for tegra234
Thread-Index: AQHYqLgAOdPi9pdX0kSZNmRTZqgyi62k194AgACb3fA=
Date:   Mon, 8 Aug 2022 20:10:09 +0000
Message-ID: <DM6PR12MB3164E33542018A69895585CAB5639@DM6PR12MB3164.namprd12.prod.outlook.com>
References: <20220805104100.3098200-1-petlozup@nvidia.com>
 <6fd64502-6061-f14f-b8c4-b19ab6e26dd5@codethink.co.uk>
In-Reply-To: <6fd64502-6061-f14f-b8c4-b19ab6e26dd5@codethink.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a6fd7b0-35c1-4912-759a-08da7979fea4
x-ms-traffictypediagnostic: MN2PR12MB4655:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X+4rSzZBW85jrWi/xiu3G88iid0cnL1dElxgFGfYPfZrLWZSAodm+EQN/hzAwG5n4Ioj2ouQw6N1UCOQyXq44o4uVC27eP4ZjJdG67WLUMrFOM+NVHOXj0JICELR9VzBjLkKbEaTyfi3yqKT8UepVLI+9UXTpYu6Us+6fnUS69PcXNZjoX5GvcmOUMb/KNT6R7BKxW2idsfcjhmqoeTdI8zkr+tWXda9XUIKHMLyRQ+n+XxYzItYI7f0FDudrr6Nd4yeCvKmAgh9NycXjrmDtkwcC8RY82wfAVsu7XX+vTIBlSugmZhdZvRGPu5He+RyKifsqEcTPSX4MuvS9HWxHZxLDcVt6wxHC93dgGb0G8QhreC3J2vy+WPb/UvkWmFXWGeEf4DgO3msZOF8UwM+shUJHdKgyiAnkfwQ+Uv9mmak2kU6345wDCD8o/b9VO3+2DSuqlT0JnDKy+UOTVw2h6O2TRjK7TeOPv8CsNCFVlIozFQbiK0/xuTIi/v+YcZNoKkT2LgoIuPj4b6Ct1KjtezjroRGFJPhvRfqgm4gGapjzzDAfsTYc7fxLgC5797Q6q51BzXW+X9s/J3VBJv8tIPv9/rVmPZvoHaxc3hrZLKqz27tm7hRNfEzb4jUYADizuLW7vz356eePkipnvsiJI6QhBLFpqajAd548HpcE7nS7Z/48R1p6AvuYlpx5s8nvv1C/C4rjiRFgaO3fRzcp/2k3EHCuLsyEwfxSEmqXN5z3IbItJrIgj0NrecY0FX4yrC5DqHYSto1nuBrit9aDlrPzmF0sCTzO9BpG92IJu4O2Mo6pyeuihiZ6ucK0Kef
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3164.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(8676002)(55016003)(66476007)(316002)(66946007)(66556008)(5660300002)(76116006)(64756008)(66446008)(9686003)(7696005)(52536014)(8936002)(2906002)(122000001)(38100700002)(41300700001)(33656002)(478600001)(71200400001)(38070700005)(921005)(26005)(110136005)(86362001)(83380400001)(55236004)(6506007)(53546011)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUZ4RmJvRmV6cGZjM3d5SjloR0c4TjlBckVwUFo0OXhtZW5KQWpsVm5neng4?=
 =?utf-8?B?NWV1UVFtZWMzV2dFZkhJRjhyOWVubXpmUTZwek9tYTNRS2lVTVdHZTUreGxz?=
 =?utf-8?B?NzBxd2tDajNoSDlUVnF3RDBlbHg0WWtxSWg1Skl2UlJHWE8vQUltZUV6U2s1?=
 =?utf-8?B?N2I5ZHdYa1doeUd4ZTdTSEkwdGtNTFFEUkZLR0M0NFZlUy9lNzN3aWR4ekFR?=
 =?utf-8?B?TjBlWEZRR0dHQm5RR1V0NHZ5bncvcmFpUHBiYU5VeVhRckM0d01JeU9zclla?=
 =?utf-8?B?cHZicUt5TEhLSHFMZEwyYzg2YWVYaHgrRFNnY0ZielNBREM1bHBkdHFRSVFa?=
 =?utf-8?B?ZnltWHRGS2NxVHordjZjbTlkYWVFcktubFNCRitkWjhqRE5kMjFUV1g1SCs1?=
 =?utf-8?B?TWxZV2N6ZVpERnNpempuS2xvbDFxOEM0RUFieXVyVXF6VUxFcmVZd2t4b1VV?=
 =?utf-8?B?WXZ0UUVha2Zxb3dIT1cvQVM1Ni83T0dieWxPTy8zcm0zRE9UUDNxVjRWNnR2?=
 =?utf-8?B?VFlyVFZnM3pvcmJxOFFxdUNpa1lPOFVXUk01REh4UEs5azYveHFWcGt5S1p3?=
 =?utf-8?B?R1poOHIrdUtQbEhlV01OQTlObEM4ZHZ0cFkzeXJCQm9FQzNrK0x5K3lqem9Y?=
 =?utf-8?B?UnprY1NPRXFzQ2oxZDhGbElEQmNPM3BtNVBRYzFLWDVIa3UvbjA3czNxUFJn?=
 =?utf-8?B?LzZES29kUWpjU2pVZWZnU0tMN014QXErVzVhTW5Vc2luK2NoTGZGdmd5c3hl?=
 =?utf-8?B?UU9keUJ2aEpXaFdSbWpUOGlMdGVPdzJzUlk5YUNYcGJkd2hXcWp1Y0FmOGE4?=
 =?utf-8?B?bkxEUUhBNkhETmgycVp0ZkdidjVLYWp6RnFLRXExQ3FCeTlFWnJrcjhNaUdq?=
 =?utf-8?B?dHFPdGFqN1JaWUhTRllhVEtYTkpDb3FJcUNDZ1dsaFJlUGl6cTN6WFEzdnFK?=
 =?utf-8?B?cW9rM0xuYkVoRjB5enk1UGpmZ0JNV1VMcEtXVGFnN3NjaytzV3lNSzV2SGZS?=
 =?utf-8?B?ckkwaUg5eVhIS2dKWjNNZFdTa0xEVW9RMy84ZkZ2TXRZZnRENThMbkVteGdJ?=
 =?utf-8?B?UW4xSVBSRHBBeUJDR3ZLai9DWXYrRVpqUStQVWl6R0FOZGFSZGF0THZQUjNB?=
 =?utf-8?B?SSsrcXRBTHIzMWVaV0hOZG1ldjN5RnpyQXFJdCtPaHBlVHo1ei9zS1IrYm1Q?=
 =?utf-8?B?RWVBVXhacmdHY1JqNTZCZHBpYitGaHEwMlFOeWhveDJjWG9mdWN0UFJzU2Ni?=
 =?utf-8?B?SU1iRUVGOGs3eVVQZGhKTHJ5REJWNUp5YWVEQnI3UnVCK2czUkdTYTdTRC9m?=
 =?utf-8?B?TkdramhCSDZEdmM3c1RuZGxwVTRmN1RNbnhnTDgxQWxMSVBLREdxaEttTnhL?=
 =?utf-8?B?bUNNSkpZZlU4d3ZONkJVOUtlWnBEQ3N4anNINFFWbWltcXJMamtobXlaeU8z?=
 =?utf-8?B?WVVUOWwvOGUvWENLZU5lSFFjcDRJb0FvTjd1UFN5K2RhSUF3eVBZZy82WlUw?=
 =?utf-8?B?c3N4bTJ5Ri9sUEtnMFdDdmQxYTF2a0cwc2w5UGo5eHlVU1hMRzBlSE9Xd1Vq?=
 =?utf-8?B?cDQybC96MDk5MFErV1FwZEJ4ekJBczJJMDNscTB3Y1kxbE1EMUpVcHphYUt1?=
 =?utf-8?B?ZDJRdWNkYjJvWk05dW44SDBHVUJwK1E5ZU94dXRZQW14TUU5MCtPSVJZSStX?=
 =?utf-8?B?d2c2MmZ0cmQ0VnlNaVg0dHFOK013RlM3ckV5QjcrcnRjem5vcXNvdVdnMHpi?=
 =?utf-8?B?ZlR2a2dickZFcDlxWERXZFlCWGUyMnV6VW5DOFRjSlYxKzA5NkgzR01QVGZ5?=
 =?utf-8?B?YTg2ejNBWVRyQXlVaUdFTmdKR1NCOHNYdmh6Snp4Q0V1cUQ3dXVGZzlub3ln?=
 =?utf-8?B?RURQdXJCdFY3WG5XL1lpVmN1ZTBnQ2w2bGxYWDdhbG9LZllkSS9LMEl1TVgz?=
 =?utf-8?B?dnJ4NE15MWl1dmdaTVU4UEpQYk9nQUtrMXpjTFE5ODRhRm02b2ZPWmJKUlVO?=
 =?utf-8?B?eUtLQmJsU3NHZmwxZVlkdDJuTlJPQ09LenArd2dVQkhDNjY0MGppR0Y3L0Jz?=
 =?utf-8?B?TWR2QkdMVmhkQVpxekdZUk9SVThQeUxpUlo2YzNtWWFzdERIWFpXcmlHWW1O?=
 =?utf-8?Q?Qx79IQkfllAU2rIXMeYHaxQYT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3164.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6fd7b0-35c1-4912-759a-08da7979fea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2022 20:10:09.6384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KXoEbPT08MirdnCQ7fv0V+pBbDpcfh0PAchOsXANrnVwuhWAY2WO1ZhWqUAtzOr7xujm65vdLIJbyuKFKMsMPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4655
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gT24gMDUvMDgvMjAyMiAxMTo0MSwgUGV0bG96dSBQcmF2YXJlc2h3YXIgd3JvdGU6DQo+
ID4gQWRkIElPIFBBRCB0YWJsZSBmb3IgdGVncmEyMzQgdG8gYWxsb3cgY29uZmlndXJpbmcgZHBk
IG1vZGUgYW5kDQo+ID4gc3dpdGNoaW5nIHRoZSBwaW5zIHRvIDEuOFYgb3IgMy4zViBhcyBuZWVk
ZWQuDQo+ID4NCj4gPiBJbiB0ZWdyYTIzNCwgRFBEIHJlZ2lzdGVycyBhcmUgcmVvcmdhbml6ZWQg
c3VjaCB0aGF0IHRoZXJlIGlzIGENCj4gPiBEUERfUkVRIHJlZ2lzdGVyIGFuZCBhIERQRF9TVEFU
VVMgcmVnaXN0ZXIgcGVyIHBhZCBncm91cC4NCj4gPiBUaGlzIGNoYW5nZSBhY2NvcmRpbmdseSB1
cGRhdGVzIHRoZSBQTUMgZHJpdmVyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGV0bG96dSBQ
cmF2YXJlc2h3YXIgPHBldGxvenVwQG52aWRpYS5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJz
L3NvYy90ZWdyYS9wbWMuYyB8IDExNg0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTEyIGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pDQo+IA0KPiANCj4gc25pcA0KPiANCj4gPiAgIC8qKg0KPiA+IEBAIC0xNTQ2LDYg
KzE1NjAsMTQgQEAgc3RhdGljIGludA0KPiB0ZWdyYV9pb19wYWRfZ2V0X2RwZF9yZWdpc3Rlcl9i
aXQoc3RydWN0IHRlZ3JhX3BtYyAqcG1jLA0KPiA+ICAgICAgIGlmIChwYWQtPmRwZCA9PSBVSU5U
X01BWCkNCj4gPiAgICAgICAgICAgICAgIHJldHVybiAtRU5PVFNVUFA7DQo+ID4NCj4gPiArICAg
ICBpZiAocG1jLT5zb2MtPmhhc19yZW9yZ19od19kcGRfcmVnX2ltcGwpIHsNCj4gPiArICAgICAg
ICAgICAgICptYXNrID0gQklUKHBhZC0+ZHBkKTsNCj4gPiArICAgICAgICAgICAgICpzdGF0dXMg
PSBwbWMtPnNvYy0+cmVncy0+cmVvcmdfZHBkX3N0YXR1c1twYWQtPnJlZ19pbmRleF07DQo+ID4g
KyAgICAgICAgICAgICAqcmVxdWVzdCA9DQo+ID4gKyBwbWMtPnNvYy0+cmVncy0+cmVvcmdfZHBk
X3JlcVtwYWQtPnJlZ19pbmRleF07DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgZ290byBkb25l
Ow0KPiA+ICsgICAgIH0NCj4gPiArDQo+ID4gICAgICAgKm1hc2sgPSBCSVQocGFkLT5kcGQgJSAz
Mik7DQo+ID4NCj4gPiAgICAgICBpZiAocGFkLT5kcGQgPCAzMikgew0KPiA+IEBAIC0xNTU2LDYg
KzE1NzgsNyBAQCBzdGF0aWMgaW50DQo+IHRlZ3JhX2lvX3BhZF9nZXRfZHBkX3JlZ2lzdGVyX2Jp
dChzdHJ1Y3QgdGVncmFfcG1jICpwbWMsDQo+ID4gICAgICAgICAgICAgICAqcmVxdWVzdCA9IHBt
Yy0+c29jLT5yZWdzLT5kcGQyX3JlcTsNCj4gPiAgICAgICB9DQo+ID4NCj4gPiArZG9uZToNCj4g
PiAgICAgICByZXR1cm4gMDsNCj4gPiAgIH0NCj4gPg0KPiA+IEBAIC0zMTMyLDYgKzMxNTUsNyBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IHRlZ3JhX3BtY19zb2MNCj4gdGVncmEyMF9wbWNfc29jID0g
ew0KPiA+ICAgICAgIC5udW1fcG1jX2Nsa3MgPSAwLA0KPiA+ICAgICAgIC5oYXNfYmxpbmtfb3V0
cHV0ID0gdHJ1ZSwNCj4gPiAgICAgICAuaGFzX3VzYl9zbGVlcHdhbGsgPSB0cnVlLA0KPiA+ICsg
ICAgIC5oYXNfcmVvcmdfaHdfZHBkX3JlZ19pbXBsID0gZmFsc2UsDQo+ID4gICB9Ow0KPiANCj4g
SSBkb24ndCB0aGluayB5b3UgbmVlZCB0byBzZXQgZmFsc2UgdmFsdWVzIGluIHRoZXNlIGJsb2Nr
cywgdGhlIGRlZmF1bHQgc2hvdWxkDQo+IGJlIGZhbHNlLg0KQWdyZWUuIFdpbGwgdXBkYXRlIHRo
ZSBwYXRjaCBhY2NvcmRpbmdseS4NCg0KVGhhbmtzLg0K
