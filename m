Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6125A9424
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiIAKSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbiIAKSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:18:25 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2060.outbound.protection.outlook.com [40.107.96.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD727134D45;
        Thu,  1 Sep 2022 03:18:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jzunwbs6frkoo99RRqIfZv0q7fQnfTauvQBkjNXTAsfw6tL2dSr4v2OxaOrrACXGJpO4G5PxnPRl5xIOyAeIpr+MMJOuTrxtnEiuzUF5Mac0ZJ8JnoBO6whb0u3eO97QdqhOHFvOruqhnv65xCrbkHl+xskCa0QSE7lLvV6dOSh5aVq7T2sX4JBpaY68qmz2Fr9ncj/zakzf4GVKQAG8bIxDBqY7RL9hpWdPHAwfUhbfPgKGWUVlDR1A924BWY3OFhhZ6Xpc8ljYS3OAKTeGunmxEFIHsFE2spsK1BpG28ly9g5TK6zhsNiRl+Uum7LF6Bz+dt7p7DtMpV62z3pkLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RKMBKZ7KJFlnIVzYlzCbctORV09sU18Ig7OcHcmchM=;
 b=MQhVBEbfoQeZuNU8vSuQzC753SZfCW6bc+WtssTY9ChOiJY1+R21iNAXLdVGHa3NWtkTvcswgUv32CpQ3tEmwrowxvcUgc1uYKJznGwLbyTkIAE+UsTyJ4oYpjg6ccibfd6CkSNM4nJeo6KuEHUhNcPxasFA1SaXSq2lDnuc95cZAjCabEYXk5hDy9gkWDDTfLl0Fn5hXDn6XQtm2mCV1ANFlung1lISdNUaV0HqPx4tnPfcr44W4cEyc3dO/5AGeHhwQ+6cLpUiA/D6SZlCn6VOcWwYcG+rBwBuASgqhhU0NvPtY3dzi4cxpESmo7jqXahOP0A/yPCk2QA9D8mK0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RKMBKZ7KJFlnIVzYlzCbctORV09sU18Ig7OcHcmchM=;
 b=FBNV9+bKSA13oHUHAvOMLyp5Qi6g986XdEdPHNQFufdfFOvB17Iey8eSCjA/zvSDybgtPZrJbmen3xNS2e9JJ6rgpG2NOvMJYnGcQa8AtXeQzftD2LapTXdepXA85Yf+xBiAB2v+NgAkmSFIIu/lDpUyFGweM923VHHOdDu59uw=
Received: from BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 by SJ1PR12MB6049.namprd12.prod.outlook.com (2603:10b6:a03:48c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Thu, 1 Sep
 2022 10:18:21 +0000
Received: from BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::f5a1:c4e7:9c3e:3231]) by BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::f5a1:c4e7:9c3e:3231%4]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 10:18:21 +0000
From:   "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v2 1/2] dt-bindings: mtd: spi-nor: Add reset-gpios
 property
Thread-Topic: [PATCH v2 1/2] dt-bindings: mtd: spi-nor: Add reset-gpios
 property
Thread-Index: AQHYvdS4ASUG0YLBMESpOo8Y2+hFjq3KNPqAgAAafiA=
Date:   Thu, 1 Sep 2022 10:18:21 +0000
Message-ID: <BY5PR12MB4258128603AA297DD8FAB168DB7B9@BY5PR12MB4258.namprd12.prod.outlook.com>
References: <20220901072914.30205-1-sai.krishna.potthuri@amd.com>
 <20220901072914.30205-2-sai.krishna.potthuri@amd.com>
 <6b06f88e-128d-7ce6-b97b-b5cacfc4834d@linaro.org>
In-Reply-To: <6b06f88e-128d-7ce6-b97b-b5cacfc4834d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8268241-fc7a-437a-b09f-08da8c034bee
x-ms-traffictypediagnostic: SJ1PR12MB6049:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Yfw2VjoP7cW3dc00QLD9yPeghc6o+T2QaLsKRd0ot6aotegbXFLW3uzBMYBjZPqxQycdtR9arYc7bjizc/dE88yUila/tuBaPX+z89MgLVV6AiNi2LBScFbVyVNgZgsRMd2X6geQ9gCyL7IkMvt2rrLasYijjf0u75ZvrA4RKzOyAmnjjOcs+dTTVkTQ5Ifh3V/9gQdhpGoUVNOw4v/8ZtCMvxoCfSJjEwM6zUSooUTjmj6zebb/eTSHh5PPl1t5PdRPZcoVIRjVbqRyrQVVMNZ3UzBmDzj1y++b1Ps2MZUgdjW7mWo/cj/ZLkDbIbaI/wp8ymfGIqVIecUIKC7WYxxslBFMHVsmA463naGn7rTMadD5fwDl6nODPKYiA63yT5tKNOobYstecoH4pAIfvE2hPj396KIGKNSHoTSYlRHUY5ShqaeGOt5FdwwoB7j3htnLSkE7lNzHVgPV0xOn6mgvBqbFDp65Yw9vlPTlNMrfSOTmu9yoy/OOWh3qNA1zdKLYTdjXXf+Whe5j1ZSJAPnK4XSIpOLGsFX8uWqsxTHcTT/tEfLyG3uh2RtNkhy+u0TN5NzjFmnZ7CkOeg81Vn0A/lr802D7ZxbsNZK/zArDWMYk9iGfb7yea4cc9nAoYwFAeVABbuA/DIBEIlxnYlUHLA/vT9mpxwXAaESdq5GhBmxv3haVpPXrX56eZ7jTVoU2yeiUNKjkMZOXPAnBTMY2OFnFivwiP/AI2zot3albtFKwD7zaqHms8bsA23O1eTjZbnMOJANeP7yNdCuZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4258.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(53546011)(86362001)(71200400001)(9686003)(478600001)(7696005)(41300700001)(6506007)(83380400001)(186003)(122000001)(38100700002)(55016003)(38070700005)(54906003)(66476007)(66446008)(8936002)(110136005)(8676002)(52536014)(7416002)(76116006)(4326008)(5660300002)(66556008)(66946007)(64756008)(316002)(2906002)(26005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXpOMjROZjI5WTRicXF5Mis5V0VCaHZseXZxYUttcXpCc21NVEhmbW9NTjZI?=
 =?utf-8?B?cDlaRzVDTHZpSWJ5cXZsQmJUekpONU4rNVUxcHM4RU4vRHk0bHM1Z2szUmxm?=
 =?utf-8?B?NldmbG9mL0xkTVZiQ1B6QnVjL3dUa1hadnFva2pNNFo4RWVmZUgrOE95VElD?=
 =?utf-8?B?YXFsS1IrZ2d3b09nZXVTOG4wbjIzOXU2K0xQNUZBRE81NFF0TUxjUEFQNXdT?=
 =?utf-8?B?cUxxK0hRQ0NYNDl1RmF2MmdqSFpPdzN3bnY0dDRqKzBVVjNDb2ZLc3ZsVE5X?=
 =?utf-8?B?c1Z4Ujc0aHNLOE5WZHFhVlZlYVdSRHNvaDAxejN0T25LVHl1WE1OVVdyQks4?=
 =?utf-8?B?OXl5SFJHNjE5eDdEdnp3MzRjN2FHdWVKU3FuNGk3bmJwSkQweGFrdTQyemI2?=
 =?utf-8?B?TkZTRDdTdzZkZ0dOM3RySmZ3Rkd4TTBDbGhmUVpKN25jZlpZU2cwdThTLzln?=
 =?utf-8?B?TlRrNG1obElEbUpYc1JmSWFnQXk3c2pzNjU1ZEtVSE9RT3c0SXh4cERIYWpl?=
 =?utf-8?B?aDRXY0VWbmdiUkNiUzB5NkROZjZSSFM5KzFHZkF0Y0lNcmZuWEUxOVNWM01C?=
 =?utf-8?B?YUFGS3RlR2NpemxpNjlTWXRQT2J0ZGloYWhBanJveXQwMTd5VWVMcjdrSFdO?=
 =?utf-8?B?Wm5iNFpFeStZOFo5ZW1Ya0dUV2ZCUXFyeWZmdS9yWVNhQkN0TUl5cytWTlNn?=
 =?utf-8?B?S1ovdGFOSE82OHNDUG5BOHM0a3FZdWhuT09TYkZoQkkwbktXSWlJZ3lweEtn?=
 =?utf-8?B?eVEzZ1V0NkhmRk1pMGVuN3VVOGRyMWJlUHhOZjN1R0NBdlNrQmEzZy9obDYy?=
 =?utf-8?B?bUx5WmVXWjBVbVlsWHZ2SkpacGdtdm5nMmU2aGR3dzVZVDlJQldGV1FSRWx2?=
 =?utf-8?B?STRkamNYQ0t5MElNb0FKMVZiZUJPYnErbmJsMVNzelN0SVYwZjNuS2lpMUdy?=
 =?utf-8?B?VGlJdFd0NGFxU3MzWUt4RklhT2c3NFJUQUQ3NHFSWGdyWnNRK2FlK1lWQ2ZB?=
 =?utf-8?B?czA1S1RkQzBRWmRjNDJtY2pEYW16bUQ5dDVwbmk2aUhmem1qdHg0SW9KYjBl?=
 =?utf-8?B?Z2VhVng0ZTJyazFuNk1LZHN3ei84UWdYOFFQRW9FOVZhQkc0NnlnSG5xaFdV?=
 =?utf-8?B?RFo0V1N0QUJvMEV2UjlqeWJjREhya3Q0REsrc25COCtBcVR3WGxOdmVPV2RR?=
 =?utf-8?B?ZXloS01LeTZIMS9FdzVZaFQ5aHVvSlBCK3ZvaE12eUJhb2thMm5FV2duNGdU?=
 =?utf-8?B?L2R1dU05czBEZUo1YTdxTi9jTGV5Uk9pOWNLTDN4dDVkQ0kzMEJkNURpRVBU?=
 =?utf-8?B?emdPSkpnMFpxQ0UwYmE5aXExWW03ZzU1aVRMc0YycFM2cEpmM0VhTkdWdlZV?=
 =?utf-8?B?VGhlNkFvR3g4VWFlY1dSaVJZY0FTdFhOODg4ZGV6ZFBrT3Y4Sm9rYjJUckhy?=
 =?utf-8?B?d1c1QmpwWFFNQ1k2WFo3M1l5SFdCaDY5TnZraXE1bTBITGZINzFoM240cGxj?=
 =?utf-8?B?RnptWnduL0dSWXpjVVJoQ0dmcTBYRlVPNmdKc2xRYVFQelIxUFVseUYxN0ht?=
 =?utf-8?B?S3RjVDE5TC9JRXE5Z2gxMGk1cGNPenh0Z3dSd2pCWi9hSFFIWXJSR1RUN3BX?=
 =?utf-8?B?d1pIYU51Zko1c2lqZkwwa1ZWVnR4amJKelFJTWFxWXQ2VGVjWFQyRDZRTHlk?=
 =?utf-8?B?Q3ZHd3JRMkVxcUNvUmZBcWlKQzdONyt4STlRdm1zTDVVaVVYblZvVEZJYTNQ?=
 =?utf-8?B?WmlTK0VhTFFZdDA4aG9OK2dVdU9aaEVGTUQ5bXVGai8xSkk3TXhZUU1wWmYx?=
 =?utf-8?B?Y0pQclNwVEJMVDNBcUlOblllTndRT2hvRm84cWt2RCtFQ0J6Wlh4VjFpTkN4?=
 =?utf-8?B?V0JUYUlyQWpiYjFpMitnYVlneUdJUmI5VVM5dGVLcTRtaEl5Zm5IbEZhUzNQ?=
 =?utf-8?B?eENORGZTR3k3UHc0UVFIWHNzS0hYYVJSYVZHOEcvNDVRSDB0MnY5N0NkYU5V?=
 =?utf-8?B?cXpCeW5icldlbnJxL3VwWjlLS24zU2s2UlFOTVNxcW1SUWFIRU1IdWpFNlNZ?=
 =?utf-8?B?Z09FVldqd1FLUEl1VDRTOVVNTTV6eUV3NGVVQVF3NFQ0aUdZSTlsNW0zeEQ2?=
 =?utf-8?Q?ge24=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4258.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8268241-fc7a-437a-b09f-08da8c034bee
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 10:18:21.2758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vb/q63bAialoIZEvUUkcPwF/aVUrjOz1/um5FXgjEwU3sSsNMn3yuFuXB+vXuZyzm5JQUOljLBhJxMWHydk0tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6049
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEty
enlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2Vu
dDogVGh1cnNkYXksIFNlcHRlbWJlciAxLCAyMDIyIDE6MjYgUE0NCj4gVG86IFBvdHRodXJpLCBT
YWkgS3Jpc2huYSA8c2FpLmtyaXNobmEucG90dGh1cmlAYW1kLmNvbT47IFR1ZG9yIEFtYmFydXMN
Cj4gPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT47IFByYXR5dXNoIFlhZGF2IDxwcmF0eXVz
aEBrZXJuZWwub3JnPjsNCj4gTWljaGFlbCBXYWxsZSA8bWljaGFlbEB3YWxsZS5jYz47IE1pcXVl
bCBSYXluYWwNCj4gPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+OyBSaWNoYXJkIFdlaW5iZXJn
ZXIgPHJpY2hhcmRAbm9kLmF0PjsNCj4gVmlnbmVzaCBSYWdoYXZlbmRyYSA8dmlnbmVzaHJAdGku
Y29tPjsgUm9iIEhlcnJpbmcNCj4gPHJvYmgrZHRAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3ps
b3dza2kNCj4gPGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZz4NCj4gQ2M6IGRldmlj
ZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGlu
dXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHNhaWtyaXNobmExMjQ2OEBnbWFpbC5jb207
IGdpdCAoQU1ELVhpbGlueCkNCj4gPGdpdEBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYyIDEvMl0gZHQtYmluZGluZ3M6IG10ZDogc3BpLW5vcjogQWRkIHJlc2V0LWdwaW9zDQo+IHBy
b3BlcnR5DQo+IA0KPiBPbiAwMS8wOS8yMDIyIDEwOjI5LCBTYWkgS3Jpc2huYSBQb3R0aHVyaSB3
cm90ZToNCj4gPiBTUEktTk9SIGZsYXNoZXMgaGF2ZSBSRVNFVCBwaW4gd2hpY2ggY2FuIGJlIHRv
Z2dsZWQgdXNpbmcgR1BJTw0KPiA+IGNvbnRyb2xsZXIsIGZvciB0aG9zZSBwbGF0Zm9ybXMgcmVz
ZXQtZ3Bpb3MgcHJvcGVydHkgY2FuIGJlIHVzZWQgdG8NCj4gPiByZXNldCB0aGUgZmxhc2ggZGV2
aWNlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2FpIEtyaXNobmEgUG90dGh1cmkgPHNhaS5r
cmlzaG5hLnBvdHRodXJpQGFtZC5jb20+DQo+ID4gLS0tDQo+IA0KPiBZb3Ugc3RpbGwgbWlzcyB0
aGUgdXNlciAoRFRTKSBvZiB0aGlzIGNoYW5nZS4uLg0KRG8geW91IG1lYW4gdG8gaGF2ZSB0aGlz
IHByb3BlcnR5IGluIGV4YW1wbGUgRFRTIGluIHRoaXMgeWFtbD8NCg0KPiBUaGUgSkVERUMgc3Bl
YyBkaWQgbm90IG1lbnRpb24NCj4gYSByZXNldCBwaW4uIENhbiB5b3UgcHJvdmlkZSB0aGUgdXNl
cj8NClhpbGlueCBPY3RhbCBTUEkgKGNkbnMscXNwaS1ub3IueWFtbCkgaXMgdXNpbmcgdGhpcyBy
ZXNldCBwaW4gdG8gcmVzZXQgdGhlDQpmbGFzaCBkZXZpY2Ugb24gVmVyc2FsIHBsYXRmb3JtLg0K
RG8geW91IHdhbnQgbWUgdG8gdXBkYXRlIHRoZSBleGFtcGxlIGR0cyBpbiBjZG5zLHFzcGktbm9y
LnlhbWwgZmlsZQ0KdG8gcmVmbGVjdCB0aGlzIHByb3BlcnR5IGluIHRoaXMgcGF0Y2g/DQoNClJl
Z2FyZHMNClNhaSBLcmlzaG5hDQo=
