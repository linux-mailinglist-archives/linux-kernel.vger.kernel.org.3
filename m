Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248345B1E19
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbiIHNKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbiIHNJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:09:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E262C2E9;
        Thu,  8 Sep 2022 06:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662642572; x=1694178572;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pUpnc7RtVD4437HqXTQlRxhP8UJLOHCDExbimp+qeU4=;
  b=hWovdNUmlYASXvPda8gStIT5I+c8WPGLX6nB0Zl0zgXlQ/IuJGb4fcTu
   Jn3QHH5uqIkLvktPvrvBuu/+bKg/8PI3QSgJQ/ZBy63S3FgZs3Twme91B
   scYcUayLqv7UTjds7idXe4aICZqbL4owy/w15pwcZvFBUpm8u3VVTaE5l
   jGQHtnDHZkA0SdXKFeC2Oi8ustHq4sM7qSoLC8FkHSPy0/V/kn59C14Ll
   nfIaVfIrOQmbKqvqFOPiQByMPlT92bjRubLnYodMU7mAuKYG7CZw/0Ptc
   jjnJtHerzPpynE+OchsRSBHbGGDXwAreyioUFeP4FGvIH75VfywL2wzt2
   w==;
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="179691234"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2022 06:09:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Sep 2022 06:09:24 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 8 Sep 2022 06:09:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBTZYh2kpqjFtn99ASTcHfPXrZZtix2geJoBmPbgLATWoXvB8U2n55RwXU6U8v9cXsWQWchpwmCh+HzcqgFjcTCNFo6DHJnyQ3iUo9pUY1pP0nAdHA/0uu+shE31Kmpx/ZBzhrxLJu08WnvrIfUd6RCKaWz57rYFgyHz0XEf/s42DG13OjFIIJSMWsohsDhm/jKux3EX1QOR8LbFfhgYk5vQTfHmMNhktDTw5gZGETe1sKNJXi4X4Yz18qP843V/yd1DqoELEctS5QDz/pYTxkezbNq+UDWwGBhhlICvuy9Rz3bpjS4chzhHLMZZB67NKKhrWSqkdqfGHhMsI5AzDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUpnc7RtVD4437HqXTQlRxhP8UJLOHCDExbimp+qeU4=;
 b=Zp6JNtsESJuC6xLvZlBxyidKHGfPyX+1U1BwJk7KlSkbBFe/2vsCrzOzES2RfGkQaECDjpRnaU0gluu04gd20CsRqr4Al2Y5Zk9y/k71/j/s/Wx3ExjKoviiY11oWlhBl9IwyD4q30P/avq+7CplQBlezt1XgiK7jDXiSHT8tGv4xpcNfalzu9fZl/h82AcfoPjJTvs4gIStqouhTvvewxIS03XCTXr3Tke6KJbvctXlEDChLoG9HjQj213GY78+0oMrvUafhwNK9bZGtXnbmNb6X2/eRv7ZRcnntrQ8dWdhTye5oqOGcmk+nsbpG3CIbIuA/+fLTO7we1lVTC/W4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUpnc7RtVD4437HqXTQlRxhP8UJLOHCDExbimp+qeU4=;
 b=plXCpFiyhsTYlwUCOpUJ3mHp3LzV80P4YCg2fmIrCxAmT5mHQpG7d5tuS0NhongJjjEmrSMl7wchXNXhDmnXXURscyAH3KBY0Fxi5dQnE22qoBKv8XZJVxc36OD0ULbdDDEpfxoR4erkcVCF4MnP2eL7WvW4qRFWqxxUDJBYv9U=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SA2PR11MB5065.namprd11.prod.outlook.com (2603:10b6:806:115::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Thu, 8 Sep
 2022 13:09:22 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 13:09:22 +0000
From:   <Conor.Dooley@microchip.com>
To:     <James.Bottomley@HansenPartnership.com>, <wangjianli@cdjrlc.com>,
        <damien.lemoal@opensource.wdc.com>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/ata: fix repeated words in comments
Thread-Topic: [PATCH] drivers/ata: fix repeated words in comments
Thread-Index: AQHYw4HU5JmlvwEteEqsIkclDNNdvK3VfdGAgAABoACAAAHiAA==
Date:   Thu, 8 Sep 2022 13:09:22 +0000
Message-ID: <a9052683-13a2-1e90-db90-ca9410fafd89@microchip.com>
References: <20220908124937.25962-1-wangjianli@cdjrlc.com>
 <e2f882f7-6871-a754-fbbd-6a5201f45f4a@microchip.com>
 <3a73cf7f02915891c77dc5a3203dc187f6d91194.camel@HansenPartnership.com>
In-Reply-To: <3a73cf7f02915891c77dc5a3203dc187f6d91194.camel@HansenPartnership.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|SA2PR11MB5065:EE_
x-ms-office365-filtering-correlation-id: 0e874de1-f4cd-4a85-4a29-08da919b58c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: De9BqR9ylNP0EzAR9znBuBnWacGHWb+cJz6q8gtjwD4xE/Gzn4xw4tjRwZiYc6s1ZXmc1tMGMuf6+t/jmVmzZCK/2U5HfO6WdHEGMRY1+JKJu2kAqxjX/gXiqXIXID9yjguTTJMAIgYeZDj2rN4nQpxOf8aBQec2gghzeB2UfjzvbfSQ4QQzKGfdb2R9rkY1GjB6E0PuXzplvoer5YcCcFcNxnaip5Kc+haNitgbzBNlBrahHTaZv8/QQEzGEdo3JPpv80KwbF/kyoQLvyMGNjynoU5Pe2596lbI+RXNmb5DANos4H+2EHAaqnOXwXMiDAl7c8+9aL9VsRKhg9E5oHp7qcwPV2m8rF2Np0L9RIvXbOIpAcOE7eIbD1WcNOIOMNXJCYbTgHBPw40wmje3YPyukMZgxNpKbwTN3SSHYc7SImoMhpDyxo/rpFHMn6mdKVqS3TwCiAKT6+sS4hV02zYxEMTJZu1Iq3dcnB1sknrVpSQrfPzW7UIJtnSnveVxuFdfkNy0lfCdOEXOEkTfgk3rESlyF2rrKJWmpKx6pe2SxXPsHeLgDFv3xRjIjDHkxkpKbMG9SXh2XBE/MzNpLnDjvuXihnhyTK6cFFu8VXhkSIyjwJmQRSJwpBXaDaz2hioP4Mkf/3WM2txLkoxqr4nIKKvvB2RGOB5Vxp3xZd6Qz7kshPmpycKxRPw0MTWVCAgUX/5tipAnrobtcHJn9F8qqRbwEEhZEurbRsQBfOpszhKnnJUgXk8RTkQW+0XKe6a3+1sieIiWX4akLXjGGN7vG1iXN6kgUkcZD83avXagyZ/A7rgENvMW0eOQcGvTuFRoef9skUDX3sKRZGhN/d/Wclr9vuQGqFFJBqEJQuM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(136003)(346002)(376002)(396003)(31686004)(38100700002)(122000001)(83380400001)(186003)(2616005)(36756003)(31696002)(5660300002)(54906003)(64756008)(66446008)(2906002)(110136005)(66476007)(66556008)(66946007)(316002)(8676002)(4326008)(91956017)(76116006)(8936002)(86362001)(71200400001)(6506007)(38070700005)(53546011)(6512007)(26005)(6486002)(508600001)(41300700001)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUhJUmlscWYzcThNR1pRUzhyQTM3UmF5OEN6SVJ1WithaVg2Q2VCbk00RGVi?=
 =?utf-8?B?YTY0UjhVL3k0cXpNaHNiSG80aW5CWHFGaEIxbU03RW9EWWFsYlhJWlIxeVMz?=
 =?utf-8?B?Z3dNTjFPYXIrTUdETkFvTVhTVEQ2L2E1TGduWlFzczRLZC83NWpaVmxmV1F6?=
 =?utf-8?B?VFYvSnJHZnhxUXI5QTNsK1JxejZaeXlyM3poQU1DUzZ4aXZqQUFZTnNsV2tO?=
 =?utf-8?B?V0I2K0Q3NitIdVlqa3JQQ2FaMWdsN295LzA2SndPVmE4Z3c1S3RCSExmNzNT?=
 =?utf-8?B?TWpQVnVmNHp2NjBZVFNlb1lnWUFDaVNRWHRzUUduMG1zNHF0RlBCd0dtSWJH?=
 =?utf-8?B?NUhBajR2Nlp6bjhVbHNURVFjcEcwd2JyQ2RWSnh4bTZLRFdXaUUvNjh4NlZF?=
 =?utf-8?B?OFR1a0VaQ3l3M0JJeE8zRXh3QlBQUDFGYTNFOWw1UzVDNjBWd29neFdqTWJx?=
 =?utf-8?B?YitodzZsMzRvalFlODZFbUcvazQxMmNERksxeWF3eWtHS0x4UWxLVGVtTXVq?=
 =?utf-8?B?akN1MXlUODZRWkRQM3U3RDQ0VHpvUFE5ZWhhTFpHT1BiNzJJUFI3NzV1S094?=
 =?utf-8?B?Tm9zWnZ0RXh6VTY4VG1icjl2T2NqUE9DemM1SkNFQ1VqUHdUQkRMVEZvN2o4?=
 =?utf-8?B?Wks5UEhVRGFrcDdDc1lkbWFERlFlU0ZFWmZIN2c3WXlpVjJmT2NQSHN1eWE2?=
 =?utf-8?B?WjFPMGV6OFo3NFVvdkVFU1FNKzVpaTk4OUNNSldwbTAyN0JyWERhM2NTS3lp?=
 =?utf-8?B?K01RN2VmN3JCeFV2VlZFS1BMQ2lKM1N0SWwrRlZpQXg1bDd2U0ZuQ3N5cXdt?=
 =?utf-8?B?SWdPK3FhTTc1a01GT3hDSldPTmd6enhPSUZTQTFjY1BSdlV2R2FwVWl3STJ0?=
 =?utf-8?B?OStZMWlJdkFEQmljS1hhckdsekFYOXhzMXVtUHBTUUE3OTVVc1ZFUzYyZDVo?=
 =?utf-8?B?UFI4d3Z6dHdOR0xicWVkNEpyTWlPTnRjdEM5L3hZSnMxY1NPYjluYjgxczVn?=
 =?utf-8?B?QmNDdGsrVlFobHRidzBHalRNb2hPbFdmSzhTV29KQ0tKSDN5SENLZEtER0VU?=
 =?utf-8?B?R0pnRDg4WGJnaG1kZDZ2WGpnN2JuTmR4M2NMZVFrOHZiWDFMZGdCc3hlSDU1?=
 =?utf-8?B?VDJHenFCZXY1cjdnSEU5eCtmcURtSGM0YS9YM2xwWnY3VkpWdUtRWDZjc0xM?=
 =?utf-8?B?ODhtQkVHWWNONC9SK0h1MzNmV2hvVlhHeDJDMThxanIwZEdFMTB1MHFZYzBQ?=
 =?utf-8?B?ZWhlZVAxeUlGSVY3N3cyYkJQNGpCRFhjOU1BVi8ra0F6SnB6c3hqQ1lSaWpI?=
 =?utf-8?B?RVBOY2RJS1ZJaVg3cnRRdnVjb3NaYjFvK3Y1ZXFaT2pOajlIME5KMWtHQldT?=
 =?utf-8?B?RVl3K0Q5cG1XS0ZidEFQbWNLWVk5V0FGSWwrTVhYNm1TVGUwYkpQRUt3VW8v?=
 =?utf-8?B?VHNBYTB0QytQTVJWQ3puc2huQjFHaS9EZ05ENkN6ZzNmSTVSZlY4TnBLL3RJ?=
 =?utf-8?B?eFkxU1FtYWV0N3FqYU94R2JydWg1ZXFVbnVRdEZheW9JeUFHYmpYRW95TXU4?=
 =?utf-8?B?MjhTTzNuUUdwTXRaZVgwMEJlMnF5OVBYRkVHajRHSDRyNWtxNGhaQ2J5TllW?=
 =?utf-8?B?WkhJS2w3V2ZmZjlaZFljdW1zOW5reDNaSVpEbllHMTJSUWVxUHJkNEV2Qm1i?=
 =?utf-8?B?ZmZiNFkyQ09nc1JFeVJoekZkUDU2dWwweDIyVE56VUNCeE9sT3BvOGEzVkFr?=
 =?utf-8?B?SG90Um12WU15OFVjRFpNUHcvbHdpZ0ZRQVN4VE5yMkI1L3Q0WkdBNC9wcFpK?=
 =?utf-8?B?ZWYvMThMRlhsM1VvR1YwZXNIS0VGQmFXYktrbWwyZXJGTEhDNTU1dEcxWHpr?=
 =?utf-8?B?cXowL09WNlhEYlhqSzN3TytDNERvZG9lSDNpUlBxelNCSEpYSHNoUWNkTnhz?=
 =?utf-8?B?bVVWZzNySmM4L2E5SytiekhlcXc3YU9EZGxaOWhiV2RDMVR5VW5vNkdrMEdq?=
 =?utf-8?B?UzB6SS94Q2x5aFE5bWEyNGI1ZWU2d2pEellqQWIvQzB2U1NRUzZqNnZoRG5s?=
 =?utf-8?B?ck42NVJNYyt5WlZlOG81bVpIWmt0Yi81eTFQcU9LdFBnOTBJQm9sdXhadk5n?=
 =?utf-8?Q?27xRBSojsRzZipwLrXJ7Rgaod?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B1C978F4505DD498BBA673B83C339EA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e874de1-f4cd-4a85-4a29-08da919b58c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 13:09:22.1381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kZKphss2R/BUKZrfU1z5HPuy2cYEOTW5zytdhgaisg5arsTwGXiRlhq0QxR2IOdsSIynPh5VElM9MfKi8oczKCIYM6FRqydvaJyPHQtcK+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5065
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDgvMDkvMjAyMiAxNDowMiwgSmFtZXMgQm90dG9tbGV5IHdyb3RlOg0KPiBbWW91IGRvbid0
IG9mdGVuIGdldCBlbWFpbCBmcm9tIGphbWVzLmJvdHRvbWxleUBoYW5zZW5wYXJ0bmVyc2hpcC5j
b20uIExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFi
b3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPiANCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVu
dCBpcyBzYWZlDQo+IA0KPiBPbiBUaHUsIDIwMjItMDktMDggYXQgMTI6NTYgKzAwMDAsIENvbm9y
LkRvb2xleUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gMDgvMDkvMjAyMiAxMzo0OSwgd2Fu
Z2ppYW5saSB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQ0KPj4+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2Fm
ZQ0KPj4+DQo+Pj4gRGVsZXRlIHRoZSByZWR1bmRhbnQgd29yZCAnaW4nLg0KPj4+DQo+Pj4gU2ln
bmVkLW9mZi1ieTogd2FuZ2ppYW5saSA8d2FuZ2ppYW5saUBjZGpybGMuY29tPg0KPj4+IC0tLQ0K
Pj4+ICAgIGRyaXZlcnMvYXRhL2xpYmF0YS1laC5jIHwgMiArLQ0KPj4+ICAgIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvYXRhL2xpYmF0YS1laC5jIGIvZHJpdmVycy9hdGEvbGliYXRhLWVoLmMNCj4+PiBp
bmRleCA3YzEyOGM4OWI0NTQuLmNhODY1YTk1Y2YyNCAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJz
L2F0YS9saWJhdGEtZWguYw0KPj4+ICsrKyBiL2RyaXZlcnMvYXRhL2xpYmF0YS1laC5jDQo+Pj4g
QEAgLTg2Myw3ICs4NjMsNyBAQCB2b2lkIGF0YV9laF9mYXN0ZHJhaW5fdGltZXJmbihzdHJ1Y3Qg
dGltZXJfbGlzdA0KPj4+ICp0KQ0KPj4+ICAgICAqDQo+Pj4gICAgICogICAgIFNldCBBVEFfUEZM
QUdfRUhfUEVORElORyBhbmQgYWN0aXZhdGUgZmFzdCBkcmFpbiBpZg0KPj4+IEBmYXN0ZHJhaW4N
Cj4+PiAgICAgKiAgICAgaXMgbm9uLXplcm8gYW5kIEVIIHdhc24ndCBwZW5kaW5nIGJlZm9yZS4g
IEZhc3QgZHJhaW4NCj4+PiBlbnN1cmVzDQo+Pj4gLSAqICAgICB0aGF0IEVIIGtpY2tzIGluIGlu
IHRpbWVseSBtYW5uZXIuDQo+Pj4gKyAqICAgICB0aGF0IEVIIGtpY2tzIGluIHRpbWVseSBtYW5u
ZXIuDQo+Pg0KPj4gSGV5IHdhbmdqaWFubGksDQo+PiBUaGlzIGRvZXMgbm90IGxvb2sgbGlrZSB0
aGUgcmlnaHQgZml4IHRvIG1lLi4gVG8gbWUsIGl0IGxvb2tzIGxpa2UgaXQNCj4+IHNob3VsZCBi
ZSBzL2luIGluL2luIGluIGEvLg0KPj4NCj4+IElmIHlvdSdyZSB1c2luZyBhbiBhdXRvbWF0ZWQg
dG9vbCwgd2hpY2ggSSBjYW4gb25seSBhc3N1bWUgeW91IGFyZSwNCj4+IHRvIGZpbmQgdGhlc2Ug
dHlwb3MgaXQnZCBiZSBhIGdvb2QgaWRlYSB0byBjaGVjayB0aGUgb3V0cHV0IGZvcg0KPj4gY29y
cmVjdG5lc3MgcHJpb3IgdG8gc2VuZGluZyBwYXRjaGVzLg0KPiANCj4gQW5kIGl0IHdvdWxkIGFs
c28gaGF2ZSBiZWVuIG5pY2UgdG8gYWNjb21tb2RhdGUgdGhlIGV4YWN0IHNhbWUgZmVlZGJhY2sN
Cj4gbGFzdCB0aW1lIHRoZXNlIHBhdGNoZXMgd2VyZSBwb3N0ZWQ6DQo+IA0KPiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvY2VjMTJlMjQ2ZDcxNTFmNjA0MWJmNTUzNjI5YTMwNDdlODFkNGFm
ZS5jYW1lbEBIYW5zZW5QYXJ0bmVyc2hpcC5jb20vDQo+IA0KPiBJdCdzIHJlYWxseSBkaXNhcHBv
aW50aW5nIHlvdSBoYXZlbid0IGFjY29tbW9kYXRlZCBhbnkgZmVlZGJhY2sgZWl0aGVyDQo+IGlu
dG8geW91ciBib3Qgb3IgdGhlIHBhdGNoZXMgaXQgc2VuZHMuICBOb3QgZG9pbmcgc28gcmVhbGx5
IGRvZXMgcmVuZGVyDQo+IHRoaXMgd29yayBsYXJnZWx5IHVzZWxlc3MuDQoNCkkndmUgYmVlbiBy
ZXBseWluZyBhIGJpdCB0byB0aGVzZSB0eXBvICJmaXhlcyIgdGhhdCBhcmUgbm90IGZpeGVzIHNp
bmNlDQpJIGFtIGEgbmF0aXZlIHNwZWFrZXIgYW5kIG1heWJlIHNvbWUgdGhpbmdzIGdldCBsb3N0
IGluIHRyYW5zbGF0aW9uIGJ1dA0KSSBoYXZlIHByZXR0eSBtdWNoIG5ldmVyIGdvdCByZXNwb25z
ZXMgZnJvbSB0aGUgcGF0Y2ggc3VibWl0dGVycy4NCg0KSXQncyBhIGxpdHRsZSBiaXQgZnJ1c3Ry
YXRpbmcgc2luY2UgZmFpcmx5IG9mdGVuLCB0aGUgZml4IGlzIG5vdCB0bw0KcmVtb3ZlIHRoZSBk
dXBlLCBidXQgaW5zdGVhZCBzL2luIGluL2lzIGluLyBldGMuDQoNCklmIHRoZXJlJ3MgYSB0b29s
IHJ1bm5pbmcgYWdhaW5zdCB0aGlzIHN0dWZmIGJ1dCBtYWludGFpbmVycyBhcmUgbm90DQphcHBs
eWluZyB0aGUgcGF0Y2hlcyBhcyB0aGUgImZpeGVzIiBhcmUgbm90IGZpeGVzIGl0J3Mgb25seSBn
b2luZyB0bw0Ka2VlcCBnZW5lcmF0aW5nIHRoZSBzYW1lIHBhdGNoZXMgb3ZlciBhbmQgb3ZlciBp
cyBpdCBub3Q/DQo=
