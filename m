Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB86584B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 07:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbiG2Fex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 01:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbiG2Fev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 01:34:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17527371A6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 22:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659072888; x=1690608888;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ik372YVI7CXRHrc7abU/EdHOrzrCVQCzUdC9Bte9wF4=;
  b=Ivp+n7fo5RGhiiFQi+BQ0ZWmYKEMPtgdfKWNZrKnL1eR3SJp/DwuzHCC
   OUt6/Oz9rwODmnE5/M3s65URclHGiiyg2RvAUkDYk/gFjxZHLs/8FZpXQ
   JnBq3ugxTmXOAnRERZewCa2S9IYkfiAJloos6toVNoDsneJpuGeJCTADK
   xgOquEmgVfbAPOwMi4NQa788asmwKm5hf282PIqOrX9Z5FD9MopAqnXf1
   V1zQDUm125zuXd7IdBpmKJY3KZ6BXRMwAvZPYNpcGoaikZCk1BpvZAij7
   vzGYIk+Q3xSUobAgqArA+30pAjfBbrbEMaHtV5MMIwSicYx4DAFFodvAR
   w==;
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="174265975"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2022 22:34:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 28 Jul 2022 22:34:46 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 28 Jul 2022 22:34:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKh1dUdfw00K1Jjoxf9bSdfK2BaIDHasbVVvlGsxBTfFcRwFAS6XZm/LXd9Y9Cc2+10s35Nuwvb/9JDzLuc1MW/l1Wcs9F6PBwo8enbMxKreqL+T6SPDABGRPj2/rwJS4B4e0yfr4I4ga31GHJ/kYcNuxCX/bEnxV5Kfg0uuPGB/nPv9cAc0Wt7BVVLiRvwALKtgTqk3giZT8yLhy7c9wsoWqXEnL5KtngtmVzzBakWODRqPjLaaLgrg7fgvMbd8VdaI9S4VVB2uhkPWjd1iyd9GWqojookbs6rF9mySQxD6q0zT0u5eHEybTZH3sHU6wZPt70Yz+QcVw1Ve6VE0Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ik372YVI7CXRHrc7abU/EdHOrzrCVQCzUdC9Bte9wF4=;
 b=XlZHngGagYIXBjbQeAxM2m+yGPuXncJRXPCSJD7aU8kiesFw9Lk2hyDxUL8NZiGgXK5UT9GubE5l059JlB9U+2HCKrnZIeUp5tjC45g/glZUw/UzyhgkJDbH8qH+SLg2eRY59i5LiGtwi/+xQyhvG95N1qODNSgGsyR6dZlxfS82KJCj1ZtOhcQ+YsdvLhgbzHA1eBlGNCM9nqwemMEguVpqoqvw6JuoZgEN2ba5GX7qcGADGLVXk7XAnlKyFlesJe/NydAjUptO8+Q+k2TZhiIuBvmefs65NsDRgOxqv1F4CU9zZ3DGexnBdRvc21WOO8b9+M0Ebk7K5E+3gAYXnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ik372YVI7CXRHrc7abU/EdHOrzrCVQCzUdC9Bte9wF4=;
 b=qqIcKjmNiyFRaoFCa2ksQfqyByGvVvX+lqgxc7yabyDnp85TBAWu68e826yNxZj9rezLMTLc3wLNhMPe7LsdXQ6yg7jglSfww8GrgHbx3SybciH5vNC9/U56k7VU9N0nIgR/0g56nKzp/MpKnDuoBX+UEILozqRilLSVtKFsJNI=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 BYAPR11MB3606.namprd11.prod.outlook.com (2603:10b6:a03:b5::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.20; Fri, 29 Jul 2022 05:34:42 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::7549:c58c:5e93:7c35]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::7549:c58c:5e93:7c35%5]) with mapi id 15.20.5458.023; Fri, 29 Jul 2022
 05:34:41 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <tkuw584924@gmail.com>, <michael@walle.cc>, <p.yadav@ti.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <Takahiro.Kuwano@infineon.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH 0/6] mtd: spi-nor: generic flash driver
Thread-Topic: [PATCH 0/6] mtd: spi-nor: generic flash driver
Thread-Index: AQHYoMaNVGoFuICE5kiLshJW1ov3CQ==
Date:   Fri, 29 Jul 2022 05:34:41 +0000
Message-ID: <79a3db5f-20e6-33fe-b6f3-7542c604f070@microchip.com>
References: <20220513133520.3945820-1-michael@walle.cc>
 <b3d5ecf7-39e4-d6f1-93a8-9efc8e352c9d@microchip.com>
 <f3f552cb-fa11-beaa-656a-9c9dd32291cd@gmail.com>
In-Reply-To: <f3f552cb-fa11-beaa-656a-9c9dd32291cd@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f30f1127-3c82-42a4-fc2c-08da71240988
x-ms-traffictypediagnostic: BYAPR11MB3606:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M3uZ8XaxcGNoO0NpFdzBvRGyEF+JUa5DLxsyqz9apO+iUB025QFFlPXG8OCKVKt6hYB19k2dpxC5c+tIcnI4U7Vhw5wbwLjzpX/P9HlRI2+Ounlj5MV/yAV2ryrlMmJ51bwUuQLN6LbXSIwDhygJC+dcNN4lqZEvE6xuG5shz9LeB6o/+Cc7ySCier3C4OPtrDC9lK+CLDHaHVjuK9fVp6j2bNcHOFXKYJUxQ66qQvjOiBqLapxjNQwho5KLz+JoOnRMwPv22/mK/Ro6LJtB+vj2qudW8CPeaW/jCCMXZ8j08FA7y+6/96puTcxfXlZrBwhCtZE2sKAd9YrNARqzvDh/al48OTDEapkgAMPnJFA+W6UM2rDhG3GpfXzYPnz719IBBGfBt5CoTtF3Ef8VsWa87QjgcxmPYBMy60spQkqoNdrmfiHa51XdGslTd6bJouDd3q1xN35BKfqM88r9kh3lKApu0chkmkc1kAyhsamHX22QZLHiSQPGYTVootD+DOwZZGR2fTiQtmSJw8OzM6EDk9HpfqBKPOYgAcZfTdiqbeStc0HtvkRrpt3hzzcqatmJsG+WTWsHi3AHoLFW1xBp83ArMYCA+uxJPFlU6K1vajechXQmp94tvcDfY9YV3y6ByzlxzWWjevSiCH8MfSvc15anxMt/hZqC5KIoSFWahN/d1XtwA5xdRMFKMreLFTG8pHKUTcinAFNMbZ0ByPHoaRoDJUARPDL9JguYpBlipokSpap8tppRZDwAyYYV+Zx7eRNnpWPp3Yk8QDWCJ0tQAGHEjlNajQvb2g5+ES5FNqxxWfxgaRZai1FfuX7kdE1bXW1vi5s3xi7hzJ4SmlXZwZs4DMzvTD7QCgHpBghJLXsIRFDvy3P0EJYehW1TIkHmK2F6ZHoioLEtRljMTl8sDULDS7RgAyd4H6+rbmk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(39860400002)(366004)(346002)(136003)(6486002)(478600001)(41300700001)(6512007)(71200400001)(53546011)(26005)(966005)(186003)(2616005)(38100700002)(122000001)(6506007)(4326008)(5660300002)(8936002)(38070700005)(31686004)(36756003)(66476007)(2906002)(66556008)(54906003)(316002)(66446008)(66946007)(31696002)(110136005)(86362001)(91956017)(4744005)(76116006)(64756008)(8676002)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVpRcFVYclc1ZFdVVzQ5ZjhkZXY3QUkxMkJUNXAxNEE2ZllNajB5dTh1ZDVJ?=
 =?utf-8?B?STY1bm50ekZmbEcvYkRZZUtWeCs4WDZyM21FZnVGeFBTRnU0U0QvelNJdmxN?=
 =?utf-8?B?bml3cUVCelo3ZnJtQ3U4SWpNVmxOa2k2QUJYQmpEY2pEcVluamZhZC9IRVpK?=
 =?utf-8?B?bDE1WnFrTE1DZFRDNjIrWlFBcEVZQlZMTFlYVHpBVXZ2WUdEOEEvTnB3NXdF?=
 =?utf-8?B?dUs3cnFXK0ZObDZNTE9qYlhsUk9hZ1FFaHF0RlZSUVEyUi9NSDhDaTBUN1A2?=
 =?utf-8?B?SmNMVTdMK3dvVFpNRURST0hQL1NGLzU1RzF2ODlMWjI0L1ZIZHZaczJrekR4?=
 =?utf-8?B?Q3pnL2pvY1JuK0hmU3hCSnBjbUdpSkhsand4Sk5UNTkzdDhPR1dVSFpxbWYw?=
 =?utf-8?B?UDhjYzBvM1Q0UUlaeVJGQmhEeWZHcjFmVGRQSi9PUWNHMEhsb0JkKzRKamFP?=
 =?utf-8?B?MGlkK09yVTd0SjlJVUhOUktGN1B6aXRhK0dNMkdUSGF6dC8vMjBtQkVVcmc1?=
 =?utf-8?B?M1Z2WnFPWUZuMjVGNWV4WE45REFCUC9SZnZpTFRnVldHRzV3blNrYVlTbitV?=
 =?utf-8?B?bVo0bG5hdzgxSXVQYnJjTVdLeFZFd2V0YktLQVo0RDRxaTNuYi9lTk5rWTVU?=
 =?utf-8?B?Sm00dUZ5MytBYVozWG9QSnNzZXBOVWw2MWRYNHUvNnB2WDZQQmg0VFM5Tm5W?=
 =?utf-8?B?VmtCTFNoeG9vams5bHU1cXNFbFBoY1cvNE5DU0JzbTF1OC80WVhtb1dZTEti?=
 =?utf-8?B?ZytLSG1LZzlxcVl5N2xlaGhmYVJJZTh1dC9WaHVzZVFyMmVscHB1eDBJZEcy?=
 =?utf-8?B?ZEhRVldXUUdaUzQ4aWVvWVpYM2F2U0pDMWNIaTRaN1VOVm50TmFiOHJ5MTNj?=
 =?utf-8?B?dG9VZi9BOUlETzBIVW9DVWM2VUt6L1MxQWNmNUdVNU1Zb2I0bHBsdTdMZDFV?=
 =?utf-8?B?UVNrSUxWRWZGRkVCOGo1cXhvcTlZblFONHhhU2N1WWhJdWpOS3k3M1Ixazlz?=
 =?utf-8?B?azZoNXZoTjEwdEw2ZytUQmc2cVRYRlVFYkVzVmZZY0pmRGFtbUJBQXRKUTY3?=
 =?utf-8?B?VVRyMEVGZjhUSjh3UTVPQzVMVlYrZnFPLzVXYjVRUm1hd2grdklXV2xDUEZE?=
 =?utf-8?B?OUNnM202Zlo4dGhZUXhTVzZ2bERVeTZ3YytSM09IeWo5ZnRlT1RLUjBzS0pp?=
 =?utf-8?B?QlY4NzFPUW1USEN5aHROejlJQWh1Vzh0Um1qcjRwREJHc1JaUmNQaTNhSlgz?=
 =?utf-8?B?Rk1HeSsxSVJESnJLV2I2RE11eHhIM1RyLzZGUWREalJzTFV0Q3pDSWRXUFhM?=
 =?utf-8?B?QStMNEU5ZXNQbGFxOFhPU1Y2OW9QU1YwTWNYcGMyRTlnMUlXSjl2ZkNoSzBy?=
 =?utf-8?B?eUE2UXI2RUY1NWpobWJTZ1FlaW9yKzhPbURuQnZIUlVEM1RYZzdXcG93V1cx?=
 =?utf-8?B?R3RHWms0QXI1bW1Ba0c4bXNlUWRUdytZUVl2eVgrT0ZxSzJuNi9vdFIyM1N3?=
 =?utf-8?B?bitFZlZoTERqbTBLaFpTZVhwTDQybGFFcFovY05yeFg2SzBtNUFpUUNvN3pz?=
 =?utf-8?B?Z2poRDNzS1N3TmpXQ0NjQk5rR2pTQXhMZVZHWHh2OEoxRGN3eS9ST0lDN3li?=
 =?utf-8?B?MmxFdWxGMGtVSmVBa2dCNElrcUdrQzRNQlBEVUF0cUVNZzQxTlBCc0VFOXRm?=
 =?utf-8?B?TWZLekxsdFFwUGIyNFhScUdXdmtNemtZVmVnOTJtckVUNUg1M25hV2FPdEZQ?=
 =?utf-8?B?c1BXNUdaWXdCTHNSZ1NEeGh4Y0o5WUUrYXRHdlRhRktNbXZHM29icjdFZm5P?=
 =?utf-8?B?NGFvdUtUVDdUR2NQUDBvcEFjQ1hpQ2ZHaVBxOWNQeHRVUEhUMXpia0VTN055?=
 =?utf-8?B?c3pXZEZNUkhhbmVUdmN3TnJZdDhBblUrV3owcXVlS3JEWXBpVWdLaFlneDQw?=
 =?utf-8?B?TUhrS2tvV09MVnhnOU9nakNMOC9EeWNMQm5NYk5ISzNGT3pJdjF4b1RvaWVm?=
 =?utf-8?B?a2pydGZDZFluZFRFNXB6K0hCemUyZ0k1UldCUWdmaTR0NGFIR1dwejc0OTQ1?=
 =?utf-8?B?WmJUdjZ1SEVpQktWZEVPYmt4YmZaWStjVnp4T2hCSVBzcTFqN3lBSllhaHFy?=
 =?utf-8?Q?PtMI/5L/XH6qwEYiJBnR5Jn3H?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D390CD876032C34083E3947798102232@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30f1127-3c82-42a4-fc2c-08da71240988
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2022 05:34:41.8610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u6fIb/RsqpWwQLnvdTfa1KC7PDgXCiAzLalNIDDmruCcx+oufQV3KvFw+yGsaQhmMg5CwT9dL6Im20AKWbsJG0h3w9spyYf1OJp6bP3khNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3606
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8yOS8yMiAwNDo1MiwgVGFrYWhpcm8gS3V3YW5vIHdyb3RlOg0KPiBIaSBUdWRvciBhbmQg
TWljaGFlbCwNCg0KSGkhDQoNCj4gDQo+IE9uIDcvMjYvMjAyMiA1OjA2IFBNLCBUdWRvci5BbWJh
cnVzQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBIaSwgVGFrYWhpcm8sDQo+Pg0KPj4gV291bGQg
eW91IHBsZWFzZSByZXZpZXcgdGhpcyBwYXRjaCBzZXQ/DQo+Pg0KPiBJIHRlc3RlZCBhIEZsYXNo
IGRldmljZSB0aGF0IGlzIG5vdCB5ZXQgaW4gdGhlIGRhdGFiYXNlLg0KPiBodHRwczovL3d3dy5p
bmZpbmVvbi5jb20vZGdkbC9JbmZpbmVvbi1TMjVGUzI1NlRfMjU2TWJfU0VNUEVSX05hbm9fRmxh
c2hfUXVhZF9TUElfMS44Vi1EYXRhU2hlZXQtdjAxXzAwLUVOLnBkZj9maWxlSWQ9OGFjNzhjOGM4
MDAyN2VjZDAxODA3NDBjNWE0NjcwN2EmZGE9dA0KPiANCj4gQW5kIGl0IHdvcmtzIGZpbmUuDQoN
CkNvb2wsIHRoYW5rcyBmb3IgdGhlIGludm9sdmVtZW50IQ0KDQpNaWNoYWVsLCBJJ2xsIGNvbnNp
ZGVyIHRvIGluY2x1ZGUgdGhpcyBvbmNlIHRoZSBtZXJnZSB3aW5kb3cgaXMgb3Blbi4NCkknbGwg
c3RvcCBxdWV1aW5nIHBhdGNoZXMgZm9yIG5vdyBhcyB3ZSdyZSBsYXRlIGluIHRoZSByZWxlYXNl
IGN5Y2xlLg0KDQotLSANCkNoZWVycywNCnRhDQo=
