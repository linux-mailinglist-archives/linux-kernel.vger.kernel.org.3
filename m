Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78719599696
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347273AbiHSH77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347270AbiHSH74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:59:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164B4E39B3;
        Fri, 19 Aug 2022 00:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660895995; x=1692431995;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gA4FxQZwpIPfgave/zsIyiBINLfk+gEbPtr6T0x+nNs=;
  b=XjArBQfvfs8HkIfmtYCEpkX2AGkOx9sQ5J4jEVfC63GD7rg+6KUHKPAO
   B92xylbotc5FhhNmhaYk+b9FTIhvmzznHjf/cH02kt6OnDPcZMtRiRgE+
   3HJklHG8XQDmxDd9Ng5xMEmNktUiLrx2EOL7/i9TwS08Ocj88mzobHyw4
   twPIvoR1k+x+1Ml4jnnPQdJwB5ZJRg4c+UYER5Vi9oMY6vaPUfl+2lHp8
   zQ/SwDsYDnfZwWChdxLmBVraEFiZoKg5IpWOJFAII7aFoB/m5wH7EHFX9
   8MSoBYyBx9T9puFe9eNz3dTmlsMdxnWPfGz/ywDHjnYC8g0yqD8Qlzztv
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="169998479"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Aug 2022 00:59:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 19 Aug 2022 00:59:52 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 19 Aug 2022 00:59:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZeqShACJ9yG7kuNposkHSOp3Leq2MoQY+5MWJoi1JBga591spvl245LGOu74xc5OhllmbnopbBBtEPHgh4R3AbPlFACo72AlY2zAo+6iGviYj3YVMMjre4Qzyhux+zOvBK/0UAu7PiDT9GgptWTvCcH2htvTnu3YoQR5RPRf1jx3baqJ93cjY3rSpTes4PAtru2KePacdlPPd8oVraUNbuU7i8wfB8bOabv9JlXSFCKCtRFKjs0HxVnDrTO9e8FLSxmxDCkzfTDCtpToGdhbT7kjeRFAx3jazn8F3gw8Svfbnc/eZ9nyTz6croV1jCLD1QpsWyDtE22oAaIb6cD8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gA4FxQZwpIPfgave/zsIyiBINLfk+gEbPtr6T0x+nNs=;
 b=EstuFhz/oAl75Q9PKLhSTkiJ+6gQ1G1EesGh3Qsi7aIx2WQXWA2mn0RjhAnG6vtWGoRYaNJ6O0ejDnn1jJkfiSKQzG2vLawvppoc13fYneFBvynG/TGWNXx1fZRUyk3kXi3TjdvjIYU13nG/oa/YJsjpAUFTug80B6ZiMBxtNnAGk12C5OX/MQsD9AGXGD2ITw34/ex2TvU65/he1F9zXZsM7L9C9D8CjJVkywHfO1cBDFZs/VFLLlZ6Y3GQa2UhsMGiVSTffxNo/o340bCQnSpdNpH7P/6lOHaTKYjw71ujLSWpv6xxlvL/h8GWUIZfha/TSICnkfzJ2Qd3RENw2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gA4FxQZwpIPfgave/zsIyiBINLfk+gEbPtr6T0x+nNs=;
 b=GNhF83RIMvz2KfyR5RPmLAbTsnyX4ZKfCbZ4xseRQHHedtiPj+gz7yGDin6+BxbphtzVMkN30SS9jl+qRjKLxAJTlq37ing5FpgO0WcvBBfmn5JCyf+n/BdhGXIzoHzvUHEkw//FIoDu4ZdS7togy5i6gbs8+/QI2TqeZfZC9tI=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by PH8PR11MB7047.namprd11.prod.outlook.com (2603:10b6:510:215::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 19 Aug
 2022 07:59:46 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5546.018; Fri, 19 Aug 2022
 07:59:45 +0000
From:   <Conor.Dooley@microchip.com>
To:     <geert@linux-m68k.org>
CC:     <prabhakar.csengg@gmail.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <anup@brainfault.org>, <linux-renesas-soc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <biju.das.jz@bp.renesas.com>,
        <samuel@sholland.org>
Subject: Re: [PATCH v2 4/8] RISC-V: Kconfig.socs: Add Renesas RZ/Five SoC
 kconfig option
Thread-Topic: [PATCH v2 4/8] RISC-V: Kconfig.socs: Add Renesas RZ/Five SoC
 kconfig option
Thread-Index: AQHYsLoPyzdSi5rmak2RSuYw1tRBkK20yXuAgAAzIACAAAmoAIAA1NgAgAAGqIA=
Date:   Fri, 19 Aug 2022 07:59:45 +0000
Message-ID: <da391246-5b21-f486-c5cd-c4689711d7cb@microchip.com>
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220815151451.23293-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdW29Q40hypWZ05KRj5cc=DY8XjnDwOPVw3kJPNUrnL0fA@mail.gmail.com>
 <CA+V-a8sVpEx==R6QXF8qxhVSsv2mVnZ_R3N2wTt+JPcQWNqCWQ@mail.gmail.com>
 <eeadea8e-a6bc-0965-1246-82b0042838e4@microchip.com>
 <CAMuHMdUPzukO8Cqk86NbPU-ytidr--Qumg6KzVcUqE4GWmumaQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUPzukO8Cqk86NbPU-ytidr--Qumg6KzVcUqE4GWmumaQ@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e0c3456-f696-49c8-280e-08da81b8c839
x-ms-traffictypediagnostic: PH8PR11MB7047:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6GlXkIUw8Ux5TCdxyhWkS/PghCZI5v5D1GZ8tAkQ6ENDXriEU0jEsaA+8B7oiLcI2sRM0mzEFevyN2CeuNUpVcpljwXXJO+LDEE3ycfRIP4YCEJ5Yo5dyW+v9lvKnh6qnu8tNh+qLOTASW3XslOWN13GbJfuxFLOZY/BILRE+1WSWMMg9rLZb6tMkfqCyGlLcR1SlNMYjeZYCqo/7OTbTB3ire2zEe1cQV50rAI0eJE5yQS8MPbZqxErMTL/DeKELCWdnZQt6fmxXzK5k32rMbFATiqdd3Qa/ZMsCVTwKYYw4PTOtMBmdOBBgnIPlog5lHyc7k1nJ8M5LGtJUr4KWDkV0i5D7zqbvNPdahGKgvTRbJf6sloCXv0Yk7gxXeBPWIyM1kn9MohK6HTMnB0KsMjJ7eMGDIaCLzE900EOpRfR49/9bLj0K5adgvxZDkKMe2qagnf/yHx9qDFeeSSsfEy7kJRb6FBn4D4wpz0TYWxzrqKJCpIDhLWKRpChAXaDFjjtOL9Em4rJi3vcpFJrMG1GjTa5IfaDXVgT0uOdXksgufILfRHeqJb7ckd/8Rt2/BNJFTlYQ6EnrD9QoUedPI5jczbKg3biuepqqHcCLkHR9wgX5rtzGNtMf4Hb1oLiL2ryRZbX9FBdblPBa+kTJgWCQHH3y0RNUAZ+daT+Sz64HnoImSKYecQxy1B6foHuEz/FMMQkKK0CFV9p6UCbCJ/rad6vl8B6GT97DfYqzUbNTtLIgUwuUlFoCMpi0CtFoiRlO2VcD5COSq8lhK48yuHmlOXiqfKzKuBsYWNtng/KQwSJuL0Y3vesiQw//fs4ClRC6fCWQguXyzgz6ZzdzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(346002)(396003)(39860400002)(376002)(91956017)(86362001)(38100700002)(76116006)(66556008)(66446008)(64756008)(122000001)(31696002)(8936002)(66476007)(8676002)(4326008)(66946007)(316002)(7416002)(38070700005)(6486002)(478600001)(53546011)(6506007)(5660300002)(26005)(2616005)(6916009)(71200400001)(41300700001)(36756003)(186003)(2906002)(31686004)(54906003)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ti9RbmFjZWJObUZxYXhEYnNLQ1p2ZDdpODl2bXVaOVZnZ2FKaWl6cjRpM2tJ?=
 =?utf-8?B?WGdsZXNHVldiUFpJV1RxL3IxaUEyM2toenQvUXphVTkwQndWRld1b3U2ZVBn?=
 =?utf-8?B?ZzhhODBmVU02Z3BSeFNVUFBkb08yK0hUZS9VUFh3Y0Q5L0RnZzY4cEcvT2cz?=
 =?utf-8?B?WjBtRWk2WlJQaG5ybVFJVWIyNXJ6TkxOUVk0TEtsQnU4K3V2cWp4djNPSWFj?=
 =?utf-8?B?Z2FtdzU4MUVLNnpJTms0YWo2MjY1eTVPVjlHOFNXVTltVUE3MEFKNVArZ21l?=
 =?utf-8?B?RVRIUC9Vc05VeXVGV09HNDRwUEJtdzNIbUNyWjdEcEQ1elprUy9uaFR0S0hw?=
 =?utf-8?B?ZWRQS3Qyc3lyazdlMUl6alNFMXA0Tk1MYm1QNDlVR3Fud1JUSlNNSzlTT0R3?=
 =?utf-8?B?c05rcW5rUkk3QkcwTHJGU29VUVlTaG9oVkNPTVRUbE9zRFdMZHVXYkcxeHli?=
 =?utf-8?B?STRaY0VxS0o4OUtYcnB4aDNxWUZCVFpZMkhkVGVzK3hjZ3ErZXNKNnpiUWtG?=
 =?utf-8?B?eFFhUHJ4cHMzejlaZnJtbks1THBodk14VGw3ZW81LzcxMmdoQUF4cnY5M1l6?=
 =?utf-8?B?MUJSb3lxZ2FqczhvUzVRMG5qVlF2YXRpaU5FQmIxL1VZTFF1aDAyWmRIbkkr?=
 =?utf-8?B?MXFML21IYmRFTUs4b1ZSb1UyaUpGcXZlRXFwSVhqM0NZZGZhbFRNT1d3MUpl?=
 =?utf-8?B?QjUxbWxNMmN6ajI4Mnd6ZGIvTFA0b3Mya0g4VUdFajFicy95MGxxanVkYzBn?=
 =?utf-8?B?STQyUktjNG13RUl6SWhLUnpjY2RkUTVycHZJb29pQWo1cjlCazYxQ2c2bGth?=
 =?utf-8?B?eW9zZks0cFdTemthODhibG1KR1JITXFNVVBnRVBmQ3RCazVyMWdZOHhBWXNs?=
 =?utf-8?B?TTM5UDRwRm5yeTNtRHVMUWkrTjgydHBobTQ4U3dFcXdzMVp3RFRTZkpaVjJV?=
 =?utf-8?B?Ym5IbUhEVy92VEZjMldyLzdvUjQ2MWpDUnl0L2ZidFFkMC9qRnVjV0NGNGVt?=
 =?utf-8?B?b3lmVUZQZEhEc3hpR01XQU1URzN0d2hzWS9rVHljUjBCNTZzQ09IRTFSRXF0?=
 =?utf-8?B?bkdNZWdxZ0RTS2crRXV4bDNMck13Y01MYlkxVDl0TWdZQ1FQYzhaQ2lwMlMr?=
 =?utf-8?B?MFpzMUJ6QTFOaWp4NWJTR3gvQlU2Wm9QTDBKVUQ5YTVJVlMrM09DNVFwNTdL?=
 =?utf-8?B?ZDVLZTY2UXlndTRPY2pyZWpEUlJPamhZS3MyeWpZaGpTN0ExUldKbXNBT2Y5?=
 =?utf-8?B?VWl3TkNBSjYvVnU0NGNrTVIwZnpmdWxIRUYrR3pLYjZudVZkU1VNdjlnVUpM?=
 =?utf-8?B?SW1FcnQzK2NmUE95ajNOMHdaMlNFb2NESE10dkdWaDBmaWUvS1cvRTkrR0lx?=
 =?utf-8?B?T1lzSWRDYmFtaXM2THRidE9tQVNCUVhIdUlhaVhGeHBIWWt1L3RvRGZ3bCtF?=
 =?utf-8?B?TzNxaEFTQ2JiU3p3SllxbW10U1VCV3RjU25yeWFKTlNHZUNva1VVTjJnNmxH?=
 =?utf-8?B?Yk5CaVl1R3JaV0hEOHh1MFNTSjR1eW81VWFzYWpkNkQ4OXFJN2txQmRvaGN1?=
 =?utf-8?B?Q2ZPSXRJM08wTEt0N0E4T1BkVHc2RnlPZEFLQ01CUlVSWnFBYVpmU0t5Z2sy?=
 =?utf-8?B?dkhxdW11cGxGQ29rVjBBd0MzODlhTFBGUWR2MzZaSHpVNEdGT2ozQ1pHL213?=
 =?utf-8?B?dlhhVkdudjZiRVBHcTIxV0ROdUJibjViVmJ2WWQzTDBsNTZmbTcvMW0zd0JM?=
 =?utf-8?B?VDRzTCs4TXlPbUhzNDV1VzkxWW1Ld29UL2lNMnVHdzljR2MvRkxibXRtdmYz?=
 =?utf-8?B?WjZtU05hSm9yRVBmZi9YUWtybDkyOVM1eGRIM1RzNnZaTEwzcXV0cWpCOHZR?=
 =?utf-8?B?a3pjNmxnMGFhUEczSnA5Q2t6c0YreHd3V092NGcyWHdzOWNySEZDeHZDQ2k3?=
 =?utf-8?B?c0gwcjNCZDRuN3NXSlNLN2JqMkgvZnEyMkJtOTdyam1EcDllcitxN0pleDdu?=
 =?utf-8?B?SlB0TFh4bmFGYTJhNmtXdy9wOTdrNUV4ako0YTBEK2lFZGtLUHYwRXc5STFU?=
 =?utf-8?B?ZmhFNjVXZkNnVW9TR1g2RFZwdzlTS1BBSnpveHYyNmprS202ZVZWMVR0Rk0y?=
 =?utf-8?Q?GQ/ngN46M3ntXVr68sNyzx2zK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88929D05C8DA2C4CA5DE7AB7381A5092@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0c3456-f696-49c8-280e-08da81b8c839
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 07:59:45.9188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jxsi2jA9bOyHf2lJIzZDy38B2l8hMOjwKFoYwpnKxyodHH9NzX8W50ueSTkSx0fy/VhlcSdKS3uNJ91uC98fN2og+NKv0e/uPy4x22N06fs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7047
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkvMDgvMjAyMiAwODozNSwgR2VlcnQgVXl0dGVyaG9ldmVuIHdyb3RlOg0KPiBFWFRFUk5B
TCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpIENvbm9yLA0KPiANCj4gT24gVGh1
LCBBdWcgMTgsIDIwMjIgYXQgODo1NCBQTSA8Q29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20+IHdy
b3RlOg0KPj4gT24gMTgvMDgvMjAyMiAxOToxOSwgTGFkLCBQcmFiaGFrYXIgd3JvdGU6DQo+Pj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4gT24gVGh1LCBBdWcgMTgsIDIw
MjIgYXQgNDoxNiBQTSBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPiB3
cm90ZToNCj4+Pj4gT24gTW9uLCBBdWcgMTUsIDIwMjIgYXQgNToxNiBQTSBMYWQgUHJhYmhha2Fy
DQo+Pj4+IDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+IHdyb3RlOg0K
Pj4+Pj4gSW50cm9kdWNlIFNPQ19SRU5FU0FTX1JaRklWRSBjb25maWcgb3B0aW9uIHRvIGVuYWJs
ZSBSZW5lc2FzIFJaL0ZpdmUNCj4+Pj4+IChSOUEwN0cwNDMpIFNvQywgYWxvbmcgc2lkZSBhbHNv
IGFkZCBBUkNIX1JFTkVTQVMgY29uZmlnIG9wdGlvbiBhcyBtb3N0DQo+Pj4+PiBvZiB0aGUgUmVu
ZXNhcyBkcml2ZXJzIGRlcGVuZCBvbiB0aGlzIGNvbmZpZyBvcHRpb24uDQo+Pj4+Pg0KPj4+Pj4g
U2lnbmVkLW9mZi1ieTogTGFkIFByYWJoYWthciA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJw
LnJlbmVzYXMuY29tPg0KPj4+Pg0KPj4+PiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+Pj4+DQo+
Pj4+IFRoZSB0ZWNobmljYWwgcGFydCBMR1RNLCBzbw0KPj4+PiBSZXZpZXdlZC1ieTogR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCj4+Pj4NCj4+Pj4+IC0tLSBh
L2FyY2gvcmlzY3YvS2NvbmZpZy5zb2NzDQo+Pj4+PiArKysgYi9hcmNoL3Jpc2N2L0tjb25maWcu
c29jcw0KPj4+Pj4gQEAgLTgwLDQgKzgwLDE4IEBAIGNvbmZpZyBTT0NfQ0FOQUFOX0syMTBfRFRC
X1NPVVJDRQ0KPj4+Pj4NCj4+Pj4+ICAgZW5kaWYgIyBTT0NfQ0FOQUFODQo+Pj4+Pg0KPj4+Pj4g
K2NvbmZpZyBBUkNIX1JFTkVTQVMNCj4+Pj4NCj4+Pj4gV2UgZGVmaW5pdGVseSB3YW50IEFSQ0hf
UkVORVNBUywgYXMgaXQgc2VydmVzIGFzIGEgZ2F0ZWtlZXBlciBmb3INCj4+Pj4gS2NvbmZpZyBv
cHRpb25zIGZvciBJUCBjb3JlcyBmb3VuZCBvbiBSZW5lc2FzIEFSTSBhbmQgUklTQy1WIFNvQ3Mu
DQo+Pj4+DQo+Pj4gQWdyZWVkLCBvciBlbHNlIHdlIHdpbGwgZW5kIHVwIHRvdWNoaW5nIHRvbyBt
YW55IEtjb25maWcgZmlsZXMuDQo+Pj4NCj4+Pj4+ICsgICAgICAgYm9vbA0KPj4+Pj4gKyAgICAg
ICBzZWxlY3QgR1BJT0xJQg0KPj4+Pj4gKyAgICAgICBzZWxlY3QgUElOQ1RSTA0KPj4+Pj4gKyAg
ICAgICBzZWxlY3QgU09DX0JVUw0KPj4+Pj4gKw0KPj4+Pj4gK2NvbmZpZyBTT0NfUkVORVNBU19S
WkZJVkUNCj4+Pj4NCj4+Pj4gRG8gd2UgbmVlZCB0aGlzIHN5bWJvbD8gWW91IGNvdWxkIGFzIHdl
bGwgbWFrZSBBUkNIX1JFTkVTQVMgYWJvdmUNCj4+Pj4gdmlzaWJsZSwgYW5kIGRlZmVyIHRoZSBh
Y3R1YWwgU29DIHNlbGVjdGlvbiB0byBBUkNIX1I5QTA3RzA0MyBpbg0KPj4+PiBkcml2ZXJzL3Nv
Yy9yZW5lc2FzL0tjb25maWdbMV0uDQo+Pj4+DQo+Pj4gSSB0aGluayB3ZSBjb3VsZCBkcm9wIGl0
IGFuZCBqdXN0IGRlZmVyIHRoZSBhY3R1YWwgU29DIHNlbGVjdGlvbiB0bw0KPj4+IEFSQ0hfUjlB
MDdHMDQzIGFzIHlvdSBzYWlkLg0KPj4+DQo+Pj4+IEkgZG9uJ3Qga25vdyB3aGF0IGlzIHRoZSBw
b2xpY3kgb24gUklTQy1WLiBBUk02NCBoYXMgYSAic2luZ2xlLXN5bWJvbA0KPj4+PiBpbiBhcmNo
L2FybTY0L0tjb25maWcucGxhdGZvcm1zIi1wb2xpY3ksIHNvIHdlIGhhbmRsZSBTb0Mgc2VsZWN0
aW9uDQo+Pj4+IGluIGRyaXZlcnMvc29jL3JlbmVzYXMvS2NvbmZpZywgYW5kIHRoYXQgaXMgZmlu
ZSwgYXMgaXQgYXZvaWRzIG1lcmdlDQo+Pj4+IGNvbmZsaWN0cy4NCj4+Pj4NCj4+PiBBZ3JlZWQu
DQo+Pj4NCj4+PiBAQ29ub3IgLSBEb2VzIHRoZSBhYm92ZSBzb3VuZCBPSz8NCj4+DQo+PiBJdCdz
IG5vdCBteSBkZWNpc2lvbiB0byBiZSBob25lc3QgLSBQYWxtZXIncyB0aGUgYm9zcyA6KQ0KPj4N
Cj4+IEkgd291bGQgcmF0aGVyIGhhdmUgYSBzaW5nbGUgc3ltYm9sICYgYSBzaW5nbGUgYXBwcm9h
Y2ggc28gdGhhdCB3ZSBhcmUNCj4+IGFsbCBkb2luZyB0aGUgc2FtZSB0aGluZyBoZXJlLiBBcyBv
ZiBub3csIHdlIGhhdmUgYWxsIGJhc2ljYWxseSBkb25lDQo+PiBkaWZmZXJlbnQgdGhpbmdzIGZv
ciBlYWNoIFNPQyB0aGF0IHdhcyBhZGRlZCAtIHRoZXJlJ3MgU09DX1NJRklWRSAmDQo+PiBTT0Nf
TUlDUk9DSElQX1BPTEFSRklSRSB3aGljaCBhcmUgb2J2aW91c2x5IG5vdCBkb2luZyB0aGUgc2Ft
ZSB0aGluZw0KPj4gZm9yIHN0YXJ0ZXJzICYgdGhlbiBob3cgdGhlIHN5bWJvbCBpcyB1c2VkOiBz
ZWxlY3RzIHZzIGRlcGVuZHMgKyBkZWZhdWx0DQo+PiBhbGwgdmFyaWVzIGJldHdlZW4gdGhlIHN5
bWJvbHMuDQo+Pg0KPj4gSSB0cmllZCB0byBtYWtlIHNvbWUgY2hhbmdlcyB0byB0aGUgUG9sYXJG
aXJlIG9uZSBhIGZldyBtb250aHMgYWdvIHRvDQo+PiBhZGQgc29tZSBwZXJpcGhlcmFscyBidXQg
UGFsbWVyIHdhcyBub3QgdG9vIGtlZW4gb24gdGhlIGNoYW5nZXMuIFdlIGhhZA0KPj4gYSBjb252
ZXJzYXRpb24gb24gSVJDLCB0aGUgdXBzaG90IG9mIHdoaWNoIHdhcyBkZWNpZGluZyB0byB0YWxr
IGFib3V0IGl0DQo+PiBhdCBQbHVtYmVycyAod2hpY2ggaXMgaW4gMyB3ZWVrcykgYXMgbm9uZSBv
ZiB0aGVtIGZvbGxvdyBoaXMgb3JpZ2luYWwNCj4+IGludGVudDoNCj4+IDxxdW90ZT4NCj4+IHRo
ZSBvcmlnaW5hbCBpZGVhIGJlaGluZCBLY29uZmlnLnNvY3Mgd2FzIHRvIHByb3ZpZGUgYW4gZWFz
eSBwbGFjZSBmb3INCj4+IHVzZXJzIHRvIHNheSAiSSB3YW50IGFsbCB0aGUgc3VwcG9ydCBmb3Ig
U09DIFgiLCBhbmQgdGhlbiBqdXN0IGhhdmUgb25lDQo+PiBLY29uZmlnIHRvIHR1cm4gdGhhdCBv
bg0KPj4gPFxxdW90ZT4NCj4gDQo+IEZvciB3aGF0ZXZlciBkZWZpbml0aW9uIG9mICJhbGwiPyBE
b2VzIHRoaXMgaW5jbHVkZSBlLmcuIGFsbA0KPiBtdWx0aS1tZWRpYSBzdHVmZj8NCg0KWWVhaC4u
IGdldHMgdW5tYWludGFpbmFibGUgZmFzdCENCg0KPiANCj4gRm9yIFJlbmVzYXMgQVJNIFNvQ3Ms
IHdlIG1ha2Ugc3VyZSB0byBzZWxlY3QgdGhlIGNyaXRpY2FsIGNvcmUgcGFydHMsDQo+IGNmci4g
dGhlIHNlbGVjdHMgYWJvdmUsIGFuZCBpbiBkcml2ZXJzL3NvYy9yZW5lc2FzL0tjb25maWcuDQo+
IFRoZXNlIHNlbGVjdHMgZG8gbm90IGluY2x1ZGUgb3B0aW9uYWwgZHJpdmVycywgaW5jbHVkaW5n
IHRoZSBzZXJpYWwNCj4gcG9ydCAoY2ZyLiB5b3VyIGNvbmZ1c2lvbiBhYm91dCBhZGRpbmcgQ09O
RklHX1NFUklBTF9TSF9TQ0k9eQ0KPiB0byB0aGUgZGVmY29uZmlnKS4NCg0KdGJmLCB0aGUgcmVh
c29uIGl0IHdhcyBkb25lIHdhcyBmYWlybHkgb2J2aW91cywgYnV0IHNpbmNlIGl0IHdhc24ndA0K
bWVudGlvbmVkIGp1c3Qgd2FudGVkIHRvIGRvdWJsZSBjaGVjayBpdCB3YXNuJ3QgYW4gYWNjaWRl
bnQgOykNCg0KSSBsaWtlIHRoZSBhcHByb2FjaCB5b3Ugc3VnZ2VzdGVkIGFwcHJvYWNoIGEgbG90
IHRiaCwgbWFrZXMgYSBsb3QNCm9mIHNlbnNlICYgZG9lc24ndCBpbnZvbHZlIGhhdmluZyB0byBt
ZXJnZSB0aGUgc3ltYm9sIGZvciBhIGNvcmUNCmRyaXZlciB0aHJvdWdoIGFyY2gvcmlzY3YgaWYg
c29tZXRoaW5nIGNoYW5nZXMuDQoNCj4gQWxsIHRoZSByZXN0IGlzIGhhbmRsZWQgYnkgdGhlIGRl
ZmNvbmZpZ3MgKHNobW9iaWxlX2RlZmNvbmZpZyBvbg0KPiBhcm0zMiwgc2luZ2xlIGRlZmNvbmZp
ZyBvbiBhcm02NCwgYW5kIG91dC1vZi10cmVlIHJlbmVzYXNfZGVmY29uZmlnDQo+IGluIG15IHJl
bmVzYXMtZGV2ZWwgdHJlZSkuDQo+IA0KPj4gSW4gdGhlb3J5LCB0aGF0J3MgbG92ZWx5IGJ1dCBu
b3QgcmVhbGx5IG1haW50YWluYWJsZSAmIG5vbmUgb2YgdXMgd2VyZQ0KPj4gZG9pbmcgaXQgYW55
d2F5LiBIb3BlZnVsbHkgd2UgY2FuIGNvbWUgdXAgd2l0aCBhIHBsYW4gYXQgUGx1bWJlcnMgLSBz
bw0KPj4gZmVlbCBmcmVlIHRvIGNoaW1lIGluIChvciBtYXliZSBpdCBnZXRzIHNvcnRlZCBvdXQg
aGVyZSBhbmQgSSBkb24ndA0KPj4gaGF2ZSB0byBkbyBhbnkgcHVibGljIHNwZWFraW5nIPCfmI0p
Lg0KPiANCj4gQWgsIHRoZXJlIGlzIG15IGdvb2QgcmVhc29uIGZvciByZWdpc3RlcmluZyBmb3Ig
TFBDIDstKQ0KPiANCj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+IA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgR2VlcnQNCj4gDQo+IC0tDQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdz
IGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtbTY4ay5vcmcNCj4gDQo+
IEluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwg
bXlzZWxmIGEgaGFja2VyLiBCdXQNCj4gd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJ
IGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0Lg0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0KDQo=
