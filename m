Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3546A4613BB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241962AbhK2LTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 06:19:48 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:33832 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240430AbhK2LRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:17:34 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AT9gkJg029596;
        Mon, 29 Nov 2021 11:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=D6rm+CBVJ7hM5wvj2qz+4pUAJjcfOIOgP9Mqpug26J0=;
 b=n4JvgCCRaZWUrin9wNtTDu3VlLwOecGn41EdAcZG/w52sUIjokiGcD5gUii6VEbe7Q+T
 KMsvv9uI9klzqWvRSPsAbq7n1QxWuMWpu7ULI/XmXhhbLxa+YPTDGroEfzlkfLyqSwR4
 lxLTjymvrEKXcgE42lYLvaTjfQZirEGpdSh1rzKHRs7S/F6QvZ2etlXt5adpBN/ntVTN
 cG60WbnB6JIhG/2qVbFcDWm3XU4l2tjZZ4vkkSGyQ2vXZVNsMzOr0iTGAGAtq/rCMk+d
 nSsF6DFekG/em+lwMvSAKp1UF27dci3shLp9+xY9vPY74mS2AsF68c0Ma4Dul/Wz1mFo OA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmu1w8uce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 11:14:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ATB5gLi073895;
        Mon, 29 Nov 2021 11:14:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by userp3030.oracle.com with ESMTP id 3ck9sw44w7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 11:14:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdLtFt83Vc4FpIt9um96+p6vx/0SCrJdxBgrbmOmee1q3oH16vNoChKH6WG16blI0/AGtZvs6P/0hsX0eniviNkiIOGUgwVP9YMfHVFKErfKmH6JkuEZN9ts41QOR5Q8EV9BJbFukW/UlkaZDL2qUx9b93EvpfpWHvnCQEx9rrEx9ggT55dvpCrzVeDmTV/FkuozNrCu3IKYjb9NboGba/dyA86AxYLzwPu7e10R7y26eyQpAvzbUy2O0jMx5MYfHln7Y2W6Ghk3zmXQxZuk+9Jm2+9w9Cb1FLPR5OtgmAiX+s2EKNYtlIBketBS4knOSKhiEygCOWf6fCPUDYxumA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6rm+CBVJ7hM5wvj2qz+4pUAJjcfOIOgP9Mqpug26J0=;
 b=AJlnWvM5aGHWVEBHVBYl08Wvek/Ei/m0zD0xYZYyBah4Jqfd8HM0HnmGR9+1S2prUOPwmFtTz9iFj1Se3XtxozF88gILZytzPthvhY3Tf27SW76hn3HkcVhtzk4hMFj2PFEsxRYKP5FFdWbX/u4cEOuqOkbfE5F1j3UpfGGHUNRGiHWCZiVOuFg3HuRfVPg3xf23RkOyTqLAMJS6fu0/VLNiyhgQJUyTKQpXErFTRidt7si5t2uMVycTt8nTeO1KchTWkFbu+KbzzOrnpjAJXpDrnvz7mAv9shxP3jgSeVpl1zN12Ji4s7IDBrdDluWDiQF/1pDGNgYbcLgAy8ORkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6rm+CBVJ7hM5wvj2qz+4pUAJjcfOIOgP9Mqpug26J0=;
 b=ipKSpHt63WhVQcnlTce7VYamEisNPnHyqLBG0sNDSDpXHRw3aMs66HqNy+lGDxYIHtKtmsMJt3nfXwt8CHq5bNGVIXcsELevPPc2awzSeg3BkNKWPIzPUJ/kgDEfQqURnxDLiZEvnboPoN4eAHHxkEmQWKBdhF3MlO4a6nYqXoA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1295.namprd10.prod.outlook.com
 (2603:10b6:300:1e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 11:14:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 11:14:09 +0000
Date:   Mon, 29 Nov 2021 14:13:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Petr Machata <petrm@nvidia.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:petrm_soft_counters 7/8] net/core/dev.c:8395
 netdev_offload_xstats_hw_stats_enable() error: uninitialized symbol 'stats'.
Message-ID: <202111260203.hEYHxybc-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0047.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::35)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JN2P275CA0047.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21 via Frontend Transport; Mon, 29 Nov 2021 11:14:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aaf9d49e-80e3-4433-d445-08d9b3295d46
X-MS-TrafficTypeDiagnostic: MWHPR10MB1295:
X-Microsoft-Antispam-PRVS: <MWHPR10MB12957A0A6F56EBB390C9AD468E669@MWHPR10MB1295.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:221;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NJXU01+aIY/xIFA261CO3FpXzRlGR963HAJOtz/m9X4UUYpsMqeBDvuP1p+x26buDo3jrMWtUKL1GIW2QXaFLhLSpl8yps6uiZPVXkxjrgqOcOIzHUtVUFlKbUxKCya7HD+U1tWZWZKbGquRedSgX/6TKBw30Yqy6olqRBjFs8/uu7p6AJMpf9UVWhR8CfCn6jEc+zT4HIlgAicTjWG1J4NIzlIiPSmxknc704g6K5egemq8e7RfoBy08k6GabJ9+mA8HBsObtBT2pX62GUtgpspSe/iuEbkT64ehsQbr3RvvSFWlUJmaOAhsfBjmJtdRwj/zdK+7R+VH16WQKKgJK6Upz/sKPT0tAC371K7g+H28d0SYM+yPSPLtcB0lJ5Vmb2JsdKDWa96qKVLDk1BjFeYhJ9CEC7PPY8v92ZKYeAmcQFDOJbv+f9ZTAptp8mKdrvnYK/6fqdp+WcB4CAPPrOGlvj//v4uxHWNHXgg4PGuT1uffvjSSNiTJ1lUDvENjcB+eM8ObTmajPHVyDol2xhByWzVF8ZpUiwVgS8rD8ptZrLd3tkX/72+0/teTGiCk44gLqvM9NgI6GsSR9tO10HnN/Ofrbc/tlxrPfUoTsOwTF2UEhprqM2JWUOX0FqRNaBNHXSA1i1tTRxm1XxVJF71cX/gPdXcWRYGswNk72WfQ6paXvrrQk3Yvw+wWzGCXmUMAz5BotREpIEEbsfjBaXmoC0L2eW/TEy0vItYcKrLmvvEO3W0f56/78QbSENCw+JM4WtGyk27whRTUn8JIACIAnfU/OlTclvdhw15txcWxpR54TPXBKIIcLrV8xnzLwb80r5W/ttkm+gl72iHKXeyAG9mmYv3EUaZEE8sG4w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(66556008)(9686003)(508600001)(316002)(186003)(8676002)(956004)(66946007)(6486002)(8936002)(2906002)(6666004)(4326008)(86362001)(36756003)(6916009)(44832011)(6496006)(5660300002)(83380400001)(1076003)(26005)(4001150100001)(52116002)(38100700002)(38350700002)(966005)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KU6h5X76Kq0VmRlFUaQfVSOL593wJrjlYzvhQNa/eRhwv4xyfRDKdJjUEmqT?=
 =?us-ascii?Q?gVfhFALCw7SQo8845egxWNboNX1foVhbKpg+ZZiIGoip3ZtwNDBMz3kYGY2g?=
 =?us-ascii?Q?AK8zJul6542SN/1FT3kEh4qyY7n6rgNJayZXk5NfPXkHyxbH09fmS1YZf0QD?=
 =?us-ascii?Q?1E4rk6IkTOIfQuuyqqKb1GwufpkNUcbkUlbrShxFzhI/0pEQGSB2kxrVl2dJ?=
 =?us-ascii?Q?cPRVhxmYqsQTuLDy/g6EdLYRN4gduzc0Jfn31QgycuQrLeLpiuV0IRYz7+Yl?=
 =?us-ascii?Q?ob1lwyjClElJeRxPdNlG1DgCxnW2YVVQfaNm+2ePJT3EEhZo3akMswBi2Ifm?=
 =?us-ascii?Q?oVh9suzhRjvIkXyceFSUT2+FpEMtpCuGmuNTqndX0YTLWqa64knKsxMZFXNA?=
 =?us-ascii?Q?203/smXoW35+dhe5epSppH5oMm4TecuElY0UBISHMJAnCo1GvtMyWrq7cfuj?=
 =?us-ascii?Q?Xj3WlTbprp7QjF8GR7pHzq1RqLkDd0ZCFvlsXV1+E0Apb8b9i4/XuhdeRYM5?=
 =?us-ascii?Q?LYlyCF3gHauN+HQItrG1axMc8WAqzW5Auea2Ad7a4rlt/h+XvDx3meMUFI9w?=
 =?us-ascii?Q?34GlmIG+zxBoSyfjWVMwZ3km8X/17YVq+bGiEepS7kojFClAyOve9ysRsMf6?=
 =?us-ascii?Q?1qrfAuV/lkV5uY2+tkfC/KgGYqXtfHgmCOX79lL4S9vVgVAVTzYXBFI4GWPV?=
 =?us-ascii?Q?tp1YEwVkXIg9cZxoaxxY1y1pL6myXyGxENJaWZogC0HIr8YZ9gcBbjAbNivZ?=
 =?us-ascii?Q?OZzsqk9J/brLkRXHfbQHtJ1Jm8NV2r71VwQigMeVaXhNpw98HY5N1vPhoxag?=
 =?us-ascii?Q?OQDpH7f5iBWqtohs8ZN4PPKxs6VrQ5b7U2q4/Q/tYKnjTWr/yjpy6isHJV1H?=
 =?us-ascii?Q?VRrRsKDTXS0iJjf+7q1hVHsjA2vdrvZSku6gl8wFvcf9NqSSA0uQtGYYOii4?=
 =?us-ascii?Q?tYyTA0s8QJHmAK7eajKLHWjH6zIKEryJX+URZmh2bUhPl9D/WSYi8NiBHX7y?=
 =?us-ascii?Q?PBP0166VKw1sXESv61B5XSRY80Z3yv7DVeGStt3TdMAOa2bh0H9Dw3Vj2yHT?=
 =?us-ascii?Q?C1N1kP7LZE9NPaeHYBIMgVUUI2fw57LPlDH0Wi64GWps5whDOaehKqyJ6bwc?=
 =?us-ascii?Q?JAekx+qf6PNmZhi4QoC4XK0RM1E0hNhRAjBSZwgnOYgWPVYzeDsQK9WOYpwN?=
 =?us-ascii?Q?QWSrkXhnO/d7AOoo2EB8/BkfBulTq7c7t6V2Box8ym9lNi8MySF4MviEKiqo?=
 =?us-ascii?Q?bSOW11vjeawjQGSe022T4Bpk+IzKwmF/xkBuJPcWgle033c1V5S4Xii6oOIV?=
 =?us-ascii?Q?aUJcAN5TCC+FY9D5vbDYW5F8V8GKPqcd+Zzg+LWdsKwS6/7gWwW9Amosjh2L?=
 =?us-ascii?Q?S6Nh04lRCv0b6q2lH2dyrc5/KoCtXFCscDXFjUgYNPy9Pt+4gdvjfwB6DMZl?=
 =?us-ascii?Q?D+gw8QBgeVdxMB7H5AcEnKqm6eHsJl0LeJTxTuYrwOn0lncTd5ZFrRwHmDSf?=
 =?us-ascii?Q?GHL32iw/xAdEe2p4eQjmFdBJB2xD4ctchrHJadBv2SxUnQLU3qbXnNVRD5eA?=
 =?us-ascii?Q?X7Ysq17Sx5eB7oBRaSPEJCSlspLsVxpIwXNE2nqXUTx48R8HbeIdmqMYZu/B?=
 =?us-ascii?Q?g1IxKEgAuHNhK3gQX6S6AdtKazJzObjzp1cDKs5d7lc/D7jWY4sxP9LVBvnj?=
 =?us-ascii?Q?zuYALUpMuqvRB9kRaFXuND2M1Lo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf9d49e-80e3-4433-d445-08d9b3295d46
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 11:14:09.1108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pg64yECixJQiDUDipzNuMjLkuTnI8pahfnypH2l4FKCZtCZFH4/JA9sOoz7BdhoOrLOd0kfjAEjnR/0Z17pyce3rmjlJR2/iiEkoyE0doUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1295
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10182 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290056
X-Proofpoint-GUID: xNYqLyNBaAZruoppS3q_woUAkAE5EpML
X-Proofpoint-ORIG-GUID: xNYqLyNBaAZruoppS3q_woUAkAE5EpML
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw petrm_soft_counters
head:   59d158395664dab1c1164364d6ee57aaaad44b96
commit: d35d00a6d28ff7a34145438df3a2b39abd00edc3 [7/8] wip
config: x86_64-randconfig-m001-20211117 (https://download.01.org/0day-ci/archive/20211126/202111260203.hEYHxybc-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
net/core/dev.c:8395 netdev_offload_xstats_hw_stats_enable() error: uninitialized symbol 'stats'.

Old smatch warnings:
net/core/dev.c:6922 napi_disable() error: uninitialized symbol 'new'.

vim +/stats +8395 net/core/dev.c

453f3cd9e64f05f Petr Machata 2021-10-29  8363  int netdev_offload_xstats_hw_stats_enable(struct net_device *dev,
453f3cd9e64f05f Petr Machata 2021-10-29  8364  					  u32 req_hw_stats,
a8a72b09197b260 Petr Machata 2021-10-22  8365  					  struct netlink_ext_ack *extack)
a8a72b09197b260 Petr Machata 2021-10-22  8366  {
a8a72b09197b260 Petr Machata 2021-10-22  8367  	struct netdev_notifier_offload_xstats_info info = {
a8a72b09197b260 Petr Machata 2021-10-22  8368  		.info.dev = dev,
a8a72b09197b260 Petr Machata 2021-10-22  8369  		.info.extack = extack,
453f3cd9e64f05f Petr Machata 2021-10-29  8370  		.cmd = NETDEV_OFFLOAD_XSTATS_CMD_ENABLE,
7f3ca7ed5c4b775 Petr Machata 2021-11-03  8371  		.hw_stats = req_hw_stats,
a8a72b09197b260 Petr Machata 2021-10-22  8372  	};
453f3cd9e64f05f Petr Machata 2021-10-29  8373  	struct rtnl_link_stats64 *stats;
a8a72b09197b260 Petr Machata 2021-10-22  8374  	int err;
a8a72b09197b260 Petr Machata 2021-10-22  8375  	int rc;
a8a72b09197b260 Petr Machata 2021-10-22  8376  
d35d00a6d28ff7a Petr Machata 2021-11-12  8377  	if (!dev->offload_hw_stats) {
d35d00a6d28ff7a Petr Machata 2021-11-12  8378  		dev->offload_hw_stats = kzalloc(sizeof(*dev->offload_hw_stats),
d35d00a6d28ff7a Petr Machata 2021-11-12  8379  						GFP_KERNEL);
d35d00a6d28ff7a Petr Machata 2021-11-12  8380  		if (!dev->offload_hw_stats)
453f3cd9e64f05f Petr Machata 2021-10-29  8381  			return -ENOMEM;
d35d00a6d28ff7a Petr Machata 2021-11-12  8382  	}
453f3cd9e64f05f Petr Machata 2021-10-29  8383  
453f3cd9e64f05f Petr Machata 2021-10-29  8384  	rc = call_netdevice_notifiers_info(NETDEV_OFFLOAD_XSTATS_CMD,
a8a72b09197b260 Petr Machata 2021-10-22  8385  					   &info.info);
a8a72b09197b260 Petr Machata 2021-10-22  8386  	err = notifier_to_errno(rc);
453f3cd9e64f05f Petr Machata 2021-10-29  8387  	if (err)
453f3cd9e64f05f Petr Machata 2021-10-29  8388  		// xxx note we need a way to roll back if the notifier chain
453f3cd9e64f05f Petr Machata 2021-10-29  8389  		// fails midway through
453f3cd9e64f05f Petr Machata 2021-10-29  8390  		goto free_stats;
453f3cd9e64f05f Petr Machata 2021-10-29  8391  
453f3cd9e64f05f Petr Machata 2021-10-29  8392  	return 0;
453f3cd9e64f05f Petr Machata 2021-10-29  8393  
453f3cd9e64f05f Petr Machata 2021-10-29  8394  free_stats:
453f3cd9e64f05f Petr Machata 2021-10-29 @8395  	kfree(stats);
                                                      ^^^^^
Never initialized.  Delete this variable.

a8a72b09197b260 Petr Machata 2021-10-22  8396  	return err;
a8a72b09197b260 Petr Machata 2021-10-22  8397  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

