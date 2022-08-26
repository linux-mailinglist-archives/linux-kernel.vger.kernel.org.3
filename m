Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A41B5A2DE8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344336AbiHZR5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiHZR5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:57:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7B6E1AA8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661536664; x=1693072664;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=b8m5EHaqbNB935GWZzz5WAkdjSertpqbRjZLoRqukDQ=;
  b=UdsgTDp86TzA/jJI+x/3OUE7wU50VWJLoJ+D3xfd+TeAZV6I6ADpDuAu
   eKDMgwzgLuGXw6qQ3IE4ubT9rFJpF0hcmhS+wD/smludBxBNj5kL8spTi
   dpS+D809MlQGMaUYiU0sZlMGXDBuPUUK9aMgEQ/gdr81yMdoM14oNVpqy
   UW1dXScsI6x8ESJrOq8sVFMdHcwajWsJylqbIqh1xzqpou3m+VWFP67vd
   BvHlHzwmuoIUQ4SWjupSRH/BMkaT4f34tFntTw8y2kLotrwvz3J4B7Bwv
   9kaHKm+BKdzT+YXrrEFMua40xAjGHbMtS6i2SIyKT+9cxf92hw/7bJpWh
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="110949249"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2022 10:57:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 26 Aug 2022 10:57:39 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Fri, 26 Aug 2022 10:57:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6mMYkJ2jPks7v1u8bLL+KL/eDiNLWGdQP9VtxpaZwqhej2HLSwYwvnbN5T8JOPsu6QK2RXmYq8bv5o3YMmncP7RFOLmb3NpSeikAFdPqwozpC+Cx+FT6o2R/iqO2iznpHhJZrr8+PuGbXGxJ2oUC7+rHuuoaor9p7vIcbhxk1JsZP+buLkzR02SDtlx5w4Ya2p5nbOBm4SMjLbAfGP2cTjbpCtOz3S+HqjWjqh+dvrbKvzj3h3oUv+6CENHqpcxxFp4Fs27wOp+7+fz2HA2c3OvrZEgnh2u+uZqZLpp7HmMssfpUokdOtW+bS6kWWpQgNjSn0c+qHHafUgH8C587Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8m5EHaqbNB935GWZzz5WAkdjSertpqbRjZLoRqukDQ=;
 b=ezLZ7pH4uHzeFEbNj7EAEg2dq8gVzpaJtJ4ezdQQjC5hEs0YstPfyc3ykVetItGT8klOA6LMjQJyDFgjU7j0JTer5gw6ZzCE14Zt1LYgKjqmtqbf8Tic2bB4kICaz/GBRgyyn8I628SvnmMFiebjRvK6DdqHzKuqt3bIzQBPuHfTLnmhdCL6cUoYueStImAAtG+yrlCfPhOrnliDOc7YzcZoWRCFbzzwqrI9kyuV2n9dHEyOm2q4mhbNubux/azQlrQMYBGU+FS3YjRzoQEiEhH9Ey5GS2as/x3samlVVeJROxbHFVQ/3JMP3AYNNS4wVood2olo+ziFOn/XwOU4bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8m5EHaqbNB935GWZzz5WAkdjSertpqbRjZLoRqukDQ=;
 b=Ktm9EMddCo/J+akQPjktjb/KSfifpD3prMtffsr6sF5lNkxuHaf9oSePycTE6ncw/nhSXzyyXJjbNe5VTSpiY9hxgOURhtPSZYr7OBpPcGTHR277wKz5E9dhBQ9Yehul3159QFjS2qIkdyCJPPENETU+h5QCerGaLqcZDmfpA5I=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN8PR11MB3555.namprd11.prod.outlook.com (2603:10b6:408:82::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Fri, 26 Aug
 2022 17:57:34 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 17:57:34 +0000
From:   <Conor.Dooley@microchip.com>
To:     <heiko@sntech.de>, <atishp@atishpatra.org>, <anup@brainfault.org>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <philipp.tomsich@vrull.eu>, <cmuellner@linux.com>,
        <samuel@sholland.org>, <guoren@kernel.org>
Subject: Re: [PATCH v2] drivers/perf: riscv_pmu_sbi: add support for PMU
 variant on T-Head C9xx cores
Thread-Topic: [PATCH v2] drivers/perf: riscv_pmu_sbi: add support for PMU
 variant on T-Head C9xx cores
Thread-Index: AQHYuWnn2Mp+lPZc6UGa6dEb3oyfda3Bd86A
Date:   Fri, 26 Aug 2022 17:57:33 +0000
Message-ID: <5f72e3da-d87d-2d8d-bb4b-d95dca65d4f7@microchip.com>
References: <20220826163500.1748653-1-heiko@sntech.de>
In-Reply-To: <20220826163500.1748653-1-heiko@sntech.de>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 114d58f6-0c21-40d6-8ad1-08da878c7427
x-ms-traffictypediagnostic: BN8PR11MB3555:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9pUYyDiJmd5/UfV1EkiHQ5FcUJDHo0Gh071mklUAf+RydMfbY9uEA/CGqkJLshYD89cL8EoydrrP1Ae3vtJt2cBRLq00ToBq2e6/OzCu+VyOcpPQ+AaHsIej37ikrlQNypl4hLj+vstq1wbxWYqMSOmiUXNl8Oj6N8y61qotz85SXIcY7ec2gBMHrrnJi+kwdWJkNpgW8vSBka37H2QtHdCGoLNGwwB2BUrVM4y0SIw7Plu/qqQ+tmbA8iWl8FBhqoOzUcOel1R7GgpnGE3pTCgJzIc/NlUkrV9OHftIIP+8wzDknUAiWAMne7Ftikk994EwR4tyhHX0yjI+jODR2jeiv/1mLtt0gXHEaEqgPieRr4e4utUuFUBYWl13+IJtaPeb/udzHfb9X0A7+7BOWQ4mIE9VdDrZmQx/ASx+G3Xr8hGTX7AYB9MEBU1Te2Dg1zmp0BcHgJ52y7umgXLBhJgFu4XtHYUFshWH78ZI7yjDCFsH9d1xHnKTiaE26zA51avm5pQtScJ03Chh+jRh1OMzHBzPFO0X5ICfvsHWSyC185aZCdbQdD98zD9+v90S+dR7VjE1Guj3dQQlz44WgkvmFUAtckqfZ9f7cJwmCo0vJSImnuE1NCBPNTsElXj5952+DvLVDFeRrd2rt8uFh6uwkiecXYcJUWyZjoqYk60aQmr4wNJf9JVEw/r8g/VqBtZ0awvsMy/0rTWK/4W22/J9HkRj1loQBAsPd9lvshHy94p8JRHeG2ZILvr9n9X5O7oEq9RCyKf0iK8fXtN8OYRV7ATeYfmJS7p+48Mlr0N7L6u17xT2SDDIKM2SrESNvAoRLTxaReHE7iQVUKsLraOlm8HfThvGq5eq65N6Wy0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(366004)(39860400002)(136003)(346002)(478600001)(966005)(6506007)(6512007)(53546011)(6486002)(41300700001)(71200400001)(83380400001)(66446008)(26005)(2616005)(2906002)(8936002)(5660300002)(7416002)(54906003)(316002)(110136005)(186003)(4326008)(8676002)(64756008)(66476007)(66556008)(66946007)(76116006)(91956017)(122000001)(36756003)(38100700002)(86362001)(31696002)(31686004)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ck9sbnVncGU2MG9ZQWR1MUZFdmVGQks4dUdVQ2RzTnpUVjkwWGRWR1lLRWlV?=
 =?utf-8?B?WXVQQkpDK0h6RzFWSlVzZkdRMXZ1OXQyR2UxZ240NGVRTWpVN3ZDWHFWWEJy?=
 =?utf-8?B?NE44eEc1NzVnNVlJS3EvT0JoaFMrZVVHMXUrcnpuRURjYVF0QXZSU1laN0Y3?=
 =?utf-8?B?SGFiWEZ6OXpxcWEyUWFVcy9kVWlMWEFxOFI4b21LTVVTZDFNTGVWQkJKZ2hG?=
 =?utf-8?B?MUphSnBtaytkRWNveXpNUGtQTXZnSzNuRjA0dzRFdGNXUG1RWElxTlhRRDQ5?=
 =?utf-8?B?NmFMc05Ma2Z6blFwaWdOUDRIVUE0S0Z5VWRBT3FqbC8zMDhvSVdUTzJQcW1C?=
 =?utf-8?B?RDZjMEZPMTFFdnlYOHNxdU92c3RUc0tScFV1dWxQbnpsMUluT3BHbzlRNTFU?=
 =?utf-8?B?UHlEL3o3b01IR0orNjlQNmdTQlM4eW5YRWtVVUZnUGxzTDBiQ3BBOFJuVGFK?=
 =?utf-8?B?ejF4cVFGcWFGb0ZtbENRc3U2d0gyWitaWFN5NnJSZFI3MnFGUVcwMzJkZUdC?=
 =?utf-8?B?ekM2Z0I1ck5sa3RqTFk5N2ZsbExqLzRKRHpvU2RyTGE2d3RTWW5kYlhxVFRk?=
 =?utf-8?B?My8yNlZrV2RaWWpIR1JycW1rN3hJKzllUDhFS1BXelNScHAwNFl1Z1ZJSEgr?=
 =?utf-8?B?STlMWHdJdUh5dWpmcm1sRVhQU0trTmNpVWlWMXI0Tlo3Qk9rYVM3K3l1d0pp?=
 =?utf-8?B?TkRpdXZTOXNxSk4veEN4eXlUSDlDQ25PWHMrL1BtM2ZZNFVNRFcrcm1DQ3pG?=
 =?utf-8?B?Q3JZMHVDeGtKRkM3UGF3SkJTbXlmU3VxVkI0YWJ1b0p3UHdUUnpmMXlpR0tq?=
 =?utf-8?B?VnhZK1FaTno2UUpQcmxQd3RPMmEwejhLRVN3aXl6akNkWitja2g3cUFWR2V2?=
 =?utf-8?B?TVRxS1Zsd1ZLRCtHZVYwRDVzbmt5dlRWVVFvQzFzNWlPZ2lBUk9RYTlSejRi?=
 =?utf-8?B?Z1NwMzY2VTV5YkxIbUhmbVNHdHRhcVVMa3FwV29BVEJ5am53alovYzZ2VVlR?=
 =?utf-8?B?RHZrTjBoQW1EZ1QxNkpDYXpRbm5zaHQzUHVGVDEyNkovTTRQRFNBOWMwUzNY?=
 =?utf-8?B?aVBDeHNjMlV5a3hPSWo3WVBKQ2pkTXUvc0U5T24xcHRlbEg4MFlveTdxWEtw?=
 =?utf-8?B?RnpDdXZpc1hPdW83MXZjZ0FOb1ZhTTZhbFU5dmx0d0k4ZnlVcW9FYzFWNkdh?=
 =?utf-8?B?a0hLMGdvMVdoMHRGYUdGenhkTUtyWkVHdjZwRzc4a09NY1FFTDZEeGphZFlU?=
 =?utf-8?B?OWptMGtJbFB4eDJpMldVRFI2aW5nR05NdHZzVGVZbGFpcmRwempXeWszQlpK?=
 =?utf-8?B?ZFZqSXVuN3FHU0pkWUQ1OXdBWG1XQTIveXcya1dKekZqVTNNNWJTY1NSZHJl?=
 =?utf-8?B?TkhOZk05S1NlM2NjcjVXZEE5aEIwbEkxdS80MEZKVy9RcjdvV0RuUXN0UG9r?=
 =?utf-8?B?ZG04dS9yR2hhcWVHdEZ0VHZWSXN5ZzM1QmNsZEcvSDRBQTRGcFNXNmkxSkFH?=
 =?utf-8?B?UUdlTmRRRklPSlB6OVVydXBjUENHQndaRXEwSUo5c0xHTnZpTEMxZ2NLM2dD?=
 =?utf-8?B?bTRTNmFHV3l1a1pMeFpnWnAwTTQ5YlhJY1ZvZ2YzWjJDc3VzY0hhcmJxQzRW?=
 =?utf-8?B?WUs3QkdOWVZvNW10NmhiUXo2elR4YmdJcG83R0lmeDJuQTJlWlY3U0ZrUGxa?=
 =?utf-8?B?dys1QlA2enMrSWVoSlkxc3liOHJBWUJjelBuZjlHVC81NDVnb2Rxc2MyTVdu?=
 =?utf-8?B?R0swdmQzZmhWbTZKNGJLTmVpRWVqeDBNTkV5L1FRUUhLZG5aN3VVYXd6R3NW?=
 =?utf-8?B?d0E0ZWNMZmJqK2tBZWFYVmp4ZGdqQm51OXJ0WDk1WWJGR3E1WkxEOHkwQ0NK?=
 =?utf-8?B?LzY2R2hudXRxZXVreUFQR21VQkR0QkhUeDZxdEtWRzdaREk0WFE5alVoaVVl?=
 =?utf-8?B?SnRGUHFXaUtiMHhUY1lVYWo0U3pZa3JSRFV4Qk56QjNNTll6c1BNcks1dTJo?=
 =?utf-8?B?MDB5eWNHdXI5ZXhUVWIraGxRaXJnUHplRzRKOFROV2NEZ0lpNVdmaWxaL1lt?=
 =?utf-8?B?SmVBczFOa090TkFpRmg4ZlcxZGtyb05JUnpUemRER0djN0VuRjJnMHF2eWlO?=
 =?utf-8?B?UVpMYkRlVTMzOEQ5UmdTMWRRRUFlSjhsS1FJaW4yK1hCWlBRRzZFY0dCRkZx?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <037D7268D6F60D42AE9F45D8276E6972@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 114d58f6-0c21-40d6-8ad1-08da878c7427
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 17:57:33.9641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JeT6MyvtGkHMHU4PpQNFoOfGobb26RqNn6FwCeXidI4gkA+eRv0i4SJlmNRicshnDxCBantDrDS8QaG60XYn/r63cULEDtOyFNlb5Vj8tgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3555
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYvMDgvMjAyMiAxNzozNSwgSGVpa28gU3R1ZWJuZXIgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gV2l0aCB0aGUgVC1IRUFEIEM5WFggY29yZXMg
YmVpbmcgZGVzaWduZWQgYmVmb3JlIG9yIGR1cmluZyB0aGUgcmF0aWZpY2F0aW9uDQo+IHRvIHRo
ZSBTU0NPRlBNRiBleHRlbnNpb24sIHRoZXkgaW1wbGVtZW50IGZ1bmN0aW9uYWxpdHkgdmVyeSBz
aW1pbGFyIGJ1dA0KPiBub3QgZXF1YWwgdG8gaXQuIFNvIGFkZCBzb21lIGFkYXB0aW9ucyB0byBh
bGxvdyB0aGUgQzlYWCB0byBzdGlsbCBoYW5kbGUNCj4gaXRzIFBNVSB0aHJvdWdoIHRoZSByZWd1
bGFyIFNCSSBQTVUgaW50ZXJmYWNlIGluc3RlYWQgb2YgZGVmaW5pbmcgbmV3DQo+IGludGVyZmFj
ZXMgb3IgZHJpdmVycy4NCj4gDQo+IFRvIHdvcmsgcHJvcGVybHksIHRoaXMgcmVxdWlyZXMgYSBt
YXRjaGluZyBjaGFuZ2UgaW4gU0JJLCB0aG91Z2ggdGhlIGFjdHVhbA0KPiBpbnRlcmZhY2UgYmV0
d2VlbiBrZXJuZWwgYW5kIFNCSSBkb2VzIG5vdCBjaGFuZ2UuDQo+IA0KPiBUaGUgbWFpbiBkaWZm
ZXJlbmNlcyBhcmUgYSB0aGUgb3ZlcmZsb3cgQ1NSIGFuZCBpcnEgbnVtYmVyLg0KPiANCj4gQXMg
dGhlIHJlYWRpbmcgb2YgdGhlIG92ZXJmbG93LWNzciBpcyBpbiB0aGUgaG90LXBhdGggZHVyaW5n
IGlycSBoYW5kbGluZw0KDQpIZXkgSGVpa28sDQoNClZlcnkgbml0cGlja3ksIGJ1dCBJIGhhZCB0
byByZWFkIHRoaXMgdHdpY2UgdG8gZ2V0IGl0Li4gSWYgeW91IHJlc3BpbiwNCml0J2QgYmUgd29y
dGggYWRkaW5nIGEgY29tbWEgYWZ0ZXIgImhhbmRsaW5nIi4NCg0KPiB1c2UgYW4gZXJyYXRhIGFu
ZCBhbHRlcm5hdGl2ZXMgdG8gbm90IGludHJvZHVjZSBuZXcgY29uZGl0aW9uYWxzIHRoZXJlLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogSGVpa28gU3R1ZWJuZXIgPGhlaWtvQHNudGVjaC5kZT4NCj4g
LS0tDQo+IGNoYW5nZXMgaW4gdjI6DQo+IC0gdXNlIGFsdGVybmF0aXZlcyBmb3IgdGhlIENTUiBh
Y2Nlc3MNCj4gLSBtYWtlIHRoZSBpcnEgbnVtIHNlbGVjdGlvbiBhIGJpdCBuaWNlcg0KPiANCj4g
VGhlcmUgaXMgb2YgY291cnNlIGEgbWF0Y2hpbmcgb3BlbnNiaS1wYXJ0IHdob3NlIGN1cnJlbnQg
aW1wbGVtZW50YXRpb24gY2FuDQo+IGJlIGZvdW5kIG9uIFswXSwgYnV0IGFzIGNvbW1lbnRzIHNo
b3csIHRoaXMgbmVlZHMgc29tZSBtb3JlIHdvcmsgc3RpbGwuDQo+IA0KPiANCj4gWzBdIGh0dHBz
Oi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9vcGVuc2JpL2NvdmVyLzIwMjIwODE3MTEy
MDA0Ljc0NTc3Ni0xLWhlaWtvQHNudGVjaC5kZS8NCj4gDQo+ICBhcmNoL3Jpc2N2L0tjb25maWcu
ZXJyYXRhcyAgICAgICAgICAgfCAxNCArKysrKysrKysrKysNCj4gIGFyY2gvcmlzY3YvZXJyYXRh
L3RoZWFkL2VycmF0YS5jICAgICB8IDE5ICsrKysrKysrKysrKysrKysrDQo+ICBhcmNoL3Jpc2N2
L2luY2x1ZGUvYXNtL2VycmF0YV9saXN0LmggfCAxNiArKysrKysrKysrKysrLQ0KPiAgZHJpdmVy
cy9wZXJmL3Jpc2N2X3BtdV9zYmkuYyAgICAgICAgIHwgMzIgKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLQ0KPiAgNCBmaWxlcyBjaGFuZ2VkLCA3MCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L0tjb25maWcuZXJyYXRhcyBiL2Fy
Y2gvcmlzY3YvS2NvbmZpZy5lcnJhdGFzDQo+IGluZGV4IDY4NTBlOTM4OTkzMC4uZjFlYWFjNGMw
MDczIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Jpc2N2L0tjb25maWcuZXJyYXRhcw0KPiArKysgYi9h
cmNoL3Jpc2N2L0tjb25maWcuZXJyYXRhcw0KPiBAQCAtNjYsNCArNjYsMTggQEAgY29uZmlnIEVS
UkFUQV9USEVBRF9DTU8NCj4gDQo+ICAgICAgICAgICBJZiB5b3UgZG9uJ3Qga25vdyB3aGF0IHRv
IGRvIGhlcmUsIHNheSAiWSIuDQo+IA0KPiArY29uZmlnIEVSUkFUQV9USEVBRF9QTVUNCj4gKyAg
ICAgICBib29sICJBcHBseSBULUhlYWQgUE1VIGVycmF0YSINCj4gKyAgICAgICBkZXBlbmRzIG9u
IEVSUkFUQV9USEVBRA0KPiArICAgICAgIGRlcGVuZHMgb24gUklTQ1ZfUE1VX1NCSQ0KPiArICAg
ICAgIGRlZmF1bHQgeQ0KPiArICAgICAgIGhlbHANCj4gKyAgICAgICAgIFRoZSBULUhlYWQgQzl4
eCBjb3JlcyBpbXBsZW1lbnQgYSBQTVUgb3ZlcmZsb3cgZXh0ZW5zaW9uIHZlcnkNCj4gKyAgICAg
ICAgIHNpbWlsYXIgdG8gdGhlIGNvcmUgU1NDT0ZQTUYgZXh0ZW5zaW9uLg0KPiArDQo+ICsgICAg
ICAgICBUaGlzIHdpbGwgYXBwbHkgdGhlIG92ZXJmbG93IGVycmF0YSB0byBoYW5kbGUgdGhlIG5v
bi1zdGFuZGFyZA0KPiArICAgICAgICAgYmVoYXZpb3VyIHZpYSB0aGUgcmVndWxhciBTQkkgUE1V
IGRyaXZlciBhbmQgaW50ZXJmYWNlLg0KPiArDQo+ICsgICAgICAgICBJZiB5b3UgZG9uJ3Qga25v
dyB3aGF0IHRvIGRvIGhlcmUsIHNheSAiWSIuDQo+ICsNCj4gIGVuZG1lbnUgIyAiQ1BVIGVycmF0
YSBzZWxlY3Rpb24iDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2VycmF0YS90aGVhZC9lcnJh
dGEuYyBiL2FyY2gvcmlzY3YvZXJyYXRhL3RoZWFkL2VycmF0YS5jDQo+IGluZGV4IDIwMmM4M2Y2
NzdiMi4uZTYxMDFlYWIyNWM4IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Jpc2N2L2VycmF0YS90aGVh
ZC9lcnJhdGEuYw0KPiArKysgYi9hcmNoL3Jpc2N2L2VycmF0YS90aGVhZC9lcnJhdGEuYw0KPiBA
QCAtNDQsNiArNDQsMjIgQEAgc3RhdGljIGJvb2wgZXJyYXRhX3Byb2JlX2Ntbyh1bnNpZ25lZCBp
bnQgc3RhZ2UsDQo+ICAjZW5kaWYNCj4gIH0NCj4gDQo+ICtzdGF0aWMgYm9vbCBlcnJhdGFfcHJv
YmVfcG11KHVuc2lnbmVkIGludCBzdGFnZSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB1bnNpZ25lZCBsb25nIGFyY2hfaWQsIHVuc2lnbmVkIGxvbmcgaW1waWQpDQo+ICt7DQo+ICsj
aWZkZWYgQ09ORklHX0VSUkFUQV9USEVBRF9QTVUNCg0KSXMgdGhlcmUgYSByZWFzb24gdGhhdCBh
bGwgdGhlIGFsdGVybmF0aXZlcyB1c2UgaWZkZWYNCnJhdGhlciB0aGFuIGlmKElTX0VOQUJMRUQo
KSk/DQoNCj4gKyAgICAgICBpZiAoYXJjaF9pZCAhPSAwIHx8IGltcGlkICE9IDApDQo+ICsgICAg
ICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ICsNCj4gKyAgICAgICBpZiAoc3RhZ2UgPT0gUklT
Q1ZfQUxURVJOQVRJVkVTX0VBUkxZX0JPT1QpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gZmFs
c2U7DQo+ICsNCj4gKyAgICAgICByZXR1cm4gdHJ1ZTsNCj4gKyNlbHNlDQo+ICsgICAgICAgcmV0
dXJuIGZhbHNlOw0KPiArI2VuZGlmDQo+ICt9DQo+ICsNCj4gIHN0YXRpYyB1MzIgdGhlYWRfZXJy
YXRhX3Byb2JlKHVuc2lnbmVkIGludCBzdGFnZSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdW5zaWduZWQgbG9uZyBhcmNoaWQsIHVuc2lnbmVkIGxvbmcgaW1waWQpDQo+ICB7DQo+
IEBAIC01NSw2ICs3MSw5IEBAIHN0YXRpYyB1MzIgdGhlYWRfZXJyYXRhX3Byb2JlKHVuc2lnbmVk
IGludCBzdGFnZSwNCj4gICAgICAgICBpZiAoZXJyYXRhX3Byb2JlX2NtbyhzdGFnZSwgYXJjaGlk
LCBpbXBpZCkpDQo+ICAgICAgICAgICAgICAgICBjcHVfcmVxX2VycmF0YSB8PSAoMVUgPDwgRVJS
QVRBX1RIRUFEX0NNTyk7DQo+IA0KPiArICAgICAgIGlmIChlcnJhdGFfcHJvYmVfcG11KHN0YWdl
LCBhcmNoaWQsIGltcGlkKSkNCj4gKyAgICAgICAgICAgICAgIGNwdV9yZXFfZXJyYXRhIHw9ICgx
VSA8PCBFUlJBVEFfVEhFQURfUE1VKTsNCg0KQklUKEVSUkFUQV9USEVBRF9QTVUpLCBubz8gRGl0
dG8gZm9yIHRoZSBDTU8gSSBndWVzcy4uDQoNCj4gKw0KPiAgICAgICAgIHJldHVybiBjcHVfcmVx
X2VycmF0YTsNCj4gIH0NCj4gDQoNClRoYW5rcywNCkNvbm9yLg0KDQoNCg==
