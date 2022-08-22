Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EB159BEFD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 13:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbiHVLxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 07:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiHVLxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 07:53:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBF426B;
        Mon, 22 Aug 2022 04:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661169193; x=1692705193;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=T8/xiZxVzwQetG+rl4nj3cszYckzSQ0hm7zBh/CRI5g=;
  b=MnMQPYI3Zy9Kgc8ALwexM8+yETtDnlx0F/TXJQOurauRVT0DJ4vuOuET
   ajuSRqVlLHmtepVqYBuW0iXj75LJ3zH0D9s+cCHmG3iUUDeqyAk7SUFTO
   DOPCpfL3Y9gWwAQmEEcc+aEbLMn+EMfflV+ZNnNck7vFXPxKQNraLcG2g
   7oTW8brfB72WSH5KZjzNOmImyVh0Y/RairrwrzUZA3KFqXQdS1CmWmws/
   TdXlmXU0EfALTYijttXW2+hzCmqCleogLTfhud/h7OWb2Kp3AzLVw+gA0
   KDLFURln4kFl8sHA9ZiHmC8zVpem4kvWMuEuMum9IcL+oduOb+2xijlW1
   A==;
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="187492617"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Aug 2022 04:53:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 22 Aug 2022 04:53:12 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 22 Aug 2022 04:53:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYqeqXWccZJLPClcFCoqFE/b1pZ8v8SKqJIXSgH1LShHsDMRzBr2TU38uK2m3XqqfbD1X19sMsUuyjJN2c4UT4D/G5ko+KbsTYAopnAkRRyKP8ACeXmYN8jfXXo62wEXw0Sw2l6eVRP2ADuVPK0KrHX3DzXt4InrLag+LcC5IvIhzbiRZrL5Y5jO4VZ6Lvf7C80Jy2wqEPv7xGIvXVm4zsjKaiMQ0XWOrFnsgpQLn57FhwAlGc7WrRbJTvLUkw4+J2AGccLnL15NxCBvn1pxa0spEh/xywLouDXM4c2iiQy3F8hbG8ebiQDcmzRbxBlwtV8q5Pu74ot/+FY7Yf90YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8/xiZxVzwQetG+rl4nj3cszYckzSQ0hm7zBh/CRI5g=;
 b=NiK57Yo7EEsc+U0jVM0fAb5HQ9uGvKKgaq7BRHViOV4YZwtEC7PGKbtxjW+K/oDtzVoJ6aCFqapqlecV9yEL8CDEnVb9Cg7fUp6lcH2GHa9ZiU/kjGI3FMGUe5BJB8uzn611dKmC/BsAGKo53nrCo9K63v84qxb9cm/sQmQ3uBdsUipow3SqjssOammOR0IWLUC39z+LGoepmfMtkdY20LC4KDL5dgC7EDwnxfrQ8hyRV0yDBWZEjbzn9MySzooTAPxqBEFROuGQ+9NQMvC9ttzojl4KO7kTxJui5rrIRsGeIXHgTtGXqrJDSo122u5PmqZxF86yvHUecXD1aVMmvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8/xiZxVzwQetG+rl4nj3cszYckzSQ0hm7zBh/CRI5g=;
 b=JwVAHKbR0WXXDL1ODBZnmbXoz+vO5B6qRyHVz6KB5VFqKf5gUNc1R40tptITrUqJbT2I4zvmlFOOw0sGtRmXqclV8VEY2DmZ2CQOGKzDqf21paG/blZWUxTZalLB1WxWGLjIv7mbUz27eZ8+uc/cWfN5GTLR3jxEh/8qF5TkZdo=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BL0PR11MB2930.namprd11.prod.outlook.com (2603:10b6:208:73::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Mon, 22 Aug
 2022 11:53:08 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 11:53:07 +0000
From:   <Conor.Dooley@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <palmer@dabbelt.com>, <Daire.McNamara@microchip.com>,
        <Hugh.Breslin@microchip.com>
CC:     <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2 2/6] dt-bindings: clk: document PolarFire SoC fabric
 clocks
Thread-Topic: [PATCH v2 2/6] dt-bindings: clk: document PolarFire SoC fabric
 clocks
Thread-Index: AQHYthqSUVtMWR5Ot0GrcHpCiU3dwK26zzSA
Date:   Mon, 22 Aug 2022 11:53:07 +0000
Message-ID: <470d663f-7150-1df9-9ce0-93087feb7819@microchip.com>
References: <20220822112928.2727437-1-conor.dooley@microchip.com>
 <20220822112928.2727437-3-conor.dooley@microchip.com>
In-Reply-To: <20220822112928.2727437-3-conor.dooley@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b9c512f-6c5b-413f-f421-08da8434e138
x-ms-traffictypediagnostic: BL0PR11MB2930:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L3AHlnDyk5xOCib8o/fY3bJE3/Xfn4YdszZPpRZuiyDWS+IDtgg31CVApLR/r21Eg1g4CW43t1TkXRkdAzRA4Hv3lE4YLunJK4nQ6m6/NC9lWQPkZYvXUqi0EPk1i1v/jW1bLqOYDQseEZ9hqldd9hNz+Ppw1FD0xmMVSXp7ekV9jcRFio5GtRmz1m+8m/EnOTiG9I78kNcTMcYL9/4q91HGKsy9etvnsYWvUe/W4pPPv0C5rKez4KbuLfqb2+zE29zNdJRnXv+7l3vCBC2FMZEMSvdc+epFoAlmJsU9304WI7xp43S884LohiqrmYd3souuc4EkhCoBi2//M699LlgmK4RqAbImAdHs8kuBypLDbUVIgxaXsG6OSS8VGOqldf2J4+kIwqF8MSddUoQFGT8i5B20THbdnX0NIhDZhu77f87pJxoikLLiv+0zRTSKyBZ680Bou+PHHn1AFg8v9qW00Hzkmn//OzN8hk5Hqp9QCg87QZzy2V1yBotFZpOIFpi2/eLSlQG8yCHDCJCcW/fk+AH9LBJb1CojTG1HdQZHGCDwlObmCGfoh265ikrEFx3I5nCjtESK8bdXJezXsO8csN0Tt0xwQykn3pQcDltwNOvfP2R2/1xFw03lPfySLmpamAYCdHtUF8Z1xOsthUxNlkxBXfDtK0NVwAEaY6eUNP5SIZoQAEhhaUxNLmHBxf3wQOo1FxoleGb9I3JsMCeJFyQpKSncTYbXuGaH5/Sl1cdmHBqbiX6JEYkBzuR2AQsG0uAFPkQyJykJQPNiFWKxbutEtfJ9y6hf/KOZ8mH92X0ot8xxVpF4nCIcnqMQYnLB4TLnFGoi+ArI1SiR1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(346002)(39860400002)(136003)(396003)(6512007)(38070700005)(53546011)(122000001)(6506007)(83380400001)(6636002)(110136005)(36756003)(54906003)(31686004)(2906002)(38100700002)(316002)(71200400001)(91956017)(86362001)(7416002)(41300700001)(5660300002)(8936002)(26005)(8676002)(4326008)(66476007)(64756008)(2616005)(66556008)(66946007)(31696002)(66446008)(6486002)(478600001)(76116006)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0lSL0VWc2t3cUZRdlJmcnVzRzlEQ0QzeWdNSXBVQUdiWnd4UlRhWlJCTDVG?=
 =?utf-8?B?K00wV2FTTlJRODdoU2k2OEFlOTd5ZnlsWUhOREQrSTNiYnE4WDFOYUQ1Z1U1?=
 =?utf-8?B?aXdDUjVuc0V1VlJERjNHU3RRNUlpTlRCeWE5aEk3cVZoaTBFVTc1TUptKy9N?=
 =?utf-8?B?Q3o2Y0wveVFHZzd5MGtpWGRwUTRsai9tNzZSTzBCRmFHT3NGRnBrK0Z3d2Uw?=
 =?utf-8?B?aXhNMHRrWHU4ZHY1MzBiMUdBL1EweWYyYXVKazBGTlZqTGdnMlZoc091a2Fk?=
 =?utf-8?B?RXFYWmNDbmdWUS9RaVAwZEVROERTY2F5QXJxN21qOXRGZjBWekdBazFkRmNr?=
 =?utf-8?B?S0YreHN0eXQ5b203NzFCdFBPNTZBdkN0RHJjMEE3Sjl6MlB4eUZTWkl3Rk0x?=
 =?utf-8?B?bjhMdzl1THpWendUUDYwcE82OHVSTjg3NFdyajFhUXN6bGFEVC91anhRN0R0?=
 =?utf-8?B?UFNad3RCdVhFWHU5bHhLTGFLbW1tQndxY1BQaG16aDVVL2hhV0xRem5kZ0VS?=
 =?utf-8?B?OEEwZVlzbzdOQkF4dkNYazlDUnlXdVR6d0R1RmNVZFF5RjN2clZMTHo5WlY5?=
 =?utf-8?B?Smp0UktsaWhTYzRHSVZSL1J4VEE5S1FaMVVacG84czRac1gweGk0ZG1Ua1E1?=
 =?utf-8?B?c1loaXZGQjd1aFVPdTVpNGZCTTREY01RQXgrNWdzZllpbHBiZ1hHQXB0UzRS?=
 =?utf-8?B?M1QvTmFEQlpEb1JOc3pNQ3pGOGc0TE50bWxjRlZoWTVpT3pHeTlIYWJpek5C?=
 =?utf-8?B?c0YrMVBaNFBZTHdQWGYxZHRmMGFtUjNXZHRFYTl6NWtZaURZTkZlK25keVdp?=
 =?utf-8?B?cnZBMGxndWtPNENyWTYxOTlWZHNRZnEya05mTW9KTUpndEluTjQ1bzNvdUhC?=
 =?utf-8?B?UEZuenBRSXJmWFgvdU1YaXNZVENoTVpPUFROSkZVY2w3S3Rrc0NwdWlrMDN3?=
 =?utf-8?B?ZDUzdFYwdnFPQjUxZWtLUS9iNEl0SDRFUGFTaEpBbFZ5cTl3bk5uZmJxYm83?=
 =?utf-8?B?U1JsWVBUbG9WNktjajY5YzBOVGNYRzIrSTlBclJNTUNXUDRIaUtIQmozR01S?=
 =?utf-8?B?QjZoeWNJUFJoaU1hclF2UjRXd2tXVnIvYjdYQTBHTFZ4SllZeE5DT3AvdE5O?=
 =?utf-8?B?YlFCUFlQcEFoZ2hYTWVHWjJlMG9GVjZ6NlA1ZEtxNlp6emNuK3FucGJuSjZU?=
 =?utf-8?B?Z0RuYjVGYjNKbW8vN0lMNkVnUitIeHNnTEY1NW9nekx0WHppY1UrNEdzajVX?=
 =?utf-8?B?dElqNG1mUGZjWDF4ckdzZWF4b1dOd1hOVGhHRGJaYmlwUHV2V0RwUlcvUUNM?=
 =?utf-8?B?OFZsNzROb3ZFOFV6VUMwWERBb0xXUjBzUXVlL25XdDQ5YkFVcEM2d2R5SnFR?=
 =?utf-8?B?UzlQNDUwbXdlM3ovY3ZPSUNNV1dmWHo0Yk5yVXplZmgyZjZjTU9iUEdkWHA5?=
 =?utf-8?B?dXhBempUMlkzL0dEeHo5c2FoZzdqYm9LNkFXeXdvR3dCc2I0dUZWemo0MCt0?=
 =?utf-8?B?M0cvaUxEQ2Z0N29EMzJrYkR3Ujh3Mm5vNktQRFlVekJ4YnU5b1MzMkU5WEhz?=
 =?utf-8?B?SFlQS2FzQ0VDRWFaMURWL1NOSnlXVUZ3ZWRBVStDWURYTDZsVVRWcVVJSTVY?=
 =?utf-8?B?YjM1Z25lVkpyc3FhM1B6YURYUExhRXVzTFBKZ0R3dlNrQVd2cXF5UUtLdThy?=
 =?utf-8?B?eDlyRUxqRjhQVmU1d09OdzFhbDlrc2syM3ZTQW92aGhFenFvUEJ1TGVncEQr?=
 =?utf-8?B?ak1TRmpWUUFoZ2JyRHZXaDI3akwvV1hEbnExeTgraVRwbm10K3BYL1hKeUZo?=
 =?utf-8?B?amZsaVRZRnZSblBMalRad1kzY3Q1YTQzc0hLU0twQzVwTkM0aWFNenF2aitO?=
 =?utf-8?B?eGVaVEIyUVZuSk1IK0ovQmEyV0hIbGZpTTRJTFJIbmF5eHNPR1c1TXkxNUFq?=
 =?utf-8?B?UDNNQytpQ1dZajlVTmNaNHhCVFQ1QWp5Z3pFeGxVSDF2d29yQW9mRExkOHVX?=
 =?utf-8?B?dzB0bkdCc2tRRmdPYUxNVHJES2lnZERmdE1LNG1MYkpWaEs3b0xNRDY1OEVh?=
 =?utf-8?B?ZTh1YnRuRkVaVmFScGh0RHl4UUJScDlZTlkwampMQjQ2WHJjNEZtVXRUUEth?=
 =?utf-8?Q?V93kwfze76DwjIO9nHg0JLUoo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D4ACE106E4A6E4E8FB656C823257D34@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9c512f-6c5b-413f-f421-08da8434e138
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 11:53:07.7962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zGrdBaZvpsPEjxGLOi5IePx479HYvONq1Lr0dzz1AMDm9NFW4GD+i+bSZZew2wf/OqvHD47OU5DOaqGU4axtSTbsM7yp/cj/Lcsd2jh13ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB2930
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIvMDgvMjAyMiAxMjoyOSwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBPbiBQb2xhckZpcmUg
U29DIHRoZXJlIGFyZSA0IFBMTC9ETEwgYmxvY2tzLCBsb2NhdGVkIGluIGVhY2ggb2YgdGhlDQo+
IG9yZGluYWwgY29ybmVycyBvZiB0aGUgY2hpcCwgd2hpY2ggb3VyIGRvY3VtZW50YXRpb24gcmVm
ZXJzIHRvIGFzDQo+ICJDbG9jayBDb25kaXRpb25pbmcgQ2lyY3VpdHJ5Ii4gUG9sYXJGaXJlIFNv
QyBpcyBhbiBGUEdBLCB0aGVzZSBhcmUNCj4gaGlnaGx5IGNvbmZpZ3VyYWJsZSAmIG1hbnkgb2Yg
dGhlIGlucHV0IGNsb2NrcyBhcmUgb3B0aW9uYWwuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDb25v
ciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KDQo+ICsgIGNsb2NrLW5hbWVz
Og0KPiArICAgIG1pbkl0ZW1zOiAyDQo+ICsgICAgaXRlbXM6DQo+ICsgICAgICAtIGNvbnN0OiBw
bGwwX3JlZjANCj4gKyAgICAgIC0gY29uc3Q6IHBsbDBfcmVmMQ0KPiArICAgICAgLSBjb25zdDog
cGxsMV9yZWYwDQo+ICsgICAgICAtIGNvbnN0OiBwbGwxX3JlZjENCj4gKyAgICAgIC0gY29uc3Q6
IGRsbDBfcmVmDQo+ICsgICAgICAtIGNvbnN0OiBkbGwxX3JlZg0KPiArDQo+ICsgICcjY2xvY2st
Y2VsbHMnOg0KPiArICAgIGNvbnN0OiAxDQo+ICsgICAgZGVzY3JpcHRpb246IHwNCj4gKyAgICAg
IFRoZSBjbG9jayBjb25zdW1lciBzaG91bGQgc3BlY2lmeSB0aGUgZGVzaXJlZCBjbG9jayBieSBo
YXZpbmcgdGhlIGNsb2NrDQo+ICsgICAgICBJRCBpbiBpdHMgImNsb2NrcyIgcGhhbmRsZSBjZWxs
Lg0KPiArICAgICAgU2VlIGluY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svbWljcm9jaGlwLG1wZnMt
Y2xvY2suaCBmb3IgdGhlIGZ1bGwgbGlzdCBvZg0KPiArICAgICAgUG9sYXJGaXJlIGNsb2NrIElE
cy4NCj4gKw0KPiArcmVxdWlyZWQ6DQo+ICsgIC0gY29tcGF0aWJsZQ0KPiArICAtIHJlZw0KPiAr
ICAtIGNsb2Nrcw0KPiArICAtIGNsb2NrLW5hbWVzDQo+ICsgIC0gY2xvY2stb3V0cHV0LW5hbWVz
DQoNCk1laCwgZGlkbid0IG5vdGljZSBJIGhhZCBsZWZ0IHRoaXMgaGVyZS4uIE11c3QndmUgY3Jl
cHQgYmFjayBpbiB3aGlsZQ0KSSB3YXMgcmViYXNpbmcgbXkgdjIgY2hhbmdlcy4NCkVpdGhlciB3
YXkgS3J5enlzenRvZiwgSSBzZXR0bGVkIG9uIHJlbW92aW5nIHRoZSBvcmRpbmFsIGJhc2VkIG5h
bWluZw0KZW50aXJlbHkuIEkgY291bGQgbm90IGdldCB0cnlpbmcgdGhlIG9yZGluYWwgbmFtZXMg
JiB0aGVuIGZhbGxpbmcgYmFjaw0KY2xlYW5seSBlbm91Z2ggZm9yIG15IGxpa2luZywgc28gSSBk
cm9wcGVkIHRoZSB3aG9sZSB0aGluZy4NCg0KPiArICAtICcjY2xvY2stY2VsbHMnDQo+ICsNCj4g
K2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiArDQo+ICtleGFtcGxlczoNCj4gKyAgLSB8
DQo+ICsgICAgY2xvY2stY29udHJvbGxlckAzODEwMDAwMCB7DQo+ICsgICAgICAgIGNvbXBhdGli
bGUgPSAibWljcm9jaGlwLG1wZnMtY2NjIjsNCj4gKyAgICAgICAgcmVnID0gPDB4MzgwMTAwMDAg
MHgxMDAwPiwgPDB4MzgwMjAwMDAgMHgxMDAwPiwNCj4gKyAgICAgICAgICAgICAgPDB4MzkwMTAw
MDAgMHgxMDAwPiwgPDB4MzkwMjAwMDAgMHgxMDAwPjsNCj4gKyAgICAgICAgI2Nsb2NrLWNlbGxz
ID0gPDE+Ow0KPiArICAgICAgICBjbG9ja3MgPSA8JnJlZmNsa19jY2M+LCA8JnJlZmNsa19jY2M+
LCA8JnJlZmNsa19jY2M+LCA8JnJlZmNsa19jY2M+LA0KPiArICAgICAgICAgICAgICAgICAgPCZy
ZWZjbGtfY2NjPiwgPCZyZWZjbGtfY2NjPjsNCj4gKyAgICAgICAgY2xvY2stbmFtZXMgPSAicGxs
MF9yZWYwIiwgInBsbDBfcmVmMSIsICJwbGwxX3JlZjAiLCAicGxsMV9yZWYxIiwNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAiZGxsMF9yZWYiLCAiZGxsMV9yZWYiOw0KPiArICAgIH07DQoNCg==
