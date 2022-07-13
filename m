Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C609573555
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbiGML0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiGML0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:26:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBE91014AC;
        Wed, 13 Jul 2022 04:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657711580; x=1689247580;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Lhyrc6vxI/4YSqfNRKGG8TVpVPVUbOOuIbI/FED7MBg=;
  b=j3Lvpdurc4mDQLmn+4PhdV4ApAbhupm6GHmpid16BvMpKmDZWIw3+6y8
   w+eKzhbaBs/nqP/OKIHCfYLVR3pHNQ8fo+zIZ0euhOp4ok5Vy86XFVOTE
   mKlYD5UyHO9yjYsyRfnxrrr8im0u8X3RmYpWN2SlRrOoq6KHRcr54wKWn
   151OqJazbonchC1pa8JakACPZfvkjDjWXX314qY87rIVQHnXKDuPCRy/K
   XAY6uxlJTd2t9TIyY1Yv1OTrvZgK3T66dPNrJLYXM/fSSwp8hidFcMGdM
   IeqQc4Pi0LsTylRD46/i/Yt4rP6ANg5gss1Rom4ygvsrrnT1U730Ea/CK
   A==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="167624561"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2022 04:26:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Jul 2022 04:26:19 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 13 Jul 2022 04:26:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLITlcVp4e5RPNf//b8K3fCn8yY9FKxnW3ob7t4rnCTcyV4855qYkpa04yDHZlhNwBqJsqwtRNuGDpiLWfMMa6YH0ETeZm4YdQc1AAWg35aG/2ow0CrrvHnftRUDJhYqN6JR77HxM1d06AFizVMsox538ByqrjO8QHIkt1gZnW4eIctF8cFQEYCv70CqiHExpHH+416atDVCzXEpigtRr9/KqubWWvHZV9oS1csVQczOuKPNO3gnYoLlbNlW633PGT9MXXsNFh8FiX29Fs6MHmI1hfu7XSlUjhcPzl3mAd9Ri8+jXliBo71Xe5dr6ihONN5khEpBQPk1Z8HrNP7iDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lhyrc6vxI/4YSqfNRKGG8TVpVPVUbOOuIbI/FED7MBg=;
 b=Rd/EGtwYLXOqv+WrleqB/FOCANL8Cil6BTYoVqebtgpX+3Z8JxRxHgsFX+urFl97cfn1MRP4EfWOT7PJ2rgRD8eTHojnpfYfJFHx4Rds1F51G339k+iybdkTjSr1OXAcO1UKiVmj90cRYJIpRefC5epTBAkXGRXkRgCdzNkQGuBmAGypAnWslgXw/hXWAg2VRYUt+7D5ymHol/9pLJ4UhWaIvfvS4rrTMc+PGyvI0W1BxbGjg4mgUn0YM/UJ9PC43JMCS/98LkAG58+0Ug2nm0zhMGumtDbBoHiv1NEzClgy/ZjGcuYclNvwyH8PpuJdcIwRQLCWFtkynCAn/YBwZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lhyrc6vxI/4YSqfNRKGG8TVpVPVUbOOuIbI/FED7MBg=;
 b=UjJSY71FXlmbE02/a2kco+L/lUVDHr1oclVWhst5BCpbnjkfZm86HnyGjg16cKqt+OfiLYIXhE6sX9/wa4WDP96aF2m/BLyJ/KTF6QBUql1l/QeKenw+yBQVpOUsFERz5hSQmyRkBOx+S88hu00jQuGhCC8+Tiq1UTBIJtR92Es=
Received: from PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8)
 by IA1PR11MB6124.namprd11.prod.outlook.com (2603:10b6:208:3ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 11:26:17 +0000
Received: from PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::6090:db2c:283b:fe69]) by PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::6090:db2c:283b:fe69%8]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 11:26:17 +0000
From:   <Conor.Dooley@microchip.com>
To:     <Lewis.Hanly@microchip.com>, <linux-gpio@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <linux-kernel@vger.kernel.org>,
        <palmer@dabbelt.com>, <maz@kernel.org>
CC:     <Conor.Dooley@microchip.com>, <Daire.McNamara@microchip.com>
Subject: Re: [PATCH v2 1/1] gpio: mpfs: add polarfire soc gpio support
Thread-Topic: [PATCH v2 1/1] gpio: mpfs: add polarfire soc gpio support
Thread-Index: AQHYlqemVrcQOBoUV020qkXDgR8Pgq18KXoA
Date:   Wed, 13 Jul 2022 11:26:17 +0000
Message-ID: <776164f4-21cf-7720-3cf3-3b30b72b8b29@microchip.com>
References: <20220713105910.931983-1-lewis.hanly@microchip.com>
 <20220713105910.931983-2-lewis.hanly@microchip.com>
In-Reply-To: <20220713105910.931983-2-lewis.hanly@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccef86bf-99e5-48b5-d56f-08da64c280e2
x-ms-traffictypediagnostic: IA1PR11MB6124:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DQWiAQ+x9lRk+6gS2DzU65a+BQmN2djxFsW2a+tBQTZxkl2z4Rx/z1X6x5ljp+20qxk5/LUKR2KKETDjxa+enzeMaYKe8WkEZ/bBy3X/R731fBZvsOCsXSolk0TLbGUYNAdKwTaoOvYn3Jj3nJfFszgRWEU9Ti3mHYZDzlR+mR82j+a1JLDS7xPa3MeChw0JaOWNS5sX1yQ4H6HGQMNtMjhPtg4akXu75wvaP0+5LiXOmzBIfWSAA6+Ke0kGj96Sp76S303l/j2XD718PYVF1BfY0sDOM2nn6BikNbrNZ+mthtovoBAooqkd8ERrT8MgJOCC+mjhkXLby25Cyo94CRGKkXyvL291Tk1g0+xCmNLi/33SVDQhVOnRmKkFZd2cp4+ejQEWdnKho4IPF/tT22+2AwX1/hxcyg/DdWSQtd4+dYXRUOpcXrbL8YpqooEbU9MZKs4eY+/Qaqg1mgnqHNxKnm6ovPsKcycMSWY7Yc5fi/eHBdVFYVN7wzONFbkSRc3Mh5E9Okd1pCFTnJd2tIE+LH+6c/kfXyoyxNi03JvMjjJyH0+TyuBCUykeBy6q3oQsCCMt1tzLq+OoScIOX6x+FcslGD9fIu4f48/KHsey2frXfodNEVFq4y9JeYf2xil3Pn/vU545OKIImKAUiD4u0JoQTlE56FfME84i/gx3VykAJVaxFHcATJhktqcUxBN4FSd4XPcvDRu0JAuHfSG/4mk+A21ewrNPH6t10rvne9TOJFrqXTlrWofPDdk1+7rjHFLK/+5RDjOWXtId2HGtgbQosvJQgud7nr+Js7BtJgSx+hqPTK6XdQYKdODnLIxPhxYjNqLbzhCS5SqJcPuywdiugtgQR9DS6GX1WID804ZOMilhFvV0cT74tKX0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5160.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(396003)(346002)(376002)(366004)(64756008)(8936002)(86362001)(54906003)(53546011)(66556008)(66446008)(91956017)(66946007)(8676002)(76116006)(71200400001)(4326008)(6512007)(66476007)(26005)(31696002)(5660300002)(38070700005)(2616005)(122000001)(107886003)(110136005)(478600001)(316002)(41300700001)(38100700002)(186003)(2906002)(31686004)(83380400001)(36756003)(6506007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWtsdDM5RXhkQ0FZL2E4WlFBUCt6U3N6aEhZMHA1VTFhVnJMYkVpTjJXVGFh?=
 =?utf-8?B?WERKblNzWEpnMzlwaU5INlV2V0pXVytpbFEwRmZlYVQ3MmgyUkVsKzNvUkRD?=
 =?utf-8?B?Mk5vM2FBOXlrbUpWL1hxRjhmelZ6YVI3S2FTRjFVYThQUUs0NnlmTWlmd1pG?=
 =?utf-8?B?eGhmTVdMdzUyM3NPeFRTUlNGbWwxaG9lWlpWK0FDSEMxa2ttRDVOVnhPQUhM?=
 =?utf-8?B?TzludENDMUR4V3Uxd2JIQk9BQTFuS1FUNTZybDZjK09FSjE5Ylo2b0dnRytE?=
 =?utf-8?B?bGk3QWtndzVVdGlZdTRFZk1UK1RJeG84dFlxc01GZXNsaVJ0aXFTeDBobVk3?=
 =?utf-8?B?dFRJVW5DOFYwQlBQa2VjOFdwU29kcFA5ZUo2TnB1bDBGQkZ1MUJTZnNDUEZy?=
 =?utf-8?B?RTRmeHcyT0ZpZGZtYW44ZSsxNDJzOExUWWtQRHdzcjBwNlk5MWRNdEFaTkFF?=
 =?utf-8?B?ZExCbXh2c2ExV3NTOWNSak1NVHc0c3E5aFpWN1hmaUQveWwvYTNNcDh0WEpP?=
 =?utf-8?B?OUJydUJZV2J3WFZ3bSsxa0drZFQyeHZJT2QwTUVUTkoyOEhBZmlpSGpZbEU5?=
 =?utf-8?B?QVFaNGlia242KzhBbGxDS1FWay91QXFmUGxPY2hEZmFReGh1WVIvN3V5QVFR?=
 =?utf-8?B?eWFQMEYxaWoyc2VvWmxETWlBNTRDTEpsZzNyUi9LOUtWcUUxNE1qa0p5MVhV?=
 =?utf-8?B?OE1GWjlJb0tTVDFNNktuaVpEb1JyV01SNDVpUFFnbFVwQnRmTmxuKzM3eTRx?=
 =?utf-8?B?Y3llMmQ5TlBiMkptZmdKUi9HeGRoUUUxUEhsbi92OG5TbTJsNEo5bmpBaHRS?=
 =?utf-8?B?ZERHTy91a0dBNXgxeUVKU3ZNd21uNmtPTmErSEt0Z1RRUy8rSm54YlF0U3Vk?=
 =?utf-8?B?UnBDb0RoUGhUN05VWTkvcDQwZnJlaHlXR01uQWtkajN3dWVPRngxRG55NEZ2?=
 =?utf-8?B?a0RMUWZobVZTNjMzQytrYXpTeTV3YzdsWEEzbmZYKzZKVGZMNXQ1L29TYXls?=
 =?utf-8?B?bE0xcFp4QmY2THZ6L05aVzIyWTIvU2tQbFZ3Tzg1ZG0rRVF1OTdpaFRSQTJa?=
 =?utf-8?B?OHJzS1JaZmdvVUhkZHdOQ1VyWmlOUnd3eW1iSTNXL3pPNnpGREYrSmk1d00r?=
 =?utf-8?B?ZlI1SVFicmlJSU5VaUFxeW9EY1NpZzN2dTJCL1hhVmlxSHMrYXh2NVArajlL?=
 =?utf-8?B?Z3JpMlM0NUJaVWlLUlEwS1ZTYjB4OEhnMjF1a3h1RnlRMlhhbTJCQ1NJbXMz?=
 =?utf-8?B?azhkeC92M2JFQmwva0RjM1R0MkQzSzBmdmQrY3JyM2ZQa3FCWVYvcHpEQ0kx?=
 =?utf-8?B?OFkrT2FKNitwS2ZBc2JZZG43cU9Fd3BFMGdkZWF4M0NlZitqeXB3dU8zOVBw?=
 =?utf-8?B?N29RU1J1NFJyajRqaExWeWVHWE5zN3NqblY3ZVNjZ0R3NXVkcHZOb0kzVk83?=
 =?utf-8?B?SkxYaEJQd0lHREovWWJjYjBBak45STJ3bVpiUUIxNVlUOUdVMnZlMHUrZTE2?=
 =?utf-8?B?Q09YUzAyamNKSW5VWWJKS1NMbFRaNFV2TEVUNFVzczYvKzVXVmQxQ0NOdG5m?=
 =?utf-8?B?cFJSNGJQcUFkU3pxZ3RLc2NKc3FKaVpYREVTb3N4MktQMlltb2R2VmJZN09N?=
 =?utf-8?B?UGxTQzhVSExFOEg1N3FrYjV5ZEJwY2ZJblNiTy9kdXNtYzdzZzVKZWw5R29G?=
 =?utf-8?B?cVY1Z1grc0JlYTlhdnBzQ2Q3eGtydTM3Tnh2RFZDZlBZREI4djFWbmhqNVk3?=
 =?utf-8?B?dUV3eFE3SHhhdnVLNFhVZFdzZFF0TStiQkduMFlvcjZJK0VmeFFjd0JSSzd0?=
 =?utf-8?B?RWdxTG42aFVDOEhucWllQnZTUHIwcUNLTUdiMjBrNmRId2NoOEZTVm15TGpa?=
 =?utf-8?B?L3lLRmxaQWt1dUE0U3h2RmRaWUhWSEdUQ2lXWVY0UWxMOTJKcHIwWW96eW16?=
 =?utf-8?B?bVBVUnhDRG5rS1BWbjZkaEJGTU9OTnM3cktCbGkwWVhySFBGREUxdUlWM0I4?=
 =?utf-8?B?Visrek5ZcFZJb21WR0NmcXNSTElJK0pzODNuTnFYVFRuS1RvbTQvajN3bU10?=
 =?utf-8?B?N1pXWFc5aVdWWHRuNVdOV1FBSHZ1TlhwNlVRalc0TUpsZ1lhd2VlcFVRTE5O?=
 =?utf-8?Q?jtCzJQBKapfFfjUsPUqBf7N7+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67BBA6803D6EE34981474F13CB546ACE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5160.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccef86bf-99e5-48b5-d56f-08da64c280e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 11:26:17.4973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wHwD5vHXRQMFxLxFyuoniU3UfWX+3rCr2A1zbagWiO5yGqu5+QjqMDu+TmOSdVzS8JpvZ5sa2V/SUqmcU+eCvSKLet0UdfbEOwYQYl6wMXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6124
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IExld2lzLA0KQ291cGxlIGNvbW1lbnRzLg0KDQpPbiAxMy8wNy8yMDIyIDExOjU5LCBsZXdp
cy5oYW5seUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPiBGcm9tOiBMZXdpcyBIYW5seSA8bGV3aXMu
aGFubHlAbWljcm9jaGlwLmNvbT4NCj4gDQo+IEFkZCBhIGRyaXZlciB0byBzdXBwb3J0IHRoZSBQ
b2xhcmZpcmUgU29DIGdwaW8gY29udHJvbGxlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExld2lz
IEhhbmx5IDxsZXdpcy5oYW5seUBtaWNyb2NoaXAuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dw
aW8vS2NvbmZpZyAgICAgfCAgIDkgKw0KPiAgIGRyaXZlcnMvZ3Bpby9NYWtlZmlsZSAgICB8ICAg
MSArDQo+ICAgZHJpdmVycy9ncGlvL2dwaW8tbXBmcy5jIHwgMzc5ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMzg5IGluc2VydGlv
bnMoKykNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncGlvL2dwaW8tbXBmcy5jDQo+
IA0KDQoNCj4gKw0KPiArc3RhdGljIGludCBtcGZzX2dwaW9fcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikNCj4gK3sNCj4gKwlzdHJ1Y3QgY2xrICpjbGs7DQo+ICsJc3RydWN0IGRl
dmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUgPSBw
ZGV2LT5kZXYub2Zfbm9kZTsNCj4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKmlycV9wYXJlbnQ7DQo+
ICsJc3RydWN0IGdwaW9faXJxX2NoaXAgKmdpcnE7DQo+ICsJc3RydWN0IGlycV9kb21haW4gKnBh
cmVudDsNCj4gKwlzdHJ1Y3QgbXBmc19ncGlvX2NoaXAgKm1wZnNfZ3BpbzsNCj4gKwlpbnQgaSwg
cmV0LCBuZ3BpbzsNCj4gKw0KPiArCW1wZnNfZ3BpbyA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVv
ZigqbXBmc19ncGlvKSwgR0ZQX0tFUk5FTCk7DQo+ICsJaWYgKCFtcGZzX2dwaW8pDQo+ICsJCXJl
dHVybiAtRU5PTUVNOw0KPiArDQo+ICsJbXBmc19ncGlvLT5iYXNlID0gZGV2bV9wbGF0Zm9ybV9p
b3JlbWFwX3Jlc291cmNlKHBkZXYsIDApOw0KPiArCWlmIChJU19FUlIobXBmc19ncGlvLT5iYXNl
KSkNCj4gKwkJcmV0dXJuIFBUUl9FUlIobXBmc19ncGlvLT5iYXNlKTsNCj4gKw0KPiArCWNsayA9
IGRldm1fY2xrX2dldCgmcGRldi0+ZGV2LCBOVUxMKTsNCj4gKwlpZiAoSVNfRVJSKGNsaykpIHsN
Cj4gKwkJZGV2X2VycigmcGRldi0+ZGV2LCAiZGV2bV9jbGtfZ2V0IGZhaWxlZFxuIik7DQo+ICsJ
CXJldHVybiBQVFJfRVJSKGNsayk7DQo+ICsJfQ0KPiArDQo+ICsJcmV0ID0gY2xrX3ByZXBhcmVf
ZW5hYmxlKGNsayk7DQo+ICsJaWYgKHJldCkgew0KPiArCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJm
YWlsZWQgdG8gZW5hYmxlIGNsb2NrXG4iKTsNCj4gKwkJcmV0dXJuIHJldDsNCj4gKwl9DQo+ICsN
Cj4gKwltcGZzX2dwaW8tPmNsayA9IGNsazsNCj4gKw0KPiArCW5ncGlvID0gb2ZfaXJxX2NvdW50
KG5vZGUpOw0KPiArCWlmIChuZ3BpbyA+IE5VTV9HUElPKSB7DQo+ICsJCWRldl9lcnIoZGV2LCAi
VG9vIG1hbnkgR1BJTyBpbnRlcnJ1cHRzIChtYXg9JWQpXG4iLA0KPiArCQkJTlVNX0dQSU8pOw0K
DQpUaGlzIHNob3VsZCBmaXQgb24gb25lIGxpbmUNCg0KPiArCQlyZXQgPSAtRU5YSU87DQo+ICsJ
CWdvdG8gY2xlYW51cF9jbG9jazsNCj4gKwl9DQo+ICsNCj4gKwlpcnFfcGFyZW50ID0gb2ZfaXJx
X2ZpbmRfcGFyZW50KG5vZGUpOw0KPiArCWlmICghaXJxX3BhcmVudCkgew0KPiArCQlkZXZfZXJy
KGRldiwgIm5vIElSUSBwYXJlbnQgbm9kZVxuIik7DQo+ICsJCXJldCA9IC1FTk9ERVY7DQo+ICsJ
CWdvdG8gY2xlYW51cF9jbG9jazsNCj4gKwl9DQo+ICsJcGFyZW50ID0gaXJxX2ZpbmRfaG9zdChp
cnFfcGFyZW50KTsNCj4gKwlpZiAoIXBhcmVudCkgew0KPiArCQlkZXZfZXJyKGRldiwgIm5vIElS
USBwYXJlbnQgZG9tYWluXG4iKTsNCj4gKwkJcmV0ID0gLUVOT0RFVjsNCj4gKwkJZ290byBjbGVh
bnVwX2Nsb2NrOw0KPiArCX0NCj4gKw0KPiArCS8qIEdldCB0aGUgaW50ZXJydXB0IG51bWJlcnMu
DQoNCm5ldGRldiBzdHlsZSBjb21tZW50DQoNCj4gKwkgKiBDbGVhci9EaXNhYmxlIEFsbCBpbnRl
cnJ1cHRzIGJlZm9yZSBlbmFibGluZyBwYXJlbnQgaW50ZXJydXB0cy4NCj4gKwkgKi8NCj4gKwlm
b3IgKGkgPSAwOyBpIDwgbmdwaW87IGkrKykgew0KPiArCQltcGZzX2dwaW8tPmlycV9udW1iZXJb
aV0gPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIGkpOw0KDQpZb3UgbmVlZCB0byBoYW5kbGUgdGhl
IGNhc2Ugd2hlcmUgcGxhdGZvcm1fZ2V0X2lycSByZXR1cm5zIGFuIGVycm9yIHJpZ2h0Pw0KDQo+
ICsJCW1wZnNfZ3Bpb19hc3NpZ25fYml0KG1wZnNfZ3Bpby0+YmFzZSArIE1QRlNfSVJRX1JFRywg
aSwgMSk7DQo+ICsJCW1wZnNfZ3Bpb19hc3NpZ25fYml0KG1wZnNfZ3Bpby0+YmFzZSArIChpICog
QllURV9CT1VOREFSWSksDQo+ICsJCQkJICAgICBNUEZTX0dQSU9fRU5fSU5ULCAwKTsNCj4gKwl9
DQo+ICsNCj4gKwlyYXdfc3Bpbl9sb2NrX2luaXQoJm1wZnNfZ3Bpby0+bG9jayk7DQo+ICsNCj4g
KwltcGZzX2dwaW8tPmdjLmRpcmVjdGlvbl9pbnB1dCA9IG1wZnNfZ3Bpb19kaXJlY3Rpb25faW5w
dXQ7DQo+ICsJbXBmc19ncGlvLT5nYy5kaXJlY3Rpb25fb3V0cHV0ID0gbXBmc19ncGlvX2RpcmVj
dGlvbl9vdXRwdXQ7DQo+ICsJbXBmc19ncGlvLT5nYy5nZXRfZGlyZWN0aW9uID0gbXBmc19ncGlv
X2dldF9kaXJlY3Rpb247DQo+ICsJbXBmc19ncGlvLT5nYy5nZXQgPSBtcGZzX2dwaW9fZ2V0Ow0K
PiArCW1wZnNfZ3Bpby0+Z2Muc2V0ID0gbXBmc19ncGlvX3NldDsNCj4gKwltcGZzX2dwaW8tPmdj
LmJhc2UgPSAtMTsNCj4gKwltcGZzX2dwaW8tPmdjLm5ncGlvID0gbmdwaW87DQo+ICsJbXBmc19n
cGlvLT5nYy5sYWJlbCA9IGRldl9uYW1lKGRldik7DQo+ICsJbXBmc19ncGlvLT5nYy5wYXJlbnQg
PSBkZXY7DQo+ICsJbXBmc19ncGlvLT5nYy5vd25lciA9IFRISVNfTU9EVUxFOw0KPiArDQo+ICsJ
LyogR2V0IGEgcG9pbnRlciB0byB0aGUgZ3Bpb19pcnFfY2hpcCAqLw0KDQpJIGRvdWJ0IHRoaXMg
Y29tbWVudCBpcyBuZWVkZWQNCg0KPiArCWdpcnEgPSAmbXBmc19ncGlvLT5nYy5pcnE7DQo+ICsJ
Z3Bpb19pcnFfY2hpcF9zZXRfY2hpcChnaXJxLCAmbXBmc19ncGlvX2lycWNoaXApOw0KPiArCWdp
cnEtPmZ3bm9kZSA9IG9mX25vZGVfdG9fZndub2RlKG5vZGUpOw0KPiArCWdpcnEtPnBhcmVudF9k
b21haW4gPSBwYXJlbnQ7DQo+ICsJZ2lycS0+Y2hpbGRfdG9fcGFyZW50X2h3aXJxID0gbXBmc19n
cGlvX2NoaWxkX3RvX3BhcmVudF9od2lycTsNCj4gKwlnaXJxLT5oYW5kbGVyID0gaGFuZGxlX2Jh
ZF9pcnE7DQo+ICsJZ2lycS0+ZGVmYXVsdF90eXBlID0gSVJRX1RZUEVfTk9ORTsNCj4gKw0KPiAr
CXJldCA9IGdwaW9jaGlwX2FkZF9kYXRhKCZtcGZzX2dwaW8tPmdjLCBtcGZzX2dwaW8pOw0KDQpD
YW4gd2UgdXNlIGEgZGV2bV8gdmFyaWFudCBpbnN0ZWFkIGhlcmUuLi4NCg0KPiArCWlmIChyZXQp
DQo+ICsJCWdvdG8gY2xlYW51cF9jbG9jazsNCj4gKw0KPiArCXBsYXRmb3JtX3NldF9kcnZkYXRh
KHBkZXYsIG1wZnNfZ3Bpbyk7DQo+ICsJZGV2X2luZm8oZGV2LCAiTWljcm9jaGlwIE1QRlMgR1BJ
TyByZWdpc3RlcmVkLCBuZ3Bpbz0lZFxuIiwgbmdwaW8pOw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+
ICsNCj4gK2NsZWFudXBfY2xvY2s6DQo+ICsJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKG1wZnNfZ3Bp
by0+Y2xrKTsNCj4gKwlyZXR1cm4gcmV0Ow0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IG1wZnNf
Z3Bpb19yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gK3sNCj4gKwlzdHJ1
Y3QgbXBmc19ncGlvX2NoaXAgKm1wZnNfZ3BpbyA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYp
Ow0KPiArDQo+ICsJZ3Bpb2NoaXBfcmVtb3ZlKCZtcGZzX2dwaW8tPmdjKTsNCg0KLi4uIGFuZCBk
cm9wIHRoaXM/DQoNCj4gKwljbGtfZGlzYWJsZV91bnByZXBhcmUobXBmc19ncGlvLT5jbGspOw0K
PiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2Zf
ZGV2aWNlX2lkIG1wZnNfZ3Bpb19tYXRjaFtdID0gew0KPiArCXsgLmNvbXBhdGlibGUgPSAibWlj
cm9jaGlwLG1wZnMtZ3BpbyIsIH0sDQo+ICsJeyAvKiBlbmQgb2YgbGlzdCAqLyB9LA0KDQpEb24n
dCBuZWVkIGEgY29tbWEgYWZ0ZXIgdGhlIHNlbnRpbmVsDQoNCj4gK307DQo+ICsNCj4gK3N0YXRp
YyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIG1wZnNfZ3Bpb19kcml2ZXIgPSB7DQo+ICsJLnByb2Jl
ID0gbXBmc19ncGlvX3Byb2JlLA0KPiArCS5kcml2ZXIgPSB7DQo+ICsJCS5uYW1lID0gIm1pY3Jv
Y2hpcCxtcGZzLWdwaW8iLA0KPiArCQkub2ZfbWF0Y2hfdGFibGUgPSBvZl9tYXRjaF9wdHIobXBm
c19ncGlvX21hdGNoKSwNCj4gKwl9LA0KPiArCS5yZW1vdmUgPSBtcGZzX2dwaW9fcmVtb3ZlLA0K
PiArfTsNCj4gK2J1aWx0aW5fcGxhdGZvcm1fZHJpdmVyKG1wZnNfZ3Bpb19kcml2ZXIpDQoNCk1p
c2luZyBzZW1pY29sb24/DQoNClRoYW5rcywNCkNvbm9yLg0K
