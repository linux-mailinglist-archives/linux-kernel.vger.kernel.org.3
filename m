Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1B2547CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 00:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbiFLWR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 18:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237543AbiFLWOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 18:14:39 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBBF4AE01;
        Sun, 12 Jun 2022 15:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655072077; x=1686608077;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=q1a2Gp3AfcCpHdxZSfPtqkMW5H/e9PGqKQXrn/iu7bs=;
  b=OprP8Ika/K4+y/F7Gerp/kx42zN8b3kzn0DpN+BVSAdCIu7ySZChWKf+
   Ifd9KlZWFYVfq2SOnLBWHqn8BzPRK+4f1HwGsgaNdnFdH8Z7PuQztdVN3
   H87ZGcPNfUx09xWrNIbtXxQUgfL79VRvzdpr71gZbyVd+xkFWl/RRAVYi
   fi+GJHbtC7DG2FGdAo6CZUYxLRd5hRvQz0Wd+9AWOqbhG3ujiry+WYnLM
   513TXL2r1Se9pZSagh8/jn38BDxwQzjrpbQg7cqFPSSeKLezl3gZ+0GIt
   og9KL7NG9Wd6wNAzj4cgZONOJEYzLxazbEyqY4tbvrq4r1uY/TB0gCZOL
   A==;
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="159957341"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jun 2022 15:14:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 12 Jun 2022 15:14:34 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Sun, 12 Jun 2022 15:14:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UD8CGBhnw8wLBGO4MAI7S8XAox2n6urdg2lGF9CkwvzanfrhC6ln59U69SMRyvTe5LWQjX4QfD0+2wWkTdDYJ7hd7pEyLSW0kKGURW04HbmOaZd+m9R1UEy3TZ+YeJV7/+XPCZWusJ7MPZ6nAxOZXfnuBwvCACnz98Gis/tw5ZiTH8EhATC4tbL0zw7NI1Mj+RthSooVJlg0mYpSe8bQ2SYao8iic3p6BRaFdzawDtFJA8DQt2eUUV08ykjhk5Mw9JEM5CzvBhKTZGT5S2maaD/tk+m7ye+gbhC4tHtshvUUCvTOQIKKYramE5J18T370NfZ+lxCv8RgcDQjVDb5bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1a2Gp3AfcCpHdxZSfPtqkMW5H/e9PGqKQXrn/iu7bs=;
 b=MXBqDZnP2vcjzExlDWzBf37dzF1XFVN2rdhMQGKhtNbA90fvcaF8xPDrj4wGOGxmlA4epR8jvnbQT9+/1rkfqrCd+sbiTfNGvY5cY5U7tar1KZdhxcybewKdmihYZS3TKzgLpMSlyZ3K6x7bkm1hq/uKGHLJHgeVsH93M3Ba7+jPXzo36pLh4svvWeCZhITnCbke7/pxca6PQYInc6RWT4DSjXGNU3vMEQsIj0hVZcTvYdpJIq2/4ngBvMe3Wy7LaOzKi/cCIvJNgUZ1enRMetQ453QMZwbLXzKEiCPpKI8FUIe2gQso3zlza9maQYuvUmm02c4Mcx32OBKXZq4DLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1a2Gp3AfcCpHdxZSfPtqkMW5H/e9PGqKQXrn/iu7bs=;
 b=R03y3/etDWrD0nPx79JdmoX7W9z+RSXz/zZhs1UhLKwkyRUeLY5DmCeVaHLoLuyz3zUrj81xF3WpTKGnMyuV70GBDp0AdP/9lvFA0bbpeD8kuBXJ0Xizp/YaqO/MO2iSqw/JMjk86Ey9ZQeDWTDMqN2+gjLe2+dW9IYUdcqboyM=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CH2PR11MB4214.namprd11.prod.outlook.com (2603:10b6:610:3c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Sun, 12 Jun
 2022 22:14:29 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5332.020; Sun, 12 Jun 2022
 22:14:28 +0000
From:   <Conor.Dooley@microchip.com>
To:     <ben.dooks@codethink.co.uk>, <b-liu@ti.com>,
        <gregkh@linuxfoundation.org>
CC:     <Daire.McNamara@microchip.com>,
        <Valentina.FernandezAlanis@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 1/3] usb: musb: Add support for PolarFire SoC's musb
 controller
Thread-Topic: [PATCH 1/3] usb: musb: Add support for PolarFire SoC's musb
 controller
Thread-Index: AQHYenIEAC7l7Bmotk+U7PkOyB0OL61EDuMAgAhPyQA=
Date:   Sun, 12 Jun 2022 22:14:28 +0000
Message-ID: <2858581a-59f2-0260-840e-137724f5d666@microchip.com>
References: <20220607132204.746180-1-conor.dooley@microchip.com>
 <20220607132204.746180-2-conor.dooley@microchip.com>
 <f4c2ad78-0b9e-c5da-e0a4-69f836e87b11@codethink.co.uk>
In-Reply-To: <f4c2ad78-0b9e-c5da-e0a4-69f836e87b11@codethink.co.uk>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49286f3f-50cd-4c91-03a6-08da4cc0eb2a
x-ms-traffictypediagnostic: CH2PR11MB4214:EE_
x-microsoft-antispam-prvs: <CH2PR11MB42143170B8F5593656A3CD7898A89@CH2PR11MB4214.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U0vwetxaW1NpSY2ZGySLBdBSA91TIRGFdsuMwWF2vtPG3rgTREOetR3eO1agiOg6xMPKbg21VbNhHrha/jGu2NcQdVLRkLYBa3cSOw23ps8FrYNPCuZGlHWRooqXK0EtaatmnEHP+TLE1q2cfnVcyr6HbzhrHHPiG0RkESz1B+kRskwBsklktxYzYEi6jReXKFG9KJKm68JO0kfv/5qEvrjCNB9/OhDCKFomLamdvKBzDYXoFL5pZIUxBq59kFK11zULqU8TlSquXDJ6VDcxKKxU6CGQQdQnGUbU43VVJOWCSPXV6Yne8m/8vpCsWbrwfX8jbLVScmDTpKaLpnS2P7b4FIh/qgjrMs5k6UZONFrlY4Ryp6KA80Ri3vUeUsQXwP+VUPN9HwsVwVOAPoupnncY1vWGZJgaHZ+D9INDh7FQ9faxypmDApMGFzAiBOmk8smBCKX/pzT31X19Dbe9PNzgmJI5flDm5OUSieBdyIN+KJircqtM5BVNA9zzLEQgBw+nDNUSx9ruYf+P87NYoBivYumS7sOytdWdrJ9MuZGOIooqpP2onevNg2/+pipZmajkFKV7Lg65ni3Kvko8LdBpsBm5F8UcGeWExdtytL+8rMldyW4IVG3Ad/oO7XdhdBn6Ijdv7V1t3ajLsyIEBbbbLiqmqE6VBQo54HTIubvBirztAzWM3wB4uUMWBge+DAq48Q15wYbcImHAsOwJWQaY8zfXqkXlv/YR4hpkTk+adCwIv4sPLhCYXkFZXj28l1mc3W7X20JsuyPApNrqRhw3CX75DZRvyq+PYKXvu4g+YBFMxcDsjXKI8prW6MJ0v7df9W1mq14WDSLOXX9+VYMPQ1DWySYg/UhTLP2NWxU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(83380400001)(186003)(2616005)(38100700002)(122000001)(38070700005)(5660300002)(8936002)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(2906002)(66946007)(966005)(6486002)(508600001)(26005)(6512007)(6506007)(53546011)(316002)(76116006)(91956017)(71200400001)(54906003)(110136005)(31686004)(86362001)(36756003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2ZLeUNkVGpueWcwR3BGK1JnTDhkNkZPcUlVQ0d4VWxZVTZidjdrZTM3K1JR?=
 =?utf-8?B?aDdKOEwraEtsS1BsOHlUTldXbXM2VlBzL1BrZW9QbmhBMTlTUGtYbnVKcmxD?=
 =?utf-8?B?YUJjck9NRC9Lb1lic1AybHo2OE5GUFd6aHhJbWtScDJsZjhSVTVranZhWFJT?=
 =?utf-8?B?cm1RSWVubVhRbGVGaVBzZmI2ODdUVXJ3TW1XTHp3bEpNeG05NlJlNnA4eVJH?=
 =?utf-8?B?MGI2Z2xvbEpPRmhrRzZrQ0xIYkdOc1JMNFJldCtmekxjdjZGOWp2YVByTGZY?=
 =?utf-8?B?eDcrMnhWZFd5c01VVXo1dGhSVDFnRExJa3NEWTBWNk9sUUJjZFEwRUpIVllT?=
 =?utf-8?B?NStmQ2hQRHhpQUdDZ2dyd3d1L3dOcjRJOHF2N2tleDk4NnF1Lzh0SHh2Rnl6?=
 =?utf-8?B?MVhkUUxTdFJQWUlTVHdpZ290S0NMNjdualVjdEFJK2RacW82MEhyNFpKSGJW?=
 =?utf-8?B?eThLMkRQTElFalpPUUMrZUZ2ZityYnNDSE55enpLeDJRQ3lRRExGL1lHVXc5?=
 =?utf-8?B?V1hZN2JYZkxodnNhUkNpalgrQ2RnV1Qyd25NQzU0cDQ0cm9vSGp6MkQ0WlpO?=
 =?utf-8?B?b3N5dUt0OFhOQmVMaDR2T1MyUVlmTEFpang4OEwyMWl6ekNmdS9CQndIeFZO?=
 =?utf-8?B?d1VsVm9OdmxVT29NTGduSnczQ2RVbDRzQ3dDQVpJS0FLZjBubTcrVldkdTI0?=
 =?utf-8?B?aHBNRHlMU01tZHp2STcvSG5lRDdjc2g0ckVJcURCYWhFV1JXbElrVWF6VzlH?=
 =?utf-8?B?UitLRDhqTHpRdGpYWDRONGRHdE5YeW1GSmw2RHl1K0tHMFVZYmtYV05JMjl4?=
 =?utf-8?B?RHcyY1N0ZjM4WDZqK0hwc2ZYNC9JTWFxKzJGV0s0N3hRQnFZV0JkMTFadVhQ?=
 =?utf-8?B?YUEvc2RSTkRwRmp5c3BDK3h0R0s1aWhnRS8wY1RtRk81enptODNtblp5eU9l?=
 =?utf-8?B?UlF1QnQyaVdyS3ljUzlsTGtaa2tlZHhxcVlXY1Jnc2lnQzZOVCthd1hTbnhq?=
 =?utf-8?B?dUUvTmdISUZKaVllU3hJa2V4dU1UdEdYb1M1NWxjaTJzekVsMWQxNFNsb0lx?=
 =?utf-8?B?MEpJYzdvV3BWSUN0aTA4ZklmKzlPcHVaYjZKMytkRkFMckh6Ym10VTFoYzBS?=
 =?utf-8?B?Z2M3WnQ5Tlg1dks5Y2tzS2hvNzh1UCthM0p5V1Y5dEx0ci9lTi9MWEw5NVdI?=
 =?utf-8?B?eU0yZUlVcDJ3NUMraVRNL0lFYzllQ1g3U3pLN29oUkx6ZWFBN3hjSm16TnpB?=
 =?utf-8?B?RG5BR1VYWWFwMktrY1Fmb25oU3dmelZrc1p5amRVNGJ5OC9XWWNWaFBicllS?=
 =?utf-8?B?WEk0T1JaWEMvbFgvZmpZaTdXSU9ydmJBbXdhL2RHNHQzZjBnSjVJMlp2blli?=
 =?utf-8?B?SUs5OEJRUE5sanYyMkU3cWtWVVY1Qzd3VDdxQlBoL050QjVwYjRRL0QxNjNV?=
 =?utf-8?B?QytnQzhyaHRXSEVTMnNZQ29nQ1NUa1FGcDF5V1VyWU55MHRHL3oya0hHN0ph?=
 =?utf-8?B?bWpiZXlXVHRqeWpLNnFOWnpWTmxEblJTZlpCcnBpWkNUclNpQ1FXdTFJYm05?=
 =?utf-8?B?ZFhRTnlVdDBwRnp4MHZCcjZkL3l5dmdqWVQrRllKS0srejJTVG9DbGVJZURi?=
 =?utf-8?B?eWVnOWNPZUdlM251UWJ1YjdBdFdieDhYYlJSQjVpeGFjZVl3RkRybFQ4ck9H?=
 =?utf-8?B?NUxNS1ZPdzdHRnF3ZEdweEtmR1VVUlZHcW9LTUg0cWQzcUp4M2JnM2t4OGtm?=
 =?utf-8?B?UnRtSDIwNVV2WXVCOFhLRHlFU295V2puaDNtYVFUUHFGbDhETUxRVXZiOWlk?=
 =?utf-8?B?a1VKWEZGQWFjWlhycEdDV0o4cFFVTDE0YVlzTWxnYWVKcU1VRG1WOGtkbzJZ?=
 =?utf-8?B?UW93M2NKVCtqS2RVc1psQnhkNmtWSmI5R0JkMWZ5ZmFrRTVCRzJIRmplazdq?=
 =?utf-8?B?OW4wdXRCNmRhbzRtd3N6SmNoemxYVUp4RjdMQzczMGZpSWhkYVp1T2xkeHkx?=
 =?utf-8?B?Rk9KSytBb3RaZGdIT2ZmV1F4NFJsd3pTV202YWxZRThJcG9Gd2tKN0ExY1dO?=
 =?utf-8?B?T1hBWHhTTnpLU1hYZ3FDSmRWRTFycmZCdDdPRFkrd0FhbjVvUlpoNjdaeEZI?=
 =?utf-8?B?VmZwamV0bGpyT3FDQlVvZXFlUDlyeXNjL2ZFaXBGZ0tJemsxaVBjazhEZFUv?=
 =?utf-8?B?Z1NMUkVVTmk3aGR4RDlvWmxNYlFIcDNQdzVFbm9BbFMwSmFCcit3bmNKU001?=
 =?utf-8?B?SVdJNkFGWWc4NDdPNjExRzJXVGVzaUtLM0E5RDVZY0c1WlBhMkhjbnE4NUVT?=
 =?utf-8?B?ODc2SFpKRzdoNzBwRXdVdDdBNDJqRWpzT0xCa0w1RjlYMzFRZWFEYUtCRzNI?=
 =?utf-8?Q?qomEGPiq7IKLWiA8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F035E83783D1E47B726705819DFFF7F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49286f3f-50cd-4c91-03a6-08da4cc0eb2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2022 22:14:28.8865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rLv7zYxl4AjLTNXoep8hbhQG8x4Q8ECNo5wY9MVa9TP8BG8xSxLw/z5Fq4DFP4BVWZig6ItHGj4TxUm9/Z1LhkRPIl+GUGOaZn3Ujplkixg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4214
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcvMDYvMjAyMiAxNjoxOCwgQmVuIERvb2tzIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDA3LzA2LzIwMjIgMTQ6MjIsIENvbm9yIERvb2xl
eSB3cm90ZToNCj4+IEFkZCBzdXBwb3J0IGZvciBNaWNyb2NoaXBzJ3MgUG9sYXJGaXJlIFNvQydz
IG11c2IgY29udHJvbGxlciBpbiBob3N0LA0KPj4gcGVyaXBoZXJhbCBhbmQgb3RnIG1vZGUuDQo+
Pg0KPj4gVGVzdGVkLWJ5OiBWYWxlbnRpbmEgRmVybmFuZGV6IDx2YWxlbnRpbmEuZmVybmFuZGV6
YWxhbmlzQG1pY3JvY2hpcC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDb25vciBEb29sZXkgPGNv
bm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiDCoCBkcml2ZXJzL3VzYi9tdXNi
L0tjb25maWfCoCB8wqAgMTMgKy0NCj4+IMKgIGRyaXZlcnMvdXNiL211c2IvTWFrZWZpbGUgfMKg
wqAgMSArDQo+PiDCoCBkcml2ZXJzL3VzYi9tdXNiL21wZnMuY8KgwqAgfCAyODUgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+IMKgIDMgZmlsZXMgY2hhbmdlZCwgMjk4
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+IMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL3VzYi9tdXNiL21wZnMuYw0KPj4NCi0tLTg8LS0tDQo+PiArDQo+PiArwqDCoMKgwqAg
cGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgZ2x1ZSk7DQo+PiArDQo+PiArwqDCoMKgwqAgbWVt
c2V0KG11c2JfcmVzb3VyY2VzLCAweDAwLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6
ZW9mKCptdXNiX3Jlc291cmNlcykgKiBBUlJBWV9TSVpFKG11c2JfcmVzb3VyY2VzKSk7DQo+PiAr
DQo+PiArwqDCoMKgwqAgbXVzYl9yZXNvdXJjZXNbMF0ubmFtZcKgID0gcGRldi0+cmVzb3VyY2Vb
MF0ubmFtZTsNCj4+ICvCoMKgwqDCoCBtdXNiX3Jlc291cmNlc1swXS5zdGFydCA9IHBkZXYtPnJl
c291cmNlWzBdLnN0YXJ0Ow0KPj4gK8KgwqDCoMKgIG11c2JfcmVzb3VyY2VzWzBdLmVuZMKgwqAg
PSBwZGV2LT5yZXNvdXJjZVswXS5lbmQ7DQo+PiArwqDCoMKgwqAgbXVzYl9yZXNvdXJjZXNbMF0u
ZmxhZ3MgPSBwZGV2LT5yZXNvdXJjZVswXS5mbGFnczsNCj4+ICsNCj4+ICvCoMKgwqDCoCBtdXNi
X3Jlc291cmNlc1sxXS5uYW1lwqAgPSBwZGV2LT5yZXNvdXJjZVsxXS5uYW1lOw0KPj4gK8KgwqDC
oMKgIG11c2JfcmVzb3VyY2VzWzFdLnN0YXJ0ID0gcGRldi0+cmVzb3VyY2VbMV0uc3RhcnQ7DQo+
PiArwqDCoMKgwqAgbXVzYl9yZXNvdXJjZXNbMV0uZW5kwqDCoCA9IHBkZXYtPnJlc291cmNlWzFd
LmVuZDsNCj4+ICvCoMKgwqDCoCBtdXNiX3Jlc291cmNlc1sxXS5mbGFncyA9IHBkZXYtPnJlc291
cmNlWzFdLmZsYWdzOw0KPj4gKw0KPj4gK8KgwqDCoMKgIG11c2JfcmVzb3VyY2VzWzJdLm5hbWXC
oCA9IHBkZXYtPnJlc291cmNlWzJdLm5hbWU7DQo+PiArwqDCoMKgwqAgbXVzYl9yZXNvdXJjZXNb
Ml0uc3RhcnQgPSBwZGV2LT5yZXNvdXJjZVsyXS5zdGFydDsNCj4+ICvCoMKgwqDCoCBtdXNiX3Jl
c291cmNlc1syXS5lbmTCoMKgID0gcGRldi0+cmVzb3VyY2VbMl0uZW5kOw0KPj4gK8KgwqDCoMKg
IG11c2JfcmVzb3VyY2VzWzJdLmZsYWdzID0gcGRldi0+cmVzb3VyY2VbMl0uZmxhZ3M7DQo+IA0K
PiBJIHdvbmRlciBpZiB5b3UgY291bGQgbWVtY3B5IG9yIGp1c3QgdXNlIGNvbXBpbGVyIGFzc2ln
bm1lbnQgZm9yDQo+IHRoZXNlPw0KPiANCg0KTG9va3MgbGlrZSBzaW5jZSB3ZSB3cm90ZSB0aGUg
ZHJpdmVyLCBSb2IncyBjaGFuZ2VkIGFsbCB0aGUgb3RoZXJzDQp0byBkbyB0aGlzIG1vcmUgbmlj
ZWx5Og0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy90b3J2YWxkcy9jLzk4NzljODFiNjgwNw0KDQo+
PiArDQo+PiArwqDCoMKgwqAgcmV0ID0gcGxhdGZvcm1fZGV2aWNlX2FkZF9yZXNvdXJjZXMobXVz
Yl9wZGV2LCBtdXNiX3Jlc291cmNlcywNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBBUlJB
WV9TSVpFKG11c2JfcmVzb3VyY2VzKSk7DQo+PiArwqDCoMKgwqAgaWYgKHJldCkgew0KPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfZXJyKGRldiwgImZhaWxlZCB0byBhZGQgcmVzb3Vy
Y2VzXG4iKTsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJfY2xrX2Rpc2Fi
bGU7DQo+PiArwqDCoMKgwqAgfQ0KPj4gKw0KPj4gK8KgwqDCoMKgIHJldCA9IHBsYXRmb3JtX2Rl
dmljZV9hZGRfZGF0YShtdXNiX3BkZXYsIHBkYXRhLCBzaXplb2YoKnBkYXRhKSk7DQo+PiArwqDC
oMKgwqAgaWYgKHJldCkgew0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfZXJyKGRl
diwgImZhaWxlZCB0byBhZGQgcGxhdGZvcm1fZGF0YVxuIik7DQo+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGdvdG8gZXJyX2Nsa19kaXNhYmxlOw0KPj4gK8KgwqDCoMKgIH0NCj4+ICsNCj4+
ICvCoMKgwqDCoCByZXQgPSBwbGF0Zm9ybV9kZXZpY2VfYWRkKG11c2JfcGRldik7DQo+PiArwqDC
oMKgwqAgaWYgKHJldCkgew0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfZXJyKGRl
diwgImZhaWxlZCB0byByZWdpc3RlciBtdXNiIGRldmljZVxuIik7DQo+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGdvdG8gZXJyX2Nsa19kaXNhYmxlOw0KPj4gK8KgwqDCoMKgIH0NCj4+ICsN
Cj4+ICvCoMKgwqDCoCBkZXZfaW5mbygmcGRldi0+ZGV2LCAiUmVnaXN0ZXJlZCBNUEZTIE1VU0Ig
ZHJpdmVyXG4iKTsNCj4+ICvCoMKgwqDCoCByZXR1cm4gMDsNCj4+ICsNCj4+ICtlcnJfY2xrX2Rp
c2FibGU6DQo+PiArwqDCoMKgwqAgY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGNsayk7DQo+PiArDQo+
PiArZXJyX3BoeV9yZWxlYXNlOg0KPj4gK8KgwqDCoMKgIHVzYl9waHlfZ2VuZXJpY191bnJlZ2lz
dGVyKGdsdWUtPnBoeSk7DQo+PiArwqDCoMKgwqAgcGxhdGZvcm1fZGV2aWNlX3B1dChtdXNiX3Bk
ZXYpOw0KPj4gK8KgwqDCoMKgIHJldHVybiByZXQ7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBp
bnQgbXBmc19yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+ICt7DQo+PiAr
wqDCoMKgwqAgc3RydWN0IG1wZnNfZ2x1ZSAqZ2x1ZSA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBk
ZXYpOw0KPj4gKw0KPj4gK8KgwqDCoMKgIHBsYXRmb3JtX2RldmljZV91bnJlZ2lzdGVyKGdsdWUt
Pm11c2IpOw0KPj4gK8KgwqDCoMKgIHVzYl9waHlfZ2VuZXJpY191bnJlZ2lzdGVyKHBkZXYpOw0K
Pj4gKw0KPj4gK8KgwqDCoMKgIHJldHVybiAwOw0KPj4gK30NCj4+ICsNCj4+ICsjaWZkZWYgQ09O
RklHX09GDQo+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXBmc19pZF90YWJs
ZVtdID0gew0KPj4gK8KgwqDCoMKgIHsgLmNvbXBhdGlibGUgPSAibWljcm9jaGlwLG1wZnMtbXVz
YiIgfSwNCj4+ICvCoMKgwqDCoCB7IH0NCj4+ICt9Ow0KPj4gK01PRFVMRV9ERVZJQ0VfVEFCTEUo
b2YsIG1wZnNfaWRfdGFibGUpOw0KPj4gKyNlbmRpZg0KPj4gKw0KPj4gK3N0YXRpYyBzdHJ1Y3Qg
cGxhdGZvcm1fZHJpdmVyIG1wZnNfbXVzYl9kcml2ZXIgPSB7DQo+PiArwqDCoMKgwqAgLnByb2Jl
ID0gbXBmc19wcm9iZSwNCj4+ICvCoMKgwqDCoCAucmVtb3ZlID0gbXBmc19yZW1vdmUsDQo+PiAr
wqDCoMKgwqAgLmRyaXZlciA9IHsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLm5hbWUg
PSAibXBmcy1tdXNiIiwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLm9mX21hdGNoX3Rh
YmxlID0gb2ZfbWF0Y2hfcHRyKG1wZnNfaWRfdGFibGUpDQo+PiArwqDCoMKgwqAgfSwNCj4+ICt9
Ow0KPj4gKw0KPj4gK21vZHVsZV9wbGF0Zm9ybV9kcml2ZXIobXBmc19tdXNiX2RyaXZlcik7DQo+
PiArDQo+PiArTU9EVUxFX0RFU0NSSVBUSU9OKCJQb2xhckZpcmUgU29DIE1VU0IgR2x1ZSBMYXll
ciIpOw0KPj4gK01PRFVMRV9MSUNFTlNFKCJHUEwiKTsNCj4gDQo+IA0KPiAtLSANCj4gQmVuIERv
b2tzwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGh0dHA6Ly93d3cuY29kZXRoaW5rLmNvLnVrLw0KPiBTZW5pb3IgRW5naW5lZXLCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQ29kZXRoaW5rIC0g
UHJvdmlkaW5nIEdlbml1cw0KPiANCj4gaHR0cHM6Ly93d3cuY29kZXRoaW5rLmNvLnVrL3ByaXZh
Y3kuaHRtbA0KDQo=
