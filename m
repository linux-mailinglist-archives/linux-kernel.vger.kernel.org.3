Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2275683F4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiGFJnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiGFJnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:43:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D26BC33;
        Wed,  6 Jul 2022 02:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657100589; x=1688636589;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vaqgWDec7rpya2fHtXy2HBmNGBzfLlaGPboZgo3h5r0=;
  b=GT1b4JxtP1TEjBFd7RJe6DBbMsljfBcME3njbmHZRy1A8lprdCiwiKPk
   ha6wNeRyWc94YsIFCT8eISEycZ6YOAnptbtsPNZxZzBi3EQk10BKH4edg
   3ktDkBYmRU/4oD5alHiNUmQzvmI7LWBnkXVbZupaC+bac+k0rdk/CZ71H
   +LiOVcYEHTRl921XI8lXDBM8y8CLdOAUyITogWdwoc4/RB3KKGOx/XAGl
   LmA8DQTl4JZT9DYt+LV+hUaCHMjkHC7gMcapviq1nZ9mAOIqUL3L5isGA
   IvaYeNcwvCXLJfdl9n5hbKbqTYisrn0UaTK9vZ8gmq0BY6oO4Dx7UgpaW
   g==;
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="163536733"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jul 2022 02:43:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 6 Jul 2022 02:43:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 6 Jul 2022 02:43:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUmakOewfRSshQFqW+sXwFx2kuWDnocJySqED4EXxpPjEIaka9ezZdPfZe+q/LaUG8WJTVe55qGyxif9mdO+eTf7QJWIfGKEHS1hNHsb744+jxr1SGbrTAZJCoxTa02dhhv6y8dipQ5W2OY9gDieQiEzMhwtB/I/a8v8P78JSRrVNyXa41BK1K5S8LB7p03Dax2aA0jtDMHSCq3W/CKqEOwGZKVMbjkodbZP/wehfEkgd9AidIYmQ5DZlhbKEISF+6zubzSgWee8yIxkND08qZXesX+jR5y5LUJDWWhdsRa0i8wnvze9G2FRaPqMLIJiq1eUfaWHpHA0m4tk0NdodA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaqgWDec7rpya2fHtXy2HBmNGBzfLlaGPboZgo3h5r0=;
 b=giR4+4SMKdvtgKutYWaY9Q8dZGphV0Z4+P2zn8p+YvE0den2EumZQEH5MiQOgUsEAnx9zb7aFun+4eg4IpJHPF5Pe8dJSSfZzvZFdbQ+anI+kr7sPNt4U4b7M2tsBtDHLInoO17VFTo0sdTHy0k0OUtM9sBoHv+JC6G+IRHr4glRkg9J1yq3ygFRgiOwcQwTm2RbKEXeY3Xxw2IYqFuMNKuA1OwSjP1/1ZvhP03PW5DxHp6FvO8SQQYCEWkNK2kd37lcyx6p8paCCS1ovM1mlOttsnlWjUzd7xMV/fpYosLOjXriD9inGHXK3W6Otw1na1+SE5Zk5TLMUqTYHENE7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaqgWDec7rpya2fHtXy2HBmNGBzfLlaGPboZgo3h5r0=;
 b=MykJxBYwLhBiEvP5fc142Pf0EYGx/bkFhyOiChatnZXtvVCaY+1copEM5NsvFkwtkd87oKks6i0E9ld1cbZk+ZQs0pYa+hHJN2jYYn3bklil9yaEvjMg/6yV3itKAcJBnjagtOwTkIugxVAyd7YrIkwngLnqf1aaLXh+Eh2Obec=
Received: from PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8)
 by SN6PR11MB2992.namprd11.prod.outlook.com (2603:10b6:805:d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Wed, 6 Jul
 2022 09:43:02 +0000
Received: from PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::6090:db2c:283b:fe69]) by PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::6090:db2c:283b:fe69%8]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 09:43:02 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sudeep.holla@arm.com>, <Conor.Dooley@microchip.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <Daire.McNamara@microchip.com>,
        <niklas.cassel@wdc.com>, <damien.lemoal@opensource.wdc.com>,
        <geert@linux-m68k.org>, <zong.li@sifive.com>, <kernel@esmil.dk>,
        <hahnjo@hahnjo.de>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Brice.Goglin@inria.fr>
Subject: Re: [PATCH 0/5] RISC-V: Add cpu-map topology information nodes
Thread-Topic: [PATCH 0/5] RISC-V: Add cpu-map topology information nodes
Thread-Index: AQHYkKIdHc6oV2H//EKJV+LfcdW+Dq1wN82AgAAD8QCAACn8AIAArIoAgAAGDIA=
Date:   Wed, 6 Jul 2022 09:43:02 +0000
Message-ID: <9f26cd2a-b389-3f4b-b7d2-06fa5c2d7016@microchip.com>
References: <20220705190435.1790466-1-mail@conchuod.ie>
 <20220705201931.nfwi5rlku7ykmydr@bogus>
 <8f07796a-d9a2-3301-aafb-7fbec4d5b1a2@microchip.com>
 <fb7be22c-cf19-0e06-f231-bb5b9167e179@microchip.com>
 <20220706092126.k6zaknwcwzyg22ak@bogus>
In-Reply-To: <20220706092126.k6zaknwcwzyg22ak@bogus>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b7dbcb1-ec8c-4df3-0d50-08da5f33eb4d
x-ms-traffictypediagnostic: SN6PR11MB2992:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4V/2yBoM/cgID15QuyMZX3kTNWyp1ocV9/AMZpS1JdNHOir0lQr4kqcjf/y4lPpQKmi7cb27sC9jiEM03D/0lhOJttJ8lJbu6tdoCQ4HPPa8ttUrJDvT9pmA6hfTGbTdvxCBgnRz12EaX3EnLeKlI/o46EsAC9UT8l634PQ1DYXxneb+x45rMzySVrAzekBpCRpU67/HEvcauCiod/OKFMuIJZ4XJzeQtv2epc48P1HheG0/UVA9vC7+PPpLyFtLCYGaWUzYWkAKOi8vPP0fnuA9hea/BnEKRvQuvgMDgRHopynneby9Kb8/uViu3x86uTFnLksBS+54CQ0Bdgfp/eNZGxuEi6Yg005VSSjfeDFJr8mzhBYCbMeAv+u40JAM5NJ2nhBPDJLL3V0L5xSvXonZP+tFSCMXGdaLXAUsZihXRC83fIVOlof8w/LKaa+vyXKnjpKudwpC1MH4MUZivXsqB3uVKauZHltZkmUT37uaSQF7Ig+Ish2v6EwEJcRamOS81+yIfiJdyL0Yk3oP13buVtnaZyfaE2T54qPzBtUkOD4JMXQaDX/ZAdasleEn/0SC+7d6sBRiCS5RuDuk4t94V5cWWYbSdLjW8hXI5E1Q4sq4r3Kld+PYzCVWKHr1H4OvOOJrvsaX4oGFLA5wl7DUgqCnbhRa7Opt4nl2nf6Ajcqeue5BGrDIMAoiUEfGURYpaoKQhvyKMTugoQTDMQo1qcLtwNlg7qenldWT7iJ7grkwbcUkGjQ4pdmABVbbJqYoRcniu6TAImVze7jxCDzv6llSuERP4eQFaS/Glbo4kG8uM76EYCqH5Rn5DNgX77umr4x7eOqPgU85BuwaZBDCU/J+wOrhA6PvwzKI2UbqyYq5jlTIikIly/3Soj3H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5160.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(136003)(39860400002)(376002)(366004)(316002)(41300700001)(86362001)(31686004)(38100700002)(31696002)(6486002)(8936002)(38070700005)(122000001)(7416002)(2906002)(5660300002)(66476007)(110136005)(66446008)(76116006)(478600001)(6506007)(64756008)(66946007)(8676002)(4326008)(66556008)(91956017)(186003)(26005)(83380400001)(71200400001)(36756003)(2616005)(6512007)(54906003)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3ozQ3pqcUVUZ05DVXFGZUs5M3NMcGx2UUpaUlladkN1TnBYYWRZRWtUc2dJ?=
 =?utf-8?B?eDhwaG5xTHdReWlraDNGblNRS3JaNFJZOGR1azUrVDl4bzBJZi8zdFFWSkQ3?=
 =?utf-8?B?WFYzOEMwY1p4TXl1V0xNOEh1c0w1S0Nza1RZL2dzUllTaitkSWJWTmVQa3hH?=
 =?utf-8?B?UnQ3YWdEWlRKQ1pKSUU1RTczdzRlUDI4dlB2RWRTcUFlZGdPL3p1NVhCcjRU?=
 =?utf-8?B?TzRrak1FaVBTb3pRZE5ZbnJjWkRWU21NdnNxclpNd3NaTk1lc1ZKKzJBczRV?=
 =?utf-8?B?YWFYMW9FQmY1K1VXWVZ4ZnZaSCtGbG50dGZoUUtyYm1ZSkN6KzFMK0Jmd0g3?=
 =?utf-8?B?L1ZYMkVaNEdzazVJa3NZSHM5UU9UR2NwOGJnVG1TdTJBKzRFS0t1cG5EUE5q?=
 =?utf-8?B?NmJkZ3c4TTZKUWU3NjBkWEJvYWlpbE5mbmUwcFZDOTVIaFM3SktselZKZ0ZG?=
 =?utf-8?B?WHhUeG5aWnQxMGd1UTN1Qy8yU1AvYThGcldDMGtyRVlZVUdCSHp2ZmtLaWFB?=
 =?utf-8?B?Zm12TU9kZGVUMHRUelZ1b2lGckxKV01wcTNMZFU0ZWs4VUZVdTFQalV4MGdC?=
 =?utf-8?B?cHN4M1ZkdFljOVRNbUJFQXlDaTVibjFIYUUyWEVOQllzM0VOb2RGajVMc3I1?=
 =?utf-8?B?MjU3N3BqRndDWWd6N2R2TU1vUnc3VWxiQk1NVGlTenlxL3YyVFdrd1dTWmo5?=
 =?utf-8?B?MStjM29VNnVPemhmUTlNUVRlaityb1BONDBSUnNJY1FhQXlPdWRmZ1RvOGF1?=
 =?utf-8?B?aFg1S3M2aEZsQ2NaZDluNkpzLzhXMEdCN20yLzdjeEh4MHIwaW4wR0dmcDNH?=
 =?utf-8?B?YTR5ZFRyek8yM1E3a2FaUDhpZEw1RjB0dCt3WU9zRzJ4V2EzcE9rZGg0TGpF?=
 =?utf-8?B?VnFibE1yT0hmSXJ0ZXJVeTNwTGdnUHF1WG94QzhFV3ZKaW9QMXRSYTR5TVZv?=
 =?utf-8?B?ZU9wNmhjOTRDSmNLVTBmRVIyMjFxWkhHL20yZ1Q5SUpJWGJjeTk1WUo5SmZx?=
 =?utf-8?B?YUk4T0I1V21pVGV3aVNaV29CYlB6RWErQW1pL29OZGtjOXJTdXJqSkVGNzhP?=
 =?utf-8?B?ZGFWbUZJb2dSSENIOHpiZEV3bWxyS0Z6TU1LeXVtRnozZVN6enBuY3JoWUdh?=
 =?utf-8?B?OTRKM0FsTVFIdW94OStMME5mZHhCMnA2cWRWQmVSdE96L1NJRTFVbTVSMWRC?=
 =?utf-8?B?ZEREc24yTnJGWmtKT1VteWJZR0Fyd3FVRE9lWlpyWWVuSUp5YUV3dllOS3FQ?=
 =?utf-8?B?U0hZNEdBNyt4S0dFNDhjV2Yra2pRZmYzVlBGZkR5VW5Xd2t5dmJNSHYvTW41?=
 =?utf-8?B?Y2FFK01mWWx6OHNFc0RSVXVSY3ZpaWFlZi9zV1lQenA5OG9YS2RCRXYzWlNI?=
 =?utf-8?B?R0lqUzlZT1gyNFF5R2ZGYjZVMkhmMFp4TzMxTkxsZkhvLzh2TG5ZdXZjUVdQ?=
 =?utf-8?B?dXRHajN5UGcrRUhrWFhiK05DVWtzcUhWNFlDZzRYblNESGdUbUp6NFcrcE15?=
 =?utf-8?B?cjVsRWloYzMxOEx6VUNPK2ZaRnByMHZsazZGV3RzTzdDQ0JkUmFrd0J4cVRl?=
 =?utf-8?B?SE1uaEhMY0lvTmVkbU5obFcwSkpaUzF2KzFxVzNMR3pUbGJ5YzA2QUFNSGha?=
 =?utf-8?B?bnptOVNOejVXcEtBTXZIb0tNTnRDcGcvSVkyRS9ac2kwWWMyd1NNWWY0ck11?=
 =?utf-8?B?K0xyMVBoemVEaHNRb2I5aWNRcG5JQis0OHNudHZBZmF0L0d1eFd1STF2ejVT?=
 =?utf-8?B?TEZwbUxtbTFEZVRBamUzaFNER0grZ1N5Z2tzejlISkxmQi9JdWx1dVlDV3B5?=
 =?utf-8?B?L1hKWDcwZGphempUblJaZU5PVnhBbmVhZm96UUszTmV2V3ZEZGZ5OGpjRDNh?=
 =?utf-8?B?VzlhRHlkTDU5NU1QY0dDRkhZWTdlWkdnN01ERmVEYWVVc0phMFE0dXkyZVVP?=
 =?utf-8?B?ZVVYM0tVV3BRZHo3K1BsYWtTQUE0bVM3RmgwR3prK082RG9PeS9lMkRNcEZM?=
 =?utf-8?B?aW9PZEpWd2RObFN1WUdPWVpuOU4wVU80MUw0SnJ4ci8zQlM3N2NmUXMwYVFI?=
 =?utf-8?B?dk9RUVhOZDArRy8vTXM5NERxMjhZamo1Z0dsZGJRelJvMW95MUxLRGNQcU16?=
 =?utf-8?Q?44YP8o2YxbH49l0+Yy10PUutp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7D9F216B8A5AA4C9B251311077777FB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5160.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7dbcb1-ec8c-4df3-0d50-08da5f33eb4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 09:43:02.1842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oqVOvJQjjCncshiYlodS1N9/SxR4A83zaSS0a4+MU+z+FxLOVVcXMrGnQHfG+1iFH10LshjvBXkErBeVUE7F66tSCUvOORgiLt09Iacv1rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2992
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA2LzA3LzIwMjIgMTA6MjEsIFN1ZGVlcCBIb2xsYSB3cm90ZToNCj4gT24gVHVlLCBK
dWwgMDUsIDIwMjIgYXQgMTE6MDM6NTRQTSArMDAwMCwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5j
b20gd3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDA1LzA3LzIwMjIgMjE6MzMsIENvbm9yLkRvb2xleUBt
aWNyb2NoaXAuY29tIHdyb3RlOg0KPj4+DQo+Pj4NCj4+PiBPbiAwNS8wNy8yMDIyIDIxOjE5LCBT
dWRlZXAgSG9sbGEgd3JvdGU6DQo+Pj4+IE9uIFR1ZSwgSnVsIDA1LCAyMDIyIGF0IDA4OjA0OjMx
UE0gKzAxMDAsIENvbm9yIERvb2xleSB3cm90ZToNCj4+Pj4+IEZyb206IENvbm9yIERvb2xleSA8
Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+Pj4+Pg0KPj4+Pj4gSXQgd2FzIHJlcG9ydGVk
IHRvIG1lIHRoYXQgdGhlIEhpdmUgVW5tYXRjaGVkIGluY29ycmVjdGx5IHJlcG9ydHMNCj4+Pj4+
IGl0cyB0b3BvbG9neSB0byBod2xvYywgYnV0IHRoZSBTdGFyRml2ZSBWaXNpb25GaXZlIGRpZCBp
biBbMF0gJg0KPj4+Pj4gYSBzdWJzZXF1ZW50IG9mZi1saXN0IGVtYWlsIGZyb20gQnJpY2UgKHRo
ZSBod2xvYyBtYWludGFpbmVyKS4NCj4+Pj4+IFRoaXMgdHVybmVkIG91dCBub3QgdG8gYmUgZW50
aXJlbHkgdHJ1ZSwgdGhlIC9kb3duc3RyZWFtLyB2ZXJzaW9uDQo+Pj4+PiBvZiB0aGUgVmlzaW9u
Rml2ZSBkb2VzIHdvcmsgY29ycmVjdGx5IGJ1dCBub3QgdXBzdHJlYW0sIGFzIHRoZQ0KPj4+Pj4g
ZG93bnN0cmVhbSBkZXZpY2V0cmVlIGhhcyBhIGNwdS1tYXAgbm9kZSB0aGF0IHdhcyBhZGRlZCBy
ZWNlbnRseS4NCj4+Pj4+DQo+Pj4+PiBUaGlzIHNlcmllcyBhZGRzIGEgY3B1LW1hcCBub2RlIHRv
IGFsbCB1cHN0cmVhbSBkZXZpY2V0cmVlcywgd2hpY2gNCj4+Pj4+IEkgaGF2ZSB0ZXN0ZWQgb24g
bXBmcyAmIGZ1NTQwLiBUaGUgZmlyc3QgcGF0Y2ggaXMgbGlmdGVkIGRpcmVjdGx5DQo+Pj4+PiBm
cm9tIHRoZSBkb3duc3RyZWFtIFN0YXJGaXZlIGRldmljZXRyZWUuDQo+Pj4+Pg0KPj4+Pg0KPj4+
PiBSZXZpZXdlZC1ieTogU3VkZWVwIEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJtLmNvbT4NCj4+Pj4N
Cj4+Pj4gSSB3b3VsZCByZWNvbW1lbmQgdG8gaGF2ZSBzYW5lIGRlZmF1bHRzIGluIGNvcmUgcmlz
Yy12IGNvZGUgaW4gY2FzZSBvZg0KPj4+PiBhYnNlbmNlIG9mIC9jcHUtbWFwIG5vZGUgYXMgaXQg
aXMgb3B0aW9uYWwuIFRoZSByZWFzb24gSSBtZW50aW9uZWQgaXMgdGhhdA0KPj4+PiBDb25vciBt
ZW50aW9uZWQgaG93IHRoZSBkZWZhdWx0IHZhbHVlcyBpbiBhYnNlbmNlIG9mIHRoZSBub2RlIGxv
b2tlZCBxdWl0ZQ0KPj4+PiB3cm9uZy4gSSBkb24ndCBrbm93IGlmIGl0IGlzIHBvc3NpYmxlIG9u
IFJJU0MtViBidXQgb24gQVJNNjQgd2UgZG8gaGF2ZQ0KPj4+PiBkZWZhdWx0IHZhbHVlcyBpZiBh
cmNoX3RvcG9sb2d5IGZhaWxzIHRvIHNldCBiYXNlZCBvbiBEVC9BQ1BJLg0KPj4+Pg0KPj4+DQo+
Pj4gWWVhaCB0aGUgZGVmYXVsdHMgYXJlIGFsbCAtMS4gSSdsbCBhZGQgc29tZSBzYW5lIGRlZmF1
bHRzIGZvciBhIHYyLg0KPj4+IFRoYW5rcywNCj4+PiBDb25vci4NCj4+DQo+PiBJIHNoYW1lbGVz
c2x5IHN0b2xlIGZyb20gYXJtNjQuLi4gU2VlbXMgdG8gd29yaywgYnV0IGhhdmUgZG9uZSBtaW5p
bWFsDQo+PiB0ZXN0aW5nIChvbmx5IFBvbGFyRmlyZSBTb0MpLg0KPj4NCj4+IEF1dGhvcjogQ29u
b3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4+IERhdGU6ICAgV2VkIEp1
bCA2IDAwOjAwOjM0IDIwMjIgKzAxMDANCj4+DQo+PiAgICAgIHJpc2N2OiBhcmNoLXRvcG9sb2d5
OiBhZGQgc2FuZSBkZWZhdWx0cw0KPj4gICAgICANCj4+ICAgICAgUklTQy1WIGhhcyBubyBzYW5l
IGRlZmF1bHRzIHRvIGZhbGwgYmFjayBvbiB3aGVyZSB0aGVyZSBpcyBubyBjcHUtbWFwDQo+PiAg
ICAgIGluIHRoZSBkZXZpY2V0cmVlLiBBZGQgc2FuZSBkZWZhdWx0cyBpbiB+dGhlIGV4YWN0IHNh
bWUgd2F5IGFzIEFSTTY0Lg0KPj4gICAgICANCj4+ICAgICAgU2lnbmVkLW9mZi1ieTogQ29ub3Ig
RG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
YXJjaC9yaXNjdi9pbmNsdWRlL2FzbS90b3BvbG9neS5oIGIvYXJjaC9yaXNjdi9pbmNsdWRlL2Fz
bS90b3BvbG9neS5oDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAw
MDAwLi43MWM4MDcxMGYwMGUNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL2FyY2gvcmlzY3Yv
aW5jbHVkZS9hc20vdG9wb2xvZ3kuaA0KPj4gQEAgLTAsMCArMSwxMyBAQA0KPj4gKy8qIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkgKi8NCj4+ICsvKg0KPj4gKyAqIENvcHly
aWdodCAoYykgMjAyMiBNaWNyb2NoaXAgVGVjaG5vbG9neSBJbmMuIGFuZCBpdHMgc3Vic2lkaWFy
aWVzDQo+PiArICovDQo+PiArDQo+PiArI2lmbmRlZiBfQVNNX1JJU0NWX1RPUE9MT0dZX0gNCj4+
ICsjZGVmaW5lIF9BU01fUklTQ1ZfVE9QT0xPR1lfSA0KPj4gKw0KPj4gKyNpbmNsdWRlIDxhc20t
Z2VuZXJpYy90b3BvbG9neS5oPg0KPj4gKw0KPj4gK3ZvaWQgc3RvcmVfY3B1X3RvcG9sb2d5KHVu
c2lnbmVkIGludCBjcHVpZCk7DQo+PiArDQo+PiArI2VuZGlmIC8qIF9BU01fUklTQ1ZfVE9QT0xP
R1lfSCAqLw0KPj4gXCBObyBuZXdsaW5lIGF0IGVuZCBvZiBmaWxlDQo+PiBkaWZmIC0tZ2l0IGEv
YXJjaC9yaXNjdi9rZXJuZWwvTWFrZWZpbGUgYi9hcmNoL3Jpc2N2L2tlcm5lbC9NYWtlZmlsZQ0K
Pj4gaW5kZXggYzcxZDY1OTFkNTM5Li45NTE4ODgyYmE2ZjkgMTAwNjQ0DQo+PiAtLS0gYS9hcmNo
L3Jpc2N2L2tlcm5lbC9NYWtlZmlsZQ0KPj4gKysrIGIvYXJjaC9yaXNjdi9rZXJuZWwvTWFrZWZp
bGUNCj4+IEBAIC01MCw2ICs1MCw3IEBAIG9iai15ICs9IHJpc2N2X2tzeW1zLm8NCj4+ICAgb2Jq
LXkgICs9IHN0YWNrdHJhY2Uubw0KPj4gICBvYmoteSAgKz0gY2FjaGVpbmZvLm8NCj4+ICAgb2Jq
LXkgICs9IHBhdGNoLm8NCj4+ICtvYmoteSAgKz0gdG9wb2xvZ3kubw0KPj4gICBvYmoteSAgKz0g
cHJvYmVzLw0KPj4gICBvYmotJChDT05GSUdfTU1VKSArPSB2ZHNvLm8gdmRzby8NCj4+ICAgDQo+
PiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9rZXJuZWwvc21wYm9vdC5jIGIvYXJjaC9yaXNjdi9r
ZXJuZWwvc21wYm9vdC5jDQo+PiBpbmRleCBmMWU0OTQ4YTRiNTIuLmQ1NTFjN2Y0NTJkNCAxMDA2
NDQNCj4+IC0tLSBhL2FyY2gvcmlzY3Yva2VybmVsL3NtcGJvb3QuYw0KPj4gKysrIGIvYXJjaC9y
aXNjdi9rZXJuZWwvc21wYm9vdC5jDQo+PiBAQCAtMzIsNiArMzIsNyBAQA0KPj4gICAjaW5jbHVk
ZSA8YXNtL3NlY3Rpb25zLmg+DQo+PiAgICNpbmNsdWRlIDxhc20vc2JpLmg+DQo+PiAgICNpbmNs
dWRlIDxhc20vc21wLmg+DQo+PiArI2luY2x1ZGUgPGFzbS90b3BvbG9neS5oPg0KPj4gICANCj4+
ICAgI2luY2x1ZGUgImhlYWQuaCINCj4+ICAgDQo+PiBAQCAtNDAsNiArNDEsOCBAQCBzdGF0aWMg
REVDTEFSRV9DT01QTEVUSU9OKGNwdV9ydW5uaW5nKTsNCj4+ICAgdm9pZCBfX2luaXQgc21wX3By
ZXBhcmVfYm9vdF9jcHUodm9pZCkNCj4+ICAgew0KPj4gICAgICAgICAgaW5pdF9jcHVfdG9wb2xv
Z3koKTsNCj4+ICsNCj4+ICsgICAgICAgc3RvcmVfY3B1X3RvcG9sb2d5KHNtcF9wcm9jZXNzb3Jf
aWQoKSk7DQo+PiAgIH0NCj4+ICAgDQo+PiAgIHZvaWQgX19pbml0IHNtcF9wcmVwYXJlX2NwdXMo
dW5zaWduZWQgaW50IG1heF9jcHVzKQ0KPj4gQEAgLTE2MSw2ICsxNjQsNyBAQCBhc21saW5rYWdl
IF9fdmlzaWJsZSB2b2lkIHNtcF9jYWxsaW4odm9pZCkNCj4+ICAgICAgICAgIG1tZ3JhYihtbSk7
DQo+PiAgICAgICAgICBjdXJyZW50LT5hY3RpdmVfbW0gPSBtbTsNCj4+ICAgDQo+PiArICAgICAg
IHN0b3JlX2NwdV90b3BvbG9neShjdXJyX2NwdWlkKTsNCj4+ICAgICAgICAgIG5vdGlmeV9jcHVf
c3RhcnRpbmcoY3Vycl9jcHVpZCk7DQo+PiAgICAgICAgICBudW1hX2FkZF9jcHUoY3Vycl9jcHVp
ZCk7DQo+PiAgICAgICAgICB1cGRhdGVfc2libGluZ3NfbWFza3MoY3Vycl9jcHVpZCk7DQo+PiBk
aWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9rZXJuZWwvdG9wb2xvZ3kuYyBiL2FyY2gvcmlzY3Yva2Vy
bmVsL3RvcG9sb2d5LmMNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAw
MDAwMDAuLjc5OWIzNDIzZTBiYw0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvYXJjaC9yaXNj
di9rZXJuZWwvdG9wb2xvZ3kuYw0KPj4gQEAgLTAsMCArMSwzMCBAQA0KPj4gKy8vIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkNCj4+ICsvKg0KPj4gKyAqIEJhc2VkIG9uIHRo
ZSBhcm02NCB2ZXJzaW9uLCB3aGljaCB3YXMgaW4gdHVybiBiYXNlZCBvbiBhcm0zMiwgd2hpY2gg
d2FzDQo+PiArICogdWx0aW1hdGVseSBiYXNlZCBvbiBzaCdzLg0KPj4gKyAqIFRoZSBhcm02NCB2
ZXJzaW9uIHdhcyBsaXN0ZWQgYXM6DQo+PiArICogQ29weXJpZ2h0IChDKSAyMDExLDIwMTMsMjAx
NCBMaW5hcm8gTGltaXRlZC4NCj4+ICsgKg0KPj4gKyAqLw0KPj4gKyNpbmNsdWRlIDxsaW51eC9h
cmNoX3RvcG9sb2d5Lmg+DQo+PiArI2luY2x1ZGUgPGxpbnV4L3RvcG9sb2d5Lmg+DQo+PiArI2lu
Y2x1ZGUgPGFzbS90b3BvbG9neS5oPg0KPj4gKw0KPj4gK3ZvaWQgc3RvcmVfY3B1X3RvcG9sb2d5
KHVuc2lnbmVkIGludCBjcHVpZCkNCj4+ICt7DQo+PiArICAgICAgIHN0cnVjdCBjcHVfdG9wb2xv
Z3kgKmNwdWlkX3RvcG8gPSAmY3B1X3RvcG9sb2d5W2NwdWlkXTsNCj4+ICsNCj4+ICsgICAgICAg
aWYgKGNwdWlkX3RvcG8tPnBhY2thZ2VfaWQgIT0gLTEpDQo+PiArICAgICAgICAgICAgICAgZ290
byB0b3BvbG9neV9wb3B1bGF0ZWQ7DQo+PiArDQo+PiArICAgICAgIGNwdWlkX3RvcG8tPnRocmVh
ZF9pZCA9IC0xOw0KPj4gKyAgICAgICBjcHVpZF90b3BvLT5jb3JlX2lkID0gY3B1aWQ7DQo+PiAr
ICAgICAgIGNwdWlkX3RvcG8tPnBhY2thZ2VfaWQgPSBjcHVfdG9fbm9kZShjcHVpZCk7DQo+PiAr
DQo+PiArICAgICAgIHByX2luZm8oIkNQVSV1OiBjbHVzdGVyICVkIGNvcmUgJWQgdGhyZWFkICVk
XG4iLA0KPj4gKyAgICAgICAgICAgICAgICBjcHVpZCwgY3B1aWRfdG9wby0+cGFja2FnZV9pZCwg
Y3B1aWRfdG9wby0+Y29yZV9pZCwNCj4+ICsgICAgICAgICAgICAgICAgY3B1aWRfdG9wby0+dGhy
ZWFkX2lkKTsNCj4+ICsNCj4+ICt0b3BvbG9neV9wb3B1bGF0ZWQ6DQo+PiArICAgICAgIHVwZGF0
ZV9zaWJsaW5nc19tYXNrcyhjcHVpZCk7DQo+PiArfQ0KPj4NCj4gDQo+IExvb2tzIGdvb2QuIEFn
YWluIHBhY2thZ2UgaWQgaXMgbm90IGNsdXN0ZXIuIFRoaXMgaXMgd2hhdCBteSBzZXJpZXMgaXMN
Cj4gYWRkcmVzc2luZy4gU28gdXBkYXRlIHRoZSBsb2cgYXMgUGFja2FnZSBpbnN0ZWFkIG9mIENs
dXN0ZXIgYWJvdmUuIFRoZQ0KPiBjbHVzdGVyIGlkIHdpbGwgYmUgLTEgdW5sZXNzIHlvdSBjYW4g
Z2V0IHRoYXQgZm9yIERULg0KDQoNCkNvb2wsIEknbGwgcmVzcGluIGEgdjIgd2l0aG91dCB0aGlz
IGluY2x1ZGVkIHRoZW4gJiBnZXQgdGhlIHNlcmllcw0KYmFja3BvcnRlZCBzaW5jZSB0aGlzIGlz
IHVzZXIgdmlzaWJsZSAmIHdpbGwgZml4IGFsbCBleGlzdGluZyBzdXBwb3J0ZWQNCnBsYXRmb3Jt
cy4NCg0KDQpJJ2xsIHNlbmQgdGhlIHRvcG9sb2d5IGNvZGUgY2hhbmdlcyBzZXBhcmF0ZWx5IHRv
IGF2b2lkIGl0IGdvaW5nDQpmb3J3YXJkcy4NClRoYW5rcyENCkNvbm9yLg0KDQo=
