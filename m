Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B3D573ABD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbiGMQB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiGMQB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:01:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5542E2BB2D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657728085; x=1689264085;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=46bnI7ElmzaCkEB7c8fo4BgjPHHfwaWDIJBI7D3bRNc=;
  b=v6KWp44zrq8GvIT4FSofKV171r1AV8jaD44HhHLWPhKQc9iEnT1VEE9j
   OOYnVAlm97L1F7TMBPrBtRmcnYKRwgrz+KwYgsgoG3xMAxsM+nMCxpxGT
   XFf0Bc6N96q3gazfSNS0L7zXsS93AM8IDphKAFRj1u6lCLG6MbNNwD9Mo
   4V51lu3CVS5rGCbMv6CGLE6k7YF25HoZAuMjaQHFvD7ZRuAG3z3y/NbzC
   k4OF1JXRRSypm3v22mj3ghO85InMLKp7LdM0uWI+jql5/NHtSxx6M9JBC
   vwJIg76NqIwxzQXxEip0Xt4FqQ4SZyUL3E1eVCcxBAvb2lHSkTg2NGq3E
   A==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="181983442"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2022 09:01:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Jul 2022 09:01:24 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 13 Jul 2022 09:01:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6Q8aBgMxJfZwdCZFAlS5VhSLIrUUyJYY1qoFiPxQdMkEVXD7oSEnXEazUdWOA4Y62RVnpzv3FCCEFMg0WgNtDzR/ncfcMDEN0trUWx+dhUhBOpJXELYm4I+C0vZVTrHT8OwI2x0LM9Nu5LiBDOMMCad9ArrPSz6L8p6qOTldoyXgiYa2OQaQvYnkqb70Gg7kbX5EJq7I35WyJDYyrsRGxPMJ5QEVoG5fmY0df0yYU16QMbum4RA/O6v3rn4vl7l5ae5nJPNyTMTeusDsuIEumKGCnHVfAENqcC1Ed9q3ZGTAwE3dLTEqGRy5UOT+6MYIY1iOdfwfPJnhevRrMnbVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46bnI7ElmzaCkEB7c8fo4BgjPHHfwaWDIJBI7D3bRNc=;
 b=KEmRSmsq6lIgazst0zowSWy8kAebukP+KIliQhSb9tJdqLrUTs5C3sIPefX6Ds5MHCzos10LKMQJjY8lyZwmjur+dqgDztO5sHOJOUw0C4OM6ZnwyRWrAzplnOG3EDto7tAhQAX/eO7e/IpftyN/x7Jo5bA6taDpATtYWqrt5zcGxrwjtp04lvQqev52p/QhpJZqSMf1T/Pwh+qr2foASmstRNjCyaidGRUMX/og99vd8ZMkZO57qvCegRqP5Q0YzB1ZX9Dxx85zhkY3jvH0yCC1C52jrriSGvsAjUGCUuiXE3ZlQmmFqyr5hYAUqkITiG6LPZG4s7qOA3cRMTDQbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46bnI7ElmzaCkEB7c8fo4BgjPHHfwaWDIJBI7D3bRNc=;
 b=fEyCye9cCyktVDcZtqyL0/cwsTRpIDQYvUoqjgY2uygTbgFACEeyR2/YI6HIuReQeTFwISA2O1y07NoQWdEBcHtoxpbkKQH9WwYga2vJRI/m/k0LzAy62LV/gOBzCzB6NjuEETdZdtRaSMWFXk6WCWHdYpQLN1wzJzv4hC48D7Q=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 DM6PR11MB3145.namprd11.prod.outlook.com (2603:10b6:5:6e::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.12; Wed, 13 Jul 2022 16:01:20 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4%6]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 16:01:20 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <peda@axentia.se>, <regressions@leemhuis.info>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <du@axentia.se>, <Patrice.Vilchez@microchip.com>,
        <Cristian.Birsan@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <gregkh@linuxfoundation.org>, <saravanak@google.com>
Subject: Re: Regression: memory corruption on Atmel SAMA5D31
Thread-Topic: Regression: memory corruption on Atmel SAMA5D31
Thread-Index: AQHYL7i/by/02n1wA0qavxdAEojSf61kLXgAgBkWqoA=
Date:   Wed, 13 Jul 2022 16:01:19 +0000
Message-ID: <9104267f-6dd5-4e49-6a81-f377edceffe9@microchip.com>
References: <13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se>
 <6d9561a4-39e4-3dbe-5fe2-c6f88ee2a4c6@axentia.se>
 <ed24a281-1790-8e24-5f5a-25b66527044b@microchip.com>
 <d563c7ba-6431-2639-9f2a-2e2c6788e625@axentia.se>
 <e5a715c5-ad9f-6fd4-071e-084ab950603e@microchip.com>
 <220ddbef-5592-47b7-5150-4291f9532c6d@axentia.se>
 <6ad73fa2-0ebb-1e96-a45a-b70faca623dd@axentia.se>
 <0879d887-6558-bb9f-a1b9-9220be984380@leemhuis.info>
 <4a1e8827-1ff0-4034-d96e-f561508df432@microchip.com>
 <1a398441-c901-2dae-679e-f0b5b1c43b18@axentia.se>
 <14e5ccbe-8275-c316-e3e1-f77461309249@microchip.com>
 <c5928610-4902-27f3-7312-e8c85eefad39@axentia.se>
 <bfb4cb27-e2e1-e709-1c27-d938e4d30eab@leemhuis.info>
 <6b1bae01-d8fb-1676-3dee-9d5d376e37f1@microchip.com>
 <0d8b2d9c-af85-7148-ff13-aa968a7f51ad@microchip.com>
 <AM0PR02MB4436C535FDD72EFE422D8B10BCB39@AM0PR02MB4436.eurprd02.prod.outlook.com>
 <272fb9f0-ad33-d956-4d0f-3524c553689c@microchip.com>
 <dc500595-7328-999e-6fa7-7e818378bb0d@microchip.com>
In-Reply-To: <dc500595-7328-999e-6fa7-7e818378bb0d@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c968a27-9b3f-4010-9f26-08da64e8ed2b
x-ms-traffictypediagnostic: DM6PR11MB3145:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vt7poBiT6KKtdX9Uw7OC5cv1ymtPkxDUJhAJXkER6/1beMnxgY6plfTQvajBTX6dbRgic/huKWgz7P7H3TubgJlDbw36KstxweZ4W/vVjSUuH71Lzra2i5VWG8Vhx7PIP/7BzIgu5tSik8jVGUH1CP/+4Igd91qE4mxUUTkDuMVIW/cvOcpBEBI0a16b48be1F5vNroif24+0ru6tyRQ/BdB1jPmYpzIJj/vG2gaFUTx54N8KYj1GOMaTTXyEEC1OSi7Rvp9vkNk4EV7kin3oa0/cO88Begai+m3YqgG06WSg7uxdIPFe0lDfsT6aj801ESafmIPRxtvo+l8+Rvwi+0dsGHMbUbhUsT3HsaUXvKD4phct6obTLw2CpUvgZ/Yabxc0sQkzx4M5vwd8wGy9OUJQuU5aD3Xp7DQNN7nZL1c0lmIrEK1MNRLxn4z+3XZonuZkHGsFAyvCEA3WWf7WM4/taQKRe+ps+POVW91YTpZXQclOJIxAucPtw79ngelPYuZFVqD8+iFwu+nKDCHroSEehm+XNvF48XVq2aJMZCW+r0vRitlE8RetrBixUe8PN8CTeAtD9rA41y+bTuaw6/9dLGlSbYQM3PggMbb7A9uR/j618pwEVbmA84TEsJalir2EhfQY2JjoqSYVtDI1dSFigbC9ESPtyZzhz88zAVNdKhfKlCT0D+DYCYTP7W+9hyfx8WtobBOB+jb5VJpEKd87xORvZiFLJ8w+51Y4MasEmB8oV4QbnsibY0mXQ9I8YJP5SZyJxE1qmxCg1/5tO2kq/00aO4JPF+dCXk3xxR9AMnF8RZA7Azl3C2R07Cim/bNEcUcFn5NuRtbAiFSXorDu+hD2Nha1YyAkr81lcd61fpqGJ3f7nJ10UnkX19X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(366004)(346002)(39860400002)(396003)(186003)(38070700005)(2616005)(31686004)(4744005)(2906002)(38100700002)(36756003)(5660300002)(8936002)(66446008)(71200400001)(66556008)(66476007)(8676002)(66946007)(64756008)(91956017)(41300700001)(478600001)(6506007)(26005)(6512007)(6486002)(53546011)(4326008)(122000001)(110136005)(76116006)(31696002)(86362001)(54906003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2ZZM1VuUlV4ZFVkckJFQU42TFVLbGFsOERydVE1YWVsZzBTZUZxaXRKWllM?=
 =?utf-8?B?S0hFNTRmRXB3cFMvbEJVVFRSYUFMNUcrancvUm1KRmFPdncrM3l5MWdNWWg5?=
 =?utf-8?B?TjJZK1FRMEprUVQ5VGIrck1Id0c0YVVDQkhWZmlLRXFsNnRnTEQxaUE0WkV2?=
 =?utf-8?B?WXA4ZWV2Tm1CdEk3ZHp3d0RyMUY2a0k3NmJWUTMzN1ZnT0VoWExYRk9rbVBm?=
 =?utf-8?B?RDN6aTFUVnZrMjdNT3Y4MFkrVEVrcDRHQUhjd1lTM2t4OENJV3FQWWVDaFBM?=
 =?utf-8?B?eXc0V1hyYnFhS2l0WU1rcmF6bEx3TWdXMklUVzFobUFNcTRZbHBFTDN6aDBH?=
 =?utf-8?B?cWdzSjFUbjFrNlZDb1hPY3JlWk5oUUc0WTRKZnZYYVQ3Ym1JWVkya1BrcGp2?=
 =?utf-8?B?aE9BUzczYkgrYXU5aG5SYk9ORmJoSUd1YXpRMnk0aXlleHl4QkFscXJDd0t2?=
 =?utf-8?B?cit3UFJUd3diNVFlaGtBWmVYQ3RnbkRqR1FZbEhEeHdvSFY3Uko0ak8xRFUr?=
 =?utf-8?B?VzNLZ1VXT3g2V1NtaUJJUDQ0bnl3WWVsVHdZNDJmRlZPbC9UQnF2TlJXMWdR?=
 =?utf-8?B?U00vUTBlYW1tWTFIdWRxL010SEJGVFQ4MkZIUnNHRENjcXBhdklxSkZaQno5?=
 =?utf-8?B?cWVSWUNlRmFkUS9BUGVWZmJrN3RYZ1lwM2tGaUJrK0VKRVRwU0JkbkE4NG5Q?=
 =?utf-8?B?VVJmTm9RaHFpd0Z3enk2YWpSOW5LbUgzYUdsVU1NZU54T0kwZDRwMEZGcGkr?=
 =?utf-8?B?Q1RYZmsvUDBsd3NnQjl5TURkTkpMa29zUWxkemxnM1FMQW11UHR0Ti90Tnh4?=
 =?utf-8?B?QjJ5cjlmWDR4VHNhdmhkVXZ1amFKWDZMUmRIcUZCV09RbVFjZ1ZQR2FJYjYz?=
 =?utf-8?B?SDNyc0xZUzI0OHF6RXZXajM1dnBJK2RrTGpYYlJ0aHFjTXByc2dSR2lBZys4?=
 =?utf-8?B?NDBkYnp6STZnWVptcWVIREVuWSsrMmZjQk8ra09zcGJwNTZtSEVXTXJMMkx4?=
 =?utf-8?B?ekR3UkZsdEZnUkJQaVdObVBIbzJjOGtMaGNKT3d6enlMT2lSbHlHendVeTBs?=
 =?utf-8?B?TnZDNXRNZGZOUTlVQ3lSa0NvdjV6ejZzdExBbDM2Vi9PQUNkbEYra3FPeEtk?=
 =?utf-8?B?Wkl2aVVDWFVqNHcvNnFwSWtweHFER21qWkdmenNPcHhheTdiZnRBc3lFVWVs?=
 =?utf-8?B?Wm9oRnA2TEVHWEQrZ2Y0QXJzdnhENWVXa2VjTjVFR0NXdUozK0FOd3p4MS9M?=
 =?utf-8?B?bWNncXNWb1hDWWZSK2EwWnZDTnJCWXJISkRQWDZRNUFibFE0T2pENXMxWUZp?=
 =?utf-8?B?RGFFTjROV01aZWNOSzY2dEMxdDBpak91UWtWbEh5KzZZMEhTVWdaY1RwTGpB?=
 =?utf-8?B?RktHUjY3VnJUazI5bXRmOHlMYVMvb240RmxwUmtDbXdlandEd0RtWlBqd1Nz?=
 =?utf-8?B?b0Qrd0lSZlc1N1BTbkpJcHc2amNJNG1hcEMvNTFvbkJUd3pUNXVaTjc1RFNK?=
 =?utf-8?B?VUZQZmNRN1NPS2RXdmJBelBGaFowVlQxWlJVTkpRbjFRSGxsR2dHRHlqeU5V?=
 =?utf-8?B?bzVMQWxJU0RyOE81N3ZGTEYvQ1RWbklsVnRGbCsvU1MxUFhYQ2dZL1daS1lT?=
 =?utf-8?B?T2lEYXQ2MSt6QVdaRDA4L21kTUY2YzVWMXllNFhDSmU3d2Z6d1VXMjNoK1Rm?=
 =?utf-8?B?bE9SZFFlWlFkemZrMnBSb1h2YnZCaGUxTEduZ2dHdHlzRUlnb3NVenNJUGZk?=
 =?utf-8?B?dmlkOWtmY214b28vdnpXWDJtQlc1Ylg1Q2xjLy95OWsyUUZ3WGE0VDI5U1U0?=
 =?utf-8?B?cUp0b0VackdjdGdPWDlVMDBZLzJhWFlpRTQ4THFkL0J0VnRrTWdTbmU0dnRq?=
 =?utf-8?B?a3dIZGlPREtsREZLd2VUcXR4Sld6eXpXVW9BRjRRZUo0VWkyNzF2MnJVOElC?=
 =?utf-8?B?NW4yckJ2WEduSisrOTR1RjVtcUwvaFJjajNSM21oMUNqNnozS0JlYTQvU2Uz?=
 =?utf-8?B?WnRxTWVCVjM1Y21EODI3VGJLSC9NT1NlbE4wWjFKbW5IRGJrZlIwUVVxaGpN?=
 =?utf-8?B?UFVnSGdkc3BYUjIzbmNXbHcySUREUEFBWENIOHpRWTBZeVlTYnQxaDQ4MTVx?=
 =?utf-8?B?ZXNnVmhEdWlLTFc2Nlo4UW5ZTTlTdHU2Z1ZubkdYUXdNaDNkL1hwTzk4a1lu?=
 =?utf-8?B?QXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF9CBDC1B52CE74A93390159A23DC629@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c968a27-9b3f-4010-9f26-08da64e8ed2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 16:01:19.9970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0MuetzgXd1VIJaMVXAI4Gmj/esDrhhBo2o6AnsDkz1VUGbbiiAr7n/4lQs27m4bmzTfhmPyXF9FrzILlRE+cC4Q1lOrFhzm0vGqaWjMML70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3145
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFBldGVyLA0KDQpUaGFua3MgZm9yIHRoZSBwYXRpZW5jZS4gSSB3YXMgc3RpbGwgb3V0IG9m
IG9mZmljZSBsYXN0IHdlZWssDQpidXQgbm93IEkgaGF2ZSBzb21lIG5ld3MuDQoNCk9uIDYvMjcv
MjIgMTk6NTMsIFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4gSSB0aGluayB0
aGVzZSBhcmUgdGhlIGxhc3QgbGVzcyBpbnZhc2l2ZQ0KPiBjaGFuZ2VzIHRoYXQgSSB0cnksIEkn
bGwgaGF2ZSB0byByZXdyaXRlIHRoZSBsb2dpYyBhbnl3YXkuDQoNCkkndmUgY2hvcHBlZCB0aGUg
ZHJpdmVyIHRvIHVzZSB2aXJ0LWRtYSAoY2hlY2sgWzFdKS4gSXQncyBub3QgY2xlYW4sIGJ1dA0K
aXQgd29ya3MgYW5kIG9uZSBjYW4gc2VlIGhvdyB0aGUgbG9naWMgaXMgY2hhbmdlZC4gVW5mb3J0
dW5hdGVseSB0aGUgbWVtDQpjb3JydXB0aW9uIGlzIHN0aWxsIHByZXNlbnQgb24gaGlnaCBsb2Fk
cy4gTWF5YmUgaXQncyBhIGNvaGVyZW5jeSBwcm9ibGVtLg0KSSBuZWVkIG1vcmUgdGltZSBvbiBp
dC4gV2lsbCBnZXQgYmFjayB0byB5b3UuDQoNCkNoZWVycywNCnRhDQoNClsxXSBUbyBnaXRodWIu
Y29tOmFtYmFydXMvbGludXgtMGRheS5naXQNCiAgIGE3MzUxZTZmNGMxMi4uMTU1N2UwZGYwZmQw
ICBhdC1oZG1hYy12aXJ0LWRtYSAtPiBhdC1oZG1hYy12aXJ0LWRtYQ0K
