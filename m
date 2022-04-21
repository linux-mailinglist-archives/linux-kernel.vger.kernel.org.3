Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6501550A105
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240043AbiDUNpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbiDUNo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:44:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1720536E20
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650548525; x=1682084525;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=msU8I4lUqFnjx2XNFYtFwoJJgXlOq73vKdPCOO8Gblg=;
  b=t96f73fK3RHbemcGx0Wck0NSvYiT02wF0/fzLE94xfzxt6H44MHD0yPy
   xWYrkUsFEa464vv5lCh2OHg0J3E8D+eQ6Sn2KWbLHQmjEH2zaGXb9SGfg
   klQ5M/VTm6ZNMfZ1YloukDb2Tf6Ejm4br8fiTZGrTmuRNbz0KT57XETJm
   jTPCk3YbsSK/EpYDyGmZ0l+UGSrUPmtHtP2wFdAXsGwuiDlj5EefqVynf
   hLhkpYfgA0IW/fK63jPTdcwnup7qPqVYKa4ewxgenPLifEX8NvgrfxClf
   uAHm8LKQK8nQQkWcTbhshFnGgzo/Mf3d+izzNT78edduBThcSQ/oyvWdK
   A==;
X-IronPort-AV: E=Sophos;i="5.90,278,1643698800"; 
   d="scan'208";a="153368190"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Apr 2022 06:42:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 21 Apr 2022 06:42:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 21 Apr 2022 06:42:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4UJpYn1FJDxK8DK8+8JjLCP0oRP/GdViRCAgVdyWHUrvmYPdYThkgry3fsw59DxmmdDzbggQSYEhYgGwbzT9vsi95ApmBiz/XUJpG/F08wZSDz2hslvUoWY43lLPx3zGbDA7BYFg2QsvhWKnWIyyKVOu+LQWMd6iCVE1CP5uHJSV3igpVQERHwTUPVdwUBun82VIfXERzyyUQDmUQSQd4GL+ihZbvJweLhvPbgUFwUO5MpJ2WffU1DS/+ka0ZwIgUxf0ICLY8rfsLk1LT7q4S5Ri4NnoIWrDtBmzdkubVRtoMFQlm8zTF/wY9z/Nem7NxEFbSrYbJdV93lERWR2GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msU8I4lUqFnjx2XNFYtFwoJJgXlOq73vKdPCOO8Gblg=;
 b=RGlJ6P6U5IAgLVSqY4D9EsCbt7snRqqqm6ttNEWB+4O+r7yIQfqm+kENfU863Lp8aLU+yHcvZT490un1LNO/tO+S61iqfUl7hzz3LphoP6ZgGjz4+X52aR7KYBwH6D3psXLtJ4pJhKoOSu4JAF/0twroefWTmk8CHhqMZIg7cQFeHy1XdStewdz+p3sDKDxYITDSjBRphW1pF3k1TKGQw/r7mtDCeBv9k3AklINK998hnvUzBhUFR8tX0q0W7bn4TWry99E0bM5eB6VYk41tcAeRq8ZIvR07CDNQANcjeJ+uqaEU807U5UtywNkAnQ+NLLaJAJY0j+gUP06Y2XqEsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msU8I4lUqFnjx2XNFYtFwoJJgXlOq73vKdPCOO8Gblg=;
 b=cUSAXFQp9mLPLeqlIhJ7mlMgSlosc2eNhePCi1t4YOiiPYbfP/eiQ9Cz51aQiDdxDYDwWw1acUfVuIn/qSaG12oI4qMEgy4wtnE5Q3p9JudHsJPEUo6fmm+qxqJcLZzdiASqMxPCDyV8uHeFBv7YKkaTXZ/QzBbF0AC5toQUi+U=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by MN2PR11MB3726.namprd11.prod.outlook.com (2603:10b6:208:ef::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 21 Apr
 2022 13:41:57 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::3414:43b2:d8a:bc00]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::3414:43b2:d8a:bc00%7]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 13:41:57 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH v4 03/11] mtd: spi-nor: core: Use auto-detection only once
Thread-Topic: [PATCH v4 03/11] mtd: spi-nor: core: Use auto-detection only
 once
Thread-Index: AQHYVU/7/NTsfvb/Zk+xiSXQh0nwdg==
Date:   Thu, 21 Apr 2022 13:41:57 +0000
Message-ID: <6f81d38b-5e4b-eaf7-0466-3c6fe5e84996@microchip.com>
References: <20220420103427.47867-1-tudor.ambarus@microchip.com>
 <20220420103427.47867-4-tudor.ambarus@microchip.com>
 <7f570c32-d0be-97ba-0a1b-9aca93cfbbf1@microchip.com>
 <20220421131657.d6hm7rltyxcb24wo@ti.com>
In-Reply-To: <20220421131657.d6hm7rltyxcb24wo@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54a7fe03-daa4-48b7-6731-08da239cb477
x-ms-traffictypediagnostic: MN2PR11MB3726:EE_
x-microsoft-antispam-prvs: <MN2PR11MB3726F02E0B65F7A3973201EEF0F49@MN2PR11MB3726.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4SYXkXY1nfptLLKP+11cHMR+yxdwFNmv0TvwZPHW9u/fOut6D0oiL5EOKcY4PvHtIXbgwqBbJLwg3TkYyhhDeGplBgSlZKo4tM4IE12oG77Qqccdi78m78j/3FIWq1XEcxfHxsX32t4Du+D9XEDogt+91t+z+iW/EE5hsM01vSOYGPW1bmm4qGVHpPqU96WXEa4TueqvGDXq1+E/HUqktz95bbbqZufn+j6hGR++QThqDWhMT59VAhJUDGgqs3TswoIZh9s9jWhCvZJghX4bLrePtNtYpdEVQhTH/ZKawTKnnPxG6Bo314KEwcEmkHNqDWbaqHnoCVRBhWcQHsUasyFmmDziC+eHp6HzFzjh3yh8V3NHDKa3OJRoLDzMhLUZZUv1+pchMcu0J7KTVfiFa8AqykWXkSBIbSQIPtptB8/cW2Ff4+bxIAMs7HWM3/7/m6eR/uxFQavSTyhs10xJBMveWdxC0MU9PVuZV4ZBjbqgHeyubey69HNwaWv00jsRVC5Flg/3TA/YmUrq+1u7QO/RaEwyCKIks8AXMEXjsZjtS5lsWLxja8HOSqJz5vWmN90GE5gN/Ba3yzfSLDhsCBRUQCiVAEXApinmRXBrPyrzyce85tI34QQBy647vgYKWTKU8pPQYBeHpBDL12mz2NmauNm7GYwnhgbilyYhPaSu8z0I7DwdCu4mn/vRTFCmhEJxvB5M8il2a80OsEbX+jR0AKbYIjrQaiGdT3OlKuQtjlb06WyFi/hXesSaxFaRH7C0wxE+c0awqVCgAexLJjtknSJf/KssH855phF6GhpXpsTj6Lmm1At14P/PCELrr4GweLTFav4cqX3z5DotQzArM3oDBK405MS84zCm79Y/TF2+GteeNy/fOtG/A9A77u6M2U9nUHiBKav8UaFdDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(31686004)(2906002)(36756003)(8936002)(2616005)(53546011)(5660300002)(186003)(122000001)(6506007)(26005)(6512007)(38070700005)(38100700002)(71200400001)(91956017)(8676002)(76116006)(64756008)(4326008)(66946007)(508600001)(86362001)(66556008)(31696002)(66476007)(316002)(6916009)(966005)(6486002)(54906003)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzZZUDZzL2pOV2h1ZmpIZjJFWDg1WW9TUm5RK3ZpYXNGcHZDVS9NMEludVJx?=
 =?utf-8?B?ZWlTMlVtczRXZkZVcHAwTnNGRjBaSjJXNS9lVWV5cWswNUt5Y1l2OFNSSkdO?=
 =?utf-8?B?VnIvU1kvUEhnZUhJZDFRTlQ0MkJUeTUrSWNta1RnckNQbUV6STNrSVA2VXEz?=
 =?utf-8?B?Q2xUbDRENXlpai9FNzlUTEJVVWp2cUpwT0NET0ZCVm1nT1h3OXZ2WWtOWVlE?=
 =?utf-8?B?d1hrR2xLakRoMmtTTXdvbU9wYTF4ZXB6OStGV215MjdDN2orQ05MTmxDRTI1?=
 =?utf-8?B?RXZBano3blA4cjBWcDFldVk4ZnhUMTRMd05oaHk3VjRXZms0UFJHWVR0NGlK?=
 =?utf-8?B?WlRXcmtBcThaSnltVHJ5U0I5cEFPc2FzL0ZjbGZhVmtyWFdILzAzUzNLaU02?=
 =?utf-8?B?NEJONHZZVUg2TWZGMk9lNFJtRDAzdE5xQWh2d3BwZVVQamFmQThSdXR2SENJ?=
 =?utf-8?B?U3dkUHZZZVdYVU8wV2xvSjkyVnNmMGpjOWRpMUkxeFpMUWNRRGtvWkJFRlB4?=
 =?utf-8?B?WXQ4aW9NT1VYRWJHNStOMWMxRHZPaFhqL0FRRU10d3NQa0JtVTg5dWxvbEta?=
 =?utf-8?B?cU43RS9mc25hdXdwK05TSjl2czNzRUM3M01iYk1OUTQrZFpmUjZXMW9ySGJr?=
 =?utf-8?B?TFN2M2d4SVFwb2JwdXN3OHR5ckdtY0R5Z2pVVnNJcGtHR3R3RDNEOVV1UDFw?=
 =?utf-8?B?TU9VMDMxZlQ0QUdCRWtTMkR0MFpXanBBUWhrYjFJaHc2YXFESmVnc0R5QjRC?=
 =?utf-8?B?YWRWczNOTXRoVFJGV001c1MrVXJOVGgxM0NVTWl1V3pHRlhZYTkybnhVemZr?=
 =?utf-8?B?ZHA1c3F4dWd4NnBmV2daUE9lUnh3MUlpa1l6eEFZVUJlaDBKUWI5RVdXazNl?=
 =?utf-8?B?dThFaEFsY25JWWZOc0ZxYkFiQU9zOVlXRG5xYVdOam8xa2dLK0d1K0dxTU5t?=
 =?utf-8?B?SzhXM3RqWGQxakZKUGNhM0pkN09NaUVhNC9FMTJ3Ty9ibTV4dmg5QitMaFk3?=
 =?utf-8?B?UzdpRmpEejZ6QXcvUi9rWllLOVJtT2xGdnpjbzZkbjA1OWIyR0dHNGtYK0Z4?=
 =?utf-8?B?V1U5RjVXaWpDQ2VGM25jWVIyQ0V3V1lzRGxkYUVQWEZTSWFKTTREY2tSQXZm?=
 =?utf-8?B?TVpmQmNIUkZOajRuTXhWVHpLRUpLZ2o4QXZ6RDYyc1lUYVhLeVFac0IySGVs?=
 =?utf-8?B?cjc4RlJQUWpFOFBvdnRjblNHMjhETlFVdTk4anI5ZXFMV1Z5c3ZRUm8xTFJG?=
 =?utf-8?B?MlJZVVB1aXhabW4xWnNpbnZZZzdadWxqdkV0eEZYMVRJV1VHY3dVazMyNXVs?=
 =?utf-8?B?RmJaaFNpOXduNVluVU1teHBlTEtNUzNvOFJpcXNEOEN2S2hCOG50eFMzaTFa?=
 =?utf-8?B?S0xmTk1QNlA2djhGZENiYldtUWMwYW43K3p4OEFBUEVHQmd6QjVjTVB2QkNi?=
 =?utf-8?B?L0VDbmllZE1NbzM5VUZ0a2tDaDZwcVpqTDVzNDVIbVJyOTNha0MrSG85T3Zv?=
 =?utf-8?B?WFFHNmEzMWhqMWdubndwU0pDVWdOMGp0Z1Z2VmNFazdwYjBRL0xBZ2FHbmdQ?=
 =?utf-8?B?ckw2VERZUkRaanBtNTgxVUIxVUhBbDFkYWZaaHVwYmlTbEtMMWN4TWlaVnE5?=
 =?utf-8?B?Ynh3em1YZm9RdVMzN002T1ZyWDhCdisvTW1NNWFzY2prazZMRHl3MkRsYXlB?=
 =?utf-8?B?dzVMWUNLMm1Odm15aE9Gb0tweDM5RnRiMzZDSnNGSGM0U0x0azRvREh6WkZB?=
 =?utf-8?B?Unc1YTRXY2NXZWtTVGtCNUMzTHdkZ1VvMTdleG9NQ2tZYkM1VWE4dGNMT2Jm?=
 =?utf-8?B?Y3ZjS0xuNFl6TnBwc2hRSkVzUWx3ZFB2OXdlSHdTYWVxZXJsN0RYWUE0TFk1?=
 =?utf-8?B?UkZEbVdRNVc4LzBIc044SHArS2MzSXR2enk2a0owVU0vUEdSZEhiZTJlNWdq?=
 =?utf-8?B?a3haQU00VjZZQzRZN0lXelhUUnhVYkZRQ0c5UklQRkhvYnlHVkRZc3VWTVJ0?=
 =?utf-8?B?TmFwQjJ3dllWSW5PVGVwYWNENUkvQ2RKNG9tcm5RYnNtR2p6YjhPQ2xKWTBj?=
 =?utf-8?B?a1NBbGhCVkloNDd0U1l3Vmx0SGh1bmtYcUV3cFNJYlpzV2dPZ2IxYit0ZWZO?=
 =?utf-8?B?aUZycmh3ekNwZ3JsWGd6bHZEWVlKb0xKUWpJWjN5SVcwZUx4d1FYV3NyckxT?=
 =?utf-8?B?V3FMM00zemxYWjZUeGZOUzRjYzFVNjFNeGF1eVQxOU5BZndsWFJFOFhGaHBR?=
 =?utf-8?B?YlNJMUlhU1p1WnVXaDlrTjhqNmFPVkwwTm1XSnkzMXNuTzNMVG5kY3I0NDE1?=
 =?utf-8?B?VGcvM3p5dU9tSmg5dGRudzNuaCtjS0k5N0c5SUpmaElLRmplVW1XOE9WUXVm?=
 =?utf-8?Q?ZqdrzozYIsVO1sMY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28FB53B0FAD2F7419F729B4762FE514F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a7fe03-daa4-48b7-6731-08da239cb477
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 13:41:57.5784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cmlQhKFia6Yp3Q6ZPNGY+Nk/2J6+hn/OTpBVhMLKr998CcFS2Mx+bltnEFXaSkzgG/FWQzVLar+iFjFqMbzXdsgIQ7AEpMy/io4lZdm8tDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3726
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yMS8yMiAxNjoxNiwgUHJhdHl1c2ggWWFkYXYgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMjEvMDQvMjIgMDc6MThBTSwgVHVkb3IuQW1i
YXJ1c0BtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gSGksIFByYXR5dXNoLA0KPj4NCj4+IEkgZm9y
Z290IHRvIHJlbW92ZSBmZXcgY2hlY2tzLCB3b3VsZCB5b3UgcGxlYXNlIHJlbW92ZSB0aGVtIHdo
ZW4gYXBwbHlpbmc/DQo+PiBTZWUgYmVsb3cuDQo+Pg0KPj4gT24gNC8yMC8yMiAxMzozNCwgVHVk
b3IgQW1iYXJ1cyB3cm90ZToNCj4+PiBJbiBjYXNlIHNwaV9ub3JfbWF0Y2hfbmFtZSgpIHJldHVy
bmVkIE5VTEwsIHRoZSBhdXRvIGRldGVjdGlvbiB3YXMNCj4+PiBpc3N1ZWQgdHdpY2UuIFRoZXJl
J3Mgbm8gcmVhc29uIHRvIHRyeSB0byBkZXRlY3QgdGhlIHNhbWUgY2hpcCB0d2ljZSwNCj4+PiBk
byB0aGUgYXV0byBkZXRlY3Rpb24gb25seSBvbmNlLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTog
VHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KPj4+IFJldmlld2Vk
LWJ5OiBNaWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdhbGxlLmNjPg0KPj4+IC0tLQ0KPj4+ICBkcml2
ZXJzL210ZC9zcGktbm9yL2NvcmUuYyB8IDEzICsrKysrKysrLS0tLS0NCj4+PiAgMSBmaWxlIGNo
YW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29y
ZS5jDQo+Pj4gaW5kZXggYjljYzhiYmYxZjYyLi5iNTVkOTIyZDQ2ZGQgMTAwNjQ0DQo+Pj4gLS0t
IGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4+PiArKysgYi9kcml2ZXJzL210ZC9zcGkt
bm9yL2NvcmUuYw0KPj4+IEBAIC0yODk2LDEzICsyODk2LDE0IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgZmxhc2hfaW5mbyAqc3BpX25vcl9nZXRfZmxhc2hfaW5mbyhzdHJ1Y3Qgc3BpX25vciAqbm9y
LA0KPj4+ICB7DQo+Pj4gICAgIGNvbnN0IHN0cnVjdCBmbGFzaF9pbmZvICppbmZvID0gTlVMTDsN
Cj4+Pg0KPj4+IC0gICBpZiAobmFtZSkNCj4+PiArICAgaWYgKG5hbWUpIHsNCj4+PiAgICAgICAg
ICAgICBpbmZvID0gc3BpX25vcl9tYXRjaF9uYW1lKG5vciwgbmFtZSk7DQo+Pj4gKyAgICAgICAg
ICAgaWYgKElTX0VSUihpbmZvKSkNCj4+PiArICAgICAgICAgICAgICAgICAgIHJldHVybiBpbmZv
Ow0KPj4NCj4+IEFzIE1pY2hhZWwgc3VnZ2VzdGVkIHNwaV9ub3JfbWF0Y2hfbmFtZSgpIHJldHVy
bnMgTlVMTCBvciB2YWxpZCBlbnRyeSwgc28gdGhpcw0KPj4gY2hlY2sgaXMgbm90IG5lY2Vzc2Fy
eSwgbGV0J3MgcmVtb3ZlIHRoZW0uDQo+Pg0KPj4+ICsgICB9DQo+Pj4gICAgIC8qIFRyeSB0byBh
dXRvLWRldGVjdCBpZiBjaGlwIG5hbWUgd2Fzbid0IHNwZWNpZmllZCBvciBub3QgZm91bmQgKi8N
Cj4+PiAgICAgaWYgKCFpbmZvKQ0KPj4+IC0gICAgICAgICAgIGluZm8gPSBzcGlfbm9yX3JlYWRf
aWQobm9yKTsNCj4+PiAtICAgaWYgKElTX0VSUl9PUl9OVUxMKGluZm8pKQ0KPj4+IC0gICAgICAg
ICAgIHJldHVybiBFUlJfUFRSKC1FTk9FTlQpOw0KPj4+ICsgICAgICAgICAgIHJldHVybiBzcGlf
bm9yX3JlYWRfaWQobm9yKTsNCj4+Pg0KPj4+ICAgICAvKg0KPj4+ICAgICAgKiBJZiBjYWxsZXIg
aGFzIHNwZWNpZmllZCBuYW1lIG9mIGZsYXNoIG1vZGVsIHRoYXQgY2FuIG5vcm1hbGx5IGJlDQo+
Pj4gQEAgLTI5OTQsNyArMjk5NSw5IEBAIGludCBzcGlfbm9yX3NjYW4oc3RydWN0IHNwaV9ub3Ig
Km5vciwgY29uc3QgY2hhciAqbmFtZSwNCj4+PiAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsN
Cj4+Pg0KPj4+ICAgICBpbmZvID0gc3BpX25vcl9nZXRfZmxhc2hfaW5mbyhub3IsIG5hbWUpOw0K
Pj4+IC0gICBpZiAoSVNfRVJSKGluZm8pKQ0KPj4+ICsgICBpZiAoIWluZm8pDQo+Pj4gKyAgICAg
ICAgICAgcmV0dXJuIC1FTk9FTlQ7DQo+Pg0KPj4gYWxzbyBhY2NvcmRpbmcgdG8gTWljaGFlbCwg
dGhpcyBjaGFuZ2UgaXMgbm90IG5lZWRlZCBhcyBzcGlfbm9yX2dldF9mbGFzaF9pbmZvKCkgY2Fu
J3QNCj4+IHJldHVybiBOVUxMLiBIZXJlIHdlIGNhbiBrZWVwIHRoZSBjb2RlIGFzIGl0IHdhcy4g
TGV0IG1lIGtub3cgaWYgeW91IHdhbnQgbWUgdG8gcmVzcGluLg0KPiANCj4gVEJIIEkgZG9uJ3Qg
dGhpbmsgYSBOVUxMIGNoZWNrIGhlcmUgaHVydHMgbXVjaCBzaW5jZSB0aGUgYmVoYXZpb3VyIG1p
Z2h0DQo+IGNoYW5nZSBsYXRlciwgYW5kIGVycm9yIHBhdGhzIGRvbid0IGdldCBleGVyY2lzZWQg
YXMgb2Z0ZW4uIEJ1dCBJIGhhdmUNCg0KSSBhZ3JlZSwgYnV0IGF0IHRoZSBzYW1lIHRpbWUgd2Un
cmUgaW50cm9kdWNpbmcgY2hlY2tzIGdyYXR1aXRvdXNseS4gU2luY2UNCk1pY2hhZWwgY2FyZWQg
YWJvdXQgaXQsIGl0J3MgZmluZSB0aGF0IHdlIHJlbW92ZWQgaXQuIEkgZG9uJ3QgY2FyZSB0b28g
bXVjaA0KYWJvdXQgaXQuDQoNCj4gbWFkZSBib3RoIGNoYW5nZXMgd2hlbiBhcHBseWluZy4gWW91
IGNhbiBkb3VibGUtY2hlY2sgYXQgWzBdIGlmIHlvdQ0KPiB3YW50Lj4gDQo+IFswXSBodHRwczov
L2dpdGh1Yi5jb20vcHJhdGkwMTAwL2xpbnV4LTBkYXkvY29tbWl0LzY3ZDkxMzc0NjgzM2VlNTRi
ZjRjNjYxMDQwZjNlZjEzNjU3ZGZmZDgNCg0KbG9va3MgZ29vZC4NCg0KYnR3OiBJIHRoaW5rIHRo
aXMgcGF0Y2gNCmh0dHBzOi8vZ2l0aHViLmNvbS9wcmF0aTAxMDAvbGludXgtMGRheS9jb21taXQv
YjQ1YmJmZjg1ZDQ5NTI5ZjhkYWZmODNjMzQxYTI5MmY2YzY0OTJjYQ0KbWF5IGludHJvZHVjZSBh
IHJlZ3Jlc3Npb24gb24gc29tZSBhdG1lbCBjaGlwcy4gTGV0IG1lIHRyeSBpdCBwbGVhc2UuDQo+
IA0KPj4NCj4+PiArICAgZWxzZSBpZiAoSVNfRVJSKGluZm8pKQ0KPj4+ICAgICAgICAgICAgIHJl
dHVybiBQVFJfRVJSKGluZm8pOw0KPj4+DQo+Pj4gICAgIG5vci0+aW5mbyA9IGluZm87DQo+Pg0K
PiANCj4gLS0NCj4gUmVnYXJkcywNCj4gUHJhdHl1c2ggWWFkYXYNCj4gVGV4YXMgSW5zdHJ1bWVu
dHMgSW5jLg0KDQo=
