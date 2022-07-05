Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17DB566478
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiGEHsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiGEHsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:48:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EA713D4C;
        Tue,  5 Jul 2022 00:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657007287; x=1688543287;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Woijr2vFEpJe6cconnctl0NPWoej9dzayetSvRb3WBA=;
  b=BQAQNbwgh8T6ZbnvxawUyFXe0PGmzvgAVWLcLgFhzkuUHAaqJDqgSMVq
   IgUEgG6HIu3E2UOFr4wwQvVx5NcaUt5KbWZseKn8ibdRXpnk25RYoWlkY
   1jYeCl+vRTfzzl82f/0TeY0+CpKn7sFGC7VB1GI8iDyl9okSwoKTZWNXy
   muoCZm79GLlf5Bnl0KkgQdRElagDSAdzIXWFJIytAE+xeerNMQq3ppcxr
   qn/Z326DdaeRUGHc/nESW6ms+D9pvg/Yf84DRoFn5qCPiqI9De3uHHz96
   j05giD5wg73BYe8UFpUpORFrKngcO41aMuSGftCBC7UjZufMERMHMGKIg
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="166380731"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jul 2022 00:48:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 5 Jul 2022 00:48:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 5 Jul 2022 00:48:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9UB4qAv2YuCly9hT59/Xky8nYBqRhWKkrjvdt2nFC+kgl2oDAipz872pjBVt9qmjRP9GIONZ1HNasknPV8ttVRzxNZ5RFxdktSk1mOSz4EyiPotNGbYtw9AxqurE98MngtPaNED6fDLydedAXorzvGlgLiGmKGtNrdda37y/Dt45sMjyVtmJG68OnCUu7LCGmNijxzlF2Q0g06EQMVuss0Y57em19VWGSXejTXKfIn6CrSwKhsUsXHSjaXvMGi7LnKGftsZQqCAGIPRfsmb2k1IQ3cUuN3yev2LGyOVThAFPmQrAQDMBkz3lu6+qWEhdMS9+TMatW+NxStfyuEMjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Woijr2vFEpJe6cconnctl0NPWoej9dzayetSvRb3WBA=;
 b=AFdZjmVC6OmEQicDP0eDwsAVt/rbU2bEiUzrPoQl/HRkalAq9lnthFTqJrc2xeO7dVk2HiPqoRYkCCqKKKnWNWdpY35htQcVkz7OUsSInAyekdYQNWpao8b9wbnWqqgdgsY9CU5QVv9Ay+EDy8QS7GjOHI5gsiIadcCGYuT31JjAzSu30oRsKajSSm4OWW4t7bMpu6r24jGBeurAAvY3ius5kKM4J6VopcUKILrmDPyfONoEpGcP9ELJli8lVvx3q7Jx5du3Qe3J6FrfMwlAFqgakURuCEwflotHWAYnYNzKF59ZjSeQOP9j9i+eW71ovnoyE2+XIEzq0oSX7kZRjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Woijr2vFEpJe6cconnctl0NPWoej9dzayetSvRb3WBA=;
 b=pvHn0Zf9rMXaQNZ3c6GeC6MhSNK+NLlHoIPh0SMboMCO4wAJkg7Adis50+vKGj8Y5/VI/nxlxBDiC2RI+yXR6oBW5bjEKznI8wJuQ5G+cXkQPcDRqkswty/I4VeKlzyQElEm5nry6PzCrt89gK63vLMhLrYRjdjBF4dZTJU2RwE=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by PH0PR11MB4968.namprd11.prod.outlook.com (2603:10b6:510:39::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Tue, 5 Jul
 2022 07:48:01 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 07:48:01 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <herve.codina@bootlin.com>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Horatiu.Vultur@microchip.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <thomas.petazzoni@bootlin.com>, <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 2/3] dt-bindings: usb: atmel: Add Microchip LAN9662
 compatible string
Thread-Topic: [PATCH v5 2/3] dt-bindings: usb: atmel: Add Microchip LAN9662
 compatible string
Thread-Index: AQHYkEOMPubwlTWz8UW7qmiGo3NFsQ==
Date:   Tue, 5 Jul 2022 07:48:01 +0000
Message-ID: <a4bac810-e714-afec-8bbc-65ee7502c7f8@microchip.com>
References: <20220704102845.168438-1-herve.codina@bootlin.com>
 <20220704102845.168438-3-herve.codina@bootlin.com>
In-Reply-To: <20220704102845.168438-3-herve.codina@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6ca06ce-0417-4ab4-f2fb-08da5e5aaf7e
x-ms-traffictypediagnostic: PH0PR11MB4968:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5x3OY5gPvsqe6Bu7srn/baKCv7g/J0lDikrEzPbGvUNljy6UZGm25eWQKVF0tyz28OMes/DVK8x1FT8qqAAckQB8OJm21ASVB5UvlS1OuDKFU+4GqzdFQiqpgPQbc4NJRmAT4pCUOSGkpmQpLQtmm49IS3i/vo/aywYTh8/ZnGD07u+LYrGjuSElBbgPGIDvLcxLV7Dx08Hl+L5Vvv1w6AQdXkBF68DX73plsjNCCRDpQJBnSb4BQOPJCZEWYfmcegsxuleXyaTwmDKunbfUkv07vjMq54hAO7k/IEeev2YuxyH1urizitZIeOP0X/1OPNjR8jGW/n6KYX3B8M4G4bs+Z6W5cLQBaL/UeWDhVNklxTn/QDgMoL635+JLBd+oqF1W0ZIwt3qzS/P59dD4jYuMjZ4OsB/HosFifVbuccDUL0zd/ezDYdJjN5/OROxPFsjyzzihYGTIPFQey/Yjgh0hXIUvdEoYCUSgXIeQxPN5x2EDBy6onorTtEsDJ51RE+S+jjLr/ONtAbyDWxOXBNhOhlj3CqjsewwfMWwzAqIA5SlmXH0xmh8jOz1+iUHsK9gjWXH+VTnxV/Fb/IUGAjaWTHsdWWyM7ELZHHmmBKCZU/na/E7Ug+vOKnrR8f4kCtlYoOxNEB0so2msh6DGEAH6gQHfjEJoRGWAiryRVOdYLbgigyLfAlGd57DUm/L2ZNgSsxY/IJyNUpphr/k2x0tPdUyMdKan7Uj2vReY4mnLbp33v9kbzCJM6ZeX5M+XApWEwIwTGzUxXaemtBSkZVIx3MqUKFMbEntviwt3kQ0UnDkPY9kGSWsXfTFoOUXNTYzaaDZTWpmoO7RqEBXU0w1fLBYR7Awnp6wTOtVGrnRKSTRbpZR8Ev44ujs+E21/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(136003)(366004)(346002)(376002)(6506007)(41300700001)(31686004)(38070700005)(71200400001)(8936002)(316002)(122000001)(6486002)(478600001)(8676002)(110136005)(54906003)(38100700002)(76116006)(7416002)(186003)(86362001)(2906002)(5660300002)(83380400001)(6636002)(31696002)(2616005)(66946007)(6512007)(26005)(64756008)(66556008)(66476007)(53546011)(66446008)(36756003)(91956017)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzFoRFJodEJtNldBelpvZk13TU82YXYwLzUrcjkxMmFzZTM1SDAvaW5uSGcx?=
 =?utf-8?B?aVpxZHJmaWZpck9QZm9DWGNaZzcweGdlUGNzeGFQckloQWptRWFlYWk4RFFZ?=
 =?utf-8?B?UmlSaktxYjllWGU4TkNQbHlHQlBsRUtDQTlNZmVpcUpSVnN4NEJramYxMk5M?=
 =?utf-8?B?MGJydm9WR2krb2dZWmhWOER1Q3RDMEVVOGJtUW51YksyVHY2NWxwN0liM3Za?=
 =?utf-8?B?M2JuenlsMVFPWFVqVENHNDZjWjFmSUlIL2VkWkpEcTNRV0h4eHlVVTd3Y1d2?=
 =?utf-8?B?NEFHZHRRTHFhTlB4dXlkLzBmNnVuNEhGS0dFeTI2Q0pJc29ENjBWSTJrM2lu?=
 =?utf-8?B?SzJibVVGcjJpWHE1T2FrT3J4WERnVkVKNXhnSkxGMG5FclVNOUI1dS8rc3kr?=
 =?utf-8?B?YW5mWDY0RWFtYmZlY0pnSmJWTDQ3am1SYVc5UVJ2UGZhSVhBVEhpK2szUzVl?=
 =?utf-8?B?alRXT01xaWhhMnU1dDIzN2VnUlFlLytxL0huUVR4MHFsaUltQ3FwZUVXYUts?=
 =?utf-8?B?bWpnUEIwSmQwdnB0SzdaZlAxWlFTeDhRd1NMNGFYZjF5V1h6eGk0Yjhub0RB?=
 =?utf-8?B?dnl3aHUxZVZuQkVLOHkydkJvZ0l1TWpoUHVKVmQzd1JvNVVGNGYraTdubkVi?=
 =?utf-8?B?dzk2eGtvbmFlMHJrR2tGTCtTNTNXTThUS1RITHc3L1l2Zm4wbXhpcHREd3Zo?=
 =?utf-8?B?ckxLN3A3a0pZQ0tsY0VBamx5dXpjbjBrTUFJVGpMaVJ3OWVqLzNKckZ1VmNT?=
 =?utf-8?B?MStNVTQ4dG9raVFNMmlYcVJnSFNsWnhhQVpuaGswQXRqcHhYQWZKK3praGVm?=
 =?utf-8?B?VE4zeWZVWFJ4MkVzUXZTU1ByMzB3SUo4akx0dy8rNXNvR3JMS0pSUTdCOWpD?=
 =?utf-8?B?VXNGUU40MkFJd214MjZFVDJ5cHhmMytGOXVvcDl5V2NrRFRITmxJRGFuZTNN?=
 =?utf-8?B?UTlvbnZkcTZmbDczWVRJSDZVNVUzcUpzNGs1TTBwSVNFQ1ZyU1FEcU5OWHZ5?=
 =?utf-8?B?NDd5R1d1aTRYNE5wQkhRSGNnMlRqeE1LcTNuZVFXRU5xUTcvbldjSFBHQ3gy?=
 =?utf-8?B?VUZGUURRd0Zvb04xSnlRalpodXBINkt6QzY4c0IwYWRocEdJaGRGUU51N2s3?=
 =?utf-8?B?T3R4YlpOVDNvbkNpbCswWHQrTmh0SHFxaHJoK2JHSDZLMmdJcjIwTEJSelZx?=
 =?utf-8?B?T05hQVlHeW4vdmxEakZ1eHd2L0NyOTBOSk9OMFI1SHF1dCt3am9SRVRUVDFT?=
 =?utf-8?B?Ui9SN2tDTEdRQ2tMVHd1azI1d253V2w3ei9oVzM0UEV3aVg5RGdlWEF0YU1K?=
 =?utf-8?B?T3AxdEY3eEVVU1hqTzFSbDFqVHBBV3BqNjZwZTRyT1FuaVdDNzJ4N1dQdWFn?=
 =?utf-8?B?YXRtOUJLK3BmVzJRUFlSNW9BWDRrTzF0dXlxR0dOalZUd0FoNHVtMnNlOG90?=
 =?utf-8?B?UTBPWFpwN1h4SDc5VEhhMmt5MHlsbmN2aWMxZTNFaU10S1hPbnFUQ3J0TGdl?=
 =?utf-8?B?dEpkYlgvWXlqTUZNUkdNamtoSkhEbEdkUCtieUNydzVJYUtXWm95WGpHRlVo?=
 =?utf-8?B?N0wxWllVRm5HMVRKeXV0eFBKU1diR3I3bHQ5aWdJR1RjVmFZWGFPNkhSa1lL?=
 =?utf-8?B?TXhONFRDdEhkcjVNdjVqUE0xT01MWmQ3cjdrai9ieWwyejltTWFOZlA2RmZZ?=
 =?utf-8?B?OVI2dUdvSm1Fb1lrTU1HWlgwUW5mcjVha1MvOVkvZmp1QzlMQWpDN2lUZW9R?=
 =?utf-8?B?NG5ha01vSEJhNC91Smp2a0F5VWJ1Y2Q0TkFyWWIrUHk4RHpBVFlOcFdNZ1hr?=
 =?utf-8?B?SGVuaUt1WktjUEwxcXk3anZCT1VabTg0ZUdEN1c2SGFXYXRNTkxEWXVLWm1F?=
 =?utf-8?B?eXJROGE4THhmRFlQZUg1NStkQVh1ZFpRdDRUNzJ5NkdKVVNENEJMUk9venJr?=
 =?utf-8?B?RXJRMTNTY0ZrQnMzU3pHZ09acWRSZXhTQ3dsc0E0cXdXd2MrRWlKQ0VoeGQ3?=
 =?utf-8?B?amJRQ01BbXNlSHR3RDJ2UVZzUTBNYW9LNTU1K1FOYUF0TjBpSHVCTUdJNzYr?=
 =?utf-8?B?ZWdlTnlLYnVBN3I5R0g3Uk9tclVxUk5BcmpJYXJZVHdGbXQwbXZLNlpHTTlI?=
 =?utf-8?B?eHZDeitESHdsNGlyUVZsQ1M1VlhMSXVjOWpXdFZIcmg0Q3BvQ0JYRWduNmFR?=
 =?utf-8?B?blE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11524980805F584AA033B7F7B3FE2740@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ca06ce-0417-4ab4-f2fb-08da5e5aaf7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 07:48:01.0590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hhRRYamJfv9kSD2ZYhlgb790QOwql8WX2L/Q/P0OJ69HMgZQ75e147kRyQzFR+LFoUYj2dxoMRjSMTyzrH7bSfhh8Bu7ATNbT29bDFl9jDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4968
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQuMDcuMjAyMiAxMzoyOCwgSGVydmUgQ29kaW5hIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFRoZSBVU0IgZGV2aWNlIGNvbnRyb2xsZXIgYXZh
aWxhYmxlIGluIHRoZSBNaWNyb2NoaXAgTEFOOTY2MiBTT0MNCj4gaXMgdGhlIHNhbWUgSVAgYXMg
dGhlIG9uZSBwcmVzZW50IGluIHRoZSBTQU1BNUQzIFNPQy4NCj4gDQo+IEFkZCB0aGUgTEFOOTY2
MiBjb21wYXRpYmxlIHN0cmluZyBhbmQgc2V0IHRoZSBTQU1BNUQzIGNvbXBhdGlibGUNCj4gc3Ry
aW5nIGFzIGEgZmFsbGJhY2sgZm9yIHRoZSBMQU45NjYyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
SGVydmUgQ29kaW5hIDxoZXJ2ZS5jb2RpbmFAYm9vdGxpbi5jb20+DQo+IEFja2VkLWJ5OiBLcnp5
c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQoNCkFwcGxp
ZWQgdG8gYXQ5MS1kdCwgdGhhbmtzIQ0KDQo+IC0tLQ0KPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3VzYi9hdG1lbC11c2IudHh0IHwgMyArKysNCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvdXNiL2F0bWVsLXVzYi50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvdXNiL2F0bWVsLXVzYi50eHQNCj4gaW5kZXggZjUxMmYwMjkwNzI4Li4xMjE4
M2VmNDdlZTQgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy91c2IvYXRtZWwtdXNiLnR4dA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvdXNiL2F0bWVsLXVzYi50eHQNCj4gQEAgLTg3LDYgKzg3LDkgQEAgUmVxdWlyZWQgcHJv
cGVydGllczoNCj4gICAgICAgICAgICAgICAgImF0bWVsLGF0OTFzYW05ZzQ1LXVkYyINCj4gICAg
ICAgICAgICAgICAgImF0bWVsLHNhbWE1ZDMtdWRjIg0KPiAgICAgICAgICAgICAgICAibWljcm9j
aGlwLHNhbTl4NjAtdWRjIg0KPiArICAgICAgICAgICAgICAibWljcm9jaGlwLGxhbjk2NjItdWRj
Ig0KPiArICAgICAgICAgICAgICBGb3IgIm1pY3JvY2hpcCxsYW45NjYyLXVkYyIgdGhlIGZhbGxi
YWNrICJhdG1lbCxzYW1hNWQzLXVkYyINCj4gKyAgICAgICAgICAgICAgaXMgcmVxdWlyZWQuDQo+
ICAgLSByZWc6IEFkZHJlc3MgYW5kIGxlbmd0aCBvZiB0aGUgcmVnaXN0ZXIgc2V0IGZvciB0aGUg
ZGV2aWNlDQo+ICAgLSBpbnRlcnJ1cHRzOiBTaG91bGQgY29udGFpbiB1c2JhIGludGVycnVwdA0K
PiAgIC0gY2xvY2tzOiBTaG91bGQgcmVmZXJlbmNlIHRoZSBwZXJpcGhlcmFsIGFuZCBob3N0IGNs
b2Nrcw0KPiAtLQ0KPiAyLjM1LjMNCj4gDQoNCg==
