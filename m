Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BF14D2D19
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiCIK2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiCIK2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:28:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9169241602
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 02:27:30 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2298S3Jb010008;
        Wed, 9 Mar 2022 10:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=r+EmaRPrtPyhs7bzpQfClPAitNhHiDbAMPQ5Ja2wVgY=;
 b=oTItXZ6Mu5infF0LDzqBynenw4LR2GpxoaAgfXoUDgj0nVvIf06f5LDmfWvg4PeysK+8
 37b0NAEIUS8PfAz8yJ9ctjWGKhNob9NH3jodqrCloR+hRSYSRMIHQ3M5jCT6yJFq1WE2
 nSZPApRDKMygtzsHg4S3OzQZ2r+qlXSjM+7YhLkQ6kJneCh061uAGrsTsUqsHaZaIZDW
 bObke0aQDio3+lqMh5zKraDG31Z8RNrBaV4PO2capMMgGLDEz7NPVKc0thfBHnBq3o7W
 vfTWqfa6LdqKd5LxcVtmAxs1pWB/w6zch41PN2symltWJ6R9fMQdtVRkjbUCDjzp2wnK uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekyrasa9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 10:27:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 229AFvkk063145;
        Wed, 9 Mar 2022 10:27:24 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by userp3020.oracle.com with ESMTP id 3envvmct2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 10:27:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0ZMtCkhHUdcEUDF0+FiAz4bf6Twy1dBjbA5Zmp50mArOgdbhM/TVdUZ6Lg8p/TQUnhL58aojxIxclUx5KG+ETbnGYKfeV90ktUBI7Gf1CNwtipmj4B6QM9uw9Z4q9DIC24/WUZEgU0gFj9KcCkmw9U5+aNE4Yrwxbf3swiCM2eAYaJ90qfrEsVH8oi7GO1q6O+si+kdJytaDsiONcY+6lasdCFtzzL71JAdYtf3kNwiAJ59fA1k59CbPuHMfkSXiRUHly10XLJFuWZB/tT1xXGhjc2DImgoj4UAnz+yzo4lgs6UvOScEFM1fVP9LYO2A9FQZza0UjXiqobyfzI49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+EmaRPrtPyhs7bzpQfClPAitNhHiDbAMPQ5Ja2wVgY=;
 b=BZFiqEQvGfxJLODA9Csz7v+r/2lR2j4i7gbs2ESontVbmNNY9MpLa27+bxqvXvQctPf6FOWQSfuUMWi2ZO8LQ0cauex6KH42dcJbJ7JR1Skxx3vFYGYGDZgB3J7T22xG6N4PAlfexh3Kk7z+fG3HpbTSLXOVXw/IJBFhA8Mn0N+DBGg8TkyXKmhScyQ2k0mGpD0KWcRDsKGfWF4eCkn/zmM4lD2tO9JYhx5XkUG6w+01xnOCHOL1Hc5Y1Ry/Z/UOFIOP+Dh20DUBDuWY/rs4u1AFiJFm45P2x3hqYWtqsoTzY81OKZgSXR2D9QwqCS7ZmmtkwjLnXUAH07Yl5mUwBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+EmaRPrtPyhs7bzpQfClPAitNhHiDbAMPQ5Ja2wVgY=;
 b=RNhBt+6obUEj6NveHH1w1eHOjltwzvOogWqB61+SmoaxO8gLXBE7SaXs2jOE1Pdo6+/v6BI1mKuff+xX0zs/AbdQRgomDDLrmCIQtKxOr4GFTSdeVDICXIj7sDwJILlXwpeZaYDuMuWwW/1uz2daXq6GpiXo4ofBG7RinT7mvSw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB3895.namprd10.prod.outlook.com
 (2603:10b6:610:9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.29; Wed, 9 Mar
 2022 10:27:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5038.026; Wed, 9 Mar 2022
 10:27:21 +0000
Date:   Wed, 9 Mar 2022 13:27:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Gao Xiang <hsiangkao@redhat.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: fs/erofs/zmap.c:394 z_erofs_get_extent_compressedlen() warn: should
 '1 << lclusterbits' be a 64 bit type?
Message-ID: <202203091002.lJVzsX6e-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0100.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:33::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 409ddf65-7c42-44dc-5758-08da01b76556
X-MS-TrafficTypeDiagnostic: CH2PR10MB3895:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB3895F7A5503281E97DDD85508E0A9@CH2PR10MB3895.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3gyS2KgDiRSjJ4WEv0xBS8TzlSDIJgNzheUhD7Fc66SbGU5M2Gi6NMj+gA/3yMs7SL+Isir8x4z2q+BPkkwYVE0YfehYjm6ZBTC+2PEIREKuos5sLzKnZheY5oefw48a3IGzE/g/z0QIqlskEqniDPWwqBfpN68M6uEKqNLddF+REeOCrftWH+T8XeCFxOLGzypuotlLNpf4EsypMLq1mjZoeJ5/bJT7WJKS4xxNb/49gupg4fpw+3+WdzFj+W5fvHdiM6p2PHDoxTTfk4OfKApzSTKrbdxMjOccfrxCKvntI0dnzA1jK6dWi4nrWw4l5WwZN1ZXpnqNls/M2rtmIWUeF2i2K8qT+KuAhTBs2ZjNEbDQ7MFxDTvsUNDLaJ/mYmTpP9Q1H4YpZZDIswzolJxIUoGXEKvOH0eohnCtHFNQNVbpMFvDv2a0zR8ZHNB2IZw+pGBFK9Jc9zOiqoumvJkinpfZ1lX8vxNJ4IRFLYBk2L3beYvwXVp89NOldMlYJW0DcLMVzkPDWrXjtcEGmy2ng5mxc+WUCIbcgBIDKwYz5BYbdNkexC0bu2wGsyEa1DgJBtC94awRxUsRhplhqAfGjSl2EzzkSFBuwZJjAQTt08wzy2Ozs9XABze29vOChOZskQQbfIHLoVlv+TTnVGewBFHBVgHArjnogqO4677ecKDmMa8WwPTvEhQOLVxWjX8HYYGLCVXjcGq03TgKGr/jj2w45uZ64C2IHd+dcBvQpyVbmc+QJ8go18eVRh/KB2HG7EYra5M4Mapm0pG1+Z69o5S5NGZ3FqHuuRztBZyf75M66xkSziNBSMMAkJ6QZY/mAkg1ZYCrNobCT1ySbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(966005)(6486002)(6916009)(316002)(38100700002)(8676002)(66476007)(66946007)(66556008)(4326008)(8936002)(6506007)(5660300002)(26005)(186003)(1076003)(83380400001)(52116002)(6512007)(9686003)(6666004)(36756003)(44832011)(86362001)(2906002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wsl5n0jZ2q9mq2GmmRUVvgOBQ2OU1dZJIuqcOfpmNb2PZKJxk9iKaYdfQ6B/?=
 =?us-ascii?Q?oMqoYEIaq91XsZ8UeQRURfJhKmbEe+VY0LaOTTVgL/++uJ1HEhzQoZqNMmHb?=
 =?us-ascii?Q?zyl354KTF0HoTUfW3MMxb6LW+B01LiUXzcQK8wsVthRlDMtyxP0wbHndodOz?=
 =?us-ascii?Q?/7CvoD869NZOec390CeQPRYBnJ5czGl8LcZhrwiMdg/Qdl6Xq8V/QAPeUro6?=
 =?us-ascii?Q?UklpAcuUueFt6wrmS9Qq1VaJucFc4+MjUayDAwCQ54cIxyFSNQvYxdgKKqoZ?=
 =?us-ascii?Q?VP67P6BxopzjPkjGfQU+Yy8oau9Dmi/Y7npohxmwFnDCIn4ArtHLooZCKzqb?=
 =?us-ascii?Q?RNrToz6LqXb6Hz4GBRkN44z6LNu9oCIYjwouaI59OsvYlzmj0sG/fz/zlMk7?=
 =?us-ascii?Q?mRuM53FInsk0lE8f6xbEbCwhKsEVrAr/2sYLQcVUYuHdVIG94py7i9TJFzMq?=
 =?us-ascii?Q?uIVgZXlCSW79p2rUb7YJp9sTxbTVi4Zjzp4VcPOH0SmZRkvrFJ9pZbK6np/Q?=
 =?us-ascii?Q?hhSzs7FIiSFaA86c9y0MWv77gF86ulduVW2kgTZchNgWyi5EFAjNgp0jTJkW?=
 =?us-ascii?Q?xVyhj8w8H5BXVDMxws3pCnLlMoWulV1hAZci7L+pcPnlJ6y+fs0qAuCJF5AS?=
 =?us-ascii?Q?lmvhmvqUPjwNzGV6dsuuZD4jhagtVaXS097yqhdgErFRXzlgQANrkNVarBPW?=
 =?us-ascii?Q?vuHaRrtNzUK2l8R0MmhrH/LG1Zj8mo234PfUjTPEZY8O+B4A/tG62SW22TgE?=
 =?us-ascii?Q?gw8OjwaZV8IEs4yVkuCBxd2I9ehCeCCkP7clru91lI8d7ruau7bN4AY4kD/5?=
 =?us-ascii?Q?N0xBQyEz0T/NTPqfLWaAYafr6Cm5SDTIwiFLgOmCfeil39Oz44iQwQIAqGEX?=
 =?us-ascii?Q?wCXGUXV4/mHuOIdGY0f2r9UU/f316RZnGlvgJfngYur0JRYvVdcQWqpiOb6e?=
 =?us-ascii?Q?odYOk7SpyBKu2BFRldQSrAV3hhyd+0L+/+5zPnupcoMmNl2cEUEPHvbBUU3B?=
 =?us-ascii?Q?uFQ3ELu4z3GF7sibJAZ92IcV5als4Y3GrJAm3sFx/T9VtIPUwO6D4ssw0qzm?=
 =?us-ascii?Q?p9JOb70fdpqV2+6ewLOaPFbt7G+FAgJzeaXx4dTM7BJb5Abfykvzpsn+FFb4?=
 =?us-ascii?Q?reObUmvxf36m+Cu/GRQ61LCkDRyGVFVWwYFeg4B++O7ibHHvMKg9M6qTJkBy?=
 =?us-ascii?Q?3uVvKFmHSHM3AcmBhu2ScinvcO8wsLmOE2lnXXWSCYsOu/fJPVUkbodDdvUC?=
 =?us-ascii?Q?uGP1rTSDhxa+3KqBermjmn/ZoLfeRiLQMZmE8Zx3AdeTr8UUXNAQljZddni5?=
 =?us-ascii?Q?yptziAraAfEnxISfsDi96X3ePvDbklLI4+OFoIIgyF44upr3oibHb1YLCgR0?=
 =?us-ascii?Q?5KFcHqezRhKBvctNEVhSPTgIDtLDjf/MK4/hcy3yHHhh8oeIqXWAkfIdFepY?=
 =?us-ascii?Q?l8AAEFF0QYfYVjrwW9oiLn8ts+jFS6YlirrnkuLGMG48mtzu9D/Vio1Ke0rp?=
 =?us-ascii?Q?k48hply9iu7avFcq/PR5E4KqFU+FcHe7GrSRGRvjaVTbgJ6S6NqEbdcaEhKd?=
 =?us-ascii?Q?E6+hzCiRrXa1+xeT2L/5Ck+g0n9hVodkjCsm3EszLqMVoKDYRAvW/GAerF55?=
 =?us-ascii?Q?rjdo5AH0zy+dmVtgcObxx8Drct9vcit4TLknOavRT4RWJf9psMSJn1eWbRLT?=
 =?us-ascii?Q?RcS34A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 409ddf65-7c42-44dc-5758-08da01b76556
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 10:27:21.8709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmTwRdXYLqNBpjT2DwJQTGye+OW6zZStWMfhSBZJUy539flokEudIN/yeSk2NZf73sK8fSCI/elfmyMcJVP2kzOLlyqkwO9rWnZmUWJq9uQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3895
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10280 signatures=690848
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203090056
X-Proofpoint-GUID: s2vpprmvNbzh1ksROSj9lxNQD4cd3q_O
X-Proofpoint-ORIG-GUID: s2vpprmvNbzh1ksROSj9lxNQD4cd3q_O
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   92f90cc9fe0e7a984ea3d4bf3d120e30ba8a2118
commit: cec6e93beadfd145758af2c0854fcc2abb8170cb erofs: support parsing big pcluster compress indexes
config: i386-randconfig-m021-20220307 (https://download.01.org/0day-ci/archive/20220309/202203091002.lJVzsX6e-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
fs/erofs/zmap.c:394 z_erofs_get_extent_compressedlen() warn: should '1 << lclusterbits' be a 64 bit type?
fs/erofs/zmap.c:423 z_erofs_get_extent_compressedlen() warn: should 'm->compressedlcs << lclusterbits' be a 64 bit type?

vim +394 fs/erofs/zmap.c

cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  381  static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  382  					    unsigned int initial_lcn)
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  383  {
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  384  	struct erofs_inode *const vi = EROFS_I(m->inode);
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  385  	struct erofs_map_blocks *const map = m->map;
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  386  	const unsigned int lclusterbits = vi->z_logical_clusterbits;
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  387  	unsigned long lcn;
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  388  	int err;
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  389  
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  390  	DBG_BUGON(m->type != Z_EROFS_VLE_CLUSTER_TYPE_PLAIN &&
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  391  		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD);
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  392  	if (!(map->m_flags & EROFS_MAP_ZIPPED) ||
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  393  	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07 @394  		map->m_plen = 1 << lclusterbits;

1ULL << lclusterbits?

cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  395  		return 0;
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  396  	}
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  397  
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  398  	lcn = m->lcn + 1;
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  399  	if (m->compressedlcs)
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  400  		goto out;
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  401  	if (lcn == initial_lcn)
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  402  		goto err_bonus_cblkcnt;
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  403  
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  404  	err = z_erofs_load_cluster_from_disk(m, lcn);
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  405  	if (err)
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  406  		return err;
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  407  
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  408  	switch (m->type) {
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  409  	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  410  		if (m->delta[0] != 1)
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  411  			goto err_bonus_cblkcnt;
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  412  		if (m->compressedlcs)
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  413  			break;
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  414  		fallthrough;
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  415  	default:
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  416  		erofs_err(m->inode->i_sb,
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  417  			  "cannot found CBLKCNT @ lcn %lu of nid %llu",
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  418  			  lcn, vi->nid);
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  419  		DBG_BUGON(1);
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  420  		return -EFSCORRUPTED;
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  421  	}
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  422  out:
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07 @423  	map->m_plen = m->compressedlcs << lclusterbits;

Same thing here.

cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  424  	return 0;
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  425  err_bonus_cblkcnt:
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  426  	erofs_err(m->inode->i_sb,
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  427  		  "bogus CBLKCNT @ lcn %lu of nid %llu",
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  428  		  lcn, vi->nid);
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  429  	DBG_BUGON(1);
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  430  	return -EFSCORRUPTED;
cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  431  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

