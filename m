Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D9D4CD11D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237272AbiCDJfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbiCDJfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:35:45 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30864180238
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 01:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646386497; x=1677922497;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ok/AZauEfQUxiYX4qHYBlIGQ0+QwAb17AIUQ8qTKo0E=;
  b=oEWOos/OhFjWUIdSAXBJ3tBsPDGxA9eKA5RdHH6WlFdOBKpCtybiMSYD
   cj3VIOnt41H2EjwcaSG/H+Xp0RnwsU2Fx+9L4NHNgOCiIOIBVctMQkE0Y
   BND4P+T9PAKrXmFHYH/SlSz0kLihadquCNvBey9LIu8+aqOG/qSJWXaDb
   vN4lMjijCBpTgoWWwz9zdQlO5NEUK3gnqhrGSv7Tqhiw+9VeElbq/Ovm6
   wQAM/tPmhfN4zmjNz7W6K1Q74SCeSJi0sHeBKr1Y5nlhrOZqIeWI4n4JU
   gVHom1xBZhY5tzRTtOcZt2J7excx1uDPkpJG/R+F5e4YRdDYeWcZXGjW6
   w==;
X-IronPort-AV: E=Sophos;i="5.90,154,1643698800"; 
   d="scan'208";a="155708299"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 02:34:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 02:34:56 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 4 Mar 2022 02:34:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnOOMltY9jVLaJ31H6EQ1VNxYGMhkPFBjvbQScnZGXle4pHpDf2YHEe3XZHrVbjJ02Bh4awqw1yDWDjSqGykTcPEDxKHeIibK55XakQMIYPC/qREcFyuOe3sEqds+EW7D9I1dJiZyaoYW1eczmDklo7EoxNZYtnKQefGU7Trqt2kmKRMnwY2a7n0mNqETtumvJjeGCa7diNX9XEnakxirLxzQ9oFXgbpqtI57bGjX16IOKP4Pyjk9rDVFv/FYbW/wjgAO8nNWejCpZjW4R5Gjas6k4nmE0Vtr9qqo+nK4ENoUqOi5ybZ0Twc1p6BYx1r9RYgaO2goOxG/SmejCAIOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ok/AZauEfQUxiYX4qHYBlIGQ0+QwAb17AIUQ8qTKo0E=;
 b=L0MMscSN5XQUW2xUvTBiLwhhmdllPf4rXxysIpYOhl8+7DS4tY4H2tyEGoDCOwh2/Fr2D4BAUJGfMUS9YBP5C0/pH6qgi4dt1QBmsuNFtzS6lBYpmFyxNsXs7LEVEH1tmFiPWdRfSrjhW4f4atna3nxlDhjzAJytlMVFnLIuBSCbgExRs+4LTgJzF/syYxTWVpExoza8lzWVTrmJyHzwaulFwN1ohgm+1dVGFsngncxZA0lqPEhlSBufvOIikZa++ri5gPwaDxeZVpreZ9mxGGXQjasmhSQC8cb39OAp9hO0iT63X9eW8sXDNUU0QZovQjRs046YIwqY7RpozgD/FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ok/AZauEfQUxiYX4qHYBlIGQ0+QwAb17AIUQ8qTKo0E=;
 b=UmCBjC9geKYL95DLuu5G9f0KNxc2kCKrkWaS6aEpFN9fo+m+ckA7Os/2oCBT2pgYlIqWwfrRjJOeR4ZsEIbm5c+s5jxjT1ATKpOCk8smhbRAp+9Wi2bQsML4+fcZ0SqB8LT7rVO4tyNQOsC3dSaRu+mHwM5qUTR790wyLf9P+zo=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by DM5PR11MB1868.namprd11.prod.outlook.com (2603:10b6:3:114::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Fri, 4 Mar
 2022 09:34:49 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::4cec:634:7163:c4c7]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::4cec:634:7163:c4c7%5]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 09:34:49 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <michal.simek@xilinx.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH] mtd: spi-nor: Introduce templates for SPI NOR operations
Thread-Topic: [PATCH] mtd: spi-nor: Introduce templates for SPI NOR operations
Thread-Index: AQHYL6sXY/7kSmK8TkCTUnmKCS036g==
Date:   Fri, 4 Mar 2022 09:34:49 +0000
Message-ID: <c4d0846f-2592-1a4f-bf33-dcb3f846ffaa@microchip.com>
References: <20220304093011.198173-1-tudor.ambarus@microchip.com>
In-Reply-To: <20220304093011.198173-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c08b97d9-ee98-4b6e-8621-08d9fdc23a6b
x-ms-traffictypediagnostic: DM5PR11MB1868:EE_
x-microsoft-antispam-prvs: <DM5PR11MB1868EBEA77A20E9D4A6E46FEF0059@DM5PR11MB1868.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d5Rr/16LDrtyyltykdMIcrvQtpR3arYUe6QKQ6nQCDVMSsy9QJT31vhUbBHiX4z1Wug7/i0GLKC4TM1cGRcKNpzssjc874tk9UZiBELBgU2B+r9srOdYt12d7GB/IsefOqZTPo6b1v1TQ/VA1fHOZjFvuTHlsS5fRs8EEvTPD/rwDPQWqS7BSnqWOhAa1aMgWbyzpEI49QdmZJp330p3xU11kgqsugP3ygeVGaTU+dieV7SHfbIReb80FfF7uMn4sy64dIyRCf0tR1SzIg4m9sFetBGIhvn5+v47vXWak81VT7SKuwesArsOoj4Js38kwrP8hvdTB9/43u0kEm8FU2yomketF88LWaJAm/OC+qmXbMokqTN2/3u2ribtPuZjjw3JoBbfgfCLlm5le1Sp1mydDho6EGBQf3KsS7Oo1RDeLXNeHiyOhBhgCcBn0qJu45hsepLy70naetBUDOJy6OTgcsAkwkXQ2wy7kFYzG1jTU9slK6ZcHVn+nPK4ceBMOaMvUmRps8/VhkbT4CvpBWMHnfPtYgzEY1VSQNSyIEoW5Gj9zRRD994QxBkehcq9/bFPD6YF2u+e3T4WaePk/GNdaZoZg7Nu6swLT7krD/i2fQlwUvB7I3kZ8ohUaScyZ2x1k6IQPtjn59HIOpBuHddZPBda2bmsgCq0nPjxO3aVEB7pCLPkLiI7qDRUmL8W0A/DXs1/PxrsX+QLQhzF07buov43h8NyYxfYOAsAIFpeaUfq78aOMQkPa7Mu/pCeuWqqb3WWLVQBJZcpuw9qceUjifV7v3JBlbKQqXe7rHUgI5Tnc95ul3QGz394Z/VeQsQLZ6ah76/3pySBMrI8UJk+0sr00Kr0iiaFdHAC3YM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(76116006)(966005)(316002)(4326008)(8676002)(6486002)(2616005)(64756008)(38070700005)(66946007)(91956017)(66556008)(66476007)(508600001)(6512007)(66446008)(71200400001)(86362001)(31696002)(6506007)(54906003)(110136005)(107886003)(26005)(186003)(122000001)(83380400001)(4744005)(2906002)(31686004)(8936002)(5660300002)(38100700002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlhFS2llQVg0U0p3ZXZ5U1JwN0Jta0RZRUhjL1BnblRsa29XSlNhbnAyZ3NH?=
 =?utf-8?B?Q2NYOWc0UE1NTGYySjJzNzBwdVg1b0dzUXBBZEF3MU0rUWlvdFREMU9GbmFx?=
 =?utf-8?B?YVlZWXFHbENCVzB6OFgwRHRqbk5nbTQrUVNaMGExOFJFTzZha2RvZzNTaDVu?=
 =?utf-8?B?alhackdTS0prUERKRThBRjYwb0xYRW1TVG55VnJaMEN0YnUrcDEvUkE0V1d3?=
 =?utf-8?B?cDZMbHNSanBrM0kxSGdhaWdsWjdGbzNRTGpuTkw3R2c0dHJLNTNiS3BqU1Jr?=
 =?utf-8?B?UDN3M3Z6bUFEWlppdWZvTVNSdUNEMWxMbjVVR2VsK3ROcG8xNS92SFRPRmFv?=
 =?utf-8?B?eTZMU0NHT2s3YkR0U1dHTlhZRG15dmsxaTQyNU5MVXFkYjRrMnNpKytXWm9j?=
 =?utf-8?B?emFIbWExSHphQ1JQTVNzWmVVcHpUdTA0cU9vZVk4OWI0OHpJSGJmZk9IYmVK?=
 =?utf-8?B?NVN1cnlQSzdGbHdVL3VwZXo4T1czRnpQdElBU3NnSFFNVkV2elhoaXhkbmVo?=
 =?utf-8?B?bTc5QWpYd2JvK0RRNmdRWjVZWGk5ampZc3NyMWZLN0lHMENWak9NNnR0amRE?=
 =?utf-8?B?UTFnZWxRWGl1VWZNTUswd1ZZMzdzdmZHYnpQOWRVb0NUVy8vTTErQkRYQ0xX?=
 =?utf-8?B?WS9SQXpHOHpVMzk5RUgydGR3QUZOWUJ4NVBVSTI2NVM5a3RtWTF1bTk1b0F5?=
 =?utf-8?B?VmZBZDJ5UXJtQW9zbU9BR0FhMVRGQW1WL1orNDRDcFNUeDJaUkNsUmhlaFZu?=
 =?utf-8?B?OS9oSHBDazdTaDRpallpdmQ0MU85NXkzZkRQemxEQlNZUVhnY0ZzMmhOK3d4?=
 =?utf-8?B?ZW90NnIvVTVsM3JJV1ZTZVVTajZjUnlZUDB2Nis5dmI3WFhESGo1SUhqUkZU?=
 =?utf-8?B?azJMTzVGb3Y4YzUrcHhLNENveVpkSitWVk00clU2YjFZYkM4TTZ3b21IQ3E2?=
 =?utf-8?B?cHlBcTNHdTIzY08xTjA2T2FwUzN5MEx1RGwyUFZmTW9FNU1WYVU2SnY0M2Mw?=
 =?utf-8?B?L0RybVRadnptVm15L0ZlM2lIUG1KcWFkdFUzdjdscWY5ZnlKdndqTTZoZWxK?=
 =?utf-8?B?clZDWWE0Y2M1UitrSzJ2SUFCOWNEek0vUzVYY1l2K0hUOXV1ekJzSnpJb05U?=
 =?utf-8?B?Rkl5Mkd5Um5JMUpTdloycjBZbG5Ya01RMWxaRndWVVN2akNONkpPWnRFamZy?=
 =?utf-8?B?T1Fyd05QR25DbzhPUi9UM0YvYnFWWUsvR1RuSHlvdDhlaTdGL0RUamZ0TXdQ?=
 =?utf-8?B?KzNkaUNlUmFBSktwcHNVWDhONU5tOFFOeE1DTW1XL05nZHlkWVlhWm5HbkN6?=
 =?utf-8?B?K2hCUml1ekQwYmdaTzZVN2l3SXJvS0g5M0RFMGJTQ2w3b3R3Rm5JUGJWSUlC?=
 =?utf-8?B?TEhFNURmeDJlMU5XSmdhNE9oY2QvTVhIZDBDckY5Rnl6TVRrR0FHVTBlYTBQ?=
 =?utf-8?B?VTc1eHRWd3JWUU11dVRSRVVhRkphKzhsZERjYUVHL1BTbzJuYTJZT3pKWmtq?=
 =?utf-8?B?c0phMUgvRTV0K3RvdERVaHJ1OWowT3V5WTVnRG5DWW9Pd2xvbVVEVzR4dml2?=
 =?utf-8?B?NkNSa0YrdVliWnRpSDBaak9OSTBkN29EZHlkTVA5c1BCNW5CdGNpdkRvQzlw?=
 =?utf-8?B?RGd0OVhibU9IWHZoMFQwbnFOcG1NaXRCMmN4eEhXaE9oNjhpM3JXb083UTMr?=
 =?utf-8?B?bmFQbjN1Q3ZRMmVuZ0FhZTM4SHZLbzIyUTNlVWhja1pNUFk0bmF6UWtiTUZS?=
 =?utf-8?B?enplVXpHTjY4Zm82aGdiTnlINGtRQ01JWnVqOWNKeDRpT25EaXJKMXdhU2xY?=
 =?utf-8?B?ei9ZejdZVnlXWDVSSmdvODJVK1lsUmRDQzVJb2d5ODd5UHdxdnNVR2J1b2pw?=
 =?utf-8?B?Y09qUzFxdzNFSDk5OEhSYUppcDVhN1JwVGowSFRmbWhlVUk2K0FJR2hSdWZB?=
 =?utf-8?B?bnpGcHB4MDdoNGtuZDJXMEpMcEFGUVVXaUVrUklsbEVMOWdwUTRIWlpEc3Jr?=
 =?utf-8?B?RkROQnhCN0p2eTZ6a1pNc2M3WndDY2ZiZlpkRHJ0d2Jqc1VacTR1d0g0U1Vw?=
 =?utf-8?B?YnFBYm9iVXBrakJjaHZKZDRDSndpRWNaVm1vM25aMGJEeHNydjkvT1gvWG9u?=
 =?utf-8?B?dG94NnFjbkdjcjN0RkhyaDByZFVkODc1TmRXOXZaVVpRYzJtV2o4aVNSQmJh?=
 =?utf-8?B?MUtRYUg2azFEaTdtNHptSzRVRGkzSXU1UmZPYy9SYm51d1NMQ05weU1zakFJ?=
 =?utf-8?B?UzBJTGExN25RRkw1ZVpVRHNVREZRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5182FFF0BAFB1D42A7169F32B1278B80@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08b97d9-ee98-4b6e-8621-08d9fdc23a6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 09:34:49.4462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OOTJxupYW1XwJai/3J/msCUL7+IUgSs1+Wc74d+s5dTN5OSismJwtJGe3h9PnE8ckAJIQL+roShJ232xeWpe4fiGClUptXbkVQp/YnKDQwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1868
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SCC_BODY_URI_ONLY,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy80LzIyIDExOjMwLCBUdWRvciBBbWJhcnVzIHdyb3RlOg0KPiBDbGVhbiB0aGUgb3AgZGVj
bGFyYXRpb24gYW5kIGhpZGUgdGhlIGRldGFpbHMgb2YgZWFjaCBvcC4gV2l0aCB0aGlzIGl0DQo+
IHJlc3VsdHMgYSBjbGVhbm5lciwgZWFzaWVyIHRvIHJlYWQgY29kZS4gTm8gZnVuY3Rpb25hbCBj
aGFuZ2UgZXhwZWN0ZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRv
ci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9j
b3JlLmMgICAgICB8IDEwMSArKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICBkcml2
ZXJzL210ZC9zcGktbm9yL2NvcmUuaCAgICAgIHwgMTAyICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL21pY3Jvbi1zdC5jIHwgIDI0ICsrKyst
LS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL3NwYW5zaW9uLmMgIHwgIDI2ICsrKysrLS0tDQo+
ICBkcml2ZXJzL210ZC9zcGktbm9yL3hpbGlueC5jICAgIHwgIDEyICsrLS0NCj4gIDUgZmlsZXMg
Y2hhbmdlZCwgMTU4IGluc2VydGlvbnMoKyksIDEwNyBkZWxldGlvbnMoLSkNCj4gVGhlIHBhdGNo
IGlzIHdyaXR0ZW4gb24gdG9wIG9mOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIy
MDIyODExMTcxMi4xMTE3MzctMS10dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20vDQo=
