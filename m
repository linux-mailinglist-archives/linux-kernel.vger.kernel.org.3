Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2694FFA20
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbiDMP3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236487AbiDMP3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:29:44 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3425F241;
        Wed, 13 Apr 2022 08:27:21 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23DClojV013152;
        Wed, 13 Apr 2022 11:26:52 -0400
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2043.outbound.protection.outlook.com [104.47.56.43])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3fb7gdtmqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Apr 2022 11:26:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfFb0joXv2abJM/ClIyoxkufDqzf7KrdDN0jcyhuNAudV0Uc0Qj2wO3Mgb5T80R+eCtBM3zgiKBnL7H8VXvoFHIySAF31VV5PXZwftr0sk1NatRmpoH6H2iENVA0jQatM5N+/MQrg8v3RVTqlSWXaeAq91KXDiZX6nZ5dqbC8FbkiD4mSW7/DlT65QLtGLE1x29XUKaLCJ1/KibHPXh37IPac5ybo7dOJPqNY3w5z9Egplgu41lpoexlHyUrvIfNPmP138kBIez0Ku6S108ZI8P3+nlwpPEORv3dDxGhQQ8dcxxA1BkEzaeens9Mn3ipH3ohOJC7++2j4rBHuh58dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4YGuTF9d+5ar6PLZOsWA4T8n3lnArp/7lc2lbJnrKc=;
 b=COWO2NKnT9xagRN5d97Tbz85hqaatfSfbZtFS9Kx+J+YSaMJ1j4sZ+CscqbxNuhuHyNvzxg1DeFUWop6vKpd2gVXA+T9K+r4wyO6YCgJwQPqE+qigseFAKOP0uMiUQt6zoIMAh5vOSrVO0W9vyzaUGEPxLrlXSxnpjbCWmqiFtheIJbil9NgkjfTiJRRX4ZU4lYzQv0EbcC4YNDD01oKIb9pY5WADvrarQ53pGqW1CSFy/A9J2hRlA3xELRMUdIlwMWLtPZSHxSQp62rennbfK6r3dHKFqorjNEmJsnK4Ywe/2YFWgw/QSUUgCchChsPxE2zDAaKzZF1Pfmmwb7uaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4YGuTF9d+5ar6PLZOsWA4T8n3lnArp/7lc2lbJnrKc=;
 b=5ZbsrWezEFcAw8FMV/W8diNRf6Yu0HkOcGOFb+r799EBhzqmFWyOcP9N6k5kh75+8M7HLqEHRZW7L3HpupqxmonfCQ7GdS9CaJDyKBQfWICMaePqa4Dlnhvh2CN/mqgUoJ8pfyGGcsyVmPXKMjiEx1/2ZTDZZpLCXpVRbYpCenk=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by MWHPR03MB3022.namprd03.prod.outlook.com (2603:10b6:300:124::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Wed, 13 Apr
 2022 15:26:49 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae%9]) with mapi id 15.20.5164.020; Wed, 13 Apr 2022
 15:26:49 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: RE: [PATCH v1 2/3] iio: imu: adis16480: Use temporary variable for
 struct device
Thread-Topic: [PATCH v1 2/3] iio: imu: adis16480: Use temporary variable for
 struct device
Thread-Index: AQHYT0Sc9udh71n6TkeksICAyi/4+azt9wKA
Date:   Wed, 13 Apr 2022 15:26:48 +0000
Message-ID: <PH0PR03MB67864A0575386CA2296212B599EC9@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220413144124.72537-1-andriy.shevchenko@linux.intel.com>
 <20220413144124.72537-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220413144124.72537-2-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMjEzZjM2NWQtYmIzZS0xMWVjLThiZGQtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDIxM2YzNjVmLWJiM2UtMTFlYy04YmRkLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iODQ5IiB0PSIxMzI5NDMzNzIwNz?=
 =?iso-8859-1?Q?E4NzAyNTMiIGg9ImtML1VvZU81aUFkczUxNU5EVk80djRvdjJzND0iIGlk?=
 =?iso-8859-1?Q?PSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQU?=
 =?iso-8859-1?Q?VvQ0FBQXRINWJqU2svWUFZVHhjbGFCcTRhSGhQRnlWb0dyaG9jREFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFFQUFRQUJBQUFBVklFdm9RQUFBQUFBQUFBQUFBQUFBSjRB?=
 =?iso-8859-1?Q?QUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQm?=
 =?iso-8859-1?Q?xBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdr?=
 =?iso-8859-1?Q?QWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWk?=
 =?iso-8859-1?Q?FCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBB?=
 =?iso-8859-1?Q?SE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtBR2tBWHdC?=
 =?iso-8859-1?Q?ekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQWN3QmZBSF?=
 =?iso-8859-1?Q?FBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e743be14-1502-400b-872e-08da1d620724
x-ms-traffictypediagnostic: MWHPR03MB3022:EE_
x-microsoft-antispam-prvs: <MWHPR03MB302220134283EBD54430143D99EC9@MWHPR03MB3022.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sMQWgWbmIybBADsQkPvQFDrAFPZjOzeNzX0Y+2uhNFl4MqlBb/lP8rHQWUQnuTLzVHFPIVxSaPimseCbPoxpqB7xR4NgZDyBGmuAPGKefHqqAR7G14mtylFSXiIffzggOozmsjA4KvwUxleuYrPLe8rUGiR4/fNvhcmmyZv4iLZnfrh8VrCIZ56Ii47of+cNzy6AoeDWw6i391ZtBxOteyJ7LN2XUXChEOIwNqUqrruMpUO5KjRiNhxuXNY09SMSQHg/gdGUfJ20vK45B22Oeo043jecr61kyyvE0GmVI4k/U4+af0tIeRnWrmuGSAdOvHpnuA2Yw3EZgOdLgr1KhVhmZZzu5sBrKkHpcWVDiZqg4QByaRoXObqC+/HqNzrknlYPFuOyMscj981QKq7RgYC6hS+1EYsXOp4q0CzFASyyryf0CzWHO40hxRPmUOy1oa3sxL09aw3+3JGGxRJWGG9fHOz2FQ/+ZuNcaQpY7Z8TV8VCgXSMJdvFBMdshOD/x7ZPROVJqia/BphriT0u/fdbBnRx+hQ+/qO65lNTxmorZn+QyAubD38O1UXxn1ENtd50t3mZtq9Dr/7w+wFA5H6VmeWEAWj0Xe719H3fsiPFVdeAUPShcfBsEPMvKVq+Ke3hYeDcPlHVh7Q+IhRTk8+j+id0vHfOAm0ohQWiyJtnBlYoO1giMerPRJYG0Chrqw1TeUUx2iAMdAhcK0wIaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(110136005)(5660300002)(8936002)(66946007)(8676002)(52536014)(76116006)(66476007)(66556008)(186003)(33656002)(38070700005)(38100700002)(86362001)(83380400001)(54906003)(55016003)(508600001)(66446008)(64756008)(71200400001)(7696005)(6506007)(122000001)(4326008)(9686003)(2906002)(4744005)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?98Z1HIeAWLUKn46XlPx+Kk/qOU1Lg6UySfyxTNvowf1+A8XfQzNr0WHN9J?=
 =?iso-8859-1?Q?OfhhdvTtI1pF8m658JzFjT+/7t3VkBDiCv3d5iRXMo689JgmnommkDH95g?=
 =?iso-8859-1?Q?3SRaw65PohqibgcVnwkBh8dr8MhbebTFeMxmUDmTc9HbrDUC4aAw/vXTBI?=
 =?iso-8859-1?Q?tnqP8tqCwD7CRdcqcpnaDumtkwgRhjm+roO4+RgsVzr/QSMZpqAUEB35qN?=
 =?iso-8859-1?Q?tqD9RY5s/aXb/YcZJHS5uojOK9sSqgswikjQEo743NmloJjcfKy0yQsIy7?=
 =?iso-8859-1?Q?Q/tGM+68ElT6NOHlIzWw/MFgebvav6EO6U7mb2xvfoEdYgquIEUJ1wb9R/?=
 =?iso-8859-1?Q?8wyricH/o+cN05YWEgHzmIQm0z2Xhtf3Vg87g1kk/c9k7FpgUqxvM1pL1Q?=
 =?iso-8859-1?Q?zBKvzxLORaQNFjG8iQePYcpNDypYfUEzj2Be37HDrGwaVj+iY+AMNulvN7?=
 =?iso-8859-1?Q?xUYyrCcr0Z+sgvZJQsyIUu6AXYkFWgqjS0sSOpAIll9l8Z9LiL9jZuau22?=
 =?iso-8859-1?Q?fy/+XzXedW2GgKJ3Ec6i0rlI9KkU8Qd8kiTlhTPMM9gWXhtlfve2lw2Qk5?=
 =?iso-8859-1?Q?N5B6m3QCMXwDa3KvfeIIe4NwTU88bqIVChWGeG76LfidE9eIDvb+W9y/Uy?=
 =?iso-8859-1?Q?RTM4BoIcK0hLMNxlAJmCmQqF8Feh7wi43ykUsjTPtvEQUB3zCqzzcOHwT+?=
 =?iso-8859-1?Q?h+YFWa9+clNia6IRFXoHoc09FkjNfQ7ZNhXvWALRzSmJQj4URTmJ+S3WTN?=
 =?iso-8859-1?Q?FOKVy1WhQJu60cf2CUSq0s6Wt2oH0GvfBGIfb5Ue5Cio8j7rNWiP96mCfy?=
 =?iso-8859-1?Q?rYBXz8iYEif1qFIdvxUF758eQw4NKcYRqi5PIn95ACIu+hJCRecuR6tkAH?=
 =?iso-8859-1?Q?wnfEVeks4HlbPcqNsCysw1/1MmAs0+omiXOHBFHAyz4WrYRG4DuYLVoa6J?=
 =?iso-8859-1?Q?S6zZRpm7Q7l+wQkaUqyblVBv3tQ9QJforvoqicdYqXyV8keGQ15zWf44tS?=
 =?iso-8859-1?Q?BM1vaWoK6IWEVkECHMSVsHVGzNtetPPhKX4fAboKzZbIcLuAo7gZ6br1fB?=
 =?iso-8859-1?Q?9Cp/SUatHZlx5yLfYgc+9DQW8FeOtgX4zNcEEIgff2Y+LbDzE8AXSM+Xcx?=
 =?iso-8859-1?Q?L47n5p9FoIHtpLID+iX/x7EEQSY6S131Oa6TkluCKQ+PX3yVA652gLEKTR?=
 =?iso-8859-1?Q?R7MujInpk31WEaCQ0kDTlu4SAtLxZl/KRM78TK7P0wSgzVh0K0GUJpyT/9?=
 =?iso-8859-1?Q?rP53gEQ2drdpCND1IADVJPYl3/V8DyhMGWjHHQpV4OanVePCPgWL7fRKBD?=
 =?iso-8859-1?Q?18IXtgS72a0DURyOfyuCaaZz5gljrJuUOde0mfNadCrMTW5ZaOnxrUR2zz?=
 =?iso-8859-1?Q?wrK0nYARkvqoiENshXG+H5tiaamZC1koLPPRQ5jk5vJT1H6Xq+XyTMCfOf?=
 =?iso-8859-1?Q?K1QklKXuEMYYJ9LCvXNKMi1K3gC6X4wt/SS9rfLv9CQkZOnPwk/ZtcOlQj?=
 =?iso-8859-1?Q?mfZwZVSIOsWeT0tdHdbVgU0DgVAntj8YFu7ohh+j/AX6h2lWnPaaxJvCoG?=
 =?iso-8859-1?Q?W4xEhBz8s+k7RFiLb1YLf5yIuWVGGURiw1ckwRt/plih4vTmBptg8p9xYu?=
 =?iso-8859-1?Q?74q6Id62JJgVLfTm5zlYhjwq2DdozrU8WQY/NaC6dDVcIGnNfkrbHk7/Uj?=
 =?iso-8859-1?Q?wH7Nq3Odop47/OkPNw0KYPzHRAPjAhz0E1riqW0iwn/IJZ3hVK56nUylID?=
 =?iso-8859-1?Q?0+g6y3CwufRRwQigcg1DLcq3cVCfEdOgd9TuQNghttli2/xJcveiJAcVsA?=
 =?iso-8859-1?Q?UIAZpA3oWj/OKiX4QAapupgCcopBmuW+HGC9je9nI0/NbquI2w0/lcYVIC?=
 =?iso-8859-1?Q?Jc?=
x-ms-exchange-antispam-messagedata-1: BurKFaaaI4bc7Q==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e743be14-1502-400b-872e-08da1d620724
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 15:26:48.9087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wzr4CQJqH5Jx5BDXksZicWfnPOXgb2ucDUbBZYeFCm3RtVdi+6nkprYL/mmPfXJ4MVyofr0ZcbPynDfhDe+DXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3022
X-Proofpoint-GUID: JlKpVlAcJNO5rsJG2rPwNbDLbngiTKI8
X-Proofpoint-ORIG-GUID: JlKpVlAcJNO5rsJG2rPwNbDLbngiTKI8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-13_02,2022-04-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=638
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204130082
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Wednesday, April 13, 2022 4:41 PM
> To: Sa, Nuno <Nuno.Sa@analog.com>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; linux-iio@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Jonathan Cameron
> <jic23@kernel.org>
> Subject: [PATCH v1 2/3] iio: imu: adis16480: Use temporary variable for
> struct device
>=20
> [External]
>=20
> Use temporary variable for struct device to make code neater.
>=20
> Signed-off-by: Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>
> ---

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

