Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4912D574502
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 08:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbiGNGTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 02:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbiGNGTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 02:19:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB601EED1;
        Wed, 13 Jul 2022 23:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657779580; x=1689315580;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LgDNh+vkS22vWiUqbKTqhG8rBowmu0MTSj0P2jcSdoI=;
  b=uzuizwv1KXV5p/7Qxc0obKqbjWgT9+q2kCvdJHCjs1HmChGNM4mzfynu
   nX/5yGcfls8+Chf37VvADlg/bvDlmsjNGbIseDJgEi+vOMsEyT8oSD4AD
   CsBJ02jyPrMCbROXGgqwTovXxTiQAzoyewYxv4iPv0Xw7QlIdRuZzeAU4
   J7lsY4rtE4C2DvUDflo/f7BsgwR0LPnBnAm2wXiMO1yrTQMqqw+NxvI+W
   wGAVrHHSK7oGQjLjnrjcXndJ8OxvClc2BzcwC9dSzoguwOmwQrN65WRMt
   aO981rsGIjvMZES2JfKdDXy/PHIT2mC6hlE6JvCj5NUDuCwSC8DOULzgn
   A==;
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="182098211"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2022 23:19:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Jul 2022 23:19:39 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 13 Jul 2022 23:19:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DebPixHtHR45N74osLnLucjZUptZMY4QGQAsaRF7sfPXQsJ4GiMKU2o8d9jFQHwMssMtzzQgSWpFQkNw0qJuMgnIQOxmwmhWhq4PTiHrjBXyoASEP7VqVS2mTfPJDT2mAR9aMyRgpuiizgCuCF1vmFPTU8MtgqytUl4pQz4vCBZoxnAmCQ4D8btaHA93BytEk+MQmNh4hVIJhkQxB8dmHAwPEK3z/JXi3g3tqbF9s6EUcDMHT8aOLvHEuktf2Wg1vs5fITT3fN0Agpo/tTEA+9fB5Hv6Y+/RF/QJLOQnexBKuHPKnAl5ndl+QYroXwjSfAEPodxHdB67eYdS49RtzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgDNh+vkS22vWiUqbKTqhG8rBowmu0MTSj0P2jcSdoI=;
 b=B4ol3mLoCAzeEzsEt8FifO9NR0+xasdqHa04cxfQ5w8vCK/ltF69/6fFsquWeuJff56vZf43Xy9X0MmBFs6Dd8fhnhZjYvjCdjI3KatTcOkRUg91q1vQ0yCL+pVg3OJtIGbvntbo8g/8oRdZvaaEwgEkRvJNvnQQLZja73Dl7M47UWeaEnN6XntQHNaazBN/V4BCYYcR/jeHVTDRcS2STh1SpFnFHusY7xDkLHMu7gkkDLUDGWeej37r0lYGuYYy9x+QbFY6wcDdgh6V0Nkkb1CHtBlKeo2ib2MXvd3wN8Z3r49JiWvfwq272GR/wgQwAVkffj+i0FSBDPE7bL/p7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgDNh+vkS22vWiUqbKTqhG8rBowmu0MTSj0P2jcSdoI=;
 b=tqPLjeCVtlPXjxBSM2ZHCxeY0d/+N7F5GFgrX1LNjfLIGu/OXzBhcaLV1b5tYrRio7XvmGGd2Mbfg5thyp2i023qgmofsO797URyst74v92iuvc624hVOgKF10J3sllyEeIxngXsRfrcOor3f6T5Uk5LxZlmWClMMTtlVaF627w=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB3547.namprd11.prod.outlook.com (2603:10b6:5:136::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Thu, 14 Jul
 2022 06:19:32 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b%7]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 06:19:32 +0000
From:   <Conor.Dooley@microchip.com>
To:     <Lewis.Hanly@microchip.com>
CC:     <linux-riscv@lists.infradead.org>, <brgl@bgdev.pl>,
        <andy.shevchenko@gmail.com>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <palmer@dabbelt.com>, <maz@kernel.org>,
        <linux-kernel@vger.kernel.org>, <Daire.McNamara@microchip.com>
Subject: Re: [PATCH v2 1/1] gpio: mpfs: add polarfire soc gpio support
Thread-Topic: [PATCH v2 1/1] gpio: mpfs: add polarfire soc gpio support
Thread-Index: AQHYlqemVrcQOBoUV020qkXDgR8Pgq18MrcAgACSjICAABlAgIAAh5gA
Date:   Thu, 14 Jul 2022 06:19:32 +0000
Message-ID: <9107c441-73b7-fd7c-9c25-e8a31afbe563@microchip.com>
References: <20220713105910.931983-1-lewis.hanly@microchip.com>
 <20220713105910.931983-2-lewis.hanly@microchip.com>
 <CAHp75VfGTd02jKYsFq94BF_Gqro2trk3iyyALBatS1Bps3HYhw@mail.gmail.com>
 <abdf389cfd049f60b951447c047bbd186fa19469.camel@microchip.com>
 <CAHp75VeX8p4m7Bi=9Zvk5=MRTOb=BTmcuDbtW1ZUOr_-1mHvyQ@mail.gmail.com>
In-Reply-To: <CAHp75VeX8p4m7Bi=9Zvk5=MRTOb=BTmcuDbtW1ZUOr_-1mHvyQ@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4dfdddf2-2b8d-4ff1-6efe-08da6560d13e
x-ms-traffictypediagnostic: DM6PR11MB3547:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NfuV/4yJz4PId8TB/Fi5dmalcW3xOod53XYrhyLmEXUT2WaZYF1aHJ7dwUBvykF/DKG3tNxw6+lda+vrmpKeNiDQlw+R0h+r1CmBJc6yo0ZDv72IElm5EoXW6/4RHIg8+1YPGLuMAckm9IqKa9gwbVRmn/g1Fy6xMOFVUti+XCfmrF4ZX4b81eGHhZSbBs0CnLi/q9fsAwJPbXHKb7MqZj36MAacUjNc2oDZrOCwERFggDGlNSNPweZ3yKeswsD8MBjD3FkOLx433SsxseZT/2f4IDQEmBQKqyKWXgRC5/rBmWlXEMq9UvNOnLsclAJEI6bdpsnCGGV1AMI6MX3gwTcEIhlxW8baUsE9dL3zVnEjg6SwmVG0rG9zmgxWLqVFcJdzWddJ3DWftWG12CIQXBpJ3z+6iPVfDdL6QOCKNQAOyeGg1FEzg1puBlwTb2uUSQU4KUrsN/Iyc+OwWU4IjCkSLdoPN5ED0fZ4O4HFLCRD6Qcd6VlqneUYTYDPSDHSdQ/njgZLNSyFDnLJZvQbeTdKnJiVq45MKoLUOv58P9vx7iid7QW0epk7aeD3C3RuaaoQjTTp+I+Pa4ApkRYal+dn7erkvyiINeu3wBWCdB5O/3e39uaE7fsBHHlV0MTO2V91IdN3zsgVZZNaDltClLcCPuKrdeGtZRKMuJLe2BJgalHhDf/f94P0BE2Ymwno4/hDmEpeUwNc+H2xSLywlwcpqdxKFpCch1cBKpqIHnRF2oM7tUs0uIR2NhMgG8LUZxuFhh5+s2odjPDsaSA0x1DogtKWG273FVXx+Bhf9onTevfuRGp4V4zrNRKE18mWPIpRehogBooP6HCnuoCPUuqL7EvHM2GlEradfA0cn66RWE6yVwIKsdbpkZAn24Z4a5rO85yZGlWRzUZZB7Hs4FHbcpaziGqzyyjLWf6mIuc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(366004)(376002)(396003)(39860400002)(91956017)(6862004)(122000001)(64756008)(76116006)(966005)(41300700001)(38070700005)(86362001)(6506007)(8676002)(66476007)(4326008)(2906002)(66556008)(6486002)(8936002)(66446008)(71200400001)(66946007)(5660300002)(36756003)(4744005)(6512007)(31696002)(6636002)(37006003)(31686004)(186003)(38100700002)(54906003)(2616005)(26005)(107886003)(316002)(53546011)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTFmMk90Tm5KU1VGdUZtRHZpYmhac3JJd1pxZ1hUUnJIclFXUmExOXFzSG1U?=
 =?utf-8?B?T2lDNDd2RUtnUk9TTVRqR295cEN4YVEzcnBOUDQ5aUJjUGpmYXBDNWlteUIy?=
 =?utf-8?B?TlR6TUxpRGNrNGZWSDdKVXl2MXpxVnlONXJDMzdwUXpnRW5BQVlCUFVJbE1m?=
 =?utf-8?B?Tkdwa2puemxLaElKZWpzTVh1MXJCbUE5MmNZcmNldllTeENZSEVPSkRxVGZt?=
 =?utf-8?B?emI3R0o5NUpHOEVrcXRkNnRFc1JISFBPKzRQVVROV2JabDJrZ1RmNElJZ1Nr?=
 =?utf-8?B?WitrbUJLckNzeVlzbjdEbFBRbkhNSlNuOUIyak4yaDYxL0l0ZDZJSHpWQVNJ?=
 =?utf-8?B?akFhUWFIVFVZVXpjK1pjV1NxeVMwa29zTWVyMW5XSjZrakd0dHBoMzZkRFdz?=
 =?utf-8?B?WlVuamM0RzNuMUdvSXZKbTZRMUhHRkNXNDdmMnFzSHhCeUVWdFZCc2daUmZG?=
 =?utf-8?B?ODN4SnFVdFczM2gyaE8zd29lVDB6VDh3SkFRbk5uU1U1Y0FyRkgyNG0ybGNZ?=
 =?utf-8?B?LzFQSGh4VXI2UFFFVUtZTkJVMmNFdGdUNmlSU0VCcmxlTDZ4dkV1cExlTU9h?=
 =?utf-8?B?NUc0UnBXR3NnZSs2cE5namFrRmtQZHBZOXloUXhTWVhQbFJlOTdvZFF4Vk15?=
 =?utf-8?B?NEhWZm8wM1hHek1kampPWFF6a2t3ajFPMkQrSUFyVEdibFlEalF2dmxVQVY1?=
 =?utf-8?B?bXltZjYzVVhOd21qYm1FUHRkNkw2KzRHVGRRdjh0VlhOemZFdGR6Vzl0ZVd5?=
 =?utf-8?B?TGZYb005ZXFxRDUrajZoekVvbUQ2M1RxTE5uR0ljajJ5Yjh5blJQMlZJQlY2?=
 =?utf-8?B?bnlCbThzMG5zYllZVlRWTEdtR1RLL0IreVZhem9VQ09ZUFloRVJxMTZndjAw?=
 =?utf-8?B?a2ppcVVLQ0Mrc3B4V1gycWpjUzU3VC9GaVVlTjU5cS9KNngyNGlRanA2Q1dq?=
 =?utf-8?B?Ykt0R3JtZGlCdWZZb2xtRDZ6SVJCSDJKaTMrREYrb1ZVbUVtbHg5Q2VwTXV3?=
 =?utf-8?B?MnR0Z3FMUytqck12d2hWYTlvNW5DbnVGYXl0Tm9SYXhrVUlnNHNPRnNSbXRj?=
 =?utf-8?B?V0JuUTc4Zk1zYlZjcGdrbCsvazNscFhkM2ZZcmJDbmdjRlJzelRWS252M3RG?=
 =?utf-8?B?QU1zNjFLMlkvMGlVVFd1Tkx1dXNxWjZWTmM5VkRFNGhkbUdibytXUDVCMUVL?=
 =?utf-8?B?VGpNcjJwYkZtYVVIRW1GRmc2LzZxcWdJK2w5RXc0UUJ2cVZWNVhDc2FyQ1B2?=
 =?utf-8?B?RXQyQlpmUlorQS9zQ2VnWFdRMUxJOWtzd1VEYmsxKysxdVN3R1ZCMU9JQ2M0?=
 =?utf-8?B?R2ZqY0llVUJ6dExxNUlzbFlBQXdSbENmNDF2U2IvbUVFR21rRTE4eE51QURy?=
 =?utf-8?B?Y2FjS3FjUGVWUjVTR1hEdllGeXFhdXBPUXk2cU1TRjhxVTZQeHV3czROK2R4?=
 =?utf-8?B?bUNYT1FSUEpQMzlSZktjNjRnRk0zQWxEalJaQm1qMHRkZW9lUGJTYUhOZFVv?=
 =?utf-8?B?VDVRbGI1KzNEWGtyUWtVYzMvS2JZbE41d0YxdkFOYVoxL2d6ZmhsTmR2M3FM?=
 =?utf-8?B?V3YvZmRzeHJJTDk2L0c5L2RwMWg4YnZQZ0kwUXRsbkhsc1lyWGpnb1d6Rllv?=
 =?utf-8?B?UDl3V2o4aXU0cWNjLzhGN2xUWXY3cmNER0RVZlFVNHhFODJ3R3NxbGtpYVJw?=
 =?utf-8?B?L0Z6QStSV1pRcVJ4ZmdVQ2RBd2tQVmxlK1dkYnRMZkJIbjlSV2gzcTQ4bWF2?=
 =?utf-8?B?Qm8yMHZSSlZXK3VhenJ1UG5Gci9SYSt3YXRwTk12K3NMUXlmVjAvVE8yMmRU?=
 =?utf-8?B?Qm8vK0hhTVdWL2d0UDZ4L1JPd2MvUDgyelNVUmJoTmpxNFpzTnNHck9XY0tt?=
 =?utf-8?B?RGNLbnRFeDhtd0NuYVY4NHJxK1ZTdW5xRDdKVDZIU0lBRStOZFE2N21uKzlS?=
 =?utf-8?B?SUkzWGJ5Q0VNZytieE9SS0xTdWV3TUR4dEZpNHo1UFlLUVo0OUVQZThsZnJU?=
 =?utf-8?B?U0VKR1libnVXaE5lYnh5SE8xTkJobTBUM0JNUW5ZUVMvbUwvdEplL1BNMytY?=
 =?utf-8?B?NHlIUmlCU2NWdXFOZERlZ2s1OTd6ZnowaW96aFF0OWc5aisyK3cxMkFWYUVz?=
 =?utf-8?Q?B3OZbKOQZgrINd9m5prnyNrcW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E69EB3F6AA38441BEFD7FC52AA19479@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dfdddf2-2b8d-4ff1-6efe-08da6560d13e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 06:19:32.7985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WIk1Z38zMBcCooIPoUmYPv7xnp4W2xx/6kQMa3r/6n2+0X98mFReXco00jhiMYN+GzQjgTz4aWCWZTBmCnFHk3G5PwvYsKePgQN/7H6JbLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3547
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMvMDcvMjAyMiAyMzoxNCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFdlZCwgSnVsIDEzLCAyMDIyIGF0IDEw
OjQ0IFBNIDxMZXdpcy5IYW5seUBtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4+IE9uIFdlZCwgMjAy
Mi0wNy0xMyBhdCAxMzo1OSArMDIwMCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPj4+IE9uIFdl
ZCwgSnVsIDEzLCAyMDIyIGF0IDE6MDAgUE0gPGxld2lzLmhhbmx5QG1pY3JvY2hpcC5jb20+IHdy
b3RlOg0KPj4+PiArICAgICAgIGlmIChncGlvX2NmZyAmIE1QRlNfR1BJT19FTl9JTikNCj4+Pj4g
KyAgICAgICAgICAgICAgIHJldHVybiAxOw0KPj4+PiArDQo+Pj4+ICsgICAgICAgcmV0dXJuIDA7
DQo+Pj4NCj4+PiBEb24ndCB3ZSBoYXZlIHNwZWNpZmljIGRlZmluaXRpb25zIGZvciB0aGUgZGly
ZWN0aW9ucz8NCj4+IE5vIGRlZmluZXMgaW4gZmlsZS4NCj4gDQo+IFdlIGhhdmUuIFBsZWFzZSwg
Y2hlY2sgYWdhaW4uDQoNCkkgc2FpZCB3aGF0IHRoZXkgd2VyZSBvbiBhbm90aGVyIHJlcGx5IExl
d2lzOg0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvbGF0ZXN0L3NvdXJjZS9pbmNs
dWRlL2xpbnV4L2dwaW8vZHJpdmVyLmgjTDI1DQo=
