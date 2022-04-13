Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EEE4FFA73
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbiDMPlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbiDMPlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:41:25 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D242765791;
        Wed, 13 Apr 2022 08:39:04 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23DCm8EU013059;
        Wed, 13 Apr 2022 11:38:49 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3fb7w8cebm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Apr 2022 11:38:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9wzvFk7aVuCrfBzu7hPsd/O+Jd3Yy+3/h4v/6iV8ir9NYgjVBYFIHGlahWErCV4hFAGZPSuTXsjU9TrvIQKRItWxOvaIWMCmbd/MYHjTETVovS0c5YHY57VbOP9YazxuWwmrp7UPMjpk4tGXPrWiXOKmRtC6dTugbyVqQhnk8N2Vc0uRBF3kPLLsrHlky4ceYcm2KkPo4tCrQUj21Kid4oAi1ortNFBQ4aYY4VKvj59QFa1s20rdn9crr4r0jjRSSo50CAxKtFdaykwVTbsLNJ1Dz51/YqGPlZA1uWOgcVJxOcWRvYrTAwB8pBUvQqGf3/1ORpRPeq2W3+USgKkJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUTca4VO4bb+F+IcBAZ7TFC83CiLgCtxRuTj6XR4YB0=;
 b=UvB71jId9EmcOZdmff3Y4T1+nGL9RzNzj9GPuLGC3j9brkAl/PCsJNLz+0q/NwJEK6yz77lC8arZpuOk3Ow/Olp5uu133zvcCCnTQ/ZK7LUOjiNxtWSovGNs8Remj8w0JHhXMz1DG6gZuFimK/mfDpyJ4dwpmBt+aKAWPICvf7CPNpkyqEeMA/SZaN7HlikIsnkEoNPsmZUqQRm9vV/8XwX7Hx9aF0Zrs2G4/yIWaxhNQwYBeGvp4wsdwP6nfzra4hE6cBHO3B38KLJLjSM5CYb8HyezqH9E9n3y67omlBrrRCIsHWtu0irdWQSkGdGLvEHCQinjd8Nm+4T9krCDPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUTca4VO4bb+F+IcBAZ7TFC83CiLgCtxRuTj6XR4YB0=;
 b=Sq7rfrDX71KDmOw1t+AK4wP1OxZS6GozSmU0OZUgsjQsrQkhM8+kBX+3F2doRxsjBxs9DoO7oaf0gNxV3EGU930r77PztoQsxaoRTSuCfG+Vt1J5Ggs5F7coGOb3327HX/STfUnDyxTRGQBrzCJZqUWBMj70aasFO6ek/6GqcIU=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by BYAPR03MB3528.namprd03.prod.outlook.com (2603:10b6:a02:b4::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 15:38:47 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae%9]) with mapi id 15.20.5164.020; Wed, 13 Apr 2022
 15:38:47 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: RE: [PATCH v1 3/3] iio: imu: adis16480: Fix getting the optional
 clocks
Thread-Topic: [PATCH v1 3/3] iio: imu: adis16480: Fix getting the optional
 clocks
Thread-Index: AQHYT0SimMwpSDVIaEuZFYVh6Y0wNazt+DxA
Date:   Wed, 13 Apr 2022 15:38:47 +0000
Message-ID: <PH0PR03MB67865D24BB7546CAF805D7BE99EC9@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220413144124.72537-1-andriy.shevchenko@linux.intel.com>
 <20220413144124.72537-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220413144124.72537-3-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctY2NhMDJhODMtYmIzZi0xMWVjLThiZGQtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XGNjYTAyYTg0LWJiM2YtMTFlYy04YmRkLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMTQ2MSIgdD0iMTMyOTQzMzc5Mj?=
 =?iso-8859-1?Q?Q0MDU3NDc1IiBoPSJkbVlYUDRVTFVybkJvRURZdytZZmg4NVNPeFk9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUNEQXhXUFRFL1lBU0VwVU1IS3M4cFpJU2xRd2Nxenlsa0RBQUFB?=
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
x-ms-office365-filtering-correlation-id: 6b6ef58e-e096-4976-202f-08da1d63b331
x-ms-traffictypediagnostic: BYAPR03MB3528:EE_
x-microsoft-antispam-prvs: <BYAPR03MB352877A524F33255EAF216E999EC9@BYAPR03MB3528.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CS6Md/X2AKb0pPDeXQF7sHWUXGqyJ3VlXMpFwTn15JGBTw6Qtxg2IT21OkrMmsdgYlED3wIHsVCa0KzMoa/oLZ6d9qx70AZYrilcUGJ0y/z/5F4pbPI/v6QkxvnPnzgYAHT638ctRPXjX3sVHeyCFcEQ9vaGc7RLTgAFtaKOOUwvBDRCurcVYPiL+YBvjJfqVWInxVhKTuNNrAu101CR9WhPqyqjxaO+aURh5m1Oobo0YibrRu30xrB2VOiBG6dxW3RKgYrI5Z1jZKUEouvxBORhJ299Sjp33R61gM0oiJSLJb/7XJCfduKjurKEGQuBDbDldg1jfikB731jef6/p5CM+1OJ8sK/m7U5ggrDgOm90G3RbSILko9vMknBhDDishpFqynqxkgPlpekzpJlM198W1rdpqtF3/QxIvsMloaVqy2ReEQMFek3vAvtcf6i6e2UuDpw9K7+x1CJ/FiiEe412+FawRVfttohCjNi3orTXgbn9SXFf5yGAiGVCS0jdESCANzKpkyNnZzDlLw/bHkiSvEy3GcPmxoyFfC6fFCnL+cDOAh/tEqG6ATrrwTa2hN4I89s7LbT6bDtv9Nda5NO4CqbKfvB6BglRqk1RwM7EgtvravFK8AKT54SzwMY6YHiuUp9BFSaNIGr6GpZY4XWcKk02mKmJtR0l1LW2mxrMGkbukggj7ZnSHLXz2NTbWyChH/DqhjP9D67w20ArA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(9686003)(4326008)(71200400001)(316002)(86362001)(508600001)(7696005)(54906003)(6506007)(2906002)(33656002)(38070700005)(110136005)(53546011)(5660300002)(38100700002)(8676002)(66556008)(64756008)(66446008)(66476007)(76116006)(66946007)(83380400001)(8936002)(52536014)(55016003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3M3GXfQ6N3AB04RAk0gcKcepZGn8nErYAaY0DoDuxZO2xLJqgW+PVW9N/n?=
 =?iso-8859-1?Q?0qsQjwy1x9B6ngNlYbOeTLGZ4K+9rpZogGABdmoZwgVRvT+rSr98+ccUsg?=
 =?iso-8859-1?Q?eMy4Ox2nmX9WP9+EO/wn1Szyvl3X29CdulgTR0EdlM3ZPF9znyPDCWZTQx?=
 =?iso-8859-1?Q?aMuSyTU+e+vGfqN4LBD00+GD3MhHxsZxVVslIlMjk9OdD10GovcCQASQlV?=
 =?iso-8859-1?Q?n9GI5EwcNta5ZTVtv0haYb0E9nJWmPzcLOOFsHXV1ewXP2RHCTEqQhJn7y?=
 =?iso-8859-1?Q?4d9mRkBlOI1DlWI4ZCCT06RnpXzKNoo2NmGVSKJUHlfr1/HoOeHENbM3sv?=
 =?iso-8859-1?Q?uSSaM3thTc+qKx3oYUBWkXwAkR62R+XeRmAWqtLAAoii3SbWujEEDPpgCH?=
 =?iso-8859-1?Q?kWHp/8GkVslKbcd4B3rTxSQJsFEN9pEBqHeFRI0Tkzhn9YjdnygQxvFwX8?=
 =?iso-8859-1?Q?YuFg/bZOnE6FRXnrV0lNCThyr9524eWbgEr81eBenE0diLMJUcSYP1xigB?=
 =?iso-8859-1?Q?v1kYv7C/AUC6jf7M3jmToxu97E7xjKcC0bmLW/BmYLRY3Ci2fplsAO0gKK?=
 =?iso-8859-1?Q?UuDvCaziNKY9+Kg4LrjtTIMICG5TWU/h7vVQin1RZ0UUCEAZaLnEwNtX7F?=
 =?iso-8859-1?Q?SjaQai1CSQq5LAQo9M/OdgoFIyzLcjuxXAi6is6m7d05X6+LRMGjkGCX0B?=
 =?iso-8859-1?Q?553bSYjASatB3P5HBjzEQEHa/gk3IsA9RCLotMVOLYv1S0JOrdccDKszdx?=
 =?iso-8859-1?Q?0QYPU1HLIfk+W+H/Wzymz0Hg8xNJNE/0RU9eTs05DJEGPsFdZKeYw0/paj?=
 =?iso-8859-1?Q?q80HD5EtiHrpkXYZPDKYp4Xe2GOZRxuCvJx2ObWPlkvVA9bDd93XHWZl5d?=
 =?iso-8859-1?Q?+9umSK9jmSS93N/cAuSdZEophBFxbsEfGhCIqQreBEC0YUwERAXtu7vFd8?=
 =?iso-8859-1?Q?v5tapmyqRUlJA6kqmqCOK0XB8m1nVSh/yiX9gFO7W7TO08mjJDmKwITWn2?=
 =?iso-8859-1?Q?LQqoeX8JhTxfQV5eCWDtW+vyG9FR7dV3VQFsnNJx4N8wMuv8pRLOmwwXYX?=
 =?iso-8859-1?Q?p2QiT6n8BMPP5Ug6qPHZI2wIs3OeQTemwDhjlYYHjm6K1IkXaXxZbnTOKj?=
 =?iso-8859-1?Q?dPd3jwXTaLhPNyEyCm6I5DEQpgvvKeU2s2EEFQQxvNnKmW5W39/H6zD+66?=
 =?iso-8859-1?Q?HFTg36Akw4B9D7/f9p+GvXrsQwaiF2HU8G075DP0vujrBVz4KwrEXMti8S?=
 =?iso-8859-1?Q?mw3u5pFAdQA+lzs+eab668v3CoEAn0lWMwS5kI3fst6hdwrENsFz3+gdg6?=
 =?iso-8859-1?Q?FOg/x9SzdWyH83ymieGTniIrWj7bFF04Dnj8eqK8nm1GZ59i/7IoTTvoy1?=
 =?iso-8859-1?Q?XjuK9ljQiZhSo7xgJBvB+GA2aXQQyHmqRPOYLGHj18pOsMTCOhZCzr1UZ6?=
 =?iso-8859-1?Q?Ams3an9L6HqWEc5AMnd0gjiHmCi0CxbmA+90JqPihQxBhIMXn8V5LvrubV?=
 =?iso-8859-1?Q?hHySk3R0GkxWemO/SgkfTt2ZL1DbsJaNTA9W1gn93UeT0zvaKkyyzwqxE0?=
 =?iso-8859-1?Q?/UMVRUDsyb2BzxUlX6rqJFOo1u942q9tuR0oEtCmymvEUIrTnKWT3ve8X3?=
 =?iso-8859-1?Q?erwgu+4ndvbdNdPEzRP0+lBWMtRoTw1oOrOJ2BR1fcu9TAg7kzsaph+ziw?=
 =?iso-8859-1?Q?aJFlZ9PwwGS+yZDlBFDIKUL3+Uzu5rqUA5U1Cei0cX36GSFzFJxgLphTV6?=
 =?iso-8859-1?Q?0xTkz7m4Rx8NjL6GTEFoO2poaHiA1C8Fbc+OktzvWkYaXQLUW27aj9N7SN?=
 =?iso-8859-1?Q?2Bq5uVYHq73FBTLx7ZQa+SXzYaoR9pXIhAcIzj3V88UYd9mIcdg6ttGefR?=
 =?iso-8859-1?Q?hs?=
x-ms-exchange-antispam-messagedata-1: E1uXODJbTO27hw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b6ef58e-e096-4976-202f-08da1d63b331
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 15:38:47.1030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VPbDrPLC/c4XEiB14h53nPEZa9svYXcaolRd10Ta9rYKpuDdwPN1iBabmapCPvF+pNfGSmNdMLM4e9IPjUaf8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3528
X-Proofpoint-GUID: DYwIrhPtjBcKar1dbabsWKpjm5Zs50q2
X-Proofpoint-ORIG-GUID: DYwIrhPtjBcKar1dbabsWKpjm5Zs50q2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-13_02,2022-04-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 mlxlogscore=672 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204130083
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Wednesday, April 13, 2022 4:41 PM
> To: Sa, Nuno <Nuno.Sa@analog.com>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; linux-iio@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Jonathan Cameron
> <jic23@kernel.org>
> Subject: [PATCH v1 3/3] iio: imu: adis16480: Fix getting the optional
> clocks
>=20
> [External]
>=20
> The extended clocks are optional and may not be present for some
> SoCs
> supported by this driver. Nevertheless, in case the clock is provided
> but some error happens during its getting, that error should be
> handled
> properly. Use devm_clk_get_optional() API for that. Also report
> possible
> errors using dev_err_probe() to handle properly -EPROBE_DEFER
> error.
>=20
> Signed-off-by: Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>
> ---

This is a nice cleanup patch... But the subject might be a bit
misleading as it says "Fix". So I would expect a Fixes tag which
I'm not sure it's really worth it here. Yes, the code was pretty much
doing clk_get_optional() "by hand" but I think it was still functional.
So to me, this is more an improvement rather than a fix...

Anyways,

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

