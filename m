Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4894B597A4B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 01:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241989AbiHQXmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 19:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241981AbiHQXmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 19:42:44 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62A39D11D
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 16:42:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+9uk7kd2fognMh92/Uu8TFV+G0F1N+kggKGa8ifUOOQ0jaMa0xpc1C3qxoxhtRWqNXUpO3c6ZYNVtKlCFV4ebgSQultmSrXtPUhNUkaFuP96DQOgQfsIpfDGuwKdjsivar+4SlKzZPGJGC2juxQNUU94qm/PQDDbmZMiHXsdXhu15aqAjpdKil3DvkAyb83YoNcPz1Zwn9kZdG0yll/BstMA7kcXewwTsE0LA02YPAR/fzUOskNgYDjIO9XhfgzH/DVLz+bOoLYcffio+0FwT7xJGfsn+OgGa+GHYsfSYgjM0R0QtJqkPoIwF8iCRS7PL4qpXcfprbGZO3Q1HjGBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9loWoYNFevlsgf75CzJ0e9r6eaXQHX4IEZQp75GFLRw=;
 b=DqxmQvbEaxWdM7rDpQpaCdU87vtkDuaN2IZgKgLzgixpqmn2XryXqcD8nDz0SIi7BZlH96xoD8GOd3yPs4DRkwWFfMHpLJh3jhZmxQhNKKOZfs3WvtxJwRCDaGOZyNnD/rM9xJqAIbTz6LVUk6TcNxHV+/52g9T5abGiPziqOd/lWQKZs5x4Bkr0Jx7caUbhZIdMoEaW7g7bmDudc+WOwL00KbylSZKV7xpBD6BbVOgRauh34I4pjDk3EAhIHH2ubvi726chPN9GYZm7l0zqjWwMsgIyfJsr9NTxNVDOfHx5W795zp8Lcn8Yv26/GXX/kdD/ajd+Xk6eFq1J7Gqsiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9loWoYNFevlsgf75CzJ0e9r6eaXQHX4IEZQp75GFLRw=;
 b=PocfqPqM6s6diyNxsUvrDCmpnKIEoBiZoFTckHzitJZoEhAG8aYwU71Q0EBrrI2y3Oi1yCbiHC4vLYXJQ9WLSF7Py+9gUEzUoZKOEsM5a2CByoIKVmCle8sAuRvK5PP9ySSs0A6OTJssnzxSD9PzLq++zXFFTgmK4pO919E8dzT2e1Fkl2SKwviGnp13fa2yJKh9mWW+v2RrwYP5pRumXqm1x1H2g9GRxj55Y+qNL6NDEeemeWx1pyRjlhV8xmUpBFZlylxpbteiGnA+YMT2OaPQdUaa1WpDH5hIkdjijWGCkabZYPAhWT1cJs603wHERuty1SxwVWPWpDsrmuJHDg==
Received: from DM5PR12MB4663.namprd12.prod.outlook.com (2603:10b6:4:a9::26) by
 MWHPR12MB1567.namprd12.prod.outlook.com (2603:10b6:301:d::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.15; Wed, 17 Aug 2022 23:42:39 +0000
Received: from DM5PR12MB4663.namprd12.prod.outlook.com
 ([fe80::b4ab:4d63:1cdd:b051]) by DM5PR12MB4663.namprd12.prod.outlook.com
 ([fe80::b4ab:4d63:1cdd:b051%4]) with mapi id 15.20.5504.025; Wed, 17 Aug 2022
 23:42:39 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [RFC PATCH] nvmet-tcp: Don't kmap() pages which can't come from
 HIGHMEM
Thread-Topic: [RFC PATCH] nvmet-tcp: Don't kmap() pages which can't come from
 HIGHMEM
Thread-Index: AQHYsVEedeiw0ct5d0K1OQCxtBxFsK2x4hWAgAD3FICAACbEAIAAw4EA
Date:   Wed, 17 Aug 2022 23:42:39 +0000
Message-ID: <960e89d2-b32a-4da7-97fe-7157f905fa9f@nvidia.com>
References: <20220816091808.23236-1-fmdefrancesco@gmail.com>
 <YvvpJbOT9iv6rnm2@kbusch-mbp.dhcp.thefacebook.com>
 <c11e62ae-3439-e3e3-adba-d7f5f951791c@grimberg.me>
 <3177256.oiGErgHkdL@opensuse>
In-Reply-To: <3177256.oiGErgHkdL@opensuse>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 230f2d12-6a2d-4fdb-3d07-08da80aa2bb3
x-ms-traffictypediagnostic: MWHPR12MB1567:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YY9A4ECr9sFi+i4yyAI5bskLq0WQGQx7rwQvbuM6gmFLGLj/GvAlEqMGIspMurO6VBNwKHdiLUR/LMtRWfMBEOTKvv6M/oMTT32LbmjveGfsXhsWcw3mWc+WK+4OPstrR/7Q5zBsWD8n9F3w++qxrl6bfREgNF3iTLcKr19uTW/C7/UOqg0ZQ1BNfhx09hX6jxlI+kwUbw6+iRLhQToG0Ww2ihch3HOVbOToVqvWvlj+/BGTlsJLMNeX5ZLqJ90JQwSSA+7tbwwn6PoNQ+JkPKXg0eLYei1ZqSF12uK9Edl7ToJww2mta3xXkhSp95AFpqPfGSRZiCbFLQCJI/9OYfRxFvUWi+V783x7MLX3MWKBbHJsVwqh6KVc7Xbs/3O7pPpV70nYgrClfBLstz9AtjOOycxpHA2p5STSqw1VKMkGXnC6EvCheJlO2sfMjhDIIqL0U2i2QR87ZWhfrPmlEoEmFuNJOguRycZwXl3wyJWtI0eaewADV+YmhY5bCbT+ogPE3xzYFBqjfMt224mqkJeTXwDnbugvVkxtPOPydoVhLQlfL9LornXQ7gyIZ0h4KS1IsbcYeak/2jewtRXn/qQ4MTcfTldc140ApEJmnm3p9F3iKwgEaS4qjsN51olYXJ6skRuroM2FIOprRlpdOu4Xqdh5QHipe3j5zv4VF0XwrRvy+UHXqZXOLC9p2tG+ErHxK+C1DR3+JpAEsXIcCy7ne5Y0PRKyC3KzVeg9SKFfblyQDabkAUu1ubVrroXbcQ3OJbWrNen0NVsxJVWHvXby3WCcCZJETm7u/rAvcs337+4n8wq2uOa9g+MyKvjgBtkvk4kFdGxrsYS1J8pzgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB4663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(6512007)(186003)(2616005)(6506007)(107886003)(36756003)(71200400001)(478600001)(6486002)(41300700001)(31686004)(76116006)(31696002)(4326008)(86362001)(38070700005)(83380400001)(91956017)(8676002)(122000001)(316002)(2906002)(5660300002)(8936002)(66446008)(6916009)(66556008)(38100700002)(64756008)(66476007)(54906003)(66946007)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VE92SXBpdHdBd0owaGVYMFlVcVZkOTFOVnJKTUI4ak94SE1SZ3hvOEt2SnVp?=
 =?utf-8?B?Wk9SemhZclV1RXpqRVplUXU4dVJnOGpKaFluakNBUy81Uk5QekxOSDlMWVZD?=
 =?utf-8?B?VjlDaTIxelFpUHZHdE1QWktmVTB2WEtiOVg3RklVVDVuRWtHVHAwN2JFck96?=
 =?utf-8?B?RWk2Sy9SUWRQNlZEK0k0bnY0blZnUEducm4vejVCTFU4TmVDMXcxMWo2TkNU?=
 =?utf-8?B?L2ZOUGEwNDhVUEt2ZXpUZ1lGQnR4MEpKK01LZ3JtZHVtV0JjdTZlSVgwbEg3?=
 =?utf-8?B?d21tSzZ2OXYxWXhqYS93ODg4RW5YMEVlRmY4ODlNQVYxQmJ2VmdWT21ha2ta?=
 =?utf-8?B?eFVhNkw0WkhpdzRCdGhIUjNwdVAvbWNkOXhQdnY0RW9ySlBLU1hubXo0UUNV?=
 =?utf-8?B?SDlNNGUvUGpINzhHaXN0UDFMclk3TGN3N1lNSHBZN1NDTkpVZ0NIUUw0Z000?=
 =?utf-8?B?Ymw2Mjc3cVJNN1RpV0pRY3hOVSt4UHh2cnZLMTJwWmR5c1o3aFJPb2JZTWwv?=
 =?utf-8?B?eDlnZm5XTXFSb1VsbDQwLzdnaFZIMzlmS1BScVNGMWptT0p0WXlvUlFSeHBx?=
 =?utf-8?B?VnliVlBNb1F6ZjlCSWd5ekFGYnlDblFNTTVvMTRIcDFXWm5hSGtkaDVHb0t1?=
 =?utf-8?B?SDk5QS9jc2cvdWJJdS81WnZEZDl6S2lhWXcyaWI0UkZJMDhGS296WnN0WE1w?=
 =?utf-8?B?eEZtOFUvTy90RGgycnJQdDVlbzV1cldSVERjbWIyS0dDMXZORkhzKzFBNjlW?=
 =?utf-8?B?d1pLL2tDNmIxVnI0ekNXSDVYSlRIcC9pdEg1RjhxY3ZGekdtQTdiRDdEU1lt?=
 =?utf-8?B?T0FKMkxFQ0FjczErMkt4dklSU1VNSU9VemdzN2lrRXZkdUtJNFN6NWZyUkxr?=
 =?utf-8?B?S3owczUzdjVuK2c5QzV3ajFsd1VVSXFNTCtSWmdNNWdBYzQ4YTNWSVlubUVF?=
 =?utf-8?B?RE9wNDczbk1jaHNIcTFjSExMSm9CN0dYNVU2dGJjbS8xYzN4RVhCQ29EM2J4?=
 =?utf-8?B?ZTVpVHRVK2t4UUFKUVlOV0FxYjhlN01KQ1VmKy9hOWRwSDB2TDVCRG9TUENJ?=
 =?utf-8?B?Y1ova1NWWFhQSE5RdHFoemQxSXNmUEcrWmZyaEE4WDZ0SXc3dnROTEozSmRJ?=
 =?utf-8?B?UVQ3RVlXdEZCdC9MUDNkcjJmWTNpeG4xOE4xelh1M0JCWW53R3BpQk8rVVpQ?=
 =?utf-8?B?VkgrSGw4cVEzM3ByekIyQjdoQmRaN3hXK3pUZ3pkSGR3bXF2WEYvSW5WWHVJ?=
 =?utf-8?B?SzhqY0dlNy9WVnFhOTcxY094SHQ5WkV0cy9lM3pyU3BKYkVYd01qZSt0a0lF?=
 =?utf-8?B?dFp1M0N5U2ZINHNhODJDbmhvb0NsTlFESm9jN3RtWHVnNzF0VGlCSDhHTFRH?=
 =?utf-8?B?ZUltOVBaVWhHZWM2L0NGaWhEU1NGc2hZTFByVU02SzVCTS9tcVNrNTBLMzhM?=
 =?utf-8?B?dTM4OFZUSHJ4WDVwZmFZOTNSdFE0Yld4Wmx2ZkpVT0RjYkI5dWQ4bkRWVnRx?=
 =?utf-8?B?ZlNySFFWcWlxcFFvWkZicm51dVNUSlVkQzc3VStRRTZ0RXorUWkrNEMxSHls?=
 =?utf-8?B?cVIwTmJvdnpGYUYxc2pFUWZFakdtVGNlb0dtS3B0SDVTMXAxazgyZkdDdlEw?=
 =?utf-8?B?MDI4eExaUUJGczN4SGNFaXg4TW5wUTIvcHc4WFdtaHJzTWNCVjQzRzgvZElO?=
 =?utf-8?B?S0xOYkc3QnMrRjJxbW0vV3dJTm9JcS96dnJuVHp0Mnowc2FQQWtBSlh6cVM1?=
 =?utf-8?B?dUk3QWJZTG1FK2pmb3BDaTgxRzVlSGRRdnBJdnE0TVZHQk95UUxsaEFBSVM0?=
 =?utf-8?B?cjh1Y0h0TVV5Z0dXL0VXQ0cyR1pPdjB3blduWCtYbDU5VnFwRnlON3dHakYy?=
 =?utf-8?B?cnJRN2FwR2VkT1J0SExrYndlS0VQRXFQWUg5YmV3ZTU5WktVTi8vbDF2bm5H?=
 =?utf-8?B?b1RjbGQ0bWdMVEIwZE5RTjBnaW0ydnZ1VEVVb0N6N1FjNlJZcEVBbmlla3RY?=
 =?utf-8?B?QWxsSlh4U09JWmovbmJGUVBZT2FlRTk0cGQ4cFpaMlJha09iVzlPZDdLaEIx?=
 =?utf-8?B?UEhQRnk1TlVNNnNhK3ZocVdWY1BWRDFKcTYxTjlFQnk4b0NTSC9TTy9LOFhn?=
 =?utf-8?B?a3BMc1l5ejF2OE5icGVVSjNtQmlIQzBWUXFBeFlPN0tqRkIvYldiRng5UEdq?=
 =?utf-8?B?V2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EA3DD37AA6EA141AE55D7FF7251D739@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 230f2d12-6a2d-4fdb-3d07-08da80aa2bb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 23:42:39.1996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KQGaRFtDcwZ22WJjkJExc17ew8HvHjZC5rD4V1as8h2ymUlzxUaumgeX7KSC4eU996KiQN29bQaBKPnYntRV/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1567
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IEBDaGFpdGFueWE6DQo+IA0KPiBTaW5jZSB0aGlzIGlzIGEgbWVyZSBzaW1wbGlmaWNhdGlv
biBhbmQgc2hvcnRlbiBvZiBjb2RlLCBJIHN1cHBvc2UgSSBjYW4gc2tpcA0KPiB0aGUgcGVyZm9y
bWFuY2UgdGVzdHMuIElyYSBhbmQgSSBoYXZlIHN0aWxsIGh1bmRyZWRzIG9mIGNhbGwgc2l0ZXMg
d2l0aCBrbWFwKCkNCj4gYW5kIGttYXBfYXRvbWljKCkgd2hpY2ggd2Ugc2hvdWxkIGNhcmUgb2Ys
IHRoZXJlZm9yZSB3ZSBwcmVmZXIgdG8gbGVhdmUgYWxvbmUNCj4gZXZlcnl0aGluZyB0aGF0IGlz
IG5vdCBzdHJpY3RseSBuZWNlc3NhcnkgZm9yIHRoZSBkZXByZWNhdGVkIEFQSSBkZWxldGlvbnMu
DQo+IA0KPiBUaGFua3MgdG8geW91IGFsbCwNCj4gDQoNCmZpbmUgYnkgbWUuDQoNCi1jaw0KDQoN
Cg==
