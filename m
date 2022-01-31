Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660774A4D6C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 18:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381062AbiAaRkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 12:40:13 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:59658 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350348AbiAaRkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:40:12 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VFx55f010608;
        Mon, 31 Jan 2022 17:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=1f9rGbk0sYaI209wSkeYHu93klJ7vh6k7PlK9Lb3d4c=;
 b=OjMrgHdE7HBEriz6Yv29Ec+yY4xgPFnGn/kOvp2KXkVLbPn8RvN+53b8YWDi2mXu5jYY
 C9JXxWOO2sP/iQhTrFPDPdHvwiadt9BY3iSGjYPGfTU31VtbYPUTftG/o+voVGam287I
 EghG2puf9syCJkUrkIdk5V02ZxfPrqmgslIU/xvEI/jzlzIgBh+oX0PRRnbQk7ML0EjE
 lvgZDAeKhXBYZDg4oqQkMtaMG2qTtO3scpKREjwJq7bQzRyp494eeqPi8mPBg3sECrNn
 XTvgZ6ROr1/XCRaC/05BXAf++v1I2nONiGaekWjcchvFtndklx4ncW71qtugO6A/CXD4 7w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjatrhe2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 17:40:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20VHZKHK149140;
        Mon, 31 Jan 2022 17:40:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by userp3030.oracle.com with ESMTP id 3dvtpxf23v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 17:40:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUd//A6xrfOFkHUvpySBhTpWlIJC2iWL7DdP9hPxpb/sLJS37ZcwSQNe5NGep+haXOC+hG/FcHHXlJbQByc//w/ZREiOZssWY1xNGqgb/xbq23Se92zE+aTFVdlAo3Rqqh+7Vrbd8gignAXaEyPCsHXvsUvMpj7l0vXaTUIhhKxUDWL7BqtSa/qPQmdX/HYguzARcwzn5kDqk2LZTHLtEM5nHT2KvDutBbQyMNkd/XjMyHnvvKNGXXdZ2SnkZxbnk2A1o9YLfmL4W2gWF93uMuUBufLbnD8kqggj4SiulIrpcOZcLwbYXOjaiM8N5hP2J/fwrtY78bA1cuFrcAHjMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1f9rGbk0sYaI209wSkeYHu93klJ7vh6k7PlK9Lb3d4c=;
 b=nt3gSbuJheRU/FhVjzco36SvVgzQLW4UId4hhUhzkKiZCqKuTEWL7EmOpMhTBYbzES7u7SSHPkhnyjuXOg4jCxUfbt5gJs3m3hY1pT7akVrBTb7qbr4ZdYIRGo6tQrxItb8DldJcVFqUkeObsq9chmXP+GuwGijwVZvjwqR6u8ggcRmbDQO1dPhhXc5/tbZCqRD5WkyUJUL9zEFh8Rl8WcjeHn6JxroTLELp/Ymj3Va+U5uTSgX6qE8HoZyJRVylGrZMPk9PRCPGBcSI24GpWXw6d1leOuzom+s5bzjUuOCtUE9gso9hpSSLlJ/c3KlatEwVjwrcAUKQO92+RSKzHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1f9rGbk0sYaI209wSkeYHu93klJ7vh6k7PlK9Lb3d4c=;
 b=RCCIYuhDJWEa6YifZBo6YAyAL2eymaoJg/NJ98ZVL7d6mOsCsY9H2iHt3yS9O5/LZR9q6tPRIiiir7IknFHJRjC85siriilmoOYHNN6mP87skmTz/VirQQlMsxeRLFkMQfoXNqqnjPUkfc0zFcPPbcNmDsjCuItnOkGPCxVnUGg=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY4PR10MB1272.namprd10.prod.outlook.com (2603:10b6:910:7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Mon, 31 Jan
 2022 17:40:02 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1caa:b242:d255:65f3]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1caa:b242:d255:65f3%9]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 17:40:02 +0000
To:     John Meneghini <jmeneghi@redhat.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nilesh Javali <njavali@marvell.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
        Saurav Kashyap <skashyap@marvell.com>,
        "mlombard@redhat.com" <mlombard@redhat.com>,
        "guazhang@redhat.com" <guazhang@redhat.com>
Subject: Re: [EXT] [PATCH] scsi: bnx2fc: make bnx2fc_recv_frame mp safe
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1k0efajrr.fsf@ca-mkp.ca.oracle.com>
References: <20220124145110.442335-1-jmeneghi@redhat.com>
        <DM6PR18MB3034D4C12A94CF3121F8B565D2219@DM6PR18MB3034.namprd18.prod.outlook.com>
        <fc2ddce7-d5f7-b9ce-3413-b6ffa87a7251@redhat.com>
Date:   Mon, 31 Jan 2022 12:40:00 -0500
In-Reply-To: <fc2ddce7-d5f7-b9ce-3413-b6ffa87a7251@redhat.com> (John
        Meneghini's message of "Fri, 28 Jan 2022 15:48:46 -0500")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0172.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::27) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd7b0439-78a1-4c91-8ca8-08d9e4e0b5b0
X-MS-TrafficTypeDiagnostic: CY4PR10MB1272:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB12721E88BD2CCF99E10FA8F38E259@CY4PR10MB1272.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: thPf0BqqKj3pMOWA/VOr+c4R+pSGmKTE30U1+kLTfJ45HP+quT5hEle0q3YUws/QNt1ON/pyNZfOv1b64l8istHMV2K7MWD6rLrE9qjWqeIGPS9smHf9GZ/AmXzKscKXfWyFuVSS3XGjbu40hwFZ29+XR6+9YSFyaBYLtALj38Hcrpl5gRXBVYExlcyp9w6LIbF25KDQATCOPpCV1FEXf+0wvWVU7B6C5wCFD2CSw6m9AVg+dQCm9U3j9JAoIwQh6WwZ5Bh/U71VNed4ImWD4crn35CUm9TUDMdygbfCuqmxhbcXnEDlPNBEZzsUiF7Gfsjj9jOOMVTCrkwnj8YLcC4rjwoINh+2PY45Gm/QNg2p2vZcbv2+W0ELvFLuA5SRLFvXBOGJDHTrdaC6kIjz+d1KGPnngmsM0Q9mdV+R3wX6kibPeyJ+eZY0m7AkDn8AUoHesxv50dys9NWJ1xNU6HRsntbY4pMuDBEWo0Gx/n7+hFrdR75Mabj63KD4dFA4/zd9gIMqypRc7WfnFKg741NvONJiasUE/pwjFCbQu+FomYKBS5YOt/W5iKCuLmb2hV8QYQLnXQ8tIiDQ+OKECymtXhqDe8V5m3Rpp2tzx9M8mei5IfGdG8ZXryz+xEdVWwxTio47qN57ZY4hOYDPQ2vUC/KgqpEsuvt6fUGbJiwt0iVDf84wpeyQwF9nA3YuftZ/NrYnEfQLrS3j3vwL5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(52116002)(38100700002)(38350700002)(36916002)(5660300002)(54906003)(316002)(508600001)(6916009)(86362001)(6486002)(6506007)(66946007)(8676002)(8936002)(66476007)(6512007)(66556008)(558084003)(2906002)(26005)(186003)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1cSfAkQFoXGS9xhlD1QD6ZmXddy/xfRb0i7mFTSBI4C5/RHSfcb5nt+20nlV?=
 =?us-ascii?Q?AFpIFVrwK2B9M/pWlJUtrOt7vsrXp8pbp6M/DoUj8+jcVnChImvX37kAYvVw?=
 =?us-ascii?Q?PscUsuSLjh01z6ZPTn+sRokJNi6zgyAUdtObJlZsSUmSjCR+RIvuAavCJ/1/?=
 =?us-ascii?Q?FLmlpN/cKZL/N5CGV6miG+3MIXB04RV8WLYuMiyQYTKzd2SISsrxkTAJR+GL?=
 =?us-ascii?Q?Vw2Ju+ZHWR6NYlYnFGQKSFaojWW7bx8egTwCz0hdAE4v779geWopwbl18Lnr?=
 =?us-ascii?Q?0XV3ztEgrzKgqsL6jq0odMioIUV7lNU/sWLsMVWz2a5bb4YVzur9FMycrSSw?=
 =?us-ascii?Q?6mrW2+MgAofOp2CJBEn8jfaTqaLOd8ThP50i+uk01ZaE1LpAkv189LRmfnMu?=
 =?us-ascii?Q?BO/Q2MKM0WISctTP9mNhPe090NGjPS+fsB15WPXFOnXB3slpUf1+g3RzUpnk?=
 =?us-ascii?Q?eQTjVP0PkyWFZMeVabML9EilTRfCk7pin15qHZejS7BDdrR1RcygD/VQdWEZ?=
 =?us-ascii?Q?VN7VZ51xort/c8HQZ91Dfv5p+uIZRM/jqW1NOYQaj739FCHmCYZs9ghPbxaw?=
 =?us-ascii?Q?R0ZG2Su/vyvJTGGUlGlq8ZGbcyvlH9BKKJtul0KCouiIOVVC+j9H6Dstr16b?=
 =?us-ascii?Q?9h2eTmziEe6W8OuTJcQLHRrCGMP98NCTltrwABKMkWBuqQrWSrwQH3mT+Llk?=
 =?us-ascii?Q?6bPdBrrHz34rPrT9soEmnNIpoqy8dcu5WWQvwnDGAoQmFdDKb9lAXDYiiGUK?=
 =?us-ascii?Q?8rfpqjG4RYjK+z10GKo/6bJRRd/EvlGGm278P4aD6M1hy2xOvMLEBsIs1QOx?=
 =?us-ascii?Q?3e5Nzn+Sjhyrllqwm4lLd5AUVsBISQRKdsRT/Qgxl5zmobm46J3wKSchm5jM?=
 =?us-ascii?Q?gcfiMBs33tMeSa3sR93VL0n89IrsL5bdde/dd2w9jqDOPH+RlmcvCM9/r2h4?=
 =?us-ascii?Q?S1wqODE4nnxq4aNLUzoGqo90wl9/iocimRAKrk9B3tGB/nBn2XIjw2RPAal6?=
 =?us-ascii?Q?CYljWoC6pcxrYK3tvtPL7cAxpAysz29LPVyqt6cgrsEviegkgolqDcSyTJEt?=
 =?us-ascii?Q?XvFE6DEGS0jv8mMHLPKCvnstsD34Vs3uRi081Qq7QIqaqtJw2+8jZPzqVwcv?=
 =?us-ascii?Q?5iM3kMT+nw1i0Ul51reoWK49BgiYhDTuH6SnBi6Ul2PbvA75QYUr53EbNiWT?=
 =?us-ascii?Q?rOyj5E+SNM7zE3v2J3o310jhZpesD3t0qxfhzQPvrHxh4jofEu+3UJjhoR79?=
 =?us-ascii?Q?y/H+CVqe4iiaEkGBkjlMiqMldi97bgw5kKIWIyGJnI8k8dj8FjXtMPDnmQ5Z?=
 =?us-ascii?Q?PB+QDPAUd/GgxYIeJuzSB7g2DQrYGUy05TA+KMX5NLXJdnesGkq+3/s1VIDC?=
 =?us-ascii?Q?sfuF1WQtqi7rAvoKR+qpqnPSxogK8i6//9SvhwcOSK1TN23dg2IWdPpoCxJW?=
 =?us-ascii?Q?ukPft3v53HTtbfqKhKNU3dNcYY4Si722rv75gmt/BUjoUY6VESSRuR72Gp+s?=
 =?us-ascii?Q?RwApjVERRM3UDJmxqZOBNJVlaKqm5SzNLvUoQ1EQ1e+a8hEJeXkmo7SouQKD?=
 =?us-ascii?Q?PGyU2V2Gj87BFm1EqDazJGlFbgfofK8fdnzTlmXDAxhxMU7G+xp14RxGH+Qc?=
 =?us-ascii?Q?QO2+T7cwrnCbsOYcJhOVbue1U6LsCnk1YJZx+NM9O9ECX1I1HYUK810tqPZ6?=
 =?us-ascii?Q?4epHlQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7b0439-78a1-4c91-8ca8-08d9e4e0b5b0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 17:40:02.2783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOSAapGokStp6l7sKYIn8qNALlkdunZYvOwU0jZlu0Wbye/9rXHurvdl3CJpvTz6qIrZRJd1fGHGBEYBPeMh+yQMPLp776mjXZnXcuOaWhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1272
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10244 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=838
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310114
X-Proofpoint-GUID: dtGjdWS07gwdRoYEyofC-jtW-SY4qq7Q
X-Proofpoint-ORIG-GUID: dtGjdWS07gwdRoYEyofC-jtW-SY4qq7Q
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

Erm. Hit the wrong key. Applied to 5.17/scsi-fixes, of course.

> Martin, is it too late to get this into staging for v5.17-rc2?

Patches sit in linux-next for about a week before they get sent to
Linus.

-- 
Martin K. Petersen	Oracle Linux Engineering
