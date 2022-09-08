Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A255B1DC0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiIHM45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiIHM4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:56:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFC89AFBD;
        Thu,  8 Sep 2022 05:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662641814; x=1694177814;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KZvjPsQf8yWXiSsqB2hhJsiAOGA+7POHn5TVroUuru4=;
  b=t+6rBmypCNmXVnNE2NwnWwC7eqR327lIbZY+MGQm/tginlU0V6jO6u22
   6sBcMH9hVy0bhq5H7ippeOkxe64jYDULaPRFEWxanv5kQiquJFL+Z+Oa2
   VAmwNsb0om7PD8G1CjCvr9xAAKETVQl4cnOsj+Q/HWKAVnQbmoTdNeNIV
   +BU1D7dA7U6HAuKdaUEkV52OZMKiKzaHLHEU6q/hvZF+gZ+bzpmRftnWH
   1y8gS2PhH3xdTXbsiXFtiuHwrEMFCIFXzBbn8csOY/X6FWoXtisFePUSI
   HirCMuVns2muijxmd1ZCS+Tfwh0sef2tYL3S8JYMjq+PDKojNZVqxVBJh
   w==;
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="179565491"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2022 05:56:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Sep 2022 05:56:53 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 8 Sep 2022 05:56:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7QcnoW5L99miSCNHutvP9Q8Kt8IaQw+PhNdjEmxnAJPhxu+nBvrCcpKGIKrkcodelD2bsWEMpNZ1zgReAf9Hk4VEdxDTDZcV72NQh2DEpbtcxdjzcmrY4MZKUjhCIpZctKP7iIoT61HBLvIuA+6RUCpLl7QA4aM0hdnrK2T/COhizGvRuRfPZSeSf6a6946ErWmNE47zm66iuU11CvDy3bY7eee5Gc/P69jP0gd1l5rqINB5uKYOdG2FAKwStIN8VX4HK2UQMFLWlO6ac5WKFr/PgTHrlOqy3jjKhNgVUd/ZDT4OsDwbIfIEPlOsJJlDOuLbgjmwNFexPtBLO2RoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZvjPsQf8yWXiSsqB2hhJsiAOGA+7POHn5TVroUuru4=;
 b=fhZ6WSLnhVIKPS3OL1h3l/78z7CBqDIgoR+o5n6oemjKPXJPzASp5dRgEqoEjVdI6r7K/AV/0ssz5d6+vaL5q9kblG2UhBByKahblOdAulrnU8h2qX28o/X8ebezaqSHdIsZQbl9jjM4BahdGp7XJEDbXHP73pf9HxlKrXRLr8vjpznhFW+OeC1wATEBG0hR/j/hJTPPG/GBCwPXVA6nXbF4r62G4Z2um/ljRFNbtIvuzfwKQLA+6zgPierNqpxf+aLko42wfkPv56GPvexqTm22kzAr5GNRC+y4CtCjOcFfPmTmMmp4e1PasQrEqalbeCpawaJwYzGIuWF2Lkrq9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZvjPsQf8yWXiSsqB2hhJsiAOGA+7POHn5TVroUuru4=;
 b=T80zvhtdV1JntHLC45iByVoalcqXZlXYkoLJb5SZd1F/4b8YSgI7muh7CYMiwd33p22FqZcA8AswgDRC7UObv4cQSDKhDAgjRPWtIouf/9Volq4HROK98V7+EpU9U6+vITM50bxpzjZF4750TUBLcVl6cAmaOO9XzdwtNAl74rM=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CO1PR11MB4819.namprd11.prod.outlook.com (2603:10b6:303:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 8 Sep
 2022 12:56:49 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 12:56:48 +0000
From:   <Conor.Dooley@microchip.com>
To:     <wangjianli@cdjrlc.com>, <damien.lemoal@opensource.wdc.com>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/ata: fix repeated words in comments
Thread-Topic: [PATCH] drivers/ata: fix repeated words in comments
Thread-Index: AQHYw4HU5JmlvwEteEqsIkclDNNdvK3VfdGA
Date:   Thu, 8 Sep 2022 12:56:48 +0000
Message-ID: <e2f882f7-6871-a754-fbbd-6a5201f45f4a@microchip.com>
References: <20220908124937.25962-1-wangjianli@cdjrlc.com>
In-Reply-To: <20220908124937.25962-1-wangjianli@cdjrlc.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|CO1PR11MB4819:EE_
x-ms-office365-filtering-correlation-id: b1148585-888f-4b69-2394-08da919997c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oubMjE8jrmUd43gRQhBtuqDBi+8I3jUSIMJyffoIBfuEnHU+uY0k52yhclYU3bqL9VtjHjL3+MqnFcnny2Kx6PnXuPkEJUH0XXfKfM90LiYflpCv+fJb3XraSz0fJA3Mw8VfpZeaGS5rme0vSAC5DQTMDakc+P6muZVhbUtz9ZYLBLTUnPxpi85kF25Rca3NV+l2jr0igbGbPpWVfuvRw2yDwGORdBZEu42ix9xOE9/w0w7CfHBe/Hw63CHJd7/NHEOzyGEa0pyJLQqheK4tOpC87pLrx98anLWrQeLE4k8z5MaSSFCsO35koWuEQnhSrTmI3kCkOFXmhNTXjhWBXn+8XFpLomcLZvWBXURR2KD1ZG8Qrp711d8kOvkgjV0LA3txEU7hPduiguOOEwaBUUZQB7sGDDFNoAG/HkPwbeEdC4sDp2xWZjDHK/Pijwqer/kh30d1oCVy9tPEKYwSjEHqaifeHjNWXO9BYBp/kjv2egUlakfRWEAnkrVyrzusWtLeKdEnZj6uFicMnui/43sVYFn3iTU/UjGwgDr+8v+S16qGk5HGVslw52uQ0uQ2DTp0EgCq2vttf0dn6EDuuueF9mniADH4UV1pL9ma4sEQk9J1vErEjvKxFnhvDY42brujtJ5TmQ4GQO14ttE1KtxoYEpj5q9lSN1xI3Dy2XS0ZJLmQlrbBNJPFYmfec0CD4W1hu2EnwCrpIU/0ZA8pRk0aP2zt8QbQHRCkDGdGB/MLj/Iz1gPsmhUHDHedYs78x15dxDtIj8jVcBK52YQ2NeK9/SHV35fRmcStzJudkj7C3FqXF74kScCnHjCBZN/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(376002)(396003)(346002)(366004)(31686004)(66946007)(86362001)(91956017)(38100700002)(38070700005)(66556008)(66476007)(8676002)(4326008)(66446008)(31696002)(64756008)(76116006)(316002)(36756003)(122000001)(6512007)(83380400001)(186003)(478600001)(6506007)(26005)(6486002)(41300700001)(2616005)(71200400001)(110136005)(54906003)(53546011)(5660300002)(2906002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1I5Nkw5NmRwdFlLTitSb1BoaXRPQi9QZDNaWWphWlRUMDlXZ3RwcmpQVk53?=
 =?utf-8?B?SEQyaHhuRjhNUUNUTTdwRGp0SjlYNk1GOEFzY0hLWEFmeHltNzV6LzNLSjZT?=
 =?utf-8?B?ZzhzaW51UkIycTFtQ0ZrdlI4eXpzMWJSeEJPRVdhTHdnL1VwQTBweWppUVNQ?=
 =?utf-8?B?K05HaVJ1Q0o1eTZjN1BvaGE3RzN1SWhqOEUzZlRoUFlKakFsSnhxaTMvMmtD?=
 =?utf-8?B?aVZxbU81SDhXVHlZMVdGcXpKYjJqNjRTQ0hxbjdVZ0JjRFRxbkYydDhOV3J5?=
 =?utf-8?B?TFJobW9rUWpwTUt5M3diN2ljTVorcnZRcEFoQ2EreHJhQ0Z6ZmdoS0pud1Nq?=
 =?utf-8?B?TkVqdTdxa2o0a01reXBZeWFXZTB2aXVXYWZGSHh0Y3loOFFlaHZXVWJya1lF?=
 =?utf-8?B?K01zeXlpbENQM3owRUVUR2VaRnRRUWxpT3pla2dPQkkzK0xodVlpQVNOSVhs?=
 =?utf-8?B?U2Q1TG8xbnJLVXVtS2Z4WFpHaTgyeGJqT1hoc0tMRy9zWkU2RCsxSEhoT1o5?=
 =?utf-8?B?bG9TV2tyYldNVjJmZHUxUjhFRmZoTXpWUzZqalJML1hsWStaTEltWjRUQmZI?=
 =?utf-8?B?WS9GbHZCK1NkTzZ2dUNHUEF6ZFFTRnRIVDREZEtWQVZxenhKS2ptd0h1VFNq?=
 =?utf-8?B?ejNxYmxlTGl2blQzWmhjazlPOFpMcVZ6WVQ2UlRvTWxOSlQ4MEFhQzJVZjV6?=
 =?utf-8?B?T1Q0NGRvK2RONHE3T1ptZUNKdFBSZ1RvNGdzSmpneEQrT0xING10bkQ3OW1I?=
 =?utf-8?B?eHdMSktWNXdDMG1zczlwRXF5UDF4dWRNTWJGSTYzcE81bUNkM2JlSjg4R0JT?=
 =?utf-8?B?SmdGWjJpdTZ2YWwwLzl6K1JMckF6ZVlMSFBrUEpOUHdMQTZab0tZMVlYWjVM?=
 =?utf-8?B?NWtxWndPQ2U4RC9wamNiUWpHYTl0aktYRkZOaWh1bUtYUWJBOEFpQ1hMREdj?=
 =?utf-8?B?KzU2VXQyZnpGelVtU3J5d05xc2FtbFhDbkdWQ3BjcWo0T2QzRVlvTGJ1UUpG?=
 =?utf-8?B?ZHBrWXhrNWtMUXJTVlZPaklQOWl6eWo2UnB0aWhaN2JodHMraXZTL255KzB2?=
 =?utf-8?B?K2hyd1ZJVlliOU1oSmpPMklEUTVocDAvaDYvUVZoazdsWUdaZk5NeEdBWU5J?=
 =?utf-8?B?K21rRkx1dHZmTXF2OUZQVFRtVU4rTlRIdTBKRjB0YXRhbUhlbWJvL21udGwv?=
 =?utf-8?B?WEUyaHhZTWtVSEVGWmdEUzhSR2ZvVm9NVXFUK0FIUWZpQjhZU3dnOWYxU1Zs?=
 =?utf-8?B?ZTVEQ3ZNUmQ5dzJyRE9lYVlXdHg3SCtESWU3TE8xNi80cEo5eUxmMkR4R0ti?=
 =?utf-8?B?cURhRGJCSU80OXBBa2k4RVNUSUlnMzJlbGVOTTRySjMwZlhocWd2Q3FKbGRU?=
 =?utf-8?B?RGZPU3h1NjFLN05ieENkc1RicTBlM1dKTURZWE95UzhzVmZ4YWRiVVhDTEl2?=
 =?utf-8?B?VEpKa0daeDRoR254eHV6Vm9keGJ6OXllVzBtRjlxRlhtQkF3Uk5BNUFWdlox?=
 =?utf-8?B?NGF6OG1MKzNJdGRIbDI5dk1ZRlpXelhTM09XVkttRzZEZFU4V3MvY1lmTzB1?=
 =?utf-8?B?NGlLMDlIbGZPRVhnU2hIQ2JRVWxpSHZIRzNrRW9NTXBjOUwyTzBabHJtUG0z?=
 =?utf-8?B?ZFFKcG01emtTMlp4ZXlsc0FHSTY4VkZDY0MrMXhOeVlsT0VPOVdmREFTU2RT?=
 =?utf-8?B?YjVhc2x6b0pYVnlTN0xSWUEwS08vOFJPaG1WelZQR0xyZGlGdHNwK2FJOXIz?=
 =?utf-8?B?dzhpd00wcUhKRXBSaVdJc1F3bzdvMnlNekJBUTdrRjlodll2dlZnSkdSbmY1?=
 =?utf-8?B?aTNrQzFhNVh5V2E0Y2k5M04yUW5XY2ZHR0dYdFphaW5lelFDaklpMHdTM0g4?=
 =?utf-8?B?K09KNGtYNVVMYUVtYVkxTG81cnBGalJweG1VZ3UzaTdkQ28rSk5EbkVLWDdI?=
 =?utf-8?B?QnNCSE1zOUw3eFBEdmExRE9YcTlkSHdxald4V1FHOURmQ2ZMdnBlTkFYYkZn?=
 =?utf-8?B?VkkxaDlJVXpnbWJFL2dTVUt2bUcrK2ZwaFhHd2hzTEg1dzVRT2o0NzZDUlZv?=
 =?utf-8?B?M1NnUm9XNWgxRFJGZjJ6Y3doazlNbEhsemEzQWt3QmZvSllBUW8rQXBZbDdm?=
 =?utf-8?Q?Sv40q+Lx8z/UtkxAOG98yp9+H?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F71486E0E6A084E91E718B9BF6503A8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1148585-888f-4b69-2394-08da919997c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 12:56:48.8206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ODEJpxBHt/9tVotzTnOGZzGuYtxWTwyXaseYL0s/moyrp5TbRyQlp7IaVy/y7fgIq9Fn12ADnvhNYerkEIf2jHuqeS7v0xWGICkoxek9JU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4819
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDgvMDkvMjAyMiAxMzo0OSwgd2FuZ2ppYW5saSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBEZWxldGUgdGhlIHJlZHVuZGFudCB3b3JkICdpbicu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiB3YW5namlhbmxpIDx3YW5namlhbmxpQGNkanJsYy5jb20+
DQo+IC0tLQ0KPiAgIGRyaXZlcnMvYXRhL2xpYmF0YS1laC5jIHwgMiArLQ0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvYXRhL2xpYmF0YS1laC5jIGIvZHJpdmVycy9hdGEvbGliYXRhLWVoLmMNCj4gaW5k
ZXggN2MxMjhjODliNDU0Li5jYTg2NWE5NWNmMjQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvYXRh
L2xpYmF0YS1laC5jDQo+ICsrKyBiL2RyaXZlcnMvYXRhL2xpYmF0YS1laC5jDQo+IEBAIC04NjMs
NyArODYzLDcgQEAgdm9pZCBhdGFfZWhfZmFzdGRyYWluX3RpbWVyZm4oc3RydWN0IHRpbWVyX2xp
c3QgKnQpDQo+ICAgICoNCj4gICAgKiAgICAgU2V0IEFUQV9QRkxBR19FSF9QRU5ESU5HIGFuZCBh
Y3RpdmF0ZSBmYXN0IGRyYWluIGlmIEBmYXN0ZHJhaW4NCj4gICAgKiAgICAgaXMgbm9uLXplcm8g
YW5kIEVIIHdhc24ndCBwZW5kaW5nIGJlZm9yZS4gIEZhc3QgZHJhaW4gZW5zdXJlcw0KPiAtICog
ICAgIHRoYXQgRUgga2lja3MgaW4gaW4gdGltZWx5IG1hbm5lci4NCj4gKyAqICAgICB0aGF0IEVI
IGtpY2tzIGluIHRpbWVseSBtYW5uZXIuDQoNCkhleSB3YW5namlhbmxpLA0KVGhpcyBkb2VzIG5v
dCBsb29rIGxpa2UgdGhlIHJpZ2h0IGZpeCB0byBtZS4uIFRvIG1lLCBpdCBsb29rcyBsaWtlIGl0
DQpzaG91bGQgYmUgcy9pbiBpbi9pbiBpbiBhLy4NCg0KSWYgeW91J3JlIHVzaW5nIGFuIGF1dG9t
YXRlZCB0b29sLCB3aGljaCBJIGNhbiBvbmx5IGFzc3VtZSB5b3UgYXJlLA0KdG8gZmluZCB0aGVz
ZSB0eXBvcyBpdCdkIGJlIGEgZ29vZCBpZGVhIHRvIGNoZWNrIHRoZSBvdXRwdXQgZm9yDQpjb3Jy
ZWN0bmVzcyBwcmlvciB0byBzZW5kaW5nIHBhdGNoZXMuDQoNClRoYW5rcywNCkNvbm9yLg0KDQo+
ICAgICoNCj4gICAgKiAgICAgTE9DS0lORzoNCj4gICAgKiAgICAgc3Bpbl9sb2NrX2lycXNhdmUo
aG9zdCBsb2NrKQ0KPiAtLQ0KPiAyLjM2LjENCj4gDQoNCg==
