Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE795A7BFC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 13:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiHaLIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 07:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiHaLId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 07:08:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96953C59F3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 04:08:32 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27V8nIaZ005548;
        Wed, 31 Aug 2022 11:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=SxezlB/Rh6DoQ20GDfa5XMliPrftmIz7banisZWMUJQ=;
 b=vXS6SoJvfDJA2JWw7/Pr3eDI7A5cagxMWLecOeUowy6BQWnKEjz/FMTFgROwJP5Yb8Wq
 LVByVamEQjAFTG0/0grc/sDXvOeYkOIxRgvaYfw5WyXF4cWPUo1pwdgsQCVqi623xEnq
 jxQSmHTKhBjXfi8OAX5GteZgn2S7zmEa2QyiLAjSVmVG8mkdN7eahi0ShfJXrtbY1T7Q
 urtAIrBaEuA9RzMAh+pC7xmaM8n+XBtshtk5P4OIkUUYmbgqyXbeL1H+d5tdQMeXxBwP
 q0So2V/zZp3ibDafyM+HcJtwaKKYn9MRdEI/K7Xtr7O2lB57fM31ZEPWYz83MbGHPe3x qA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7a228vec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 11:07:54 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27VB7hrh035906;
        Wed, 31 Aug 2022 11:07:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q56k2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 11:07:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGZPwGrjQHq/ShHgCuleqF3JjQ6CAENbLUONwsfzIMu9vbDuf4nWcKlpz9oYCTe26LdjkC0dwLxQPfyeTZHa8968o6IIgRBa6BRBRnoExO5FzdJNvL+sIQIDnmHwmYq03GEKVg5d3ajVmQXaZgcdOJvHoAaBv5kjytOwt7/CiOaIG+WdNb8dnOufWmAUjRn3kOQXozjsP4vY4mAfulzHyi5nmDdDH4l/1pKtpsM3Zfkpr6kvRV9THj3Ds4nRmjTuI/Cv42tLrwBEXatCgOPlAK9E13oWNx5k6Q5dZREFsRcH0x56MlORuORb3XIx6ThOvKI1QSiev2Bk08VpYcrXcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxezlB/Rh6DoQ20GDfa5XMliPrftmIz7banisZWMUJQ=;
 b=ZGirTPGl3wzWyYbwcig6dZNCoC4bRdKm+9pYS1hVf/JxjkkZvYQ2oWVfBhXYRHmVa6rbAe0QCaWf1TDqBQJhQFDtsGZhnJKeDJ29UcP9osOADh3XS9nZg4A5mJUr1BVPUDsVGV0Au4tEGzkG4fTD8skcsl52wSD33gl5Dhz78drfDKD0OTo0GqcKjQBGNaROyTKgWNbndQf5F2p7uipOZTiRpPzZmFMuZU32q8e5SHZ6zHV96N6kS8b3iRMz5FKokhOmArULd17KAlg9tWH0R5BxnVhYN7L/WswLFjLVXxTGtBE14P/OLju5aktwG817VckfGx6H8yONUmjcw7VCAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxezlB/Rh6DoQ20GDfa5XMliPrftmIz7banisZWMUJQ=;
 b=xi0CN3ZkA7oo4UNe6xnQRv93T872/0zuUcndzwYvLqIxtFQ15/VSGTFEVD1Mc0cdjxU/iZmXrtX86VCaQo8BNyMLH19j6MgdmVVlo3sVOGtqkBEtO7DNE5PWRIP/WDCu6UVadheZIn4Ag80lxvNPo0aLwxmVU0fO/piEYeMDBe8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN0PR10MB5141.namprd10.prod.outlook.com
 (2603:10b6:408:125::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 11:07:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 11:07:48 +0000
Date:   Wed, 31 Aug 2022 14:07:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hawkins Jiawei <yin31149@gmail.com>
Cc:     syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com,
        Anton Altaparmakov <anton@tuxera.com>,
        akpm@linux-foundation.org, chenxiaosong2@huawei.com,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com, 18801353760@163.com
Subject: Re: [PATCH 2/3] ntfs: fix out-of-bounds read in ntfs_attr_find()
Message-ID: <20220831110727.GK2071@kadam>
References: <cover.1661875711.git.yin31149@gmail.com>
 <8a43c95b068e4ca404e864d64a2a44d357754e5c.1661875711.git.yin31149@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a43c95b068e4ca404e864d64a2a44d357754e5c.1661875711.git.yin31149@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0008.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab25dc13-5650-4d01-37ae-08da8b4109bd
X-MS-TrafficTypeDiagnostic: BN0PR10MB5141:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xmIrMxKMEz4PL2/eLLjQIPnadeQGqlh3+kylI4Lp+9AiCYeu0SyDs+G3d+T5SqzLK85e7TphkbhRYwfWjUNdp2zGKRHfJoGpgq2Q6sLfPki9UWsfOGW1EzzKBOWqalyTOj9DatCpUWKxqDyIlwVpr9dVtus7MCz3CmPTf4SXjQ2Bi8Of9+T/QaCFZDSFipLgpAmFNoqNK6o3LHvXt4fj6FWGnV5+H54sNmKk+IWgZu7PPFRWt0bEqan5R9+9bDNpF7t8r0VIM7J/HpANaFjldjv108cd6QzX5GM2HM3eqPqiF6vvINmw4zkX/3UNQT70iEFwRJhFJY/rwSwa5hveDRmntbKqg6UmNqMdTKWBmmbyycWyvc0mIFpYyagur8VuTX9tUi+9Jr3C70lTWhOYLyj2AxaJgxt+SxQBOk8x0pVvSj+zM+hBTdvt3BXx0MlPV/yPmQl1vF9BBbxpbu72FBcD6z9Np4szo95XYc8ELWJIZHzWNSNVdi1B0WSmRzoZDHHZLrhJ3Yulh49RKOe83hL5dHbZqW8PGvfPpf2nnBHfT8A2kzfnnseXDR9r/bc2/IUAnAUmzJaPIW5rfVhx1jeoF5EyrzoH9nsPTesYotZ8sLl5IDjAu2MYyab8/51mxbReECi0PVuwynoarUyIuSLdbzbQHbLCnxt07aAo+4cUoqzAjdIRBk9CW/SlPVKoLnowFa8LqNTKaya8M3diBPQiDv9dLc6Goba1SpINM0xi3fKumZHcyMPKhK4l6hmga6Tucw4rx7/q9A4OlR+IlVn0uUl+WCfighy/TDoK9BV3cFxYYgq2Go8QktkjVI9wjy5stAUp67sK+4BAV5j1bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(346002)(376002)(366004)(39860400002)(396003)(33716001)(86362001)(38100700002)(38350700002)(478600001)(8676002)(66946007)(66476007)(66556008)(4326008)(6666004)(8936002)(5660300002)(966005)(6916009)(6486002)(44832011)(316002)(1076003)(83380400001)(186003)(9686003)(26005)(2906002)(6512007)(52116002)(6506007)(41300700001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jgT449sH6l2LrSEy8uxjFg42GBuiW2NcJU/8prRxPikYeeoJlT78FG+fJXbR?=
 =?us-ascii?Q?LZ/mGfOr+ZiUZRCcAOcjQgfrb9O+JRrXSOTgQScE3uwevsQqxLjL3EkAtVPk?=
 =?us-ascii?Q?8PMK6CLpv72rLMgW9duQrwSx9ZWjQ4opwXTUMr6fVzp5E94xcIGiVT/hJi4x?=
 =?us-ascii?Q?UEAQ28qgKz8EhudkZKbLOE67A21THJ/Ko82COWIikDT1L9zZc3+llvAnZKjV?=
 =?us-ascii?Q?94fvDQL3BZQb3Aelxt9252uSkw4+x5vucCeQ2sHgbOfau6io9x4ohjYicatB?=
 =?us-ascii?Q?hXw1kwCIOLjsVhb30XCo+q1HJUWdNYigAOFCTJwVJsCLKokzHLW0j1tolEFI?=
 =?us-ascii?Q?SRPNp9IZxYkQ5MJRsV5LUqMqdlg9itzHiMPmJ8AoJGErkNYqzof58/sCO27i?=
 =?us-ascii?Q?W8LwR8Gt9kmc4rdi9D1Kh/bRlPi9lneJeSYDqJ9EVFycoEYuDb/bXVf1ksvC?=
 =?us-ascii?Q?3BPi12UPMnC1rThlWMaWtDBM0kjQfKH2LKiMRGI66WG5+vANkLALa9vP58Bn?=
 =?us-ascii?Q?3TpkMKtQqw+/af6PQIJSRblc6QzjtSH8d/8Y1f0Q1bA8eEcpAFEPFzYrKLuk?=
 =?us-ascii?Q?+Ab233hLLjieXWadphWxZZkiVOvQF9ehhqUphbiT/lEuAyS9KBHWaUfsK6dg?=
 =?us-ascii?Q?JMRBGO4qN7P/fzCWeV6pLmezrreAxFN2dq834xCm6E2lf4UMGapqDAcD9v5w?=
 =?us-ascii?Q?p0p7QJ85ZG+6Awwnj0lLiSNEFydKqeoHptDSY3izLtMsG1fes16QtOl6uQrd?=
 =?us-ascii?Q?7uVs4OGep1+AnWdHiIEQeT4TWGFWQWLSjQqxZeLz8Xf+upfaKNz36sFaN7V0?=
 =?us-ascii?Q?7hd5nx7isUW1240k+QYHnfFlvJ4LUAoYduCKMCWBYgkg36iIw71cgfGzSirH?=
 =?us-ascii?Q?hvQEBf0OGmhl8LMZXKiKNWTNgKULkGllK7Px2JXGYJtEtXDSbUb6OcPjUGAF?=
 =?us-ascii?Q?OZuTMypIRBPY9I7O4e/uRkBIyPqAH/B/RteGoFlrMLp1zv+26EE9mfmFN72V?=
 =?us-ascii?Q?d/qJ4dlr6MImw5KdV4Reow9qJvF2YPuiq3WsSfl+KagB91of7LoyY1pCEyvK?=
 =?us-ascii?Q?zWssNbbEcl6VeWTrJZtRcTJs+IOu9wg+iUTso9Qjw665TugZWpUSdOL6zowY?=
 =?us-ascii?Q?ji2msKL78htxS6DLwH0I1dHp1Yd/C14yWb1owR7mgF5LVq0keMSDL3vVYLHf?=
 =?us-ascii?Q?TUD283Acm6eeWNtn5cCnLIoFiOrZPgbCq4hf0dIENVQbqlEC8p6ZDW0zZrWl?=
 =?us-ascii?Q?SAazalzSl57qNFMBjf5aTeA15TE3P0tuZr2N7m1Vo0A5chYN8ybd39C2+Gv7?=
 =?us-ascii?Q?MTl3g1mEseaLjzAkA5o3RtJTH2jhcPIhkR1Uwx+zEBywws8hv/m8snv1WGzl?=
 =?us-ascii?Q?de7FnC1BcPeytjPMe+r+JVYi+pwo2PPtPfVCPFqhgPNuT/9bIelFgAn2ob8m?=
 =?us-ascii?Q?ICSi7qfxsDiGgcjuICD7iClkwWbImVWCfVUmfYibtGOitOmfQ5BPqAvt567R?=
 =?us-ascii?Q?mPU4rS+MILUp1neghaq1/fN30PitP/KsC0SFgtnpGomjinhV/5vxX/4E/SeO?=
 =?us-ascii?Q?UufnjOvK3F7RTSh4ki//qtY+oUichQHh1eQnqCAyjC+21C/yn7KVgiL8ewBw?=
 =?us-ascii?Q?6Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab25dc13-5650-4d01-37ae-08da8b4109bd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 11:07:48.0751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3xfwNmbhX5i/iRFoqGg5X+YxmQVuDVNevdsMYhEENy0FM7wlsscw2wq5nUfU9Le5M7Aq+3k1AmeguYnQeD1034W+XVQirLX2mQzXbL0M7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_06,2022-08-31_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208310055
X-Proofpoint-GUID: z68D1ZUf8f3a9oSbRsFDijwn9ncIX4b2
X-Proofpoint-ORIG-GUID: z68D1ZUf8f3a9oSbRsFDijwn9ncIX4b2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 10:43:36AM +0800, Hawkins Jiawei wrote:
> Kernel will iterates over ATTR_RECORDs in mft record in ntfs_attr_find().
> To ensure access on these ATTR_RECORDs are within bounds, kernel will
> do some checking during iteration.
> 
> The problem is that during checking whether ATTR_RECORD's name is within
> bounds, kernel will dereferences the ATTR_RECORD name_offset field,
> before checking this ATTR_RECORD strcture is within bounds. This problem
> may result out-of-bounds read in ntfs_attr_find(), reported by
> Syzkaller:
> 
> ==================================================================
> BUG: KASAN: use-after-free in ntfs_attr_find+0xc02/0xce0 fs/ntfs/attrib.c:597
> Read of size 2 at addr ffff88807e352009 by task syz-executor153/3607
> 
> [...]
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:317 [inline]
>  print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
>  kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
>  ntfs_attr_find+0xc02/0xce0 fs/ntfs/attrib.c:597
>  ntfs_attr_lookup+0x1056/0x2070 fs/ntfs/attrib.c:1193
>  ntfs_read_inode_mount+0x89a/0x2580 fs/ntfs/inode.c:1845
>  ntfs_fill_super+0x1799/0x9320 fs/ntfs/super.c:2854
>  mount_bdev+0x34d/0x410 fs/super.c:1400
>  legacy_get_tree+0x105/0x220 fs/fs_context.c:610
>  vfs_get_tree+0x89/0x2f0 fs/super.c:1530
>  do_new_mount fs/namespace.c:3040 [inline]
>  path_mount+0x1326/0x1e20 fs/namespace.c:3370
>  do_mount fs/namespace.c:3383 [inline]
>  __do_sys_mount fs/namespace.c:3591 [inline]
>  __se_sys_mount fs/namespace.c:3568 [inline]
>  __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>  [...]
>  </TASK>
> 
> The buggy address belongs to the physical page:
> page:ffffea0001f8d400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7e350
> head:ffffea0001f8d400 order:3 compound_mapcount:0 compound_pincount:0
> flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
> raw: 00fff00000010200 0000000000000000 dead000000000122 ffff888011842140
> raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> Memory state around the buggy address:
>  ffff88807e351f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff88807e351f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >ffff88807e352000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                       ^
>  ffff88807e352080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff88807e352100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> This patch solves it by moving the ATTR_RECORD strcture's bounds
> checking earlier, then checking whether ATTR_RECORD's name
> is within bounds. What's more, this patch also add some comments
> to improve its maintainability.
> 
> Reported-and-tested-by: syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com
> Signed-off-by: chenxiaosong (A) <chenxiaosong2@huawei.com> 
> Link: https://lore.kernel.org/all/1636796c-c85e-7f47-e96f-e074fee3c7d3@huawei.com/
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com> 
> Link: https://groups.google.com/g/syzkaller-bugs/c/t_XdeKPGTR4/m/LECAuIGcBgAJ
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
>  fs/ntfs/attrib.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index 52615e6090e1..904734e34507 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -594,11 +594,23 @@ static int ntfs_attr_find(const ATTR_TYPE type, const ntfschar *name,
>  	for (;;	a = (ATTR_RECORD*)((u8*)a + le32_to_cpu(a->length))) {
>  		u8 *mrec_end = (u8 *)ctx->mrec +
>  		               le32_to_cpu(ctx->mrec->bytes_allocated);
> -		u8 *name_end = (u8 *)a + le16_to_cpu(a->name_offset) +
> -			       a->name_length * sizeof(ntfschar);
> -		if ((u8*)a < (u8*)ctx->mrec || (u8*)a > mrec_end ||
> -		    name_end > mrec_end)
> +		u8 *name_end, *arec_head_end;
> +
> +		/* check for wrap around */
> +		if ((u8 *)a < (u8 *)ctx->mrec)
> +			break;
> +
> +		/* check whether Attribute Record Header is within bounds */
> +		arec_head_end = (u8 *)a + sizeof(ATTR_RECORD);
> +		if (arec_head_end < (u8 *)a || arec_head_end > mrec_end)

This works but I feel like it would be more natural to just check if
a was valid and if a +  sizeof(ATTR_RECORD) was also valid.

	if (a > mrec_end || (u8 *)a + sizeof(ATTR_RECORD) > mrec_end)

But what you have also works so if you want to go with that then that's
fine.

regards,
dan carpenter

>  			break;
> +
> +		/* check whether ATTR_RECORD's name is within bounds */
> +		name_end = (u8 *)a + le16_to_cpu(a->name_offset) +
> +			   a->name_length * sizeof(ntfschar);
> +		if (name_end > mrec_end)
> +			break;
> +
>  		ctx->attr = a;
>  		if (unlikely(le32_to_cpu(a->type) > le32_to_cpu(type) ||
>  				a->type == AT_END))

