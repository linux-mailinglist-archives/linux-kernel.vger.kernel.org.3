Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A483C576E33
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 15:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiGPNfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 09:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiGPNfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 09:35:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441C218B23
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 06:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657978518; x=1689514518;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rVPiLKHkTb1ncNpTpcKOHQiQ3jDYndYwNchARMKBTSY=;
  b=kHu73lNZxW4XslQ5Eux3VM2Y4ZygypNZCcpvDtdCvNkS35eI5oLC+Nzv
   O3iJcEM18mQKGOgveSWTHNI6BVB1IHUXmFWy2e6XS6Tz/yKAjANrrxxD9
   nTeXvhdgx0ZnT1FtXSZ11ial+u+/kBheopNcRWUX2PDeLuu9DMaVT1TWf
   wgddznxedvmKp4e9eSICel1CT/rSVLK2G6inYFIWoapK+4mtLV6U01tpr
   AutHY0h1Oo+/Q3iO9alfhaI5QYqAyAPAln3YvCmrqJv7QhW+Lvw0DkJM4
   yls9+FcGjVphI6WBhZlbS3QkB9RcME1DNJHyihkO6zi2jekRPjBiWX5zY
   w==;
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="165043669"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jul 2022 06:35:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sat, 16 Jul 2022 06:35:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Sat, 16 Jul 2022 06:35:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmWDbl/WNUyYPnBHnQjcA5rhEV+nbMPEI9IaA/pZI1lnFSO7WxFiJ3vJKUnPljJljWpTTsk8DROVdDSKADImykgz7XdR7WLu32WXSEknf0YBSTfso6ibJtXbQbeCxI+BeeMQDnv19UwzEwwIDaCiamdAGdOizx24289QGd9BGOtBFlIlZ8G+jQOmI8NgL3ZS4RE8YvZf5oEsqB859QQAQBn3lzLAEQiUP1tYGOByBzV0XcrFsCOvktVhJEig7zvNmdZZZVkV0/O4ENLNY7YAsjUQ1fhARnPH8UYhdU17QsZW2JyqMrZD9SQJDSZm3zj2Wg9I39o4c9jlVjizUbFvOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVPiLKHkTb1ncNpTpcKOHQiQ3jDYndYwNchARMKBTSY=;
 b=lDZ049D35uWtu8RrXWs/2W5ZbBIC4OlSuROnO2dfZfvIgvcdx+Z20kPf+Rx6rg7wrMyRH9rOzrLfhEp92AIkHBQ/UzNP6pwhRfcP+Plae8vXzhLDuqR9u/TPZLxjEhTnF5kxNvjjmg17kzKZAU1Fb2W/9PYsDoqyHL2nNt0ntam+VS2nN9kIatiHH+NC/vcxmmn6B9WBJO3ki+qXH4MFY36H9x0pv5tbiG8XD6CJGjMQaKBzZguAd5bHxwOcQXt3yfU8co83F8QPrF++oeB1oj5t06rVnIrwaARJFOjIbqFuYkk/EB2jt5k3RtcVTNd40Plwj77nax0vdwef2DCc7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVPiLKHkTb1ncNpTpcKOHQiQ3jDYndYwNchARMKBTSY=;
 b=qQfxATT+q1G2D0QBIJos1jV+v2pokrtGqRq45AyCJt3crGI0d6nSZORSxi0safToTRe8ygqYwiTmO6qaOHNl2dX6C/4zfyQfWH+zttqhtfaRYgnnt1yFfwvah8E5kTWZm4TN+H4+yOmHyp7BuzQa3/6DPdoIqJzi+MeSAPjq85I=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by PH0PR11MB5110.namprd11.prod.outlook.com (2603:10b6:510:3f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Sat, 16 Jul
 2022 13:35:09 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b%7]) with mapi id 15.20.5438.021; Sat, 16 Jul 2022
 13:35:09 +0000
From:   <Conor.Dooley@microchip.com>
To:     <mail@conchuod.ie>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <palmer@rivosinc.com>,
        <aou@eecs.berkeley.edu>, <sudeep.holla@arm.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <Daire.McNamara@microchip.com>, <niklas.cassel@wdc.com>,
        <damien.lemoal@opensource.wdc.com>, <geert@linux-m68k.org>,
        <zong.li@sifive.com>, <kernel@esmil.dk>, <hahnjo@hahnjo.de>,
        <guoren@kernel.org>, <anup@brainfault.org>,
        <atishp@atishpatra.org>, <heiko@sntech.de>,
        <philipp.tomsich@vrull.eu>, <robh@kernel.org>, <maz@kernel.org>,
        <viresh.kumar@linaro.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <Brice.Goglin@inria.fr>
Subject: Re: [PATCH v4 0/2] Fix RISC-V's arch-topology reporting
Thread-Topic: [PATCH v4 0/2] Fix RISC-V's arch-topology reporting
Thread-Index: AQHYmHPj95q5mWrtS0GGLuvs3DXs0a2BANMA
Date:   Sat, 16 Jul 2022 13:35:09 +0000
Message-ID: <b5abb978-75d4-962b-c6de-fd75dc6cc537@microchip.com>
References: <20220715175155.3567243-1-mail@conchuod.ie>
In-Reply-To: <20220715175155.3567243-1-mail@conchuod.ie>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94837e1f-66ec-4aaa-36f5-08da6730007e
x-ms-traffictypediagnostic: PH0PR11MB5110:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: odm8tJyGQqrXd1uL5jgznMzklDWUvlt9kBg/O8EtjMBkybh5CkPuO6y9P2BgZ3u4oNpLnzKZJtrjn37CJ8EYC3wBeamJQ1IVd8HvR091kYUEVn4LJVvucZ/MY4MATjoQaxGy6o9FjlmXOTug7LL/2V9Aoq0YXSl7W33M7GxE3Dj6/0Yvq/IXEKmtvlxI6qTKr+1ETf7nsyIafOVVVnrH2W1i35hujG4FogQxt/1DS/kAXilEuGv4RZkTZ3qtKjJSowk8uOCYjn1I2Pc72tPI+2hRTE6fyG6gaDGLk/uDTmimIgWP6fwMJvr/gkdzNGICEKWMvO+8h/nDEPLP4hDWo7TGFFSF2MZ8GSZbfDstxjL1Y12386rhyA22flyhLY/mAbfJF2FSh1xw8Ua633E6S2U0qUWed4QrbbbZ9ABmh1wODqF0S1eC38R9JmkJYlgG6yTflNgt/0p+Q0jX0OAF0YPWuM0Yo2YVGHX7YKm1eNd6G4Ky/z56mn1be6gYA+SUVOc4hjqgRCNBTE6TtNRWK6OADCFsdzkOfGr5O9KMrxzz6Bru/5LN2P8RzMlyuffh/IQ8xNRk6uI/xE2HkXsGLJKdQx/yOFjU5z7WSJiidRLXp9HVY00F6KdTTpHC/6WGQqsuVPTLNePJEootOc7aqSoKbJL5TKD8zF1k6s6fiBCMAmQXlZjgvqoyFbfHm7Mkn2wrcRI6mekXPZg9el65Vmw3SCFqGLPEXu2UA4qSxL60Dbip+9Lp55uqKAPm5VEWTCd+4XBRgz+g+bIpKA0D52wY/rxbbCzEgDqx+xluI4sIpSQSwmO2oPbFc0p5BpknlEln/DJgtlZelyvVd7JXDv9NSUFJdcDHTcag0j7/8135hk9Rnzmpkomw6bIYGTKSTY6CkN+qIx+S3NMxjF6p8DT0lyjcao+qeqVUQ0hhYXw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39850400004)(376002)(346002)(366004)(396003)(83380400001)(2906002)(66556008)(2616005)(38070700005)(186003)(921005)(36756003)(76116006)(66946007)(66446008)(64756008)(4326008)(8676002)(31686004)(8936002)(7416002)(66476007)(91956017)(26005)(6512007)(5660300002)(478600001)(6506007)(41300700001)(31696002)(53546011)(38100700002)(86362001)(54906003)(71200400001)(316002)(6486002)(966005)(110136005)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHRCd2NLR2d6Y1pDa2NleGd0NnRtNDNXUENDbjlUeW50cWFDdUt5bW1EWXd6?=
 =?utf-8?B?N3dGdXlrOVVtdTBEK09jNE1PY1VvQWVTSjZTc1I2cndsY0w2OGRtZGxYT1Ri?=
 =?utf-8?B?cFNhZ1JxcWhCc2ZSL2FEQk8yaXFBcWlzb3hoRFlHRXBpZzlmdXZlWVo5M1Ey?=
 =?utf-8?B?OXo3MFFoTmxPVkV4TGZZTWVES3NPeERQMjZzbEI5SWU3dGNnd0xpQnMwNnll?=
 =?utf-8?B?NEpOUW5sQy9GcERKQW9XRHl0MGtyQktodzB4Wk8zTmtoaFlaOHpHUUkvZm9T?=
 =?utf-8?B?WVd6ZjN5R0VUOTYrQjExK05GVERMdkFtMHk5bDYvMjhpWnhnUXc5cGt3Rmx4?=
 =?utf-8?B?Y3RXK29JNW1iNHQxNUJJR3dxcDFoRnJrclpuWTEwUndmVVVmTzVOdG5UbG83?=
 =?utf-8?B?YVlDOEpHS0EwKzVUbzZWR3VsblY0azhwY0x6TVJyMWJ0cjJLT3dqM3loUGNX?=
 =?utf-8?B?c1Rqc0EzOTJYQnJtVEEzUzFGUkozckc5SjdlQkpPVlVsYnlVdjVRcGVuUmNx?=
 =?utf-8?B?UXpDa0NZbGVNMHVQSFVXWExpSm96U0kyRytNWjdXMjdxVkZsUFFRRUY5WWRZ?=
 =?utf-8?B?R3RFRVdBWURsNm5KdzBzSlYrQ3Q5UGE5dXJ1TTV3R1pTRlFHZWU2WkxIM1dP?=
 =?utf-8?B?Y2ZVMHNybm1EM0w4SlBMTWQyaWp6TUFkMTJDaWU5NUhEVHBKVjduWUpCRk5q?=
 =?utf-8?B?bEVRSXJkdVp2aXhOK0lTeWduMllrWjZqVklpTmhvRWJTYWtNZENyTTRNU3NU?=
 =?utf-8?B?ODd3MVd4NlIzb3I1Z0NUNjgzT0dVblk4MUl6SXJSbGh0TkpFa3dBR2Qrdlha?=
 =?utf-8?B?WTN0VWdMUWZSVjAzb3gyVDRnakNjRk1PSHdCZTZuc2hHcUlHaFV1Z1hwakhn?=
 =?utf-8?B?Q2pBRnAwb0ZqRjVJYVBjaU9Wa1oyWXBRdzZ3cUhJOFBlM0dsL0VtTm1vZEJK?=
 =?utf-8?B?NnFhS3dnMDBDdHFlUU9zM2RDa1BuR1ZUU3B2RVBreTJVVE8vOTdKck5MNVNV?=
 =?utf-8?B?OUl2RXFyZDVOdjlTY3daTVJQdjJkMk5LZDlpM09PZ1dZeStCSklmSldkWkt4?=
 =?utf-8?B?VU9SN1IyelVQZFc2YWhaNkkzTmY2Z3QyUWVLMHJPRnhSd2Jkazh5Z2pVR2Rx?=
 =?utf-8?B?Wm92OGJPUjM1QVZuZHlsK25uS2ZaL0FFaEU3azFIVTNqUkljWmpxNytTWCt2?=
 =?utf-8?B?UURxMjNZdFNncy82bEtFYWd0Z3oyOHBGL0VYbW9YWkdNTWt1RWEvRGRUVk9x?=
 =?utf-8?B?azFlaVdnTUlpRmpueit4eFJzeWd6a2JlYXlXZHhIOXFiL1IrVUhtK3FHVWhm?=
 =?utf-8?B?V1dIVUlCYW01bEpJNmFZUjNxdlExQVVlcDNWdEtRVGxyYUVqN1lkbFF1Nnhu?=
 =?utf-8?B?TUVJYjJaY3gzUGxQcU1rZ21QcisrQW1ubXFKYnBYQU41N1RrMFhiWFZMR2xw?=
 =?utf-8?B?TDk2dkE2d3NjZ1VkNFRZOGZoYTZ5YVdTcVU1bTZTYVpXWWZIZzRzM1RSS0hy?=
 =?utf-8?B?bXI4dVVpa3lWM3lSelJWSWxPTlFWcW9HUng5emZha0hGNDdQbnZBR0Jkd1E4?=
 =?utf-8?B?aGNZdHk5azVVYm1BeGp3SlFaclVhY0p4MWl6SmNGSmRZQkxoMkdQKzhBNGNZ?=
 =?utf-8?B?dWNwaSsxTFBmSW5qOVRtTVFhRlh1UHJEaUJOZXFaQzRuNkNsL3lhQm55cDZ3?=
 =?utf-8?B?RkYrSjloOXFlRXRBaDZBQ2crSnQrMHF5d0Y5K0pvamptanAwR0VEdW8vUENM?=
 =?utf-8?B?Q09QbHRUckVrMnM3RVRGRWhna0hLdnk4eVhkWXdXdnZibDhZMEhpci9RYjVE?=
 =?utf-8?B?bzljdmx4RGo5eEQrNHJ1TlRTUWpnMXJOM3VkNTJPd0g3UklTM2NkWGM0UE9J?=
 =?utf-8?B?eTlndnF4b09ZLzVDZDR6ZXA5b2FkNmFuRHMzaXlUWk56cWZBd1Rvekd4Mks0?=
 =?utf-8?B?b0pRd25SQ0ErNGdlSitWdHgzTXJyNVBzV3N5Zm9vMzVIV2JrTmpiUkd6dU83?=
 =?utf-8?B?aHhyYUZXeEVpaXl4ZjV4MGtpeTQyWnV5NFJuV3JONFJRdlZQOGlsdVNyOTR0?=
 =?utf-8?B?Y2U3amZLUUkzdmg1Uzgrek1UYWtLOC9vNktZVHNWSHZ2WVJ3d2F5aEx5UUcw?=
 =?utf-8?Q?hcnOgAY+pO+JgxFDDUQP7wGdU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD0F0184D4ECBA44B8B7747306F0B0D4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94837e1f-66ec-4aaa-36f5-08da6730007e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2022 13:35:09.0396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1vMRWOJj3OL7jLBmag3vzpnGRQVj9B3vWICOZDkACpxluCUteOSIjSkUkyAWQj6X/tzgtgHNZg8vAzQPuGLYuDZGPCfX8sTal7R7nz+qkSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5110
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUvMDcvMjAyMiAxODo1MSwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEZyb206IENvbm9yIERvb2xleSA8Y29ub3IuZG9v
bGV5QG1pY3JvY2hpcC5jb20+DQo+IA0KPiBIZXkgYWxsLA0KPiBJdCdzIG15IGZpcnN0IHRpbWUg
bWVzc2luZyBhcm91bmQgd2l0aCBhcmNoLyBjb2RlIGF0IGFsbCwgbGV0IGFsb25lDQo+IG1vcmUg
dGhhbiBvbmUgYXJjaCwgc28gZm9yZ2l2ZSBtZSBpZiBJIGhhdmUgc2NyZXdlZCB1cCBob3cgdG8g
ZG8gYQ0KPiBtaWdyYXRpb24gbGlrZSB0aGlzLg0KPiANCj4gVGhlIGdvYWwgaGVyZSBpcyB0aGUg
Zml4IHRoZSBpbmNvcnJlY3RseSByZXBvcnRlZCBhcmNoIHRvcG9sb2d5IG9uDQo+IFJJU0MtViB3
aGljaCBzZWVtcyB0byBoYXZlIGJlZW4gYnJva2VuIHNpbmNlIGl0IHdhcyBhZGRlZC4NCj4gY3B1
LCBwYWNrYWdlIGFuZCB0aHJlYWQgSURzIGFyZSBhbGwgY3VycmVudGx5IHJlcG9ydGVkIGFzIC0x
LCBzbyB0b29scw0KPiBsaWtlIGxzdG9wbyB0aGluayBzeXN0ZW1zIGhhdmUgbXVsdGlwbGUgdGhy
ZWFkcyBvbiB0aGUgc2FtZSBjb3JlIHdoZW4NCj4gdGhpcyBpcyBub3QgdHJ1ZToNCj4gaHR0cHM6
Ly9naXRodWIuY29tL29wZW4tbXBpL2h3bG9jL2lzc3Vlcy81MzYNCj4gDQo+IGFybTY0J3MgdG9w
b2xvZ3kgY29kZSBiYXNpY2FsbHkgYXBwbGllcyB0byBSSVNDLVYgdG9vLCBzbyBpdCBoYXMgYmVl
bg0KPiBtYWRlIGdlbmVyaWMgYWxvbmcgd2l0aCB0aGUgcmVtb3ZhbCBvZiBNUElEUiByZWxhdGVk
IGNvZGUsIHdoaWNoDQo+IGFwcGVhcnMgdG8gYmUgcmVkdWRhbnQgY29kZSBzaW5jZSAnMzEwMmJj
MGU2YWM3ICgiYXJtNjQ6IHRvcG9sb2d5OiBTdG9wDQo+IHVzaW5nIE1QSURSIGZvciB0b3BvbG9n
eSBpbmZvcm1hdGlvbiIpJyByZXBsYWNlZCB0aGUgY29kZSB0aGF0IGFjdHVhbGx5DQo+IGludGVy
YWN0ZWQgd2l0aCBNUElEUiB3aXRoIGRlZmF1bHQgdmFsdWVzLg0KPiANCj4gSSBvbmx5IGJ1aWx0
IHRlc3RlZCBmb3IgYXJteyw2NH0gLCBzbyBob3BlZnVsbHkgaXQgaXMgbm90IGJyb2tlbiB3aGVu
DQo+IHVzZWQuIFRlc3Rpbmcgb24gYm90aCBhcm02NCAmICFTTVAgUklTQy1WIHdvdWxkIHJlYWxs
eSBiZSBhcHByZWNpYXRlZCENCg0KRldJVywgSSBwdXNoZWQgaXQgdG8gYSBicmFuY2ggZm9yIHRo
ZSBzYWtlIG9mIExLUCB0ZXN0aW5nIGFuZCBhbGwNCmFyY2hzICsgcmFuZGNvbmZpZ3MgYnVpbHQg
ZmluZS4NClRoYW5rcywNCkNvbm9yLg0KDQo+IA0KPiBGb3IgVjIsIEkgZHJvcHBlZCB0aGUgaWRl
YSBvZiBkb2luZyBhIFJJU0MtViBzcGVjaWZpYyBpbXBsZW1lbnRhdGlvbg0KPiBmb2xsb3dlZCBi
eSBhIG1vdmUgdG8gdGhlIGdlbmVyaWMgY29kZSAmIGp1c3Qgd2VudCBmb3IgdGhlIG1vcmUgc3Ry
YWlnaHQNCj4gZm9yd2FyZCBtZXRob2Qgb2YgbW92aW5nIHRvIHRoZSBzaGFyZWQgdmVyc2lvbiBm
aXJzdC4gSSBhbHNvIGRyb3BwZWQgdGhlDQo+IFJGQy4NCj4gDQo+IFYzIG1vdmVzIHN0b3JlX2Nw
dV90b3BvbG9neSgpJ3MgZGVmaW5pdGlvbiBkb3duIGluc2lkZSB0aGUgYXJjaCBjaGVjaw0KPiBh
bG9uZ3NpZGUgdGhlIGluaXQgZnVuY3Rpb24gc28gdGhhdCBib290IG9uIDMyYml0IGFybSBpcyBu
b3QgYnJva2VuLg0KPiANCj4gVjQgaGFzIG1vdmVkIHRoZSBSSVNDLVYgYm9vdCBoYXJ0J3MgY2Fs
bCB0byBzdG9yZV9jcHVfdG9wb2xvZ3koKSBsYXRlcg0KPiBpbnRvIHRoZSBib290IHByb2Nlc3Mg
aXQgaXMgbm93IHJpZ2h0IGJlZm9yZSBTTVAgaXMgYnJvdWdodCB1cCAob3Igbm90DQo+IGluIHRo
ZSBjYXNlIG9mICFTTVApLiBUaGlzIHByZXZlbnRzIGNhbGxpbmcgZGV0ZWN0X2NhY2hlX2F0dHJp
YnV0ZXMoKQ0KPiB3aGlsZSB3ZSBjYW5ub3QgYWxsb2NhdGUgbWVtb3J5Lg0KPiANCj4gVjQgaXMg
YWxzbyByZWJhc2VkIG9uIG5leHQtMjAyMjA3MTUgdG8gZ2V0IFN1ZGVlcCdzIG1vc3QgcmVjZW50
DQo+IGFyY2hfdG9wb2xvZ3kgcGF0Y2hzZXQuDQo+IA0KPiBUaGFua3MsDQo+IENvbm9yDQo+IA0K
PiBDb25vciBEb29sZXkgKDIpOg0KPiAgIGFybTY0OiB0b3BvbG9neTogbW92ZSBzdG9yZV9jcHVf
dG9wb2xvZ3koKSB0byBzaGFyZWQgY29kZQ0KPiAgIHJpc2N2OiB0b3BvbG9neTogZml4IGRlZmF1
bHQgdG9wb2xvZ3kgcmVwb3J0aW5nDQo+IA0KPiAgYXJjaC9hcm02NC9rZXJuZWwvdG9wb2xvZ3ku
YyB8IDQwIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgYXJjaC9yaXNj
di9LY29uZmlnICAgICAgICAgICB8ICAyICstDQo+ICBhcmNoL3Jpc2N2L2tlcm5lbC9zbXBib290
LmMgIHwgIDMgKystDQo+ICBkcml2ZXJzL2Jhc2UvYXJjaF90b3BvbG9neS5jIHwgMTkgKysrKysr
KysrKysrKysrKysNCj4gIDQgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgNDIgZGVs
ZXRpb25zKC0pDQo+IA0KPiANCj4gYmFzZS1jb21taXQ6IDYwMTRjZmE1YmYzMmNmOGM1YzU4YjNj
ZmQ1ZWUwZTE1NDJjOGE4MjUNCj4gLS0NCj4gMi4zNy4xDQo+IA0KDQo=
