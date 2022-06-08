Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084105428E7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbiFHIHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiFHIGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:06:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64271F5880;
        Wed,  8 Jun 2022 00:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654673853; x=1686209853;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Eag6Lh/S0LV708EcBNMf/sXvde4Yq+2WtaO4ZjLD3QA=;
  b=j6DI3+cCycsZ/MU1e+/o+N9OKU12c+WQAk8tsLSeUasi1kWthVxl7nQn
   ucG3KMUGDICDKCzOuuLsoW6FCphQaWK7f3h9q5Vo5sY3xU7NBDZzphhmx
   IsCXA5K1ArB7XVTUMqARYMZSdskanl1VzQF02iyUYW0ZM1EeGOr9itRxf
   coFDpsLwyV8T4GXjnq6W/WsM1Mja91mt/tgsWKmEqaPctFji94tAwn7oi
   WCw7rHnEHcOPq208QH8p/hjKg1/MOR9/Q55XZl+hZG1U/KSgT2lHQC6FE
   FWmDjrfNVxFcOWVmKCIVe8FKzfCaMUYnKaAdxlQnMKsmYUOvH6gI/XTxX
   g==;
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="99068344"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jun 2022 00:37:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 8 Jun 2022 00:37:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 8 Jun 2022 00:37:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMIlH71D+iXpUkqk5wo0Tm3gYpk1sv3Y14He+XzTPaXo7iwdpHpcD61ZDHp3wENtLSircf5NlEaDmYQa+jaWM0YBUF6aHhMtAygcgn4vBgHk+Ce4jr/jLpjzl9nCpGy3aTkgUq91Eb+l6AWSxTtLu+/D3O211speJhCvpDyU1FIobVPoE+SJbQdMp16S+gOBcYcRyI/SUEOzNKYgls/6vofw6mFE/AbdAziztXj1veehA1ws7UFFEoNCOHD35ro9szz9+p/wFD1p9ClLsHJW+c/N37xCPGIPL0C5mxSpDYkrMzjy9gl+5S1103mj/qpMSZNYYp6fxCtUSQ5nVz9RNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eag6Lh/S0LV708EcBNMf/sXvde4Yq+2WtaO4ZjLD3QA=;
 b=dq0VWGeXxpXU5hMLd8bGHGw1uqzlpQVB3KPvGgNUWURv7mcjeYR1bgGksaDscZRSnHv/lOlSmDBZlaD5cfAaIa1ossD0Qb9xgJiAysXvbMl7aGyzwh2E7U3xEPFyDZb1VY52caCObpWEIQST8Igzo/pd3pvY3ipQNaUiiJvVm+3L1GZC4yXb7bRwAQkXlNPzBrJmdYNNZQKYSU3dXZTS33n85Go57o5acDoeNzrp1srHYgPPEDghgYSgZ/GrrLPBe6O5nYUVuOjaxPbu2iugf6WImrEJTBtsxS9y79vVw3nfattk0rhmNHO8SJ8FUVRzfkdkY8/ZBsnETB3U+fRqYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eag6Lh/S0LV708EcBNMf/sXvde4Yq+2WtaO4ZjLD3QA=;
 b=Xsi+tCdE7eQNoDPGHu8kvva3IB5kG7brlf2cvfJwvAkEHeGvLKaezENzvi+Aw3b6B5tU7GJJgPzAFh6tRw6+tLjtMCKXXdVpbf2OLndrOW2xhk+LarRjv8ve527glbLC80jElTcVdZKMXFrkzIrPqB/bOjp88VU+dLmNgAY9g/U=
Received: from CY4PR11MB1960.namprd11.prod.outlook.com (2603:10b6:903:11d::21)
 by PH0PR11MB4888.namprd11.prod.outlook.com (2603:10b6:510:32::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 07:37:28 +0000
Received: from CY4PR11MB1960.namprd11.prod.outlook.com
 ([fe80::457f:8e4d:4bc1:b997]) by CY4PR11MB1960.namprd11.prod.outlook.com
 ([fe80::457f:8e4d:4bc1:b997%12]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 07:37:28 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Eugen.Hristev@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH 2/2] ARM: dts: at91: sama5d2_icp: fix eeprom compatibles
Thread-Topic: [PATCH 2/2] ARM: dts: at91: sama5d2_icp: fix eeprom compatibles
Thread-Index: AQHYewqawICcesfza0CkEkcF2D0qvA==
Date:   Wed, 8 Jun 2022 07:37:28 +0000
Message-ID: <a946e0fb-815b-cb38-9541-5d6092708007@microchip.com>
References: <20220607090455.80433-1-eugen.hristev@microchip.com>
 <20220607090455.80433-2-eugen.hristev@microchip.com>
In-Reply-To: <20220607090455.80433-2-eugen.hristev@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ae9716e-0a96-4205-3a7d-08da4921bd67
x-ms-traffictypediagnostic: PH0PR11MB4888:EE_
x-microsoft-antispam-prvs: <PH0PR11MB4888859BE3BE6D3F0DABA32187A49@PH0PR11MB4888.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: llXlnV+oJ7/4nzBp5ipcJN1W6EqvqPDzhA+/6ViEZ/0sZOIJocqNu/ZdDk9BOpF4hOMNWe5ngqNiIVQttLHRAlWZiSj2zN9nX9ki7eF3kY0uO9Exhs94DdsdaTIE3LR6qwTwEo4zDPmWbZPo/POX1dboCTqO/eVCSFpOh23BV5KUVsRO2oGBvHrKqX36jwMRxTu3QFe+C01RNt4SUnzFpcaBsQJcW1ojQ/+Hq033l7e02buCwlQNu9kjAv30H5t4p2N8YuF4lcnVXw4JtLlhhH3UC05+R6Rw4h4Xbj0itnLyIrEwdDsj+2ixWM03om5speTgHek9DOF0bv+cnlj8KIgqJTRWG3Q0Yzyb0Mcc6cavaP50mVaw0qnPOMEQFkRGFYB7Ozs3qqdqL/H3fZa4fsfJcbb9KKX864JT8Itunck3wnerO8C0j2nMkCZM/0X5WC7gZHdsiki54PudIDU6akVtkDEId/JLmW6VhDXgw7/ZWJ6O4hfd6HUY1B/tOyB2oSKUQQZHLI1VYdEfTsTdDOvcWhcOSmtT+wPtpOO/EV4Hwky0mXqrVpGJViznlFezbmlxiqa0o5RgbHYW9/89+IgkI8FrvbXnWqXewTQPZ7NV47SJ+kTYPQR2tDhHR9k1keHzO5MrYD8NYHJoxg3hJpVBGHAer1+xHeCQt9x83MsXIN59xk5trhxKUR01aKfBJQMVH1qWLRAutGReulZm0Wri8LiYYRShrWDyVuNwZTYzd/Hz1WgF8tLy7xhIW8gJBHauSbazcKmx3whZNSiBAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1960.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(8936002)(316002)(91956017)(508600001)(5660300002)(38100700002)(38070700005)(110136005)(54906003)(66946007)(71200400001)(66446008)(36756003)(66476007)(8676002)(4326008)(66556008)(64756008)(31686004)(76116006)(6486002)(2906002)(122000001)(26005)(186003)(31696002)(2616005)(107886003)(86362001)(53546011)(83380400001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2RLdE1jckJ2K3lqcS9jaExJdzY2cHdINFZqZGpHWEhZWEZlY0xiZ2d2YVhx?=
 =?utf-8?B?Y0YwSjB3OXJneHhWMnY0SmhzVFBBalhpZ0lIRXFaaEM2U2FrT0psYjdjdEVP?=
 =?utf-8?B?dVU5WHZBWlFoclkrOHovOHppenNKTXpWdjZ1aWhzMyt0VWhyTVVHdVk4d3pZ?=
 =?utf-8?B?ZlAydGc4RTlhdW9zS09ib05vZXlsUE5Xem5ZSURqN3NhOXBNR1JXdjRNQ3BK?=
 =?utf-8?B?OGJJQzJaTVAwOStKVXNJRUd0Tm1GR3BoR0ZEOFdSdENNem1Rc2o4akZacDlZ?=
 =?utf-8?B?bzk1cTdGRDhpYXdURVZqQ2JCbFpxVjBiYlBkUElWWnE2cEpIYzVtZC92WVJV?=
 =?utf-8?B?a05RZzJETzUzUThNVjM5eVN5TW1zYThPbjFOeGVQb25yK3NjRkI5bUFiMWxB?=
 =?utf-8?B?R2RtdnlNa2d2N2xoWWxIclBDMVNNYXN2N2ZrN1VselVUSTJoVU9kMU5qM2tB?=
 =?utf-8?B?RWhYYytrY1V2VGI1Y3RsVk9jQjB0SllHOTFLRHNHVTI2MHM0YTlOd1FNWlZ5?=
 =?utf-8?B?bjhBNm53aTZUZjBRbVlac0ZGQmhKM0lrS1VSZms5bmp0VmZGZXdkRWVlNUhR?=
 =?utf-8?B?RkJrakg5ek5XWmFpVGpwdnpCU3p2ZnZMWElsT3JwNVBIQ002TnRxV1k2Vjg1?=
 =?utf-8?B?aXZyTVNRd0Z2NmRUOWV2VVAwQlN2ZGFudnJzRURBU1lzTlUzNGJNbExQanVj?=
 =?utf-8?B?QVJ1MnFxU0pzcVZzbHRWYzVPMzI4R2o0Rmg3S2EvVUtBZWdhTEt5eDBrZ0Yz?=
 =?utf-8?B?R1YyZmNvYjhmMlpubWQyQTkxbEh2d29EYUNtM3B0K3RBY0p1QUZ6L2tQMkNJ?=
 =?utf-8?B?WEhlRWJoZVJiY3JoT05wVVRpaWZ3QlFvNDJLdnhtSUM3TWY5WE95V3k0UVl2?=
 =?utf-8?B?eGxROVdpTmVIaUtvcWpuR3Z5a1VEMFFhUTY1NkpXdnUvUllCV2lsMW10aXRi?=
 =?utf-8?B?eVQ1Vnh4NGllVlhFY21idkdFeDhjTDNFOU1NallFZXFLc3pHWlRuekRUSXls?=
 =?utf-8?B?KzBoRXg1TlVMWElQM05vYzMzREFLSEtJMk1pei9jSzk5NytySHp3YWxqQWdX?=
 =?utf-8?B?N0Y5VUEvdTVEMEJHd2JJbFRVSHVpWUc0VFhDUit4WG1Sa2UvL0hSWFV0ekhw?=
 =?utf-8?B?TS9LNVBTcDBVUXVyM2pyOHgzT0JpZ3JZWlZZcXE4cjVHUzlXcDJWRmFwSDVF?=
 =?utf-8?B?WEdpZk5mR2VNdFlGR3U5UGtQc09uamhKTjgrdjhSVzVLRjNtNjVTWkcrdUx5?=
 =?utf-8?B?MUd3NUVzWVpEbTNQZzFnenpGalpES1Rta2JyeHcybW13K0l2WkFXWGc4SEdE?=
 =?utf-8?B?RUFYbVpjRExnUFlmNkdCUWRyU2d4aW90V0ZjbjMrTXdWYnJLV3FMaWxRdzBF?=
 =?utf-8?B?eXpJWkZPeWtobklxV0hxVEwvazlscUo1TEI5K2ZjRkU2bHJJSEpHcWdCc1NE?=
 =?utf-8?B?ZUtDU2dxVE1LZGcwR3hDWG1oOEJJVXlER0E1Sk52WE0vVzJlcE9zMHgvMklm?=
 =?utf-8?B?VXNjM0ltU0JDUGF0czZTdVFINloxRit4NkpmakliZkNIc29NdjdrTVBxbEJx?=
 =?utf-8?B?R24rZ3ozTEwwbWNoaHhRRVVtdFpoUU1FZGtXZFVWKzl3MU5xaHZJUVJQTWl3?=
 =?utf-8?B?S3JSYWhrN0tHdWxmbnRaa1lhQ2pmcWY2QjI1VllzdkRhOEN1T2swOGhvb21j?=
 =?utf-8?B?bVlUNXE0RFhQRVEyVkU4NXlzTEZVVzhBM0QwSDlmbUVIaDdVVU01RWxNTGoz?=
 =?utf-8?B?RXlDV3EzVCt1QVZXQ2MvdkUwZDlCcCsyYkpwY2w5dXhtSURiZXVSTGFGc0tO?=
 =?utf-8?B?ZkU0ZUw0eWhOQUx4ZkxHNzJIdzJuMHRiS0RweWpmc0syd25rRGxQQm1EZHBk?=
 =?utf-8?B?cVNhMUVqOGR5NnI1dmovOGJUYllPbDdBemRDbWs1Um5IVjI0UjBMeVRBTXpZ?=
 =?utf-8?B?ZzhZRzBLRXpEUGJiZ2dndHlzbXJlR09YVk5qQXhZK3AweVJhWFNmcFBicFlH?=
 =?utf-8?B?WHdXQUplVTRhSGtIbmhpNCt1ZlA2TGduczJPWGZHK2NKMkdxVCthQVowQys3?=
 =?utf-8?B?bFgwb2Q2eVVCWkdlZUdnSlp1dG9BVzV4Wm1vMTQ3UnZuYXVhWk5mUnlLNDhw?=
 =?utf-8?B?RDYxM2Z4d3JJeUhhLzA4R3VYRU9oS2FCbHNoL1VWQmVvUVd2MUdQbncyMElY?=
 =?utf-8?B?ejVIYlBCdkFPVjlXMXUvblVaTXdVUWVjT0Y5cHRmeXRVMWhEZDViNm80YVk1?=
 =?utf-8?B?K2JHMmZXVHBYUTZFaEo4dytseUpBREpkMlpFT0FxQTV4RXRsMWhYVWNCSUJZ?=
 =?utf-8?B?cnM1TzUxUVR6YWdsUXVCaU9yelY2NUJvenBaWHhiUnhoNWphSnRrTjdEejly?=
 =?utf-8?Q?la3VMNc6XgBKICAY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59E61DCE930DAC40B911C9A6B95FA754@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1960.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae9716e-0a96-4205-3a7d-08da4921bd67
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 07:37:28.6285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d4G2RA6JWAjz7Cd3/IPoTEMIKIjMfJH1rEy5K5zxLkKVdIc3xPtOJYrAt3Zn20kRlgWNrll2IQUO6TCYLOMg40MbwP4+EkppUXp09Qo12dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4888
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcuMDYuMjAyMiAxMjowNCwgRXVnZW4gSHJpc3RldiB3cm90ZToNCj4gVGhlIGVlcHJvbSBt
ZW1vcmllcyBvbiB0aGUgYm9hcmQgYXJlIG1pY3JvY2hpcCAyNGFhMDI1ZTQ4LCB3aGljaCBhcmUg
MiBLYml0cw0KPiBhbmQgYXJlIGNvbXBhdGlibGUgd2l0aCBhdDI0YzAyIG5vdCBhdDI0YzMyLg0K
PiANCj4gRml4ZXM6IDY4YTk1ZWY3MmNlZmUgKCJBUk06IGR0czogYXQ5MTogc2FtYTVkMi1pY3A6
IGFkZCBTQU1BNUQyLUlDUCIpDQo+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuIEhyaXN0ZXYgPGV1Z2Vu
LmhyaXN0ZXZAbWljcm9jaGlwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENsYXVkaXUgQmV6bmVhIDxj
bGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQoNCj4gLS0tDQo+ICBhcmNoL2FybS9ib290
L2R0cy9hdDkxLXNhbWE1ZDJfaWNwLmR0cyB8IDYgKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTVkMl9pY3AuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5
MS1zYW1hNWQyX2ljcC5kdHMNCj4gaW5kZXggODA2ZWIxZDkxMWQ3Yy4uMTY0MjAxYThmYmYyZCAx
MDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW1hNWQyX2ljcC5kdHMNCj4g
KysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW1hNWQyX2ljcC5kdHMNCj4gQEAgLTMyOSwy
MSArMzI5LDIxIEBAICZpMmMxIHsNCj4gIAlzdGF0dXMgPSAib2theSI7DQo+ICANCj4gIAllZXBy
b21ANTAgew0KPiAtCQljb21wYXRpYmxlID0gImF0bWVsLDI0YzMyIjsNCj4gKwkJY29tcGF0aWJs
ZSA9ICJhdG1lbCwyNGMwMiI7DQo+ICAJCXJlZyA9IDwweDUwPjsNCj4gIAkJcGFnZXNpemUgPSA8
MTY+Ow0KPiAgCQlzdGF0dXMgPSAib2theSI7DQo+ICAJfTsNCj4gIA0KPiAgCWVlcHJvbUA1MiB7
DQo+IC0JCWNvbXBhdGlibGUgPSAiYXRtZWwsMjRjMzIiOw0KPiArCQljb21wYXRpYmxlID0gImF0
bWVsLDI0YzAyIjsNCj4gIAkJcmVnID0gPDB4NTI+Ow0KPiAgCQlwYWdlc2l6ZSA9IDwxNj47DQo+
ICAJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICAJfTsNCj4gIA0KPiAgCWVlcHJvbUA1MyB7DQo+
IC0JCWNvbXBhdGlibGUgPSAiYXRtZWwsMjRjMzIiOw0KPiArCQljb21wYXRpYmxlID0gImF0bWVs
LDI0YzAyIjsNCj4gIAkJcmVnID0gPDB4NTM+Ow0KPiAgCQlwYWdlc2l6ZSA9IDwxNj47DQo+ICAJ
CXN0YXR1cyA9ICJkaXNhYmxlZCI7DQoNCg==
