Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4C74933AA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 04:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351324AbiASDhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 22:37:40 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:10730 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344436AbiASDhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 22:37:39 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20INxW97011247;
        Wed, 19 Jan 2022 03:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=UgTv5/VEpNg+//O8DT5eOyt5pFExb8FzxycchF5Zo0A=;
 b=YKvREJ9/7svqkF/UbuHM01AFYr1AiaO2ovjli/22nC94v+HDPfOzNml0aELxaQkUQft5
 NP8dSh0nwC7kfvGBfAOhWB8HQo1QnZTbsVPIKcMKZ8st0apaExDJbkawIHj5kvvkuPln
 qIyi7C+BjyWF9+FfZ5iCvQgmWSQHY7hQwQEJbF0aWjLEvNX/MewvNykFMsHZADNTmX6u
 tGzpZqNzpD2mMYQCZEdoMnD2dMscxbKRvqNxph/KdW7W/AXImNTe8+EQ8S227+vq41AB
 pIoVMY3tmUQSdDyH7ol/qIPx/Y0019+MxkShAfYX+wSSiuOq0VzMByfhb1gNIYHyc6Fx vA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnbrnutbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 03:37:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20J3UamT106350;
        Wed, 19 Jan 2022 03:37:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by userp3030.oracle.com with ESMTP id 3dkkcyg8k7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 03:37:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BO3S7OTeUsCNpX9bbclvMm5gKFjxwFkmskY+v5QjkQ3QZxl1Sw5ZoKU4SaGevP8sOpTHs8cOH8iXAR9768P5d1JvyE+j2mMBBCw9Bg5kSYKY5DHqvaOzAp7XUPISl94DKt1vpa5UvCB/Fy7SLjwadN2DmB9/3vYEu4kWh+qlmKY/hruYtNAbd/e/+prv+02UuHQ1SgBWaTSm4Qq5QIk4BTX4LaQcHIfePo8yXOmYQ4SDtfAmBy4GrtJH++2auLW6NGBE4eg8Q80k1tngvbiQ8VpxbQmRTXPFbtRwqsI60vNvTh0/RTfe8CULvUmIskMWatwBFmja8A4JW1TibozTig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgTv5/VEpNg+//O8DT5eOyt5pFExb8FzxycchF5Zo0A=;
 b=XTh+lb2nGhNnvJOuKcZtTmWJ7jMJZLmdRaYRGYOITbBivuAItPq+qUD6DX2ab/KqKe0+CCv86AZbfJyhKuC/cuXdG8M6nGZK0mu4LPZ8flGOJUNIyG+siguVvbb8Z3KEI+qkL2o1n97zd8eUlwV3kM5QnVsIpNxyAd2mHN3/aYQ2G0VzMq4SvOxLzfuHXQ/b9ELCl4RD36/FGLS3dNeFCpxx2fuz6a6TcgaRNk6qlGC8oa+nuW3MjJ8MwKb2HJfBThe3oRchPDkFUcoAzHkLXFs9Mb7LF5fxs4FQLCzspj8490t9f8oFG2Gxq7hJeeNkrIC0Rn6DrFABgrtwqoIWNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgTv5/VEpNg+//O8DT5eOyt5pFExb8FzxycchF5Zo0A=;
 b=YYP6I21cLYRaFpJFHtyM4Dqi7CWyIaha8805BlSsLTSPqa2CpFxCgo7p4Y3dGJPiorpBDTbDGYZWdbPFUHkuicf8Duu/mRM6XgsiE5E7+BczN8xots2aydD33/zLyKFmPBeS66Ux6H0rApco6RmlDTHpCv4Sna1j2UxQyPk52WE=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH0PR10MB5001.namprd10.prod.outlook.com (2603:10b6:610:c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 03:37:26 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166%7]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 03:37:26 +0000
To:     xkernel.wang@foxmail.com
Cc:     bvanassche@acm.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
        alim.akhtar@samsung.com, avri.altman@wdc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: ufs: ufshcd-pltfrm: check the return value of
 devm_kstrdup()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1czkomm52.fsf@ca-mkp.ca.oracle.com>
References: <tencent_4257E15D4A94FF9020DDCC4BB9B21C041408@qq.com>
Date:   Tue, 18 Jan 2022 22:37:24 -0500
In-Reply-To: <tencent_4257E15D4A94FF9020DDCC4BB9B21C041408@qq.com> (xkernel
        wang's message of "Sun, 16 Jan 2022 11:06:49 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::12) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae9ec49a-6533-493c-b6eb-08d9dafd02ff
X-MS-TrafficTypeDiagnostic: CH0PR10MB5001:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB5001A8259F1F04C153ED91928E599@CH0PR10MB5001.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k7Wbq9mbb1bTkJ8p/8AbjOtozt1nzcr/tKiYK8lnOJ1KsmPBZgqFdDj6rqLSitiaFIBCDoVdF/033y+ctBxe9Svbjl60cJZb8GtFGdOH7BgvxEPhPPuupUPASFmtKT3SGNv26s/nG9fRWvV77fyimpHIwFY9BgHoOmpyYMsMnZHyQh0zDea+JA4aGZdEBX2+OM4v3R5iDq4ApoKJplZZJQBEJBewLyPcDb96LogYn9s7TIwd8FsslpVn9wHfk+5JdPOLqVpxhbcA3LHLt9HOLexvT9SqE6gtM2sFsAvYtr1/nw19/+XMUfacOhYbueRzn9OmQ69wG8sVYQrhBnqlRKoPXnSTDoXPUy1cBDVZEjiewuK+61hNgdmNVfRPMQzMpJGDf4eJFZxKqNCa1cIEnnpMLU540DL03oMxDjH0rKVjh2Ik3e+qMc0pu4IsjxYXvJFr5Tfd6woK0nnfSbDTgkbT3mhHJ1FWagIJVhx/05TKB1C7Lddsh8FnwQZC+V6zWU1+pSFgQNATXFAJv3uR4VevZ1D/XmwUPINXP4pRTSYvO3XN36nLjVEVv5QpX65GLJayUg/lPBh8LcSs7XLEtxy35eAUZCIAGGcN6Tq2OKeBlzUltiz5kpwevPVtxuwRZAsSm295Nx7v6wUgrSexQGC/T/+Xb4p0+qmL8MMfAudztryyCmGWB1PQa8lQg+oaYYzSQX0MceYRKcqVDIjlXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(186003)(6506007)(2906002)(36916002)(66556008)(558084003)(66946007)(38100700002)(6486002)(508600001)(38350700002)(52116002)(86362001)(316002)(5660300002)(26005)(6512007)(8936002)(8676002)(6916009)(83380400001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UzcQ1R0Zxn1ybDIpfzph8c/i/TSZ1rVihHH/DhYGGw5NDd2oYitU21FkKP8N?=
 =?us-ascii?Q?XJCWccNPxcyF8uQgjjmr9m3F5NDFtBxetE8MerXrrCI5nVZ7r97WD5w9q6Kt?=
 =?us-ascii?Q?zzd5Vx4Du0cEZT/bCKQcPleJL+d7Hds8UVP2gKYvYj6K0vQD7vsjcMRKNxYQ?=
 =?us-ascii?Q?LMul8Xq1+gct1vKsAWz5azbiDwzQNliPeHUGWgcggbHUUeioZ2TL5Icke0yS?=
 =?us-ascii?Q?6CjAlqidSz2/7bfG055tnOPQdovJwjKBGW6boSESy1H0KTVmlzFswDmQLYPv?=
 =?us-ascii?Q?ZrDi0gbRMWIJaXHZeUk/A/QO8IE6/0TFTQFn06+mDGDfTllrsLSrkvII1JWQ?=
 =?us-ascii?Q?lXYNnt3ullF9yvLAw0tkc9m18tNnC99HTmY5E8kf7lofKBvxrkHrn5CflYpc?=
 =?us-ascii?Q?iIDgrbfiXWJGBp1rBU/UCPXn7BOA2fR1Mk5vLZM5X5DdonERdectRucNWjrL?=
 =?us-ascii?Q?MlJVSCp8qVB90u2pcRQTVfJQnztxx2eIzPOQn9lvq+CbfwGSBIunPfHMEcIT?=
 =?us-ascii?Q?tFRs/LyO2qroUZnZNHXtCn8fPFNhNSpefaWqEgRQ4Tlown8YjlOJSvuYnoUO?=
 =?us-ascii?Q?7Eot7fWRulb37KzreKmGUawl2r5rqLMG2NX+OqMB4UCY1liKj8/LofLDwFk0?=
 =?us-ascii?Q?oslsvG5tHflOz6JIhm/MIYd/higPdRFgKYixv5yxn6m3u3uHvWWCAY129Gm8?=
 =?us-ascii?Q?7YCoU8vw+O45IYMmvQlXKqOFEXYtwaw8qlUOvViWjbLrZxal6fidUHgvsRv7?=
 =?us-ascii?Q?IpabAlGRhgkrNAVNRrYox2TwnfOpibZ8u2974LzJL7HNkA57a1OcOZfKLoXm?=
 =?us-ascii?Q?OSTC/x/ZU7ujW93pnRmkUGJokjuZms8GVoN2y++JA7sJ7yniRdE+pL3MeQ0h?=
 =?us-ascii?Q?nkEp1el6AWcfuSgrAZ9ONv27JmUzmdSmkIIL7aa2t3/fSVUDEhD9vEc3Xyqe?=
 =?us-ascii?Q?v4LQxl5dOcEyDE8MW0ItTSKXtG/QG7txpTuVYb6xRm41BYubvzRBS5Q0PWeD?=
 =?us-ascii?Q?S7TjhKnBFj9sTR1MdFtVLScwRe+DlX5ekU62Diylo/oz8Aany52tVjbM+cTI?=
 =?us-ascii?Q?p+nN77h7VibQb/Fp8oorVVBtm7IfhLCno6sj/icpgBd+LX1uoqBjJeAqi44A?=
 =?us-ascii?Q?m+3jB3VVf6xNC1NGzLJAxN0fgsTxHt+ZbBhbQqjzYuMn7yDAIQc6/Z7uxDXF?=
 =?us-ascii?Q?/u3ly2KyqsnXv6B7vwlqZO0MVRV/w1ELKMnofPiQhdY0Zf6E/BHqxq3dXHhr?=
 =?us-ascii?Q?P3CPVntiKzG0mNJpjy9tGDXh1Y/tjc2l/SCnJ7pdGcA0w47onkAyDSxt2gv7?=
 =?us-ascii?Q?KYNMesp/p80wOoxd20iOomVbBeK8y5Ar0tS0Toj3tAi8h2sS22OftvcKz6X6?=
 =?us-ascii?Q?whcqX4m76hIYzFEdu2pj7Is585gpD/uR/QvCbD8GEiCU0ri7mGKrYO3AMilq?=
 =?us-ascii?Q?z+KjZxumGNXm0Yu7y0vBrLneffvgMcoD/bxhp1ueZAAFXxfqCcTOmrq9VIO9?=
 =?us-ascii?Q?axso92Dym6OjfqSHzBr105rKdRU+jiWKbnK+XwbOsrWkueS87kGc4i1M6qIZ?=
 =?us-ascii?Q?40KZ8LF2opMVLNlg6w3KjcTlu/vVQkmBTf2ZjHDAO2nocaSwJmix/eazNVO+?=
 =?us-ascii?Q?e7Rzj2DZYXpxP1GAXsu66/0gQh1DPCBO4lsI0shqrzjWxzYCgTbdym+OdODO?=
 =?us-ascii?Q?YQcUQg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9ec49a-6533-493c-b6eb-08d9dafd02ff
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 03:37:26.2936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQNdIPnTa9bBNiTV680OshSGv++HbvSg5eMFxU2UO7I1GuPuPTlBkZmdUtsNxB9dPrCKkDuwYrMGLlU6g+ByujKUY7Ya8RYu9lu1AKgbf6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5001
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=661 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190015
X-Proofpoint-GUID: GgsCd1Fezyerrygnv02RMbp3wRKSDX_0
X-Proofpoint-ORIG-GUID: GgsCd1Fezyerrygnv02RMbp3wRKSDX_0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> devm_kstrdup() returns pointer to allocated string on success,
> NULL on failure. So it is better to check the return value of it.

Applied to 5.17/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
