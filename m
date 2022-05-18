Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AE152C498
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242647AbiERUft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242590AbiERUfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:35:41 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3593722EA65;
        Wed, 18 May 2022 13:35:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKTJW0G7F7NWp9Lg6hexdujEUE4q5VHAzVZ/upe4mFK0a96Lcw0GyXyPljB+tj5TKG4JoP2pOif84yK+2Xlaup3b0xSF7dTgQ1uSK7YuKOFaWhgjY6QFwVrQU0wHcj5cjmm2s4XoT1OzEaU/8424/Ci8qoEOWTdGKDEFjmlGlBQLVzoIFc9hOhJgwFXm/TYWroM/R6+SuhGpEo3yEcpH+hx1MF9RufWGQPkkVx8w3N/98ZecU51NpYPskcfsVpVlTTv7RFwxuyFt4PLdZbuL22ut3omOCzq1P2VO0NPO7Wm7Du+JSmEF/+EMIBhXAUn4vNPm1LGCSzRWSeyrGLXHbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+vqRahvqthcMUfgr+KY2V3UCBbs5+JVRZREpdJxBP8=;
 b=P8SFZRqum6XEisBCGJsTpc1spRsbZyOetCpLeX1tfR+dnUk+HS6cGavbPrh1kuhjqdgTDKTWB0yTwfPfQTSQQoyVUe2jRvDwj6Y2hLUhh+V1O4re9CT7lyz+OMvBmXvDr+PYd2oJvZkablsoQSAItTfkj89zRVTHlwZUKRUjDttvZHBFaEWGBFKGiaMWH7VsE//dOkLWbUm4HHhT170UAz7rLEeyMV1s7/8Z5ZP4OCrRoXbEWxQRmGLf/5iz9VRbi9FqRWFLvUN+J23nqHSF7Sp6ryOVlAtC2HLQJvJsUUMysfcv2R/5TKYRK4zrxMeGV5/Raj7iC0V8fdSk/hzTvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+vqRahvqthcMUfgr+KY2V3UCBbs5+JVRZREpdJxBP8=;
 b=r6bQPfs9n/+67AKxyll03Q3+eNmdW7lhObXY0iwvlDC/Qv5OrVD/xaoYoIWLkW6WvIb8kq/PnGiHzB/Td+CC74yr+wkkoeuLHH8dnn1p3MlHepMOC/xbtAn0j8vLauD8PBS5mC7Rrd955jJbuElcKvVjMCUTupVLaIXaWGz1Oj3/wi7KU0eAMTjBRoXOu/bF9yh2OU5HhIINsS1aUr1NrwTxZuXKPq5tkfX09flK6VwCRlovnKNaDT9gNmqhNEFXvRmiM+aWdqChcHtHoVHZsQeLy9ixj0TkGY5qJtl/+UR3yEr6VfWkwMaC0ztKs1+3J4rprXBekt2k7GnDrhgpZQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA1PR12MB6065.namprd12.prod.outlook.com (2603:10b6:208:3ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 20:35:38 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4925:327b:5c15:b393]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4925:327b:5c15:b393%3]) with mapi id 15.20.5250.019; Wed, 18 May 2022
 20:35:38 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Vasily Averin <vvs@openvz.org>
CC:     "kernel@openvz.org" <kernel@openvz.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2] blk-mq: fix incorrect blk_status_t casts
Thread-Topic: [PATCH v2] blk-mq: fix incorrect blk_status_t casts
Thread-Index: AQHYaraHgqLxBKTNZky5EXzVGwWDrq0lGDyA
Date:   Wed, 18 May 2022 20:35:38 +0000
Message-ID: <eb6026ac-1616-b6e4-5708-48610eb52213@nvidia.com>
References: <YoH0/2FBC2YS9kk5@infradead.org>
 <55475ea9-5f6c-fa19-b52d-93fb89209850@openvz.org>
In-Reply-To: <55475ea9-5f6c-fa19-b52d-93fb89209850@openvz.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa01fbe4-7615-400c-1f45-08da390df804
x-ms-traffictypediagnostic: IA1PR12MB6065:EE_
x-microsoft-antispam-prvs: <IA1PR12MB6065E0FBE31757C90DE76B42A3D19@IA1PR12MB6065.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dytrb84sJD1SmQiMyGQTWK7ID9Hy2avfiFF9bw8PBO+BBeHzawj1P0XuUSIUYYlYd5zyaOCzSrazSek/+R6EWkCE2AwyvobQvA9vz8/r8rJVpYqRRS6ZEV7GwGHKoc2kEyYrkLJXkBzbr6VmE1yOkc+NXXZ9ItZ6x97kmQJbG8DkJV1PoIB06Ww1IH7JaG2f1M6PEGpmNDID3zdMhW/7AdGz2MlAQ1oNKouGzDRcZLGYCkbRknLf0q4SB6/1xxX7yhbdWCTOvpswIcftME1f8cT/WHwkInrfh4w+DrgYdHcquAOaC8OuP9dzKvMraaJx2vDbfxbi6o4sKKrTptJSN77U+XF71eZJ13zcRZbvDtFJWcJb703rRbJ/cH3BXH+vwOzpSNwQG8tUGRcFAJ9kWPJFPW48+xVV93sR/2TSqUEtKxQiKQ4vW5AQCOW3UASI9nGBSah6P2zb8DlWNg4A73cwEbXqhueIYBPmCzLmV4sghu1k7CmFlra/TmzWG3GkZavK05fG4Ug2yeacIJ9LV9/16b9x3J6oYSF2OFfcNxEw3XmE/5ofuCksxrRFExPaiUdOKGL1bimUG3f7oSpXCk8pMAcwFSMWxFz9csod6JBSiJhGW3+yVl5HF3kVEmaC1cgjQrgWO6Y+Wr4PypXJhQ3o8enPRgqaRyP9++Z+LzXMVTMEe7vd404SbwoGkBAvaUOHaxerhdEh13Pk+L81tJPbi9cthe/KKJa0uZeapOldzY0xaI/x7AQTCV5zmaVAPSL5UhK7tTw4Ka2XPS/KMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(66476007)(66446008)(66946007)(66556008)(53546011)(4326008)(64756008)(2616005)(31696002)(86362001)(122000001)(71200400001)(6506007)(6916009)(76116006)(508600001)(8936002)(38100700002)(31686004)(36756003)(83380400001)(5660300002)(54906003)(38070700005)(6512007)(2906002)(186003)(316002)(6486002)(91956017)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUgwOWd6UjJGeU5uRWVOV1lUdEZJTjRGOC9oalRhUHZST2lWc0dacG81eDBt?=
 =?utf-8?B?YlpwNVppY2l6T3F3MGhER3IwMW1LeER3RnRJNlV0RWl2WitpZjFwMXdrdzZZ?=
 =?utf-8?B?SUxaOTU4MUxwYWN4dWpRcUtWNzE0aWtLSzcxZm5VamFxWUFGOUtJYUdVZmd1?=
 =?utf-8?B?RVJmSlpXb2RWTDIxdGRDdnIwTmFVWjh2MXZ5aTVtNXVrOTlSMFNLM2Y1MGV5?=
 =?utf-8?B?bEIvWk1lUUNpUTVpdjYxZWFqQ3lYK2loYnBad3lNMnpibk5SangvdWhNZ1p3?=
 =?utf-8?B?SDVyNlBiZ09nSTRWbzUvZVJzdHhMSUlEU1BrOUc0RlV2SjJHUk14Y01mS0dD?=
 =?utf-8?B?ZGlWZzdLajIrc05PU0JRSWxFbUpGcytEUVZ2SUZSc3dhZU0rKzZIdDFXSENw?=
 =?utf-8?B?QVk1MzJtMTNHZ1RBM3ZLQjJuQWJhV2VXNVhmaWdhcVBtUmxxcGVIdmRxelN4?=
 =?utf-8?B?bE9UR3NxTFdmUG5VM25oNmZodFhyOG9RRUo1Uk9VdksxNy9vM1RvNFd6TFZB?=
 =?utf-8?B?REFiYnB4RnpHUkg0WCtWazd0NXE3NVBXMDZjYnlKaUtZMHlQK01hRGwwVVV4?=
 =?utf-8?B?bzlMWUFXRGcxT1BGc09uTlE1ZjFmTVk4UzVzMlVMZi9tSzVTN1pZUzJVR1FW?=
 =?utf-8?B?azhhUkRwVE1DSGhDeXJmUVhaMzR4NUxybU5yMzNQb2Yva3NCeCsvVms3MEFC?=
 =?utf-8?B?WGl1S2tGSEZnVjFsazhxakF0OGlqOVVIN0tLNDM3c05VRHVaNXNGcUtBRzJF?=
 =?utf-8?B?MlI0dHNyNlJ3ZjdDRFFNei95emNTVnpMa2w2aTdFekhmN1VTRGs1VWFSZGV4?=
 =?utf-8?B?ZkI5YytNQU9xL2VHcnlWRkVIV0pTZjFCcmUyKytFbWVSZzU4YWRaOVlHQ05m?=
 =?utf-8?B?by8yQVJqWXQyMm9WQUV4TGloekM5TVhaMVpFWEZRczRHZkF4QW10SlowOVNa?=
 =?utf-8?B?OWl4ZjJKdDlsbGl3SVUrMTkxaFhCQ2N5ZXVFNTRyZXRmOVNFTFc0Z1lMYWxF?=
 =?utf-8?B?MGtBd0VaMGRzUHFmU1p3SDNkZzcvaGdva1ZScEtSeDljTFBqc3RteUtPR0px?=
 =?utf-8?B?VDJ0anNxbzRJVC9XeDFTTGRDVk9LVUllaEEzbVdpblB0VnlkMHM4d0UrWjZT?=
 =?utf-8?B?em1LbE40ZHJNekZIT2NyeGJxY3ZwTEhoUXI3LzZackZSeHh5T1ExeTBpL3Zr?=
 =?utf-8?B?c3VqSUZOeDI2VXp3dTZPVTB0NFMxby9TbG5vTGFUNS9Qd2VpUXZhUURwQm9N?=
 =?utf-8?B?ZXBiUy9sNVZXUDNlZzRUQUpzWms3SUQxOU9zSnFLL3poSGVWOVFmMEQydWxD?=
 =?utf-8?B?QkFJNm82TTFNR3hlT2NIT2xic0NWLy9BNTJhWEVQYmZmYytqMm55SlIzeThv?=
 =?utf-8?B?Ny9iQU1QcmRSKy9kaTVhcXpBVzhySlMwS2xoSnNnOTNFVHRhZy92dXMxc3hY?=
 =?utf-8?B?clhoRzZXU21sd2xmZm9KL1lNdEN3VlZUWVdSRlFzVGw2YkdWV3RvbzY5dVJs?=
 =?utf-8?B?SWlKVXVpQlFLMDRSdUdMT1premJmdFRDRXdTN0luaVdISTU3QzFNOHdqTjF2?=
 =?utf-8?B?WFN5SngzQ0tvSWszQS92SVRuUzZ4dVpRSG5HL0tWMlZkWDNXZ1FPT1RFM3Zu?=
 =?utf-8?B?VGV2UUoxNUxYV1pPQitMbW5zS3RZMXdRbUk2dDFtZ0RKRWprVHhrZHJqWVhP?=
 =?utf-8?B?TGduUUZuRnJnVHR0SWZTREFJTFE0MWkrTmd0Sm41d25HVlE4TnZsTHVlWVh0?=
 =?utf-8?B?VmEwbUtCVitHQkloNFJSQmpiOVF1c2JEdS9TQXd2dmNIUjJlaHNDb3lTWjFQ?=
 =?utf-8?B?elk5YmRPdTRFN0svK0E5dWR6WXVmWUNqUmh6c0hlL1Q2ZHozODFvMlhSbDZV?=
 =?utf-8?B?QmpEai9RaHc0QWtsL2trVGowWjBMU2I1QXp3Q25MWVpQYmkydE5rNTI1NkZQ?=
 =?utf-8?B?Ukxwbjg1NXJ2Z0QrNTJEbXpSbnJ1RUtmQ0NtdTBkTzJWR0thQTFkTnhhTXI4?=
 =?utf-8?B?ajROK3llQSthTlJESkxTRHBFdDN1MVBDUXNuK2xIYjgvSjgvcXY2Y1FTM0Jh?=
 =?utf-8?B?MDlNMTJBVERLbVNlZDdVQmttUm9yMkVVa0xtYkIzYTZjVlZpdXVsdnYvLzdt?=
 =?utf-8?B?Zk5OWTFqWWlTY0wwZmJVUjc4T1RVRWhWR3dLbGtTZzBRbWtxVTFjTFpnd2FC?=
 =?utf-8?B?UHc4M3FDZ05YSmhjczhNWXZkNDcxNXVCQ0NyR1Z4aHdjdTZRanBCRW9haUlL?=
 =?utf-8?B?ZndCazh3VDZaaWhzUTRmV3EzNHNsZU9hWjNvYlVPSWlYc3JQaEYxTUlIY2RT?=
 =?utf-8?B?MXhjSVVDSks2Q3Vxa2QycU14QkZRZ3FvcWhYbVRzZFVrQmZScWQwOUdrdzlo?=
 =?utf-8?Q?CaELyWjM1zoHlKCW7iZtMUD8e4WO6Lg2Tp9FqpjQiSU3w?=
x-ms-exchange-antispam-messagedata-1: fBf7gYnUaNj43A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <6591B8927BAE9C41B4B3ABBE65C23B43@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa01fbe4-7615-400c-1f45-08da390df804
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 20:35:38.4099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LXn627u3731de7LBsxuk8WJeAGUByUbh7LbFgSZk6CnGuj35q+RoBqclCBeOqOrx3nfn+OqJoddFjL4PziCyHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6065
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8xOC8yMiAwNTo0NSwgVmFzaWx5IEF2ZXJpbiB3cm90ZToNCj4gRml4ZXMgc3BhcnNlIHdh
cm5pbmdzOg0KPiBibG9jay9ibGstbXEuYzoxMTYzOjM2OiBzcGFyc2U6DQo+ICAgd2FybmluZzog
Y2FzdCBmcm9tIHJlc3RyaWN0ZWQgYmxrX3N0YXR1c190DQo+IGJsb2NrL2Jsay1tcS5jOjEyNTE6
MTc6IHNwYXJzZToNCj4gICB3YXJuaW5nOiBjYXN0IHRvIHJlc3RyaWN0ZWQgYmxrX3N0YXR1c190
DQo+IA0KPiBibGtfc3RhdHVzX3QgdHlwZSBpcyBiaXR3YWlzZSBhbmQgcmVxdWlyZXMgX19mb3Jj
ZSBmb3IgYW55IGNhc3RzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVmFzaWx5IEF2ZXJpbiA8dnZz
QG9wZW52ei5vcmc+DQo+IC0tLQ0KPiB2MjogaW50cm9kdWNlZCByZXF1ZXN0X2Jsa19zdGF0dXNf
ZW4vZGVjb2RlIGhlbHBlcnMNCj4gCXRoYW5rcyBDaHJpc3RvcGggSGVsbHdpZyBmb3IgdGhlIGhp
bnQNCj4gLS0tDQo+ICAgYmxvY2svYmxrLW1xLmMgfCAxNSArKysrKysrKysrKysrLS0NCj4gICAx
IGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9ibG9jay9ibGstbXEuYyBiL2Jsb2NrL2Jsay1tcS5jDQo+IGluZGV4IDg0ZDc0
OTUxMWY1NS4uOGYwNjdiMDIxYWYzIDEwMDY0NA0KPiAtLS0gYS9ibG9jay9ibGstbXEuYw0KPiAr
KysgYi9ibG9jay9ibGstbXEuYw0KPiBAQCAtMTE1MSw2ICsxMTUxLDE2IEBAIHZvaWQgYmxrX21x
X3N0YXJ0X3JlcXVlc3Qoc3RydWN0IHJlcXVlc3QgKnJxKQ0KPiAgIH0NCj4gICBFWFBPUlRfU1lN
Qk9MKGJsa19tcV9zdGFydF9yZXF1ZXN0KTsNCj4gICANCj4gK3N0YXRpYyB2b2lkICpyZXF1ZXN0
X2Jsa19zdGF0dXNfZW5jb2RlKGJsa19zdGF0dXNfdCBzdGF0dXMpDQo+ICt7DQo+ICsJcmV0dXJu
ICh2b2lkICopKF9fZm9yY2UgdWludHB0cl90KXN0YXR1czsNCj4gK30NCj4gKw0KPiArc3RhdGlj
IGJsa19zdGF0dXNfdCByZXF1ZXN0X2Jsa19zdGF0dXNfZGVjb2RlKHZvaWQgKnB0cikNCj4gK3sN
Cj4gKwlyZXR1cm4gKF9fZm9yY2UgYmxrX3N0YXR1c190KSh1aW50cHRyX3QpcHRyOw0KPiArfQ0K
PiArDQoNCndoeSBub3QgdXNlIGJsa19zdHNfZW5jb2RlKCkgYW5kIGJsa19zdHNfZGVjb2RlKCkg
c2luY2UgYm90aCB0aGUNCmZ1bmN0aW9ucyBuZWl0aGVyIGFjY2VwdCByZXF1ZXN0IHBhcmFtZXRl
ciBub3IgcmV0dXJuIHJlcXVlc3QgaW4gYW55DQpmb3JtID8NCg0KLWNrDQoNCj4gICAvKioNCj4g
ICAgKiBibGtfZW5kX3N5bmNfcnEgLSBleGVjdXRlcyBhIGNvbXBsZXRpb24gZXZlbnQgb24gYSBy
ZXF1ZXN0DQo+ICAgICogQHJxOiByZXF1ZXN0IHRvIGNvbXBsZXRlDQo+IEBAIC0xMTYwLDcgKzEx
NzAsNyBAQCBzdGF0aWMgdm9pZCBibGtfZW5kX3N5bmNfcnEoc3RydWN0IHJlcXVlc3QgKnJxLCBi
bGtfc3RhdHVzX3QgZXJyb3IpDQo+ICAgew0KPiAgIAlzdHJ1Y3QgY29tcGxldGlvbiAqd2FpdGlu
ZyA9IHJxLT5lbmRfaW9fZGF0YTsNCj4gICANCj4gLQlycS0+ZW5kX2lvX2RhdGEgPSAodm9pZCAq
KSh1aW50cHRyX3QpZXJyb3I7DQo+ICsJcnEtPmVuZF9pb19kYXRhID0gcmVxdWVzdF9ibGtfc3Rh
dHVzX2VuY29kZShlcnJvcik7DQo+ICAgDQo+ICAgCS8qDQo+ICAgCSAqIGNvbXBsZXRlIGxhc3Qs
IGlmIHRoaXMgaXMgYSBzdGFjayByZXF1ZXN0IHRoZSBwcm9jZXNzIChhbmQgdGh1cw0KPiBAQCAt
MTIyOCw2ICsxMjM4LDcgQEAgc3RhdGljIHZvaWQgYmxrX3JxX3BvbGxfY29tcGxldGlvbihzdHJ1
Y3QgcmVxdWVzdCAqcnEsIHN0cnVjdCBjb21wbGV0aW9uICp3YWl0KQ0KPiAgICAqICAgIGZvciBl
eGVjdXRpb24gYW5kIHdhaXQgZm9yIGNvbXBsZXRpb24uDQo+ICAgICogUmV0dXJuOiBUaGUgYmxr
X3N0YXR1c190IHJlc3VsdCBwcm92aWRlZCB0byBibGtfbXFfZW5kX3JlcXVlc3QoKS4NCj4gICAg
Ki8NCj4gKw0KDQp3aGl0ZSBsaW5lID8NCg0KPiAgIGJsa19zdGF0dXNfdCBibGtfZXhlY3V0ZV9y
cShzdHJ1Y3QgcmVxdWVzdCAqcnEsIGJvb2wgYXRfaGVhZCkNCj4gICB7DQo+ICAgCURFQ0xBUkVf
Q09NUExFVElPTl9PTlNUQUNLKHdhaXQpOw0KPiBAQCAtMTI0OCw3ICsxMjU5LDcgQEAgYmxrX3N0
YXR1c190IGJsa19leGVjdXRlX3JxKHN0cnVjdCByZXF1ZXN0ICpycSwgYm9vbCBhdF9oZWFkKQ0K
PiAgIAllbHNlDQo+ICAgCQl3YWl0X2Zvcl9jb21wbGV0aW9uX2lvKCZ3YWl0KTsNCj4gICANCj4g
LQlyZXR1cm4gKGJsa19zdGF0dXNfdCkodWludHB0cl90KXJxLT5lbmRfaW9fZGF0YTsNCj4gKwly
ZXR1cm4gcmVxdWVzdF9ibGtfc3RhdHVzX2RlY29kZShycS0+ZW5kX2lvX2RhdGEpOw0KPiAgIH0N
Cj4gICBFWFBPUlRfU1lNQk9MKGJsa19leGVjdXRlX3JxKTsNCj4gICANCg==
