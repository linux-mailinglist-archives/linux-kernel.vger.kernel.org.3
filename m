Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78440564DA0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 08:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbiGDGTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 02:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiGDGTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 02:19:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A995FC9
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 23:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656915561; x=1688451561;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uPpw7HQy197uphHqTQhYcCy8e+n2zAJZp2yPLcPhYlU=;
  b=D5kczSrCpmD+dEMjCgTEpuhAXnurksOQTitIy23+LSEW4ACskZhAO2oP
   HtmGSIQITku0awPR7PDmEl+/0DzCdHbaQHjH37qF4lqu4rfLVs0EwARR7
   vhG5rXBCeDRBOonuuxLy/wnmeMwXfCDNu1E3INr9TGFkoPiKfIikPXXGr
   0QA4sKNWoB7IE9bbhW46brqpqqjeDsw8OI3rflZmGrjM45btkf00XofHv
   TDyTfw58EkJxlE6i5XEGB3HKzoXUVRYyzFnWfNe5zKfeuA82CAt0m94Yn
   9oMAj5MpW9HGljMeyq1mXYlFy4bn3YLL6FbrjAEWbCmkT1S9LFq/WyhM7
   A==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="170910047"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jul 2022 23:19:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 3 Jul 2022 23:19:21 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Sun, 3 Jul 2022 23:19:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HY/D3G17Q6fGHmbuvxjmGLg8Y+zvwpxx15JMR+ovluN/cSAsemomPGIF1rQ28OCv4dGP2OIPLnCv2VJJRiDwtEdsbzu+s5B2hQ/OpRTQDn5LDnjHyo1U4z+RG2nh9SSWGGUWvrZ6gfMS6VgH85t8VmSyvY07LqvLnA1e+tkZlhU/PaNisMCyGe5McpBSAIEe6JCmv7ZWSnXuFExIkXj5zSrUMkgCALCTm++LF7P+XMOiQqYzJ0zhonHDgkvY8UC782LDguj1XV+ogzqdXbFIc4/wllCMNrCcBKqmJhMr/wDoWWTUMEeweIApRC2CFQssnp6qus8fAz8wD/ZDQP1NrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPpw7HQy197uphHqTQhYcCy8e+n2zAJZp2yPLcPhYlU=;
 b=L+lgWiZG+b456fg3vr6H1pQ5AcnJoOQpZF9Cz7IuuAYR0gURCFTUH47l4akHANj3Rs4e+AM1bPNFh2fpq6iIJcIBS4ccebejpNpFUh8g6IW3syH0581bWWR2Tu/WqmLh/INnr75ceFaVhNkaGogEyEE7r1pCofyZc9BdeHnDXfA9dL8B7O2FrGBgTcVuASbDyTqUg2xXV60HPJsX7lCQbmNyA+2Zisov2tIm08rZVMwSYFP3T0EGmCRdYbJyi8CULaWmJbcRDTg62/FQvoKBw0tUHX73tyl4I5zfG5YtveSY5wUNPQyE3tOTeS/l8ighydu5aLMkdkVM2l8kgYJZFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPpw7HQy197uphHqTQhYcCy8e+n2zAJZp2yPLcPhYlU=;
 b=TYG2r1c0DJ50SB0rnr1IISvkH4lRWDLUB04kCWBQOIlXoeDn+nulLo2WGxNHDhUcgmlznZilgBpWQb+y8ejELF4JeQNORlBjd9OjicI9opPFz/FeR7JTjH4GdO+LsnyjyYb16eC0HTuxQL3rRLePq+XoQGyzK0vI9UAGkmc7e6o=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DS0PR11MB6543.namprd11.prod.outlook.com (2603:10b6:8:d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Mon, 4 Jul
 2022 06:19:17 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 06:19:17 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <clement.leger@bootlin.com>, <linux@armlinux.org.uk>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/2] ARM: at91: add sam_linux_is_in_normal_world()
 function
Thread-Topic: [PATCH 1/2] ARM: at91: add sam_linux_is_in_normal_world()
 function
Thread-Index: AQHYj238/VLC3Z9H60WomxAXo+ygxg==
Date:   Mon, 4 Jul 2022 06:19:17 +0000
Message-ID: <fe771973-e9aa-d397-1849-41617cc2d226@microchip.com>
References: <20220606145701.185552-1-clement.leger@bootlin.com>
 <20220606145701.185552-2-clement.leger@bootlin.com>
In-Reply-To: <20220606145701.185552-2-clement.leger@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f399f982-5d3c-4534-fa9d-08da5d851fba
x-ms-traffictypediagnostic: DS0PR11MB6543:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wSyMwBeLO8uJ+Fnf57+gU0p/EZs9+T8u164dVWFrqTrfwPhZ7N1dfY2wepc848lDZPelipqHDbTgZf+kfB27HP25B9uHWzrafExBlKnBLi78jCL2DqhHEA7vYfrRfyoyk9nnqz1qIPb7xqc4zIOA89fcGaVG/5lDesdRfTTMEc+sH1pSmjiAEdBdbOn2KtiyJM45Y9+QR8UVocIe4YtgodZf0UP7++xh83ks+PIdi3j1PYTdgPnwfE5rjQ5lROZIoEYH6FBvVerSGICvfIO1NdJBiZQvozkkIt4haviHoD5bwR6yEQMFwuIi6xx8UHk1VfLy9P9tHmoAoVDXRZhFgxOErNcXk/YYTJBSq32h4eB8AC5rDu53Xg05wWvV9btq2uTFPqNXZj+2872HWg/SA8Nj2iPPkrg36W69BumgbmvlK/Q/SyZoy/2g4GO0/roEcORgqres81HILmqzsprBnG7K14ajfRC1d351ST4uxZP0zPiMFUqoq/YyEOinaWbT2EPX4LGsL0EhUvntUp4Jxqjp7dhIzn0t1aeHbP7MI8lHjsLe1Uh/nsODWkzNTJ7zJohx38hbZOY7+LEdGUvaa8bzSJCmPB2cyLRGSeGQ9tOZzMxk3HxcruKZlvDgep2L9TBS3/Unu11+iqdk0Z+dor1bcC3acaQZUpZ9zBY4KOklBBxaNUd4reevexwuCRW1XR0ygdOyzzu8wESQ5IVf1qdfb65E500IL2p5kDF/pRtSQajo+wXKdVBFpSuR/0TiStkHmGxtcbOdmVaR60mMqDEtyepm/svWr/Y7RZynpqaPvIbQ9a6kOVmfaTrEqF5GhDDHYUk4ugBSzUExsLsPD2fi+m8rIDa4Q8sU8gEzEqVX3RNWseGHiEOOPr6MGt47
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(376002)(39860400002)(346002)(366004)(38100700002)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(54906003)(76116006)(91956017)(86362001)(31696002)(316002)(122000001)(110136005)(71200400001)(38070700005)(5660300002)(26005)(36756003)(6512007)(2616005)(31686004)(6486002)(2906002)(41300700001)(8936002)(478600001)(6506007)(53546011)(83380400001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2Y0Zk05MGRPNVVEMXgyQ3JrcUVSK2FxbzgyN2JOK1IvcnhjYmtPSGRMdllU?=
 =?utf-8?B?L3RURXlhWWtwT1hSeGRwNVpSS0tLTGthZU5hK0M5UzFMYkxQU09xemNhUW1S?=
 =?utf-8?B?TzJqcFBmeXZKUFNwME1ONFJsODA5aTRiamFGQ0VsUkRJUktMUE1VNjdtSERs?=
 =?utf-8?B?dXdDeGZvQTdHQkJuanFqUVpvNzE2b3g5N1hOeUFSNUFvZmgwdkh2WVgvS1FM?=
 =?utf-8?B?Nm9wd25ZUExTSFlVem0wYjYrUlJNQ2l4ZHpsT00yUzZYV0JqMVAycGM1d0dV?=
 =?utf-8?B?NldNQ1BvSCt3MU9OWGpSTE11R0tHQVJBTUNiMmh2a0YxMnRzcTVVOElRMGw3?=
 =?utf-8?B?ZXRpdEdDS2tPYncyelpIaGlPeURlcGx1eHlEaUVCNVdCTnpxMU9VRFdZSXBl?=
 =?utf-8?B?MENmeDdGb0YwQldIMWtHbjdTU3BEL3V1UzFFckQ4Wjk5WUE1YUZvYWFHdEli?=
 =?utf-8?B?eUNjWkZCYXBLZFpQRFBwb1pXRFFGV3lpSzNsa1NSMFZzM1ZiRVc3RG1GcDd3?=
 =?utf-8?B?R05WVEY0MTlDTFlZTzU4dHBJeThya0h2U1JiSW5XbU83bnIwYUM5U0VlaXF0?=
 =?utf-8?B?RWhjVm54VjBody9NVFdKM3dvYzRQNFF6MDk1MEswekpzcGdGZVZ2UEJFRk9x?=
 =?utf-8?B?OUVQaTkwRGtmOUZSOHBTTjFrb0g5Vm9vdHduZU5CRXgxMkl3TWlqeENjdWln?=
 =?utf-8?B?WWIvMk1iTUZyWDVpaGJrU3FFRmptSUhWNTBMWFI4QkNjMmF3bmNRSWIzRFpR?=
 =?utf-8?B?WG5OSFRKb3ptZ20vek5teXhhMi95aE05K2Z3NWx0N0FMeDJoS1YwbFNpTUIx?=
 =?utf-8?B?OWtoZEM2M2wzOW10Nkx4SDFGRStqY2xzdDQrL1VadWFmMzNSNTNjYkVmbk1a?=
 =?utf-8?B?bS9sdnRDU0ppTGdXNlpqdDVhcHlQZVpaZUppZW9NajFvNUhkZFhvYXkxQTY2?=
 =?utf-8?B?M1ppWTdhbGNwU1hrWGNERFFqbkl4MFV4dXFaVm1DRGkxdWhLclpobzB6SElH?=
 =?utf-8?B?TFNkaDMwV0JuZ2lGNlVtR24rcWV1S2c0V2xoMEt6aXpacnhXa1lobW4wMHI1?=
 =?utf-8?B?VWFtNTkwdFFRMkdoc05ZWmdydFUvcERRZllzT2dVQ1F3bU5LSEM2MGlFYUtL?=
 =?utf-8?B?NUk1OElGcDhBaGUyU1NXUURKcEF2OXQ5K3A5bnJpZmlSeDI0REJ0VHgrc3px?=
 =?utf-8?B?L3hmV2g2R0swUG92QWdJU0Y5eUY5QzhCTXhxVStPK3RQSW5YRHRxYUxNRTg4?=
 =?utf-8?B?SVlUVkdPNUVJdTNlQUg3NUhsVFhZeGNDVnJiSUJGL0JNOXhpNVZWdnpOUDNI?=
 =?utf-8?B?aHB5eWNVU2FOa2E1bEY3d29vZHg4UDVmVHJPSkE0ZFhVV01aVUtqYUR6U0k0?=
 =?utf-8?B?QWRDSnpRTmJuUVVrMW1uRGVnRVMrRmdnL09PNldHSVZUTW5BYjJLTmZpaEV0?=
 =?utf-8?B?S1N1Mk5SU2JrMWdtUVF6VEVVWW9JOE9QUm84eHpxMDQ2RGU5SDVaVk9JUk9h?=
 =?utf-8?B?am9pcXdHc1paZFlIb0d2cndDR3J6N25SbkFoWFhNdlg3TlZQZkp0d1l4NEEx?=
 =?utf-8?B?QU9GbW1sQlVNYmN3b2JMVVk5bEFCc0ZTaUx1U0FFMFg2aU5IeVdZNVlvUHBW?=
 =?utf-8?B?Z2NCL3hwYXVvc29Mdmw1RWxHV1dlSngvUTNpUXVZV090MllNbFkzSE1jalh4?=
 =?utf-8?B?R1BtRDY0MjIyekVXdGROV014YkUxdTRxYllSTFlkMGQ3bHNlVVZmTER2RVQr?=
 =?utf-8?B?VnNxQWNRQVZmRGlDQmVJbGczeU5Vd3NzOXh3ejIyT3JDUDJxUTl5SHgrY0sy?=
 =?utf-8?B?Z0VydjNRTEZDaUp5cGVGWUJHaXE4dTdVTUhtbHpISFNhUW8vS04wb0lxUG1L?=
 =?utf-8?B?eFpHMk53VUx4SVdvNWhpZDhYZXdLSnJiYjZxYUc3Yms2YUh1TElEMjZndzFs?=
 =?utf-8?B?NklDa29nb2Z6QVBCOGZoTDV6OTdnR3QzWUk3OUc5OWExaUpiTmVlRkVvbzl3?=
 =?utf-8?B?c3BNazZIRHh4R1VsVitReUlTM081a09SMVRFSWl2SlR4N2l6ekVDa3ZCRDZr?=
 =?utf-8?B?NXNNMHRYcW44c0J5ZDRGMlZwUWZwWmI4cFBvOWpRK0piN1RUc2ZzUjBZb1Z4?=
 =?utf-8?B?eVNTUHlzSUJjbjZ6YktjLzRCN3NVaW9VN2tVYTczWTZ2K25LdnVzWWk5MFpw?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <50BB5B0EE7E9B2488F6D2FB0FF618D26@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f399f982-5d3c-4534-fa9d-08da5d851fba
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 06:19:17.0571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kCZfmOz4HPfQR73Bs38b7PeW8SeSJd4vGwDIOM6UdjnQbWljF+4nDpD2E9nPjyel5sI2hnzge7n6ovW6xJlkMfSbrqxcDeS/kbKcXINAyw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6543
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIENsZW1lbnQsDQoNCk9uIDA2LjA2LjIwMjIgMTc6NTcsIENsw6ltZW50IEzDqWdlciB3cm90
ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBZGQgc2FtX2xp
bnV4X2lzX2luX25vcm1hbF93b3JsZCgpIHdoaWNoIGFsbG93cyB0byBrbm93IGlmIExpbnV4IGlz
DQo+IHJ1bm5pbmcgaW4gdGhlIG5vcm1hbCB3b3JsZCBvciBub3QuIFRoaXMgZnVuY3Rpb24gaXMg
dXNlZCBieSBjb2RlDQo+IHdoaWNoIG5lZWRzIHRvIGRpZmZlcmVudGlhdGUgdGhlIHdvcmxkIGlu
IHdoaWNoIExpbnV4IGlzIHJ1bm5pbmcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBM
w6lnZXIgPGNsZW1lbnQubGVnZXJAYm9vdGxpbi5jb20+DQo+IC0tLQ0KPiAgYXJjaC9hcm0vbWFj
aC1hdDkxL3NhbV9zZWN1cmUuYyB8IDYgKysrKysrDQo+ICBhcmNoL2FybS9tYWNoLWF0OTEvc2Ft
X3NlY3VyZS5oIHwgMSArDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtYXQ5MS9zYW1fc2VjdXJlLmMgYi9hcmNoL2Fy
bS9tYWNoLWF0OTEvc2FtX3NlY3VyZS5jDQo+IGluZGV4IDJhMDFmN2E3ZDEzZi4uMWVjOGM4Yjlk
MTE5IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9tYWNoLWF0OTEvc2FtX3NlY3VyZS5jDQo+ICsr
KyBiL2FyY2gvYXJtL21hY2gtYXQ5MS9zYW1fc2VjdXJlLmMNCj4gQEAgLTI3LDYgKzI3LDEyIEBA
IHN0cnVjdCBhcm1fc21jY2NfcmVzIHNhbV9zbWNjY19jYWxsKHUzMiBmbiwgdTMyIGFyZzAsIHUz
MiBhcmcxKQ0KPiAgICAgICAgIHJldHVybiByZXM7DQo+ICB9DQo+IA0KPiArYm9vbCBzYW1fbGlu
dXhfaXNfaW5fbm9ybWFsX3dvcmxkKHZvaWQpDQo+ICt7DQo+ICsgICAgICAgLyogSWYgb3B0ZWUg
aGFzIGJlZW4gZGV0ZWN0ZWQsIHRoZW4gd2UgYXJlIHJ1bm5pbmcgaW4gbm9ybWFsIHdvcmxkICov
DQoNCkluIGNhc2Ugb3B0ZWUgaGFzbid0IGJlZW4gZGV0ZWN0ZWQgZG9uJ3Qgd2UgcnVuIGFsc28g
aW4gbm9ybWFsIHdvcmxkPw0KV2hhdCBJIHdhbnQgdG8gc2F5IGlzIHRoYXQgbWF5YmUgeW91IGNh
biBjaGFuZ2UgdGhlIGZ1bmN0aW9uIG5hbWUgdG8NCnNvbWV0aGluZyBsaWtlIHNhbV9saW51eF9p
c19vcHRlZV9hdmFpbGFibGUoKS4NCg0KVGhhbmsgeW91LA0KQ2xhdWRpdSBCZXpuZWENCg0KPiAr
ICAgICAgIHJldHVybiBvcHRlZV9hdmFpbGFibGU7DQo+ICt9DQo+ICsNCj4gIHZvaWQgX19pbml0
IHNhbV9zZWN1cmVfaW5pdCh2b2lkKQ0KPiAgew0KPiAgICAgICAgIHN0cnVjdCBkZXZpY2Vfbm9k
ZSAqbnA7DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLWF0OTEvc2FtX3NlY3VyZS5oIGIv
YXJjaC9hcm0vbWFjaC1hdDkxL3NhbV9zZWN1cmUuaA0KPiBpbmRleCAxZTdkOGIyMGJhMWUuLjZk
OGMwMWY5YzVmMCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vbWFjaC1hdDkxL3NhbV9zZWN1cmUu
aA0KPiArKysgYi9hcmNoL2FybS9tYWNoLWF0OTEvc2FtX3NlY3VyZS5oDQo+IEBAIC0xNCw1ICsx
NCw2IEBADQo+IA0KPiAgdm9pZCBfX2luaXQgc2FtX3NlY3VyZV9pbml0KHZvaWQpOw0KPiAgc3Ry
dWN0IGFybV9zbWNjY19yZXMgc2FtX3NtY2NjX2NhbGwodTMyIGZuLCB1MzIgYXJnMCwgdTMyIGFy
ZzEpOw0KPiArYm9vbCBzYW1fbGludXhfaXNfaW5fbm9ybWFsX3dvcmxkKHZvaWQpOw0KPiANCj4g
ICNlbmRpZiAvKiBTQU1fU0VDVVJFX0ggKi8NCj4gLS0NCj4gMi4zNi4xDQo+IA0KDQo=
