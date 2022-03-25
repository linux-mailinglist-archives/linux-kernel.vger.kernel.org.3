Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2314E720D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 12:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354751AbiCYLNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 07:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349575AbiCYLN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 07:13:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1531CFB94
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 04:11:54 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22P7Zs5M031145;
        Fri, 25 Mar 2022 11:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=1/PxpTY8hzJwNU4Aj5tLSvG/Z4d5A+tlBOi8LAGf5jo=;
 b=ZKZkiuHoRMEclC52Jnhrz0LWR9Yr6szUHTHphyx8J61g3RWaaHQKOWhJOHW1RK4T5MIE
 rVvO+7nTJAcals8banfDjCBs9wpEldeXU0m6BpZjqvO4kwWNpPruNToSC4l2o6CrluhH
 lAVr6BC7vlapNkhQXWs7P6fdTLdAQYDqAG8lr/yiT/ABUfIWjjRkAjCTQklVWL0LOvHe
 AqYY+c7D4EZTvaHtY4E4ik2s0ka6XHJvSP+lByBQ0Sugc/1O4RAF4SgEpOWIi1VUry78
 pXrO9e9jQD97U9hWP6iyZ55cc+Vjq8daRxiQL1SkK10f3r2P+IgADESMdTS0SVHdVzCg Rw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5s0xyd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 11:11:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22PBBdBJ018111;
        Fri, 25 Mar 2022 11:11:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by userp3030.oracle.com with ESMTP id 3ew49rfg4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 11:11:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auXzRE9TRjHtrLfuBmAtHxCYW51YbwljbyjWjPTAMx6DPXKRZvX8RxKH5JWNjBmESzmxOTTuF7Yh5ZFbUqBKCc0+SyumP70jqN1Bo+qsV47dR2ub1hyu8Lu4Bt4ytRHj5WAvJs7Y7AFXsPtD8kFvQNRIuu+KhGU5XoSARXmLrGzuSzOVsiYrNcU+jN1kiDMiY6eQ/tX5Zx8RTFbqi9Jt554J9wUm2vo8LKQtMf+9Oj7uPYaz6yki/708+H/lomAb3hE+tJsG5Ykc1ZkBfpau3BugnIR8EHtm+n2twDLPaevFPEuuObMCk33JXrh4Y3Vdo7lWqMXzMZMsn7n80/tFBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/PxpTY8hzJwNU4Aj5tLSvG/Z4d5A+tlBOi8LAGf5jo=;
 b=QqBWS8zDE1AoBVDVqkKiYDmIgVl0cqegChAOZhjhlcS+CYHo46RY5tCZpyOQ04hwK4bTO1DcECcKdb9SHPQXEr+YdwV4hLvcd2Ad4cg+00eN+/WYPokI/acSXQ8AzikEOgMxU8WivF5KnO7aU+DjqmUsCR0/5iC4ydJG/Bk11bd/QphWZ8pa3DjTB0Qd2f45EkhgvU74HZzd6dSZHwUrodmPluT6sSvi9BF04F604SrS6yFlBPa/GpW2Cr6UbM0cICrHo+GjFwfHvJFwIN64GdKcK9v+w/dFFBF9NVi66YDhx8PwYhjIu4M8vBgjKFJNou4K1PPt7+MevbqFNiGZ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/PxpTY8hzJwNU4Aj5tLSvG/Z4d5A+tlBOi8LAGf5jo=;
 b=LP11e9QTGxkPW0lWBPITlHGgAJkk7+9a5323Cd0AFws1h/0sGlywIfzbs+U8/crfM/DOOvPzPbdsduJzHUL5SM19UjPHwROV6XPcQ7IGsLAdZ/u9dAaWTmfQff9WdatPASEPnhnWgTw8ofFw0KGnLdgT8bnnJfF4CoTxys3lwIY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB2741.namprd10.prod.outlook.com
 (2603:10b6:a02:b3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Fri, 25 Mar
 2022 11:11:47 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Fri, 25 Mar 2022
 11:11:46 +0000
Date:   Fri, 25 Mar 2022 14:11:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [nsaenz-rpi:pcpdrain-sl-v3r1 4/4] mm/page_alloc.c:3571
 __rmqueue_pcplist() warn: ignoring unreachable code.
Message-ID: <202203251815.T2oLEgNJ-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0011.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcfcdf0f-2cf1-4b0d-5fe3-08da0e503ffc
X-MS-TrafficTypeDiagnostic: BYAPR10MB2741:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB27419D90953908131C6BA2058E1A9@BYAPR10MB2741.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +aaNg0ZYGukhQoF+JLjEUBoaV2uJ78hNuZ2SIvNDDux4gpGdcuKCuEuPOK77eSUDp93fN2lhOrOVG9sQ9HN/rMgfJWn4gf6OXc77wOPrmz4/vCQpVJX82qkHJYoIKfoDE7GDfVV+ngCf4MWI6g0Ul1Y8DXUHLkyel6Eg24PGlIyfxOLCdQMfDph3O7ZGvJV4+Wwor/+RCB9MvZw7RqtaoMH4j9zaPI5ybIF65Ps1i9JCENn1RD0Hk56MXMCRXi3yspzP5z0SBtusMNbZoso3X4BaTURrLUUyvTUStGlsG4fivutIJm1rlidUkIRIrL21khCBX9J6Y5/ZlnxEsyi/hAz3Q9I+LR4af9M85nxdobER8Z3BVaGZuMQFEOFHM2wow1zVWsGy7GFpcuTqq+sRrnVgkT2awn5CHMYtHZI5m9iHDHqUTIwB2cgSoHsV4s2rbievYhE/syN1bOrSt/H/pcIefkTrl3LCZu38YGV9CgBwZ22m8+C+hnpJcFPTF87/J8A3MUxOAwgKN6B4QTlo4eXx2zRhituHzIvzSk8wxfqOyjOSAEVyPIvNbmPHbXQWZ2P9389ZBZxAPWKwhaHixSV5EKNlp7iY9q6NKfp6AIkdQAbmXcKNJl29VRpZ7M1zJ7Nzc0AUEh55dPNVuPwqFd+lmZZ4JFYo3dkoM33+Ob3RMNW36GUii+8CL0EYIoFH5U/ZyywHItLMHlvMRm7/eBlYYuqc7aKA8pVtTKsud5dbFCGRsBSsPHIPxP0hJkkiLQ2JmJwvfeR0ZDrSOgPiVstBvPX5hyMOn4eSx0YjhmWViB8ui0nY2y12ApErVzHo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(52116002)(9686003)(5660300002)(966005)(4001150100001)(26005)(66946007)(316002)(44832011)(86362001)(6666004)(8936002)(38100700002)(2906002)(83380400001)(36756003)(38350700002)(4326008)(6916009)(6506007)(66476007)(8676002)(1076003)(508600001)(66556008)(6486002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xhYOGllUSVN+C1ItVzv6bE3GAi6XL5Bgj0x/o02fVAxKTS7pazemVflw6DlU?=
 =?us-ascii?Q?xFMTfhspcXxuij1PKy87T1FmUWLEjUFxQ9kEaeKgQWthc89crg8CDRcMkzmC?=
 =?us-ascii?Q?di7VY3thzjneZ2GDpSIIIl2uAQ3UKqUo09ZkRtWcaM1PdmkFiIqd+vKVFCjg?=
 =?us-ascii?Q?8K9GzAjt8864eLKaP4pFIfjuW6ilAK02ekCJEgDh68NDjSxgSaDm+wjQn4hC?=
 =?us-ascii?Q?XroQAmXwDz3BKdN11b/IVI1jnviN7HUTj2Kg6YKlRB2CmxZFU3BvDge7QWgC?=
 =?us-ascii?Q?cF15pBb5a+WSWUmMcF9Fcg7cl4Ip6PSAfgM12crZrpBEOqQuZz9L2LlotIES?=
 =?us-ascii?Q?wOTtiDrbhjf12mGh5TiR6txykbV6VyR3rPxuBxjXzCR0FEYIwfbNTbOfOiKj?=
 =?us-ascii?Q?M5SS0oGEW3bMcuCzUP8OoPnNm0dQNl8RreL18n/AZNeF2sNazzTg1a3Xiboe?=
 =?us-ascii?Q?oPyyTsi8CIY9+n60Fcvtmk7NcKmpWx8mAOTWCaHR8On50Di9ZDu5x1bHnwGF?=
 =?us-ascii?Q?vWW5qBpMtscKztxrjiz0nl41EFVhbBsIqbQja9fzJGwBF0XIuOg4WBjU+xZT?=
 =?us-ascii?Q?+dji8cnQwF3kR40ggGNNLM7cdpy+Z8TPAuA6MVtQPhmUBeuFQlXoimePgQBw?=
 =?us-ascii?Q?SqOqTnNOeiDYHiKDFo13Bj31UAbtYYRdMbSqEUiN+0sR36pxy4OeyvUG7tH/?=
 =?us-ascii?Q?JQsfokOLFJx/65dFrwPata7EeLFTxv8WccqAlny5vKjS8wwNsjvM6e99+/sn?=
 =?us-ascii?Q?r8dRfqEMkA9qfjDurmbHB5CZUgIbaVEi4kVzgiBw9ZydcaRGMoGK2I4jD6CS?=
 =?us-ascii?Q?npIJlW61HSpkNaAXrWfHTXw010cI9sTG3HVe2ojI77PFSonQealdRv9PYfre?=
 =?us-ascii?Q?BQFNuTo/PnbVDtEib0xKgQP4I0/CKuia5Egy8xOQu33ZMFMYBxR7NEX+KfFN?=
 =?us-ascii?Q?Cw+PwWlNCiVLAi8CfZDHk/onHtYWjQbdzYnr+rv9jr7WVuSC0rgp9ag7tp3H?=
 =?us-ascii?Q?AHsh6ekPAoHNbo4C4xcaXTatmBhmiTk0xv1IpMHK3fF+mi6wewV7FDFkqvWV?=
 =?us-ascii?Q?0A4UuwEvv9lD5/RgqblaOPW71B3oKeW/19XHDBAuvw8862cjitENvhkFs9Uk?=
 =?us-ascii?Q?OXU/JRePJ1VLcjp7Cddi95l7vOf8rbrKkP8A7agMNFxkw98fGErTwV1kDRKX?=
 =?us-ascii?Q?DCRRa478ikzZ1dszD/d48cn6MtzMzPQ+yXxoB/eaKi1JqZnRntbMM46io3xe?=
 =?us-ascii?Q?9fOuLA13GFMVAlR/FyFlbJUw3c5hCFwA1yhSDFpyDAPD3EkLEU8F0Ny0F55d?=
 =?us-ascii?Q?OhrJhglZ5PSefmeFNxOBcb7CMd+1S//Hts1y14kfWb4tQpgMWuwAylQQdugy?=
 =?us-ascii?Q?LC9BcVlB/oXrCRT7iMOA+oEoZk1zMU56LttPkOFAjZpSwIq8BZmQGdxEdPRq?=
 =?us-ascii?Q?Ed8wKaXIVzrSUeToGPjSzY2C7a869I7c5ysJO21vRzvTIvVPV695KA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcfcdf0f-2cf1-4b0d-5fe3-08da0e503ffc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 11:11:46.3772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfVVkP+mfp/k3EDegTcxCONQ21p554YXYju9mRGOaNa+EHavgjkJ1cF6z/0ujEJ2FuvG/vG31NiQfCCD/R3AHZYONU/lGZhv6Gr8aLuvojw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2741
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10296 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203250064
X-Proofpoint-GUID: gO0vjd_ZvBBJbCj5CFuCVbR_IKtBkUOG
X-Proofpoint-ORIG-GUID: gO0vjd_ZvBBJbCj5CFuCVbR_IKtBkUOG
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git pcpdrain-sl-v3r1
head:   9710838f0540b295e2ffc2ded307fe65a9fa7111
commit: 9710838f0540b295e2ffc2ded307fe65a9fa7111 [4/4] mm/page_alloc: Avoid disabling interruptions on hot paths
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220325/202203251815.T2oLEgNJ-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
mm/page_alloc.c:3571 __rmqueue_pcplist() warn: ignoring unreachable code.

vim +3571 mm/page_alloc.c

3b822017b636bf Jesper Dangaard Brouer 2021-04-29  3532  static inline
44042b4498728f Mel Gorman             2021-06-28  3533  struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
44042b4498728f Mel Gorman             2021-06-28  3534  			int migratetype,
6bb154504f8b49 Mel Gorman             2018-12-28  3535  			unsigned int alloc_flags,
453f85d43fa9ee Mel Gorman             2017-11-15  3536  			struct per_cpu_pages *pcp,
9710838f0540b2 Nicolas Saenz Julienne 2022-03-24  3537  			struct list_head *list,
9710838f0540b2 Nicolas Saenz Julienne 2022-03-24  3538  			bool locked)
^1da177e4c3f41 Linus Torvalds         2005-04-16  3539  {
689bcebfda16d7 Hugh Dickins           2005-11-21  3540  	struct page *page;
^1da177e4c3f41 Linus Torvalds         2005-04-16  3541  
9710838f0540b2 Nicolas Saenz Julienne 2022-03-24  3542  	/*
9710838f0540b2 Nicolas Saenz Julienne 2022-03-24  3543  	 * Is IRQ preempting or a parallel drain in progress?
9710838f0540b2 Nicolas Saenz Julienne 2022-03-24  3544  	 *
9710838f0540b2 Nicolas Saenz Julienne 2022-03-24  3545  	 * If pcp->lock cannot be acquired, the caller uses rmqueue_buddy
9710838f0540b2 Nicolas Saenz Julienne 2022-03-24  3546  	 */
9710838f0540b2 Nicolas Saenz Julienne 2022-03-24  3547  	if (unlikely(!locked && !spin_trylock(&pcp->lock)))
9710838f0540b2 Nicolas Saenz Julienne 2022-03-24  3548  	       return NULL;
9710838f0540b2 Nicolas Saenz Julienne 2022-03-24  3549  
479f854a207ce2 Mel Gorman             2016-05-19  3550  	do {
5f8dcc21211a3d Mel Gorman             2009-09-21  3551  		if (list_empty(list)) {
44042b4498728f Mel Gorman             2021-06-28  3552  			int batch = READ_ONCE(pcp->batch);
44042b4498728f Mel Gorman             2021-06-28  3553  			int alloced;
44042b4498728f Mel Gorman             2021-06-28  3554  
44042b4498728f Mel Gorman             2021-06-28  3555  			/*
44042b4498728f Mel Gorman             2021-06-28  3556  			 * Scale batch relative to order if batch implies
44042b4498728f Mel Gorman             2021-06-28  3557  			 * free pages can be stored on the PCP. Batch can
44042b4498728f Mel Gorman             2021-06-28  3558  			 * be 1 for small zones or for boot pagesets which
44042b4498728f Mel Gorman             2021-06-28  3559  			 * should never store free pages as the pages may
44042b4498728f Mel Gorman             2021-06-28  3560  			 * belong to arbitrary zones.
44042b4498728f Mel Gorman             2021-06-28  3561  			 */
44042b4498728f Mel Gorman             2021-06-28  3562  			if (batch > 1)
44042b4498728f Mel Gorman             2021-06-28  3563  				batch = max(batch >> order, 2);
44042b4498728f Mel Gorman             2021-06-28  3564  			alloced = rmqueue_bulk(zone, order,
44042b4498728f Mel Gorman             2021-06-28  3565  					batch, list,
6bb154504f8b49 Mel Gorman             2018-12-28  3566  					migratetype, alloc_flags);
44042b4498728f Mel Gorman             2021-06-28  3567  
44042b4498728f Mel Gorman             2021-06-28  3568  			pcp->count += alloced << order;
9710838f0540b2 Nicolas Saenz Julienne 2022-03-24  3569  			if (unlikely(list_empty(list))) {
066b23935578d3 Mel Gorman             2017-02-24  3570  				return NULL;
9710838f0540b2 Nicolas Saenz Julienne 2022-03-24 @3571  				goto out;

The return statement needs to be deleted

9710838f0540b2 Nicolas Saenz Julienne 2022-03-24  3572  			}
b92a6edd4b77a8 Mel Gorman             2007-10-16  3573  		}
b92a6edd4b77a8 Mel Gorman             2007-10-16  3574  
a16601c5458eb7 Geliang Tang           2016-01-14  3575  		page = list_first_entry(list, struct page, lru);
^1da177e4c3f41 Linus Torvalds         2005-04-16  3576  		list_del(&page->lru);
44042b4498728f Mel Gorman             2021-06-28  3577  		pcp->count -= 1 << order;
77fe7f136a7312 Mel Gorman             2022-03-22  3578  	} while (check_new_pcp(page, order));
066b23935578d3 Mel Gorman             2017-02-24  3579  
9710838f0540b2 Nicolas Saenz Julienne 2022-03-24  3580  out:
9710838f0540b2 Nicolas Saenz Julienne 2022-03-24  3581  	if (!locked)
9710838f0540b2 Nicolas Saenz Julienne 2022-03-24  3582  		spin_unlock(&pcp->lock);
9710838f0540b2 Nicolas Saenz Julienne 2022-03-24  3583  
066b23935578d3 Mel Gorman             2017-02-24  3584  	return page;
066b23935578d3 Mel Gorman             2017-02-24  3585  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

