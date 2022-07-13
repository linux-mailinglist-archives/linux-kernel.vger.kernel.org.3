Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE7C57395A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236633AbiGMOzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiGMOzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:55:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221603D5BA;
        Wed, 13 Jul 2022 07:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657724148; x=1689260148;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XJPUAe8+cFXgr3P96YJo5pc4Uj+DVsdlHLimhbufaQs=;
  b=Ifa93oKMiyZjgy56ST6/pQuodj86as/GiBMEHCKRZaHvuuT23RzvIAdh
   lQEoalz0NkTOZVq6NHZ4/RPtxyt3+pyaCV9GPxhF8fKA/x9+0uctDm2FC
   avPnqqrlvQQ7+mTRugarSKrzA+i1Rnz0ADFKjonYlsAadsQm3z52fXmOX
   LCKZ3QMKCsiS3+3vBnF/Kt9HQAJupgnaAetA59V7hkDHu2vjGY/DXCXxP
   uWZouFYSjMdz4SAF9ATfiOpFLfreuqBKNvluRQDs7eW9dEnRLyaZb5rb2
   SDxuFlgX4mUXf5WixpeqCCM0NsmpEa+Aob0UCgQwj3iEyZ6YN1sDwN3mJ
   A==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="167661471"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2022 07:55:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Jul 2022 07:55:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 13 Jul 2022 07:55:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiGWAwf6zm4/XCe7/w14zJ6PIZFADDqO84JXegYVZhfKHhyWQ0I3B3mCn09nhNdemAVXTNJNMn/+4PhtLbqc0GHVuHQf8X4ukzlgKlK51WXLlhzrn7UZVEmwdetYiJe0xIxJpHaxfOS9UzgT85wcjeoV2+dj6tJzE0dX3hUw8gXkU6aCPcWvKCX2Zf2cuZVeEVvjaTJusU8eYPpS6WksZeIqnt3n3iI1q6nSbdUW0IQ3u585icbmQZOUG9XqNzg0B1MDvRHc8nY+gd7QY3JNubg7mATarfj1VT7ZTwVaqAlkyislvb7Tx+iiXjgyQcUsCedc3Cubn7ZluG0qiUatpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJPUAe8+cFXgr3P96YJo5pc4Uj+DVsdlHLimhbufaQs=;
 b=MU11SVRNK5aBTorqULG//9FCi977zuxeamgstH3aZXQ7bwXms+fTurbpumkMQYkVZRSuqGqYAH56U1MhsfaRDd2SF+ZE4FkV0JzMymxzicMndEvIuI29tmxTut9cY9wrC0GYSCpZJlYNKn7uJcJGs+iMiZydOpKdBHqH9xpOWkKlpTtoipg3AYbf7XmVkiWNlC/XFAUtRJVa2R7xuIwLJfbAVjpwWd3sx5YzmqYhBG9izLWMvOOQK/lhknm5kg3PXLs6XJ21eDHlNzCTHu4bGTb/+pPUida4XLKiZHh42JiAvvSqC5MBNnFhZ3ZAz4uyt4xvR2/nIXatlMYcoDfcWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJPUAe8+cFXgr3P96YJo5pc4Uj+DVsdlHLimhbufaQs=;
 b=YtAlhIfSdgddtPDVH51RJWS6ck6h7bOtFjqCupbb+DssfiPzXsD49/S0Yze5OhK3veUJI3pia4Tg69JOUfqGwhBjK6nQyD6SCUjVf8VlI0AfZXt2SS2bCBrQzsFYEJau7yNmRhuV+5EZ4BUEsWkc60aIgIafLgssJEOUM8wpsX0=
Received: from PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8)
 by MWHPR11MB1422.namprd11.prod.outlook.com (2603:10b6:300:25::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 14:55:35 +0000
Received: from PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::6090:db2c:283b:fe69]) by PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::6090:db2c:283b:fe69%8]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 14:55:35 +0000
From:   <Conor.Dooley@microchip.com>
To:     <uwu@icenowy.me>, <mail@conchuod.ie>, <kernel@esmil.dk>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <anup@brainfault.org>
CC:     <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] riscv: dts: starfive: add the missing monitor core
Thread-Topic: [PATCH v1 2/2] riscv: dts: starfive: add the missing monitor
 core
Thread-Index: AQHYlVY+6t1yOzd6XkeyUffI8zZgA618XkoAgAAIQIA=
Date:   Wed, 13 Jul 2022 14:55:35 +0000
Message-ID: <55e9da06-ccdb-f8e5-b5b9-8125b5fbb58a@microchip.com>
References: <20220711184325.1367393-1-mail@conchuod.ie>
 <20220711184325.1367393-3-mail@conchuod.ie>
 <e8543838cd221ab6699da16c985eed7514daa786.camel@icenowy.me>
In-Reply-To: <e8543838cd221ab6699da16c985eed7514daa786.camel@icenowy.me>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4758f501-29c5-46fe-2c3f-08da64dfbe10
x-ms-traffictypediagnostic: MWHPR11MB1422:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1plKeyW8UWFj1qM3hvKGdrvDFki97YuhKgaquHNbk6f5jQRR+tviwGwMkLVoDWhXSuseQF90X27QAk1YntwxmmBBz/OVFJ2oo3O1Z48NC1ki/FIOgKOTQj2P5mD3w5VjpFyc2ls6KSbQJS7JU7mk/ZNpZPafYyDwSoP6y2d4U9dwMf77s8Qi8zpSUqwT7ySd7PF8h5bE9zqSUFVLeHWYLLHMTEwGzOeqR+NqFP+/n/+/8hnM9MItTgfSJzMLDQslChJNjv5vFQtx+0+rvvBcpW5Wdf+NT+ys6Y+3MR5BrunfnOQIOGt5wop8dSVF65XWyUuzzdAZfdKPkZpnuL324+ZORGN/Lc7R8+Jz/P32gPHckYGTAMmBadxw/nD530PDXzxlttH2/6I6VxOZf+LsuXBiwKwe07GvCe90ndUgaT0LukJLUJq9u9bxqWvqjTdt2AMSyERgtq1+dYlI0ruX+zZdZuvyCTKCvBwGVW5rRyLXyIy6ZMgqHIkCSkuDWfnSysT/Cw1xEAlxVqmsYrtzclhCsN2Fgqujwzz4/2uZhwfm4UvJCy3j/MF9amrOc355Nras5mckZVxEP13H81smJ0BoDX/1RY1EFXZ6LLqxhDStusewI99L4Qcw0zzpS20QwxQe9lJ4dSJ0IpXyKpeQVHBNMExjEL0A3GthzUA0kPL/lGn7rmKfOsoQc+eIQZ3WXvJPMRl6+GGBfQqa5nqoZBpInaETUYODvnwXYNZKe7L3NbPeW9MVR4ce0RzzcDpSCWqJUgUSbXDLiRzp5mP7psDB+DGaomwAZ5z5/AdqPpvRS7UH+YLpZgPniIYmDnt+h/yPfGLXkB7po8n5cy/0FU9WKm5ptAY/cuWUK5FNpe1MQ+Gqn/HC0lr5UjvUY17g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5160.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(376002)(346002)(39860400002)(396003)(122000001)(26005)(41300700001)(6512007)(6506007)(53546011)(38100700002)(2906002)(186003)(83380400001)(2616005)(478600001)(6486002)(86362001)(8936002)(31686004)(66476007)(66446008)(64756008)(8676002)(71200400001)(36756003)(66556008)(66946007)(4326008)(91956017)(76116006)(54906003)(110136005)(38070700005)(5660300002)(7416002)(31696002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekJyVnFHTEpYQXFRQ3ZTWit0TU40akpkajloSEZ3dXZIMWdwTjV1QVVpcXFn?=
 =?utf-8?B?WWZIZnV6SnFnbWhybnJianVQL2x6NVl6aGp4YTQ4L0JUdWQ0UUNhSkVUNlY1?=
 =?utf-8?B?WEpBYmR1Vk82dEF1THFsc0cyVVI5RzFRVThzR2lYZUs1SGVNNDNRTEtxMi92?=
 =?utf-8?B?MU5LdVFMV2lZQmg5Z3kxUXcvT0lYSC9EVXlmWU8xdGlxSGU1djQrU2FvYXZt?=
 =?utf-8?B?Y1NXc1Z2NnlRZGtGejUxM1B3RERuSlphaFg1OFpTR0dEZ1hqRms3bGF3VXFW?=
 =?utf-8?B?UFkwbStJYmczMUZLYUxTdFF2ZU43cUFaYmJRTGVncEZKdzJhbFFMNy9DMm5I?=
 =?utf-8?B?V0EzMmlha1JMTCt0L3BHYytHZS9ZZSt4SkNjZHdQNmZZSmc0MUlqWWM2aXdF?=
 =?utf-8?B?SGxWdnl4NHNSN3dzY1NXUUJrT28rSlJUdHZ3R2JXK3pWR1hlRXY4Q0dxYUE2?=
 =?utf-8?B?T1M2N0FXUWdzczZ4ZzlIbHVkeHNuMWl6d0w0OUVHLzhQOCsxamsxUkJQVjF4?=
 =?utf-8?B?UUZQSi9YenNaNHVja0puZ0xxU2FQSVUwSlBmVXlvWWg0YWRUNnE1TWZTZXAy?=
 =?utf-8?B?R09qaUR5VWk5T2E0UUNNWFh1WXg4VnR2c3FCendOVHRvUVcvOEQ5QjlUdmdU?=
 =?utf-8?B?T1lJWUlmMlNFZjJ4a1VkdjVteC9ZMTh1SUxuaTkxU1ZzSWlWUHVkR1dja3JU?=
 =?utf-8?B?ZVRHL1Z6U0hlRlc5YzFzamc2Rjk3ajAzUVNBRnl0eG5oSnVuYjRIUnRRVGhU?=
 =?utf-8?B?NWxPV0xqTzBiZFNxSXdCaDFXQ2RleEt3TTQwOHVwM1V1QUFXZ0JZWWJUZ0pj?=
 =?utf-8?B?RzdLam9ZeGhWY1Rwa1gvZm9zY1lSa25OemlVYzczUHNVbDYrR1NObStxUGQz?=
 =?utf-8?B?Rk9UV3daK1JLNlFSV25JVnV6UURZckpkOUlDMWEyK2lvd0pxVFdNZm9PTVVQ?=
 =?utf-8?B?Vjg4UnJxemVHeXh5ZzRNb2pQWS9nZUVxd3dYV09hZU8rSTJwSTlMMmNtczk1?=
 =?utf-8?B?ZG5rQlo2amptdkpXSDkwaXhONUJXNURqMGJVZ2tORVMrWTI3WWo4SHh1ZEVH?=
 =?utf-8?B?cy9xTzBJNkJhL1Juc3FSaEN0WnlMSmkrWmpscThDYzZNQ2hTMDRiQmoxTUxK?=
 =?utf-8?B?N0hqVVRQTWt4ZkxmSU5lejZJWjhiTGhsK0loTnlaTWF3dzVqV3hBQVRtOWMv?=
 =?utf-8?B?ek1YanRMWXovdy9xWjExb08rQ1l1eERGK3RwemY5S2NHMUxpZnZtRTMxdmw0?=
 =?utf-8?B?NU16YitKV1VBS0YrUzQ5Q3hOQkJYVExWQU83dEluZm1aajdKQnNQOUNQTU9r?=
 =?utf-8?B?R3ZVMWhmZXhYVUg3M0kvRHJRbG55ZE9LT2RFSzJoNi9HNlFXSExtbzFIb1RV?=
 =?utf-8?B?MTkzcXVHb1p4c3J1WkVHQTBmT2Q3YVhBaU1GM2ZMUmlzYUppaENHRVZNZHpP?=
 =?utf-8?B?NFlmUHZmdExwTGNockZCN1R6aDZzRUZrWWdzWWprbUwyTmwxV0JaWTc0WXhy?=
 =?utf-8?B?OWtSdVBEY1NNMitlSEJMSHFxUzFWME9mdDNKd1Y2Q1lEaUdlZEc1bEVaWkI3?=
 =?utf-8?B?ZUlQQXBSRGtxNE1iUi9wU0lVT21LS1FSZGFrR2Y2bFFmRDFkM0NwVWU0MG9r?=
 =?utf-8?B?ODU1MHhwVkpnRmJBS2lacDRjSHNsRjNUUUd5TUFCaUR1aGhYS20xZUd4TlBa?=
 =?utf-8?B?WFBnQXM3bE9FSTBCWUNZb3luYnVzQ2htTnA4VE03MWRKVVdDUm1PdmJvczVi?=
 =?utf-8?B?MTZERDdrbzIwN3dQeW52dUY3eUgrUFlIaTBoeEVjNVZKU1Z3VDJNRVBpdEEv?=
 =?utf-8?B?R3JYZktTWXVxR2hYYWZUUzRwc0IwMVp2amlHY1Badjg1Z2M5UXFSN1Q2bzRz?=
 =?utf-8?B?c1c1d05uOXZPanMyL0RDc3ZBNkVNVWxnUitkSlVjMjh0UHVlektRQmpncTRI?=
 =?utf-8?B?bFNxemhaMHBOa2o0OGM4aEx4c2IxcUsvVmI5bWV5S2tIaUdWZERVUVNkUUxn?=
 =?utf-8?B?VUszazBKYnFHcDZvaWFJTWhMVk81NDJNUXRCdWo4YnZjTHhGenJvN2MvRDcy?=
 =?utf-8?B?TExFNXpXOFJtWHRHTTE4QnRYYnoxYnRzZ0x0dE5ZWjRSYm9CTFRNUWVBTStu?=
 =?utf-8?B?d2N5elFRUll6SmUzeG5zQWwzWXNVMngya0xkSmkrcHFnMEd3Q25ZMVJUb3U5?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <866C32FB9551644E83BF86EBCDBB9D96@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5160.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4758f501-29c5-46fe-2c3f-08da64dfbe10
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 14:55:35.5249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m+B+/5tUKXRMxjC1d/A5QIIggIE2qS8I7zHvmBTFiuQL0QoSxsfXe7uESy83EiwaVwp9mQ9QzB3IdRntVCY+HcuZJ/B5sXBAoXvJAuRgrZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1422
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMvMDcvMjAyMiAxNToyNiwgSWNlbm93eSBaaGVuZyB3cm90ZToNCj4gDQo+IOWcqCAyMDIy
LTA3LTEx5pif5pyf5LiA55qEIDE5OjQzICswMTAw77yMQ29ub3IgRG9vbGV55YaZ6YGT77yaDQo+
PiBGcm9tOiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPj4NCj4+
IFRoZSBKSDcxMDAgaGFzIGEgMzIgYml0IG1vbml0b3IgY29yZSB0aGF0IGlzIG1pc3NpbmcgZnJv
bSB0aGUgZGV2aWNlDQo+PiB0cmVlLiBBZGQgaXQgKGFuZCBpdHMgY3B1LW1hcCBlbnRyeSkgdG8g
bW9yZSBhY2N1cmF0ZWx5IHJlZmxlY3QgdGhlDQo+PiBhY3R1YWwgdG9wb2xvZ3kgb2YgdGhlIFNv
Qy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNy
b2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDcx
MDAuZHRzaSB8IDIxICsrKysrKysrKysrKysrKysrKysrKw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAy
MSBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvYm9vdC9kdHMv
c3RhcmZpdmUvamg3MTAwLmR0c2kNCj4+IGIvYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9q
aDcxMDAuZHRzaQ0KPj4gaW5kZXggYzYxN2E2MWUyNmUyLi45MmZjZTViNjZkM2QgMTAwNjQ0DQo+
PiAtLS0gYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poNzEwMC5kdHNpDQo+PiArKysg
Yi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poNzEwMC5kdHNpDQo+PiBAQCAtNjcsNiAr
NjcsMjMgQEAgY3B1MV9pbnRjOiBpbnRlcnJ1cHQtY29udHJvbGxlciB7DQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICB9Ow0KPj4gICAgICAgICAgICAgICAgIH07DQo+Pg0KPj4gKyAgICAgICAg
ICAgICAgIEUyNDogY3B1QDIgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJs
ZSA9ICJzaWZpdmUsZTI0IiwgInJpc2N2IjsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHJl
ZyA9IDwyPjsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGRldmljZV90eXBlID0gImNwdSI7
DQo+PiArICAgICAgICAgICAgICAgICAgICAgICBpLWNhY2hlLWJsb2NrLXNpemUgPSA8MzI+Ow0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgaS1jYWNoZS1zZXRzID0gPDI1Nj47DQo+PiArICAg
ICAgICAgICAgICAgICAgICAgICBpLWNhY2hlLXNpemUgPSA8MTYzODQ+Ow0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgcmlzY3YsaXNhID0gInJ2MzJpbWFmYyI7DQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICBzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPj4gKw0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgY3B1Ml9pbnRjOiBpbnRlcnJ1cHQtY29udHJvbGxlciB7DQo+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAicmlzY3YsY3B1LWludGMiOw0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHQtY29udHJvbGxlcjsNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgI2ludGVycnVwdC1jZWxscyA9IDwxPjsN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgIH07DQo+PiArICAgICAgICAgICAgICAgfTsNCj4+
ICsNCj4+ICAgICAgICAgICAgICAgICBjcHUtbWFwIHsNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgIGNsdXN0ZXIwIHsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29yZTAg
ew0KPj4gQEAgLTc2LDYgKzkzLDEwIEBAIGNvcmUwIHsNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgY29yZTEgew0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGNwdSA9IDwmVTc0XzE+Ow0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB9Ow0KPj4gKw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb3JlMiB7DQo+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY3B1ID0gPCZFMjQ+Ow0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9Ow0KPiANCj4gU29ycnkgYnV0IEkg
dGhpbmsgdGhpcyBjaGFuZ2UgbWFrZXMgdGhlIHRvcG9sb2d5IG1vcmUgaW5hY2N1cmF0ZS4NCj4g
DQo+IFRoZSBFMjQgY29yZSBpcyB2ZXJ5IGluZGVwZW5kZW50LCBqdXN0IGFub3RoZXIgQ1BVIGNv
cmUgY29ubmVjdGVkIHRoZQ0KPiBzYW1lIGJ1cyAtLSBldmVuIG5vIGNvaGVyZW5jeSAoRTI0IHRh
a2VzIEFIQiwgd2hpY2ggaXMgbm90IGNvaGVyZW5jeS0NCj4gc2Vuc2libGUpLiBFdmVuIHRoZSBU
QVAgb2YgaXQgaXMgaW5kZXBlbmRlbnQgd2l0aCB0aGUgVTc0IFRBUC4NCj4gDQo+IEFuZCBieSBk
ZWZhdWx0IGl0IGRvZXMgbm90IGJvb3QgYW55IHByb3BlciBjb2RlIChpZiBhIGRlYnVnZ2VyIGlz
DQo+IGF0dGFjaGVkLCBpdCB3aWxsIGRpc2NvdmVyIHRoYXQgdGhlIEUyNCBpcyBpbiBjb25zaXN0
ZW50bHkgZmF1bHQgYXQgMHgwDQo+IChtdHZlYyBpcyAweDAgYW5kIHdoZW4gZmF1bHQgaXQganVt
cHMgdG8gMHgwIGFuZCBmYXVsdCBhZ2FpbiksIHVudGlsDQo+IGl0cyBjbG9jayBpcyBqdXN0IHNo
dXRkb3duIGJ5IExpbnV4IGNsZWFuaW5nIHVwIHVudXNlZCBjbG9ja3MuKQ0KPiANCj4gUGVyc29u
YWxseSBJIHRoaW5rIGl0IHNob3VsZCBiZSBpbXBsZW1lbnRlZCBhcyBhIHJlbW90ZXByb2MgaW5z
dGVhZC4NCg0KTWF5YmUgSSBhbSBtaXNzaW5nIHNvbWV0aGluZywgYnV0IEkgZG9uJ3QgcXVpdGUg
Z2V0IHdoYXQgdGhlIGRldGFpbA0Kb2YgaG93IHdlIGFjY2VzcyB0aGlzIGluIGNvZGUgaGFzIHRv
IGRvIHdpdGggdGhlIGRldmljZXRyZWU/DQpJdCBpcyBhZGRlZCBoZXJlIGluIGEgZGlzYWJsZWQg
c3RhdGUsIGFuZCB3aWxsIG5vdCBiZSB1c2VkIGJ5IExpbnV4Lg0KVGhlIHZhcmlvdXMgU2lGaXZl
IFNvQ3MgJiBTaUZpdmUgY29yZWNvbXBsZXggdXNlcnMgdGhhdCBoYXZlIGEgaGFydA0Kbm90IGNh
cGFibGUgb2YgcnVubmluZyBMaW51eCBhbHNvIGhhdmUgdGhhdCBoYXJ0IGRvY3VtZW50ZWQgaW4g
dGhlDQpkZXZpY2V0cmVlLg0KVG8gbWUsIHdoYXQgd2UgYXJlIGNob29zaW5nIHRvIGRvIHdpdGgg
dGhpcyBoYXJ0IGRvZXMgbm90IHJlYWxseQ0KbWF0dGVyIHZlcnkgbXVjaCwgc2luY2UgdGhpcyBp
cyBhIGRlc2NyaXB0aW9uIG9mIHdoYXQgdGhlIGhhcmR3YXJlDQphY3R1YWxseSBsb29rcyBsaWtl
Lg0KDQpUaGFua3MsDQpDb25vci4NCg0K
