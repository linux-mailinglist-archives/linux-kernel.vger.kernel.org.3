Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFEE5231C3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbiEKLcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240203AbiEKLcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:32:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5099C5908C
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 04:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652268750; x=1683804750;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mO1eQMxb1y7hDEnQBFFyxNaop8H2Bu1R4FdlFzBSQEU=;
  b=mxsDY+L86HC4CDRiIenLqRLzK8QFIMiHG9ThIs+UvZik3Rnv/HLMRvba
   8ReHjDRi6+Sqn/j+ZCC/ayuu0ccuu+eKZ4xzA3kxw/m+td6dgjQUTqUM0
   dAbcEaYE5ba+54YRphjnpKqWtmpn9w27FUJNN8cO7/1vnRD3BwivR7Nbi
   X0lsmagb8G+4j6Xm0TNJeqjF7r7Q635zEzwhoXDFcnEqDapPFATqCnxf8
   7H2kZlhcREZJl2pJFMeszol6RzK+LzdGHwTEr2i2rkw1Sdllh+GlOBJGg
   +GALtPBfRe5E1OUvdpRIfC2zFpZUOTXWejniYkjbAXP5QbOlY7j6bwUXn
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="95328625"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 May 2022 04:32:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 11 May 2022 04:32:27 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 11 May 2022 04:32:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqQcYTBaR/5C9wUw8H9zxg+g3n929k0XYoRoc/KRn+2ASX0j2YgMOtA9D8pBy0DepcMEUQ2fI397BeNeJpW1Bri7KIu0v8eZfkjxmIB+3VohuHywBEMFj+hTev8MusmKxOb+mIr9sxK7TqxurfLcKfCYXI0vWaKQFDBEKIH9C8/TOW6sqBYCTrJ22W+d1vBbSjFW5eufrpiKaZLtZ6F5K7BGpCxV+xv85RbmYIguMnFsMkkHNnlJYcVnrYD7qi/zq8w53MiejqAJHyyXCjUZdat2A0Vu0IDNjQmxSiDcK3KpQpoL/Gb5S3dZj1QCgvl0TW8ak2M7tyI2gKAyVMw0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mO1eQMxb1y7hDEnQBFFyxNaop8H2Bu1R4FdlFzBSQEU=;
 b=hzWV1p/DdIS26j8uLYe4Z9AIjBZzu70Hzph79dopU3bUqCt0blEp0a1Mk2ZCD3eH6NaTgJCvp+JZdYpbbqVPpzkvY1xqDFiHIrtnpqqLjcEEOewGa0usK+zxm8+RIxqSGvjOQhFC16wqT2wBrnTdrh6R82Pm4dveZG9+ls5+BYoJdwd23I1H6BYQM9sgreVUbHqHlVkQMDAjZEoQmE3z7YgH1gNAXMjx6r/45P3QlVq9oWDa7ZIlgP6TN5Phd4rEYqqDXu3h0WBr1tUboQlT/kQh2YC2Y8cdELGuPdUaL5uuLbLNguJ71l+PbgjzHwF9u2q22uPCYbFK7EJ08N7dtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mO1eQMxb1y7hDEnQBFFyxNaop8H2Bu1R4FdlFzBSQEU=;
 b=ZhoxqbRyI2fX019JaQJQ2jsMlZolQGakBjfLDDhc1scvNpL3dPaCPFVfx6dwIVji6JgITYkjXqZI+6bLF8t3UKxeHGLblYDuyy+PDmrrdbcvQOogFC+trPobl22qzqrWCeft3Dq1eULn6gLqhCM4z9Y6ohhWQXX487GAFOXtZMY=
Received: from PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8)
 by SN6PR11MB3519.namprd11.prod.outlook.com (2603:10b6:805:d0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 11:32:23 +0000
Received: from PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::d10f:cc33:cfd8:365e]) by PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::d10f:cc33:cfd8:365e%8]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 11:32:23 +0000
From:   <Conor.Dooley@microchip.com>
To:     <xianting.tian@linux.alibaba.com>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <akpm@linux-foundation.org>, <anup@brainfault.org>,
        <wangkefeng.wang@huawei.com>, <rppt@kernel.org>, <alex@ghiti.fr>,
        <twd2.me@gmail.com>, <david@redhat.com>, <seanjc@google.com>,
        <petr.pavlu@suse.com>, <atishp@rivosinc.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <guoren@kernel.org>, <jianghuaming.jhm@alibaba-inc.com>,
        <mick@ics.forth.gr>
Subject: Re: [PATCH] RISC-V: Remove IORESOURCE_BUSY flag for no-map reserved
 memory
Thread-Topic: [PATCH] RISC-V: Remove IORESOURCE_BUSY flag for no-map reserved
 memory
Thread-Index: AQHYZSm8+0TwSlE59UKl1CUeebE3tq0ZitGA
Date:   Wed, 11 May 2022 11:32:23 +0000
Message-ID: <c6c9c8d2-cc6b-cd5b-a066-44bd970f9292@microchip.com>
References: <20220511112413.559734-1-xianting.tian@linux.alibaba.com>
In-Reply-To: <20220511112413.559734-1-xianting.tian@linux.alibaba.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85363d83-d753-42b6-851d-08da3341eac2
x-ms-traffictypediagnostic: SN6PR11MB3519:EE_
x-microsoft-antispam-prvs: <SN6PR11MB3519C337DBA0C3CF1DEBF27A98C89@SN6PR11MB3519.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7QITX0YsrZYVwcZocLxxTq7LMRfuPZ1LnbwlZeBU9RI0iU2ZYwNT7gXHPW3nrfn7JIraiGxb6f+JK2avDVnMS18TQmv9sp1CYO4o7hUuP+7poWmtxz9MkLOTVxj8p5cfiCXvNsSWJIiqejzNyy5gfjnNUDFb599/Ld49xGP85Kq4e/yoWx60cqC8KaciL7bZwRevT+jabHHVPXdMuiOPWXs8s4uwDiPK4z0qEMouxfRD1/CjWVisQrlnLZsvyrQeMN0CgCFG4BWsOSenFkXZAvyGWIcR3uYQbypcWEezvINXwzmNZMi34HBS9ZAB2EgbXQi5pIOqBycZNaI2EyllE23OFEPvT9LqmJPoX3iCDcLo2xHjsqXyWlnNdk6YGCvxJ1lb67Kt/J79BaNcjyH1XvXMABlZMRv1SiUlsarQijqq4uLgi/POYplCV2MTOcELNteQdU3caIizUvcshzzhtdQHuK2JcJfXqe3/xfkMN4irpmGA6XlY0FlK9i80B9h2T+iuyt5JbZFGDRwPwRYksliAQbIXsv/PCUjCIanWnTtq7YJxwIAQdHj+cm81G751PHpA72pRJ+hjcr7VXKLImKyvYvNlcv8rXq/OQcyJ5tyEDhYPuRZvGpqL4zrxGIab7T6+/uN8vprJl0MbHGV0bsRtfftRZMo6K9p0/Y6R4PY6AvaP+ZFfmjJhSLHogwHEYa/urwFtoqczjSyi/zBMX21u3Tty0LQR2ZOraYecEwGapaSa1CQqwCorWQv6w3uGokwD1+t3YsY7eKISvsMnlLjv0nDC/zbYK7/ouA16Ybs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5160.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(38100700002)(31686004)(76116006)(36756003)(4326008)(316002)(66946007)(66476007)(64756008)(66556008)(66446008)(2906002)(8676002)(921005)(71200400001)(110136005)(54906003)(91956017)(122000001)(86362001)(5660300002)(186003)(53546011)(6506007)(31696002)(6486002)(508600001)(8936002)(7416002)(2616005)(6512007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWI1d1U5RGtmV3lObEQ5RkQycjFzMlByVGJ2YXhiTHJ2NVFsMHZXYUQ2OTBl?=
 =?utf-8?B?MGJWL00rMGpnKzlsVHdaTXh4dHVCOHQwMjIyc2NoNUIzVWVBemtlRkNndVlz?=
 =?utf-8?B?Y3pxNWU3QndxN1k1YUtKVzFMZVZWMnYzb0lJYVpub0JzNUFRd3k3cG1FK25o?=
 =?utf-8?B?V0ZLUnAyQ0ZJWVNsVW54ZjhWYjZ5YXVuWFIzQTI5dU1Ca0JTbSszeTBiZzRw?=
 =?utf-8?B?dERWU0wrVnJBVzJVRXl0dHNVTStuR0lScHNLdEVIWWRLdXdYeG41NTRoa2ZV?=
 =?utf-8?B?WVdVeFExeE5ydHJpUXhWTDE3aXllVGhXR1RwNHV2dVJIOHFzdnJRQUdybnRh?=
 =?utf-8?B?RnFteEdpa3J2d2pKTUlhR2hiTVc2QlQyUVhSTTNaeWtyazdVMjBCRjB3S2RT?=
 =?utf-8?B?eUh6SUMrS3AzS3hTbkN4R2taRVJudlJ4QThxVy9sTU1scFZLNDY5NWg4T0cr?=
 =?utf-8?B?ZlV4ZS9LK3l3RnhqTXgveUtmeGx3dXZmVFVLM1NMdlM1UHVzbm5VZGdUdElv?=
 =?utf-8?B?OUc4U29iVG1ONU1leEl5UTRWNXhrRUJoNUhuNndLVFMvcXdLZkhXTmJDUVps?=
 =?utf-8?B?cDkwNzVaWVl2RkNrWXlEOEd0TlVDSGFSMCtQV252M0dQdnZYM1RqR0dKMGtl?=
 =?utf-8?B?V3lUYWJLdklqY25JOXZUVDNEM2dNd3p5Y1l6K0gwMEVUbTlaY2c0ZEJkOVpP?=
 =?utf-8?B?ZFlvaGJhSTFlZ2YxK05LZm5KdzFKV1NHaWRETGx1c04wZDNnMVZtTVFSRUVO?=
 =?utf-8?B?b0hwOFJpbVQvYkdha0FLdkJ1RWFRN0FoWU5vczIzd0wvbEwzanhERWoyVWJW?=
 =?utf-8?B?WVQxclloaGo1cmpLNE1HR2dkRm5ERWFRTkxCbW9QUlZXTGV0WEt4b2VWR0x2?=
 =?utf-8?B?cUFzNVpQTExTY1Q1QzZ1dkFJYkcyU3lzTTRLQU5TL1dNbUE1eXFKRmg4eGVs?=
 =?utf-8?B?c1pZZmRqb2ljeVhMVVVtZ0RITmdQeHdqdVR2MWRkL1RSb1hrZFYxbkZTR3U3?=
 =?utf-8?B?R2JpU2dEWCsvM0o4R2JtdE0xcHlTNWdvQmNaU05LeFZhRU9rV1Q5TFdkVlZt?=
 =?utf-8?B?SDRpeStWb2N4UlkvSDZDRHMzV2dVMDMzblIrVVN1WVZ4L2d1YWtpS2JES3VC?=
 =?utf-8?B?S1BCYjBuZXVwMDZXbGgzNlREU0NBbzI4em9RblhGeHRzWU9mOWFaQVdhY1lu?=
 =?utf-8?B?UWQrcTFFbkk5SU1VYkl4ODhnSWh5T2l0UjhCakFhMWE4Qi8xSm43V21XWC8r?=
 =?utf-8?B?N0xzTnlsd1VzSktOL2NsVUVodHlXQmhTOW1JVFFkVzZsVExBd3NCSTFoc3Zu?=
 =?utf-8?B?RnNRTTBFWG9Qak9JcmlPVWtMV2liNi9CbVNUb3JRTksraGhPakVtYkR1dDZC?=
 =?utf-8?B?SnBQQTR4ODV6T3JBazNhWExmUHp1M01RM3dIVG85VkVtSkkyb1N2M3VueFVQ?=
 =?utf-8?B?U3I2S1V4QmJFWUsxV3RoWmNOd25ySDBJeHYxbUVEMU43eXE2S3VSdHU3ZGNa?=
 =?utf-8?B?d21WbStNRCtwUHU2d3Q2V1J4bFBZcnQ0bkNkekJLSUY3ckREM2RvUVRsTWFO?=
 =?utf-8?B?ZEUxNUcxMU9ScnUwMGpQOEltbGkrTE4rdUdBMzJPb1pTbDczZG9McUhwOVdZ?=
 =?utf-8?B?aHQrMzQ3U2lFVFpsaUd4MlM2aTZJc3BRbTJLejRzUDNTNHNuYjhWaUpYL09p?=
 =?utf-8?B?MzR0ektqODh4ZzB4cVp6L3ZzK1F5Smh2am9COVFuREhVaklEaXNaYkFCUnZN?=
 =?utf-8?B?MCtYanhNR1JpQVY1Y1FUQXVrUmNVeWc4WjdreW5UUVZoUkxjWGtPWUF2MzY0?=
 =?utf-8?B?OVkxN3R1MVRSOUw2TndXK2RTcWNJelJYS2NsNUJpc0JHSHhyMmQzMFdIU0FR?=
 =?utf-8?B?SUFNTmozMUhJSFhyZG1WVXVmSEJiQXZ2QkVRdEU0SDZIVFJRSTRpNVAwaFQ4?=
 =?utf-8?B?T3VZZDJJbzFIQ1crcmREREM5R3B2dzg5Z2c5ckVkalpXVWRCeU1ZMXU0bmxq?=
 =?utf-8?B?SXVTeHpRWXN2VHBZT25vTmh2NmFqUVZ6OHZlbERCWkg2MCtHK25FTGdzSHNo?=
 =?utf-8?B?TU1kQTJ6NkFSUTdsN3Fld3RQR29PdThWSzd0Q3JwSnRrNFcwZnlUa3hycmZo?=
 =?utf-8?B?Umx5YjFrRys1MXAzZ3YrME9UODQ1VDJsNDJrU1pia0NZY0plUXhOWUZNV0FI?=
 =?utf-8?B?VEREWTY2ek1SYXJZNUZjelEzb3FpcktETWErRFNCbU00RlFiU25FSjBmNlZy?=
 =?utf-8?B?NndRNVdnbi9FVUZ2cHVDQXpKRE9MWlFVcUJZR1RIdlZMSDVMeHpVZXp6d2t2?=
 =?utf-8?B?TW9Gb2pKRmNPVWplUlV2eTBISHBnTlVPWnRtRnhpYXlWbHlmQ0JiZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C59E3C7818CA94F94738865FAA2D230@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5160.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85363d83-d753-42b6-851d-08da3341eac2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 11:32:23.0228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8OAaNNf5ifp/H17fzJTslwduYEODDrfDNgf9sy0EJzdHpJioKjBl4nO1n9N7Rqbmzo0Hi8QD4xasE74xZDUShCa0ZJ1gjLyTvoFDRI2Mq6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3519
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMDUvMjAyMiAxMjoyNCwgWGlhbnRpbmcgVGlhbiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBDb21taXQgMDBhYjAyN2EzYjgyICgiUklTQy1W
OiBBZGQga2VybmVsIGltYWdlIHNlY3Rpb25zIHRvIHRoZSByZXNvdXJjZSB0cmVlIikNCj4gYWRk
ZWQgSU9SRVNPVVJDRV9CVVNZIGZsYWcgZm9yIG5vLW1hcCByZXNlcnZlZCBtZW1vcnksIHRoaXMg
Y2FzdWVkDQo+IGRldm1faW9yZW1hcF9yZXNvdXJjZSgpIGZhaWxlZCBmb3IgdGhlIG5vLW1hcCBy
ZXNlcnZlZCBtZW1vcnkgaW4gc3Vic2VxdWVudA0KPiBvcGVyYXRpb25zIG9mIHJlbGF0ZWQgZHJp
dmVyLCBzbyByZW1vdmUgdGhlIElPUkVTT1VSQ0VfQlVTWSBmbGFnLg0KPiANCj4gVGhlIGNvZGUg
dG8gcmVwcm9kdWNlIHRoZSBpc3N1ZSwNCj4gZHRzOg0KPiAgICAgICAgICBtZW0wOiBtZW1vcnlA
YTAwMDAwMDAgew0KPiAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDAgMHhhMDAwMDAwMCAwIDB4
MTAwMDAwMD47DQo+ICAgICAgICAgICAgICAgICAgbm8tbWFwOw0KPiAgICAgICAgICB9Ow0KPiAN
Cj4gICAgICAgICAgJnRlc3Qgew0KPiAgICAgICAgICAgICAgICAgIHN0YXR1cyA9ICJva2F5IjsN
Cj4gICAgICAgICAgICAgICAgICBtZW1vcnktcmVnaW9uID0gPCZtZW0wPjsNCj4gICAgICAgICAg
fTsNCj4gDQo+IGNvZGU6DQo+ICAgICAgICAgIG5wID0gb2ZfcGFyc2VfcGhhbmRsZShwZGV2LT5k
ZXYub2Zfbm9kZSwgIm1lbW9yeS1yZWdpb24iLCAwKTsNCj4gICAgICAgICAgcmV0ID0gb2ZfYWRk
cmVzc190b19yZXNvdXJjZShucCwgMCwgJnIpOw0KPiAgICAgICAgICBiYXNlID0gZGV2bV9pb3Jl
bWFwX3Jlc291cmNlKCZwZGV2LT5kZXYsICZyKTsNCj4gICAgICAgICAgLy8gYmFzZSA9IC1FQlVT
WQ0KPiANCj4gRml4ZXM6IDAwYWIwMjdhM2I4MiAoIlJJU0MtVjogQWRkIGtlcm5lbCBpbWFnZSBz
ZWN0aW9ucyB0byB0aGUgcmVzb3VyY2UgdHJlZSIpDQo+IFJlcG9ydGVkLWJ5OiBIdWFtaW5nIEpp
YW5nIDxqaWFuZ2h1YW1pbmcuamhtQGFsaWJhYmEtaW5jLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEd1
byBSZW4gPGd1b3JlbkBrZXJuZWwub3JnPg0KPiBDQzogTmljayBLb3NzaWZpZGlzIDxtaWNrQGlj
cy5mb3J0aC5ncj4NCj4gU2lnbmVkLW9mZi1ieTogWGlhbnRpbmcgVGlhbiA8eGlhbnRpbmcudGlh
bkBsaW51eC5hbGliYWJhLmNvbT4NCg0KSGV5IFhpYW50aW5nLA0KVGhpcyByZXNlbmQgaXMgbm8g
ZGlmZmVyZW50IHRvIHRoZSBwYXRjaCB5b3Ugc2VudCA1IG1pbnMgYWdvLCByaWdodD8NClRoYW5r
cywNCkNvbm9yLg0KDQoNCg==
