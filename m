Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F4959FAC2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237525AbiHXNBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237251AbiHXNBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:01:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB7797B2C;
        Wed, 24 Aug 2022 06:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661346090; x=1692882090;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EPaw/lunFQP32S/KxUIhgqMEQkG4lszRKCRUriIxAq0=;
  b=F2qfm+gj/TZjuZB6tmrH9xY3fZz9PGbRONpkvBU5DuRb8FoXgV704sVB
   PXKVcc7KH5CzDqxyBpEel65Hd2PCWnP0sTIuAuh55Npo2NUITSx03FBz3
   bhCQrLsfmiVfI+EsK6+UPI/8ixqmjjRfyZT0iybXi6szWO1t8agWGcntd
   ss35hZyoN8gqtVowxsahK5tbJE6qKBWQiKRfbUtiAt/Y7SjcDCNJPOU39
   2EESa1rfm4L/Qb73/4sfEAjua7rBFVIhMmyl5J4k90NlWH2vXZvEZtScd
   an2YqvfvlrwRwVW4arwC98phZOb85Ps9Xx+eoDUPJ/e+jovzRl/AwXI7t
   g==;
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="110509458"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2022 06:01:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 24 Aug 2022 06:01:29 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 24 Aug 2022 06:01:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5LS+flnb3iwFQFm/5E/PCnnVytNX76Dv38zcyFJqiMtWqSlQIg+CkqUi30koD1bpNcnPRSZgAZQpRWHcKuwQTJCWFFGzJY2+BY8/imVn/wGmJ7Xk5//LPL0X/3v/tS/54QiYc3RQfi5HB6wwLGGqMfJcK4072Jr9WDsa16opL+dtyXxz2cUaFO3PeNwG/2AzLjoyIRBkt4f3hrY1HecmHuQkc93PSrbFRi3JS/XFUWiFfDxu4Wy2OzQqY5YWnc5OTHTJg+V0WZtHL+cL8+AGU0NxBCMqXOKozNAegDjcBwg8IDoGrGkCyLN+gRoh5yW7iqUkju8AsUlSL0HdMXA8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPaw/lunFQP32S/KxUIhgqMEQkG4lszRKCRUriIxAq0=;
 b=VwS9nOyK/tTQFKFOx/Z6Mrx/TAEGU3eq7EQddoV4lMKNMu5HVbRWgdykj66H2F25ag9u1iNaG8MBb9l0zaSdAUnGJtcysoeicMN1t7kK3s4+0iU5/5bs9VRjU5QOEIlybgxZ2wLUM5WALupfPkcpe7wJa6vf+UQSAveRbUMNVB/0r4jXDo/PTTEAd7j85KoManJX7u0MmvGXNLdWU8MauujVtgOFqK6RlsXZVZacUA85DSEs12MHfbvJeeoIARrmGP96vxsnRU6P0kxNi8aot4Hquu09MHG3r79BTSMR3hNkSArtBGHwrPfuaZhfNzUJkSFAn5BVTfRmVqgLYcNbRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPaw/lunFQP32S/KxUIhgqMEQkG4lszRKCRUriIxAq0=;
 b=IOfUMx46BX4Tan//3FcWXegyeTPA7vrvrn09V+Q1nOCmzk0wUCeKNjc+/KG0FT/4zaCpo43VZh4Ir+qFloaZjY72T2Jem3YQfe7kfPLlpR3HNqVPNXYvI0+sYMYUM5l20TyFiI0ejzoR3OuL5jVA7gtzAK0/aO/SxKf+eefkdGU=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by PH0PR11MB5578.namprd11.prod.outlook.com (2603:10b6:510:e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Wed, 24 Aug
 2022 13:01:24 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::6852:5740:4bc9:d1b4]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::6852:5740:4bc9:d1b4%7]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 13:01:24 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <ilpo.jarvinen@linux.intel.com>
CC:     <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>,
        <rmk+kernel@arm.linux.org.uk>, <claudio@evidence.eu.com>,
        <rick@efn.org>, <ryan@bluewatersys.com>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tty: serial: atmel: Preserve previous USART mode if RS485
 disabled
Thread-Topic: [PATCH] tty: serial: atmel: Preserve previous USART mode if
 RS485 disabled
Thread-Index: AQHYt69r9DO2gppHqEGjH0pbHuSI9K2982YAgAAQdIA=
Date:   Wed, 24 Aug 2022 13:01:24 +0000
Message-ID: <96f5251b-c476-a792-b9c4-b6310fa7e6eb@microchip.com>
References: <20220824114255.444655-1-sergiu.moga@microchip.com>
 <2cab23a2-7a82-9321-dca1-5c7c71484ad@linux.intel.com>
In-Reply-To: <2cab23a2-7a82-9321-dca1-5c7c71484ad@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc3a847d-d887-48fc-197a-08da85d0bf9b
x-ms-traffictypediagnostic: PH0PR11MB5578:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w5Zsf1lN53ARfolGhDJoTICocogkJYkN4+BxUpEOiZcYsZ2MrXfPbF1ru+PwUhgf8xktFXB0uFLAuW/Fj+k/FBuHYPu94U5iGDW7rRv0T0Oce0AlD96qM6h5tlqua/8Af0PQuO0AEe5+6dRNwrHJ+3Eq2h5JCCF6ZHbKOCa5Mb3Kk/G8xhMtQJZx1b8djVsNVFaL0tc8lxJR/y9nga2CCv6WF5TrM+5GIx6vSincYFIE/omIoTYmWyWXqJyjrp2JFd3XmGj1RXfbERHtwEoXTw1on3sjjaG0MGb42CRTbv/RjwOE/GAdKd3p+Luz8zDEB/ipV+MqPLOB/1bE1f9KL8qp7zrA7kkpyjuKLsCiGgxN2shxfyYhPuCXJrAajCDzwXDtIv9L0IdS78Tom4ZXftXf+5pkfPfThi2b3GfFush8/eTT17UyWgpaaslTb8MlzawVXHzyGzxYT9+rikdoY4mwXbCu+eIBNR2l+aRWuA22cH985vpN3l7Y8rij5QHr2E0/N+YWu3CSigPmDjVdDquTyJSFDZW+xcNdDkKm/3ee3Sc+m1RidQA5oVjnZoEFn/TGZo8awdofdZ8m7X/ePVB+yUBvmf+cYquvr6jAF5a6uJ9WkaTrlvJHmuSSylE4adGOAc+Kp9Kk0E1kDg4v6qQjF+RSHIDno4ZvqkE0hpXx+7/3TXWWpUFgYgzpphe7MbN/LlxUzQz3l04a2ZVcrsT7oeJlPzZDfH28URE6c/RNqZSxgtiusCavZN5xz+/z2kA+/lwpI6DfV5NhsKSmrbFy78INnO52SsseLhLn02A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(39860400002)(396003)(366004)(346002)(66556008)(91956017)(66946007)(66476007)(6486002)(64756008)(8676002)(71200400001)(4326008)(66446008)(316002)(7416002)(54906003)(186003)(41300700001)(478600001)(5660300002)(6916009)(76116006)(53546011)(83380400001)(26005)(6512007)(6506007)(66574015)(31686004)(2906002)(36756003)(2616005)(86362001)(31696002)(38070700005)(8936002)(38100700002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVVkbHU5UE1QTVh0UFZoaG1HREc1NStNUkh3SzBTZkFwVnBNZlZ4cEMrNFpE?=
 =?utf-8?B?QW1PQ1JOdWR6Ym5ZUWlwdjZjVE5qY05hTjBlWTZrR3EwTWF2WDBCYkhCT2Rm?=
 =?utf-8?B?NytHcVVVWm8xNlVma21CZDkxc0IyYWxKcWE3eWs0dmFiQ3AxSmJFUDVCQ1ox?=
 =?utf-8?B?MnhuUW8vTSs3U05iUkRUb2l6L1hHNXVsUlB0ZXp5UndtUWkwam5uU3VuVkQ3?=
 =?utf-8?B?Vyt2NVBSQVl4V3BHdDRRN3RXek9TS2RlMWhwMUZLMGpYQ3ZuRytuQlpVSXJ1?=
 =?utf-8?B?RUpnOWVGeGRLemdEc25LYS9iZXcyRG8zVDUrMHNOUzV3Mk9VSi9WbFU5bmJu?=
 =?utf-8?B?cmkrT2ZPWjJqZ0Y5ZEVDUHpCYUhPSnhWRks1RzVOSFNRbHNubWt4MkgvZjQ1?=
 =?utf-8?B?VWhVZkNPODFVVTFPb0VpbDI5Y3dIUDBNYlJ2enBXUVc0SE9lN3J3cE83UHM1?=
 =?utf-8?B?TG42Z2lIQXpEc1l6dllvY3N0NkdRMWhZYmg0b3B2UnMwMkthVkJGS0lJQVV5?=
 =?utf-8?B?aXBIb2VIcDNuTGg1TDJjVFd4dEFDT1U5SFNQVmRxZS9RaFFDdmNVN0NNTW9R?=
 =?utf-8?B?TTdwais0MHBsSHQwS1k5ckp3RUFEUjhCbVhGbjhoU1cxSFF6ZzlpZ0xKaFND?=
 =?utf-8?B?VTIrdWorME81T09KTnhtV2p1OVZ0Yk9JSXlMQmFyVE9wSGRJMks5azNTd0Nr?=
 =?utf-8?B?T0RjQmEwTnNkUmNMVzhSQVpMMU5DZWpCeXQ5MmlnTzlYN2s0ZzJjQWtaSzMr?=
 =?utf-8?B?dll4NklGWC9iVU5OT3lDYTJzTGs1TTVYZ2kzQUJEWXBUTDByQU9vYnY5eU91?=
 =?utf-8?B?blA2bVRISjRqN09xZ1REOWhUV3dxL25ETEE3alZWRTZOYnltU0w1WlFFM0ZS?=
 =?utf-8?B?VE1mZW03Tlc0b1FHMlc4THBrYlNUbzVpcTFjcDRGcmhUaEszK2JsRXpSL1dO?=
 =?utf-8?B?S1ZuUEE5TU1Fc0tSTGpOb2dFeHJMWG43djZaamZGK2ZRUGE1dVhkVzVWdk5C?=
 =?utf-8?B?czBEM2JhZG1hZ2dkRkRPeXp0WU03a3NYajZKVjJqczc2blpFNG8vSVJTR1Iz?=
 =?utf-8?B?d0ZielJDNWRRL20zM0Q0bGVINkRaSjZwcVlNRHpCTkJOODMxRnAxYXdONnJi?=
 =?utf-8?B?UnBrV3NXZFI3TlNlUzRkZHRDYkgyNW9yclNSY3RtOGNmcnczTFJxcmRObzNl?=
 =?utf-8?B?ckl5YzFuZXlUWGgzKzdoNzZCWnBBYmN6NWtIanU3MWZDVDd5VTFBWkJJQjlF?=
 =?utf-8?B?a2d4NnpzaDBoZGhOd0dTeUUwRlZJWEo1WXdBSXFZMDlQMGYxQU1oTk9LU3JI?=
 =?utf-8?B?ZytlSnlkaklmdW5CMjV4eVlnMjZUMjUvMnlyQ2hZK3RLUVlueUVIODBkKzlz?=
 =?utf-8?B?aUhMZWNUOVZtbDdIa0EvVC9UcklWenIzRWd0TDVzWTV1RmVPeFNNUzRkdlBO?=
 =?utf-8?B?K1JhQjlkZ3AwUi85dFROOVEzcHd6OTNPbTQ5RjZ1SThreGlVdldWM1hOYzlv?=
 =?utf-8?B?cmRwV0U5ZWhoZkdrcklKL1h3OE5SSVd0UTBHY2daVlJwTnY3aytyQkNZMSt5?=
 =?utf-8?B?bnVwNVJVTk1kZFJnZFpHclNCWEVRZGVPT3dpb1dpTURZRllFZWZJWlJDaGRZ?=
 =?utf-8?B?NkxPMUhzNlMwYWdYQTYvd1lrT0dsdjFKclVaTW9iOU5IZGxDd3BmVnV4OFg0?=
 =?utf-8?B?Y3NuY1l1WDBsWlAzY054SmRKaEk1MkY2bzFZSjg2UVJmbitaMUJtNWczdUxY?=
 =?utf-8?B?UWtqeHhZVHVpOXJRNzZ6TGZPMFJrOEZ0UHBOYTF0bzkwZm94VzczRWxZNktP?=
 =?utf-8?B?aEVWbHdTVStSVWFSdDlSaHNDMjE3cG80SW8wdlNoVnBRRmZ6d2o0MDhPZHpD?=
 =?utf-8?B?blUrM1RpTGFwc3dVd0hrMWRxb3ZtWHRHZHJRU1ZkVUxnSVhkcDM4ODR5WGtm?=
 =?utf-8?B?VHBkT2hncjF4SGJ6Ri9GdG95OUo1bnFmRDZhZzJ4aXpMNW1mbXhwb05uWDdo?=
 =?utf-8?B?WFVicUxYa1FRNkRmdmwxL05vcENQOUJrNUJYRllONTl2K3hwTjdyYjU5MnBV?=
 =?utf-8?B?Y3JsOGhqNnZEZTM5MXJzbW8ya3paZnVJaW5FVXN1VU96eU8rU0g4VkhDVDEv?=
 =?utf-8?Q?IwEZS7dO2iLuQaE9EGuRQzNJj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A491BC1FF8DB547965709E4DED3A3BD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3a847d-d887-48fc-197a-08da85d0bf9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 13:01:24.0494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5UNqkcuKcGgK2UnEzg6a5GJsrLMLJMrenoVhQxN1vW7GQZp/8Xk419pEysJ9XyIJRvMmnkoJxWkxgjKiSJlT5VfBfmkCkyjqplsw5EPacaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5578
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjQuMDguMjAyMiAxNTowMiwgSWxwbyBKw6RydmluZW4gd3JvdGU6DQo+IE9uIFdlZCwgMjQg
QXVnIDIwMjIsIFNlcmdpdSBNb2dhIHdyb3RlOg0KPg0KPj4gV2hlbmV2ZXIgdGhlIGF0bWVsX3Jz
NDg1X2NvbmZpZyBkcml2ZXIgbWV0aG9kIHdvdWxkIGJlIGNhbGxlZCwNCj4+IHRoZSBVU0FSVCBt
b2RlIGlzIHJlc2V0IHRvIG5vcm1hbCBtb2RlIGJlZm9yZSBldmVuIGNoZWNraW5nIGlmDQo+PiBS
UzQ4NSBmbGFnIGlzIHNldCwgdGh1cyByZXN1bHRpbmcgaW4gbG9zaW5nIHRoZSBwcmV2aW91cyBV
U0FSVA0KPj4gbW9kZSBpbiB0aGUgY2FzZSB3aGVyZSB0aGUgY2hlY2tpbmcgZmFpbHMuIFNvbWUg
dG9vbHMsIHN1Y2ggYXMNCj4+IGBsaW51eC1zZXJpYWwtdGVzdGAsIGxlYWQgdG8gdGhlIGRyaXZl
ciBjYWxsaW5nIHRoaXMgbWV0aG9kDQo+PiB3aGVuIGRvaW5nIHRoZSBzZXR1cCBvZiB0aGUgc2Vy
aWFsIHBvcnQ6IGFmdGVyIHNldHRpbmcgdGhlIHBvcnQNCj4+IG1vZGUgKEhhcmR3YXJlIEZsb3cg
Q29udHJvbCwgTm9ybWFsIE1vZGUsIFJTNDg1IE1vZGUsIGV0Yy4pLA0KPj4gYGxpbnV4LXNlcmlh
bC10ZXN0YCB0cmllcyB0byBlbmFibGUvZGlzYWJsZSBSUzQ4NSBkZXBlbmRpbmcgb24NCj4+IHRo
ZSBjb21tYW5kbGluZSBhcmd1bWVudHMgcGFzc2VkLiBJZiB3ZSB3ZXJlIHRvLCBmb3IgZXhhbXBs
ZSwgZW5hYmxlDQo+PiBIYXJkd2FyZSBGbG93IENvbnRyb2wgdGhyb3VnaCBgbGludXgtc2VyaWFs
LXRlc3RgLCB0aGUgdG9vbCB3b3VsZA0KPj4gbWFrZSB0aGUgZHJpdmVyIHNldCB0aGUgY29ycmVz
cG9uZGluZyBiaXQgdG8gMSAoQVRNRUxfVVNfVVNNT0RFX0hXSFMNCj4+IGJpdCBpbiB0aGUgQVRN
RUxfVVNfTVIgcmVnaXN0ZXIpIHRocm91Z2ggdGhlIGF0bWVsX3NldF90ZXJtaW9zIG1ldGhvZA0K
Pj4gYW5kIHRoZW4gcHJvY2VlZCB0byBkaXNhYmxpbmcgUlM0ODUuIFRoaXMsIGluIHR1cm4sIGNh
dXNlcyB0aGUNCj4+IEFUTUVMX1VTX1VTTU9ERV9IV0hTIGJpdCBvZiB0aGUgQVRNRUxfVVNfTVIg
bW9kZSByZWdpc3RlciB0byBiZSB1bnNldA0KPj4gYW5kLCBpZiB0aGUgY2hlY2tpbmcgZm9yIFJT
NDg1IGZhaWxzLCBsZWFkcyB0byBoYXZpbmcgdGhlIG1vZGUgc2V0DQo+PiBiYWNrIHRvIHRoZSBB
VE1FTF9VU19VU01PREVfTk9STUFMIG5vcm1hbCBtb2RlLiBTaW5jZSBpbiBoYXJkd2FyZQ0KPj4g
ZmxvdyBjb250cm9sIG1vZGUgdGhlIG1lYW5pbmdzIG9mIHRoZSBBVE1FTF9VU19SVFNESVMgYW5k
DQo+PiBBVE1FTF9VU19SVFNFTiBiaXRzIGFyZSBzd2FwcGVkLCB0aGlzIGxlYWRzIHRvIG91ciBl
bmRwb2ludCBsZWF2aW5nDQo+PiB0aGUgUlRTIGxpbmUgdG8gaGlnaCB3aGVuIHdhbnRpbmcgdG8g
cmVjZWl2ZSwgd2hpY2ggaXMgdGhlIG9wcG9zaXRlDQo+PiBvZiB3aGF0IHRoZSBvdGhlciBlbmRw
b2ludCBpcyBleHBlY3RpbmcgaW4gb3JkZXIgdG8gc3RhcnQgdHJhbnNtaXR0aW5nLg0KPj4gVGhp
cyBmaXggZW5zdXJlcyB0aGF0IHRoaXMgcmVzZXQgaXMgZG9uZSBvbmx5IGlmIHRoZSBjaGVja2lu
ZyBmb3IgUlM0ODUNCj4+IHN1Y2NlZWRzLg0KPiBDb3VsZCB5b3UgcGxlYXNlIHRyeSB0byBzcGxp
dCB0aGlzIGxvbmcgcGFyYWdyYXBoIHRvIGEgc2xpZ2h0bHkgc2hvcnRlcg0KPiBiaXRzIHN1Y2gg
dGhhdCBpdCB3b3VsZCBiZSBlYXNpZXIgdG8gcmVhZC4NCg0KDQpTdXJlLCB3aWxsIGRvIDopLg0K
DQoNCj4+IEZpeGVzOiBlOGZhZmY3MzMwYTM1ICgiQVJNOiA2MDkyLzE6IGF0bWVsX3NlcmlhbDog
c3VwcG9ydCBmb3IgUlM0ODUgY29tbXVuaWNhdGlvbnMiKQ0KPj4gU2lnbmVkLW9mZi1ieTogU2Vy
Z2l1IE1vZ2EgPHNlcmdpdS5tb2dhQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICAgZHJpdmVy
cy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jIHwgNCArLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jIGIvZHJpdmVycy90dHkvc2VyaWFsL2F0bWVs
X3NlcmlhbC5jDQo+PiBpbmRleCAwYTBiNDZlZTA5NTUuLmMyOWIxZmI0ODY5NCAxMDA2NDQNCj4+
IC0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwuYw0KPj4gKysrIGIvZHJpdmVy
cy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jDQo+PiBAQCAtMjk4LDkgKzI5OCw2IEBAIHN0YXRp
YyBpbnQgYXRtZWxfY29uZmlnX3JzNDg1KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCBr
dGVybWlvcyAqdGVybWlvcywNCj4+DQo+PiAgICAgICAgbW9kZSA9IGF0bWVsX3VhcnRfcmVhZGwo
cG9ydCwgQVRNRUxfVVNfTVIpOw0KPj4NCj4+IC0gICAgIC8qIFJlc2V0dGluZyBzZXJpYWwgbW9k
ZSB0byBSUzIzMiAoMHgwKSAqLw0KPj4gLSAgICAgbW9kZSAmPSB+QVRNRUxfVVNfVVNNT0RFOw0K
Pj4gLQ0KPj4gICAgICAgIGlmIChyczQ4NWNvbmYtPmZsYWdzICYgU0VSX1JTNDg1X0VOQUJMRUQp
IHsNCj4+ICAgICAgICAgICAgICAgIGRldl9kYmcocG9ydC0+ZGV2LCAiU2V0dGluZyBVQVJUIHRv
IFJTNDg1XG4iKTsNCj4+ICAgICAgICAgICAgICAgIGlmIChyczQ4NWNvbmYtPmZsYWdzICYgU0VS
X1JTNDg1X1JYX0RVUklOR19UWCkNCj4+IEBAIC0zMTAsNiArMzA3LDcgQEAgc3RhdGljIGludCBh
dG1lbF9jb25maWdfcnM0ODUoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwgc3RydWN0IGt0ZXJtaW9z
ICp0ZXJtaW9zLA0KPj4NCj4+ICAgICAgICAgICAgICAgIGF0bWVsX3VhcnRfd3JpdGVsKHBvcnQs
IEFUTUVMX1VTX1RUR1IsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByczQ4
NWNvbmYtPmRlbGF5X3J0c19hZnRlcl9zZW5kKTsNCj4+ICsgICAgICAgICAgICAgbW9kZSAmPSB+
QVRNRUxfVVNfVVNNT0RFOw0KPj4gICAgICAgICAgICAgICAgbW9kZSB8PSBBVE1FTF9VU19VU01P
REVfUlM0ODU7DQo+PiAgICAgICAgfSBlbHNlIHsNCj4+ICAgICAgICAgICAgICAgIGRldl9kYmco
cG9ydC0+ZGV2LCAiU2V0dGluZyBVQVJUIHRvIFJTMjMyXG4iKTsNCj4+DQo+IE1ha2VzIHNlbnNl
Lg0KPg0KPiBSZXZpZXdlZC1ieTogSWxwbyBKw6RydmluZW4gPGlscG8uamFydmluZW5AbGludXgu
aW50ZWwuY29tPg0KPg0KPiBVbnJlbGF0ZWQgdG8gdGhpcyBwYXRjaCBidXQgSSBjYW1lIGFjcm9z
cyBpdCB3aGlsZSByZXZpZXdpbmcgeW91cnMuLi4gRG8NCj4geW91IEJUVyBoYXZlIGFueSBpZGVh
IHdoeSBhdG1lbF9zZXJpYWxfcHJvYmUoKSBzZXRzIEFUTUVMX1VTX1VTTU9ERV9OT1JNQUwNCj4g
aW5zaWRlIHJzNDg1X2VuYWJsZWQgYmxvY2s/IEknZCBoYXZlIGV4cGVjdGVkIGl0IHdhbnRlZCB0
byBkbw0KPiBBVE1FTF9VU19VU01PREVfUlM0ODUgdGhlcmUgdG9vIGxpa2UgaXMgZG9uZSBpbiBh
dG1lbF9jb25maWdfcnM0ODUoKS4NCj4NCg0KQSBxdWljayBnaXQgYmxhbWUgaW4gYW4gb2xkZXIg
dmVyc2lvbiBvZiB0aGUgZHJpdmVyIHNob3dzIHRoaXMgY29tbWl0Og0KNWRmYmQxZDczNGVmNTQx
NWJjNDdiMDM0ZGY3NDMzYmEyMWU0MGU3Yg0KDQp3aXRoIHRoZSBmb2xsb3dpbmcgY29tbWl0IG1l
c3NhZ2U6DQoNCmBgYA0KYXRtZWxfc2VyaWFsOiBmaXggUlRTIGhpZ2ggYWZ0ZXIgaW5pdGlhbGl6
YXRpb24gaW4gUlM0ODUgbW9kZQ0KDQpXaGVuIHdvcmtpbmcgaW4gUlM0ODUgbW9kZSwgdGhlIGF0
bWVsX3NlcmlhbCBkcml2ZXIga2VlcHMgUlRTIGhpZ2ggYWZ0ZXIgDQp0aGUgaW5pdGlhbGl6YXRp
b24gb2YgdGhlIHNlcmlhbCBwb3J0LiBJdCBnb2VzIGxvdyBvbmx5IGFmdGVyIHRoZSBmaXJzdCAN
CmNoYXJhY3RlciBoYXMgYmVlbiBzZW50Lg0KYGBgDQoNCklmIEkgYW0gdG8gcmVtb3ZlIHRoZSBs
aW5lIGluIHF1ZXN0aW9uIChkZWxldGUgaXQgZW50aXJlbHkpIGFuZCBkbyBhIA0Kc2ltcGxlIHRl
c3QsIHRoZSBzZXJpYWwgaW50ZXJmYWNlIHNlZW1zIHRvIGNvbnRpbnVlIHRvIHdvcmsgZmluZSBp
biANClJTNDg1IG1vZGUuIFRoaXMgaXMgZm9yIHNvbWUgb2YgdGhlIG5ld2VyIElQcywgSSBhbSBu
b3Qgc28gc3VyZSBhYm91dCANCnRoZSBvbGRlciBvbmVzIHRob3VnaCwgc28gaXQgaXMgcHJvYmFi
bHkgYSBnb29kIGlkZWEgdG8gbm90IHJpc2sgaXQuDQoNCj4gLS0NCj4gICBpLg0KDQoNClJlZ2Fy
ZHMsDQogwqDCoMKgIFNlcmdpdQ0KDQo=
