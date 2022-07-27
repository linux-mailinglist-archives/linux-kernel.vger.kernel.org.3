Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB7B583501
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 00:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiG0V76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 17:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiG0V7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:59:53 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA7B4D83A;
        Wed, 27 Jul 2022 14:59:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGOnQ70FR6iraqCqU8GtV3AAaVaNoahSlKnjZkCItSjkx/VjaOGB3YXQHNOXig18KgjkEh/vXl4K7Aq9QbP5YnQo690MODtbYKrLxkVq/tOzMh/o9QPNnOuRK8iVVQWY9dAfXedJiUq81MrOTAg/FI2bNn7fiRHlB94o+9dsZaAmNmSQtGqgVeiV8oAwWlkBPH7yvvHU4ZapaxgoXBRcSdrCNw1fKm4jt5M9n73XJ0B6CV9z15BGHBcnXdfNEPVYxxtLlRKrH1s3tHoGOAKj3s7RD+VKk6Pl7gD16j1qKEoVh6vEd2QRbSpKn2yS+hHF6MjwY2EBf0i3R6aoJvjllw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KXPtGxkndMDf0YmBxcJ8Nhf0OhNEh3LXlaYJjm7UZI=;
 b=EYI/v2meX4FnJjfP+oxd+q/ghfzpavDahHM6kY6q2SE3ERY6SvE1xzF3D2IZyrSXq8qM/MMiXJHnHZ5h/Ff6LOor+6lvXPTUbuT/V1JlD2C+1mz6kSxyVrNNdM9YgyVuX2HcCj87zORHDPbQfY32kGSF+QoM2fvahaf+FRrqxfaN+3F2hpz1SnISLtnubFTLLAD0yIz7CpkIjxK0E5cugu1nHM3J6Qa2T3o8OUeuWzwubBV8f8h+man1Z8pVwdcvdo0vjISu1tWJiooizfEZY4lwM3CkDF2K5D8VhpspSUiiqR4RENBkYFcGagL4F9rdAZivE+rA9WGqtIn5NFIIaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KXPtGxkndMDf0YmBxcJ8Nhf0OhNEh3LXlaYJjm7UZI=;
 b=mdDaPpj50OXHw6tF72RPPDU0B1Bu1awE5JkD2BB0a5D7ddgNkbbBNff8NoNEFJ71csWOXMl+mHRsTb18cqCTybOZhR9VPk4QMb7UN+58aoxA9O24+lQgZFi+58tS7qfw0yYKxFDysD0BCoGomfsWvfF9yZ1SoBWM0BPOiwWZ5jEjslNkNvxL80D+kwymrMPoyFjeoAc0MWlSFwK7Zbgv1EYMcLYbAifNvOCc7sLm5gxHu29Uu7VKtF7mv+YboWo6C3GuPS8u6OpHS5a3x+cZEHUdJ0GFp7pHgzIdk2oS4xKSFd5Its7xv4MV24INvym0ot71zbuVpGiGXrcgLlSWjQ==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by MN0PR12MB6080.namprd12.prod.outlook.com (2603:10b6:208:3c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 21:59:51 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::21eb:6424:fbf6:a189]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::21eb:6424:fbf6:a189%6]) with mapi id 15.20.5458.024; Wed, 27 Jul 2022
 21:59:50 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
CC:     "snitzer@kernel.org" <snitzer@kernel.org>,
        "matias.bjorling@wdc.com" <matias.bjorling@wdc.com>,
        "Johannes.Thumshirn@wdc.com" <Johannes.Thumshirn@wdc.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hare@suse.de" <hare@suse.de>, "hch@lst.de" <hch@lst.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v8 05/11] null_blk: allow non power of 2 zoned devices
Thread-Topic: [PATCH v8 05/11] null_blk: allow non power of 2 zoned devices
Thread-Index: AQHYodViv/Y7J0eqK0KIahJ7h6pcpK2SxLgA
Date:   Wed, 27 Jul 2022 21:59:50 +0000
Message-ID: <bbcfe218-5bae-266c-5712-3489b2eeaaba@nvidia.com>
References: <20220727162245.209794-1-p.raghav@samsung.com>
 <CGME20220727162251eucas1p12939ac3864fd8705ae139eb2d1087d8f@eucas1p1.samsung.com>
 <20220727162245.209794-6-p.raghav@samsung.com>
In-Reply-To: <20220727162245.209794-6-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfd20fb2-4f0f-4a90-be1d-08da701b5470
x-ms-traffictypediagnostic: MN0PR12MB6080:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Vi0donuo2Yr+6seP/Sg2eAUDPnyKlxoMdf31OT9WtUezLKoq3xI6reu6OgVvhEp3h0QQNK8BdOTRp+HLB5QoWrJXSZjXmS4tP96C3MJ3MhrJr20J9l/ETSTk4yjYNEEEZzZY8/SGTtESPT/tXT7bNc7EFdzE/z5Os9fnpVwDdtWfVJQOhviyeJIIiK0NtcSXNx714A4G9bC6roHwX/zhQ/Fvhr8bwfwVJOnBoPEM/cqyvC1RD2k6nRsFS1il+2NMQKHT0jGmwiCeKv/YVq+M72XztAxL/iEQ/raaMskND76f+NUyueXjTN/tRFdT6MFAuP9BsfC3ym3588VIjZ7U5Hq1qjXaS0Clshj11zJslwcpr3JdqlP1p3r1gYd1FAyOfF7SMVIr6lGe+tAO9OZefyikouafiZYK8Ptmst7btbTa5bkELxmF2qLsPvSxilXZlnyQjyHZmbMjLgz/giQIk4ULq3GtA8emOGwuOtsVcZQ5bh/eU4wMkpZizfNHPAxRjRVHSm1ZdQglwhm2tKkGpo+Lnia/pp1npZwPfGpLv/B26b279Fo/p8ZKnwG29SLi0pQBk97YBFAvOGYlG2CrpLDJ+vQJwj32mf0bHCVwq653yEc4w6qE1seYKaEHQSvu97Tc0wX0Q+c2u4su4okyO/m5Flj/AjQMSXBaynQWwFhtdM5AYI/zxfWhlrDH48kWeNL+mu44xYDttuEWEbRUU7sBCy0Ip+h2coloV4wSTt18AqJB3rA6polQCMDqKG/kOVJAhTlupFTug/b6iD79oh9lIFxkm63MqZkRfCYUZtWbr5LtMFzh7NWQEaAp0Kv1jEy5Aszi1f7sX8+Ig+wJMoqy+OPlIVTLb45qS6uMyKK0ETRNgU+65Rp27T1tBAn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(5660300002)(2906002)(7416002)(2616005)(6486002)(86362001)(54906003)(41300700001)(71200400001)(31696002)(26005)(36756003)(38070700005)(91956017)(6506007)(6512007)(186003)(66446008)(8936002)(478600001)(122000001)(8676002)(76116006)(83380400001)(38100700002)(316002)(31686004)(6916009)(66946007)(64756008)(66476007)(4326008)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eldWK29pZlFqQnFpLzhKRk85TUUzaTVabTN2RlYvRzRvVEVXOUxOM2xMZWM0?=
 =?utf-8?B?Y0dzT1lGcGx6dlFJbk9iWTArWlEzRzY2dUxMZHQwN2FCTlJZN011QTU1QTNE?=
 =?utf-8?B?N2RBNk95NDYrVWozOEN1RWt4WUgzQ3pvdXZYbkNQeTJrZ3pFaXcrL1RPclIw?=
 =?utf-8?B?dlh5bTM1Ykg3YUtETi9lU0lBYmJxTmdQRUN1ZlJoQjM1SUdTd2xtbVo3c01O?=
 =?utf-8?B?aXk2V2kyYXR3Y2FQM0RaMnBUOW5QSUZtQmZqVWFGNm5XSDNWeFJXN1lIbHdB?=
 =?utf-8?B?UHpydXRxa1ZBdmFqMVQ4Uk95YUIzK2RsWkQ3RjQ3VllSYThlNld2cjVXaU91?=
 =?utf-8?B?Z3Y1UGU4THlRTVNDRUNkV3Q0L0hTcVFuNWF3YjNZMnlUOElack1yUjN4eTZp?=
 =?utf-8?B?SkJoMUtEcllicHBScHA2UmZCby82SVV0Z3luV1FnOExzRGxvRGRqeVhydS91?=
 =?utf-8?B?V092dUFEVnVnQ0UxL0JBTDNuYkdySC9CbzhjNmdBamRCZE4xVm4zRFJ3TEdw?=
 =?utf-8?B?bnJTUGtDZS9jTTE2Wmd3Mm95NkRVdHpSY1NlR1dYRjJPd0V1T1JUUUNCWFI4?=
 =?utf-8?B?TWRJK0JOc2syOExyZjZaWGVFWU9YekNtczkzWkZZNFJYNHZpQzZlVVdZMC9J?=
 =?utf-8?B?SVViSkE5MTFuMFRzSURSZW8vVmpEay9YOTJuVDZPaXNrUVg3K21RdjRQdFRY?=
 =?utf-8?B?Y0srNlRyaHcwWnBqYzFDTG0xaXZRWjRrUm13V09CZnhMN3dBS3ZpOEtPdXlt?=
 =?utf-8?B?S0dOUjNmNmdyVm5OSzAyNG8zQXVWS1BMdDBHUkpJNnd4WXJZcHNCRW12OWJu?=
 =?utf-8?B?aVQwNzYydjl4bFFacHhEdklEVEV0ZDNxUW1QaldWaHdTRGo2WU43TVN4eDRk?=
 =?utf-8?B?Uk41eWwrdE9BMDZLK09qcUt0ZE8rMkRKbitlOG03MWdCUnltZEpVYXdxRXlE?=
 =?utf-8?B?MHJiZVovNit5b1dHRmRsdnRaWnQ2d2JORVBwT2Rzd1YrQ1JGY3ZVOFJiUnpy?=
 =?utf-8?B?TzdtODJTRXJqUGRGNU9Nb0JCTVpSU2NFU2NTZWJYQ2FiMytjdjFHZDgxK3RY?=
 =?utf-8?B?RDMxRmVoRVh0U1BEZVdDN2dEL0tSZmlHRWJIMytFRmw5eGRlWkZ6RkFLcmxq?=
 =?utf-8?B?UVhXNDN0UFk0WHZyZFZHSlkwU1U1RnIvaVpuZ0hIT1A2c0I5eUdCY0lKUkdL?=
 =?utf-8?B?QlVjUWhnMEJsdEx1UUVrYWtJdFdxRWF3dW9LMUsvSDhjVUtmWGZIeHplOThk?=
 =?utf-8?B?aVRMbGlGOWJoaWh1SWpvOFNrUGFUTFJrcERwOVRnOFQzdmxTVyttdFhoQ1lv?=
 =?utf-8?B?UTdhQzFNRlRsS2JTdnpUaENxMjRkak1UemZwQ1VHZk4zU0tsM2ZHdWV1S0ps?=
 =?utf-8?B?c3ZTdExoTWRVOTNBditIOXdUQzBxWTJWYWl3SjR4SlVvRUxKYnpGb0ZYRmk5?=
 =?utf-8?B?RThLKzNvaXJrNEQ0ZFV2bFpaRUNydzMrNHd1KzcyNUtHMGYxcWJTNlpLVmxu?=
 =?utf-8?B?dHZDZ285Vy9YdHhqMUM1STdXcS9FajlyblZKUjdFeG5iZmhpeXpPVHVoTXNB?=
 =?utf-8?B?SGR0dzd0ejlUdG9VVkd5cVluNHBpVjBtTGlKeXRKeGhIKzVuOGt4TEZOYWxS?=
 =?utf-8?B?MFRFaDhtZXRqemliSGwrQlJZNUg5czhKNlArdENBUFVQYlM3bHBicUlwMjgz?=
 =?utf-8?B?ZHhFUjJQTVZrYWMrQjFhTFhsTmp6Z3ZDdFZCbm56eG96b0QvWjJSZmZjcE01?=
 =?utf-8?B?eENlRDF6c1ExZmNhSlptZnVDalBqM095Vlp2dzNKK2R2b2FlV3hJWW5Rd2pi?=
 =?utf-8?B?M0h6dG5manNvL1dKdnJDNVlqbTRobGZuU2JrQlZ3T2o0bWh1ZXRRZ2F6ekhy?=
 =?utf-8?B?bmJ1MVlHSUZtemVkN1FMQUpWZEdqWTNhNkVxU05URjdZQTd0VXUxQWV2ZnBn?=
 =?utf-8?B?bTRJeWw0VVh1bmNLWjY2WGlQUkFicU1XdnFZRmFxRmZwK1NGcnQvVy92cUVo?=
 =?utf-8?B?SGx3a3ZkMm1HS2hWZ282dmdXRTlhN2ZnNUR3S2hwaWZwSUI1R3d2UWFFMkRr?=
 =?utf-8?B?NjF4bCs0bnNQREJnL05qZnR3V0VBQzhTVDdNam1Yc2lGYUFjSW8zTlU3T25G?=
 =?utf-8?Q?lc0Zrcy3e4A02OEL2xb1jnTsX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AA1B5F7B2C29A40A04790AB8C373DFF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd20fb2-4f0f-4a90-be1d-08da701b5470
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 21:59:50.9293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 81MggmUGkafdNaiHSSql/3OGl12QEFNwvZipHrdssrIDSW4JzYhoCIFhW9auT5YJgdKckzgibBo6O0xC0UevVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6080
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IFBlcmZvcm1hbmNlIE1lYXN1cmVtZW50Og0KPiANCj4gRGV2aWNlOg0KPiB6b25lIHNpemUg
PSAxMjhNLCBibG9ja3NpemU9NGsNCj4gDQo+IEZJTyBjbWQ6DQo+IA0KPiBmaW8gLS1uYW1lPXpi
YyAtLWZpbGVuYW1lPS9kZXYvbnVsbGIwIC0tZGlyZWN0PTEgLS16b25lbW9kZT16YmQgIC0tc2l6
ZT0yM0cNCj4gLS1pb19zaXplPTxpb3NpemU+IC0taW9lbmdpbmU9aW9fdXJpbmcgLS1pb2RlcHRo
PTxpb2Q+IC0tcnc9PG1vZGU+IC0tYnM9NGsNCj4gLS1sb29wcz00DQo+IA0KPiBUaGUgZm9sbG93
aW5nIHJlc3VsdHMgYXJlIGFuIGF2ZXJhZ2Ugb2YgNCBydW5zIG9uIEFNRCBSeXplbiA1IDU2MDBY
IHdpdGgNCj4gMzJHQiBvZiBSQU06DQo+IA0KPiBTZXF1ZW50aWFsIFdyaXRlOg0KPiANCj4geC0t
LS0tLS0tLS0tLS0tLS0teC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXgtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS14DQo+IHwgICAgIElPZGVwdGggICAgIHwgICAgICAg
ICAgICA4ICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgMTYgICAgICAgICAgICAgICAg
ICAgfA0KPiB4LS0tLS0tLS0tLS0tLS0tLS14LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0teC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXgNCj4gfCAgICAgICAgICAgICAg
ICAgfCAgS0lPUFMgICB8QlcoTWlCL3MpIHwgTGF0KHVzZWMpIHwgIEtJT1BTICAgfEJXKE1pQi9z
KSB8IExhdCh1c2VjKSB8DQo+IHgtLS0tLS0tLS0tLS0tLS0tLXgtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS14LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0teA0KPiB8IFdp
dGhvdXQgcGF0Y2ggICB8ICA1NzggICAgIHwgIDIyNTcgICAgfCAgIDEyLjgwICAgfCAgNTc2ICAg
ICB8ICAyMjQ4ICAgIHwgICAyNS43OCAgIHwNCj4geC0tLS0tLS0tLS0tLS0tLS0teC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXgtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS14DQo+IHwgIFdpdGggcGF0Y2ggICAgIHwgIDU4MSAgICAgfCAgMjI2OCAgICB8ICAgMTIuNzQg
ICB8ICA1NzYgICAgIHwgIDIyNDggICAgfCAgIDI1Ljg1ICAgfA0KPiB4LS0tLS0tLS0tLS0tLS0t
LS14LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0teC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLXgNCj4gDQo+IFNlcXVlbnRpYWwgcmVhZDoNCj4gDQo+IHgtLS0tLS0tLS0t
LS0tLS0tLXgtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS14LS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0teA0KPiB8IElPZGVwdGggICAgICAgICB8ICAgICAgICAgICAgOCAg
ICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgIDE2ICAgICAgICAgICAgICAgICAgIHwNCj4g
eC0tLS0tLS0tLS0tLS0tLS0teC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXgtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS14DQo+IHwgICAgICAgICAgICAgICAgIHwgIEtJ
T1BTICAgfEJXKE1pQi9zKSB8IExhdCh1c2VjKSB8ICBLSU9QUyAgIHxCVyhNaUIvcykgfCBMYXQo
dXNlYykgfA0KPiB4LS0tLS0tLS0tLS0tLS0tLS14LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0teC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXgNCj4gfCBXaXRob3V0IHBh
dGNoICAgfCAgNjY3ICAgICB8ICAyNjA1ICAgIHwgICAxMS43OSAgIHwgIDY3NSAgICAgfCAgMjYz
NyAgICB8ICAgMjMuNDkgICB8DQo+IHgtLS0tLS0tLS0tLS0tLS0tLXgtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS14LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0teA0KPiB8
ICBXaXRoIHBhdGNoICAgICB8ICA2NjcgICAgIHwgIDI2MDUgICAgfCAgIDExLjc5ICAgfCAgNjc1
ICAgICB8ICAyNjM4ICAgIHwgICAyMy40OCAgIHwNCj4geC0tLS0tLS0tLS0tLS0tLS0teC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXgtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS14DQo+IA0KPiBSYW5kb20gcmVhZDoNCj4gDQo+IHgtLS0tLS0tLS0tLS0tLS0tLXgtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS14LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0teA0KPiB8IElPZGVwdGggICAgICAgICB8ICAgICAgICAgICAgOCAgICAgICAgICAgICAg
ICAgICAgfCAgICAgICAgICAgIDE2ICAgICAgICAgICAgICAgICAgIHwNCj4geC0tLS0tLS0tLS0t
LS0tLS0teC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXgtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS14DQo+IHwgICAgICAgICAgICAgICAgIHwgIEtJT1BTICAgfEJXKE1p
Qi9zKSB8IExhdCh1c2VjKSB8ICBLSU9QUyAgIHxCVyhNaUIvcykgfCBMYXQodXNlYykgfA0KPiB4
LS0tLS0tLS0tLS0tLS0tLS14LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0teC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXgNCj4gfCBXaXRob3V0IHBhdGNoICAgfCAgNTIy
ICAgICB8ICAyMDM4ICAgIHwgICAxNS4wNSAgIHwgIDUxNCAgICAgfCAgMjAwNiAgICB8ICAgMzAu
ODcgICB8DQo+IHgtLS0tLS0tLS0tLS0tLS0tLXgtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS14LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0teA0KPiB8ICBXaXRoIHBhdGNo
ICAgICB8ICA1MjIgICAgIHwgIDIwMzkgICAgfCAgIDE1LjA0ICAgfCAgNTIzICAgICB8ICAyMDQy
ICAgIHwgICAzMC4zMyAgIHwNCj4geC0tLS0tLS0tLS0tLS0tLS0teC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLXgtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS14DQo+IA0K
PiBNaW5vciB2YXJpYXRpb25zIGFyZSBub3RpY2VkIGluIFNlcXVlbnRpYWwgd3JpdGUgd2l0aCBp
byBkZXB0aCA4IGFuZA0KPiBpbiByYW5kb20gcmVhZCB3aXRoIGlvIGRlcHRoIDE2LiBCdXQgb3Zl
cmFsbCBubyBub3RpY2VhYmxlIGRpZmZlcmVuY2VzDQo+IHdlcmUgbm90aWNlZA0KDQptaW5vciB2
YXJpYXRpb25zIGluIHdpdGggYXNwZWN0IG9mIHRoZSBwZXJmb3JtYW5jZSA/DQphcmUgdGhlc2Ug
ZG9jdW1lbnRlZCBzb21ld2hlcmUgPw0KDQptb3ZlIHRoZSBsYXJnZSB0YWJsZSBvZiBwZXJmb3Jt
YW5jZSBudW1iZXJzIHRvIHRoZSBjb3ZlciBsZXR0ZXIgaXQgbG9va3MgDQp1Z2x5IGluIHRoZSBn
aXQgbG9nLi4uDQoNCg0K
