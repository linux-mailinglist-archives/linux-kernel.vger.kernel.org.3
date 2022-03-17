Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BE24DC10D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiCQI0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiCQI0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:26:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2510DB4A0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 01:25:29 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22H8GQdZ001936;
        Thu, 17 Mar 2022 08:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=AOU691oDqFSFpc/0oa3XeGOLlgfzqlJ+wnFA6NJBOvA=;
 b=mv9mFYGzKB1gnWFE5PqNTtruIpch8Szed6oXcFStSslb8uq/+O2PILyYPJXfKqf4Q48T
 W7SbPRKMiedevZFnXG3ZcXhYpc2gyKwRetFicQaF5qDCxY9URleUpqWRXVBAshThZEp/
 w8zYajg6t2Q9GR4i89dQVGzWtQ7jO6HwiJ4uMtvTCBZvHavT5GKMTWPvYjbsfJh7K0IE
 KAaiTGR6hZ8Xjy8RCiut8RIdQtBvu3LKxVU9FOowcrCVZu7M1pIeIDBh5saqg1b/0MEx
 CfZQLN/inMq4yOgHwTa0/0CfwPLMLaKYACs1ZjPfQg7u4DT6tmgt0dc2XHpijm/vszjF SA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5xwr8u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 08:25:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22H8Gjjs121162;
        Thu, 17 Mar 2022 08:25:25 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by aserp3020.oracle.com with ESMTP id 3et64m5s4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 08:25:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wp7nzyGDbiZVpuGZ83m3WXb7Oy2inQHMf2MEKOl7jagfpK/TZA0sXiuMqepa4lxPI1qzw/wPR7HQkbnJCb6Zi9dKNgAneF2mObKDjbDh5Mk4Ms9CYqRX/EjGKU+hZF4n9FyJW469tHJciBJugHVnOwDBbSLo7lGmYqLzVDanYuMsGDh4Kkhya/eGwqf6omsDSn+O9w4QOB/LGy9ssDpXeb6LFOvN9Al3GDf/n7Bz/ywY6AO/xdIhFllmkmlRjYpKrBHHLpKI6t6C4c9QdZCBVrGwHxCInEIG9Ca1KvfTolwxqqn3Oo1tR36bTtHasRRfLkMAUo8DsQc2W74+To2URA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOU691oDqFSFpc/0oa3XeGOLlgfzqlJ+wnFA6NJBOvA=;
 b=INLZjbbxvBndUlXghp6M6xShoIOsAHU+Pa8IuZJbBVY8JqEtP4sH7CvqoJ702oI11/ETprugn+GHyw1hOXkdbxBmHPG8KjBeXNamwty8//6yEzRtSBfciCPdVC+fodwdEf/zO3yDImqrjC/kexSBnC1YDR43swxE6gC1VOkxWhdQ9oK6QIWGrCvgRjKZ3ocNVoaXjjpcvF8138KXiYZoE2vAsPmhWI2YmsA//4OeD8l2CSaqPW4MPFBl4Wstw7z+ZEbV5TEvVbBwtiCpeW9DxNOHJSB/xu8179p5lpl95CB83msM48dNX1kenUT4cXolsN4ksrPy8l1UVjawE5GTrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOU691oDqFSFpc/0oa3XeGOLlgfzqlJ+wnFA6NJBOvA=;
 b=J2GJmLgq5GwEHSIVcM/YFs53d1KG6DWEJMOkB06/oBKAHTZzX7mUVe4TfdeUZIWuSBPDR233vFY4XEpi7GVjhCZCPayprKgaJJL3rCB9Jasiuscvxjaoddod2I2ugTJ0Gj49ndXHnu8ko0SEeWtWyLU8A3ilezdrPVp/W33056w=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN4PR10MB5654.namprd10.prod.outlook.com
 (2603:10b6:806:20d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Thu, 17 Mar
 2022 08:25:23 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 08:25:22 +0000
Date:   Thu, 17 Mar 2022 11:24:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Andreas Gruenbacher <agruenba@redhat.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [kbuild] [gfs2:for-next 9/11] fs/gfs2/file.c:796:24: sparse:
 unsigned int *
Message-ID: <202203170954.vFlMcTje-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: W42IIGHFD2LWJARLL25XFIR4TNBTMIEI
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0036.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::24)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d2f1aae-7f95-4b9d-072d-08da07efadfa
X-MS-TrafficTypeDiagnostic: SN4PR10MB5654:EE_
X-Microsoft-Antispam-PRVS: <SN4PR10MB5654ECB42B416B106FB99BBA8E129@SN4PR10MB5654.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HuHVsMkd37yHH9uX6dA/mw8IfLaHa0Ed7UlypK7pYU9AI8/dokJ0xRfWztq4GEq7M5xphO1UEcz/vg+Zs2dBG9rcRVZ8WYkxiMSlxoYv9Nwn/2pLZJe7kl5c6NCUSU4+RnmZopPGycISvCAPHyp3+BJGrEWrPKHn3n3fsJFuCHR8+5ktWNbUJDky5VsIuBaI+AuH1mnRhcDmL6ctDpnvFsdja9snzJmYmezW5f/P7y3YUP6KiuuSvxzMq0gJ8FxfvP/sDON7GCRiHrWHDvixkSA5P6PLCj2/hQigIuDSpYs/CX0jfjoJ0KD2mVTRE4dRHhhxrg8BpQEUGUk+q+QG90nc5Mp7w+PIkSOHlDjZXQYjs/vQnQFblYD4dBdqxgon9FE5Cjhuc/QNbYESF3PKPT/eFCAopNWbUvzMaExkGNgDWVIhBSeiM/kux90sIzcgl+cAm/xPsSGKKhGwvhssxXrPuM1SUhSBNzC0GNc4Zgq2nvdeSepjgQMXagWXv+M9rO4f19bIGMtbXFqVpNZwk9Caxf1GZTAvG4OYULzDUfWLEmhIc9gS3y2rQ7TNO0Qn+UAPHaJ+ebuGradmHTU4F178l3Xv4ECa/3W1SnIdTH4dV8P32wXzTri+AOLtL8SS/U6VytD2ZNyPdNlkjV4BXRcvmJsSstAU+5PFt/moxvARxJCaXsnxNOfYzgna2a7VbfcMMbAW6rsJVlEqXTKmR3QS+G66T08TvtvnPrKqfdB3ho3AZ6bYYWrBh2fDmTJGeNK9iVEzjeR69egC5jMWoF2uElAAjja9rvtbMQ027kWovCbr7pV0a3UhuTjpm8ErpQzFczSevT8mfS8Rw689Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(186003)(316002)(6486002)(966005)(66476007)(6666004)(6512007)(6506007)(4001150100001)(26005)(8936002)(1076003)(83380400001)(6916009)(36756003)(52116002)(66556008)(9686003)(5660300002)(8676002)(38350700002)(4326008)(44832011)(38100700002)(2906002)(86362001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SZPb7TpxxWALzM51vpgTpWzSiUqS3TVEBTmT2vZUN/0byc1kcN2wHka+ozd/?=
 =?us-ascii?Q?du44AZxFU3mZ3nJgqqjU9zsegYz6+3n1ewpDUXLjCs+CrXqbb12WLuP474Oa?=
 =?us-ascii?Q?o+p1Qw9qGihRMgbwHlDNAHF2lc3/D0vQeRySgKLdterePj4yGGHWiq7d1Nmx?=
 =?us-ascii?Q?vM3SPK00YMHsFaOS/k/7soX/ylbYXkXsVK4sJIunPL2vd3at08ckUEVVGhLh?=
 =?us-ascii?Q?kBid07y+iHc9z8GIyWALLucHEzEfDoZ7/zP9vrThWHEyNhrfkZ2Ir21323dA?=
 =?us-ascii?Q?dG6swp+Ual5dsgpXG0GwUe/TG1ySVU1bzZZ7ZiR6NTrLS70xp+hsmpdPyMAq?=
 =?us-ascii?Q?PprCR3Iagity5k2+rBuynhnmslR46FAF1zuIUgkBlthXUKSJgLEnVC6ybijm?=
 =?us-ascii?Q?FCE0S0yg5xvt/1bg70c278FIuk/Pm0HE++wdTduWTYhyjCj6VgOwOuYe6AjS?=
 =?us-ascii?Q?QQOtj1gveOkRYPvBK1xZF8hdzJHyOeg2CYGeRsKW1bqmeq71RmUIVJki2pjU?=
 =?us-ascii?Q?BIOgYRZRDv5Lrqw3qDhhrnHzicqEarBLP6YOdKAICuGqw1pgia9Pv+tNQsha?=
 =?us-ascii?Q?Otq2rzNiPrHCd97dv4bQ6xXvAXYdT+aq0l5NabujhhhsbIgaRoJAu2MIv8qH?=
 =?us-ascii?Q?Ku7oEYum1XqiJk8QoL87TfH8W/OQAxjBwZoJMZ3WE4A827CSvNhPFxY5DHEk?=
 =?us-ascii?Q?KC0q8z2Xm0f3NQXL49juX1MgfHRCAZPvV+yRgBoNg5broCYIqEk9UQcKZL+a?=
 =?us-ascii?Q?v/RX8Ncki8ESVGs+DfqxXmkDjDpmmWHDKJA+hV7jg1CMdjybwb5SGTN90RQV?=
 =?us-ascii?Q?U0QvcIoi/DnS6mottYmOgyN7d/2XN8X8Y8Si9FvvWE5OJtmsaFRE8uv8eC/k?=
 =?us-ascii?Q?6edZQynJDnxMqU6zgtySFGAvBJbrMcTUfkWM4Hf3AQi6FKqC4o505RpV0n7k?=
 =?us-ascii?Q?jTFZdScZqRkD2DBRCRSfsQVW0kb/ViutmA2T0KBp+48QwhmUtwIqefbzl9aL?=
 =?us-ascii?Q?MazzPvH2xTe6Yu4JWkZ8mmI//ocAvSTH/xh4TTt+bW4EoF21+C/YmbAD9tAu?=
 =?us-ascii?Q?6PyMAhIgu+z5aiZsGQZmI5XtvBeavcLGf4Z/5QqtbNQ3+rQz+ZzhsPtTHfmr?=
 =?us-ascii?Q?LyOUIYw3tWAmNhUgp4SCPovUeD4br5cKPVmhTW1QZoV+DcgqQaP9JNy1idZk?=
 =?us-ascii?Q?Ree7aylAa6iPIvELiLuXvXg4ErPA3jmdVdjYIMwiBR1OHUv4WsDXc9v66+Lb?=
 =?us-ascii?Q?IXezw4wAhHW5WAYyeORDiI+sx+a+POI2gSLzCbqcGIKvsXstOmwcgduPKhwL?=
 =?us-ascii?Q?7UiNxHjI74QbKJnSecMdXp+L+8Xsyk5BZVzH9YOFhkleFDwvs6w9Uo/D4BMQ?=
 =?us-ascii?Q?J0ll3MwtDSe+PfEMizw7/DdBEPzhO8FUAS+tvQDVa7l5n1XMepF9eW70omEY?=
 =?us-ascii?Q?2eofMBeCuqj2q5uZknestH4LRTCZMX0/D9tqZe9lY02mu2+uY5yp4g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2f1aae-7f95-4b9d-072d-08da07efadfa
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 08:25:22.4706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5Xiw7m7gNjizzY4Vd/d7uxALh27PallqutldaOPZfoK2OY4UzR1Ca9aSf47NaVSDS4YGZ3Ka0b18niiIYnsXaq37XvkPjeM/aJyIC8S6S4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5654
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10288 signatures=693715
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203170048
X-Proofpoint-GUID: 9T-fC7HEFdsLGeX5OARXPmNk9RpT45xN
X-Proofpoint-ORIG-GUID: 9T-fC7HEFdsLGeX5OARXPmNk9RpT45xN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git  for-next
head:   a20050c14edf19add5a9588cb196bb00aa410650
commit: 165d142ffacdef3e620819a1031df3d896aa29ab [9/11] gfs2: Fix should_fault_in_pages() logic
config: sh-randconfig-s032-20220313 (https://download.01.org/0day-ci/archive/20220317/202203170954.vFlMcTje-lkp@intel.com/config )
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross  -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/commit/?id=165d142ffacdef3e620819a1031df3d896aa29ab 
        git remote add gfs2 https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git 
        git fetch --no-tags gfs2 for-next
        git checkout 165d142ffacdef3e620819a1031df3d896aa29ab
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sh SHELL=/bin/bash fs/gfs2/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   fs/gfs2/file.c:796:24: sparse: sparse: incompatible types in comparison expression (different signedness):
>> fs/gfs2/file.c:796:24: sparse:    unsigned int *
   fs/gfs2/file.c:796:24: sparse:    int *
>> fs/gfs2/file.c:796:24: sparse: sparse: cannot size expression

vim +796 fs/gfs2/file.c

00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  773  static inline bool should_fault_in_pages(ssize_t ret, struct iov_iter *i,
00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  774  					 size_t *prev_count,
00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  775  					 size_t *window_size)
00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  776  {
00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  777  	size_t count = iov_iter_count(i);
165d142ffacdef fs/gfs2/file.c     Andreas Gruenbacher 2022-03-07  778  	size_t size, offs;
00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  779  
00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  780  	if (likely(!count))
00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  781  		return false;
00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  782  	if (ret <= 0 && ret != -EFAULT)
00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  783  		return false;
00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  784  	if (!iter_is_iovec(i))
00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  785  		return false;
00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  786  
165d142ffacdef fs/gfs2/file.c     Andreas Gruenbacher 2022-03-07  787  	size = PAGE_SIZE;
165d142ffacdef fs/gfs2/file.c     Andreas Gruenbacher 2022-03-07  788  	offs = offset_in_page(i->iov[0].iov_base + i->iov_offset);
00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  789  	if (*prev_count != count || !*window_size) {
165d142ffacdef fs/gfs2/file.c     Andreas Gruenbacher 2022-03-07  790  		int nr_dirtied;
00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  791  
165d142ffacdef fs/gfs2/file.c     Andreas Gruenbacher 2022-03-07  792  		size = ALIGN(offs + count, PAGE_SIZE);
165d142ffacdef fs/gfs2/file.c     Andreas Gruenbacher 2022-03-07  793  		size = min_t(size_t, size, SZ_1M);
00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  794  		nr_dirtied = max(current->nr_dirtied_pause -
165d142ffacdef fs/gfs2/file.c     Andreas Gruenbacher 2022-03-07  795  				 current->nr_dirtied, 8);
165d142ffacdef fs/gfs2/file.c     Andreas Gruenbacher 2022-03-07 @796  		size = min(size, nr_dirtied << PAGE_SHIFT);

size is size_t so nr_dirtied needs to be size_t as well.  I'm surprised
this compiles.  The min()/max() macros are supposed to trigger a compile
error for type mismatches.

00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  797  	}
00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  798  
00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  799  	*prev_count = count;
165d142ffacdef fs/gfs2/file.c     Andreas Gruenbacher 2022-03-07  800  	*window_size = size - offs;
00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  801  	return true;
00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  802  }

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

