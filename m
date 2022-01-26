Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B35849C74F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239809AbiAZKRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:17:49 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48098 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239815AbiAZKRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:17:33 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20Q9lBKW001958;
        Wed, 26 Jan 2022 10:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=yCWe6xoqSdzwDWOwhJWFcl1NfRCNvj4FwjJziH9kej4=;
 b=R34xYsZuCoZgU7KY2gT7nINSQ7Wp74lWozVk77izo7rwj2wlvy6cZ50mwxHEgctusjE9
 3F5TqU2qdAgTIOX6276Fu3PlDeYC+yPL0tMA7uj2V6s6gzuDLHLB9ZE+TH96URQkzYdv
 MJFW8dWaQRmw2wuwbVEN5lsv1VoYJdclPXsqSobtP5+9dt985M7zmYE7ObSJczb2uVKD
 wjoCAmK/oVj3iRBSAcNVPZUWN/1Uc2Sab3dW/KDJyhkcvXOz4IfdWgTirgH49TJ6g9NH
 3VZ9UmGQV6x3gzVhvk+gB+dlXQHbSVaqgZsLrMkUQT5e9xaTJiZ/EoKxl8AweUtUsrdt SA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dswh9p2k5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 10:17:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QAB29i021526;
        Wed, 26 Jan 2022 10:17:12 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by userp3030.oracle.com with ESMTP id 3dr720t87f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 10:17:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knAOtgErUxjWHeGqwN11EBqEswZFhC6DMOM/qlOMhL8I5HQcpNOLP7OCNlz6tIlWDEYh5kDTAVcQNztFRIxgsHPeSpWwG9KyEcU8iv4R2+cDQDKCpZo/SSdr0Uneiq39AbZx0Pzsiyg5VC+A+hwb89oupBdShA6xcteiK/Kt3Civf4JYvuiSk58vJrji3vrdQ3NjgWN/qr2PAtfpNSPap5p4e8EtOTkG7jsSm5VoNNMuCjgUrUTy6GcC0w/rqF/vIfFCCmPzgexKfFLkqhQMdIk0hXiTa2334UpZe38ISYQQKOcGOMRxAo31gVLg7q3S/rkTXCldJNs4atGbtY2/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCWe6xoqSdzwDWOwhJWFcl1NfRCNvj4FwjJziH9kej4=;
 b=naKTqF44YFA8YGwevF2HOfhL98S3j+8oaodbSS1kRUizR5DumofmMqhy+pmlo4bkcFVQg6hbDz8Z13DSjUWuy2+tL3Djy/Sit7NSfp8yvXuWWLF+bt2jpuvjPKstq375cZ/+NXLGDObh41TlCJW0Uh3BWxdoed4RrRi/V8nZGkKzF8ppwNp0ZDqdisYEpWduOuxf29j+UrYRqOJ2OtOW0Zy2FG/rhvpN77ETkhy9ePk25iXkKRMEA1brN/Qjt2QLStIcQRJfPpzUs2WNmgd4qGuPnj4BoNUm24pIkacyU865JyPNu0WRcsQi42UfwrAJMn+n8UMcqwlpSYBr2bBauA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCWe6xoqSdzwDWOwhJWFcl1NfRCNvj4FwjJziH9kej4=;
 b=NLsrUxmdnvVlZVgVUcEVF25oqHn79ORO0mFhgnr9afbitHIPLLXWc9gC/VXZOFXhoh7j1oZkR2HHLlKmbkbl9VW8NeTM8jLD8C2jYpePLJbyL76FsYqQUkciu3z6rx7ACmYhM5u0HbG924+rVfRt91IJ0/Xz7mNgnYbOghbnkp0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3980.namprd10.prod.outlook.com
 (2603:10b6:5:1d2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 10:17:10 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 10:17:10 +0000
Date:   Wed, 26 Jan 2022 13:16:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jing Liu <jing2.liu@intel.com>,
        Yang Zhong <yang.zhong@intel.com>
Subject: arch/x86/kernel/fpu/xstate.c:1580 fpstate_realloc() warn: variable
 dereferenced before check 'curfps' (see line 1559)
Message-ID: <202201250223.SYDiQopU-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0041.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::29)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb1611d2-ee56-495b-c371-08d9e0b50372
X-MS-TrafficTypeDiagnostic: DM6PR10MB3980:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB39804058312F8DECF402523C8E209@DM6PR10MB3980.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SUnm/5SiBRzQ+9vNKC6xx02piL6ulhbnzgQcVBoWmvOsUeGRLtP6eV5z3e70jMZVbONW8ADJ80yHOMNbdRIYWOkYMqS5bVqwTByPkSdRe3cL/JvC07jq68tFUmP1yP/eFupyytoO/JZZl9Y6WLA5Zaoe8AlxJ0BsNLhLjI0Kw3cLiwFqZCgBYmp1g/CHBJktQ5GNC0HZ3DomIt2I3HFImyWUYnqMzaDzWUC6UcKmkBE7kT1OqTufmUsRcjuf3QV32PMvoV3ZPxGwOK3s6dw8OxNJKRcxvofaOMwIzs5hxziJPU6//wZrM2E2mRjSJouYEPFUKKZK6yC8Nx62ntkxlNfDUlJEpYugeW5q+OfrpgVQygPCSBJSNz3hRWg89qn5H9lNx5QVzwFDp15FfDafBN39J1u/2GfBy0OIxGaZ9gG4F3/Iyyl2p2CzP0p2r4CrPf/afZuWfDBZ4own5998W82FUC003+7hrBMbNdVqoKiR9hOdclIok7+zhD0nABjcE5q9bP6jY/ZQAdNPn57oJNJVNs9hOb/SwHajaj4jDD9B/4j878O5xJawF0/dT2iibsac6bbNsldrH47aCfr0kezczzBQtvzAXgKgFSs3in1eCbP8KrNvZ8ZY81DmQtgI0h0s3nUsCVOBbhqPLaAGltpvU9QIiV8QNwMgBBM0I/cQggYQAKhGrbJdTCS45fcZ6ZGJslcBKA+39Lp+eU0QauqUiKxjcJoP5QvVAa8Mk59r49Sbgw8GPSIFTpZSPHjrWTS8XpkmK1ULulwY6g0KdyPPBi1ZuqgKSrR4NfJ0jP6cBEIZc0wdqCkqys2C8qtrxewA55xaVKSGDi7IiLRpOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(6506007)(52116002)(9686003)(26005)(5660300002)(2906002)(4001150100001)(36756003)(44832011)(186003)(1076003)(6666004)(38350700002)(6916009)(54906003)(86362001)(6486002)(4326008)(66946007)(508600001)(966005)(38100700002)(316002)(8676002)(8936002)(66476007)(66556008)(83380400001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SG6IN/ZrHEE4qNJe2qdhPn2xAOsxslcUzEAXYcGwn6y9zFHtcANYzsaAUQsW?=
 =?us-ascii?Q?5zQwqCPxUUZGeCpu18/1ctWpPPpvneZQjNh8alnPWZawhc4YxP+AotCgR7px?=
 =?us-ascii?Q?LeqrxAFoeg9fpRNn368hnqKUXyiZKHzLksJT5+dQH1q1s84QMuV0W8XvV0Ze?=
 =?us-ascii?Q?VnfFXNwV5Nx+Z0IXsTgCPMeqvL4Y0p1I5nBXZ1OJOFzkjjRZvt+9lMxwelF9?=
 =?us-ascii?Q?1PnuTwJOSF9Kwfb87RI0B0ZzH/VksSPT3iJfQKuRInLF9DT96cC7rPxONbVG?=
 =?us-ascii?Q?YmTecyhKFb6ZBVabWAG6SBaz9LHTtnOvHFiY5VLWmEEASa3Xlx5M2J3A7fSl?=
 =?us-ascii?Q?YADKJaQTbqz8aT5BufOfbQ7JDWg5I83TeJ3VWqzu2VbUhfSTObQ1udtY7DTe?=
 =?us-ascii?Q?+qlmfmnNpfccq6eljXTEF6lSALww6wdS8751RYB+KeHvqAmu4pfY4XYKjLod?=
 =?us-ascii?Q?jdtUqp/Jv+VZHbJSa1nqdG/R/FK94JJGRzfCDn2lOJibMSu9Xcor2e/8VI3B?=
 =?us-ascii?Q?Ey5H48g5HJg+zRwn8YOo2k+Rp+KMIpsjP7Z6nLx8gWvpd8lfC/VaXVXgyYUN?=
 =?us-ascii?Q?dADED9qEB1knlbhcz6moyuIQAVIaDrPmG+Off3HkLvP2IYhmZN/WPKbFrDT6?=
 =?us-ascii?Q?U6WLK8a0mAqbZV3FQEe7X3WQjB3pFntsSeVTbzrZrVdRagt3jaDVnXXpJn6o?=
 =?us-ascii?Q?YFaFwI1O9F/z5+HzAkajtNU0tQIRtzKMfktygkWn7AVQK6Nuv15z0dOodX7Y?=
 =?us-ascii?Q?nfrkp3z7REI1MgfxEdTty9VRkvxcRnQwy9oYjkfsetLvx5tuBJ6N1NRhFWMB?=
 =?us-ascii?Q?+1ZFqvCtMJf+gYRyUCtg+4Cz79YmHY2EUIabT0pC2R/kbW6gGuh0ZOGCikfy?=
 =?us-ascii?Q?oUsQ8+cGR5DYC+YSAoUGMtO5QWHVT/omMtsYssA+aQyZ4ZQkN9ipMN/eZd2O?=
 =?us-ascii?Q?SEtmdR8wbBoo1QKpagANJoSqdoYbcLV0Nq1g/u/JV7uOulyU1wBAFUSjGhRT?=
 =?us-ascii?Q?9FXF9J3KrWT8rFOtHpiMv4qp/Ddd+VxiqS79fh2zTuWV4ekCacg5p7ELW4Tu?=
 =?us-ascii?Q?9DqOz95VG+eDsyk8dfStWHUtWuOk8NWSAj0ukTLo80YspfliZ0wGWlMdeqhk?=
 =?us-ascii?Q?P19cjxhgijc+D+GxfjAgNQ0YcUqdwYAd/Uw/dEZASQapohxGtvGueCJ3KMWW?=
 =?us-ascii?Q?MONeO3S0BFbcDWApNHZ/PcYsYXwk2iiOYlW8KF/2NesAZEdZ895kGahNjAaR?=
 =?us-ascii?Q?lHWwwN0zxhXP0vy+whmRsAQAZ/4v12QRPhtCPCxvqWjjwxvIb26QvmgE9HlB?=
 =?us-ascii?Q?TDNpNHnpPEBRwzuSP9bjhR7pLnSLMXeDnDyD1xjxEIWWWhDVboYJAP0Qvkrj?=
 =?us-ascii?Q?J2T/nVGB3sEExbsHN82y5l52ph2wYbbVo1UAnUS/mJdDXPhGFgOK9Sx58yKy?=
 =?us-ascii?Q?3yzKqwh+Ltjj1CDl4WVkCZes3Eif0a6pBODgLTEAUmFs1IXjbXprXyjwdie6?=
 =?us-ascii?Q?ScNm9Yv4F0x3SzGt/GlcUEAhQ2cp/YFjfStTuVKqjpATEdxKtAG7gVY3uRoh?=
 =?us-ascii?Q?2eP1psZYwBkHzMEpgX/OUAvj4mIMIZF8j9BwFwH//oerZlrLzf2sYTh/BNP2?=
 =?us-ascii?Q?75KSUFIUYcmJpVsWG3N6cuKhWgnBVXQQwkVVccSR9LQGw7js97PXTm1W1r0G?=
 =?us-ascii?Q?KICVR4iGVj2tbHSmhwpnAKj3+Ns=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1611d2-ee56-495b-c371-08d9e0b50372
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 10:17:10.2128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/E+XJpMw9jGVu6AiBWK7nytK6GbHawH99GBlY5VrvWS4e+n/Lj5AFMZqcSQLg5OktQEr1BLzU9o3ZJ9HHHj8xMqyF9+7kXKIQ/isi/MMqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3980
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201260060
X-Proofpoint-ORIG-GUID: 1zY_RaFfEhcbZEbAfPvbbKVW2h5yzT4R
X-Proofpoint-GUID: 1zY_RaFfEhcbZEbAfPvbbKVW2h5yzT4R
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0
commit: c270ce393dfd700e7510a4579568deeefba954fd x86/fpu: Add guest support to xfd_enable_feature()
config: x86_64-randconfig-m001-20220124 (https://download.01.org/0day-ci/archive/20220125/202201250223.SYDiQopU-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
arch/x86/kernel/fpu/xstate.c:1580 fpstate_realloc() warn: variable dereferenced before check 'curfps' (see line 1559)

vim +/curfps +1580 arch/x86/kernel/fpu/xstate.c

500afbf645a040 Chang S. Bae    2021-10-21  1517  static int fpstate_realloc(u64 xfeatures, unsigned int ksize,
c270ce393dfd70 Thomas Gleixner 2022-01-05  1518  			   unsigned int usize, struct fpu_guest *guest_fpu)
500afbf645a040 Chang S. Bae    2021-10-21  1519  {
500afbf645a040 Chang S. Bae    2021-10-21  1520  	struct fpu *fpu = &current->thread.fpu;
500afbf645a040 Chang S. Bae    2021-10-21  1521  	struct fpstate *curfps, *newfps = NULL;
500afbf645a040 Chang S. Bae    2021-10-21  1522  	unsigned int fpsize;
c270ce393dfd70 Thomas Gleixner 2022-01-05  1523  	bool in_use;
500afbf645a040 Chang S. Bae    2021-10-21  1524  
500afbf645a040 Chang S. Bae    2021-10-21  1525  	fpsize = ksize + ALIGN(offsetof(struct fpstate, regs), 64);
500afbf645a040 Chang S. Bae    2021-10-21  1526  
500afbf645a040 Chang S. Bae    2021-10-21  1527  	newfps = vzalloc(fpsize);
500afbf645a040 Chang S. Bae    2021-10-21  1528  	if (!newfps)
500afbf645a040 Chang S. Bae    2021-10-21  1529  		return -ENOMEM;
500afbf645a040 Chang S. Bae    2021-10-21  1530  	newfps->size = ksize;
500afbf645a040 Chang S. Bae    2021-10-21  1531  	newfps->user_size = usize;
500afbf645a040 Chang S. Bae    2021-10-21  1532  	newfps->is_valloc = true;
500afbf645a040 Chang S. Bae    2021-10-21  1533  
c270ce393dfd70 Thomas Gleixner 2022-01-05  1534  	/*
c270ce393dfd70 Thomas Gleixner 2022-01-05  1535  	 * When a guest FPU is supplied, use @guest_fpu->fpstate
c270ce393dfd70 Thomas Gleixner 2022-01-05  1536  	 * as reference independent whether it is in use or not.
c270ce393dfd70 Thomas Gleixner 2022-01-05  1537  	 */
c270ce393dfd70 Thomas Gleixner 2022-01-05  1538  	curfps = guest_fpu ? guest_fpu->fpstate : fpu->fpstate;
c270ce393dfd70 Thomas Gleixner 2022-01-05  1539  
c270ce393dfd70 Thomas Gleixner 2022-01-05  1540  	/* Determine whether @curfps is the active fpstate */
c270ce393dfd70 Thomas Gleixner 2022-01-05  1541  	in_use = fpu->fpstate == curfps;
c270ce393dfd70 Thomas Gleixner 2022-01-05  1542  
c270ce393dfd70 Thomas Gleixner 2022-01-05  1543  	if (guest_fpu) {
c270ce393dfd70 Thomas Gleixner 2022-01-05  1544  		newfps->is_guest = true;
c270ce393dfd70 Thomas Gleixner 2022-01-05  1545  		newfps->is_confidential = curfps->is_confidential;
c270ce393dfd70 Thomas Gleixner 2022-01-05  1546  		newfps->in_use = curfps->in_use;
c270ce393dfd70 Thomas Gleixner 2022-01-05  1547  		guest_fpu->xfeatures |= xfeatures;
c270ce393dfd70 Thomas Gleixner 2022-01-05  1548  	}
c270ce393dfd70 Thomas Gleixner 2022-01-05  1549  
500afbf645a040 Chang S. Bae    2021-10-21  1550  	fpregs_lock();
500afbf645a040 Chang S. Bae    2021-10-21  1551  	/*
c270ce393dfd70 Thomas Gleixner 2022-01-05  1552  	 * If @curfps is in use, ensure that the current state is in the
c270ce393dfd70 Thomas Gleixner 2022-01-05  1553  	 * registers before swapping fpstate as that might invalidate it
c270ce393dfd70 Thomas Gleixner 2022-01-05  1554  	 * due to layout changes.
500afbf645a040 Chang S. Bae    2021-10-21  1555  	 */
c270ce393dfd70 Thomas Gleixner 2022-01-05  1556  	if (in_use && test_thread_flag(TIF_NEED_FPU_LOAD))
500afbf645a040 Chang S. Bae    2021-10-21  1557  		fpregs_restore_userregs();
500afbf645a040 Chang S. Bae    2021-10-21  1558  
500afbf645a040 Chang S. Bae    2021-10-21 @1559  	newfps->xfeatures = curfps->xfeatures | xfeatures;
                                                                            ^^^^^^^^^^^^^^^^^
Unchecked dereference

500afbf645a040 Chang S. Bae    2021-10-21  1560  	newfps->user_xfeatures = curfps->user_xfeatures | xfeatures;
500afbf645a040 Chang S. Bae    2021-10-21  1561  	newfps->xfd = curfps->xfd & ~xfeatures;
500afbf645a040 Chang S. Bae    2021-10-21  1562  
500afbf645a040 Chang S. Bae    2021-10-21  1563  	/* Do the final updates within the locked region */
500afbf645a040 Chang S. Bae    2021-10-21  1564  	xstate_init_xcomp_bv(&newfps->regs.xsave, newfps->xfeatures);
500afbf645a040 Chang S. Bae    2021-10-21  1565  
c270ce393dfd70 Thomas Gleixner 2022-01-05  1566  	if (guest_fpu) {
c270ce393dfd70 Thomas Gleixner 2022-01-05  1567  		guest_fpu->fpstate = newfps;
c270ce393dfd70 Thomas Gleixner 2022-01-05  1568  		/* If curfps is active, update the FPU fpstate pointer */
c270ce393dfd70 Thomas Gleixner 2022-01-05  1569  		if (in_use)
c270ce393dfd70 Thomas Gleixner 2022-01-05  1570  			fpu->fpstate = newfps;
c270ce393dfd70 Thomas Gleixner 2022-01-05  1571  	} else {
c270ce393dfd70 Thomas Gleixner 2022-01-05  1572  		fpu->fpstate = newfps;
c270ce393dfd70 Thomas Gleixner 2022-01-05  1573  	}
c270ce393dfd70 Thomas Gleixner 2022-01-05  1574  
c270ce393dfd70 Thomas Gleixner 2022-01-05  1575  	if (in_use)
c270ce393dfd70 Thomas Gleixner 2022-01-05  1576  		xfd_update_state(fpu->fpstate);
500afbf645a040 Chang S. Bae    2021-10-21  1577  	fpregs_unlock();
500afbf645a040 Chang S. Bae    2021-10-21  1578  
c270ce393dfd70 Thomas Gleixner 2022-01-05  1579  	/* Only free valloc'ed state */
c270ce393dfd70 Thomas Gleixner 2022-01-05 @1580  	if (curfps && curfps->is_valloc)
                                                            ^^^^^^
Checked too late

500afbf645a040 Chang S. Bae    2021-10-21  1581  		vfree(curfps);
c270ce393dfd70 Thomas Gleixner 2022-01-05  1582  
500afbf645a040 Chang S. Bae    2021-10-21  1583  	return 0;
500afbf645a040 Chang S. Bae    2021-10-21  1584  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

