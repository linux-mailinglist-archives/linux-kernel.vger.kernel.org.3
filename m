Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379CA4FCF61
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 08:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348717AbiDLGX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 02:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiDLGXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 02:23:55 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8773526B;
        Mon, 11 Apr 2022 23:21:38 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23C65LLb029861;
        Tue, 12 Apr 2022 02:21:17 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3fb7gdgdxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 02:21:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQllj8w0T2ffc3iZhZtEilpR+mpgZiwBSyV7Xy6iiQPzX4+NXc6il7JhO/kbCE7YhwQGHV09t6RMeiqPyhHgs82tTYCd8SGGC4Mp9ZKWte1WJLvGF06qTBe+4DWU+5SW/Kzbne5kjttlDb/x6TT6t8twkcdTnc1q9PUQtrJkCoELsa51GNakYHGxo5J5pGweu+If7/j9IiSvxlVrSIBOgnofpTq9HqF4z20M/n1cNDoiUpNuSR6jZSHnP2wkCSZHTsZSBHsyH6gRJl7ohoCpUXYVLfp8DmDXX2SXrTgVlzNcveAi5RU11sp+bUc723ECsgu86vtUHNu0G9WDTcwi6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOhzHC/8pIlttovfeBVJuJxZ7eshWs31jDIxeOYf9H4=;
 b=ZenB7u/IBTxFd+AWyc4YFnLrSelQTsm9N+Jl+Xvw3jE6ssAg0pPE0Fz/JK98Z7R8vO3gCdvcz3+JqzQWt70MdC2kBaOy+xxEOd6Sjl5F8wu/cGTCjjp5tuB1oBA4ZOVz9F6NUppOvzQd25Amx5dK1kedxjK28GEzUCG2h4i7xmqkLhfPqH3zSRsfxvsAZLQRudstf2JGX8itEoMAExafaO/Ea9Tm+9zSd492AKA/q/VQGlQXltRL6OBzcWyxRcWpxksQrL1qRUAfbYuBxkaZBs4E22BMcu8/WznV7unouooCXzUDuxtWmyqs+JkEW+C+IB28GUQcFFAZq37Pktvb7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOhzHC/8pIlttovfeBVJuJxZ7eshWs31jDIxeOYf9H4=;
 b=6ABz9r8GLzrNAGlrNJvTxIogK5s7NwNRM6ufKYxqwFgGqMAaMLN8Tt/0yGlWDLpRqBZ/p73X6KHSB1+To0tSGzLbHjy/QCSLbPuyPzl+IM9bbjVGu1AZ/Mu+M6OsHv3yPkqWldh+vxau8ta3mFDJGONtBuBf1/p/LL92pQUNlnI=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by DM4PR03MB6191.namprd03.prod.outlook.com (2603:10b6:5:39b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 06:21:15 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae%9]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 06:21:15 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Miaoqian Lin <linmq006@gmail.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ivan Drobyshevskyi <drobyshevskyi@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: proximity: Fix return value check of
 wait_for_completion_timeout
Thread-Topic: [PATCH] iio: proximity: Fix return value check of
 wait_for_completion_timeout
Thread-Index: AQHYThl99NRYKGRf3UqRiCXMHbklwqzrzqNQ
Date:   Tue, 12 Apr 2022 06:21:15 +0000
Message-ID: <PH0PR03MB67863270EC86D06606F1E44E99ED9@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220412030022.20249-1-linmq006@gmail.com>
In-Reply-To: <20220412030022.20249-1-linmq006@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctYmZiZjY2YTItYmEyOC0xMWVjLThiZGMtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XGJmYmY2NmE0LWJhMjgtMTFlYy04YmRjLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMjEwMCIgdD0iMTMyOTQyMTgwNz?=
 =?iso-8859-1?Q?MwMjQ3OTE0IiBoPSJqc3lUa01aL0FkdEswb2xkYlpGK1Y0djVSRW89IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQURxbWhlQ05VN1lBU0NJRnlDSWk2UVZJSWdYSUlpTHBCVURBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQVZJRXZvUUFBQUFBQUFBQUFBQUFBQUo0?=
 =?iso-8859-1?Q?QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0?=
 =?iso-8859-1?Q?JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFH?=
 =?iso-8859-1?Q?a0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQV?=
 =?iso-8859-1?Q?pBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?iso-8859-1?Q?QUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3?=
 =?iso-8859-1?Q?QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQU?=
 =?iso-8859-1?Q?hRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c9c3b24-aa1d-42f3-dfd6-08da1c4ca601
x-ms-traffictypediagnostic: DM4PR03MB6191:EE_
x-microsoft-antispam-prvs: <DM4PR03MB619141B6DBE3D1B64C31BA7A99ED9@DM4PR03MB6191.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 23ySK/LX67qmROBgEIdj9tMl/3mNNglJgXVw6uDsicZ+HL0Ouusr0wyCLgRftV3eaZfP0YUAQyiXDTJF6KC9ciLut0gCj8yV29N8FKQQBH9PV74btmvhVXXir/i2OULRFyspmblKhx37zab+DnyOnRI9Sz26mVn0eqGJdUIqH5cC0AcDdWkGPBrh6FiZYwWt5Xu0P1LyXN3njKH4KBPxmYXSfju6HBgJimTpow+MZHfqAM8sjlQyL6XguK8w4QrP1x5wud2Tg5HQHdaPF7OVs8QzFJMkpk+hf6d6K6NKYp36YH8GErJ/kNg2I2rYkARTKw8nixfgZbKqDtaGeXpwk1Ejx8CSjTLn8jtHUp/hzl63IclNU3OwNh2ALve5ozK5ceIMP35GHo6ALGOV3q8l5CO9TwFJgIzMybWKDyOWXMQce5FxRtuJ4/cxpOuZ+iXr/rvOlHoOlFeiBs9E+1XjIith2E9yVhnCwWLfNBUwtqHPqVQzrUt52KOlfaFGGG4PbCfckpXnKYrfgPDlWqlh8op8EHoU033rSxc4rjXfJQ4k1BQx91rGWuAehgJLn0lpwUp2SzLaxiK8utNBfkZcbTlTsbkBJdmb2db90Qv1BIhm9Z3tebcBcKayKrcF3kcm3fiGTMkqZ5Yoy8g1/umrRLhuVtowDU/35oevBdXjZqGaWXiR5XI7WIonLXwr2UKDT9t31ISfW74+4VeNVbDBfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(64756008)(66556008)(66946007)(8676002)(66476007)(186003)(8936002)(52536014)(5660300002)(122000001)(2906002)(38070700005)(38100700002)(83380400001)(7696005)(6506007)(9686003)(76116006)(66446008)(53546011)(316002)(110136005)(71200400001)(508600001)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BY/r4IvchMce9E2lNE4Aq31ChcGv4vKtCokbyohGu+9vJOzLhvARskQhEP?=
 =?iso-8859-1?Q?gcmUuajFtGqk/yHOd68WmtlZm8T03vNvHGn0VdCFFbWQhVyPDLgfkU0ME7?=
 =?iso-8859-1?Q?NorYLAu1YpJwgIHxGvwjNGVdbXLD+qwCg4eBSIvIGPX2mwO5SS/IfOD7LA?=
 =?iso-8859-1?Q?SbFrNc72+jNvfi+LOR5Jz8BpXvo9acO1NfToB2HOEPFE8heu4QEw9ZLZ72?=
 =?iso-8859-1?Q?gRoeeBIG5K3xmeGr9Ei6uALV/+KtS3TawjIIUsfMS76dEQD7Eco5gHqYAz?=
 =?iso-8859-1?Q?0ZUxeqlMxPvNIF74CQvWPDmA52kB04+kIw6UR3NJP7Mmm4csIDcgia15GB?=
 =?iso-8859-1?Q?QMxc2xIuep/jK2gop22Z20nj7tAsxU7htU0lLTJdYWvJQfofwQzDQugoH8?=
 =?iso-8859-1?Q?HeEkMW4CFcbtNBPlk5LJfsPlXzV6JEVeBrV2dBQcb3omzg6MaN+F0PY2iA?=
 =?iso-8859-1?Q?Y7bVf1S5okEMBZzW1A1XXJbrf17amsSFnYW7yE9AVAUsAWIlO/SFkDPtNg?=
 =?iso-8859-1?Q?rwp3eikGUE9QuxhG34k3rUhSZFLFdHjX1cHQPwaHJvG3OOqV3JIxcqO+ZH?=
 =?iso-8859-1?Q?hkMvng4Edvz4h4lyADO9y+kg1SnuFb5XzQZcSUKfxhOTLH0QTj8Vh9Wwwf?=
 =?iso-8859-1?Q?M8urSCLIpbKiE+3F4pMkNuxKKwdJHwQu576eXDHFrlhy0nCGGH/9bA/8yd?=
 =?iso-8859-1?Q?JjK83PZxzr1IYwj+EbcAfnzrxd7bDqSODin5YNbbdWnAHdj6RD0V43OIFf?=
 =?iso-8859-1?Q?hN8CVfPbGSJVvRozlc3/MQ+KD4q8OJinIDI0b98rLVwotSND93zG2/fZsp?=
 =?iso-8859-1?Q?tZQn2PzW4NxKMVCDRQS8Kb/cGIef7xQ1epuXn+9F/0tPQuOq3AgSCSD35C?=
 =?iso-8859-1?Q?D+60NfUXsB3iahe08R3MPF8LHNyP6ivigvjBFz2VNByat5mz2ogyug7v8y?=
 =?iso-8859-1?Q?LRqK3DOh5YZOsO2RTHoazTVjFhOY75OMV/JAs8EAYV4uT0lHKRWjGMPVet?=
 =?iso-8859-1?Q?y9nM2isM5UsEbxf/qR8tG9mcbfFKi/S32BWhGmmt9T/1+jqS9KRIrA47gi?=
 =?iso-8859-1?Q?sCccE3i1d42221+W3hC6kdbF4waRJ0tVe8THA6OJyI5PXcd6RRf2cmMA4S?=
 =?iso-8859-1?Q?b9sugN+9Rt2jrTQ074iwx3hyNrjT+GiYeBJvB7T1+f1FUsaU2pzolVvU3O?=
 =?iso-8859-1?Q?UsOqmEYPI0E+LNl3qBTAOGOvOnqT/kFj3oRe5olPMyi5H0tBQyoSDILkBx?=
 =?iso-8859-1?Q?YKdhZs2c9C4NjeZQ2NpP8ijMbBiYPWd/I8KiJ22P5WAzIwten9yevUQf5a?=
 =?iso-8859-1?Q?nSnAWVKUj3BaPNKavkS4YJYimdcT5qXi9hkuOqvQQK64mXqnl/czEKUbb0?=
 =?iso-8859-1?Q?AitS4qGWbri1GjyH6uJCXYX57Xr2z4AFYpJuH3D7WcQIWvEdqH2ZaH4LRd?=
 =?iso-8859-1?Q?iDDRBKSQyiwuIuAnQQUUar23Btow5VwSchNb6tU4FVd/USkJ1sGrX9wvXE?=
 =?iso-8859-1?Q?9MWKVUPMAOvQwURhpxLML41E83icZovyDM69KY/O3R7ZE6oXa9CBmCR2su?=
 =?iso-8859-1?Q?6sUNUtMHDCX8561NWY6niCrQZCzaLu5lbvIURGvhu3hr3Lr6PyLVKISyvs?=
 =?iso-8859-1?Q?9+rZdWPBHkvifWiW22MLWPf3pMMwtJxSsZ6Ni75WqkdjCRpoLEFdPzV5SW?=
 =?iso-8859-1?Q?HAgI8qoblfiuZ448/R2EipvIq6opCxugXfnCb9gusDSJa0zgwGpF+OwcrL?=
 =?iso-8859-1?Q?4xJR8zBrJdEFGJgQz+0fdGyvSxuK6oj5KwkmtMT2Mi8wWbKW+3vajAyv/Z?=
 =?iso-8859-1?Q?iQg3D9/f9lv+Fz/Z5DhKIO9dUjw/AnlnwCRMMKnT2bE0DmNilb9C0mDvg/?=
 =?iso-8859-1?Q?qU?=
x-ms-exchange-antispam-messagedata-1: D5Ynl9oHE97u8A==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9c3b24-aa1d-42f3-dfd6-08da1c4ca601
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 06:21:15.3642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uLnBnrc2h8GEKZgETJ1quZ1BoLkkcqAGd95DW6exfUSdFBRJi5wikB/vqJDTi6fbpYPN+i0POWb+DQRewJh4Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6191
X-Proofpoint-GUID: 7xyUSTFM_rZjC9qdZq4IjJMPWE1HpVMr
X-Proofpoint-ORIG-GUID: 7xyUSTFM_rZjC9qdZq4IjJMPWE1HpVMr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-12_02,2022-04-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204120029
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Miaoqian Lin <linmq006@gmail.com>
> Sent: Tuesday, April 12, 2022 5:00 AM
> To: Song Qiang <songqiang1304521@gmail.com>; Jonathan Cameron
> <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>; Ivan
> Drobyshevskyi <drobyshevskyi@gmail.com>; linux-
> iio@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: linmq006@gmail.com
> Subject: [PATCH] iio: proximity: Fix return value check of
> wait_for_completion_timeout
>=20
> [External]
>=20
> wait_for_completion_timeout() returns unsigned long not int.
> It returns 0 if timed out, and positive if completed.
> The check for <=3D 0 is ambiguous and should be =3D=3D 0 here
> indicating timeout which is the only error case.
>=20
> Fixes: 3cef2e31b54b ("iio: proximity: vl53l0x: Add IRQ support")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

>  drivers/iio/proximity/vl53l0x-i2c.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/proximity/vl53l0x-i2c.c
> b/drivers/iio/proximity/vl53l0x-i2c.c
> index 661a79ea200d..a284b20529fb 100644
> --- a/drivers/iio/proximity/vl53l0x-i2c.c
> +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> @@ -104,6 +104,7 @@ static int vl53l0x_read_proximity(struct
> vl53l0x_data *data,
>  	u16 tries =3D 20;
>  	u8 buffer[12];
>  	int ret;
> +	unsigned long time_left;
>=20
>  	ret =3D i2c_smbus_write_byte_data(client,
> VL_REG_SYSRANGE_START, 1);
>  	if (ret < 0)
> @@ -112,10 +113,8 @@ static int vl53l0x_read_proximity(struct
> vl53l0x_data *data,
>  	if (data->client->irq) {
>  		reinit_completion(&data->completion);
>=20
> -		ret =3D wait_for_completion_timeout(&data-
> >completion, HZ/10);
> -		if (ret < 0)
> -			return ret;
> -		else if (ret =3D=3D 0)
> +		time_left =3D wait_for_completion_timeout(&data-
> >completion, HZ/10);
> +		if (time_left =3D=3D 0)
>  			return -ETIMEDOUT;
>=20
>  		vl53l0x_clear_irq(data);
> --
> 2.17.1

