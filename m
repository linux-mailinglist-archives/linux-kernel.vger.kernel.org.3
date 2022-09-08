Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0191D5B161B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 09:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiIHH7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 03:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiIHH65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 03:58:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE7CC7BBC;
        Thu,  8 Sep 2022 00:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662623931; x=1694159931;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=1af6S0WWC8doZDKNzWamhC1g+6g9zju1b77tpFT+ULM=;
  b=jz4pw+nmDKCxLcEz6ynF0z3+aS2J2Inw2gz1cjRDZibV0/m4wIqHhC4b
   h/faI26BSvuKj1LnykK1Ghy01y2S5w50SqK38BmZ7G+h3bxfXiWJEc3T1
   i+QmkuH0uUhGkO//qXB1giPpq15AY17pc/7ugmfBqLziOlgZQg949CqYz
   20LFB6Oe1maVC00ViyGWlPjOrII5azwRFSMiTKJrGlemonTUxjAi5Tx4j
   34gvI2Wp/8W6iz07pEyK+tb6wieBjfwsnCjr2SYmYS6EynW3BNnO5OH7t
   cEP1+b6qTjVwAa7Y8Ib+OPNvid7qEBu0nuIChgjhxdXV9cWsOOPpVs8aP
   w==;
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="172908432"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2022 00:58:50 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Sep 2022 00:58:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 8 Sep 2022 00:58:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPWBHLReV57ha8yW2mk22pmqFAszsrT2RszOcBeqxKWLr75BY/DtBQfKozd1c7fL7WgN1P1ctHJ7JxYoCBa5MDSUP8PJ51sevXUocIGb65DzDqKZG21rBydbUIxxSF7sxmiqoPeGIFM7KSWaAv3eAJNaCuT2SafJQL7DJlTf1/S9oY/nc+nT2BJkCaA+hDN9ffCwQxMdudPWpADqyemkpCa8ntOUFsZAaE21jRZPWPji55vTiVtjpB8zaCetlTdsuhS/d1dLO6A9CJe2M5H0IqDPIZQ8aguygRWVf+fQljH4GFYQD2JUqR7lvVdUkcH3afISH0ji9YKpDGrAsdtbpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1af6S0WWC8doZDKNzWamhC1g+6g9zju1b77tpFT+ULM=;
 b=Pd61+AYZrOMroZEfstbT9Ot9vTa0u+vfbqOn5w2feUol6DwdwvuUqIPbb7O2fY7cVGz2W+rDHM80jPPehzcXtevF919krzPp0WZBCZ2NWOORrdSVY3O7xgOYG2tMBbMySHc9Lsp5rZH1eV0vd//iGWhknuDtT/2c0eRarMZKX5Q5u9B5Oyv4ejV6JQV0DLO59LVTLTRLXhCIgCTWuobt0wY++NfgomIVFRu54O1kdLXS1Sl0Sg7sZQSbvtoY6Zw318G6gUadupiybWov4GV2Q1dGS2TkINaznB1hNJbWBZQ6060Au7jRwGjJ4yBcBN1ixwEG/vM9ebFqyBQ9s9kkmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1af6S0WWC8doZDKNzWamhC1g+6g9zju1b77tpFT+ULM=;
 b=T0+3IbQ+O4SoCC00uWmpc2fMVG5W+YJGkVBUFuSkZmLn0LUFt0V+IzMYzul4tgqP0FB0ozXEpVpzY1hcqpmK4ZQ7N0Fanjbtu2Sguq3hEQGs0N544UQFlFZ5K8DHPWBB2FhjV9Q0aX0NeHy83vDCulHcVQ3yCok2dLGWoi8C2JQ=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SJ0PR11MB4816.namprd11.prod.outlook.com (2603:10b6:a03:2ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 8 Sep
 2022 07:58:44 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610%11]) with mapi id 15.20.5588.014; Thu, 8 Sep 2022
 07:58:44 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Hari.PrasathGE@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <davem@davemloft.net>, <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.belloni@bootlin.com>, <arnd@arndb.de>, <olof@lixom.net>,
        <soc@kernel.org>, <Manikandan.M@microchip.com>, <michael@walle.cc>,
        <Horatiu.Vultur@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Durai.ManickamKR@microchip.com>
Subject: Re: [linux][PATCH 4/6] ARM: dts: at91: sam9x60: Add DMA bindigs for
 the flexcom nodes
Thread-Topic: [linux][PATCH 4/6] ARM: dts: at91: sam9x60: Add DMA bindigs for
 the flexcom nodes
Thread-Index: AQHYw1jQu8SZvsnDy0mAKgZeTljtUQ==
Date:   Thu, 8 Sep 2022 07:58:44 +0000
Message-ID: <3a26d5a6-49fb-85c2-def8-d08b8f0842bc@microchip.com>
References: <20220907092054.29915-1-Hari.PrasathGE@microchip.com>
 <20220907092054.29915-5-Hari.PrasathGE@microchip.com>
In-Reply-To: <20220907092054.29915-5-Hari.PrasathGE@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6168856-e0ca-44fa-98d4-08da916ff3a3
x-ms-traffictypediagnostic: SJ0PR11MB4816:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FL27TZtJOPQAoldqg7V4LYtv45ktXgZb5g1nnGF5hc7eqqPOX+EvuEM02cnU5BKvkfmaW0XVcj/IAiyJBX6hEXOAKe401WR/W9PhHEOMjFK1TOv6xa9gJDEvrpf6hXEGcIIi/eW/uDvyEF5j7BJnjb/V9hL9j7Ok78b5ldtLAI4iN/zoQWXshgXf9hOI54uZMmk2hvQCWtZzSPGr3t2GPjuoiXaF91ju+z+5MY+qcqfjdmbWHRuGdXABNs5YTiTv1rxBx/NxP1s4n3a7pE2kR4ko9QkFBMTzc0ZrIRKsgSa91yWPSUpdkEQi2rP2sDUymDm2pKl7JhbCsCg3y73wokGdOMTAu6VaajTfnW9Qt6MVCz088Sr7GE8ig/MG25HiCxXJ+Fsy4oF4cw8epGmGESwJwkSpgFt76ah6OtN4VpXEc/nCGP9G+hIRE80uLu6xVjHrVMDaWEBJOcZhG9pmDZqrvmgVTUJBQ4X8YBmIWDrlwo7efG/a5gBhc10dNXr8n3nxxSbvDLz8ZU4WOxhRcasHU1GNPsQAibDltU8AHL39iJcKhNwgay+y3i+gBYqQmSwLmGsI2jYwzC1OrPcP5gYfV1u5W62zLQivkQQvpJmKfXMYGZQPqhhA2WtZbeLHW/wVecQyhVH5sW+IohJWpWixfZLYFbMJaNo9L3X36jf16EM+j5mLfFQQNh/wh0m5PTIP38XOCHvd866ZcyLkabLWfYFntudqPo3aSGknKDA8Tl5wcHG9G+9KK/Vrx5WWJOKJD9efvaaGG4sAbp5BwovQrMAZvSSmFh4PPP26g3wEU6Lu1JvWjKJEd4UPYeCGc9PlyUI1LWi0BaHvJJtblKYUGXNAP1wj3XF80lQQtlg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(346002)(136003)(366004)(186003)(26005)(53546011)(71200400001)(921005)(31696002)(6512007)(6486002)(86362001)(41300700001)(478600001)(122000001)(2616005)(38070700005)(83380400001)(38100700002)(6506007)(316002)(31686004)(2906002)(66556008)(8676002)(66446008)(6636002)(66476007)(66946007)(110136005)(7416002)(64756008)(36756003)(76116006)(91956017)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REhKQ3RDRmkrdHhaRGV2T1k0M2UvVnFrOG15di80dzB0UExMaEFGZjVTMHB1?=
 =?utf-8?B?enBudTJrSWlIM0pwY0lhUE01MFFJR2RZcnNya25Ia0xoTC8vN00rQXJ5clFI?=
 =?utf-8?B?M0dWM2pjT3psOVBlWjRkVXNSTVltbDJmYUhpYUFYVXB4d2w0RXNCSDdnM3Y2?=
 =?utf-8?B?czBxNzNvR0Z4VFQ1RldNS1ZtaHJ2UDNBd1oweXBBT3NyeHpUUFZjZGZtQU5G?=
 =?utf-8?B?SnQ0S2NSVzFvVThFWnRud3MzZnNLbXErZXUvb0ZzTXFtZGxXcjFSS2IxdStN?=
 =?utf-8?B?VkpsQWlZcEhLSjJNRGY0UUIrWVRmQlpKZ3pCcXVMZVhacEhmMUdhdXNzSnRy?=
 =?utf-8?B?NzBqSE5xQXBwT2drZW1zZzFDL0s2dmhMUzBpZ1VSOFhNK1U1and3ZHFFVnVt?=
 =?utf-8?B?eE1XbDFVWHBZREI1b1phMXIxc0doTThXcGYrR2ovdk8wZU1sTGFNNEhXZ243?=
 =?utf-8?B?UFFyVGpCME1vSzZVaXQ4b1ZDcWE0aUZCeXdLOHJyNmVrR3NlS0pIcXNXMWpK?=
 =?utf-8?B?WEVqbVhiWWZwT2lDQ0IrVnVoVHRLVC95T2NDVnBBVG9uZXVCNmtjRjhLanRh?=
 =?utf-8?B?ZVJLdFRNaUROalRSU3pHY2I4eERFbHpJVDVURG9PMktOVWRkaGVtSjk5WStX?=
 =?utf-8?B?bTIrVXpQUERJOW1GcHFWclg5M05TcVA5UktuNXNyczgzdFphcEFlbHFvdlkx?=
 =?utf-8?B?K0hzQzZCUEN1bXVwdklVNUpSNEV2ZEl6SzZPOVIvOVgzaFVJSEtOamlpMmJF?=
 =?utf-8?B?T2xhTktVamN1aUpkTU1VUERLT0ZTZTNMbUhnQVRpOXdwWlpSSjE5RThxRmpO?=
 =?utf-8?B?ZDVidkdJUmNQZjRQWFlkV1o2N21CTndmRVZPTWxBTzFYODFjQ2NzZm9NQ2RH?=
 =?utf-8?B?clRVbzFRQ2VBUVZXZExJdFFOZDJTZDVzQmtpUFlkbWNaSVJGajNGNzhmZmg2?=
 =?utf-8?B?WVcrbGNlS3NGQ1hFNWE1T0hYeTdYbS9nQzZ1cUhQK2FWZ2ZyTHlaREhPSVhL?=
 =?utf-8?B?Y0dnWWhRWU5JWkZWS0QrTktLYUFidTJJWWtxVEc3OENnWEJ5d25yaERKc0Nz?=
 =?utf-8?B?ak11TWdjVi9jSmVTeGNreXZaOEFsdHBVQTRmOEdaRS9vN1paY0Q5OWluQkJU?=
 =?utf-8?B?MkNmdjQ5YUpvbDBpajFTaWIrMG1CSWw0cWlua3EzbGhhbXdqbDFOM3grL3Y1?=
 =?utf-8?B?R1I4QS9mZk8xbW5LZy9ySDhSZkRHZ2JTZWx6WGFMMUNmUkRlYThwbDJucTNo?=
 =?utf-8?B?OVI3TXpCbVdZY2tTVmwzWk1XMjExQzFFaWhqSDR6NDdvT1FEazRod0IwS2hD?=
 =?utf-8?B?cmJDcFpVM0NBYmFiQ2RtVWlZenEwc2R6NXU0TGNlK0Fack04RCtuRnNwek0v?=
 =?utf-8?B?NTZEUFcwWkovOHlsUFhwbmV5U2xMWjByN3YyeTh5aGYyNkpWWjd1VTErMUto?=
 =?utf-8?B?Y29TMWZTVlh4ZWhUd041bDI1YWdYL3VGRndySjlVY1g1ZEZQU3poN3hKR01Q?=
 =?utf-8?B?R094QUNtZUgzSm9rY2FxOXZYemF1WUJUOEN6U0hZQTBjTlVkQmt4OWozdzJ2?=
 =?utf-8?B?eXFta05NMDVkNWEyQUk5WGhUSDZTU2ZnSU1Td1orU3JtZVNJSDV2RnJ1a3JZ?=
 =?utf-8?B?dStVRWxqamJ6R2tZYUk0eGhMMXZWbGNoSGVBdERVd2JtTmhBcVF4dnRSaUhL?=
 =?utf-8?B?ZC9DanVIQ1JYSWZBRWc1aUF1dWJCSUp0anZKSktLdG9XRmkwaTlqamV3YnNU?=
 =?utf-8?B?djljbm5EaXFWVWIxUXd6N0tQTngwbWliakc5UXh4SlhENmU4M1hvWE5sL0Fp?=
 =?utf-8?B?WC9HU0dSZDcxdzVWaGhHb1M4Qk8rSUhKYzNpREtCNDFrK3p0OWJCKzA5anZV?=
 =?utf-8?B?OWw0dU5vUFBQSjZueGdZZis0a0lGOTk4MHgvaEhGT21XMmpnTk5QNGNKUmM0?=
 =?utf-8?B?c3VDQTczcDVRZmxNalVRVllPaHVBd2RiNjd1QVV6MjZncDJ2bjZjaEtsbkEy?=
 =?utf-8?B?WHFuVFVIWFAramRxUWZneDhvZzVnVkl3eGNSdEF3UnhKVkdGZTUwNHB5aVUy?=
 =?utf-8?B?WDB0aXZkN2lsS0pVckVYSTMxNWRPWEVxMzNJUW14NWNDSUNmVWlJZVUzS1lK?=
 =?utf-8?B?K1RvZVBVby9TeEJhRE16by9IdGlYbjNqYXd5eFBsUEJ3ekNhaTZqMWgwMytK?=
 =?utf-8?B?VHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82511D91602B0741A4F21594913A2220@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6168856-e0ca-44fa-98d4-08da916ff3a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 07:58:44.1172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xdWjRgZsZof3dIIleS/ECmS99U9DcC7lImL2lOredSM4VXBz7YZ2pwjzbEDjquZKCwuDUo4/oVPvfPSSyzwoORmssgSp55L4J+YW/41eoT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4816
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcuMDkuMjAyMiAxMjoyMCwgSGFyaSBQcmFzYXRoIHdyb3RlOg0KPiBBZGQgZG1hIGJpbmRp
bmdzIGZvciBmbGV4Y29tIG5vZGVzIGluIHRoZSBzb2MgZHRzaSBmaWxlLiBVc2VycyB0aG9zZSB3
aG8NCj4gZG9uJ3Qgd2lzaCB0byB1c2UgdGhlIERNQSBmdW5jdGlvbiBmb3IgdGhlaXIgZmxleGNv
bSBmdW5jdGlvbnMgY2FuDQo+IG92ZXJ3cml0ZSB0aGUgZG1hIGJpbmRpbmdzIGluIHRoZSBib2Fy
ZCBkZXZpY2UgdHJlZSBmaWxlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFuaWthbmRhbiBNIDxt
YW5pa2FuZGFuLm1AbWljcm9jaGlwLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSGFyaSBQcmFzYXRo
IDxIYXJpLlByYXNhdGhHRUBtaWNyb2NoaXAuY29tPg0KDQpBcyB5b3UgYXJlIHRoZSBhdXRob3Is
IHlvdXIgc29iIHRhZyBzaG91bGQgYmUgZmlyc3QuDQoNCj4gLS0tDQo+ICBhcmNoL2FybS9ib290
L2R0cy9hdDkxLXNhbTl4NjBlay5kdHMgfCAgMyArKysNCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3Nh
bTl4NjAuZHRzaSAgICAgICB8IDI3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMiBm
aWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0vYm9vdC9kdHMvYXQ5MS1zYW05eDYwZWsuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1z
YW05eDYwZWsuZHRzDQo+IGluZGV4IDlkOWU1MGM3Nzc5NC4uOWFkNTI4ZTFiZGQyIDEwMDY0NA0K
PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbTl4NjBlay5kdHMNCj4gKysrIGIvYXJj
aC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW05eDYwZWsuZHRzDQo+IEBAIC0yMTMsNiArMjEzLDcgQEAN
Cj4gIAlpMmMwOiBpMmNANjAwIHsNCj4gIAkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ICAJCSNz
aXplLWNlbGxzID0gPDA+Ow0KPiArCQlkbWFzID0gPDA+LCA8MD47DQo+ICAJCXBpbmN0cmwtbmFt
ZXMgPSAiZGVmYXVsdCI7DQo+ICAJCXBpbmN0cmwtMCA9IDwmcGluY3RybF9mbHgwX2RlZmF1bHQ+
Ow0KPiAgCQlpMmMtYW5hbG9nLWZpbHRlcjsNCj4gQEAgLTIzNCw2ICsyMzUsNyBAQA0KPiAgCXN0
YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICANCj4gIAlzcGk0OiBzcGlANDAwIHsNCj4gKwkJZG1hcyA9
IDwwPiwgPDA+Ow0KPiAgCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiAgCQlwaW5jdHJs
LTAgPSA8JnBpbmN0cmxfZmx4NF9kZWZhdWx0PjsNCj4gIAkJc3RhdHVzID0gImRpc2FibGVkIjsN
Cj4gQEAgLTI1OCw2ICsyNjAsNyBAQA0KPiAgCWkyYzY6IGkyY0A2MDAgew0KPiAgCQkjYWRkcmVz
cy1jZWxscyA9IDwxPjsNCj4gIAkJI3NpemUtY2VsbHMgPSA8MD47DQo+ICsJCWRtYXMgPSA8MD4s
IDwwPjsNCj4gIAkJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gIAkJcGluY3RybC0wID0g
PCZwaW5jdHJsX2ZseDZfZGVmYXVsdD47DQo+ICAJCWkyYy1hbmFsb2ctZmlsdGVyOw0KPiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvc2FtOXg2MC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9k
dHMvc2FtOXg2MC5kdHNpDQo+IGluZGV4IDIyNGI0MDZjODM4NC4uZmVlYWJjNTNlMGVjIDEwMDY0
NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9zYW05eDYwLmR0c2kNCj4gKysrIGIvYXJjaC9h
cm0vYm9vdC9kdHMvc2FtOXg2MC5kdHNpDQo+IEBAIC0xNzYsNiArMTc2LDE1IEBADQo+ICAJCQkJ
CWludGVycnVwdHMgPSA8MTMgSVJRX1RZUEVfTEVWRUxfSElHSCA3PjsNCj4gIAkJCQkJY2xvY2tz
ID0gPCZwbWMgUE1DX1RZUEVfUEVSSVBIRVJBTCAxMz47DQo+ICAJCQkJCWNsb2NrLW5hbWVzID0g
InNwaV9jbGsiOw0KPiArCQkJCQlkbWFzID0gPCZkbWEwDQo+ICsJCQkJCQkoQVQ5MV9YRE1BQ19E
VF9NRU1fSUYoMCkgfA0KPiArCQkJCQkJIEFUOTFfWERNQUNfRFRfUEVSX0lGKDEpIHwNCj4gKwkJ
CQkJCSBBVDkxX1hETUFDX0RUX1BFUklEKDgpKT4sDQo+ICsJCQkJCQk8JmRtYTANCj4gKwkJCQkJ
CShBVDkxX1hETUFDX0RUX01FTV9JRigwKSB8DQo+ICsJCQkJCQkgQVQ5MV9YRE1BQ19EVF9QRVJf
SUYoMSkgfA0KPiArCQkJCQkJIEFUOTFfWERNQUNfRFRfUEVSSUQoOSkpPjsNCj4gKwkJCQkJZG1h
LW5hbWVzID0gInR4IiwgInJ4IjsNCj4gIAkJCQkJYXRtZWwsZmlmby1zaXplID0gPDE2PjsNCj4g
IAkJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gIAkJCQl9Ow0KPiBAQCAtNDE1LDYgKzQyNCwx
NSBAQA0KPiAgCQkJCQlyZWcgPSA8MHg2MDAgMHgyMDA+Ow0KPiAgCQkJCQlpbnRlcnJ1cHRzID0g
PDkgSVJRX1RZUEVfTEVWRUxfSElHSCA3PjsNCj4gIAkJCQkJY2xvY2tzID0gPCZwbWMgUE1DX1RZ
UEVfUEVSSVBIRVJBTCA5PjsNCj4gKwkJCQkJZG1hcyA9IDwmZG1hMA0KPiArCQkJCQkJKEFUOTFf
WERNQUNfRFRfTUVNX0lGKDApIHwNCj4gKwkJCQkJCSBBVDkxX1hETUFDX0RUX1BFUl9JRigxKSB8
DQo+ICsJCQkJCQkgQVQ5MV9YRE1BQ19EVF9QRVJJRCgxMikpPiwNCj4gKwkJCQkJCTwmZG1hMA0K
PiArCQkJCQkJKEFUOTFfWERNQUNfRFRfTUVNX0lGKDApIHwNCj4gKwkJCQkJCSBBVDkxX1hETUFD
X0RUX1BFUl9JRigxKSB8DQo+ICsJCQkJCQkgQVQ5MV9YRE1BQ19EVF9QRVJJRCgxMykpPjsNCj4g
KwkJCQkJZG1hLW5hbWVzID0gInR4IiwgInJ4IjsNCj4gIAkJCQkJYXRtZWwsZmlmby1zaXplID0g
PDE2PjsNCj4gIAkJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gIAkJCQl9Ow0KPiBAQCAtNDU0
LDYgKzQ3MiwxNSBAQA0KPiAgCQkJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gIAkJCQkJI3Np
emUtY2VsbHMgPSA8MD47DQo+ICAJCQkJCWNsb2NrcyA9IDwmcG1jIFBNQ19UWVBFX1BFUklQSEVS
QUwgNT47DQo+ICsJCQkJCWRtYXMgPSA8JmRtYTANCj4gKwkJCQkJCShBVDkxX1hETUFDX0RUX01F
TV9JRigwKSB8DQo+ICsJCQkJCQkgQVQ5MV9YRE1BQ19EVF9QRVJfSUYoMSkgfA0KPiArCQkJCQkJ
IEFUOTFfWERNQUNfRFRfUEVSSUQoMCkpPiwNCj4gKwkJCQkJCTwmZG1hMA0KPiArCQkJCQkJKEFU
OTFfWERNQUNfRFRfTUVNX0lGKDApIHwNCj4gKwkJCQkJCSBBVDkxX1hETUFDX0RUX1BFUl9JRigx
KSB8DQo+ICsJCQkJCQkgQVQ5MV9YRE1BQ19EVF9QRVJJRCgxKSk+Ow0KPiArCQkJCQlkbWEtbmFt
ZXMgPSAidHgiLCAicngiOw0KPiAgCQkJCQlhdG1lbCxmaWZvLXNpemUgPSA8MTY+Ow0KPiAgCQkJ
CQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiAgCQkJCX07DQoNCg==
