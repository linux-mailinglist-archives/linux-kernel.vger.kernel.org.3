Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF200582198
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiG0HzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiG0Hy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:54:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCF442AC1;
        Wed, 27 Jul 2022 00:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658908498; x=1690444498;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Mevq92QNkzfeB8OIZtSAghCblC16+8+/c/mc7LohpuA=;
  b=y4NiZmLGtz55HfsjL/XgVAb3D3Ca2geFpgPvq1x7EcVtAt3Hs0C3wYqV
   ySHDnx5UXiE72jv62e7FSWcQwRpBMGFZ+hux59izVFkODVMpLYgrPvTYk
   OJa1qJLEXz94cJIVXJ5qOJOK8NxJ9bGlERee4PXaRxGg4vC42iZOqJmZI
   jTIFzLwtZkRL8srAwdsD2ouHQmAMFW6H8dWQPjHovQVG7AvVCzBCYK2M2
   nKGHq/4L5Oy5iC7TfczKRtwQaQOGyDjwJ7XyTK7O9KYYqvzrlqxTQHWQc
   tJBFj4jf5oIHjKqL0C2B/t6LixVbMtU/ZPWHSCAUlf+tPMKIsBgRXJE2v
   w==;
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="106316564"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2022 00:54:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 27 Jul 2022 00:54:45 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 27 Jul 2022 00:54:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bapFp/KCiHF59zBM9DSRyMJHxvyQbfJcoeYe7zXyorsV2SmcI+dPHUpm1CdmgOhaBOxyCkiTauRXFNuayWohCpyDVhCeTnkYeSBKTIL/PST2CHjuthPWtvtdx3UaLPkpFGg8RwY77/4Nb1J9dHkpHEE04h7Qi11a//VQNYjXMKieJgSG8q/ABmy4Hf2CHkBBmuSWyZMCh9nMY5VUm3C+aAHX6ECOXmn19hDtu4ytbtnkD0Fc8f+RHdej/WdGkZesXPcrRFm5emdjumQQU+uUIOO7XB1eUkxgak4EBU3LkdAJKOmen1JxxGPE/9usGQeDZ2WN4kY26gVz8ZD3Lcc4cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mevq92QNkzfeB8OIZtSAghCblC16+8+/c/mc7LohpuA=;
 b=m4+0RGbwS2rArHZ5i/et0ev7AAMDx0GQSX7V6txkDOB/8MMMhIkjS5WsNNfZnIBRCJ7OTaZTuIGVhkrKwVlAxWerhMCs6onqUSCDq3ph1By7Kg0sNXpKEj+SWT7hcSc2sr+/SwPNjRG/xKqB1270yh0+IkLK96sdlDSjsipdKFqXXKbZekWOzaR/cLJw/8m2EZyxNDgl2fR+gYFrPnr+kKF+MjWr1VQwwNNP+DhD6x5xn2TF2bRaKPymcW/fo0fITgwTG12EsNSt9Ztn6VqFNuFSYlu3IMF8Osc6eVyZSm5ryp+kOqgF6j4JScrl82TlQDfm9uVW3EJ73bRHNOUmFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mevq92QNkzfeB8OIZtSAghCblC16+8+/c/mc7LohpuA=;
 b=IRuAtcIGerEdIZOrAc5OPQrj+f0WOh1szkI2FYyjFdpDRGsATHeZBreWsyKeXYcJuVb3EOCpNUD+U+2H0/oJm073da0dlwXU+A76Lrs9QRNG22pPbgVriEaYMo/d+kZgz8q9kA0dgmxZ1nV2wQUY11JtmilzFlI0JXW87a8SUmE=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BN6PR11MB1651.namprd11.prod.outlook.com (2603:10b6:405:e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 27 Jul
 2022 07:54:40 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 07:54:40 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <arnd@arndb.de>,
        <olof@lixom.net>, <arm@kernel.org>, <soc@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <f.fainelli@gmail.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <nsaenz@kernel.org>, <Conor.Dooley@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: soc: microchip: drop quotes when not
 needed
Thread-Topic: [PATCH 3/4] dt-bindings: soc: microchip: drop quotes when not
 needed
Thread-Index: AQHYoY4fq1pijnAHw0SCV6iarEQwfA==
Date:   Wed, 27 Jul 2022 07:54:39 +0000
Message-ID: <5b5d40d2-ddbf-a79e-239e-73418ee0a3a8@microchip.com>
References: <20220726115841.101249-1-krzysztof.kozlowski@linaro.org>
 <20220726115841.101249-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220726115841.101249-3-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 744522da-aefb-484e-a268-08da6fa54254
x-ms-traffictypediagnostic: BN6PR11MB1651:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?Y2tFUVdWRXI1YzZEOUFybURXNDk1K2ZSWnZ1NjlCZ00rRUtMbEErdjdybHFM?=
 =?utf-8?B?VnI5QlNlRVRrS05PQU04eG91ZzlXNnVWUk1wV3pWaU9NS0RJNjBWRUhZSC9D?=
 =?utf-8?B?RWE4ZEd6WEtMNXVtaWNSMENOY3VjdmdHQ244UnBKTHlaeGN5TERkZGpTbGcy?=
 =?utf-8?B?OVNHcDJ4RzBlUzQ3VlZsdjM1bkpqbG9SWnFqcHF6K2dmeEJ3RW01bkw5Unp1?=
 =?utf-8?B?ZGc3czBPVWZ2dy9TQSt6ZHRWb0VtRDlybkd1WUZ4bGtaSGNkMHlJN2lJM205?=
 =?utf-8?B?S05oeksvYzJ6akx1UHJmQTE3Qi9kNWdJb3RWUitvaFFHYjFiU2FJYk94U0lx?=
 =?utf-8?B?MDVFbXllL1RLcjI3RU9qcCtSdVAvY2NVeWpuQ0szWFhDSk9IbXRVUWpSOCt0?=
 =?utf-8?B?Ymd3a3kzOHZNemVXbGd4R3dqN0NvTklHOFhLNklDaS9Bd0NKQWhoWkJtUzJV?=
 =?utf-8?B?NjNZaFhlV21sOVd1V2hTcElxanl3RUpwcktzbUV1WFVVbjJ5K2ZzazF4dmp2?=
 =?utf-8?B?M3lIcTZzbWVHUG9PaEhaa3BtT3JGTFNxL1pYWTA2Q01BYS9GNmNoOVJMWEY1?=
 =?utf-8?B?eG5uY3hmTmNCR0FzTlNlZXNlV3FlbG5oWSs2VXR2RWp5ZGFzam9rb1FVdzFa?=
 =?utf-8?B?Vm9uSnFQYmxtODhYQTRaRXdwZjVvNStFNDJUTktKeWhJR0ZVemUxYk9aT3Qy?=
 =?utf-8?B?M1NrRTErRnFpQzhxZVhta0UzVjNwblkrRUttSGE2d3RZVFJhc3BFL2tiWENq?=
 =?utf-8?B?MmpBeDBwY1dMbWtzMG1Xa3grSVhLMEx3VHJVNUVVc1JVQ09Td2NWOVVHZ1pa?=
 =?utf-8?B?TmtXTDZyL0ZBam91Qm4xWXR0bFpsbHg4NVlpTHdOQjcxSjZxWjA4em9kdFRz?=
 =?utf-8?B?aEJsdDBsclhiTGZpcHVLMGVKRndCZ0Nta2llWEJTZ01Rekx2Vm82N3UxaU5w?=
 =?utf-8?B?VXhFTmRaSXJROElrNWxBUk9wa254cVZ4VENTUmcwM2p4VlFMVEFwMk9WV2hJ?=
 =?utf-8?B?cjA2U3VCT0ZaTTFvc0RvUGphWGE4NlZPVnowcjZjNlFFNHhxbG9vdytkREsz?=
 =?utf-8?B?UHBGMUloQnpTRzh2TVdTL3N6elI1RUZzYUpWOEdFVG45T0hiT1pkWUR6d01n?=
 =?utf-8?B?bllKZFoyNnpwdHUyeU1JenI5WWpHU1RJbUJvU1pzQjl5ZjN3dVhNQXRwSGdj?=
 =?utf-8?B?Vmg3MVdJNllZclg0alhPOHFGUGtkTU85ajc3OFNlWjJIUC9WNFB2ZEtiNE5F?=
 =?utf-8?B?UVhvRE9Mem5lOU4zNlZoMnRtYjRZbFFURm5uVEdyNmEreFJLUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(346002)(396003)(366004)(136003)(38070700005)(66446008)(66946007)(66476007)(76116006)(71200400001)(921005)(53546011)(186003)(66556008)(41300700001)(7416002)(2906002)(5660300002)(8676002)(64756008)(6486002)(8936002)(478600001)(966005)(83380400001)(122000001)(31686004)(2616005)(110136005)(316002)(36756003)(6512007)(86362001)(38100700002)(26005)(91956017)(31696002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clRFZ0plblNGcG9wTUcrMnFCMFk5dE5oRCtNRWtQRGE5ekU1cThnWktvWU41?=
 =?utf-8?B?R0RiY1ltTVdGT2x1eHJXa3Y5MTQyUVFqZVdnWnlQOE1iaFFHS0NnUkhQS0o2?=
 =?utf-8?B?SDUvY0tleWhDOUsxSElVNTNDMk8vYVplUDhvb2VycWpoU1lQVTlGK0IxWDNj?=
 =?utf-8?B?QVRiNENaclQ5QU1aMW1YdkV1UlREd0U5ZW52NktQMlNHcC9YK1lmelRPaTlH?=
 =?utf-8?B?eUlOclJseWZKM0k0Wm1yc2lvNkd5WEhQUnA3TTdjbGcvazN5Z3lZN3FnYnIz?=
 =?utf-8?B?Zm9VZmptNy80VEtGOVptdm9iaXY3VFVIVGM4ZWhFOUYwTy9nVm9ncXdEUGFR?=
 =?utf-8?B?NUduT3NhU2RGMlp3VDB0eDd0cXVKOEdrM2EwdEViL0pRd05ER24yUUZsMnM5?=
 =?utf-8?B?dktyRTNWUC8ydjFtVTJWZ2VtN2s0SncvZW9wb1RHTEIxT2I3WnBPSXNZQUV5?=
 =?utf-8?B?Wlp2YnprS1lvTG9OVGIzV2tMSTh0NDdEdjNRajNaUWlwMzRLSzFlQWxNRnZO?=
 =?utf-8?B?T0ptZ1VMdnk4Zmc4dytnRW1VTERpbzVKUlE4Z0RRL1ZQNGM0NnlFd1RtQWpJ?=
 =?utf-8?B?UXcxNWpRY2NHa1NyUGVEc25SOGU5ZHZ3alM0cFlBWlZQdlNaaXp3Rm93YmJo?=
 =?utf-8?B?UmxBVVhZTDIyYldJdDgzb0UxM0IwRmZBeDNURkdRUlhiUEpYbitsN0Njd1Bx?=
 =?utf-8?B?Z0E0a3p5QktvRGdEVWt5eGJWQkxzYndOTEhVcUZiNTFHbTRkcDJISEg2QnN6?=
 =?utf-8?B?d0NKMXg3ai9SVzBsOGNKYy9SYXNqWkx5ZlVtRmZMcUdDMERaM0VQVUpWM1Jl?=
 =?utf-8?B?Z295QXQyTmw1UVFUZGhuc3gzSzRnSzRyWXZQaEZjd1ZLV2ZrZENBdHlpdTlH?=
 =?utf-8?B?ZzQyYnJvNFVzc0JwQVZ5b0hHOU1ZUExjVWUrZ2FjMkoyVnBRMWlxMDBKK29N?=
 =?utf-8?B?cXdtc0p3emltZW1LbXVlSVRZTERnVlc2Nlg5eVRCRWFEQWczODUveE5ISnlM?=
 =?utf-8?B?YW9kRDhHalhPVkdkNlhaNlRteEZKS1grSFV3UkRHeDc4aHdBaWVZRnNZU2VI?=
 =?utf-8?B?M1ZmcGNGMDNBU2Zqa0h6K2Ewak1hdVUyRUxUTzlYTS9YZC9rTENtaHEyeTl4?=
 =?utf-8?B?UnliWW1FZFZoZ2hDRzJwYWpWbEhxcWZmYVFVd2svM2tpRE1QUW5XVHVId0lE?=
 =?utf-8?B?N09IQkFEMDNVUGQyZ3pQYVNadXQ2Zmg4a3VlaFRjZzNpLzdPbE1VTU9seGNN?=
 =?utf-8?B?ZFkxOWczZzBUZ3I0WS9zSG5TSTNjNkpEc0RpaEtvQnpPa205ajkyZGlyRXpG?=
 =?utf-8?B?WXhQWlVWRS9WUWw3NDNmb0xCNlo3dk02SXZVQmpXNVozcVFqdnVTNE1ZV1VK?=
 =?utf-8?B?L2gvTVF5ek4vWUxCRlVBaUQ5emNHeUJ5V2ZuOXZ0Y1NXazh2MVFxRi9nNmJQ?=
 =?utf-8?B?TWE5cXhueHZ6RFVPeUdUUnJ0bmFSeG9lVWVRZVlPZGR2cU40RTBtaHlmd3pM?=
 =?utf-8?B?cy8vQUlrK0oxYWw5MmwvNmthTUl5N0UzU0YwSXltNXRFVEpDVnFHamhETlpv?=
 =?utf-8?B?T3V5TTh1a2NrRVZ0c2VvMml1Y0hZTXB6d2xiR0hyQ1ZqWDhjTWQzMGxSbVVu?=
 =?utf-8?B?OER3ZmFDZWRxZnZkTmNEOUF5STdtWWVrZURyZ1ptV3VpZnFjUEozTVhTQnRZ?=
 =?utf-8?B?bjNaZkhDeEY1MTFSSWhLSUY4T2o0a2dUL2lHZkpBeTVrN0Q2a0treFBqbmJp?=
 =?utf-8?B?N0ZQWVFYR0VQV1VVSVZXbVVUWm1pVWUvZFNURlQydFo0UVo1QS96WkdPQ0JU?=
 =?utf-8?B?Q3RFbzl6UGRVUVBGa0tqV1JMZ3hrOFZQQlpuVU04VDJId1h0R0dKQ2dPblpS?=
 =?utf-8?B?T0sraFBrU09pejc4T0t6a01sNlZ0MEFRNkZtVk1pQWM2MFVJZUlmc0pMdzVt?=
 =?utf-8?B?WXpoSkdCV0ZpTU44L2M5ZG9aSEZDSGQvSVRnN1FESktxOE8zc0FUYnpucE5z?=
 =?utf-8?B?Vm81TjBLLy9tVXdsS0JJODE4VG1GNnV1MjZWdlN5OEk3S05DZmUzVHRiVEY5?=
 =?utf-8?B?M2xuQXdicStMb1UrWlQyckYxajVtdEtBSG5QSGhEZFR1MG1qM21BVFNWOGg4?=
 =?utf-8?B?aVpqdUttcDY2cFNaSmdrZzVkcm8vdENnZ1lneW83ZXI0d1JOS25pSG5DclJ0?=
 =?utf-8?B?SFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61ADE537E8A9D04487546DAD2BC94766@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744522da-aefb-484e-a268-08da6fa54254
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 07:54:39.5882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Y1X9VfmehT7ZeQ32WrTANA8HtLKKDDX7mJ8GBM6ob7Hj3B5n5E8yN4YV8qM62EB/Lbgs/tChtutGQwG664zeOX7kcfX272soQ3t1ekPfxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1651
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYuMDcuMjAyMiAxNDo1OCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBJZCBhbmQgc2NoZW1hIGZpZWxkcyBk
byBub3QgbmVlZCBxdW90ZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0b2YgS296bG93
c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQoNCkFwcGxpZWQgdG8gYXQ5MS1k
dCwgdGhhbmtzIQ0KDQo+IC0tLQ0KPiAgLi4uL2JpbmRpbmdzL3NvYy9taWNyb2NoaXAvYXRtZWws
YXQ5MXJtOTIwMC10Y2IueWFtbCAgICAgICAgICB8IDQgKystLQ0KPiAgLi4uL2JpbmRpbmdzL3Nv
Yy9taWNyb2NoaXAvbWljcm9jaGlwLG1wZnMtc3lzLWNvbnRyb2xsZXIueWFtbCB8IDQgKystLQ0K
PiAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9taWNy
b2NoaXAvYXRtZWwsYXQ5MXJtOTIwMC10Y2IueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9zb2MvbWljcm9jaGlwL2F0bWVsLGF0OTFybTkyMDAtdGNiLnlhbWwNCj4gaW5k
ZXggNTk3ZDY3ZmJhOTJmLi4yZjhjZjYxOTE4MTIgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWljcm9jaGlwL2F0bWVsLGF0OTFybTkyMDAtdGNi
LnlhbWwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9taWNy
b2NoaXAvYXRtZWwsYXQ5MXJtOTIwMC10Y2IueWFtbA0KPiBAQCAtMSw4ICsxLDggQEANCj4gICMg
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wIE9SIEJTRC0yLUNsYXVzZSkNCj4gICVZ
QU1MIDEuMg0KPiAgLS0tDQo+IC0kaWQ6ICJodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9z
b2MvbWljcm9jaGlwL2F0bWVsLGF0OTFybTkyMDAtdGNiLnlhbWwjIg0KPiAtJHNjaGVtYTogImh0
dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIyINCj4gKyRpZDogaHR0
cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvc29jL21pY3JvY2hpcC9hdG1lbCxhdDkxcm05MjAw
LXRjYi55YW1sIw0KPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1h
cy9jb3JlLnlhbWwjDQo+IA0KPiAgdGl0bGU6IEF0bWVsIFRpbWVyIENvdW50ZXIgQmxvY2sNCj4g
DQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21p
Y3JvY2hpcC9taWNyb2NoaXAsbXBmcy1zeXMtY29udHJvbGxlci55YW1sIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9taWNyb2NoaXAvbWljcm9jaGlwLG1wZnMtc3lzLWNv
bnRyb2xsZXIueWFtbA0KPiBpbmRleCBiMGRhZTUxZTFkNDIuLjA0ZmZlZTNhN2M1OSAxMDA2NDQN
Cj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9taWNyb2NoaXAv
bWljcm9jaGlwLG1wZnMtc3lzLWNvbnRyb2xsZXIueWFtbA0KPiArKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21pY3JvY2hpcC9taWNyb2NoaXAsbXBmcy1zeXMtY29u
dHJvbGxlci55YW1sDQo+IEBAIC0xLDggKzEsOCBAQA0KPiAgIyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+ICAlWUFNTCAxLjINCj4gIC0t
LQ0KPiAtJGlkOiAiaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvc29jL21pY3JvY2hpcC9t
aWNyb2NoaXAsbXBmcy1zeXMtY29udHJvbGxlci55YW1sIyINCj4gLSRzY2hlbWE6ICJodHRwOi8v
ZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMiDQo+ICskaWQ6IGh0dHA6Ly9k
ZXZpY2V0cmVlLm9yZy9zY2hlbWFzL3NvYy9taWNyb2NoaXAvbWljcm9jaGlwLG1wZnMtc3lzLWNv
bnRyb2xsZXIueWFtbCMNCj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNj
aGVtYXMvY29yZS55YW1sIw0KPiANCj4gIHRpdGxlOiBNaWNyb2NoaXAgUG9sYXJGaXJlIFNvQyAo
TVBGUykgTVNTIChtaWNyb3Byb2Nlc3NvciBzdWJzeXN0ZW0pIHN5c3RlbSBjb250cm9sbGVyDQo+
IA0KPiAtLQ0KPiAyLjM0LjENCj4gDQoNCg==
