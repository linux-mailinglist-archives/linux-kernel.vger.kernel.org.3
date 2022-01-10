Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBA548907F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 08:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239128AbiAJHDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 02:03:03 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41282 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235119AbiAJHDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 02:03:00 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20A1QAtA006855;
        Mon, 10 Jan 2022 07:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=BwUzYQ4FsM2Zo9egPqGkGRYmZPq7as8B9Hckp1lD4Gk=;
 b=dxHCdHTLNXZ91QWGbfCDV4Guk4xy6a+GteD8qRAKjvYsMKIdaaC7wo/WfKqtfSp52L4a
 9Es3BPKZiEvP+uZ5eWAtSVZqU1yJIwm054pU4VdZxC0XY+uzQKyfprRyAtgplRvIFyYE
 c8YkwbCvq7Zaj6sSPJ5x+R2wqaje9IVDCowCDAyD6hlCQQ4vKttYlrffvBa2tTGlXz5O
 iWWr1HCUgOWdi57dvoocTTs7+8C8dd5LpMdFDo9oFl5fAisb4fAPtzMXAdc/dqhCo0QP
 yWOP9G/mv3ljhwBsqNsJyPMegacuPQ7MVChz7yGcwjKC9lcR6P0CK7QJHGHBM5zM4AkN mQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3df35u29m4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 07:02:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20A70P3e128109;
        Mon, 10 Jan 2022 07:02:19 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2041.outbound.protection.outlook.com [104.47.56.41])
        by aserp3030.oracle.com with ESMTP id 3df0nc6qe8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 07:02:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKFFSjGAkAuL5YHAoZdFv8f1YA1fNylYThL/srMtBynaqLBMak9UnWbpJypcAMB44JboAvcMrmoue+xo5MKwj37c/G09aXDKYNFLCtFp44KRvjYXGVTcOOq4aVhqDN7kdPT3shEJ9viYtKeJId7GvlSRbJ2MS1zRa/xepqiqPM/ezSQ5Xt1+CzNNeoSmExjSrZlLjYTjER3WhW05hpM4fofHFEELlJMPaO+8Qon6heEeQ0vJGt3K6SuhIoU19EO6ZVAa2RUraC0YwZe7drXJJoibnUrcrsGvrDxAmJT3ZJtGG+3MXO4OKskB6I2nj6mmVdqkXfQAisnGyZZlfCKI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwUzYQ4FsM2Zo9egPqGkGRYmZPq7as8B9Hckp1lD4Gk=;
 b=ndMzudBZtFUNUmcBVlVhXVgQLoYKG07U33PKjVuKX67XXJKtwiCRWi8IHoCmYcNOH/hn4L6DbQMSGG2UHrr8me+EbzmK5bxDhbJdMyTOiODZ1VXi13vqDixjDIedQ6oaeEh+tQGDAxA9Xt4EfNwgP5ZfgIOAs6XJuhaZi9pUtGs1uXkr/SYjrcwxTrdNGGNhGlzntuNcijsDupFyVGyTrI6FIoLta+V0i2AAJI6ztCHQlSvRpFmvMymKg/qlf0IuPY+npQsyFslHxM4zM15MyReUqn06CCk8fYX2yNfLPaxP8jVS5OkMN4rImmHnZsGUxfVV+inDV99sTH25fIkBaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwUzYQ4FsM2Zo9egPqGkGRYmZPq7as8B9Hckp1lD4Gk=;
 b=wSBi0J2aUt0WqAS8W6vpAJgERXTNUHr72GWZsMri9bHhmL4AkMsC/DkssPClxI3kkC75C+AdoyWv3+s892Sw7HfjglZyAW+tmh2pppcTguMZx+M5MYclCO9bbmQrng8FZdecvLjojFm5/9oGKIDFqOsy7r+L4aDwT1dYxX2Az6s=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1294.namprd10.prod.outlook.com
 (2603:10b6:300:20::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 07:02:16 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 07:02:16 +0000
Date:   Mon, 10 Jan 2022 10:01:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Christoph Hellwig <hch@lst.de>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Smart <jsmart2021@gmail.com>
Subject: [mkp-scsi:for-next 67/132] drivers/scsi/elx/libefc/efc_els.c:73
 efc_els_io_alloc_size() warn: sleeping in atomic context
Message-ID: <202201082354.iAG3UuiL-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0041.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::29)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a33ec916-7ea0-44f7-ba2a-08d9d40722ad
X-MS-TrafficTypeDiagnostic: MWHPR10MB1294:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB12944919F3D526271D0C47668E509@MWHPR10MB1294.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:175;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nYM0kEfk7uqFkKS/CEIH9nO6vK5fLieM5BTuqhj+JOatKpgqruodD0Rs7zAWi0CY+wBeU8uyDgxuao2xPmoj+q53EWXq4XODUANxCOc9mXSExGELb+oj0q/hKdRynDgr9BPEPfd+YrMHHCZvLWUZfut3qH04Ve9dODfeE/G53lkesJ0BrjpHamcEf3Gh5Awh2ynGjHacdV/VlCKcBgAGIrz7EnCtsPf1OzjdJ9pdbAw91wlhfXNCsGRVDrojemGvP3G5Q6yRFYqmPyiRJOhaxpRwrdNUhTXOFHC1pzFG6eHDDjflWMMVXs6vozicB1fhCkrnpRAXlcXnWkBrG/wIz5jJ3SvbqzUQxqaeDHAPQB5XvD8mFjyjzZ/GfgSmFydv7C2CmkPadiDXX+NUU8R1H5YMo9JaW6qa3iBM/rIzbJKFLlosfLqi5MIo8EiDz5b24NDdN7TznuYC2GTgZ/3usxtkt+vKEoYklcvE0rxRAVwk4bs3+RdUyem8ZwQFs82taW6cI3IEVY0lHXgm2qIy3XQF7gJfDEgVACdRlAvum7g593LbFss6uX8IbriCIQFShTz1XGxfhk/wdptGlZJ/8FY74nW0Ak4dgOuXyUTCmYed0Ffv6R9qs2epghYEMZdaj9IsLXOG+GVIV6hdEsV+vTVMjjnLrYR+bKtXZfsxqpt/6SAj8zaWT5SwHkSdDI9ktyWYlfmy5i4fE/e4TS9Arg6jyUr//m/69IL7+vXCemCOWFynrP04ggjVM7XUbi+KKTQOAmuSoxbINe/qi3KR8ZTQ7nXE0jN6rSoIVINMSxBjo/5pPc4uwLglzx37HAzBFJ49aQ3xO+m4IyIlSydkvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(83380400001)(36756003)(54906003)(66476007)(6916009)(508600001)(66946007)(6506007)(44832011)(6666004)(1076003)(6512007)(8936002)(26005)(2906002)(8676002)(5660300002)(4001150100001)(4326008)(9686003)(86362001)(66556008)(6486002)(38350700002)(38100700002)(52116002)(966005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Ko5iXK/EOJs1VaxGWxlqtB5TiCjbQF6t+Iteh54kGOZ2+nRrR2kTSK6y3pF?=
 =?us-ascii?Q?9VGLlrVZLg3UxEI6Zwwb4bKKYsB1ohddHKdRzBSVF0+DkRsoDoO9i1Da/JDa?=
 =?us-ascii?Q?d9hkSLDpdpSomTrkdDZBv5d0U7xjNrfSFwqI7EAVcxVwW5nF+kI1uXs4OU6w?=
 =?us-ascii?Q?mhMyQLEbuh+Q4E0cnjawgfjELQxNxSnJt4Kwb8GBSrDBV1DAJnIPgOLVgWYB?=
 =?us-ascii?Q?B+s6f5osutOQNf2rJ4qR+RyoDHpHJUsWVwSBo7eORd6bfrtvPh8KU6R7HNRI?=
 =?us-ascii?Q?NhI0JIdAe4unPh9RF9xMm+z77XLreZOf2y5OGZynGLKlum4rjEc7RwbaGgAX?=
 =?us-ascii?Q?0aqw8j6FRL87BYD8jrcvCSJtwwBAL2JEBqYhvdN3E5J6uh7FC7ET4VhpACId?=
 =?us-ascii?Q?nJhCNKaRBMBuebr1y+ta3yngGLgZAKWze/X+RZxRZJeXN5tf+9D87EleoV+S?=
 =?us-ascii?Q?65o0Reo/o+HdG4HgffKDTqUk+KyGz0rTXNGVIIjKjKHu3Wnx99SbuK1w7XsK?=
 =?us-ascii?Q?tK+LHG7zdxLGchqkvHD3oSWtNtbNlhn3PoBYDxw9LQ5+t0/6WSAABlNiGzyV?=
 =?us-ascii?Q?OM4KMDIXTD6r9dFbzIYKpdJYGclmCEUuyz3K92mJSusWf3ri2z9nTncor8eV?=
 =?us-ascii?Q?C91xf5mWk/j45wOIaW0nbMsAotczMxeZV+M6WDbkVnHhAL36U1KTlGyzKU2/?=
 =?us-ascii?Q?AX5L3it5oLURFXYFnIRHpKaTGYDmBk/A3jauomsL5n9CFrjUuUxmIK1jhbIJ?=
 =?us-ascii?Q?K4v68YzRQbg30qM0bz0uZAtrfQYKltQYbLf8yOCzZf4iIJzXxJuia8YYfIaP?=
 =?us-ascii?Q?S+ed+4Iy19wbC96yA6HWlW+UrXHIYJZrVPM7jrPbrJ7teK27PMuMLoO9EbIn?=
 =?us-ascii?Q?61kDYfTtszugH4x7I4/vZhYx9p/Hz7Bx7LkljpVhg1S9S41x03guNCIw8gLQ?=
 =?us-ascii?Q?aJWQ6yp16/gwegFrVQ448kzr92zit/H4aYzqEA+3e6p1vPnJD19gor9D9L/+?=
 =?us-ascii?Q?NAjl/qExNPVKwfdVHrmaufv+7ZuTPNAwTbsLfa25r0V5+vWwmIO/rc+JfWH1?=
 =?us-ascii?Q?a06InuJAuaoOZfAGG6BiDo47zAKwwmRr2Ss1KYylwo7F+eGpZHbcR3R5mzlm?=
 =?us-ascii?Q?toc6SBMQ5FtQWJRYeMy05EqXrWE3+EoBm7puBRVHf7IimmKG04uAZrrfVzaF?=
 =?us-ascii?Q?xF9iNjm9F33TyE1O8rIZ5S5e5hFdTR3fKqHpkUyBCrjOeFiQlhpuIxPmjeph?=
 =?us-ascii?Q?djZxNSL2HzrvEkM7dtiZqnlMU0+xAHtvfxYcoTrE8dFqLUvGAc/16YgDSgpz?=
 =?us-ascii?Q?SezSQQnu3OyC3U8OsTWOIjbgApnvDT7M/96hRvyyQ1t67V3ryBld46P1B+gy?=
 =?us-ascii?Q?4k/eaxsqT4ZcM7QkKKCPKZnJSNjUcR10pCJeAG0oMb8U4H5v7OSRSt8aJ56v?=
 =?us-ascii?Q?iJ2Qg9iQ9upY6d+AqPWYrnRUInQHSjOxtRp6ckvx3E400/8NIhGgv8suGg6Y?=
 =?us-ascii?Q?5cQSeougtIh2UZgv1ykqoI+vFH1QAYni0FDUw24AKfmM6jp9BQWFws7Fq1h0?=
 =?us-ascii?Q?ikIT1ZWCRT92dELJb8kNtKAUpHXSxhO8Mxjm+Q+81C9cUh9LIk7YfXY2mnqx?=
 =?us-ascii?Q?LVV5P0kEQ+cUC0T9cF9nkO1FbNkBNNu9zsGOixkxIHoopI3osweBidj4ry6K?=
 =?us-ascii?Q?4sKKEiJrlT7wo20mD0Nkagvco3k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33ec916-7ea0-44f7-ba2a-08d9d40722ad
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 07:02:16.3024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHEdMXNQ7K/6rcL1ZbO2V6sYg7xIPB4wUo5CfqwCkAhE00pYq4+n7c+CXtv4mm7Oh/zSZ3doVFDr1aUdnH/7Hfgxpz4omutb9e01y4922Gk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1294
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10222 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100048
X-Proofpoint-ORIG-GUID: cvxmtgYW_rUlMFV9blVU09QZGDx6bmf6
X-Proofpoint-GUID: cvxmtgYW_rUlMFV9blVU09QZGDx6bmf6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
head:   315d049ad1951cef02d9337a2469cac51cca6932
commit: efac162a4e4dc4cebcc658e02676821ca834b56c [67/132] scsi: efct: Don't pass GFP_DMA to dma_alloc_coherent()
config: x86_64-randconfig-m031-20220107 (https://download.01.org/0day-ci/archive/20220108/202201082354.iAG3UuiL-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/scsi/elx/libefc/efc_els.c:73 efc_els_io_alloc_size() warn: sleeping in atomic context

vim +73 drivers/scsi/elx/libefc/efc_els.c

8f406ef728597d James Smart       2021-06-01   40  struct efc_els_io_req *
8f406ef728597d James Smart       2021-06-01   41  efc_els_io_alloc_size(struct efc_node *node, u32 reqlen, u32 rsplen)
8f406ef728597d James Smart       2021-06-01   42  {
8f406ef728597d James Smart       2021-06-01   43  	struct efc *efc;
8f406ef728597d James Smart       2021-06-01   44  	struct efc_els_io_req *els;
8f406ef728597d James Smart       2021-06-01   45  	unsigned long flags = 0;
8f406ef728597d James Smart       2021-06-01   46  
8f406ef728597d James Smart       2021-06-01   47  	efc = node->efc;
8f406ef728597d James Smart       2021-06-01   48  
8f406ef728597d James Smart       2021-06-01   49  	spin_lock_irqsave(&node->els_ios_lock, flags);
                                                        ^^^^^^^^^^^^^^^^^

8f406ef728597d James Smart       2021-06-01   50  
8f406ef728597d James Smart       2021-06-01   51  	if (!node->els_io_enabled) {
8f406ef728597d James Smart       2021-06-01   52  		efc_log_err(efc, "els io alloc disabled\n");
8f406ef728597d James Smart       2021-06-01   53  		spin_unlock_irqrestore(&node->els_ios_lock, flags);
8f406ef728597d James Smart       2021-06-01   54  		return NULL;
8f406ef728597d James Smart       2021-06-01   55  	}
8f406ef728597d James Smart       2021-06-01   56  
8f406ef728597d James Smart       2021-06-01   57  	els = mempool_alloc(efc->els_io_pool, GFP_ATOMIC);
8f406ef728597d James Smart       2021-06-01   58  	if (!els) {
8f406ef728597d James Smart       2021-06-01   59  		atomic_add_return(1, &efc->els_io_alloc_failed_count);
8f406ef728597d James Smart       2021-06-01   60  		spin_unlock_irqrestore(&node->els_ios_lock, flags);
8f406ef728597d James Smart       2021-06-01   61  		return NULL;
8f406ef728597d James Smart       2021-06-01   62  	}
8f406ef728597d James Smart       2021-06-01   63  
8f406ef728597d James Smart       2021-06-01   64  	/* initialize refcount */
8f406ef728597d James Smart       2021-06-01   65  	kref_init(&els->ref);
8f406ef728597d James Smart       2021-06-01   66  	els->release = _efc_els_io_free;
8f406ef728597d James Smart       2021-06-01   67  
8f406ef728597d James Smart       2021-06-01   68  	/* populate generic io fields */
8f406ef728597d James Smart       2021-06-01   69  	els->node = node;
8f406ef728597d James Smart       2021-06-01   70  
8f406ef728597d James Smart       2021-06-01   71  	/* now allocate DMA for request and response */
8f406ef728597d James Smart       2021-06-01   72  	els->io.req.size = reqlen;
8f406ef728597d James Smart       2021-06-01  @73  	els->io.req.virt = dma_alloc_coherent(&efc->pci->dev, els->io.req.size,
efac162a4e4dc4 Christoph Hellwig 2021-12-14   74  					      &els->io.req.phys, GFP_KERNEL);
                                                                                                                 ^^^^^^^^^^
Sleeping in spin lock

8f406ef728597d James Smart       2021-06-01   75  	if (!els->io.req.virt) {
8f406ef728597d James Smart       2021-06-01   76  		mempool_free(els, efc->els_io_pool);
8f406ef728597d James Smart       2021-06-01   77  		spin_unlock_irqrestore(&node->els_ios_lock, flags);
8f406ef728597d James Smart       2021-06-01   78  		return NULL;
8f406ef728597d James Smart       2021-06-01   79  	}
8f406ef728597d James Smart       2021-06-01   80  
8f406ef728597d James Smart       2021-06-01   81  	els->io.rsp.size = rsplen;
8f406ef728597d James Smart       2021-06-01   82  	els->io.rsp.virt = dma_alloc_coherent(&efc->pci->dev, els->io.rsp.size,
efac162a4e4dc4 Christoph Hellwig 2021-12-14   83  					      &els->io.rsp.phys, GFP_KERNEL);
                                                                                                                 ^^^^^^^^^^
Same

8f406ef728597d James Smart       2021-06-01   84  	if (!els->io.rsp.virt) {
8f406ef728597d James Smart       2021-06-01   85  		dma_free_coherent(&efc->pci->dev, els->io.req.size,
8f406ef728597d James Smart       2021-06-01   86  				  els->io.req.virt, els->io.req.phys);
8f406ef728597d James Smart       2021-06-01   87  		mempool_free(els, efc->els_io_pool);
8f406ef728597d James Smart       2021-06-01   88  		els = NULL;
8f406ef728597d James Smart       2021-06-01   89  	}
8f406ef728597d James Smart       2021-06-01   90  
8f406ef728597d James Smart       2021-06-01   91  	if (els) {
8f406ef728597d James Smart       2021-06-01   92  		/* initialize fields */
8f406ef728597d James Smart       2021-06-01   93  		els->els_retries_remaining = EFC_FC_ELS_DEFAULT_RETRIES;
8f406ef728597d James Smart       2021-06-01   94  
8f406ef728597d James Smart       2021-06-01   95  		/* add els structure to ELS IO list */
8f406ef728597d James Smart       2021-06-01   96  		INIT_LIST_HEAD(&els->list_entry);
8f406ef728597d James Smart       2021-06-01   97  		list_add_tail(&els->list_entry, &node->els_ios_list);
8f406ef728597d James Smart       2021-06-01   98  	}
8f406ef728597d James Smart       2021-06-01   99  
8f406ef728597d James Smart       2021-06-01  100  	spin_unlock_irqrestore(&node->els_ios_lock, flags);
8f406ef728597d James Smart       2021-06-01  101  	return els;
8f406ef728597d James Smart       2021-06-01  102  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

