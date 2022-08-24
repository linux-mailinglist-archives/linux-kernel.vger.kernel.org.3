Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1201F5A00CD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 19:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240195AbiHXRzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240290AbiHXRzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:55:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49C413F64;
        Wed, 24 Aug 2022 10:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661363727; x=1692899727;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IuoOt1Yin62Q4UTD2qI75cDQ+U5JicfuU7VzUtDEtXc=;
  b=PeT96wB+HW7u25TtpFbOmb8hcwVg0ePYrrHNJiVQZ54hbXi1LxzOOMG0
   R0vg4CaAVI/ks0CY3z5UChrLMB+n3igQVyoi2OVdUeSlr7TFzg8RpcUgW
   l6sjN+qftZh0JmYlCSZY18saMyuH7dYaJ58QxXErF2zr2fwvrLmvlVZ+x
   81DPuNsKoCSRoB9vKcVhgoPLF6SwiMMnOL4hj5y/JcfAu5uEkc62WbyUP
   yds9UmNHPksxtz83yRWU9OTWNi4j65c9DYvny8wYm1hFDKuRnufWe0REz
   BvOetIr2Z/iujtyI5xE5QLCNjgQ2vEoZEpD3+ckwysKRUOjEy5B6Axgow
   w==;
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="170788986"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2022 10:55:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 24 Aug 2022 10:55:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 24 Aug 2022 10:55:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aV4LX7ssi2obP+a2NiMvhlH946aT5EC9lpmW6tw5TuztxYH4bMwFQ8VStO2rWDzMl0F8l7+tsdz/8YConBUsH2TuUy6tkDbvkdhvGZSyPN3VxgtSFz1K/yDbBQwpPKmwqCeLnmev0d9OiKw7e0aCR0kgXVWx0PCikvao8Y91kGlj8peUaWcGaNI3AGmjBkkY3ggSNMi0LduwlId+fYUquNKxYXa9XGXqw+wJA/w62/6p2vW+c917qgiLkma2HdrwYxzTUdeTcq9nlo7AXZa5UB9VMRI/4TUl/GLfozzj6qQVzh9dJrTpS6ghnKtkzYA7ZVcDltE1SSsuRzrO8uUrcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuoOt1Yin62Q4UTD2qI75cDQ+U5JicfuU7VzUtDEtXc=;
 b=YB8IzI2A+UG0EkCgrYDksgkIAPvdziSvbRCYqXEpfM8bTLI8T1zp9MIn9T4Zo8F85ZPfTrGoKrsaAOgeG/pqdd43FajbeGlwpmYjTX60h+KVMsQjpmPXGEIjSBVvkJ4nqxQEUCS+Difjx7uWvnEwm2yVlrbQOAN99r8dL6FwNu/uAhHpMHMyW5NexIg8WEgL8i5pRXTMXSpFuvY4NCyC18SpVNGPNyNO9iW/EgRbokFt5QMN/98BuZYP2ub09+GHkcdEXXmOJcKlzp2rCKfS8tnALS3OCT9AK9PGNzVLR/cNin5PljUcXrMY+ZVPKUEwdt8YsoW789xPf1RnIAuApQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuoOt1Yin62Q4UTD2qI75cDQ+U5JicfuU7VzUtDEtXc=;
 b=D3pZXCwVfRTRRZpbJrjzQoyh5uJ0HW2+PcAVPUlnFkLvxAGDJdN92XrEDz4ybQrexDHqlkBqvvpxtB1G/wY7SHwlpO577vTHxVYtYaK7t6Vvnu6LOy7DksooGPD4Q2CQjduaiW3AJRuOwAapMn3aetqaGz+yuHP8upmOAnyGb0o=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB2553.namprd11.prod.outlook.com (2603:10b6:5:bf::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 17:55:18 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 17:55:17 +0000
From:   <Conor.Dooley@microchip.com>
To:     <heiko@sntech.de>, <tglx@linutronix.de>, <maz@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <linux-riscv@lists.infradead.org>
CC:     <daniel.lezcano@linaro.org>, <anup@brainfault.org>,
        <Conor.Dooley@microchip.com>, <guoren@kernel.org>,
        <sagar.kadam@sifive.com>, <jrtc27@jrtc27.com>,
        <ajones@ventanamicro.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <qemu-riscv@nongnu.org>,
        <robh@kernel.org>
Subject: Re: [PATCH v4 2/4] dt-bindings: interrupt-controller: sifive,plic:
 add legacy riscv compatible
Thread-Topic: [PATCH v4 2/4] dt-bindings: interrupt-controller: sifive,plic:
 add legacy riscv compatible
Thread-Index: AQHYtx72QjT8DbZ4AUeIZ7mMwDZq162+VAYAgAADEoA=
Date:   Wed, 24 Aug 2022 17:55:17 +0000
Message-ID: <95fe8df7-581e-f7ec-be1f-1c6e06cb30a4@microchip.com>
References: <20220823183319.3314940-1-mail@conchuod.ie>
 <20220823183319.3314940-3-mail@conchuod.ie> <3948407.AJdgDx1Vlc@diego>
In-Reply-To: <3948407.AJdgDx1Vlc@diego>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afdd74e2-3b01-4d14-4925-08da85f9ce2b
x-ms-traffictypediagnostic: DM6PR11MB2553:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tGMPnvBiRdo4WKUMiNPFYGirNFbYkvGMEgeYkldBNW3Cs/EQP1iZvDE0LzuaLbLCJKzZgoJh0bhKcyllO/Fozix66arYY0kZjqAzhQ21x+JRXEslo+QH2kNkZx5sIYGcycONqXF87BcRKx+uCCcUbab/N/9hlLMflI4IroYjZkMzARk3IdQ861XXtsFY1sveWN3N/ariMQP04h7HBTQJvclQHEvQmK9a6wP67QwltK4W7c5To2nA5ph9joy4XE4//nNtvLP6V8qBf7XRw3HPbigNhjq50ifTcrK9PtyTaYdX1qzlbGVsUJsH187PYQTe9RciXcvcgSlF7UitRUwv5hoL10qoxPdSTbH6dTor6UbMxgM+DsqSL9Yep1bnmPQXc+yNbVQnOA/oJZCWBVQ1AdwgzMQOk5o0XU7xlemGUokZsCwnMd6eJSAZHux78r7LJZGBJFhBCceKZNlT99LGn0Gvtn2D6l2+R0wRV50x0gBVOyXbThI+FmhxAhtMntpsmI7XH/h0lIgMCHoK3hr6Z5XZS63abwjB8LqDl+heBoDlFzAY/9ubhATSYCfsUQqvehVJsyk3Uk5KtpEm84e0bU8x5Hmo/StMd8AdYtGu19Dtuv5laAHLVsNi+3gNpF2qHPDgOHO8CP7RwAht6NU6JxeX9fFJfGQW+mnjq93IHJb5biPaPEU5oMpZnP6PYZPXg4uZCn/5HML4nrCumb463GkwVdzh/LOdMUoDzLGASlJMxYbZ3X4WWrIWdUMPs6absNll5vJ4RO7Yg5XBi6vhyY6JaPVDJ1b7IOxumsdjj5Qg8MLl7rZ6rKm2/xnu1scZ7+nbjXcHwLHtdvKKgzjCcP81iRfwcl099ss5Bwnan3odA+CO/VU1yT7aGjmFEzLKm5jDQD3rACPJuEspRqamLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(376002)(136003)(366004)(39860400002)(122000001)(2616005)(186003)(38070700005)(86362001)(7416002)(5660300002)(41300700001)(31696002)(8936002)(6506007)(26005)(6512007)(53546011)(2906002)(66574015)(66476007)(83380400001)(38100700002)(110136005)(54906003)(64756008)(8676002)(4326008)(31686004)(76116006)(478600001)(6486002)(66446008)(66946007)(66556008)(91956017)(71200400001)(316002)(36756003)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTJBZGdwcE9hT1YzaWsvZSt4UTZwZnlhcXdpdE1XVkJKR3pmVGVQazNuWURE?=
 =?utf-8?B?M3cvYTM3bjNLcDVCQzdLVGowbGhzZER2VmZKKzFKQWdFMEZPdlVEN0pFc2tG?=
 =?utf-8?B?TG13OG44aVdFYS9DMVo0WVBYbG5wMERKcDcrT2hSY1dqQndtRkhYWk9FZkVK?=
 =?utf-8?B?aVhIYzZHN2lVZ2FDSW8xYW1zcjFrU01Edmg4WE92bHJFQllManB6WDhPMFd3?=
 =?utf-8?B?VTlHUnFsb0FNRmZXbFptV1YwN2MxR2dxWnpEdnMrWmZLVzZPQ2l1a05INnFD?=
 =?utf-8?B?bllpdDVzMlhxaHJPU3A3UXZIcEcyZXRmditwamxubHRuVjJQUEFZN2J5OWsy?=
 =?utf-8?B?ckdrYldQb29jeEtnWDNFWU0yWExQWmtXaWNadU82Y3pZenBWT3BlRXlRc0lR?=
 =?utf-8?B?WE9nRjkyby9tYXVhK3hmMVNGWmMreENrY0tVNEZvYytraFAwUnIzNDdXK2NY?=
 =?utf-8?B?NExaVUMyV1VBZ0swUEgzcTF4YnFhWjBXS1Flam4xYkd2ZmY5ajBJK3VSUjZi?=
 =?utf-8?B?L3AzbWNCWXVCUXNvTjRjSlBTaUNhUWZuaW40eVlDQitVZ3VScnZTTG1lU3B1?=
 =?utf-8?B?Ni9hSkU1NFVZdHpoVzJlcTZsYi9kUkcyOGZ0RCtUbzR3ZHZBbUViZTh2NEd6?=
 =?utf-8?B?T2psdlJSc2k4cGtDdmY3WVFRV28vWHJRTUxDNi9QdWpEUkRkbDRiRWZKTVJk?=
 =?utf-8?B?SDJCN2p5MWlKT0tkNGJrVThkKzFoZEk4aEtzSHMvTmZ4OHVpKzk2VklYcVZk?=
 =?utf-8?B?UnJ3bFJwelBYSDYxRjB5WWJhaTZybTVKR2srZVJaOEdCY0QwcHNURmo3UkFV?=
 =?utf-8?B?d3IxMlZHNi93aEk2WGxkUWdjdURGSDRBNWMwSGNKaHN6SUROYnArU0pycDdq?=
 =?utf-8?B?NUgyNE0wV0V3RnJJaEozcm9tc1gxdE1nd0xSNk00Qk1KNmMxTXhVTkFObEJ3?=
 =?utf-8?B?NFZIWGJIN1RtaUdTM1ZjYkxuNEQ0eDlzZlVrYTBwckpaTHIxWjVTRTZZa1RS?=
 =?utf-8?B?YU5VU3Z5TGdzeHdlQk1OL0s5RUpBTVNjRUZrb1N5NDh4SWxMb0F3TkUxN2dT?=
 =?utf-8?B?WDkrV2xqejlBZ3dEaTZoSzZIZUhWTDhSbldUTWowY1VmUW1YTTQyWlVjQTZU?=
 =?utf-8?B?SEFpZ25jdUxwbm5PYjJBTlZZcmtJaEkyWjczWnhWRmFLTEVGZnZUaEVLQzBX?=
 =?utf-8?B?RHdxQnpkTFJGZG9QeEw2bmorZjFaZWJSWTQ0cFpYT0hZQzQ5czQvSmNGazRW?=
 =?utf-8?B?MmdsL1JsRmlnWW05Y1VJTmU5ekk1cXdTU2MrbjM4Wmsyb3dpZks0cTM4V043?=
 =?utf-8?B?RUk3Smxnbk5CMk15bkxtdmd5WEQ4L2JodG10c3AxcnU3RjhJQnJPUGZTcUtz?=
 =?utf-8?B?bkVmZHFNSklxUmNUMnhhaDROOEk3aS9NbW11VFNKWlJBak1yRXhHQ204MDhE?=
 =?utf-8?B?OFNtY3gvdjRMc3Mwa0c5S2xLaUNoakNrcEpoT0UxR3RWbjdhMXU3M1FSQVJS?=
 =?utf-8?B?dm1TTHJDNU1uaXE1VTN3NzlKNFVaNnZWNHNScGV1WU5USlhkK25DdG02Q2Qy?=
 =?utf-8?B?ZUpZazN0RkNmbmowNG0rNVE3V0U1QlJpK0s2MTYzYlEzc3lwbkgrTEVJczRE?=
 =?utf-8?B?ZldsUU5vZy9EYmt0dzZuWktBMHNZMWZqUWpCdi9jWTVYQXRRVXZxRGhxMzJu?=
 =?utf-8?B?S053cTE2cmVLSjBSZVkvY1drRmJ1aDIrYU9jSHF2OTRHNTUyQVRUeThQNHFs?=
 =?utf-8?B?bk1ESGNEbG5qaWRuV0gvZVRYT1o1UDFRbHV1Z1plbUQ3cS9DUFUySiswNkEz?=
 =?utf-8?B?YjZXWmF5STN2eERqSHJuVDZKanhYRWsrTVd5SVU4YnIySWt2NkhoUDcvMmRQ?=
 =?utf-8?B?Q201ME84cEp6UGtEOEFzMEFQclB5U0dYYjROV21LVXZ4RFpXWjJENmFZY2NK?=
 =?utf-8?B?QjVrMUU5endjaXNuYzk4RnQramdCL3pkUWlwSzZHSDBLOE9VMktvT29OZVhJ?=
 =?utf-8?B?Wm9URG9GU01ia1lKc0kwQW84RVprRENUd1dqZ2NDdElYSW1INmJab1lIbVl2?=
 =?utf-8?B?RzVSU0hINEhuZjArNElGeTlxb1RsTFBnYU9wNmV3dlhpSjl2VkpaOUtPSGlY?=
 =?utf-8?B?Ylo3c2FHNVMyYWhPVzJ0SDc5cHk0RjFCVmMxK1M2UFN0T3VrVFl4eWRvQmo2?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0706E995B07D1E4B87A2B7267F336CC7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afdd74e2-3b01-4d14-4925-08da85f9ce2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 17:55:17.8015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JZFi2C29sEib7AMmYoT9iR/Lrv7ma88U+PwwuZqLQZuLcjnbdNIEUCqR7L5NN9SW3bwcfj/7FsVHrwqjMffNohiazj5cvpEkxH9qwkNG3nQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2553
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjQvMDgvMjAyMiAxODo0NCwgSGVpa28gU3TDvGJuZXIgd3JvdGU6DQo+IEFtIERpZW5zdGFn
LCAyMy4gQXVndXN0IDIwMjIsIDIwOjMzOjE4IENFU1Qgc2NocmllYiBDb25vciBEb29sZXk6DQo+
PiBGcm9tOiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPj4NCj4+
IFdoaWxlICJyZWFsIiBoYXJkd2FyZSBtaWdodCBub3QgdXNlIHRoZSBjb21wYXRpYmxlIHN0cmlu
ZyAicmlzY3YscGxpYzAiDQo+PiBpdCBpcyBwcmVzZW50IGluIHRoZSBkcml2ZXIgJiBRRU1VIHVz
ZXMgaXQgZm9yIGF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkDQo+PiB2aXJ0IG1hY2hpbmUgZHRicy4g
VG8gYXZvaWQgZHQtdmFsaWRhdGUgcHJvYmxlbXMgd2l0aCBRRU1VIHByb2R1Y2VkDQo+PiBkdGJz
LCBzdWNoIGFzIHRoZSBmb2xsb3dpbmcsIGFkZCBpdCB0byB0aGUgYmluZGluZy4NCj4+DQo+PiBy
aXNjdi12aXJ0LmR0YjogcGxpY0BjMDAwMDAwOiBjb21wYXRpYmxlOiAnb25lT2YnIGNvbmRpdGlv
bmFsIGZhaWxlZCwgb25lIG11c3QgYmUgZml4ZWQ6DQo+PiAgICAgICAgICdzaWZpdmUscGxpYy0x
LjAuMCcgaXMgbm90IG9uZSBvZiBbJ3NpZml2ZSxmdTU0MC1jMDAwLXBsaWMnLCAnc3RhcmZpdmUs
amg3MTAwLXBsaWMnLCAnY2FuYWFuLGsyMTAtcGxpYyddDQo+PiAgICAgICAgICdzaWZpdmUscGxp
Yy0xLjAuMCcgaXMgbm90IG9uZSBvZiBbJ2FsbHdpbm5lcixzdW4yMGktZDEtcGxpYyddDQo+PiAg
ICAgICAgICdzaWZpdmUscGxpYy0xLjAuMCcgd2FzIGV4cGVjdGVkDQo+PiAgICAgICAgICd0aGVh
ZCxjOTAwLXBsaWMnIHdhcyBleHBlY3RlZA0KPj4gcmlzY3YtdmlydC5kdGI6IHBsaWNAYzAwMDAw
MDogJyNhZGRyZXNzLWNlbGxzJyBpcyBhIHJlcXVpcmVkIHByb3BlcnR5DQo+Pg0KPj4gUmVwb3J0
ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+PiBMaW5rOiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC1yaXNjdi8yMDIyMDgwMzE3MDU1Mi5HQTIyNTAyNjYtcm9iaEBr
ZXJuZWwub3JnLw0KPj4gUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAu
Y29tPg0KPj4gLS0tDQo+PiAgLi4uL2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL3NpZml2
ZSxwbGljLTEuMC4wLnlhbWwgICAgIHwgNSArKysrKw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL3NpZml2ZSxwbGljLTEuMC4wLnlhbWwgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvc2lm
aXZlLHBsaWMtMS4wLjAueWFtbA0KPj4gaW5kZXggOTJlMGY4YzNlZmYyLi45OWUwMWY0ZDBhNjkg
MTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJy
dXB0LWNvbnRyb2xsZXIvc2lmaXZlLHBsaWMtMS4wLjAueWFtbA0KPj4gKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL3NpZml2ZSxwbGlj
LTEuMC4wLnlhbWwNCj4+IEBAIC02Niw2ICs2NiwxMSBAQCBwcm9wZXJ0aWVzOg0KPj4gICAgICAg
ICAgICAtIGVudW06DQo+PiAgICAgICAgICAgICAgICAtIGFsbHdpbm5lcixzdW4yMGktZDEtcGxp
Yw0KPj4gICAgICAgICAgICAtIGNvbnN0OiB0aGVhZCxjOTAwLXBsaWMNCj4+ICsgICAgICAtIGl0
ZW1zOg0KPj4gKyAgICAgICAgICAtIGNvbnN0OiBzaWZpdmUscGxpYy0xLjAuMA0KPj4gKyAgICAg
ICAgICAtIGNvbnN0OiByaXNjdixwbGljMA0KPj4gKyAgICAgICAgZGVwcmVjYXRlZDogdHJ1ZQ0K
PiANCj4gaG1tLCB3aGVuIHNldHRpbmcgdGhpcyB0byBkZXByZWNhdGVkLCBkb2VzIHRoaXMgbWVh
biBxZW11IHdhcyBjaGFuZ2VkDQo+IHRvIG5vdCB1c2UgdGhhdCBjb21wYXRpYmxlIGFueW1vcmU/
DQo+IA0KPiBJLmUuIHJlYWRpbmcgZGVwcmVjYXRlZCBJJ2QgYXNzdW1lIHRoYXQgdGhpcyBpcyBr
ZXB0IGFyb3VuZCBmb3Igb2xkIHFlbXUgYnVpbGRzPw0KDQpJIGRpZCBub3QgbWFrZSB0aGF0IGNo
YW5nZSB0byBRRU1VLiBGcm9tIHYxIFswXToNCg0KUm9iOg0KPiBDb25vcjoNCj4+IEluIGFybSdz
IHZpcnQuYyB0aGV5IHVzZSB0aGUgZ2VuZXJpYyBnaWMgY29tcGF0aWJsZSAmIEkgZG9uJ3Qgc2Vl
IGFueQ0KPj4gZXZpZGVuY2Ugb2Ygb3RoZXIgYXJjaHMgdXNpbmcgInFlbXUsZm9vIiBiaW5kaW5n
cy4gSSBzdXBwb3NlIHRoZXJlJ3MNCj4+IGFsd2F5cyB0aGUgb3B0aW9uIG9mIGp1c3QgcmVtb3Zp
bmcgdGhlICJyaXNjdixwbGljMCIgZnJvbSB0aGUgcmlzY3Yncw0KPj4gdmlydC5jDQo+DQo+IEkg
dGhpbmsgd2UncmUgcHJldHR5IG11Y2ggc3R1Y2sgd2l0aCB3aGF0J3MgaW4gdXNlIGFscmVhZHku
DQoNCj4gSSdtIG9uIHRoZSBmZW5jZSB3aGV0aGVyIHRvIG1hcmsgaXQgZGVwcmVjYXRlZCB0aG91
Z2ggaWYgdGhlcmUgaXMgbm8gDQo+IHBsYW4gdG8gJ2ZpeCcgaXQuIERvZXNuJ3QgcmVhbGx5IG1h
dHRlciB1bnRpbCB0aGUgdG9vbHMgY2FuIHNlbGVjdGl2ZWx5IA0KPiByZW1vdmUgZGVwcmVjYXRl
ZCBwcm9wZXJ0aWVzIGZyb20gdmFsaWRhdGlvbi4NCg0KTXkgaW50ZXJwcmV0YXRpb24gd2FzICJk
byBub3QgdXNlIHRoaXMgY29tcGF0aWJsZSBpbiBhbnkgbmV3IGRldmljZXRyZWVzIi4NCg0KSSBk
b24ndCByZWFsbHkgaGF2ZSBhbnkgc3Ryb25nIGZlZWxpbmdzIGhlcmUuIE1heWJlIHRoZSBkZXNj
cmlwdGlvbiBpcw0Kc3VmZmljaWVudD8NCg0KVGhhbmtzLA0KQ29ub3IsDQoNCjAgLSBodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC1yaXNjdi8yMDIyMDgwOTE0MTQzNi5HQTE3MDYxMjAtcm9i
aEBrZXJuZWwub3JnLw0KPiANCj4+ICsgICAgICAgIGRlc2NyaXB0aW9uOiBGb3IgdGhlIFFFTVUg
dmlydCBtYWNoaW5lIG9ubHkNCj4+ICANCj4+ICAgIHJlZzoNCj4+ICAgICAgbWF4SXRlbXM6IDEN
Cj4+DQo+IA0KPiANCj4gDQo+IA0K
