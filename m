Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2127F4D930E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 04:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344665AbiCOD3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 23:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344276AbiCOD3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 23:29:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE0E1115E;
        Mon, 14 Mar 2022 20:28:20 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22F3HfYX008028;
        Tue, 15 Mar 2022 03:28:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=hU+WSS0qRSmdawqGuhgmJmFeIHrs6CB3Vj5aMA+ekTA=;
 b=X5XkcbLMORRWPeMda6GTH0jqmwLzhDDw/QYy1AT8Unh6s3EXraCn5+WVvXhoy2h32CPL
 A2aj68OzCVVAZDE3AxV1t5cB+8YrM7re7sSRVifFiGOx69tiRNUwNVKcen28ZhMLeEwd
 5AUZ6WKdj8JbMAR7lDLk2ZW1FxQHaBexk83lYa7FVL577Q2KOSZyeV03bHgNaHUR8haw
 WjhJIf91nfwaG6NPK759npRA0gPHXOoPY886a95WhCcV+7FA5QhD8tdsQFXtKKBdHkAq
 iDSj7jC+psOUCVTkkCs21baT2PKYHlCv0Eo0aCIJv2brqJq3QGkhzRS7NFQ+LwZ26L5g wA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5s6hxdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 03:28:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22F3FirJ178951;
        Tue, 15 Mar 2022 03:28:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by aserp3020.oracle.com with ESMTP id 3et64jkubu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 03:28:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHsmtNmNEqIjIHrn7cph0KqD276aQl5i8pM/64YhA3kV8eiCJaAOh4NUOpK2qhOmoGVFkzOqj+Lge/xe+grWi1pfwjmZ8HXvMaz8kds4mJiG+AjF0DRJz60HYo7wR838i63r2xFp27TGIdqVCleJZ8pSxYM9cTb+7VLj3VtL1fn7ExZ2dQFy51+i3VbTyEIKdjVfUgS1LkZ83xzzhjw7aIqxOYOyWMEHLrrlxNEwkSRKnOA3h+n2NbK+t7wMmLAWEMCyhtEXo5gAeDHVnJECprYlg/b9m8aCmjVipG83vKnWxq+biJq9tvT8mgiY5jxDcGkcdjlWI6C9hIU6oP7Hog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hU+WSS0qRSmdawqGuhgmJmFeIHrs6CB3Vj5aMA+ekTA=;
 b=MJX/xbmRSQbQ62hjZRTL0SQEpetr9QRuatg58gnYozV26KY8xaRLph9OCBf6Xi2ITuh0o0LbSIlo/8t0/zrTeLaPAxqbwyJXD3palGi1qS7z8OxxBwWGSO2cPmifKM0W6hPiRoFXVaAwkhtAmuXAh4epZ+FnVLbC+YY8NHxpslM0YhMVAJWEEVDBGKfA3/kHvAUBUJ9GXvLHHMmDkgmBvCrv19bMy8dqr00yqOF+oaG6hXsP7dzP0O4bBuh5+yPBMhCpvvOaWO8dQ1v8NJqUmpf0BwT26EpujZoTehwvAQB0E8R1upJfH+sbMjp0876hq8dxBDc2cZkcZYu/oyd/Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hU+WSS0qRSmdawqGuhgmJmFeIHrs6CB3Vj5aMA+ekTA=;
 b=vSvbqDMER0tRsBT7RmFEqB7z2YWhj6DgKsbTIkL36CptVr4sAQx/AMaEADf7rmgNetZjaiRVs4paU/4+15n9P9t8qdGQNWo/hPr1bmwjc4TFN2BN2lPreyMEJJGM84Gez2ZtBtEGSR/pebo426vV/v/7uT67n6ONusheo/g+ULI=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN6PR10MB1556.namprd10.prod.outlook.com (2603:10b6:404:3d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Tue, 15 Mar
 2022 03:28:14 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 03:28:14 +0000
To:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-hardening@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        PDL-MPT-FUSIONLINUX <MPT-FusionLinux.pdl@broadcom.com>
Subject: Re: [PATCH] scsi: mpt3sas: Convert to flexible arrays
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1a6drevyn.fsf@ca-mkp.ca.oracle.com>
References: <20220201223948.1455637-1-keescook@chromium.org>
        <164462189850.7606.6908949862618145181.b4-ty@oracle.com>
        <CAK=zhgpQcJkRKVNFHy6mDqV9hOyzFsV_uqOWur8UsNLRZy-VdA@mail.gmail.com>
        <yq1ee3blsqp.fsf@ca-mkp.ca.oracle.com>
        <CAK=zhgoiQ_ZeSO875DmLUrE2gGDRCUcPUdY9b9Yw+oftZ0=f1Q@mail.gmail.com>
Date:   Mon, 14 Mar 2022 23:28:11 -0400
In-Reply-To: <CAK=zhgoiQ_ZeSO875DmLUrE2gGDRCUcPUdY9b9Yw+oftZ0=f1Q@mail.gmail.com>
        (Sreekanth Reddy's message of "Wed, 9 Mar 2022 12:14:35 +0530")
Content-Type: text/plain
X-ClientProxiedBy: DM5PR22CA0012.namprd22.prod.outlook.com
 (2603:10b6:3:101::22) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e5c3f16-7d18-4dc8-9c6f-08da0633d6cb
X-MS-TrafficTypeDiagnostic: BN6PR10MB1556:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1556621D96CD9BE0916726C18E109@BN6PR10MB1556.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q9B0JLpYCnbeKegwjxhHd6bUTHsaN+t+EZFF1GxZXDmc69EtX2JIm6mVFq+WmrYMu2P761w0TJ5VO/qOac9PjGCLBY8QJmVV8cUJMpK4Jz70jupDxzRjE2mIDGl3wRq0+wUpMIv/ViVteRKB8yrPkNb+8DrDTIzGfyg1UDbo4K+nwcJTc/Z/Pul78Z8XtXMavdgQLt4R8XpW0qoC+GPabuxYsKX54QI6cbfJFDU40W067Eq4fOLerMMTt8kgmVv+Vm54uKT4eRAe1rmBldDpAOK1jaV7hW7C+B1h+v6VrCF2C8S02hGh/ziDO4DzeYV/+feGWKIXcvgNwM245KI+ylV/brbVl05FSLjuDD92OdQupZvnTyOFXfNSXe2sg/21P4DJxKNJxGf391XWdQU76bmsOmQWxjtm3PDcW9oPYPBRrJAb5qQhxaO9fZUdiMAYbwG5shYOpSL8w5qwzldyfvxsWAWuPdBTmXGJwWeQ6EqktMQ9Ae+/nCxwsMRNTjKpz7NPOtEtA++mSjpQ1HK3krWGFA1qWLu0pDyuaWsQv+cHnCG1qVyvUtAiy0bPgdLcz5BiFQoNUoTWYyAyl0owEb7bvUEQ4OU/XN2A5+Mle53WV+V7ar9mbLNAjL4YOTad2NHjn72vnVVBjDJOan2B09Z0o041gl6ZnNdnUYKiUo64mWksHYedqjT+alu7bf82HvXxOPJUduMKWD9hD18Fl9cYXNfe0ukwFThklMwBwW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(558084003)(6506007)(36916002)(38100700002)(38350700002)(52116002)(8936002)(5660300002)(6666004)(6512007)(86362001)(26005)(186003)(316002)(66556008)(66476007)(6916009)(54906003)(66946007)(6486002)(8676002)(4326008)(508600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZEWvs7qh3JvqX8zIwVvkFUmI78I00IxeU11sCVMu+C0J/egRoK44pLqTqLaf?=
 =?us-ascii?Q?IV3uZiacZz/GLJ0DCJnGzLyuVXmdRCYZb6hy45owEp3PvLBx4KUG9RiCLH7c?=
 =?us-ascii?Q?2Ben8ciitC7LzS+7K2X0ocwoscRiKCoa0QsDc847pmLjSob2MeqR+wRy6oYA?=
 =?us-ascii?Q?YdtAsxBq6FmTBGVu32PJRygF8jJ85aTdutlt7GHr0Y0fmGJ+4B3SX+V0nppk?=
 =?us-ascii?Q?1WH+SjI9L85cqqLFmMB51lHZGmOd0ZRl6F8k5Rn5zTkEMWFztvIrNyzDBq0/?=
 =?us-ascii?Q?XeNINCN6ZxEV3IiLxgSEL1zewAdY+DqtqQYcjWXY2WLtaBLup8Nc6p0fsYq+?=
 =?us-ascii?Q?YdD4SSz0dw8VprySlXuVpTSzoCrerV9+Z696Fb0D9pFMmzbDYfUicJxAWtjZ?=
 =?us-ascii?Q?6h/4xHqg7fVpWNgXZ2Zl1vAryr6xa8WBY6wNpRhC4lDdy9EKBoESHl6J2krG?=
 =?us-ascii?Q?lSxw105CDlMGH6EgNtI4HbEANLs8ncCoP0oA5xykNq1DkLa+jFPdwZAqGegv?=
 =?us-ascii?Q?IQqSskjnl7gQH4jaSUViIdt7TN3Fto/2HjtDhueAUB+4/wEtOVY2EQODPMG5?=
 =?us-ascii?Q?D2eU3tdGs/x2QAKW8NRVy4toMEb8WnrYY0Asi67WJ595GlunO5oxS1qoROXW?=
 =?us-ascii?Q?RGtFciL/9UPMsdi9lnUReW+DuHxhGTC5FQM9hdjpTBMJgpGxbWTpe4piFb7w?=
 =?us-ascii?Q?aqCNtbNteKu+O3uZSE8YZ7CpKpLFu22oc2DQcWOVHUG3es14BNEQR5pibEK/?=
 =?us-ascii?Q?iyAGw16q21dDI743gCCYlcalt6z+wpSmBAdJ2jKptFd44lDb+MHBk2p2v173?=
 =?us-ascii?Q?MU0feFt/yv/TYpN2avGosFmLlS662Vm+xmIvm63GQ3tyHBoGpJQdmUAGxTce?=
 =?us-ascii?Q?/XpYbVebBe8EFJ83WuROupqgIGfy6E4ypJc8xXMoKGYGzedsANeDT3RGo9UZ?=
 =?us-ascii?Q?Sd9/HLqoXRl7T5voSfDZGzfbRbHJar8xusXWDdxH+w6gNZQNB5K/BUIkFhCz?=
 =?us-ascii?Q?7HvpnQl1PtjLN0MAK+oHbhM6GCVgQqXxCvN0CTZjBxTrfQqvRs8STWle1FB/?=
 =?us-ascii?Q?8HoP02dPbweuHQ7KoCv1tTALA3+MJs+BBvjzvRBXwiA/6P/mj/fD/JQ6k+jB?=
 =?us-ascii?Q?8orlvaHs/6ZGx0N6LrnIGH0c7DsbAqQYeLJQ46TPcesGmHhxt+r53k4Z/F3m?=
 =?us-ascii?Q?hWcEBz7z9k1mp5zHF7rvpKYvAdGiwcD8jPFC1nv1lyFahXlCOmSZAHe7zOpk?=
 =?us-ascii?Q?Va93Yqc21RJ7rX28AQWrSjSaQR4G9cu9+3zh2Wxp8TfCRJgdpH7wzbh94qaO?=
 =?us-ascii?Q?JiOx7QdjJcjZAZuKArIklRPwHnyhZYQFERKJfN8p4c7TXAr++HutEQGGSego?=
 =?us-ascii?Q?QYaxwTn3CudLLaxy1iWb+W2EaN2m9vKzEDsyb59PBFyB2lk3k2FuRmZhywzp?=
 =?us-ascii?Q?q5EpfrkGnLkQxCZzPFRzp3OyLeoqjBRRjEfskInBCFASy19Blxenqg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5c3f16-7d18-4dc8-9c6f-08da0633d6cb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 03:28:14.4363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSzHpTPSY08jiDXGPSx1NzkOWeIDznCeOd4/SEUFxw0mfN3xdfOuZ2jJ7QQ25Pg/9nAaVS4TktUpHpwOUCwQ2jallJSqmCvYRASpQAubCH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1556
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10286 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=868 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150019
X-Proofpoint-GUID: UocnzZ9VpO8hK3_cqsZZqQILTL6ko81j
X-Proofpoint-ORIG-GUID: UocnzZ9VpO8hK3_cqsZZqQILTL6ko81j
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sreekanth,

> Looks like we will observe this issue only if DIF Type 2 drive is
> connected to the HBA. When this panic occurred I had connected one DIF
> Type2 drive to the HBA.

No problems with Type 2 devices observed here.

-- 
Martin K. Petersen	Oracle Linux Engineering
