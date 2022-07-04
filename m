Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA24565732
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiGDNbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbiGDNbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:31:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC415FC6;
        Mon,  4 Jul 2022 06:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656941104; x=1688477104;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=x6tTVFntyvHQ33dPKp33656urGGxZcg4VrN0VGOoEV4=;
  b=FoOIB7rImyzj/WUTBhtLHB94osZTNcXXR4A0coHdxTZEa4grOqBp+zq5
   sSIKTaaj/VqrnjkHV1ix53PdA/0MZcnaOOunhIAX2t1pVNGXlWnEGlUvZ
   Y6ksACJ3Kief5o8gYkZjFnMRLnSvAuoOhHgMZubNOWoz4n94KpRMkcQhJ
   LMSfOG+XxndM103g3CJnuVgR7u6XLVU3ZYkOMhMq/zfXi0yLpSDaGxnOM
   hMTUXqY1HluGdw1jz2nkndJLm4rvi2VYzauZ7cmcK38UXSeifQ87XLoJe
   GX64AJDQdSoraom0bsRjQ+F8y92evh3Olsr15dEqyoSoC1/3IJbhkWjmv
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="163218089"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Jul 2022 06:25:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 4 Jul 2022 06:25:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 4 Jul 2022 06:25:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQoCCeAiVslMHtJkZJAHgO+9063cAVrNnwX1cAdCUr1CQSPWaNdBh1xRV9VW5P8hEIsHHU7w8EOk/tXDTNKy0GUrbV5TKRxRZBXrx0tNC9RYl/qGzeg1PRS7/P8JL5k76CHPwRgEl9VjYqDAdr+FUIiSY39B8k6zOUn9hmFZ4DUBgRkkf2xbowb9GqhIcyUn+UZO0bkaH395P7OkMOdxtpkAp+nMOmZLdGRnOcNbNiAKm7yjtDfgevfP2LaFkhUbX6iGvYfJXceUHLpO/sswbXxCBiZ3eFkLGwL9PTidLj/SSwZw2yThtr+6s8zLFVV+H5YFEK6aHeX7xe2PLm6/RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6tTVFntyvHQ33dPKp33656urGGxZcg4VrN0VGOoEV4=;
 b=TdvBgASlmJmes0CT2p6LZccyrXFC/EOFMisiA9fbw0ipUyYgCVYVF7TecwIcm9QFpcxQn4NT08PcW2TpkX8rWPmMtWu8gS4p4nzn2KjQJsHsgcT/jNIMv08jjaxbbvrsERd09l7WGYSz9L6MfOt8VJcSaKbXPcd4BqYy4CNaSCrDBovAo6C/gW7+2Gxerg9h9Cb/N9TSL1dGvj5EviPlPzMUZ8CNrM5FizloLhvl4rugNR4OqyjKoRjwHwDGZzm+vuWUBDAaYdTALGZIHMfmmW3UsIMQjxVQ0IzTdM41CbiWoILnXeQGvAejTBsqR8pDU/a+ES/onyOJdLBDUULBRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6tTVFntyvHQ33dPKp33656urGGxZcg4VrN0VGOoEV4=;
 b=RzQbIlO2/IMKSGDtSz+/bNWBCXTAle7LCIcetlf+3tpjXFurfxwVIang7qFqNRuXfYUBn2V6ADMSha8yAAcK5jY72iTK5mm4/ew091nMahWHCfRmFx3Q7Eh9ajwGJfXZZ8a1H8AxslY56NZRm3oztc59OyU7qG1WkULB90u7HXo=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 DM6PR11MB3129.namprd11.prod.outlook.com (2603:10b6:5:65::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.18; Mon, 4 Jul 2022 13:24:54 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4%5]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 13:24:54 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Sergiu.Moga@microchip.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v2] spi: atmel: convert spi_atmel to json-schema
Thread-Topic: [PATCH v2] spi: atmel: convert spi_atmel to json-schema
Thread-Index: AQHYj6lyQJ8vjFq+GEKvMgbTaAY2pw==
Date:   Mon, 4 Jul 2022 13:24:54 +0000
Message-ID: <7fc3b50b-c9fc-b1b5-ba84-752b2e3da7d7@microchip.com>
References: <20220704083143.56150-1-sergiu.moga@microchip.com>
In-Reply-To: <20220704083143.56150-1-sergiu.moga@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ab82ff5-9a56-4a10-160b-08da5dc09557
x-ms-traffictypediagnostic: DM6PR11MB3129:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JBOz8GYYDNAvquYaiZDOAINH/N6SBR8c08t8ebwlZplAKJv++pcwabRP49dZ2Bl9jRf2pW7eW61JkxIWpLdP3EVDDUJuVBeFxmJcRS7NPW38s6+1Vp3iEcQQuKYAltt/2FNLhc59WvkLlMc+XvVX/CVIo6g1sBxAe5nt6BhgcuCDVCvn8fuNABM3dQQeAZKB53yQo3Bu+t12Sjmv7ksMIHn+XQRbaF7Q+rkqz7EO/lqYoJiWPeYwmqV5kn7jr8fHV6UV+l5Ss9KPea8YHjxeIIvBZuLn3pJEdCRX/fB6qTK0w19X0mP/yB5JXyfHNfT/cfhuzEpHs7IwbsT9osEGnTAnyC4jjdFl680q9aee35HeWJ9MyQ7faSEwL3zDPzuOZ8NjlPcZVlsc8GxXs7E6GnnsfL+A5SXNx+VpPSABFglPcOWSAnKRkBg3AZ0kec46sBQdV7UVNCVMXXdMCffj/J3raihFbxN0t/hS72paD94E6K+NFC26b8AdK94Waiu3sEbVeiA0P1PPY7TerFH50HgiH+hz3Sonexz9VYVuUKFlstWPkJoLa9cTuzG8tExELSlv2EGpayR6lzn6YaTyDOMNYIUuidNCGIhaXNnLBeJhZlAa2u+Y2Qb66KGIqLquIMXe6XiLmFTgrKpSsV2kpFBKqWFvEj12ad9MAm7Dx5iai6Lya5O0dAjMpQFnTuf+bU6xZRpmAYULyNAxcP3GmNsf5Azw2emQzQ2vbA8GIXLxE3lY2undfM5u/Vvcejcy7j/7+J7eiZV7zPVJyaoAPJgBjTT2RUQEBwMJ7QoqC08+UXyxRz6E9X0LERjLPGpp7L3BOdItqTHGr6+uI4ZcdghJ2iV3y8U2ZcTcadUJJ9cSwV3dXGDhDmLF/y67pbUI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(376002)(346002)(39860400002)(66446008)(4326008)(31686004)(36756003)(186003)(66556008)(91956017)(66946007)(110136005)(6636002)(64756008)(8676002)(54906003)(71200400001)(316002)(66476007)(76116006)(38100700002)(5660300002)(478600001)(122000001)(53546011)(6506007)(6512007)(8936002)(107886003)(2616005)(86362001)(6486002)(38070700005)(41300700001)(4744005)(26005)(2906002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajZhdUk3cGt5YUlMaGFUWDZXOEc5azZtaU15YU5ZZldoa0RRWm5xcElRVUEw?=
 =?utf-8?B?NUdLSmRzUVNpSHhHZW9IMzNvaE9HRERHK1NWT3BwQTExK1JoWWUvTUQ2M3R5?=
 =?utf-8?B?OGlwbjh3N25JL1MzbTk4T3hZL3hNVENoUFRtZ0x6TjlhQVRHck9rUDA3KzNO?=
 =?utf-8?B?cW5OVHUyVE5SWXlXZkJneWNZOFIwY2IxL29zaEo1RUR2dXd5RXQ5dEJJcFha?=
 =?utf-8?B?ekJ6TG13aXpqTm8vbkE0R3VNRm1nVDBxcUs1MVAzSmRWZjFDa1lCcWpPMTFJ?=
 =?utf-8?B?K2NUZEhwMzZJZElMbktORENiL0t6dThMVFgwVnljVHp0dGNESjc2bElGeTcx?=
 =?utf-8?B?SEJ4b2ZyY0J4b3hsUTY0STlmaGZvRWxuN21abVNDWFc1bUFjMHdrbHBNY3Zx?=
 =?utf-8?B?eHZBRVNyamk3UStuMHArQTJlaW5ncTlqYnViaG1iQ2NEVlVVaDBMNVRXbGFW?=
 =?utf-8?B?YXFZY1FtVW15M1pJbXF3Y3VtK1c5Nk5YQ3NJWEQ0QmVxSUdEcEpyUXl2V1Zl?=
 =?utf-8?B?WXdERERqT0JvdjRJcnBSQ1d3RmpTemFRL2dRK2tmSTdUOWJGSzE4WjFxL1Az?=
 =?utf-8?B?YXh5Q3pib080RTVtdGRxbkQyRGhzK0NlVlhDQ1Z2Mk5iajBHaUxuY0VsR0pz?=
 =?utf-8?B?YlB6VnRubVpzRVg2OEptb28xZ3FEYm81Q2VvY3grOG9RNFNXVWhFWjN1Vm51?=
 =?utf-8?B?bFVRcXlDTmNHTFlicjZ3eFZkNmNqdW12bTk1cElrcWI0WDNMdmZId0Z6VEtx?=
 =?utf-8?B?NWMyaURLV1RERWxVbGZlRWY1L0syb0t5VisyYVlPWmdlVHM0R3NjbVZWbW9G?=
 =?utf-8?B?M05RTGFtOXg2Zkt3QjY5dk1OTm5iM1liSmxwN2haN0NoeVpBZnlPWDBEc0kz?=
 =?utf-8?B?ZktxU3Zxc0xrSXpqOGMrMEJZa0lLb1EwVnhFZjAxUDFCaWNmTzJKVW9ERnM4?=
 =?utf-8?B?OWZMaWNJSWd4RzliekVyek9QQVNuRFlPVGhjQk5JRHVBdDJ0Qmt5enNLYzVr?=
 =?utf-8?B?SDg3MjE1anMrWmdnZ0o0Vjh0Um1rM1ZqSHA2dXdLK2ZuR1VrUVZQaWdheWFy?=
 =?utf-8?B?RXc4Z3g5Y3hyRXdSWEZ3ajVIcDVPWmp0ZE84ZmxicENTeURmaEJaYit5RlJ6?=
 =?utf-8?B?T1EwRFZOUDNiR2RBSTVTVGx5S3p5UDhWb3VaelZzdWNqaE91SjFmYUNTMnJC?=
 =?utf-8?B?RXYranh5RGVxMGRQNWVEVXFYMEs4QUZuSEJOZ2FDWUk4SnNnSnNOakJWWWQ1?=
 =?utf-8?B?ZHRSUDI5VlpiMmlyUzBib3Y5RXJCLzlpRmJpZTBwUG4zQWs1c3JyQzQ5MnJz?=
 =?utf-8?B?c05aaVQwSS9pejNTZEFYOEJMU3ZOYW5sNFBYNnBqR0pHWTR4cTJhcXhWa1JY?=
 =?utf-8?B?Z2dKVWFMdElTTGhUNnpwaWZOdDRiY3diK3gyQXpOMXl4dXBYeEtydkxWaTV5?=
 =?utf-8?B?Ym5FNndUb2xPSGxONnMvWVV6NW5DbXp0bGpUL1Nacy9VOHA2VFEyUDR2dXhV?=
 =?utf-8?B?SVdsRm9ONVVoc3p1VzNpenJlMVVpbG80TWUrSVNrdldoN25RSnlkV3VJWjhR?=
 =?utf-8?B?MjRzSGh0amZlbFh0VFhwSVA2N2dod0FlNXZTcWR0RzBKWFd3b0NPRWZIVENC?=
 =?utf-8?B?TUsrTFBEUklNRWxvQ0U3M3dwNUpPS2lHYWJGZkdCRWExM1lYcnlMZDhTTkxp?=
 =?utf-8?B?SzZOM3ExVEpjbFZaU2pmQ1NIYjlsUWdSalN3ekd6OVpOUEFadUxlenQvQ0p3?=
 =?utf-8?B?V3doSTYzOUlxVGdWeThiS2xpdVc2R1luVGtlWGVVWkx6azhSdWR0cDFBdDJv?=
 =?utf-8?B?VlRaODd4dldwSzlsbno2MGplV3VNNTlZbDlRRHpKWTNnamdXT1l2czNqVURZ?=
 =?utf-8?B?cDBSbUJXNGViek9haDhFVmNoL1JrU2xmQTErQkVReGN0MmNvamVlMDRmUDhq?=
 =?utf-8?B?UjJDVXV3STdnVjRXZ3hmNVhyUjNXbTNuK01tb2JwaFdQUGJQTHczVGZlQnBN?=
 =?utf-8?B?WTFoLzFYcW1aQjFJMEhIT3lJTnFHSi9OajcwekZFVlpHOHQzWXVMRkJWS3lG?=
 =?utf-8?B?RXcrSDRjSk1HU1IxS3RhUUhxbXJpL1VrM1hSS3VDeG8wVWp2MzAvbUt5dUJa?=
 =?utf-8?B?Y29CTDRFbFJBVDVQWXdlbkdGdmZ4MHlCZFRIVkZVVGlBSTdiN3NrN1FjNThV?=
 =?utf-8?B?bnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5505F5B68F52964FB4B28D348936FF1D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab82ff5-9a56-4a10-160b-08da5dc09557
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 13:24:54.6806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XJg1Di2kseqgfuj3IwqEZTtqESpaTwEA4t0Sy34FUE3VSD2OrzvSrhHMmzihv5m70FkrZsw9IHMW/KGfooFpE3Y3uOStD7vIzqNtcIN+hKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3129
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy80LzIyIDExOjMxLCBTZXJnaXUgTW9nYSB3cm90ZToNCj4gKyAgYXRtZWwsZmlmby1zaXpl
Og0KPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0K
PiArICAgIGRlc2NyaXB0aW9uOiB8DQo+ICsgICAgICBNYXhpbXVtIG51bWJlciBvZiBkYXRhIHRo
ZSBSWCBhbmQgVFggRklGT3MgY2FuIHN0b3JlIGZvciBGSUZPDQo+ICsgICAgICBjYXBhYmxlIFNQ
SSBjb250cm9sbGVycy4NCj4gKyAgICBtaW5pbXVtOiAxNg0KPiArICAgIG1heGltdW06IDMyDQoN
ClNob3VsZG4ndCB3ZSBoYXZlIGFuIGVudW0gaW5zdGVhZCBvZiBhIHJhbmdlPyBDYW4gdGhlIEZJ
Rk8gc2l6ZSBoYXZlIGEgdmFsdWUgb2YgMjQ/DQo=
