Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0659C55D842
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238718AbiF1HNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiF1HNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:13:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD6F27FC3;
        Tue, 28 Jun 2022 00:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656400379; x=1687936379;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bwu2b164KD4lBBgX3TqxrNbeEv6yZ2o9FolFnsyj/TM=;
  b=nRL5voRFABfFZS+HlEbxlpraiUIUBY2E67kPJzG32NqCIIhfEZuVye2O
   +0ljvzxEs0VhmWRdk491VlwX/lyh1orJcurhNIRCk4GGzc7QGxUQOqN7m
   CL6TL1XXzQwuQizsc80W0ED0T8Ufzw0sz31p91X9SoyZy8Lpr8jSBp+Vt
   DgVEbdffkz+NMQlAuaFEQe72Ec0k9FBYQv25qnJifhSHB10xF/fSgouRr
   TFsZsJ/VD/ad5Nfg8DrRgRXeK0b5bPz2yMHY794RJSN+gYqJ/I6mY0Mcw
   zvB+eFucKuiu8u1V5MA7+XrBK4pACU5DA0nLYeMtjCY1wdojJWhfh1GFV
   A==;
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="102035806"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2022 00:12:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 28 Jun 2022 00:12:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 28 Jun 2022 00:12:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqF2Lo9QdDNdSEJ+yv3rzpQnhYmAh3zhBVC/n2n3s32ZL8C9IrhDSvuxxLKXkPx4EQDdQdy9V1HOPQUo6CkzH4wMhtBQn4z6CxWeDOk0w67cgzmKTumZqfpFZKC3WQMf4ooimjP1y+Tg+h4a2OaAeG+ZTOHWwb2cUxqZe2jdcLGSOeWqs6A85kUgnHaXGFEyqMuCZ5eNte1HLiA/q3GxuAvxMVLOlnlL20eBUyi1e2FI9i6BOtgy/5nXhfhAGnjck75JOVt4TewspUH43K99rjyRNDVtqOeu+8hWpNI2IjVegF/UPnDibijJf0ux9bfJ8+UTf2gjJDgGtljpNtUHdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwu2b164KD4lBBgX3TqxrNbeEv6yZ2o9FolFnsyj/TM=;
 b=kj1on3hABAd1p1+vjqfmEQmFm9rBI7eWWUdUMkUQe9tYyYj4+AinbLqbutZ5XAeKjwGD1BgLoPKa5htQ/o0QptwSduSv2RWCWFSzx4J8mqtwOkI0TjbGu08RzqdDMsh20VXluBwuzNy6PPLeT5FaRzvTW7zTJlo8BNNaO4rSsO7jC7gA7nuo/UUUmGFO5Zg2VaoXqRHtsJSbfldKnX2ZZdD7V5pCT7SDBVI1L5pn9x7fROKACcbJca7nOJMefhVKIB6mUF5qHMq5Jrtjo2KRF0AkRieRLioKVhuf19pPWwAf94G4BRPrp04r26oCl865VmPn9mtqq3WxhR70AUygkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwu2b164KD4lBBgX3TqxrNbeEv6yZ2o9FolFnsyj/TM=;
 b=ZIQd28f7lanL+8uhpp2ASPbVDDDYi2NYLU9SA3VdB3R+D0t2tBoQ9fFtPEtS2bEwGWjDwQHLvcmgES53z0IZqAMkrATemG8hd3TGOQx5EWQAohqJVvcsrZHA26uPQPi6JF1KPisRYuSCy/0Uqlh2ryLURt1ZZiUCa7wcHYqeZcY=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN6PR1101MB2113.namprd11.prod.outlook.com (2603:10b6:405:51::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 07:12:53 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 07:12:53 +0000
From:   <Conor.Dooley@microchip.com>
To:     <trix@redhat.com>, <Lewis.Hanly@microchip.com>,
        <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <Daire.McNamara@microchip.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtc: remove 'pending' variable from
 mpfs_rtc_wakeup_irq_handler()
Thread-Topic: [PATCH] rtc: remove 'pending' variable from
 mpfs_rtc_wakeup_irq_handler()
Thread-Index: AQHYimjiTUE7thD3Oky3B/i8V/+L0K1kaB6A
Date:   Tue, 28 Jun 2022 07:12:53 +0000
Message-ID: <17cba42b-0345-fdb2-69e3-cfc3f310c2f1@microchip.com>
References: <20220627205943.2075043-1-trix@redhat.com>
In-Reply-To: <20220627205943.2075043-1-trix@redhat.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d0870fb-28d7-49c1-c2d7-08da58d59e4b
x-ms-traffictypediagnostic: BN6PR1101MB2113:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: obtl+ROh3FGAYv051FHAa66A+xgAFu6WtV10RrQjSZ2UUtvq5KaSLsfwZE2aTkgoL+8oEAExkvkipUscMBmx4x3JbPwqjAdkOqLKiyFR4aAHnI33/FwPf7Vw31LA4ACv6bwi7S/H2+3rYagioUZa/SnYj7UYMIDhioG5guBgOutXzIaAcg3h9Y+4frkEQ8K3ccgAr6/Y3gOXiI4mkOP8xaYeVj5rMXvj+7RZoPH89G6Xf56PsQOFrnK3xl4O/iTHV8QusCs5TrG8zNWDpPSTVwvhgiboomurQqie3fn6vWLsANhU9QKj6YNJ1qJ7N/GT4DbAPQJQuQV2rSeUU3ktdRQsqNSvwQco5nwSxkzZDxtfRTV+LvIjS2IzmwKXpEjggqQ6OrRULfU6vV3YBi5B1ZiB6NyHbvReGxXQKEe6JOKX6ZOlisiWqg4jSdiEREIIbYNWlutCdC61WnV620M8EvdCeT/Iiw61oLRJ3YyYBw+WVm1CpXIh23Fco0zhkUnh8gyRnn4ZEKQB73CBTyxws23v+ti6zlAblFX5abmWmNLlCpHXh9xElXGXBB/t88AXb+e0Q2/TY/S5g4gB7AgbSwQ7py/XozEGYnWnyToxDBmx4oYPA2R3e+8EO4933+Wrq6OcIXNyQWJWNpSkcWwHFjIhEmOFs3x4Kzhl7XAHtsTvqMehWi6CpDTsJs0LYybV0N721hSi2KTRyRalrDslY6XBWJoyOBk/55o3DWFaaakCEMDH+OqxY7HgjZM/yzcLCAuvDntYRZd9Y9r0sPeXUpJJ9X7knzdX1/O84wpMeWfOTfJfhIrxrc6VP8nUNrd2pGHpWECAWl8r72NPVTfDwly0ldykH5bWBZ3wco1lVaE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(39860400002)(396003)(376002)(366004)(54906003)(2906002)(6512007)(4326008)(38100700002)(64756008)(8676002)(6636002)(316002)(66556008)(66476007)(38070700005)(110136005)(8936002)(5660300002)(86362001)(122000001)(66946007)(66446008)(83380400001)(91956017)(6506007)(26005)(53546011)(478600001)(71200400001)(76116006)(31686004)(6486002)(36756003)(186003)(2616005)(41300700001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHIrT0hjUFgxLzlRVEdtT1JTdW5JZnB5d1hNNFVkMjIrOGhLck9nZ2dxQW5L?=
 =?utf-8?B?ZFI0VjVXbGV6ZGRYcGk5Ulhmc0ZwUHgrV0dKODVhaURXRzhyNVFpbzN0dXdK?=
 =?utf-8?B?b2ZwQjduSG1TOWNNMHVac1BsWVJJM2c5c3NqT3dYUkozd09YSnVZL3NKTVZt?=
 =?utf-8?B?MzNHNjIvekZvQXNMT1IzM2lydFF1bk03R2dzeGlyUHIyWjVmZm9YWFgrSjJ3?=
 =?utf-8?B?Nzh1cVRqZzREVU9MZGRQK0x0V0FST09kNzZnd3BvZnUvRWxKeVdxeWx2cU95?=
 =?utf-8?B?amxOelJFTWZzYUFOazFucFNwNmZtRUc2Zy9iZCt0WHF0WnN0UWFJR1FQSTNO?=
 =?utf-8?B?TjBBN3lBL01XUUEvYThhRFNGTnlSc3NQVjVBUXEreWo2ZGZJWEI0R2ZHY3VV?=
 =?utf-8?B?UC9LR0JHemlYZXRZN0EyNENlWE5aS2NPa0liY1FiNHhRdUlUSXNBWlZqdjNK?=
 =?utf-8?B?K1BTMzE3Yjk5aVA4UUcxNU5OQXdMa1hDN3c2eUJ6amJXNWYrbHJ4TDJLU1ha?=
 =?utf-8?B?MUhvOE90OWxkeStvTUhJYTA2V0swZWltY2dnUzNDelZRRy9FMXo5Z2l3SEd0?=
 =?utf-8?B?T055WXhhQzg5MDgzZVlSZlhNYW8rczJwUlpMNTZtTktjQ0xVRjBlYXFnMmcz?=
 =?utf-8?B?c0kxeVJTRTBLT0x3cGdaWnV3S21mK014ZG5RRHNINjR3LysveGxyU3A2ZkE3?=
 =?utf-8?B?cUcwV0dYS2VtUk5MWWNkVGpvMENUdVltVTNtZUJoZklnZUEvQkxLZFVaN3ZH?=
 =?utf-8?B?Zzg2TVcySWVpUjhMSlVFSFB3R0VrTWVRSVAwN1dRZ3NBUXo5SEcyMEV1ay96?=
 =?utf-8?B?OGJpK1JQRDYxaGJlanRyZXFmVU5BSHNxS3JKTzgybStXNTlnUUpYalI1V2NI?=
 =?utf-8?B?cE5Ld0ZrTjYxZGh1NTQxQXlJcGxtdmdvWlh0Unc4STUwYjRkcmZ3WnRsZEtW?=
 =?utf-8?B?TlNjTy9tVXVBQXcra3JmRnhpbEJrZXdvQXZyblYrWERmYWoybC9xVlhPWmJ3?=
 =?utf-8?B?dGEvei9jYm51Y3QzeXhRYVZ3N2VHTXJMTzVvTm5maWU5ZEpMcmxlaFRsTFc0?=
 =?utf-8?B?NWQvZmVqNmtGaVIrUWNUem5ueGhYTUUyRG5ETnI0azlBQ1hwR3VjbzVmYzJz?=
 =?utf-8?B?VHphc3IvZHBFVXpsb2FjbVZHd1pFakRwWUZqSll1ckhIYUtWaTR4Mzk4Z3F0?=
 =?utf-8?B?YnN2eWJmdnFXNEpXQnJCdXFoaG44eHp5UjdYQ0pHK3k0Y0VuN0xXaTJscEla?=
 =?utf-8?B?WHZVTWhrVEt4OVhqTkx1ZnpZa1JkUjQwWVgwaW9ZSlpTZTJXeHZEd3JxUUlU?=
 =?utf-8?B?dG5lcFZBbEVNT1QxSGVwYWwrUmM0aEFYaDRKRVVIWHhEZWt3TDBBTnFRTUxu?=
 =?utf-8?B?RE54VytxelA1UlZkUmRHVmZOZGhnU01pVlJUSXR5OTViMWF6OUJ2T2F3WXdG?=
 =?utf-8?B?RVo4VXh3cUlpMy9mTDZ4N3kzblpKU015WkIvbW1KSkQ4LzBQMVFXd3lxSVJ3?=
 =?utf-8?B?SWJ4WHhPYm8zQWJqYUdGL3k2elMxMElud3IrVEJRaFJWbWx4TUtSNG9TdGZR?=
 =?utf-8?B?MzBhMkQxOEZYQnMyQVdrbFFsTmZLVmxqeXYxblZrT0VIelZiakxaYXJkWEdM?=
 =?utf-8?B?RTFBelJKcWYxelVEUVBnUkQ4RDhVakc1N0pOTEU3ZHZ6ZDdsSVozUTY1bkF0?=
 =?utf-8?B?VVRudG9udHJkeTE3YStPQ2R5blNqcFVGandmSW9vTmtrRU9LS1lOaGZwVTJD?=
 =?utf-8?B?MVYreHZoVEp3TVQrSHFBQ1RhbURoMnZYL3VrbnBkM0xZbkxyMWM3cmdCN2FD?=
 =?utf-8?B?cit1Qk1HZlhnMXlMRE1NU2tBM1lWdGFoT1piMk40ZU9OSStITllHUmxpeHU5?=
 =?utf-8?B?OFNyVko4QjFvcElJcWRURDRNVDBXR21ScDZtQXFzc0lqNCt5RzdrcWw5YjVK?=
 =?utf-8?B?V1NwZW1JRGFsOEhmM0MwVjZxRCtnd0xna2JwMXpSWE9PNk5oSXNMNnB4ekVI?=
 =?utf-8?B?OTZIVjg2RUhVYTljZDF0U3Frc0hxOEloZnc0dUJCSGY4VTdHdVduUDB2cWNI?=
 =?utf-8?B?b21Jdy9mQnB0OHo5czV6VXVBUUxHalRRdDViQytnUmZJWDYvT094c2tpQnJL?=
 =?utf-8?Q?N3SS5USF7eGFcNTqiMRRTtYHr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DEC78195ACC7749A90B6115D8878669@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0870fb-28d7-49c1-c2d7-08da58d59e4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 07:12:53.3233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iP0++YPI2pgIGSmKt3Kumiv9H2LY/2qIMi4BFgcX2fDHxIC/C3BmbXvVgFrevHrsSMfeHDaBhXGzjOp+XAgvVdYTW1QspQDzfT4Ngj4WM3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2113
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjcvMDYvMjAyMiAyMTo1OSwgVG9tIFJpeCB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+IA0KPiBjcHBjaGVjayByZXBvcnRzDQo+IFtkcml2ZXJzL3J0Yy9y
dGMtbXBmcy5jOjIxOV06IChzdHlsZSkgVmFyaWFibGUgJ3BlbmRpbmcnIGlzIGFzc2lnbmVkIGEg
dmFsdWUgdGhhdCBpcyBuZXZlciB1c2VkLg0KPiANCj4gVGhlIGZldGNoZWQgQ09OVFJPTF9SRUcg
c3RvcmVkIGluIHBlbmRpbmcgaXMgdW51c2VkIGFuZCBwYXJ0aWFsbHkNCj4gZHVwbGljYXRlcyB0
aGUgZnVuY3Rpb25hbGl0eSBvZiB0aGUgbGF0ZXIgY2FsbCB0byBtcGZzX3J0Y19jbGVhcigpLiAg
VGhpcyBsb29rcw0KPiBsaWtlIGxlZnRvdmVyIGRldmVsb3BtZW50IGNvZGUsIHNvIHJlbW92ZSBw
ZW5kaW5nLg0KDQpJdCBwcmVkYXRlcyBteSBpbnZvbHZlbWVudCB3aXRoIHRoZSBkcml2ZXIgc28g
SSBhbSBub3Qgc3VyZSB3aHkNCmV4YWN0bHkgaXQgd2FzIGludHJvZHVjZWQsIGJ1dCBpdCBsb29r
cyB0byBtZSB0byBiZSBzdXJwbHVzIHRvDQpyZXF1aXJlbWVudHMuDQoNClJldmlld2VkLWJ5OiBD
b25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KDQo+IA0KPiBGaXhlczog
MGIzMWQ3MDM1OThkICgicnRjOiBBZGQgZHJpdmVyIGZvciBNaWNyb2NoaXAgUG9sYXJGaXJlIFNv
QyIpDQo+IFNpZ25lZC1vZmYtYnk6IFRvbSBSaXggPHRyaXhAcmVkaGF0LmNvbT4NCj4gLS0tDQo+
ICAgZHJpdmVycy9ydGMvcnRjLW1wZnMuYyB8IDMgLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ydGMvcnRjLW1wZnMuYyBi
L2RyaXZlcnMvcnRjL3J0Yy1tcGZzLmMNCj4gaW5kZXggZGI5YzYzOGU1MGY3Li5mMTRkMTkyNWUw
YzkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcnRjL3J0Yy1tcGZzLmMNCj4gKysrIGIvZHJpdmVy
cy9ydGMvcnRjLW1wZnMuYw0KPiBAQCAtMjEzLDEwICsyMTMsNyBAQCBzdGF0aWMgaW5saW5lIHN0
cnVjdCBjbGsgKm1wZnNfcnRjX2luaXRfY2xrKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gICBzdGF0
aWMgaXJxcmV0dXJuX3QgbXBmc19ydGNfd2FrZXVwX2lycV9oYW5kbGVyKGludCBpcnEsIHZvaWQg
KmRldikNCj4gICB7DQo+ICAgICAgICAgIHN0cnVjdCBtcGZzX3J0Y19kZXYgKnJ0Y2RldiA9IGRl
djsNCj4gLSAgICAgICB1bnNpZ25lZCBsb25nIHBlbmRpbmc7DQo+IA0KPiAtICAgICAgIHBlbmRp
bmcgPSByZWFkbChydGNkZXYtPmJhc2UgKyBDT05UUk9MX1JFRyk7DQo+IC0gICAgICAgcGVuZGlu
ZyAmPSBDT05UUk9MX0FMQVJNX09OX0JJVDsNCj4gICAgICAgICAgbXBmc19ydGNfY2xlYXJfaXJx
KHJ0Y2Rldik7DQo+IA0KPiAgICAgICAgICBydGNfdXBkYXRlX2lycShydGNkZXYtPnJ0YywgMSwg
UlRDX0lSUUYgfCBSVENfQUYpOw0KPiAtLQ0KPiAyLjI3LjANCj4gDQoNCg==
