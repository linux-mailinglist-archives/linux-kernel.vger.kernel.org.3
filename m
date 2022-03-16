Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BD54DB443
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357040AbiCPPK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356970AbiCPPKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:10:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE99465837
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:09:01 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22GCnKSU024156;
        Wed, 16 Mar 2022 15:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=7iTDqDWNG+96FR3SPtfCERJPa4hkRHqPXv/j+yG+vuI=;
 b=0mFw9EkhhV2JC+90eixyMrljg8Rn3jRk9KXJd5AXLw1uYHkE2fZ4pXtfqW95hlgVhDKU
 VYXkyMP2sf5dIBd+itUWg5H7+2DEjM7ThT77tBV4EkqT6Wge2KFF6MkBzRnCIRH6hKfo
 GHa2lXjp8mRDYjTSCGYONIetfrHmO0VnVW+WBGRrwDx1zOqYfoxMFZg9eJzw2OR7OOHJ
 XeVJv0i6PdWad0D4LkeIDYboBFIiNKK/iqhgqSUr6/mse4U9KSAjTOjIzISyFtOht/1G
 1JxZitpsjEu0GEgIwpPjGII4m0PFQbOjv7PfC5YC5Ci0I/YcMRlikvIg0UPvfAeRSyV6 /g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5s6phb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 15:08:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22GF7A7j140775;
        Wed, 16 Mar 2022 15:08:28 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by userp3030.oracle.com with ESMTP id 3et65pyv2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 15:08:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLXj/z8h1+3Hwu4XZ0LG0X82Kl7JDh21uu6MUV5FSp6N0nHj56cghGgX23IcUSC3E15hvosJ8uZ4ahFCbch445o6FrsbNishoJG5mZQAH5t99eZhoBF1XX83LuohcOD4xU1ZqitJdQ/sLkQNtM7/YlTp/E2xzhImSSPEpMkSPwP9WCWSlQ0fSM6IJ+2HxC6z6mssVmi551R/7cNF/+nod/CNd9Mw2ZrNV92mNkTNVA93T0bTZdgl8o/X9WNYMi+XWMmgk/PA3Buyi9pq6fidYWjAOxG4qKivaM1E/xx2f/aCrJajHvU8/YWosNUtHAJgDd/rz0qrkVH2yfnK3Rr26A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iTDqDWNG+96FR3SPtfCERJPa4hkRHqPXv/j+yG+vuI=;
 b=mgT1iN91MwqqGWZ69EdXUs+aoqhV9FbJjE49lEOLhKXLXTOGBCwNL6A/W/xXbwAqR2H+97fhgbtJmDDnTnQ5K9Rl3O+jkjdOeirKgk8xxzac7Bv6gHkJaUIfu+zqpVnzJA/Pn6w+eW+WNawfT2HA2MkWhp2PrAdkHcKpef/uJg3Shpir6635ZE5j213n+JFND1CPCebsMR2zHMUJiX8f3M8rbq2WgZd+VaoSV4TX03PLbPEEVwpmuWFLXJ/hFqop2NhsEh6xgdMg2+PHN2xVX/pDhdAq8fyHFsNcCWoAT3TfU0bVmmVjnA1PU1FuqcUDBBw96V2AyEt4bQs090ogAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iTDqDWNG+96FR3SPtfCERJPa4hkRHqPXv/j+yG+vuI=;
 b=AmANQgqVpZShETkMHvm1nI5est90Zv9kg1qNpiXrVvqwMOv7P0IN9b92HfhEKWuXHanATxa0flwKsms1aCcQ3JWNmAKaI2NwKDtxXutil1EIyTwYz6mD5X1zsWYL50YInGkUJw7J6/BZCqBIebZrKPGogaEgILsmEL2Vt5SVYLA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH0PR10MB4874.namprd10.prod.outlook.com
 (2603:10b6:610:c5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 16 Mar
 2022 15:08:26 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 15:08:26 +0000
Date:   Wed, 16 Mar 2022 18:08:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [willy-pagecache:for-next 174/179] fs/nilfs2/inode.c:232
 nilfs_dirty_folio() error: uninitialized symbol 'nr_dirty'.
Message-ID: <202203162210.u0O3mmI4-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0030.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c350f1e-475a-4246-a052-08da075ed27d
X-MS-TrafficTypeDiagnostic: CH0PR10MB4874:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB4874F6652086D368453992E88E119@CH0PR10MB4874.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZQsgN3bmmO9DB5eNLsRXZBBXXakZ6RqFr5u9+nTA/5mg1NbtuTxmrQ/wdlRJRsPTZF/PrdFSU3Uv59Lmz4y3PbZeARvXQF3XI/41NKcoPDDKD/D/6rypL/jtrcFiWXyzckNNRaqMN/0LlYn1wxHMt5bML6f0H/kiSjr4b1AgrpEGSS1LGm2SNCVe4J3d8ebBiLmkWsabqmi6IV0vB4V2toeSlE8Kc218ojlYceCVwaKc+7u7Qb3xwitm2NO6dexeEJGfWay4+C7iXEMY/RXq7uHr9YLf0ECU8qf0Rh/KK1ywn/nf2KDugjVfKx/92NFLetFPdYOTk+Bzi6ht+e/kjNMdCgACakAA3Zze/VchUt4cdqZ51YEnUWs/QceeUWNp4TzLcZUGNo83r4ydC+xRgURe4X3y8DNavp5vpuV70dt3WhyuZELdZIe4s5gEczMOH2Fzn5yOm9z3RY/CTqoUgL3hY8TE4XRTOc5pnX5a1gqwEe9/o8wVIKtHWwx7dkA6SQuftgaq67bNc9EZYSrrkRAQjKR73xsDbHZrPVqD+UWVecuZaw5QkLbKZv7BMwcPHfEk64qrqKYBpGl0BC+hswmTjuc/LqoLOumfx0Qr++NQw95bfWhtb0mUWb3lw0dyydyCDcpbmKowU3ZtEKQtbs3MirBDiZqj9Iu7XPnaOms/Gcyyo6bpWMSbdRMz8PjoD761v3wQsG3RpI0/mjSfoL6BJmsz8rbXy6gkFEO3U2YFEjl2eskxDHPeUX87wSVijiI5W72nD9bayuWoCpSJIeiafLJAjiVTvsOVhDYWrNsiGHrBi6u2r24NKiFfk4VZ+Lmh2xrZ6/UWHpk5/W8OrpTdVZ2JQA14bB1xjkO+0A8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(4326008)(83380400001)(508600001)(6666004)(38350700002)(9686003)(38100700002)(5660300002)(6512007)(6506007)(52116002)(966005)(6486002)(8936002)(1076003)(316002)(2906002)(26005)(186003)(6916009)(86362001)(8676002)(66946007)(66556008)(66476007)(4001150100001)(36756003)(14143004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kxxZFfspZr8JgWhiUE1Uzz3PcuEXsaTyHTkwljcVe5ax0u+TlXY4n9Xq/r5x?=
 =?us-ascii?Q?E5cRtiLmBGwMHK8GXGWATomJtyh909GnUQXUJb9Qk5etFx56lJxOqERwSvCZ?=
 =?us-ascii?Q?jxZTMR8hKzUuhco700VIpLyXdLPEW5ZgGxQy7BA22XV/L6wB8fvpqDlYWB7V?=
 =?us-ascii?Q?Eue7vD/mMbbgwI8QVBbXbfRPn82yuDce8/hiVAKX7eA+8rJiNSAOsyDJV4Ck?=
 =?us-ascii?Q?d9yQ2YorLnGm/RDNxkQg7OlJqpEZLYlahzHTSUDj+ZnH4ktRiylKhVdl6Igm?=
 =?us-ascii?Q?wexFQ2FrqVoFIfXDzrOpz01v1HvXJAQeIDYA92G0pG42OixlROhaoB7n6t0D?=
 =?us-ascii?Q?WO49r/V1iGgXWBqZ1u4A/6nVGpv8gKwCDkEsSyMw3o512cTG3qXGGiy+zAhA?=
 =?us-ascii?Q?KJ+xjnF6MUm6Xg57ay0LIwXWP3GChi8gt3SPvYdGR1FmgkqJePIAxUdwQsob?=
 =?us-ascii?Q?wzInwM4BrvvdLxJGQwb3KZUzosVJDT2wbDg4/Oh2lxGQZjTKj2JLtDR9DNaM?=
 =?us-ascii?Q?bd1bSY9W6kjaVvjHE49QKCYMQJx7KcsYbn8g0wZNB2sD+JGxkAe7hugO1d8s?=
 =?us-ascii?Q?bsiAVzRIgpL1DqZqWVkAgsBOEyKFpYPc5io2g7P+nRtJ67gy8VzVg8Z5z9ad?=
 =?us-ascii?Q?5ZQTpKx3TZI0r/Sr4ViocHkHghoOwD5LilraJkXHMgUYhDQkRvcG0x5tDcip?=
 =?us-ascii?Q?SF2ZVq7MyfFlh7rGNNF621+qg5RPnKiWvRBDOb3f5D3dXfh5Ksa/54htypZT?=
 =?us-ascii?Q?8FwK8WYe5VXktRABCHS3Jv1z5zYPp9BMumdS5ys7TNWJKVNTZRAyC48schUL?=
 =?us-ascii?Q?6IPfT4Y3ftt5nuPTXMG3SuJLeD55rWCYRJz7bhmE/I0m5gDi/y4LHHq+e3Zd?=
 =?us-ascii?Q?8HrMN2pMP/SqkfoSjI/NIbqIV34FEZyRqRsiiT2IOcERk2bk3eON6YwCKHiY?=
 =?us-ascii?Q?NqeTXqUrpmyhzTZMVGKeGpFq5i65sSHjCP0FGnj0t6zI2ahOvTfYH62FCPov?=
 =?us-ascii?Q?udUzeQS472rppyzGM85mgf+ss7Mq8bgrR/mG0dqize4MTCyy1whKMzjCov1s?=
 =?us-ascii?Q?a7cMP52WtFTwW0DWx5MAZOpolwabs3Qf3i4nBduXoWIB6oYd+93jYppK9HkK?=
 =?us-ascii?Q?a9AsH498OjILLmJZMIxnLw3Us1FDtFhbjyReTydnVtUbLcGws+zdjqsjxBs7?=
 =?us-ascii?Q?cVB3IDN5k3J3sEaL2BKnJouzARqPLoSkgFW58NbLtYXmXjIl7dxSg8gjrCvL?=
 =?us-ascii?Q?GHTrGv72zoJ15RvV37A8bVHMRrFMvRPbF3rZFNqdmTnBoZoWqdlFs7Nh7Pq5?=
 =?us-ascii?Q?zshw19542nHCG3/6lEXSIh68ptobTvU4Gh1jGyZ0qM4Jd39OeMTKHAqhZTk+?=
 =?us-ascii?Q?0ov9E/41HSpLBRg/xWIG5pDVpMTFm6qRmaxiasf11jFzzbIx8bhtpdSTD4gX?=
 =?us-ascii?Q?m+BBA36EMZBCX53cJ0L01pgrdBo4Dr2PytYzZudlLpMURvjmsEwG3g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c350f1e-475a-4246-a052-08da075ed27d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 15:08:26.7208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FSZb8rTqx9FO8MxGAHiG6T2h/DX9J6ER0UeYWk0FukA2H4xcTgK91mMK2wjOvMHsCv0aro6hyeeFrwlQ/UX1nC+plN5ySC66CmcuY5AaOyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4874
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160095
X-Proofpoint-GUID: tDItfqqmOWFDZgaHwb3MwXgyqvfXsRdU
X-Proofpoint-ORIG-GUID: tDItfqqmOWFDZgaHwb3MwXgyqvfXsRdU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.infradead.org/users/willy/pagecache for-next
head:   223ab4ed54499645015108bfbb3055e0f8c64613
commit: c5abb86e384b80b5b320c73668066e67142c706e [174/179] nilfs: Convert nilfs_set_page_dirty() to nilfs_dirty_folio()
config: x86_64-randconfig-m001-20220314 (https://download.01.org/0day-ci/archive/20220316/202203162210.u0O3mmI4-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
fs/nilfs2/inode.c:232 nilfs_dirty_folio() error: uninitialized symbol 'nr_dirty'.

Old smatch warnings:
fs/nilfs2/inode.c:1084 nilfs_fiemap() warn: should 'n << blkbits' be a 64 bit type?
fs/nilfs2/inode.c:1097 nilfs_fiemap() warn: should 'n << blkbits' be a 64 bit type?
fs/nilfs2/inode.c:1104 nilfs_fiemap() warn: should 'n << blkbits' be a 64 bit type?

vim +/nr_dirty +232 fs/nilfs2/inode.c

c5abb86e384b80b Matthew Wilcox (Oracle  2022-02-09  202) static bool nilfs_dirty_folio(struct address_space *mapping,
c5abb86e384b80b Matthew Wilcox (Oracle  2022-02-09  203) 		struct folio *folio)
05fe58fdc10df9e Ryusuke Konishi         2009-04-06  204  {
c5abb86e384b80b Matthew Wilcox (Oracle  2022-02-09  205) 	struct inode *inode = mapping->host;
c5abb86e384b80b Matthew Wilcox (Oracle  2022-02-09  206) 	struct buffer_head *head;
c5abb86e384b80b Matthew Wilcox (Oracle  2022-02-09  207) 	unsigned int nr_dirty;
c5abb86e384b80b Matthew Wilcox (Oracle  2022-02-09  208) 	bool ret = filemap_dirty_folio(mapping, folio);
05fe58fdc10df9e Ryusuke Konishi         2009-04-06  209  
136e8770cd5d1fe Ryusuke Konishi         2013-05-24  210  	/*
c5abb86e384b80b Matthew Wilcox (Oracle  2022-02-09  211) 	 * The page may not be locked, eg if called from try_to_unmap_one()
136e8770cd5d1fe Ryusuke Konishi         2013-05-24  212  	 */
c5abb86e384b80b Matthew Wilcox (Oracle  2022-02-09  213) 	spin_lock(&mapping->private_lock);
c5abb86e384b80b Matthew Wilcox (Oracle  2022-02-09  214) 	head = folio_buffers(folio);
c5abb86e384b80b Matthew Wilcox (Oracle  2022-02-09  215) 	if (head) {
c5abb86e384b80b Matthew Wilcox (Oracle  2022-02-09  216) 		struct buffer_head *bh = head;
c5abb86e384b80b Matthew Wilcox (Oracle  2022-02-09  217) 
c5abb86e384b80b Matthew Wilcox (Oracle  2022-02-09  218) 		nr_dirty = 0;
136e8770cd5d1fe Ryusuke Konishi         2013-05-24  219  		do {
136e8770cd5d1fe Ryusuke Konishi         2013-05-24  220  			/* Do not mark hole blocks dirty */
136e8770cd5d1fe Ryusuke Konishi         2013-05-24  221  			if (buffer_dirty(bh) || !buffer_mapped(bh))
136e8770cd5d1fe Ryusuke Konishi         2013-05-24  222  				continue;
136e8770cd5d1fe Ryusuke Konishi         2013-05-24  223  
136e8770cd5d1fe Ryusuke Konishi         2013-05-24  224  			set_buffer_dirty(bh);
136e8770cd5d1fe Ryusuke Konishi         2013-05-24  225  			nr_dirty++;
136e8770cd5d1fe Ryusuke Konishi         2013-05-24  226  		} while (bh = bh->b_this_page, bh != head);
56d7acc792c0d98 Andreas Rohner          2014-09-25  227  	} else if (ret) {
c5abb86e384b80b Matthew Wilcox (Oracle  2022-02-09  228) 		nr_dirty = 1 << (PAGE_SHIFT - inode->i_blkbits);
c5abb86e384b80b Matthew Wilcox (Oracle  2022-02-09  229) 	}

No else path.

c5abb86e384b80b Matthew Wilcox (Oracle  2022-02-09  230) 	spin_unlock(&mapping->private_lock);
56d7acc792c0d98 Andreas Rohner          2014-09-25  231  
c5abb86e384b80b Matthew Wilcox (Oracle  2022-02-09 @232) 	if (nr_dirty)
bcbc8c648d6cc88 Ryusuke Konishi         2010-12-27  233  		nilfs_set_file_dirty(inode, nr_dirty);
05fe58fdc10df9e Ryusuke Konishi         2009-04-06  234  	return ret;
05fe58fdc10df9e Ryusuke Konishi         2009-04-06  235  }

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

