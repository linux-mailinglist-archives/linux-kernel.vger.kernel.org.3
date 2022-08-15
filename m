Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CFA5929F0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241097AbiHOG6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbiHOG6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:58:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C1210552;
        Sun, 14 Aug 2022 23:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660546690; x=1692082690;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IIhJDbYfe+jBk/+g2LpKwr/p95f4SrTrKXMru2z2nTM=;
  b=es95PbPKTviK5YR0o26dgpWlOEg2zumb9bCaGan3HZePaLv07HwXPkPD
   555L3l47F6sX+8jxJkRJ7Ks4SjxGRiTRaOklpRkY1xEyHOmp6OZdzkA2D
   /soBkTNV0u0ObXmkPPXUVguvBx13wUVvsq2XIv+NJz9siQPke17AMYj9i
   3b5Cw3dOpWbixT7NGggMVj3JVkvtNRD0QghNT8RYxUfq3A8Ekt8+n3JcE
   Pf1oQ+yE10ucbkIWCwtizwk/0emfmIVN8oBNHS1IVQRvB2Ea5UDCTixUP
   And76Y3D/xO5ZFsqnMnK1wiF458aJCVJNySQD/+f77HG/GU6YSwETRP7I
   w==;
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="176375315"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Aug 2022 23:58:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sun, 14 Aug 2022 23:58:09 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Sun, 14 Aug 2022 23:58:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YC/5erupTAX2IiMGZUBztF3ewWQPDq5ONN+O430uRAdR+utsiT2XBWv5x73azYa+JlwcmW3o9zhgDr6S2JIKOKVRMKfxUtfNGO8ttds8l13qE6D7U9acgsD9Bnc/NosU9Yn2errWpfZrqJe9ACY6XAISLnzazs1f1IRABa7xGOs/cIMr+3uiH+hOo7h1FvXRbXbLSeYEJAcSgX943+1aR14E/0own040fCzBHWXNi4V8ptflVNRqJlsGokc41QAiAC/MASBvx8X29XJ10zQXZYT6OULXTFoWGQ7+joURYwI94HDoK3rA4uWMhbtbBl4UDfooWFvutwhymCX51t3NJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIhJDbYfe+jBk/+g2LpKwr/p95f4SrTrKXMru2z2nTM=;
 b=aSNV9b2OnW8S61XIYAOm/Z/gnYFcsU7o30HVgMAGxifSJL/zKfuekE/ceJbnPfAHVNwzC15w18y/RKzAbOi1cFyiHZx0PDZgk9/wDjj6efxbt3I9BIAdhddMtchkuqe9XTqvMtrN91uZ8SiuT26Kaee9VZ0InlBOQvE1B8k3UyhVyfiRznYYzh8mSkjqvZDqX0/rzLFY9s37c2cv9P843uhKaXRVCf5x6zqhb721WNA+QB11V5l61QsXfHoH/JhVWK5fVjtl9NPIJKGwNSsoH2vQUqy5r3cM4cRNc9AbxvPoMvn+p6RF0nfSsJypUiUCOZiSKGL05eqIKut2LjZXJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIhJDbYfe+jBk/+g2LpKwr/p95f4SrTrKXMru2z2nTM=;
 b=Kw5o/tA8JpWL7P612urABCig7XRzaQLAk9AZNpOw2ndEljmpbhLuWaKEylEwpYNbx4suu7nQTVILVFqyMk1u3wxEgByqqPBvwldvWmUa4B8VeLYab+X/wL6krceErx24uFi1kuy8ZAYdY4Ac011XUAYjSI6/SCOZFbq27+OWj9k=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CY4PR11MB1304.namprd11.prod.outlook.com (2603:10b6:903:2c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Mon, 15 Aug
 2022 06:58:00 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 06:58:00 +0000
From:   <Conor.Dooley@microchip.com>
To:     <samuel@sholland.org>, <wens@csie.org>, <jernej.skrabec@gmail.com>
CC:     <arnd@arndb.de>, <hdegoede@redhat.com>, <icenowy@aosc.io>,
        <krzysztof.kozlowski+dt@linaro.org>, <mripard@kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH v2 00/10] soc: sunxi: sram: Fixes and D1 support
Thread-Topic: [PATCH v2 00/10] soc: sunxi: sram: Fixes and D1 support
Thread-Index: AQHYsF1YH+pqN4MNEUGCE6LhJWZNVK2vh+gA
Date:   Mon, 15 Aug 2022 06:58:00 +0000
Message-ID: <095cb5ca-3e63-50b0-f604-4c8c226f67e0@microchip.com>
References: <20220815041248.53268-1-samuel@sholland.org>
In-Reply-To: <20220815041248.53268-1-samuel@sholland.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ac307b8-ae36-45e3-21aa-08da7e8b7e0a
x-ms-traffictypediagnostic: CY4PR11MB1304:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SXK8wCaoionQw0sjCIEsvRfYm7+6FZHrY2gIj5gJvlZ3bTZWEDg+xzpa694pyWvFS9T8WCnM1oyjhF6Yhg78cpxY8pI3aTXs7uqv3mbGwAseSPnq0jX8yCJlr5vX4/7NcqKOo073Uzs+V4Ts0fN1VceNYbwSmUJxNxXAjDI3JLJ03dCq/3Axu6LtjtJ/COS/hJoLUge+aD2UaSfIjsr2Y0cL7uHfDsDbEXJSmut6UsFZQhL7kp/us/J8BkcVp6knF/ZzhsPwFJJUCOBa0wLVu/1hsTb2/OJBGMX6590v9EKdlR2ktNETFIawE7KjLDn5S8nkscBTl8l3pYP7tkWwCe4sOuP+3hSJlFnS1IejPaPSF5rJ5Dgg8xdeiT3H0DujCvL7eMknYtSx1SEmlTrw53uYqQzaFk/gA5/zaJvmlSAZV3q13FYUyoPm4EqTTBsCGSHuR7jcczkcmE8QGKRIGxndKsjDpPRzQbz+X5sCY7kTgO8e9biCEjdy57VMcc6darAAl+2xV/AeaAz2bbl1i2FYf46ui0L3oNTE+Q6cKCVy6WekLppOwbRP4Dd9qrwdJ+wJA7FQ5FDn0mPOCpw/A2nLHRwot/87Yks68lmiWGLQjfI5wtywuYKsP6p0Vpu2K1zjPGIM/D/xVKn+RgMa7X/wFG8k+KjJ1NJlkM4q+WmlNpp90HFOlqFoCPZcDHTNPanRMMmk737OtOmmsOigGs21h1F+7Bv4TrerTe8E2oYj2GoZ96x4q2AuvlV7XjkhHmihjvq+UiTAo4HIW/zcoSiE4mHFbI7qMftcuEFqoqU8SnufQ+7L06LutfYlpI7GKih59DII3RgeGtAueo0O/65yv2UxMRgEUiNK80YfkcY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(376002)(346002)(39860400002)(54906003)(31686004)(110136005)(316002)(6486002)(91956017)(71200400001)(4326008)(76116006)(66556008)(66476007)(66446008)(64756008)(8676002)(36756003)(66946007)(83380400001)(6512007)(26005)(2616005)(31696002)(5660300002)(8936002)(7416002)(86362001)(186003)(478600001)(38070700005)(2906002)(6506007)(41300700001)(53546011)(122000001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eldDRndyckpOUkVIMS9pc1c1cjlhalVZdEh2TUVmY050Z1o4NUV0bGdLRkhV?=
 =?utf-8?B?ZHY5YXUyYUFESGhpakl0cktRdHZmTGhPMFUxM0pDMzZkeHVLVSszTURNYnBj?=
 =?utf-8?B?blZNbituWlVmcndycFV4OWJWaU9PY0xCVG1OMUNEYnJuYU1DdTEzVldCUmEz?=
 =?utf-8?B?MTBwcU1TM1dETTBuK3NZeFM4TVlTVm4xKzBQZStGQS9OSXNHT1ZRM2ZrZ0h1?=
 =?utf-8?B?WnU1RXhkc29yaExsNmlRczltd0M5Tk5hWnhhVWhDY1FMbnEvZDc2T3lOb2pZ?=
 =?utf-8?B?dGhVZXdNYmRFbnRnazhIQWkwQTJGREVIMm9rRkdxQjJoVGkzTFBIT3Q3aktq?=
 =?utf-8?B?S3NkbjBnSGt6TFpHamlRa2dtdGEvZ0Y4dThoUEV1U3d2SEo5eGJET3lTRWhy?=
 =?utf-8?B?WE9Id2Faazk4MjU1UUI3R2ZXT1hSYnppWTBQUGpqdE05MjNWWG56Smd6VTBI?=
 =?utf-8?B?TEtzSlhncDhQM1g2cGZxSzIyZ1FVWHNWa0FyRGhFQjRVeEExZmwxS3BKd2Nx?=
 =?utf-8?B?WWlIZDVMSlN3N3N5RG5uazNDZGkwNi8rMlJ0YTJHNTFFRVZtTGg3YmV4cm0y?=
 =?utf-8?B?REl2azA1ZFBmaTVsT05VRWFrdVQ1dHN6RmFBL3ZUampkaG1wM3hHLzBGUkZ3?=
 =?utf-8?B?TjlsV1N5OFhMN0Zab3pvbjZBbjZhbE8xdW9Ka3NZQU91OXRQYzRVUFhpWHRi?=
 =?utf-8?B?UzU5NDUyUm45b3dyajIrNTNuQ3k4TjJ4N2pMZGgvRzNFNFpuNGFkaklTdnl1?=
 =?utf-8?B?Q0RJcmxwbmhXMW83NUxNemR1RGxEUUh1Mzcvek8xL0Rucjg0N2x4Z3lZeGd5?=
 =?utf-8?B?aHY5dWFTeEdxd3JLY0pUUGE3a0JzeVdPMjJEaDhEQklzTHVaKzVWYzhLN0ky?=
 =?utf-8?B?aDZyN2kvQXJUNEFxK3VlVWxSNEFTbDNTT2VWeW1HQWdEY0dOWlVza3Y5YTZT?=
 =?utf-8?B?RUo5VG9oRE5MMDV2NGM3YkRFY0svMnlwUGRUWiswS1dIekFMQU1jQ1ZrVGFx?=
 =?utf-8?B?U01HMjVTVG44QXhlRUQ4RWxRampFVFluVlFnbzZrSTI1RzZWRnNTOUxEbVZt?=
 =?utf-8?B?ejdtbmxjdDF0cUZ2MHNPVWI3VGJnWDlManBWcWlrV2JBS1FBaExnQ0g3NDFl?=
 =?utf-8?B?TnpuVkRsNU1LY2hLRnV2akUwa2MwdXJGMjZVZ0Vydlo0aGRqOW5wbUJqSGwx?=
 =?utf-8?B?Z005VThyK0NlajlaL3pyb0hGcndSdmFIMlE0b3F6RFBLOGF5QVI3M2Fpak45?=
 =?utf-8?B?UDBLLzNqZmMvaEV4c2gvUkVyZVQ0a1lzYmY4blMwelo1VDBVRVBRcElaeEli?=
 =?utf-8?B?d3dWTk9ZaVFtUm9ISzhDSWlvQXJUalQ5eFYzV05kUnVoNzFqNEZxa1pIcXQz?=
 =?utf-8?B?ZUp5OEJrZmZzeldTVnRXR1lUdjZIbGxHV1pZSzMrTzdIdk91ai9RdXJKWmln?=
 =?utf-8?B?UmlDR2d0WGl5d0kzcFRrT1lTbHFzd2k3dzVWNjVLU1laZ1Rua0t6QzdhdDBJ?=
 =?utf-8?B?Y0dwdGVSb3Rzd0lxWDFPUW1wcm9VbU9jMnlEUXU5aUVQSkhiL3ZoaWRTUG5I?=
 =?utf-8?B?b1JWajdrS3FHZlgwbG5QdEoyQXBVbHFLMXRzbVZXcWp5djlwVGowWEsydmM5?=
 =?utf-8?B?SWpUVGNRdmpEYXRyQnJZeDg3bkRjU0VRNHJUVEtwYmFFQlRzMVgrVmpoRWZv?=
 =?utf-8?B?TmtGbnlwb3AyTXN2T1NhTXd4eUdIY0pETXFiaEpiTEJha0tmaDlKMml2Mkth?=
 =?utf-8?B?dzRXVHVYWlJiQXl2aU5scUFnSnBlM1JoSkxVUVVjSlFBRXNlVVF6VFFZSTNO?=
 =?utf-8?B?am0wTTA4T1R3TDNKQ3VnL1BKV01vSU9UdEFJZks1Z0plN2l2OWx0d0dTalcr?=
 =?utf-8?B?TDVIcXZFZm9DQlJBR2hjczB1YzhRMFc3cTVWZ1MwTm1ibDd6MUExejVndHNG?=
 =?utf-8?B?WWZlZWduZTFrQkxPd3V0aWFvaHZkcVkyNGlVeXEyMnVmdW51alRkMHZoOHJs?=
 =?utf-8?B?RGVBQlZiRFoyTkVsOTFkeDYxVjlpZml4TGpXS0x1R2JhZjZNc2RjbVBRc1Z5?=
 =?utf-8?B?MXJSV01ndmNnQnluYUVBNDJWOWZsd3FkUUtpZVdCVUJDNGxKTlN5MEdtemE5?=
 =?utf-8?Q?tcQKe6+ZR+5xZFPJYFRqzFstm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C120FA41A0250449EBB13D02C6204A9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac307b8-ae36-45e3-21aa-08da7e8b7e0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 06:58:00.5857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0TuiyAxo/7UtsKIZcOPjUfCNsBkjX//hiyIQV1JlnV0Xt97bRi94UMK49VImdg6myFolliMP7dKnxgMuCwW1r2NFPbKZePLvBti5HEIjKrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1304
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IFNhbXVlbCwNCk9uIDE1LzA4LzIwMjIgMDU6MTIsIFNhbXVlbCBIb2xsYW5kIHdyb3RlOg0K
PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFRoaXMgc2VyaWVzIGNs
ZWFucyB1cCBhIGZldyBpc3N1ZXMgaW4gdGhlIHN5c3RlbSBjb250cm9sbGVyIGRyaXZlciwgYW5k
DQo+IHRoZW4gZXhwYW5kcyB0aGUgZXhwb3J0ZWQgcmVnbWFwIHRvIHN1cHBvcnQgb25lIG9mIHRo
ZSBwYWlycyBvZiBMRE9zDQo+IGJ1aWx0IGluIHRvIHRoZSBEMSBTb0MuDQo+IA0KPiBFdmVudHVh
bGx5LCB3ZSB3aWxsIG5lZWQgdG8gdXBkYXRlIHRoZSBTUkFNIHJlZ2lvbiBjbGFpbWluZyBBUEkg
c28NCj4gb3duZXJzaGlwIGNhbiBiZSBzd2FwcGVkIGJhY2sgYW5kIGZvcnRoIGJ5IGNvbnN1bWVy
IGRyaXZlcnMuIFRoaXMgd2lsbA0KPiBiZSBuZWNlc3NhcnkgZm9yIHVwbG9hZGluZyBmaXJtd2Fy
ZSB0byB0aGUgUjMyOS9EMSBEU1BzLCBidXQgaXQgaXMgbm90DQo+IG5lZWRlZCBmb3IgaW5pdGlh
bCBicmluZ3VwLg0KDQpJIHRyaWVkIHRoaXMgc2VyaWVzIG9uIHRvcCBvZiBib3RoIDYuMC1yYzEg
JiBuZXh0LCBidXQgSSBzYXcgYSBzaGVkDQpsb2FkIG9mIGVycm9ycyBmcm9tIGR0YnNfY2hlY2su
IEknbGwgdGFrZSBhIGxvb2sgYXQgdGhlIHJlc3Qgb2YgdGhlDQpzZXJpZXMgbGF0ZXIgb24sIGJ1
dCBqdXN0IEZZSS4gSSBrbm93IEkgaGF2ZSBzZWVuIHBhdGNoZXMgZ29pbmcgaW50bw0KZGlmZmVy
ZW50IHN1YnN5c3RlbXMgc28gSSBhc3N1bWUgeW91J3JlIHdvcmtpbmcgb24gaXQuIEhvd2V2ZXIs
IGl0DQp3b3VsZCBiZSBuaWNlIHRvIGxldCB1cyB3aGF0IGFsbCB0aGUgZGVwZW5kZW5jaWVzIGZv
ciB0aGlzIHNlcmllcyBhcmUNCmR0LWJpbmRpbmcgd2lzZSBpbiB0aGUgY292ZXIgbGV0dGVyLg0K
SSBoYXZlIGJlZW4gdHJ5aW5nIHRvIGdldCByaXNjdiBkb3duIHRvIDAgd2FybmluZ3MgYW5kIHdv
dWxkIG5vdCBiZQ0KaW4gZmF2b3VyIG9mIGFjY2VwdGluZyBwYXRjaGVzIHRoYXQgZ28gaW4gdGhl
IG90aGVyIGRpcmVjdGlvbi4NCihUaGlzIHBhdGNoc2V0IGN1cnJlbnRseSBwcm9kdWNlcyBhYm91
dCA3NSB3YXJuaW5ncykNCg0KVGhhbmtzLA0KQ29ub3IuDQoNCj4gDQo+IENoYW5nZXMgaW4gdjI6
DQo+ICAgLSBOZXcgcGF0Y2ggdG8gZmlyc3QgY2xlYW4gdXAgdGhlIGJpbmRpbmcNCj4gDQo+IFNh
bXVlbCBIb2xsYW5kICgxMCk6DQo+ICAgIGR0LWJpbmRpbmdzOiBzcmFtOiBzdW54aS1zcmFtOiBD
bGVhbiB1cCB0aGUgY29tcGF0aWJsZSBsaXN0cw0KPiAgICBkdC1iaW5kaW5nczogc3JhbTogc3Vu
eGktc3JhbTogQWRkIEQxIGNvbXBhdGlibGUgc3RyaW5nDQo+ICAgIHNvYzogc3VueGk6IHNyYW06
IEFjdHVhbGx5IGNsYWltIFNSQU0gcmVnaW9ucw0KPiAgICBzb2M6IHN1bnhpOiBzcmFtOiBQcmV2
ZW50IHRoZSBkcml2ZXIgZnJvbSBiZWluZyB1bmJvdW5kDQo+ICAgIHNvYzogc3VueGk6IHNyYW06
IEZpeCBwcm9iZSBmdW5jdGlvbiBvcmRlcmluZyBpc3N1ZXMNCj4gICAgc29jOiBzdW54aTogc3Jh
bTogRml4IGRlYnVnZnMgaW5mbyBmb3IgQTY0IFNSQU0gQw0KPiAgICBzb2M6IHN1bnhpOiBzcmFt
OiBSZXR1cm4gdm9pZCBmcm9tIHRoZSByZWxlYXNlIGZ1bmN0aW9uDQo+ICAgIHNvYzogc3VueGk6
IHNyYW06IFNhdmUgYSBwb2ludGVyIHRvIHRoZSBPRiBtYXRjaCBkYXRhDQo+ICAgIHNvYzogc3Vu
eGk6IHNyYW06IEV4cG9ydCB0aGUgTERPIGNvbnRyb2wgcmVnaXN0ZXINCj4gICAgc29jOiBzdW54
aTogc3JhbTogQWRkIHN1cHBvcnQgZm9yIHRoZSBEMSBzeXN0ZW0gY29udHJvbA0KPiANCj4gICAu
Li4vYWxsd2lubmVyLHN1bjRpLWExMC1zeXN0ZW0tY29udHJvbC55YW1sICAgfCA4MiArKysrKysr
Ky0tLS0tLS0tLS0tDQo+ICAgZHJpdmVycy9zb2Mvc3VueGkvc3VueGlfc3JhbS5jICAgICAgICAg
ICAgICAgIHwgNzQgKysrKysrKysrLS0tLS0tLS0NCj4gICBpbmNsdWRlL2xpbnV4L3NvYy9zdW54
aS9zdW54aV9zcmFtLmggICAgICAgICAgfCAgMiArLQ0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgNzMg
aW5zZXJ0aW9ucygrKSwgODUgZGVsZXRpb25zKC0pDQo+IA0KPiAtLQ0KPiAyLjM1LjENCj4gDQoN
Cg==
