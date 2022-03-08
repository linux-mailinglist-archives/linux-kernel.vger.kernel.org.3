Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609BE4D18C7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344141AbiCHNLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiCHNL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:11:29 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9736F483BF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 05:10:32 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 228CiTob023549;
        Tue, 8 Mar 2022 13:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=6kMxCzu9R4E7gxkwcokgunpqg14NC3TYVziLSGBS+Ew=;
 b=MCgHPaWnhkIkk/fyRNJVFjNyi59/jZeja74ryixhlhHogV4zxebrALyVwQqvAemuacl0
 jdHTTDpts4v9UaVbECOf+9OvC6s8EoEC8dwDlNA7XRNlPSTyNpxGGg8SGQ3ErIAXDDPY
 eypc0lAjRXcLIrhr0kjuRSNVUsgFPheLLvdxn3qJd+aHc1nIC7D63q65IUO4ORTIvfQU
 VH70K2ntQDCdTSa5gDGUzsL37edaAF5RZiBFoTiCy4TEUxDwDCw8gtvSCbE3dnvQ6E7s
 8pK9yP3V3bX1cLu2RSbG8xuOimWjti+yNywjAKS+DcTGf5iHv591VKddi7MMNfeBFEJC 5g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekyrappne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Mar 2022 13:10:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 228DAIPE100978;
        Tue, 8 Mar 2022 13:10:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by userp3020.oracle.com with ESMTP id 3envvken5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Mar 2022 13:10:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVTc+45vEWGqwjckVlyHwu4lJkKKfHOzx9WBXdlAxb9O5KyPjW5BsxMx5HUU3RHI3Xeh0PgS98odziAzqCtEGzYVgMiTpv0uis5hFbufZwxiH0Z8wOSnHxhubHOvbKJTs9KCnPrxdn2ryHZSB2b+RTgQlOrFv7kOc1wV7QTS1yTDbKGVBwFCWw1BPxGmO2KjcXz9CoPCzy27Wf8m8d0iOUynj/JNyWtVCJRAiSrOWJkjsQIfXo7Nej0rwLkx7mJx6oIrkCOm//XqSyUXpqeHpB0KdEdZs83yTgrUdVfmYyOQPXSYVtMiEDkgnQhkQ0OnUH0YLvi7bovKQeqUAzOI3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kMxCzu9R4E7gxkwcokgunpqg14NC3TYVziLSGBS+Ew=;
 b=c1g9UzFVt5r96oOzAUdLtnJpahrq/I4HtROI3MAEletdK1vkvoxzO5iB/TxDRxBRYhnTeLB/dHi6NAAxe097XDuaSpIC0wPFCAdOrLe4vPmszbyY6glDxiL5CSr6GzQVMyb/d1g+GDigCSz89rGFfYdfEkekS6InCdBaa4nercnapxJ+cKcgedmj53BI1vCrPkZepSK6vbOjj2jfqOBsYJ50XAh9hJGh8YDX53GhClNg72ukuI1dyWeHGKxCA5/aEr1jopTRSidOhAfcL9EOLzKbbfmDQ58uv5miKk5ParOSXDJTcE5P8Wv1majZjZXGhLGBeVLZioM3H7WNgIrRnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kMxCzu9R4E7gxkwcokgunpqg14NC3TYVziLSGBS+Ew=;
 b=dirv5rYa4S9TKgpidSv7IbAxpCF7F1jttwa0dGAHseF4S3HLuXkI0o9M+qTo6cAYmyIS29l9Zyf/iewMnFQ+u2oj3ZhmAO7eQMRSJ914UQIshTrRufuAFR81X9E1VAhUBg193ZFrMslZ65CZOGjjIk2Lepe2gEBLQrK+on5mISw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1730.namprd10.prod.outlook.com
 (2603:10b6:405:8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 13:10:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5038.026; Tue, 8 Mar 2022
 13:10:22 +0000
Date:   Tue, 8 Mar 2022 16:09:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Qu Wenruo <wqu@suse.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: [kdave-btrfs-devel:for-next-20220307 108/147] fs/btrfs/scrub.c:3146
 scrub_raid56_data_stripe_for_parity() error: we previously assumed 'bioc'
 could be null (see line 3138)
Message-ID: <202203081837.zOttrQRN-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0018.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::30)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6cd9b8e-72db-4875-cdf3-08da010500a4
X-MS-TrafficTypeDiagnostic: BN6PR10MB1730:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1730C911C2EB0D91B37F25B88E099@BN6PR10MB1730.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pRcEyM3xsWOKN+Ge5BaB8vTTXYwhVA1tHEyHfPPs1q5x632ckbHjPr36josggnlK4OiASy62jCuPQekdsqVNw3oFR62DCO3FULwp5HNXu9fwi9eDof8ZtQa3XRvqSEvZWmPEzKaULPHjddBDAGTVAt/1DWHTTahNGDgnQ+TZCV/Fe8TLdoMbIkstsuPqOQMOh1LVySszldFgUAn7L403AcMSsEInKx0hYGsiqChUiW9aic4GmyJQgsjwam+qVRDZxEYtKqkdqUB9ipGhPzjaIaojReRhaE/NAc7Ci5pjBR1/gxc50EaSAfIkymkJSQ9F/PB1dwnCnK0b0cgM9EZp8eECvDSJFcxFTRf/eX/kgzJb4ivx/MuW/bIUIjlSJByEASosgpoSNyK5VOdhP2yW5cMQwxLj7OiR6k6Di3CdroxCcYAWj6EUz822DG/g7V4U4yPNIjwGe5MFOtZyJOyk7Yo7tL8fLmO06P2h8HcPgP6WUIqF3xCFESYPv2L812Fd1dvzmJaxCFp70YpPi0Gz6bKOYzdOOman/0PDY77HiQIFJktwyv70Pk/GxzlJqj6RGP7UwGHB8kOu9rXi1ne5UPZZMEwvJMNTh1bst+vAXNBH257IF6Qb2y6JA5f9OE5520lywB/efgEdHa1izGsQi09VHAceV+Cqi2ELzyuMvDB/wv5GSSILr3ibefUEQysrtBe94Oo0sbE6JzErJlIWBdSVA8lpLFp6quWG0rAOX7Mp81vmdEfl5Yf1k1W+Ynfs72ClypeKdTuPNGCub+6AEPgd5M9MQxb0IdlZsuamtXiOHTE77spwPn1GY996ILPoyyWkU5oeRsrs161FUAf60w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(26005)(966005)(6916009)(38100700002)(6486002)(6666004)(508600001)(44832011)(30864003)(5660300002)(4001150100001)(38350700002)(83380400001)(8676002)(2906002)(4326008)(186003)(86362001)(66946007)(66556008)(316002)(36756003)(1076003)(52116002)(6506007)(66476007)(6512007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D2TeB0Xu/0uldRGZ37YUHZ1hjg59LDPGSc+SzhlrADo+E57VpAa0neknnldK?=
 =?us-ascii?Q?uS1+TJ0TMUW5a3p399fhJNdyX+BmoovZYqe9KZAc7i8elO8JVww8TJCWi1Ub?=
 =?us-ascii?Q?xBuWFpeXTVJ9+UdnR/ksvQgWIRmQ/L5CFK2LC183pgydr+yYvp8IhQmhbZXF?=
 =?us-ascii?Q?k88H79htomPmoHI4di3BPuLIPtzQKZp3c6TY9sH52/4II6qIbVtiCssE9QXd?=
 =?us-ascii?Q?qHEEfdgAiTX/8qn4R6Wpv8jlBQHL1a7Zy22hW+92hEuEnxjEQCDEEup74MxK?=
 =?us-ascii?Q?dLMn1LTVs+MH1qUK545TtG/ZeHsUBBE5vvuPHA4FF/XIK6CLBobqS5vqBGxC?=
 =?us-ascii?Q?L2dS3dhqatm/8t7BLs7UJPU3dnNaBnWFaJo1mrsCSGiCniCMjPHBx4jGkrVs?=
 =?us-ascii?Q?02mb9vqSJpNhXDWkyhDD4FhI9pAeGXOTao8CQebWFMTojVo7pwJ1gput/DEr?=
 =?us-ascii?Q?Huogtn8jYR/xFHXVTezSGGRP/RXwW9O2DfRxlHSp4yXX7NNT1LDof+oESm3J?=
 =?us-ascii?Q?2pmCoXXorLB4aFbazdJItw8altXpju42bFeMmEpNT5Ltonre4YgpuMnqrXRf?=
 =?us-ascii?Q?RaWsxOCuu1FzyW4X8y0PMeDNqbaF3p6CA46buIguo5win+uHaLckg5DbFwCd?=
 =?us-ascii?Q?Oe47Jkq88JKYTO0PxRNi6K7+sHv5mbfamDfDHJ4PfvryprINHuclYXio/0ht?=
 =?us-ascii?Q?8q7T/Ooa59m9L2EKLMOP8ZcehyBTkrDsFqhck/zBcV/fMuR+HD/Z4h72qBUH?=
 =?us-ascii?Q?KIjIOeuCMhWNMlifawh4aiZSoWA5giouaOxgPnZ4lUOciDSCQVr0neej82RB?=
 =?us-ascii?Q?J6nByR+aU+NEG5NsZlZUaFh7k8sN8o1mf4UXuXca8YYeY7gLPpGneLOd5nQT?=
 =?us-ascii?Q?XlwekObM830jmjBj1+lu26RUJaWmDhQzrL+orS7R6F8K4i0Svb3UkSHlztYs?=
 =?us-ascii?Q?F+sHNNJ5/4WLuOMasugb19LSE2paZf87WiWjGJ6Qwe/tjsPPfObPsQ4+ElB1?=
 =?us-ascii?Q?IKM/3uMxNG5aHX43kCxw5GR6F/qHN59BzHSPdbgI+gE4AHPllOO+TMA2uKPX?=
 =?us-ascii?Q?fwswHdV6xAA8rMZXWH5rANG/tRFikVw+SV2fIKSWwtx+AJz33igqBUjTRvC9?=
 =?us-ascii?Q?S/oL8hQg45hBAahE2Irp2/2dsktqi/bAUH3GXCN1gIdvMKwW6grt5YF3kpFO?=
 =?us-ascii?Q?xs1nKihwyRIDHlI7q2V38wPNDKe6JLKIvSINt3YHQQXdh9v43+TwBD9McIZw?=
 =?us-ascii?Q?5DLwLEvrthMYOKc61np7qMvdrz1+VmnsDV3rzPwhSNXBNcp4iemqsTyPJz8U?=
 =?us-ascii?Q?cN8pX5A7TcvVEGDxs78Vs4oHXSBa+Ol0YXMniiVr5UIqxZiyGVChNNu9rN99?=
 =?us-ascii?Q?BiGr6T98Ldn4KZ42lruOjaCaHB11aK7a5Zj+Ujpm1MvsHCt0mfMoh7lJbOUH?=
 =?us-ascii?Q?tSDEjZKdFXaSX9po98nSXmIexPgZYSwccYPyEyT444P6+/rZxIuds4pHNCi0?=
 =?us-ascii?Q?BmfZX9eKRTD6up63JNf7pPtz++r0xGgbtTiD+h5PWhDgs1ggrkFlJmoWn8Lo?=
 =?us-ascii?Q?CAiDZzyqPD9A3BbM1ou0d/n55GrXbGGzvAYjRpLn52ozaNYuajyvzJ9waLjj?=
 =?us-ascii?Q?UzWB71XO1wV199yJnbLo3E1fQKoNNuIt1HUqFOeEPPD3wuDI5tUMwZZXOGf7?=
 =?us-ascii?Q?OUQDkQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cd9b8e-72db-4875-cdf3-08da010500a4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 13:10:22.6111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ozz5He7LCmEq3FRQL9/j9jPJL7v7NmsAYSQEALEBFW5ReNwR6rujPZcR4yoh48o7NCZT8ebZZPe5ynDm6ep2DItEl+PxejIL6VnwSQHv234=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1730
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10279 signatures=690470
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203080070
X-Proofpoint-GUID: ZDqmuAzdLTKDzzlOWoF4y_xvRYxEWWX4
X-Proofpoint-ORIG-GUID: ZDqmuAzdLTKDzzlOWoF4y_xvRYxEWWX4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/kdave/btrfs-devel.git for-next-20220307
head:   912dedd70aeb485247c507115704ea7d137d758b
commit: 80cd926eefca522182ee3cf04d8e9984073d34d1 [108/147] btrfs: refactor scrub_raid56_parity()
config: i386-randconfig-m021-20220307 (https://download.01.org/0day-ci/archive/20220308/202203081837.zOttrQRN-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
fs/btrfs/scrub.c:3171 scrub_raid56_data_stripe_for_parity() error: uninitialized symbol 'extent_start'.
fs/btrfs/scrub.c:3172 scrub_raid56_data_stripe_for_parity() error: uninitialized symbol 'extent_size'.

Old smatch warnings:
fs/btrfs/scrub.c:3419 scrub_simple_mirror() error: uninitialized symbol 'ret'.

vim +/bioc +3146 fs/btrfs/scrub.c

093741d4cda2cb4 Qu Wenruo     2022-02-18  3021  
80cd926eefca522 Qu Wenruo     2022-02-18  3022  static int scrub_raid56_data_stripe_for_parity(struct scrub_ctx *sctx,
80cd926eefca522 Qu Wenruo     2022-02-18  3023  					       struct scrub_parity *sparity,
5a6ac9eacb49143 Miao Xie      2014-11-06  3024  					       struct map_lookup *map,
5a6ac9eacb49143 Miao Xie      2014-11-06  3025  					       struct btrfs_device *sdev,
80cd926eefca522 Qu Wenruo     2022-02-18  3026  					       struct btrfs_path *path,
80cd926eefca522 Qu Wenruo     2022-02-18  3027  					       u64 logical)
5a6ac9eacb49143 Miao Xie      2014-11-06  3028  {
fb456252d3d9c05 Jeff Mahoney  2016-06-22  3029  	struct btrfs_fs_info *fs_info = sctx->fs_info;
80cd926eefca522 Qu Wenruo     2022-02-18  3030  	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, logical);
80cd926eefca522 Qu Wenruo     2022-02-18  3031  	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, logical);
5a6ac9eacb49143 Miao Xie      2014-11-06  3032  	struct btrfs_key key;
80cd926eefca522 Qu Wenruo     2022-02-18  3033  	u64 extent_start;
80cd926eefca522 Qu Wenruo     2022-02-18  3034  	u64 extent_size;
80cd926eefca522 Qu Wenruo     2022-02-18  3035  	int ret;
2522dbe86b54ff0 Qu Wenruo     2021-12-14  3036  
80cd926eefca522 Qu Wenruo     2022-02-18  3037  	ASSERT(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK);
5a6ac9eacb49143 Miao Xie      2014-11-06  3038  
80cd926eefca522 Qu Wenruo     2022-02-18  3039  	/* Path should not be populated */
80cd926eefca522 Qu Wenruo     2022-02-18  3040  	ASSERT(!path->nodes[0]);
5a6ac9eacb49143 Miao Xie      2014-11-06  3041  
5a6ac9eacb49143 Miao Xie      2014-11-06  3042  	if (btrfs_fs_incompat(fs_info, SKINNY_METADATA))
5a6ac9eacb49143 Miao Xie      2014-11-06  3043  		key.type = BTRFS_METADATA_ITEM_KEY;
5a6ac9eacb49143 Miao Xie      2014-11-06  3044  	else
5a6ac9eacb49143 Miao Xie      2014-11-06  3045  		key.type = BTRFS_EXTENT_ITEM_KEY;
80cd926eefca522 Qu Wenruo     2022-02-18  3046  	key.objectid = logical;
5a6ac9eacb49143 Miao Xie      2014-11-06  3047  	key.offset = (u64)-1;
5a6ac9eacb49143 Miao Xie      2014-11-06  3048  
80cd926eefca522 Qu Wenruo     2022-02-18  3049  	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
5a6ac9eacb49143 Miao Xie      2014-11-06  3050  	if (ret < 0)
80cd926eefca522 Qu Wenruo     2022-02-18  3051  		return ret;
5a6ac9eacb49143 Miao Xie      2014-11-06  3052  
5a6ac9eacb49143 Miao Xie      2014-11-06  3053  	if (ret > 0) {
80cd926eefca522 Qu Wenruo     2022-02-18  3054  		ret = btrfs_previous_extent_item(extent_root, path, 0);
5a6ac9eacb49143 Miao Xie      2014-11-06  3055  		if (ret < 0)
80cd926eefca522 Qu Wenruo     2022-02-18  3056  			return ret;
5a6ac9eacb49143 Miao Xie      2014-11-06  3057  		if (ret > 0) {
5a6ac9eacb49143 Miao Xie      2014-11-06  3058  			btrfs_release_path(path);
80cd926eefca522 Qu Wenruo     2022-02-18  3059  			ret = btrfs_search_slot(NULL, extent_root, &key, path,
80cd926eefca522 Qu Wenruo     2022-02-18  3060  						0, 0);
5a6ac9eacb49143 Miao Xie      2014-11-06  3061  			if (ret < 0)
80cd926eefca522 Qu Wenruo     2022-02-18  3062  				return ret;
5a6ac9eacb49143 Miao Xie      2014-11-06  3063  		}
5a6ac9eacb49143 Miao Xie      2014-11-06  3064  	}
5a6ac9eacb49143 Miao Xie      2014-11-06  3065  
5a6ac9eacb49143 Miao Xie      2014-11-06  3066  	while (1) {
80cd926eefca522 Qu Wenruo     2022-02-18  3067  		struct btrfs_io_context *bioc = NULL;
80cd926eefca522 Qu Wenruo     2022-02-18  3068  		struct btrfs_device *extent_dev;
80cd926eefca522 Qu Wenruo     2022-02-18  3069  		struct btrfs_extent_item *ei;
80cd926eefca522 Qu Wenruo     2022-02-18  3070  		struct extent_buffer *l;
80cd926eefca522 Qu Wenruo     2022-02-18  3071  		int slot;
80cd926eefca522 Qu Wenruo     2022-02-18  3072  		u64 mapped_length;
80cd926eefca522 Qu Wenruo     2022-02-18  3073  		u64 extent_flags;
80cd926eefca522 Qu Wenruo     2022-02-18  3074  		u64 extent_gen;
80cd926eefca522 Qu Wenruo     2022-02-18  3075  		u64 extent_physical;
80cd926eefca522 Qu Wenruo     2022-02-18  3076  		u64 extent_mirror_num;
5a6ac9eacb49143 Miao Xie      2014-11-06  3077  
5a6ac9eacb49143 Miao Xie      2014-11-06  3078  		l = path->nodes[0];
5a6ac9eacb49143 Miao Xie      2014-11-06  3079  		slot = path->slots[0];
5a6ac9eacb49143 Miao Xie      2014-11-06  3080  		if (slot >= btrfs_header_nritems(l)) {
80cd926eefca522 Qu Wenruo     2022-02-18  3081  			ret = btrfs_next_leaf(extent_root, path);
5a6ac9eacb49143 Miao Xie      2014-11-06  3082  			if (ret == 0)
5a6ac9eacb49143 Miao Xie      2014-11-06  3083  				continue;
5a6ac9eacb49143 Miao Xie      2014-11-06  3084  
80cd926eefca522 Qu Wenruo     2022-02-18  3085  			/* No more extent items or error, exit */
5a6ac9eacb49143 Miao Xie      2014-11-06  3086  			break;
5a6ac9eacb49143 Miao Xie      2014-11-06  3087  		}
5a6ac9eacb49143 Miao Xie      2014-11-06  3088  		btrfs_item_key_to_cpu(l, &key, slot);
5a6ac9eacb49143 Miao Xie      2014-11-06  3089  
d7cad2389560f32 Zhao Lei      2015-07-22  3090  		if (key.type != BTRFS_EXTENT_ITEM_KEY &&
d7cad2389560f32 Zhao Lei      2015-07-22  3091  		    key.type != BTRFS_METADATA_ITEM_KEY)
d7cad2389560f32 Zhao Lei      2015-07-22  3092  			goto next;
d7cad2389560f32 Zhao Lei      2015-07-22  3093  
5a6ac9eacb49143 Miao Xie      2014-11-06  3094  		if (key.type == BTRFS_METADATA_ITEM_KEY)
80cd926eefca522 Qu Wenruo     2022-02-18  3095  			extent_size = fs_info->nodesize;
5a6ac9eacb49143 Miao Xie      2014-11-06  3096  		else
80cd926eefca522 Qu Wenruo     2022-02-18  3097  			extent_size = key.offset;
5a6ac9eacb49143 Miao Xie      2014-11-06  3098  
80cd926eefca522 Qu Wenruo     2022-02-18  3099  		if (key.objectid + extent_size <= logical)
5a6ac9eacb49143 Miao Xie      2014-11-06  3100  			goto next;
5a6ac9eacb49143 Miao Xie      2014-11-06  3101  
80cd926eefca522 Qu Wenruo     2022-02-18  3102  		/* Beyond this data stripe */
80cd926eefca522 Qu Wenruo     2022-02-18  3103  		if (key.objectid >= logical + map->stripe_len)
5a6ac9eacb49143 Miao Xie      2014-11-06  3104  			break;
5a6ac9eacb49143 Miao Xie      2014-11-06  3105  
80cd926eefca522 Qu Wenruo     2022-02-18  3106  		ei = btrfs_item_ptr(l, slot, struct btrfs_extent_item);
80cd926eefca522 Qu Wenruo     2022-02-18  3107  		extent_flags = btrfs_extent_flags(l, ei);
80cd926eefca522 Qu Wenruo     2022-02-18  3108  		extent_gen = btrfs_extent_generation(l, ei);
5a6ac9eacb49143 Miao Xie      2014-11-06  3109  
80cd926eefca522 Qu Wenruo     2022-02-18  3110  		if ((extent_flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) &&
80cd926eefca522 Qu Wenruo     2022-02-18  3111  		    (key.objectid < logical || key.objectid + extent_size >
80cd926eefca522 Qu Wenruo     2022-02-18  3112  		     logical + map->stripe_len)) {
5d163e0e68ce743 Jeff Mahoney  2016-09-20  3113  			btrfs_err(fs_info,
5d163e0e68ce743 Jeff Mahoney  2016-09-20  3114  				  "scrub: tree block %llu spanning stripes, ignored. logical=%llu",
80cd926eefca522 Qu Wenruo     2022-02-18  3115  				  key.objectid, logical);
9799d2c32bef6fb Zhao Lei      2015-08-25  3116  			spin_lock(&sctx->stat_lock);
9799d2c32bef6fb Zhao Lei      2015-08-25  3117  			sctx->stat.uncorrectable_errors++;
9799d2c32bef6fb Zhao Lei      2015-08-25  3118  			spin_unlock(&sctx->stat_lock);
5a6ac9eacb49143 Miao Xie      2014-11-06  3119  			goto next;

This goto next is what triggers the uninitialized variable warnings for
extent_start and extent_size.

5a6ac9eacb49143 Miao Xie      2014-11-06  3120  		}
5a6ac9eacb49143 Miao Xie      2014-11-06  3121  
80cd926eefca522 Qu Wenruo     2022-02-18  3122  		extent_start = key.objectid;
80cd926eefca522 Qu Wenruo     2022-02-18  3123  		ASSERT(extent_size <= U32_MAX);
5a6ac9eacb49143 Miao Xie      2014-11-06  3124  
80cd926eefca522 Qu Wenruo     2022-02-18  3125  		/* Truncate the range inside the data stripe */
80cd926eefca522 Qu Wenruo     2022-02-18  3126  		if (extent_start < logical) {
80cd926eefca522 Qu Wenruo     2022-02-18  3127  			extent_size -= logical - extent_start;
80cd926eefca522 Qu Wenruo     2022-02-18  3128  			extent_start = logical;
80cd926eefca522 Qu Wenruo     2022-02-18  3129  		}
80cd926eefca522 Qu Wenruo     2022-02-18  3130  		if (extent_start + extent_size > logical + map->stripe_len)
80cd926eefca522 Qu Wenruo     2022-02-18  3131  			extent_size = logical + map->stripe_len - extent_start;
5a6ac9eacb49143 Miao Xie      2014-11-06  3132  
80cd926eefca522 Qu Wenruo     2022-02-18  3133  		scrub_parity_mark_sectors_data(sparity, extent_start, extent_size);
5a6ac9eacb49143 Miao Xie      2014-11-06  3134  
80cd926eefca522 Qu Wenruo     2022-02-18  3135  		mapped_length = extent_size;
80cd926eefca522 Qu Wenruo     2022-02-18  3136  		ret = btrfs_map_block(fs_info, BTRFS_MAP_READ, extent_start,
80cd926eefca522 Qu Wenruo     2022-02-18  3137  				      &mapped_length, &bioc, 0);
80cd926eefca522 Qu Wenruo     2022-02-18  3138  		if (!ret && (!bioc || mapped_length < extent_size))
4a770891d9ddf94 Omar Sandoval 2015-06-19  3139  			ret = -EIO;
4a770891d9ddf94 Omar Sandoval 2015-06-19  3140  		if (ret) {
4c6646117912397 Qu Wenruo     2021-09-15  3141  			btrfs_put_bioc(bioc);
80cd926eefca522 Qu Wenruo     2022-02-18  3142  			scrub_parity_mark_sectors_error(sparity, extent_start,
80cd926eefca522 Qu Wenruo     2022-02-18  3143  							extent_size);
80cd926eefca522 Qu Wenruo     2022-02-18  3144  			break;
4a770891d9ddf94 Omar Sandoval 2015-06-19  3145  		}
4c6646117912397 Qu Wenruo     2021-09-15  3146  		extent_physical = bioc->stripes[0].physical;
4c6646117912397 Qu Wenruo     2021-09-15  3147  		extent_mirror_num = bioc->mirror_num;
4c6646117912397 Qu Wenruo     2021-09-15  3148  		extent_dev = bioc->stripes[0].dev;
4c6646117912397 Qu Wenruo     2021-09-15  3149  		btrfs_put_bioc(bioc);
5a6ac9eacb49143 Miao Xie      2014-11-06  3150  
80cd926eefca522 Qu Wenruo     2022-02-18  3151  		ret = btrfs_lookup_csums_range(csum_root, extent_start,
80cd926eefca522 Qu Wenruo     2022-02-18  3152  					       extent_start + extent_size - 1,
5a6ac9eacb49143 Miao Xie      2014-11-06  3153  					       &sctx->csum_list, 1);
5a6ac9eacb49143 Miao Xie      2014-11-06  3154  		if (ret)
80cd926eefca522 Qu Wenruo     2022-02-18  3155  			break;
6fa96d72f79a155 Zhao Lei      2015-07-21  3156  
80cd926eefca522 Qu Wenruo     2022-02-18  3157  		ret = scrub_extent_for_parity(sparity, extent_start,
80cd926eefca522 Qu Wenruo     2022-02-18  3158  					      extent_size, extent_physical,
80cd926eefca522 Qu Wenruo     2022-02-18  3159  					      extent_dev, extent_flags,
80cd926eefca522 Qu Wenruo     2022-02-18  3160  					      extent_gen, extent_mirror_num);
6fa96d72f79a155 Zhao Lei      2015-07-21  3161  		scrub_free_csums(sctx);
6fa96d72f79a155 Zhao Lei      2015-07-21  3162  
5a6ac9eacb49143 Miao Xie      2014-11-06  3163  		if (ret)
5a6ac9eacb49143 Miao Xie      2014-11-06  3164  			break;
5a6ac9eacb49143 Miao Xie      2014-11-06  3165  
5a6ac9eacb49143 Miao Xie      2014-11-06  3166  		cond_resched();
5a6ac9eacb49143 Miao Xie      2014-11-06  3167  next:
5a6ac9eacb49143 Miao Xie      2014-11-06  3168  		path->slots[0]++;
5a6ac9eacb49143 Miao Xie      2014-11-06  3169  	}
80cd926eefca522 Qu Wenruo     2022-02-18  3170  	if (ret < 0)
80cd926eefca522 Qu Wenruo     2022-02-18 @3171  		scrub_parity_mark_sectors_error(sparity, extent_start,
80cd926eefca522 Qu Wenruo     2022-02-18 @3172  						extent_size);
5a6ac9eacb49143 Miao Xie      2014-11-06  3173  	btrfs_release_path(path);
80cd926eefca522 Qu Wenruo     2022-02-18  3174  	return ret;
80cd926eefca522 Qu Wenruo     2022-02-18  3175  }
5a6ac9eacb49143 Miao Xie      2014-11-06  3176  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

