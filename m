Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46101493490
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 06:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351592AbiASFkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 00:40:47 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:54174 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351560AbiASFkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 00:40:45 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20INww4v031897;
        Wed, 19 Jan 2022 05:40:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=543Y0BN1cSsWAGyQI+JYNidb00Y7/X6LZiIOYQBahzk=;
 b=ZGjJcxq0TQJbC1+RXhB8yOriF0CbZ4ijsdtZbgHJvXJG8d0oRvZsj2j29sPPSA8JuPNi
 UCAItOJs81mqZk3QR6jeaFvGloZOWNxUUAxWlGLcJ01x1suctYHL5iL/u8hUfe2Q5pDx
 sgNjrGB1ZULMrT3omQhjIirLRTQq1H6HOgCL+oC5jXfet8w0sklv/s4e2EIqNneXIzG7
 HtZ/+MxENNoISRtO23QkiyPj20rLYJjF7nQe0YTjaXhLbpChe81iP1OdR3Bpw6FXaNvH
 RC9DsqcnCUcMuE7yxSncB4RS1ujJMoKkj9lq2JmmMWMeA9Tqt2DusCt1B4qk8fuMOmOj tg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc4vm26s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 05:40:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20J5Ua3u086065;
        Wed, 19 Jan 2022 05:40:21 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by userp3030.oracle.com with ESMTP id 3dkkcymm48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 05:40:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nns8MdMPj53hx7JGPSImjdBs4KuHO3n+xd3qBeXqlpuzxooNs/sS3aJI91MWp5WfHygqOAJklGSFmHNSr98wS82yAXXwd4TRlJGXrgR3V9cNVv1pSCBqKZ6tf7/yx2uoPr8hxJXyz1WQwU4/uXelWVmxCeSgpGNGHQQIUjVhIlQnw7gFSPZT70YpBawwfOHUmZSAxwgEJr//WXoLCjwbN0ZFa7vS/OVvVkMY4myFgCz/ukIrJA7U9c04LNi4Uopxmo7f06PdUC+p9EkLKMIhIsgrzSYRFMsQ1yZPaAHY207MrlM+vEbv5M952KSux6ql68hjqOBWUuHvwcnSY8H4JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=543Y0BN1cSsWAGyQI+JYNidb00Y7/X6LZiIOYQBahzk=;
 b=LlgGoc5u/xXdAR7UkKru4FassUFT6WaqqDiqe/oKf2twiYLHT3sQbus8Js/jxANMyrnPknBcmJ2ET/dMr9/HgOkloetFjCPfE1YRwEiZeynO9s5oLfBC9CMnO0+H1xFH5nnmY1qakucMxF0dskrnRt0Ne7pNE5W5yi+0LU3CrgJ0ad7ioaiwrGaRHamtEJIFKa/vtc5shL+nBj4kSG4ZOy+eJ1VIn3MLSZBVupB+VYOL1LTAo+lH7+1VhcFhbVugE68Hm3Jgw4+H1BfvErrca+gNEC5FeYUPjn/vo6tz+5dqyHGQUAxskhRH25J8LkWDNQ1WkdCgW8ylFog8ZGJ6Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=543Y0BN1cSsWAGyQI+JYNidb00Y7/X6LZiIOYQBahzk=;
 b=IDoj8GHMjpm+fpU1Ol4XX49fPkwbrxK/LPcmMgN5oqfnVTubyo0fWol6m1FqwTWTRWHS5ScHi/oAoI4SCtyItJignBYQfKfJWV2mDaxrggBKgLN9BfJ9c3ut+QPUkIgMeDNVLQ4soSl7jfUcLC/rD1WGfdrp/7L9UM5wj/VoRwQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN0PR10MB5253.namprd10.prod.outlook.com
 (2603:10b6:408:12f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 05:40:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%5]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 05:40:18 +0000
Date:   Wed, 19 Jan 2022 08:39:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Ohad Sharabi <osharabi@habana.ai>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Oded Gabbay <ogabbay@kernel.org>
Subject: drivers/misc/habanalabs/common/command_submission.c:2457
 hl_cs_poll_fences() error: we previously assumed 'fence' could be null (see
 line 2430)
Message-ID: <202201190048.qRDA3uFx-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0029.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc6851d5-241b-4639-1bab-08d9db0e2cbc
X-MS-TrafficTypeDiagnostic: BN0PR10MB5253:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB52531D6F8FD296596F0CD9798E599@BN0PR10MB5253.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wKmN+JGW/mOSGKbHE1gDwRo4lDLHqbYB6l8JjowlWkPJ+nRfNMG1aAW0MeasW4dgTw04bKWGwi5wCVfcvtJZRjH0pnozhXYkEtEyK9xGjUoF1gkOW6EQosLtNL6T6Gj+Taq3MIod41YIhPcrt02G0lV0swc/aRrg0tGZFsYR9nnEcwKbHnaMmrjVDug1ZovCl2aVmmLsqaPPSlaoWBhyjZTeLupPgVhzLbt/jzR1qAopWulNW+Z28RU0BocC9qGR7XZBXqgEgrA721MshF6FK+DAqZkchGP1f8icQyZ6HOBlkz0msfz3mBDvJTpDR7PmMVGjRq5byjBxpJwFmr+kijsEVCY+h60pbJmo9NlU4T4Wki5A4FBRka68y4vMixZhK/p4PIrXbX6oYeR98YqpiWWH03T/W5o0lsB2DXMRNK0/3LRMDswSmxM9OAwWowW9GJLQVdfPg9vX7fDG71A+zJDRZEWpJ8r1AA0BbkxSPDMWVUuaeb8yxfEfkn+IO2Vlh+x1SDzW3ZT6ZzP7Eqlg1WIrjdL6T6ne9Bv+H347D1UK3goZ6K336zhSa0Mz4AXZvc1dzifc9CuCVQ95UPpv/EFrHEqhKSsQurDyldwDWYaSfB47vHCWT/BAxaXzbWcymVi6fqZO0J5gpIY2qhDA5o1EW1nH7L64R2jZxrJNuDbOh4pamVQ5MdVIPGP3RlypUqU/+TFuUimfA7SZff31ulH+xRjyEePd8YeOjdSnY147d2/NiILL+FXcbIEJNhICHjl7inCg96k2oMM2ctGoBbJLRyiKX0sdZI2QJQ9XJQkYp3GEzVDzGHx0DYR3fJjDbI9vL2smPeyNNxQSW4ucng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4001150100001)(38100700002)(66556008)(66946007)(6666004)(38350700002)(2906002)(5660300002)(66476007)(6506007)(1076003)(6486002)(6512007)(30864003)(9686003)(316002)(52116002)(26005)(83380400001)(186003)(4326008)(44832011)(36756003)(508600001)(8676002)(966005)(6916009)(8936002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n2o2rwK9OTRrm7qbIHUwD/lokFX/l9/rrn+kDqNNGPMuFNg3t+CeBWDFrm4c?=
 =?us-ascii?Q?4U8/MGJ1ndPxIWEnwf5MHESqREVTB83WM42uRpljCp71a5TYtZaDB6A319mf?=
 =?us-ascii?Q?yXE9izQNiLi0/gS2blQt+3MslnYeLap1Bf6e9WkXnxlxvGgK9MfvsyVyOgpd?=
 =?us-ascii?Q?BRMqOFMTjrEomSXzI3ivWvP9qWTBfdeEC/9ZPGUE/9AQWk6DcwS2+BIoDHoL?=
 =?us-ascii?Q?PgTAg/FEdWROIcg1+lzOX60bZtTfPltnSBT7Gw30aHPwc40w/mDQ0jqMynco?=
 =?us-ascii?Q?CimL3StnUKSDe2bq/sZx9TobmJI8CI2d9fKXjv0dsjMI2GjpxUIO6QX0cEST?=
 =?us-ascii?Q?V4fnVHKN84jIMjgfSUF0s4fSD3MShro4ijOyNW6gBVKj/CVVDyZ0z/VTCrb9?=
 =?us-ascii?Q?6D1jWIqwhpigNcxbj9BLTCdZDRQ5xoW4kPD3jVGdOTokoC31cOPqxt+yt22P?=
 =?us-ascii?Q?+ddPk3uikxO89LPdHm090ngM9wwTasXR/OMgowOiMPja7d85PZxR0Yx82RtT?=
 =?us-ascii?Q?WEAev/F77IukGwTtPIusnIr/aM5sFvg0gL8HLJ21yuM4JioFJ2Z7RbfWEZF+?=
 =?us-ascii?Q?Y/pOct/7CAnFMlzACptBfYXzvopdQPEWaZKXEnV+em4CrLeO22njhLGEZTRH?=
 =?us-ascii?Q?AEHrIjLrDQ1O+mVHk1pOFhaLe0peD+Izl2wz0YXa+oZGUrbuvHTQmb31u8CQ?=
 =?us-ascii?Q?1bXT50EdV2LEWA7QRNui2xWUcz26q2a934zh4V1K9kwvYkJ1z2v4wQUKKolw?=
 =?us-ascii?Q?Jg4ORyXmWihGWw2jqufQ6VdIpTjiWhmZ4tehjzjOvpdsCNQ+sZnGLNLRcYox?=
 =?us-ascii?Q?cyzLPxlTD6h5BzmTnd/XN7lq7ToxCqJY1LxURzmeZQCPOfaX/tywZz2T69wS?=
 =?us-ascii?Q?xHI3hdn0mneQYakQ1+W7y0AlNiR8ctvUiXczIykxrLTpwacImhM63mNaMGHV?=
 =?us-ascii?Q?hoKKsuvwTHBK8giZmlccQB/qA1IU9z8mdkAPLWznv/aEXVXwW/vUElSBpSw/?=
 =?us-ascii?Q?q/9EwlyMNeU/88khKGTEH/7iUMyEmYo0WBOA3WkWoWyPj4m+pcCZ3A4ND3S4?=
 =?us-ascii?Q?PQS3XGlTmV11cuXHkH5De9EBntDtPnHvOVrYz5/OAgDLkaGdQzxr5QHDDrZ7?=
 =?us-ascii?Q?mKz25duzrHXbQwxXBboMOg8uhamMRgY0Y7qlud0eS4C7tUe8oHk4cgQ/q0gu?=
 =?us-ascii?Q?144Il/vs2eA+C3sRvCO67lTdGPHS3FidGBmGA2zBVA785/+IkH/rCfwwwjTl?=
 =?us-ascii?Q?bXNxw3/QUWpQym23HtTZ18Yg9ATkm7AKd5pyScz1ZigA8oNQZ8eNBsCBY8I+?=
 =?us-ascii?Q?etnTm2/qTUzQ1TYLsrQg9xkymOk045cf6ip2yK9GpoVFFOwL6X95RQrnGV0N?=
 =?us-ascii?Q?MfUEcNE4Kn0npzPJ1J4G9QGRazSpgdRrKAuYLCfVMoG7LELNFGxgPJjbjtBp?=
 =?us-ascii?Q?nZAcqVYodiVdWnJ43IwWcP7cl6LJj943ZiIZYn1ppLxxq6pCnUfzlNSEnwi+?=
 =?us-ascii?Q?ggQNZgnqmJiufu4SwzqAD0fQMhNthx6H9LPZPTy4FfxhPF7gQTOeS5LrhdOn?=
 =?us-ascii?Q?tClkAoiof4T3duIs7VCWnFyshnZ8xpWocdPbxqjtWqehjM+M/5Din0LfNN+d?=
 =?us-ascii?Q?yR3YePiVHjjwEuS7QgdxH508yKMaNfRfITzCnatvvR1JNeezrUIZm2JvKw2k?=
 =?us-ascii?Q?9PTgy0Cl6nHDd0SOakzILYZlKCQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6851d5-241b-4639-1bab-08d9db0e2cbc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 05:40:17.9467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IyhhOXCBh5afE+1XXrrCfPdxUMqhbRQ9Us/cnhrwkRPWnFDWtLK7TYJXds3rVF/YN4ui1vGqEG5tUOLQP8MWfbe9QT+4kqtR96b1siU3JdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5253
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190028
X-Proofpoint-GUID: 0GSC-7tIUkUqUner6PvlNPjYTDpHH3dL
X-Proofpoint-ORIG-GUID: 0GSC-7tIUkUqUner6PvlNPjYTDpHH3dL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   99613159ad749543621da8238acf1a122880144e
commit: e2558f0f84d85bfe2407b91d57798f133d8ad32a habanalabs: prevent wait if CS in multi-CS list completed
config: s390-randconfig-m031-20220117 (https://download.01.org/0day-ci/archive/20220119/202201190048.qRDA3uFx-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/misc/habanalabs/common/command_submission.c:2457 hl_cs_poll_fences() error: we previously assumed 'fence' could be null (see line 2430)

vim +/fence +2457 drivers/misc/habanalabs/common/command_submission.c

e2558f0f84d85b drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-12-07  2383  static int hl_cs_poll_fences(struct multi_cs_data *mcs_data, struct multi_cs_completion *mcs_compl)
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2384  {
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2385  	struct hl_fence **fence_ptr = mcs_data->fence_arr;
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2386  	struct hl_device *hdev = mcs_data->ctx->hdev;
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2387  	int i, rc, arr_len = mcs_data->arr_len;
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2388  	u64 *seq_arr = mcs_data->seq_arr;
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2389  	ktime_t max_ktime, first_cs_time;
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2390  	enum hl_cs_wait_status status;
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2391  
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2392  	memset(fence_ptr, 0, arr_len * sizeof(*fence_ptr));
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2393  
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2394  	/* get all fences under the same lock */
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2395  	rc = hl_ctx_get_fences(mcs_data->ctx, seq_arr, fence_ptr, arr_len);
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2396  	if (rc)
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2397  		return rc;
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2398  
e2558f0f84d85b drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-12-07  2399  	/*
e2558f0f84d85b drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-12-07  2400  	 * re-initialize the completion here to handle 2 possible cases:
e2558f0f84d85b drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-12-07  2401  	 * 1. CS will complete the multi-CS prior clearing the completion. in which
e2558f0f84d85b drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-12-07  2402  	 *    case the fence iteration is guaranteed to catch the CS completion.
e2558f0f84d85b drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-12-07  2403  	 * 2. the completion will occur after re-init of the completion.
e2558f0f84d85b drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-12-07  2404  	 *    in which case we will wake up immediately in wait_for_completion.
e2558f0f84d85b drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-12-07  2405  	 */
e2558f0f84d85b drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-12-07  2406  	reinit_completion(&mcs_compl->completion);
e2558f0f84d85b drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-12-07  2407  
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2408  	/*
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2409  	 * set to maximum time to verify timestamp is valid: if at the end
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2410  	 * this value is maintained- no timestamp was updated
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2411  	 */
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2412  	max_ktime = ktime_set(KTIME_SEC_MAX, 0);
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2413  	first_cs_time = max_ktime;
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2414  
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2415  	for (i = 0; i < arr_len; i++, fence_ptr++) {
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2416  		struct hl_fence *fence = *fence_ptr;
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2417  
e2558f0f84d85b drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-12-07  2418  		/*
e2558f0f84d85b drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-12-07  2419  		 * In order to prevent case where we wait until timeout even though a CS associated
e2558f0f84d85b drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-12-07  2420  		 * with the multi-CS actually completed we do things in the below order:
e2558f0f84d85b drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-12-07  2421  		 * 1. for each fence set it's QID map in the multi-CS completion QID map. This way
e2558f0f84d85b drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-12-07  2422  		 *    any CS can, potentially, complete the multi CS for the specific QID (note
e2558f0f84d85b drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-12-07  2423  		 *    that once completion is initialized, calling complete* and then wait on the
e2558f0f84d85b drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-12-07  2424  		 *    completion will cause it to return at once)
e2558f0f84d85b drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-12-07  2425  		 * 2. only after allowing multi-CS completion for the specific QID we check whether
e2558f0f84d85b drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-12-07  2426  		 *    the specific CS already completed (and thus the wait for completion part will
e2558f0f84d85b drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-12-07  2427  		 *    be skipped). if the CS not completed it is guaranteed that completing CS will
e2558f0f84d85b drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-12-07  2428  		 *    wake up the completion.
e2558f0f84d85b drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-12-07  2429  		 */
e2558f0f84d85b drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-12-07 @2430  		if (fence)
                                                                                                                    ^^^^^


e2558f0f84d85b drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-12-07  2431  			mcs_compl->stream_master_qid_map |= fence->stream_master_qid_map;
e2558f0f84d85b drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-12-07  2432  
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2433  		/*
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2434  		 * function won't sleep as it is called with timeout 0 (i.e.
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2435  		 * poll the fence)
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2436  		 */
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2437  		rc = hl_wait_for_fence(mcs_data->ctx, seq_arr[i], fence,
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2438  						&status, 0, NULL);
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2439  		if (rc) {
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2440  			dev_err(hdev->dev,
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2441  				"wait_for_fence error :%d for CS seq %llu\n",
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2442  								rc, seq_arr[i]);
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2443  			break;
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2444  		}
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2445  
b2faac3887df87 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-12  2446  		switch (status) {
b2faac3887df87 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-12  2447  		case CS_WAIT_STATUS_BUSY:
e2558f0f84d85b drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-12-07  2448  			/* CS did not finished, QID to wait on already stored */
b2faac3887df87 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-12  2449  			break;
b2faac3887df87 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-12  2450  		case CS_WAIT_STATUS_COMPLETED:
ea6eb91c09cd4f drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-03  2451  			/*
ea6eb91c09cd4f drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-03  2452  			 * Using mcs_handling_done to avoid possibility of mcs_data
ea6eb91c09cd4f drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-03  2453  			 * returns to user indicating CS completed before it finished
ea6eb91c09cd4f drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-03  2454  			 * all of its mcs handling, to avoid race the next time the
ea6eb91c09cd4f drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-03  2455  			 * user waits for mcs.
ea6eb91c09cd4f drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-03  2456  			 */
b2faac3887df87 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-12 @2457  			if (!fence->mcs_handling_done)
                                                                                                                             ^^^^^^^
Unchecked derereference

b2faac3887df87 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-12  2458  				break;
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2459  
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2460  			mcs_data->completion_bitmap |= BIT(i);
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2461  			/*
b2faac3887df87 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-12  2462  			 * For all completed CSs we take the earliest timestamp.
b2faac3887df87 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-12  2463  			 * For this we have to validate that the timestamp is
b2faac3887df87 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-12  2464  			 * earliest of all timestamps so far.
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2465  			 */
b2faac3887df87 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-12  2466  			if (mcs_data->update_ts &&
b2faac3887df87 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-12  2467  					(ktime_compare(fence->timestamp, first_cs_time) < 0))
b2faac3887df87 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-12  2468  				first_cs_time = fence->timestamp;
b2faac3887df87 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-12  2469  			break;
b2faac3887df87 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-12  2470  		case CS_WAIT_STATUS_GONE:
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2471  			mcs_data->update_ts = false;
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2472  			mcs_data->gone_cs = true;
b2faac3887df87 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-12  2473  			/*
b2faac3887df87 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-12  2474  			 * It is possible to get an old sequence numbers from user
b2faac3887df87 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-12  2475  			 * which related to already completed CSs and their fences
b2faac3887df87 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-12  2476  			 * already gone. In this case, CS set as completed but
b2faac3887df87 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-12  2477  			 * no need to consider its QID for mcs completion.
b2faac3887df87 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-12  2478  			 */
b2faac3887df87 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-12  2479  			mcs_data->completion_bitmap |= BIT(i);
b2faac3887df87 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-12  2480  			break;
b2faac3887df87 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-12  2481  		default:
b2faac3887df87 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-12  2482  			dev_err(hdev->dev, "Invalid fence status\n");
b2faac3887df87 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-12  2483  			return -EINVAL;
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2484  		}
b2faac3887df87 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-12  2485  
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2486  	}
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2487  
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2488  	hl_fences_put(mcs_data->fence_arr, arr_len);
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2489  
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2490  	if (mcs_data->update_ts &&
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2491  			(ktime_compare(first_cs_time, max_ktime) != 0))
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2492  		mcs_data->timestamp = ktime_to_ns(first_cs_time);
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2493  
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2494  	return rc;
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2495  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

