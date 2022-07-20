Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B03C57B751
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbiGTNV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiGTNVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:21:53 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425D63FA3F;
        Wed, 20 Jul 2022 06:21:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUlAiTgnc6eis4CvNaQWamQ3zvsaTGqeMbpDS3a4GIINe5S5Xajy2f3rr08wrh2roKY55v2el2SsxM3scmPO8WUqY7PcK6X1VIt8WMorHzteY+aJgevWEV7lsavYZy3dbhjqAWKF9Z15SN1qf7TkoeDIvZSNr4Y2B1Yt2eHwhcbdE/FzVn+m7SZN8Ig+Lv2Nqrs6XHehRmFiznsJqBmw1sxlL880bUlAaM9wjjp6fFa45frbIB+UjKrblT+smodQjH2TsOgSrOa9idtS7wLhdlAg7GzjHD5ovXlwn3cpNBqj/fOl003nnMavach5fMx4npZxrM1f03gUftr8wlBcig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Apsag0pAIPmi6SKOm2sistmIe4yAvLkWzbtTJu0GsPY=;
 b=h00DHIFKMF5bIYTs1wrA5AWBcgvlW5znGqxWQRn5zQM50EKWCvAMCysqkaH6M9I/FK2Y8NN+6xXgCI+MPtnnbn8LCiV0bfcvd2fOyz8VAXR1Y7rrQVP56qIlEDS52Bjsk/1lvySQg5G+O9xwhMpmXh2/FG0faaY7ol5IMUQNl9FKewFuYiQVYt8t7Dygct+UDXmADqx6deLyaO2enayPjym0rNbrTphI0SC0M7mVFCT9/2RPtGCWbZ8/QLNb12k8147iQGCxvfKIMIeWY8uKdiFevBNSbhQMvuxsqMu0JEFe/71uWD46z4DSIeUxBH1a/lPLg8Sl8k1anBDhJGYT2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Apsag0pAIPmi6SKOm2sistmIe4yAvLkWzbtTJu0GsPY=;
 b=2dPkuP/mjVvwQUs4A1ShrTD+3Tds6MtWB2Jlmg4Lyhkyg4McPv3IrfxV+1VGIesgSzNmgzgDvyMcLALaT2+NRMn+r85y+7IYd6frPhWMfk9uBKg5WE6XCXO8B+2p3xa0WRzNrbyO7XKuQ3V2h2Xlh39iRIC2l5BxCCPMmGDIuw4=
Received: from BYAPR12MB3527.namprd12.prod.outlook.com (2603:10b6:a03:13c::12)
 by DM6PR12MB4122.namprd12.prod.outlook.com (2603:10b6:5:214::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Wed, 20 Jul
 2022 13:21:47 +0000
Received: from BYAPR12MB3527.namprd12.prod.outlook.com
 ([fe80::a4b7:450:5a11:bb08]) by BYAPR12MB3527.namprd12.prod.outlook.com
 ([fe80::a4b7:450:5a11:bb08%7]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 13:21:47 +0000
From:   "Rao, Appana Durga Kedareswara" 
        <appana.durga.kedareswara.rao@amd.com>
To:     "Simek, Michal" <michal.simek@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rao, Appana Durga Kedareswara" 
        <appana.durga.kedareswara.rao@amd.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "git@xilinx.com" <git@xilinx.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: misc: tmr-inject: Add device-tree
 binding for TMR Inject
Thread-Topic: [PATCH v2 3/4] dt-bindings: misc: tmr-inject: Add device-tree
 binding for TMR Inject
Thread-Index: AQHYm/4IoDZ6+6FTEEK4tZSIaTro0a2GyFqAgAAkiACAABMjgIAAKx6AgABwK4A=
Date:   Wed, 20 Jul 2022 13:21:47 +0000
Message-ID: <7acd93f9-dc5f-3b30-2d7a-4042246e1984@amd.com>
References: <20220720060016.1646317-1-appana.durga.kedareswara.rao@amd.com>
 <20220720060016.1646317-4-appana.durga.kedareswara.rao@amd.com>
 <77e8433f-6cb8-eb32-63d5-414a92d3b874@linaro.org>
 <f45fccec-4496-19af-0e14-bd626e14c7bd@amd.com>
 <bc99e06b-1aa5-441e-c86f-0fbfb0945d0c@linaro.org>
 <259a1808-934b-359c-a95f-50d654a48816@amd.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.50.21061301
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5b91627-194c-4921-8fa9-08da6a52cc64
x-ms-traffictypediagnostic: DM6PR12MB4122:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: csFTnD41XjyxneeMv/NLskzl8HGl1wI+sTwb+hNIYyGlart5UfoyBykZzDCxIgVC4Gl5TBZiHDenmaRxciByd2irjXmJbXl7xurJyTn9Sc+kt9PwWDf/wHaZnR+i3XAyE0Ldhf7rFtYfZxlP/UdWdNsJJ6EZJt8fjwRo0RhqTWvVOMbyw75K7AnR4mfeG1IcrPSgYSxEm/dZW1QilpuYEzgtxC96ZDXPYgHRvXQht6jY3rjNBC6wZjlGK8qkJFwCrKSF9DWPyKfmaiOlK1oCa4Fbckg/OqTjidL0+xGklR2PLrJfKvm15CkMUrcGZwKxF+tMusTbQ8zHeEkyK0SvMsp3hA/X5nkpOSvAV0nIltd0S9lzhTX0cQPfaw+m5m2hmRNqecDEqvXVWncK3Xw4yYfwIvPnxvfuI1Leruju/JokPgJBEnvA3KMC1YuI4WOxh7EFL6pHtu1l590OP6nnv25mrc51r/SsFYc1HAWvEb7S8cSdoP3C73CR6QUZdXYXrAshwo83WA9u+JWxyWsI0xNkX/wAHPm3t/g16iOTLqoX5PPc13gI5ynx1ieswTEVK9Xo7hISvutzFlZ1dHCxYrir5C42V6anaFlOD2wtES5wTIxe++Rofhglaq5CsvaMHav5opPPPhZpSHjYgf2ZJ4oJXy3+MQ2RH9j7JPuu/SCJuQdr+fJiDQtr6msUmJoz20sPkHZZsppJwIVCrznKom5s8v3P/MZQop2J1QjvXZhF3Lc4Fp/PR6a7YGKriI/RVetRvRtMse1k90V3xzIEwJhS/TbkbocuY29PvpdQHe4WxzrtPnL0qD9IqmX3EAzsdvKT5gX+N0/JJZkO8XX0IqXLaZeVZ53g+Yky2kmFmcE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3527.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(38100700002)(86362001)(4326008)(8936002)(66556008)(8676002)(53546011)(64756008)(66446008)(66476007)(5660300002)(31696002)(36756003)(316002)(76116006)(6506007)(38070700005)(66946007)(91956017)(921005)(26005)(110136005)(31686004)(2616005)(107886003)(6512007)(2906002)(186003)(41300700001)(71200400001)(54906003)(478600001)(6486002)(122000001)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUN1a0RXcTFlSE5ZZzVIRTM1ampyRGZyQjFuU3FhY2VQcHo4U2pQU2RsTjJ2?=
 =?utf-8?B?SGgxYzdOOVR4cFpja3JVS0JnM0pkMWYyZTNqWVlIZjhhRU40NnJFQXN2Vkln?=
 =?utf-8?B?ZGhxbk13ZTVZVVlDc0hmU1UveWpmeHBEcUJMMUV2NWxNbDRQNFo4ZW42RzFu?=
 =?utf-8?B?c3gwYU5iaEFNWUJpV3J3bzZDZDZkZGo2MEZWVDFwTWhRdk53NTdDeVJMRVJk?=
 =?utf-8?B?WWpaZVA3WktSa0ZMbEVtQ05YQ3BnM1lXMlZwREt1UHpNWlZIeUxhdVlwamxw?=
 =?utf-8?B?LzVuRWhWNi9pRlRSY3FJUnlhMnVVNFhNZ3lCQlBSbHlkU01jMjV5U1BTMEVS?=
 =?utf-8?B?bDMrQmxkQ3FyODhhZDlOaHVaeE5JbkhJQTBoQXVuUHc1OTNOSnliNndPZTdn?=
 =?utf-8?B?ektodG1XSm1BaEF1Y2orNmJ5MS9sWmcvSVpxV3VwN3BySWZ4cnZ1RnlDQVVX?=
 =?utf-8?B?NU95NUVWSjFTTkFTekhWVVlwN2RaRHhWOFlwb0NLZ3k0eGRNYkxPMVkrQ0lW?=
 =?utf-8?B?eVhYcUJsMDNVeno2SnU2ZUt4STlSdjNzRG55MURrMTJkeXJqRUJ4WVREMHJn?=
 =?utf-8?B?azR3M3RLemZyR0FSNUNPVHgvZlFFU1ZGcG81dEZsNUhsWHJPMkp6ZVNIY05X?=
 =?utf-8?B?WEd0ckFnNHVDaDdJSjRQYXA3S0xNTDBRUFU2U3UzYUs4Tmx6c0tYNGZHemNl?=
 =?utf-8?B?WDFLbDVnQ2Z4dDBGMlRVRXBoWUZrbnJQSzgvcm5UTDMwSFErMEpPOFV5bEo3?=
 =?utf-8?B?bmxHL2VGa2hDZU80NnlxR1lYK3diSTVtUGlhWjdwbElzU2RTSFlnKzVaeFdw?=
 =?utf-8?B?bThvWithRWs5djVHNm4yY3FVWXIxWncxK1ZFUm5jNHEyTFBMOG0zNEpWaTZL?=
 =?utf-8?B?RjJ6KzdBZGxJK3p6bG9QZU9FcG5kSExGclZOdHlRRHh6ZzV6TTlzajdJUEt6?=
 =?utf-8?B?RzAwWk9RejNHOUdjeno4V29VQzV4Tmg1WDgvUExya0RJL0FzNzlWaUZxNWx3?=
 =?utf-8?B?RVpsVWVjYVZ1RU5TNitXa1NsYXQ2WG9DR1ZTQ2NHZzBxbVVCdGpsWVd2a0hw?=
 =?utf-8?B?Mk40TDBxdUlzMjBkM2c4YUZYUmVRdU8xaVVaYTcyeWJVVnNwSmVBSEFjZktk?=
 =?utf-8?B?Rm5zMHRQei8xMUc3K1lJVGFNcWU4VFN3VTFmWng3YVNIc0p4MTFaWFhGM1JK?=
 =?utf-8?B?Z0tncUVBMS9ialNsdy95U25VRnZzKzArOXZDdlUwOFcxT1BTOGhNQUxreDJE?=
 =?utf-8?B?TDErQWFCM3A1YkhZVkpTOWpjRnRFZWZVdm9SUFdRRVU5ZXFTTDkzS08raUlB?=
 =?utf-8?B?dzUyRWkyYS9UV1A5T2hQL0hzTGw5ZDQxOHdRSmRmbTB6UE1xaGcvZkRncWhD?=
 =?utf-8?B?L3RzVGNMMnV1ZWM1ZUxzY1FBMWJjL3V0ZFBBTmFXeUd5RU11eFUwSjYrdkZF?=
 =?utf-8?B?YTlkbXdPdFltK0lrYzZCaitpYmpMbTY2azJudkNEcjlDUGgvaGgwZ2hKT0w2?=
 =?utf-8?B?L05wR2lKbTJ2OVhsYW1tOXREbS9sMTVwaTJhR29JQ25rc0tvbGNKTEUzK1pk?=
 =?utf-8?B?NFJnV3NCTXB5LzV6dnFhNjlBWmtteXUzaENXZzY0WDJkTzdhNjQ4UE5MTTlB?=
 =?utf-8?B?UzB4Skh5NElFUWN1Y1VsRG1qb21FMHNHdFptOHhkTmlXajFyZEFFTzg5ZFlB?=
 =?utf-8?B?LytadXF6Wk1lRWZPZC84NURQcEdUQnhGZlVSekp0eCs1YTlMZzNxZmcxWldZ?=
 =?utf-8?B?cURtSTAvNXdFN0F2T3BTZ3F4bXIrRmRSK0hQZWxDNkduOERGdWszb3FMQ2dz?=
 =?utf-8?B?bTZKS1NVTU15WWRoT21qRk80ZFRwVnNwS1FTUFp4MG5vRHJKVlg2dWEvckQ0?=
 =?utf-8?B?QmVCb3VVYkdBTnFoZGVQam9OVDBWN3VRZ01tT05YT3pBbUFKOUUxTGM1STFo?=
 =?utf-8?B?ZGh5NndYVFozc2ZFa00zUjFMODE2YW54Zkx4WmNrYnNaZFc5b3dhWXRDbHE1?=
 =?utf-8?B?UXN4NEtLSlliM3VYQWlBZzN3cWltKzc0Z2F5aGRFTGdZeCtVQmJleGFqRmtC?=
 =?utf-8?B?Q0NjdnI0OWVFdnk0UUdnakxmeDhFamJqUEZMRW15UCtkMUNmamYxSk1hQmlp?=
 =?utf-8?Q?kuDUqp1WbzRjW/JQw8YmoM791?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14DAB7A651456C4F81E4709DA80A19D8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3527.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b91627-194c-4921-8fa9-08da6a52cc64
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 13:21:47.5039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jGcIeodG/vLPXHPgllhUy6Pj6mWr1fDGNTPxDT1h7yjMuqyux7gzga8GIwutx+qB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4122
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldyBLcnp5c3p0b2YNCg0KT24gMjAvMDcvMjIgNToz
OSBwbSwgTWljaGFsIFNpbWVrIHdyb3RlOg0KPiANCj4gDQo+IE9uIDcvMjAvMjIgMTE6MzUsIEty
enlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+PiBPbiAyMC8wNy8yMDIyIDEwOjI2LCBNaWNoYWwg
U2ltZWsgd3JvdGU6DQo+Pj4NCj4+Pg0KPj4+IE9uIDcvMjAvMjIgMDg6MTUsIEtyenlzenRvZiBL
b3psb3dza2kgd3JvdGU6DQo+Pj4+IE9uIDIwLzA3LzIwMjIgMDg6MDAsIEFwcGFuYSBEdXJnYSBL
ZWRhcmVzd2FyYSByYW8gd3JvdGU6DQo+Pj4+PiBGcm9tOiBBcHBhbmEgRHVyZ2EgS2VkYXJlc3dh
cmEgcmFvIDxhcHBhbmEuZHVyZ2EucmFvQHhpbGlueC5jb20+DQo+Pj4+Pg0KPj4+Pj4gVGhlIFRy
aXBsZSBNb2R1bGFyIFJlZHVuZGFuY3koVE1SKSBJbmplY3QgY29yZSBwcm92aWRlcyBmdW5jdGlv
bmFsIA0KPj4+Pj4gZmF1bHQNCj4+Pj4+IGluamVjdGlvbiBieSBjaGFuZ2luZyBzZWxlY3RlZCBN
aWNyb0JsYXplIGluc3RydWN0aW9ucywgd2hpY2ggDQo+Pj4+PiBwcm92aWRlcyB0aGUNCj4+Pj4+
IHBvc3NpYmlsaXR5IHRvIHZlcmlmeSB0aGF0IHRoZSBUTVIgc3Vic3lzdGVtIGVycm9yIGRldGVj
dGlvbiBhbmQgZmF1bHQNCj4+Pj4+IHJlY292ZXJ5IGxvZ2ljIGlzIHdvcmtpbmcgcHJvcGVybHku
DQo+Pj4+Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogQXBwYW5hIER1cmdhIEtlZGFyZXN3YXJhIHJh
byANCj4+Pj4+IDxhcHBhbmEuZHVyZ2Eua2VkYXJlc3dhcmEucmFvQGFtZC5jb20+DQo+Pj4+PiBT
aWduZWQtb2ZmLWJ5OiBBcHBhbmEgRHVyZ2EgS2VkYXJlc3dhcmEgcmFvIA0KPj4+Pj4gPGFwcGFu
YS5kdXJnYS5yYW9AeGlsaW54LmNvbT4NCj4+Pj4NCj4+Pj4gS2VlcCBvbmx5IG9uZSBTb0IuDQpT
dXJjZSBLcnp5c3p0b2Ygd2lsbCB0YWtlIGNhcmUgb2YgaXQgbmV4dCBwYXRjaCBzZXJpZXMgb253
YXJkcy4NCj4+Pg0KPj4+IG5pdDogRmlyc3Qgb2YgYWxsIGl0IGlzIGZyb20geGlsaW54LmNvbSB0
aGF0J3Mgd2h5IHhpbGlueC5jb20gc2hvdWxkIA0KPj4+IGJlIHRoZSBmaXJzdC4NCj4+Pg0KPj4+
IEp1c3QgZm9yIG15IHVuZGVyc3RhbmRpbmcgYWJvdXQgZ3VpZGFuY2UgaGVyZS4NCj4+PiBDb2Rl
IHdhcyBkZXZlbG9wZWQgYnkgWGlsaW54IGJlZm9yZSBhY3F1aXNpdGlvbiB3aXRoIEFNRC4gQW5k
IGJlY2F1c2UgDQo+Pj4gaXQgd2FzDQo+Pj4gcGlja2VkIGZyb20gdmVuZG9yIHRyZWUgb3JpZ2lu
IHhpbGlueC5jb20gd2FzIHRoZXJlIHRvIGtlZXAgb3JpZ2luIA0KPj4+IGF1dGhvciB0aGVyZS4N
Cj4+PiBBbmQgdXBzdHJlYW1pbmcgaXMgZG9uZSBieSBuZXcgY29tcGFueS4gSSBjYW4ndCBzZWUg
bm90aGluZyB3cm9uZyBvbiANCj4+PiBrZWVwaW5nDQo+Pj4gYm90aCBlbWFpbHMgdGhlcmUgYnV0
IHRoYXQncyB3aHkgbXkgb3Bpbmlvbi4gRGVmaW5pdGVseSBub3QgYSBwcm9ibGVtIA0KPj4+IHRv
IHJlbW92ZQ0KPj4+IG9uZSBvZiB0aGVtIGJ1dCB3YW50ZWQgdG8gbWFrZSBzdXJlIHRoYXQgd2Ug
ZG8gaXQgcHJvcGVybHkgZm9yIGFsbCANCj4+PiBvdXIgc3VibWlzc2lvbnMuDQo+Pg0KPj4gSXQn
cyB0aGUgc2FtZSBwZXJzb24uIE5vIG5lZWQgZm9yIHR3byBTb0JzIGZyb20gdGhlIHNhbWUgcGVy
c29uLiBTaW5jZQ0KPj4gQU1EIGFjcXVpcmVkIFhpbGlueCwgaXQgaG9sZHMgYWxsIGNvcHlyaWdo
dHMgdGh1cyBAYW1kLmNvbSBwZXJzb24gZG9lcw0KPj4gbm90IGhhdmUgdG8gaW5jbHVkZSBwcmV2
aW91cyBTb0IuIEhlL1NoZS9UaGV5IGhhcyB0aGUgcGVybWlzc2lvbiBmcm9tDQo+PiBlbXBsb3ll
ciB0byBzdWJtaXQgaXQuIFRoZSBzZWNvbmQgU29CIGlzIGp1c3QgcmVkdW5kYW50IC0gYnJpbmdz
IG5vDQo+PiBhY3R1YWwgaW5mb3JtYXRpb24uIE90aGVyd2lzZSBwbGVhc2UgdGVsbCBtZSB3aGlj
aCBwaWVjZSBvZiBEQ08gdGhlDQo+PiBhZGRpdGlvbmFsIFNvQiBhZGRzL3NvbHZlcyAoY29tcGFy
aW5nIHRvIHNpbmdsZSBTb0IgLSBAYW1kLmNvbSk/DQo+IA0KPiBvay4gSXQgbWVhbnMgZW5vdWdo
IHRvIGNob29zZSBvbmUgbm93LiBJIGFtIGF3YXJlIGFib3V0IHNvbWUgSVQgaXNzdWVzIA0KPiBp
biBwcm9ncmVzcyB0aGF0J3Mgd2h5IHRoYXQgcGF0Y2hlcyBjYW4gY29tZSBmcm9tIHhpbGlueC5j
b20gb3IgYW1kLmNvbSANCj4gZm9yIHNvbWUgdGltZSB0aW1lLg0KPiBLZWRhcjogcGxlYXNlIGp1
c3QgY2hvb3NlIG9uZS4NCj4gDQoNClN1cmUgTWljaGFsDQoNClJlZ2FyZHMsDQpLZWRhci4NCj4g
DQo+PiBTaW1pbGFybHkgd2hlbiB5b3UgY2hhbmdlIGpvYnMgd2hpbGUgcmVzZW5kaW5nIHlvdXIg
cGF0Y2ggLSB5b3UgZG8gbm90DQo+PiBhZGQgbmV3IFNvQiBidXQganVzdCBrZWVwIFNvQiBmcm9t
IEBwcmV2aW91cy1jb21wYW55LmNvbS4NCj4gDQo+IElNSE8gVGhhdCB3b3VsZCBiZSBtb3JlIHF1
ZXN0aW9uYWJsZSB3aGVuIHlvdSBjcmVhdGUgY2hhbmdlcyBpbiBvcmlnaW4gDQo+IHNlcmllcyBh
bmQgbmV3IGVtcGxveWVyIHBheXMgeW91IHRvIGRvIHRoZSB3b3JrLg0KPiANCj4gSWYgaXQgaXMg
M3JkIHBhcnR5IGNvbXBhbnkgcGlja2luZyBzZXJpZXMgd2hlcmUgdXBzdHJlYW1pbmcgaXMgbm90
IA0KPiBmaW5pc2hlZCB5b3Ugd2lsbCBleHBlY3QgdGhhdCAzcmQgcGFydHkgd2lsbCBhZGQgdGhl
aXIgc29iIGxpbmVzIHRoZXJlIHRvby4NCj4gDQo+IFRoYW5rcywNCj4gTWljaGFsDQoNCg==
