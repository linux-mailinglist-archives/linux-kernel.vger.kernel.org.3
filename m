Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FE349B054
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574181AbiAYJca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:32:30 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:38044 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1573499AbiAYJYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 04:24:10 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20P6WBNP019284;
        Tue, 25 Jan 2022 09:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=L0Ia5Chwev/j/EZgq1pKlFt33QISvvwzGSUs8tawmAA=;
 b=Fo6gR4vIgmilmg+lmZZx87GA1eF8s0R/LrWVWf3WaEcIwuOmenai48C71uFMKbE2qyFQ
 qUMPZuYyKkJPxUFDF1sPqcDMGgJ7wSRvH+ROCniKeKJglKE7PDCCG6ZHE5XBhjsMWXl8
 LgGH00483+aIYLnilwkluOpwbw7BB4QqUJDYuAGDpYG5KJZuDsLzE1ouMHStenon7UzB
 5dRbyRta3FCauq2PM/2x8c/1Z/B5o2m5JDrtQeT15kJLJ7BnpqSMbVU5KktBQPkGu5m+
 /mDOdVzIiF9wVYv6wcJoe2ks3lmCw+yPIzWFO4oJreLjYU8uoA/pWkM/PWMGQ/Wu7oiY SA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy7atg0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 09:23:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20P9Av22015123;
        Tue, 25 Jan 2022 09:23:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by userp3030.oracle.com with ESMTP id 3dr71xbtjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 09:23:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7v8MeMYjxlSd7/0XamVmIZUcAZgF6lim2++wsPpkbUd+8Bm61mA10y5d64opeMtF80wK8NwCs6RJ6GU2qSR3xTA77UwwLCwOsoe8f957iDA+TDhf+Q27BASFbrXb3DSS9DiT9CuhEhPVT+QZ5KDVUM61uorfUNE7r0z6hEIOsozy1IzaoTmFnR03LWuhK1e6Hh1mIB1fW8QD308aIo8SR+3gfmuhJVKXty5LONl2PHBfYJVJJLUFGbNUuFfZejxUBYj8Vw67MT+gqaTDCasPLz2cz65fGv7QK1ODBSbwfSdfYdhScY0Ev2Sw1w3PKDDXf2hxKHiG3e7GGQWYg+7Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0Ia5Chwev/j/EZgq1pKlFt33QISvvwzGSUs8tawmAA=;
 b=M3MUJ4xtjSygtBQLAhuu0VNMZveWrzWjI+G+UbHUVPqWr8AyPcvZmhJ8eS8uRom8CQzXbKuyydGC78oCw6Ez6oA+z1E+7TscYPYFEhxRuNOdeJcGoCAyvK7lkXU/JOSC41AYRmMATsPyGgUAd/IKVQPxCrWHPy8sZfoiXAp4S9VmxhMRHWa/wPQyP6lyyhh+N3JPklwG8gCVRdKSEMMfgZX1Nl0pb1aj/k5RY5ASKOE/72yjPhz9cYOzwt4WSYfx8NCoM0FOKqHbxuSnmEKtCiXYy51YPFmSCCJ9g/PywpbgEilKwobLLgDukZTOJ0cELXgYWDfH5M2OdNVIxckn3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0Ia5Chwev/j/EZgq1pKlFt33QISvvwzGSUs8tawmAA=;
 b=SeBkorq+resietdrVG0Kc61FGtiNl6bIdJqy39dsnmo7VxoNPsdNkzEDu2NeEeWHHSLettGJdl0sFib/cd9UNA2BMps6gVCtZvoE2ndjBZl2zqpc1rPCXk/XEbzfY46pBm5Q+28rXhjQ6ldbZFbepTXyRyDBOU2BN/8XUAh8MFU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1659.namprd10.prod.outlook.com
 (2603:10b6:4:8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Tue, 25 Jan
 2022 09:23:53 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 09:23:53 +0000
Date:   Tue, 25 Jan 2022 12:23:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Allison Henderson <allison.henderson@oracle.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [kbuild] [allisonhenderson-xfs-work:delayed_attrs_v26_extended
 28/30] fs/xfs/xfs_ioctl.c:1753 xfs_ioc_get_parent_pointer() warn: maybe
 return -EFAULT instead of the bytes remaining?
Message-ID: <202201250715.EbP8D1XT-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: GPHOHELAK6AMHPQIYWC5GUNOVXQVQQMP
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0013.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 624757e5-3d69-4a2d-e9b1-08d9dfe467a4
X-MS-TrafficTypeDiagnostic: DM5PR10MB1659:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB16592EAA619B2DC53C281FAC8E5F9@DM5PR10MB1659.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vG+rK198sl9UnvSpOgoivE5h5Hry/RDtOVrSFzrabo6E9CJC3W8pdxxogn3WKQ/RyAc+rAjvQSUEOBcJxDwQkWdQ3elB/9hTcXI/iW2hlVxVnkwq8EMO59OO+9BokZsDdQSfLgIvsa4s6qtvUKGkn9VUmuJbjp191hy2SyciKbkSPcy167JbNmfwJU9BWf0Jc6CYcztMA+g6gBC4BsqjOitnFG5zfseN2xzkAj8ywq07hHWyBtJmCKOTv4ojqjEZ48o+UZPHoCPq/hvKUYdrUHCHxbIZealPTGw3Z9JZFO3zT0klqrwfMq/SBy88ILxrrHh6bnBH6fodiYMPbPfbmvEtB7+bvmfNPBILNCILWiHcSQytRVeqMHudLHb6zp+7eIVm4PER5n34TpfcP0oXlc3TQUGxWTm0ep6xCk5JJDqvaZvqUp+7TbV8JpsJDc/qNKk7V7+ATs90c4Y9SPhkVDlClytXmTH08f0Lx+dBB3os+Hag/2nyIXR8I/f/RcdtyMoaPUGX+r0xNqMJiPPJDPEzmwhqHHLedKYJBNoYsi/af4rwgb2gkOnhxQ315marDZanF8rxPKpsRfvKV6NpiwSS2SE16qRZSdTk6SxUg2rvm2sK+2OE/iDxWpE/X9cP2kPOPakZsTSbdWi9mJpQpHhfhc4qNl85NFNuvw3p64hoBw+8j33xLqOsPkkZXy2hCtOlNGkCaT7flDgM+zKQGeRlwBwIQ2R+S76FW+OyUwv7HWHISUA6l6vM2x/vxtvAOLU8Ia2F7m1wJnUnr7C2x0fXsyEkxEd/fXOOL1wvXJ80XsIAyeIp1RZk6YwaNT092MgYp9kDPBM7ZA5W7OJVug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(1076003)(2906002)(38350700002)(508600001)(8676002)(86362001)(66476007)(6666004)(44832011)(8936002)(52116002)(66556008)(6506007)(4326008)(38100700002)(36756003)(966005)(6512007)(9686003)(83380400001)(316002)(6862004)(6486002)(5660300002)(6636002)(66946007)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PCo9n9KRZ1qnTl4xUPeXS8u4mlCPfvUtwC1XlhRmx/N1mSxfiVY4iSSvPUQ1?=
 =?us-ascii?Q?Bf/zOEsD9eKrTmYTHa5ENtHf447+VRzse4c+wqhIUXa5bCyY/TG9/v6fZymb?=
 =?us-ascii?Q?gHdjd/qQC6bkhTtc3TiNElsrBbVCdJkbaTIS48uoHWFVdrMcNVJOb2T78m18?=
 =?us-ascii?Q?RURjGBcFvLPgIMSqS9AboRgL1uK6AU5JwKKeWwvVjVFvL16G49k+UqScEoPq?=
 =?us-ascii?Q?pB9pJdhyWaOQzSp9+jJUyqYX/Rt/tDP54YQQ30rdz9BCKedD/8SGp/B+Cgci?=
 =?us-ascii?Q?vKP2NebbmJo/FAYDBc3WBbIB25/+T/dgCweGoaovbd+IGjMsm/YtvPlN5tPl?=
 =?us-ascii?Q?lQM4NFfZMfO9BxKN6i2bCuqD3IVtsUywBbuLqkaIAZmWd6jMhiOvsIQI7V8h?=
 =?us-ascii?Q?+NUYmWpwv02anwablZrwuyTGQ7tPZhwnvH90WVRgi0CbchM9Wa6jggV/TGbQ?=
 =?us-ascii?Q?5zCUrdm831Fzqso/2U3fXfrsKyT4TmgwseMWRilEpkeVD5QCJht2xlYOBfGs?=
 =?us-ascii?Q?V/+y2yGAHXTS4tSco97d2uEnHcUctXnjQo+zdzJZ9iUxgkgP8Ejp1mk8Rm7G?=
 =?us-ascii?Q?luLYHsJ9Io3hIcckFcnxGEpmmbPWnOQCv7ayk6Ic2HXWaNZ5MWPrh+WGPb4O?=
 =?us-ascii?Q?GojUFPbSP4eZ5qzkolUKwRhBIxSCStd/d7RlWQiEU3pCs5BfwaHesFNYP+Xr?=
 =?us-ascii?Q?tQsosm1Gv3cxQLs+0gVHrtouaOuxDyy1f1Fgey9P2Eh/oihk/LI1xVOzdyXN?=
 =?us-ascii?Q?gVUa17rDPduDNBvQL/9ggCgrGsW3p5P2by2XhSuiTqCkd0aKrXjhc4A652rg?=
 =?us-ascii?Q?A9oIXliYZwbePKgtIfJV93Jo0wA2uJV1qzvzDKyHBxIJqyK9N9scCcxv+RiN?=
 =?us-ascii?Q?o99kjlxv6GD9WOGvD9Hnc8DtQyW36w/fY2SzIOKnSUmAIrXnq9iJbKSBG4IC?=
 =?us-ascii?Q?ItW2GTeSoEux5tYrKSqCnHe2B0yhMQPKxDx40c0JJMGsx5ywOT8pMebU1wqi?=
 =?us-ascii?Q?nFb3EwEz8/zjpPQLdGj7iNkcsxOuI5N+qWNVy9CJY8TvPYInqh+eGRliFGTC?=
 =?us-ascii?Q?PIkQDo7m/cGJj4sEwp2c4egSBoWRfNX3Wx4gJMHx7gbdyOJRzLSA9iIR02YW?=
 =?us-ascii?Q?xWdYkjnJKbLqZzuYTS4zRSRA3Yt+8YhgXgsvHffdbf6Ph8Kb0qkZTvPSXb2d?=
 =?us-ascii?Q?MyYY6cuK0Ns6hth2s1TP0GGKcmsiPMMbF0jsWJY7LydfzTG68MknYeulvpiJ?=
 =?us-ascii?Q?w5FMRf9Kk6eOORyN7Hi6HeSP9Wyop53w0gZqGgPksETfZqtMZw6lwyIkFrP8?=
 =?us-ascii?Q?90TViif3d5XdPicF2xgs+VuRdii7kHgwSm++Cch7WijgomAgpKqXqvdaXL+4?=
 =?us-ascii?Q?SwI96fcBnOE5O8Ro8MD7H3Zss0usdR1MfDsWg/hZV73K0yZCK5ngEn0KNfCN?=
 =?us-ascii?Q?pBsRDGKV5uBfLO/jYzgKuG/MnwgJRsU04AH3ylgUvRpF+i9JeSAjU4doSBvH?=
 =?us-ascii?Q?5jKvU7mTx/tRtDSpxhVkWqFNt886tZ/PteYjUVywXB7I0My84UP6YZxC26AR?=
 =?us-ascii?Q?qEor0RfmftHlSW3EtVXj2HWz+aStyawk9Ggh0WgrZVSSwUMwNb0n0WQFFVQ8?=
 =?us-ascii?Q?4Gmxhczv9U4FKG1EUzPu3SpNlpByVcXJNlK0xsvBrEt5DhUTqA8WRLdXEvrJ?=
 =?us-ascii?Q?ke0qE2DasUuibZtvMIlPKXXFsuA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624757e5-3d69-4a2d-e9b1-08d9dfe467a4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 09:23:53.5752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgFJuo0T0FzVN6meyxYWNHjcyICVp8TD+X7fczEXKeSXQtw3/n65WbcpMla3OELXThqU2nNVERr76/qjC6mCp2jSVrS426GSWV4pbgtTryQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1659
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10237 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201250061
X-Proofpoint-GUID: WPMg_hSKUpELa6CtRZia7JuqoVIIViez
X-Proofpoint-ORIG-GUID: WPMg_hSKUpELa6CtRZia7JuqoVIIViez
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/allisonhenderson/xfs_work.git  delayed_attrs_v26_extended
head:   19459f5cfa422b0a6a9cd3898892e43ecb49f8f3
commit: 38f492d29e0c25066170d87572b7ade7bf2af72b [28/30] xfs: Add parent pointer ioctl
config: nios2-randconfig-m031-20220124 (https://download.01.org/0day-ci/archive/20220125/202201250715.EbP8D1XT-lkp@intel.com/config )
compiler: nios2-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
fs/xfs/xfs_ioctl.c:1753 xfs_ioc_get_parent_pointer() warn: maybe return -EFAULT instead of the bytes remaining?

Old smatch warnings:
arch/nios2/include/asm/thread_info.h:71 current_thread_info() error: uninitialized symbol 'sp'.

vim +1753 fs/xfs/xfs_ioctl.c

38f492d29e0c25 Allison Henderson 2021-07-23  1686  STATIC int
38f492d29e0c25 Allison Henderson 2021-07-23  1687  xfs_ioc_get_parent_pointer(
38f492d29e0c25 Allison Henderson 2021-07-23  1688  	struct file			*filp,
38f492d29e0c25 Allison Henderson 2021-07-23  1689  	void				__user *arg)
38f492d29e0c25 Allison Henderson 2021-07-23  1690  {
38f492d29e0c25 Allison Henderson 2021-07-23  1691  	struct xfs_pptr_info		*ppi = NULL;
38f492d29e0c25 Allison Henderson 2021-07-23  1692  	int				error = 0;
38f492d29e0c25 Allison Henderson 2021-07-23  1693  	struct xfs_inode		*ip = XFS_I(file_inode(filp));
38f492d29e0c25 Allison Henderson 2021-07-23  1694  	struct xfs_mount		*mp = ip->i_mount;
38f492d29e0c25 Allison Henderson 2021-07-23  1695  
38f492d29e0c25 Allison Henderson 2021-07-23  1696  	if (!capable(CAP_SYS_ADMIN))
38f492d29e0c25 Allison Henderson 2021-07-23  1697  		return -EPERM;
38f492d29e0c25 Allison Henderson 2021-07-23  1698  
38f492d29e0c25 Allison Henderson 2021-07-23  1699  	/* Allocate an xfs_pptr_info to put the user data */
38f492d29e0c25 Allison Henderson 2021-07-23  1700  	ppi = kmem_alloc(sizeof(struct xfs_pptr_info), 0);
38f492d29e0c25 Allison Henderson 2021-07-23  1701  	if (!ppi)
38f492d29e0c25 Allison Henderson 2021-07-23  1702  		return -ENOMEM;
38f492d29e0c25 Allison Henderson 2021-07-23  1703  
38f492d29e0c25 Allison Henderson 2021-07-23  1704  	/* Copy the data from the user */
38f492d29e0c25 Allison Henderson 2021-07-23  1705  	error = copy_from_user(ppi, arg, sizeof(struct xfs_pptr_info));
38f492d29e0c25 Allison Henderson 2021-07-23  1706  	if (error)
38f492d29e0c25 Allison Henderson 2021-07-23  1707  		goto out;
38f492d29e0c25 Allison Henderson 2021-07-23  1708  
38f492d29e0c25 Allison Henderson 2021-07-23  1709  	/* Check size of buffer requested by user */
38f492d29e0c25 Allison Henderson 2021-07-23  1710  	if (XFS_PPTR_INFO_SIZEOF(ppi->pi_ptrs_size) > XFS_XATTR_LIST_MAX) {
38f492d29e0c25 Allison Henderson 2021-07-23  1711  		error = -ENOMEM;
38f492d29e0c25 Allison Henderson 2021-07-23  1712  		goto out;
38f492d29e0c25 Allison Henderson 2021-07-23  1713  	}
38f492d29e0c25 Allison Henderson 2021-07-23  1714  
38f492d29e0c25 Allison Henderson 2021-07-23  1715  	/*
38f492d29e0c25 Allison Henderson 2021-07-23  1716  	 * Now that we know how big the trailing buffer is, expand
38f492d29e0c25 Allison Henderson 2021-07-23  1717  	 * our kernel xfs_pptr_info to be the same size
38f492d29e0c25 Allison Henderson 2021-07-23  1718  	 */
38f492d29e0c25 Allison Henderson 2021-07-23  1719  	ppi = krealloc(ppi, XFS_PPTR_INFO_SIZEOF(ppi->pi_ptrs_size),
38f492d29e0c25 Allison Henderson 2021-07-23  1720  		       GFP_NOFS | __GFP_NOFAIL);
38f492d29e0c25 Allison Henderson 2021-07-23  1721  	if (!ppi)
38f492d29e0c25 Allison Henderson 2021-07-23  1722  		return -ENOMEM;
38f492d29e0c25 Allison Henderson 2021-07-23  1723  
38f492d29e0c25 Allison Henderson 2021-07-23  1724  	if (ppi->pi_flags != 0 && ppi->pi_flags != XFS_PPTR_IFLAG_HANDLE) {
38f492d29e0c25 Allison Henderson 2021-07-23  1725  		error = -EINVAL;
38f492d29e0c25 Allison Henderson 2021-07-23  1726  		goto out;
38f492d29e0c25 Allison Henderson 2021-07-23  1727  	}
38f492d29e0c25 Allison Henderson 2021-07-23  1728  
38f492d29e0c25 Allison Henderson 2021-07-23  1729  	if (ppi->pi_flags == XFS_PPTR_IFLAG_HANDLE) {
38f492d29e0c25 Allison Henderson 2021-07-23  1730  		error = xfs_iget(mp, NULL, ppi->pi_handle.ha_fid.fid_ino,
38f492d29e0c25 Allison Henderson 2021-07-23  1731  				0, 0, &ip);
38f492d29e0c25 Allison Henderson 2021-07-23  1732  		if (error)
38f492d29e0c25 Allison Henderson 2021-07-23  1733  			goto out;
38f492d29e0c25 Allison Henderson 2021-07-23  1734  	}
38f492d29e0c25 Allison Henderson 2021-07-23  1735  
38f492d29e0c25 Allison Henderson 2021-07-23  1736  	if (ip->i_ino == mp->m_sb.sb_rootino)
38f492d29e0c25 Allison Henderson 2021-07-23  1737  		ppi->pi_flags |= XFS_PPTR_OFLAG_ROOT;
38f492d29e0c25 Allison Henderson 2021-07-23  1738  
38f492d29e0c25 Allison Henderson 2021-07-23  1739  	/* Get the parent pointers */
38f492d29e0c25 Allison Henderson 2021-07-23  1740  	error = xfs_attr_get_parent_pointer(ip, ppi);
38f492d29e0c25 Allison Henderson 2021-07-23  1741  
38f492d29e0c25 Allison Henderson 2021-07-23  1742  	if (error)
38f492d29e0c25 Allison Henderson 2021-07-23  1743  		goto out;
38f492d29e0c25 Allison Henderson 2021-07-23  1744  
38f492d29e0c25 Allison Henderson 2021-07-23  1745  	/* Copy the parent pointers back to the user */
38f492d29e0c25 Allison Henderson 2021-07-23  1746  	error = copy_to_user(arg, ppi,
38f492d29e0c25 Allison Henderson 2021-07-23  1747  			XFS_PPTR_INFO_SIZEOF(ppi->pi_ptrs_size));
38f492d29e0c25 Allison Henderson 2021-07-23  1748  	if (error)
38f492d29e0c25 Allison Henderson 2021-07-23  1749  		goto out;

This should be

	if (copy_to_user(arg, ppi, XFS_PPTR_INFO_SIZEOF(ppi->pi_ptrs_size))) {
		err = -EFAULT;
		goto out;
	}

38f492d29e0c25 Allison Henderson 2021-07-23  1750  
38f492d29e0c25 Allison Henderson 2021-07-23  1751  out:
38f492d29e0c25 Allison Henderson 2021-07-23  1752  	kmem_free(ppi);
38f492d29e0c25 Allison Henderson 2021-07-23 @1753  	return error;
38f492d29e0c25 Allison Henderson 2021-07-23  1754  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

