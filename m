Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F1A55FD7D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbiF2KkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiF2KkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:40:07 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AE2369CE;
        Wed, 29 Jun 2022 03:40:06 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25T6gqYG030980;
        Wed, 29 Jun 2022 06:40:03 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3gwy07gyfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 06:40:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APGDdtCXUHwZqfC18Ym8mwqgEp/OnJgnIvXIM7J9+qzVMTcZqRdDNWMQELAt90yYowHyPX+Cg1DLmXR0B4UXa3IiosFo6qD4ShfH5zPy53VoV9YdQcM23i+YjKq4rnZ71lirXpIph16Dl/oJkqiAXf3SZp/0vudcIH+8wy5X8I0/zZ557FrnD3Z1TtdNthpfjKYk12ViL1b3n7RL4Uaw+/exoLMEzWrWC0HR5SxkjMxuxYhFhdFHaT+9+I/mMlrnBP6YJsObtvrNr61dAcuD3TYNqmzPFfSLuyQ/eNQAe9iDuoCqVmB5Ho37kMuzAkkHZSM2MW0hs7xJwW5Yp3Aoqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GXjm4FA+05mH10Cgj5pfM/DC4nhtc8TUCwgCEF03SY=;
 b=fhyqet8NfaLyIE/aBCSNmNRPKCoydp/gC5D6cAXhfrgzLMV5oa0cFIp2b2BBiOmlx7Qzri9ZwYT1Sq+1y7iR46OdjdQvqc7udpSRC85Qp4PQIe6g1rovPA0U8YR3PBSPoc7IFHOLEdze1K/kCk9EP0i4z7DUr97iURm1CX8He3UBa5lgn9r+u5V7/oVKRziWvmoWKOYggDl7AN9zF931zamJ68Vcz2C1/f7ewClRRy02oQQSfC14d0xChKqVeuwuxJ9scAsnZHSWtClWGHiSpI0YcGJPpbjxXkCnxKJCqVEtEeAXn2CIFw0QfNGoa8MIWwrn7TDc1F+Fjp4RkEszZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GXjm4FA+05mH10Cgj5pfM/DC4nhtc8TUCwgCEF03SY=;
 b=Y4tTjzxDJUn8uL71/a2QBfkGyK+eNxplRaD4hkJF9Ye2oRLVFgmw8f4Nh8/I0sVWggyEkeR11GS2ZxL7JQSZYf1DHZqFo3r65LDh2BDe9nAVjHxXGTMmHv+ZeyipL8k0dmc7Dkum1VRw2Nh8Kt6jhz+gXTxliCGMQYv9OH2wFXU=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by BN8PR03MB5009.namprd03.prod.outlook.com (2603:10b6:408:d7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 10:40:01 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a4ee:b745:7e51:a3e0]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a4ee:b745:7e51:a3e0%6]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 10:40:00 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: RE: [PATCH v1 3/3] gpio: adp5588: sort header inclusion
 alphabetically
Thread-Topic: [PATCH v1 3/3] gpio: adp5588: sort header inclusion
 alphabetically
Thread-Index: AQHYiya7Gmk/GcosSkmil/FSbhBbb61mD/pwgAAXk4CAAAI8UIAAByKAgAABh7A=
Date:   Wed, 29 Jun 2022 10:40:00 +0000
Message-ID: <PH0PR03MB6786A0E94BEC148D3547D90A99BB9@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220628193906.36350-1-andriy.shevchenko@linux.intel.com>
 <20220628193906.36350-3-andriy.shevchenko@linux.intel.com>
 <SJ0PR03MB6253C3D92FFF37717D48C7618EBB9@SJ0PR03MB6253.namprd03.prod.outlook.com>
 <CAHp75VfR6XwW1HZDKoxhxs0i9R6s=uim1-dTtwJeXrA9AGWGQA@mail.gmail.com>
 <PH0PR03MB67861277E1AE456A316DFFEB99BB9@PH0PR03MB6786.namprd03.prod.outlook.com>
 <CAHp75VfeZ9jbWvFwL+Sae0h8DG36GeV4PKtskVQe10hpWGf28w@mail.gmail.com>
In-Reply-To: <CAHp75VfeZ9jbWvFwL+Sae0h8DG36GeV4PKtskVQe10hpWGf28w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFpERmtZalJoTjJNdFpqYzVOeTB4TVdWakxUaGlaalV0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhHUXhaR0kwWVRkbExXWTNPVGN0TVRGbFl5MDRZ?=
 =?utf-8?B?bVkxTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTWpNMk1T?=
 =?utf-8?B?SWdkRDBpTVRNek1EQTVOekkzT1RnME56Z3lNRGMxSWlCb1BTSnJabGN5TVU1?=
 =?utf-8?B?TlVETlBUVzFYVEZoeEsyWmFTM1F2YkZWRmVrMDlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVUTNVMnBUVlhCSmRsbEJaV2RPYkRKaFdrMVlVVFEyUVRKWVdu?=
 =?utf-8?B?QnJlR1JFWjBSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkVZVUZSUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVXB5YWtwSlVVRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
 =?utf-8?B?bWhCUjFGQllWRkNaa0ZJVFVGYVVVSnFRVWhWUVdOblFteEJSamhCWTBGQ2VV?=
 =?utf-8?B?RkhPRUZoWjBKc1FVZE5RV1JCUW5wQlJqaEJXbWRDYUVGSGQwRmpkMEpzUVVZ?=
 =?utf-8?B?NFFWcG5RblpCU0UxQllWRkNNRUZIYTBGa1owSnNRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkZRVUZCUVVGQlFVRkJRV2RCUVVG?=
 =?utf-8?B?QlFVRnVaMEZCUVVkRlFWcEJRbkJCUmpoQlkzZENiRUZIVFVGa1VVSjVRVWRW?=
 =?utf-8?B?UVZoM1FuZEJTRWxCWW5kQ2NVRkhWVUZaZDBJd1FVaE5RVmgzUWpCQlIydEJX?=
 =?utf-8?B?bEZDZVVGRVJVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCVVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVOQlFVRkJRVUZEWlVGQlFVRlpVVUpyUVVkclFWaDNRbnBCUjFWQldY?=
 =?utf-8?B?ZENNVUZJU1VGYVVVSm1RVWhCUVdOblFuWkJSMjlCV2xGQ2FrRklVVUZqZDBK?=
 =?utf-8?B?bVFVaFJRV0ZSUW14QlNFbEJUV2RCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlFUMDlJaTgrUEM5dFpYUmhQZz09?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44162805-2f92-45f9-018b-08da59bbb821
x-ms-traffictypediagnostic: BN8PR03MB5009:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M7/pWhKd3jCZc8iAa8JacRsKpZy1yIx3pOeZgTlOMhlcF2wLgco3V8ieJe397rP1JTWO09r+S0lJJYAY9rZ1Dy9mHx8uipbZQvcpjNeusj5CZXyFYEmcCUSIpCe8CWFRGGER3HryGixWtSVVCPJ97kurpVT0Qz85YMgCBpy3huwFKocA+szNhUJ/kJaOXH1COJdcymQ7Cu9dQkPy/fRkMyatC1oepsf66A1TmZ697FGPB0go4CCSyFGcaTTqcUhh7URWJhS21NbBYpq//GiXjJS+MIwgsKi0EywVSv62oXwZR20r3pf5x7miJjjTNNW4VLkXBMuiWPWB/dleBj34qwMxYZH5DDdgquiVbcFrBXcXyfjrA0fVGQdhDJuodvN9UPngl76VT6yyLcsTZ0sPavCDIQhtJhVCGnwGWTvLLdkq+AnZASO8MPfxE7pHuyT2xX1Rl/eoGIMk1cboiJkt4b9JDbjR8h6Ja29IBNo7LVnvF8qg5H4cq0/XAfTl2OVA0KZZRwubpwqpHNUqcu8+gQTBdHDtKJm/3UIt2YQuGGqdthqalhX0A+5jE+HlEyy4dkaIFicD3C/wr+fazINE68r4uElXBXCZjAFHraPoLLOKZgm2i1IuLwINqLQWi+nOIYYKtaf7SErtW9IAWTeU6Nze2ltj18Z430WZtPFpuH860J+mLWfEyOauzvzoGvmHP+s3FiduRay2TosFMKdzabwMzvf8H+S4gy84FoCE6Riih1uOIQflZDsZhibmOsw9rbJ0kQxygdikFs8eOI1HVBUcPmPbUZuTEDdlCRTIf//HBmhyF7NuUD4oUPzGuNaIC94vIxCWshQE3/1/m6RLcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(7696005)(6506007)(86362001)(41300700001)(52536014)(33656002)(71200400001)(5660300002)(8936002)(2906002)(478600001)(38100700002)(76116006)(66946007)(66476007)(64756008)(38070700005)(66556008)(9686003)(122000001)(966005)(4326008)(8676002)(186003)(66446008)(6916009)(83380400001)(53546011)(55016003)(54906003)(26005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REEvckZJY0Y4bXFzYWVIUm41RUdIK012ZW5iU1oxYVVITGtkeWJjK2JlS1ZY?=
 =?utf-8?B?SUpSM2pCalVUTXlvenhCWFpyc29mY0pZajlDMWFsbi9GeGhkK3RlaHdxNEdL?=
 =?utf-8?B?RTdzWWVtVmEyWjAyZlMwb3dvOTBsdFFZeVJRNmNGRm5XNXZDdE9scDRFRld5?=
 =?utf-8?B?c3cvTzd4eERibUNPWGVTOG11QzdmVjFGTnhIaHB5Tmt1NHoxRVB0bEd5dlEv?=
 =?utf-8?B?Q25kaW9BK0VzaVd1aDdQenpXcjJQT3NjZ3NCUnRRbVFidm03aEdJMjl3dnIv?=
 =?utf-8?B?cFYzdENDbjVZaHBaQ1luaG10ODVyQ2VNSHBsdk4yS0k1VXBOOUwvUGw2L281?=
 =?utf-8?B?cTJ6L080NHNESyt6ZkpLblliczU2TEZWblU3bVhWRzk3S3dQTnFNNThucXps?=
 =?utf-8?B?dHptWkVmZXp0Sy92bVVFWWRSTTY4OFVTL2dEZ2g3NTVSa2ZhdWZtY29OS0xa?=
 =?utf-8?B?bXNHS1hrOFhLbzIxSjZrMFE1Wk9JTHhVa05JNGtIYWZSK3Y0R0FlSk9zSmV2?=
 =?utf-8?B?Mk0zMllrVlVvTXJYMFZDZlNobmVDbFUvUnVTcDRRYitwVEc0TitPbkVaVUJG?=
 =?utf-8?B?TEFCN0RsL1phaTRLRTA4NXBJV0o0b1U3RVVWZFMvN0lwQkFSYUZsR2YzNmRh?=
 =?utf-8?B?V3Q5dkpBNnhLRzVTcWFqNWtnV1U2U2ZoZmwwZWhaWXhQQmFHT1FDdEE2dzZN?=
 =?utf-8?B?aEZyeHN0eCtjUG1MWFJuaXB6cFFVUnNrK3YybUd1eVVSdklYTmxXYUUxWTB2?=
 =?utf-8?B?YzVMOE5LUFZkSUdyaXN1dUIzcGdQc3dxRjV3dEhPQUo1U1ZWajFwalFKcEVI?=
 =?utf-8?B?NXpmeWlaNm0zQUtKMFVZTWMyNTRwb3NLZ05BbHNweFo2SDBGbGFmdHp4dFo2?=
 =?utf-8?B?MWk1UXc0c0NSTkMxdmF6Rm5OOTcyYVMyWnhiazR6ZDh3WEo0M2djL0FzTjQr?=
 =?utf-8?B?OW1HRlhnU0dqL2V5citmbkRjSWR0M0UzbDFBTmJSVTUxUzI1WDNyMDN5YkJR?=
 =?utf-8?B?NHhHMW04RUl1c1VycTd4SEQvcndKN2VlaFg4MHpOMnVEL1JxMDJpRW9EcTh5?=
 =?utf-8?B?K2dLSXlxa3ZJOTBnblNxeHg5ZHUwUnJXdDBBNzIzTXBMOC9KYkRjM1Vkb0hm?=
 =?utf-8?B?RFMrREVCRnNDWVRycGFoVHhCSE1iUU1IRStCQVdvYU0rUWE5OVBObE51bTAy?=
 =?utf-8?B?MFM0TzljQkFxcHV2azQ2T3lYSVpPRVh5b1c2RENReEFxOUVIUXdoSnRBdHV4?=
 =?utf-8?B?TTU4c2tLbGVyc0hZSy9xL1lqSWl3Q2dWQXhadWxvMnkxeHVEMGRoREZtWGNW?=
 =?utf-8?B?T0VyL0JvZ1c1R1JhS0RrUmhwNVl4ZGNKK3kvdmxCK0p1bUFSL2ZlcTZteUtT?=
 =?utf-8?B?MWwrYUV6Y2oyQVIvdU5mU0JwSjB6UTlJdlVUeU9OWWNVTkVYUEV2VE5VMEtK?=
 =?utf-8?B?T2hNT2s0QlNrSC9ydWtsR0k2MkpMbDRuN01sNlRLV21GTCsxVi9IcFQ3RWdE?=
 =?utf-8?B?Zm1wM3ZaaEJsSTV6eGxrWjdOUWlSczNIV0h5VGxnQWpZbkoxZjFubTk1cENz?=
 =?utf-8?B?algxajFneVBxZ0psMkdkUmE3V21POHVTYXo0c25jczZxUStuaUZmME5xcll5?=
 =?utf-8?B?ZTZtaXFOcjRCNDVxeHMvN2lRQlp1UzN3M1RsaGtIM2dDSHVGdzEySVZRQ3Bz?=
 =?utf-8?B?VnJWTCtLUEljdnFIMW9qSFVwWjNGT09jaDNyUlIxRjd2RWE4V0wxdGQ1QUNq?=
 =?utf-8?B?RlIrMlhCbTNsdkxlQjBPSTNmclZVVlh5Y3pJZlFsN1RITUg1TFQrbWlNN3k4?=
 =?utf-8?B?bkpsQm95b1REaGQxd3g5aUFBbUN0WDdUWXFYVGtpYU1taW5iVkNhVk9sK1NT?=
 =?utf-8?B?NFMrNi90NUFrTUhPU2p4b1BidnJPSlRFd0Y4RU9yYk9PaFNnSVdqU0NTcFF6?=
 =?utf-8?B?SnNJV2h5WnBlYkNDWWdreTJ3L1NRd0Q4MWdWMDczVHpNanJGenAxV1BWUHhS?=
 =?utf-8?B?c0JkS1JMenB1dnJFMDBuQUxqQldhOWNRem9yRDg0WlM3OWxGcUtqMXAvYmRK?=
 =?utf-8?B?bjk4R3FiaEM2VWY1MXVjUUh1bHpMblNGRkhHS2pYNmloeGJmNjZWVjdMM0tQ?=
 =?utf-8?Q?7G+f98uZguwmYgj/qHA+biTJ3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44162805-2f92-45f9-018b-08da59bbb821
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 10:40:00.8954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AbMetQkbioxE6ckDCmPBKDZu1Xf0NfPYTyvGaY6n8ac0PBlg+4sab4YJldW/5iPuRZhppR+tjtYOVrjKZu/RpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5009
X-Proofpoint-ORIG-GUID: FrxTI-eayENw6we9o5bLXya25GbgkF4x
X-Proofpoint-GUID: FrxTI-eayENw6we9o5bLXya25GbgkF4x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-29_15,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 phishscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206290036
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bmUgMjks
IDIwMjIgMTI6MzMgUE0NCj4gVG86IFNhLCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+DQo+IENj
OiBIZW5uZXJpY2gsIE1pY2hhZWwgPE1pY2hhZWwuSGVubmVyaWNoQGFuYWxvZy5jb20+OyBBbmR5
DQo+IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT47IGxpbnV4
LQ0KPiBncGlvQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
TGludXMgV2FsbGVpag0KPiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPjsgQmFydG9zeiBHb2xh
c3pld3NraSA8YnJnbEBiZ2Rldi5wbD4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAzLzNdIGdw
aW86IGFkcDU1ODg6IHNvcnQgaGVhZGVyIGluY2x1c2lvbg0KPiBhbHBoYWJldGljYWxseQ0KPiAN
Cj4gW0V4dGVybmFsXQ0KPiANCj4gT24gV2VkLCBKdW4gMjksIDIwMjIgYXQgMTI6MTAgUE0gU2Es
IE51bm8gPE51bm8uU2FAYW5hbG9nLmNvbT4NCj4gd3JvdGU6DQo+ID4gPiBGcm9tOiBBbmR5IFNo
ZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+ID4gPiBTZW50OiBXZWRuZXNk
YXksIEp1bmUgMjksIDIwMjIgMTI6MDAgUE0NCj4gPiA+IE9uIFdlZCwgSnVuIDI5LCAyMDIyIGF0
IDEwOjUwIEFNIEhlbm5lcmljaCwgTWljaGFlbA0KPiA+ID4gPE1pY2hhZWwuSGVubmVyaWNoQGFu
YWxvZy5jb20+IHdyb3RlOg0KPiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4gPiA+ID4gRnJvbTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5p
bnRlbC5jb20+DQo+ID4gPiA+ID4gU2VudDogRGllbnN0YWcsIDI4LiBKdW5pIDIwMjIgMjE6MzkN
Cj4gDQo+IC4uLg0KPiANCj4gPiA+ID4gPiBTb3J0IGhlYWRlciBpbmNsdXNpb24gYWxwaGFiZXRp
Y2FsbHkuDQo+ID4gPiA+DQo+ID4gPiA+IFRoYW5rcyBmb3IgdGhlIHBhdGNoZXMsIHRoZXkgbG9v
ayBnb29kLg0KPiA+ID4gPiBIb3dldmVyLCBOdW5vIGlzIGN1cnJlbnRseSB3b3JraW5nIG9uIGdl
dHRpbmcgdGhlIGlycWNoaXANCj4gc3VwcG9ydA0KPiA+ID4gaW50byB0aGUNCj4gPiA+ID4gYWRw
NTU4OCBpbnB1dCBkcml2ZXIuIEluIGhpcyBwYXRjaCBzZXJpZXMgdGhpcyBkcml2ZXIgaXMgZ29p
bmcgYXdheS4NCj4gPiA+ID4NCj4gPiA+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LQ0KPiA+ID4NCj4gaW5wdXQvWXBNQ2gxWGplKmpz
bnk4akBnb29nbGUuY29tL19fO0t3ISFBM05pOENTMHkyWSFfQ2IxdUFzDQo+ID4gPiBELQ0KPiA+
ID4NCj4gWjZpel96U0RmcmQ1VmE2ekxtZG94anYxdkxZV1FHSERPcVluaWFYVlZIbDNPdTJsT1VR
SWp3aFNODQo+ID4gPiBLdTJhWmtZck9iOHhNaTJjWnRmbXN2JA0KPiA+ID4NCj4gPiA+IFdoaWxl
IHRoYXQgd29yayBpcyBvbmdvaW5nLCBhbmQgbW9zdCBsaWtlbHkgd29uJ3QgbWFrZSB2NS4yMC1y
YzEsDQo+IGZvcg0KPiA+ID4gdGhlIHY1LjIwLXJjMSBJIHRoaW5rIG15IHBhdGNoZXMgYXJlIGdv
b2QgdG8gZ28gdG8gYXZvaWQgYSBiYWQgKG9yDQo+ID4gPiByYXRoZXIgdmVyeSBvbGQpIGV4YW1w
bGUgb24gaG93IHRvIGRvIEdQSU8gZHJpdmVycy4gV2hhdCBkbyB5b3UNCj4gPiA+IHRoaW5rPw0K
PiA+DQo+ID4gSnVzdCBhcyBub3RlLCBJZiBub3RoaW5nIHVuZXhwZWN0ZWQgaGFwcGVucywgSSdt
IHBsYW5uaW5nIGluIHNlbmRpbmcNCj4gdGhpcw0KPiA+IG91dCB0b2RheS4gSWYgeW91IHN0aWxs
IHRoaW5rIHRoaXMgbWFrZXMgc2Vuc2UsIGZpbmUgYnkgbWUuIEl0J3MgYSB2ZXJ5DQo+IG1pbmlt
YWwNCj4gPiBjaGFuZ2UgdGhhdCB3b24ndCBnaXZlIG11Y2ggcGFpbiB0byBkZWFsIHdpdGguLi4N
Cj4gDQo+IEFoLCBPa2F5LCBJIHdhcyB0aGlua2luZyBhYm91dCBhIHdlZWsgb3IgdHdvIGZyb20g
bm93LiBMZXQncyBzZWUgaG93DQo+IGl0IHdpbGwgZ28gYW5kIGxldCBMaW51cyBkZWNpZGUgaG93
IHRvIHByb2NlZWQuDQo+IA0KDQpZZWFoLCBpZiBpdCBkb2VzIG5vdCBoYXBwZW4gdG9kYXksIEkg
d2lsbCBvbmx5IGdldCBpbnRvIGl0IGFnYWluIG5leHQNCldlZG5lc2RheSAoc28gaW4gdGhpcyBj
YXNlLCBtaWdodCBtYWtlIHNlbnNlKS4NCg0KLSBOdW5vIFPDoQ0K
