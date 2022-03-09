Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC5E4D2657
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiCIDVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 22:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiCIDVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 22:21:33 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A1814E95E;
        Tue,  8 Mar 2022 19:20:36 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 228M9DvU010464;
        Wed, 9 Mar 2022 03:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=3P2knesILFmPZHTK1tuENQ4UE2+L3URD9GI/2GduEcA=;
 b=gHoLScOY/o8bd6hM3LqJvKd9zM8MnQC10qTK1Z/yGe0791/yyNIti2cp06vvpY+YZx34
 EgOZaiVZmpiu2L3PvgTPKoKF66NDpAqVFNT+TdNdNo3Z/gKiF7sh25jFj35ItVUwlFph
 nC93AqYu+AXIlgYVCt8NQV6f/Wlw0sGQ48bSjLfjCTESNqyr53OuuFpuyp1z2R42NGqO
 H7tKtynvKkNhbl082cD906SJ9Jz0Qf0wbwhWHrpO7cUkPgGchv8nFb/UwntAKJ3oTLUX
 LF5SnU1GwBpma/NVZSBCGPLPMNKSDXy+upRE5dCvxluCa3IVS/ML1rVzN+DuF58Aq5MD iQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxf0rssc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 03:20:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2293FHAX098928;
        Wed, 9 Mar 2022 03:20:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by aserp3020.oracle.com with ESMTP id 3ekyp2pwxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 03:20:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+CgcxEYXyVL2cjyoPZKdcYVEamRQr8fiiUYwH73qrZVu8uVbTgXRK+OE9OUauEX1213qeS9Io0OuLAUNGxjZPumRhPOVNfDfroZrTfjXvi4+hX32k4kJy+ev8cPaN03OnmJ5QafmvhduDoAoEz492zfhsumhEf7jFtBVK2fx5Qvnhkx14jk72KwdVAFAtnXUmrM6drRxaqU8JL4LhV0YStb94+m545eYpbYsx+zYNzBAVL7pNgBn3qgEsuE4UPYwQe9f+Ij4NOwTHs0HZmm5CKDOqjRv9DDPRQoQJbY671VDyUuFF8vRzjNZPefjo2ELkCbM8Cz5XBSos435yqLZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3P2knesILFmPZHTK1tuENQ4UE2+L3URD9GI/2GduEcA=;
 b=KyA4LTt6NFVL/J9vq9E8dedlZNZUfluHpgRw8oXg1E/4gM7N9IdU0Y5hvl08agElluckYL20EdYmkHXuTryJXziJgUpLoYZU57n1D+a5NqLa8x7E5Bu+QeMpbvuSK4/516Qcgf+O/cBs7P/W/Hn6X6u39W4cdG+aFViyRHmauMh4ICYt1DF4NnEG/dO0vXdh3ajILclHlsbD2bL4D3vP1Cjy6VonHofPfW21lPehFoDUzhzx+dOUONrngIIpvfPXBobRixeBdgsKu4Z7/DwttAn+1Gpzy1UkPXJusNieXoCALgKO6l1Zo9b3FR3+XSol5UgTcfEVhq1UbohLILntdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3P2knesILFmPZHTK1tuENQ4UE2+L3URD9GI/2GduEcA=;
 b=RtvIYbsLEyPzVRrl7yqduLLGkypKXwwnU7HlkmxKSOgy57YQGNzjmJOhE6k9woZoix4AsDVp3p3dmlOCnwX1yJuXbnxQFDJhN3cg8LUjt9UiOc8W5JocSw4Hd2vFvJVTS1CBO6OoYoid9G/AlFUoRfDpVcCubznoSWvQJpasZos=
Received: from SA2PR10MB4763.namprd10.prod.outlook.com (2603:10b6:806:117::19)
 by BY5PR10MB4035.namprd10.prod.outlook.com (2603:10b6:a03:1f8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Wed, 9 Mar
 2022 03:20:30 +0000
Received: from SA2PR10MB4763.namprd10.prod.outlook.com
 ([fe80::a045:e293:518:7604]) by SA2PR10MB4763.namprd10.prod.outlook.com
 ([fe80::a045:e293:518:7604%3]) with mapi id 15.20.5038.026; Wed, 9 Mar 2022
 03:20:30 +0000
To:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Kees Cook <keescook@chromium.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
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
Message-ID: <yq1ee3blsqp.fsf@ca-mkp.ca.oracle.com>
References: <20220201223948.1455637-1-keescook@chromium.org>
        <164462189850.7606.6908949862618145181.b4-ty@oracle.com>
        <CAK=zhgpQcJkRKVNFHy6mDqV9hOyzFsV_uqOWur8UsNLRZy-VdA@mail.gmail.com>
Date:   Tue, 08 Mar 2022 22:20:28 -0500
In-Reply-To: <CAK=zhgpQcJkRKVNFHy6mDqV9hOyzFsV_uqOWur8UsNLRZy-VdA@mail.gmail.com>
        (Sreekanth Reddy's message of "Thu, 3 Mar 2022 19:31:18 +0530")
Content-Type: text/plain
X-ClientProxiedBy: SN7PR18CA0017.namprd18.prod.outlook.com
 (2603:10b6:806:f3::34) To SA2PR10MB4763.namprd10.prod.outlook.com
 (2603:10b6:806:117::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fd0040b-4884-4921-c3ac-08da017bc37f
X-MS-TrafficTypeDiagnostic: BY5PR10MB4035:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB4035597E84FAE1981828F36A8E0A9@BY5PR10MB4035.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YFEtqEfS3tjTkeq8uamqQ6QJhLhc1y1nzndI4GUoxiA/+jpRj/fB+w/mYE5jBNAjska/6xpFUKnk82MJv+nYEq6NW2RUqygvn2JKyMMjauItTn+96c1kx+htYD16kCFw8Ukv8olWUy2QTyIh29DXCo8DbnqW4VuIR8eutzCXUIaBJsM+Wa20Ra7LtbnYoKnuikRGXBwn3uROTueHwyqnmwu0ABFUNgvs4bdWyxR9lCowJ0lQ7O7bNRjY4YGhziTYl/pIGQLba6KxRvzXLENFfpPH3dHJ1DLsusZGrjj5D666LmObiLPBpvrWHEnzXFwrC5hhbVZWDqo94f3+DIQmELs2su65VCRpxgAhalBAbQfcJgkoj7N88UfC8ay5LVSOcW9WuXCbu4PurnQiNky/sdPt2JYoY06rmiqEgsb5Pbg966JgjJPk+uj6FplVJxIm9hISGbv4sSDx2Wo+XMq6ydTWFTH8mc5ehmNl/1d6h43mU1vF1bSkHIlcK8j2ra6dILrozKYZjcXT12ICzH5rmwUsjXdo1XYxw1uu2lw3y3mwIcDHe2mnzi3cwNrE0itIXwYpmJzC5PhXmmyA5tTtkJiMRMJ7ezxdy9J6fU4eUw8uejZBvSbbsAZkEkMoBfkI7tUl+rVDffT706D08oMFjATdCuR5COMPP/Pu+VUsi1ORHNpgFM+ozfg5xZTFar1i1KFkgjxpMh/4XGI0W1cbq+7CxHDgWWWzE+QePJAGr5I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4763.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(86362001)(5660300002)(8936002)(38100700002)(4744005)(66556008)(2906002)(66476007)(8676002)(4326008)(6486002)(508600001)(66946007)(110136005)(54906003)(316002)(186003)(26005)(83380400001)(36916002)(52116002)(6506007)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IxeuTB4g06tHtUDjA+gu8vNJQPZIv0BbX15HO8oPel7FvMsIg5AbltTPu/tI?=
 =?us-ascii?Q?wjLvP6j9AY67jDHVcGQd1TQ/en8Cb2wp18mGQfpKV/I8lS8RxNV5/Y/PheEk?=
 =?us-ascii?Q?+GWD++gsMlQmkG+MyJu+OaPH6+cHoMEp93RmHxqT1WsUErc7uRLNaAEhsJ8B?=
 =?us-ascii?Q?18kQfPS7yQxxsORcHaECdUQy7UHbWIhupy3i+ZI0FVAVAyneze8lipxwY3YY?=
 =?us-ascii?Q?Vb8uSzzdvnkxvXHepWphCT0egFGkGFQ6phgJZRWEBsUh39EQr2NSDgU2/X+6?=
 =?us-ascii?Q?Bu9BkprJ8AUFZyLhbzyYWl7rEKKIm3ZAX/j1sl3l5zQkwvWdJ8JVmuLPI8oO?=
 =?us-ascii?Q?/iMH582nu6r7WZ4AhTnjDeGeJIUl7GjLn27c/ZIRbI9uBMlOgi9v3Srb4a+Q?=
 =?us-ascii?Q?1d1+J6bAfYBYWLaHd3qXXwxl4Rz3t0VGKOTsP1jBnv9TBxaV5MMc29jW5Tlb?=
 =?us-ascii?Q?zsrBHyCQYxqs+c7M4lPrw4K//igQCqE2Hb3/q4L2zAmQKyiwxB+iQJf4sWYq?=
 =?us-ascii?Q?/+MPolzn9P4vPo9fR9ikXCjyLfKFPyaaxsbhBHUGlMHofwLjSMjNlu5gBuk1?=
 =?us-ascii?Q?MCccjoLFVzmmcKdvbXZbzskGbzupgynWbcxN4lr6YFonbCub7rki6YbX+AhZ?=
 =?us-ascii?Q?gL8lCsUxObhCkgHURnVxLjWkMyso4karc6GODTGV7EtN0IF/hTzjpNUDk6kt?=
 =?us-ascii?Q?eDxh86h1LwigZT8c4qOcH1fb8XuzGOg0vIrn0FP+2BP7SANH38GwyWScfFGH?=
 =?us-ascii?Q?0UkjDmxTiY3gFAzSvL3GJajTEiOXNZFAq1dqJuicVMKuwc4LgwHqkSjgeE5Z?=
 =?us-ascii?Q?MyZ4fNXtJvxSOnhEIklp5DyPMRtKdOTyAVO6XBdXMw926uvRKPnVAEayKkwg?=
 =?us-ascii?Q?uKE/ffk5LmyIlTC6KGZSQGqOW6Dn5nRxt1/oujM907uilIw1CsyQfp1wQiks?=
 =?us-ascii?Q?JbbzRLhjpfH9enICIryJD7sKWZvG+DzXjC6U1Q8vuXFdX1r8ltYakRGjExTt?=
 =?us-ascii?Q?0taarKCHvgb3A1VU7WRr4WjWnzHXzQ3ZsgpKZ34T0RZPWFRa478TPdDXkyvr?=
 =?us-ascii?Q?hHWG/jjd/PvDcRXVQkXXtoCAr8DxU1DcGbGrJSYLwlQHs/D6LFOFr4XHow2W?=
 =?us-ascii?Q?OS/HVR/V1N4xkuOg9B9z1lBOqWULuOi+BTZ5qPIcYw1yBj3iVpeZHDFv8Zr6?=
 =?us-ascii?Q?QErOXFEQ450nc9+DJXqYxC73L8u20FXDNpMwKJHU+BO0Pm8GqS1K+ZpK7V3n?=
 =?us-ascii?Q?IYEGRGG+NRuULs/wJThp5U3jpcDt5j+qoGI3rzBaMTRcTmjz/jMBavpdkKAm?=
 =?us-ascii?Q?0mBG0O76Yp3znU50W8oz1nx1YF0fPw2zVzBLNsU40XLe+l0gllQiTh3lhHWL?=
 =?us-ascii?Q?ihXnheSWrwHKs0NerG8VTnhgVn9Omlo/Yw7yDHn/0syvotxUGaAtd11C0N0t?=
 =?us-ascii?Q?H+4gRvrL9of7D8WCz8eu6JwQ3GuCTniWZTr6CT+G+gqtuHbMRXfNMRZJr9Jn?=
 =?us-ascii?Q?5e9htft/rE5MjvdtBAkGKgrF3S3hsmbHI/d+dGXzzB1ymW6Q0gKjKG/5GdHZ?=
 =?us-ascii?Q?shtI5aujRri2seUyNAGfLbNDv2CLlbCscRXWy6gzPGuGLjkoy6+hL1K1k5BG?=
 =?us-ascii?Q?I/XFLVSn0gXDRlM2v0d0vHsyZ1ZcpX25xezKQrtwGfeiMkZKQJA7EDWBado5?=
 =?us-ascii?Q?6HWDMzwjlfonbAlKdWXu/e6MxA0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd0040b-4884-4921-c3ac-08da017bc37f
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4763.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 03:20:30.0600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vS2S90LLybjzt4TWA8+ZzABD0LoG35Ls6h4nY2JCmBwEddMcivvrAiIfBy9Hl6PxVj+kasz25zDz7ZwVw4MaIcV7uiXrmBIs/XjaW0tSrho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4035
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10280 signatures=690848
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=946 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203090016
X-Proofpoint-ORIG-GUID: VUe_yfRwOJZf5IHLcvrigyLmWjeWzyw7
X-Proofpoint-GUID: VUe_yfRwOJZf5IHLcvrigyLmWjeWzyw7
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

> I am observing below kernel panic when I load the driver with this
> patch changes. After reverting this patch changes then the driver is
> getting loaded successfully.

I am puzzled. The driver loads fine for me. I have verified that the
generated object file is identical before and after Kees' patch.

-- 
Martin K. Petersen	Oracle Linux Engineering
