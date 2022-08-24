Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DAB59F6FC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbiHXJ6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbiHXJ6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:58:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D759B79698;
        Wed, 24 Aug 2022 02:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661335121; x=1692871121;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QIlZ8/UhnQGhKTJXTGKWR8gTGG6/qcPkgKzPd5wxjIQ=;
  b=g/hb0q1u4lK+io98MrOUgDpnKG+AriGiosd2VKqWai6IKDtDjW2XQBQQ
   JW3dROqQlg9gin9mhjs4g+ZkMlqcjhq+y0teKvLI7xL3HJYzYV5Kize4c
   popTOGNd9Es4k71MZbL75xkPgvoUuTWhBMBL7RmHsmPP1anaxGQRszzpM
   camTKIgh7papa7XSJ7XjU0H57BtgmZhKs17+JKhTAH+s0ESmN4OOoBPQt
   UKh/XOLsPS3vwNY4zaMGs4FdiX069Ah+rUPxwWkoqUOH1mLz6yfPkWKPj
   7fKiqypjDLD6jmmbPpFM7QPd9WNBDkbH+6hT+uLja67Mx70B01UH4Vg/b
   g==;
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="177673183"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2022 02:58:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 24 Aug 2022 02:58:41 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 24 Aug 2022 02:58:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4oG4tFs6Ds6A/S+KEj+4tOTsI6AxJ0cRIJBxZN7bxNw1B2kqXWgpvSrW2EJfg3wAwSfOg4IvkXuv/JfeRv4AoaIFVASgRm58ME8Rv/bHoh80MTfn7kcPpn2Zaheu9mb3ccQrYo/E88UzEVqgJJLAMeWjPwig9n/kUZVdGK6JArti+zCu++TWn50M5KZBGoHhvuiYIDChH8WV4NAFkAdJx1Xm063eko/toKb/5Fa4jVMcZ8ituEWfgz8RmTyG3utjiEBlJ54Uo6l8YdOwtmYLAjA1IrkmXAoGrRTIElLoSAGfxK/4aPLo5ZN1uo4naKLepPANbhLFACFJ/i/yH9d6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIlZ8/UhnQGhKTJXTGKWR8gTGG6/qcPkgKzPd5wxjIQ=;
 b=WrrJkzoV80THc9mZcNQ1Uc6ANUjsSLi+HdrzFK5KzPHIZH52lSJ7sQODvFj4TbWA863U8ZQfQwGne8f6ffSDASYV2UTHnsBoOQZD+sFbNIU/iwCvVwXO9tXhQ7nbXPpI2pf8rPar837BRzbKcc+4AKmGIzqnG9t2k934jaGr8MraIKL/sovjrLd/45NjP+xqdRUVyGZfYsi/aeVW82PD5+QyWALhOYyKInYgnnbh+8wuUsZsmDhW9zVByR7lNifFmGD7tbs2bu6SBhIUsMv6DZgBxnvcMLugjetgQZMmSiHGBBMis7BmErqyifhuACriCc2a8Wbpn/Ay8wpgLc6pow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIlZ8/UhnQGhKTJXTGKWR8gTGG6/qcPkgKzPd5wxjIQ=;
 b=spnIhYDsPyt1skTxxue1K2znVPYKudKOhfKtIFEsEBtz4+cvTFxYLmJa4tNLG9e0PMiTMFCRLI4+3OwybjSyFrcwKOzZo5D6NaNMbhLyiw+5r4gCILPrmH8dEcF1O9oOo+fs5xXIy1iil2yIMfGSqlxeORn6EbWK+i+MfI5AO1s=
Received: from PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8)
 by DM5PR11MB1564.namprd11.prod.outlook.com (2603:10b6:4:d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.22; Wed, 24 Aug 2022 09:58:35 +0000
Received: from PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::b5a8:a5c9:beb5:70b0]) by PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::b5a8:a5c9:beb5:70b0%4]) with mapi id 15.20.5566.014; Wed, 24 Aug 2022
 09:58:35 +0000
From:   <Conor.Dooley@microchip.com>
To:     <christophe.jaillet@wanadoo.fr>, <Daire.McNamara@microchip.com>,
        <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-rtc@vger.kernel.org>
Subject: Re: [PATCH] rtc: mpfs: Use devm_clk_get_enabled() helper
Thread-Topic: [PATCH] rtc: mpfs: Use devm_clk_get_enabled() helper
Thread-Index: AQHYt5IndXqzWMJbz0OfuNYZ1M2LkK290O0A
Date:   Wed, 24 Aug 2022 09:58:35 +0000
Message-ID: <f76fb247-5160-61ed-a0a3-037d2f40d2f9@microchip.com>
References: <e55c959f2821a2c367a4c5de529a638b1cc6b8cd.1661329086.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <e55c959f2821a2c367a4c5de529a638b1cc6b8cd.1661329086.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 473ceec8-d31d-4696-375f-08da85b735c0
x-ms-traffictypediagnostic: DM5PR11MB1564:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xISuxwolJHGP5MnWuWsEtmJvnXrVnxp/SBFMfUKhLyoCqe16aZXWKaf991HOJDHJuvzY/JIxFR9Hkh4p0X+oeR4j+LhyWGXq18UzOdhb8EdnY7PYW/bOIh/3JHdHqbmnBfXVtTgLPB+Ddu9YTL8RmYFtezyvt6AED/IIQ/i8sjEYLYnpnXgEh7K37vHOXStH3fjnRs4n0B2OCAX3P+m8BolpBdVKdOIZG1ZpCDaUXPopj6IWE6QErCoGrpIZpEDuST9SGZfLwxKvrGsiX5x5WmaFJyP2GNV3fDHS3JEABU+1GArdsyyA64YFtVYVaHhEaVwjDOvssU+WPekMXfJCCWIEWP+Nc+gKyaRZnVNaQImHhyHm3O/yGLSuaBTmyQtl4NdNPyta1wdvizCE6n99q3Zkv5O8qa0zYO5FJPspI9LPwg9lZG7es007JqUXzDtOSgwONqvNnn3ww0N1evmwXl3yQSNAQCZ4H6b0ju5JyeOqKXzci5qnqidImF34air/rv5GBaCKLe2MXCyd09MIylGFCZVO3IZs5bE9MOraJeSnFNjMPit5mlZDfNN/loVaR/Kbldgf+RGGHOSCrzaMNJ7fRSGLEi01CMvsormSNrocJm0yDDWYclHGDPG5LYjEqvJgONXSPo35XzARNuwXBix8SbeYEIJ+zjar8vuBgtiED2OFPNmeDqeMT6Qji3/6ZJndyRiMi/LmaRSbT/mu6scZyPU8ZDmbtEFaaSmzD+nBHRdpAwwUh+jpcPCmbRw55LxNqcwUq2rRmkgWKl07e/vPaqJorTu5xV4PueSyrHs5D22W3FOAZO6EK7XcdgCIi38skPH4JN2KMHAY+h3+abQD4NYyEN1wMrNqCDcB0k4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5160.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(39860400002)(376002)(366004)(396003)(54906003)(66556008)(110136005)(86362001)(8676002)(64756008)(66946007)(76116006)(91956017)(66476007)(31696002)(316002)(4326008)(38070700005)(66446008)(186003)(2616005)(83380400001)(6486002)(966005)(478600001)(38100700002)(71200400001)(53546011)(26005)(6506007)(6512007)(41300700001)(122000001)(5660300002)(31686004)(8936002)(2906002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dW0vYndIeTltS3lvdE9xMm5TblhJSmt2NVFwRVRqNm1yVGN3ZWNHUDAzUkxF?=
 =?utf-8?B?aXg2QVZIdzZDeGcvMkpGYk5NaTV0MWIvMEhiUU9UQkpLWm9KM21VV00yUk4x?=
 =?utf-8?B?cWkyU1BkNGI3MXFuOVRiSFB4b21wQ3lYejZjR0ltckVBTDdxQ1lmeWNpSmRC?=
 =?utf-8?B?cTBzQ0thR2RHM2FEeUk2aHVoVm90aDJkZ2FlT1F4aVVDaHBrRUZRZ3pyQVB5?=
 =?utf-8?B?ODdwV3JkNVFwZUlQQ2NaVHJLVzF0UWowem14T0JxTXB0Nmp4TElaMmtDblNu?=
 =?utf-8?B?dUJwMUNlalR0T1UyZW5HNXZjUTNsUnlqait6ZFlQMzdoL0FTbTFKUEgrc295?=
 =?utf-8?B?SnYzc1AwOGpYWTFBTFVxeVJmR2w0K2JOVHlSejRiYkRTRTVNOUFOOFNTRWp6?=
 =?utf-8?B?OVkweVpGalFOeUYxaGg4MkF6eXpyMGFZUEhlaitVV25ROTE5TERuQVZJUEE5?=
 =?utf-8?B?dTg4d2pIWmRHbXRtUklLdU9hZWhGMUpTYmZEUGIxSEhMU3R2KzRaUXNHMFVQ?=
 =?utf-8?B?Qi9XZzBIbzJhVmJJZldFNVBvMk1CeVdaVjgwVFEzc3poWVptTGdUWElXbHZ4?=
 =?utf-8?B?ODdwWEU3WlN0aFRsQnhsNXZOT3BsRGhUVkUwM2FpRnBhTXFVa1JsZHdnbndH?=
 =?utf-8?B?N3VLSGF0OEMzTVlmSVFSZEIyT1ZVVW1GR1hucnFZN0xnaXB0NmM2SFBia2Zx?=
 =?utf-8?B?cWRhbk1yZVJ0Q2QxWUNrU1MzVm1zR0c5RGsyNC9TQjY5Nmt5L2Y4QXNuQi9W?=
 =?utf-8?B?MnM3d29LdkhqUFhhU1hSdDNxbjBjY2xWK0RNaW5UdW4xU3lJY0ltelFFUUYy?=
 =?utf-8?B?ck9xVE9XVkRoTjhSbUJoQXlVV0VqRzZJMTVhUXdlY1gvVzZJSEpRbnBTNUZp?=
 =?utf-8?B?QVJUN3hkRmxUMFBhbGdncHpKVFVuUXNYaGZSeTdwQTc0NjVFS1p6bFI4VmU4?=
 =?utf-8?B?RnJTN0tlZmNTWTVDN0tzSmdCb29xMk1SSTErZURLa1FLSnM2K3JUdmJZY2dl?=
 =?utf-8?B?RGU4MGFybVZQOWtRam9XaDVzU0ZFNWlJTnRvVmlyRGpmUGpJRVVzS29GcllE?=
 =?utf-8?B?MXpCaStQNE1MdU5uMlJOYzVvU0ExcDdQSVhRZVllcFdGQXYxTk1GVEZYUmZr?=
 =?utf-8?B?ZjUzYWhDTTlPdzF2elVVVU1GYVJSLzkvWDZFbDhrTWtETzBKR0pTb3I2VnZF?=
 =?utf-8?B?OGZQSVdNL29sOXc2a3h2U1QyVENuMzl1U1d4NzFWYmI2b2gyK1FPQk5OZWRG?=
 =?utf-8?B?U0phMnFCeW43YlVCN2JkczVLZzRpYStBSXlFYnlWVzdBSThBdHdpK3hCZjdD?=
 =?utf-8?B?RzdCeno5STdGaTJ2VGRjZm5PbTNVem94YW9KdjRTTTB4bWU5N0dvdmw0djUz?=
 =?utf-8?B?U2plNWZwNjh4dk1keWZ4Zjh2RHZZeG0vV1d5a05pbzNwMnpzVVRvcDJGQzZ4?=
 =?utf-8?B?UlQzS211ZkROYWZHL09ydyt6bjhCbUNkbWZXVnIvT2dmODJKYW1jUkZNeVBs?=
 =?utf-8?B?V3NpYS84V0htUDBQK0xyTXhhTml0ZmpQenlMYjk4ckQyY2JOTkdHV0hydmhN?=
 =?utf-8?B?bEhncDkwZXJYb1JyWjFJdTlJdDhsOVlWTlhPdU9ndS8xc1pSQnNFQzgwOGM4?=
 =?utf-8?B?RjVKVXlWWGJHeEtnNmxTR0xvQXpvTGQwd2ZPeGFHOHBXcU45OHJjcWZ1MFMr?=
 =?utf-8?B?UVJJdFNmbVFud0c3Zjg5NTJIbVNOdE1uVS9MelFIbUR6ZUszWWVPdHJ6M3Ni?=
 =?utf-8?B?Qm5wcnpQcUk0VjliNnp0VFZzQXhZR3RlWWdHRXEyUlN3QWtyc20vRDJUSU1C?=
 =?utf-8?B?dlYza1owMTZHQ1NZWEd6NnBsQzhxV251bGdPWjBzcW5wOTI1UzBoeVIraG5M?=
 =?utf-8?B?UXNYdVhJZ2ptS0x6UE95NENsb05kc0xKdDF6eGRBSllJUE4zSmp6SHhnMnBn?=
 =?utf-8?B?SjM2N21vQ1RxMG5uejVMNmJkOXdwY1pBQmNpUlNwZjFwdUFVTnJzTlhxVS9z?=
 =?utf-8?B?MVBoQm94M2RUcWlhcjdwcEhkZXJJWFdTSm5WVlFOY2d4MjJJNVBuTVk5Snla?=
 =?utf-8?B?amFyWUY3bUFMNWlablV3Tld6clZjNlZ4a0hIa1NEU3BYMnMxdm5HVHBLSkht?=
 =?utf-8?Q?yWjZHQAPzXFWJ10civl4L2s/1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C793923F8F9AA47B4CE19A9B872C5A6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5160.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 473ceec8-d31d-4696-375f-08da85b735c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 09:58:35.3176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ItCJZXqeW8rmOJPe+vZ+IDcJ4H3+6AhP0AXmwPEufbp5IWj+Mgfnz6Zie7DYGTkwWQPWfAYd1iM9EBOH0xd6e2RXe/hpTDouBsL3VVeRyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1564
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IENocmlzdG9wZSwNClRoYW5rcyBmb3IgeW91ciBwYXRjaC4NCg0KT24gMjQvMDgvMjAyMiAw
OToxOCwgQ2hyaXN0b3BoZSBKQUlMTEVUIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90
IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250
ZW50IGlzIHNhZmUNCj4gDQo+IFRoZSBkZXZtX2Nsa19nZXRfZW5hYmxlZCgpIGhlbHBlcjoNCj4g
ICAgIC0gY2FsbHMgZGV2bV9jbGtfZ2V0KCkNCj4gICAgIC0gY2FsbHMgY2xrX3ByZXBhcmVfZW5h
YmxlKCkgYW5kIHJlZ2lzdGVycyB3aGF0IGlzIG5lZWRlZCBpbiBvcmRlciB0bw0KPiAgICAgICBj
YWxsIGNsa19kaXNhYmxlX3VucHJlcGFyZSgpIHdoZW4gbmVlZGVkLCBhcyBhIG1hbmFnZWQgcmVz
b3VyY2UuDQo+IA0KPiBUaGlzIHNpbXBsaWZpZXMgdGhlIGNvZGUsIHRoZSBlcnJvciBoYW5kbGlu
ZyBwYXRocyBhbmQgYXZvaWQgdGhlIG5lZWQgb2YNCj4gYSBkZWRpY2F0ZWQgZnVuY3Rpb24gdXNl
ZCB3aXRoIGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldCgpLg0KPiANCj4gVGhhdCBzYWlkLCBtcGZz
X3J0Y19pbml0X2NsaygpIGlzIHRoZSBzYW1lIGFzIGRldm1fY2xrX2dldF9lbmFibGVkKCksIHNv
DQo+IHVzZSB0aGlzIGZ1bmN0aW9uIGRpcmVjdGx5IGluc3RlYWQuDQoNCkZpcnN0bHksIEkgdGhp
bmsgc29tZXRoaW5nIGlzIG1pc3NpbmcgZnJvbSB0aGUgY29tbWl0IGRlc2NyaXB0aW9uIGhlcmUu
DQpkZXZtX2Nsa19nZXRfZW5hYmxlZCgpIGlzIG5vdCBqdXN0IGEgYmxhbmtldCAidXNlIHRoaXMg
aW5zdGVhZCBvZiBnZXQoKSwNCnByZXBhcmVfZW5hYmxlKCkiICYgaXMgb25seSBpbnRlbmRlZCBm
b3IgY2FzZXMgd2hlcmUgdGhlIGNsb2NrIHdvdWxkDQpiZSBrZXB0IHByZXBhcmVkIG9yIGVuYWJs
ZWQgZm9yIHRoZSB3aG9sZSBsaWZldGltZSBvZiB0aGUgZHJpdmVyLiBJIHRoaW5rDQppdCBpcyB3
b3J0aCBwb2ludGluZyB0aGF0IG91dCB0byBoZWxwIHBlb3BsZSB3aG8gZG8gbm90IGtlZXAgdXAg
d2l0aA0KZXZlcnkgaGVscGVyIHRoYXQgaXMgYWRkZWQuDQoNCkkgaGFkIGEgYml0IG9mIGEgbG9v
ayB0aHJvdWdoIHRoZSBkb2N1bWVudGF0aW9uIHRvIHNlZSBpZiB0aGUgYmxvY2sgd291bGQNCmtl
ZXAgdHJhY2sgb2YgdGltZSB3aXRob3V0IHRoZSBBSEIgY2xvY2sgZW5hYmxlZCwgYnV0IGl0IGRv
ZXMgbm90IHNlZW0gdG8uDQpUaGVyZSBpcyBubyByZWFzb24gdG8gdHVybiBvZmYgdGhlIGNsb2Nr
IGhlcmUgKGluIGZhY3QgaXQgd291bGQgc2VlbQ0KY291bnRlciBwcm9kdWN0aXZlIHRvIGRpc2Fi
bGUgaXQuLikgc28gaXQgbG9va3MgbGlrZSB0aGUgc2hvZSBmaXRzIGluIHRoYXQNCnJlZ2FyZC4N
Cg0KSG93ZXZlci4uLg0KDQo+IA0KPiBUaGlzIGFsc28gZml4ZXMgYW4gKHVubGlrZWx5KSB1bmNo
ZWNrZWQgZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0KCkgZXJyb3IuDQo+IA0KPiBCYXNlZCBvbiBt
eSB0ZXN0IHdpdGggYWxseWVzY29uZmlnLCB0aGlzIHJlZHVjZXMgdGhlIC5vIHNpemUgZnJvbToN
Cj4gICAgIHRleHQgICAgZGF0YSAgICAgYnNzICAgICBkZWMgICAgIGhleCBmaWxlbmFtZQ0KPiAg
ICAgNTMzMCAgICAyMjA4ICAgICAgIDAgICAgNzUzOCAgICAxZDcyIGRyaXZlcnMvcnRjL3J0Yy1t
cGZzLm8NCj4gZG93biB0bzoNCj4gICAgIDUwNzQgICAgMjIwOCAgICAgICAwICAgIDcyODIgICAg
MWM3MiBkcml2ZXJzL3J0Yy9ydGMtbXBmcy5vDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3Rv
cGhlIEpBSUxMRVQgPGNocmlzdG9waGUuamFpbGxldEB3YW5hZG9vLmZyPg0KPiAtLS0NCj4gZGV2
bV9jbGtfZ2V0X2VuYWJsZWQoKSBpcyBuZXcgYW5kIGlzIHBhcnQgb2YgNi4wLXJjMQ0KPiAtLS0N
Cj4gICBkcml2ZXJzL3J0Yy9ydGMtbXBmcy5jIHwgMTkgKy0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMTggZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ydGMvcnRjLW1wZnMuYyBiL2RyaXZlcnMvcnRjL3J0Yy1tcGZz
LmMNCj4gaW5kZXggOTQ0YWQxMDM2NTE2Li4yYTQ3OWQ0NGYxOTggMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvcnRjL3J0Yy1tcGZzLmMNCj4gKysrIGIvZHJpdmVycy9ydGMvcnRjLW1wZnMuYw0KPiBA
QCAtMTkzLDIzICsxOTMsNiBAQCBzdGF0aWMgaW50IG1wZnNfcnRjX2FsYXJtX2lycV9lbmFibGUo
c3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgZW5hYmxlZCkNCj4gICAgICAgICAgcmV0
dXJuIDA7DQo+ICAgfQ0KPiANCj4gLXN0YXRpYyBpbmxpbmUgc3RydWN0IGNsayAqbXBmc19ydGNf
aW5pdF9jbGsoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAtew0KPiAtICAgICAgIHN0cnVjdCBjbGsg
KmNsazsNCj4gLSAgICAgICBpbnQgcmV0Ow0KPiAtDQo+IC0gICAgICAgY2xrID0gZGV2bV9jbGtf
Z2V0KGRldiwgInJ0YyIpOw0KPiAtICAgICAgIGlmIChJU19FUlIoY2xrKSkNCj4gLSAgICAgICAg
ICAgICAgIHJldHVybiBjbGs7DQo+IC0NCj4gLSAgICAgICByZXQgPSBjbGtfcHJlcGFyZV9lbmFi
bGUoY2xrKTsNCj4gLSAgICAgICBpZiAocmV0KQ0KPiAtICAgICAgICAgICAgICAgcmV0dXJuIEVS
Ul9QVFIocmV0KTsNCj4gLQ0KPiAtICAgICAgIGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldChkZXYs
ICh2b2lkICgqKSAodm9pZCAqKSljbGtfZGlzYWJsZV91bnByZXBhcmUsIGNsayk7DQoNCi4uLiB0
aGlzIGJpdCBoZXJlIGNvbmNlcm5zIG1lIGEgbGl0dGxlLiBJIGRvbid0IHRoaW5rIHdlIHNob3Vs
ZCBiZQ0KcmVnaXN0ZXJpbmcgYSBjYWxsYmFjayBoZXJlIGF0IGFsbCAtIGlmIHdlIHBvd2VyIGRv
d24gTGludXggdGhpcyBpcw0KZ29pbmcgdG8gZW5kIHVwIHN0b3BwaW5nIHRoZSBSVEMgaXNuJ3Qg
aXQ/DQoNCkkgdGhpbmsgdGhpcyBpcyBsZWZ0IG92ZXIgZnJvbSB0aGUgdjEgZHJpdmVyIHN1Ym1p
c3Npb24gdGhhdCByZXNldA0KdGhlIGJsb2NrIGR1cmluZyBwcm9iZSAmIHNob3VsZCBiZSByZW1v
dmVkLg0KDQpUaGFua3MsDQpDb25vci4NCg0KPiAtICAgICAgIHJldHVybiBjbGs7DQo+IC19DQo+
IC0NCj4gICBzdGF0aWMgaXJxcmV0dXJuX3QgbXBmc19ydGNfd2FrZXVwX2lycV9oYW5kbGVyKGlu
dCBpcnEsIHZvaWQgKmRldikNCj4gICB7DQo+ICAgICAgICAgIHN0cnVjdCBtcGZzX3J0Y19kZXYg
KnJ0Y2RldiA9IGRldjsNCj4gQEAgLTI1MSw3ICsyMzQsNyBAQCBzdGF0aWMgaW50IG1wZnNfcnRj
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgICAgICAgIC8qIHJhbmdl
IGlzIGNhcHBlZCBieSBhbGFybSBtYXgsIGxvd2VyIHJlZyBpcyAzMTowICYgdXBwZXIgaXMgMTA6
MCAqLw0KPiAgICAgICAgICBydGNkZXYtPnJ0Yy0+cmFuZ2VfbWF4ID0gR0VOTUFTS19VTEwoNDIs
IDApOw0KPiANCj4gLSAgICAgICBjbGsgPSBtcGZzX3J0Y19pbml0X2NsaygmcGRldi0+ZGV2KTsN
Cj4gKyAgICAgICBjbGsgPSBkZXZtX2Nsa19nZXRfZW5hYmxlZCgmcGRldi0+ZGV2LCAicnRjIik7
DQo+ICAgICAgICAgIGlmIChJU19FUlIoY2xrKSkNCj4gICAgICAgICAgICAgICAgICByZXR1cm4g
UFRSX0VSUihjbGspOw0KPiANCj4gLS0NCj4gMi4zNC4xDQo+IA0KPiANCj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gbGludXgtcmlzY3YgbWFpbGlu
ZyBsaXN0DQo+IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yaXNjdg0KDQo=
