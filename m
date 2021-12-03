Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2AB46786D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352455AbhLCNhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:37:20 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:10614 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241579AbhLCNhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:37:19 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B3CMiNT007655;
        Fri, 3 Dec 2021 13:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=qwVhXM8qeJbQA69eLubbbB+f/YGbX4BN+W9L7FsfsLo=;
 b=CGOnzEeRLD9fuwz9qJ0s13pERbzz6C/5GNiQ6ZLyx9mAqu5CE4XDZkIv3o8qZ0IlcuvQ
 kHkzkSRyPmytlO+fcXstSMPklq4stFnZhv88y9IpYdrWLe6Tv1uSpMiXBj7+WX2pzJoa
 L6xAXtmIWbKw7AicAjvC8I9a9xMAo2036l4cBUemgjf2ILGhh6VyN7NIrOhRDE7nCkOc
 yQlczwMU/rkewVly9cBGpg3gu1kZ3LQvi3IBtpCRHJDCXenYbq9Qw+898jCf2cDQhvCz
 EZR6C0baD4g6E3HgxNjKYQtfNXYUUmAQSaSoRpuszXyCmhYSgBs1NHrQLqPUbQojNg44 wg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp9gkyhfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 13:33:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B3DLree166720;
        Fri, 3 Dec 2021 13:33:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by aserp3020.oracle.com with ESMTP id 3cnhvjey10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 13:33:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbQ/Rqs4d0lbhu1LNFfOTUryi3usRo8GxjPoQF5vVsbg4tXL/Zdc0pzI97oZuhFMVSiUhPZkMbGUxmTwQVOPb9WGmY3alNDaVGTyYPW1ZgRfhr9EScthKz2FvF/3y0NnlTYad8h4OrZzFKJMgEC4iemAQYWtnei+B1eeAgxVYcQ1iMwx/F9h932vi1P9nJJ9nJ3bwcTOcWQK7pIOTeEjBAwpsQIsJEol6WymLMGu/Z3eGGRUS8bgrAvCUntzmy+2lpE+kwn+Q8u37VRBMU47dSxaW/0HmxkdPiQb4KYyuHTCCD3nrcJeg4XvDbim940heR8/YNwTraCjMUZ6Uwulqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwVhXM8qeJbQA69eLubbbB+f/YGbX4BN+W9L7FsfsLo=;
 b=aHTy3dXSWotVAceR+1jPK3S9OzOnv0Aa+obCt7HUkK58INOJqXc287gHOUSIsCcGBME8BbbNCwkYDpmMw3QNFZPSEQ/v8YwwWbShtJj6NaZSOUzW194RckwFliHwxGn4BG7KkLwsSNoGo3JFUpkzVgFINWCbff7alFnHMkS4nVjVWAQW3WTcnQjMG9y7DF1kD4TA8HbFE1VQg7lOX4jNpMkG1SwYrlgTrScBNulolBRpURMnl7PYtRQhzSDNtUsy17mTpc5FlqIbQE4YCUZ9YHt7nxwfuo8s7843m7x3pNVFOvlVFwhJQ6bl0CgICwjeJPvTmEXMQgqB26Z9aaM/CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwVhXM8qeJbQA69eLubbbB+f/YGbX4BN+W9L7FsfsLo=;
 b=Y2OHJWtiE3YMvhX4iPPBgnBPpCaspUEIS+vYi48ZFdrE4JEBOw7RR3IR8n5apdnDENj40cFBnf6xrKUeebrSBpU/IItzvseHRNQ8wDqf0LDuDbSYe5eYw6+JrI9JFtGtoJPTODxezLGPw+l6Kk903uKKDKpA4YHvXyInrBoIHbs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1568.namprd10.prod.outlook.com
 (2603:10b6:300:26::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Fri, 3 Dec
 2021 13:33:45 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.027; Fri, 3 Dec 2021
 13:33:45 +0000
Date:   Fri, 3 Dec 2021 16:33:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Alexey Gladkov <legion@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        "Eric W . Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v1 2/2] ucounts: Move rlimit max values from ucounts max
Message-ID: <202111280022.ugxpiKpA-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcc85eae4f5e3799f9efdf2d73572bb88616ebac.1637934917.git.legion@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0055.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::11)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0055.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Fri, 3 Dec 2021 13:33:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fe162d3-6351-44eb-da8e-08d9b661872f
X-MS-TrafficTypeDiagnostic: MWHPR10MB1568:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1568386835EC3BB3F550504B8E6A9@MWHPR10MB1568.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: coKgoxOa3bHmKbo6bVowoG+zr7/u9DIsss2ZZXRPOPJ+jodzjuYD01VZjyXCEyIkTI4eW/bxPL3HWHxWu9DYBkngeAzQ74hAOFm2yHHppBJvdda7WKYxifUY7tc1cCamhqovPY+4dbyjP6e8F4rZwsfH8xSTPtRbTjm5Mkwh2xSNswLDrla+Cf8/ztV90dJkGqYFc1KUlarTxgrvMzMhHcdfeYka6Z9L5X40LvjMKHamCMP7N6oZbSRI7yFo721xttz8d25xt3PKtzuMBwms3DiiiLpdsSxkvPb/xg6RnkllP3TkhIER5uTx83lLJmUIql93ZlNlkqVKCMQx+dkYHEOHP3kkjf7sgfoYRuEbMN2E5O052Rm/PiXeisow1Oi8/jfFJGK2NC6Kjl2Uv7ghxwMmvP0GpmgcjDNoJ57ySLqtGqV4XqHGl/XQ5iaMqyQSb35SGSaSQzTZTLaipVekqhTBGUJiA+EKHVu4xXD6K+1csle7J53wC10Q2iWmgPP6jslOdE3pqdb8JDbv1ka2xUOeB6AQ7DwyyH5LR4nyEv5YQTV5k6H0c4SKiOo74RbUwS/F1yg1VXuzFtu0Wx/foAvQyFgRLgh0sRvisVrEkQPGxchLMGtD70GEX/4RtyCmSQTJ9bs0or/iScN1Vs34uvW9oUaz+anxxpFm90sc203Cf5O2J6fkCE2ulIWu9oEXbOi5Oz2kJWRqdbaZ+peJQoXrRdRXAiXXF6w007NFhp6VYTZkEHSQzdA7DcjTq/tBgkleY2xcOs5q9fDhgf/cDtRe9RBOBubjOcbfVUsHVhklx8N7Bsmw8yUPsP345zJPissun+klPssSy4IeHUhF0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(5660300002)(52116002)(8936002)(26005)(6486002)(86362001)(38350700002)(38100700002)(6496006)(110136005)(9686003)(186003)(83380400001)(44832011)(956004)(1076003)(316002)(8676002)(508600001)(4326008)(6666004)(966005)(36756003)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WURT40JjsaO5nZkCAkdv4NMl2izpWI/uTkrIf9tL1xnNg+uLTQZ7tYrSYtaQ?=
 =?us-ascii?Q?E+izlHhV6HHLTXhX4jyCGy//HpxLo98ush+zhX2TPhVs7oqLVdzOi4CsGcQr?=
 =?us-ascii?Q?IbElAqPjTBbrQWKUwALGUv8czxrRhNIpNiic4yzBLe5mHqY9pjhuXH8arKeQ?=
 =?us-ascii?Q?0qSCNqCHzfW7LVRocR8fqjWxX7ErOHnTZG+N4XbrxA+lJJoPOgewkUPZIPVm?=
 =?us-ascii?Q?zrmT3sgxpETzLDQD93DYGSendA0ykc5EtjlQTzZprNyYko0gdT6guHYkxciF?=
 =?us-ascii?Q?CNfuXGdUJiGdyA1jZcGXtQeGQxiNTJadMAY58/6Wo08xz+LeQPIB9bwPTW23?=
 =?us-ascii?Q?Ez39QyCUYLvKxJ8YAStGzE7LvJp1U+hC2FztsLgfJIoRh5Rbj80PTDcxINen?=
 =?us-ascii?Q?sE1aYt65SvL4YqhpLU2TpiQAxIf9qEoy9X0rvITyg6LL1WSUYRY1+7M19qmU?=
 =?us-ascii?Q?jG4HrtUnRflE0Fc1MIXRAewCbTrQ1UICG1KMOVFl1Ntvb4lHTC2d/YbuR5wL?=
 =?us-ascii?Q?/ige2moOwrLozPrXoxejjuSoWepqD6VZLPBFCeI0P5vjoH7g121aOzZWshN/?=
 =?us-ascii?Q?R3soAoJpltPy0I0Fp9q5ks+0cJA9V84iPTZO6t0IC0Zm6HetLbye2a/dIDl/?=
 =?us-ascii?Q?by8kT6TZbHcX3jcJ5All62GyG24Yp4wmgj2nGqplTccUG40iN/VOsaRI6lxV?=
 =?us-ascii?Q?xjSD5T+uli7RTwOrqYXCoVwpRuHN6oJ0C+d0NBRWwJw6vx4UYybuGD4nFulI?=
 =?us-ascii?Q?zUwLrgB6PgjGAUqic6RAmqnGAb0X4jNKnOAmagy9J33+auD6nCWcgh1OQ2y8?=
 =?us-ascii?Q?HscVmdnUgQmOhCXOgGtVJ/Lv/nlj5OvB8iZRCwGJaLA5EMLKKBt2ej9Lyvnu?=
 =?us-ascii?Q?JmU9EDQkncRl33Psiz7uI51DRiGGgoZOKAnQDPPFV5vlBOJIZeVEjvRKOo77?=
 =?us-ascii?Q?Do4WrRGW01ifq53GyAW86pnLFVHzbNsIvTkShVWn5hiWtRhovNbw9ZOwhsCD?=
 =?us-ascii?Q?qoPnsO+B7tyIFZTYJhVu4e2gFh/XbLRLdjktIGWmVwZ/mjL6s5uVpKNuZxly?=
 =?us-ascii?Q?mSeWy2frvE9tiPQ7RtG+lPgZa9raEYEjzxYe5yhG/D4USrG3fhxLOoIgfJ7I?=
 =?us-ascii?Q?2/hUX3lqqF/q6ERQ0n1hiXp4i9La6sUMxy3+jHzv8fZ/12vYn5+PPv4e6wdd?=
 =?us-ascii?Q?SrYctbc61zkCJQwJKBO5WGQVRxp5IFiDolSmhGyECeI2rP4Byof5OWNh5DGb?=
 =?us-ascii?Q?9vxR7STglud38KGM+cOA7Z7OHwIM8HDkt5yLftkgLjb7zKzMUjgM+RpFyA+u?=
 =?us-ascii?Q?eJlX5ASBoq5S+MzJ7RKyPF38bMJcEEn0UmLoi48r3pE4ZRZUgQVOSaOa7k98?=
 =?us-ascii?Q?Ga8NxJ2GWAik26AsVPfdKw17wxNA1ifwOCaCbWNqxCOKIb8I5vF0u+0vXwUE?=
 =?us-ascii?Q?TKa82V1dN3ji85K06xogcvx0cJrkq9xoGJiXh2MtLInsiWsIo3jjvZJqbILi?=
 =?us-ascii?Q?BQNVRkJd+hjdkWF5gW555sMek+wai9o/NR1wXzn8CjQtyZwjrYWdowhyCZXP?=
 =?us-ascii?Q?FEUom50eOze1DWkEdanW04raZkB17G8cGWe3SAgTfj4OGOho1vgn6QCCQyNQ?=
 =?us-ascii?Q?Ci74Zyo7C48twhM8kgFcAbJm+w9xVCW3PwuI7GtCJu0r2YhPW3jZq1QRd2Eg?=
 =?us-ascii?Q?ODhAGtgotQxuAvkIJfJRHk8yufU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe162d3-6351-44eb-da8e-08d9b661872f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 13:33:45.1635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wi28Dg+QwG6TwwIzjtGcvv7P1hTM0SdUWn39F3hHx4LLn8fxTKeOo3obBzeCwMEpjvDTO+V5eI+tIh7qOfvrA0Im7WbW1XVadC8jJ64q4WM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1568
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10186 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112030084
X-Proofpoint-ORIG-GUID: bbLYFmu--wQ49yFfAxtacNrALuhGahEm
X-Proofpoint-GUID: bbLYFmu--wQ49yFfAxtacNrALuhGahEm
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

url:    https://github.com/0day-ci/linux/commits/Alexey-Gladkov/ucounts-Fix-rlimit-max-values-check/20211126-224059
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 136057256686de39cc3a07c2e39ef6bc43003ff6
config: i386-randconfig-m021-20211126 (https://download.01.org/0day-ci/archive/20211128/202111280022.ugxpiKpA-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
kernel/ucount.c:109 setup_userns_sysctls() error: buffer overflow 'ns->ucount_max' 10 <= 13

vim +109 kernel/ucount.c

dbec28460a89aa Eric W. Biederman 2016-07-30   98  bool setup_userns_sysctls(struct user_namespace *ns)
dbec28460a89aa Eric W. Biederman 2016-07-30   99  {
dbec28460a89aa Eric W. Biederman 2016-07-30  100  #ifdef CONFIG_SYSCTL
dbec28460a89aa Eric W. Biederman 2016-07-30  101  	struct ctl_table *tbl;
0f538e3e712a51 Jan Kara          2020-04-07  102  
0f538e3e712a51 Jan Kara          2020-04-07  103  	BUILD_BUG_ON(ARRAY_SIZE(user_table) != UCOUNT_COUNTS + 1);
dbec28460a89aa Eric W. Biederman 2016-07-30  104  	setup_sysctl_set(&ns->set, &set_root, set_is_seen);
f6b2db1a3e8d14 Eric W. Biederman 2016-08-08  105  	tbl = kmemdup(user_table, sizeof(user_table), GFP_KERNEL);
dbec28460a89aa Eric W. Biederman 2016-07-30  106  	if (tbl) {
25f9c0817c535a Eric W. Biederman 2016-08-08  107  		int i;
25f9c0817c535a Eric W. Biederman 2016-08-08  108  		for (i = 0; i < UCOUNT_COUNTS; i++) {
25f9c0817c535a Eric W. Biederman 2016-08-08 @109  			tbl[i].data = &ns->ucount_max[i];

The patch changes the size of ->ucount_max[] to MAX_PER_NAMESPACE_UCOUNTS
but this loop still goes up to UCOUNT_COUNTS.

25f9c0817c535a Eric W. Biederman 2016-08-08  110  		}
f6b2db1a3e8d14 Eric W. Biederman 2016-08-08  111  		ns->sysctls = __register_sysctl_table(&ns->set, "user", tbl);
dbec28460a89aa Eric W. Biederman 2016-07-30  112  	}
dbec28460a89aa Eric W. Biederman 2016-07-30  113  	if (!ns->sysctls) {
dbec28460a89aa Eric W. Biederman 2016-07-30  114  		kfree(tbl);
dbec28460a89aa Eric W. Biederman 2016-07-30  115  		retire_sysctl_set(&ns->set);
dbec28460a89aa Eric W. Biederman 2016-07-30  116  		return false;
dbec28460a89aa Eric W. Biederman 2016-07-30  117  	}
dbec28460a89aa Eric W. Biederman 2016-07-30  118  #endif
dbec28460a89aa Eric W. Biederman 2016-07-30  119  	return true;
dbec28460a89aa Eric W. Biederman 2016-07-30  120  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

