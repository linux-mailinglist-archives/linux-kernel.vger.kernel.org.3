Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924A457941B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbiGSHYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbiGSHYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:24:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD4C32D83
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658215471; x=1689751471;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HWNcnheqlmZxv0NHbiVSRCGuSM7yKHBVhZmEx+oiLH0=;
  b=r/vnflK9LD8atmebgohtEWTXz5oZgKq6DHorBWkM0GQigbw2wbninZMq
   lHOn9uEXIcVZVke8XOCUDVPzej3S2/8PwXTt0Clb6esPaAbiGxIxluoI7
   +ZVppFcSjQCM2bsJeS8Or7qrT2QOgrDMpJjvgyR6zhqa9wJI49mOXnnW4
   pYPbA2V66UufMrtXdCN4rxDL9fknYZS/HN6tEYw//4rjURPOH0LlR11Lx
   ypfYDonnOM6Cxdod7apnl+D4LLdiqzbizfuuf1hMtbm3mw3dZWz5OPZgt
   BC+atrHSN1UDQf3oOqcdl6ZZxU6UkCbZY2B51wIRwXqlVb1Z4n0q+OYSB
   g==;
X-IronPort-AV: E=Sophos;i="5.92,283,1650956400"; 
   d="scan'208";a="168459041"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2022 00:24:28 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 19 Jul 2022 00:24:28 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 19 Jul 2022 00:24:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhP50ByQzdt4Cs7zL60clDG0ldfM+eWPvTHp9O5hT6FoHQeFjEO9QTRCdJR5G9ql13vKAaOZU3tKIJTFToqIrXA2C1gdTPg20uJ833NUl5ihUiiWuhd9UF4Yv8yo7qVTbib5nhIFvl02HexacsQEE8FImhsA8CuKHV9lS0/9l52g5pD9U1Zxgj6GG1FZGQ8SPro0jgSPRM/NzDh0CUDivTM1nFIHkgSHZ7Z0a2hIRZk5F1dGr1Ix4BsLlgVjZu6sz5xh0v0jYx9d1UGYRdzGQn/wa1RizOgbX3dYiYuRD4Ib2MjffokGV/WUGsWrjkImz8C9unzMPugJvHJ1PJuFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWNcnheqlmZxv0NHbiVSRCGuSM7yKHBVhZmEx+oiLH0=;
 b=fXFaTmwgne3AiBBrkEGK6NjCM/my0Mw9C5SoSljAvyupCZ12OZbSemoPpzhUZz5R/kQDZTeQtYhaq+sKGpZBMUTWhS2CrilJvdMu5SnRjGY56nADpbwEWDs4s4rRRw9LO4FYQm2OQ/hzfC6n3FbEHMYtawe6VD6n8jB4xLgL2DFvGrsTthYhwLhymxDS1BSL82adYuBJsdT5wamDCjXc2pH/HhX/kxmf2ofgQ/FFS/M4PH9pkRFxA3j3sNjQNGKEOTVR6rq1Mpazls7lkZj9EpdkHIC/udqnhE6Qh4kGL1Y5zi+edVGbDexRRXB+jOZbSi6sfbCY15RjvdkPRNJqVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWNcnheqlmZxv0NHbiVSRCGuSM7yKHBVhZmEx+oiLH0=;
 b=tlfvh+Ds07rK60JQGSnfHtbJ+r2zBrPQlYgui8koBrMe3AA+pVCM3lpVpNZ9mEzqFgtOO61ODSdWnxRPL/DClAg5V+mPKEDkcTCufJfC0Xm/GyNEWv24LE2xhGg7QWvSXKR3wnxL95j+gl6bkRmurUQTVagxq5McZwzomzTB8tw=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 SA2PR11MB5098.namprd11.prod.outlook.com (2603:10b6:806:11c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Tue, 19 Jul
 2022 07:24:17 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4%5]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 07:24:17 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mtd: spi-nor: winbond: use SNOR_ID3() for w25q512nwm
Thread-Topic: [PATCH 2/2] mtd: spi-nor: winbond: use SNOR_ID3() for w25q512nwm
Thread-Index: AQHYlcsGaT91mZeLa0CO/P6y+1cRGg==
Date:   Tue, 19 Jul 2022 07:24:17 +0000
Message-ID: <0125cf8a-be06-e422-8e8f-157cf9dccb4c@microchip.com>
References: <20220510140232.3519184-1-michael@walle.cc>
 <20220510140232.3519184-3-michael@walle.cc>
 <735a88af-c4f1-a6b3-3f85-ea532b3f39c7@microchip.com>
 <305d3c9cf8a2362ad23a87f6ea92c6b4@walle.cc>
 <3e018ae9-66b0-0699-1121-e55c88f37570@microchip.com>
 <4ac08f08010a71e288b0114fc02d47a4@walle.cc>
In-Reply-To: <4ac08f08010a71e288b0114fc02d47a4@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1e53ea6-750e-4c8f-19a9-08da6957b0d0
x-ms-traffictypediagnostic: SA2PR11MB5098:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ax/AT4xcqeKKXbjz/I1O8YvZFvho5soQw4sxtavh7Ghatv4dwW/iba8iEObTj7FNxV8fsdn1VVJ/F7kPMlOKxbdZEoy8bhkgSyMkfrtmrQsfFo5K1ukDw7/4iBoEprcz9VY5kcUTX2q8a4sZhl6zcH8KNNxY0ifumhcemHnQ85QvsTVlN27tt1Eu0CKWak98TFSLliGS934fphXLHNotMHFJCGPPju3V0aLA5+RTgFL1JyFT0PIcic7cV0gHVBha+oKImaHxd69Od/kvu8MYEundNG0RWPfU05h8yFi3PooQA7eBpGCJ0CUf3KFxa37gO0daiZPu3FiGACu5CvHICsRIcfZrRdVGkIcSk2g8W8DnrXcj1pKVKiRJ0AEEtNFQesGDUxk4RbEe6iUWIxuKPQJww/fJZKwqX4JK4Qb/ACKxcxFKdx6xPRtwhh7PEeiUnmClNjFbjaGm/oW7WhG0HS8sZhg+s4AUpcwxFkXQe/0rmawrqIW+L7R6p6fDONil0fdlYv/bYa44Hrmg4am4I4KFLRGPUkQPuRdB1ic348XUXMBijqq6a5I0f8YJU7MizkIpfJBcMnLs0mmWB83SfXCjoBq1tWa+KPj7uR/f6U3UtIQshx0GV+xozRvCvONibPHfyLasfJv4tBWjNqWBgy9XmWVah0T7ERf22He/+hdqogqFNTTI0/DHeuGbNmB3R+XHWfVNKz9hz6w4H/ji8bZLwps1ST35KM9Uss/khLKJNFHvTHU5aLaefLnK9UXQKY56W99HR9r1aVdV38mMnxO7et/EO7VCksu5d/kxh8VP0+IU7e+ap3mHuPmQezCX0fcld26TH9NwTu5Pc6lZhzqwPNG/8USCdvRMVhe2Cb7BFXN/uLgM/cssM7BMn7Xvm3VO+fKcvHyrMAYgk8qK/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(396003)(376002)(346002)(2616005)(6512007)(31686004)(4744005)(122000001)(186003)(41300700001)(2906002)(6486002)(5660300002)(26005)(478600001)(71200400001)(76116006)(66476007)(4326008)(64756008)(8676002)(66446008)(66556008)(66946007)(8936002)(86362001)(6916009)(31696002)(38070700005)(36756003)(91956017)(53546011)(38100700002)(54906003)(316002)(6506007)(138113003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmdTRHhDUWIybStvZWYxRExaOXh3NUc1MGZZK3BTK1VudWNyTXd4cG1XaDBJ?=
 =?utf-8?B?RGVJNlRCQ2hCS3F1VXVNVWFxM1Urd3JZOE05a0JxRWJEdFRSdllYUzFJS3Jm?=
 =?utf-8?B?UzNMbDJ5cjlZZ01IVXYwMU5kdGpuSStSMjNIVSsyK3NlYkhIMW81Vzgwc3RI?=
 =?utf-8?B?V2Y1WVhCK3NNd1MvV3lTVElHMXQ4bVpoRHdtc1M1dit6VkVTd3JWbzVSVENH?=
 =?utf-8?B?UUFpc2lWODlYQU1oY3NzeFJubXdYWi9uSU81dThSZGlmOXl0ZktoY0R6YnBn?=
 =?utf-8?B?ZlYxSGtMRjhGSFRtRVF0OC9qR215MlFSa3pPUjF4RTcwVkhpZys5dS9aVDlM?=
 =?utf-8?B?SDVBeTJXaFNuT2hiUUYzSFNyK2V5ck9Eb29uZERXbXZwRkRVS1I2alo3NElr?=
 =?utf-8?B?UjB5TXdJZ1JWUXVTeU54QVYzQzVFWHdyWjVmQXI5cHdRRDBFMjdybGdkYWVk?=
 =?utf-8?B?ZXlibk5SM00xMFJ4Y05kRHlOSFYzV0hTZ0RpcVBMWVlhbWh6emRIbU5DZWpm?=
 =?utf-8?B?bUtEeTdTTjFuYi93WUcwT3Z6RVp5UmhsamZBSXlLUFh3ZnJDMHFsbTFYcmV3?=
 =?utf-8?B?UlY2dFBxbWFwM1lHZHdtV1RtV0xTS0FEdFY2MWZHemlyWWlHRUF0bmtkekww?=
 =?utf-8?B?ZHlGOVNIa3gyQStXdElvLzhERUxSdm1rRUsvaGdOMzlVcDdQbHMzYWtuUkxV?=
 =?utf-8?B?akIxaWpMcFFrMEk2eDR3UUIyNVI2VmtJcjhVN3JLaWlPYmhGRk93THBlM3pV?=
 =?utf-8?B?cHJ1cEJnYlpzN042NHBJYWdzYVZRN2o2MmljaTEyQTdPOW45dUhjSkhETkRi?=
 =?utf-8?B?UmdCSGNRVGJGSEs4V1ZDWTlmT0c2VXpuZDZXbTVueWJ0dFkwSjRUeFhySjR6?=
 =?utf-8?B?SHpWdzJGMWFveWdpSHZlOUpTQU5mZTU4R3YvNkJ5WDRmZzNBOURkeTZPTndI?=
 =?utf-8?B?UWtYKzJhaUp0MDVUQ0dFczhzcjhoaG4zMlEraDFoYmNHUDVFMFFiWlRkb0pL?=
 =?utf-8?B?dFNQd2Y4NUFYcENGOW94S2pkeXVsZ0JPRWNIQlN2NVlOaUo0cUZkOTJyL2pr?=
 =?utf-8?B?RjAyTmd1SzB6a29NMUZVNVFkcE9RckNsQ1dMTHpZYmJ3cFMyc1lxelR3cmxw?=
 =?utf-8?B?Y01TSDB6WFFVWTh5emxiNng3SUNZL3BWWVBadTFVeVlFNEVsT05aZi9NZXQ1?=
 =?utf-8?B?RUtSOEMxN3Z5YjJLbmNvcGQ2Ulp3QXM0Lzd0TjdhZFhONERDWDB4a2F3VUhw?=
 =?utf-8?B?Nnp4N2o2WHJFbzZDb3Z2K1NIa2lmeThPVUtFM1FrcllkeUR5SkhVQk9wa0cw?=
 =?utf-8?B?NmY4UXdkNHNNOU1WVmgyVHVQM1J1bXZMYTZCWmZZaGkrU3g0UjdCblUvMENt?=
 =?utf-8?B?MXFvZU8vNFZaS3BoMGpCWCtOQWFuMzVyTHk2blI1YUErbFlOSFdtdFQreUdo?=
 =?utf-8?B?RjhtRjgzN3AzaVF3eTVjYkRHWS8zbmUxOTRRS2o3RHFjTy9PeTk3Y0JmV3Nm?=
 =?utf-8?B?ZC94QUpnWXBZeDVoRjV3aHlXUG9PaDROMllkT1lCYVRpS3lLQ1hGYmZ4N2Ux?=
 =?utf-8?B?Mk1qSzdNVEhhUVBaRHdESWMvbVB0U2Rvc3Y2VUgyR1czYXJraUtraWpOM2RU?=
 =?utf-8?B?Q2V1cVdYb0JFKzBvbkQ3Q3Z5Ky83VVBCekZ0bHB3V0tVN0kySVAyR216WTFO?=
 =?utf-8?B?bjlHYis1U2dKVFJkaFNadDBTODJvS3ZJQS9JVVo5UXBqMGQ3cWZEdTZnN1p6?=
 =?utf-8?B?WXFhWG9OQ1lLM1JrM3ZIbXk2Q3o5K0VrYVkrZ01YNzhEZVUyelVhM3U5RUZu?=
 =?utf-8?B?Q0swbkpJak5UT0d2SFRKNmpsd1pYOUJJUmZONlRvTHZrc2NNaHA1bndtZ1FQ?=
 =?utf-8?B?VEZFTnBNTFlrM1Q5Z1dJRUQrdDBubTlpeWVDNVlhUUtzNGlvZTZHOWZ4aTFk?=
 =?utf-8?B?UlFMOEZtRFU4TVVjakZmTmwvVkMxLzJLYTV2ajFzbjlkV1poUHJBeUVuaW9Z?=
 =?utf-8?B?Ty9ocTQ0a05rUGV2TWlkSEVTUi9vbkJsZ28wa2VWaURGMHVzVU1lbnpETnM3?=
 =?utf-8?B?S0gwMDhLbWxXclk1VURYS043M1hNcWYwVUF4M1RYWXVLR1lBczNVa1dndWNR?=
 =?utf-8?B?ZU85KzU0L09TeXVoY0F2c2JtZGtoK0x4dlBWTGNucXR2WXRncnRkTmZWMXoz?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B2397005FECC04C8580554B2B352348@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e53ea6-750e-4c8f-19a9-08da6957b0d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 07:24:17.5220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UNbUGrlRr5VGRotu+HLstPFnE3SYGLUbLHCzwlxt+6zOEst3AEfKh7bDhLi12jbSCA3BJVxgvpIt1Bgky4AJ4esy2zgwnXqyPVV8R2iyEUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5098
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xOS8yMiAxMDowMiwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBbSAyMDIyLTA3LTE5IDA4OjAwLCBzY2hyaWViIFR1
ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbToNCj4+IE9uIDcvMTgvMjIgMTA6MjUsIE1pY2hhZWwg
V2FsbGUgd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdw0KPj4+IHRoZSBjb250ZW50IGlzIHNhZmUN
Cj4+Pg0KPj4+IEFtIDIwMjItMDctMTIgMTA6NDAsIHNjaHJpZWIgVHVkb3IuQW1iYXJ1c0BtaWNy
b2NoaXAuY29tOg0KPj4+PiBTaGFpaywgY2FuIHdlIGhhdmUgeW91ciBUZXN0ZWQtYnkgdGFnIG9u
IHRoaXM/DQo+Pj4NCj4+PiBTaWdoLiBIaXMgZW1haWwgYWRkcmVzcyBib3VuY2VzIHdpdGggIlRo
ZSBlbWFpbCBhZGRyZXNzIHlvdQ0KPj4+IGVudGVyZWQgY291bGRuJ3QgYmUgZm91bmQuIiBTbyBk
b24ndCBleHBlY3QgYSBUZXN0ZWQtYnk6IGhlcmUuDQo+Pj4NCj4+DQo+PiBXb3VsZCB5b3UgZHJv
cCB0aGlzIGFuZCBwaWNrIHRoZSBvdGhlciBwYXRjaGVzIHRoYXQgdXNlIHlvdXIgU05PUl9JRDMN
Cj4+IGFuZCBzdWJtaXQgdGhlbSBhbGwgaW4gYSBzaW5nbGUgcGF0Y2ggc2V0Pw0KPiANCj4gSSBj
YW4gY29sbGVjdCB0aGUgb3RoZXIgcGF0Y2hlcywgYnV0IHdoeSBkcm9wIHRoaXMgaWYgd2Uga25v
dw0KPiBmb3IgYSBmYWN0IHRoYXQgdGhlIGZsYXNoIHdpbGwgd29yaz8gKEJlY2F1c2UgaXQgaXMg
dGhlIHNhbWUNCj4gYXMgdGhlIHcyNXE1MTJud3EpDQo+IA0KDQpXYXMgaXQgdGVzdGVkPyBJIGRv
bid0IG1pbmQgdG8gcXVldWUgaXQsIGJ1dCBJIHRob3VnaHQgd2Ugb25seSBxdWV1ZQ0KY2hhbmdl
cyB0aGF0IHdlcmUgdGVzdGVkIG9uIGFjdHVhbCBody4NCg0K
