Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F68048D5F2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbiAMKnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:43:43 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:40750 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229675AbiAMKnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:43:41 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20D8SX8Y031740;
        Thu, 13 Jan 2022 10:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=PuBLW3DQ1dylqsjEn6T9PhS6urB7zyByrdrzFPmyg6s=;
 b=hBlE5UMB3n6Tl8GHyJujyD9B/yK3AOTFUN0EbBkEvFbmdkf8iQu7FneLRdgp0EvEp/AB
 rahxmL3orImzS4o0cqWlKMYvIgxk6dP11tARLacS1niOITeBVMfAJmbN7mdI+1v/2XHs
 O7M45tLC9yqNwlY98sW73MzAbClWRCZi4ki4/PCm0A2s2VZN6olVxyZCnIB9rBW+v9vo
 YFMXepvYmDIBaiI5oH48KDqifGZ/DlbvuQTHKTIg/eBi5B0xr+dX4OUxm+BPbIuBNan2
 tFEatUWiN3F5Nm6r+I8iY62eXkE4ZZYLkiHp+I2OBROMRUhY/Io3hv/V1PvfmURsKwgw MA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgmk9gsex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 10:43:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20DAgIFa098265;
        Thu, 13 Jan 2022 10:43:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by userp3030.oracle.com with ESMTP id 3deyr1hjdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 10:43:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Le0QpEf+FdEr6b6myKEXuJE/rEQUupv++DkUxKC/J8w9qjdUOicnBKoZJwqIwSxvEmIYCMO5ZXt9dQ2ZBUWOVopC0dZlQxvves1UHT70KRM9z3RZLdYQqPC5JoaF1KXA7mmzYAij5FoTU1Han72bfJkghmXJ9qu5ZDtdCQcJ+8BBAAQQFUItcupYafV70FtcqOwuZtTXepArGbpiMNued0FNmkUfnoOt1P4nWW25SKlqFar2WAJftRZXXi54HKRt7ptqgsU7PZwWHx256O7T+u2ymQms9hlSN4Lu3X7cqxQJZSZOGZhRGwwnd9czmRXkT9BbpKrGZjuruK0YvAQxSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuBLW3DQ1dylqsjEn6T9PhS6urB7zyByrdrzFPmyg6s=;
 b=EWQguUSApP0aoUJyER79VbV5c1iIMNOt8EmRfu1l0nA7legUnR/vwpOATRZ/BCu0iDjdpRqNVP0/VYWL+INGKsbb5H+7I3ZYFufKRPJIyIIF4wZj0cw/ddpnSMmykfLdhMDQ6WXPG/r6+RclrHq1Z5LlJf8phHOfmMUJU6s2OFRLDVAzBiRE2Jg/yVVmO0tn5kdM2Mxsc0NlcF6mi4tTr3ZCYF8rDhAja238i+qP7VI77WGUZ30jviqw2Gv3nt4WXRTzukLtTKRjF3/oPMpqikTDFbsfXoPBPLbEDzVVNT4vImaOpQhlXiQemuvrBd3+rttClpyhFWxmPYXXMqYcaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuBLW3DQ1dylqsjEn6T9PhS6urB7zyByrdrzFPmyg6s=;
 b=N+wL7vf91JEkpY5IqNHOvDDNhxNOV/27kgSB7QDgyuKHt8tbMniah9iTvaHl7LqKPbUOrBX8ZBRVR6XbAdcsdBrz+iuP6+Gs/jrOn0SgifsrrYuOE/K04msR9TI7NHaIXXVpqqaiXdp+U54LINrhQfeKYa520s6mBbA5YP3GoW4=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CY4PR10MB1751.namprd10.prod.outlook.com (2603:10b6:910:b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Thu, 13 Jan
 2022 10:43:34 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::183a:8dd0:6d9f:596f]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::183a:8dd0:6d9f:596f%4]) with mapi id 15.20.4888.010; Thu, 13 Jan 2022
 10:43:34 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] kernfs: use hashed mutex and spinlock in place of global ones
Date:   Thu, 13 Jan 2022 21:42:57 +1100
Message-Id: <20220113104259.1584491-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0083.ausprd01.prod.outlook.com
 (2603:10c6:10:3::23) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce1964c7-cf13-4eec-4b65-08d9d6818c2a
X-MS-TrafficTypeDiagnostic: CY4PR10MB1751:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB17516A36AB44BD332BCBE06DB0539@CY4PR10MB1751.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 23rIlNTz84QZAttBcVMYAsXKtmDhB71QgNnBgP9zINDdjxsu/EHmAnB/NeLtdJRaX4BmY2F8Mu37+B9AxCttJY9fvJpQfoViORgTD2zm13rXJSZuJFMVi5IfgGzdrmSpUdxPstXGh2WGnRFuL4Y5uLgB1BSi/lF1W7kt/jRsFBLdKdE37yoOj3bmaM0KxbJgIsFT7HaYb/CnwNxNcbgl59g/4PMKzUjhJwnX9zEx2+EVjlOShrv+BRWtrShPldBeTH8+FIyB0e5k9cIG0IcdcROyDqH5IFWHvrxW17zxN/3a/VFGmnuZ/EZ9UClIRDLpDZKBtfoQRX3i5gupS96Cz26HKIpQjTPSn/cVWPMoF8cRhvNQW6aRd39GvtFkKmw7bpSYhP0bnSLpuBBkiWRnRK5WKM6kJrhWPQ6O8qyTzEZOmlD4lqPZu8YrYWrtlLg9yRIFAG9zljYJxHWJEMnIajoaJJADUE5gTepl/jD0spA926HYm6dqSNnATm6PgncNZxcQaoQpoIcLIY3SMt0LhpWev3BHxshUlsN75QL2JZb/cky2yFsVBcI0hBzsW7WDYecW2E4dMv8rdIfuL2BuweYPUzs04p0BeKomDhzTVIrzDhTN/bPHOBBs6UC25VkZEp9yaXT//q0y/BW9rk4u0a6zwlHzrGilwph405JFmkTNhGrAUFdaLmMTs3bEx0dyPOKUpTXeqSNx4TcVuHmiTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(86362001)(2616005)(66946007)(38350700002)(38100700002)(1076003)(6666004)(26005)(8936002)(2906002)(5660300002)(36756003)(316002)(83380400001)(103116003)(6506007)(508600001)(6512007)(66556008)(4326008)(6486002)(66476007)(186003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cutr7YL5hyVKZVCzkrUzPsL/Ne1QAIOiq4rIQ1Frq5ZlFOXV74M3AfpLgnba?=
 =?us-ascii?Q?KzKJkCbV2pCuBm7NJoG/Qu0/RHVIzQWjZ6JAVVN6npDVFAglWV8mtR2oILmQ?=
 =?us-ascii?Q?QHyjopiY7rY8aGLjeXYS3CTW0Iehl+02U5pbbI63UFb5HoWhnDizeu3nm7nE?=
 =?us-ascii?Q?g3bysx2lBiHOhkzL0gJ+WABC2M2LTi+FyQd1Tb48lqGuv2tbva+7/ZrqstpE?=
 =?us-ascii?Q?DQhpcZ5sqRKlF1Q336ST8WJ4GI2+LjuNd4GQtl2lqTpC+QUXz+l8ZfQH2klN?=
 =?us-ascii?Q?SfdediaAK8ZpodoecQQ6RP2iR6QNobeAJ0ZSltA3P3aycZJTdAoOvVog5jJD?=
 =?us-ascii?Q?/35QY+p6jSwSgiyYU6NaUDKraAtPwOVpl35eJWfyVGFf4fAxaXFaUW70a8tB?=
 =?us-ascii?Q?OVUbCUg8cGeuFnHyl+wsUWn/WRlkGxfusagqMI/Bb8XyH+O1rZtdXLh0QwjI?=
 =?us-ascii?Q?3pHRfEqhCmCQ6E7oUfDmqT0lIupOecv8/oSVp7qSn5hQ9jYarF1/diQoWqg8?=
 =?us-ascii?Q?ZG1NAzkI7RxigKyLZP4tC9vkioYFP+Vuv4fL0Uoyq9bgq7UKv1xhWb37ioQ8?=
 =?us-ascii?Q?zNPWfoxQhmF7y/FLy4ICmqZI/KGkutE8olS11nszxt/nQaDaVXuBAEffLb/2?=
 =?us-ascii?Q?Y2pLc5HX6M8bh/8SbSEMGWWkb230Ue8u3mftBqi2ZyR8GzgW17VdVDHvx5iL?=
 =?us-ascii?Q?/lrZDzDX3l2AoQ835pMXhZkdjRNuIBNj3VmZHhgcWDZ5MbKUpuV9guHqOTqm?=
 =?us-ascii?Q?QJZWFqGhnFk1sfXt+K58JeweWRCqpYo4B4qLYAolu1qV8o+rux8VvcQxPyXd?=
 =?us-ascii?Q?pfM4j4pN2+NLFT/Ofwds0JjC+quATvgOFTHtwpgUkfGeBAcPZa+9JlTwL9I2?=
 =?us-ascii?Q?nrzcmrlsZYHhV9XOh/Hm94dOzXQmrjxWMyqPspVuv+9a/CRJ4tORdOgDWoNZ?=
 =?us-ascii?Q?xPlfuGdSe26beCHFM+dYr2J++kVAINIeHRJV/gS4Bc0shTxVjE7oEg99jNmo?=
 =?us-ascii?Q?sVCkui8wJ0kE6t/EDAzjtiEKUYFdIahmydGQJJ+K1dOTx6OVLSQnHwQKDVcd?=
 =?us-ascii?Q?xob8U8Yv7bGeuVSCZhxIY9wju5/h4Ua97Uqvq3U1qv3cvcgAl2DDn9rOA8oo?=
 =?us-ascii?Q?1zDFPzDYKlXI9d1aEFeW8Q+BuNcMkEWFHLLZvJStAQ5/ja+L+AQfvYFSaYgc?=
 =?us-ascii?Q?6mN9gZ00p7nwHiZ4IqPNp+KRJ3X1CA16QIQdOQ+Wg/gWVHTMwpSzZL4SSNWh?=
 =?us-ascii?Q?QF7NPwWVKdkBamZzxYCNa57k7KCMoavcCZCfrGYAxnWfLeq9m45RFN42JPy+?=
 =?us-ascii?Q?nDAXMbe8fUq6L4sgWPt8vcn7zhKmOdUe5TFDjaY+Ekxd//7hZsuz9sdWL3AE?=
 =?us-ascii?Q?/O3ri+INuHvl0N31usEw+rs8edLA5Zg7kk3vI5rzSdH6MmZohaUoaVCJro0m?=
 =?us-ascii?Q?/JlngYEiM+MUF/FntLmEDq8GgWWyqM4xWh3R48MboEdStootYCtxjCk3l8g1?=
 =?us-ascii?Q?i/Mr6F37dQxO9dXDiv+UkgsWSSqWFVk7g0opgjP1vOYq6WGoETeJyDOmO+jc?=
 =?us-ascii?Q?xUSE7p1ATqJGlRrE8Z8qNBAMB2XIsnTd/2vPD6Ffk73VgjqrytBQbLcQXbPd?=
 =?us-ascii?Q?kS7G9OqUGTD1W3WshK+PXj8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1964c7-cf13-4eec-4b65-08d9d6818c2a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 10:43:34.1894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SH2iBQ/FJemeIc+qaTrRcFdC+bbCzjhRAmoYbjrFDFaB7CWnDoobAIyXzIj8eG5qMQCiP1feseVrJ52woWIl/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1751
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10225 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=490 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201130063
X-Proofpoint-GUID: mNs2jiSSQm7BST3XrkYs-b7_00fJmQC3
X-Proofpoint-ORIG-GUID: mNs2jiSSQm7BST3XrkYs-b7_00fJmQC3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce contention around global locks used in kernfs.

PATCH-1: Make global kernfs_open_file_mutex and kernfs_open_node_lock
	 hashed locks, where address of a kernfs_node acts as hash key.
	 This results in kernfs_node objects, whose address give the
	 different hash value, using different kernfs_open_file_mutex
	 and kernfs_open_node_lock rather than all kernfs_node objects
	 using the same kernfs_open_file_mutex and kernfs_open_node_lock
	 as was the case earlier.

PATCH-2: Use a hashed rw_semaphore to access permissions, so that we can
	 avoid contention around global per-fs rw_semaphore, seen if
	 multiple applications are executing inode_permission and
	 walk_component in parallel when trying to open sysfs file(s).

------------------------------------------------------------------

Changes since v2:
 - Remove RFC tag
 - Use hashed locks rather than using per kernfs_node specific lock
   (Suggested by Tejun Heo <tj@kernel.org>)
   

Imran Khan (2):
  kernfs: use hashed mutex and spinlock in place of global ones.
  kernfs: Reduce contention around global per-fs kernfs_rwsem.

 fs/kernfs/dir.c             |  8 +++++
 fs/kernfs/file.c            | 65 ++++++++++++++++-----------------
 fs/kernfs/inode.c           | 35 ++++++++++++------
 fs/kernfs/kernfs-internal.h | 71 +++++++++++++++++++++++++++++++++++++
 fs/kernfs/mount.c           | 11 ++++++
 5 files changed, 146 insertions(+), 44 deletions(-)


base-commit: a70bf4a85b43cb952bd39dd948b103b1b3eb2cf8
-- 
2.30.2

