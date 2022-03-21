Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259464E216A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 08:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344917AbiCUHex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 03:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243106AbiCUHes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 03:34:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3C813D08
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 00:33:23 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22L3mJm5027331;
        Mon, 21 Mar 2022 07:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=aHZB1HjPdn1yNjSBu6LdFH4EGQHTr9tapvIIR22Ns2Q=;
 b=uGYdaKj8IKBezQOqID9JTAiW0/9W2dEMyH6dbrwD3MWbUgkyZxi/+7oC3MZ3qKVjE0Zb
 4wM9Is1AlRXUcmgpOcUbitp1syVZkyNtyQ57j5XBHJaROgNMj7Sun9wIaVqghhZMvJJW
 cXN1dJY1X6+d9HcvGMgYfUlkSx/muzTsV41SQZbtbVgRAKAZbg4irDBofyBS0d3F2Zdf
 6nk5dpGDTcEqcdgeROxkMSpWjTZC9DS3NNN7wislvvlz99rtcarXvHo74E1g2dI8+Ajj
 oKMrGKN4fGJqL1RQTQJEM7n4ZvGP8UJAati6x7CVcfi8mVYJsMRGT3nDs63vo7vkTW7i OA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew72aaaku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 07:33:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22L7QMMn153135;
        Mon, 21 Mar 2022 07:33:16 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by aserp3020.oracle.com with ESMTP id 3ew700amwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 07:33:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EB+VVIVBfKJXqi0YgsDszIzTorteQo+nufoIso6CAc32YBDxKuTg6zXYluyLRhPDlv8A+TR8q6r9xLR90RRjcEOtBTjmUSbLl3DElOc7bjyBMD4TtLYOcl/rr2XfWdlTCXpvCm19kTysBjr8sqHQPQfm8KaoSwCogh5BR036xBq3TtVjTTwpU8Kqkm+LFp33llsISFjyUjgmnXNG1grS/dqVBHPB4h6s7arLmDHW3Syt2bwua7la5vgpK4g9t7ywi80BG4pO2y9R+CYXW8+IoWI/Ix7yYwvhtFJ91IC2Y2kHBSmxYVo4w2kGyNMMn6NeSzu1f/PP4iZ07EUMwaqlgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHZB1HjPdn1yNjSBu6LdFH4EGQHTr9tapvIIR22Ns2Q=;
 b=AWewt5yHt3d05miJrsMpWl19UAO40PUBehf8wjVPxyluQa29g6eLgpoHJhrBC+UxG7apwgftEehvyDpva8QWQ/EtdV3InsbAb2yj+T6YXGe5hrxywQCyFkHzLCex54k30nxseoueYGO9a8+iIMBnTR9TBfEDwwj5eZvDEsi29RY9ioPNX6fU524qaF7g4a/kKKYGixdF5kkpUHaXEd4CTmXEmIw+w5M5ZOcWjWcRAv3+xq5nbt2Z7H8RNS7vX6/4SUgg8RTrlwxNYOgBOCRZbJYQz7xfBmO3wuTXhVlxuyq+sbvF7eZAdnVGpoSeEIFY37y5EjaPjklCMe5Q039l9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHZB1HjPdn1yNjSBu6LdFH4EGQHTr9tapvIIR22Ns2Q=;
 b=auon2Hkv/POFKDO6mFBPXc1TQTXgTGmijHZLYSkimb9iupbLJZpZEjVsZD3mUfTxBlPfAcJ2y2caQMUiI0oSW+rsdDs/0cl1LEIavcttPe7eN66i0QyQIVAuik738jKULI3q3EsNN8sSwxcb5ixhejdecnFuRIH9XbkEHimT4os=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1785.namprd10.prod.outlook.com
 (2603:10b6:4:b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Mon, 21 Mar
 2022 07:33:14 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 07:33:14 +0000
Date:   Mon, 21 Mar 2022 10:33:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, "Darrick J. Wong" <djwong@kernel.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [kbuild] [djwong-xfs:djwong-wtf 349/351] fs/xfs/xfs_bmap_util.c:1372
 xfs_map_free_extent() warn: missing error code 'error'
Message-ID: <202203190831.AYu7l0vX-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: JG5N7CWYJRRELAPCLLP34F4FKRK6DD6D
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0013.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::18) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f66502b8-3f4a-4a5a-cdd6-08da0b0d0ec4
X-MS-TrafficTypeDiagnostic: DM5PR10MB1785:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB17850C94DA801B05940278108E169@DM5PR10MB1785.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HbrlMp2dEytqTnDIKqVbxKGD9grUv2atipev0uyltKcIWjCxWhpayibdCuIBZFKrDSmhoUPHu4A/UmbTCu3i3XCsNY1T0r07FQY4Ntpw9gNiXwmsgBUZmzkbab71wMrwP1vY590MUPdiXzxlp/ONK88On+0oCvRfql4pmvVQ7E5OzqBF7O3PrkB+zXXIi4AOOyaLn6i5z7Os8IEn69X1GHZnG24WpVPKWC3B+14YHq6Nf7TmhDynmpC4qOrvc3A3xypva/Xz1WlKJ1AKxGLkaAvJ5FUZ97orKaEdzvU9LEy3zMmCJ6RHzNP/34fD8g0UB+4L2ZYo1y9Bg8/XUrFtUN88eqKCnXLqV5ECiOYzmuS/aow3TR8TyZtgv/1QZNzJ3iVtYvsFDpHQtutFiQIcBdXFwTe6v/A8UJaWhBLChPOrINsP3n4tsppYh91GARmNNmY94sgJOP1+7eoFt1Uo/509nG+I6jdxPWTPmhbLWCqY4G0YFIJrcnne2uIluan9K5JOIbXDnyJifpJII/7DyyuAEw9fWaIcU14W9Umfe8iaYzgBBpdq6IFef8uOTGPjzx9CCWxXHVTE4copv068XSb9GCqVnSehp5CZH8osBcwzEHYixh9cRmcTNWSMbvIbb0nplpP+iUh4ibOu21yfO3VjMxEnqvBWPG11iQEAk1cLPN8DX29CeUHYzk3ycmACTMk2KNlLfADXgO5haFZY52AuasuwgjAEZAtAwmTMZyST9X1cw4nMEJ2sW9E77QOBb8uP0YOR9XKq45DFNboUKat9PtrxU3jmzRYaK6Mt9UaLO1Ey3bAokyqaUpVMzFpaVm3uovDTCHDMK26MQmwiaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52116002)(83380400001)(2906002)(36756003)(9686003)(6506007)(6512007)(6666004)(66946007)(186003)(1076003)(66556008)(66476007)(8676002)(26005)(4326008)(316002)(6916009)(38100700002)(8936002)(966005)(6486002)(508600001)(44832011)(38350700002)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?InBgeO3x6w2P9uichFzt7LyxYbaMtSWyPzc1dzow35Fdy0lNFoPqOkAFQ6Gj?=
 =?us-ascii?Q?y7G3NaJZ4WrIQU/gSZL4glDKuMQCz18Yd3ncJLle8wnM9wFGC1heLkXagiBl?=
 =?us-ascii?Q?FdHY5ZWucS9o/0DljnUqOGTIwzP4ADGl0h/N6LX0O85491QXU+YvU5OcsJwb?=
 =?us-ascii?Q?d4apgjrodgH0ZJ34c8wAcu+KVEmiEs5yks3Yfu/24mGQd7yp5QbH9Jx2dV6T?=
 =?us-ascii?Q?oQgdl6uUcTezUP24jFEYlB3SzEYBsQKFS/OfzJIVNoiwWL2mppGEMRDrKmgv?=
 =?us-ascii?Q?KxgJmcQ+auWAoTvuEEjt6twgRl4x+NzS1SI0vHyJxR7lwRiHG7fWxaDXmMuR?=
 =?us-ascii?Q?w9laoX9hMtWzUsGkPxjCZOEjV6ceqHHOyuFG31nCMx1efCH99xwA7ANUmfxe?=
 =?us-ascii?Q?5qC3y7ZT+xNyqSlRQgeVmFu2RzIP7riLkMTEanFiWePmK7hwyxsuGpDLmBvF?=
 =?us-ascii?Q?rL9Y3KVQADhqK3odW8l7kBGfSUuVvPFMyIzztoa0eCsEWlDqAKnrOTo9oODU?=
 =?us-ascii?Q?lm5VUv//GQvq5MOegv853c5UBT5Dyryy6TEu7r6omtuLXl3EWiEOBNjAg0ns?=
 =?us-ascii?Q?YF+oI+QmNzsO2ya7T8/VOZRDkjggYMuUV4cif+ep/j8RRlbYx0dvlNiHh0du?=
 =?us-ascii?Q?TIhYyNGsIjhcx7LuJqJcrMddlewqu0pIT+BSjTFuXt4mnaga3t6iu6PFYpQ+?=
 =?us-ascii?Q?48CPXszUsZovfZdR8F7wQcGLlOrtgv8k9WAy0NSDWxqSHltHQNdfvdhq0C5d?=
 =?us-ascii?Q?x8xX/bBB9FJPjnquYQUnpTjXnZXxVqzT8mvK8/wipV6brrakAd/CvMoO7TjR?=
 =?us-ascii?Q?Ba8fRbPmqCE1OML/xDS+YoLrxntp654A898ovBeNrwRHcR1FUE+yZsWl8Cel?=
 =?us-ascii?Q?P33X7+Alx/iXGbGvX4B8AzLIgDuc6K81wO/rjUTA+dViji7QPYxKVZXOynnI?=
 =?us-ascii?Q?RU2GzHH9vMShKVUfv6B1ZgX9R5g6Vkf81cJjjvEV2UR9Ysjf/Hj+gp0fn2wv?=
 =?us-ascii?Q?OlZ38iZl7v05fY2xKtFIXQ2jqpVzKdipSA2BriqdWm+izSILvE3nrC8gWWHU?=
 =?us-ascii?Q?kuQgMBSW0xhv+6TPq04ZS77pd2Olyt7wSvffJzH7DiMalnCO6Ex32VDBqklN?=
 =?us-ascii?Q?pXDmf3l820Ijqb4XWrpBwffQjBixC6kp4ZbSp/uNkBiraPipVogPlo/XBJgi?=
 =?us-ascii?Q?8iAOKAy4/igeFZHaRm2z8+QLrYu1RYMm7JLh1zWpiQS//S4gMFIzTIDo6G2o?=
 =?us-ascii?Q?jUFeqE2yC3Ts0EVJO0Y59tnUz1qb9UtF8dD6+XOFi0qVzXnrFUKJ0kPM9Swh?=
 =?us-ascii?Q?EVQSB54aKTaom7iyMq8a+Otmc1ZA9hDaa0JAEIJ+ayQ/RsiFxW4gEFPJ7b1Y?=
 =?us-ascii?Q?QsRO96p7QLfNShRg8PzH0NIKMoZxfFnT8VrT7bYhQwImcKnxe4NVg9PAVRt9?=
 =?us-ascii?Q?DiIV16ERAk+FYghec5PB0mG7bmE10mkQLWv459kLYm5N24lwoFPf7Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f66502b8-3f4a-4a5a-cdd6-08da0b0d0ec4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 07:33:13.9574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UyVwDqLYD05J+3oM59fl0ED/hXpeHAqCw4SWfUZMCxZtZqTg58qwX/goPfav79fxAfstmBbAszWG0Djf/bUCpD9MPDvdyt6Zot9ezWe6lNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1785
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10292 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203210048
X-Proofpoint-GUID: Dzy-sk44M7gXU_uxTt21EbWdUTvAXuWj
X-Proofpoint-ORIG-GUID: Dzy-sk44M7gXU_uxTt21EbWdUTvAXuWj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git  djwong-wtf
head:   baa8d54bb35559f0bc36ec9e9933bec9ab23e25f
commit: b82670045aab66d3d66eca40f277354c3da07f1c [349/351] xfs: fallocate free space into a file
config: openrisc-randconfig-m031-20220317 (https://download.01.org/0day-ci/archive/20220319/202203190831.AYu7l0vX-lkp@intel.com/config )
compiler: or1k-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
fs/xfs/xfs_bmap_util.c:1372 xfs_map_free_extent() warn: missing error code 'error'

Old smatch warnings:
fs/xfs/xfs_buf.h:430 xfs_buftarg_zeroout() warn: bitwise AND condition is false here

vim +/error +1372 fs/xfs/xfs_bmap_util.c

b82670045aab66 Darrick J. Wong 2022-01-06  1341  /* Find a free extent in this AG and map it into the file. */
b82670045aab66 Darrick J. Wong 2022-01-06  1342  STATIC int
b82670045aab66 Darrick J. Wong 2022-01-06  1343  xfs_map_free_extent(
b82670045aab66 Darrick J. Wong 2022-01-06  1344  	struct xfs_inode	*ip,
b82670045aab66 Darrick J. Wong 2022-01-06  1345  	struct xfs_perag	*pag,
b82670045aab66 Darrick J. Wong 2022-01-06  1346  	xfs_agblock_t		*cursor,
b82670045aab66 Darrick J. Wong 2022-01-06  1347  	xfs_agblock_t		end_agbno,
b82670045aab66 Darrick J. Wong 2022-01-06  1348  	xfs_agblock_t		*last_enospc_agbno)
b82670045aab66 Darrick J. Wong 2022-01-06  1349  {
b82670045aab66 Darrick J. Wong 2022-01-06  1350  	struct xfs_bmbt_irec	irec;
b82670045aab66 Darrick J. Wong 2022-01-06  1351  	struct xfs_mount	*mp = ip->i_mount;
b82670045aab66 Darrick J. Wong 2022-01-06  1352  	struct xfs_trans	*tp;
b82670045aab66 Darrick J. Wong 2022-01-06  1353  	xfs_off_t		endpos;
b82670045aab66 Darrick J. Wong 2022-01-06  1354  	xfs_fsblock_t		fsbno;
b82670045aab66 Darrick J. Wong 2022-01-06  1355  	xfs_extlen_t		len;
b82670045aab66 Darrick J. Wong 2022-01-06  1356  	int			error;
b82670045aab66 Darrick J. Wong 2022-01-06  1357  
b82670045aab66 Darrick J. Wong 2022-01-06  1358  	if (fatal_signal_pending(current))
b82670045aab66 Darrick J. Wong 2022-01-06  1359  		return -EINTR;
b82670045aab66 Darrick J. Wong 2022-01-06  1360  
b82670045aab66 Darrick J. Wong 2022-01-06  1361  	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_write, 0, 0, false,
b82670045aab66 Darrick J. Wong 2022-01-06  1362  			&tp);
b82670045aab66 Darrick J. Wong 2022-01-06  1363  	if (error)
b82670045aab66 Darrick J. Wong 2022-01-06  1364  		return error;
b82670045aab66 Darrick J. Wong 2022-01-06  1365  
b82670045aab66 Darrick J. Wong 2022-01-06  1366  	error = xfs_alloc_find_freesp(tp, pag, cursor, end_agbno, &len);
b82670045aab66 Darrick J. Wong 2022-01-06  1367  	if (error)
b82670045aab66 Darrick J. Wong 2022-01-06  1368  		goto out_cancel;
b82670045aab66 Darrick J. Wong 2022-01-06  1369  
b82670045aab66 Darrick J. Wong 2022-01-06  1370  	/* Bail out if the cursor is beyond what we asked for. */
b82670045aab66 Darrick J. Wong 2022-01-06  1371  	if (*cursor >= end_agbno)
b82670045aab66 Darrick J. Wong 2022-01-06 @1372  		goto out_cancel;

This looks like it should have an error = -EINVAL;

b82670045aab66 Darrick J. Wong 2022-01-06  1373  
b82670045aab66 Darrick J. Wong 2022-01-06  1374  	error = xfs_map_free_reserve_more(tp, ip, &len);
b82670045aab66 Darrick J. Wong 2022-01-06  1375  	if (error)
b82670045aab66 Darrick J. Wong 2022-01-06  1376  		goto out_cancel;
b82670045aab66 Darrick J. Wong 2022-01-06  1377  
b82670045aab66 Darrick J. Wong 2022-01-06  1378  	fsbno = XFS_AGB_TO_FSB(mp, pag->pag_agno, *cursor);
b82670045aab66 Darrick J. Wong 2022-01-06  1379  	do {
b82670045aab66 Darrick J. Wong 2022-01-06  1380  		error = xfs_bmapi_freesp(tp, ip, fsbno, len, &irec);
b82670045aab66 Darrick J. Wong 2022-01-06  1381  		if (error == -EAGAIN) {
b82670045aab66 Darrick J. Wong 2022-01-06  1382  			/* Failed to map space but were told to try again. */
b82670045aab66 Darrick J. Wong 2022-01-06  1383  			error = xfs_trans_commit(tp);
b82670045aab66 Darrick J. Wong 2022-01-06  1384  			goto out;
b82670045aab66 Darrick J. Wong 2022-01-06  1385  		}
b82670045aab66 Darrick J. Wong 2022-01-06  1386  		if (error != -ENOSPC)
b82670045aab66 Darrick J. Wong 2022-01-06  1387  			break;
b82670045aab66 Darrick J. Wong 2022-01-06  1388  		/*
b82670045aab66 Darrick J. Wong 2022-01-06  1389  		 * If we can't get the space, try asking for successively less
b82670045aab66 Darrick J. Wong 2022-01-06  1390  		 * space in case we're bumping up against per-AG metadata
b82670045aab66 Darrick J. Wong 2022-01-06  1391  		 * reservation limits...
b82670045aab66 Darrick J. Wong 2022-01-06  1392  		 */
b82670045aab66 Darrick J. Wong 2022-01-06  1393  		len >>= 1;
b82670045aab66 Darrick J. Wong 2022-01-06  1394  	} while (len > 0);
b82670045aab66 Darrick J. Wong 2022-01-06  1395  	if (error == -ENOSPC && *last_enospc_agbno != *cursor) {
b82670045aab66 Darrick J. Wong 2022-01-06  1396  		/*
b82670045aab66 Darrick J. Wong 2022-01-06  1397  		 * ...but even that might not work if an AGFL fixup allocated
b82670045aab66 Darrick J. Wong 2022-01-06  1398  		 * the block at *cursor.  The first time this happens, remember
b82670045aab66 Darrick J. Wong 2022-01-06  1399  		 * that we ran out of space here, and try again.
b82670045aab66 Darrick J. Wong 2022-01-06  1400  		 */
b82670045aab66 Darrick J. Wong 2022-01-06  1401  		*last_enospc_agbno = *cursor;
b82670045aab66 Darrick J. Wong 2022-01-06  1402  		error = 0;
b82670045aab66 Darrick J. Wong 2022-01-06  1403  		goto out_cancel;
b82670045aab66 Darrick J. Wong 2022-01-06  1404  	}
b82670045aab66 Darrick J. Wong 2022-01-06  1405  	if (error)
b82670045aab66 Darrick J. Wong 2022-01-06  1406  		goto out_cancel;
b82670045aab66 Darrick J. Wong 2022-01-06  1407  
b82670045aab66 Darrick J. Wong 2022-01-06  1408  	/* Update isize if needed. */
b82670045aab66 Darrick J. Wong 2022-01-06  1409  	endpos = XFS_FSB_TO_B(mp, irec.br_startoff + irec.br_blockcount);
b82670045aab66 Darrick J. Wong 2022-01-06  1410  	if (endpos > i_size_read(VFS_I(ip))) {
b82670045aab66 Darrick J. Wong 2022-01-06  1411  		i_size_write(VFS_I(ip), endpos);
b82670045aab66 Darrick J. Wong 2022-01-06  1412  		ip->i_disk_size = endpos;
b82670045aab66 Darrick J. Wong 2022-01-06  1413  		xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
b82670045aab66 Darrick J. Wong 2022-01-06  1414  	}
b82670045aab66 Darrick J. Wong 2022-01-06  1415  
b82670045aab66 Darrick J. Wong 2022-01-06  1416  	error = xfs_trans_commit(tp);
b82670045aab66 Darrick J. Wong 2022-01-06  1417  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
b82670045aab66 Darrick J. Wong 2022-01-06  1418  	if (error)
b82670045aab66 Darrick J. Wong 2022-01-06  1419  		return error;
b82670045aab66 Darrick J. Wong 2022-01-06  1420  
b82670045aab66 Darrick J. Wong 2022-01-06  1421  	*cursor += irec.br_blockcount;
b82670045aab66 Darrick J. Wong 2022-01-06  1422  	return 0;
b82670045aab66 Darrick J. Wong 2022-01-06  1423  out_cancel:
b82670045aab66 Darrick J. Wong 2022-01-06  1424  	xfs_trans_cancel(tp);
b82670045aab66 Darrick J. Wong 2022-01-06  1425  out:
b82670045aab66 Darrick J. Wong 2022-01-06  1426  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
b82670045aab66 Darrick J. Wong 2022-01-06  1427  	return error;
b82670045aab66 Darrick J. Wong 2022-01-06  1428  }

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

