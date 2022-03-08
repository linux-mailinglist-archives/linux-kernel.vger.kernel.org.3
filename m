Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D855A4D121A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344996AbiCHIWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344993AbiCHIWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:22:43 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1D13F889;
        Tue,  8 Mar 2022 00:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646727692; x=1678263692;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=L32U9avNG4O9VvaurRh+xAzeSnzdHvL870euA3k8dlg=;
  b=QfvZ3NbZzTgNR/B7ZQbJDjjpIodRmwfkqSRgVKu7njpnL7lIMy4WI57e
   p4kBVWKn9gMxnIzE+y5ZTt8viDY53WeORzLmCLsdUeag0E5bJXKXROn6E
   tcaZLq/NcsYlgkCun3mE5ejeKc/UyuPoWAA2nj6/FHkMRLoNaq/nobubk
   TeRcdinLiprJTW+PqXCtFf4NbdDMIbEontVuqpidDHskUOM6dCrhoAdzE
   2+N+9R3oXEKAk4kmBj8I2lStDaUI/1+SnvxATfwhV93PittxphjP6jV0R
   rJZbXoPN671/NzI+3f28fj7EOP8XIy5BuvajYc/gBXh9tXfk9GgSpJOk7
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,163,1643698800"; 
   d="scan'208";a="156065367"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Mar 2022 01:21:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 8 Mar 2022 01:21:31 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 8 Mar 2022 01:21:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDnZ//CXHoCYKFpiSHavTicSoaWhpX8eoE/WnrXnBYO1XVL/4naYCbIlvnEQKF38UT5nVXzHOQUXfIYZ12XK3CksSVbqrIiR6EWZbcyP9ZhcOud6T8sfdVJHCxYNRImVUlcp/yoXktqvGcWgHDwpzOaL9QbQ7ACqCOFh0ziTC1UNa556Q2BW4k06JOf9e0dvyyeMu3IvE1w+33ikUh5hLH7DZ1bgWNXfbIeI0XeohHn35NStxqHEryeCjugVPPFnEdsxPIHNs/ugI+6nu04Va44/+jnF9PdhA5WsYTFjcuEZ4X8uQLIRhhlgMhBrzTFMq22aJuXdbPGkuwgrL47t4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L32U9avNG4O9VvaurRh+xAzeSnzdHvL870euA3k8dlg=;
 b=GEM+mok2ugxXTf9jhvUui1b1pKYhz2QJ2FzddWZ+rDLHRg0NeCsnLeESAws+1WMFZ1PVg0fcNXxyUXyRldtXw2nGK9b+zHYSTAfMNvWsO1H8qlRFfmomvpuHYVTlh36E5lLYmrt/skFpyqqqWLfpC4qt+d2nF+9f5S6FkvahmqC2XvPQQ+waMXwdXrjxlZB7IU6r3BuhOuxLkDzYt3VrqrJ2hY9O/4YkvBt2Bs2/R9bssteePlcNTjI+CgLb8msmaxewIGLu7AyzQU6cNgEuf2dHJiFd+ydFLOjLuu9ZO32bmt8CyaVDc4sSUglu5EyieVInPhdAkx/zbb6Jgc1wow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L32U9avNG4O9VvaurRh+xAzeSnzdHvL870euA3k8dlg=;
 b=QOlZPxI6Ya4PpBsnoV34frKJGfJZtH8hDxduYuhqUc+MfIjAp90BH603d/8AyyY3Rj9M0Hxj20ht5y5RqvGty0GolkXNyEBqvBRRY4CaxbO3MMUGqlwXhwGscyBk/OXZWUCo7jtGqAQRn8eS8yszJPui6q7tW6v05D/NAVuU3TU=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BN7PR11MB2673.namprd11.prod.outlook.com (2603:10b6:406:b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Tue, 8 Mar
 2022 08:21:24 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 08:21:24 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Eugen.Hristev@microchip.com>, <Nicolas.Ferre@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH] ARM: dts: at91: sama7g5ek: enable pull-up on flexcom3
 console lines
Thread-Topic: [PATCH] ARM: dts: at91: sama7g5ek: enable pull-up on flexcom3
 console lines
Thread-Index: AQHYMsV/s2WdRnKidECAAxXEB22tbA==
Date:   Tue, 8 Mar 2022 08:21:23 +0000
Message-ID: <d16673c8-3a19-fcbf-63d0-2d2090fc7318@microchip.com>
References: <20220307113827.2419331-1-eugen.hristev@microchip.com>
In-Reply-To: <20220307113827.2419331-1-eugen.hristev@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd5799a6-79b6-4f59-faed-08da00dca234
x-ms-traffictypediagnostic: BN7PR11MB2673:EE_
x-microsoft-antispam-prvs: <BN7PR11MB2673E4F56949CA295663CB36F0099@BN7PR11MB2673.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8EGcuR/MTpzeabmnW198hIpkfNUwEvAyjIzHntKpa3Ze0q6nIVsBof2Vu4gki+dj+lQgmfF1s1I94j4HwyS5gTePXOQ+yXz4k1s0xfrr9DijQjiwSP1akZtRJ2jegj3UrJzcOWr7TI5vou1UGs4IBS77tWgNC0NfRgPN8U+Ac4nsn+X5yD12WanV/xsreZfmd+2N2sOJ+cBn99RJq7OhMfE54RI+9KRT4uuTH+dNgV6C4nbTOpgZLBQpQwuTbrVJcRu1P6LO1ftOAYEI3Z5phIe2WkRIzcnI87mUIoCbnRuD+BYfXinsZOzCXrbqGCXXYRxjntSdstoluRrSc6fymC3DjsdRAwiBjCi+tWMLwcMkmyPqM0PnUP2RABa5Jw0Cm55HHFXjDSPHpDbpJeyEHm5ZfnMl2c0ZDQ3NuLXb8noOsQjbfkhB4muDj5zO618/qtCqefu4MGUkohMr4+oO5ZfDclieOUgC8rfZ+5KyeP5xU4hjJiibCI7aDi27UiYgPhQ3NMLmJ/1zO3jPj8mHTB6/1NtNoS5pMcrPDR6OGXZgYwRq/Ic8l/GCcrQPJwm0my0iwx8clhmjWjj91sp0ku0eicyicjEWao97dt3AtoanQImK5OnxWj7DzVvBCx4p3KfJqMsktN0PUosZxGVdCIf2n+NTfIfZdWbYU+5XSXb0zTE7lEZWtdGcOZwoJRwG7Q6OpfP4YgIt9dJdFF6g+QkSGVtYSqIoDrAOlj3ZchvBy1Tm6CmjauL+Ix4xurPNDQet46M9nUtbS09f4rrWhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(66556008)(66946007)(4744005)(316002)(5660300002)(6512007)(8936002)(26005)(54906003)(91956017)(64756008)(508600001)(66476007)(110136005)(66446008)(4326008)(122000001)(86362001)(6636002)(186003)(31696002)(6486002)(8676002)(36756003)(53546011)(38100700002)(6506007)(71200400001)(83380400001)(38070700005)(2906002)(31686004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXdaTkgrRnRZbCtZZ0JtZVpOUXFhbFhVWEZVSSsvOUNCTTVIbzFhVU5OWkRz?=
 =?utf-8?B?TWZuVDZocXZtRnBnNk1lalNoN3B2a1I1eFU2ZzJMRFRsZTFpRDNiVEVoQ3B0?=
 =?utf-8?B?WE93aTJyL2tHVzZVMCswcldRejVaMTMrMWJRc2VYVGlVNUJENkVpaEdwZVlD?=
 =?utf-8?B?WUZVWmMwQXlBSWVBWGNIQzFIOHhIRHo3YVVNWlRieFRRcmtMWEpWL3krY2Ro?=
 =?utf-8?B?Mkd6S0ozVEQ4YXZlUnJJV3ZDdTJKTTVTcDl5UjZMZ0JiYU90SzVERkJzYmJw?=
 =?utf-8?B?MEFoUmtmMW95ajZmcTdGRGZjQml1MG1rQTVUdlUyM3loei9wcUJ0N3htOHA1?=
 =?utf-8?B?RVhDdDE0c0w1b0ljb2JKNk81RURMQUo5ZzlKbTlmOGJ4NEVoaFNYdTdHSis4?=
 =?utf-8?B?cW45RklsQjFpWGx3QTBXaDFsNU94a09LeEVqRFZucDNvS2ErQXpkY3FGa1g1?=
 =?utf-8?B?VmtBaFlnK3M2RWRFYXBzTzkrSi80MlhkVExkNGU4ek1NSGIwR0VJK1BUbDdW?=
 =?utf-8?B?WEsxNVRpemlmczhpUnhBSUJEdmZrM2wyNVFvRXNhRktCR0lSc0cxZVlVSzZv?=
 =?utf-8?B?Y255aGMvZUxzeG1jL1BORXdnbU1HdmloL3krcVJuZmtmMzBKbGV4UzRtNEM5?=
 =?utf-8?B?Rnd4Vk5rS3JyVzNNaFUySHAxcnlPM29hQ3R1RXdaaWgreDdLU3RIRGx2N0Zm?=
 =?utf-8?B?NEQvSzNOdVNaangvTXJ0ZFRKVFhOS3lkV01JRy9kelRtU0tkZ2hwalYxaCtm?=
 =?utf-8?B?Q3ExMWpZYVBrQjJWNXg2K3hiODVpeGkyL2RoMXU2djZ4VDFya052cmh2NUdm?=
 =?utf-8?B?L1ptemZEQ0tDVUpBdFRWSzJTdGF2SnFSNWpVclRkb1hvb0swemd2L3ltZWtE?=
 =?utf-8?B?Vit0VS9LMlhJbDllSWxSTzlnMEpZZ0w4QjVKZEx1MXhZY0hSdDFiSXpLcEpP?=
 =?utf-8?B?MlBEL0dCa1JZNExoNC94ZGNHV21hY25TOWM0ZUpjNXp4cVlJbmZtbkorcy91?=
 =?utf-8?B?MWl5ZTFPVlErZzIwWHplRUh6MHZydXUyZnZob1NkUnFqOEZXK1FnRVl6LzRK?=
 =?utf-8?B?UlZkNHNxdWVHSzZVMXo1b0Nwck8wWUtQMFhyMU5CdklLT3ZjMDk3ejBPWFlD?=
 =?utf-8?B?cDdCZmFvUHpyRVJONE5RUW9GWm05NkdOMlJpeGZTOUhwSWRtSGpQRTZtWk5F?=
 =?utf-8?B?T0luQnRMRW5EdXNxVmVZaEZSNG1QZjZZamVJbmpsVnZYQjkwamZoTHc3OU1I?=
 =?utf-8?B?eEdUM1NBN0VST2RTZVZKaG5tRngrV1hjcWJjd0U3MmFKTkNOME5DbDAxRzl5?=
 =?utf-8?B?cG1HelNoUjhUaGZNYXhFSDhUcHlpY3B2TDBCT1JWYkhLVzNXRk5NdlJRK0h1?=
 =?utf-8?B?eWJrTU5VRkhYMDd4UnJXVkdrSXN4SnZldU5KTXVkVmRHcVdOdzFXWmRlNFBV?=
 =?utf-8?B?czVHTlp5RGdzZkI1ZkNiNFNZbmhocXYzWmNQdlVZTXl2SDdyeFVsS1c3Q2Ju?=
 =?utf-8?B?Nzl1L05jUStOd0k3eHZwY2U5NFVNRGZQbWg3UlYzMDNobFF6NlhNa1E0Q04v?=
 =?utf-8?B?UVo5VGhXMCtPYUt4M1duaWpoN3dhVFVDK2RqTnFTNU1UWG1nc2wzTW53c3VH?=
 =?utf-8?B?a205K0xEVDhyWFdaVmRmd2N3b3lnSVdWQWw5cklUZDJhdDdURUNzL3BBRThj?=
 =?utf-8?B?UUFUYnVucDBKelI0bU1pK0gxcEZyVklnanNVdlBuTzg3L3RyYnJ1eFBxNWVG?=
 =?utf-8?B?bEhVTXk4OW1LWTJCZU9TRkw0SHNZeW1VRHJkZ2xBa1o4QktLZGJ5alVUSGRV?=
 =?utf-8?B?d09saHREMzdpUDFreEJKME5zbTNURTZBb3ZobHpxQ0hzV0ZIa294cFlwSlVI?=
 =?utf-8?B?UVJaNUN1WjJtQmpDdE9aN1VZM29DcU1MRUhmdkNKNHdCSFhoa0xPZUdXbUlD?=
 =?utf-8?B?dmV3TDNtTFMxSlNockNYNm83RmZGd3ZNVFR1RUpISHNJZU9yYzJmd3JlWEl3?=
 =?utf-8?B?VmF0ZS9xdUo4Wmp6Smd2d29uWllFSmNVUlhic0NEeloxdk1QSy9ZYll3Um1U?=
 =?utf-8?B?cUs0ZFU1cjkyeGFjL1J4YTdlRUVIMzIzZXNHTkdWVDJjK0RrMGhsOGh4WDZX?=
 =?utf-8?B?V3ZhMXBvNGdYN0dGcHFJaW5PSitTR0lPSmRIWjF1cVJhVTJKT2MrS2lyeVl0?=
 =?utf-8?B?NVdvZG84bGlYdU84OW9uQmlCUFd4am5Vd3BleEllKzhEeWFDTnlNSldJQnh6?=
 =?utf-8?B?cWlpWWVWMXdNQmdnTFVqeHpWREFBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C055E9ADAC93E4791EBD3626C6A9E69@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5799a6-79b6-4f59-faed-08da00dca234
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 08:21:24.0063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CrGQ9F/P4lXCN4ytB2g7yP9zxcJ70ip2BLbesY+ZhuMn4hApoOQooxj3727TQ4ZNLkptNPE4vemWsPP19liCEOkvxB3l98HbIEnc4NFh4Qc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2673
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy83LzIyIDEzOjM4LCBFdWdlbiBIcmlzdGV2IHdyb3RlOg0KPiBGbGV4Y29tMyBpcyB1c2Vk
IGFzIGJvYXJkIGNvbnNvbGUgc2VyaWFsLiBUaGVyZSBhcmUgbm8gcHVsbC11cHMgb24gdGhlc2UN
Cj4gbGluZXMgb24gdGhlIGJvYXJkLiBUaGlzIG1lYW5zIHRoYXQgaWYgYSBjYWJsZSBpcyBub3Qg
Y29ubmVjdGVkICh0aGF0IGhhcw0KPiBwdWxsLXVwcyBpbmNsdWRlZCksIHN0cmF5IGNoYXJhY3Rl
cnMgY291bGQgYXBwZWFyIG9uIHRoZSBjb25zb2xlIGFzIHRoZQ0KPiBmbG9hdGluZyBwaW5zIHZv
bHRhZ2UgbGV2ZWxzIGFyZSBpbnRlcnByZXRlZCBhcyBpbmNvbWluZyBjaGFyYWN0ZXJzLg0KPiBU
byBhdm9pZCB0aGlzIHByb2JsZW0sIGVuYWJsZSB0aGUgaW50ZXJuYWwgcHVsbC11cHMgb24gdGhl
c2UgbGluZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbiBIcmlzdGV2IDxldWdlbi5ocmlz
dGV2QG1pY3JvY2hpcC5jb20+DQoNClJldmlld2VkLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5h
bWJhcnVzQG1pY3JvY2hpcC5jb20+DQoNCj4gLS0tDQo+ICBhcmNoL2FybS9ib290L2R0cy9hdDkx
LXNhbWE3ZzVlay5kdHMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9hdDkx
LXNhbWE3ZzVlay5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE3ZzVlay5kdHMNCj4g
aW5kZXggMDg2ODVhMTBlZGExZC4uZGQwNDdhODUyMzkwNyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9h
cm0vYm9vdC9kdHMvYXQ5MS1zYW1hN2c1ZWsuZHRzDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRz
L2F0OTEtc2FtYTdnNWVrLmR0cw0KPiBAQCAtNDk1LDcgKzQ5NSw3IEBAIHBpbmN0cmxfZmx4MF9k
ZWZhdWx0OiBmbHgwX2RlZmF1bHQgew0KPiAgCXBpbmN0cmxfZmx4M19kZWZhdWx0OiBmbHgzX2Rl
ZmF1bHQgew0KPiAgCQlwaW5tdXggPSA8UElOX1BEMTZfX0ZMRVhDT00zX0lPMD4sDQo+ICAJCQkg
PFBJTl9QRDE3X19GTEVYQ09NM19JTzE+Ow0KPiAtCQliaWFzLWRpc2FibGU7DQo+ICsJCWJpYXMt
cHVsbC11cDsNCj4gIAl9Ow0KPiAgDQo+ICAJcGluY3RybF9mbHg0X2RlZmF1bHQ6IGZseDRfZGVm
YXVsdCB7DQoNCg==
