Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EC14933DD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 05:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351460AbiASD7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 22:59:33 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2214 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344750AbiASD7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 22:59:24 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20INxeS1000758;
        Wed, 19 Jan 2022 03:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=WcpbZI4+/hD580s+PtJIqOpT+QF5T7WFIpi8xnuXb7Q=;
 b=zb4i8niqqMqDofI6f7r4Y1GrgubH8OZA5tx4wnnfEyb/mC1zq8udaTSjJRq22YJsIxqg
 4QNaa1HcVPX7ngXtRW7+8T30LAskyuIRjzCEpn4Hy19yd8MypXHdgUE/Zl8s4tcxlNlT
 06tl67LtdbSs2DkiSPqejJaNTMzuaCKzN4IRAFr2zT0QpjUoZZKEKpst4vX1VZTvvhOl
 FKSH7mbsWSKSQo024h5jyD2+TtUl9SH28Bhuvhu5UfPSrTMxV84SIFcRS+DpCauemZaT
 D97cVNpuQ8a+E0b5p5Vjmz2Hewt/oxjCVDAZ62WAFAuNFTbsRVWW1krM8S8Ii3dMSxt3 kA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc4vkvrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 03:59:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20J3u4kX077705;
        Wed, 19 Jan 2022 03:59:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3020.oracle.com with ESMTP id 3dkqqpnhgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 03:59:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Caflaj3XReZT6SXPlWe/gzHjQ2WKbVLSJkSPjkfu6Et6X2L8Q0kANL7/7xb1oSvCDgyGJe7IbZ92EKkCJXmXBCwe+zokZGjISqqdytl/A0+Z0NEYw0eyeqYEsawBO0hDjs1/y46MVs7O0SitV1/5ZSrbe1e98oUGDpGbIcFC5bdrr16qfX/YKSXgBKNW49i2MycD1TEQFqX4cGKyNn8ghvglGlqrsU8YyifjhIPqfdr2HqI1SLTyvLM5M94tcFfyM65sIXGkkdB1RdN73SB096ZnGJds9bdFM4NMIVTUbeWGbC6vi/P5Hlz+U2WZMBH23LVj+/bE7C81MdwUOmis+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcpbZI4+/hD580s+PtJIqOpT+QF5T7WFIpi8xnuXb7Q=;
 b=dQG0ZXGJfScqnKaEPv8b03bp2cRU1C1/vrqzjP5zXV6BuB5V9SXcbgHKIPCWna/zHRyo6HDeiDUpHZlAW00PuTEB94NKj5mZFG/Bg5u3zsWJ1cttFwTwZygsHS8Kg3OZ3sIIy1LpkuJCZhimaAAQEMVKINiVERS7M+ErkwBw+Udm+VpweqkmCx+TpZLnGK/u6Slc6wZJCQiCMhtE9EqnxaE40z9RpLoyxvAhVh6/61ut89/8tBUr0A93+u+7oQ+HILVcxekbpe3BlywH+txLcT2bjfx9EEizRJpibRW8jHkCi7Eu+Xn5Iglu1ERbdb3EwvhYC/gb2K76Umm/M9BMhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcpbZI4+/hD580s+PtJIqOpT+QF5T7WFIpi8xnuXb7Q=;
 b=MMKg651wqpACWgVjEfG8nf1Wd9GPiuRHMR9p8MD7Z8H1WUOF/H3f47fQDq0JUdxb5yxCyIoh9oEDuYx4SiIa/HiiFEFCyoRwXD41OC8y8qqjOKAqTcb54fu+hqi1iZAauU70fa2KUIW6UJCAAuwgNjlhqbOt8ZeSkZDq4HzRYuU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1424.namprd10.prod.outlook.com
 (2603:10b6:300:21::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 03:59:06 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%5]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 03:59:06 +0000
Date:   Wed, 19 Jan 2022 06:58:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, "Darrick J. Wong" <djwong@kernel.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:vectorized-scrub 99/334] fs/xfs/scrub/fscounters.c:198
 xchk_fscounters_freeze() warn: inconsistent returns '&sb->s_umount'.
Message-ID: <202201170928.GcIhOWMI-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0038.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::26)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f56e3a8c-5e01-4ff0-2a9d-08d9db0009cf
X-MS-TrafficTypeDiagnostic: MWHPR10MB1424:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1424B917FEEBCE94EDD57FED8E599@MWHPR10MB1424.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:84;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fiLY2O+eX1+BDTzgCj6B7CqHYqZ50fwjNm4yrxLfzD+/38z9FM3VtpNs8t5pKeOwNlWnJz8qEuyDiHNYfJA3CzHPQAKYzWLi4/6mqm98jFoAky1tDVJzx4aA4p213iu7r0jRp3e+VfkY6QeDXRz5X2r/hKG49vWF/DTPOhKECOQT8P1RmOxoz70c5xFDHe1oiBssEjjmd+O3sKAojk7xT/5pKDgsU6OJYJ71HWMYwMus2R5Kp7KFSD4B8bqIDCHZJazKknpZFL0QMCPtgx91Da9X1JbYEo3Ne7ku7xSr0715X9p3wdmcGwOxE14mPE5nFN/AOfKPsRNdulJLdrs07hP4He34E/nfMKm0B3z+G2MYg6JasoNC6zYYUfcPOTuONKyzE3KjUgMMFdZ35Rs9HY2xEa+ogtXT2KOUHXBrPgDF6JLRWcOt/iUBGp+tB3K62bNdQyppfv+fn4DkqMUoIu/GOxSKwq4LIihNkC3f7lJ67MWMtOw6CTAklCEScAMp5PK06kxDRD7ffxZof1k1I548UO2JMpAKrfnUZcHLAKJwzB10/yoGljW/2CrBQpkc84AF6I6D9Y3mjYzTp01NcQ81PUnIejjdI5XAKTZuiIldLIvrKA7O6S9UvHPQZTM555JQdNrK8nEFoVORSiJclMxYGp44z33I5sfVA3yZEthQkFBvUHOhPxuo0JkXBzFw/UHid4pYAXXg9NRE8xWSgzDdayb9bFzdi7w8pddOhA7onh1WjKf54T2p61bN9f+xce4rAGvTLQ6EFq6cWfGaP0pql0z8CS+IUh3cxJUJ8KIGHO9Vg/EcuPvfM8ZSN81xzqko3jyZg//P9VUglJHkog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(5660300002)(66946007)(8936002)(26005)(86362001)(186003)(36756003)(508600001)(6916009)(52116002)(316002)(6506007)(66556008)(6666004)(966005)(66476007)(44832011)(38350700002)(8676002)(6512007)(4326008)(38100700002)(9686003)(2906002)(83380400001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v0eWgZyLxyOTOcG4HQ2fiSnVL3Fzi+l0XAn9r+CL0A+aV7qi5g6P3OZCJvQ5?=
 =?us-ascii?Q?lW9BZX8WVmMNmcZL6j01trO3kihN7x6SD5gnrixlXk5MZOPh46sHjZxkVROB?=
 =?us-ascii?Q?Bc+lRgWGkDIFT1+n9Nh9uQYMVYlojDSB/jncQu4eDCL6riuknVVnle3cGMzK?=
 =?us-ascii?Q?AJhNuQoViM4FTkyM3jXecPIYmR89JLkvuuMcWa8Qjbid6u3F3Kikmkl1O0Ae?=
 =?us-ascii?Q?SED19In+m/i98irQE4KWzRp7sKIrT2/k14Y01hy2hhWwbXte80G4QzY7RvtB?=
 =?us-ascii?Q?0Ow9gV93RLN4Q37LxZNT47itcshy9dT19JOjQP4R12MPzo9TykDSUy2/3v8g?=
 =?us-ascii?Q?WDXM5eK0SukJbwqxSzrje68MKyyAABtFNxgqymnXEWDorFz05k9mT15v2O6N?=
 =?us-ascii?Q?l9DeiK2qNhpaYjlSBxIGo8qAYBjg4dpb6eFumQT0iveDi6qZAphEdbNE6Yz1?=
 =?us-ascii?Q?sAup1aGfipiGVQJnCYoU0RldMYyc2AFS/eF0NPPBfsDpFOIl2jsyd7hIIK5p?=
 =?us-ascii?Q?DE/NpO9eCUAm4aCQVy+uAZdQTY5kGJPP1tJ1pQ9FfO8HheA6miA+AUmwVeEn?=
 =?us-ascii?Q?68AImMz/Uy0XmXrZBmtQH3oCZj6Hw5v946a/Qj/6vAg1pFZvn0h595LAf/OE?=
 =?us-ascii?Q?Fyd+A3Qg6DajLk+EyEBtkdE8AHZiOzn+rj6sgNoJwU9pmeG7n6rEkrIfcteU?=
 =?us-ascii?Q?eQO6wQTzN8ZBh2N9rVu8Sh1JGvz6C75LKjUucnjrvkoQQAdHg8iZGwJGqJ8/?=
 =?us-ascii?Q?H9VixUxozOQ5KRQ801Qr5Ri7u55hrJW2eNiafRNJfj31Z+ZvIU17mqPA+bgi?=
 =?us-ascii?Q?a0k/U/hhu/9n82kB/2EyvyuhOWiQAu4tOY6IttI5jCxhEUrf07cjGq5d76Cx?=
 =?us-ascii?Q?ll/oVb8k1CuOY2Q+o3ctsWQ/KfcauV2pxl3BW41cxueAFo7zIUkWybajgY2c?=
 =?us-ascii?Q?eup4LciTCQPRJFa4oEoatiYCS7Esmwi0zOC3dhl9eodydLwLLgCwHlaUf/CQ?=
 =?us-ascii?Q?9HjDQ1GMskhFzP1fCZmBk9c7yj0EdSB6At3c0s/o7FUt1krsK8jsfNM0W6gX?=
 =?us-ascii?Q?pyRfhYUyS5oQyYxOuiN2DgmTO8hUcjJgFk1L1JjweYYm4K1OovCL73tfta/S?=
 =?us-ascii?Q?/bLx/SAQNliufh31T9xLWPhBDHDCVr05O8G5e5ogbqgFgQHnn2mU/sWqF88i?=
 =?us-ascii?Q?qIev4LSGffsjfXmb2On02qZreKD9d21FLvqn/IVLiOY3h/9IDCtwVvmQ8/Jj?=
 =?us-ascii?Q?dk17N2tMwIZHnwQaaedbpavdpURy+5oh8uI8Oo/Nk3eX+w7RW/kO5zScY7nx?=
 =?us-ascii?Q?jA1OOufMK+XJYvwG/9Ie7TKz8muCNReDDadeDvOZFVV0ADFoLM3yZTmf9xM0?=
 =?us-ascii?Q?Cxj+2XvGIu35jXLQrIMNbrvT7CsZoisT6Kn6q+JTX4cC1REswJIpKZ4eq1SF?=
 =?us-ascii?Q?beHgznwWQ0KD4niV0in2E4OIqamrVZcKshfR+bwsqzv5q+8VStofY1IBilNS?=
 =?us-ascii?Q?436f/loWnRuRH0lxgryMAFxgphYq+AJ6HPx5SfPxtinImZFWXvVUsGe4r+8m?=
 =?us-ascii?Q?/0BTA9j+/L5wBj5pymtriMr3u0pup+lUIS1hOE8kyPpKVD5Lmrzix70uMCzO?=
 =?us-ascii?Q?uRfrS56qKPcQ5IOnjdcvAShxmewqX1wyZ5pDZUAR9tDgZTCctWI41DtEuu68?=
 =?us-ascii?Q?/YX5+GfHXn8jLgQaw+m7dHtAJ6E=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f56e3a8c-5e01-4ff0-2a9d-08d9db0009cf
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 03:59:06.3034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6b+or2IyPQSIzfpt2VatAOzGcjqMO1P12S+RO3eq9b3bcXxMABpwnj/3RdC95YsrEvFScU/Qsyabowvh9AoGPRg7cY7E0WNOIeU/JcNnNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1424
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190018
X-Proofpoint-GUID: DtY15rYYVwf5orWF4IL4tHa_GXgg8wRC
X-Proofpoint-ORIG-GUID: DtY15rYYVwf5orWF4IL4tHa_GXgg8wRC
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git vectorized-scrub
head:   8427da8e62fbcf9a04e5b2663fe60b97d6911417
commit: 8dd594d12f08acc6c6fa388b2cae3e270bf8effc [99/334] xfs: stabilize fs summary counters for online fsck
config: ia64-randconfig-m031-20220116 (https://download.01.org/0day-ci/archive/20220117/202201170928.GcIhOWMI-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
fs/xfs/scrub/fscounters.c:198 xchk_fscounters_freeze() warn: inconsistent returns '&sb->s_umount'.

vim +198 fs/xfs/scrub/fscounters.c

8dd594d12f08acc Darrick J. Wong 2022-01-06  125  STATIC int
8dd594d12f08acc Darrick J. Wong 2022-01-06  126  xchk_fscounters_freeze(
8dd594d12f08acc Darrick J. Wong 2022-01-06  127  	struct xfs_scrub	*sc)
8dd594d12f08acc Darrick J. Wong 2022-01-06  128  {
8dd594d12f08acc Darrick J. Wong 2022-01-06  129  	struct xchk_fscounters	*fsc = sc->buf;
8dd594d12f08acc Darrick J. Wong 2022-01-06  130  	struct xfs_mount	*mp = sc->mp;
8dd594d12f08acc Darrick J. Wong 2022-01-06  131  	struct super_block	*sb = mp->m_super;
8dd594d12f08acc Darrick J. Wong 2022-01-06  132  	int			level;
8dd594d12f08acc Darrick J. Wong 2022-01-06  133  	int			error = 0;
8dd594d12f08acc Darrick J. Wong 2022-01-06  134  
8dd594d12f08acc Darrick J. Wong 2022-01-06  135  	if (sc->flags & XCHK_HAVE_FREEZE_PROT) {
8dd594d12f08acc Darrick J. Wong 2022-01-06  136  		sc->flags &= ~XCHK_HAVE_FREEZE_PROT;
8dd594d12f08acc Darrick J. Wong 2022-01-06  137  		mnt_drop_write_file(sc->file);
8dd594d12f08acc Darrick J. Wong 2022-01-06  138  	}
8dd594d12f08acc Darrick J. Wong 2022-01-06  139  
8dd594d12f08acc Darrick J. Wong 2022-01-06  140  	/* Wait until we're ready to freeze or give up. */
8dd594d12f08acc Darrick J. Wong 2022-01-06  141  	down_write(&sb->s_umount);
8dd594d12f08acc Darrick J. Wong 2022-01-06  142  	while (sb->s_writers.frozen != SB_UNFROZEN) {
8dd594d12f08acc Darrick J. Wong 2022-01-06  143  		up_write(&sb->s_umount);
8dd594d12f08acc Darrick J. Wong 2022-01-06  144  
8dd594d12f08acc Darrick J. Wong 2022-01-06  145  		if (xchk_should_terminate(sc, &error))
8dd594d12f08acc Darrick J. Wong 2022-01-06  146  			return error;
8dd594d12f08acc Darrick J. Wong 2022-01-06  147  
8dd594d12f08acc Darrick J. Wong 2022-01-06  148  		delay(HZ / 10);
8dd594d12f08acc Darrick J. Wong 2022-01-06  149  		down_write(&sb->s_umount);
8dd594d12f08acc Darrick J. Wong 2022-01-06  150  	}
8dd594d12f08acc Darrick J. Wong 2022-01-06  151  
8dd594d12f08acc Darrick J. Wong 2022-01-06  152  	if (sb_rdonly(sb)) {
8dd594d12f08acc Darrick J. Wong 2022-01-06  153  		sb->s_writers.frozen = SB_FREEZE_EXCLUSIVE;
8dd594d12f08acc Darrick J. Wong 2022-01-06  154  		goto done;
8dd594d12f08acc Darrick J. Wong 2022-01-06  155  	}
8dd594d12f08acc Darrick J. Wong 2022-01-06  156  
8dd594d12f08acc Darrick J. Wong 2022-01-06  157  	sb->s_writers.frozen = SB_FREEZE_WRITE;
8dd594d12f08acc Darrick J. Wong 2022-01-06  158  	/* Release s_umount to preserve sb_start_write -> s_umount ordering */
8dd594d12f08acc Darrick J. Wong 2022-01-06  159  	up_write(&sb->s_umount);
8dd594d12f08acc Darrick J. Wong 2022-01-06  160  	percpu_down_write(sb->s_writers.rw_sem + SB_FREEZE_WRITE - 1);
8dd594d12f08acc Darrick J. Wong 2022-01-06  161  	down_write(&sb->s_umount);
8dd594d12f08acc Darrick J. Wong 2022-01-06  162  
8dd594d12f08acc Darrick J. Wong 2022-01-06  163  	/* Now we go and block page faults... */
8dd594d12f08acc Darrick J. Wong 2022-01-06  164  	sb->s_writers.frozen = SB_FREEZE_PAGEFAULT;
8dd594d12f08acc Darrick J. Wong 2022-01-06  165  	percpu_down_write(sb->s_writers.rw_sem + SB_FREEZE_PAGEFAULT - 1);
8dd594d12f08acc Darrick J. Wong 2022-01-06  166  
8dd594d12f08acc Darrick J. Wong 2022-01-06  167  	/*
8dd594d12f08acc Darrick J. Wong 2022-01-06  168  	 * All writers are done so after syncing there won't be dirty data.
8dd594d12f08acc Darrick J. Wong 2022-01-06  169  	 * Let xfs_fs_sync_fs flush dirty data so the VFS won't start writeback
8dd594d12f08acc Darrick J. Wong 2022-01-06  170  	 * and to disable the background gc workers.
8dd594d12f08acc Darrick J. Wong 2022-01-06  171  	 */
8dd594d12f08acc Darrick J. Wong 2022-01-06  172  	error = sync_filesystem(sb);
8dd594d12f08acc Darrick J. Wong 2022-01-06  173  	if (error) {
8dd594d12f08acc Darrick J. Wong 2022-01-06  174  		sb->s_writers.frozen = SB_UNFROZEN;
8dd594d12f08acc Darrick J. Wong 2022-01-06  175  		for (level = SB_FREEZE_PAGEFAULT; level >= 0; level--)
8dd594d12f08acc Darrick J. Wong 2022-01-06  176  			percpu_up_write(sb->s_writers.rw_sem + level);
8dd594d12f08acc Darrick J. Wong 2022-01-06  177  		wake_up(&sb->s_writers.wait_unfrozen);

Smatch wanted an up_write(&sb->s_umount); but this looks intentional?

8dd594d12f08acc Darrick J. Wong 2022-01-06  178  		return error;
8dd594d12f08acc Darrick J. Wong 2022-01-06  179  	}
8dd594d12f08acc Darrick J. Wong 2022-01-06  180  
8dd594d12f08acc Darrick J. Wong 2022-01-06  181  	/* Now wait for internal filesystem counter */
8dd594d12f08acc Darrick J. Wong 2022-01-06  182  	sb->s_writers.frozen = SB_FREEZE_FS;
8dd594d12f08acc Darrick J. Wong 2022-01-06  183  	percpu_down_write(sb->s_writers.rw_sem + SB_FREEZE_FS - 1);
8dd594d12f08acc Darrick J. Wong 2022-01-06  184  
8dd594d12f08acc Darrick J. Wong 2022-01-06  185  	/*
8dd594d12f08acc Darrick J. Wong 2022-01-06  186  	 * We do not need to quiesce the log to check the summary counters, so
8dd594d12f08acc Darrick J. Wong 2022-01-06  187  	 * skip the call to xfs_fs_freeze here.  To prevent anyone else from
8dd594d12f08acc Darrick J. Wong 2022-01-06  188  	 * unfreezing us, set the VFS freeze level to one higher than
8dd594d12f08acc Darrick J. Wong 2022-01-06  189  	 * FREEZE_COMPLETE.
8dd594d12f08acc Darrick J. Wong 2022-01-06  190  	 */
8dd594d12f08acc Darrick J. Wong 2022-01-06  191  	sb->s_writers.frozen = SB_FREEZE_EXCLUSIVE;
8dd594d12f08acc Darrick J. Wong 2022-01-06  192  	for (level = SB_FREEZE_LEVELS - 1; level >= 0; level--)
8dd594d12f08acc Darrick J. Wong 2022-01-06  193  		percpu_rwsem_release(sb->s_writers.rw_sem + level, 0,
8dd594d12f08acc Darrick J. Wong 2022-01-06  194  				_THIS_IP_);
8dd594d12f08acc Darrick J. Wong 2022-01-06  195  done:
8dd594d12f08acc Darrick J. Wong 2022-01-06  196  	fsc->frozen = true;
8dd594d12f08acc Darrick J. Wong 2022-01-06  197  	up_write(&sb->s_umount);
8dd594d12f08acc Darrick J. Wong 2022-01-06 @198  	return 0;
8dd594d12f08acc Darrick J. Wong 2022-01-06  199  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

