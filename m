Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B333346B26D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 06:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbhLGFgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 00:36:21 -0500
Received: from mail-eopbgr50068.outbound.protection.outlook.com ([40.107.5.68]:31461
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234147AbhLGFgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 00:36:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCXGbcx5YXeCjVaf5EcecOE0pV+u+yghbJuclSlt7u9biLGuMnV4pP3/Yk27KsJtvXyautcHhD1KxRIyZNQklXTdxR3q+5/8gA64tqzE4xehm8rXDZ91VlSyVIeFmhiaBIxI5/PKANas3OTon7GXnZIHg9wyIO8sc3Qwg9S9W/YMva/CxIgifp2bbRwi7fb7DqqWh/IdfMWkfp6pDlGOxca1evAZO49psZko4Bj6NvkIPzNNY9QFvzOnARs6pFSu9Qcya87rHrWEnF7xa6YD1wFrs8wigH97arlt0bHQLcq5GHm6yhQF6XwY5u8vhmosEw+RiZwqvDP0pgVT/prtiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPfyVky6MQwU3PaTxjupGvwyhEMfmPGsqxiGAXpiqGU=;
 b=bDIbjTFehYsY5tf8dapeHc/hLZpM/KOm6Meo+fv4iW/b47TniRhU2doXKfGr97KHLTWQlMz18Zvs9evgUOFD7L5w0JCZVtVCvVPd4HAcGtVBcvCUhWsVIwIz3QgOdPCIaZQ3GqjqswXtmkIjh02oX3V2PMy0YuUF0qLP5w9BmiOMepScBoiy+NUydDzt0yFWH0PH7a/EZ7ocEKneshkDsnaVod8WX/c7ont8JNxVS8BFAIgqtD+EzcUPaLyYEjp8sMEFi2u5M11IfJcmfG7/O2k5rGCNToxVO8Qt7XqNitlotjuw4+8GaoxijfKR7BrYVzZ0ku9EQcK3N4nmnDTiTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPfyVky6MQwU3PaTxjupGvwyhEMfmPGsqxiGAXpiqGU=;
 b=pcn5MyRrCT9J1N46uIWlN4wzdHQvZHhZKf3pBTKm7/VzkKxBq/Nzoh9yjyhkT/ST6D+93iDmh4tgfSanJ4IRZRlu8ogDFy13PUWl1UN2VQSoPtJZ3yW7UpMmtyxsPmlmlCM51fdByaTilbsfS42E+4GjWsxG6eDYrUXNzDcbmHE=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0302MB2732.eurprd03.prod.outlook.com (2603:10a6:3:f0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Tue, 7 Dec 2021 05:32:47 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::544e:754:6241:aa7f]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::544e:754:6241:aa7f%6]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 05:32:46 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Baruch Siach <baruch@tkos.co.il>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>, Tony Lindgren <tony@atomide.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Thierry Reding <treding@nvidia.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-unisoc@lists.infradead.org" <linux-unisoc@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
CC:     Ray Jui <rjui@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Keerthy <j-keerthy@ti.com>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2 1/3] gpio: Get rid of duplicate of_node assignment in
 the drivers
Thread-Topic: [PATCH v2 1/3] gpio: Get rid of duplicate of_node assignment in
 the drivers
Thread-Index: AQHX6qPlbNC/xZaZB0uM50SVI3g84awmgnGA
Date:   Tue, 7 Dec 2021 05:32:46 +0000
Message-ID: <c5464ae4-d8e9-6fab-4855-3ca1ba58d705@fi.rohmeurope.com>
References: <20211206131852.74746-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211206131852.74746-1-andriy.shevchenko@linux.intel.com>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a59a12dd-6973-432c-2a9c-08d9b943005d
x-ms-traffictypediagnostic: HE1PR0302MB2732:EE_
x-microsoft-antispam-prvs: <HE1PR0302MB2732B1150C7F3ECAC7FF3644AD6E9@HE1PR0302MB2732.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sxxlaCytz7SgGEZz6QCsHFfuItTQnpZ9SrpWlKlUuzHJYqFgkGkJrJb84rDrE45zhc0ZoT9Va5Ncj2Ev4zK/ICX4wmePK0oHjQIkkAnJfjK4meG+gptWgjbGpZ0iODlg11ezncupkaU5fINSYA0TiZoknSIILuOCrvH173TQvWKKjoQKfh/mdAHpc9Bog+C85hUBR3M+WPx0VpyFel2hlYsybwluFk+gQuQEPvcnZ0w3sUfxyahVoBhICOAvD7+9QwuvQj0r5QxsPvYd+KjZgmirRwgptJr573sOX++jCF3rQIT2t4JyMaY8Vy0+grUtI7mdKgDZbCjeME3FQk/1ZfDjsktB5ueVaB30I3LeLo26ZVHToWHY917ZPItn+4P2QABLpg1sApBA4Lnkmu1jsaWmyVv9tE6sAA0rXbNMLUPYnQuWWTIwPuhdWA8aTYC4hSwjqcZYP2cjPWSDP6PlJsf4oBbCaOGuiIzIEdzaFX47JNmutniC/NyUsvxNrNobhgiLiOGVz4KhGOIZpi0IFZaoC6u/tNw6yEBOlVUat//x320zLbGrGQ102doiTqZnlHdr4XgQiR5j75GqPGFICxkR63NlnI44E9PS32VftgeWXa8TInUB05azti0cFbOfXYxSfeAjv82GyWkXpyitOdiVSPeJk+OCqOWIJo05i570tijfN9uzYMHO9dfCWU3nvsOAPeYtzmtgX2cajdEZla4rnP0aQY/Gic35o9YjgEMDL4T0yx8fAV7GbwaDbuM221On6nhThbqf5AppCPVfYIuZq9B7j3c+A8aM0kpoSCeyFv7efgPd6J3ymxDMureg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(53546011)(71200400001)(186003)(86362001)(6506007)(4326008)(6512007)(38100700002)(76116006)(31696002)(6486002)(122000001)(83380400001)(38070700005)(64756008)(66556008)(66446008)(7416002)(8936002)(7406005)(66476007)(2906002)(508600001)(316002)(110136005)(66946007)(54906003)(4744005)(921005)(8676002)(5660300002)(2616005)(26583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzZRMkhQSWxUUGtreWZqZ0h3VmMrZjh0WVh6TWFOOWZrZVBrVTVZOXowLzVI?=
 =?utf-8?B?N2pKajczSGVtY1F5Y0VyRVJXNTR5OXRlSHRhUGM2MDVlaU85OUJlT21Rb0FX?=
 =?utf-8?B?TTE3aUhWVnRRMVJsMWRqL2cxQVJXSHgrTTUrbHJiRGwxQmdzazJlSDVkUXR4?=
 =?utf-8?B?Wm5DK1NjSzNHUGIvanpGMkozZnRocDFoVEJFRWROWFcrb0FubkhiSW5LVC85?=
 =?utf-8?B?bzJZYWx0bnJGTHpFTWZtSWFyS2tiMjJUMmxrYm9QamRHSHNtSFB1cHZyaEYr?=
 =?utf-8?B?aHl3UDEwT3UxajUvaW9oMHd2clNvTGJwYWhLVzlNc1BwbVR3MGZlT214bFhy?=
 =?utf-8?B?NG1KK3lCL1p6NmJJTEppZm45ekJ1R0VBZlMyYU9RcHpjdlE3VGRzN2tvNkNE?=
 =?utf-8?B?SDBHcVF1R3BYQjI2NnRxbkpITytHOC92VVVoNnpoRkpxZDUzVmpiRVpJNXVp?=
 =?utf-8?B?ZTlicWdzVVFhRjNKOENBY3RVYUdpelkzTnh0SXBGWFhseWpWUUMzOE90eTMy?=
 =?utf-8?B?Z0I1a3FVczFEczNyS1ZNc3E3WmZBU1JieldwcTdlbWVjaXRXNmJhdG94TERJ?=
 =?utf-8?B?emtGd0JrTVJwbVVOQlVpL3hobGRMTHJlZWdueldnZ2VFbVVwSEViMlB3UjFY?=
 =?utf-8?B?a0FwRExyaWl4a1Y5amlOSXlwWEhPelV3OW11cWJSWGRJU2wyQ3VhWmdXZVds?=
 =?utf-8?B?Q2RpN25NajN2R2gzZ2VjVWRWZDI5VGpQem9mNXhtd0pVSnphNEFyRUpuaUs5?=
 =?utf-8?B?VlBRSVZJUEptK3p1YmxoaGlsVzBmNWJEQUVPZE91TzBsYjNTZjJoTlJQbTBK?=
 =?utf-8?B?ODRmVUVNZnlGbnRMWUhUUlFjVk1lZUtPZlRaMHcxUVhDdjFpdmZVSGp3WGtz?=
 =?utf-8?B?OTZ6VmwxK1ViUVB6a2plMzY5VjE5OXd2eEU2bU5QeXFqbHgxWldZcFBGSEpw?=
 =?utf-8?B?Z2ZwaENWU1JzMWhMYmI4OGdmN29xZVlwL2F0ODRmeDR0cDJDb1FGWVE3VmhE?=
 =?utf-8?B?TG8rR2NTUEZxOVZPWC8yMFJmeVR5VHNUZXFpMVBjRUFEQzVsRHVIYk1sZkdz?=
 =?utf-8?B?M0tpWDRldnVGdWRoc08zNld2Qm9UM2tvb3JiQ3c1U2VybkNhM0UzTnZ2MlFQ?=
 =?utf-8?B?ZzhPbmpvUE5tR2NTaG84bEZmY0M4ZVJJVmVWSFpyem9ZV1ZRTlozVDV3NWRp?=
 =?utf-8?B?NzZHT3Jnam9rZnFIb295bDhUbzFmcFhSUS8vVHdXWVZCcGNGQ3BIb1VyTS81?=
 =?utf-8?B?QXhMYW9aUHJGZDVSYXJsVWZxcXB4bGZkTnhaODNRZ3VxL0RGbktIdFJZcmMr?=
 =?utf-8?B?U3QzNVpiNnZVK0FvVTVvNi9mTFRsc1MvcW0wWW4yVUJVc1czQ0xqQTk1YlZ0?=
 =?utf-8?B?WFlFT1RWT1dnS2RuNVNFbTVlNEttK2lMM3lUR24wVDZOR2JYWW9BVURheDZk?=
 =?utf-8?B?aTU2Z0hkbVJMVHJ4S2VJZTh2UHFBZTBMUmlERThQZWtsWFNnRXE2Z1BlRW8x?=
 =?utf-8?B?NExQNkh5dFpRSW9BaERRdG5xR1U5NGdXUlFHS2tvVkFPMUdyeEMyYmxuMmJr?=
 =?utf-8?B?MjRtYnhZVVljRFVGQUF4bmFJR1gwTmJqUHBtQzNHN2hGVVkyS09Jd0JnZ0hR?=
 =?utf-8?B?TUdQdEhZVzR0VlpHY25Da0lwbmdiRi9CUys5YXg2aFRQdnduRnFyQ3FPREgx?=
 =?utf-8?B?ejYzb3lyMlY2VzdpSWdUclcwakEvTXNFeXBVYnhpY2s2MlI0OFd2TUh6NHRS?=
 =?utf-8?B?SU1CaFdWdEtyMVk3b0ZPS3dCNnEzck50UDVpZnVrTmZLV3huQVc0c2J1L0dC?=
 =?utf-8?B?ZXpjTktLT1FTTFdsUEVGWDhoUS9wdkxVTWY0RURqemlaM3pkNlAwYklENlAr?=
 =?utf-8?B?Q29rR2ptb2xHOW9sZjFGeThnSzdnWUpjbE5RTTRvZUdVUUUxU0w5UGdEV2pC?=
 =?utf-8?B?TERwYURybFhrVDZ3UzNtQ3NUTEVsM2FHa3hWc1RLYm1BME5EUW8xWWUxWWVh?=
 =?utf-8?B?dzEyUVZhUURDNWRTVEJ3eG9TS3JiamhmQnpGczRsem0vQlBDRTJsN3VrY0ZQ?=
 =?utf-8?B?UlhNMmtkQmhZaVRaZklZVkp2UXU3ZlQ1TlZpYTgwWFk5QWVGTXNMNkFMOFVJ?=
 =?utf-8?B?RkpqdmFBTmtUeU01dHFDTVRJREF4NVFZYTd3Uk9Rb0FGWS81dXJJVlY4bGxZ?=
 =?utf-8?B?cnp5Vlh4NXpmZWpnN0RZUFVVTW5XdC9zVnJVZm14S3JGd3Q4VTdmdjhYa0ZQ?=
 =?utf-8?B?bGh4ZkVEalZ3ZCt1L29mY3NCY011NEc0bzVjUllUdTVabEQzbDlqRnFRdWZN?=
 =?utf-8?B?RVNrNEdzMU4rNktxbHErYmNRengxTnN0L01yakJwR3UzczRTSGx2Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <127CB2431B374341B6A92C1C7D91C3D4@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59a12dd-6973-432c-2a9c-08d9b943005d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 05:32:46.6220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8dQPkrp6bQCbQMUUZZGm5Sk9KOE6hymi2KDAdTq8W+oJy/yq9Zkesb/eEtoUeP+5cAreL4ajFusG8h+6VrxO3v7iFXvhIMoc7bNk4J9YtHdYWBKjJEJyBD3ej1mCYitX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0302MB2732
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvNi8yMSAxNToxOCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBHUElPIGxpYnJhcnkg
ZG9lcyBjb3B5IHRoZSBvZl9ub2RlIGZyb20gdGhlIHBhcmVudCBkZXZpY2Ugb2YNCj4gdGhlIEdQ
SU8gY2hpcCwgdGhlcmUgaXMgbm8gbmVlZCB0byByZXBlYXQgdGhpcyBpbiB0aGUgaW5kaXZpZHVh
bA0KPiBkcml2ZXJzLiBSZW1vdmUgdGhlc2UgYXNzaWdubWVudCBhbGwgYXQgb25jZS4NCj4gDQo+
IEZvciB0aGUgZGV0YWlscyBvbmUgbWF5IGxvb2sgaW50byB0aGUgb2ZfZ3Bpb19kZXZfaW5pdCgp
IGltcGxlbWVudGF0aW9uLg0KPiANCj4gV2hpbGUgYXQgaXQsIHJlbW92ZSBkdXBsaWNhdGUgcGFy
ZW50IGRldmljZSBhc3NpZ25tZW50IHdoZXJlIGl0IGlzIHRoZSBjYXNlLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5j
b20+DQo+IC0tLQ0KPiB2MjogbWVudGlvbmVkIHBhcmVudCByZW1vdmFsIChMaW51cyksIGRyb3Bw
ZWQgY2hhbmdlIG9mIHRoZSByZW1vdmVkIGNvZGUNCj4gICBkcml2ZXJzL2dwaW8vZ3Bpby1hZG5w
LmMgICAgICAgICAgICB8IDEgLQ0KPiAgIGRyaXZlcnMvZ3Bpby9ncGlvLWFtZHB0LmMgICAgICAg
ICAgIHwgNCArLS0tDQo+ICAgZHJpdmVycy9ncGlvL2dwaW8tYmQ3MTgyOC5jICAgICAgICAgfCAx
IC0NCg0KZm9yIGJkNzE4Mjg6DQpSZXZpZXdlZC1CeTogTWF0dGkgVmFpdHRpbmVuIDxtYXR0aS52
YWl0dGluZW5AZmkucm9obWV1cm9wZS5jb20+DQoNCi0tIA0KVGhlIExpbnV4IEtlcm5lbCBndXkg
YXQgUk9ITSBTZW1pY29uZHVjdG9ycw0KDQpNYXR0aSBWYWl0dGluZW4sIExpbnV4IGRldmljZSBk
cml2ZXJzDQpST0hNIFNlbWljb25kdWN0b3JzLCBGaW5sYW5kIFNXREMNCktpdmloYXJqdW5sZW5r
a2kgMUUNCjkwMjIwIE9VTFUNCkZJTkxBTkQNCg0Kfn4gdGhpcyB5ZWFyIGlzIHRoZSB5ZWFyIG9m
IGEgc2lnbmF0dXJlIHdyaXRlcnMgYmxvY2sgfn4NCg==
