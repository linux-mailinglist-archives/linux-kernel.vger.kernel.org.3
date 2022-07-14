Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23330575071
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238601AbiGNOMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbiGNOLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:11:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535754C628;
        Thu, 14 Jul 2022 07:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657807912; x=1689343912;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FLcVrFHBIj6QVofQXzDohIFa+PlIiJd2U5ofGyYW8Sw=;
  b=FVKVl4kCPFARLpS4jf6LslFb1vioKw9nG3DI412eE/zFk8i0cPeCkDoz
   /KVTeJRFCCN9JfO3NvUuGGmBSZd1Mb8VxV8U92bzZ4ZsV14KOtGXrK6xA
   EhpbaAnH23ZrUJQQ8JjTUPP1P8QyyNqwxbYYCQiGFjmBnBknIotJQSNnV
   Y3Coka6dDHzFvA1oizukThANSAG+BXG5Jku8HpQsRVPG9H9sBH9ZzXn5W
   J/1OHIsDGL0LN7NfNLT9Bd0ai26LtUeahbMk0YsnZbwRTHQ2CaJ/jRenW
   8jSRuz/BnrP/FGNOHFO7fhpR+d69KW+z9ewD8mDKgiYAFU5a/HeOBfml9
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="104470265"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jul 2022 07:11:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 14 Jul 2022 07:11:49 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 14 Jul 2022 07:11:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmun8QEhKNU2wzFv0CLpS+srb0CleUVQxW8Q3aTdOl4jjqPP1J0T5bqOAadkjnTEjzlWXDQIb0XraF8CXaPHYS2XgOWB6Agy6ks2lXMusSpVEj0vGKpQx3taXNjC1MpD40NN8avoWF5uHQjySQfDxEBguRuRDQRKkhjxS7TokJIHOS78bWGRnzm+uVZFczc/G+ouNletZNrTMGtwdRTXJrp1iaSHSA/lYPU4exSgnC2psO6INEAo/lRJjoMPE61vY9PLoVTYcNDLpxi0Qb5XP51Nt+1dNTTzQu3D95cjiWk00XwwasWsYdhAIPwtKcTKvyB8/uSZvpWZWiJx1nfo/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLcVrFHBIj6QVofQXzDohIFa+PlIiJd2U5ofGyYW8Sw=;
 b=gDYp2v/Ytswq4zgSzmDdHQ252SmS58drZ0K8S0V3k3y8mwWjarZBOgFBKov35fMBAs3hrjv+OigvsDUB+kqzzOt65oDBdJXkO37hd6T3f6Y+fFEvT42eHuP4s3W8KItpbdojfOghekcd8OF2dHAr5mvnJDIqZqHQU3/UXJ1rb+hN8WvrOjqV6sf3mleJAv26Qxw+4rM6op+Flr24BVopvJINl3hPs5l5VSrjhcHATPPBeeLK+mKu95ezLlLS90q6pK5godVQJFtNtjgjR9ZW69g521LQnBm4YZYWFoOvjO0Ee1cVFEqqIkkhIllUYJ2ztEZBQ3RnvCANAbxfgXTz7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLcVrFHBIj6QVofQXzDohIFa+PlIiJd2U5ofGyYW8Sw=;
 b=DX/rQBS5EMyU8FpMKK7ZlBZFzaY8H7ZpYu4IebTONEvw3ibe0YWcQQkm/gfzg8Vl2vJigcTvYwwZSvA0c3aYSyBHkXTxyz96m26gg0DPvZxZxdQZ2nrfiYC0QeC9QmKqB2lE1qMVIE9cWUnR7DnWcjBhGCeZnST/CBwkWDC/d7I=
Received: from IA1PR11MB6467.namprd11.prod.outlook.com (2603:10b6:208:3a5::18)
 by DM6PR11MB3930.namprd11.prod.outlook.com (2603:10b6:5:197::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 14:11:43 +0000
Received: from IA1PR11MB6467.namprd11.prod.outlook.com
 ([fe80::9063:e12:7eb7:b7bd]) by IA1PR11MB6467.namprd11.prod.outlook.com
 ([fe80::9063:e12:7eb7:b7bd%7]) with mapi id 15.20.5438.012; Thu, 14 Jul 2022
 14:11:43 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Sergiu.Moga@microchip.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4] spi: dt-bindings: atmel,at91rm9200-spi: convert to
 json-schema
Thread-Topic: [PATCH v4] spi: dt-bindings: atmel,at91rm9200-spi: convert to
 json-schema
Thread-Index: AQHYl4ulQLqN+PskkkS1RdkEMIbDOA==
Date:   Thu, 14 Jul 2022 14:11:43 +0000
Message-ID: <238c756c-fc6b-b30c-f0da-741778579789@microchip.com>
References: <20220713132908.175026-1-sergiu.moga@microchip.com>
In-Reply-To: <20220713132908.175026-1-sergiu.moga@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cdf6e08d-f58f-4fa3-e557-08da65a2c7b3
x-ms-traffictypediagnostic: DM6PR11MB3930:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rz+rOeG4F5ForLlgbmnTiylY4sN9m/BsOomzeV/nZ4yjtctKcuQW1MzuzTRT7dJq4AcvQpqk7O50WOtZ/7lKC27q4By76sGOrN0vqNELjX8YOaG398l/Au/UmCffBOiWtPRRl+nRWvGfHS/vAfJNsKsVFCx24vRiXlyE4so+G7VZAgklrbpdnKeJMz1NqGXnvOSsYvaZQSMDqH++xPiReLP55lpr6cXfdbgdB0zA+0oefILiJJ7YXsc+ekQmm1mPsGw1CutiDxwvH0jCPiOSF3RUsnEmb7oRwyGdKXIg/8o0VgX9UJ3qgAqCorFxKCshQaUl3mGAQk9Mzf/7E0lVsNEScH5TbBKw0NF9GEXIzZgjEzCCFnU9c8TPhY0/BhUoV4yVOg4G4GUHVWhffoMix8hlqIimumfyTU5WIHjlMwVy4DNm4tneQDEaLb6/NlRLQTurw6xfPZfEIDfPEezWrDYWMePGUCGEIaXtOSXiHi6UP9m7dSlj9vCl/ERT4osjG+V+wxSsdNu4sWURKZEEsZHSPRjKRutot9vTj0FAq2gZcV8Z3Z5czBv9aZw7AYhRCZRAkG8AYkN1JRGBhQ2NuYCNJbCWDUUn3akwrmxpQaeVNfMKbmU9QOwIEVn3BTVi09skHGqbbYTbOtQ2D6doqcwltkiAd3BJ+NRFrVXp3Ihc/2sZtLtVVvjR/y1Cl6WhPpcnJ6+s8rFozilYTn01nE8jJZP80/As35ZLbh60Qf7gkUDw/10fl8byPHyLiUpzV4EG3aG1iGvKvhf68cNTqIDnjqT2mn+CSNHksP09tGQtuhypr9Lmxgp2iIQuQVb83Wdgv5FglPGIykOzJeAVfVAi5CF4d05zl0305Igg9KEbdJ++cxQojlfAV6Sso1/f
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6467.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(396003)(136003)(366004)(53546011)(2616005)(6506007)(6512007)(26005)(66446008)(2906002)(8936002)(5660300002)(6486002)(41300700001)(36756003)(31686004)(558084003)(478600001)(186003)(110136005)(6636002)(54906003)(71200400001)(316002)(31696002)(86362001)(38100700002)(66556008)(66476007)(66946007)(76116006)(91956017)(122000001)(8676002)(4326008)(64756008)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWsvazhYUDErT0prOUdPV0ZIVENkUEo0RnJsdnQ4WitzNStGZmU5MWJVam9z?=
 =?utf-8?B?dnhraVNzanNOdkF1cG53OE1Nb1hSdmxQQ0tsQWorL1JRRHBHU0FrQ1VTL0lj?=
 =?utf-8?B?dDJKakNaZlBBc1FnREVaem1EaUwzWWJRUWFjWXBQaXNUUlpLcldYVTE0MVF0?=
 =?utf-8?B?RDhCUmVjMmYxaUwwaDlZSkMvOXlmWVVzVm5DR3JYRjBDK0FrcTR4S2t6WHRX?=
 =?utf-8?B?eVNJRVhnYUZZdG0zUXRQckt3V3hZTFE4dUxueGJFSC91UnRUN1pCbnkvTUlB?=
 =?utf-8?B?YTE1RDZKcG90MWpJQ2V5WHFiWnBZUFVZUHhtZFZRclk2dTBpNmc5S1NUOUJm?=
 =?utf-8?B?bWt3UHdMdDEvVUVvRTV0OUk3bC9XdVlxL05VWmtPeFplNjhuNWIyeVZhMDl4?=
 =?utf-8?B?Z2FzZWNsYTVPck9NZkU3NWIyNit3aERTeWNqM2JPVmg0K3FORWI0L1F6bTJZ?=
 =?utf-8?B?RFpkb2xRWk15blRRdmFDODJYK0I4eG5nNHp5Wk4yOVpGR0lSVlIwU1lNMEpL?=
 =?utf-8?B?NFYxZnpYRW9DTjZ6ZDB6Q3hvb1NyNFIxdStqRzBKeGJ1UHBxV3ZLaktwTkFV?=
 =?utf-8?B?RTE0MktMNHFPb2xCY1dlbzRzeHJhU2FKSmh4andEL3hoSHBMMVp0K3BwcnBU?=
 =?utf-8?B?YWR0d3ovNkhVMi9uUnJha3hZYlY5UFBYNjZZUElXaG41ZXkybSs3TkI4OTJB?=
 =?utf-8?B?MFR6a0g0bjRmL014WW9pZ3hqbldKaUpvWHBwVkFUMERnZlZTM3hlS2d2dCtE?=
 =?utf-8?B?TGlMVlY5ci9tL080M21tSUtDbnk0Z04xMHU3dEVJTEFDYWlOV1VrM3UyVWJ5?=
 =?utf-8?B?QzJKRndWWFlwUmJuVVFPdUpqV0VuVTZ6VTNQeGdPa1Z6dStyV1o0Q0FUVk96?=
 =?utf-8?B?YlArUjRkeHg2N0FtMWhGSlFpbnBmNWJjY0V2ellQLzM4Y042UVQ1aEdKZzUv?=
 =?utf-8?B?QkxFdTV1RlBEbW5ZRmxoaHY5NjF3bm9lTVZERzBZY1hHdzJ0clNOVEorNmpQ?=
 =?utf-8?B?K0hWSFJVMC9jVm0yNlJud2NGNXlqWXRUSUZnQithcDdtV05VTGQ0aVFaYmpC?=
 =?utf-8?B?SGFQTUFQcnBHdmF2QWhPeS9iVTE0TWxGYTZvYmV4M0UzbkxkMkpKZEJGSk1I?=
 =?utf-8?B?REZWSUdRam1YclNsblFpMnZIZS9PQ3NjNlc1UlJjWVVsTVhZV291OGxBTFVv?=
 =?utf-8?B?YURjYlQ4NXVxcVliY3pkUmtZM0R3Rm9yNlcyRmZReUs4elNubytIbytDdnZz?=
 =?utf-8?B?RDFVdkZ0WTB2V3Q1cW1MNmNzYjJuRldnV1NyZ295cWFCT1lLS0E2OWtPQi9i?=
 =?utf-8?B?OWg1L0UzMDhhMndRTUFHUkpuSE16NWcvWFB2N3dZYTVYMHRpVGVkc2NXRkhv?=
 =?utf-8?B?WGhZMHNDaHJPK1lqeEcvM3dFK1NXaWJId3FLSDRDM0tFZ0x0dkF2YTRZUjFk?=
 =?utf-8?B?a25EUS9jNEdmVFNlM1VPdzdjbnQxQjFNRXA0SDlPcW03eURKWS9VaWtZN2FB?=
 =?utf-8?B?TTlBNkdEa1VUWlNqWWtqUml1eUg1UmVaekxDNGVDTVhhaytYaE5jUEdEU0Zj?=
 =?utf-8?B?WmNiZEUyZWM5cFpDTm9sem53dGorenV1aUZhK3BQVEpydG9xOEhja2sydHZM?=
 =?utf-8?B?NnV2bjBhQmpDMjZLV2RnM0FkM0Rhdit1bjdGN2Q1MlU1Q1RjR2VzYmc5Mm52?=
 =?utf-8?B?cENFMXRleXQxRm1pZDFQcTBIdnpuT0svcjdpNGlydkg4UGMrYlQvZC9BUHVa?=
 =?utf-8?B?TUpPQWhqc3BRVmcvMUw0MlZHcS95RUFpbEt3UWg0ckxvbkdVczNVUCtEZ3I5?=
 =?utf-8?B?cStaeGpULzRvVUNZSWV1ck4yWVcyTk1ycFAvY3RmSHBGOWVmUnAyN04zVWp0?=
 =?utf-8?B?NE44a1o4Uy91NmNkZUgrZVkyNU55Qit4bWl3Y1hXUWkzc2NlQUFaaXUxWlFt?=
 =?utf-8?B?eUdRRlh6LzJRcTNjQkk3VzJKSC8xQ2NGZzFFVDBacG5yQStOVkl0Nmg4SUhZ?=
 =?utf-8?B?Z1pyaklQYTUxT0RXODBpa0Nla2dzbVJrUml6RFp4TjFVb2VGODZKNEZ4dHJP?=
 =?utf-8?B?aW1aaVNTRGYzZW8zNjVVZmtqTEZucnF2NXZONzJmWWg0ZHJMNFBkYnBjVjZh?=
 =?utf-8?B?eXZJTjRBMm9CSzB0cUpvVVVlWUpYL2NFN2NyZkF0RmtLYkhUSzlrZTRnS2Nz?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <64941CC6088674408D0B89AFA5F0E50E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6467.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf6e08d-f58f-4fa3-e557-08da65a2c7b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 14:11:43.5284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cpSc5H0da0swLhCIiXluSFj6NlE3dQ1+6Yu6rV8iK6+FkVYbRHlHJHpiWHvIfKpy91ruRpb4BLHAWmXZsGKcj2J50LUJFk6V0yzJv8m60FU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3930
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xMy8yMiAxNjoyOSwgU2VyZ2l1IE1vZ2Egd3JvdGU6DQo+IENvbnZlcnQgU1BJIERUIGJp
bmRpbmcgZm9yIEF0bWVsL01pY3JvY2hpcCBTb0NzIHRvIGpzb24tc2NoZW1hLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogU2VyZ2l1IE1vZ2EgPHNlcmdpdS5tb2dhQG1pY3JvY2hpcC5jb20+DQo+IFJl
dmlld2VkLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFy
by5vcmc+DQoNClJldmlld2VkLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3Jv
Y2hpcC5jb20+DQpUZXN0ZWQtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9j
aGlwLmNvbT4NCg==
