Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E4E580F1E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238547AbiGZIey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238460AbiGZIet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:34:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E1E31201;
        Tue, 26 Jul 2022 01:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658824489; x=1690360489;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0kVSv7eb18AUMY/zN5qGrPteL0lDJMR20khzTd2R8lg=;
  b=XGrlhpXNAz1/R1UhdpQ9BCTPtibVvBq8uvI+qziDbawh3ouvRTD0NDBx
   6Rzt2vaZTBPQlstXZXFQ4grDCyr+m5HzQ/9qTdj9q2+hC5Bj32nNvlYPb
   eaR+ygTEzi6Pruh60nf4fxThvCs2StBS8Xl9fkEnJdOcHRozAyMLTj0v/
   AS5ph5q4ozf8dmJn+nCtx9uVGqdKpyb/lS6R9C91ByCOKAqmEru9D8oxS
   9eV4GuAkdrWIHcEkyBaiZKTgjLjPcnpcXzRwMC9gVfbFalAo/flLRznKt
   JjyG8wph96kPG91+dqDeQ5jgX+1fzbmYsmz9J35F2JZDyz1a17E4UIy1N
   w==;
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="173642658"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jul 2022 01:34:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 26 Jul 2022 01:34:47 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 26 Jul 2022 01:34:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dB/jdXRbcfOiLR8kzJqH99H5yywF1twRJzbqAA8C+z6u5K2E+cxkQV9LcYPbX7/3gcA66OWAfXbiQu/Omk3SzsMiOZ+Ajl1yXItPVkd5qERn6VNHkC0hcPcFsddXFqtHznschf/jpGddQWDTv1TDrtQq5gyXBaENwgkMpx2d1YQxOZW0RPuuYaKBm7NbehL74GAtUQbpnu+BjCzSj8MQ1XkdGHqFWljHfn69qe+DTl/29r495vwrEZP4Z5A5koYqDhK/mnhMOcTqS8fhbrHKKc0sT2H/qYB5V4RRsFHVaiITytTlrRqL6wEUhr5sJcTxLEA37sxtiSv0irqKmSmngw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kVSv7eb18AUMY/zN5qGrPteL0lDJMR20khzTd2R8lg=;
 b=BEABzWAnjI3vf8fyWUfbHATq/wQj/QpMJ7vEkuPKWanVa5+0Ojj/GREzBXKmoAXEc52i+qyzME0FAAGCEQGJ45X4AWBnliNUEy9nhKWQNuLXhTOrySG7Sw7n1io3KeEs7AICp/56CJXw1fK/fAwNY79evTA2pg5BhFm0fkieq1ow0F8z2e7X6ph4K67rNcgswQ5LQozMKiT9zl5u8mixsJyGVqi+579nBe7z1guNIrxizClBv47F04hehbJEBG6gKFyc91XnAhf+zpfCC6V+KU58b/05dMlwH2JX0ayOy2SG8mit4VaW//58T3JLpKMi4xtiTf6WDmJzFvKOqXsf2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kVSv7eb18AUMY/zN5qGrPteL0lDJMR20khzTd2R8lg=;
 b=DXzQRyLnzsqS3iH5NaG1qryVGMOL2ly919EojVxiqW961GToTX+0/bmHr0JkXc0u7c+eB6AG6CsEkAhX3t5iH3TwZ8UzR78MEZvsRx98ySZbV+2MdpJovKW1vmhJ18O50qqfBHRurSH7Qt3DvgQXjU4HRd7zDD9Xes9jSop8YFU=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by PH0PR11MB4775.namprd11.prod.outlook.com (2603:10b6:510:34::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Tue, 26 Jul
 2022 08:34:42 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 08:34:42 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Horatiu.Vultur@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <UNGLinuxDriver@microchip.com>, <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: at91: add lan966 pcb8309 board
Thread-Topic: [PATCH v2 1/2] dt-bindings: arm: at91: add lan966 pcb8309 board
Thread-Index: AQHYoMqNW0JGVBf+L0WVaiJVhOHfYw==
Date:   Tue, 26 Jul 2022 08:34:42 +0000
Message-ID: <5ca59e67-1af8-76ee-770e-8580495b9781@microchip.com>
References: <20220722131836.2377720-1-horatiu.vultur@microchip.com>
 <20220722131836.2377720-2-horatiu.vultur@microchip.com>
In-Reply-To: <20220722131836.2377720-2-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbddd47f-2d6a-43e2-1cd9-08da6ee1afc0
x-ms-traffictypediagnostic: PH0PR11MB4775:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1W78JSyBkkvnyo3EDi9s4ulXwpZwLo/D/njgmjMJfHyPFhPfZF15mmBxXqQGoXWOPRD/jaJtfQ328uqFz3oq4QXS1j+YfKmXoL1x5qPQtZWB5ubZwvQb8iYGHbOtOfumEL7ZaPwvSq6WK4e41FgjOY4zrXMOzMMrFeN5SOdK1aj+PhmexaQ4APXLJco4R2HqdblXMYTABzmqfnwteksoaR+GrZNv1B93EppgzGKtRvpNEBqvJ/ttNkZM1RLOsguwKJt2t1AO2U4ohOgMfH3/RliVVKz6wpYoDxtqFqSXZyXIpsm9ecc41zRY77KdzAj7Uq5G2C2AdOFgBjPeLaX4+ahontb7x5ktWMaqbRh9TpWWcnZNhhl7T1vBMNEsPmz1willFaRYyLslJKmbJU/azyRxG1+Y1J7TU9AvoztDP069UZ8/jCVEY+I/JqQXrNBnGJfv8qj2p7PtquethXoZGLCvAM/82MH78oUXePQn4si+Dk6mLq68y6Bv/WkA6PO6BMrKou26MJYu6nH5zu2NmuVdUMT2CWzEUUQJe1ukhgNIPNQ6Yo6doJJ7LRVCFTmUJVLF3UD81Zc30an7WOOlsy/hRd0s5uGTCz1ljJxNXvTWLebfNag0cc5bWSmeuTS2xPU7Q/Sz0cPhUHyovw3OfF3VLehVIHYVTJTRgmQhEy2uSQSVilKteBOhroR1oLBmOtDoCMsni76QJsKze52RAqOUNnfxiaLq745ZhPeRdbPb4GSkWhyCV7NPtm8IhF6i/0hVSjPig6tfsVRtzAR15urzN2UnYa01LpSg+lHk3gt8hNvYLLiLz0GEF+70zkxCUAPmPKQG5jkODtGvu7fUqfssHg450Dpgc9UDTZcJ+TjxJa3vFJHnAB+NgTecAxCs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(376002)(346002)(396003)(366004)(41300700001)(186003)(53546011)(26005)(2906002)(6506007)(2616005)(6512007)(38100700002)(31696002)(86362001)(38070700005)(83380400001)(76116006)(122000001)(110136005)(54906003)(7416002)(71200400001)(4744005)(66946007)(316002)(4326008)(8936002)(31686004)(91956017)(66556008)(5660300002)(66476007)(66446008)(64756008)(36756003)(8676002)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WW1FNFpaRENDcjRPVGZkWjNmczMxUmxKWXBycGNDTW5jTDlIQ01vdllKUm1K?=
 =?utf-8?B?SURkSHpiMW9kT3dkNFEySDVhRFltdFV2NURGRUV0dS80ZW5nVGVBSGZTMUN4?=
 =?utf-8?B?b1lOVjlLNEtkVWFwT2Z5RFh0SFBtYjVYckRJbllXTXRSWnZpRU5mcE50RGtE?=
 =?utf-8?B?T3JsbE4zQ2dub2htRDExSnNTaFp2WW4zNzc1dG5PNnA2WmFLV3dXcVhTYjZJ?=
 =?utf-8?B?Z0NteUF3VFdEL0xZMkUycnB0QVBPZ1pIeGUrNDhMNWJTMFB5TnZWaUhGZ1pi?=
 =?utf-8?B?aGlVRklzU1pETzBlbk9VSkFhY3hqMWtta0lGcm9JKzFpQXpaZDRyaDQvQ00y?=
 =?utf-8?B?MWNKT3lYWERYbU5RVVdYU21iWHJjZ2hDSUJBTDRoRitDWXpkZVFRZFBGWFFo?=
 =?utf-8?B?bUlaQ3g5UzdvYVRndVRlMG4yMERiSlVGL2JzVzNISFRxZnlMNTFEQUQxNytS?=
 =?utf-8?B?N21WRjM4SFErOGllVWdTZWJVYkdvY3pOYTdtWmtXZ25YT29QSUhLRDdob3hz?=
 =?utf-8?B?YjhlL3BwYTdpaDBQTHhsV2dLSG5Bc1BxL2tudHlUaU1QSG5kTSthaVBQMTBp?=
 =?utf-8?B?bkVySzRKOUQ3SldmTGlNUkpjVE1NbzA2NDNGMnZrUHBiRzFnenJ6RU1xejF2?=
 =?utf-8?B?YTZ5czNNMmlHVENKT0dLWlRBQThWaWs3N1JrdWNPTnlPeFBIS2NtME1YUkhs?=
 =?utf-8?B?b21hdStDdkd4SGhPR3RoTVd6RlBYakhTYko5Sm9EdndCb3V3WjBycElyK1Q1?=
 =?utf-8?B?S0R2Qm5KVUVNYit6ZzV1Uk54aDlKSkJKL1Mrbk1ISEl5YUEzcnJESVI4K2d3?=
 =?utf-8?B?NW5CaDJaVHFzeGhsbksyQ0N3U1RQSTEyTUZCS0VqY3pBeE1jbXFzZWtUVFhY?=
 =?utf-8?B?K3RxYlpUa3RkbENHNFMvbEMwSjBTNmdzVnREN3IwK3NTSkVVN0JWNlR5bjBE?=
 =?utf-8?B?c2MxZVJyQkxnajAvMUFTY1dNVjRVdGxNUmYxUXppYmhmdzVENzZ0TXhYcXpH?=
 =?utf-8?B?UkJqZkx2cUF4QUZ1ekY2ZjdoK0Z1QmFSblFJaytJTXFTNEFCL2s2WVRyNzJC?=
 =?utf-8?B?YnlxT0dFdXNxNmNBU0RyWFlINnhGZU9ENHMveHlGWUlsa01MSkVtSWxrVHZH?=
 =?utf-8?B?Q2lQVDVBbGp6OUdIQzdKMnRsY1ZPVGltMGp2NVBJSE9NY3MwbDQ2N1ZocUI5?=
 =?utf-8?B?YkdvYVRNSFRvaWtBMGtwUGcwTjBEb3RLZmxackJPWENYWDBwcnlQM01uUm56?=
 =?utf-8?B?alpVSkZpaG9jWFRGRitwQ0t4LzNhY0tGcWFmRkhiWjNQU1hXWkNqZ090U0hk?=
 =?utf-8?B?cFRzU0QwOU5ZNStiSjlObkg2UERGOWVUVDlXTlFTVVUzemljejBHbFh4cDBJ?=
 =?utf-8?B?bUZXTUM5anhVSlpSQnlrWlZhVmVUVjA0VktxZEZYSDZ0VVpTeVZjNXNWd1lm?=
 =?utf-8?B?amVuZnljK1VwM3FHYTFiU20xajNjR1NjSnYzTWZ3U0lMemk5bWxMTE9tdzhk?=
 =?utf-8?B?MHNvVFp0dzdQMTZKdDJJN09idUZweUQ1dnN1c1MrSzBpU1Ixc21tQ2JSQS94?=
 =?utf-8?B?RDhDU2QxTHZDNW9HYlJxVGFsZTlWQUdDZ3FhMHNUYjNJVlJudEhPY0VSd0xj?=
 =?utf-8?B?TG82ekZObnlpTzFkZ0V0Tm96QTdncUVaQndDRjZKNTJHSmNGWUVTK0RERU1V?=
 =?utf-8?B?dTdLQzNwT3AzVmZUNUtjQU5WZlJnbG0vN0tBMGJqU2Vqd0YybVF0Y2lGQjJQ?=
 =?utf-8?B?QzBTRjZrV3JkQ1ZKT0cyaUZqOHUzNkRBSnFGd0ZLY1B5ekF4VzVJajNaWEFr?=
 =?utf-8?B?K3J5YTRDR0oyNnFBWlhpS3ZjVUgyeGNCS1g4a1ZWYW5GVCtKOEpuSUNXZ3R5?=
 =?utf-8?B?Q0w4WnVNMnhPV3F5eHgvMzdvUFZZOThkTnZpMCtlNHpaVlhZZzFXYUF0bkVm?=
 =?utf-8?B?VVJ3WHg0MzhxbkpLZzF4R3lJdklKQWZldDJGaVJVQ3FBSS9scGtGWmgyR1dK?=
 =?utf-8?B?eGdFSmsyOFlSVlVYd3lYSGRhV3ZzN1BNSXNtekdCUW0ydlFpMENKVjY2dXNV?=
 =?utf-8?B?UG1tcEdEK0djUW4zOXJhV3pDdDA5S25PY3JaV3FMRmowT0RKREM5Zmhsb0JX?=
 =?utf-8?B?MEhadEFPRWNTUjVzalEyUW95UFlad0RJN1AyKzg2SmRlZjZHdUFYSE9lZWV5?=
 =?utf-8?B?aWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C32E03C965D6B439CA5DB65EC6888CA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbddd47f-2d6a-43e2-1cd9-08da6ee1afc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 08:34:42.1490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +NpwIbk/LUMafA44VidIFWObDUL4/RF7nLtVPKQp1PH/tRjTWOq6jg92la/6JZWUpJPsChL2Du4S6YP6Pgy89Qq0qkfM0yzQcFmhELAnQDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4775
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIuMDcuMjAyMiAxNjoxOCwgSG9yYXRpdSBWdWx0dXIgd3JvdGU6DQo+IEFkZCBkb2N1bWVu
dGF0aW9uIGZvciBNaWNyb2NoaXAgTEFOOTY2MiBQQ0I4MzA5Lg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogSG9yYXRpdSBWdWx0dXIgPGhvcmF0aXUudnVsdHVyQG1pY3JvY2hpcC5jb20+DQoNCkFwcGxp
ZWQgdG8gYXQ5MS1kdCwgdGhhbmtzIQ0KDQo+IC0tLQ0KPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2FybS9hdG1lbC1hdDkxLnlhbWwgfCA2ICsrKystLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2F0bWVsLWF0OTEueWFtbCBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYXRtZWwtYXQ5MS55YW1sDQo+
IGluZGV4IDRlNDk1ZTAzMjY0Yi4uMmI3ODQ4YmI3NzY5IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2F0bWVsLWF0OTEueWFtbA0KPiArKysgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2F0bWVsLWF0OTEueWFtbA0KPiBA
QCAtMTYzLDkgKzE2MywxMSBAQCBwcm9wZXJ0aWVzOg0KPiAgICAgICAgICAgIC0gY29uc3Q6IG1p
Y3JvY2hpcCxzYW1hN2c1DQo+ICAgICAgICAgICAgLSBjb25zdDogbWljcm9jaGlwLHNhbWE3DQo+
ICANCj4gLSAgICAgIC0gZGVzY3JpcHRpb246IE1pY3JvY2hpcCBMQU45NjYyIFBDQjgyOTEgRXZh
bHVhdGlvbiBCb2FyZC4NCj4gKyAgICAgIC0gZGVzY3JpcHRpb246IE1pY3JvY2hpcCBMQU45NjYy
IEV2YWx1YXRpb24gQm9hcmRzLg0KPiAgICAgICAgICBpdGVtczoNCj4gLSAgICAgICAgICAtIGNv
bnN0OiBtaWNyb2NoaXAsbGFuOTY2Mi1wY2I4MjkxDQo+ICsgICAgICAgICAgLSBlbnVtOg0KPiAr
ICAgICAgICAgICAgICAtIG1pY3JvY2hpcCxsYW45NjYyLXBjYjgyOTENCj4gKyAgICAgICAgICAg
ICAgLSBtaWNyb2NoaXAsbGFuOTY2Mi1wY2I4MzA5DQo+ICAgICAgICAgICAgLSBjb25zdDogbWlj
cm9jaGlwLGxhbjk2NjINCj4gICAgICAgICAgICAtIGNvbnN0OiBtaWNyb2NoaXAsbGFuOTY2DQo+
ICANCg0K
