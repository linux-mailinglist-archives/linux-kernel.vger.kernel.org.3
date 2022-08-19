Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A153A59A59D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349929AbiHSSQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 14:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350510AbiHSSQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 14:16:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3856641C;
        Fri, 19 Aug 2022 11:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660932964; x=1692468964;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+qNNqNtjU2HzI8xIrLh3qo00eogsEmTw5EXVAGOxTt4=;
  b=UyTQYwfz5+zTk0IaVys+Csz467ze6lMlXzMwu6AOxLwt1Lr9SXHAFOTP
   eDjGDQ+ZjwIititxZcHKkYJ+4aZj5w7AxNODytc4jnsvhd/41QtGLErSz
   KDY41vAMJ1eLgnZyAyJISCRW7mlM/dvw1weCGb0dJYOCag1bvcq+jT/px
   VDn5AaOXpYmi3MAiUI77EOResMRDjGUXhkQnPVp9wlvh2SexYdvlwqEgZ
   9MD/bUBOYDxgLDhT7QKajKRY4cwCGBVG7aj5VCynGpArVlHLJDEepZhcJ
   L7p6Q+THIXH1xQwKp12/YV8gB/COVqb3+dDSzf73cbJCGxmzGkPoMvfXb
   w==;
X-IronPort-AV: E=Sophos;i="5.93,248,1654585200"; 
   d="scan'208";a="177112027"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Aug 2022 11:16:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 19 Aug 2022 11:16:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 19 Aug 2022 11:16:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7gVlpdYvflgEsDdlSGtwwiQ21eGye9hLoCu1gA/Bs3KyXKisEUanOLTSpSpEHcwgN+WAyQpIFb/slr49a0xkiy/cPf7esX4rKhzEeEU2zrB4LW+z8iFxLMrQHCKptUstiB8eGOiaSidJc762c0SFTy9KI3FU/cSZXYWDGDQMLqHibww7uYNOTvjBRcqVqNg/Z7rXk8ZDqXCWiehI7LmVGHXKTvHtauYJBun/jE38fmAVpGUck6UnGgGHZGnafU1LL0BtKQ+6O520kUKoiHYafkkb8McHGYkaprJXnivvxFB0Of5kv4yAvcHx0xlCfYtDkDzxLVUyDc1kDmqM7dGGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qNNqNtjU2HzI8xIrLh3qo00eogsEmTw5EXVAGOxTt4=;
 b=R2vwySfVZKbuFzdV54swgin2XiYWhlDim1ttQiafT80HwhD4MSvZ0ttCw+TGOckJIwSPePk34MCTAM0A/F3CXYjLtEsbWmB0JLd0Gx2qt4UfC3PoWEALGehGvagJj8eNBOOUGaB7ck1Ya8//QzqdreQFeIishQaG62R9vkfNZtKPy0MMRLKoyFOdAuwBt2A0tt9XlLUuGkYHzsqCCxDvQeKzCenbsScfWIV/hsc5trkHJmRGRnPNdqdzVMUEFFBq6qWPDg+ipv4l++sz6KYJ2LIkkMM0r7eoseZHYHQeJZsAOqtAaPSg5LV98LXZoMITUv8vByqTRxCvML9ftcEd3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qNNqNtjU2HzI8xIrLh3qo00eogsEmTw5EXVAGOxTt4=;
 b=s50xsTPYo5KJvQuicsiF8jxgHHPbQA64pi2L9rZWMBkVBLKMOQFXlO+3UhuAFhWs+x23YajY/uUoK9XGF8FVoZHX1oHf+ZEW8s+mp/z/V2oMuydLeqCh4UvqzwUOXqjNUhLTEfL0ocQcJazuB6VTrDl+sdYUSURqhHBZJ/5baIQ=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BYAPR11MB3477.namprd11.prod.outlook.com (2603:10b6:a03:7c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Fri, 19 Aug
 2022 18:16:00 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5546.018; Fri, 19 Aug 2022
 18:16:00 +0000
From:   <Conor.Dooley@microchip.com>
To:     <prabhakar.csengg@gmail.com>, <geert@linux-m68k.org>
CC:     <prabhakar.mahadev-lad.rj@bp.renesas.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <geert+renesas@glider.be>, <anup@brainfault.org>,
        <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 6/8] riscv: dts: renesas: Add minimal DTS for Renesas
 RZ/Five SMARC EVK
Thread-Topic: [PATCH v2 6/8] riscv: dts: renesas: Add minimal DTS for Renesas
 RZ/Five SMARC EVK
Thread-Index: AQHYsLovHvp8srW8EUKH5nn4yyg3dq2wUQGAgAAVRYCABYKrgIAANlYAgABuu4A=
Date:   Fri, 19 Aug 2022 18:15:59 +0000
Message-ID: <c8f2b4ae-9921-157d-bb43-8fd8154255e0@microchip.com>
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220815151451.23293-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <07342070-d96c-59fc-f9dd-b65cd742d97a@microchip.com>
 <CA+V-a8uNRr+WPX=YC+UMT4ch4S5XwsatHCzUoSt+hTk4C=cheA@mail.gmail.com>
 <CAMuHMdXjWsUF1_CnojrvT+EyEmAp25jkT2TyWSisGinAGgMb3w@mail.gmail.com>
 <CA+V-a8t-O8ro8U3n46sjMS=HBJC-09V2hrdNXUCyhEZDrsiTfg@mail.gmail.com>
In-Reply-To: <CA+V-a8t-O8ro8U3n46sjMS=HBJC-09V2hrdNXUCyhEZDrsiTfg@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e618e5e8-47ba-4b62-b121-08da820ede7d
x-ms-traffictypediagnostic: BYAPR11MB3477:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0SJXXZHvZHJwW77AbC0uqbPZe69bWM6l5fODecV3kUIWCBLjoeHrbNi0R6PXJTr8RAseNsLhI2pbjHTwPFhlmZwpcxGqI5ff7H3SrxbjNhktpQloJxvp9jKA68W8HHY3NjkUQeYCy2w1XrbW3/AZEuCCQk4w8GfQz+WPAQypnBYvVUgND9p34gGv54NVzQBeL+ayfCWs6ApNETQEj7PW0OV90FMXgyhmPfNmHXg7ckGXfX/Z2NKFRUiLsk/ofiuCiveAYOD6yuw2KTwCs7hcB/vGKxiHfGA5WA8oRbo+3Qe0sJho1EXm5y0JdZJRzrm41j7BXaAMC1aMfqjfOT2usXP3SiDu17OHWJ9VHNALunZRhbP7SU4HzwcSrxiP7+5At2nYV1oGhv5B2e5VTWXA6K67JhIbctjDPFJRP6W53ztnPbVZv8UqGNmKpqcFcekIwKexFnuQuXPODAIYr6P5JpBsTpsNb+Y1MSXVmiMoZjOq0CH0uBVnnhtciPfJXPq3gC67igmImJewp4pFIYY9nLRa0MT4tkVN5FE0rQrA7IlhzqDi6zWGahF5hA964nyhmRdxFgEKiGZVmLDchDv/P5J/pHOHrsNRujuUclawXwde6zUXcrZ0Bzfbj9TwMUxyivWDgEz1gTOmMQqzttNNB09i+PYlIlqGucJp9gSKqUkC/dGtVvWs1rjVfvcp79qvWOhfyTcPSTnh79UpqMCKxyJ6XFU9Oyt/hJsxGj5INUHhJGvLpVcUy2tCUuqeRw3sOIOa7IwBwgC1kxF3JNNyT9Kj8GHm6/SWxYCNNZVPEMPTEs+QtuWIQV6JHsOkE2w7ojl9cMAIKFC6SjkORjWFcnS73l7CQEi/vC6XStzHNNA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(39860400002)(346002)(376002)(53546011)(6506007)(186003)(83380400001)(7416002)(5660300002)(36756003)(8936002)(26005)(6512007)(2616005)(31686004)(966005)(41300700001)(71200400001)(6486002)(478600001)(86362001)(38070700005)(8676002)(316002)(66476007)(54906003)(2906002)(110136005)(122000001)(76116006)(66946007)(4326008)(38100700002)(91956017)(64756008)(66446008)(31696002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmV2dWw0aWE2enR2Sy8vd1BSSC8zd09JYVVFWko3cmVhb3VBdlNBZHlSNE9a?=
 =?utf-8?B?KzgxdzNGUkwxZ3J0b3NFMFI0QjdrY1kyN2J6WnFNRkE3L0FvaW42alUvaTlJ?=
 =?utf-8?B?SFJNZGdLalFvZHUwb1czbmNWTklJdkJJVlNRdmdyd3VEeTZTZlRCWitLNUha?=
 =?utf-8?B?QU0vY0xkdE1zZTQrVnVqT1dLTlB6MnpCbXZFbWFsbE94djlkdU1oWjU5ZHlw?=
 =?utf-8?B?NVFVY2FPbjU0OHNUMVRkVlQ4eG83S2Fsa05NS1VSOXpwSlhDUU5WVmlINWM3?=
 =?utf-8?B?SlBmUk5Dd0V0bzRockVGTERHd3dxc3J5UUlxR3NxZi9BZ2cvYjQ4cEl5V2dJ?=
 =?utf-8?B?TkgxbkZKRXdLNkJsNEp3RFVRSkRwbS9PVnJnUGRjanBLUnRvQmVrNzNIeXdD?=
 =?utf-8?B?TE1aaEl1Uk1VUlZDeDFVRmltektYbEhjb2lYREJLUkJLZGt4UjRUTTVRekZ2?=
 =?utf-8?B?MFNDellJaHVYT3l5dWNCOFBpNFFENkw1OUN6R1hFRWhmTDVXaFBuWWJUOGR2?=
 =?utf-8?B?cFlack4wYzZtQ0lldnNrelBZOFg2NzNraDRuWG14NDR1UGp3ZXozVTBncDdL?=
 =?utf-8?B?OE4xQmNqZ3d1aWxDbFVJdzNITnY2OFpJTWNRYWo5cmVCSDVPbDlscHpuaFlZ?=
 =?utf-8?B?cSt5UnB0NHhubldyVFNzUGE2RVBscHE4QWt5NGl1K2htNnZjUVhSWXUrSnI4?=
 =?utf-8?B?eEhXbDdzaFR0eU11WDlOZVdJbVB6N0ZxdzNKTnFDbTMzQ0hkQkJCR0dTSDl4?=
 =?utf-8?B?YmF2bkZlT3M5WW9FdjhlZFN5dEdRblpMZU9JdXVwYU5Eamd1bUo3c1NCNmJw?=
 =?utf-8?B?bHcwaEYrRUxkK1JNNnVzdmk1Vk5FNFRqMlJXSWRxdkRHWmdia3hlSkJ1U3VZ?=
 =?utf-8?B?T3N5YVFXZEtaQzRzOCtDaTV3eCtDUGs1Y2h1RnNObTBNOWw4NUpneW5mV0hv?=
 =?utf-8?B?Q2ViVHBzMWplNUhoVXJ1L0c5Q0dZY0Z6bHM0S0VyNURoTVpJQWtGcWhnU3FK?=
 =?utf-8?B?dlV3VzNETHEza2pXdW1GZUpZOFpHNDFEZTNxcVVXYlNGSTlQTU8yeUpJWnBq?=
 =?utf-8?B?ampRdXVWSnBydzQvRGRwdEprOGhCUnZlTjZxSGdKa0dKRGVjSnBtQVN6cFQ3?=
 =?utf-8?B?MWJPYlh6RFZXU0tlUm43bE1YU0h5Mko1WFRhM0pPWGRKY0k4SE15SE5NVStv?=
 =?utf-8?B?N2V3QVAzUUY5UjMzeVN6b3ZPMEhObEUzNkdjbnR2c1oyalU1NU9kbG9aWkRj?=
 =?utf-8?B?cDE5a0ZmRTZ0MzNKd2ZGOFFaNGFvTnR3eFZVZTFJMnlnTFdhaS9hRG00MFg4?=
 =?utf-8?B?bmhtNXROT003UmRHMXNIT0RiRElPMDN4a25NZDkwSjFsYVNPNGhiWUJaQmpE?=
 =?utf-8?B?M3ErNk1SWWdTd1BDd0pkNGEwMWo2Sk1VN3pQcC96QnQ2ZEFzNndBV3g2bmxU?=
 =?utf-8?B?UU9vcHBZQS9OZ3h0YU1YRDhQeEs4b2hZSlBIQUEzWnNITE5YVk9xQ080eU1h?=
 =?utf-8?B?NUw5U0cxQnNtck4ybnRFdUtTNWVWVFNqcWRWM3djM0h5WXZ2N21ZZXZQTzRU?=
 =?utf-8?B?M285SWxyUGdZWlZ1Nlc3a29jcDU3RXBSOG5jWGtsOWZBa0Zka0kyNnFwb3ls?=
 =?utf-8?B?OGhmNmczcUdlRFZiTytlelpLWU9tZ3AybldkMTlyMVFaY0dncjh2VEZyRkpl?=
 =?utf-8?B?ekVHaStvVUxocGwrVFprcDFlOE9ldnRjbVJrWGQyQVpMU2ZQdzZuZ3NMbEJL?=
 =?utf-8?B?U1FSdUQvbUVCQ05zRkdJeEZmMVdrRlZ6cURHTGQ2YU8vcFB5ZGpiRHozQzd3?=
 =?utf-8?B?R2VpYnErc2RvWHdiYnFtOEF2bmhvdEx4dGEwaWpDL0dTYUZvYUkzaUIwTDVK?=
 =?utf-8?B?cCtsT0Vnc1FNYW9iUkoxV1J5Vkp4QUxrVXBFTVFva0lQRzhyekZSa3lVS0cy?=
 =?utf-8?B?NmpzK1VrOWxXUVkzbjJORXNyWmM4c0hjaUw4Wjl5UElLR293SFJjNDg1OEIv?=
 =?utf-8?B?UCtPbk5UUFJ3Z3c0MTIxUTIwRFI3MUpHRnR2aks2dEFlTlcydUVoVjFBUlFs?=
 =?utf-8?B?a0NjZ0U5VFNQQlhONE9pekNHOGV5UTRTcTVLdFBCTWwyZ0JCQWU0YjQrTTVz?=
 =?utf-8?Q?LX8pJi77NL8FeKibJviiWca5f?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4162BF5E6680C4FA69587B64AEFFA9B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e618e5e8-47ba-4b62-b121-08da820ede7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 18:15:59.9797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LwAOdC7/co3khgRDXmLTD5B5ESBuexmnBksi4YBFPJoekZCw/oRZWWKn3y0GR3YZN2RB9cOr30mW4erDR97AJTtU1lyUhoNJeBnvoPQlT8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3477
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkvMDgvMjAyMiAxMjozOSwgTGFkLCBQcmFiaGFrYXIgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGkgR2VlcnQsDQo+IA0KPiANCj4gT24gRnJp
LCBBdWcgMTksIDIwMjIgYXQgOToyNSBBTSBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4
LW02OGsub3JnPiB3cm90ZToNCj4+DQo+PiBIaSBQcmFiaGFrYXIsDQo+Pg0KPj4gT24gTW9uLCBB
dWcgMTUsIDIwMjIgYXQgMTA6MTYgUE0gTGFkLCBQcmFiaGFrYXINCj4+IDxwcmFiaGFrYXIuY3Nl
bmdnQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4gT24gTW9uLCBBdWcgMTUsIDIwMjIgYXQgODowMCBQ
TSA8Q29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20+IHdyb3RlOg0KPj4+PiBPbiAxNS8wOC8yMDIy
IDE2OjE0LCBMYWQgUHJhYmhha2FyIHdyb3RlOg0KPj4+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5v
dCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29u
dGVudCBpcyBzYWZlDQo+Pj4+Pg0KPj4+Pj4gRW5hYmxlIHRoZSBtaW5pbWFsIGJsb2NrcyByZXF1
aXJlZCBmb3IgYm9vdGluZyB0aGUgUmVuZXNhcyBSWi9GaXZlDQo+Pj4+PiBTTUFSQyBFVksgd2l0
aCBpbml0cmFtZnMuDQo+Pj4+Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogTGFkIFByYWJoYWthciA8
cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPj4+Pj4gLS0tDQo+Pj4+
PiB2MS0+djINCj4+Pj4+ICogTmV3IHBhdGNoDQo+Pj4+PiAtLS0NCj4+Pj4+ICBhcmNoL3Jpc2N2
L2Jvb3QvZHRzL01ha2VmaWxlICAgICAgICAgICAgICAgICAgfCAgMSArDQo+Pj4+PiAgYXJjaC9y
aXNjdi9ib290L2R0cy9yZW5lc2FzL01ha2VmaWxlICAgICAgICAgIHwgIDIgKysNCj4+Pj4+ICAu
Li4vYm9vdC9kdHMvcmVuZXNhcy9yOWEwN2cwNDNmMDEtc21hcmMuZHRzICAgfCAxNiArKysrKysr
KysrDQo+Pj4+PiAgLi4uL2Jvb3QvZHRzL3JlbmVzYXMvcnpmaXZlLXNtYXJjLXNvbS5kdHNpICAg
IHwgMjIgKysrKysrKysrKysrKw0KPj4+Pj4gIGFyY2gvcmlzY3YvYm9vdC9kdHMvcmVuZXNhcy9y
emZpdmUtc21hcmMuZHRzaSB8IDMyICsrKysrKysrKysrKysrKysrKysNCj4+Pj4+ICA1IGZpbGVz
IGNoYW5nZWQsIDczIGluc2VydGlvbnMoKykNCj4+Pj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJj
aC9yaXNjdi9ib290L2R0cy9yZW5lc2FzL01ha2VmaWxlDQo+Pj4+PiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGFyY2gvcmlzY3YvYm9vdC9kdHMvcmVuZXNhcy9yOWEwN2cwNDNmMDEtc21hcmMuZHRzDQo+
Pj4+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcmlzY3YvYm9vdC9kdHMvcmVuZXNhcy9yemZp
dmUtc21hcmMtc29tLmR0c2kNCj4+Pj4NCj4+Pj4gSnVzdCB0byBzb3J0IG91dCBzb21lIG9mIG15
IG93biBjb25mdXNpb24gaGVyZSAtIGlzIHRoZSBzbWFyYyBFVksNCj4+Pj4gc2hhcmVkIGJldHdl
ZW4geW91ciBhcm0gYm9hcmRzIGFuZCB0aGUgcmlzY3Ygb25lcz8gT3IganVzdCB0aGUNCj4+Pj4g
cGVyaXBoZXJhbHMgZXRjIG9uIHRoZSBzb2M/DQo+Pj4+DQo+Pj4gUlovRml2ZSBTb0MgaXMgcGlu
IGNvbXBhdGlibGUgd2l0aCBSWi9HMlVMIFR5cGUgMSBTb0MgKEFSTTY0KS4gUlovRzJVTA0KPj4+
IFNNQVJDIEVWSyBjYXJyaWVyIGJvYXJkIGNhbiBiZSBzd2FwcGVkIHdpdGggUlovRml2ZSBvciBS
Wi9HMlVMIFNNQVJDDQo+Pj4gU29NIGFuZCBzdGlsbCBiZSB1c2VkLg0KPj4+DQo+Pj4+IElmIGl0
IGlzIHRoZSBmb3J2ZXIsIGRvZXMgdGhlIGFwcHJvYWNoIHN1Z2dlc3RlZCBoZXJlIGZvciB0aGUN
Cj4+Pj4gYWxsd2lubmVyIHN0dWZmIG1ha2Ugc2Vuc2UgdG8gYWxzbyB1c2UgZm9yIHJpc2MtdiBz
dHVmZiB3aXRoDQo+Pj4+IHNoYXJlZCBwYXJ0cyBvZiBkZXZpY2V0cmVlcz8NCj4+Pj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcmlzY3YvM2NkOWVkNWItODM0OC0zOGFjLWZlYjEtOWE3
ZGE4NThjZWJjQG1pY3JvY2hpcC5jb20vDQo+Pj4+DQo+Pj4gaXQgZG9lcyBtYWtlIHNlbnNlLiBC
dXQgSSB3b25kZXIgd2hlcmUgd2Ugd291bGQgcGxhY2UgdGhlIGNvbW1vbg0KPj4+IHNoYXJlZCBk
dHNpIHRoYXQgY2FuIGJlIHVzZWQgYnkgdHdvIGFyY2gncy4NCj4+DQo+PiBZb3UgY2FuIGtlZXAg
aXQgdW5kZXIgYXJjaC9hcm0vYm9vdC9kdHMvcmVuZXNhcy8sIGFuZCByZWZlciB0bw0KPj4gaXQg
ZnJvbSByaXNjdiBhcyA8YXJtNjQvcmVuZXNhcy8uLi4+Lg0KPj4gQ2ZyLiB0aGUgc3ltbGlua3Mg
dW5kZXIgc2NyaXB0cy9kdGMvaW5jbHVkZS1wcmVmaXhlcy9hcm02NC8gYW5kDQo+PiBlLmcuIGNy
b3MtZWMta2V5Ym9hcmQuZHRzaS4NCj4+DQoNCklzIHRoaXMgc29tZXRoaW5nIHRoYXQgeW91IGlu
dGVuZCBkb2luZyBvciBpcyB0aGF0IGZ1dHVyZSB3b3JrPw0KSSBoYWQgYSBxdWljaywgYW5kIEkg
bWVhbiBxdWljaywgbG9vayB0aHJvdWdoIHRoZSBhcm0gc21hcmMgZHRzaQ0KYW5kIG5vbmUgb2Yg
dGhlbSBhcHBlYXJlZCB0byBiZSBhIDE6MSBtYXRjaCB3aXRoIHdoYXQgSSBzZWUgaGVyZS4NCg0K
SSBhc3N1bWUgdGhhdCdzIGdvdCBzb21ldGhpbmcgdG8gZG8gd2l0aCB0aGUgIm1pbmltYWwiIGlu
IHRoZQ0KcGF0Y2gncyBzdWJqZWN0IGxpbmUsIGFuZCBzb21lIHJlLW9yZyBvZiB0aGUgYXJtIGZp
bGVzIHdvdWxkIGJlDQpyZXF1aXJlZD8gSW4gYW55IGNhc2UsIHlvdSd2ZSBub3QgaW50cm9kdWNl
ZCBhbnkgbW9yZSBkdGJzX2NoZWNrDQpkZXRlY3RhYmxlIGlzc3VlcyBzbyB5b3UncmUgZ29vZCBp
biBteSBib29rIHdoaWNoZXZlciB3YXkgeW91IGRvDQppdC4NCg0KUmV2aWV3ZWQtYnk6IENvbm9y
IERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQoNCg==
