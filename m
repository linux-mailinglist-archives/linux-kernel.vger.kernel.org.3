Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3236597EA4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 08:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243672AbiHRG30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 02:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiHRG3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 02:29:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E73E2E6B0;
        Wed, 17 Aug 2022 23:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660804162; x=1692340162;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nD+5wimM8oYMr6sj1W9jheter6gfpjq3Qocd7/vYbPA=;
  b=NeX0Ee3Ge7WuwdshziWv2jI2jJ45gQD8IvOEXVg3HQtzfXmAvnm7u9S4
   0TtY3B52WI7p20qh9X2tYfzEl00ow48XyM7vuhjI/6yU7HDnBh5RS3AzD
   3szM2cuyL1bW2YlEvCJ+mx9lVPvJhcsYHwo/pDvrLX/LGlWiA/DJS6zGS
   FHUmlJKlN3SCLWUQXbcgwk3iUVGPiJrsNJyIdXG4l9x4ILbTEWDKj9D/s
   Ff84AlD4OqxLT6LTRkjyilLx2UtgSAjxKJsIjxobT//bblwmAZfsXwgPw
   h82FWn1YvSGOB+1N1vbLPqFErAn4YNor3RaO10EDltLETTSf1zWdP53js
   A==;
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="169808228"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Aug 2022 23:29:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 17 Aug 2022 23:29:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 17 Aug 2022 23:29:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQndTrk2NvQYl8zFD9woipD9uMEd5PEV+wT/ZWb7YtZa45eIJkwx7OMWVyyiNJKxpRfXm9wIzTiKy6MjlpX5ue557TL4xIW5uMlLRJOYkikUUS/WE4HUxVagNnyL6AOkrSufvoEtbZR3htVV6vjYbPG34PLui7ma84fXg/mninAUMfUnBX0OPMRJ0vP9bprWrqV1ALNYpLYPkKIMkPFVVI1OHD16d8aRZ+q2dv66KZGlUqQcf5MG6EjKO8uoh0GjXc1cPWiRLDvYK1oE2t3byuva0fGC24SLMGrp+DN/o2F12RvA8ygstHY3AUI7b49kTdjt3o+9CJ23MieHZvktmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nD+5wimM8oYMr6sj1W9jheter6gfpjq3Qocd7/vYbPA=;
 b=VrCQf0WqZ2o1Bt+KOoSNiKXhArHX0qvnuA+9WZ0cakWBjVLjJdNkY0ayhgh08cCvfQ45cKUayHbBowCyOzAVjXaOkePvPP4oArr3XRwqaVoe0/ERBNeV25DexfXPI4L5lKWIerSBWn+HgneBdoDzpLW2dXsOdI9T2DYY7vvMiFoGszY8GpDdLvqkLEaYM/VYbK2aC8qAj8DCfmiDGDzmFWZ/bReEGV3m/ln7RTr+5oTFVL1KwlH6wXU8RYRiLxKuFpG6f6X0kw2nEm0wbld4ggU3Eb/OrsbbqyW8dBzlPnAGYrM2NdvLcR3BVh0tTy+eu2tmnMTqjtb75R2mDXgnsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nD+5wimM8oYMr6sj1W9jheter6gfpjq3Qocd7/vYbPA=;
 b=MoW8O5v/xGLHnx0Nf8SjrNsxMpwkk4yp0u+dxzEtFNRrNqkzEfjSKVt6Vczjdq9v4CJLAuUuakv09lRy/LnuNkiJiCe/k/ydZ/lp8JLl5bTso5z7Z5rJKybH5ri81t6Bmz7RnCrCsn8zvzsfmnTPqxDuF4Y9Z/ZslPX/6pShEaQ=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN6PR11MB1764.namprd11.prod.outlook.com (2603:10b6:404:101::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 18 Aug
 2022 06:29:10 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Thu, 18 Aug 2022
 06:29:10 +0000
From:   <Conor.Dooley@microchip.com>
To:     <palmer@dabbelt.com>, <qemu-riscv@nongnu.org>,
        <alistair.francis@wdc.com>, <bin.meng@windriver.com>
CC:     <robh+dt@kernel.org>, <mail@conchuod.ie>,
        <daniel.lezcano@linaro.org>, <maz@kernel.org>,
        <tglx@linutronix.de>, <anup@brainfault.org>,
        <aou@eecs.berkeley.edu>, <guoren@kernel.org>,
        <sagar.kadam@sifive.com>, <jrtc27@jrtc27.com>,
        <ajones@ventanamicro.com>, <paul.walmsley@sifive.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 1/4] hw/riscv: virt: fix uart node name
Thread-Topic: [PATCH v2 1/4] hw/riscv: virt: fix uart node name
Thread-Index: AQHYsnTlXqZocSjAkkiyi1piLobxpa20MqiA
Date:   Thu, 18 Aug 2022 06:29:10 +0000
Message-ID: <3026d87d-08a0-18d6-4b03-f0a05536d682@microchip.com>
References: <20220817200531.988850-1-mail@conchuod.ie>
 <20220817200531.988850-8-mail@conchuod.ie>
In-Reply-To: <20220817200531.988850-8-mail@conchuod.ie>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7c9268c-4121-411b-7aff-08da80e2f5d2
x-ms-traffictypediagnostic: BN6PR11MB1764:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OHAmnRDw/GcL7sMVu7sXNsuWO6IDtgo3mDORMvIW7yzwEROQqrfsWGHTOc5TttPI5Vv7xscyOXSSxm6O4MfpBgChC3mub5+pjLvDsi2TMS3RIMsEQIlwGMVMQDRlcMITFqW/0J1q9yS13MgVWibFHAMTO5X3IwwQu8BoxQj1G1tRigmvXNAy/zJ+9rXSTXeVbU5i/f3CCkY/41ZF9xqcRpL+J7jp9r8gWuQVEfVaU9gIjUrzP7cpqEpCKbLq49mOcflYYuEyMiIv0BLddSZn91KAaXwltZOJYtPlZhl2yt8aGq4gKyqY8+nizdqdKKXWv4Ygdo+zBr1UMtF4GL1LaVUbgxKpF/khaO9Qlgv2Gchk/plDsa0Hj8uZOKJy77r1Hv9znd90NgFWkRDDLYBg5lHQ+ojr2OtoSQ3E8QYBsfQFdBza2csA5GiFbcYNOYszvXjLZPfOGrrBIxrfCy1NYMhHI2dwNhFBKKSc0XxkcIHxwC2feCUgr0lLYG+Tc+qcJe36uSRJGkAHn2zy6LfFwctlbQvfGFT4QO7L3Psk50pTy0FwTWkhhUbmS+xqa2cy3zKBOjnO9Zj3CHrKXPv1OO2m1kCNBI17tjUs6pjFHKaWls4EWWndEASfCzEt9a42tjy58iZOVBPBAweWjZdHjHhcuwApBzzKyK+4KCb66YbyQpF4ug+AK8gNkumfunFmV84J22pXD9K4//dYUHBRPJlk2Oy154b5mZ6Lqmg1LqI1IvU1niZ64HBOhtrq9HDbpdUkB/XHCwvF6N4ACL4vYCPDNjW7M/EPiUzaC8akfMozz2vlV6QyZhOGeNV0CmdesgZ0YKUKHlULrH0ZbKc3XHNE94Hy62QA10jNzaYjGog=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(346002)(376002)(39860400002)(366004)(316002)(31696002)(66556008)(53546011)(41300700001)(64756008)(83380400001)(76116006)(2906002)(66946007)(4326008)(8676002)(36756003)(66446008)(54906003)(110136005)(31686004)(186003)(2616005)(38100700002)(122000001)(26005)(966005)(6512007)(8936002)(66476007)(38070700005)(478600001)(71200400001)(86362001)(6486002)(7416002)(5660300002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUY2Rk83YXUzak5rNy82YXUzdHlXRlVNOUNkT2QzbDdqWFFlMHpqWlpkNzdz?=
 =?utf-8?B?S1AzT2dyZ1BFcWNrZ1lEVnJTTk0vdU1QZmt1N1c1N29OMjltV1FEdmpYcEZo?=
 =?utf-8?B?WDRPVG9RSkZvQVFQSXFZeE45Uy8vdUdKc1Q5eVMwNGhzT3ZiQS96MWZQTXNZ?=
 =?utf-8?B?VnFMcUhESjZTSXRWR2hLTzRZdlA4ZDFIbytleXhpTXNrZVFxRWdNSmN0dC9u?=
 =?utf-8?B?ZWdxd2JlY2NwKzVnZ3NSYkhxUUt2c3paVmVZNXl4Sk1ON2gxM2ZVS29JWkMz?=
 =?utf-8?B?R1FNSkdid2VOVkZJcXFQbmV3V1k2WXZzSnRaUE9CejRvMTYwLzc5SkZDUkIv?=
 =?utf-8?B?L2IyM2FjU0hxWUdzNlZEM0toQ3FsNEVBaFZMaFY3SkpVZXRpWGppZkRUS1ZY?=
 =?utf-8?B?cFN3ajBuNG9KZDNyNHdwb0QybjRtSUFZejBkcC80NVlkQ0VwSHNUNGRsYUd6?=
 =?utf-8?B?Z2M0aitYcU5lNE5qZG41TS9hWXcrZVovWVFZNkJJS2hpQnV2N1BSV0Q2Y0Vu?=
 =?utf-8?B?RWl2ZHphN1BKVWdIblpiSFhhZ2lKQjg2azIwR29wK1hkMGNTdk0yTlp4aTRt?=
 =?utf-8?B?d1hESkdRbjFqd09iSWkvQmJMZE5ZYWVQbzlhMmRBYjNTOUUwc3ZtMXJmc1gw?=
 =?utf-8?B?ZDBwa0JsYVFsU205UjNTY2tabm9KOERwa0hvL2hwOE9UNThGMnRqYk9ic09h?=
 =?utf-8?B?VmJQc0xxZ3NXRVplaDJuRUFsRDdYQWptUldYSVRob01ZOWEzNGROS2NucHFF?=
 =?utf-8?B?MTJWSVdHOFU0d29IYzV3eFFyaFd5VEJUNW1uMTR5R1Bxc0k3S21ZSWdYOXhY?=
 =?utf-8?B?ZCt1cnA1TzBlUFZheXpFOXdpVkVTS09QS0hqQ1BTQ1l5UVRCUElEUVJ5d0pY?=
 =?utf-8?B?N0E4VUlOY0RCQVZYY2hxUXRUQmwzYWFIN0xTN2ZuMExmQ01nTzJkZWZmZUJh?=
 =?utf-8?B?R3pTMXRlR3dHelN2azRJL2twYUhIQ1hGVXdPdkRlVjkweGpoVXNxZ0JEb21x?=
 =?utf-8?B?TnRub0hkZ1ZkUmZWbC90WmZuWWg0d0JLWEE2UzFHa0NIeG16YnB6TG9IakpP?=
 =?utf-8?B?Ykc4Z24raDZIYys1RHp5YVNrQ2dJcjc2WUZuSTdLQW5lekFnQkQ1OWw0VnhP?=
 =?utf-8?B?aiswalhCWnNNNFkrWVZ0eEhNalBPdGxCWGhjNWRmMFUvbDEvejlrS3FIdHox?=
 =?utf-8?B?aklmZkh3dVFSaTNGbW10RGN6amllcHF3b0VOVnlKdjF6cmhxU2o4VzVrNFV6?=
 =?utf-8?B?WHhDY2pESU9PRThWMUV6NFZDVHRQenBlNlo5WVhBK1U2Z3JSbkUrNVZ6dXMz?=
 =?utf-8?B?c3FNYXUxVzV4TWZpQ2x5d1BCdkY5M2lLQjRWdzd1MnBJdVQyaHB1b1Q4UGcw?=
 =?utf-8?B?TFFQaFQ0RnRNRjJPT1BtUEdiNG1XUTBHdEkramN5ZWo5Q3NTUGFTREUyY1gz?=
 =?utf-8?B?TGpYS1kwcjU0WkpMNml3Smx3U1lEQ3FialJvZjNVajJlZEJoRElTSVRXYmZJ?=
 =?utf-8?B?NGtCcEN5STJod3MwUlYvMGVYeDh3RGZadlluczg1d25oSmE1OVovUy9EaVpE?=
 =?utf-8?B?b1BXWlFEMU1hVjdwUWVTK01rNFNGM09xNVVIRFdQbHZVdldLZit0WVZlK2tP?=
 =?utf-8?B?Ykk1SVQxSTY0aDR2dXFDakNuVVlXUXVMVVdqUUxsVUdxVklEemxyUU1wOGhS?=
 =?utf-8?B?S1lhRGJUVEs5WXk4bG0wdmErVlM4MjMvVm0yTTFnR1lzVFN4NlhDbzVWbEpJ?=
 =?utf-8?B?V1dzYWM2R0R2S2RPMFo3bVNHbThwVC9zcGRqZjhaS1hSOVlUWFBhakxhL0pl?=
 =?utf-8?B?S1lyNHl4RFZtK0xnN2dqL0s4VTRkTGtVa0padS9RYlJubWtYenY3MmVjRGwr?=
 =?utf-8?B?Ri96YzdPUVlqREFuUiszTjBPV2Rxazh2T1VqNEpHTVFKek4wZ3B6MUg0Tmg3?=
 =?utf-8?B?WnRld04vbkNqNEpGT21aYmFvVGFBUkhNQmt6eDB0SHZTSEJlMFIwS0pHdkM4?=
 =?utf-8?B?Z0xQOGZqNFUyOFFjM1ZmR0ppcjh1RGJtTjNLN1N1NzBxRlhoemlncFFTVzMv?=
 =?utf-8?B?SDZXdXNuNStrWlhGSzJrL285dWlQTy9VZzhiZVZEYXNONkZYWWE4elM4WDhk?=
 =?utf-8?Q?kJdbm8vmu3ir+ArYicX9beGR0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <737D69459D03AA41844F18FB67977D48@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c9268c-4121-411b-7aff-08da80e2f5d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 06:29:10.1210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PiRVxLM82/tc3RZ0rPjmz4oa/6tKTVZzI9uzr+G10triMT8qA1ctuiMeQf2+VaSGtNEq5Zm4uPYlFsRG2gfUTrA9yWHAGMC9wV/5IZC04eo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1764
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTcvMDgvMjAyMiAyMTowNSwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KDQpJIGRpZG4ndCByZWFs
aXNlIHRoaXMgb25lIHNsaXBwZWQgb3V0IHRvbyB3aGVuIEkgbWVzc2VkIHVwIG1haWxpbmcNCnVu
cmVsYXRlZCBwYXRjaGVzIHllc3RlcmRheSwgdGhpcyBpcyBpZGVudGljYWwgdG8gd2hhdCBJIHBy
ZXZpb3VzbHkNCnN1Ym1pdHRlZCBhcyBhIHYyIC0gSSByYW4gc2VuZC1lbWFpbCBvbiBhIGRpcnR5
IGRpcmVjdG9yeS4uLg0KDQpJIGNhbiByZS1zdWJtaXQgdGhpcyBhcyB2MyBpZiBpdCBtYWtlcyB0
aGluZ3MgZWFzaWVyPw0KDQpUaGFua3MsDQpDb25vci4NCg0KPiBFWFRFUk5BTCBFTUFJTDogRG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBj
b250ZW50IGlzIHNhZmUNCj4gDQo+IEZyb206IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1p
Y3JvY2hpcC5jb20+DQo+IA0KPiAidWFydCIgaXMgbm90IGEgbm9kZSBuYW1lIHRoYXQgY29tcGxp
ZXMgd2l0aCB0aGUgZHQtc2NoZW1hLg0KPiBDaGFuZ2UgdGhlIG5vZGUgbmFtZSB0byAic2VyaWFs
IiB0byBpeCB3YXJuaW5ncyBzZWVuIGR1cmluZw0KPiBkdC12YWxpZGF0ZSBvbiBhIGR0YmR1bXAg
b2YgdGhlIHZpcnQgbWFjaGluZSBzdWNoIGFzOg0KPiAvc3R1ZmYvcWVtdS9xZW11LmR0YjogdWFy
dEAxMDAwMDAwMDogJG5vZGVuYW1lOjA6ICd1YXJ0QDEwMDAwMDAwJyBkb2VzIG5vdCBtYXRjaCAn
XnNlcmlhbChALiopPyQnDQo+ICAgICAgICAgIEZyb20gc2NoZW1hOiAvc3R1ZmYvbGludXgvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC84MjUwLnlhbWwNCj4gDQo+IFJl
cG9ydGVkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiBMaW5rOiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC1yaXNjdi8yMDIyMDgwMzE3MDU1Mi5HQTIyNTAyNjYtcm9i
aEBrZXJuZWwub3JnLw0KPiBGaXhlczogMDQzMzFkMGI1NiAoIlJJU0MtViBWaXJ0SU8gTWFjaGlu
ZSIpDQo+IFJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdk
Yy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3Jv
Y2hpcC5jb20+DQo+IC0tLQ0KPiAgIGh3L3Jpc2N2L3ZpcnQuYyB8IDIgKy0NCj4gICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9ody9yaXNjdi92aXJ0LmMgYi9ody9yaXNjdi92aXJ0LmMNCj4gaW5kZXggYmM0MjRkZDJmNS4u
NmM2MWE0MDZjNCAxMDA2NDQNCj4gLS0tIGEvaHcvcmlzY3YvdmlydC5jDQo+ICsrKyBiL2h3L3Jp
c2N2L3ZpcnQuYw0KPiBAQCAtOTE3LDcgKzkxNyw3IEBAIHN0YXRpYyB2b2lkIGNyZWF0ZV9mZHRf
dWFydChSSVNDVlZpcnRTdGF0ZSAqcywgY29uc3QgTWVtTWFwRW50cnkgKm1lbW1hcCwNCj4gICAg
ICAgY2hhciAqbmFtZTsNCj4gICAgICAgTWFjaGluZVN0YXRlICptYyA9IE1BQ0hJTkUocyk7DQo+
IA0KPiAtICAgIG5hbWUgPSBnX3N0cmR1cF9wcmludGYoIi9zb2MvdWFydEAlbHgiLCAobG9uZylt
ZW1tYXBbVklSVF9VQVJUMF0uYmFzZSk7DQo+ICsgICAgbmFtZSA9IGdfc3RyZHVwX3ByaW50Zigi
L3NvYy9zZXJpYWxAJWx4IiwgKGxvbmcpbWVtbWFwW1ZJUlRfVUFSVDBdLmJhc2UpOw0KPiAgICAg
ICBxZW11X2ZkdF9hZGRfc3Vibm9kZShtYy0+ZmR0LCBuYW1lKTsNCj4gICAgICAgcWVtdV9mZHRf
c2V0cHJvcF9zdHJpbmcobWMtPmZkdCwgbmFtZSwgImNvbXBhdGlibGUiLCAibnMxNjU1MGEiKTsN
Cj4gICAgICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxscyhtYy0+ZmR0LCBuYW1lLCAicmVnIiwNCj4g
LS0NCj4gMi4zNy4xDQo+IA0KDQo=
