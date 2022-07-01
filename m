Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE24562E4E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbiGAIcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbiGAIcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:32:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D504D1C926;
        Fri,  1 Jul 2022 01:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656664361; x=1688200361;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uJ2x8pJ8S/tjT6kCtMKTEL/Mj25x2MarOzmUxKl79M8=;
  b=gZZuZsdLEYonskDFa8jO5beI7NCNO7Shh/g67n68No7Fbtx2A/LEjwL8
   BC+38IwvzOKv5mnTCwCfFsc4pVTWadLpUlUJ3aAjicFcQMkY/+JjrfS9B
   YcsaDdxJo3cWn5F9TUKulMAbQskoNC0Dx0OJW8mJlHUdtEJ6zFmDryslM
   t2ZdmPubnkyvznJw2HBJTlQk1iw7Pkdi6wsYdBcDdbc1lxibW+PE1jcIv
   5vvChBw1e+Zrz/qaOASioacHrD17g8OJ9/8ZitPnM3PvvyrvTRreZRSjF
   XAfSXLM5W24xF/oHaLY/BlA2FdWf4G4G5iGRHgjHh3uLU5e1qyNvugtGy
   w==;
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="162903748"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Jul 2022 01:32:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 1 Jul 2022 01:32:38 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 1 Jul 2022 01:32:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gq4miL/VUQ+B4r7q/xTZlBPncYso9bsyVcQlDypvwuO9Aj0imOTKwbZiBxopRaZacVY30XV8+hlQGVO9om+ep+AM4hfhL0dXwhtBgiFEgnrsnMbx9+qscz8QhZm2SYGLgRN4KMcG6vl/50YLFSEgcjn70D2t6zSRtZAx3/7LP8FxfdbvJv+UWFHbZ9q2AzS7FNfQi/rWm0JPCXCJNkUaGETPD+3yhtBVzwSWxo5Fj+YW+9jCdeIYfSpAOdHuZaA+pyHAoNUMuS5LJShLuBeuUDFnrDPItSuyFwC7ZTE5lRU+8pOLmsuNgCynUBauvMjxWC3ld/nW5P86TkE0FHgDUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJ2x8pJ8S/tjT6kCtMKTEL/Mj25x2MarOzmUxKl79M8=;
 b=Ts7DOIosShI4CECGg1q/+BOkKYxbBZxlVWQhw7h2TtIvT3/dN+iZf3QTL2Ciiw1KWErSYjJIZZ3IZulcl6ho/DFjrn1OpKc1tg2/rPG0DwnQKb8hQ/fD01Qb5789Zl/Zpm6rTH9uuscldLpkjUvFjs58qcfOuJrcDF04P8B7dJN5j2iJQBfVIO4C7a5KzL+RBre0jpsCrIaLhE4DGRI/AfxaVVtbxn4Z5iHTiZq+9WRqLJJ3fc6pTIOUV/GqtBLixZ4bdF00tHR1esv2zjZR/uADlCgoe2jey84MjPTDMSGc8BgHqn4VkRML/4946+N/rl6u/y4NIyYalEGdG4zPEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJ2x8pJ8S/tjT6kCtMKTEL/Mj25x2MarOzmUxKl79M8=;
 b=T1wvVErBjtpIL1kUkcwA6bD4CRGGgs+H5bP0dLgS2sP441f5m4poUYvSDnlIx+E71eIXrZGN3ZpuIFlbT9h/uCCHC9DWU1DRRkM4tQP1UUiUMUknHhRCiVNH+N8tCrn5AOMjxSVRmP4zB7pDnKvLdDzxCkCJ1bVrqzoDbL9RejI=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by CH2PR11MB4405.namprd11.prod.outlook.com (2603:10b6:610:49::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 1 Jul
 2022 08:32:37 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 08:32:36 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Kavyasree.Kotagiri@microchip.com>, <arnd@arndb.de>,
        <alexandre.belloni@bootlin.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <soc@kernel.org>,
        <robh+dt@kernel.org>, <Nicolas.Ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH] ARM: dts: lan966x: Cleanup flexcom3 usart pinctrl
 settings.
Thread-Topic: [PATCH] ARM: dts: lan966x: Cleanup flexcom3 usart pinctrl
 settings.
Thread-Index: AQHYjSUezYlt/YDWP0CZa+imvdgWlw==
Date:   Fri, 1 Jul 2022 08:32:36 +0000
Message-ID: <3ef4a858-9534-0b4f-744b-b254bb7555f2@microchip.com>
References: <20220627091217.21701-1-kavyasree.kotagiri@microchip.com>
In-Reply-To: <20220627091217.21701-1-kavyasree.kotagiri@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 886d32a1-5ac5-4c24-97be-08da5b3c40bd
x-ms-traffictypediagnostic: CH2PR11MB4405:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1J4tugpOmnXK1GDtBA6r1w8myzgdSGKjUc2CAOT1G/1IKzHkWI2m4rOVAaBCC+Y4QA4DhgllFXqYcuCYSyUyKjlv/q4ayaaVlohRTwWRJ0mbyRrNrmp8amVZnPwc//CY9jUJAFDIRTg5WgN/vxl13dMjZHnDT3qk6Gb8DiZUoBTh0gSN/ultrQCZ6RY82CsLdqQXd7lpd2PZ3TnQHRFxtf+kQEIXzP9G8ExpaXdOCl2TpvQVMIC5DZZlrijfjy6JgSvPTKRd7inGGGIQpUXzV0zr1Kw1Dv4S/gNNtymBEg0HKtnO/HqGsbdC4nX6bRoqGo+rRiqPK9dSM0tXMVaFj5kFXBgJ0BY1ZH7/GTk9sjay17HUJ9kWFVQf61S6LewuOPSOERPs7tSByQ05JOO4WptgtUP6qONNgzliI+ajxlsUhX5bODsI7Z9X9xKisLXnjYpqcww4/822V+iHMTh5MgnF5gHZG3NO1/S5TcXvskyofyHSFwfhX1W6yCs6oM19BHu+0d7SDGpoOplkeljCCtqj5HlMuKL9jvjdbk9lBe/KHMsPfxHkLFDTVGfdYbBf0OzzKgzgm0vnGaNvnAakg8vrkGIoXxAfW2nrqW1KxeGTdY6UmC+uS44ANHU9sIrZbNd5hdCWls0wabLIHfhFM8wPQ8m44v3D7nHONVLgYa8ibjK7BpQ9FTrdJWsBxjsNC/bZxIuGol8YdgcmZ7yCkFjTnzYhasFLZXKVMKC6dABwj/cU7qZHrS+QkxN00fGfFCJOjWYAGLfyemyTRhiQoqLC8Hji9B8b8lbNP9ldbsQwCzV7uPlp3A1HY3oZemq5Ug4NIsKnFBqZqYr7rpl66ulDppEhN6vtOmfGqx4Ob9QilrHMk6CH26XibNlnSamTmWIg80MLjpcdA/j/RpNXmdEDLJ6rUKzh89gqXpEwMy8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(39860400002)(346002)(366004)(396003)(83380400001)(107886003)(76116006)(41300700001)(66946007)(122000001)(31696002)(36756003)(478600001)(38100700002)(6486002)(2616005)(66446008)(38070700005)(71200400001)(6506007)(26005)(6512007)(54906003)(53546011)(186003)(5660300002)(66556008)(86362001)(8936002)(6636002)(2906002)(316002)(91956017)(4326008)(110136005)(64756008)(966005)(8676002)(31686004)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWNTRzQzb0xlWEhmcldzY2N0RkJIcnVsL0ZZVElsekFEMVBRS3B5VXdBSmQw?=
 =?utf-8?B?L1U4OU41K09pWnNIcHc1UmF0ajNpMThONzY2TzJITXB0OTM4M2UyZThBaVk4?=
 =?utf-8?B?blJxdmNTZGVzRFRIWkh0VlNDS0NrWFFQbGIxK1Z6NXhLN1BxdmFCeGVTTlRs?=
 =?utf-8?B?bkFTVzcxamFVakhNZTUwYUp3OE9zUzdYS29INVpvMU0xaTN4WEZlR3Y2cEk0?=
 =?utf-8?B?T3hPRlJESVlYMnZoVi95WkZuVFFTZmVzNmV3d2JFcUtlMFA1b3lhUU5rL2Fy?=
 =?utf-8?B?WnhPelpoV0JWRjZXa1J6R2N5VStPVnBUb2ZueU5rMnpzanBhQkdIMUxJTktR?=
 =?utf-8?B?SHBWTXEweFJUY0pnWU04aWY5eXhNODVmSlJsaStzbGlmY2ZVeXdqRWpML0Na?=
 =?utf-8?B?Q1FQc0RibXFCL3NrSzROTUo5alpOc3NaTkZvSEJyNVRsaVRTb1JiWFZpMlVh?=
 =?utf-8?B?ZkZDNkI3WU1BTUVuL1JoelM4eWVTZFRlRkxoNHJWUVAvbzlRTjBOcmpsU2w5?=
 =?utf-8?B?ckViZXliRWNWNE1hMGtTRmJTSmRIRVRIUk1RejV5dUVuWEM5ODd1bG9GQmVM?=
 =?utf-8?B?L0xJWVN0T055amRDdFhvbXNndms1OW5NK0k0WXVHOXVuSURnbkxoTDNSRnlE?=
 =?utf-8?B?cTZwaUhtaXlOdyt0bktlVHlNT09lQ0Z0OFBpRGhOc2ZrM0srSktsa3dyUHpH?=
 =?utf-8?B?aTk5TVUrUXd4czVMWThQVmpZc3dYK0pJV3lhbVNmTERPbG9NOHBrYXpkNTRR?=
 =?utf-8?B?eW5MYmU2ZDZIQ2pja2ZCcGtGQ2lkM3I5V29IdG9BN1RvSVNmbGVza1RpU0pR?=
 =?utf-8?B?VDBNT2YrcWVGUEk0R2p5eXhJdG42L2k3TVRBMDE4SHlYbmtFM2hpdnpTWXYy?=
 =?utf-8?B?OElCVFI1NmxHVTg2bWI4UjcrWjAydUZuYXhUN3lRQ3hUYU1Ta0dic0VxWnhw?=
 =?utf-8?B?VHN1SlVFL0Exa3NXNGM5SnQ0OFpPY3dKOE1nblpHVUJXNE5BdHNhcHR6K2Zl?=
 =?utf-8?B?UWM3aGJtS0JBZ2RZRUw5TUprS1pId2pRTS9CS1VNM09jZisvTWpBSXg4VWdn?=
 =?utf-8?B?WCsyOVFoQ0ROR0ZXUWgxd1d3T091MUVna3BoM21pK3lsTkJrNElYTk9oeVVS?=
 =?utf-8?B?dysvbWZudm5zMWlhc0tibWxoY2trT05wbEloTTc0RTdqUkZaVk5TMzFybnJJ?=
 =?utf-8?B?UTFiYTJhcFFNakUvcVg5UW5oaG40R1lLS2F0WlJ0Z2l3ZnVSaytZM3QxSXYz?=
 =?utf-8?B?TDBqTS9EWHFBaFA1U3N5SGpQSDljRUp0WXFzYzBnU3ZBR2ZEZEt4dlgvWndL?=
 =?utf-8?B?WjdUUHR2a0RoV1lSbHh0eUtFN2EvTDhzWTl6THh0T20wbHIxVmwvbng1blpM?=
 =?utf-8?B?WjJod3k3bWhldzVjVTh3UlU3dHF5OGNDZGxVTVBDN2I4WlF6VEFtSVovb3Jz?=
 =?utf-8?B?MzJlOWpJajNjZU9XR1NlL0dXelEwbTRJUE5zQ0pzSzg4UmMyMXlyemRvN3ZE?=
 =?utf-8?B?RnhpS2krcGtmOWxGTk5XajhRWDJ1aFMxbXlHbW50VXpuTDVGV3BIT3FnWWFl?=
 =?utf-8?B?aHUwZllzSG9ZdGNzNGpzQ1NlOW5wTmhOOFVreTQ4WWtSSnB0ekdtd2VuZWpM?=
 =?utf-8?B?TzhSYVgzN3plZHJkRUl6WlUxeWtrUnRUYWo4dTk0Ymg0cWR0Wi9lSWsxZ2g4?=
 =?utf-8?B?a2wvVDF5RmgyOU9qZFZYN2JYVU9ldEJqdVk5UWdMMFpSYWt5MHQyNjlFeHhq?=
 =?utf-8?B?NXM4cFhiV3BucGg2NWhMSTJPVENBOStGb0FpVnU0NURoRWFvanM0R1RTclZP?=
 =?utf-8?B?bjduelBKalhXUVBSRDBDVm5RaEtXY1BjdUcvWU1iNkZML0NBKzVkSEYzQkZK?=
 =?utf-8?B?dHRCNmFpbGxMV2svNzVJS2gxS0dpSE9mbEpWWkNENWpBeDVOc2JjUEMzVU9M?=
 =?utf-8?B?MTRGeVJjOWFHMStGL3NJdExmY1p4MjFPaTBreEZZNWg2UFR4UUc0NStZUnZ2?=
 =?utf-8?B?a0dFeGp4WG5Fb1BTTG5DVStqZm9PL3VpNTQwSTlIaWNMbkMxOFV6bnVkVU1i?=
 =?utf-8?B?RU9TS2piMlBiaWtxM01kZVhkOVkzYlNOTHA1MnhpNkJydzFMRkpIa05FSW9V?=
 =?utf-8?B?N0lCek9QR3BUeUZqR0dvU1JTek1jZEtaRmRXZCszWUI0WEMvYnhNeWI4eXNZ?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B3781FD59B1B54BB38A2819A920CFA7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 886d32a1-5ac5-4c24-97be-08da5b3c40bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 08:32:36.8522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IvO4fMO0+YEZDidSXz7+/jp8K43bflE9JMcAfVtdFQoIbofWQADAkanvrf2guIvR/ZQ6Zpi3U55KjjROXHq0jIztwYwnDqsBONTgG/YYlKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4405
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjcuMDYuMjAyMiAxMjoxMiwgS2F2eWFzcmVlIEtvdGFnaXJpIHdyb3RlOg0KPiBFWFRFUk5B
TCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIHBjYjgyOTEsIEZsZXhjb20zIHVz
YXJ0IGhhcyBvbmx5IHR4IGFuZCByeCBwaW5zLg0KPiBDbGVhbmluZ3VwIHVzYXJ0MyBwaW5jdHJs
IHNldHRpbmdzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2F2eWFzcmVlIEtvdGFnaXJpIDxrYXZ5
YXNyZWUua290YWdpcmlAbWljcm9jaGlwLmNvbT4NCj4gLS0tDQo+ICBhcmNoL2FybS9ib290L2R0
cy9sYW45NjZ4LXBjYjgyOTEuZHRzIHwgMTggKysrKysrLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LXBjYjgyOTEuZHRzIGIvYXJjaC9hcm0vYm9v
dC9kdHMvbGFuOTY2eC1wY2I4MjkxLmR0cw0KPiBpbmRleCAzYzdlM2E3ZDZmMTQuLjVkYzhlZDRj
ZWU5YSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC1wY2I4MjkxLmR0
cw0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LXBjYjgyOTEuZHRzDQo+IEBAIC0x
OSwxOSArMTksMTMgQEANCj4gIH07DQo+IA0KPiAgJmdwaW8gew0KPiAtICAgICAgIGZjX3NocmQ3
X3BpbnM6IGZjX3NocmQ3LXBpbnMgew0KPiAtICAgICAgICAgICAgICAgcGlucyA9ICJHUElPXzQ5
IjsNCj4gLSAgICAgICAgICAgICAgIGZ1bmN0aW9uID0gImZjX3NocmQ3IjsNCj4gLSAgICAgICB9
Ow0KPiAtDQo+IC0gICAgICAgZmNfc2hyZDhfcGluczogZmNfc2hyZDgtcGlucyB7DQo+IC0gICAg
ICAgICAgICAgICBwaW5zID0gIkdQSU9fNTQiOw0KPiAtICAgICAgICAgICAgICAgZnVuY3Rpb24g
PSAiZmNfc2hyZDgiOw0KPiArICAgICAgIGZjM19iX3J4ZF9waW5zOiBmYzMtYi1yeGQtcGlucyB7
DQo+ICsgICAgICAgICAgICAgICBwaW5zID0gIkdQSU9fNTIiOw0KPiArICAgICAgICAgICAgICAg
ZnVuY3Rpb24gPSAiZmMzX2IiOw0KPiAgICAgICAgIH07DQo+IA0KPiAtICAgICAgIGZjM19iX3Bp
bnM6IGZjYjMtc3BpLXBpbnMgew0KPiAtICAgICAgICAgICAgICAgLyogU0NLLCBSWEQsIFRYRCAq
Lw0KPiAtICAgICAgICAgICAgICAgcGlucyA9ICJHUElPXzUxIiwgIkdQSU9fNTIiLCAiR1BJT181
MyI7DQo+ICsgICAgICAgZmMzX2JfdHhkX3BpbnM6IGZjMy1iLXR4ZC1waW5zIHsNCj4gKyAgICAg
ICAgICAgICAgIHBpbnMgPSAiR1BJT181MyI7DQoNCkNvdWxkIHdlIGtlZXAgYm90aCBwaW5zIHVu
ZGVyIHRoZSBzYW1lIG5vZGU/IEFzIGluIGNhc2Ugb2YgY2FuMF9iX3BpbnMsDQpzb21ldGhpbmcg
bGlrZToNCg0KCWZjM19iX3BpbnM6IGZjMy1iLXBpbnMgew0KCQlwaW5zID0gIkdQSU9fNTIiLCAi
R1BJT181MyI7DQoJCWZ1bmN0aW9uID0gImZjM19iIjsNCgl9Ow0KDQpUaGFuayB5b3UsDQpDbGF1
ZGl1IEJlem5lYQ0KDQo+ICAgICAgICAgICAgICAgICBmdW5jdGlvbiA9ICJmYzNfYiI7DQo+ICAg
ICAgICAgfTsNCj4gDQo+IEBAIC01Myw3ICs0Nyw3IEBADQo+ICAgICAgICAgc3RhdHVzID0gIm9r
YXkiOw0KPiANCj4gICAgICAgICB1c2FydDM6IHNlcmlhbEAyMDAgew0KPiAtICAgICAgICAgICAg
ICAgcGluY3RybC0wID0gPCZmYzNfYl9waW5zPiwgPCZmY19zaHJkN19waW5zPiwgPCZmY19zaHJk
OF9waW5zPjsNCj4gKyAgICAgICAgICAgICAgIHBpbmN0cmwtMCA9IDwmZmMzX2JfcnhkX3BpbnM+
LCA8JmZjM19iX3R4ZF9waW5zPjsNCj4gICAgICAgICAgICAgICAgIHBpbmN0cmwtbmFtZXMgPSAi
ZGVmYXVsdCI7DQo+ICAgICAgICAgICAgICAgICBzdGF0dXMgPSAib2theSI7DQo+ICAgICAgICAg
fTsNCj4gLS0NCj4gMi4xNy4xDQo+IA0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18NCj4gbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QNCj4g
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbA0KDQo=
