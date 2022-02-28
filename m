Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEFC4C612C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiB1Cgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiB1Cgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:36:43 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7B96C917;
        Sun, 27 Feb 2022 18:36:05 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21RMwa6U029567;
        Mon, 28 Feb 2022 02:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=XBPLthZ08S7/23MJpAax8WwuwKJgyyB4G+XRQg+JtZU=;
 b=SP5S4tAF1uuwtUSuMjCxMKhlXQRI2qRr2SVBzDu1NiLju9N+WJBcWHaAPbNgNoZuKs/u
 dz8ZjJgDkCblDi2SWzUQNZ6U1N9AR9czg0vDgqqz6RyKt9WIqaMrD16rAnLwDXWpRVYz
 +bUcTrWX5DiD9V8LoNtKVOuKJOgXme9YlqOaAPI6feThF5F95fvcLwaIrPW4PmnFmZyV
 W2+L6BoqJl8hFgdjprR+OIPvPliEJEHO1/5gyfwGzqG/LW3MtAzBxWilphHpZ/JrV1tu
 M8WKad4iR6LKwmaqem7QbgPzqvtJG85Y3Hme/xfeIQv5aqbR9HTu957A9/eIXHBVWFvN jQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efbttavpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 02:36:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21S2VAQ3037355;
        Mon, 28 Feb 2022 02:35:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by aserp3030.oracle.com with ESMTP id 3efa8bweyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 02:35:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ToYrDhfxqfyGD9yqMYs/EzuHaFB9lL/mkLxWioB3CiYlUijRdTa42mphyZ+q/SOndMZ7JIIVprkxH7pdJy6PovGSaKVajYDs9tgDv1gQQ7doY81aqIJADDb/O5vS/MI2DY9lktp5RG1xSdAgNVRhpSVZW6TxGBAIGZ1JB5GVYodAkm96rQZSR2H/3faGh/hPCQeYISq1NPN8UelN9ehbmosk2kM/DDcTuWNijFQUPbSHhRH9llsoSq2nSbYc/DgBGGs9KVnEzaypra6Zlrl3hQ9Crl68Rjze0rdSU1lHFETHA5hlLr24I3vj3F2DZuuSDfcRumROPEy1cq82xvOXNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBPLthZ08S7/23MJpAax8WwuwKJgyyB4G+XRQg+JtZU=;
 b=Hc0PNlwgWePRXUIHI+tV6UfbrewEsL95BJ3UHq0Uu3NdHfhOn0ALv0xtgbFjf3+ldfb2+PPIuFRIvr1+5cb9fqVb9xEzkyF+ln7b3514j9FnsKT0kJobjZhdIecBOhavki1HaKOV8o9kjrdwYEQnfeMsVS+OZHhZldrJ62rxxcaDPDrxTmcQQffWM+37lRBPMcwvw22SUZ5WN1z0XeHatnMioMVtguhK5ZcfEXg3JPZd7VNYUHmH2fipSIidOoiZQzyX9t4KkToCD0cYMSJrmjON3H0n+Kv/JjhurgemLe+uyY9r6ZD+H+wddt1sV+lnnhvGHXLm/brXWpUPwtvjwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBPLthZ08S7/23MJpAax8WwuwKJgyyB4G+XRQg+JtZU=;
 b=XMvldlMJidBSCZEpqBdQo2ph0s8SJyGkhgUy+q57YMvI4aJMvzGk4MJp3obQ30mHlI7jVWuej7PlmV2EgNTL7U7n1rtxJmBh8f6aL2s09SPm73/vSeXfeWnqU4Jvn9qXoG51bxl3nUSpOnqU0nmAdx8pS5Pt+gsxcUpd9PRE4S4=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BYAPR10MB3717.namprd10.prod.outlook.com (2603:10b6:a03:11a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Mon, 28 Feb
 2022 02:35:58 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::180:b394:7d46:e1c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::180:b394:7d46:e1c0%6]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 02:35:57 +0000
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mac53c94: Stop using struct scsi_pointer
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1sfs37m64.fsf@ca-mkp.ca.oracle.com>
References: <3529a59873a7de8455a27af2528341afe5069adc.1645484982.git.fthain@linux-m68k.org>
Date:   Sun, 27 Feb 2022 21:35:55 -0500
In-Reply-To: <3529a59873a7de8455a27af2528341afe5069adc.1645484982.git.fthain@linux-m68k.org>
        (Finn Thain's message of "Tue, 22 Feb 2022 10:09:42 +1100")
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::26) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01fb821b-215e-4eae-5c91-08d9fa630d14
X-MS-TrafficTypeDiagnostic: BYAPR10MB3717:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3717A10EB88683B5301F45878E019@BYAPR10MB3717.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hJmegBxSE7bcfMS4/Sh+Ypggmpobf8rlqYqrJ14Tj0duTyz2U6n9gs9iYSXk83e4Uhxq6v02dbMv9WwdK0N9hJMYLm12maBoHDVdCVsHuSIc6gc0wtKoscMDWpHppsO0EjTUBx4XxptgLLNhWTdXUeSS8SqESj9fx11kIXxFpKIknckU9kPqcYP5O8WAOuithuXsgI5XSz1LuLqp8YFqeh4XuYjTCLzT0gK/FNA3+bDZwgQxWdYO9zw6H924dGQrfzWo74FCRxEmmeKD6qp75MqG+ZtHzg4ttsLN5nNN+9QlisiB8sDQxV/tFTZisxyjUOhI5qTKGRviOvqGhnlbztQfuiot9auPWzxp6YdbeJJK+ABbokOwZWDu27IBiHSbYvaiVPHIv7wBDrKNZCZGSq6MWz6nDAP+b6bjpQUt+YO/aqb9DZV5IDSGsMUWTvWSbNNosaY6Bae5/uz4UIxNkzKDdlKmqnij1j2ZstGBIsqJoUx5jNsTVny2WrBodnSGSJZME8+WaL8X4B78J6J+4X+lv9w0UNLXkAFE+NQF0bAJRxvzCH3mOQrx2jwDWlTmKyQdXihBXIJYrWM8OWvOZ/3AsGn3V7zxrw5mzzKOQbG4zlfin1YL7I3DdO/fxfUpoTtOyfialPl5sQieqTvfO1edPF8rmdmJyGPv+Bawbd7oUM4gZuzKnK59b4DoH33VGPBxMO9g3whMGsrYW0UhrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(36916002)(26005)(52116002)(6506007)(86362001)(508600001)(6486002)(186003)(66946007)(66476007)(66556008)(316002)(54906003)(6916009)(6512007)(38100700002)(2906002)(38350700002)(5660300002)(8936002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5+9ugNhguLsLvpDkK9lDlUw+YmCMFxZWPMKu27Nev569joDnCP0Ss1mhXfky?=
 =?us-ascii?Q?i2hm62w9h1/RtAYSjMHWAxYOGnICSKZT2Iulhszoq3n9NSzQjl5NugUsFXB0?=
 =?us-ascii?Q?SX0tY0BM8JsL9vq0JQQlQ5L0Bqqv4a1m/fPsSS9UNYXLGICBQ+Ky6lTeWuw9?=
 =?us-ascii?Q?fZWTcN0cR0X4dIPKnPtTMHQMQ/WqJDDtlacGe16WDi6L39SbrMubNM2IYF/e?=
 =?us-ascii?Q?7QxHmR2qxpu1/lADz6njCD9JYtVRYjwAvKdTDLEvQyREeaTR/fV0whLcYNvp?=
 =?us-ascii?Q?DM5w92CsgiMlEjYrmINZJyl1aReKxQbHi6eKKapW5xzE1WbKW//RiuJubizn?=
 =?us-ascii?Q?y4IXH1T/IssmwYnDa2GhZM3zfDnelSZQVspJMIjPtoWj5d1gR9fU+MRCav/p?=
 =?us-ascii?Q?Fks3Ls1gVUfkXqQwc2akayBL/deqvMrTybYi252ZG1xD2wwG3M8DXFusqlAM?=
 =?us-ascii?Q?BAwGdaXZXmYlyt21hUYDOh5u4pWf0LzhKVj3mE/a+vxw2robyjN7n2C1HPDp?=
 =?us-ascii?Q?NLqUBTbb8u50tBmx1uSoJdpkMVXfKISFlAcs37WoHvmfIFJDDIpQr+Tt72be?=
 =?us-ascii?Q?2Q0Y7N9qWB4Tp1Ia4V7B6uZWOXj33rMGoX6CQPj8WmgKND3XFd1nrn99MYOg?=
 =?us-ascii?Q?36ffy/G8DyPFcsXoNT3UuHkHqyg/X3zFFeJItFb+DIvJiAFcysAq4sG3uRG9?=
 =?us-ascii?Q?D1WbSM4jsobRPu6EM9pUr9+11NCv/RF0K+RB1/h2jtg9F176sd9Uvj1FbJbj?=
 =?us-ascii?Q?mP2QmUcBylhiK++u7QJ1FqO9AWQAtuoXe6m2wq1e5uhvqGenWlrqlgLf3GBY?=
 =?us-ascii?Q?QVmfGTuCmv/oX4IHyOjYnj2kCJrYCE0uwhwf454X6jDy13jg9AOvu/ukxGoZ?=
 =?us-ascii?Q?6a1J8FXc3/Il+MI3oRiXIkv2DgNBjpeUK+/JqtcmTl1BxUEeZ9SdrraXDDyo?=
 =?us-ascii?Q?9I778S6sXqBKU37BqUGNNTtJ7TKa/w0Z23DWBCe0lwievIMavYysGcAxEGFQ?=
 =?us-ascii?Q?iapRDLwUqcoZUikVX7OSasEIExkoYTl55O3dAybGy0Pfi4qcbl6bv46TPmh8?=
 =?us-ascii?Q?l3omISdBrR1NmflOnnuLBGjmMsZXpYaX4G2h6394ATiWFSFGpdZvppQS74BP?=
 =?us-ascii?Q?XNZhwCj+vuZ/QDwDmjGdyAy8o7RpVrTLTGt6T80wb1pM1rHrNi1iiySmh6R+?=
 =?us-ascii?Q?B2Ehb9i8sCzotAyUrLGr/DIqYE5xAAA19AyOy8zd1U7SuIYD1DDV0tzN2i3m?=
 =?us-ascii?Q?WlCLPSTfBuS95F3kW/e6UAjReRIyxj8/ReIjYpTnW241dG49EOOkrIxoWC0f?=
 =?us-ascii?Q?HUUIm6/hsaYTDVk/B9ZtK6T2wvnGglih+cFsaHZWUKhsEGC9lC9+KgOg8Pqg?=
 =?us-ascii?Q?iU/inynxX3G2dn3QSzRW/EGFYcwTcM+i5/HqOjVBfLG8wJMd6f5B9lEfF5Ch?=
 =?us-ascii?Q?d/4Ak2npqJOcjrYCYHzNWUNXmDlfMUDCQE0HT8/suBD6o41WnlHtXjxNVyXW?=
 =?us-ascii?Q?tgo+DKk81Z/SLl3Nkvh5AZavwaWwZLzM15jfbC6KxiY/O6nLhHOGg83ZPyQK?=
 =?us-ascii?Q?Npml79YbfG4GGH6Zc7V54SBMmfIotecAmrUK4sLjHqw1M/2OCCcXFfktrgmA?=
 =?us-ascii?Q?tTrlYHFnJWY222vQP1fSnGZRZWaKVAAqpIHOoebMiGrW9yuu8tXk7dzN88p2?=
 =?us-ascii?Q?tvvUcQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01fb821b-215e-4eae-5c91-08d9fa630d14
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 02:35:57.9031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zX4WCDy9BLOaF97yBSXm4F+t7g1MOmVcNxECQ4bW3q24uHZLAeUCcBACW1uZc7u6+Wp9WaGtYji5q5cD1mMRsGB3qLtk3/HvjExcYCUFi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3717
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10271 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=903
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202280013
X-Proofpoint-GUID: Gr2zPPP59BWH3ZbAzxCZTbz0eHX_8F0N
X-Proofpoint-ORIG-GUID: Gr2zPPP59BWH3ZbAzxCZTbz0eHX_8F0N
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Finn,

> This driver doesn't use SCp.ptr to save a SCSI command data pointer
> which means "scsi pointer" is a complete misnomer here. Only a few
> members of struct scsi_pointer are used and the rest waste memory.
> Avoid the "struct foo { struct bar; };" silliness.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
