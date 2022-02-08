Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15ECD4AD045
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 05:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346884AbiBHERH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 23:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346853AbiBHERD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 23:17:03 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6DEC0401E9;
        Mon,  7 Feb 2022 20:17:02 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2181rYDe020210;
        Tue, 8 Feb 2022 04:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=263ZpCfIeeurZhrrhXJbdcBitC0YZGumRtrrZIWyo2c=;
 b=sg6dQS2VpcfNExi4veZprv5i2xF5wGtDfeodjw5dhAkMJveWJHN4FO+afdqKKKK8zYec
 bu3Xw4xWSEZOMQ4MSX6FT+R4FJ7+yXYLD/BU2xoO2uQINhqHG65P0OSL855Ojd1gXylO
 zKaHuNIcVRASpf/Tb3gWlqQE3qbmnlMD0xgKN5kO7NS3XoSGgEa0r6fzq/qDbnvZVkl+
 zWYIcZyloSj465XJEeTrk30PIl2KPGwaA/NEwi39WnuHoRs5MKLEVb89xw+19jczWDdY
 lR1CLca6nTsBHBnRsn84eNc8Nl7t2juLn1oYGElXu8ucRNiUSmwG1EGU/darJgrbE0Ol og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e366wshy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 04:17:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2184GwYO178996;
        Tue, 8 Feb 2022 04:16:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by userp3020.oracle.com with ESMTP id 3e1jpprq45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 04:16:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AA/jtSUpu5ZIiKs2a6XswgKMZzaul2d6cHE5uB5H9M/jQfxhwsmGjMPpFABYqCyCUc84dipPCmDnWeGPs3zqVsd0I5+iTBEbvLn5MMSxp1b0H19PM0tS0G1aMQk5LHmT5E4BzaqFgP6LROi3vX+wliLTkMfUK+BHJY3rxnZiiR1qUhh/WIkDBAJsvwOVuXPbsqQRGMDvhVwTsTG7WD0TC/gx3yMX0i+vkLrgDhuqLupa9T0lVP2DemOzz16t2yCSNxbw6d4MNGHPyqr7M8I4g/JY/q6wQIXp4MITWPd7TBn06jGWZLY64PTKFZKHi7vlihMdf0LDULD88nxRYeU0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=263ZpCfIeeurZhrrhXJbdcBitC0YZGumRtrrZIWyo2c=;
 b=az7uzqQFbnvbT2tNu0uLoiq9hYxASNQnuMh0c8dts8l7Rscfo9ajyYj9sGUZKoFPsV8nYQ+1h0lC0Mehep/H92yP1gOIeYwLVJeQVuy3+8yIJzRNQWTRmZPAhfc7Xr8gjq35ZeZptNkwS44EbDi6jAqazwMfbuZK0e2DeQ4qycn5MqQYVJzEXqOFNUURfCHbyOvr2E8MA0L4KX61jiT89viJ98GvaloG6r8HeM9BPtsPJPefEMQU9Zdk/Csjs76r2U86ooQceDV14GbzitYUUqMj2uxtX+zArJduIKy+ugrvUdDa150xy3lCwmAI3wy1wSQSjGFXC9bpVBzJkBPgTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=263ZpCfIeeurZhrrhXJbdcBitC0YZGumRtrrZIWyo2c=;
 b=Pa+ssmsJv772piz9SMSIXyq5dh6FcRbtwD9/01oWvjjggR4wFAY/Th6e6j8N2nhlldHnZn2/djR0UmpEPU6lV6Pf26gWTMXPPwMPmjiXv2jPkXR+TUuHK1guQbaa41YPAulyvuPDmiKRpeIRJCnz3kk26qR0Tgt10cghKZluNg0=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM6PR10MB4299.namprd10.prod.outlook.com (2603:10b6:5:216::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.16; Tue, 8 Feb
 2022 04:16:51 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2d45:d1bd:ebb9:48d1]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2d45:d1bd:ebb9:48d1%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 04:16:51 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: mpt3sas: Convert to flexible arrays
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1wni6vvq0.fsf@ca-mkp.ca.oracle.com>
References: <20220201223948.1455637-1-keescook@chromium.org>
Date:   Mon, 07 Feb 2022 23:16:49 -0500
In-Reply-To: <20220201223948.1455637-1-keescook@chromium.org> (Kees Cook's
        message of "Tue, 1 Feb 2022 14:39:48 -0800")
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0701CA0042.namprd07.prod.outlook.com
 (2603:10b6:803:2d::16) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5e11329-0dae-40a1-3ef8-08d9eab9d4ef
X-MS-TrafficTypeDiagnostic: DM6PR10MB4299:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB4299E81FC4A8B6DD263C4CAD8E2D9@DM6PR10MB4299.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MnSaJ2WN9nMOUL0qoGhlufMr4AWn+hHVgaNNiWwM2pY6Kb5V+qEF+1rC3/f9iPnMHyMLzWoJuWnyuV6W9+8iwIeHVoUlFNTjB+c1RM1XkGSiAgpm6ynBUXtVCcKy0THSPGvTvw7plrAQFT1Ka3ZzPFqfCvRTvbSY0d703RJOCiU50514q19Wttv0L/8ogMWD3cWsd3RNGIKs1hAPPPLQwylGObFqS0KIGRLl4wVIxpCA4uFJOEIwwSs87ci6jxUyomn7WNY6Su43ha7s8n1hnq+KgFOO5AXWC5e+8Q/gEiVS/DVshpr/XAjRB02nk79gGvoMz1cH2fJwCYkkOD4GABlYGUvqxcsbAoR1td1lJG1QL21vF8qabMX8Ge6VtAI1qI4DsaCTnphi1p4Q0mwTFyvItTGarfEOhXW2nQVC1eYuIziJDl4pKcvHZLqL2fDykR3E42f7fw/6/bppU7m+s3gPVlDxOEzAqWl5J2D+UL1IMEDXKnRNUoqXEXPKTKoFMARofWQAyrivY91oSJMTt67dziwDUPFBqOOkXD/PHvwvgFp/Ny/whkj6nGbQmmnDfoFUNwOOOEosvezcfZ8yMDTwqhTDjStfQ1D0SQgFnuXNqzzUbJ3yvEZUv/vsrE3uqp2li1oykzwdZbWk/XoPgNJZyS2wJSzrzjqaDptATHrRLtb5zGG5Qmn8SJRzkAAm6Hbp0lWL38cmBU62d4xKqPhE4YGTR6ZMNYJedBpiecY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(6916009)(8936002)(4744005)(66946007)(66476007)(66556008)(8676002)(4326008)(38100700002)(5660300002)(6486002)(186003)(26005)(508600001)(2906002)(38350700002)(86362001)(6506007)(36916002)(316002)(6512007)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YSzKYIMKgY8vCC0WgPWUbvzegVjN/gWSKeVZ89nASkpARTXBNQVLTX2AZ5e+?=
 =?us-ascii?Q?Zf7UOVGEiOaEDojHuJSYFVmg0707/5Uwylbe5QqWFq0TQAT+AR+7RxYv6rUp?=
 =?us-ascii?Q?bZWphcjsgMsSLE5r1JClPctr48UNJw4wWHYIuwOARfrc0+34puKq41NO77FF?=
 =?us-ascii?Q?o7ZzQSqXlMQSBEgbpEALPR/qAB3bwH4kiNeqoNj8Qu74hZaXkl9k9r/bSzh1?=
 =?us-ascii?Q?CSa+IoDOpSbQBdx9916t6t6I0lRR9u4lBDG+r9QimrQ3a2nHye/BDfML7raY?=
 =?us-ascii?Q?0ROpZ4A+WfoIzYNTgUyNGba/QpEcrA82sDZ9sSPbGkATkEE/gK1yu6kZkYlM?=
 =?us-ascii?Q?G6BoverqO/tGGltXu/MDzWeKyi7r4KcSuW661BIexpL0rO29e5YLZCWG79hp?=
 =?us-ascii?Q?YSPoGPgLzP6gB/3U30lLtUUzycIYetDsMCD+dlD81SPa26NXXaOfMAgCf2h+?=
 =?us-ascii?Q?zkCZVdBfbAwyljtDkryAj36R74p7VwMcsh5b7JNUGTtJxW4Rh3J9vFR2CyyI?=
 =?us-ascii?Q?C0LzSMx5b2SMJkbNh645m0NHuyqwqaLvKfYcpuOAM/xRHCnSkImB35HvXz+l?=
 =?us-ascii?Q?ff0SfnbKRJSHgzOhAUN7S/DbDVv26DWD35Kg+uQZVj3R4dmq1hbzhi7LO/Ye?=
 =?us-ascii?Q?cjT29ufarycoX/l+1knbHf6fUdTdz011AD4WGRiec3fLqY6g+RWf/D2QN2MP?=
 =?us-ascii?Q?6LrbCK9hF+RNWRRIxgLrlLfnSWc5sEImqHFGc+Wm0tf3KIniAHBEPMGOQ9J1?=
 =?us-ascii?Q?SWzJQgqaGqVuiIKV+wam73hy1XKehSyT5CsOSt9h3++3X0bmf2Yu67TPw1rZ?=
 =?us-ascii?Q?Ajfa1qYx4GpwhyDsnMfrzM76sGPD8fMX221UrEpuElLRoKJ/T2Dw4L5ElrG6?=
 =?us-ascii?Q?8JmqQpyJGrxOcndkknxuD7OCFoGH9K1h218gds6Nj0DUMtaAwySCG/RYlOlJ?=
 =?us-ascii?Q?FpZy16XsHe7hPFtTZWjv7XRPu/EsuafY2AHjnZYSJxByGXNQBDTNAriG72M8?=
 =?us-ascii?Q?BK70a2BdMVVyny/lcCiAFetfQxeA9YpD9sBGtL0m8B71IaQSHbp8Js6qrceq?=
 =?us-ascii?Q?pVInSm4QpyeOargbLu28vNx4aiC4nO93uq72/mGs1Dw4iC/ckR257cX7S7KI?=
 =?us-ascii?Q?mtH2ba53Gb+XxYxfBxoowgcIoVDl5HhY7Z1FlbN4jg2lCLVZ1KnTeAle7/Zj?=
 =?us-ascii?Q?wChoJsAhgETsgv3Xd/fJacG+wcFiPEXqo3Z3dCVuBfjkathYN3FOYYqyNz1p?=
 =?us-ascii?Q?6Mw2ST+IMc7cg40CnCArOR991AlsA5Xp6PJD3LkOaLoMt2okE3L4919BuNmQ?=
 =?us-ascii?Q?5LUtdi0zRPJmDiuA/lJPf89WFffQpIzf+ywm2kCXCHqwvQg3I40L2FxlFxOu?=
 =?us-ascii?Q?qwE+1Ze5alH+RUKV97UFGOdhg+2OJ0EnBdgw+mE0hHAwETqdlqr5R54dt/b0?=
 =?us-ascii?Q?+TYs4lMLU6S65b1W69RKMPIhb9Qll+jtVSrMUtSM2nIoMwPyW5UIdJpBgVO0?=
 =?us-ascii?Q?CT9cvDAPHe/yfBElRgwxIWrrRHBdIzFm/nkSeYmrjjxRADjzALEBOid4JYVU?=
 =?us-ascii?Q?V+AFhqMXQ2fbJRNea4ieh7U0KgkObCyhFBT0aJIyaBZs46AJJvG4eOEtJbQw?=
 =?us-ascii?Q?V0O1o/aidM0FucM1psMLsWGXyebxHmAqxSVeaPuBtw8mr2NGZEMG1uXLmuld?=
 =?us-ascii?Q?DIHnww=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e11329-0dae-40a1-3ef8-08d9eab9d4ef
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 04:16:51.2871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +KT55vsF883dm8KDzt5ckPWBciEW8vzcCiuiHajWVL2R8SWIFAy5fSRFdDtKEJUIbXPn/dU35zSJmcSDGnCwso0+bqR7gC/rKDe0nvSQ9uU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4299
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10251 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=887 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202080022
X-Proofpoint-GUID: o6nrHbB2xsgtz0rW7HfpES06nWGmkTzo
X-Proofpoint-ORIG-GUID: o6nrHbB2xsgtz0rW7HfpES06nWGmkTzo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kees,

> This converts to a flexible array instead of the old-style 1-element
> arrays. The existing code already did the correct math for finding the
> size of the resulting flexible array structure, so there is no binary
> difference.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
