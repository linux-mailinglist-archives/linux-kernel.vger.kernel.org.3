Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C7F51446C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355858AbiD2Ina (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbiD2In1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:43:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAF4FC6;
        Fri, 29 Apr 2022 01:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651221608; x=1682757608;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BZJe0tsNI0cAMqfjk1U6SSdqdJICrFdgh0nDkXjQWP4=;
  b=GxFRXaHuYqdKSKVRVCS3j75ZQAmcXmEDC+8MysI52Q1W3z4K2TBARgLx
   dTFruhGbSvv6e8kyj5dAhKl6dVj+9NSAgRcAErSKFExLt8Ce8KRKbrl4O
   6vRO+Ai4Sgox75cq1kfRSrlKrxc/hUF69DMf+n/wAzxbJZvmzCLGSpYPy
   aMtVI4eWZBOfsWqRIyvCjRvFvPaXDb+wLS+chi2hs00hAStsz+1v3sD7f
   kfy6PfPU9aJq+1BSIY4Dl5x2jUxgp56cLnVcQPP3eDQOpgZnUDbbQB1e8
   Hka3OZ4sghqBoCkvhTiTv6hWYaOrQUWaBg1Y5IJSkKxQyaewRXlDZZ85h
   g==;
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="94022514"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Apr 2022 01:40:07 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 29 Apr 2022 01:40:07 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 29 Apr 2022 01:40:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2YpIbEujExlvvH7KNURINoQ7csWK+778ig4hOOXFhsHETgODsHfPox+KzKh77sPHRm4AXQvhBUAI6Nxt/pbiOI+RgXc7R6JQQexFty7mDNYWF4bHN9zsIZr8niQ/1qTLXeI94uxZ2X/kK8KA/TtQwec8zQOE4GHba8BC2fA/xPKoZivJ5Yp5ZBDOBlbuausP1gG7ugHCm9HP4lkcCKEvzCiS8TN597O+6GtCYMCWwSglM+X/gcTZjl16oREe7Kwn0Nbzd/yxcLnVlyBrLkUmF9o3lThgT/4q+LGXTkYq6ZuCG9yNXLgD8JwEPhytm+ubv3tytqc0uP1aImDy3l4Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZJe0tsNI0cAMqfjk1U6SSdqdJICrFdgh0nDkXjQWP4=;
 b=RoZ2K+qlWs0bVDCHpFceEyTRW7a7SQ7lKZ5Yf1BcMGSmduLyZ4i2dCLfhE3d6ZZ8mHIVQvVBy8Q/gDXZ0gW1brcfx8afw46iCwbDRVYGaulNKoQCRtvlSgC8hIbZtbgi6NGG/UXneI79FzTTEJwoR33BpTo2CAfKGB03OylpY2o9qOTTpZNqjKJVFLFzC9+IrTCc8Fnkfh0DJryuM44gZIXZff91KsMKy/LfYNyokRABYa5ZX3IcBeO6CwMEFEwlKoZeyBTwU+VPL281+7CX/EClThH6LMFWhADqsvw2I547puq/El5Z4rOeitWxFV26RmsVPr38mRXA7FwR4cPkuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZJe0tsNI0cAMqfjk1U6SSdqdJICrFdgh0nDkXjQWP4=;
 b=hDQFatw2vPY471EJsAgS8xhL2j7sztyuUBouRM10WCk+zLM0l50thkl6TsE+bl7yamBaKntjvFvk9HSRKQgiCulww9kwxzRvo5cuwog7shAYMuIkqhY2HwOB3MH2mB1m0Fab1RnZG/QNat0TZiW9draLsExTgiMYdMM2CS3v/GU=
Received: from BL1PR11MB5384.namprd11.prod.outlook.com (2603:10b6:208:311::14)
 by BL0PR11MB2930.namprd11.prod.outlook.com (2603:10b6:208:73::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 08:39:53 +0000
Received: from BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::39cb:eae2:1dbc:a5f2]) by BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::39cb:eae2:1dbc:a5f2%8]) with mapi id 15.20.5186.026; Fri, 29 Apr 2022
 08:39:53 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <hverkuil@xs4all.nl>, <linux-media@vger.kernel.org>,
        <jacopo@jmondi.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v9 00/13] media: atmel: atmel-isc: implement media
 controller
Thread-Topic: [PATCH v9 00/13] media: atmel: atmel-isc: implement media
 controller
Thread-Index: AQHYNGSL7RD2tHVvQUiepBZFYhl0460G1v0AgAAEK4CAAAO/gIAAAbGA
Date:   Fri, 29 Apr 2022 08:39:53 +0000
Message-ID: <950ce59e-ff3a-0e1c-d8e4-0fe14643f738@microchip.com>
References: <20220310095202.2701399-1-eugen.hristev@microchip.com>
 <d76bab1c-6547-5b9a-ad17-25a73bcc899d@xs4all.nl>
 <9111ee7f-9eb9-5da5-f65b-6e868f2e72f4@microchip.com>
 <75a667ca-7c12-ff61-dab4-bdea03c16754@xs4all.nl>
In-Reply-To: <75a667ca-7c12-ff61-dab4-bdea03c16754@xs4all.nl>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fc98c49-d8bf-4de2-d946-08da29bbd513
x-ms-traffictypediagnostic: BL0PR11MB2930:EE_
x-microsoft-antispam-prvs: <BL0PR11MB2930921C79AAAE33B8073CC9E8FC9@BL0PR11MB2930.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9QfHuRCtdirOvDLOxVmp6B/Rxq74xvHptXsdAYSLuVEAr4Ix/I5cA3ip4vSZDDs8+fFSrpBusKEF85LzotincwyeSoUvDzzLNK/IMIbz7s4mcbaLUxTsElQGaQt2iYZK/pL2ikc1SK/FV84ITGiYqGAitZYtp0ZEUogg2Kxy5yBQdT8YsA+8pl7DU/CS6uhCPG4TZXLHKqTCohl1RtlTEyIFcTBZjfZtk+B4IZ4FWxhg3T6YWikylkSmRsQ14S2Yo9zit+tCnInw3FFd/2qC9oNwPNtmGy2ITofmOKDx9qyugbExQqMa1BhbtGQsLRXroLlnKrgjCsTXU/MRZnTAcbWRn1Z3aU7us5ss+abWCXt4yDANPuV4NyWqAnUYpNAAPwmHKdJaKaQlhTaWZ8DRDywxAPwGkTmZVTjjOJyh49okYR9l7GXTASq+duuv+UVZozSNeK6OZGAufim+uL5Y4oL/q1XNEeuLHtrDMjKjYU3vXC/GxGCzHd/lLN3+zsPAY9BGJ1UPfrJdeRyLDXFN0xW6rT4JS7vyYOxCJxKa+uV7ZJKznkI4/nD+UKVLnFYa5/pErvU9M7Jhbarp5hDLxSdUQsh9KgOPzq0mBdYXI0aklXZUNG21kS65reS3UDVVfgjZ/JRRS4eJX+j1c9QleUnuyUGPFGkGVU+TuqKE0fDxma4iIHspR34i586/ECgHfU7FoNZmvd/T2n21r2ZIFIDbveU6EaTI1/rdlhpxDeVRQtqbzHuOIBzCgTeKqC7ImmhFeMUqwGMc5nwiR1gcFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5384.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(508600001)(31696002)(2616005)(71200400001)(107886003)(86362001)(53546011)(6512007)(26005)(6506007)(122000001)(38100700002)(38070700005)(316002)(76116006)(91956017)(2906002)(66476007)(66946007)(66556008)(186003)(36756003)(5660300002)(8936002)(31686004)(110136005)(54906003)(4326008)(83380400001)(64756008)(8676002)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alMxRzFEeXI3b0VCR29GTG9SZ1VabzZ4R0JLaklmeWp1MDBXQkIxRS9XOEJZ?=
 =?utf-8?B?S0kyNVJ1L1QwVFpid2xSeU5GcDZrY0FyTXJwV092NkJpbWErME5YbGoyZTV6?=
 =?utf-8?B?Ky9zREswVWhrRWl0YUZBcHZ3WlJTTks2bnc5RXhqRVJ2cHNLVXg1My92b0Rt?=
 =?utf-8?B?K1NuOTFJU1NLY29MclowQ0VHekloQ0l4Y3czWUp1TVZQb2ZXbWtNMTN3dVBn?=
 =?utf-8?B?Y3pQb2dVMzBhaFp6VDkxNkpyNzUrdXNyS2xpU0ZBVDVSQUJvYjVaMWZnbVJF?=
 =?utf-8?B?N0NQZmduUzlVSUQyMGF2OCs3eU05cDU1VXVOa1FQYVNyNktXVUdoenl6Znpr?=
 =?utf-8?B?WUgrWlZYcFZiVVpKN3VEVzY3M1BmeWk3UzIyRGIvUjQ1SVZwQ1MxdzFCbmhu?=
 =?utf-8?B?VEd1em01SW5nS3B0MGNWUDlZbVZJNnJQOXAvcEp0TlhtdzlVcm43UVJWQmRQ?=
 =?utf-8?B?enpKVGFVUlhwODJOUXJPaE81NlFCZnBGdXB3U3RWMVpBeVNJZDUveVZZTjBs?=
 =?utf-8?B?OUxKZDk4clBvOGhvRnY0TkFnZ3dDTm9ZK2xNSC9aQi8xYmYvN0VWL3NydUxO?=
 =?utf-8?B?N09QRC95dS9IRDZ4TzJtemR1Z0Q3T0x2NlZFV2lUVFE3N00vVUs2THpXSTFI?=
 =?utf-8?B?dE9walYwdFJNWmxMMUZGNkgwOG1Zb1J1cEd6eVRMMnV2K05DVFlRQWVPR2Iw?=
 =?utf-8?B?M0U5L3phbWVhaWl1M09hRWJpOWFlZVpoNjlldFEwZ2FXUUJzQi9LaThMNGhu?=
 =?utf-8?B?VE5ZR2FBYjM3R210dWd2VjFwcUhsTUx5YVNSV3pGa0hROU5GcmpIVFM4ZmFi?=
 =?utf-8?B?NDEwWisxa1Z5bjJLSCtHMlczN3lFVGFBTTJrRHIwQ3JQV1F2Nkg2UEQrdzE1?=
 =?utf-8?B?Qk5uSUl1OVpNSkpMd1A4ODlVdkhxKzExY1ZKL2lHWmNGK1dSbDBIK3E2bU9Y?=
 =?utf-8?B?dTJRT1VhSU54d0thSHJmNFEycG5ZdDNHeXprUEY0bzdiSHB4MmptM1h2aDJs?=
 =?utf-8?B?MlUzRHd2bVR3ZW4vY3pwL2dPdm9PbUNUTFBkbFZ5V1pjcGFPYkN2SEtiUnRX?=
 =?utf-8?B?aUdQdlhTc2g4Z0xJTGxudzJnaVRMUzFtQS9QNW1xbk1TL0xBL0RvRW0wMDgr?=
 =?utf-8?B?WS9tbEszZWpKSmR3L2hJQy9maHdKVzVnZkRIWE1qUXdIcUN0a2NNNnVkS1lN?=
 =?utf-8?B?VkhwMkVyTUp4ODMwQ09VTW9LdjVvVzhDbVlCRkxkdXNXQlZYRXREN3Q0M0I2?=
 =?utf-8?B?SzVnaFpsV3hUaVVxM1hJUWs3SkFhZzhON0tZNnhDZzdDV2hweHY2TE1BaDhT?=
 =?utf-8?B?d3lDeGs0a1NWQksxV09tRXFCSnRvVHJVMUhrRFdvaDVqV3NGWm5DWVVKQnBG?=
 =?utf-8?B?Tk9zUjVsbHBTNXVsanUvb1Q3Z1lqaUhLcSsxOHF4YWU4QmlROUl6RkZQaThR?=
 =?utf-8?B?cXkwcVdpdjRwUlk4ay9jdFNuMVVQSkN0TUFDTks2VEl6TTd1bUp4S2FJaTBW?=
 =?utf-8?B?b2NKeXRUVlVkTTREdkwrRDFuZEtnNlY1TWJuN3lFejlxeUQ5bEhlVjlaVW9m?=
 =?utf-8?B?NWxZSjZreGFGakozeWpNNHNPUjg1T3BxNG10d3ZQZ2hOTkQ4OENjWXpmRHFR?=
 =?utf-8?B?bk10WEFXWVNCNmJXRjRaQUFyTUt0eW41RnRCdHlsKzhKUEx6TWRRU1Z2NWRm?=
 =?utf-8?B?bERhVVZYcFFhMStDMzlwYStkWndRcGJYY3FZcEZUR0pOQU9ZUzZaTXAvbmtH?=
 =?utf-8?B?N09NeFR2b3loWXN3cTFScWZHNEJ6ZngzTzRwSlJPWHQ1dFh4WUNYajlweTlr?=
 =?utf-8?B?NTQ5RGRSRUxVVXB4ODlkUk5RMm51dVBaOEM4S29uUVBseUhSOGJPbzRPQTRx?=
 =?utf-8?B?elpsSVN5TEE3ajRtSTAyeWs2RFBLRGlnd0hpZUJ5R0xEbjl1VnpWaFlNcU50?=
 =?utf-8?B?RnJqbFVhbWpvNGVsbWUxdTR0VC82TzN1QzVleEFMMGRISjZJV1RDZ3pCTm9k?=
 =?utf-8?B?a2dDTmRxSFFUNS9JVGpvNTljYnRMWDY1d2hsTCtCa3BPK3NYTDRrSkI0NUg1?=
 =?utf-8?B?T3J6SVhpUnFJcUtDYmtCQzIxWDF5SGlOWXpRcmdIcGpkbXNQOUJ2RGJBbWx1?=
 =?utf-8?B?TE1DV2RVOXJEeUFvREl6OUtKazdZUloreHJENkNvZjZVQ3pNR0JpVGlVc2xi?=
 =?utf-8?B?WWtCdzY4bm5EVDNtcGRYMGRuLy83cXZIWFluSjYzS0hmSG83VExlZFdwZ3Zw?=
 =?utf-8?B?RjcrSEVpUStvbTh1Vy9MWW5lbzVNVTZVRjVueW05dGo1eDNtNHBscnBVczFl?=
 =?utf-8?B?S1JIczlvMzMrT0ZheUh0Vkh3cUoxOGkzdkFNVGYycy9jSllSaGtpekVhYjFO?=
 =?utf-8?Q?NFGpA/yWnDkalbtY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E5244B5ED3AB6408C7A40FEBC010283@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5384.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc98c49-d8bf-4de2-d946-08da29bbd513
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 08:39:53.6192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n8/tiC1kcEDaUm/uQlf3fWh74SZGC2uIxbB3GEOI4160oL11R+c2SQ49u/R9dlNcJvKgJtTrJ2OxqSy2N+CoLhl+XhJ7pe4yZCr0xJgqcVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB2930
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yOS8yMiAxMTozMyBBTSwgSGFucyBWZXJrdWlsIHdyb3RlOg0KPiBPbiAyOS8wNC8yMDIy
IDEwOjIwLCBFdWdlbi5IcmlzdGV2QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBPbiA0LzI5LzIy
IDExOjA1IEFNLCBIYW5zIFZlcmt1aWwgd3JvdGU6DQo+Pj4gSGkgRXVnZW4sDQo+Pj4NCj4+PiBP
biAxMC8wMy8yMDIyIDEwOjUxLCBFdWdlbiBIcmlzdGV2IHdyb3RlOg0KPj4+PiBUaGlzIHNlcmll
cyBpcyB0aGUgdjkgc2VyaWVzIHRoYXQgYXR0ZW1wdHMgdG8gc3VwcG9ydCBtZWRpYSBjb250cm9s
bGVyIGluIHRoZQ0KPj4+PiBhdG1lbCBJU0MgYW5kIFhJU0MgZHJpdmVycy4NCj4+Pj4gVGhlIENT
STJEQyBkcml2ZXIgd2FzIGFjY2VwdGVkIHRodXMgcmVtb3ZlZCBmcm9tIHRoZSBwYXRjaCBzZXJp
ZXMsIHRvZ2V0aGVyIHdpdGgNCj4+Pj4gb3RoZXIgcGF0Y2hlcy4NCj4+Pj4NCj4+Pj4gSW1wb3J0
YW50IG5vdGU6IHRoaXMgc2VyaWVzIGFwcGxpZXMgb24gdG9wIG9mIGN1cnJlbnQgbWVkaWFfc3Rh
Z2luZyB0cmVlLCBhcyBpdA0KPj4+PiByZWxpZXMgb24gcHJldmlvdXMgcGF0Y2hlcyBpbiB0aGUg
c2VyaWVzIHdoaWNoIHdlcmUgYWNjZXB0ZWQuDQo+Pj4+DQo+Pj4+IFRoYW5rcyB0byBldmVyeW9u
ZSB3aG8gcmV2aWV3ZWQgbXkgd29yayAhDQo+Pj4+DQo+Pj4+IEV1Z2VuDQo+Pj4+DQo+Pj4+IENo
YW5nZXMgaW4gdjk6DQo+Pj4+IC0+IGtlcm5lbCByb2JvdCByZXBvcnRlZCBpc2NfbGlua192YWxp
ZGF0ZSBpcyBub3Qgc3RhdGljLCBjaGFuZ2VkIHRvIHN0YXRpYy4NCj4+Pj4NCj4+Pj4gQ2hhbmdl
cyBpbiB2ODoNCj4+Pj4gLT4gc2NhbGVyOiBtb2RpZmllZCBjcm9wIGJvdW5kcyB0byBoYXZlIHRo
ZSBleGFjdCBzb3VyY2Ugc2l6ZQ0KPj4+Pg0KPj4+PiBDaGFuZ2VzIGluIHY3Og0KPj4+PiAtPiBz
Y2FsZXI6IG1vZGlmaWVkIGNyb3AgYm91bmRzIHRvIGhhdmUgbWF4aW11bSBpc2Mgc2l6ZQ0KPj4+
PiAtPiBmb3JtYXQgcHJvcGFnYXRpb246IGRpZCBzbWFsbCBjaGFuZ2VzIGFzIHBlciBKYWNvcG8g
cmV2aWV3DQo+Pj4+DQo+Pj4+DQo+Pj4+IENoYW5nZXMgaW4gdjY6DQo+Pj4+IC0+IHdvcmtlZCBh
IGJpdCBvbiBzY2FsZXIsIGFkZGVkIHRyeSBjcm9wIGFuZCBvdGhlciBjaGFuZ2VzIGFzIHBlciBK
YWNvcG8gcmV2aWV3DQo+Pj4+IC0+IHdvcmtlZCBvbiBpc2MtYmFzZSBlbnVtX2ZtdCAsIHJld29y
a2VkIGFzIHBlciBKYWNvcG8gcmV2aWV3DQo+Pj4+DQo+Pj4+IENoYW5nZXMgaW4gdjU6DQo+Pj4+
IC0+IHJlbW92ZWQgcGF0Y2ggdGhhdCByZW1vdmVkIHRoZSAnc3RvcCcgdmFyaWFibGUgYXMgaXQg
d2FzIHN0aWxsIHJlcXVpcmVkDQo+Pj4+IC0+IGFkZGVkIHR3byBuZXcgdHJpdmlhbCBwYXRjaGVz
DQo+Pj4+IC0+IHJld29ya2VkIHNvbWUgcGFydHMgb2YgdGhlIHNjYWxlciBhbmQgZm9ybWF0IHBy
b3BhZ2F0aW9uIGFmdGVyIGRpc2N1c3Npb25zIHdpdGggSmFjb3BvDQo+Pj4+DQo+Pj4+DQo+Pj4+
IENoYW5nZXMgaW4gdjQ6DQo+Pj4+IC0+IGFzIHJldmlld2VkIGJ5IEhhbnMsIGFkZGVkIG5ldyBw
YXRjaCB0byByZW1vdmUgdGhlICdzdG9wJyB2YXJpYWJsZSBhbmQgcmV3b3JrZWQNCj4+Pj4gb25l
IHBhdGNoIHRoYXQgd2FzIHVzaW5nIGl0DQo+Pj4+IC0+IGFzIHJldmlld2VkIGJ5IEphY29wbywg
cmV3b3JrZWQgc29tZSBwYXJ0cyBvZiB0aGUgbWVkaWEgY29udHJvbGxlciBpbXBsZW1lbnRhdGlv
bg0KPj4+Pg0KPj4+Pg0KPj4+PiBDaGFuZ2VzIGluIHYzOg0KPj4+PiAtIGNoYW5nZSBpbiBiaW5k
aW5ncywgc21hbGwgZml4ZXMgaW4gY3NpMmRjIGRyaXZlciBhbmQgY29udmVyc2lvbiB0byBtYw0K
Pj4+PiBmb3IgdGhlIGlzYy1iYXNlLg0KPj4+PiAtIHJlbW92ZWQgc29tZSBNQUlOVEFJTkVSUyBw
YXRjaGVzIGFuZCB1c2VkIHBhdHRlcm5zIGluIE1BSU5UQUlORVJTDQo+Pj4+DQo+Pj4+IENoYW5n
ZXMgaW4gdjI6DQo+Pj4+IC0gaW50ZWdyYXRlZCBtYW55IGNoYW5nZXMgc3VnZ2VzdGVkIGJ5IEph
Y29wbyBpbiB0aGUgcmV2aWV3IG9mIHRoZSB2MSBzZXJpZXMuDQo+Pj4+IC0gYWRkIGEgZmV3IG5l
dyBwYXRjaGVzDQo+Pj4+DQo+Pj4+DQo+Pj4+DQo+Pj4+IEV1Z2VuIEhyaXN0ZXYgKDEzKToNCj4+
Pj4gICAgIG1lZGlhOiBhdG1lbDogYXRtZWwtaXNjLWJhc2U6IHVzZSBzdHJlYW1pbmcgc3RhdHVz
IHdoZW4gcXVldWVpbmcNCj4+Pj4gICAgICAgYnVmZmVycw0KPj4+PiAgICAgbWVkaWE6IGF0bWVs
OiBhdG1lbC1pc2MtYmFzZTogcmVwbGFjZSBpc19zdHJlYW1pbmcgY2FsbCBpbg0KPj4+PiAgICAg
ICBzX2ZtdF92aWRfY2FwDQo+Pj4+ICAgICBtZWRpYTogYXRtZWw6IGF0bWVsLWlzYzogcmVtb3Zl
IHJlZHVuZGFudCBjb21tZW50cw0KPj4+PiAgICAgbWVkaWE6IGF0bWVsOiBhdG1lbC1pc2M6IGlt
cGxlbWVudCBtZWRpYSBjb250cm9sbGVyDQo+Pj4+ICAgICBtZWRpYTogYXRtZWw6IGF0bWVsLXNh
bWE1ZDItaXNjOiBmaXggd3JvbmcgbWFzayBpbiBZVVlWIGZvcm1hdCBjaGVjaw0KPj4+PiAgICAg
bWVkaWE6IGF0bWVsOiBhdG1lbC1pc2MtYmFzZTogdXNlIG11dGV4IHRvIGxvY2sgYXdiIHdvcmtx
dWV1ZSBmcm9tDQo+Pj4+ICAgICAgIHN0cmVhbWluZw0KPj4+PiAgICAgbWVkaWE6IGF0bWVsOiBh
dG1lbC1pc2M6IGNvbXBhY3QgdGhlIGNvbnRyb2xsZXIgZm9ybWF0cyBsaXN0DQo+Pj4+ICAgICBt
ZWRpYTogYXRtZWw6IGF0bWVsLWlzYzogY2hhbmdlIGZvcm1hdCBwcm9wYWdhdGlvbiB0byBzdWJk
ZXYgaW50byBvbmx5DQo+Pj4+ICAgICAgIHZlcmlmaWNhdGlvbg0KPj4+PiAgICAgbWVkaWE6IGF0
bWVsOiBhdG1lbC1zYW1hN2c1LWlzYzogcmVtb3ZlIHN0cmF5IGxpbmUNCj4+Pj4gICAgIGR0LWJp
bmRpbmdzOiBtZWRpYTogbWljcm9jaGlwLHhpc2M6IGFkZCBidXMtd2lkdGggb2YgMTQNCj4+Pg0K
Pj4+IEknbSBhIGJpdCB1bmhhcHB5IHdpdGggdGhlIG9yZGVyIG9mIHRoZXNlIHBhdGNoZXMuIE1v
c3RseSB0aGVzZSBhcmUgZml4ZXMsDQo+Pj4gZXhjZXB0IGZvciBwYXRjaGVzIDQgYW5kIDgsIHdo
aWNoIGFyZSB0aGUgbWVhdCBvZiB0aGlzIHNlcmllcyBhbmQgYWN0dWFsbHkNCj4+PiBzd2l0Y2hp
bmcgb24gdGhlIE1DIHN1cHBvcnQuDQo+Pj4NCj4+PiBDYW4gdGhvc2UgYmUgbW92ZWQgdG8gdGhl
IGVuZD8gVGhhdCBhbHNvIG1ha2VzIGl0IGVhc2llciB0byBtZXJnZSB0aGUgZWFybGllcg0KPj4+
IHBhdGNoZXMgaWYgc29tZSBtb3JlIHdvcmsgaXMgbmVlZGVkIGZvciB0aGUgTUMgcGFydC4NCj4+
Pg0KPj4+IEknbSBhbHNvIG5vdCBzdXJlIHdoZXRoZXIgcGF0Y2hlcyA0IGFuZCA4IHNob3VsZG4n
dCBiZSBhIHNpbmdsZSBwYXRjaCwNCj4+PiBzaW5jZSBwYXRjaCA0IGxlYXZlcyB0aGUgZHJpdmVy
IGluIGFuIGluY29uc2lzdGVudCBzdGF0ZSBzaW5jZSBpdCBpcw0KPj4+IG1pc3NpbmcgdGhlIGxp
bmsgdmFsaWRhdGlvbiBjb2RlIHRoYXQgcGF0Y2ggOCBhZGRzLiBVbmxlc3MgSSBtaXNzZWQNCj4+
PiBzb21ldGhpbmc/DQo+Pg0KPj4gSGVsbG8gSGFucywNCj4+DQo+PiBUaGUgZGlmZmVyZW5jZSB0
aGF0IHBhdGNoIDggaXMgbWFraW5nIGlzIHRoYXQgdGhlICdvbGQgd2F5JyBvZg0KPj4gY29uZmln
dXJpbmcgdGhlIElTQyBpcyBubyBsb25nZXIgcG9zc2libGUuDQo+Pg0KPj4gUGF0Y2ggNCBtYWtl
cyB0aGUgSVNDICdtYy1yZWFkeScgd2l0aCBhbGwgZW50aXRpZXMsIGxpbmtzLCBidXQgdGhlIG9s
ZA0KPj4gd2F5IHN0aWxsIHdvcmtzIChtZWFuaW5nIHRoYXQgdGhlIHRvcCBkcml2ZXIgd2lsbCBj
YWxsIHNfZm10IGRvd24gdG8gdGhlDQo+PiBzdWJkZXYgKS4NCj4+IEFmdGVyIHBhdGNoIDgsIHRo
ZSBkcml2ZXIgbm8gbG9uZ2VyIGhhcyB0aGlzIHN1cHBvcnQgYXQgYWxsLCBhbmQNCj4+IHZhbGlk
YXRlcyBsaW5rcyBhdCBzdGFydF9zdHJlYW1pbmcsIGFuZCBubyBsb25nZXIgc2V0cyBhbnl0aGlu
ZyB0byB0aGUNCj4+IHN1YmRldiwganVzdCB2YWxpZGF0ZXMgdGhlIGNvbmZpZyB0aGF0IHRoZSBz
dWJkZXYgYWxyZWFkeSBoYXMuDQo+PiBTbyBvbmUgcmVhc29uIHRoYXQgSSBoYWQgdGhpbmdzIGlu
IHR3byBwYXRjaGVzIHdhcyB0aGF0IHBhdGNoIDggbWFrZXMNCj4+IHRoaXMgYmlnIGNoYW5nZSB0
aGF0IGFsc28gbWFrZXMgdXNlcnNwYWNlIGJlaGF2ZSBkaWZmZXJlbnRseSBhbmQgaGFzIHRvDQo+
PiBjb25maWd1cmUgYWxsIHRoZSBzdWJkZXZzIGFuZCBtZWRpYSBwaXBlbGluZS4NCj4+DQo+PiBJ
ZiB5b3UgZmVlbCBwYXRjaCA0IGFuZCBwYXRjaCA4IHNob3VsZCBiZSBzcXVhc2hlZCwgSSBjYW4g
ZG8gaXQsIGRlZmluaXRlbHkuDQo+Pg0KPj4gTGV0IG1lIGtub3cgaG93IHRvIHByb2NlZWQgPw0K
PiANCj4gQWgsIHRoYXQgd2FzIHlvdXIgaW50ZW50aW9uLiBUaGUgcHJvYmxlbSBpbiBwYXRjaCA0
IGlzIHRoYXQgeW91IHNldA0KPiBWNEwyX0NBUF9JT19NQywgd2hpY2ggaW5kaWNhdGVzIHRvIGFw
cGxpY2F0aW9ucyB0aGF0IHRoZXkgaGF2ZSB0byB1c2UNCj4gdGhlIE1DIGFuZCBjb25maWd1cmUg
dGhlIHBpcGVsaW5lIGNvcnJlY3RseS4gTW92aW5nIHRoYXQgdG8gcGF0Y2ggOA0KPiBzaG91bGQg
cmVzb2x2ZSB0aGF0LCBJIHRoaW5rLg0KDQpPa2F5ICwgZ290IGl0Lg0KDQpEbyB5b3Ugd2lzaCB0
byBhcHBseSBzb21lIG9mIHRoZSBwYXRjaGVzID8gbGlrZSBtYXliZSAxLDIsMywgNSwgNywgOSwg
MTAgDQo/IEkgY2FuIHRoZW4gbWFrZSB0aGUgc2VyaWVzIHNtYWxsZXIgZm9yIHRoZSBuZXh0IGl0
ZXJhdGlvbi4gT3RoZXJ3aXNlIEkgDQp3aWxsIHJlc2VuZCBldmVyeXRoaW5nLCBubyBwcm9ibGVt
Lg0KDQpFdWdlbg0KDQo+IA0KPiBSZWdhcmRzLA0KPiANCj4gICAgICAgICAgSGFucw0KPiANCj4+
DQo+PiBUaGFua3MsDQo+PiBFdWdlbg0KPj4NCj4+Pg0KPj4+IFJlZ2FyZHMsDQo+Pj4NCj4+PiAg
ICAgICAgICAgSGFucw0KPj4+DQo+Pj4+ICAgICBBUk06IGR0czogYXQ5MTogc2FtYTdnNTogYWRk
IG5vZGVzIGZvciB2aWRlbyBjYXB0dXJlDQo+Pj4+ICAgICBBUk06IGNvbmZpZ3M6IGF0OTE6IHNh
bWE3OiBhZGQgeGlzYyBhbmQgY3NpMmRjDQo+Pj4+ICAgICBBUk06IG11bHRpX3Y3X2RlZmNvbmZp
ZzogYWRkIGF0bWVsIHZpZGVvIHBpcGVsaW5lIG1vZHVsZXMNCj4+Pj4NCj4+Pj4gICAgLi4uL2Jp
bmRpbmdzL21lZGlhL21pY3JvY2hpcCx4aXNjLnlhbWwgICAgICAgIHwgICAyICstDQo+Pj4+ICAg
IGFyY2gvYXJtL2Jvb3QvZHRzL3NhbWE3ZzUuZHRzaSAgICAgICAgICAgICAgICB8ICA0OSArKw0K
Pj4+PiAgICBhcmNoL2FybS9jb25maWdzL211bHRpX3Y3X2RlZmNvbmZpZyAgICAgICAgICAgfCAg
IDMgKw0KPj4+PiAgICBhcmNoL2FybS9jb25maWdzL3NhbWE3X2RlZmNvbmZpZyAgICAgICAgICAg
ICAgfCAgIDIgKw0KPj4+PiAgICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL01ha2VmaWxl
ICAgICAgICAgfCAgIDIgKy0NCj4+Pj4gICAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9h
dG1lbC1pc2MtYmFzZS5jIHwgNTE4ICsrKysrKysrKystLS0tLS0tLQ0KPj4+PiAgICAuLi4vbWVk
aWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwtaXNjLXNjYWxlci5jICAgfCAyNjcgKysrKysrKysrDQo+
Pj4+ICAgIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwtaXNjLmggICAgICB8ICA1
OCArLQ0KPj4+PiAgICAuLi4vbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwtc2FtYTVkMi1pc2Mu
YyAgfCAgODcgKy0tDQo+Pj4+ICAgIC4uLi9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1zYW1h
N2c1LWlzYy5jICB8ICA5MyArKy0tDQo+Pj4+ICAgIDEwIGZpbGVzIGNoYW5nZWQsIDc1NCBpbnNl
cnRpb25zKCspLCAzMjcgZGVsZXRpb25zKC0pDQo+Pj4+ICAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy1zY2FsZXIuYw0KPj4+Pg0KPj4+
DQo+Pg0KPiANCg0K
