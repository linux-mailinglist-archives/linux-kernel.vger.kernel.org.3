Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B655681FF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbiGFIoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbiGFIoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:44:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336B712D20;
        Wed,  6 Jul 2022 01:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657097048; x=1688633048;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=h+df/Gs7FKaq9b9awWINRv1F07cFWC8afjoFkrUEGKE=;
  b=HgUlEPeGLbXuoZ/wq7SLZpK6uWM+6mseNKG2MKp452SQeffxZI8hIEFC
   dErXvNgPqsliuS6c39/c6cKW/zYWha5wfiyrJPhagm3qyYCfNPlF0wHZ0
   s0eCIGLQzJ/evxBfWX+7ZMnbRHYstazMnXQf7REmzjeGH3bAOKPy03oiX
   DwQ6eiojZvOCnGvp70Q/gO3RqTitRzFtjc5pYQ0gLvyGRrmDNwr8djdRM
   tyrre3LAU42HDHLsL6xCLOM9TViyohQZ+5DeBvmP/7Fs6BO/a8I0hrX8w
   dCBKJ3sZGy4KVve8Q/KNcmLFpBteYZzmrlSVZmhp4wRj1mzu4XvtSBkRg
   w==;
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="180948945"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jul 2022 01:44:07 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 6 Jul 2022 01:44:07 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 6 Jul 2022 01:44:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXbiKf6zl3Y9+yJpEmdZBtAfu3CWNftKBAFs9hFH4+RiYc7swUkFL16h+PN9YwmoBt5M/5JBe7YKL9yGknVG3pJEZhxpAfKxz2kgxzcKAc/pubn/eZjvHonSQzmb4wYBveCNMm1kZb7bMVqg37kzyqvvdifFBOiAfH0DUeMZFEvlR2kQk8iBbT1ZmCNdOxKV3Vryjws6nbUF6BXjEfI0qcs6uToaQ2hlcc6RRCtIJw8cNOENPV5DlpXwSpLJALtzjLkAfx5XSBM5fvQjrSl/QUGINiYThxUINrwiwJweeBTD53pKAf/iNFf875ZUKCerMM2wK/E+V3YFCj1WToLkDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+df/Gs7FKaq9b9awWINRv1F07cFWC8afjoFkrUEGKE=;
 b=DRHoQHY2zDyN60NmgeVHbm6J3qebq+dJZlsL8/wdW1B50jvj0j6qL9zwqSbLpCJ6JYmUiBTkY7Eg3BBdnHFOsnx26uaQkL8jlgN7/z9Ml5Gr1ngDMild4BIHEl8gNrfn+IF3N/v4ut4JsvMkrNv0TyFawI6By0TiCOBEFUmD7fN0gZJBuUOhDy2Vu/BWrXt85l+5tmI79Hl/mAyVvGSB6GqjiVzOmm2AYOM/hm9v/lK/UExACoZgbkIA8/xif7hUW5y2uFmurp5xbUh0gt1sj8fiEwDL4WYSH0FHLP/qUWGbkb0FSXzh4LTszt+/JK9G+3YAr0WZX0ux+V2sfILXUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+df/Gs7FKaq9b9awWINRv1F07cFWC8afjoFkrUEGKE=;
 b=BA4AMMJt/vsoolY5+syjYeU9Pignmc1KDLLJzm0RAXA0mCHJxiz1BNQwQM1S6kmwkHat1OoG0nkxiZN47EiePBsMwm+9GI5+4ZucbFD7yC5Ez1KqAER91wen/V6Zsf/SS4HUhik04SQia3ezahs9e4zvS+RPkwSTZilbyLMTXIc=
Received: from CY4PR11MB1960.namprd11.prod.outlook.com (2603:10b6:903:11d::21)
 by SA0PR11MB4541.namprd11.prod.outlook.com (2603:10b6:806:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 6 Jul
 2022 08:44:05 +0000
Received: from CY4PR11MB1960.namprd11.prod.outlook.com
 ([fe80::80c4:1a95:649d:2ee0]) by CY4PR11MB1960.namprd11.prod.outlook.com
 ([fe80::80c4:1a95:649d:2ee0%10]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 08:44:05 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Ryan.Wanner@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Alexandre.Berna@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: at91: sama5d2/trivial: Fixed typo in i2s1 node
Thread-Topic: [PATCH] ARM: dts: at91: sama5d2/trivial: Fixed typo in i2s1 node
Thread-Index: AQHYkRSMBwfveU4Ml0eZhCXP/optKw==
Date:   Wed, 6 Jul 2022 08:44:04 +0000
Message-ID: <9c4740fb-b7f3-c590-9835-a8a2884a2d73@microchip.com>
References: <20220705164250.19636-1-Ryan.Wanner@microchip.com>
In-Reply-To: <20220705164250.19636-1-Ryan.Wanner@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d13bc124-5461-4be1-929d-08da5f2baefa
x-ms-traffictypediagnostic: SA0PR11MB4541:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nJt89popC+jZEEHmKttz2WOgqzdJtVVrkfFLKzVTNP1/W6/Q0/eKwKKeJGBi6so9vmV4r0RpusXsoVreSZ+7LRe87ocnw56HSjqFZGBXMFBjXj/sVPlMR/R9JNGXjEC3vL81nxGa3XVVxatvcuK+1JQGhapcYrGptnPp2LQbQV3M9grxT54gBvhzdgoxjR8q2zyZKDwPimmvf+ux/0bvH0wQR8K5looqAclOMlOQmIQ6kfqRD9nh5nZsPTdKUcBRw0hEOYz8rtDjjmvjtvlVvvUh1AJjyW4tcYGQARWYABEjdMTLcp9fXgZb8hbg3+pRX6XuvKdfsHQSDZbPsGRazJShyLgBgzFGuOXam6cJCyAzaEzkEgqI2Ir7areZUT9siZ31EE6MWrwjgHbjseC8te66qUq4ut/ezVVJ7+2wlmJ9MuRyYbjpPSUyVYe6XXPmfu6LUiXGp6EIARkWgjXEIwPYJspJcc+ZbP6TkfarYzeUkbhqWYfPGZaYN6l4Q1guStVdUXe6LJgKaKJK+cHynxSxjL9oWPdrhAkghEqLqwqBxfjAPIza6g+gfeIdIyEco4phf23m6wu7gGI5Nc7tmAisxJ8B54mS4cohMktYhbuyBU8ZP7Gpqi4C/WHmxW/YE/K8RukklE3c9MqcfzaXJ+50RE2K6K5flXvW11fawYCfvkQPIPHX789uUr3Uv+FtL7PIiwCyLyeh9ixya/1iI9tElxuo/bYYG66EeY4s/JHGx2eY+Kl/eeXTuHRO3B6eJgHprsWRNhuGE2g0pu/ZilYOQew9Jhrmz6fH9IA73NHWeo4GarlCs37u2QJ2Ncaq3PfZvrgsGwPC+M6REMiEcdPDCfWYeI7DPXqxi5QlgjWRVzHgr075apfIJM+nbJqb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1960.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(346002)(376002)(366004)(136003)(8936002)(41300700001)(71200400001)(4744005)(478600001)(31696002)(86362001)(6486002)(5660300002)(2906002)(38100700002)(316002)(91956017)(2616005)(36756003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(186003)(4326008)(8676002)(83380400001)(122000001)(53546011)(6506007)(38070700005)(31686004)(26005)(110136005)(54906003)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnhnUUFMdm04eEEvVWk0VTJkTUJCQjViNkx2NDVQbTBxQ1lxbmJnSnB6UjlT?=
 =?utf-8?B?M2pGd0FSQ05LbmRSTTR2OWx0MDhBbE5oNnRHUkFQakxrU2FMd1VZNnRtaVZY?=
 =?utf-8?B?S01sc3U5dkpDZFF3dXZjTk5EUjJZUTI4V1JLNXJSdEY4MVJ4aXk1MkdSZ3FG?=
 =?utf-8?B?SFlGTVl0YzczQW5Yd1JWYStkRmJCUmM3NVBXWERVbnE1Sk1lazZEdndFRTlY?=
 =?utf-8?B?S0IzQ3ZQZzVjMU1XSVp5QzMrSEVkdjBIaWpXaStkWi83OWxiWmQrVFpxTEFS?=
 =?utf-8?B?dGNFU3V4Tk9sWlc2aWNNb3R0Ujkxbmg5S0ZOSWFMN1dRM0RYT0J1R3diZFFZ?=
 =?utf-8?B?dGNCTmxHSzltaWpITW1LSzFYenFKaEc5Ny81bEYvLzF0S1o0bWdKTTNXakEy?=
 =?utf-8?B?dU1QeWdTbEJmNERVbmdyQnVJZzJIMUJ0a09sM0I2YkNNeThPbHZ1ajFiQ3BF?=
 =?utf-8?B?OHZ6bCtaSUcyM1hMc3d3eFB3OUoySHgzY0w4TTJqdXdjZE1iSzJaNFNMa0dx?=
 =?utf-8?B?eExNUGs3c0J3cVlFQ2UyM1lFUmNNN05abFpvREhaMVg5TmpIeUsxVGFqdUxH?=
 =?utf-8?B?L2lrRGx1c1ZDaXZzMkFZczRZa2UzTWxOQ3JLMEhYVVk0Sm9KU1FqcUtNVnlz?=
 =?utf-8?B?SVpzSGxuUHJKUVRrajQ4aWpNVXJ4Q1lCMFFUV3d4WmxNdWUvMnErU2hsOXVl?=
 =?utf-8?B?WGRWdVcrbndoQ0VtOUd2T0ZadkZTL2wwY283dmZvYk9XdjBMV0t4VG1LV09V?=
 =?utf-8?B?b0F4bnFodHphUWdPRnJHMWc3Mlg3ejkyVjRnZHdrT2NUMG9xQzQwaFFVYm1w?=
 =?utf-8?B?Y3JzbXVFK2lyV1A0TDF6VGk5bmd0WEgxVjBKVFkxUmNHUmVuWkFXWEx6dU96?=
 =?utf-8?B?Nm4wQURTSEJ2cEFFemZDbE92YnpNQnliYi9td3pmZDRqWjIwL3ZlRExoUloy?=
 =?utf-8?B?Wm9ucVRYZlhBVmp1MWc4TnFYZnJqWUVaS2NFSnkwNGtlYy8vd1JNY0hzZFZW?=
 =?utf-8?B?aXNIclpGUW5Nc1ltRXgxTVdGSkhsYyt4ak8vYWcyTzJDemNCbnYzVHY2dkti?=
 =?utf-8?B?U29hTzJKTWxGcmVOam4xWFZvbkVGeVZJWm9ta29BdGJrd3VCMnRhRHM1RFZE?=
 =?utf-8?B?UXFMN2xrQ3JrZnRWUnBPQzYzZThUczBESTZaYUxGVUsvb3YrRFlDMUZGNHZj?=
 =?utf-8?B?WGxMbFZMNGpkR080Q1RTczQwdmUrUU93S3YrdnI2S2pwc3N3ay9jWFhSMGc3?=
 =?utf-8?B?SUpmcVR5bWVibFdiS0c4ZTc5ZWNTODdXeUVjM1ZjQks3eE14UU1UUm1hUTVM?=
 =?utf-8?B?SVNSUFJSOGc0eEZIcDBLdy9mdmhpaUN4RFVyK2JvaUJ2bTMraW5GazhNRFIw?=
 =?utf-8?B?SUpCWDRaVnRIOE5DUlNUckx6c09wcjBuVHVTOHh3eUlmUmxRUlZLYys1b0pk?=
 =?utf-8?B?VGtxVndpRmk5alMwaGlyTVljVzZGc3MvM0JsUXN6T2ZSUGJ2c0RhSFVzd2FO?=
 =?utf-8?B?VVN4ZzNPQjNFQ1U1eWFvWEZFc3EyVkdmNEYwMTFyaW5BaERpNEFJOVlCcGFr?=
 =?utf-8?B?WWNUV1RKN25MZEh5RGxLL0F0cnRyS1ZNMFo4RHdRSlVtd2pHczZnLzZ5a1FZ?=
 =?utf-8?B?WDBhZE5Gd2tqZWo3WC9JZUsxTENUS1hqeVM1VmpKMy9jbm1ydkpZNFB2ajR1?=
 =?utf-8?B?U3p3cjVvMmZITnJRV3BuUm9vcy9lR1dtRmlyR0RRUGpHWnRYT3ljWEkrNVdU?=
 =?utf-8?B?RzJEWGhsVTBCK1VPNzZLVzZ3RFBjMHluTmd3cFEyUjBBdUpiT2dTUEZ6aVlU?=
 =?utf-8?B?ZzZERGEvYllFdVBjT3BEQXBNaEtYblVuVytVQmRaRmVjT2FidHQxVjVwWHBV?=
 =?utf-8?B?SXdGK1AxRmlGYUErakNseGJsSlpOQmpyR2MrVVN2Z2hDOFN3Y0wrVEovdnlB?=
 =?utf-8?B?cGYybkNWUk1vZk4yVXRyZ2hMbmtVRFNjalZQTFY5Ums0bDJsNCtmZjdxVVRE?=
 =?utf-8?B?bXRRZHRZTEJMdzBrZkdnZER2TE5RQ1BkWm1BWmM5a1ZGSHN0Q1U3cFczR1Mw?=
 =?utf-8?B?dnkrbTQ0Q0RqSjF2eHprQ3pNc2tjSzRwS2t5QTI2UzhpRWJONTE3Sll0Q1Uw?=
 =?utf-8?B?VTBTM2EzQlBOenNZMzlUMTRwTElMZ0pYS0hlY3ZneTNEQ0syOHNla0F6dVlx?=
 =?utf-8?B?akE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05E7A1F68339BF4E90C258E0B7346B8E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1960.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13bc124-5461-4be1-929d-08da5f2baefa
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 08:44:04.9731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yXHEZ7wvwtSFoHsqFDMHh94VUt7JnjOfImIu7fr+p0pu7XcdMIjdVZbnFUu0YqCGH3F2FSLzEMtQcep6AOxZjn1bkcw3djrQrjG4T5uGiZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4541
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJ5YW4sDQoNClRoZXJlIGlzIG5vIG5lZWQgZm9yIHRyaXZpYWwgaW4gcGF0Y2ggdGl0bGUu
IEFuZCBhcyBDb25vciBzdWdnZXN0ZWQgcGxlYXNlDQphZGQgdGhlIGZpeGVzIHRhZyBpbiB0aGUg
bmV4dCB2ZXJzaW9uLg0KDQpUaGFuayB5b3UsDQpDbGF1ZGl1IEJlem5lYQ0KDQpPbiAwNS4wNy4y
MDIyIDE5OjQyLCBSeWFuLldhbm5lckBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPiBGcm9tOiBSeWFu
IFdhbm5lciA8Unlhbi5XYW5uZXJAbWljcm9jaGlwLmNvbT4NCj4gDQo+IEZpeGVkIHR5cG8gaW4g
aTJzMSBub2RlIHRvIG1hdGNoIGkyczAgbm9kZQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogUnlhbiBX
YW5uZXIgPFJ5YW4uV2FubmVyQG1pY3JvY2hpcC5jb20+DQo+IC0tLQ0KPiAgYXJjaC9hcm0vYm9v
dC9kdHMvc2FtYTVkMi5kdHNpIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMv
c2FtYTVkMi5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvc2FtYTVkMi5kdHNpDQo+IGluZGV4IDg5
YzcxZDQxOWY4Mi4uNjU5YTE3ZmM3NTVjIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0
cy9zYW1hNWQyLmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvc2FtYTVkMi5kdHNpDQo+
IEBAIC0xMTI0LDcgKzExMjQsNyBAQCBBVDkxX1hETUFDX0RUX1BFUklEKDMzKSk+LA0KPiAgCQkJ
CWNsb2NrcyA9IDwmcG1jIFBNQ19UWVBFX1BFUklQSEVSQUwgNTU+LCA8JnBtYyBQTUNfVFlQRV9H
Q0sgNTU+Ow0KPiAgCQkJCWNsb2NrLW5hbWVzID0gInBjbGsiLCAiZ2NsayI7DQo+ICAJCQkJYXNz
aWduZWQtY2xvY2tzID0gPCZwbWMgUE1DX1RZUEVfQ09SRSBQTUNfSTJTMV9NVVg+Ow0KPiAtCQkJ
CWFzc2lnbmVkLXBhcnJlbnRzID0gPCZwbWMgUE1DX1RZUEVfR0NLIDU1PjsNCj4gKwkJCQlhc3Np
Z25lZC1jbG9jay1wYXJlbnRzID0gPCZwbWMgUE1DX1RZUEVfR0NLIDU1PjsNCj4gIAkJCQlzdGF0
dXMgPSAiZGlzYWJsZWQiOw0KPiAgCQkJfTsNCj4gIA0KDQo=
