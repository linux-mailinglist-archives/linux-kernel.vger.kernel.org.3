Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D09249339A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 04:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351290AbiASD0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 22:26:51 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:40072 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351282AbiASD0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 22:26:42 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20INx2YG022251;
        Wed, 19 Jan 2022 03:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=G1HpGCpwZSvfDCcJ9CL6FYNHObVd8qrKso465vC/ocY=;
 b=w2e/+CamTdUFjNy5IkL1Qu8fHDJ54uww/CnF7ZRIlt+Wq/Fwi5R8J0DZVOT5ad4Kbdvh
 3AHCvJN2AhaQlUNDnB0xBgdjW2ghLKwvBWeAOAaaN2fSLIZFv/KzrTusoEqxd7opNrJE
 6xvmsD1SvDHbJFUnvwQc6KUsLZNG9GZkeqpdWAkjZRuc3YkzIy2dv0XpSVXXEhGJc3zr
 Rm0dvt6oiZHvPrdjML93yi8rbjCAkUoPSruypw9lmGeB5Bp73I4dbt4DOXb4ejGtY+x2
 10JB0SGORaW9hbEjmVu7L7+lEvQeqci9ATbUdY4y4givPYFX9ugkfGJHcUqOHlzcNaxk Ew== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc52uskx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 03:26:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20J3GDgU147402;
        Wed, 19 Jan 2022 03:26:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by userp3020.oracle.com with ESMTP id 3dkqqpkxmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 03:26:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxzQVHDr81BMaonQycKLj4dzSNUsd+T+t4KkQi/mBXkZp/iBDSL2dO2d7GQ0OcHorrikVknqeoLuyJqzxeBLhDgfpEZbEIoG+rdFcOUIYJCD+fkr1fwikIJmNGLDU14DPZWl1jnqfYbNQkTKbV0qf0Rfa8Tn/2j4wiVf90rp0dhryCFc9I5tgbz1tPeaVytXxBDQ1APUa5NHoVJCRuTW2PjADz8/O1Y0al7+qtugZh6yzsmJFaPwJ3kMn/dc3Dal5luGXprwvPQGwYIexMxfSJRMOUW2YQpuqNRvRELisobgNOx8wIzdPULMrvV3/yoWwNGIdv4KuinTT1xSOGr6kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1HpGCpwZSvfDCcJ9CL6FYNHObVd8qrKso465vC/ocY=;
 b=k4biHJno+EYRjLAo4admv/sCVHLSrJ8ieAM35hwCMXz/CfZg8YJrHJnBsrMK8k0X7BMm2dtBcQoKRycmQsstfTSD89mlFNY1cVHYSBlpzejEFEbBNGOoVUprib3pNNEh1iiBSqCqMjCZ7hX711UiXxR0UIOkVlwIHdke+NQ1QI/osz2HPAmQvDOOuRW+UO30Lwi5vmF5KSLxCWHV8ObRTWp6yjTgQIFtTvXP4i+WiBW5BRny0cikDxJgRcBwNz+WhW3uigQrlK7XdZJm4Soeie2FLUhHAQ6Djecj9C/l6JaAivUVxN4R02m3pwvkOvafFmOMBmNPRKkl8TgQBxyXhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1HpGCpwZSvfDCcJ9CL6FYNHObVd8qrKso465vC/ocY=;
 b=Hrq9IFYQyBeJAwyS9oJutj9I8ggOENZNPvCGPHQjFtv0WZLDMH5gg760ZtfluNygPao2cZbSs0SpqSJ6UZ4+XJxQed50gb7pVTowKy/OPtjGwwc3z8EMI3xcTvF0b18WZC43RlSBbEG+7kTYkdXKThZE+SkpVpeC/sF/E/7Vf0k=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BYAPR10MB3480.namprd10.prod.outlook.com (2603:10b6:a03:119::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Wed, 19 Jan
 2022 03:26:30 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166%7]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 03:26:30 +0000
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <target-devel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <hch@lst.de>,
        <james.smart@broadcom.com>, <martin.petersen@oracle.com>
Subject: Re: [PATCH -next v2] scsi: efct: don't use GFP_KERNEL under spin lock
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1o848mmna.fsf@ca-mkp.ca.oracle.com>
References: <20220111012441.3232527-1-yangyingliang@huawei.com>
Date:   Tue, 18 Jan 2022 22:26:28 -0500
In-Reply-To: <20220111012441.3232527-1-yangyingliang@huawei.com> (Yang
        Yingliang's message of "Tue, 11 Jan 2022 09:24:41 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0701CA0047.namprd07.prod.outlook.com
 (2603:10b6:803:2d::20) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e87ab6a9-da1f-43c5-230f-08d9dafb7bf8
X-MS-TrafficTypeDiagnostic: BYAPR10MB3480:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB34802D652958172A75D7227C8E599@BYAPR10MB3480.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: biO7Gvt/Zss0ZECFxOCou7zJYxYjjWyZYoTA5F5+DwrW5yWIKoAOkmSyIQso5MvWQ6rKUS1kSEz3eNI1EZeARzD+Co8UCI03Cii/BmAjKYoeKv0o64MSQoSFz3iEkhR4cMRHF7iH2LL3LqGO0f1s2pDi9P5Rb4zIEhPgJ0O4QjWo9gd+DBFS6oFBCeDrmKYZjiKbr8ovUqIEQnUvdeQWfbFAyQyWYS7VpwjU96aeEk8NMj/ySqi48JbU2uimDaSQgyIfe/eW4T3Huev8HyVyu3xPlp0t8mL4dZdiyD/RhrgLeh/Abv34lgDlZYJ5gWrM3kFBg1vBYydNBb2g9jZGWqMxnPe0u4XtbrC2jrOIKFgMlDtLo4hfYF2cxLgLb3w1jact1jqSTd1jhWfcKC/1szZeQ8ybt2aCZDuaDXDZCqn1EvqpDX/gsHYxWYI7R40iDW4h23OxNJq9DK0o6Wc+sgeJK0m2BG1HnapyBUxicdgnfXd8CoImi0FIT6G6sZMXMIajYiLZg54S4fSkU40tzxNhp9ire/Hyv/eA4IdNY1adPEi3YA2cqKYa01TB4b6h/5b4Srt2CHWRvfVpVbQ4GXUoWp55KGLsWtTp95W8zXoaExBtFKAleYM+h59yN1Irwj2UpVGG4qHz8gPm8Sd0sqm5RX4jt2sV2Gtra78FJ0WEr/UT5DLFtbin1y9ssj+VrnO5rzr3LdIXwBObGxvx2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(6506007)(5660300002)(26005)(38100700002)(36916002)(2906002)(52116002)(508600001)(6916009)(38350700002)(4326008)(66556008)(186003)(66476007)(8676002)(316002)(8936002)(66946007)(558084003)(107886003)(6512007)(83380400001)(86362001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5aKMlTnYb/2UIrPCGkdtq1ndSFJnTUjaC7xiBjvlUxf+MUjsa71Hy6VOre4m?=
 =?us-ascii?Q?cTJlvwNKCGLaxzr0qMq0tNtewGTy456patHXkCkFsaYbwg/D+g1LztSEdzx3?=
 =?us-ascii?Q?i8yVp0D+1yoqo6nb2V/CIlKf6cUbxnQ0ciBR+O986j/lHaFxW6KJcpCpIczE?=
 =?us-ascii?Q?wlxrqhGTTwP7bbGjoQDFOQezYrQnV56VcsyoItJMsTb/l3bNTyLdXeACmKT5?=
 =?us-ascii?Q?gFBem7qycjYwdxhTVYrnuqTZIqeUV4vYG1chbA7m7kB0zoS7lcVX24vXCfC6?=
 =?us-ascii?Q?+Aj/q0Kszk8Ifz1Y8TWuxzcUWwTCgxBPLM0teRP37wFY09W0bZqsUzLD1uXl?=
 =?us-ascii?Q?ltUpm3nwKs9TU3Ek92vbaQ7+zQu+nxv99Fu7F1yT6TVtZ9k3juFs7mkjwmjF?=
 =?us-ascii?Q?OV+RmTxI2btNRa9Odf7ezroW7WIeMUSITiY/0M52eSTakjAqiOBYglTJNwf9?=
 =?us-ascii?Q?shO6wmzgW/MZWrBabsa0wsXVSIswz29240NKWSqcYMsBqCV6ujmPCreSsFF7?=
 =?us-ascii?Q?+4t832g8ASIze+JgvZ2eD/yyHT8KVUBfG+jAfOvAc/0pmFYe9MzI5r22pPzc?=
 =?us-ascii?Q?dmf5XePq8zfh3VIxqoU3UeU1L/S1mmhEHzuS1oxsz5klCTx+fs/Xm0rOctCV?=
 =?us-ascii?Q?Tqu8GGUUoVh4oF9uzwUsf0ZHlg8LXltoc+TC0+VbBXTVNaCA8mSkMl0QNOz/?=
 =?us-ascii?Q?Y7RxvWY3iTMKZm+/DibnFJGEYQCHblKqFWQdBvgmuyGdOlDMfkQ3pW5AqSkx?=
 =?us-ascii?Q?tnB5l0/AeprUoFPkzdnrP3m25mBfGjLFevNNqbZYezBdY7Ezp00c7y2IUdFT?=
 =?us-ascii?Q?95jxPrzZOD/aZ8LeYga12DN6uQDEvhyoIM1Q9uYa7F3wAQ7wVnt6J7tmQK8u?=
 =?us-ascii?Q?WQ+OU3kzJ4AqkjhTkLTywD8JhdvAXnat96CAbcJmv1KyYsZDPxwk1AmTlXyH?=
 =?us-ascii?Q?qP2IDWDxX7Il8gloEHJPx68NhuYa/S15lNyQ+EbdId3e3VaNEZKNP2KPmRwr?=
 =?us-ascii?Q?+VXT/SJsVTsTLFHWOolHE3XkpFuaBQOjjY8c8M5k5lR6yoIhIghDJAwWN5RU?=
 =?us-ascii?Q?M3i5JWd0LxZaP/xzLJq6iKX4uci56UbNwerPIAYe1cXUwowMcQcW4LiMHXlS?=
 =?us-ascii?Q?bpfn30fHJJF9qm0kiAIxAKQmf09jWdGQo8YdIh1wthYT82X++dqdPOZ+00+M?=
 =?us-ascii?Q?1ry6wuFzPjwLLVv/p+Ia3lyumRH8Q2lBuU7PFVkZN+ORYg5fnAeUXQC7iCiR?=
 =?us-ascii?Q?KBliMwYwbWaiz78L3Px9LH+3FABHGnFhkhvZuOcWjEg9jAqjshduAqclo+U0?=
 =?us-ascii?Q?HyAXjgiVgzC3/neG560sZA/lZC5sSvgROKgZT5l1/ct3U/96o8bh0eu8W/7I?=
 =?us-ascii?Q?HQS5dcqNvQ4I2/t877qsqj+TVz7WaNKPZyNXhnwRccchOaVjVjrMvjJjbkoW?=
 =?us-ascii?Q?HXCJpo9lkOmbHgg5zAyJly3LHhY311fWfKLMlEiipICipY1dhmBR53iBLaZJ?=
 =?us-ascii?Q?T/cDwZgcVmz8rs7J+u2qlYsu6RNly1mC/PVnAhl0MusAygcPl4V+7Zyd2boZ?=
 =?us-ascii?Q?vXc8dEPO7xNm0kRNqUJlySm1zVS3vwe+gE1rwd9Gkp2I7oiRsZrLzTKYE5iG?=
 =?us-ascii?Q?q51nhQ43vi60wdLDZYHpPKIV0QqK4Mh5YFRwPF2FZ7OIjLmd2jhMs2vioLF1?=
 =?us-ascii?Q?vuPpTg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e87ab6a9-da1f-43c5-230f-08d9dafb7bf8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 03:26:30.2234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCE99+/SQqp/uL3hCYNQYyvXOxzkwE05RG/m4Xdgh0G82H34CoeZzG6iydsvQU5KD7KZ5Sp+iSDwVvANvtCnIERO35YqSiBgEvM16AEd/Ro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3480
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=851 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190014
X-Proofpoint-GUID: z4-YUeFsat4MTavwbshh8mEuePTRVhpo
X-Proofpoint-ORIG-GUID: z4-YUeFsat4MTavwbshh8mEuePTRVhpo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yang,

> GFP_KERNEL/GFP_DMA can't be used under a spin lock, according the
> comment of els_ios_lock, it's used to protect els ios list, so we
> can move down the spin lock to avoid using this flag under the lock.

Applied to 5.17/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
