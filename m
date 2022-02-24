Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270CE4C2987
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbiBXKca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 05:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiBXKc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:32:28 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A4F1B8FC4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 02:31:58 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21O7iOI2006520;
        Thu, 24 Feb 2022 10:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=S3DCUTJYMT2taS0V58hCb37c5x2JpNw35jOWGVLLbPU=;
 b=JNHMdA0HGUt9Yp+SgoilfPndXryU/IoAEQqFYgnDVCvBLFM1GoFaocMHA16sxXRtpLmt
 F/wfHFcO0emyAm8HElZkAVaHyGR7qz0PqmD6NajAD2eY/tuSlSjmdK7ZZ8l/Zim6zrrm
 mHjye4zUnr7FosDmo/CdeDTtoYXFDx/hdQn46G/7WtIGzj0MFuXJ+pzZiPqG+MQnWBrA
 JbNBs/c9CJq0HlnVq3A6Qj+A6JOS/tr+U7eJCVc7agHRYk9lmRmusmsEKpbfeNYV4oEO
 zDSNRZ1q+sxVjdLFiAsXgGHQoOSJ9KCI8RP2ZBxypShajp3c9knudp8htldDTszj1dml /Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ecv6exujc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 10:31:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21OAGWkO006444;
        Thu, 24 Feb 2022 10:31:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by aserp3020.oracle.com with ESMTP id 3eb483e11s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 10:31:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHSUo53x7btyvS/E4yP1+ZPyCZXWifvdKOVj9fFopihPspxrIoJCZQce/Fmh6OzcXevgvSYjx2hAomSpJ5xYiBFvR16VBmZ/9guukDSCjpCdOC4BMQrAhvC/ee9GT+9j41g5bwSGZSj8YkKZsy8MBaeuhUIWs4RzTX3meOzeQVMVg38rl3igfLoVHrRUx+4y3p8kappqT8c3ePZutOaLLjiK8iKcATU9qcUOr3jruAeT64YHoXzjjOAkcZ8IrZWycTFOjAfevpe5bXqWQzLzmJWqcIlE0UcRD2CLwqmaO/9Aw8cq4QF3lnYKsG3alVWjutgviWKoIQv5A52QRIosxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3DCUTJYMT2taS0V58hCb37c5x2JpNw35jOWGVLLbPU=;
 b=SqAbz/xg6KboEiVq3KpY0AXp5pTKFURR58IP0A6+o8rH0ZrNujrdUlyxcwPhb0WKmoNXf1aQIE+SJa4llMu+jcYrPl7CX6pzW5oFx+LrBjqHWZtFxeBb1uNRZcXf1SGu3vrAp5eyFf3/yjYL3bxEsxeBc3s3BZO9UqXJxQaLI7L8kvXu00M/wIzDfUJaIh6gpfK+jM/mDnG0LUzUmh9enBPuqHiuI5DLK0t8FP/ok0xbVQoQFM8jJ2xBS75F8SwMO0FrxZ7dDp/WbTPTMLzf6TU5lr/nkD7kCJ7d+OCRfF69fryCo4DoGAf4dzCdS4DTGTRJQag6Ak2t/1pkh48hrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3DCUTJYMT2taS0V58hCb37c5x2JpNw35jOWGVLLbPU=;
 b=V6j6BXzNik0cxCZa7Jx2+Ly88HvvT7ED0+woWbYRT0WrzqXH2VaV51pg112qYKD4naHQ8DJiQkB1Y9bGbL8EUfPGpFw40zL5s7WhobcXm5eUWj2QfnaGtSC8pDgocQe35px6O7uN/Y7IhZTHXub2yBo0x/P9uNi5c6VL+jQANsg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1756.namprd10.prod.outlook.com
 (2603:10b6:4:7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Thu, 24 Feb
 2022 10:31:51 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 10:31:51 +0000
Date:   Thu, 24 Feb 2022 13:31:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Atish Patra <atish.patra@wdc.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Atish Patra <Atish.Patra@wdc.com>, linux-kernel@vger.kernel.org
Subject: [atishp04:sbi_pmu_v6 14/17] drivers/perf/riscv_pmu_sbi.c:464
 pmu_sbi_get_ctrinfo() warn: potentially one past the end of array
 'pmu_ctr_list[i]'
Message-ID: <202202230110.onIE1TGT-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0075.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8fe634e-66c0-4a1d-e87f-08d9f780de5e
X-MS-TrafficTypeDiagnostic: DM5PR10MB1756:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1756242E468CBABB75809E138E3D9@DM5PR10MB1756.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4pm9dCudHmnehtC52xQbfZ1zc8AgNII9vAO5ppbXzb1FOzlVV7pf2LJpVnsQP5k7c2awpuQje57mV5xEVy+hO3FEHfoBbVUrSpjQZMRcs4fo7c5lAX3xCF6kJNp4a81xehTFd9GfCytVKo5f3C4r7p8Gl2Y8ZqhQizJFdUnqfxJBx3RELNDQ9DIi70+tbKg/mo3WaDd94uhFzQ9c4H8exje7kwF0IsTWuw9UEMtEFHg7xJKqv95tLvw3tLy7tulO3jXRSf3JBQEJOB7KoSB0EOWl5XrMOXeYEZo1jh5hmzodZo6dygWHyPFSBHvnDesZEXeNtNlq3zGL6NRW53LhwLKcwi7gERaj80/VZ9gJ1FfVlDLvIbskAlg6ypgEwlu2Bg9KVJ3K+d+77zOsvTrBZu0ktHfU++WiDzUCFfNm8Er8NxRoPd+zVAb5Sse9R6v4nsJVKd3Ee3Y+qFSBq7U7hv7sQzn3NbM+SUF+JbnS/SAYDKGBfVa4GVrJes4zcFl7HAqhk9Xo7tw0472cu8UFbCI3/uBewb+sxX8mAgN75UvqDDgALqoY6hmG8WCTdxqREOzabtVfR5SAkzxqTC+QeZ3gF+rql6QMmUEBKPDZeouwdQqB+GOBzmugYD969kUs/Z2NIqdFb/I5tjHEvIRJjtUj2UIen2jEbkIpG3fXJ5A49YAKEGggoBwmyiAMpY6kddyX0gBJpo8EoxoCNmUEZaNQv3CxUIBNU9aRjWCkKd2iHw+kCqRmSTzZ//arNRpKb2rVZOUj5gQDlFdYJnT+iGIlc9ZZshIXv1bJHwNVLiARH4P7Q1/8wHD7xXgr//wajspcaMgt28mrBaSGWY7F9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(52116002)(508600001)(9686003)(6666004)(6512007)(66476007)(66946007)(966005)(6486002)(6916009)(316002)(86362001)(66556008)(1076003)(26005)(8676002)(6506007)(83380400001)(36756003)(4326008)(38100700002)(44832011)(38350700002)(5660300002)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7K3WOG53KatHjr4MnN1Rux4ATz81FzdyTfp7oHcReZTv3MfBwjAiuLzT4KfC?=
 =?us-ascii?Q?ZhkRD7zO9vxAtLdRwUZZM0fz5/J8SLuW0UXo5pv+PtJy+LZs7RaBGr9qP7wh?=
 =?us-ascii?Q?RvlBjGRqeJMN/vuCtE5QDDpo1Aeem2IOlHt/1lmV7UxYdE1zne+4tLiVtDv0?=
 =?us-ascii?Q?bu8nNeWin4hkuIJDMSdr+jb58fTLl9IpQW3tVhAz9X8qe5QLDN0CPUeYnYd5?=
 =?us-ascii?Q?+lpDZZNqiruugi7nuazUkBVFOc7ADM8W7Ar0nZji626CjNUb9SyoJHfKTvG2?=
 =?us-ascii?Q?7U8P3yxyvsaowJU1wznCzeZWHrQL+zNhT/W6UYTLnay2sTuM6vaT01ReQxO4?=
 =?us-ascii?Q?2TCq3lrE5iO8Ih7G7wU5Pi1aF2rmggAvvOGuRQ3Bvhwa15Lym1kIibjUDTM9?=
 =?us-ascii?Q?/VVQiEf3vMdFapRki9dwwJt3wutf/aFU7h0bgoTtKPbKC1xnAzpJE6Ah3lGr?=
 =?us-ascii?Q?jcBXaQTbBOL6LhxaxAx5Ubk8mJd4uP7W3K8kdmCWYk6v/QZrNMtUdAc9y6S7?=
 =?us-ascii?Q?jPqe+7bkaOsISuwUD/Ng1CC/QbhXwT9LgQFI50uVBrE2XgRBheeIhU9cDsxJ?=
 =?us-ascii?Q?CLSLpd9EhSwoQWbm83fbiSUhNiBLhWwYSNhzlCb6clG2ytn09Kny7bzm4b3a?=
 =?us-ascii?Q?1+9rPDNhKKUOqCBole4S2whdHh+EMYHtX+RCj9SYFLqa92d/uM4ltigHLTvR?=
 =?us-ascii?Q?ilKi3QNRy2zgCHUKQGGzg+7fjahQ3C/R/RfABeJ7q/QwO7mzhMW7EXpIUDGp?=
 =?us-ascii?Q?TEGzznsP+YGEfsHEP4Rvo/OzH0Tm76ym+e/2a5G6foPkDsmrj3PcArUZ/3NW?=
 =?us-ascii?Q?yEdeZ7qEZGsH5Y4Vq4Bw/amEPh0u6pvc1Of1YG1QDvMzl9NShHV9r4z3yoJC?=
 =?us-ascii?Q?I5sHj+lI8hWqFsUj3afA4sMAMDTX5Fqp1Cu52Os46S5mnYZCks5BHf8L/gzL?=
 =?us-ascii?Q?nyPVV3M6Ek2jLJXQtZkDpfTqd9+GTMbxny7WXRl/Xav/yXFI+4pBZFw2mlpc?=
 =?us-ascii?Q?Scxjc3PHergMRxrZBSu9vzCBP/tC/0QGi1/711ER7SSJsjr8l+MBczdHdH/8?=
 =?us-ascii?Q?RdycOLnZoNKhRpiFuy9r0ok87uHxyuH8Avx7uKMsFGS9eutERF0S388Ntgly?=
 =?us-ascii?Q?/sdTVJjxZRISCeGqm9tWqnJKqJzAODh5tF36dN8YmzGR7Lug7z/4N9kSYbXf?=
 =?us-ascii?Q?FXIeGjnZRsRza8bpbLwIm/GBxLACd4MfZqw34Qa9ruXtAP4++O0u0TlW4b1r?=
 =?us-ascii?Q?P+iKUE0Tn9P6xMVwEQcTnUTtNm7xC8mzRno/7jDv2fRamVN/Dq+Ijd4mezg5?=
 =?us-ascii?Q?foid4kFiqAZfe3NYU1HuigDPaArDCHE49tGr+EOFsOH7huHUgNuaymkS0RST?=
 =?us-ascii?Q?I6Rvl0YLyOqtjKbbN536KsopONeDs8IJxgelg8eSal+NZv9Po5gRu/CLYvCJ?=
 =?us-ascii?Q?Npr4U8iN1RQ50a4PJxZSwXEyr29Jlhb4qLDR7Bh/HoQvkzeYj0Y01yMoInIK?=
 =?us-ascii?Q?dWf6WaT/icA9LQKsVNU3UWzcdbbUeOrpcSzXiuLjDUisuUi27TvjLENVCJ2z?=
 =?us-ascii?Q?cSi4ob34H0Fuig0d/E2npZ2AsnfQpyvxQX+lO2lRRqhWrb3L/VpSyn4pqnBa?=
 =?us-ascii?Q?MDO+cVXcvXkLIs9WemMD6WYN/fcET/h6U820Mmc1UHiDQMPZkBeAtTO0PSGE?=
 =?us-ascii?Q?7yuR2A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fe634e-66c0-4a1d-e87f-08d9f780de5e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 10:31:51.0147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Da9sdwOKIMoi6zyD3My9N/nX/luqXbH1Y+Nl44eBjKzVlaRE7T5J3K468dikSB9wvLJ5Wpbd1EgXchbC12mAXShfJysrPHuJExMIrIJr8TM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1756
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10267 signatures=681306
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202240061
X-Proofpoint-GUID: XqweDRGnpYoRSsuk_cuFQjhw6ZJrrIy1
X-Proofpoint-ORIG-GUID: XqweDRGnpYoRSsuk_cuFQjhw6ZJrrIy1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/atishp04/linux sbi_pmu_v6
head:   876094386d4f915d81ec2ee5b8b412987a10d808
commit: 626af3184b715c86adace38af397cf4223f2cb75 [14/17] RISC-V: Add perf platform driver based on SBI PMU extension
config: riscv-randconfig-m031-20220222 (https://download.01.org/0day-ci/archive/20220223/202202230110.onIE1TGT-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/perf/riscv_pmu_sbi.c:464 pmu_sbi_get_ctrinfo() warn: potentially one past the end of array 'pmu_ctr_list[i]'
drivers/perf/riscv_pmu_sbi.c:464 pmu_sbi_get_ctrinfo() warn: potentially one past the end of array 'pmu_ctr_list[i]'

vim +464 drivers/perf/riscv_pmu_sbi.c

626af3184b715c Atish Patra 2021-03-17  444  static int pmu_sbi_get_ctrinfo(int nctr)
626af3184b715c Atish Patra 2021-03-17  445  {
626af3184b715c Atish Patra 2021-03-17  446  	struct sbiret ret;
626af3184b715c Atish Patra 2021-03-17  447  	int i, num_hw_ctr = 0, num_fw_ctr = 0;
626af3184b715c Atish Patra 2021-03-17  448  	union sbi_pmu_ctr_info cinfo;
626af3184b715c Atish Patra 2021-03-17  449  
626af3184b715c Atish Patra 2021-03-17  450  	pmu_ctr_list = kcalloc(nctr, sizeof(*pmu_ctr_list), GFP_KERNEL);
                                                ^^^^^^^^^^^^           ^^^^

626af3184b715c Atish Patra 2021-03-17  451  	if (!pmu_ctr_list)
626af3184b715c Atish Patra 2021-03-17  452  		return -ENOMEM;
626af3184b715c Atish Patra 2021-03-17  453  
626af3184b715c Atish Patra 2021-03-17  454  	for (i = 0; i <= nctr; i++) {

This should be < nctr instead of <= nctr.

626af3184b715c Atish Patra 2021-03-17  455  		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_GET_INFO, i, 0, 0, 0, 0, 0);
626af3184b715c Atish Patra 2021-03-17  456  		if (ret.error)
626af3184b715c Atish Patra 2021-03-17  457  			/* The logical counter ids are not expected to be contiguous */
626af3184b715c Atish Patra 2021-03-17  458  			continue;
626af3184b715c Atish Patra 2021-03-17  459  		cinfo.value = ret.value;
626af3184b715c Atish Patra 2021-03-17  460  		if (cinfo.type == SBI_PMU_CTR_TYPE_FW)
626af3184b715c Atish Patra 2021-03-17  461  			num_fw_ctr++;
626af3184b715c Atish Patra 2021-03-17  462  		else
626af3184b715c Atish Patra 2021-03-17  463  			num_hw_ctr++;
626af3184b715c Atish Patra 2021-03-17 @464  		pmu_ctr_list[i].value = cinfo.value;
                                                        ^^^^^^^^^^^^^^^^

off by one

626af3184b715c Atish Patra 2021-03-17  465  	}
626af3184b715c Atish Patra 2021-03-17  466  
626af3184b715c Atish Patra 2021-03-17  467  	pr_info("%d firmware and %d hardware counters\n", num_fw_ctr, num_hw_ctr);
626af3184b715c Atish Patra 2021-03-17  468  
626af3184b715c Atish Patra 2021-03-17  469  	return 0;
626af3184b715c Atish Patra 2021-03-17  470  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

