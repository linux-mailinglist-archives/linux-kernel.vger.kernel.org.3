Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1ADF59D1CB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240660AbiHWHLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240880AbiHWHLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:11:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2F061B26;
        Tue, 23 Aug 2022 00:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661238670; x=1692774670;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3xyLEu1S/e4ll1jcSceDVlfuPOIPPOIvZRahZF4LWJQ=;
  b=CQu+pmH8FdLULmrRH4u/gPZS2aQ9E1MyxbkuBpvGxmcVREADS6Rp/oYj
   B+kT0tr2VmeKLpga4rRj5PeumEjW/LslWpzpKD6Zubygp0VsJR0R3DaTq
   BEpSBhB4pZGAcqOW8S5Bnp6eWt8PUpHrgUdrw59dbh9x29TNXTnI8d+S2
   3+h9JxWg/XUjduunULhCiSSEAEUylGbho2bVRTjV5bFMzkb2fFJZOldFP
   OCIcNmSrLQS8387Q8LPQ8d9qzBznj31wr70/+vGPm3IKhI2lF2hW6ndAW
   gKGS03k5KEhBn0w05ZjJrpCI7yRq09399Vfgpd3tSY0cEEwdqroT2tRWq
   g==;
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="177493121"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2022 00:11:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 23 Aug 2022 00:11:09 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 23 Aug 2022 00:11:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEcbxTxoh53gze6bk/iRoLuzMnRIxFBIOocnw8d59ILYuB2HODHALFyTtwzSIm7jZWk15PYqZdYL4kqAHiz5+8hga+ZcH0zksVRpodOLUUcOz0t6Xu9/jFdi9t13KpBsjDAhLXkd+WFejc9lMcAsKqrsIgjbYrGvjGw5Y7oz2L4HtZyCSF3krwo3xk2S74JsSjLAO8efATqYOuX4b8J8Bh+ZvvBmIPame22L2gfPRsM8JOZw6WzEdrWDy92kgaNk1/nz/XvXD71XiQtxA6g1EJDOar4FgpoZ9c+05lrOQSQ/iTvoqKnf0bWMDQJMIt6rEXcsPayNRKzqi6WjIsq7ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xyLEu1S/e4ll1jcSceDVlfuPOIPPOIvZRahZF4LWJQ=;
 b=Nme0pUt7NcsnWve/Ru1PpgFbMJnOQFW1vX8s3WgETOLWoDkGgiWl8TIZvxo4rsjLfcxoCQzBd68zpw7mUUBHyJaOB+wZZeXkePNPRsJRk65UPzNrAPsuiI9c2OtA27N7hQQ3+F73hMh8QKy++ATehINyyAd51nD9bLivOOJZ3uUa24sOxJRuJXVHiUdchhCWxqfyHs1qY2cTxu9L2Bebp7qIbtJNU/ozUiXPF+lJD3k9yRJgnwev31QpQFPneqZo0i7UipkblAxja7zeusNvzD/dMHOgmBA5uDLmtCxWtmSysKQnyUMH+tOO2M3EzPuytvsTvFOkEk6cpeU5NtzOQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xyLEu1S/e4ll1jcSceDVlfuPOIPPOIvZRahZF4LWJQ=;
 b=HGPxszPr3Rk/baKEOXY2cHIHfAibzF+Xpv7IethzZdHijGz/h5hevikNoetjbeDyTbXTVR2lZqJt86i6/1O+nhvyRXrAzXGjDQahdG2YVzKDKcHovZDb61d6cvbYOlLwIUipByvTWNxzvC6wIgrDg5RiJAUEVw3TfhAspeIuH4w=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BYAPR11MB3573.namprd11.prod.outlook.com (2603:10b6:a03:fe::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Tue, 23 Aug
 2022 07:11:03 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5d86:57e1:cb42:9ef1]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5d86:57e1:cb42:9ef1%11]) with mapi id 15.20.5546.022; Tue, 23 Aug
 2022 07:11:03 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Horatiu.Vultur@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH] ARM: dts: lan966x: add support for pcb8290
Thread-Topic: [PATCH] ARM: dts: lan966x: add support for pcb8290
Thread-Index: AQHYtr+A3xHDwRVEVUSpobFruhZzOg==
Date:   Tue, 23 Aug 2022 07:11:03 +0000
Message-ID: <8e6c780e-28ee-1f37-c14c-f0ca5f590743@microchip.com>
References: <20220817190027.1632721-1-horatiu.vultur@microchip.com>
In-Reply-To: <20220817190027.1632721-1-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85503fb0-3698-4632-d359-08da84d6a3b1
x-ms-traffictypediagnostic: BYAPR11MB3573:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VM92ujUOyHfyUVW3qUOG4EVceF/aWWPZNalH0E5IfCeMgpv3laDZLA27c0oMV5BJVuj746iaQerw5NASVeTGBUxIyztLhy9CkuOMvrgoHH2O0AVGo/NXLyy6RZUwbVbMyBXq5oOc3AP3Df9MaTkeb3zKawgqpml6WSI3snE/PJey6KNF9ssZ/YcxrkxV1Gfh564HvG55qzQ3/PYUFwWCqWGLxIhufECOEVI8azmfyC5FLaqszqfvPEIwCSFdkVu8z4QvHuh7/tNEHoMxBZx1flHj8hNS6+IjMqxZVuxC24ZecWkBMaD7sOAaX5B5+JwcO7yGMz+8MTodfyP/sxUVty75xE8HtPH5F43LSCloF7LD4I0/OG1zFdBAHcy4PL3f1JhPtihO3z2jPtwZKqO9CET0Ee3v/cCs+jPCW2PDS086EoJT162CsSoRqir7aLkOLkZW8DwMy4rg6j1OD8JJsXtHT1JvZSGDasvG6869LnxmlIAqgiE8/zLb5t3IJP32g+FOCErQqcZQ5SR5+NvxSAm5INWydsmRY2r9nEn1TAQMN6nOxDkhKj1NTwLjn7VIxXnAcR6i/aQGJFeQK8AH4163hgTg2Lc46pODTaiV4QARgYzxWHCAwBbzPWZREUWLd9+sfiaNq94Rwe9HhNYdWoZQwHAMMhL2+USoC2IeO+G97Jv9CE79SByf1HfPBjRX10A+SGH7jEsGjJkmhB+gfW9/gllYYBZNDH7KCk72sRZKeke9p20l0jcaDWA1OZeqWsvtOnTWhPDvDUJIFt2LJ9jdrptm3wupSwMRQhbo0jUGGegHlNAYz35cS2b0JfkckZTjVqONnngGvd/1IaoKQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(39860400002)(136003)(346002)(36756003)(2906002)(5660300002)(31686004)(91956017)(66476007)(8676002)(64756008)(66446008)(66556008)(66946007)(4326008)(76116006)(316002)(6506007)(110136005)(54906003)(478600001)(41300700001)(53546011)(71200400001)(6486002)(26005)(6512007)(38100700002)(38070700005)(31696002)(86362001)(186003)(2616005)(122000001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3dRUkNJL2Y2Y1VFTlNjWlBsc0ZNZU1ic2IxNHQxaVhJQlk5TUhKYmVNZmhF?=
 =?utf-8?B?UjdDTG9MenZmYngrNHJSVTdUUUhIc1RPT0Q5K3ZvLzREWXllT3NDMmtZY1FS?=
 =?utf-8?B?bDJqMWtkVi91L2hFYTd6aVBpN3VsK3NXVU1wekJqOEIzRm9ZUUI3eWg1MURL?=
 =?utf-8?B?YWVaWTVkWE96YURBSWxTRGFYcjczQUNHcHhwVnd0M1BCaWRjYk1IeHZWMXJk?=
 =?utf-8?B?YnpsQnl1eC9VVCtYaVg1TzBxT1BtbXdGcWp1Q2VFOTlVUFgxSTR0MmxrM3h4?=
 =?utf-8?B?WkgzN3R0azlTaWc2TW5idTlLM2Ryam90QkdXRUFSKzFCekRnUCtKSW9mREhr?=
 =?utf-8?B?TzFWdzZYMG9rZnZ5Z2trOTFCSExOdDVsQjBmbmFTZ3BDV1N3bzgxQWkvMk41?=
 =?utf-8?B?d2VmdFNpZTRZejkvc2Q4L2Y4UjdnbHBPeFo5bzZEUjVpR21RNUV3V3hZZTg2?=
 =?utf-8?B?b0FEQU5HMVdxYzlBU2luN3pxV2ZrOWF5TWQxT0MrMXdoRlo5ZExwQmZEdERY?=
 =?utf-8?B?WVF5REZkYzZOa2RYUDdqWGQ5N3JkN3NJU1d1T0FvaU5pbzJKSno2K0t4bk5T?=
 =?utf-8?B?cUp3dlFyRHplS1NqQWYra3ZlTjZTZHVmQ0JFbHZDaUlVR2hjandZSXdadzFk?=
 =?utf-8?B?RFJJWU82dFlib1FvQ2xHUDNUNlBhNkduMG1zMExIR0lzcG5aV0dSbzVWNStW?=
 =?utf-8?B?OStqQWNBRE1Ic1ltWEhMMmRUa1VpNnBOZHlmcWJOb1BLcmNsSitUemY2RzVs?=
 =?utf-8?B?V0VOOGRDQW9ENzJ0eVZZMUtBNVRtMm5EN1VkMkozSEd2NWF2YlBFVHdUaENX?=
 =?utf-8?B?eGxMNFdnVjkwVWhzdUdoMXFRRDk5MUx2OXZCWlVjcGRmb09jYTJXY1FtZGFy?=
 =?utf-8?B?UWVMRTczRWd0bDByczJtenFxYWR3elJ5M3VtK3oycWlEcDZEVnh6aHRlUHM5?=
 =?utf-8?B?K0VubDZJU0MxSWg3ajlSSTRIb0VDU093eHJ3dC9FSithcHM5d2dUQUhGZ0o2?=
 =?utf-8?B?Z1NwQiswVUVmSExVRTFhQ0FvYkQ4U1R5SUlDT1RrUUM4NEJvSEhPaUhJSldz?=
 =?utf-8?B?djhibDFFL3Q2b2I3c3dUVGlhUmN4VGdVTE9FRXdmUzBtQjl1WWIzekx6YmFZ?=
 =?utf-8?B?STY1blFEYnpLdm9RMXgxRlpqNElTVnZzclI2elJmbVYxUU9ZVUdUVFdVNy9w?=
 =?utf-8?B?cmJ4N01YWHA0dUkzMDcySDQ4ZzN5Y2wyNldCVHo3VWR0eENOM2c4SXZqRFBF?=
 =?utf-8?B?a0pEN25MQVFrdDhmaG9lUWtDOG5FbEpmTkRQbUdxYzBxT3Q3WkpTUnNBOE9m?=
 =?utf-8?B?YVd6cDhlcU5VWXcrbUZSUTd0dERJT3NJTDZjbkVsRUhHQU8zbncvTkJNQVN3?=
 =?utf-8?B?TStUak5MZjBzN0RnMGZHN3NHM3VmT1JSY01GMWt2SXk5dnJ4djFJYnhtUFBj?=
 =?utf-8?B?TS9nQzlUYnpNWGgrRU5OajRaVXZKWEZMTURadWptd2VBbytLMkdEcnp6MEp0?=
 =?utf-8?B?NXEvRCtqeDQra1Flb3B5Q0JleUU1Y2pFODN2LzNVV2lYTitMblR4ZzduTFpj?=
 =?utf-8?B?T3kxMmdjMjZRTnpOckZFZDVIdUN5d0ZZZHJxVitkQUNUZEFkVnJvMlp0YW1I?=
 =?utf-8?B?ZkJuSURvVGtNOVdPN0RMMzhxdVlOZmV2aW1OQ1dMTVRQRzZRV0lXTkgrT3dH?=
 =?utf-8?B?dVVsV3RrVDFoUklnVFZxMW15TTJoSmppSklBaUh1OHBLZU5vSmd6dTM1Q09D?=
 =?utf-8?B?dVl2ZWkyOXNFekQva2pjODNFYkFWcmVEalltak5TZ1NwUUFoUG44UmxvS2VV?=
 =?utf-8?B?YW5Rdi9PVStlSisycFlSRy8vRkVXV0VKVm4yQTM0eUZzd05hMXlJMnRmaXR1?=
 =?utf-8?B?aXhKMlZvaCs2N1hJbklDM3pzRUxNWEp0Z2FjSy95N2FKQWRoYWc5WThuK3Mr?=
 =?utf-8?B?QTRLZmJtQUVjTVdBZW9iYkNySVZFVWFKQlVyOTl4aWYreDRIaFVCelU5Z1Vq?=
 =?utf-8?B?VEdsei9DQkRlOEJtZ0hWOGhENnhIME5ySFlVSW1aWUpEZXFTSktGOW1RcStm?=
 =?utf-8?B?dHVrUmdnUHc2TWh4S3BldGZNa3NpaFBGdWJwQ0JDbFJ1OC9jKzhBYmN2czcr?=
 =?utf-8?B?T2pTZEFKbUhRVjJjQWEyVUlVN0tZSGtia0o0T20yYlkzeE54bzBLK1Z1b2kv?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <069E41BBA084D74880965F31197E8248@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85503fb0-3698-4632-d359-08da84d6a3b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 07:11:03.0398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PXOfManOqscysOewiQuLl0TTDxLr8OcTzU1AVV1Tukgy7LLRePh4CJkXXmNNDheap+7qbxj6BPjTadFGwOzrb74KHGXQun9/F3YEQJoBVN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3573
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTcuMDguMjAyMiAyMjowMCwgSG9yYXRpdSBWdWx0dXIgd3JvdGU6DQo+IEFkZCBiYXNpYyBz
dXBwb3J0IGZvciBwY2I4MjkwLiBJdCBoYXMgOCBsYW44ODE0IFBIWVMgb24gdGhlIGV4dGVybmFs
DQo+IE1ESU8gYnVzIGFuZCBubyBTRlAgcG9ydHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIb3Jh
dGl1IFZ1bHR1ciA8aG9yYXRpdS52dWx0dXJAbWljcm9jaGlwLmNvbT4NCj4gLS0tDQo+ICBhcmNo
L2FybS9ib290L2R0cy9NYWtlZmlsZSAgICAgICAgICAgIHwgICAxICsNCj4gIGFyY2gvYXJtL2Jv
b3QvZHRzL2xhbjk2NngtcGNiODI5MC5kdHMgfCAxNjkgKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTcwIGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBhcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LXBjYjgyOTAuZHRzDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUgYi9hcmNoL2FybS9ib290L2R0cy9N
YWtlZmlsZQ0KPiBpbmRleCAwNWQ4YWVmNmU1ZDIuLjU5NWU4NzA3NTBjZCAxMDA2NDQNCj4gLS0t
IGEvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMv
TWFrZWZpbGUNCj4gQEAgLTc4OCw2ICs3ODgsNyBAQCBkdGItJChDT05GSUdfU09DX0lNWFJUKSAr
PSBcDQo+ICBkdGItJChDT05GSUdfU09DX0xBTjk2NikgKz0gXA0KPiAgCWxhbjk2Nngta29udHJv
bi1rc3dpdGNoLWQxMC1tbXQtNmctMmdzLmR0YiBcDQo+ICAJbGFuOTY2eC1rb250cm9uLWtzd2l0
Y2gtZDEwLW1tdC04Zy5kdGIgXA0KPiArCWxhbjk2NngtcGNiODI5MC5kdGIgXA0KPiAgCWxhbjk2
NngtcGNiODI5MS5kdGIgXA0KPiAgCWxhbjk2NngtcGNiODMwOS5kdGINCj4gIGR0Yi0kKENPTkZJ
R19TT0NfTFMxMDIxQSkgKz0gXA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvbGFu
OTY2eC1wY2I4MjkwLmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NngtcGNiODI5MC5kdHMN
Cj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi5lYTUyNjdhY2E2
YjQNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LXBj
YjgyOTAuZHRzDQo+IEBAIC0wLDAgKzEsMTY5IEBADQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogKEdQTC0yLjArIE9SIE1JVCkNCj4gKy8qDQo+ICsgKiBsYW45NjZ4X3BjYjgyOTAuZHRz
IC0gRGV2aWNlIFRyZWUgZmlsZSBmb3IgUENCODI5MA0KPiArICovDQo+ICsvZHRzLXYxLzsNCj4g
KyNpbmNsdWRlICJsYW45NjZ4LmR0c2kiDQo+ICsjaW5jbHVkZSAiZHQtYmluZGluZ3MvcGh5L3Bo
eS1sYW45NjZ4LXNlcmRlcy5oIg0KPiArDQo+ICsvIHsNCj4gKwltb2RlbCA9ICJNaWNyb2NoaXAg
RVZCIExBTjk2NjgiOw0KPiArCWNvbXBhdGlibGUgPSAibWljcm9jaGlwLGxhbjk2NjgtcGNiODI5
MCIsICJtaWNyb2NoaXAsbGFuOTY2OCIsICJtaWNyb2NoaXAsbGFuOTY2IjsNCj4gKw0KPiArCWdw
aW8tcmVzdGFydCB7DQo+ICsJCWNvbXBhdGlibGUgPSAiZ3Bpby1yZXN0YXJ0IjsNCj4gKwkJZ3Bp
b3MgPSA8JmdwaW8gNTYgR1BJT19BQ1RJVkVfTE9XPjsNCj4gKwkJcHJpb3JpdHkgPSA8MjAwPjsN
Cj4gKwl9Ow0KPiArfTsNCj4gKw0KPiArJmdwaW8gew0KPiArCW1paW1fYV9waW5zOiBtZGlvLXBp
bnMgew0KPiArCQkvKiBNREMsIE1ESU8gKi8NCj4gKwkJcGlucyA9ICAiR1BJT18yOCIsICJHUElP
XzI5IjsNCj4gKwkJZnVuY3Rpb24gPSAibWlpbV9hIjsNCj4gKwl9Ow0KPiArDQo+ICsJcHBzX291
dF9waW5zOiBwcHMtb3V0LXBpbnMgew0KDQpDYW4geW91IGFsc28gZG9jdW1lbnQgdGhpcyBvbmUg
YXMgd2VsbD8gSSBjYW4gZG8gaXQgd2hpbGUgYXBwbHlpbmcgaWYgeW91DQpwcm92aWRlIHRoZSBz
dHJpbmdzLg0KDQo+ICsJCXBpbnMgPSAiR1BJT18zOCI7DQo+ICsJCWZ1bmN0aW9uID0gInB0cHN5
bmNfMyI7DQo+ICsJfTsNCj4gKw0KPiArCXB0cF9leHRfcGluczogcHRwLWV4dC1waW5zIHsNCg0K
RGl0dG8NCg0KVGhhbmsgeW91LA0KQ2xhdWRpdSBCZXpuZWENCg0KPiArCQlwaW5zID0gIkdQSU9f
MzUiOw0KPiArCQlmdW5jdGlvbiA9ICJwdHBzeW5jXzAiOw0KPiArCX07DQo+ICsNCj4gKwl1ZGNf
cGluczogdWNkLXBpbnMgew0KPiArCQkvKiBWQlVTX0RFVCBCICovDQo+ICsJCXBpbnMgPSAiR1BJ
T184IjsNCj4gKwkJZnVuY3Rpb24gPSAidXNiX3NsYXZlX2IiOw0KPiArCX07DQo+ICt9Ow0KPiAr
DQo+ICsmbWRpbzAgew0KPiArCXBpbmN0cmwtMCA9IDwmbWlpbV9hX3BpbnM+Ow0KPiArCXBpbmN0
cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ICsJc3RhdHVzID0gIm9rYXkiOw0KPiArDQo+ICsJZXh0
X3BoeTA6IGV0aGVybmV0LXBoeUA3IHsNCj4gKwkJcmVnID0gPDc+Ow0KPiArCQljb21hLW1vZGUt
Z3Bpb3MgPSA8JmdwaW8gNjAgR1BJT19BQ1RJVkVfSElHSD47DQo+ICsJfTsNCj4gKw0KPiArCWV4
dF9waHkxOiBldGhlcm5ldC1waHlAOCB7DQo+ICsJCXJlZyA9IDw4PjsNCj4gKwkJY29tYS1tb2Rl
LWdwaW9zID0gPCZncGlvIDYwIEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiArCX07DQo+ICsNCj4gKwll
eHRfcGh5MjogZXRoZXJuZXQtcGh5QDkgew0KPiArCQlyZWcgPSA8OT47DQo+ICsJCWNvbWEtbW9k
ZS1ncGlvcyA9IDwmZ3BpbyA2MCBHUElPX0FDVElWRV9ISUdIPjsNCj4gKwl9Ow0KPiArDQo+ICsJ
ZXh0X3BoeTM6IGV0aGVybmV0LXBoeUAxMCB7DQo+ICsJCXJlZyA9IDwxMD47DQo+ICsJCWNvbWEt
bW9kZS1ncGlvcyA9IDwmZ3BpbyA2MCBHUElPX0FDVElWRV9ISUdIPjsNCj4gKwl9Ow0KPiArDQo+
ICsJZXh0X3BoeTQ6IGV0aGVybmV0LXBoeUAxNSB7DQo+ICsJCXJlZyA9IDwxNT47DQo+ICsJCWNv
bWEtbW9kZS1ncGlvcyA9IDwmZ3BpbyA2MCBHUElPX0FDVElWRV9ISUdIPjsNCj4gKwl9Ow0KPiAr
DQo+ICsJZXh0X3BoeTU6IGV0aGVybmV0LXBoeUAxNiB7DQo+ICsJCXJlZyA9IDwxNj47DQo+ICsJ
CWNvbWEtbW9kZS1ncGlvcyA9IDwmZ3BpbyA2MCBHUElPX0FDVElWRV9ISUdIPjsNCj4gKwl9Ow0K
PiArDQo+ICsJZXh0X3BoeTY6IGV0aGVybmV0LXBoeUAxNyB7DQo+ICsJCXJlZyA9IDwxNz47DQo+
ICsJCWNvbWEtbW9kZS1ncGlvcyA9IDwmZ3BpbyA2MCBHUElPX0FDVElWRV9ISUdIPjsNCj4gKwl9
Ow0KPiArDQo+ICsJZXh0X3BoeTc6IGV0aGVybmV0LXBoeUAxOCB7DQo+ICsJCXJlZyA9IDwxOD47
DQo+ICsJCWNvbWEtbW9kZS1ncGlvcyA9IDwmZ3BpbyA2MCBHUElPX0FDVElWRV9ISUdIPjsNCj4g
Kwl9Ow0KPiArfTsNCj4gKw0KPiArJnBvcnQwIHsNCj4gKwlyZWcgPSA8Mj47DQo+ICsJcGh5LWhh
bmRsZSA9IDwmZXh0X3BoeTI+Ow0KPiArCXBoeS1tb2RlID0gInFzZ21paSI7DQo+ICsJcGh5cyA9
IDwmc2VyZGVzIDAgU0VSREVTNkcoMSk+Ow0KPiArCXN0YXR1cyA9ICJva2F5IjsNCj4gK307DQo+
ICsNCj4gKyZwb3J0MSB7DQo+ICsJcmVnID0gPDM+Ow0KPiArCXBoeS1oYW5kbGUgPSA8JmV4dF9w
aHkzPjsNCj4gKwlwaHktbW9kZSA9ICJxc2dtaWkiOw0KPiArCXBoeXMgPSA8JnNlcmRlcyAxIFNF
UkRFUzZHKDEpPjsNCj4gKwlzdGF0dXMgPSAib2theSI7DQo+ICt9Ow0KPiArDQo+ICsmcG9ydDIg
ew0KPiArCXJlZyA9IDwwPjsNCj4gKwlwaHktaGFuZGxlID0gPCZleHRfcGh5MD47DQo+ICsJcGh5
LW1vZGUgPSAicXNnbWlpIjsNCj4gKwlwaHlzID0gPCZzZXJkZXMgMiBTRVJERVM2RygxKT47DQo+
ICsJc3RhdHVzID0gIm9rYXkiOw0KPiArfTsNCj4gKw0KPiArJnBvcnQzIHsNCj4gKwlyZWcgPSA8
MT47DQo+ICsJcGh5LWhhbmRsZSA9IDwmZXh0X3BoeTE+Ow0KPiArCXBoeS1tb2RlID0gInFzZ21p
aSI7DQo+ICsJcGh5cyA9IDwmc2VyZGVzIDMgU0VSREVTNkcoMSk+Ow0KPiArCXN0YXR1cyA9ICJv
a2F5IjsNCj4gK307DQo+ICsNCj4gKyZwb3J0NCB7DQo+ICsJcmVnID0gPDY+Ow0KPiArCXBoeS1o
YW5kbGUgPSA8JmV4dF9waHk2PjsNCj4gKwlwaHktbW9kZSA9ICJxc2dtaWkiOw0KPiArCXBoeXMg
PSA8JnNlcmRlcyA0IFNFUkRFUzZHKDIpPjsNCj4gKwlzdGF0dXMgPSAib2theSI7DQo+ICt9Ow0K
PiArDQo+ICsmcG9ydDUgew0KPiArCXJlZyA9IDw3PjsNCj4gKwlwaHktaGFuZGxlID0gPCZleHRf
cGh5Nz47DQo+ICsJcGh5LW1vZGUgPSAicXNnbWlpIjsNCj4gKwlwaHlzID0gPCZzZXJkZXMgNSBT
RVJERVM2RygyKT47DQo+ICsJc3RhdHVzID0gIm9rYXkiOw0KPiArfTsNCj4gKw0KPiArJnBvcnQ2
IHsNCj4gKwlyZWcgPSA8ND47DQo+ICsJcGh5LWhhbmRsZSA9IDwmZXh0X3BoeTQ+Ow0KPiArCXBo
eS1tb2RlID0gInFzZ21paSI7DQo+ICsJcGh5cyA9IDwmc2VyZGVzIDYgU0VSREVTNkcoMik+Ow0K
PiArCXN0YXR1cyA9ICJva2F5IjsNCj4gK307DQo+ICsNCj4gKyZwb3J0NyB7DQo+ICsJcmVnID0g
PDU+Ow0KPiArCXBoeS1oYW5kbGUgPSA8JmV4dF9waHk1PjsNCj4gKwlwaHktbW9kZSA9ICJxc2dt
aWkiOw0KPiArCXBoeXMgPSA8JnNlcmRlcyA3IFNFUkRFUzZHKDIpPjsNCj4gKwlzdGF0dXMgPSAi
b2theSI7DQo+ICt9Ow0KPiArDQo+ICsmc2VyZGVzIHsNCj4gKwlzdGF0dXMgPSAib2theSI7DQo+
ICt9Ow0KPiArDQo+ICsmc3dpdGNoIHsNCj4gKwlwaW5jdHJsLTAgPSA8JnBwc19vdXRfcGlucz4s
IDwmcHRwX2V4dF9waW5zPjsNCj4gKwlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiArCXN0
YXR1cyA9ICJva2F5IjsNCj4gK307DQo+ICsNCj4gKyZ1ZGMgew0KPiArCXBpbmN0cmwtMCA9IDwm
dWRjX3BpbnM+Ow0KPiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ICsJYXRtZWwsdmJ1
cy1ncGlvID0gPCZncGlvIDggR1BJT19BQ1RJVkVfSElHSD47DQo+ICsJc3RhdHVzID0gIm9rYXki
Ow0KPiArfTsNCg0K
