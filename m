Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9466F50B7D6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447695AbiDVNF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbiDVNF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:05:56 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EC957B31;
        Fri, 22 Apr 2022 06:03:02 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23MAuCuA020263;
        Fri, 22 Apr 2022 09:02:48 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3fkh6rkh4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 09:02:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsLMHmcjvn0aRPBz3+uJyfTaXeo6/NWitmJbS/luTkLL4im3Idz5B4whUOchrKyPZGN9M0+9oDE42q0SkRcu7Fqnpe6ovEeIwMQL7R9/O9FNrVveD1ZsSRbCskKMyNFQJ28Sq+H80DsKV9p2tnjtBvfQ6tQMaTwaa+DOab1JpXJr9T/wc5qvkjNK/HHt7y4TyGxAzMeQ9nh2u8Uy/N+hRyrRzKEMTIhrojYc7xfc6V4vxiLxEU0MO1GZ2GfKzU1dnpeEFXsMlhfUsau1/SY8LS+CcN0RXMLw8wqaOS9JT8aoRJdia3/1J8Zfyj7q/rBs8HG+miGWaTtVF5XiSLuDKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfMob7md1vKpHh25BpmAlgcZIoxOJ0FwPq74Dm7ps0I=;
 b=R1zIFPKotBHUsZ2nOqjZLqeOqUZmR4TmNImukqyaiRHv/cMHQk2fID39Qn+cWWxtDNJwZ1S9DheYiG0abs2uc1wHoxYYOfVUAcOa5fjRxoUbovma2EDXtTFYI7kXRb6t5OSKkYeOGnTQNPfrwP7pJNsWvnQKoBSetuhDDbb21grSqPxXc8cx44HkCe2a9UNy4n9SYwEH7UKmN0a9Q5oIvWkzXEvQKkzajXT+zxTsAwiv5ZrcQJbmlGIcy0a5NekbUBE6tlUhVkMvmUDD/pGFyo70//V7KNBorDLrIlJYbJqpJueyFbBQZr81UKgYlpeMUx2QZtdlw0s9GSXhWUhXoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfMob7md1vKpHh25BpmAlgcZIoxOJ0FwPq74Dm7ps0I=;
 b=TVj4ByDH7q6SeVR4Ltq6RVYfpw1QRMVC+M9wAHjb2hibaSZN6+Ej/1HLggSuYMlShWZ7q+dsPWveG1wPxx/Dl11gjbf52H0fWMJyf3U7u3Yz8fb4qV285NEA6KHcYJrihEtNJnW/qrZ6JeWQTGiufZ8TlDLpnXUhY9HVKYCWTO4=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by MWHPR03MB2925.namprd03.prod.outlook.com (2603:10b6:300:11f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 13:02:45 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae%9]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 13:02:44 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH v1 1/3] iio: imu: adis16480: Make use of device properties
Thread-Topic: [PATCH v1 1/3] iio: imu: adis16480: Make use of device
 properties
Thread-Index: AQHYT0Scayim55zviU+m0GokmBcEa6zt9nCwgAAaiYCAAzbegIAKq+lg
Date:   Fri, 22 Apr 2022 13:02:44 +0000
Message-ID: <PH0PR03MB6786DE02A05CB290C43377F099F79@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220413144124.72537-1-andriy.shevchenko@linux.intel.com>
        <PH0PR03MB67867FD2A0043F5331D1C5E399EC9@PH0PR03MB6786.namprd03.prod.outlook.com>
        <YlcBTfVdtp7nUhjR@smile.fi.intel.com> <20220415190403.220b135d@jic23-huawei>
In-Reply-To: <20220415190403.220b135d@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE4yVmtNbUUwT0dJdFl6SXpZeTB4TVdWakxUaGlaVEl0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhEZGxaREpoTkRoa0xXTXlNMk10TVRGbFl5MDRZ?=
 =?utf-8?B?bVV5TFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTVRNMU5T?=
 =?utf-8?B?SWdkRDBpTVRNeU9UVXhNRFl4TmpNek56RXlNamszSWlCb1BTSndVRmRFVG0x?=
 =?utf-8?B?YWVsRjRjVWxxYVhWbVVtOTNSVGhyYTNwTk1EUTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVTndVVVJDUWxOV1lsbEJaa05PVUhGWU1reHRSMjA0U1RBcmNH?=
 =?utf-8?B?WlpkVmxoV1VSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkVZVUZSUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVlpKUlhadlVVRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
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
x-ms-office365-filtering-correlation-id: c405cea6-87e9-439a-3544-08da24606483
x-ms-traffictypediagnostic: MWHPR03MB2925:EE_
x-microsoft-antispam-prvs: <MWHPR03MB29253EA194BE44F8B8681CA899F79@MWHPR03MB2925.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6yXVSzqhFxVbQqdO4xWsvMhc5eBvKDh9ZGEdspUfeC8PII506uVC9ZwJPJrji1h9BrcSerFHg0WHKhkwUk0VcatXl9k225o7wuDUqsFEFodOK9C0szU+7HlbgrhBO+bFQI3T9YRPtUdM1cyUk+L4wCUX0I8lKC9h8voYlWRSvLNjAO9qlqu5WNeni1ygz6NRU35CVPvjvUIMKWePAycexsOIz6OwIHLoHcOzCQdxFsYaNFK8Wc6VRBmOmJP8Yr410RXuYZBYE6sGfCMndalCtct+F0LetKNxx17IbssYzNaFSD/e4uKhJ35TIDONPgpKHbjSOoQI1dAuot0e6hcm2Pqu6e8S4z91CC0XcfNKywj0TVOHMiUF0KC0iSFYzxMEZUzYDErPBTP9U79DJCR7SmIspie5fyfMZMh0piBkpL7rTFQChSTkNGEDIB/7vpkPqKLj0K959tzn2hPW3nX8pjk2/TkPCP3tOmkt2e4Zk2wb7RG5Jgp+3+3YkL5Foja8UR3JcpQqpJfME1yLk9oSlnqdJWXqYjzEGoYAPV8J59RUPr14agw4dhkw9ZAeHrst4tkugVfRh0wrqAS+5kSsAHWFhAz7pzR1NIfv0LDQEOYEks7B7bVju5BV0/tNrMp8HH/6lgFOzGH6HqePqiXYWdXAzk/DbfvOJKKp8GZhIfOgnLeEF3GiVw7HQEsdo7CaX/ZZotPdkT8WlEvetDz4ig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(107886003)(66946007)(66476007)(4744005)(66556008)(52536014)(110136005)(186003)(6506007)(8676002)(54906003)(71200400001)(86362001)(5660300002)(64756008)(4326008)(76116006)(66446008)(55016003)(38070700005)(122000001)(7696005)(38100700002)(2906002)(316002)(508600001)(83380400001)(53546011)(33656002)(9686003)(26005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uk5VWjZaNzQzK3VJQ2xDbGFSa2ZVSHg2dURkNVhYU3YvVlRzc2pWSUdHTVdI?=
 =?utf-8?B?bWhRb0pGUUJzYnYwRGt6bHJJSlJ0YUQ4eEZXbDBLSWRJaXdUQ21sK0YxR3A1?=
 =?utf-8?B?TkxKQUlrQnFCTU5XTUliUUpYNm90Q0dRZzZRaTB2eVVjck8xSlVTcW0wQ2x5?=
 =?utf-8?B?UUtyYUlySFV1WWhKQVlOaUxvN2dJNjhTS0R4c2xoczVQYWg1U1RYbVJXNkk1?=
 =?utf-8?B?MGk0clRTTktjcDJkNDJjeUl4ekNTSlVrOVExM1lFQ3ZXbDIxRHk3RmltNkxZ?=
 =?utf-8?B?WmN4S0ZyQU0xaXBCUkFoRjQyT0tNUGN6Y1V0NHhXa2wyMktSSkYyNGd0UWZT?=
 =?utf-8?B?Rk56VXNROEZiejZVOXdPUmlrWkRlUUN0L1ozaWVTVkZhckVNekFkcTJYMW56?=
 =?utf-8?B?OUg3VzNweU1iUHlVSFl2Ym82NmdCNGs2eVZzdnpSQzlxMTB6WDBLb2tqNjRi?=
 =?utf-8?B?UjBtU2Y1SFFUNWdya1BVcG1hcDVKSjBnZ2JOcmRNcFJ4SUs0S3lCdFU0aWI0?=
 =?utf-8?B?cWI4akZlUnRCTndaMURPalZiODZHek5DeGNJemFBemNMd3h1a3c1K0JjWGwv?=
 =?utf-8?B?TDR2VDBCVWxQYUZkbEtNZ1pOTFlNSHJVclBTQTFWUXdnMTJXdURDWXVVQXpq?=
 =?utf-8?B?VjB5OXBNMWNZaStSUm5VdTNpOHJLa0hRZXZqbS9aU0puSDRjUkdHdGFmcE1i?=
 =?utf-8?B?UmkrbG4wQkVZdmo5Y0FXUzVpZE52eGczZDVrZktydlpYenBXakJNVVMwZUVy?=
 =?utf-8?B?VG9FVlNtaHJVa2owNm1ZLy9xamNZYmxOUmFsejUxaEtPQXJZYmNlSzdlZUtk?=
 =?utf-8?B?MlRZL3VPVlhMSDU4UnhDaU96K1RyL2daQ2MwSWVBTkN6OUF6Sk0vdVlUblRP?=
 =?utf-8?B?dGl5Zm4rdTJ1THk0cld2YmJQbFd1ZDUyQTFCbFpoQUk0ZjhiUjcwbWVES1hn?=
 =?utf-8?B?UHpzdk54dWM4aHlXT2ZmbzlQZWJSMjlUbFdBK2FNWld5bExXanVyeUJsOVNT?=
 =?utf-8?B?aVptQ1ZhdUV3Q0dqNGZDaXltbGRrNUdoSnl0eTE1LytBcEdVSURtVnVEbUY5?=
 =?utf-8?B?c0dFL0J4L2VYa0J2RFRsR3piQnFjUEx2djROc2VJUTB5bGVnT2hRTTVMVUNz?=
 =?utf-8?B?a0dKTitETy92ODF1d1JOMGRTQkNKbGdDT2hzbzNXd2Nsc1cxRmN3NjhicWh6?=
 =?utf-8?B?RVlVUFlGdGw3VFpIQUMxOUJrSWsxSHN0RFZJckQ5c2piOWJKZTZ1MkFrZ2kv?=
 =?utf-8?B?RUtONG9BcU5URkRHTERNTzVyK1F4eGtWUVBuTmFDcXJRenlqRTc4aG1MbFA1?=
 =?utf-8?B?NHRFbFAwMXhWQmlycHFQbFVWeHg5MnZPTWtDNEpxdWNsOEo5VWRFRjkvcGRp?=
 =?utf-8?B?bDN2NzUxcE12S2YwMUo3T0VETzZ6eERlVmlXd1FtdXB1WFNrcEsrcmFLYXVG?=
 =?utf-8?B?L2JuRjR0Y25DaVJ3ZkRNd0dEcWFuMkl6bjNnU3lKQWVESGdJR2EvTHl6bXpo?=
 =?utf-8?B?bWV0cjVLdlI4VnR2em9mWWI5dCtZZGVHRklNdy96WVVtbjMrUDNiUUprRG1Q?=
 =?utf-8?B?SmR6QnprS0Y5RFR1ZzV4aUlLckpGbVdiUmgreVhHREo0TDBKa2R0VklNMHkx?=
 =?utf-8?B?M1l6VGE1d1lnbnFkYmY0M3pERTE4Z2VOcEVVckJOTndPeTFGcS9pazZxRjRT?=
 =?utf-8?B?eGF0bW4zY0tLcmFISnB6U1BtVlFQWGpaRjFFT0NkWGFONFN5Q3NLR1ltcjR0?=
 =?utf-8?B?ejlwQVhVeStQNSt4VGdiQWNlM0w1d1E3clQyVDRqemZKTlZhL2VuSFN6VlRj?=
 =?utf-8?B?NFdoMUJXOWpTeERjQ0VxSkxJY1NreEJmOXNHVy9lVExVb1prZEdDNkdha3dZ?=
 =?utf-8?B?c3YrNnpGTFFwZkYxQy8rYk9kQ1ZjVVB6cTNORlZyWlJGb21vbGFqOExKRnFG?=
 =?utf-8?B?QmowYnRaNEtNcTROd2Z3c3F4SXUzYWpQMmYyY1l2b1NiZXhpZFZuVFNkU0s4?=
 =?utf-8?B?MmJqVDNtN3pRZkRiZUtzZGRYTlB0MXZSSHBwcHN0b2Nja0NrQnlFOFV0dFNK?=
 =?utf-8?B?cGZ2MFc1TlNnNXJIS1JuYWZKWUJzM2ZIamNvZ2tNeEcxNVA4dk4xOTVqTVVy?=
 =?utf-8?B?ZFVJV2hGTUExNGFJQlJvWTJucldIUWNiQU5aT3ZIaHlWV1U2eDRxeGQxYWdN?=
 =?utf-8?B?SENXRVdoVlExZUhQY0dUZndBNFJwY3h5WjBwbU1lWjNlaXdvQldYVHFCYjUw?=
 =?utf-8?B?N09Sb2pwSTVhMHdmbWkrVk5LQzM0Qnd1OFpnZVhZTEozYTU0TkpKL2VBdHZ5?=
 =?utf-8?B?c2NaODRtY240ZlhXUThsT3N6VzJHNU55T3BLanhKRzc5VEJsVStGUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c405cea6-87e9-439a-3544-08da24606483
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 13:02:44.7814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DOBxMLMMRc0ytWqyNxULz9ntpG0tpRRslu6wKZ6ZaWRh8jqpiSkZFIj8mUN4DUlukTZNeCkaH1l7dBf1jvfs7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2925
X-Proofpoint-ORIG-GUID: OeXvtJSf5ur8HITBDBZJSQCGOvhmytRw
X-Proofpoint-GUID: OeXvtJSf5ur8HITBDBZJSQCGOvhmytRw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_03,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0 impostorscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204220057
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJv
biA8amljMjNAa2VybmVsLm9yZz4NCj4gU2VudDogRnJpZGF5LCBBcHJpbCAxNSwgMjAyMiA4OjA0
IFBNDQo+IFRvOiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVs
LmNvbT4NCj4gQ2M6IFNhLCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+OyBsaW51eC1paW9Admdl
ci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBMYXJzLVBldGVy
IENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT47DQo+IEhlbm5lcmljaCwgTWljaGFlbCA8TWljaGFl
bC5IZW5uZXJpY2hAYW5hbG9nLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAxLzNdIGlp
bzogaW11OiBhZGlzMTY0ODA6IE1ha2UgdXNlIG9mIGRldmljZQ0KPiBwcm9wZXJ0aWVzDQo+IA0K
PiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBXZWQsIDEzIEFwciAyMDIyIDE5OjU4OjUzICswMzAwDQo+
IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPiB3cm90
ZToNCj4gDQo+ID4gT24gV2VkLCBBcHIgMTMsIDIwMjIgYXQgMDM6MjU6NDlQTSArMDAwMCwgU2Es
IE51bm8gd3JvdGU6DQo+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+
IEZyb206IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29t
Pg0KPiA+ID4gPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDEzLCAyMDIyIDQ6NDEgUE0NCj4gPg0K
PiA+IC4uLg0KPiA+DQo+ID4gPiBZb3UgYmVhdCBtZSB0byBkbyB0aGlzLiBJIGFjdHVhbGx5IGhh
ZCBwbGFubmVkIHRvIGRvIHRoaXMgbmV4dCB3ZWVrDQo+ID4gPiBvbmNlIEkgc2F3IHdlIGFscmVh
ZHkgaGF2ZSBmd25vZGVfaXJxX2dldF9ieW5hbWUoKS4NCj4gQW55d2F5cy4uLg0KPiA+ID4NCj4g
PiA+IFJldmlld2VkLWJ5OiBOdW5vIFPDoSA8bnVuby5zYUBhbmFsb2cuY29tPg0KPiA+ID4NCj4g
PiA+IChJIHdpbGwgc3RpbGwgZ2l2ZSB0aGlzIGEgdGVzdCBuZXh0IHdlZWspDQo+ID4NCj4gPiBU
aGFua3MhDQo+ID4NCj4gSSdsbCB3YWl0IHRvIGFwcGx5IGl0IHVudGlsIHlvdSBjb25maXJtIGFs
bCB3YXMgZ29vZCAobWluZCB5b3UgSSBoYXZlbid0DQo+IHJlYWQgaXQgeWV0IDopDQo+IA0KDQpG
ZWxsIGZyZWUgdG8gYWRkDQoNClRlc3RlZC1ieTogTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNv
bT4NCg==
