Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEA1572EA8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbiGMHDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiGMHDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:03:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E762E1461;
        Wed, 13 Jul 2022 00:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657695801; x=1689231801;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3KOIJD3p52NTmLG3BG8VYDoHHYbP9SdvXnXWYGyEqYo=;
  b=l5aHqZbMgg4d80hr/qA5x4YBPvvoAYsopyp6F3kN6gDN7+0DFY58a+j4
   2EN2fynUZyoW+R/JYam+PiYp8SrL6va8ehCnHJdqwLHWh5IBSm3myq6ee
   /vxYv17a8FPvPrrNAEkTY/tpnBIc6Wdi3LJuaCSET3NjphMDFG1fY3ZQ3
   C+DUOV7QHY7YR6z1pbqI8kC7Gle7nlR/9FLVjWbyat9WUGBi04mHCZNcz
   9WdG+Z4VsMUbWPgKNnsIrN9p+aSjPYniBWd2Ijr5eQ/CV2W/0dTgwbZIu
   fsVWLHGq5SRsPQXm818RqtjpvmZGvz5xu5mAKq5cTZGut9sZdEAhbR9wG
   w==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="164498012"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2022 00:03:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Jul 2022 00:03:19 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 13 Jul 2022 00:03:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9nd7oR/QV03sJ/xo8r8TbNbVuMUfBcgT+4YETJk1SrB+233fp/wR5BYDRABcX/CrNuEmANP7xCQ9MJ9ZirBDUSj+NWuceUzv/ZhAqD7s7auDFSvFNXKDyTErtkquS9aT9c5X+SXHLuhrRU004xWzlcwy5nNfh5WxAaCLU5owlGtzQFj2jvCp9gkiVlZbLXthoco5rf2aQIWaQf48gMn6mc38rzxckgvkZKEOl+DZzSWz/orHTmTfodW+SRuTIN8bKEogmHNpCzXox4agZCcUFKsKco3cTWaFum05ISSzhteSbryfZCqkcZdFvt38VZzJVQT22XfWkBCtVgSjjOzAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KOIJD3p52NTmLG3BG8VYDoHHYbP9SdvXnXWYGyEqYo=;
 b=QlQxYbBY3wmdA7nS7xPX9+dJ8ne8LYRXQqvirN9ZN1SJZtVtRmI6gqjCpSDzqoO/bxN7QrDeiaTidMrOfEZlTRN1doj/pAnd/YGIyADTGGDu8bggg4y+lETsRSrWLcJg95zr4aXUzXuEM9yUGPZCOtwGRqDmq1pWxeiU944Fov5irjDk96xMg4mP+ZzrJ1fHbxBV7xYkXBWxJ6zJCtEIAiet9SRLqzfi4zZ1P1Rpeogm3m+NEVEYz5ZZanlDsLrB43KmmChcssYYr/Hkin3Uz/S6XQLQ2jenABlthzhOGlFv6KnP+Xdu6pTxMm6wWrh+lOETdBDrjL73x0NtyRcM9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KOIJD3p52NTmLG3BG8VYDoHHYbP9SdvXnXWYGyEqYo=;
 b=BINhD+2V20qUX0x4k1lfwWgrQfnkwVUM/ZSphoZpHrbMhM34rUn6lBDHHBXlnnCBN4mP8oj8xOMRxHWpGLa9sHM4TycyNoNxoLm5c9HVBU6p8qFsx60YZGw4WGvQ9V8yyabtfP2LDPZSjLjBwqONiyshYpD54PromSP8VTAKT1k=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BL0PR11MB3204.namprd11.prod.outlook.com (2603:10b6:208:60::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 07:03:14 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 07:03:14 +0000
From:   <Conor.Dooley@microchip.com>
To:     <yangyingliang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     <Daire.McNamara@microchip.com>, <broonie@kernel.org>
Subject: Re: [PATCH -next v2 0/3] spi: microchip-core: fix and cleanups
Thread-Topic: [PATCH -next v2 0/3] spi: microchip-core: fix and cleanups
Thread-Index: AQHYlmL1WOfA5tQjaESXQrzlQuwIXa174ISA
Date:   Wed, 13 Jul 2022 07:03:14 +0000
Message-ID: <f6280aaa-51ab-1857-59ae-2ba2ed03f24b@microchip.com>
References: <20220713025657.3524506-1-yangyingliang@huawei.com>
In-Reply-To: <20220713025657.3524506-1-yangyingliang@huawei.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88f024a0-0b8b-481b-d09d-08da649dc151
x-ms-traffictypediagnostic: BL0PR11MB3204:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5+OXalEDZCsfG/OZWIzaetiHK4UFLPiU4io3e4jpDBy4QClfoXg/IVuTCrfUkNzc56RB66PMWiIrNLgekU4Og0waSq8u3R+B1lIGEwhYbr6rmrFXhGCaF8jRjE87TcRN3JpxmdUlt4fj1mjPzpi8NceVSQTflS9Pj33CIxLVuom2KoAOUFDGAdxmOaypLUja39qzGiy3RJ9lgqBniZyxoWueHPIvfxPttjy5WmUJj5U/7dlJ/Ik6mu/CwOw0/9ILVauY+hPqMY3gHewA2J7L7gxxdTRIsTH1iNcBQzCcSgpQF+SPMXUwLITB5J4h5mPTi6HGaL3sgPdQYwN9gR0E3GnRU2d28h/j7uulorNlkCOyJrXq1dqT/z5YtW4dQ8Nks6ZjL7ruekYvPDPSepggLViRPITcHjYPQcRWpn3sCfgZhj+NH9nx25M2OCdo2qu92xoOpgC9tQ5Ika6cK25BBYNCCkEEv6mY6dtZGaV6tERkn3blDSwgRAWMe67BLkAKOwklaCxpdUKm1eRWB92Uyrl8U5gSglJiH3Z9pNO+oqBSJX1j5ZmI9H/MHBLmIlLUozrvWx9KkcfZcLOhQ4q/i95cRItueTyVeZTOtwshLDO2PzawR/mQRWPKQxslm7aJBdTqN+2iYnnIlzn1lCthFa1e19yb8Lv/mBnMo2ii8/DTxW17Jd6yrxTeBcEEs52J+TBnsSe7/3cF8/OomYPez+Pe3VDUHKUVSOD35m+pJfagTNcbMAnl7Wl30Rdh45jTtCWJlTmNDM4AUgcMzHbJMXXlmqkJ5Zp+oNmnFPatF1ZpZ+xxeSBirNbNCNPIuZ8VUsm/FUswfZEpDp5lVkGyNLBBFzGC1fDglWdlOL2KCE2km6beJm5+YZNVVybd5b0P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(366004)(396003)(346002)(39860400002)(41300700001)(38070700005)(53546011)(6506007)(2906002)(316002)(122000001)(83380400001)(26005)(38100700002)(31686004)(91956017)(186003)(110136005)(66946007)(4744005)(64756008)(5660300002)(66476007)(8676002)(76116006)(6512007)(36756003)(66446008)(478600001)(6486002)(31696002)(86362001)(71200400001)(4326008)(54906003)(8936002)(2616005)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qk0wUUN6NjJOOXFGMWNacjNBVlpRbndHYkk5Z1hGZHY4UE11MW5iRXp4U21t?=
 =?utf-8?B?SG1TTVJpU0dKck55bUV1Y3BhRWtxN0RsbktFenhmdVNteHpPemNYZE1DY0J2?=
 =?utf-8?B?UXVFdkxGcGdhYlRmNTVUSFhZTDVSN09CQUFZNTZSVXRpZW9TOC80QVgxWS9z?=
 =?utf-8?B?Ti9uUVZPTEpIdTJjOWE5UFlvbndvQU9wTDA4VzAxY2JjY1RZU0xiaTdsSkFa?=
 =?utf-8?B?alpmN0lrdUNmSEtlMzNGUTBCM00vSXZtQ2dnZ1JQM2EzejdvbHEwOVBndE1o?=
 =?utf-8?B?dkFhYWc5TDU5ZnBYRnBjTGFIc3RVcktpSDJ3MGZJRnZIMS9FL3pzdExSZ0Fy?=
 =?utf-8?B?ejRoYVp1ZlBJNkMxT0J5UjA1K2xzV1ZoQjlHWTFJay9NRy9TYkhjbjJHam40?=
 =?utf-8?B?ZmFiNVM2VFlDdE0xUWlkMWFTUVJaL2hjVTlCMVpUMkxrK3NoL2c3Y3h4SDE4?=
 =?utf-8?B?RG5FWUVLQ2NHa0NkdER3VUcwQUFCMHBucnZ4SEpRWEVjN2xSQVd1STloRytT?=
 =?utf-8?B?Z0dvcWNaTkZlb1JXSzYySnJXdFhLbVg2dTFMTk9SOHI3MnNBbGNpaEtXSkxW?=
 =?utf-8?B?Z2hDcGV1VkFIWVVqRTk4NWhXR3ovZ2RiMXpDQzdLbVJYamVKRmVSbGNITWZi?=
 =?utf-8?B?OFB2RnAwUlFNSHBYdW5vVkhNVUdMN09abEZvUnRoZnk5OWp0dU9RSEZ6djg2?=
 =?utf-8?B?WEJFNXpVMTdEN1dWWDdyNTNyelBJVUtWYmM0VXBybHI3MEIwWkpOT3pCRTg4?=
 =?utf-8?B?OGpGZTMyZ2hWL1BJaU1CTkJ5TlZoRklaRWRZVFoybW90Y3hMSWtTY0JyL2ll?=
 =?utf-8?B?RzZjbXdlSk8xL3F0bG1zT0lMWStadi80WHRXTXVCZFNib0hqRlJTOExOcms3?=
 =?utf-8?B?QmpxYityNVZmeER1Wi9oSWxFbjFkc3Uyamdta2thUDgveE5Iay9XSjNZNXZi?=
 =?utf-8?B?cFdrV3JmcnU0c0xhRkpWRnZ4YWd6OW5jdFRUd0p0TGRFbFp2SCs1Qyt5TW1p?=
 =?utf-8?B?L0lKUCtOSFpSMzBWWVM5MFBlRXh3a2NCdndncG5qOHdVUVYzUGdhTFFnQ2do?=
 =?utf-8?B?b1RMOE0yRzdXekpBU3JvenR4cHJHSFVuVmFCQVpmcVV1a1lZVXh3b0l0dFlk?=
 =?utf-8?B?U2JjRkRzbGI4ampNeGlCZzdFeG9RVVZna1dWbml6TXlyYzlib0VNRjZ0MEdr?=
 =?utf-8?B?V0NMTmk4Y0xOZndSV1AzOW9EMFh4V20vMkp6ZkpQSTg2ZGdWOEU2a0p2eHVp?=
 =?utf-8?B?UUFSWTlWekd2Vkp2SmlOelArb0RvYzBQVFMyWEp6Mm1FODAzWGttampJYmdq?=
 =?utf-8?B?TmRDRUdTMEpUa2N6S25MY0Ivd2p5N2VaOVAvUzkyWDRZQzJaTHJqWlQvclRU?=
 =?utf-8?B?QmR4ZmhCdHBTVnl5TXdWbFUreGcvNVlnODc2aVRLYjZqL1pmZUF3cFhPOWdY?=
 =?utf-8?B?WTBEMGNLNktIcm1YTGRlMGF3eFAwejVvQzdaSUhIdG5sQ1Btc0NHeHVGb0la?=
 =?utf-8?B?aUhCcHJObUQ1YlI4dzFGb2ZFcER5S0FybU5QandhSzFvejVBeVlreS8wajdO?=
 =?utf-8?B?Wm9NVFluaTY5emR4L05Pa3p5YlN5WUwvbXJSSGFUckE5Z0hkNUZKZ0hXQ2tK?=
 =?utf-8?B?TnBYZit4ejdaMnFWKzRjR1pqVW5ZY0dxdVVGZWF6aEp3RndtKy9Da0N0SGhj?=
 =?utf-8?B?elR6UmJsaFVHZDdRUzR1RnlRRDg5ZWl2TnRHaW1LUGduc1djbmc1Q1hjY0t0?=
 =?utf-8?B?UThWbXBOK1Q3THVrMVM4NHIySkorOVZUOWZHMWt4SVNNTncvS1ZlYkt6OFZs?=
 =?utf-8?B?bVhndzh5QlluVFJqbmR1Wi9MMkg2eVcwYWxGNzNzRExpUG9BRkMxdWFzSmdN?=
 =?utf-8?B?bmlscktOVWFiNnZxZlpSQUdaQm4yZG9IazcxU0dTYmJIL0EwbUwyakVnVklX?=
 =?utf-8?B?SGgveTFmMTBxSjcxT1hNOXFDalcyL2FrS0tEWGcyaHlVemZrY21qSFZqd0hy?=
 =?utf-8?B?MG52WmZoVCtYSWgyVGNGYk56bFl0ZnZjaHpHb1F2a2dRd2pSTjFQOVZGeHJl?=
 =?utf-8?B?UlhrWktmOFNicmJBWTUxWXNPSk9YUkhmY3kydDRtMGwvTnN1QjNuRFhDOUFN?=
 =?utf-8?Q?vKxlyjTc9KmS/yu8MBL1HJEWs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <95F4291DA4ABF341A1DAD8EB63DE4618@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f024a0-0b8b-481b-d09d-08da649dc151
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 07:03:14.2041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SsxPEDX0YPqjMWy9CXHzUKSrl9MJfEDmubAJLeoT9lOXp03zuyxhNNdtbwISo+87uktx6fcGM5b2Czwq73LopqpPGix1eOon3NPmdB11HmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3204
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMvMDcvMjAyMiAwMzo1NiwgWWFuZyBZaW5nbGlhbmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gUGF0Y2ggIzEgZml4IGEgVUFGIGluIG1jaHBf
Y29yZXNwaV9yZW1vdmUoKS4NCj4gUGF0Y2ggIzIgYW5kICMzIHNvbWUgY2xlYW51cHMgdG8gc2lt
cGlmeSBjb2RlLg0KDQpQIHN1cmUgSSBhbHJlYWR5IGdhdmUgeW91IGFuIFItYiBmb3IgcGF0Y2gg
MSwgYnV0IGZvciB0aGUgc2VyaWVzOg0KDQpSZXZpZXdlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25v
ci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCg0KPiANCj4gdjEgLT4gdjI6DQo+ICAgIGFkZCBwYXRj
aCAjMyB0byB1c2UgZGV2X2Vycl9wcm9iZSB0byBzaW1waWZ5IGNvZGUuDQo+IA0KPiBZYW5nIFlp
bmdsaWFuZyAoMyk6DQo+ICAgIHNwaTogbWljcm9jaGlwLWNvcmU6IGZpeCBVQUYgaW4gbWNocF9j
b3Jlc3BpX3JlbW92ZSgpDQo+ICAgIHNwaTogbWljcm9jaGlwLWNvcmU6IHN3aXRjaCB0byB1c2Ug
ZGV2bV9zcGlfYWxsb2NfbWFzdGVyKCkNCj4gICAgc3BpOiBtaWNyb2NoaXAtY29yZTogc3dpdGNo
IHRvIHVzZSBkZXZfZXJyX3Byb2JlKCkNCj4gDQo+ICAgZHJpdmVycy9zcGkvc3BpLW1pY3JvY2hp
cC1jb3JlLmMgfCA1NiArKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAzNiBkZWxldGlvbnMoLSkNCj4gDQo+IC0tDQo+
IDIuMjUuMQ0KPiANCg0K
