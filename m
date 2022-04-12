Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9B94FDED3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240436AbiDLL7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238672AbiDLL5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:57:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BE460DA1;
        Tue, 12 Apr 2022 03:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649760192; x=1681296192;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=8qAQjqpft9tI5v/7km05FenThG+ew36Aa3BCJdGV6Uo=;
  b=ymeVInkqdx9mdnJICsRVTHHbZyoGtmWRDIU/ozcSLV0Uo1a8hbu+nSJW
   0oJ5WIFtvtD42LgMuAsDIeN5aTYl+XWku4makcYelmy5n01q6pPZPZI3E
   vzKv+Imjaa1n4395d20S6Zhg6dORAjWt5ZNXTMZfFHznnenHTGhJQDq5a
   fy943g0APusHzbiBmqqApRwR+yei0KNad5TACCSmHsEEd0I2hl6V53OW1
   rHfx2LSjPFHgvIbChiduLcFu5MHQSI19cCcMPGOOKNmM/sr0Syu11dSoi
   K21/OhdGtZivRHixP2tEH8hUvZX4MQFqyvmxNxbSW6KsdiKwXmINax1Vo
   g==;
X-IronPort-AV: E=Sophos;i="5.90,253,1643698800"; 
   d="scan'208";a="160221541"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Apr 2022 03:43:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 12 Apr 2022 03:43:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 12 Apr 2022 03:43:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4Ny0D6e0UhwlCNhxHmkReY12KaFH+0h5WK8jAfiKHWGF2oOucqyFrE69w8m1jj6Px0gFbMgz7cunlvo9FQV+yrgp8zQa5+fy5488lVKMqsuiIKsuRpJn8nBDSPRdGqGveekW33yU1MafCGc2Jos2lbRzGJuoCaz7hXg+0UcGWvsei/lJJu+nWqXRU0jbKTYCLwsH8sIBTkzaCwV6/8F8vUuTqgvlsPzOEMGPCefZO07MU5r0EHldj3bNsypGlwWF17j+904ngzx1bowYPZlnTq5sShG1o0zpIwOgktvaHRq9Cn2b1+9LZx3gyuvuNaSg1hU7UkoJn3+oMyVfcR67Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qAQjqpft9tI5v/7km05FenThG+ew36Aa3BCJdGV6Uo=;
 b=WQ3fUGMdbDufP7WTGgB1W5LCNIpCbgwXv0DczU8eYAyvFJThyFoL5+CR+yBHaWztYEzYH0TLVnQylVYvc4rYb6if8nD/q+MOMrpRHbeINzAfJ0YbQmtcTN6Gu5MTetXfjeHYDhFP+0BufVMCQANwxNzBP80ALoZaF4r3BYD6TtGVq4a8XPeVfaIWzexOt+LXyyYV3qRl9nxWft/Mnf7Fk51D+MY7mLoscuMlIHTew82f1HhR+xhb3us2faWftM7CT7ktZ2SOVFsQASl6WimGfZVEt4uOXIhjIANJ5FKQU5xfoYqCWgCoNlacOT22p1xvHkoc9hhBggO9BFox3qqP7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qAQjqpft9tI5v/7km05FenThG+ew36Aa3BCJdGV6Uo=;
 b=iQR307l8wYIREEn6RpUkTVQt+sV1FDAbbhyngLxH9xQ6EqjvMbVeYgM/vTCpcSdmDPeWY8j9j/B8vr+8iYk+ky/s9j2aqusvZCFZoo+j4WEHOnJ2rrpT/jXT7BYqrc3K5QOvLg8c4bCitYGIgkwBk4tQp+IuZ72Ve4v9FILLpw8=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by MN2PR11MB3709.namprd11.prod.outlook.com (2603:10b6:208:f3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 10:43:06 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::39c7:55bc:f22f:ac8a]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::39c7:55bc:f22f:ac8a%5]) with mapi id 15.20.5164.018; Tue, 12 Apr 2022
 10:43:06 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>,
        <Lars.Povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: microchip: align SPI NOR node name with
 dtschema
Thread-Topic: [PATCH 2/2] arm64: dts: microchip: align SPI NOR node name with
 dtschema
Thread-Index: AQHYTloYCs2/JATEhUKEGhLhZb+HkQ==
Date:   Tue, 12 Apr 2022 10:43:06 +0000
Message-ID: <c8f9c4a6-9fdb-7d84-6416-c64943acb966@microchip.com>
References: <20220407143223.295344-1-krzysztof.kozlowski@linaro.org>
 <20220407143223.295344-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220407143223.295344-2-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfa8d212-617f-4d3e-58ef-08da1c713a9b
x-ms-traffictypediagnostic: MN2PR11MB3709:EE_
x-microsoft-antispam-prvs: <MN2PR11MB3709B50E6CBA9C1D9BF3D15BF0ED9@MN2PR11MB3709.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9GvcVaoBxRqLpHgyZeYCUg7MMOkUj34QMYzcCc4dU+cnBGUrCDx8pKNSfSX4VPPJ/+pawZFxVk32eiumRBmbh7wBpA2gSJKXLKkUtKOTrFb1eUe1uxCGaegERRIgLjHuXqgTYtcTsMC9g0/mll3DHwfHnaI26dHc/wG7pEpzpaxYUJgZF6lyfOLrUxaqJTnZzAYyAYz59pZR902FeJ+RMYPpREkcWYlWVg8MmakUpziv6zP1yJ/2H+qTaEUNnc06/mX9NOBYj8G+WXTC4ujwD5/5bfLmtF8QeJNhiLI3zpCoFJ0c5tyYjvbGt5y9yRorGhXt7Pu075Vo+H5QB902hMXrZnWPoka7+Ip5bRpC0EwP06Kw3aNODZwOWAfEM6vZivc9/NPKJ/WXhzOFtXL7hAHyuSn2OH28QqetBmWGRvIKz3yuzbdl6pEn8ePP/WcA2dUlHGfrVgA3dhUp3rFivfbmJTbu8hhML7KAul2ycYY+2GRZ3Ft64EuqR8G286RvqW1ku9Jpv22zTC/rDytV4Zf/MC3Bb/JLgVJOWiObq8XhWxgBTetl8haaFeTsImipgEZMcp1o72GiowN9JYOYuPEB5wtpkNcqXKeYbghQlaojKSenlE0j0ycrwnev4Exfg5Oiv0NqdAXMtANuAihJL49cli0WglkGDuJNFoOQKnjNgePYeTDt4RCSdugRFI8oQDMnO2+wAVA/ljA5PBVArhpfz73dHypJQqTipCEODpzcsNsAtSz9G8fmjSKbEPl7IgG7cTAvsjdR9pAY5SoAwmomt41BN03BuicvcCBv+ShlvwctdN2fHX0MFbNzTqIaJhM0eBiX90nwqVMeOPepnL/mtDCtxfHpVM3G6A0sxC7AZERnZToP96Kgnoks/VXB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(2906002)(66556008)(66476007)(64756008)(26005)(91956017)(76116006)(66446008)(66946007)(6512007)(110136005)(316002)(6506007)(71200400001)(83380400001)(6486002)(966005)(508600001)(8676002)(186003)(86362001)(38070700005)(122000001)(5660300002)(31696002)(31686004)(53546011)(8936002)(36756003)(2616005)(921005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTZUUDlpNFpvZHRvVm03SnlzV2NLbUwwa2E3alEvclpoeXRvbjdHKysvaXNq?=
 =?utf-8?B?WnhOSWtBSHBlL3hGcmJxZFZLVGxXSG1PRlZEaVJ6blFuT1JPR0wrazd4VklJ?=
 =?utf-8?B?NVdMdGlzMis1V1IvTDRTRG5wRGFJcFRHbjJKSjgwK3BWRnFxd0JIV1JQQWFo?=
 =?utf-8?B?S1NZVUdadDFKeDY2aXdPWlRnV1BZY1ZVR2FOdTBEWm9zVUdCZ2l6eVp6VmNs?=
 =?utf-8?B?RmVidDRiTlJpTnVuamZqa3psaTlUM2FnUlVjamY1ekY1TVVNZEFmVVNZNmEz?=
 =?utf-8?B?cDJUUjJ2VEtOM1lZZlFXRjF0cHFvMlZiL0ErNC9jQURhV3NPOVBVOWlQaWdx?=
 =?utf-8?B?UDRZdFpRWkZubHRCWkRGZ1pIWGpRdDVaVkk3QlR5MlhHQlc5Q0dLbms0YXNZ?=
 =?utf-8?B?a1VKdWFIbTRVOVVibGVmWk5Nb2xxb1hKM3FoejJFbE0zdC90STN2Nk1ZUHVG?=
 =?utf-8?B?VXJSMUpvdUxTazBzbkxXY21XS2JENlVhZkFzTU9qY3RaYnBBZ2Jlb2ZScHNF?=
 =?utf-8?B?SVJkRVp5RXJjbi9RdjdGTkltSi9RK0g1aGlHZFBwWXZETDJ5WUU0Q3o3RnZ6?=
 =?utf-8?B?TUFZMkkrc3NCU3RTZUlWYUFyeHJiU2NVOXdrVm5ER3FaWkpxQ0U5OWIvckh1?=
 =?utf-8?B?VE1LeUF2NFF5MHhYZnJhNFBob29FWlN0MXY4WThFcVZUblNoVDVTdGtGNmJW?=
 =?utf-8?B?SS9QRjhnQ1NmL01odTdUcDdlQ0lQbXBCWGpmY1RWSXllVnRPMG9maWFzaGlE?=
 =?utf-8?B?MXV2d3Z2dVl2TEpWcXNzSzRDMVVYZGpGaWZaM3BCVSt4a3Z6dGtWSnV5R3pR?=
 =?utf-8?B?eXE1UTl4SFlLU3BiMDBuZmJnUElxRlFmeVJHMUIzakRCQVZIZ2djeXJyRTlE?=
 =?utf-8?B?bXIzL1IxWjBac2I2ZHZKVms4OU53eGxpdkhaVmNQUXFRQXJhODVTOHR2Mjd4?=
 =?utf-8?B?aXVJcHpCWTN3UlhiSnRjS2RPMjFkS0hOWENzMER6OGszMU1FK1RUbXpzZjFh?=
 =?utf-8?B?ZVJ2V09lK1pjbmF4aDhHcEMwQVo0THNNSGpUbitTK1ZOc2xVVXoyN25Fak1P?=
 =?utf-8?B?WlJuYk5YbGF0dVRzQ0Z2UUJhb0tOVzBicHpJamIyaGo5ancxNk9LRGdweGtn?=
 =?utf-8?B?RkF2M3ZCQ0JkTWtUNEZTM04xT1V0aG9TQ2o2dE5qaG1hSCtyeEVPNTQ4MWFX?=
 =?utf-8?B?YTQ0cFJDMU9kTW0rZkcybm1SMlA1Zmlpb2tBSlQ0TkpHeXNqbTF2Ulkrb0tr?=
 =?utf-8?B?YnFqV01nNkFjcW1TQjBrUHc2RDZkQ0dwWnUvWXRwWGswclBsSGNZY2ZtaVlB?=
 =?utf-8?B?S1doSmdkNnZrYW5zeE5zN003YzBLZStKYWpKS2sxK045L2hyaSs0K1lxaTVW?=
 =?utf-8?B?QzJWOXlHRHBzcG9yZ25zRFlKb0NHYTBkMG83a0NMdTFzczZnQU96WmtmaTZW?=
 =?utf-8?B?eG1IR2lNL1MvSms0OGNqakhuNzZRL3p4eWZOakRkR2lacFoyaXV0WDhib1NV?=
 =?utf-8?B?NFU2bU5wY1ROcTdVQUVYRURMeGFZb05KMlV3Ym1zdVZCV0Z0ck5NNUtXUEVL?=
 =?utf-8?B?RkdlcXJodWZBd3VNcjZIM1hTMUgrN2Q3c2lZbE1BZUNuR09rTUM0UUlJaVV6?=
 =?utf-8?B?L0RDY0wwSWRYalVsVXh1dkhuTXc5azRvWGkwSU9SRllBUTdYR1RHL29DU3lt?=
 =?utf-8?B?MWFCSVFhcTY5RDdpcG9PZU1DVmoydUYzNVFibHpKeWhRR0NDM09IREdsYi9K?=
 =?utf-8?B?QlFFUHRXamFJeUVqbGYrTS9ZYTEzTWloSVAxZENVaDdJYm0yVWE3MnUvRHhG?=
 =?utf-8?B?NGd2QTZtSnhyUldSRjBveCtZaEZKc2xDMkFKcGlLdFVYN1QwNnNNTEJja3V2?=
 =?utf-8?B?cVdmdmRwOWUrRU0vT3FocmtSTTZ5U2d1RUQvN2FrM3ljTFc4KzRnNXpKRnJx?=
 =?utf-8?B?aTZ1TzVCYXZJdzgrSjlBdGJUeXNwOUhGS015YXFQTmhqK3JXVzNqMmxlbExJ?=
 =?utf-8?B?eElmTVdyYUVnRTBEUmVLdk1ScWNnRUgzaTZvOGlMUjNWV21uaytUQURTS2di?=
 =?utf-8?B?UTVTWjhkVTZwdC9XMHV3cHZIYlpWcjZXWktkSDlMaWdWWURHWU96V2FRdFA4?=
 =?utf-8?B?NEs5TDE1TmlNWVVxVnVLOStYUmY0MW55a3EweHhtY0M5NmlPVTJCOEhUcmZW?=
 =?utf-8?B?TDM0bG5mcmErWTdJcnJsWWtmMjBGMSt5V2cyYUg4N0RRaGlvWS9JNzNBd1NG?=
 =?utf-8?B?ZUFjWWJDVnhVOFJkcXROaXViKzZEbUhESGFnSU9SNXFXM1VheTVUbHhaUGMx?=
 =?utf-8?B?TDN3NU1nVm1UZXIrRnVvWWhLbTYyMVVQL2lwUDBma1NYUy9oVXBDRGt6WG1y?=
 =?utf-8?Q?JGoiQuW0U70Btg58=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DAF56600E84F345B3F886B2B5D9C6BE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa8d212-617f-4d3e-58ef-08da1c713a9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 10:43:06.5264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B5Zs1jsUeed9zrULm+4fDRKuOHC8T78nXhoaYvDFjpwBi8u8eMPSnUcpkRegNeB2juFVWUtqERk2oDx8p5akNSwVFrmP52yKIQdB8VEQzh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3709
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC83LzIyIDE3OjMyLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFRoZSBub2RlIG5hbWVzIHNob3VsZCBiZSBn
ZW5lcmljIGFuZCBTUEkgTk9SIGR0c2NoZW1hIGV4cGVjdHMgImZsYXNoIi4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJv
Lm9yZz4NCg0KUmV2aWV3ZWQtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9j
aGlwLmNvbT4NCg0KPiAtLS0NCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWljcm9jaGlwL3NwYXJ4
NV9uYW5kLmR0c2kgICAgICAgICB8IDIgKy0NCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWljcm9j
aGlwL3NwYXJ4NV9wY2IxMjUuZHRzICAgICAgICB8IDQgKystLQ0KPiAgYXJjaC9hcm02NC9ib290
L2R0cy9taWNyb2NoaXAvc3Bhcng1X3BjYjEzNF9ib2FyZC5kdHNpIHwgNCArKy0tDQo+ICBhcmNo
L2FybTY0L2Jvb3QvZHRzL21pY3JvY2hpcC9zcGFyeDVfcGNiMTM1X2JvYXJkLmR0c2kgfCA0ICsr
LS0NCj4gIDQgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWljcm9jaGlwL3NwYXJ4NV9u
YW5kLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21pY3JvY2hpcC9zcGFyeDVfbmFuZC5kdHNp
DQo+IGluZGV4IDAzZjEwN2U0MjdkNy4uY2UwNzQ3ZmQ2NDQ0IDEwMDY0NA0KPiAtLS0gYS9hcmNo
L2FybTY0L2Jvb3QvZHRzL21pY3JvY2hpcC9zcGFyeDVfbmFuZC5kdHNpDQo+ICsrKyBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvbWljcm9jaGlwL3NwYXJ4NV9uYW5kLmR0c2kNCj4gQEAgLTE5LDcgKzE5
LDcgQEAgc3BpQGUgew0KPiAgICAgICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+
ICAgICAgICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gICAgICAgICAgICAgICAgIHJl
ZyA9IDwxND47IC8qIENTMTQgKi8NCj4gLSAgICAgICAgICAgICAgIHNwaS1mbGFzaEA2IHsNCj4g
KyAgICAgICAgICAgICAgIGZsYXNoQDYgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBjb21w
YXRpYmxlID0gInNwaS1uYW5kIjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgcGluY3RybC0w
ID0gPCZjczE0X3BpbnM+Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgICBwaW5jdHJsLW5hbWVz
ID0gImRlZmF1bHQiOw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9taWNyb2No
aXAvc3Bhcng1X3BjYjEyNS5kdHMgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21pY3JvY2hpcC9zcGFy
eDVfcGNiMTI1LmR0cw0KPiBpbmRleCA5YmFhMDg1ZDc4NjEuLmRiZjhjMWQ0OGEwMiAxMDA2NDQN
Cj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9taWNyb2NoaXAvc3Bhcng1X3BjYjEyNS5kdHMN
Cj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9taWNyb2NoaXAvc3Bhcng1X3BjYjEyNS5kdHMN
Cj4gQEAgLTQ3LDcgKzQ3LDcgQEAgc3BpQDAgew0KPiAgICAgICAgICAgICAgICAgI2FkZHJlc3Mt
Y2VsbHMgPSA8MT47DQo+ICAgICAgICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gICAg
ICAgICAgICAgICAgIHJlZyA9IDwwPjsgICAgICAvKiBDUzAgKi8NCj4gLSAgICAgICAgICAgICAg
IHNwaS1mbGFzaEA5IHsNCj4gKyAgICAgICAgICAgICAgIGZsYXNoQDkgew0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImplZGVjLHNwaS1ub3IiOw0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICBzcGktbWF4LWZyZXF1ZW5jeSA9IDw4MDAwMDAwPjsNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgcmVnID0gPDB4OT47ICAgIC8qIFNQSSAqLw0KPiBAQCAtNTksNyArNTks
NyBAQCBzcGlAMSB7DQo+ICAgICAgICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4g
ICAgICAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPiAgICAgICAgICAgICAgICAgcmVn
ID0gPDE+OyAvKiBDUzEgKi8NCj4gLSAgICAgICAgICAgICAgIHNwaS1mbGFzaEA5IHsNCj4gKyAg
ICAgICAgICAgICAgIGZsYXNoQDkgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRp
YmxlID0gInNwaS1uYW5kIjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgcGluY3RybC0wID0g
PCZjczFfcGlucz47DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHBpbmN0cmwtbmFtZXMgPSAi
ZGVmYXVsdCI7DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21pY3JvY2hpcC9z
cGFyeDVfcGNiMTM0X2JvYXJkLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21pY3JvY2hpcC9z
cGFyeDVfcGNiMTM0X2JvYXJkLmR0c2kNCj4gaW5kZXggMzNmYWYxZjMyNjRmLi42OTkyNTZmMWI5
ZDggMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWljcm9jaGlwL3NwYXJ4NV9w
Y2IxMzRfYm9hcmQuZHRzaQ0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21pY3JvY2hpcC9z
cGFyeDVfcGNiMTM0X2JvYXJkLmR0c2kNCj4gQEAgLTI3NCw3ICsyNzQsNyBAQCBncGlvQDEgew0K
PiANCj4gICZzcGkwIHsNCj4gICAgICAgICBzdGF0dXMgPSAib2theSI7DQo+IC0gICAgICAgc3Bp
LWZsYXNoQDAgew0KPiArICAgICAgIGZsYXNoQDAgew0KPiAgICAgICAgICAgICAgICAgY29tcGF0
aWJsZSA9ICJqZWRlYyxzcGktbm9yIjsNCj4gICAgICAgICAgICAgICAgIHNwaS1tYXgtZnJlcXVl
bmN5ID0gPDgwMDAwMDA+Ow0KPiAgICAgICAgICAgICAgICAgcmVnID0gPDA+Ow0KPiBAQCAtMjg5
LDcgKzI4OSw3IEBAIHNwaUAwIHsNCj4gICAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0g
PDE+Ow0KPiAgICAgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+ICAgICAgICAgICAg
ICAgICByZWcgPSA8MD47ICAgICAgLyogQ1MwICovDQo+IC0gICAgICAgICAgICAgICBzcGktZmxh
c2hAOSB7DQo+ICsgICAgICAgICAgICAgICBmbGFzaEA5IHsNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgY29tcGF0aWJsZSA9ICJqZWRlYyxzcGktbm9yIjsNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgc3BpLW1heC1mcmVxdWVuY3kgPSA8ODAwMDAwMD47DQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgIHJlZyA9IDwweDk+OyAgICAvKiBTUEkgKi8NCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvbWljcm9jaGlwL3NwYXJ4NV9wY2IxMzVfYm9hcmQuZHRzaSBiL2FyY2gvYXJt
NjQvYm9vdC9kdHMvbWljcm9jaGlwL3NwYXJ4NV9wY2IxMzVfYm9hcmQuZHRzaQ0KPiBpbmRleCBl
Zjk2ZTZkOGM2YjMuLmQxMGE5MTcyYjUyOSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9ib290
L2R0cy9taWNyb2NoaXAvc3Bhcng1X3BjYjEzNV9ib2FyZC5kdHNpDQo+ICsrKyBiL2FyY2gvYXJt
NjQvYm9vdC9kdHMvbWljcm9jaGlwL3NwYXJ4NV9wY2IxMzVfYm9hcmQuZHRzaQ0KPiBAQCAtODks
NyArODksNyBAQCBpMmNtdXhfczMyOiBpMmNtdXgtMyB7DQo+IA0KPiAgJnNwaTAgew0KPiAgICAg
ICAgIHN0YXR1cyA9ICJva2F5IjsNCj4gLSAgICAgICBzcGktZmxhc2hAMCB7DQo+ICsgICAgICAg
Zmxhc2hAMCB7DQo+ICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImplZGVjLHNwaS1ub3Ii
Ow0KPiAgICAgICAgICAgICAgICAgc3BpLW1heC1mcmVxdWVuY3kgPSA8ODAwMDAwMD47DQo+ICAg
ICAgICAgICAgICAgICByZWcgPSA8MD47DQo+IEBAIC0xMDQsNyArMTA0LDcgQEAgc3BpQDAgew0K
PiAgICAgICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ICAgICAgICAgICAgICAg
ICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gICAgICAgICAgICAgICAgIHJlZyA9IDwwPjsgLyogQ1Mw
ICovDQo+IC0gICAgICAgICAgICAgICBzcGktZmxhc2hAOSB7DQo+ICsgICAgICAgICAgICAgICBm
bGFzaEA5IHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJqZWRlYyxz
cGktbm9yIjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgc3BpLW1heC1mcmVxdWVuY3kgPSA8
ODAwMDAwMD47DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDk+OyAvKiBTUEkg
Ki8NCj4gLS0NCj4gMi4zMi4wDQo+IA0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18NCj4gbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QNCj4g
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbA0KDQo=
