Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEF654AC81
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355833AbiFNIuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355067AbiFNItY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:49:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D532DD0;
        Tue, 14 Jun 2022 01:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655196551; x=1686732551;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vhtIuIjNOxvlRytlOSuiG+LwyT95x2rnFK4q3EXBOOI=;
  b=KEKyCBuTZSbvmxt29JjE4qutASPT5ZFynh5MXuE2liWm/gTpKkg0w4cj
   TiTF8/G9ZOXGfcyX8twpfcArB47+lig6hXWp+Od7t5QD4iY3NSbcwz3vA
   giSGh95bY2+2pyqHkoDdxy0gI36rpsKmyX/kX5peTVjIQcwAxFG4s/0k8
   uVRXgora+KYGm9lZJj1BtP0argegGMO/LZfHSW+OPLQ5hQ6tvnbxeS5y8
   7eE5QQRvphFUbKiMqchBAhF1WYoZDIY9A7Rkc9aUeO0fMzvZXxEITp4Jb
   Eztr+H2y6EvbcfYaT7zTkCPGD+CuUbFvb/8pjSU8oQsjLvwJyRm6TYvvk
   A==;
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="177856035"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jun 2022 01:49:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 14 Jun 2022 01:49:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 14 Jun 2022 01:49:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8+TwfE8R4YncnC/zJIglKcZ/hcZrIo1u9Q2jm5YSFa4FSbTiuzwmnjuTg860/BWwE0qOjPaN5hMn4VREursO1IuWgEJ0ZzYcpyHR7QKXYyiAEA9WtU9azgFnVvQYvoXjgRsjtVSa8KNk5qwdGfr45cy0cUtzT/B/esIi4z3GJNQnQ9/o4dWtUDGz2dZQ6JJtFM5R9E58ZEfVRPBPaAHm3EU9u+xskVZ+auiREJEQPbxmlGxvT+ZFFW90z17cs/zNimiJHdd2DPiq3TM7I/Ac4/Mn37rKB5KMBomDMH+eSq4uE29hufxipqDhAkheU7e7L6/ax1VNdGY8mmnhfN9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhtIuIjNOxvlRytlOSuiG+LwyT95x2rnFK4q3EXBOOI=;
 b=kV1JbGgOioKhIu19bXziCTt8knDLE40+tJjxcpHrZPxTZzTMpL64BZN8Fa/JyvCO6N1C9O/6h5DEjXCmz8r085k29h3wBtjak+MnP/+ixi0PCA557eBUPx0Zd/uxJGBShOtvYdL98ip04GatAxz8+L3hJ+2IEpKI6r3prNYX5sw2dzs2vIXOMlUvukyNuU4qMRgeir+zgw9TiPVqglORoicuqALAV1ySWy0BjfIfdrkvjDhJMWlQPliRUZywSWYE33TaBFGyIJCB4gR5UZmlDarYECJLFIolgVKFXpTC6bAxfW4yLDTHERGeZqTZpYpPTSDKVrj8yoXnu5sgfMrBnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhtIuIjNOxvlRytlOSuiG+LwyT95x2rnFK4q3EXBOOI=;
 b=U7Sn2YTS4d7Qphkjwf5DPdHLh/y/H24g/iuYTxf8ndto6aWfuL+8ajA+5WHMqGOJahU9M+2PnUmzHmIYwUUa/BZN88fdy21M3CRsEJCcXb+UgplDRSply4ZiGC19ejuSo/P2CjU5e2S8yWCqRMKvvpkajRC1HNxYKdqAtWo4fCI=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SJ1PR11MB6276.namprd11.prod.outlook.com (2603:10b6:a03:455::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Tue, 14 Jun
 2022 08:49:04 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5cfe:8088:aa93:fce8]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5cfe:8088:aa93:fce8%3]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 08:49:03 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <jic23@kernel.org>
CC:     <Eugen.Hristev@microchip.com>, <lars@metafoo.de>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <ludovic.desroches@atmel.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/16] iio: adc: at91-sama5d2_adc: simplify the code in
 at91_adc_read_info_raw()
Thread-Topic: [PATCH 07/16] iio: adc: at91-sama5d2_adc: simplify the code in
 at91_adc_read_info_raw()
Thread-Index: AQHYf8uZj7DB9JQzJEKqTek7NXQEjA==
Date:   Tue, 14 Jun 2022 08:49:03 +0000
Message-ID: <14fc4d7c-4ce7-e4ed-3e2e-400cbd16c071@microchip.com>
References: <20220609083213.1795019-1-claudiu.beznea@microchip.com>
 <20220609083213.1795019-8-claudiu.beznea@microchip.com>
 <20220611185403.3eaf9b65@jic23-huawei>
In-Reply-To: <20220611185403.3eaf9b65@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35411821-2c31-4410-0054-08da4de2bc08
x-ms-traffictypediagnostic: SJ1PR11MB6276:EE_
x-microsoft-antispam-prvs: <SJ1PR11MB6276BF88B56CBA9661F25CA187AA9@SJ1PR11MB6276.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KF3aSVKci4fE0ZqZNZBh5KxtK9tmdOeYkZCeCcD4lFOuKZvEHynIYtrcf2tWZMVHc6rElx8jAyls7F06jpatEN3tRJLYyuBQsKENfmeVkRnyj5T8diOgVKBK9SB8Ow7FNLbpgBkT7hb9Raoo+eXjbRgnJwRXheHz+oYzx65Dodf7s71oql7/6DnoqvWEmjMxGGlqAbR0A8jO/yZTZH+h3VouSON+wPzIqUNGGchVSXjmixWPkIGLG9PUU1jSRNjkKBTScHJTuHD9sWr1rJqM4zeWikvnCHNyA9i+QzpG+rVpe6iW4KUBLvh8FHHlU85rBLypETrbg7d/jY8ppybdp0mJVBnU5XST9Ffhcocx+OStFpqeyVlWr30cNlFz7iDRDZa0TQdeDHXesfqUTTGgQ+Ro/OMPvzdsn9GBl4XhNS3p0MGi6Y/uDXn30fZyiO2pgUqg1YnvzJXvBzULedieXp2yz6BHmVmzjzldPtgZM+pvnaQ0TnvA2oFvdTRnakM4+QUnULJ74NaIsrZtFz1krwIB3RPFNneEd26JQ6UrZ+LP2P7fqQhZz+RoN7aMPOsoXmnd63M+Th140pqOUl+0R3y941+EtcN3sneik8MzrMrtW+J/VLLSNusFyNEJQosOc+Kba+VvnE7DpOIuKpMyWY3MPP3Uh245VhzfcywatV4AG/kzXXJO2ZQeJTA0pSdu0Mxgfpd77a9XVmBuKXGiD7lVtTGOPGsKhPSG5TdC+I8MeO2TWQ+9mqltGi5ZISdJbRZI2eMIi8lMS9+kPffCTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(66476007)(91956017)(66946007)(4326008)(64756008)(66446008)(8676002)(76116006)(66556008)(6486002)(7416002)(38100700002)(6512007)(8936002)(71200400001)(38070700005)(2906002)(6506007)(5660300002)(31696002)(26005)(53546011)(86362001)(36756003)(54906003)(316002)(186003)(83380400001)(122000001)(6916009)(508600001)(31686004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nm1DWnFaSnZhd0pLV09DVWxvZnp0YkNqSFZvSjlnVEliTjZua2tScmZCVCth?=
 =?utf-8?B?bEZaYXEva2FHZGIyNEdiSG9seDJBSkhrMzFJL0FBakljTU9wSmY0Tm1TcldX?=
 =?utf-8?B?RDkyQ2dpRXd1bWZxcU82S3RqdFlncjc3WFZvNzBldUV6RVBlSi9weGErQnZh?=
 =?utf-8?B?UG1VYnI1ZEVzTDRKejZiQmppQlJOMUIxaEpERVB1dlVnbk01Y200WkpRZWNF?=
 =?utf-8?B?enFrNHR4eDRPSFgwUHArV3I2czNYSG1NMGkxa0hoenJJdjd4K3FYTUROQXZl?=
 =?utf-8?B?QVZraU9TK2hqbGFLNjF2NENqMDhabFNOdWloNTJvMkxrQmlrM3gxZGZ4WW5Z?=
 =?utf-8?B?TzRpOFpBcEpSZ25kb2VkK25XeG1mSVpKdTZkdTBjdzVHV05pVlAyUWVTeXRh?=
 =?utf-8?B?ZlVhTDIwRDZocDF4b1NERFNqc0FoclZrc0FVdE1hRjV2SURnT2h3WnE5b3lP?=
 =?utf-8?B?aEhxSUlQcER3RS9jcmcrcFdxZmZIeStJUEs2NTNrTXJPS1BKRTlTWEhoVkhq?=
 =?utf-8?B?QWxkSFFzVEZnTG9PRi8zYVpYSHZPeHZKMnRCSWFLZXcrbGpFWTBpWTY4VnpV?=
 =?utf-8?B?UURPRC9aZzdUdVlidTRQNnoraE5CeFkrdFliTFBCSyt5Zm9mVzZSTDlxUWZT?=
 =?utf-8?B?WmM3Yk80dFFhbzhqMkQyUnp6VFJ2cE9aRHZjQ0d4NUNNeHVtZjhxa1ZlczBw?=
 =?utf-8?B?WTNPVXRmZHhXOHlxdk1kMWV5R0o2QnlndEZYMVk4SXdMWVJKTHBaRkFpN2Z1?=
 =?utf-8?B?MWVqejdEMWFBSis2YzgvTEhuZnRaQmpmU2tCVWxsUjNtNVFQbFYzdFNXZ0NR?=
 =?utf-8?B?SklmcEdaNFVtOG9ITXVmVmJXZXdOV3JxbUNiaEF2N3FXTU9FTzdQYlVwUXpO?=
 =?utf-8?B?ZHdqZGlOYUtzYzdIc1pXVVlpSVRzRGowcWdUZURqaktmSFVLR3JEMFNub1pL?=
 =?utf-8?B?NUVteXlmd0hSNWpvYmRta3N1Z1l5WjgxUnRMd0xERWQ0ZnhVMGI2RGgvNFNN?=
 =?utf-8?B?b2dhL1ZkQUFZUHlqVSs1cm12clFGdDI3TElaNmRiTEZyWThoRkJjZjZoVVlZ?=
 =?utf-8?B?YzBKdGQ3SFl1dVc2Z3VrbmR3cmhaQzdSYTc0aHF2VytCb0pvQVc2K09HSTMw?=
 =?utf-8?B?OHVNUXdvS3g5ZDZpd2RrODMrQ29JUFB5SnNvNFhvMEc5SjFJSGlGUjgxSTY4?=
 =?utf-8?B?VGNGUE5ZZE9RdHIyMzYwM2l0cUFSeU81QzFnUTFweTJpWWxvZHFqWEJKQkVC?=
 =?utf-8?B?ODhmbUJHTDZNZWtrYktOeVlmZWhXSzRZeW92ZnpYRWpORnJxQ2hvems2OUdK?=
 =?utf-8?B?NHR1d2NhblY0bCswamxuVitIRElQaTU3ODZUdEZUaWlJODVGZGtKWHAwenpR?=
 =?utf-8?B?OGMvbWZObWtlYWRRdjRDbklOeXF0aHZSTm9XQkdjNy9oZWUySTIvbElCUnpM?=
 =?utf-8?B?V1VXc2M1RURRYzdDZ0dscml6ZG5lUy9LOUxPWUxFYjJIbS9PYjd3SVFDaWh5?=
 =?utf-8?B?eExmbkNuZTQxT3IrWEM5cklXZ2NoVDlTemc0MlhpanljR3ljQWdFaUtNZ25k?=
 =?utf-8?B?WHhaNWV2dVduZFRWV2ZwNWllZmtRRHc1NHdSbHpMYUhIS0pOMG5wUDdUTTE3?=
 =?utf-8?B?TWZORnE1eU9PeU1mL2hsR08yZkt1UXRlN1ZzaDg2RnFrQ0YzS2xkaTROWWdv?=
 =?utf-8?B?M0lPSUUxbUFVQVlyckc3UzJxTEtsWEp0MXVzOHdEeWdqQTVQSWorb3JhK3pw?=
 =?utf-8?B?TUt4L0kxV1JBY3hBMHlaRnR5ZUwwYnZFTmF1UkRLWW1WUjJTeTl4c0pXZ1F6?=
 =?utf-8?B?M1JvTk15enBkb0F2d0lOZWY2V3pVaEF0aW0zM2MyaTh5aEp2eDBRdE9rMGpN?=
 =?utf-8?B?MTZiL2dKVGROOEhhU2h1WFZXY00wTk9GWXpsZ1RrSFhyWEJLTk1pSEFDSzVp?=
 =?utf-8?B?c0V2Vm0xZFRMdklaRkpLdFVyVGtGN2dnL2tyNVQ1V1lRL0xYc2hmbHB0RVdF?=
 =?utf-8?B?RTE3UXMwc2ZBaHZpejNncnNCY1diZHVkSGRidlZUOUZ3UnFwNHRFeEwyVVFs?=
 =?utf-8?B?NXdVSFB3YVcyK0I0WTVTQWtsbGR3NnVuQWE3VklJREFWRjF1ejBWNFZpNDNv?=
 =?utf-8?B?ZGUreWtyeHJvVEEyZmtqUkgvZGR0U0dqaG42NldoZUR3T1NnRVQ3aFp4ZHgy?=
 =?utf-8?B?N2hlcXpLbXlhOUxWMDBRVnZ0RDdoZjU2QlVDM3ZMOGRNK0lZVHlpSHZSK09Q?=
 =?utf-8?B?WVd0aUpLeVlaOWFvSXAyd3FuY2tyZEJTc0dZS0pTa2pJcS82NEc1Z3pZQkZQ?=
 =?utf-8?B?Ui9EMEVYcE9wRjluczJlWEJ4Y0FHNlV5Q0swVm9BVHdKWG1qTkdCblNYTHRh?=
 =?utf-8?Q?3UCCohTyk0YWNRrc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E363DC5F3E511E43B642E6D17C407FC7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35411821-2c31-4410-0054-08da4de2bc08
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 08:49:03.8310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c/y1TIEwjc2MqiVUlq+DUJBvdlYVn1rFIWAVHserBYB9nvWPtzdcBsmAJjWrQ0lvf7X1vivNOl8FnU10pgZzD+XKZgi2dN+1iCFdotYjHJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6276
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEuMDYuMjAyMiAyMDo1NCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUaHUsIDkgSnVuIDIwMjIgMTE6MzI6
MDQgKzAzMDANCj4gQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+
IHdyb3RlOg0KPiANCj4+IFNpbXBsaWZ5IGEgYml0IHRoZSBjb2RlIGluIGF0OTFfYWRjX3JlYWRf
aW5mb19yYXcoKSBieSByZWR1Y2luZyB0aGUNCj4+IG51bWJlciBvZiBsaW5lcyBvZiBjb2RlLg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNy
b2NoaXAuY29tPg0KPiANCj4gSSdtIG5vdCBjb252aW5jZWQgdGhpcyBpcyB3b3J0aCB3aGlsZSwg
YnV0IHRoZXJlIGFyZSBzb21lIGxlc3Nlcg0KPiBzdGVwcyB2aXNpYmxlIGluIHRoaXMgcGF0Y2gg
dGhhdCBwcm9iYWJseSBhcmUuDQo+IA0KPiBHaXZlbiB5b3VyIGVhcmxpZXIgcmVvcmcgdG8gbW92
ZSBhdDAxX2FkY19hZGp1c3RfdmFsX29zcigpIHVuZGVyIHRoZSBsb2NrcywNCj4geW91IGNhbiBu
b3cgbW92ZSB0aGUgbG9ja3MgdG8gdGhlIGNhbGxlciwgdGh1cyBub3QgbmVlZGluZyB0byBoYW5k
bGUgdGhlbQ0KPiBzZXBhcmF0ZWx5IGluIGFsbCB0aGUgZXhpdCBwYXRocy4NCg0KT0ssIEknbGwg
Z2l2ZSBpdCBhIHRyeS4gV2l0aCB0aGlzLCB3b3VsZCB5b3UgcHJlZmVyIHRvIHN0aWxsIGtlZXAg
dGhpcyBwYXRjaD8NCg0KPiANCj4+IC0tLQ0KPj4gIGRyaXZlcnMvaWlvL2FkYy9hdDkxLXNhbWE1
ZDJfYWRjLmMgfCAzNSArKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICAxIGZpbGUg
Y2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMjUgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJfYWRjLmMgYi9kcml2ZXJzL2lpby9h
ZGMvYXQ5MS1zYW1hNWQyX2FkYy5jDQo+PiBpbmRleCBiNTJmMTAyMGZlYWYuLmZiYjk4ZTIxNmU3
MCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJfYWRjLmMNCj4+
ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJfYWRjLmMNCj4+IEBAIC0xNTc2LDYg
KzE1NzYsNyBAQCBzdGF0aWMgaW50IGF0OTFfYWRjX3JlYWRfaW5mb19yYXcoc3RydWN0IGlpb19k
ZXYgKmluZGlvX2RldiwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IGlpb19jaGFuX3NwZWMgY29uc3QgKmNoYW4sIGludCAqdmFsKQ0KPj4gIHsNCj4+ICAgICAgIHN0
cnVjdCBhdDkxX2FkY19zdGF0ZSAqc3QgPSBpaW9fcHJpdihpbmRpb19kZXYpOw0KPj4gKyAgICAg
aW50ICgqZm4pKHN0cnVjdCBhdDkxX2FkY19zdGF0ZSAqLCBpbnQsIHUxNiAqKSA9IE5VTEw7DQo+
PiAgICAgICB1MTYgdG1wX3ZhbDsNCj4+ICAgICAgIGludCByZXQ7DQo+Pg0KPj4gQEAgLTE1ODMs
MjkgKzE1ODQsMTggQEAgc3RhdGljIGludCBhdDkxX2FkY19yZWFkX2luZm9fcmF3KHN0cnVjdCBp
aW9fZGV2ICppbmRpb19kZXYsDQo+PiAgICAgICAgKiBLZWVwIGluIG1pbmQgdGhhdCB3ZSBjYW5u
b3QgdXNlIHNvZnR3YXJlIHRyaWdnZXIgb3IgdG91Y2hzY3JlZW4NCj4+ICAgICAgICAqIGlmIGV4
dGVybmFsIHRyaWdnZXIgaXMgZW5hYmxlZA0KPj4gICAgICAgICovDQo+PiAtICAgICBpZiAoY2hh
bi0+dHlwZSA9PSBJSU9fUE9TSVRJT05SRUxBVElWRSkgew0KPj4gLSAgICAgICAgICAgICByZXQg
PSBpaW9fZGV2aWNlX2NsYWltX2RpcmVjdF9tb2RlKGluZGlvX2Rldik7DQo+PiAtICAgICAgICAg
ICAgIGlmIChyZXQpDQo+PiAtICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gDQo+
IFlvdSBjYW4gZHJvcCB0aGlzIG91dCBvZiB0aGUgaWYgc3RhdGVtZW50cyBhcyBpdCBoYXBwZW5z
IGluIGFsbCBwYXRocy4NCj4gT3IgZXZlbiBiZXR0ZXIsIG1vdmUgaXQgdG8gdGhlIGNhbGxlci4u
DQo+IA0KPj4gLSAgICAgICAgICAgICBtdXRleF9sb2NrKCZzdC0+bG9jayk7DQo+PiAtDQo+PiAt
ICAgICAgICAgICAgIHJldCA9IGF0OTFfYWRjX3JlYWRfcG9zaXRpb24oc3QsIGNoYW4tPmNoYW5u
ZWwsDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnRtcF92
YWwpOw0KPiANCj4gaHVoPyByZXQgbm90IGNoZWNrZWQ/DQoNClllcCwgdGhpcyBzaG91bGQgaGF2
ZSBiZWVuIG1pc3NlZC4uLg0KDQo+IA0KPj4gLSAgICAgICAgICAgICAqdmFsID0gdG1wX3ZhbDsN
Cj4+IC0gICAgICAgICAgICAgcmV0ID0gYXQ5MV9hZGNfYWRqdXN0X3ZhbF9vc3Ioc3QsIHZhbCk7
DQo+IFN1cmUgdGhpcyBpcyBkdXBsaWNhdGVkLCBidXQgbWVoIGl0J3Mgb25seSBhIGZldyBsaW5l
cy4NCj4gDQo+IA0KPj4gLSAgICAgICAgICAgICBtdXRleF91bmxvY2soJnN0LT5sb2NrKTsNCj4+
IC0gICAgICAgICAgICAgaWlvX2RldmljZV9yZWxlYXNlX2RpcmVjdF9tb2RlKGluZGlvX2Rldik7
DQo+IA0KPiB0aGlzIGVhcmx5IHJlbGVhc2UgKGNvbXBhcmVkIHRvIHRoZSBsb25nIHBhdGgpIGlz
IHRoZSBvbmx5IGJpdCByZWFsbHkNCj4gZ2V0cyBkdXBsaWNhdGVkIGluIGFsbCBwYXRocy4uDQo+
IA0KPj4gKyAgICAgaWYgKGNoYW4tPnR5cGUgPT0gSUlPX1BPU0lUSU9OUkVMQVRJVkUpDQo+PiAr
ICAgICAgICAgICAgIGZuID0gYXQ5MV9hZGNfcmVhZF9wb3NpdGlvbjsNCj4+ICsgICAgIGlmIChj
aGFuLT50eXBlID09IElJT19QUkVTU1VSRSkNCj4+ICsgICAgICAgICAgICAgZm4gPSBhdDkxX2Fk
Y19yZWFkX3ByZXNzdXJlOw0KPj4NCj4+ICsgICAgIHJldCA9IGlpb19kZXZpY2VfY2xhaW1fZGly
ZWN0X21vZGUoaW5kaW9fZGV2KTsNCj4+ICsgICAgIGlmIChyZXQpDQo+PiAgICAgICAgICAgICAg
IHJldHVybiByZXQ7DQo+PiAtICAgICB9DQo+PiAtICAgICBpZiAoY2hhbi0+dHlwZSA9PSBJSU9f
UFJFU1NVUkUpIHsNCj4gdGhpcyBzaG91bGQgYWx3YXlzIGhhdmUgYmVlbiBhbiBlbHNlIGlmICgp
IGFzIHRoZSBjaGFuLT50eXBlIGNvdWxkbid0IGJlIGJvdGguDQo+IA0KPj4gLSAgICAgICAgICAg
ICByZXQgPSBpaW9fZGV2aWNlX2NsYWltX2RpcmVjdF9tb2RlKGluZGlvX2Rldik7DQo+PiAtICAg
ICAgICAgICAgIGlmIChyZXQpDQo+PiAtICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsN
Cj4+IC0gICAgICAgICAgICAgbXV0ZXhfbG9jaygmc3QtPmxvY2spOw0KPiBoZW5jZSB0aGlzIGxv
dCBjYW4gYmUgc2hhcmVkIHdpdGggdGhlIGFib3ZlLg0KDQpUbyBiZSBzdXJlIG9mIHdoYXQgSSd2
ZSB1bmRlcnN0b29kIGNvcnJlY3RseTogaW4gdGhlIGVuZCB5b3UgcHJlZmVyIHRvIGhhdmUNCmEg
cGF0Y2ggd2l0aCB0aGUgcG9pbnQgeW91IHN1Z2dlc3RlZCByYXRoZXIgdGhlbiB0aGUgaW5pdGlh
bCBwYXRjaD8NCg0KVGhhbmsgeW91LA0KQ2xhdWRpdSBCZXpuZWENCg0KPiANCj4+ICsgICAgIG11
dGV4X2xvY2soJnN0LT5sb2NrKTsNCj4+DQo+PiAtICAgICAgICAgICAgIHJldCA9IGF0OTFfYWRj
X3JlYWRfcHJlc3N1cmUoc3QsIGNoYW4tPmNoYW5uZWwsDQo+PiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgJnRtcF92YWwpOw0KPj4gKyAgICAgaWYgKGZuKSB7DQo+
PiArICAgICAgICAgICAgIHJldCA9IGZuKHN0LCBjaGFuLT5jaGFubmVsLCAmdG1wX3ZhbCk7DQo+
PiAgICAgICAgICAgICAgICp2YWwgPSB0bXBfdmFsOw0KPj4gICAgICAgICAgICAgICByZXQgPSBh
dDkxX2FkY19hZGp1c3RfdmFsX29zcihzdCwgdmFsKTsNCj4+ICAgICAgICAgICAgICAgbXV0ZXhf
dW5sb2NrKCZzdC0+bG9jayk7DQo+PiBAQCAtMTYxNiwxMSArMTYwNiw2IEBAIHN0YXRpYyBpbnQg
YXQ5MV9hZGNfcmVhZF9pbmZvX3JhdyhzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LA0KPj4NCj4+
ICAgICAgIC8qIGluIHRoaXMgY2FzZSB3ZSBoYXZlIGEgdm9sdGFnZSBjaGFubmVsICovDQo+Pg0K
Pj4gLSAgICAgcmV0ID0gaWlvX2RldmljZV9jbGFpbV9kaXJlY3RfbW9kZShpbmRpb19kZXYpOw0K
Pj4gLSAgICAgaWYgKHJldCkNCj4+IC0gICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4+IC0gICAg
IG11dGV4X2xvY2soJnN0LT5sb2NrKTsNCj4+IC0NCj4+ICAgICAgIHN0LT5jaGFuID0gY2hhbjsN
Cj4+DQo+PiAgICAgICBhdDkxX2FkY19jb3Ioc3QsIGNoYW4pOw0KPiANCg0K
