Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6484CD324
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 12:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239110AbiCDLOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 06:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237983AbiCDLO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 06:14:28 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA441AF8E7;
        Fri,  4 Mar 2022 03:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646392421; x=1677928421;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/+fyBmvblkWAEunmKYStLlrPZcQh9y3kuh+GrgpmdAw=;
  b=xCwcniSiVxt2Tq2Cr3F3wJhvFHAz+PoZTQPTOKmGIWyIZpXeWcZ+HtRJ
   V/NLkQV6HiJSSIqIoFimz1EbwungN9TKsl29roZHM+xelO/BBUE2uJN75
   BJA4e7ZJUr1Gaomr3UyJDyIo3opLPPeyjPc0bIwIkE/Pmfzkr5QBqHx7N
   +Qb/xqMXldT3XfKFctRQ03ucLpx/USjoGBhsDsg47nF13JDu5c0Gw61Gr
   ggCRoWSYkD/p+5w2vAOm3VVzYDNz8++ZzoEEYMTknf2BHyd5ziufntMgQ
   9Hzp7iQh1KwMtgva5WKHOcyvU2R+iEy70F8rVK6XSW0S9cwGza/AR+bcW
   A==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="87823770"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 04:13:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 04:13:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 4 Mar 2022 04:13:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CaRh06cG1fw178BzkLUHhdJX646nyJxjzeAdqQB/4fNCO6Ar74Pb7nLeYTFFEesX+4Z38tSeBEdMwNhXgAGIKbOUPApZbEp+8HweYrfjq9eQ1kRhnEQ0gvtHEawMpMHCjqaOq3AT31BTk7PLLYKFZOyIVd6RLeaFrxYmQK1gRklhMKOUrAN4FpTVcuB7ym+qzvvdLzCXwPBHucSyzB+cyaZmQU9XtKg2IPVP9HmiVrgbpQGHa7D6NuUMM6wHuzqq/05CFvBBmZwdqoEZHDSV1H9oAEY43slKfLRaFZ6jn7k4HpIi/5TASveqZyjD8Wnv//178Vyf8RxhyA9R/phwgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+fyBmvblkWAEunmKYStLlrPZcQh9y3kuh+GrgpmdAw=;
 b=nNqthbmG9nvmVVUPiA3ciR53HNC8BfWReD6Ac4lvusCUlk0M43/p/P8jZgTW3o8S/69F/yCShOi6KT2GSEHRZDFbI+hJX5ZmjFuDHfx+aFDIqXHKnn6lmJTO+sE7K/5uSYXpZ7hJVacCQYoVETB4aQARBfpMjQvEuvoQu9qTeKSns5A7BumVaKTBDKTpUiYcKQ1wDGBijJCwm9xwNNJKJF+MVTuFMagCW/zfFc/3N2MuyX58lfsTPYWRoOnFWhxBfGz8FGvGpl4Don4Nwi1vTLRyO9Jzo0NZN0b+hYmqCtLjwSCh0N1W3OK3F2jUyckCSqSqje1e0839FtB1BT4+yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+fyBmvblkWAEunmKYStLlrPZcQh9y3kuh+GrgpmdAw=;
 b=MLbtmv1JatbMtkhXD3Zni94XW6X6ZIZKJHgVHfIAXvFfH6pzEI7uC8whzODMOtHNkwEGFxMyU9zb/GGc6vJmWUNx3UsVYlLsnBFojAE1agg3xjJtlaTDkxTl90s4H2YztnwkoT+gGpSHKUeRPtqPViojpbB/IKdRiE41pjenxjA=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by CO1PR11MB5185.namprd11.prod.outlook.com (2603:10b6:303:95::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 11:13:35 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%6]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 11:13:35 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Sergiu.Moga@microchip.com>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@canonical.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>
CC:     <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] ARM: dts: at91: Use the generic "rtc" node name
 for the rtt IPs
Thread-Topic: [PATCH v2 3/5] ARM: dts: at91: Use the generic "rtc" node name
 for the rtt IPs
Thread-Index: AQHYL7jkMl54TSvq/UaROGqfrHF6eQ==
Date:   Fri, 4 Mar 2022 11:13:35 +0000
Message-ID: <301e9ccc-a356-aa4c-a1c6-896beafe9472@microchip.com>
References: <20220303140626.38129-1-sergiu.moga@microchip.com>
 <20220303140626.38129-4-sergiu.moga@microchip.com>
In-Reply-To: <20220303140626.38129-4-sergiu.moga@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29f8215d-a00b-4a5e-14fc-08d9fdd006c2
x-ms-traffictypediagnostic: CO1PR11MB5185:EE_
x-microsoft-antispam-prvs: <CO1PR11MB5185FCAD3CF81232B75C4B58F0059@CO1PR11MB5185.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TioHW9J5W1QuYvw+OPCQKNkkb2uVuUcohyWLZl66YsRMOeH8ytk7lzY2kF1YbOBsxh+fX6WO8YFJO6qJfFnacPN8LtzSqwwBzS//2K3L1vriI16D0H4f4v/+FKqQ7CUOrn9IBDWD4Ss5UaIkX94whqaKOsuVsg5JpBKLUxxpiNF3BVQ+E7r582BcN1itGLMQdl4nXWF97EOpz0/r7F4JY4UStZsHY6L954g/B+pWoDlrh5E9MOQjvKD3g+hM17rrzmCW0Pz4e5NpDdJ7TlmGphqJ1SrqvugQ2mmCx59um5FKim3zWgpOvldVcRZjL+d5HSZEotJ/MIbY1IV0TwGfsDBBhCmgtn1JcDrcqVtXoXlUU5IXRO/q2/GcDWFQwtzJzjM1H7LXQgucjl+S10fft9zP/KtwUKJQAMeYDaHOnry4H1+GZYzXwHoL1NJtA6w5hyFHYiL55ZlB9/3sdO9MdYwtM9+fGspBq6wrgR2e6QGIrpAVdupeaxOpwCndoTSmfpYCj8aehaob+XAncXg0PcBausif1K6AD2/bsILwZjyeEPcTjTCjaBnOhPtGJheETdTyYwtNE2/vQN3P4b9NCQHeinV8QXrPxjyz+EvC0SMUkwtnlXemY9UYu4LO1m1t3uuA2dSlmjT/9JWIIBlYZWiaPY5F9Ylye9pjVMhMb+4uSO2s/q98JJpFlQSAJTIZu117vaOnKGGOAgq6M83OTFJNeqlie+1a6p/whNt550vQWUzYP2+y9gBGNoH+r1hQSobS60qD9EKp/eqbQethgRMpHBW3MrzKut3tQojCq0HQG8XP4seNntYyxVo5vRSwnxPhdWx8f2Kw25pW8qAxDRHH2W5GA6ArhG8atcNG1Rbm3wCKNtRmbH4csLJqNy3J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(2616005)(38100700002)(186003)(53546011)(6506007)(38070700005)(8936002)(26005)(31696002)(6512007)(86362001)(122000001)(5660300002)(83380400001)(966005)(4326008)(8676002)(31686004)(64756008)(6486002)(6636002)(66446008)(66946007)(76116006)(66476007)(91956017)(36756003)(66556008)(110136005)(71200400001)(316002)(54906003)(508600001)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDU4Ylk3NEd1NElyYStxWjZlK1B2b2x0b0FldFlBYURvZjhYMlYzNnIzRDAx?=
 =?utf-8?B?K09La29pYlNNaEZxdi95U3VndzlLTkZWUHN1QVJ5aHJaUkEzbUhyVnY0RWdt?=
 =?utf-8?B?a2Z1TFh3Z0VXdHQ0NnlXaTBNVEthemFNNGdWY0Z6Q2E2UGxWRVV5WlJoU2NC?=
 =?utf-8?B?REg5SnptYTNHaHgxOHg5ZjI1R2E0b1JFMTdZWmh6OUxLN0E3YnNFU3pXdXY2?=
 =?utf-8?B?Y0hMWU5ZdGdEZzdQMmo4OC9TZEVkblNWKzExWE9Kck9qdUE0a01BM0lFRVo0?=
 =?utf-8?B?bDN0cjVjYUxaRkdLMTEzTmdpRVRLVW96L3JyNzdNODRKY3FwZmFBYmw2RGxM?=
 =?utf-8?B?bTRZK1J6d0gyaEEvNk0wM0VxVHdVTXNnc2l2N1daTDl2L0ZZVExtOS9VWjEz?=
 =?utf-8?B?ckQ2clJmWWdKbjVUeU94RGNGZk9mWXExMHR1K1FQMlU4SUh4MXJPZkg2YTRw?=
 =?utf-8?B?WnpUb1R1TXZQdGw4WUV6VlBoajhkQ0k1TXJvMHVJRHVWS2pjMUR2N01Kenpv?=
 =?utf-8?B?d095R1diTFV5L1FLTlN5eEdNV2F4MEdBSCt3bHZicTlvcU9NcVYweHBWWS9O?=
 =?utf-8?B?eXpmQWNmdTlBNXM4RFJXeFBQbDRTWnJ6RWo4enNpbzFyNnhRdnhlM1RkZ29l?=
 =?utf-8?B?NU5HM2ZjajdwWEJrc3RtMmxnMG53YXVuMDlvZWNNbjRxbXBjUTBxZ21nMUJr?=
 =?utf-8?B?M3BkRHhQQUVjZGVuczRuQS9IRkNrT2dRS2FTQnh0YWxxbTlwNVptTkRBNm1R?=
 =?utf-8?B?R3UxcUNGSkx2Vk1VT0M2NHEraElkbWsvYy8vRDFhdHVOcWlxelFYcTVZanln?=
 =?utf-8?B?K1JwQ0xDUVVUY2o2bTNsSVAvRlJncmQ3cEZxNmNoMHJkT3pLdmk1VG9oZG44?=
 =?utf-8?B?dDN0YWpNby95K1ZsWHRzS3ByYXh4TEVteUkwZ3ppTFAxN2cxaWt3clVxR2M2?=
 =?utf-8?B?QjFQeFptK2tjL2xRUURpTnU5ZDdhd0RLVm1qNWFzK3dveVIvLzFBOCtxMDA2?=
 =?utf-8?B?ekk2dDE2MmUwaTkzK1JyNk95SkdmOUQ4b05FeC82TGkwZU9GYnNUNkNKMHU3?=
 =?utf-8?B?N0IyeUFKWk9zb05ZZ2NkeXdwT2hXcXJLYkJMUjh3SzBZTkoxZ1JBcktaMmhO?=
 =?utf-8?B?eVB3Q1czTGpOdDJOVFcwNGJ6WFJaQ3BnczkyYnBYTmxPZXp3Ti9DdlBJRmlB?=
 =?utf-8?B?NlRuenBJZGpkaERjTjl3eFpWSmhpcjlRcUxYVHpxdTVQVktvdzNrQW90QVBv?=
 =?utf-8?B?TlRKei92dkxwWXNTTm93VjlsQnY1dWhaTzM1OEMzTzdHUWk2RjhzNnlOaW1w?=
 =?utf-8?B?aU9PWVZnRm9BQmtxU29XZmdMUmlUekhwQ00wTGJvUlh2YTdGZ1pFQnFseWM5?=
 =?utf-8?B?djBkeE5XazFMUlVsZ2YvelJsbS9Kc2pLMmJRazQvejlqNmZpVFF3bTJIdVF5?=
 =?utf-8?B?M3pPUFVpQXRSSDg0MEpKbHZleXBkK0dYUVJzbGtNNzQ4VFZibVJ5WTZqNXkx?=
 =?utf-8?B?TXFOYkxVU3Jsa3pkdzZiYUlYbXdFL0E1TkVNbGVvMFI4UGExbWVDMlgxdWla?=
 =?utf-8?B?VGtZTmIyUVpyYnFsbFZXa3RRR1B4UE03YWtWdVo4UmFNZTlRK1YxNDNZVmUv?=
 =?utf-8?B?cTRIcVBFL2o0RE5Zb2dhWFBVU2YrSnJzc0FRTjlDV3c1YXNiSFFWeEhvdk5Q?=
 =?utf-8?B?QmhubEdDcXFZQWJYblpHZ0FyRitMY0JhTWUwd0dDNXgzcmZlbzBJSGtBS09h?=
 =?utf-8?B?ejFhV1l0RjZYMTdZQnJEQUtaZnBweFZnaURFTFkvY1hNdDZTMkZSNWRCa0la?=
 =?utf-8?B?TE0zWVRoaVg4a2tlSW80SWdVVkNHZnRERnZQK1JETWNBVUE3M0VFeHNlK1k5?=
 =?utf-8?B?SDFablROY3RkekNvZ3pKOTBqOTVIb0JSN2E3ekFsTFFBUEwvM1hET1ExQTVJ?=
 =?utf-8?B?bUZFa0FTc1JwSjBhSkMzbCsrNjFiN0dCcEZzNXg2OFJuckpkeWR4K01ZMEZm?=
 =?utf-8?B?TXZ2RXdvME5pZUczQ0dkQTg5c3krbFc4SzR5emR6ajMwdW1zT1VLWGxwaEF4?=
 =?utf-8?B?ejByTmtqdG5aVkpBeng2VzdKNHNjVytCS1RYR2M4MjNlSzExVGovVDZhR3Va?=
 =?utf-8?B?cWVFZzNtOG5sZU5kanFMc3JXSmRIakkzQmxHajcrcjhVKzYzTTZUczZ1RkZi?=
 =?utf-8?B?bDdHL1U1NlVHN2QvQUNQejNCcC8wZGFyUWlQbnJrVThvVWhYUDd3SjhhMTJx?=
 =?utf-8?B?c05iMGk4R3kybmpmRkJhcEJoT1BBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08F63DDF743E3D43A92131E51F39B51F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f8215d-a00b-4a5e-14fc-08d9fdd006c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 11:13:35.7730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tW9IiHL8T002WrRXt12nEsXjJnewGzDaYIu2irinpgxbR8KFbnWxXEUfyTwoJrWY2Q2BcofixaQhTnGY7Le0HdbXHeSjF/O4EpJLtUWqvDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5185
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8zLzIyIDE2OjA2LCBTZXJnaXUgTW9nYSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+IA0KPiBBcyB0aGUgRFQgc3BlY2lmaWNhdGlvbiByZWNvbW1lbmRz
LCB0aGUgbm9kZSBuYW1lcyBzaG91bGQgYmUgb2YgYQ0KPiBnZW5lcmljIG5hdHVyZS4gVGh1cywg
dGhlIG1vc3QgYXBwcm9wcmlhdGUgZ2VuZXJpYyBub2RlIG5hbWUgZm9yDQo+IHRoZSBhdDkxIHJ0
dCBJUHMgaXMgdGhlICJydGMiIG5vZGUgbmFtZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNlcmdp
dSBNb2dhIDxzZXJnaXUubW9nYUBtaWNyb2NoaXAuY29tPg0KDQpSZXZpZXdlZC1ieTogVHVkb3Ig
QW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0KPiAgYXJjaC9h
cm0vYm9vdC9kdHMvc2FtOXg2MC5kdHNpIHwgMiArLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvc2Ft
YTdnNS5kdHNpIHwgMiArLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvc2FtOXg2
MC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvc2FtOXg2MC5kdHNpDQo+IGluZGV4IDU3YmE0N2M1
NDA0My4uYWY3NjAyY2I2NWY3IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9zYW05
eDYwLmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvc2FtOXg2MC5kdHNpDQo+IEBAIC02
ODgsNyArNjg4LDcgQEAgc2h1dGRvd25fY29udHJvbGxlcjogc2hkd2NAZmZmZmZlMTAgew0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIH07DQo+IA0KPiAtICAgICAgICAgICAgICAgICAgICAgICBy
dHQ6IHJ0dEBmZmZmZmUyMCB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJ0dDogcnRjQGZm
ZmZmZTIwIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0g
Im1pY3JvY2hpcCxzYW05eDYwLXJ0dCIsICJhdG1lbCxhdDkxc2FtOTI2MC1ydHQiOw0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweGZmZmZmZTIwIDB4MjA+Ow0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8MSBJUlFfVFlQRV9M
RVZFTF9ISUdIIDc+Ow0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvc2FtYTdnNS5k
dHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvc2FtYTdnNS5kdHNpDQo+IGluZGV4IDE1MzBkODhjZTgw
Zi4uODdhZjZjNjgwMzIyIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9zYW1hN2c1
LmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvc2FtYTdnNS5kdHNpDQo+IEBAIC0xMzMs
NyArMTMzLDcgQEAgc2hkd2M6IHNoZHdjQGUwMDFkMDEwIHsNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4gICAgICAgICAgICAgICAgIH07DQo+IA0KPiAt
ICAgICAgICAgICAgICAgcnR0OiBydHRAZTAwMWQwMjAgew0KPiArICAgICAgICAgICAgICAgcnR0
OiBydGNAZTAwMWQwMjAgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0g
Im1pY3JvY2hpcCxzYW1hN2c1LXJ0dCIsICJtaWNyb2NoaXAsc2FtOXg2MC1ydHQiLCAiYXRtZWws
YXQ5MXNhbTkyNjAtcnR0IjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4ZTAw
MWQwMjAgMHgzMD47DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8R0lD
X1NQSSA4IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiAtLQ0KPiAyLjI1LjENCj4gDQo+IA0KPiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdA0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1hcm0ta2VybmVsDQoNCg==
