Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8A94EED5C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 14:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345938AbiDAMoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 08:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiDAMoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 08:44:08 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7599B1C884F;
        Fri,  1 Apr 2022 05:42:17 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 231A548i004904;
        Fri, 1 Apr 2022 08:42:00 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3f5urv264u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 08:42:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGSZpNRj4RXECDgimu+es7uqIQIu2MzTwuJSJkliG6iMbryABmkZLoaquoWYi8kNLC0NevE35r4w6y0/66sKOCDy8RK7gYtUdthBIehm8LZhFAJKfvXzVt8l/ONKBVfQyZZ1j6lwF7TY1phNL3FMyOSLHH24eANe5X9/0stE1EFrcd3rRdG1wkkoAJu09B1p7HMoVrdq8FU/bjQa4tMNmzIIwsQLcos5bzF9pam7zLtTSmgVT3yy4iBkBLNi8BMMA+73unmw5Qne9bdgAcd/ay1KYMZgUlrM2mx2P7pwk2El84DawMn/+yCRRPBSu4HdkO24yve3vFbz4j7kN/Z2hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rd789an8mBiLyhsb48lr7XmOuPdCaURvshrh7Q5ArZw=;
 b=aww4JaywWfou6g23/D8UBffr3oLmt+ofYsaWBpweK0bhx/Wi0KkFjs+sFao/Fi1y8MZe8Y3nrgJNLPqKXhRabqfZEa2JxvhYeSugrMCoXNnmfQNW+whjvexPGFwIqA1Hfb8+UoHwIZlkxCTtX8rG3xTT80tmr4BReLcs/CfHLlee/aY4w15tGfs4ipepgBBYEmk5qlsgEqf5f/z0w3djjRv2nWoGgYM/BsA6G4ocCpsRcKEvqYbPX0fhDWYzF2DQL6N91unEpQ9V60gP14+xDZAFzuu/kyvei6E2voIqHmCsFZlUTmBYzMdvI05D1l1nIXQwPbJgGi/zNH+ZwFxs8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rd789an8mBiLyhsb48lr7XmOuPdCaURvshrh7Q5ArZw=;
 b=LJCAxeVm/BQwtjeFxb+F1iNm13BpzpwtlEKp9A1yTV94ZfnaKz/KfoEMFsde00JbLdFHLY5gMcXgYuf58fVP+a+BW+PyVnMr2bftyEUFsdvDWgi4r4/oz0Q/BZanneksKqp9xkxSS/X6P5jOZ22avch2Pfx4KlOVVlrZmVzXFSA=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by DM6PR03MB4361.namprd03.prod.outlook.com (2603:10b6:5:105::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.28; Fri, 1 Apr
 2022 12:41:58 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae%7]) with mapi id 15.20.5123.026; Fri, 1 Apr 2022
 12:41:58 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: RE: [PATCH 3/3] iio: sysfs-trigger: replace usage of found with
 dedicated list iterator variable
Thread-Topic: [PATCH 3/3] iio: sysfs-trigger: replace usage of found with
 dedicated list iterator variable
Thread-Index: AQHYRVQVvfcCkAayHki5B3/GCfYmDKzbAO5Q
Date:   Fri, 1 Apr 2022 12:41:58 +0000
Message-ID: <PH0PR03MB6786714E36293F44FC8F971899E09@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220331230632.957634-1-jakobkoschel@gmail.com>
 <20220331230632.957634-3-jakobkoschel@gmail.com>
In-Reply-To: <20220331230632.957634-3-jakobkoschel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMWQ0MjdlMDQtYjFiOS0xMWVjLThiZDUtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDFkNDI3ZTA2LWIxYjktMTFlYy04YmQ1LWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMTU4NyIgdD0iMTMyOTMyOTA1MT?=
 =?iso-8859-1?Q?Y5Nzg4NzQ1IiBoPSJpWk95czI2MFd4bWRxaFhlUnkwdU9vWG5xdGM9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUJKSDV2ZnhVWFlBVnkwVEp3a21JN2dYTFJNbkNTWWp1QURBQUFB?=
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
x-ms-office365-filtering-correlation-id: 89424d8a-42a8-4dc9-cfd8-08da13dd02f8
x-ms-traffictypediagnostic: DM6PR03MB4361:EE_
x-microsoft-antispam-prvs: <DM6PR03MB436164794B3B2AE986CF986E99E09@DM6PR03MB4361.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cufyk9Lmbzl7GCEFLNFLl5MRaILqqFmqoiAt5KBkP0ua5f5A5fcvl8S1eOGlxKD0O8fKsgHy125kHLsIALIXHcuOv+9FDU+QTP2H5O+BHaT9HRvuyhF1UBdoe67GvoYukA41FFm6n7H3vphJbgFUzsuN4HhB2rlEom77ZVHOzXCjc2FR5y6UUxlaXRU5LGJcUCqhYI2+Yv33rQn9f4LvBmZM+Y2yxZHu5wxm0qruKz5Gw+QNom9cKf8S1at77c0mzLQwvOwQ973mNyuHZVt2DYtgyuZdtnI7sOyZGE9WxbyYD/2yKGMtt2hzxW1FMa98sQp21HdmtrX4EVobnyhirotOo3TX7wvokwuw0aPmJ60h6vMx13nNuvJce1Mu/idvHYeW9hhDTSiMn64hmQtT5ofGXZ2DSTi8MXOeBNIS7Y8adDRpb22UPZm3WsRn2B5wrJWeBtTI75MpqBJ96Nv5/85AiRlQ5ryBUn2sCXG+b17bIWuXvWHvl1cKjpM3/GyHBEerCf9u0j54omX5j9aWLC/1ex1KmsNQQpENPoX/mFivLWIvD3t7BUS0cwFBDQ4EC2nNxthUdbdi6qEcHcythcnwI/+XjPa7KlTUpcelJKWJBH4LYMRYVCgKaRiu3Xs/D/xBWBsMDKk8FfYgYpDdfrFTrh/guIwSlVeZ3H7AnvdenW76rMTDY6m3gL0l/lE1o5skw0M/GNjNL9/Rbto5bJJNSj/7gmaQUIGAzRqcekkcw34PrYitnyfGZIMaNRp2/7DgH4k0QTbd++0fRWafEN4E7k0K4wSAq3krEDzfshw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(83380400001)(38070700005)(2906002)(71200400001)(8936002)(966005)(7416002)(5660300002)(55016003)(508600001)(52536014)(66946007)(86362001)(8676002)(4326008)(64756008)(66556008)(66476007)(316002)(186003)(76116006)(66446008)(53546011)(122000001)(54906003)(110136005)(6506007)(7696005)(9686003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?w0dL0IjPs5IOAUIko3hMCIE+IX6ysdBsjD1uO2FnyCWr7iF1snGx+TPV+L?=
 =?iso-8859-1?Q?Ou9JNjgl89HdKMptN3zfG3+KYk7tPwKSjrvC9jOCTs3YMkVKiHbd94BuVH?=
 =?iso-8859-1?Q?Ri4l0G9gGOQYAqK6PQ6UTRVCJKid7QoFBzxurzrs+Kd3BhK44yj3SuAzNL?=
 =?iso-8859-1?Q?ovcKxq5gUAt+sAaDaawtviXsSTfaiiS942pnPUlr+f9Hb4u1xge1+vV8lC?=
 =?iso-8859-1?Q?PocK6tkzZQZHJvpe1VuLJJ+OYnhw9Ej7X0NxFnNRv494C/+VvLEaRB95Wh?=
 =?iso-8859-1?Q?szA6X6HkwBBeiLZ8b6+42NPOWyMz+hEbsHoQ5ow7sNcIwVlQP1wwiNuoLH?=
 =?iso-8859-1?Q?HISLl2aAMl6nQj1Pw7LpLh/0j6t4oThP/VMZWoA3PTOMzDcqtp/qX7Ot6p?=
 =?iso-8859-1?Q?6NX4NYu/IbnuArl0MtAI384FYfPm9FVzuTDpTvY1ffZ5/3QAwtakj0LNXf?=
 =?iso-8859-1?Q?LzJikHfJ/bdN7TB6rSFp7zJ7UlL5fiIftjTZhb3tRrzzH4H5l2zLrzDwVp?=
 =?iso-8859-1?Q?cVgffgF8GmCey6fWp/962AlzRIPYkdS5W9TKuCLkw17P8RF9QNJ+LLtiHc?=
 =?iso-8859-1?Q?ODXtju+/rTynP+vF4WY065Ht7wRxCv/plUQiGoJkUpLXocKu80hNC21MES?=
 =?iso-8859-1?Q?v5OkpoUbcU+u0T9ojfqVjcmAsXpIAubtNcr5QqGesyJzo7p2vKdXYpA7sU?=
 =?iso-8859-1?Q?tWE1UVHUXxiIzgNwELzua22wOCpSkmA3YkOZCVXL67FjjzgH0FM4T6jkyL?=
 =?iso-8859-1?Q?dv0NEc7vNsqJkpHD7PaE9N54H1sCxcnkUprohLGfYQHroC+Ji9St0X91ro?=
 =?iso-8859-1?Q?jUCkALysM4CO3Zn8OU0Y8ybCAWSdWdh3v9Sl2ggJpdAhSzA3KSOB1S+rjU?=
 =?iso-8859-1?Q?QofesXefahv+km/X8tXXmoBpwlrP9BcB4mUevv4T/EHrk5COyKEpGVRDhS?=
 =?iso-8859-1?Q?1F6aQA7xkcCTIRByQILafVuB+XDqMGFECyFAEtL8er6CrPdD+/OyMJIHoM?=
 =?iso-8859-1?Q?Zyp1ulewwuXpb5hRqEnQ7DJRFDqI6Ajb1jxRouSxoeeqq066J6xMrAF3BP?=
 =?iso-8859-1?Q?bAyWwdJ0xAMEopz0bM6VOaWoWp/PM25G6NXTzOFvmKv8QHQvER8qqE7CMF?=
 =?iso-8859-1?Q?PMw/hN3SkDE4Ya7YhfSNCMigelBcx+SRfYkq+X2dbl5keQYcLrISThNTzH?=
 =?iso-8859-1?Q?skH6j0rS2T1vYq7/9gYm3yGjDLmArOHVp338kpdYFDbBxVhb5W8Qx66udw?=
 =?iso-8859-1?Q?xrvIe30KiFyWrnP2oG8dlyXdQGjD9ZYgmH4kx/dIOwps5G31JyfqagPJFw?=
 =?iso-8859-1?Q?7sOMZ+pgd3jwMwRLNH611duONMQfMGPTr81NV9j4P8BMAH5bzQTnzDk/pu?=
 =?iso-8859-1?Q?uDHg7w03BQkQP0OAyX/wK0Wpjk54IFHwRbyklva89BIjtY0PdmbyVmSzt7?=
 =?iso-8859-1?Q?z2pkWPl9f5V7ic2WPnbAOvBIRlhTNsFffwUSiljOkxc/pobut5wPc7FMVq?=
 =?iso-8859-1?Q?6e/qCagTuuba/UJLWPfKZfjzSjMoD7LH4NNX6NKgPtFuH605qJlbBnN4or?=
 =?iso-8859-1?Q?mmeUxeG7xTlcC0+x4qRE7H7zUCQYd5v05OghZ0m6W3GYL4rE1PPs6r4QBu?=
 =?iso-8859-1?Q?tAZ7NoqqS7CnGLTpMtKuLgnFIs9YZ6JS8k/qgMUMlqwtFkKiRKryD7hnkm?=
 =?iso-8859-1?Q?Ur70X6rKdRTAVgrL3qHMu0Xf+LgkPiNtJkmuPwPPgF9O1kfSEyx5D6qmmK?=
 =?iso-8859-1?Q?FQ4wRP4sDi+vPwqyNdPJ7qY0DDeyR14z/HevtnchjHU53u/JmJnPwXSIDi?=
 =?iso-8859-1?Q?GEjJ1P3dvBDzx8TDHpsexLIlljOtyQ9C47L1w46xgwkQHYcqHgVJJZHIF9?=
 =?iso-8859-1?Q?8h?=
x-ms-exchange-antispam-messagedata-1: mB4Kc8XR+k9Slg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89424d8a-42a8-4dc9-cfd8-08da13dd02f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 12:41:58.3813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2hXLQ+Zo1mVIQ7lbTJvw8ccHrZa2NO3ivqSjebJf4VX5g17KWeC0lajM9C9/+92HLqkb430TBWh/jVfhfSoB9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4361
X-Proofpoint-ORIG-GUID: ui7EnSDj1qgBb8DUHViBt8ZSlu5A_QS_
X-Proofpoint-GUID: ui7EnSDj1qgBb8DUHViBt8ZSlu5A_QS_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-01_04,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 suspectscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204010058
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jakob Koschel <jakobkoschel@gmail.com>
> Sent: Friday, April 1, 2022 1:07 AM
> To: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Dan Carpenter
> <dan.carpenter@oracle.com>; Jakob Koschel
> <jakobkoschel@gmail.com>; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org; Mike Rapoport <rppt@kernel.org>; Brian
> Johannesmeyer <bjohannesmeyer@gmail.com>; Cristiano Giuffrida
> <c.giuffrida@vu.nl>; Bos, H.J. <h.j.bos@vu.nl>
> Subject: [PATCH 3/3] iio: sysfs-trigger: replace usage of found with
> dedicated list iterator variable
>=20
> [External]
>=20
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
>=20
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
>=20
> This removes the need to use a found variable and simply checking if
> the variable was set, can determine if the break/goto was hit.
>=20
> Link: https://urldefense.com/v3/__https://lore.kernel.org/all/CAHk-
> =3DwgRr_D8CB-D9Kg-
> c=3DEHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/__;!!A3Ni8CS0y
> 2Y!q8mEciLiCAWjMGEwW9jHDD2DoeaKzrMwtUcRCNAZ0gW9DPBVtJk
> xR5FMPPCJNw$  [1]
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

