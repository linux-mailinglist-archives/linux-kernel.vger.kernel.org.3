Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3134785B6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 08:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbhLQHtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 02:49:35 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:32842 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229449AbhLQHtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 02:49:33 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BH2b15W013696;
        Fri, 17 Dec 2021 07:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=/nEm3HWez22E3QyM3E1EuvRNGDwrPy05CaePbM85R7c=;
 b=xshA2YJL+5pbsKUBTw6SjFm2QGw/YQoxbqEbz/h443+/hH8m6kDZwG0orYdY73edXFCa
 7vZBLg7/i5sdrrprNUytOzWUCBBwvI+pKm/D9hnENM6w1Phj6YeKPPhrpZ4X8HGFbPPP
 dxi3JGXDeAOqmHIaTd8ig7zYY+fuK1nUNr6F9gs3h/gUPIPELqxojSNz1rz+pwyiSfwG
 CTACSrP3FUL+FJNivzDRjj9W8WKynGlZPNKOPow/Yw5WvPDuTor2kFICW+qpfeAu9q+S
 Ame5xOrOrS9hjqa0Rvih/dVY/C0s2ijgKpaGabQ89iUETlEzqwC/EG49L/Xg4Dc5Cq9E 0g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknc51xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 07:49:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BH7kj3Y135322;
        Fri, 17 Dec 2021 07:49:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by userp3030.oracle.com with ESMTP id 3cvh43dnxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 07:49:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jc+IumpP7mgteoXUDQ/gIoRl1UMUmwWVcwPjLwj/MBGk58a2Z3J2CznryA00wSVZpndRssSuLsL35JvHeiah41q6AKquz2Yyxsb4Oqg2CgQH2xGdX+rSgJlkkRzid3ED5THsoN3+K4ahQ2pT6xEROHrX0xyINyr50Oi6wiZBWF6HM8tj13ANhtq2AI7uV48ApizHfcQS7O0FNWeqCyMn05y/B9kd1jMaKKAiBfw9fFld/WNnTOWGmCY02nUkTIb8r2abBciQNx2ty5+oBWVUZKlTjxP3czSUJO4wgw1Lrp08dbzMaHPSPOZVvzj3xpvCzuiiRfZKP8O7uhwuCgb0Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nEm3HWez22E3QyM3E1EuvRNGDwrPy05CaePbM85R7c=;
 b=OvvGZADlvAV1Z8U0v2wdUV6MQVfB0CbrB27oj39ZVK+CHqoa+Z6bXIq9x4eyQ60V1NpqMVWHUHrt2jYY0dz0w/bID9sToW7IRNxm+qdOKKOEWE888GhFoo4L8o1cwpXVeyvlj+qSzyrZX0RN94+xO9ZWLf+MYRUX29QtLPEkGiTvE6XiLphAqHojqMuRzsU59ZYJpd0vPkYYPX3r3U5O0GYI0J87i1JdfpYZQINwQ4iLrjH75ssc7M/MEk+BHcXFuEQtAqenXBqvClGkaDD7wPyiB7iHF5RhwgRRyG11AzVnmHYsMxvN0xymqlMB/uUD27KvZwZqmYTKEmi+palKEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nEm3HWez22E3QyM3E1EuvRNGDwrPy05CaePbM85R7c=;
 b=xPg9T0UPV3XEg0qh4X/xLH8fB2QkUA5/t9TFIWalMMsD7KRqPAIN3wrDXEfhuuBSBUHEwPZYCxU+ZBnGCf2zC47YPqvpZjbIuoL00FYgwNZs3E4C2kKe6EuFZac//sOrV5IajpUhCEhU1/hbIMDod7WQnvUkuDHHDpu86UKYcZE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1774.namprd10.prod.outlook.com
 (2603:10b6:301:9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 07:49:23 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4801.017; Fri, 17 Dec 2021
 07:49:22 +0000
Date:   Fri, 17 Dec 2021 10:49:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Christoph Hellwig <hch@lst.de>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>
Subject: [axboe-block:for-5.17/block 106/108] block/blk-ioc.c:307
 set_task_ioprio() error: we previously assumed 'task->io_context' could be
 null (see line 300)
Message-ID: <202112171520.5hNnOM0q-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0072.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a72938d-93fb-4678-4b22-08d9c131bd56
X-MS-TrafficTypeDiagnostic: MWHPR10MB1774:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1774D20B3F5E5893C0C9D76D8E789@MWHPR10MB1774.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:221;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MeiUHQosiDNxNmC78uawd4XrfEpZ9JJB2xjaLR8dkNxEgrBpO65XiL2y31eqRfdaeCZ9GB6NT+19WOZLt789ZRmBaT6swgiRB1k4vPQstZ7w3/FbU40wjxG/B+qY1BIuSJyxCPC/WrdJyR3EmO7iXyNzbS4qcT9UlfdUZl0xpIcarJ4MUi5s+yDXjYIb2z4mDptDvSDDZfRqU8QC3tgnLq+SQ6cGMcXL/mt7CzJXdJ/dJr37n1VVPz6NrG+bxS8fzQdNLYQB9P5z2u7IOAjcsB3WDcMzYsHZ/tfu0R+wCMR0eO6j85EhABM+ysMjfDiuNSTZzkg8Wvpg9Wf2qLgFnS5a8r3JRjQUcAAVJzBQld2IwKfLvT0+0mrOyTs3cQjRFX3AyVPpxrfRW/1r3N9xag4Rd4PRMuWCeelXPhqTptED1G0RhZGlVro2A6EGJeYbV7mrFTWHMter8H1X4tJ8QtLw1Wui0fje5EQJyJCVmWFZAl1Opm49T7kXUr/KGcibr8nM+k9gFvR7z1hg0vftojUdibASgkWoOpVy8Mj3EG19iDuElA2GXfG45x3vWvJJ0YX8r1W4qBRPpSyRfOJ+pBHCT/+QsCxpXNQLh/OmlqGTvIHc54rX3e8DHzZvsPE6N+ysO/yHZNh/JHAaRsJC/Pkrn2Uhor1BmC/HTclDIDHIZAYpnWhQYg3iSf38AWV5P7WZRehCnVzz9YR18e1JyTYptKVsf1CQ9e9g/R0CJ5UleXsQ13aDtNg/vsg8OBrnR0vR0s5UMFJyei2ni9LugrS4GORzUzszMpw/DZuwYU1/mRo4SuHrAsUm5xpKz4kvL5TO0RfB7O08Z910mj/c+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(508600001)(316002)(8936002)(36756003)(966005)(52116002)(86362001)(26005)(6506007)(186003)(38100700002)(38350700002)(66476007)(66556008)(54906003)(2906002)(5660300002)(66946007)(83380400001)(9686003)(1076003)(6486002)(6666004)(8676002)(44832011)(4326008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9A/O/McC7At/537p+g1wa7KAbjI30mjkPrpjPfvduyucho5ORCOi2sqI45MC?=
 =?us-ascii?Q?UQhy8GzEk8MDb0C3yAvoJSjN1uSQgG5CR23Gdyaok5MPH0/0kST8ZaQhuPbW?=
 =?us-ascii?Q?oHfZEMvhZhEej0mHe1PqnLh9YeF68p24DVWD9OqSKi2uBvcLSQLS3fxyCpVZ?=
 =?us-ascii?Q?lr1adpIub/POhtUihVoaEuNgvXK79l/P1z/oRtDglPctU+9X9AKOWiXCoPKd?=
 =?us-ascii?Q?Xj5fUFBsib990VFfKVFtf4Y9qXLj+CzCzq5m1XJ/J77JtF8NqVQDmjbRltzF?=
 =?us-ascii?Q?X1F25xoUnpYLDxPuLCd++n7p/8I3jARVndzUGhujoXTthIfQub2Kb6Wyo+xA?=
 =?us-ascii?Q?JC5cgYSNoYLQ5VB4/84BuM0dnhJR/iZ52LrajG/spLV4CdeWTE/I8PvKmnIn?=
 =?us-ascii?Q?HddH6KDXIQPeNsdn6YBN+k2KFn4rHzw3nGe9XyOJw1NV4yHDH7M/Q+mVRtqA?=
 =?us-ascii?Q?av9PzQEkebWb/WwWx7K04YxPWjnK1Vi4NHN5UpEs0+/orFsy31IHFnzEeo2I?=
 =?us-ascii?Q?MFRHYbHcgtDPatcXZORdGOruzqON/419Hhwse628sq2S4AsSZ6MtVb9XBHBG?=
 =?us-ascii?Q?dT7KRerO1hSFIU9BBRbgKteV3tktincMKYkIHQKyhswRXI4EszjF6nZxtEoa?=
 =?us-ascii?Q?A2o8xq/SUQORn0ipB+CaSf9X33W1tXb5TBV6IVgd5FisQ/eqyLfy/N4z2gec?=
 =?us-ascii?Q?AmxGcCDrO4nCe7ZQOr8us97p8s3KeblZ1QFzyd4tlcsOhZs1So0DSIbc5MbA?=
 =?us-ascii?Q?e3HXwJPj59UjOBNWRuz/XHer36lTdER6Mm4p/h0KyO+KeFlXijyJGbHUmSZr?=
 =?us-ascii?Q?N9F4Ng2Bosbzt37qDEOHu5jE8jXT1YgFv053JpwA7mpJtcfXvQqBy+yFQmFa?=
 =?us-ascii?Q?HVYOAZxLYg5f3rnNHsz3+axLSCKgnN0lqE/nu5SlH8lJOSvJ4Cr7UoXEay5k?=
 =?us-ascii?Q?NO4iaHYjH/ORwp4o0jcWb6hI+OhUdfcc7UOq/X3nVrK8t17uvYgEKGw9Emd2?=
 =?us-ascii?Q?VMYvlPH/5/1Cun0yt3nuNiOsOYQ48XCtuvjSl0Tkd6XS+6lviYJx/4nmcv03?=
 =?us-ascii?Q?+pv7WwIU8B9eXZj1mRbTkKLw84AGYx3ahfMP+Z9TJCbVd5PaaO8cu9d1TnJx?=
 =?us-ascii?Q?IIz5zl+mI4quXvOI9HfFJtNkj1DAxHnMbliINzTSw/Y9aGAD7jQKPJUPwDw3?=
 =?us-ascii?Q?P8wHIeBrMpHwWOHG2nfoYQ3S/JDZrsAVCTrYHZVMqkdBADNhVF0aF5EtFcRz?=
 =?us-ascii?Q?pAUN8z08APHBwQjaVslebRvayaFRYS/Zbd/mQ/CAMd+2iKJrv9iWAq2fapKl?=
 =?us-ascii?Q?dD0RdwbK9vjMxd06366k5eLcKY7NomyuWLJuXCRGIRrkRMYg8j1Z34MkAM0o?=
 =?us-ascii?Q?Cp5wlugUERM0tdsDfKb0yP2nhSedwyxTy+hX6tbja/ryy6V8+o6LFJrrtrdf?=
 =?us-ascii?Q?IrvIwfBps0BeaYnGSpQOJbeURDU9in4bo6NY9vtYDWoIF7co2CYU+FBZPqVz?=
 =?us-ascii?Q?ZHzk+tmcDiPjLgrLRDmHkwyHIAgP3rcGMKuTAecgkNOsx50NrSr97bFipfx4?=
 =?us-ascii?Q?B/w6/eUHN17TeXN86C39RPe+UYDHEMfWa8FXtKkL0AJV4eUBGrzwGS/gfY6M?=
 =?us-ascii?Q?ZW1nKKCWb+0QCAYPEZquh2VCWGSRWcv42k52YBVSe3WWFcjf1djHHroCutno?=
 =?us-ascii?Q?i0SVLGjZXrvMRhGCGmqMwIeYpys=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a72938d-93fb-4678-4b22-08d9c131bd56
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 07:49:22.7850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4dOPy3ICRfFFh0sT1IIg/lugpqulYWjTX2T1LpZMhozGL5VEv5ZIqIRxmrR2UBQGC68Jxy40wFazGTC95nQP3LR/vVRiu0WaP/dzHRFLrCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1774
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10200 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112170043
X-Proofpoint-ORIG-GUID: 2vw_POIgy3htMbvvEjs04hgB8HNiN56z
X-Proofpoint-GUID: 2vw_POIgy3htMbvvEjs04hgB8HNiN56z
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-5.17/block
head:   5ef1630586317e92c9ebd7b4ce48f393b7ff790f
commit: 5fc11eebb4a98df5324a4de369bb5ab7f0007ff7 [106/108] block: open code create_task_io_context in set_task_ioprio
config: i386-randconfig-m021-20211216 (https://download.01.org/0day-ci/archive/20211217/202112171520.5hNnOM0q-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
block/blk-ioc.c:307 set_task_ioprio() error: we previously assumed 'task->io_context' could be null (see line 300)

vim +307 block/blk-ioc.c

a411cd3cfdc5bb Christoph Hellwig 2021-12-09  271  int set_task_ioprio(struct task_struct *task, int ioprio)
a411cd3cfdc5bb Christoph Hellwig 2021-12-09  272  {
a411cd3cfdc5bb Christoph Hellwig 2021-12-09  273  	int err;
a411cd3cfdc5bb Christoph Hellwig 2021-12-09  274  	const struct cred *cred = current_cred(), *tcred;
a411cd3cfdc5bb Christoph Hellwig 2021-12-09  275  
a411cd3cfdc5bb Christoph Hellwig 2021-12-09  276  	rcu_read_lock();
a411cd3cfdc5bb Christoph Hellwig 2021-12-09  277  	tcred = __task_cred(task);
a411cd3cfdc5bb Christoph Hellwig 2021-12-09  278  	if (!uid_eq(tcred->uid, cred->euid) &&
a411cd3cfdc5bb Christoph Hellwig 2021-12-09  279  	    !uid_eq(tcred->uid, cred->uid) && !capable(CAP_SYS_NICE)) {
a411cd3cfdc5bb Christoph Hellwig 2021-12-09  280  		rcu_read_unlock();
a411cd3cfdc5bb Christoph Hellwig 2021-12-09  281  		return -EPERM;
a411cd3cfdc5bb Christoph Hellwig 2021-12-09  282  	}
a411cd3cfdc5bb Christoph Hellwig 2021-12-09  283  	rcu_read_unlock();
a411cd3cfdc5bb Christoph Hellwig 2021-12-09  284  
a411cd3cfdc5bb Christoph Hellwig 2021-12-09  285  	err = security_task_setioprio(task, ioprio);
a411cd3cfdc5bb Christoph Hellwig 2021-12-09  286  	if (err)
a411cd3cfdc5bb Christoph Hellwig 2021-12-09  287  		return err;
a411cd3cfdc5bb Christoph Hellwig 2021-12-09  288  
8472161b77c41d Christoph Hellwig 2021-12-09  289  	task_lock(task);
8472161b77c41d Christoph Hellwig 2021-12-09  290  	if (unlikely(!task->io_context)) {
8472161b77c41d Christoph Hellwig 2021-12-09  291  		struct io_context *ioc;
8472161b77c41d Christoph Hellwig 2021-12-09  292  
8472161b77c41d Christoph Hellwig 2021-12-09  293  		task_unlock(task);
5fc11eebb4a98d Christoph Hellwig 2021-12-09  294  
5fc11eebb4a98d Christoph Hellwig 2021-12-09  295  		ioc = alloc_io_context(GFP_ATOMIC, NUMA_NO_NODE);
5fc11eebb4a98d Christoph Hellwig 2021-12-09  296  		if (!ioc)
5fc11eebb4a98d Christoph Hellwig 2021-12-09  297  			return -ENOMEM;
5fc11eebb4a98d Christoph Hellwig 2021-12-09  298  
5fc11eebb4a98d Christoph Hellwig 2021-12-09  299  		task_lock(task);
5fc11eebb4a98d Christoph Hellwig 2021-12-09 @300  		if (task->io_context || (task->flags & PF_EXITING)) {
                                                                                         ^^^^^^^^^^^^^^^^^^^^^^^^
Assume "task->io_context" is NULL but PF_EXITING is set.

5fc11eebb4a98d Christoph Hellwig 2021-12-09  301  			kmem_cache_free(iocontext_cachep, ioc);
5fc11eebb4a98d Christoph Hellwig 2021-12-09  302  			ioc = task->io_context;
5fc11eebb4a98d Christoph Hellwig 2021-12-09  303  		} else {
5fc11eebb4a98d Christoph Hellwig 2021-12-09  304  			task->io_context = ioc;
a411cd3cfdc5bb Christoph Hellwig 2021-12-09  305  		}
8472161b77c41d Christoph Hellwig 2021-12-09  306  	}
8472161b77c41d Christoph Hellwig 2021-12-09 @307  	task->io_context->ioprio = ioprio;
                                                        ^^^^^^^^^^^^^^^^^^
Unchecked dereference.

8472161b77c41d Christoph Hellwig 2021-12-09  308  	task_unlock(task);
8472161b77c41d Christoph Hellwig 2021-12-09  309  	return 0;
a411cd3cfdc5bb Christoph Hellwig 2021-12-09  310  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

