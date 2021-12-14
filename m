Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05CF4746D8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbhLNPvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:51:25 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:22250 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232324AbhLNPvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:51:23 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BEBKU2d005916;
        Tue, 14 Dec 2021 10:51:03 -0500
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3cxtad8qxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 10:51:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kY5XjyvK1I2865Hzmfwcz+ijNAb+VYnAJYW0xe8ra0o4CSo5pDML57yWYOLqe5US9xcDd68e17/Yd2vetQ497X/PXifbDyBK9ubSVA5GynJ2Id+OPbbMPiDfPElLHgh4AfOSpvK3S7EnHwE+IKTkYIDZdFY0LL7qVE9mYBRyrmc52UyHl1gL0XkfsAp8HI7i8x+L+I6RbRUhHTJwoDRj8eJ/UkbUp2Pwq3/1y+NR0gnSOYvrNdzpj5BoBwvG0xJHI/7PyLeiJFxw7bndjer4EdArY2+oBhfEa+CPLIobYVMnrdCh3HACwnZmvYajtH1aSLXTKMsNcT24ge0nVTJcHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aL3ty266Po9y/usjVAdtlpZQb4EKQQD1+c+z7UjzEEU=;
 b=fMFCqctiEzpNE6XT3v0X5eZ2jPLaB7Lay6u0BIz+ZyaApBbbYGqhayJ2JElJgd3ov5niSFwh8PmXvFrS8ysIVwhJUZIzrGvaSarjZHKMby2o/kItbVu/vRM8W6WtJS9QjAr7oA6Y/IOAIPzfYEMrv6c3+EczwDYPxBO3jt0YTCN3RTkFvhOQSJUc/lqzrquIJBVOJV94Iweo2njpr1uLUC+l/sCDmLs16M+Q+k9jlNavTH3WMW0NWRUaYLxMGBirQt76L+AL5FHqsn0lEWqecON7Zl0c20qVksTtcOGaeHHwcIhEzDD/u2S8Wb7QDn8PGa9BqY9tuousEMIUgmDDtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aL3ty266Po9y/usjVAdtlpZQb4EKQQD1+c+z7UjzEEU=;
 b=kQQDm3PVJakn6c4dzmgTVjinsKAkhlg2vdyvJEVBOSw3iEbzxDeeDlAyUVCIhqN3gJ2zBiVNfXRq38JropanwATkiiDu9zm0YYbKDWDETpFSsZbiNMxxriWPgiEMVu81BnwrYyUMERcTgxcz1q0FuWMRR2Yjc0viHKS/ZJ2Dm+Q=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by PH0PR03MB6462.namprd03.prod.outlook.com (2603:10b6:510:a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 15:50:59 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::9cf:c1e3:ea42:f47e]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::9cf:c1e3:ea42:f47e%8]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 15:50:58 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav <demonsingur@gmail.com>
CC:     "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/2] Add ADXL367 driver
Thread-Topic: [PATCH v2 0/2] Add ADXL367 driver
Thread-Index: AQHX607zS+Y18pI3YkCYhfH3shQYV6wwVB2AgAHGLwA=
Date:   Tue, 14 Dec 2021 15:50:58 +0000
Message-ID: <PH0PR03MB6786F735806555204139F99599759@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20211207094337.59300-1-cosmin.tanislav@analog.com>
 <fbf1bc12-5013-0b09-a6f4-a602f0afbe70@metafoo.de>
In-Reply-To: <fbf1bc12-5013-0b09-a6f4-a602f0afbe70@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE0yUXpNVGxoTm1NdE5XTmxaQzB4TVdWakxUaGlZVEV0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhETmtNekU1WVRaa0xUVmpaV1F0TVRGbFl5MDRZ?=
 =?utf-8?B?bUV4TFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTWpneU5p?=
 =?utf-8?B?SWdkRDBpTVRNeU9ETTVOamN3TlRZd01EWTNOemMzSWlCb1BTSnRkMWhQVjJo?=
 =?utf-8?B?elNIQmlZelp6T0dsUVlVSTBRVVl5VVc1emJEZzlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVUkNSVTVFTHl0bVJGaEJVak0zYUVaRFJrbHZSbVZJWm5WRlZV?=
 =?utf-8?B?bFZhV2RXTkVSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-ms-office365-filtering-correlation-id: 7a6094f1-3233-49be-d43b-08d9bf1985d2
x-ms-traffictypediagnostic: PH0PR03MB6462:EE_
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-microsoft-antispam-prvs: <PH0PR03MB6462B94C96C7C87CE572482F99759@PH0PR03MB6462.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bZJ+Mqw6OxrEJ3Hsn8Mfr5L7NqyZJvSNWzQS+CZ72YjLcufMwczlaj0uOu/sTqt16Ftnou2AGjEDM9//JuHIyY6wqUxg2+y94D7pD6qVl7Ofrn79VTGOy11i0ZEtD2xuHNqTfuRhZYxjQUaf2eeC86rLrMK1sMgPH3tK+yabDf37vaxjZX1ObuCD995KCoGd6HQnOJPCFWsef8dlffJ8oYan/NUlBslq4VNPMDP3iykl7VBDu06ebNublTxqXqyg7bBkZp494CX+/jnrNNCYgkByNLlThP/kgz7MU+pXcsNGeWy89He3hxtJnRjaSjhNouHvham7z3j+Dr3Ux/7JBm9ZwJ5mdsNcZcg+RdyXdwM3gsODGnd6Yv7OMnzmqJhQbGtNhkjc+alHxdrfqRAbECFfXNeiAFjjux+Do4nevPhgBgGHHHyjMMU04t9gKALBGCXFPrnIMoMyPYUYGRrPGNRUTp4SSx8nSZnM6N7BzwhYdHE+V2seAc35lLqHbsBEBtoMWfa2Obo8i8OapzsqDX4UsgWcG1S+o4sIZO8f6zHfw028xxZf3PALaNnAJc2MCbe3NToQqo29ACB/jWbx1b7Cli4T+i3LVRYnOXp0s8rT46A07l9UulsYC7IMNDKPir5BB7j4khp8SHtvnZKCvFKkOWNWptJAFqetgP+eM241vuNT2x1X4ZSyTcLu0Tnki0rHL9CIgTye2WXgVFyknazAxa78e8yF8rbGFBtR4Z5fS0u+Kvh24EuIoGiifJK1IrMh8Uq8U9FHkh0gHZwTZ6S1X6FGUwwaVo2omkVed3o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(508600001)(86362001)(9686003)(4326008)(2906002)(66476007)(66946007)(66446008)(33656002)(64756008)(76116006)(52536014)(5660300002)(7696005)(38070700005)(66556008)(122000001)(110136005)(186003)(6506007)(71200400001)(8936002)(316002)(8676002)(55016003)(38100700002)(54906003)(53546011)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1dNenJaRmE0S2JVVlFWanl2dExvcnAvTHhLYk1qWGZYNmNCK29WU3ZyTGNj?=
 =?utf-8?B?K3JUQUdSNXkyam55TWIzY3hURVIwamJYaWdDK1JsMmdQcWoyVU9oWkJEb1dF?=
 =?utf-8?B?bUtmaDVQVlFLT1BKTXVCbklJN3loT09mY3h5eGhwbHpIZFgzakxRUDR3N0dk?=
 =?utf-8?B?YXJEbTVpeVdrdkYrbnZWSHF2TU94ZVl5RjVjZ1ZFWU1lTThEc0M4SXd1cmUy?=
 =?utf-8?B?VDBibGhaTlJwQlR0SFZXK0h3dWZiOU8xaGRrY0JxMEtlV0xuNnkvVExZdUt0?=
 =?utf-8?B?ZERSTFBwWlJhRjBSVlh0UnhIMzlkNjdTaGUrV3NiZ2FZNmN6dm9FRDRvWVNv?=
 =?utf-8?B?QVhORDFKeEM0ZXV5RlgwZnBiYnRwTDliZUhoZURObkFwOWNWWHdMdGRUUzVm?=
 =?utf-8?B?dEhiclFIMXJMZldnVm51dEp1YWFhSGlvNXZrbWJaVFRIdjdzU1JvT0I3djNX?=
 =?utf-8?B?dE1jUDlwaVZCa3J2NlJDRGcrVW1WMFRuMkl5Vksxc0haYVpmV3czQVA1ZFY4?=
 =?utf-8?B?R3llcncwS2d3aEdhTmVlYjRteWNySXpLWnlTWUJjQ3ZmWkpKK0R5R3NsYVU0?=
 =?utf-8?B?YWNDQWVDb291Qis0MXJUMGhrbEtqejRKaFRUUytvVDg5MDl4OWkxLzhSNEtM?=
 =?utf-8?B?SUtmNDcvWWI0bStLQ0FtNk9oK3ZQdkFFcEV0VzRnY1k4WDZKRldyTEdETStk?=
 =?utf-8?B?TXdLWlVMSXZld3YydGJiaEwySGIzdDVBWWNRSDlTYnVtaDhHSzBjd2ZQWFhK?=
 =?utf-8?B?UWNuSWZ3MU50ZldOejdQVC9aZFRhOHBPMjhpZjNXcjNjWnRVblJsZ2JuRXNJ?=
 =?utf-8?B?ZllSdE9qMUdteHZMaW5Ya3RLZFNXM1NxdE9aYlhvTmxlNVhjQk94aFZ6VTd5?=
 =?utf-8?B?bENGMFpoMHZHODMxelNWRWNpNUxBMkgxSk93dmVhdUJhSWs4QnZHWGtNdTZj?=
 =?utf-8?B?M0Y0VGIvWW5OMjRiWjlKa1NQL01maGE1dndTclNiQTlBSzVaNy9GK0JseXJO?=
 =?utf-8?B?YWNIKzF2RVdnMVlKdkxwNDNjNTBuUHZxdVhQVzJKTThpWE5nbDJ4eXNnVHl5?=
 =?utf-8?B?TUdzUjlkNFQ5Z1BNVXVHb2FXN21yWWoxc2FXU2hzQllNbG1kQitBTGttS2pK?=
 =?utf-8?B?WUV6TnlJNHJhbTJaSS9kOVQxSVdEVTI5VzRpeUU1Q2NvaHhaYmsvL0xLb2VF?=
 =?utf-8?B?UTBRY2w1RWFibUpJV0lGbVJrVmkralRUcHhYNklocExjQkdlUDFuR1NqdTFO?=
 =?utf-8?B?dlE0Mm1hSGw5ZFVMYVhSSDltejBtOEFhY2dZNGtQei9KOUkwYllLSFM3Z2gx?=
 =?utf-8?B?OGUrSFNLSW9NbGRMcTZoaU9hSHBuRWdEMXZDeWNjV08yVHpLM1pPT0VVQmYr?=
 =?utf-8?B?YTZZSC90YlZ1cXBvV0s5L245YnBwdDMrMDFOd01uUkYvdURBcE5mTFVzRzZ1?=
 =?utf-8?B?MjNBQVB4aGlZOE1KaFNXV2hGS0I2eGhFeDhLakVPeXZNaHZ5QnlJQkhUZDU5?=
 =?utf-8?B?MnNVcFNiRVZ6NTdQZlFmVHNXVHN0V1poMVNGemhHSW9oc1NINkJrQXRSc1JJ?=
 =?utf-8?B?VFpYQUFFRmdtZW50N0ZrVTlTMFZJMkVJWWVGZ21zSnZGSmNmOWV5USs3dy9L?=
 =?utf-8?B?cHltZkkwN3Z5dldLSHhIVnhvemRtU3dRN0VqbWIxOTlubkYySlkrSFFlWjdv?=
 =?utf-8?B?aU9FV2xlM0Y1cExKQUJHWDN4NmF1ZHlBdkwzbWJXZllQRWI4dnJLYUU0SElB?=
 =?utf-8?B?dnNyeEJqRERXenRxZVROYUJLMTF0ZEdEQlA4TllvQkMwUjR6TDMycGVHbm1u?=
 =?utf-8?B?ZkM3QnVYT3FUYmFZQjhQV0NKcWRVUFFaYVFkdDhpbVZqNk12cUJvU2l3dWto?=
 =?utf-8?B?ci8vLzNCc3FEcmhnN2NVdzJSVDF1LytPcGVUblhhS053OTg2WXU2YlF2S1dC?=
 =?utf-8?B?SlJqTlJqNjV4YXVVc3hkMXA1dTZPR3BwWEEwQU5jM2h6V0FlSEE4N2pXRnk2?=
 =?utf-8?B?MlY4RVY2ZEtwd0w2a1lXc2FSaHFNaXFSNU9HZStpQUwwUWl6eklqUmpYZUpt?=
 =?utf-8?B?cUZhSktRSXZwT21NQ253SW53cHRnNWdqY2hZYTVTazVDYlE4UUtINFpXZk8r?=
 =?utf-8?B?dEp2dXNpaHlBSi9Tcjkzb0dvUHhwVCtmSkdBWkZPbjBFcGRRZklhYXljYWJs?=
 =?utf-8?B?TGx3d2J5ODFvZ0Fwa2Z0UjRZazZ6TFlCN0FBS1o0Mkw3VmVlWFFadDJGSVVt?=
 =?utf-8?B?Ry9DdTRiaC9qV1B3UC9abXZUNEV3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6094f1-3233-49be-d43b-08d9bf1985d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 15:50:58.8191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CN7/sddWy0QUAQjiQPs/X0gxuwNyIxLcz9C7RyAnkiYjiIZQf+HUkajxOg65Jwgs+5RWZjYmPDPved8VPcWPJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6462
X-Proofpoint-ORIG-GUID: rCLaQDmJrsYWzJjub-CbNDGmIcCsHQAR
X-Proofpoint-GUID: rCLaQDmJrsYWzJjub-CbNDGmIcCsHQAR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-14_07,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 clxscore=1011 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112140090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT4NCj4gU2VudDogTW9u
ZGF5LCBEZWNlbWJlciAxMywgMjAyMSAxMjozNCBQTQ0KPiBUbzogQ29zbWluIFRhbmlzbGF2IDxk
ZW1vbnNpbmd1ckBnbWFpbC5jb20+DQo+IENjOiBUYW5pc2xhdiwgQ29zbWluIDxDb3NtaW4uVGFu
aXNsYXZAYW5hbG9nLmNvbT47IEhlbm5lcmljaCwNCj4gTWljaGFlbCA8TWljaGFlbC5IZW5uZXJp
Y2hAYW5hbG9nLmNvbT47IFJvYiBIZXJyaW5nDQo+IDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBsaW51
eC1paW9Admdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAvMl0g
QWRkIEFEWEwzNjcgZHJpdmVyDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiAxMi83LzIxIDEw
OjQzIEFNLCBDb3NtaW4gVGFuaXNsYXYgd3JvdGU6DQo+ID4gSSBoYXZlIG9uZSBxdWVzdGlvbiB0
aGF0IGlzIG5vdCBhY3R1YWxseSBzcGVjaWZpYyB0byB0aGlzIGRyaXZlciBidXQNCj4gd291bGQN
Cj4gPiBoZWxwIG1lIGNsZWFyIHVwIHNvbWUgaXNzdWVzLg0KPiA+DQo+ID4gSSB1c2VkIG11dGV4
X2xvY2sgYW5kIG11dGV4X3VubG9jayB3aGVuIGFjY2Vzc2luZyBhbnl0aGluZyBpbg0KPiBkcml2
ZXIncw0KPiA+IHN0YXRlIHRoYXQgY291bGQgcG90ZW50aWFsbHkgYmUgd3JpdHRlbiBieSBhbm90
aGVyIHByb2Nlc3MgaW4gcGFyYWxsZWwuDQo+ID4NCj4gPiBJIGhlYXJkIG1peGVkIG9waW5pb25z
IGFib3V0IHRoaXMuIFNvbWUgcGVvcGxlIHNhaWQgdGhhdCBpdCBpcyBub3QNCj4gPiBuZWNlc3Nh
cnkgdG8gbG9jayBldmVyeXdoZXJlIGJlY2F1c2UgbG9hZHMgYW5kIHN0b3JlcyBmb3IgZGF0YSB3
aXRoDQo+IHNpemUNCj4gPiBzbWFsbGVyIG9yIGVxdWFsIHRoYW4gcmVnaXN0ZXIgc2l6ZSB3b3Vs
ZCBiZSBkb25lIGluIG9uZSBzaW5nbGUNCj4gYXRvbWljDQo+ID4gaW5zdHJ1Y3Rpb24uDQo+ID4N
Cj4gPiBPbiB0aGUgb3RoZXIgaGFuZCwgSSBhbHNvIGhlYXJkIHRoYXQgdGhpcyBpcyBub3QgdHJ1
ZSB1bmxlc3MNCj4gV1JJVEVfT05DRQ0KPiA+IGFuZCBSRUFEX09OQ0UgaXMgdXNlZC4NCj4gPg0K
PiA+IEl0IGZlbHQgd2VpcmQgdXNpbmcgV1JJVEVfT05DRSBhbmQgUkVBRF9PTkNFIGluIHRoaXMg
ZHJpdmVyLCBzbyBJDQo+IGtlcHQNCj4gPiB1c2luZyBtdXRleGVzLg0KPiA+DQo+ID4gQ291bGQg
SSBnZXQgc29tZSBvcGluaW9ucyBvbiB0aGlzIG1hdHRlcj8NCj4gDQo+IFdoYXQgeW91IHdyb3Rl
IHN1bXMgaXQgdXAgdmVyeSB3ZWxsLiBSRUFEX09OQ0UvV1JJVEVfT05DRSBhcmUNCj4gcmVxdWly
ZWQNCj4gZm9yIGNvcnJlY3RuZXNzIHdoZW4gbm8gbG9jayBpcyB1c2VkLiBUaGUgY29tcGlsZXIg
aXMgYWxsb3dlZCB0byBkbyBhbGwNCj4gc29ydHMgb2Ygb3B0aW1pemF0aW9ucyB0aGF0IGNvdWxk
IGJyZWFrIG11bHRpLXRocmVhZGluZywgd2hlbg0KPiBSRUFEX09OQ0UvV1JJVEVfT05DRSBpcyBu
b3QgdXNlZC4gRS5nLg0KPiANCj4gaWYgKHgpDQo+ICDCoCBmb28tPmJhciA9IDEwOw0KPiBlbHNl
DQo+ICDCoCBmb28tPmJhciA9IDIwOw0KPiANCj4gQ291bGQgYmUgaW1wbGVtZW50ZWQgYXMNCj4g
DQo+IGZvby0+YmFyID0gMjA7DQo+IGlmICh4KQ0KPiAgwqAgZm9vLT5iYXIgPSAxMDsNCg0KVGhp
cyBleGFtcGxlIGNhbiBldmVuIGJlIG1vcmUgdHJpY2tpZXIgdGhhbiBzaW1wbGUge1dSSVRFfFJF
QUR9X09OQ0UNCihub3Qgc3VyZSB0aG91Z2gpIGFzIHdlIGhhdmUgYSBjb250cm9sIGRlcGVuZGVu
Y3kgYW5kIGNvbXBpbGVycyBub3QNCmFsd2F5cyByZXNwZWN0IHRoZW0gYXBwYXJlbnRseSBbYnV0
IHRoaXMgaXMgb3V0IG9mIHNjb3BlIDpEXS4uLg0KDQo+IEluIHRoZSBhYnNlbmNlIG9mIG11bHRp
LXRocmVhZGluZyB0aGUgcmVzdWx0IHdpbGwgYmUgdGhlIHNhbWUuIEJ1dCBpZg0KPiBhbm90aGVy
IHRocmVhZCByZWFkcyBmb28tPmJhciBqdXN0IGF0IHRoZSByaWdodCB0aW1lIGl0IHdpbGwgcmVh
ZCB0aGUNCj4gaW5jb3JyZWN0IDIwLg0KPiANCj4gRm9yIHNpbXBsZSB0aGluZ3MgbGlrZSBgZm9v
LT5iYXIgPSB4O2AgaXQgaXMgdW5saWtlbHkgdGhhdCB0aGUgY29tcGlsZXINCj4gd2lsbCBkbyBh
bnl0aGluZyBvdGhlciB0aGFuIHRoZSBzaW5nbGUgc3RvcmUuIEJ1dCBpdCBjb3VsZCBhbmQgdGhl
IGNvZGUNCj4gaXMgbm90IGNvcnJlY3Qgd2l0aG91dCB0aGUgV1JJVEVfT05DRS4NCg0KVHJ1ZSBh
bmQgdGhpbmdzIGxpa2UgbG9hZC9zdG9yZSB0ZWFyaW5nIHdlcmUgYWxyZWFkeSBzZWVuIGluIHRo
ZSB3aWxkDQphY2NvcmRpbmcgdG86DQoNCmh0dHBzOi8vbHduLm5ldC9BcnRpY2xlcy83OTMyNTMv
DQoNClNvbWUgdGltZSBhZ28gSSB3YXMgd29uZGVyaW5nIGlmIHRoaXMgY291bGQgc3RpbGwgYmUg
YW4gaXNzdWUgZm9yIHNpbmdsZQ0KYnl0ZSBzdG9yZXMgYW5kIGxvYWRzLiBNYXliZSBmb3IgdGhh
dCBjYXNlIGl0J3Mgbm90IGJ1dCBiZXR0ZXIgbm90IHRvDQphc3N1bWUgd2Uga25vdyB3aGF0ICB0
aGUgY29tcGlsZXIgd2lsbCBkby4gVGhlIG5leHQgYnVsbGV0IHN1bXMgdGhpbmdzDQpwcmV0dHkg
d2VsbCBhbmQgaXMgYSB2ZXJ5IG5pY2UgZ3VpZGVsaW5lIDopDQoNCmh0dHBzOi8vZWxpeGlyLmJv
b3RsaW4uY29tL2xpbnV4L2xhdGVzdC9zb3VyY2UvRG9jdW1lbnRhdGlvbi9tZW1vcnktYmFycmll
cnMudHh0I0wyNjkNCg0KLSBOdW5vIFPDoQ0K
