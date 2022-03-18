Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424824DD1F1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 01:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiCRA2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 20:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiCRA2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 20:28:47 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F96D3D5350;
        Thu, 17 Mar 2022 17:27:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsJSrOypbWp8qEOFgDTRpoCgeUAzg/oRoN4GJyk9mtvLY+qQ8rvqecZJdnLNhd4t8t59wG0B1uoxNRzkwNtTXE8L+SUYqqH5L19RF4y7J5CmVPDErOSFedrR4RzoUESkE0qp4RYeH7g/+19VmBsqYDmhyM5yITCjwKDmj12mzZucdH8FZuxmvc/lKbEyJKs/N5dJWDbmY23Vk5s9Gpn7/5TrKOQW7/A/ShkylDVgBLq8kYNheD85JzlmP8vcgDZa1iIb2VGGm4mpzF9y5MX9L9uQn3gWVqjJeFGnKgcBDFU7d9vQFdQb12I7TiOKSFpkdd0VAc0yfeyfHXjWiAybEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n123T5h6GqzHcS9GsbX/BUuszFbiVFcJiRKA9G3Mzew=;
 b=ddUVf68BUFwr3jYRmaDJAHgzf/oeL8AT+HGtFN+OucPluKX0UiI1TMDA88yC9buzSFbcI9/dzGc0dyNIbacflcJB8zErBSYd026dP83n5cRom4jLA45QfGCmpedNkaUrr1dAl+TkJKusNZpHernaFB5h0uyXRXTkNLWN3d3/PnRK+VHwyDysy1jRi22jfNCv7VCUhDYjWkaA1RcdzcmvQto/8pxdoD+DG1WUwcP87hA2fWtkwDx/I8cpWzwkRkpPpTvu1mA1RD7amjBXlNoWqQ0OIx+W3sYhzSmNdNe5R+IYpWtnQs//J0kaHnBq2aBgWVzTizSAMRZ8Q8nyx3ItXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n123T5h6GqzHcS9GsbX/BUuszFbiVFcJiRKA9G3Mzew=;
 b=UHvxBuqLoZo5rWUi2zDRpqBYRDAZDa47ES39GoAOAoid3MtDk9UkIX1Iee15DNnUdFfKxkMl95QtLe1aSvkZwi6x/bre1fWxBQmxuyAsrH/ZAmZGN5v0zqxBlYSKDQmepd91k09SmnRO5P9nq475amPbyF+XsgQ6YYmN96fttGpNwZi/qFBOmxkB86sgUA60KW/32zdKy47+dzbtwGfdcPhrzTMK8UbL8A2BPrKxdAnvCr4OrfshhTQdmDDySj4GD3TRbbuMoTo+fFTQ6vuARJghpqp6OYtpYFAesuEj+LCOgsO995xAJDnDhCMz67mfvQw6tPGDYoXgaM6Ye2pBmg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN8PR12MB3201.namprd12.prod.outlook.com (2603:10b6:408:6c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 00:27:28 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5081.017; Fri, 18 Mar 2022
 00:27:28 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
CC:     "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "roger.pau@citrix.com" <roger.pau@citrix.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] xen/blkfront: fix comment for need_copy
Thread-Topic: [PATCH 1/1] xen/blkfront: fix comment for need_copy
Thread-Index: AQHYOkvDA9JzRaegSkiE+wRtHI7puKzESPcA
Date:   Fri, 18 Mar 2022 00:27:28 +0000
Message-ID: <4e5a802d-563b-1d53-5563-c9ed2582b826@nvidia.com>
References: <20220317220930.5698-1-dongli.zhang@oracle.com>
In-Reply-To: <20220317220930.5698-1-dongli.zhang@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ddbb6d4-c360-4496-13ac-08da0876155e
x-ms-traffictypediagnostic: BN8PR12MB3201:EE_
x-microsoft-antispam-prvs: <BN8PR12MB3201FCAC916A4192FDB6D2A5A3139@BN8PR12MB3201.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5w7Zd0KLrishRoVdWBecLKXqECd6JeSi6SQFeIuNiJK9Cy2GFrYuad8kVmWgQx4jN76CuM/8aLWwR8uwGwDaP/PX/h3RTO6+zPFLQjKG7lOdIguwf/Nn0Iz0hg5HFlgg+HDKKgtqH7519VnGUXxTlEMukFoYWY7bCXAMkeibElm1Oh1YwPSDODX7HkPnK0ogBHICTJ0tNgn7StC0th6CcBR+HYOFDd8iK+ee+qu+MTDjZBApGVXN0h9hsYWo7mLDlZqYbJyFxDimBsz9Dzk/ouR4mYAkzEDt++ejgID4qNJ+AynG6iQoNO7Ng1yJfk2E6xSpudG3vRnrzWB4d2WJiGpgCcjg0kxtEu5PjK0nBjShIcAcciUHWD5HA21q8N75NZxURlwicW/AE6yetxnEkAY3FUvt3sKpszNVEckr7XW6NGcQVmWzKjTgBP2gx37PivQZkKUSgzdw2kmtXQG1OsnImcnHDrHaNI6uI5H/RH28tk4EBGBvl3MLPvb5YTVhkI/Xrqn/dxBeX1bNxNald8kWW7l/ZnmBuiUB58x30fB7jY7p052TrBJL+DXZCgoBNLkX7Uyau9k6BWj8Wletyv1BEiJCrTwgieDtpmZdamYvBDx0nB3pNMwb7DOznIaLdYJac/2MLWj/K5Ih148iFJfvQQsgs9pYKKfrzqHy9sMJVyzcO3gZOkLdpr1quLghgf13v8U4G8kZXWtigDGqklyVTcsk30PLdVU2CTMnS9kUAadg2L8ttuwi4D+NevD9bovuh+z19uxMdUwrRJGuHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(91956017)(4326008)(64756008)(8676002)(6486002)(53546011)(66446008)(66946007)(76116006)(66556008)(8936002)(66476007)(316002)(38070700005)(2906002)(110136005)(4744005)(5660300002)(31686004)(36756003)(122000001)(54906003)(38100700002)(83380400001)(186003)(2616005)(86362001)(6506007)(31696002)(71200400001)(6512007)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFFqaUluUDdHdDBnS2pGa3RBRDR4aytCOU1id3RJa0pkL0RNUklXaFA0eHhU?=
 =?utf-8?B?Q3hmazBPclZRZGN1RS9DNHVhOGtibEozZFd5Q2hqTDNScFNDY0NzSVpTYkVD?=
 =?utf-8?B?QTJhWkxNbHpITDR3R3JsNVV3Mmx5ZGtpVVhzRllpQng2UGxWVFlYdVorSmJk?=
 =?utf-8?B?MjdRT0YwakpXTDcvNWIyUmM2cnVIOUUvMVN1eEMzZk85OWZFZ0ROcmFkdXlK?=
 =?utf-8?B?bmgwbXhuSm50RDdjRW9kK2xVQWNnWFdvZ3I0TjNvSFQyREpUOVhMYmc2eFBY?=
 =?utf-8?B?dE9zZHpmOEx1WnhQemc2MmVsNkdpVUEzQ25SUFR3cnEwSTE1cXM2VU9HTjVx?=
 =?utf-8?B?UUhpb2d3WW9IVDRiY1lRcGhFaUtDK2lYaXpWY3VtWi84QzE3N2NzRzEwK3Jx?=
 =?utf-8?B?M1UvUVFleU1KVEFBcUl4Z0lGVmJlTnRIQ3g1aGpSS29RS1gxK1BqZ3FzSmdR?=
 =?utf-8?B?VWxnZHY4eG9XTmtPaUJ6VURuMDhhYmYzbHlPSGlLcE5aeXJ6VFRmU09UN01L?=
 =?utf-8?B?QlRtV0lDR2F1WldNV05XQ05yTEh4N2ZyYkZ2MFdXaVNqMlRhcDYrQ3ZqUS9k?=
 =?utf-8?B?NFprOCtoajFSZksvSXA3WXJ5SVVzd3pXQVFJMXFzaDdBU1VUMndkb1BUR1pl?=
 =?utf-8?B?U1dpQmszdTM0SnIySE03TGZxeUZFRzY1akVHbU50bERvdjZaSE15ZlNha3BX?=
 =?utf-8?B?a0wvRHB5MzFNalB3dHR3alhsdFBkNEpZREF4UFhIVkY0b3lDYk8rdElFOFFB?=
 =?utf-8?B?T0JyT1FpS2UzNTRBeVdKMTdlRmpzNFRjb0hCc0d6QUtKQ3IrN2F0TTZVR0ti?=
 =?utf-8?B?KzROR1pnSVNXcW1WR2VndE16Z3BEclcvTjBUZFpTMlpTeEZzSmFWeVpTQkZu?=
 =?utf-8?B?WnlWblptVmNpUkViNCtjc1MrUU9uRzhBZ3RkOHpUTG5nVWVheFNQNW84Q0ty?=
 =?utf-8?B?UWZTVmRJdHlZbDRGbFFYaEkrMDdUSHV0TGh3NHFlOC9MQWxEaE9YVGhPR2J0?=
 =?utf-8?B?MVdCZmltVUZzQllkdFBXWWgrbnYrTkVuNXdqQU84Q0hHbzR1Q3JtTk5CWUJz?=
 =?utf-8?B?QVhQV2NCa3Bybit2NW1vZnd1b1ZqRkJWMXduem15ZXhJZWhXRCt2Z0h0OC84?=
 =?utf-8?B?eDI3SDJQVWVsUWNVbEdRWVZWbXdiTTBzVnU0cmJKckhoQnNyaEhQSFAwUHlN?=
 =?utf-8?B?dy95c1RYLy9sZWdLOG0xRzJld2tJb29XT1NyRU4rQUpYQnRoNm9nT0oycllZ?=
 =?utf-8?B?UWdXcHJOd2lTS2E0RWVZNm1qeHBXQW5SNks4akV6M3Y2bFlQYVZONHpXUTRw?=
 =?utf-8?B?ZWJvVERETUZIZFc4ejBrZ0pkUlR0RjU2elNDSVh1eHMzUHZEZlM2dXlwblM4?=
 =?utf-8?B?UGp5N3ZJREc2RDRZNU1XbG5VbXRhK0NXTzV6WGx4ZUkvbGF3cENnR2RubnRP?=
 =?utf-8?B?WXpqaFJRc1JZbmFFbjA0NWFGeGc1d3FHNytsUWI0dStIY3kvSXdSRWNwbW51?=
 =?utf-8?B?SExrS00wSWd5UnA1QUdaSHRXMlEwOGNERVdhUVFabGlzU2htTE94K1pQR2U2?=
 =?utf-8?B?VTZ2WGtaQ0NRTml1SDYvRSs3YnBRdWpNOHdXd3VZaDQ0NFVSem1XdU81cklW?=
 =?utf-8?B?dWRuUUI2cjhIenBkK3FMQTRVVkV3Lzh4MmtxVzhwTXlEQS94U2tzZ1FoUjY2?=
 =?utf-8?B?SVE3N2ttWVpHd2hBTmVmaFV6VEdKN095dlgrSWFsZFZha21wdUVMREZKdWVG?=
 =?utf-8?B?Z3dsYVp0YmdvVFJzcGtrQUpzaGVOaVREaXJBN3RMVXdqb3Y3WUViWnhnSmdI?=
 =?utf-8?B?Q2N4a2NOeTRlVmtLSUZ4dDdxZmNZNUMyQmM0MlhiRngzd05TMUVuY1A2MXF6?=
 =?utf-8?B?SG9FY1NPQ2RoaG8va0UvK0k1TFFDK0d6YmdDY1diQ1pid1VWVzB5cTZNbGVH?=
 =?utf-8?B?bEZEamsyc3FaTisrOXVMZCtQRXUrb2NaMFNCQUZ2eUw0dlM0dFNlMDJOYWpF?=
 =?utf-8?B?d3hyRGNEQklBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99630C566C512A42B0A52BB73A69F7F7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddbb6d4-c360-4496-13ac-08da0876155e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 00:27:28.3215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z/Qhc+pof+sIEwuGaksugiwvGtoV6rOunfDbRM7ur2r1oRPfBnLsQoyL+hjQgZGOVZwsTWNiNH0s2Kv7W5lKLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3201
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xNy8yMiAzOjA5IFBNLCBEb25nbGkgWmhhbmcgd3JvdGU6DQo+IFRoZSAnbmVlZF9jb3B5
JyBpcyBzZXQgd2hlbiBycV9kYXRhX2RpcihyZXEpIHJldHVybnMgV1JJVEUsIGluIG9yZGVyIHRv
DQo+IGNvcHkgdGhlIHdyaXR0ZW4gZGF0YSB0byBwZXJzaXN0ZW50IHBhZ2UuDQo+IA0KPiAiLm5l
ZWRfY29weSA9IHJxX2RhdGFfZGlyKHJlcSkgJiYgaW5mby0+ZmVhdHVyZV9wZXJzaXN0ZW50LCIN
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IERvbmdsaSBaaGFuZyA8ZG9uZ2xpLnpoYW5nQG9yYWNsZS5j
b20+DQo+IC0tLQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGth
cm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
