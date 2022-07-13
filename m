Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C58573A52
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbiGMPg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237019AbiGMPgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:36:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202C44E84D;
        Wed, 13 Jul 2022 08:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657726574; x=1689262574;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EtJ9Db3aYW1ftSF5gKrZuGUpDaEiK8wbmG0ZvM77u6o=;
  b=1Xqgp3qrC+fchD70Vyxkpnr7UkxPLVU8iv/ByDsBfwX8TWzuz3jgpfeI
   R4IPiep489zeSU6vJWNHlCtJlj3YTg2kCH8F94JVuKYoaiKygxN6ed7Iy
   pK+CB8gSj5DcHCoKNCxrmQ4uKdtG5+2QkV+vYn5vWy/fju1Wn5b8urOn8
   N+okiUpIpJc88DU4HV2DkmhFxjWjZNGZoRMKTw/nEEq5eECxc1tXih/EQ
   iQfdcfhXEMbKSqHZMLMp8LI2Tz0WZyEEiv2SOZzfPIKLWSXTI53RpTGUQ
   3kL5cYPyHqHEWtYIEv02A1M3VsBPb05hNGnx7Nsc1dZGK7RTGL1RnYkKa
   w==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="172223667"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2022 08:36:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Jul 2022 08:36:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 13 Jul 2022 08:36:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOo7fT0WcK7zyi1WcqJZaSTySov+/aRn2KuIVt1t/tuAioQkbl87Eyg56WVd6n2zmB+ogqVKPy5J5q7HZhzXynnZP6AZmS6Q0S1vEZnEZTBjNBYn+2bybwHx7dMPAV4tBhoCx4dBwOhvdJ4sng2K9EM9wdgBCM23g24fpSy7/KbVsUlB9MIDGQQxvaFcfw1s2coFI4HYTtSdyCi0llAo1PeGG39rnNPQlDYN2gW8Lp887eE+m2FK+txASumRrGoYEVCBBtVx852kXF3Fk4osXwM4vqL53efmenKaDprX9xnLimAESP2zZWmXWLoc3uaUfDASh0Cb0eyu578Kcl4ZAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtJ9Db3aYW1ftSF5gKrZuGUpDaEiK8wbmG0ZvM77u6o=;
 b=HGBWjhhI+zxwdXoNEEl/Fj4RX2BLr96gmxDN1isfRVph5up1wfOLC008gd0//i4rHulCraDL4IZ3BWv4dHLhLpcyQzADjRt8u8P8RBG5KkAwVTGCh6Pe6gCTSFENHd3CxiXsnxkyMadqvtCUeQgY1C3nZ5gAFm8xzRuZvG6y064Gs+JOYtGYQAadxoBZn+Pfita32jS/alVTzXyeKGhKLMDot6HyH1OsZgiYT4ynwNvTs6FFW9SglJXupcfE/TVFWrOuidbvtmIYJo6haKNjSNMzUsBcHod6FLYjDMlF8ESRvAOVHIX/8QyOCe+7p9KxTHOitkqSooQCterEKkIF7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtJ9Db3aYW1ftSF5gKrZuGUpDaEiK8wbmG0ZvM77u6o=;
 b=S/HKVOTuZQeoiyTP88X3mq17TIj4Otbg+RHLBecWj2uYr/qEmfzXAhJ+8nZC4DJPcJLWSZP3ZL7hxtvPwr+7zXQ2ToxbEZ/eVYY4OLvswCSThG5bgk1CRgC8ij0dtZLlEgO2Veibl/bTFKT4Jnk6TJkuivTMXtyT3BFq+Ui9LKw=
Received: from PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8)
 by MWHPR11MB1709.namprd11.prod.outlook.com (2603:10b6:300:25::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Wed, 13 Jul
 2022 15:36:11 +0000
Received: from PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::6090:db2c:283b:fe69]) by PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::6090:db2c:283b:fe69%8]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 15:36:11 +0000
From:   <Conor.Dooley@microchip.com>
To:     <uwu@icenowy.me>, <kernel@esmil.dk>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <aou@eecs.berkeley.edu>, <paul.walmsley@sifive.com>,
        <devicetree@vger.kernel.org>, <palmer@dabbelt.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <anup@brainfault.org>
Subject: Re: [PATCH v1 2/2] riscv: dts: starfive: add the missing monitor core
Thread-Topic: [PATCH v1 2/2] riscv: dts: starfive: add the missing monitor
 core
Thread-Index: AQHYlVY+6t1yOzd6XkeyUffI8zZgA618XkoAgAAIQICAAAHzAIAAAggAgAAAx4CAAAJ6gIAAAXSAgAACpgA=
Date:   Wed, 13 Jul 2022 15:36:11 +0000
Message-ID: <83f6eb6e-2f3d-cc65-da94-43879ed3eaad@microchip.com>
References: <20220711184325.1367393-1-mail@conchuod.ie>
 <20220711184325.1367393-3-mail@conchuod.ie>
 <e8543838cd221ab6699da16c985eed7514daa786.camel@icenowy.me>
 <55e9da06-ccdb-f8e5-b5b9-8125b5fbb58a@microchip.com>
 <822ceff8a6e7f41179abde307ce59c2120684294.camel@icenowy.me>
 <6f6fae32-e3dc-4b9b-21b1-cc2ab0c67de6@microchip.com>
 <1dc0f29b40d34bc6472ba4139ff36f63e9cc9e84.camel@icenowy.me>
 <b8fd1440-12f3-05af-5d6c-7938adf66344@microchip.com>
 <b983267d05f4acefb2a37f2ab8dd5d5a1742d9ff.camel@icenowy.me>
In-Reply-To: <b983267d05f4acefb2a37f2ab8dd5d5a1742d9ff.camel@icenowy.me>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c89662a-57d9-4c54-c525-08da64e569c0
x-ms-traffictypediagnostic: MWHPR11MB1709:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ma0lzETPRErN4986k7UjR1qM1XAFBe7CO6M0pCNw5ffo70SwYwDBu+KaRvi+WcM+WwphwgiHhnTSOzMywOSc0KwO9x1JzrTMkIPkqoQpGo56CI3lGRwwoiDBTme/bKeEM14tAK/gReTkaDsuoV2f5gyy6Telx/a9xTOLqmsEG1ucOS8RlmA+5B+1lTFn4NpCANRC02cttUDpMaYFCC0Qbr+s+tTkBafK8rvq+YSF1ZJnVQUz82qJGA+OyBiwxuZ+oqM9QvVDn6Esprw7HuzFdBepGvzvuZVIeEY5nCIfoEWYaVNsX0O/0jdzqSn8oHlMC3w4Esbodn2lL0Akj17XsMOGD6t3a7V4JA48vIt3+r69hs3LSvY+Fw7e5iuJKH+fxECFnfAADOpY8zMJD7O/FtTqQi3MXYmzEWWsBJGt0K/QeZTnGzBTsqr1snEDBHUiDsefBW7AszUWZh6pWK053t2d+vAEpIPIUwlrOSmjkcRpS8aEhtiHFvuxdDUL/r/LLqF8dqZseRwAb/OcySByO3IRsTs7kP4hVMJGjWa6iJ5CZyh8jNY5+hAfQYav9Spi6RIAC+x85G5So9qC0smxaA2jC0sF4G9I139EMxP/DkhHcaMyPbqk9VNWOec4d5Ol6YG9dYXqLdrjzkElK6UrsVKUCVCxLgQrytJx10ZR403MCb2EhcBqAiVySoElsNVd/CMFBW39slYWf+Dk2ciBqKClVi64Q27PE/8CyopDkfQO/jQVPOEMOJ1raDw68Zrg6tzjwqRNOh3rJwi90tpnA98+ekyWDc3rVigj+mzGA8ShN3TNmklsKZO+8+xuMMKPWZyo8oJzc8w5vHmAInRosZYAYFt4I9hXPsg5Jbe3Ty7eBKIABBrXJwY8YXbX/Hi/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5160.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(376002)(39860400002)(346002)(396003)(83380400001)(36756003)(31686004)(4326008)(110136005)(8936002)(41300700001)(54906003)(38100700002)(6506007)(71200400001)(86362001)(26005)(66556008)(2906002)(38070700005)(53546011)(91956017)(8676002)(76116006)(66946007)(316002)(66476007)(2616005)(66446008)(6486002)(7416002)(5660300002)(6512007)(122000001)(64756008)(186003)(478600001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHFHNE9FRVR3emJaSFQyS1dWcUJHM0I4NGlWSXpWQjRmRjVSTlIxNVUxaVZr?=
 =?utf-8?B?WXdVNnRHOGpiSGFnSUV5ZUpsKzRuMVl5NnlSSG9RYkxzQlVhSUxkajRVREZ2?=
 =?utf-8?B?Yk5aRDBKUmtDS3JPOU5JRWxEcFNHd0hJUTZWcmw4SHpscnk4VWlLZTlNWmor?=
 =?utf-8?B?ZEVoMnFiL0VmTzhJQWFISXozOUtDWkwyMlVpcTVzNHJyZVFUamJJVkQzRTVr?=
 =?utf-8?B?b0NyaTRDWDBuSTZodEp1YzVNU0UvUXIzcW9NSDU4R1pIcUNua3MweU1qRTJi?=
 =?utf-8?B?UEVOUGRqYmROOWFDeUdrWFFtVlVTeVh5OXdOd1k0UG9pbUgzVUcxL2h4MDlZ?=
 =?utf-8?B?aXgwcHNjMWZkVHc0ZzNNR01JTDFsTWhTczdHbDZ6MjBKNWZTN2l4S2pncHRu?=
 =?utf-8?B?M25oWDVnUTVIMnhiRlg4RFAyd1N1elJMZTJDNno3c21pYTJ5QTJtUkJhR013?=
 =?utf-8?B?MUNDNHNta0kzMXQyV3F4bUJ1dTROSlpUVFBtZlIyWEVIaE1kbzNBbCtKZFAz?=
 =?utf-8?B?cy9tZTQ4VXBralFxaDh0cHVVNi9MekhLRXhSdzlkVkphNFltdHV3OW1HTzRh?=
 =?utf-8?B?b0VwTmNKbzVtRUpjOTRvNU8rOWVwM25CSDM1UUN1N0NCQnRoN2dOY1ZwYmVX?=
 =?utf-8?B?T2NMbUREYndIL05NeENiVUpWaHN4K1N2M2RLL3lnZXlKdkxWaHRjTHYydXVx?=
 =?utf-8?B?ZGl3WGNKUm5UV2lCSHI3Y1UzYUxiQVNkdWFqUklweEhJWlZUclAwU2wwa2xo?=
 =?utf-8?B?Nzc5RExnMDh5dXBtRmF3VGE4VVhKcmRPUHBJeGFSdG9sUHBXQlp3MEN1cnRQ?=
 =?utf-8?B?dEdlT1pQWWFTRnlRVVdFbCs3LzNkcU1TWk9MUDNJRGhiWHlUZW1jeEU1SGhM?=
 =?utf-8?B?OW15VHh0clhrdmhZaGhCQjViNnZBRWQraWFJTEF2dXBKZklmUkk0Mm50YStL?=
 =?utf-8?B?ODQ5RUE2eFlKdStOdFRsNThKK04zemVGc0k0ZmF2bjcwb3VZNUFZK3ptdmNU?=
 =?utf-8?B?clMrNGE4UVJXTU1ZZklxcmttbHNtUnExWWVVcU0wSlRLOXhGNHJxVGRNVTQv?=
 =?utf-8?B?bWt3bVh1WGtJSXN2V1JYUmFUd2FEOGNsR2pFNXZxZzQzRk1mMUlwS3BjY2xS?=
 =?utf-8?B?TG1rQzlQYTkvUmYycmhzNEZ3TjMxMHduSmxRYlhBeXFRS0FRaFE3WXVZT1d5?=
 =?utf-8?B?aC85NmQzWm45UW03aVkydGZtVUY2QmN6U3VlQWtUSlRRWS8wZ1ZkNGU4MWMy?=
 =?utf-8?B?NE85T2xBNHhXMTBVYWNQY3VsSlkwUXpYbkJsczhyZ3RGaTlzaXZVaFk2QUYr?=
 =?utf-8?B?RTlEMVBUd29MU29Sd2ZLY21JNm5tbVI0ZWhhTGFBcHUrUnh3Q0xMc0ZFRTM3?=
 =?utf-8?B?UzdJT1M1VmNmQjV5U0tScldhZDlDZVVtcGpLSjJBdC9TQS9IRkdTaDBMa0dw?=
 =?utf-8?B?WXdsMjZLc0JBV3VmVWpMR2E2Z2l3Y0pWSmM5dHBkWEwyRGNDTFVkdHltTWhB?=
 =?utf-8?B?ak1ha25wWE1NUllHRUtmazUvclhFT0JUenJ6cXNBWjN2eVpsRWwrYWNZeXhk?=
 =?utf-8?B?RzdQZXdmUUQzdWZzOFYyajdaaWZmc0VNa1kxeHFJa3BveVMrSzlzS25EanUw?=
 =?utf-8?B?WW1Hc2tGVngva1ZXSE4ySDNiMlNDV010N25iYkwzdVY5VzR5SW1ZdlVabGs5?=
 =?utf-8?B?ZncvNmdyV1J6THZyMmVsa3EyejMyRTdkd1NVZk1UL3oxbDBWVk5pWGdEUWZl?=
 =?utf-8?B?cGNod2s5bStvVmd0RkIrNGRoYitTQ2lja2tSaFJjNElNTVd6ZldJQlFxYjQr?=
 =?utf-8?B?TDhpdjBVVFE2MTlTdExRdDVMckVrSlBhMSt2TnpYa1lza0g2dWZBK0l5Q3F4?=
 =?utf-8?B?dFZqL2JZMEJOVkdUTCtYOGx6Y3lpSzhhMXpGdWtWeWxPd1NpaWVGNmg1Q09X?=
 =?utf-8?B?SWl0UXdwaFhqeHpRaFpRMkkrOU93bGNORkFxaTRKc3NQVkhCNWR2aHE3SHRx?=
 =?utf-8?B?RVNKeUcrdERsNlpETmtRbEUvTndwUERIVXF5OXNQTGVLbmlIaVJHRk1DMVBD?=
 =?utf-8?B?eW9jNUVkZk5qV0tjTEh1d25JUThySnVOZThOZ2xsNmgwZTlHdFd2ZVdjaHRY?=
 =?utf-8?B?RjY3Z1lrL2J2K2dUSWZKQW56RmFSZWtEbmlmMUkrcVZHKytzY0NUeTlobkJF?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D6A8739D97CA149A5C1F47569DF596F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5160.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c89662a-57d9-4c54-c525-08da64e569c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 15:36:11.0251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ooVPQy9srML+5BzmwwRSm000TKYhugmjfFtzuNGLUJXcFTBzeLDect95Wh8+082utenzRivr6G8pxNibDMydwbmaTFMRaNDLA70++Pomwvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1709
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Um9iL0tyemssDQpHb3QgYSBxdWVzdGlvbiBhYm91dCBob3cgdG8gcmVwcmVzZW50IG9uZSBvZiB0
aGUgY3B1IGNvcmVzIG9uDQp0aGlzIFNvQyBhdCB0aGUgZW5kIG9mIHRoZSBtYWlsDQoNCk9uIDEz
LzA3LzIwMjIgMTY6MjYsIEljZW5vd3kgWmhlbmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4g5ZyoIDIwMjItMDctMTPmmJ/mnJ/kuInnmoQgMTU6MjEg
KzAwMDDvvIxDb25vci5Eb29sZXlAbWljcm9jaGlwLmNvbeWGmemBk++8mg0KPj4gT24gMTMvMDcv
MjAyMiAxNjoxMiwgSWNlbm93eSBaaGVuZyB3cm90ZToNCj4+PiDlnKggMjAyMi0wNy0xM+aYn+ac
n+S4ieeahCAxNTowOSArMDAwMO+8jENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29t5YaZ6YGT77ya
DQo+Pj4+DQo+Pj4+DQo+Pj4+IE9uIDEzLzA3LzIwMjIgMTY6MDIsIEljZW5vd3kgWmhlbmcgd3Jv
dGU6DQo+Pj4+PiDlnKggMjAyMi0wNy0xM+aYn+acn+S4ieeahCAxNDo1NSArMDAwMO+8jENvbm9y
LkRvb2xleUBtaWNyb2NoaXAuY29t5YaZ6YGT77yaDQo+Pj4+Pj4gT24gMTMvMDcvMjAyMiAxNToy
NiwgSWNlbm93eSBaaGVuZyB3cm90ZToNCj4+Pj4+Pj4gU29ycnkgYnV0IEkgdGhpbmsgdGhpcyBj
aGFuZ2UgbWFrZXMgdGhlIHRvcG9sb2d5IG1vcmUNCj4+Pj4+Pj4gaW5hY2N1cmF0ZS4NCj4+Pj4+
Pj4NCj4+Pj4+Pj4gVGhlIEUyNCBjb3JlIGlzIHZlcnkgaW5kZXBlbmRlbnQsIGp1c3QgYW5vdGhl
ciBDUFUgY29yZQ0KPj4+Pj4+PiBjb25uZWN0ZWQNCj4+Pj4+Pj4gdGhlDQo+Pj4+Pj4+IHNhbWUg
YnVzIC0tIGV2ZW4gbm8gY29oZXJlbmN5IChFMjQgdGFrZXMgQUhCLCB3aGljaCBpcyBub3QNCj4+
Pj4+Pj4gY29oZXJlbmN5LQ0KPj4+Pj4+PiBzZW5zaWJsZSkuIEV2ZW4gdGhlIFRBUCBvZiBpdCBp
cyBpbmRlcGVuZGVudCB3aXRoIHRoZSBVNzQNCj4+Pj4+Pj4gVEFQLg0KPj4+Pj4+Pg0KPj4+Pj4+
PiBBbmQgYnkgZGVmYXVsdCBpdCBkb2VzIG5vdCBib290IGFueSBwcm9wZXIgY29kZSAoaWYgYQ0K
Pj4+Pj4+PiBkZWJ1Z2dlcg0KPj4+Pj4+PiBpcw0KPj4+Pj4+PiBhdHRhY2hlZCwgaXQgd2lsbCBk
aXNjb3ZlciB0aGF0IHRoZSBFMjQgaXMgaW4gY29uc2lzdGVudGx5DQo+Pj4+Pj4+IGZhdWx0IGF0
DQo+Pj4+Pj4+IDB4MA0KPj4+Pj4+PiAobXR2ZWMgaXMgMHgwIGFuZCB3aGVuIGZhdWx0IGl0IGp1
bXBzIHRvIDB4MCBhbmQgZmF1bHQNCj4+Pj4+Pj4gYWdhaW4pLA0KPj4+Pj4+PiB1bnRpbA0KPj4+
Pj4+PiBpdHMgY2xvY2sgaXMganVzdCBzaHV0ZG93biBieSBMaW51eCBjbGVhbmluZyB1cCB1bnVz
ZWQNCj4+Pj4+Pj4gY2xvY2tzLikNCj4+Pj4+Pj4NCj4+Pj4+Pj4gUGVyc29uYWxseSBJIHRoaW5r
IGl0IHNob3VsZCBiZSBpbXBsZW1lbnRlZCBhcyBhIHJlbW90ZXByb2MNCj4+Pj4+Pj4gaW5zdGVh
ZC4NCj4+Pj4+Pg0KPj4+Pj4+IE1heWJlIEkgYW0gbWlzc2luZyBzb21ldGhpbmcsIGJ1dCBJIGRv
bid0IHF1aXRlIGdldCB3aGF0IHRoZQ0KPj4+Pj4+IGRldGFpbA0KPj4+Pj4+IG9mIGhvdyB3ZSBh
Y2Nlc3MgdGhpcyBpbiBjb2RlIGhhcyB0byBkbyB3aXRoIHRoZSBkZXZpY2V0cmVlPw0KPj4+Pj4+
IEl0IGlzIGFkZGVkIGhlcmUgaW4gYSBkaXNhYmxlZCBzdGF0ZSwgYW5kIHdpbGwgbm90IGJlIHVz
ZWQgYnkNCj4+Pj4+PiBMaW51eC4NCj4+Pj4+PiBUaGUgdmFyaW91cyBTaUZpdmUgU29DcyAmIFNp
Rml2ZSBjb3JlY29tcGxleCB1c2VycyB0aGF0IGhhdmUNCj4+Pj4+PiBhDQo+Pj4+Pj4gaGFydA0K
Pj4+Pj4+IG5vdCBjYXBhYmxlIG9mIHJ1bm5pbmcgTGludXggYWxzbyBoYXZlIHRoYXQgaGFydCBk
b2N1bWVudGVkDQo+Pj4+Pj4gaW4NCj4+Pj4+PiB0aGUNCj4+Pj4+PiBkZXZpY2V0cmVlLg0KPj4+
Pj4+IFRvIG1lLCB3aGF0IHdlIGFyZSBjaG9vc2luZyB0byBkbyB3aXRoIHRoaXMgaGFydCBkb2Vz
IG5vdA0KPj4+Pj4+IHJlYWxseQ0KPj4+Pj4+IG1hdHRlciB2ZXJ5IG11Y2gsIHNpbmNlIHRoaXMg
aXMgYSBkZXNjcmlwdGlvbiBvZiB3aGF0IHRoZQ0KPj4+Pj4+IGhhcmR3YXJlDQo+Pj4+Pj4gYWN0
dWFsbHkgbG9va3MgbGlrZS4NCj4+Pj4+DQo+Pj4+PiBUaGUgRTI0IGlzIG5vdCBpbiB0aGUgY29y
ZSBjb21wbGV4IGF0IGFsbC4gSXQncyBqdXN0IGEgZGVkaWNhdGUNCj4+Pj4+IENQVQ0KPj4+Pj4g
Y29ubmVjdGVkIHRvIGFub3RoZXIgYnVzICh3ZWxsIGFzIEkgc2F3IHRoZSBkb2N1bWVudCBzYXlz
IHRoZQ0KPj4+Pj4gRTI0DQo+Pj4+PiBidXMNCj4+Pj4+IGlzIG1heGltdW0gMkcsIEkgZG91YnQg
d2hldGhlciBpdCdzIHRoZSBzYW1lIGJ1cyB3aXRoIHRoZSBVNzQNCj4+Pj4+IG9uZSkuDQo+Pj4+
Pg0KPj4+Pj4gVGhlIFU3NCBNQyBvbmx5IGFsbG93cyBTNSBtYW5hZ2VtZW50IGNvcmVzIHRvIGJl
IHBhcnQgb2YgaXQsDQo+Pj4+PiBub3QNCj4+Pj4+IEUyNC4NCj4+Pj4NCg0KLS0tODwtLS0NCg0K
Pj4+DQo+Pj4gQ29uc2lkZXJpbmcgRTI0IHNlZW1zIHRvIHNlZSBhIHRvdGFsIGRpZmZlcmVudCBi
dXMgY29ubmVjdGVkIHRvIGl0LA0KPj4+IEkNCj4+PiBkb24ndCB0aGluayBpdCBldmVuIHByb3Bl
ciB0byBhZGQgaXQgdG8gY3B1cyBub2RlLg0KPj4NCj4+IFdlbGwsIGl0IGlzIGEgQ1BVIGlzIGl0
IG5vdD8gSG93IG9uZSBpcyBzdXBwb3NlZCB0byBkb2N1bWVudCB0aGF0IGENCj4+IENQVSBpcyBu
b3QgYXR0YWNoZWQgdG8gdGhlIHNhbWUgYnVzZXMgSSBkbyBub3Qga25vdyBob3dldmVyLg0KPiAN
Cj4gSSBkb24ndCB0aGluayB0aGlzIGtpbmQgb2YgQ1BVcyBzaG91bGQgZXhpc3QgaW4gL2NwdXMs
IHRoZXkgc2hvdWxkIGp1c3QNCj4gYmUgc2VlbiBhcyBwZXJpcGhlcmFscyBhcyB0aGUgbWFpbiBz
eXN0ZW0uIFRoZSBzcGVjaWFsaXR5IG9mIEZVWzU3XTQwJ3MNCj4gbWFuYWdlbWVudCBjb3JlIGlz
IHRoYXQgdGhleSdyZSBpbiB0aGUgc2FtZSBjb3JlIGNvbXBsZXggd2l0aCB0aGUgQ1BVDQo+IGNv
cmVzIHRoYXQgcnVuIExpbnV4LCBqdXN0IGNvcmVzIHdpdGggYSBkaWZmZXJlbnQgY2FwYWJpbGl0
eSB0aGF0IHdlDQo+IGNvdWxkIG5vdCBleHBhbmQgTGludXggdG8gdGhlbS4NCg0KTWF5YmUgUm9i
IG9yIEtyenlzenRvZiBjYW4gc2hlZCBzb21lIGxpZ2h0IG9uIHdoYXQgd291bGQgYmUgdGhlIGNv
cnJlY3QNCndheSB0byBkZXBpY3QgdGhpcyBjcHUuDQoNCj4gDQo+Pg0KPj4+DQo+Pj4gQW5kIEkg
ZG9uJ3QgdGhpbmsgaXQgaGFzIGEgaGFydCBpZCBvZiAyLCBhcyB5b3VyIG5vZGUgZGVzY3JpYmVz
Lg0KPj4NCj4+IERvIHlvdSBoYXZlIGFueSBpZGVhIHdoYXQgaXQgd291bGQgYmUgdGhlbj8NCj4g
DQo+IEFzIEkgYXNrZWQgb25lIG9mIG15IGZyaWVuZCB3aG8gaGFzIEpUQUcgYWNjZXNzIHRvIEpI
NzExMCwgdGhlIGhhcnQgaWQNCj4gaXMgMCwgdGhlIHNhbWUgd2l0aCB0aGUgZmlyc3QgaGFydCBp
biBVNzQtTUMuDQoNCkhtbSwgbXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IHRoZSByZWdzIHByb3Bl
cnR5IG5lZWRzIHRvIGJlIHVuaXF1ZSwgc28NCml0J2QgaGF2ZSB0byBzdGF5IGFzIDIuDQoNClRo
YW5rcywNCkNvbm9yLg0K
