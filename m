Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3C24C0D6E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238707AbiBWHmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbiBWHmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:42:06 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C1D2DAA2;
        Tue, 22 Feb 2022 23:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645602095; x=1677138095;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=r70NBIG9KHueUVtk7xgfVuNM7I0zn2eTmRvYH5PZCqs=;
  b=SHTrWuEiwzM5LDY02BMkLbO/Txuni91IQpY9cIDSXfGG8BFTlSsHFRvv
   0+FcY98s76KJ1dTGrYOGw3ooDzmozRPJk8FgA6Spf3k3DFTSeE27Gsq6Q
   VIend1E6kSvFb3QsPx1RBfUlC2XbL1IfX6cIiqDnrHFRrMYtJLROZG9ps
   f4tW4lQpyTGfsH/p2GAqS0l4sDARDD0ykHnbbOvH8e7TT+vojhLTMxPk7
   aOpjuO9GY29HutMUgWQQCmKAgKgNL7kOnLlLoqrzcU9OjBJFtGbrktXw3
   GiHquJi+0V0nGaLew/yOIvQNIbcjMROjuLst98I1wIKVWx09Vxx+YFnLx
   A==;
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="154555208"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Feb 2022 00:41:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 23 Feb 2022 00:41:33 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 23 Feb 2022 00:41:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtJVfGsLk/KEQuRj8iVv3e09aS5p5nTY2Cv5VNSuE52fQpMfM6WzkJL0lNDsejoxIU+gBjEbWtskdSnMaddrueT7KynH81kdQXfIlX3XvJrboz/FKN0dfVCVpgkDZy18b+WMR11zrD8Yo+jGwvAYXDquaOLBYqx8yxtds7S091tfNFKw7An94fEox+xhjc3/8yIzo/wgtJo8Y9THdmLQyoQY3pNv53v282mUMc3cSorJZXUfd7xDi3EAauknREPvGFzR1nBCyc+b2uZ16rhb8t0V1QPfa4DFpqRHZGAAsY3k74kEPrNh7jKS1/67CkflS+yZd4jLnKELvJJ35nN1HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r70NBIG9KHueUVtk7xgfVuNM7I0zn2eTmRvYH5PZCqs=;
 b=JGU4QgznyiQ7V92kSs33GliVaMensrsB/oCsmc5dviAjGgRYnGjyOJB5i1awHfx4YQg3CpKC+jj+5I+akCo00P0Lc0QCfIQasMq10Gv34R/dCJklO1lGjvYe6Z7yYIEZZupduRFQp1uPGdwMSbSZXcUWewQKkd0VEPLNjfLW288/1F0C/AZtuu/eewYhEy4q0SZscqocKMf9eOA4gB7vW0le7v9fQjvmd0zF0IyKTdnci77XonAyZ+eanPiAz+gkxK4+IYVyoPxNmARXO5I0H4NLZDI3PCogztae5vMQzARDfUYQhnwGWDp5CIzYRfGpxIF62BmeYQ8conQH+NneqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r70NBIG9KHueUVtk7xgfVuNM7I0zn2eTmRvYH5PZCqs=;
 b=T6BK5NpPOsJoqvoiv4wNQa2PxYDxoupdx8XlF6wBXc0NdVALS4OnVXtWU/5cSFQzywRZQAj6z5rqxwbfGBghAHFmSsTFk/TcjZ0bLKKcTretNAiZWAizBVGfihDMMRk5+WRxN6mu8h19+0yn3SkQjdIBvEbLIXScdj5u17Au5Rc=
Received: from PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8)
 by SN6PR11MB3278.namprd11.prod.outlook.com (2603:10b6:805:ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Wed, 23 Feb
 2022 07:41:27 +0000
Received: from PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::d46c:fea3:ae31:aec]) by PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::d46c:fea3:ae31:aec%4]) with mapi id 15.20.4995.016; Wed, 23 Feb 2022
 07:41:27 +0000
From:   <Conor.Dooley@microchip.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC:     <Lewis.Hanly@microchip.com>, <Daire.McNamara@microchip.com>,
        <Ivan.Griffin@microchip.com>, <atishp@rivosinc.com>,
        <palmer@rivosinc.com>, <robh@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <robh+dt@kernel.org>,
        <jassisinghbrar@gmail.com>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <lee.jones@linaro.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <geert@linux-m68k.org>,
        <krzysztof.kozlowski@canonical.com>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v7 03/11] dt-bindings: rtc: add bindings for microchip
 mpfs rtc
Thread-Topic: [PATCH v7 03/11] dt-bindings: rtc: add bindings for microchip
 mpfs rtc
Thread-Index: AQHYIaqttStvU5ae7EKFzk9c8SSw/KygzymA
Date:   Wed, 23 Feb 2022 07:41:27 +0000
Message-ID: <5b0681a0-ff46-7eb4-3644-0d1173c1f0d4@microchip.com>
References: <20220214135840.168236-1-conor.dooley@microchip.com>
 <20220214135840.168236-4-conor.dooley@microchip.com>
In-Reply-To: <20220214135840.168236-4-conor.dooley@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34229e3d-7b2e-4cae-30c9-08d9f69fe661
x-ms-traffictypediagnostic: SN6PR11MB3278:EE_
x-microsoft-antispam-prvs: <SN6PR11MB327869C900577C9E864D94F7983C9@SN6PR11MB3278.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mI/KB1OoXJ0a0pGGzterbUFbVs0TDrVBVYAvnqGix/jKnLw/uz+qpbaqUgus+BzaEgaAkXxU7OGbsIgMRCXHtDAVXqEdIlQfZMV/wxHNXUddnVuCIK4Q1BCODRIpi4OQ0BroK7n4uFFm+a+RGbACTYP4Vb0bpZCfoiRVTqyVWZBAgaPYJjqpZtCQ6v3trem7uUlkPH0/KLwA8fB0czVGh5cm/Au5yftaKIEr41dE6EZOdjr/YzpwS5H8bioeJZAbXHc1FPkEqLatl8IBKTSUtHmage8mYJDU1PGKX6jhm0Co1/5ycu5SjLqcJWiB8UMfmyC67mxskGcx96CJ7mBM/E4H+za4vDlxcYC9LHnYEuHPOEklTrKp3o1tD2IvxAC4oC4p9Z9wD9zOAVHUJzYjRCutFeWtnjTrMbTflDjOrv7XDjGiQH3GjQyC4cDfk0c7CPsYS87nEp31PZ6opquPpz3Sb9KEdE9Y9E9mwxgJL3vDAKvYhVfSWWCr0HGPlHniQDrwe3YeMs4xKoRxYU7BVygpS2i3a33mSBw0++Ro6YI19faQNFajQ+5hfPvioY5mfQLpoOPUP1cxLn9/Q4PJMbeUEFX9Jn+1VbCQ5kTqTQhSCK/28mFhZQTwF/pfHR2FsOCaGsv9kz8lIieQdIW1mer4k3MjCb6h1lLGmi9ADyMUoqsXwCtKIHoAmHnWC7WPHd1RQwtljp92PzGDJJyb+MLKcn1/+RXdcKgWfpIL5sqvo6Af4JyQ2rmj7hoaGrPzu1FfFganQDOJUyBKMupbEfzxc6ubU4ivXNzeQTr59VolBrlXTOsqzuIfbZ0UD96UqzBxX7wVRiSFhJBfN0kOirbFQWTaWknnCZ0xdMET73uKD6lFAiZOkfo7c/nzYQjrpkXty7k85mvY8X1V+44eDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5160.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(36756003)(71200400001)(122000001)(54906003)(316002)(38100700002)(110136005)(31696002)(6506007)(6512007)(86362001)(91956017)(66556008)(2906002)(508600001)(66946007)(66476007)(83380400001)(8676002)(4326008)(64756008)(966005)(6486002)(8936002)(5660300002)(38070700005)(26005)(186003)(7416002)(53546011)(76116006)(2616005)(66446008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDNmdmc5WlVlNFFBVlNVUGxERGhheHFSTE5qRnZkWEN5WUJCQmQ1aEVqZ1Fm?=
 =?utf-8?B?MXNVY3g0NSttc3ZVUU1Bek1wRk5WOUN6TXo1RmEvZGVELytXSXJMZnB3T3Az?=
 =?utf-8?B?NHU0RktCNUxpWW1IckhEY2VkL0xOUEMvbjlPdVNZNEpXTTRWY1k3Vlc0UlVX?=
 =?utf-8?B?ZXdJdkhMdkx5RDJUS1ZTakdSS3MrcC93L2d5bjJQQTdwSGN5KzRVaTl3MW9y?=
 =?utf-8?B?UDM5Q3FGbTNyZnJHTjNQYmY2R2ZIYTR1V2w0cUczclA4Y25DeUF6OFp5ZWFX?=
 =?utf-8?B?U1lkdmRJMEdqdmNNeDFpUUR0Unh4bmNUeCtseHhnU05kM1pWcTRwQzBIUkU1?=
 =?utf-8?B?ZXhOS0h1TmkxUzhucmV2bVNBTUdWZ040c0dCQ2JEazV2US9BYzZZM0k4L2pi?=
 =?utf-8?B?MkQvekpzV05TdXYyV3FkNG5yOXVJdWFqcEFrZHcvWGszdDdjUWdwOXZta1E1?=
 =?utf-8?B?OXdwcnc5SEIxcGQzeTRSbFJtQmdTS2UxRmpzQW5hTDEzT2taNzh1NlB5UEds?=
 =?utf-8?B?aDZyNVh1VXpkVklLUm0raUZOMUJyM1BmQ3RUVkVoQlo0Mldjcnh2endlc0E2?=
 =?utf-8?B?azUzTzFybFRnaWtRQ3NjZHB1ZEZBTGgzUkV4NzhnVGxTYTlvMUh4ZWo0My9K?=
 =?utf-8?B?bndRanVsN0NyZHBYTFFtRkFZUWlWWWdKVlFyazV5M2NMOXNDSkhNbWpPVURJ?=
 =?utf-8?B?UkxqOVdUanRZOE9HdVExWnd2bW9CeU9vcFVndldVZlJpSzZiR08xZlA5QVpy?=
 =?utf-8?B?Ym05dnZleGpxSCtCOWdzTlVVcUY2QzRQdldqSWVWN2lvblFUMW51b0dmV0dD?=
 =?utf-8?B?VUNCNWNwTFF1eWVnaHlIU0Y5ZE5aQmZzNml6VUhSU2c2MnY2dXViT0tqWUcv?=
 =?utf-8?B?TGZCOUpyNHhrdkUxbzRLcmxWY2xaQzZFaXJVL0VzTFh4YjRKOHJEdVVxdGpN?=
 =?utf-8?B?YnlEWU9RMnBaaFQxMU5CL3crcG1lRy93Z3czWjhSQkZEYWsyYzlCS1FoK2NM?=
 =?utf-8?B?ZUhJUmlWdU1aZ2xjUGF0clMxdHNrOCtMQnk3aWRDemh5RitvZThveXVPODMr?=
 =?utf-8?B?SlF4eHdPUnNMUXdBem52NFNad2VrTjFzSkV0bnlpckZ1bEJ6Z0N4d0p6UzVE?=
 =?utf-8?B?WVZzUHozRXlub3JKSGZLMUJyZ3JhNFZmTjB3YUlOajlaSG0wOGRqd3l2YjVX?=
 =?utf-8?B?cXNyUGR3VzFOSGtCR3M5NWlmMHRPZXE4QjRqZ04wNUtGb1c1UWVuN2hBTlFW?=
 =?utf-8?B?Sk5Ebkhhak5hNThjcHU3K2hiSnFwMDV5cXpRVk5rRy81VlVHTjNlckJXUTN5?=
 =?utf-8?B?aEsrN0lPMzl4L0E1L1Q3K2UwWTlpUzlKcDZESnk0YkUyUC9UUHdpdk40RENR?=
 =?utf-8?B?SFhpNmhLVFFQVDFrYnpiTWhHOHgzV0N5Mkd4RllmeGRPR0l4YjZvZnpScXkx?=
 =?utf-8?B?N0NoU3E4dVNaVTlkT2lEWCtoSExqdTB1MXB6NHJPWGxOaFBJWUhnTkF0eW1k?=
 =?utf-8?B?d1Y3Y0Ywb3NEejdIeWFmZmlGQThkZGNuclVEeE04b01LTWx4a1EzeVc0VHZh?=
 =?utf-8?B?eHhiY21MZEhaZWpUWmxkOFFBSU1ZTGxVby9iUWVESnIxR1cvOUJmN3BMQlAx?=
 =?utf-8?B?WTF4dHNHN2pRVlBZeGlSSEh3Z2NHUWNlR1dRZ1Vlc0pnZEthRnNvWC95bTVm?=
 =?utf-8?B?K0NCZ3RPeG1kczlXckQ1QTRDNUVPL0hOUzZVVEdTdDZRVFJKRUJYYjArcStj?=
 =?utf-8?B?VkNWNUh6TWVqL09Va09EOExmeFp6RGwxZHV3RjM5eGZqSk9tZlFFYkJzWGZ1?=
 =?utf-8?B?Z1kvMkovdFY1MTFPZU1VUHFLNHhUNkhsRkVMR1EvWDJFaENSSVY1a0RxQWVz?=
 =?utf-8?B?YmFPQ1kya2tPMWhITTZFMzdsWitXRUFyNGUyRjQxamdKek95blJCMUF0bzRB?=
 =?utf-8?B?M2JsajRyNy9MbDV4MUlmRXNPc2tMZVFGalRaR0Jka21MQVdvcklJcFlFQUtV?=
 =?utf-8?B?bnR5aHNNU2ZCakYzR3gyRk1ISXRzMGJwKzBRdmJPc0pZdVpnOGRjREZEMm1U?=
 =?utf-8?B?SDJOb2dpRkI3eWZObWYrYTlHblA4WVRSTE41WW1HQkd6ajBDMkFIcVdRQ3hu?=
 =?utf-8?B?RzFFOWFlVE5rdktqOFlac1VsS1FVQW16WU1oTWtMaXcxNUEzTXR3S05iT3JL?=
 =?utf-8?B?VUlmMnlUeTFISHc1b1RjdHJFV25jWmJCMEU1Y3ZzSnNqeFNuUkpOd3M1djZL?=
 =?utf-8?B?OXh6Umc2S0NEMFR2R0dBaGRHWU13PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CE277C3C3DABA4EB1F3B8D0ED926F6E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5160.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34229e3d-7b2e-4cae-30c9-08d9f69fe661
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 07:41:27.4216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gJ0W5EZxdGZXO5uNjwjwt9lQMYcDCtPUl0iNhWWFEyUsQ2o+OOa/1Wzjy0/c1lEOvgoFPS7MqR3fx0Q37SL//JxIQ8CINZFD9dORuM/kgq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3278
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxlc3NhbmRybywgQWxleGFuZHJlLA0KSWYgb25lIG9mIHlvdSBjb3VsZCB0YWtlIGEgbG9v
ayBhdCB0aGlzLCB0aGF0J2QgYmUgZ3JlYXQuDQpUaGFua3MsDQpDb25vci4NCg0KT24gMTQvMDIv
MjAyMiAxMzo1OCwgY29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+IEZyb206IENv
bm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+IA0KPiBBZGQgZGV2aWNl
IHRyZWUgYmluZGluZ3MgZm9yIHRoZSByZWFsIHRpbWUgY2xvY2sgb24NCj4gdGhlIE1pY3JvY2hp
cCBQb2xhckZpcmUgU29DLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGFpcmUgTWNOYW1hcmEgPGRh
aXJlLm1jbmFtYXJhQG1pY3JvY2hpcC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IENvbm9yIERvb2xl
eSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+IEFja2VkLWJ5OiBQYWxtZXIgRGFiYmVs
dCA8cGFsbWVyQHJpdm9zaW5jLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2Jo
QGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiAgIC4uLi9iaW5kaW5ncy9ydGMvbWljcm9jaGlwLG1mcHMt
cnRjLnlhbWwgICAgICB8IDU4ICsrKysrKysrKysrKysrKysrKysNCj4gICAxIGZpbGUgY2hhbmdl
ZCwgNTggaW5zZXJ0aW9ucygrKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvcnRjL21pY3JvY2hpcCxtZnBzLXJ0Yy55YW1sDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3J0Yy9taWNyb2No
aXAsbWZwcy1ydGMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ydGMv
bWljcm9jaGlwLG1mcHMtcnRjLnlhbWwNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXgg
MDAwMDAwMDAwMDAwLi5hMmU5ODRlYTM1NTMNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcnRjL21pY3JvY2hpcCxtZnBzLXJ0Yy55YW1s
DQo+IEBAIC0wLDAgKzEsNTggQEANCj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwt
Mi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPiArJVlBTUwgMS4yDQo+ICstLS0NCj4gKyRpZDog
aHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvcnRjL21pY3JvY2hpcCxtZnBzLXJ0Yy55YW1s
Iw0KPiArDQo+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2Nv
cmUueWFtbCMNCj4gKw0KPiArdGl0bGU6IE1pY3JvY2hpcCBQb2xhckZpcmUgU29jIChNUEZTKSBS
VEMgRGV2aWNlIFRyZWUgQmluZGluZ3MNCj4gKw0KPiArYWxsT2Y6DQo+ICsgIC0gJHJlZjogcnRj
LnlhbWwjDQo+ICsNCj4gK21haW50YWluZXJzOg0KPiArICAtIERhaXJlIE1jTmFtYXJhIDxkYWly
ZS5tY25hbWFyYUBtaWNyb2NoaXAuY29tPg0KPiArICAtIExld2lzIEhhbmx5IDxsZXdpcy5oYW5s
eUBtaWNyb2NoaXAuY29tPg0KPiArDQo+ICtwcm9wZXJ0aWVzOg0KPiArICBjb21wYXRpYmxlOg0K
PiArICAgIGVudW06DQo+ICsgICAgICAtIG1pY3JvY2hpcCxtcGZzLXJ0Yw0KPiArDQo+ICsgIHJl
ZzoNCj4gKyAgICBtYXhJdGVtczogMQ0KPiArDQo+ICsgIGludGVycnVwdHM6DQo+ICsgICAgaXRl
bXM6DQo+ICsgICAgICAtIGRlc2NyaXB0aW9uOiB8DQo+ICsgICAgICAgICAgUlRDX1dBS0VVUCBp
bnRlcnJ1cHQNCj4gKyAgICAgIC0gZGVzY3JpcHRpb246IHwNCj4gKyAgICAgICAgICBSVENfTUFU
Q0gsIGFzc2VydGVkIHdoZW4gdGhlIGNvbnRlbnQgb2YgdGhlIEFsYXJtIHJlZ2lzdGVyIGlzIGVx
dWFsDQo+ICsgICAgICAgICAgdG8gdGhhdCBvZiB0aGUgUlRDJ3MgY291bnQgcmVnaXN0ZXIuDQo+
ICsNCj4gKyAgY2xvY2tzOg0KPiArICAgIG1heEl0ZW1zOiAxDQo+ICsNCj4gKyAgY2xvY2stbmFt
ZXM6DQo+ICsgICAgaXRlbXM6DQo+ICsgICAgICAtIGNvbnN0OiBydGMNCj4gKw0KPiArcmVxdWly
ZWQ6DQo+ICsgIC0gY29tcGF0aWJsZQ0KPiArICAtIHJlZw0KPiArICAtIGludGVycnVwdHMNCj4g
KyAgLSBjbG9ja3MNCj4gKyAgLSBjbG9jay1uYW1lcw0KPiArDQo+ICthZGRpdGlvbmFsUHJvcGVy
dGllczogZmFsc2UNCj4gKw0KPiArZXhhbXBsZXM6DQo+ICsgIC0gfA0KPiArICAgIHJ0Y0AyMDEy
NDAwMCB7DQo+ICsgICAgICAgIGNvbXBhdGlibGUgPSAibWljcm9jaGlwLG1wZnMtcnRjIjsNCj4g
KyAgICAgICAgcmVnID0gPDB4MjAxMjQwMDAgMHgxMDAwPjsNCj4gKyAgICAgICAgY2xvY2tzID0g
PCZjbGtjZmcgMjE+Ow0KPiArICAgICAgICBjbG9jay1uYW1lcyA9ICJydGMiOw0KPiArICAgICAg
ICBpbnRlcnJ1cHRzID0gPDgwPiwgPDgxPjsNCj4gKyAgICB9Ow0KPiArLi4uDQoNCg==
