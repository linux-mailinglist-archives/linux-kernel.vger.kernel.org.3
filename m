Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D5755FCE4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbiF2KKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiF2KKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:10:06 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADF621258;
        Wed, 29 Jun 2022 03:10:05 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25T8XhKK012964;
        Wed, 29 Jun 2022 06:10:01 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3gwy969y1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 06:10:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvDiV6Q8vU5b5arOqspW5iN9XvaDOBTuQh9PMhVAKQi0a4jaOKVM/Jq3nUUF5WnLe0LB8J+uHPxNDTTxDHfFev9jrUYMsp5/35C1ckVLfFXPkPdjdsfxAA6TIotlGzAfzyWppdQvpOmYeOxjgERG3Qs9y99FCRDebbpE4ImnmpBSasZx1V6zaVNz8PB8uDamE8uz54ieysHn8cmGO4oElG9FKXOMFUc2opWWFYEqPwOxwiRuMbU1I0Al50FQIDSEyciUZXQMCX7wRiH7smU2SNJtoSqeyo8eyaeg11hInXTbJ7/pF0FMsHtFvYZUtB2MgbRYy0RwflRKcBraYnOoow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nlrSfdv2bI6kGAMDCNR4qyefJzOLZiFBHtM/kxFLzg=;
 b=VSMVTxElQP4IbPJCDybiUcdJfg02o6CAotOLn0zvQrAbK6F4O0YEmINsQC1TqyYGvDHxAJ3HURd684obO/RI72GQ9+Hdm5sKBwDTsP0FM8CRcySWytVwHA1tNb+v0kFqCy1dahsnbqCIvDg8xjt7DhW87P1pjsnzTF5YWorTDGpM8m62h4GCmDf0nNEohSPKQHINSftOyIbjJSQOgstAxf/mhWDPsoNcj8X4B8vMAPu7QtrK+T5acplFTvo07y3+cN0vA9lw086qQv/nai9HCPxvs+7uGymuIfS9BJBVe15m3gVBksZZqqBKrbSuCJc9kjFiZdqcBvTr+iZ4WUlF3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nlrSfdv2bI6kGAMDCNR4qyefJzOLZiFBHtM/kxFLzg=;
 b=2UTYQX9glu50ljpQn5z0qV8WXLBynui+AwL3EXSDndiPpc4bPEaja9R9Tkq5pAuI4rNsuBSyscAm+pdHQldIJ7P3q3CRCHpGy2Qm3hA0i3Vg6gv7/0je+2A48zOixtCdAkbm0+HPLZvfuSM6bwfNmX7KV6CWIHRw1cp1ePjfY8Y=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by MW5PR03MB6981.namprd03.prod.outlook.com (2603:10b6:303:1a8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Wed, 29 Jun
 2022 10:09:58 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a4ee:b745:7e51:a3e0]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a4ee:b745:7e51:a3e0%6]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 10:09:58 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: RE: [PATCH v1 3/3] gpio: adp5588: sort header inclusion
 alphabetically
Thread-Topic: [PATCH v1 3/3] gpio: adp5588: sort header inclusion
 alphabetically
Thread-Index: AQHYiya7Gmk/GcosSkmil/FSbhBbb61mD/pwgAAXk4CAAAI8UA==
Date:   Wed, 29 Jun 2022 10:09:58 +0000
Message-ID: <PH0PR03MB67861277E1AE456A316DFFEB99BB9@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220628193906.36350-1-andriy.shevchenko@linux.intel.com>
 <20220628193906.36350-3-andriy.shevchenko@linux.intel.com>
 <SJ0PR03MB6253C3D92FFF37717D48C7618EBB9@SJ0PR03MB6253.namprd03.prod.outlook.com>
 <CAHp75VfR6XwW1HZDKoxhxs0i9R6s=uim1-dTtwJeXrA9AGWGQA@mail.gmail.com>
In-Reply-To: <CAHp75VfR6XwW1HZDKoxhxs0i9R6s=uim1-dTtwJeXrA9AGWGQA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE9XWTVZakEyWVRBdFpqYzVNeTB4TVdWakxUaGlaalV0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhEbG1PV0l3Tm1FeUxXWTNPVE10TVRGbFl5MDRZ?=
 =?utf-8?B?bVkxTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTWpFMk5p?=
 =?utf-8?B?SWdkRDBpTVRNek1EQTVOekE1T1RZeE56ZzRNVEkySWlCb1BTSk5jWE55TkhC?=
 =?utf-8?B?MVNUSjRZMDFKYWpkaVYxRlJRemhSYUdGQldVVTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVUmxUM1pPYUc5SmRsbEJWVkV5TW5ONlRVTndkV1ZTUkdKaGVr?=
 =?utf-8?B?MTNTMjAxTkVSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-ms-office365-filtering-correlation-id: 439e474a-d932-4afe-f3bd-08da59b785b4
x-ms-traffictypediagnostic: MW5PR03MB6981:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ex6yeCsr9//oQ2JiNeK8wzm4ZELZJEFwSwrL83ZcbYZysHhQrXcezkKKC88U6OKxkhFrOmTOcspp3Z+fNCmK7k6KZsKJ5e2hBbswOILe5uKl4Mh6yzVWE5SoXFTdlZp/MU5I2UWexUqZZWdxaiedZ9ozmRCYB18t5F8mBWN9jPPwLsk8k0nmAjVtaFo+J8H5PRwOIXDPZt+QBlgVM+2x3xMuo0wnkpUsdnr93t0eXOWHu8+zo0ObqBcAHdFpxFWQRvVbtWn3f/AyCPplwvQyB75Sq/IloMmaO/fruIZD8ZCzcCOqx0viBRog480ZOG3lzT9Jwk6YwOQ96jkidvgpVf2RGR2040cJN/B63D5ejxuFHsK2x/BLAuZI74sOyGsGLoWWDepr0ZqfGhsrLgzg3i6R3tQE6wRUZfW1tPEoUfMcbbuVyeSDnQMmUdGcGlwQe1x+SKGjm59As+pHP5JWME71xfTFX/MIDWJ0j+WE5yRiR2Q3y1ckx16dFs3Uir3nYg+dLmnyNQQU10yANl/3EzV/LKBHntDr62/glGKVfc83AcS8dzsA3ldDHNEke6Qe8tm08x+JNr8eKuKaoCsVrCBZVvYKOmgLHKNLhcnDc0DhqqudRr7kgs7FPHoCCSrOpjg0KWVF8lWem4XjlJFlCpvKxvYpcqNd1TVdNUCk27xdPz5ghi68jS32Uxdayv6mpcOVbsXOqYJnYnNW0QiRC2AnuocA8xmLECzrMep/DuGUK2UWsFkuzw2aApYAHE2HOPxHLJVaFC+D0rP+n/y+XR153sG0uXYUNSNnCQV+guTHPvZvWQEO2E1Bx86F0cEwuxCdutW1alQzKrNkUsCw0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(86362001)(41300700001)(6636002)(52536014)(53546011)(4326008)(38100700002)(9686003)(110136005)(478600001)(55016003)(26005)(38070700005)(71200400001)(2906002)(966005)(54906003)(66446008)(64756008)(66556008)(33656002)(6506007)(8936002)(316002)(7696005)(76116006)(66476007)(186003)(5660300002)(122000001)(8676002)(83380400001)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1Mxd1NlWGtyS285elNrSUNLeHNnZ0JvTmVzLzVpRUdxb1JrYmdvUlU5QVJ6?=
 =?utf-8?B?QUdwcytBd1hoR21JcWpJUUJrN1NQVWtpVTlnTXB6ZHpWcENwbFBzRUlrZEZX?=
 =?utf-8?B?YWpPM1J6eC9PZ1lWazdETS93bjZjWDJpNWhWd2VoUXNQSkVzbjB5NG1VZkgw?=
 =?utf-8?B?Q01hRkJTc1JZcS9oSjdsaVV5Mnl4MWtOamFwQU9WY21LM0FZNUdtUGFjeGYv?=
 =?utf-8?B?UzRrNytENkdCalBlY0tBeThMV1psLzllSkhtV091T3N5TzJmbGVjQ2lGdDM2?=
 =?utf-8?B?ZytqWXNrU1NsOXhURnhuOGwzL2EvMzFOWGpiYndYL2ZNT2NCcFRSWFZLdEFR?=
 =?utf-8?B?bnUvN2xXbzg1QXc4T3NMS254TnBVMVdONWtkNzJNMmRkT0Q3eW9rK0I5WEtJ?=
 =?utf-8?B?U2VNWm1YcUltclBMazBvckNQY2dWZnhEUEMxVnBkZjZXSFJZTTdjSHBkUTln?=
 =?utf-8?B?M0s5bDN4Y0IzT0ZRL0lVZ0ErZ3NHL0h6dVMvMXFVWS9MeEVpM2JGcWh5OWZa?=
 =?utf-8?B?SG0xbFcwSkZHazltWDMxQUh0VW9VZHN3d2xsdjI2S3pTcDdlVzI5b0wwVWdR?=
 =?utf-8?B?OW1aS2VVb3ZramZJdlZBeGtmUENSZTBxUjVpUmowRVF6ZzlHbmIwclluUHVa?=
 =?utf-8?B?bFlCdThaYnZpR01STmtMdUE4S3VQWkNrMjg3K0xnTHkrMHZmWkZwRXpxTUEy?=
 =?utf-8?B?WU9IRTl6cmNpTjFjdzkvLzVqQys5OCtwanUvVmlCUm10bHd2bTVzMi80Z0Y2?=
 =?utf-8?B?R01LV0lVWW1USTFTQ2xPZzZrQTU1Rml6VVllYmNqQ3BQUEd0QzBoQ0lDbDNk?=
 =?utf-8?B?ZElOM0swVm55cXRlK0gwSGgwd1lQMDllSGhMY1hOV2l3RTVqZHYwY0EzUkdH?=
 =?utf-8?B?MjVITURMRFArQ0lZOHdvc3BXTnVsRldlekI4M09PU3A1eWVZT1l0SWQwZEZ1?=
 =?utf-8?B?b1UySzRla2o4aG5DWGdYNER0L3BYWUJnbkw0a0FUdEg5VzZTaWM3VzhWUFVC?=
 =?utf-8?B?cnNsa1ZYd01kMUNRLzZ2QXh6T3F5WVRiRlRjQ0tzQmgvZnMvSExNYUptVTI3?=
 =?utf-8?B?RGkrZTRjMm91Q2czeHNseS9hcDBmOHkwV2M3UDB1Qi9sM0dkY1hOWFlxUDhJ?=
 =?utf-8?B?NWhxQ29EeUMxeTFjdGlqMDVLZkNqR3U2dUlidDZDR2hKbjRwOTQyR2NHeUVw?=
 =?utf-8?B?d05NckdRL3BOWUk4ZVcyL3d2TW0rbS9rNWFleklQUlpaOHQxMGQ1ZDV4TDNu?=
 =?utf-8?B?alh5dEtJNXVRVnBOQWg0OGF2RDZKU3hKSUlaTURqaEZ6QjhFRjFPYnVrRG9q?=
 =?utf-8?B?SzhUZTBLVWUwL2ptbExFNFExMzlyNGFXYVQrNU1PNzVtc0JXYW5KSlhUS3lT?=
 =?utf-8?B?anVhcXZrTWY4eXpxdVM0cUJ5ckxCQ3lqZTJuMmI0d1NYMHVWenFJcVI1WEgr?=
 =?utf-8?B?U1BEVnpsYXVITDRKdU1vR3pXYXg5RmFFZ01FK2VXc2dLYjZtUkE1cmovMEkv?=
 =?utf-8?B?MkJpd1gzdkhYT1ZsL0RSVmNOR3l1MnZsTkZKVURuZUxyUTRMZ0U2eWJ0ekFP?=
 =?utf-8?B?ekRSVUthSmRoMGhrV084R1k4V3pOd0ZOdE16bzJDeVBNR0xtd3NZUVd4VlB1?=
 =?utf-8?B?SlZZb2RkQ2U2eml6Sk9kbllmeFg4U011OTIrcEdISVFDNTNWOUExSXBOd3hN?=
 =?utf-8?B?SGZkOGM3S2dIMDJzNzI5cmFVSDBsZG9ZRWlVUGF2ZlRTbTNqdk5Oc3JIcCsx?=
 =?utf-8?B?VGpKMzFwbXdZci9kNklrR3FnWnliYm9BVzIwTG1LbDVPK3orOG9ZdTFWbWZY?=
 =?utf-8?B?bTduOFFTR1hPd2xySDdTUVBwcjZaYkZhbDZrcUk2VkpnNjNZL0tNQSs4TmFB?=
 =?utf-8?B?aXhMeXAzNCtYdjZIc2xwMUdBMkt4eGl6TEVQcjM3UUJ2NGIrb0VuQzd2WC9i?=
 =?utf-8?B?elVseTNkblpNd040b2M5cnpLczJpakxpaHl5K1pSYm9RNENISzV4eE5POGJu?=
 =?utf-8?B?SFJtOFdob21RWXkrRjJadFp0Qk5vSlpvTDVzWDY5SFRWdnMzZ3RlWlVaMnBq?=
 =?utf-8?B?TE5vT3RTd1RMTHc0ckZ3SzRmMVlaNWhlLzZGalBJdFc2NS92VUVKYldXOHZy?=
 =?utf-8?Q?ZsEoE9i3CH9spY6RYs9ajKqe5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 439e474a-d932-4afe-f3bd-08da59b785b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 10:09:58.2837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pszAAKrvnxmEEahypSMYscISSoxYWbZmE0RoUZ+4k/xpBrqTGymnjdANZ2iskXrUAWti/XM3VVAZQlxeWfgzwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6981
X-Proofpoint-GUID: gpASon8H_kgkEBJHa-fSiH0bck7T2NTb
X-Proofpoint-ORIG-GUID: gpASon8H_kgkEBJHa-fSiH0bck7T2NTb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-29_15,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=997 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206290035
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5keSwNCg0KPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFp
bC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAyOSwgMjAyMiAxMjowMCBQTQ0KPiBUbzog
SGVubmVyaWNoLCBNaWNoYWVsIDxNaWNoYWVsLkhlbm5lcmljaEBhbmFsb2cuY29tPg0KPiBDYzog
QW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+OyBsaW51
eC0NCj4gZ3Bpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IFNhLCBOdW5vDQo+IDxOdW5vLlNhQGFuYWxvZy5jb20+OyBMaW51cyBXYWxsZWlqIDxsaW51cy53
YWxsZWlqQGxpbmFyby5vcmc+Ow0KPiBCYXJ0b3N6IEdvbGFzemV3c2tpIDxicmdsQGJnZGV2LnBs
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDMvM10gZ3BpbzogYWRwNTU4ODogc29ydCBoZWFk
ZXIgaW5jbHVzaW9uDQo+IGFscGhhYmV0aWNhbGx5DQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBP
biBXZWQsIEp1biAyOSwgMjAyMiBhdCAxMDo1MCBBTSBIZW5uZXJpY2gsIE1pY2hhZWwNCj4gPE1p
Y2hhZWwuSGVubmVyaWNoQGFuYWxvZy5jb20+IHdyb3RlOg0KPiA+DQo+ID4NCj4gPg0KPiA+ID4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEFuZHkgU2hldmNoZW5rbyA8
YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPg0KPiA+ID4gU2VudDogRGllbnN0YWcs
IDI4LiBKdW5pIDIwMjIgMjE6MzkNCj4gPiA+IFRvOiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5z
aGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT47DQo+IGxpbnV4LQ0KPiA+ID4gZ3Bpb0B2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IENjOiBIZW5uZXJp
Y2gsIE1pY2hhZWwgPE1pY2hhZWwuSGVubmVyaWNoQGFuYWxvZy5jb20+OyBMaW51cw0KPiBXYWxs
ZWlqDQo+ID4gPiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPjsgQmFydG9zeiBHb2xhc3pld3Nr
aSA8YnJnbEBiZ2Rldi5wbD4NCj4gPiA+IFN1YmplY3Q6IFtQQVRDSCB2MSAzLzNdIGdwaW86IGFk
cDU1ODg6IHNvcnQgaGVhZGVyIGluY2x1c2lvbg0KPiBhbHBoYWJldGljYWxseQ0KPiA+ID4NCj4g
PiA+IFNvcnQgaGVhZGVyIGluY2x1c2lvbiBhbHBoYWJldGljYWxseS4NCj4gPg0KPiA+IFRoYW5r
cyBmb3IgdGhlIHBhdGNoZXMsIHRoZXkgbG9vayBnb29kLg0KPiA+IEhvd2V2ZXIsIE51bm8gaXMg
Y3VycmVudGx5IHdvcmtpbmcgb24gZ2V0dGluZyB0aGUgaXJxY2hpcCBzdXBwb3J0DQo+IGludG8g
dGhlDQo+ID4gYWRwNTU4OCBpbnB1dCBkcml2ZXIuIEluIGhpcyBwYXRjaCBzZXJpZXMgdGhpcyBk
cml2ZXIgaXMgZ29pbmcgYXdheS4NCj4gPg0KPiA+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMv
X19odHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC0NCj4gaW5wdXQvWXBNQ2gxWGplKmpzbnk4
akBnb29nbGUuY29tL19fO0t3ISFBM05pOENTMHkyWSFfQ2IxdUFzDQo+IEQtDQo+IFo2aXpfelNE
ZnJkNVZhNnpMbWRveGp2MXZMWVdRR0hET3FZbmlhWFZWSGwzT3UybE9VUUlqd2hTTg0KPiBLdTJh
WmtZck9iOHhNaTJjWnRmbXN2JA0KPiANCj4gV2hpbGUgdGhhdCB3b3JrIGlzIG9uZ29pbmcsIGFu
ZCBtb3N0IGxpa2VseSB3b24ndCBtYWtlIHY1LjIwLXJjMSwgZm9yDQo+IHRoZSB2NS4yMC1yYzEg
SSB0aGluayBteSBwYXRjaGVzIGFyZSBnb29kIHRvIGdvIHRvIGF2b2lkIGEgYmFkIChvcg0KPiBy
YXRoZXIgdmVyeSBvbGQpIGV4YW1wbGUgb24gaG93IHRvIGRvIEdQSU8gZHJpdmVycy4gV2hhdCBk
byB5b3UNCj4gdGhpbms/DQo+IA0KDQpKdXN0IGFzIG5vdGUsIElmIG5vdGhpbmcgdW5leHBlY3Rl
ZCBoYXBwZW5zLCBJJ20gcGxhbm5pbmcgaW4gc2VuZGluZyB0aGlzDQpvdXQgdG9kYXkuIElmIHlv
dSBzdGlsbCB0aGluayB0aGlzIG1ha2VzIHNlbnNlLCBmaW5lIGJ5IG1lLiBJdCdzIGEgdmVyeSBt
aW5pbWFsDQpjaGFuZ2UgdGhhdCB3b24ndCBnaXZlIG11Y2ggcGFpbiB0byBkZWFsIHdpdGguLi4N
Cg0KLSBOdW5vIFPDoQ0K
