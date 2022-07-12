Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21706571129
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 06:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiGLETI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 00:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGLETF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 00:19:05 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9F3DF28;
        Mon, 11 Jul 2022 21:19:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmDBrCFL2XfkhH2j9fgnvWDajtbCDsyzSgYKP4K+1og4/EncY7K3Yne6/+U3JCjBhovONvdkOzX0Yl4gTNz85Ke6B40v9SQfGo3+APddSLJir5hU2m4iJbSUrLReuY3B6cr5fjU/EcUSg5DL7uZVFSbx6YPetzrk9mpZLtFRWy9AGqgFFiQfViomtGjwzI/LY6rFG00OzFhDTZyr9W8lFzTW0Xl1BPl8soR3pd4GsZvIgeXTQjB0gO56PSyPg3DKVxpwQnXFScJRuB7eyofa2fxbN16qw89wyoMjJkXzekke66yURFdrNy+ZF7Sr6vCDlicLharuI1+pAsFfXfTFFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1EBSrq/MXQif3KHpICiuc3iZ7wk6guBI20ZIhYdTo0=;
 b=DSHG9X515sS4Y89b37WChXsDLLVMGvjlqNIIQcB8mmKExq3ynTKMgntYvIXP9ftuB40it/t7ck2XcUG5xPAMgdeGoHTbA/u10AbWj7J8fHeHY+T83TMu0JgJKpLpTmUqUNwQErD3bF7cOBLsqKxkgQhmLwl/M1ExHp74mMQRa75zMceIJWwqzE9fHLXhW2lvC3QHJJL6xPdDg9kSXbyJs/NZXpigWoQ4/q9RNRnCMai7jpX31px8Q+JRRe99iKNrV0w2Jc2q3i8A4FIDY8nT8dx/qiJe99RxjqmmjuT4czKmE8cq9ifZNyDKhuaG/QGQy2dFlCpephoCp111MQeZlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1EBSrq/MXQif3KHpICiuc3iZ7wk6guBI20ZIhYdTo0=;
 b=uOS5RWI3K3Kq0Peoih/+sIfW70rkzdi9b/I6nYKmvNMF9osZ7nZVsfnHIjxrHQL0gEM8a6dF85Rm14Ar6Krl0T9PJfIIo/ckM32cfYI8DyxaEfcg7CP/dy1KuVUXsO5BpfGh7nulSjz44LjFV7NS/d+lLQs/LS0KZji6eB6UZso=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by DM5PR12MB1194.namprd12.prod.outlook.com (2603:10b6:3:6e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 04:19:03 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::bd3b:532c:bc96:c60a]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::bd3b:532c:bc96:c60a%9]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 04:19:03 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Huang, Ray" <Ray.Huang@amd.com>
CC:     "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 14/14] cpufreq: CPPC: remove the acpi_disabled check
Thread-Topic: [PATCH v2 14/14] cpufreq: CPPC: remove the acpi_disabled check
Thread-Index: AQHYk58W2PChK2/9wkanAx9Eo4jUjq15keUAgACTIZA=
Date:   Tue, 12 Jul 2022 04:19:02 +0000
Message-ID: <DM4PR12MB5278A77554A57D41A86E319F9C869@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20220709142032.837089-1-Perry.Yuan@amd.com>
 <4df9485a-4947-6f2c-e3f3-89ff44e12113@amd.com>
In-Reply-To: <4df9485a-4947-6f2c-e3f3-89ff44e12113@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-12T04:18:59Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=35cb03da-9733-4fe0-bf08-20fdd9f3d462;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-07-12T04:18:59Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 476d0d8e-f4f1-471a-85a3-d754aadc2801
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee9bc704-50fe-44a9-1144-08da63bda716
x-ms-traffictypediagnostic: DM5PR12MB1194:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6/WvvkqYqIZ+QMoYGJ90gQQKV0+pzvZsoSnXNNUATtWZxui47OTrHdCRpP5g1KaW+s047V9ZsHRbMXgrP8/k913kqBEaoXWKrrCMwI9zCogxBJSasSfobuRBpLSGFKthlPRRD4CzBtj+XK4F7KhVB5c4o6sJrcdRPV/p5svi7D3x9gkb05khpZwpg1yFuhTw3FQfPqCz43dA+CLXA03pSKz5LxtkOZLgmlHDTgTjgS5Ahzy4IGn6tS89CuPTJyV/MyQ7jqh/t0e6m9IczPiiBrJvwp47lVQZGihbz5VrqE+sjILS9NLZoqGQrD3xAwT8bOV608u/d4sTlRwIu+609QZfQPwgKNsU25T+SbI14KmltZ0NdPnJtgjo6S372pEja8Ja47hMXhFQfv/dr8dGrhtb0qR0KHLAq8zi07W/oKrCb5iULeShFv9iNbHPd+kB5sbisC2IdussPfMWYvA81Iz0zTLngjT+w+wRJNwBmrHOUsX5rsEaAP4CpGda4aI+s7Ycu6wJ3yrAeVj3zwUGZexxHwkiOB7CkRZZH+I/WRLyV2xKd7Er4TdaOzw3RMVhzaSfF/YEEw9KMDB77TExNQVWPNjvHPuXXScnj7SSZKemIYy4KUOVgy6wyV5bGRhXMCWqhZyzkjpkDgBeen8bv/+gUcqpNmDm4bZUMVMhEv3KiQIQFHoVh6d/QMJMUz8HPn/oIDMJ9ax6RibdrvuESVJ5yoDONn94yRcCcl/I2n0CODbY0p0JPJB1i9V5wWmr2qd7uInHf1X5SL7RMhWUBs8Soh5945JhuW/Rw3dtDrgX5QZK14MwKqYRb720DEhh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(6506007)(9686003)(186003)(53546011)(26005)(7696005)(66476007)(83380400001)(41300700001)(66946007)(38070700005)(38100700002)(8936002)(76116006)(478600001)(52536014)(2906002)(5660300002)(33656002)(64756008)(71200400001)(54906003)(86362001)(110136005)(55016003)(4326008)(6636002)(8676002)(122000001)(66446008)(316002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c09TS2UrcjNENU13UW5SdWloaCtHVU4vd3p2MWU3QWJEckdJbWxkN2x5ZWIw?=
 =?utf-8?B?TXZ2alNxSDNvaVB3UkZFdkhzcUNNMmtYeDdQTVZHQWJIMWZRZHQ1eW1HOFQx?=
 =?utf-8?B?eHpjM1lObXZ2bGltSm43Qmdwcjd5TmJVcktpbHZ3ekUyOStMUFV6WjVNT0V4?=
 =?utf-8?B?dDBMWmJyLzkyVVFESENBL24wd1NQKzVJTEFRYmNya252d1lMeUtxWFQ0bnp0?=
 =?utf-8?B?clozK0R6SHkyU1Z6REhGaUd1VXpZbzBFYTFlZ29kU0FDbnY2ZWFNNjROcmlu?=
 =?utf-8?B?V0Z6S21FeCthR0Fma0dKTlE1NnNDQ2NIblR0Y21GdEhoRmF4VHgwTjUzN0lw?=
 =?utf-8?B?T09PcWE3VkRBNEYzMURYR2ltNTVCRW9Id1lxdytJYnMwc3d3YTB0VUV3N25T?=
 =?utf-8?B?cHlHL2pGODIyZ2ZielpVdFNGdFRJbVRxTTdYZ0lDMCtBRFBNR2tJcnRTKzRp?=
 =?utf-8?B?K0Fra1lpaUhuYkxYejIwWE1SRHRWbjkxbVZPcTBkdFprZ09OZHI4YVJuK01u?=
 =?utf-8?B?QmhMMVZEekMwOFUrN1oyMW0xUnBzRHJpYWJscjVzU1JKZnF6UzVISmN2MUpi?=
 =?utf-8?B?T29RbWdQejFmdERtZWJXalZRdzNuWkVDQTJnK1VMRlVITExlNUQ1V3hLOUVo?=
 =?utf-8?B?LzI1bXZmQ21iUVJoOFhGaDBNWkxYMWJlVUQ2MVZuKzIrZ0M4Sm5mZlRZZVc3?=
 =?utf-8?B?QUptV0dKTjJURzNWRDY2RTZEYnVtWU1HUjFoLzFVanc3WkJDbEoxMzhNTVlL?=
 =?utf-8?B?TGZKcUpKdWNwMDNFeUcza1Z4aU9rbHhnSGFuUDVha3VudGw1aFBYeGNQVm5I?=
 =?utf-8?B?d0JwUzVKcWZXOGdwVnhSN1paWnBSSTdtVWkxcHNGZDFMZ2FsdjYyaDRWbDVV?=
 =?utf-8?B?amZKSXlHd3lGYjJNcWVaYmpIVk1IbWtqRUlaMVowY3BxWk00Z0NKUmdqWEtj?=
 =?utf-8?B?b3llWU1iK2tKZjlRMXRRSnl5dnh1emdHLzVmVWg1SjhqUHA0TlE5RXFuNW55?=
 =?utf-8?B?aVlubXlDY0o5MFdNNS8xM3NRVHdFWThUZGhseVJFOW41cnNpY3I0cHhXdU5r?=
 =?utf-8?B?OWlzOGdyTlNuU2swczZXUGczeEdtcjhNUml5YjdXUUNBNXVDQlhHMThhdjFs?=
 =?utf-8?B?K0xWTExISmlSVklDV1RPSFJJSVBJb1BPQVkwL1BkTVdjMUw1THlCUnUzWjhr?=
 =?utf-8?B?YW5FbFNNSHRrUUVHZ1FQUGdPSTEzL0Z3aEJWYXRCTkQxNTZ1TWFHOVlUekVn?=
 =?utf-8?B?cnNNSENHYVNKN001S0Jja2hCWDdTWEJhdWFQMFV0QTZiTkFMcFlZNkpZaWxU?=
 =?utf-8?B?cmZVOTJSZzdRcGJRZG5saXJJY29mTzNJbkxLZVVPc25XYkFNZFNkWnVXenQx?=
 =?utf-8?B?MVJNTlB2ZVJaQ1U2cEhad2ZQVkFoVTU0K1BMZlAxbks0aUxMSXhzZDhud1N0?=
 =?utf-8?B?WUtvNW1IREVGTm1UNG02cm5LQXNuY0owNzUxc3gvcjZQUUlJT0ladWlYRTJ3?=
 =?utf-8?B?NWR3SklkUDNTR1p3Qlp5cmFwbi92WWIwc29JNDJwMXIra1pRMXFmbERvSkhj?=
 =?utf-8?B?YlNyeVkyN2RSZkkyeXQ1c1lXaFNma3R0a2cxdTVMS3NWQkhXRG9IdnZuZzdW?=
 =?utf-8?B?RnJOczFudFZvVk15LytieFEvcTBBaHQraElscXpSY3FUNzk4ckpEc3FPc09P?=
 =?utf-8?B?Uk5aK2NkNE1aU2xidGJKWHB1SW5RQTRjNFJ3WFBiUE0zcDVwZE5WQmtMcXRl?=
 =?utf-8?B?Z0hVUXVScWJTN0xkekZxNmdaUFkvZlVuM3dlVnJhSHloc0t3ckN4elRwMXV4?=
 =?utf-8?B?dS82NzlpZGp3VTJvTkNmaHZQbGdUOHc2TnZuNU9yd1FKNVhOcHJrajhDN0Qz?=
 =?utf-8?B?elgrWU9Sc3RxKzF3VFFuOFduWHpweVpIQVE4bW5iWU84Zy90c3IzbU1QVUcv?=
 =?utf-8?B?Z3VqRGllaWs4eU9RNHQwV3krbTZLS2lRWm43NEdhZnVXYkV2a2tJR0ZLMGJK?=
 =?utf-8?B?WndhV010YlYyaGRpNXdUbFJ0eWtkaEdzZXFBTkxQekJsd0NzaDlTMTJjYXJE?=
 =?utf-8?B?VzhDbTJFeFA4bTFtVkxYQVJ2OVlFVGYwMHh0ZGtVcit1M3BtUkQ1MkdOZE1S?=
 =?utf-8?Q?ILO4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9bc704-50fe-44a9-1144-08da63bda716
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 04:19:02.9244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tmWlejh2yqwNOyZX+pGg5YewxLGDduPtrKwFE+iEQ32NBY1ZhtIHPmBQj2Y6xOWhSzznB4HYP7KqgJQTwQp+1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1194
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpICBOYXRoYW4uIA0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZvbnRlbm90LCBOYXRoYW4gPE5hdGhh
bi5Gb250ZW5vdEBhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDEyLCAyMDIyIDM6MzAg
QU0NCj4gVG86IFl1YW4sIFBlcnJ5IDxQZXJyeS5ZdWFuQGFtZC5jb20+OyByYWZhZWwuai53eXNv
Y2tpQGludGVsLmNvbTsNCj4gdmlyZXNoLmt1bWFyQGxpbmFyby5vcmc7IEh1YW5nLCBSYXkgPFJh
eS5IdWFuZ0BhbWQuY29tPg0KPiBDYzogU2hhcm1hLCBEZWVwYWsgPERlZXBhay5TaGFybWFAYW1k
LmNvbT47IExpbW9uY2llbGxvLCBNYXJpbw0KPiA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47
IEZvbnRlbm90LCBOYXRoYW4NCj4gPE5hdGhhbi5Gb250ZW5vdEBhbWQuY29tPjsgRGV1Y2hlciwg
QWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgU3UsIEppbnpob3UgKEpv
ZSkgPEppbnpob3UuU3VAYW1kLmNvbT47DQo+IEh1YW5nLCBTaGltbWVyIDxTaGltbWVyLkh1YW5n
QGFtZC5jb20+OyBEdSwgWGlhb2ppYW4NCj4gPFhpYW9qaWFuLkR1QGFtZC5jb20+OyBNZW5nLCBM
aSAoSmFzc21pbmUpIDxMaS5NZW5nQGFtZC5jb20+OyBsaW51eC0NCj4gcG1Admdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djIgMTQvMTRdIGNwdWZyZXE6IENQUEM6IHJlbW92ZSB0aGUgYWNwaV9kaXNhYmxlZA0KPiBjaGVj
aw0KPiANCj4gT24gNy85LzIyIDA5OjIwLCBQZXJyeSBZdWFuIHdyb3RlOg0KPiA+ICJhY3BpX2Nw
Y192YWxpZCIgZnVuY3Rpb24gYWxyZWFkeSBpbmNsdWRlcyB0aGUgYWNwaV9kaXNhYmxlZCBjaGVj
ayBhbmQNCj4gPiB3ZSBjYW4gcmVtb3ZlIHRoZSBkdXBsaWNhdGVkIGNoZWNrIGhlcmUNCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFBlcnJ5IFl1YW4gPFBlcnJ5Lll1YW5AYW1kLmNvbT4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9jcHVmcmVxL2NwcGNfY3B1ZnJlcS5jIHwgMiArLQ0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2NwdWZyZXEvY3BwY19jcHVmcmVxLmMNCj4gPiBiL2RyaXZlcnMvY3B1
ZnJlcS9jcHBjX2NwdWZyZXEuYyBpbmRleCAyNGVhZjBlYzM0NGQuLjlhZGI3NjEyOTkzZQ0KPiA+
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9jcHBjX2NwdWZyZXEuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvY3B1ZnJlcS9jcHBjX2NwdWZyZXEuYw0KPiA+IEBAIC05NDcsNyArOTQ3LDcg
QEAgc3RhdGljIGludCBfX2luaXQgY3BwY19jcHVmcmVxX2luaXQodm9pZCkgIHsNCj4gPiAgCWlu
dCByZXQ7DQo+ID4NCj4gPiAtCWlmICgoYWNwaV9kaXNhYmxlZCkgfHwgIWFjcGlfY3BjX3ZhbGlk
KCkpDQo+ID4gKwlpZiAoIWFjcGlfY3BjX3ZhbGlkKCkpDQo+IA0KPiBTYW1lIGNvbW1lbnQgaGVy
ZSBhcyBmb3IgcGF0Y2ggMTMvMTQsIHRoaXMgY2hhbmdlIHNob3VsZCBiZSBwYXJ0IG9mIHBhdGNo
DQo+IDExLzE0Lg0KPiANCj4gLU5hdGhhbg0KDQpJIGNhbiBkbyB0aGF0LCAgYXQgZmlyc3QsIEkg
YWxzbyB3YW50IHRvIG1ha2UgdGhlIGNoYW5nZXMgaW4gb25lIHBhdGNoLCBidXQgSSBwb3N0ZWQg
dGhpcyBwYXRjaCB0byBzZWUgaWYgbWFpbnRhaW5lcnMgY2FuIGFjY2VwdCB0aGlzIHdheSBvciBh
bm90aGVyIHdheS4gDQoNClBlcnJ5Lg0KDQoNCj4gDQo+ID4gIAkJcmV0dXJuIC1FTk9ERVY7DQo+
ID4NCj4gPiAgCWNwcGNfY2hlY2tfaGlzaV93b3JrYXJvdW5kKCk7DQo=
