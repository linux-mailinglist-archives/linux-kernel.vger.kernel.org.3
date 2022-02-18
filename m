Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079A94BAEF6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 02:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiBRBCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 20:02:43 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiBRBCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 20:02:41 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30280256EFC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 17:02:24 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21HMNnJ1013831;
        Fri, 18 Feb 2022 01:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=GnH8TTmNK2icC8zZCP1+2K5ZwPMTxaf7Cvql3IPOHfk=;
 b=fvRg7D3yIhOGUBkN2xu6Z/6Lslqx7ainEwVHIDiEtu0JkiVsc1gG/j/jTetBl4rJ/ANI
 lXlfUS1MKN2N7cTWSy2ym9oVAnXMvXRxvqme2hNLycj8kFs7UPAl1/y8aO61rLELwccy
 EF29pbxdW0AUSSzcaeBZ3DxsVEgDE3DQG2k7Hml4kg2y9OfWlK19gtugiTSCIwVhh45B
 M1SxsCJdL/0EnTWHv5ZURHKxzO9lsyz1xf/BEHEsRzf/iw/2pzFdkax5/8TrBPU2DALL
 yp2A1Mqb6cF9AB5rqPv5MVPotaAW3/h9BTZWmxoWIwvBbzS/AmhtiRtZNUWFE8sVygI2 Gg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8nr97wxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 01:02:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21I10dmk118129;
        Fri, 18 Feb 2022 01:02:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by userp3020.oracle.com with ESMTP id 3e8n4wqgmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 01:02:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qlalp+itflzxHMMfl1QNIndfufh0Yp6MIpSWq6Yg8EwmI7or2OyEPv1iCYsCk/nF1ZXLy8fRq8tRs5RKGJkSVOxpGdLUveeZpuKP/6LO0sjRQg6q0wct53daPTsBccE8Y54glgasadfJYsJCroOkJZXsi82m9fRhkGI13P795wZuzK5q9bx9pgU06+mkWVDObS5urs85a+NMXsUnHhLkmrlhRbSuLHnIssx0Ld44OlaJ5QSQ7TcQsLfT1xzIiB3TjiQQ/nrwCKC63KW5lynk4gf7NP8lPS1sO0iCouuRT8H/AWZ7f4q7J+/1LA//8J+WhV99GYLyJ3LjrNFQk5/ZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnH8TTmNK2icC8zZCP1+2K5ZwPMTxaf7Cvql3IPOHfk=;
 b=DbP7Eklk7+RW/I4kIluY68jyZeC4wmRSVeo2WjkUFAGUi6pXLTsFoXk0qANJ4Jph06iai6nIU8q39K2zf2e1QH4KEZzCq2fDogCLkdh/cVpm/d7/hRU/Tg7FklRS6CWt+U3GER6Ouria2FINiONPshaofuzNENS9rVacMz3QHkSLB+zO2L7onMJifpoIDABHcKHBGwM+wJFXXo8zn++dsPMbJiaUeXsiPMkm7FBJTmBRQlQGKJCRo2Ijr45NrITUoL7tIGV6sw0WxHUpMPJvWU7fbtVtB0qb0YFgPcPTlNIixrEgL0TH2O5boXK7DBDZ1BwRJd5T2rYUVc9NlHEvpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnH8TTmNK2icC8zZCP1+2K5ZwPMTxaf7Cvql3IPOHfk=;
 b=K96nlLHMDs31E/s1uaVKzEIbZuLIioogkep2VlBexXqSaDIHdYXnZwORxTGxy2AHBomd9+MXQQ665y/vwnDNEAKeiwyaJtbSAQjFu6oG0WHlRz/Brcd8jmZE5c39ZTOXxowP/bNFmSJ6y2yhmNHb92kE/jQdw58a6zYDeVne/BQ=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MN2PR10MB3341.namprd10.prod.outlook.com (2603:10b6:208:12f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Fri, 18 Feb
 2022 01:02:17 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%7]) with mapi id 15.20.4995.015; Fri, 18 Feb 2022
 01:02:17 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     gregkh@linuxfoundation.org, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kernfs: remove redundant kernfs_rwsem declaration.
Date:   Fri, 18 Feb 2022 12:02:05 +1100
Message-Id: <20220218010205.717582-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::33) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e221941-e3a0-406c-03aa-08d9f27a4edb
X-MS-TrafficTypeDiagnostic: MN2PR10MB3341:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3341DA9B9197ED2309A9E165B0379@MN2PR10MB3341.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:85;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SkAdrsas66Oc9UOYkwkwD/+gCcEs4vK1uYRUQFkLZB4VUdC92qFnnytQpN3sIcZxPhDbhkeTmv3Qnw8epoFUFJIlXCyUW8uFchgNKk6abLs3am75/4D4kd6+Qie5sgOHe8l3cmDqL36ec3IiyH/1jjfxV5Mol4iKYYa6dDtf5SQh+ZMIu/FM85G0XOIZQ+2qkiE4GGL01vPjnoQIelLJAXZAKRd9dp3zeMu5IC91QqdUp3SSpzCJDj1P9Xe8NDrECRt9GgihgGvT4+31xlrhJXHrWLt6ggFiAFnxlOWRLbfDgWBV/C0DUA6uxvGrbIOTY26sieV8ezqHPuZXvmINUtxW9b4614Ci8dhHr8K/2NPT6oWBesV9i4xOINWHgi8FA9LMIiGcf+bkdL2TX/wewt/w8ASwZBWHUq/BwqdW4kITKAwSafX6o3LI4uq2Vlb1QvN8/tct1DSTGO4AQlTMwRNovLD/rzLMQL1cfZDqN+0bVO7WyiKbWXFO6jQ1tID1OoOqrVBXXd/llxKrFYmHaVnUyZCi4XAMpOutzJVRxOB2RpQTf4pjy5IH7CYE/U5RHeKUF3nQpl3+46K1OzYpU16QfASKPNlsjGWGZ6ogODAwxqY4v3ryv1Uc7w/cM0e78y3G76tTmD9pLSRIlaDZZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(83380400001)(2906002)(316002)(1076003)(86362001)(6486002)(36756003)(66556008)(66946007)(66476007)(508600001)(6512007)(2616005)(4744005)(103116003)(4326008)(38100700002)(52116002)(6506007)(6666004)(8936002)(5660300002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vHU9/qeido/qUDyhGXdBa9x/oZtE5b2RqdHZiEd84eLljfV5YeMeSeZTAlSd?=
 =?us-ascii?Q?GoVQMvVhfou4FZ3mjv6ZR/5ND5AV/IDa2Lko/0aiWlI40JakgMKtoCblCsg2?=
 =?us-ascii?Q?pCalH8FtU2epmYyaT+1t+6PREt/x+mSMtw2zHhKZCHwLsmnK6fDnoSiSNJGq?=
 =?us-ascii?Q?+8u8XE7kSFkXwYydk+DqNGuJ6kzHAQOEttF1tuQNAXhBIqXrFGwORY/liXG8?=
 =?us-ascii?Q?P8CR2V850Ka1rhTTM1WBcrtSLc2b3rJgfYq3irrbP6YwKs1fkJOBuXPvGqWA?=
 =?us-ascii?Q?XHYUeETimmmB3XH2ZhAofbCviK6R0nXdTUlWsoaLD7O4fSB/hsX7BbeHswIV?=
 =?us-ascii?Q?Je8sbuI/a3pFWS2Af3q77IR/OD9VJs2LhfF/FKdOccw/TLQNEveXhJ345jMY?=
 =?us-ascii?Q?j03x6ESPogMnIxUl4YumVF5B2U2eUUZZC7zEV4NMOIaxXeLbHrcGb8Zl14+U?=
 =?us-ascii?Q?9fa9EvpQxCBPaErGMUQfpzFMMKk5U/XZswbIHW44d8yL5wL4zopbaOBqstlf?=
 =?us-ascii?Q?KRWy2Rj8vGA9UkT1SvQBaD4iZ2jZ96Pm5zJkiwFlEBsnZnfzRrNWCI+nsqBA?=
 =?us-ascii?Q?EueBsP1g0+DgKt9Ja3wEOy+nTg6jyP6LKF8mSJiKpD52nWnj2tYtIhVebMmu?=
 =?us-ascii?Q?ZUx6s/gTdJDfQ3Wy5tbh6fzNa2npXSgYGEulUUJbXhkLyxB4Xev8oHUfXkIR?=
 =?us-ascii?Q?pBVT1Q89lvbDsxYVqhwsSNN4jMwgJTlWuxsnm/30l+ceh9yeVwEuwP338m41?=
 =?us-ascii?Q?JfYIA+Ye+wKYzVc6rNxzmpCAWKCQy25a+TqFNTDWJ5oIqBm5ZO1mHNuL1AGA?=
 =?us-ascii?Q?m9dMOQzxwyHa6AY4P4AsUaK07Ufjm7if8kQs+H69WIYue5ewWJxzNXVbjHoF?=
 =?us-ascii?Q?pP7gfUct/RevdQXiBGhYGXhlfyQkVGF0SJLHBW7zagJwqW95bBHFuKmsiydC?=
 =?us-ascii?Q?SNtz5Hf+aJISH6wTQ7UXBb/ZVk/sJTtkjgAvRedK0Agl2qoG76J7gT8JuPwx?=
 =?us-ascii?Q?HMEZWUcGBt8VLG4KpI9afqFyec8DY5u7HNbEPyVM3YfCMN6nYH1bSOMurPed?=
 =?us-ascii?Q?dXqprvjROcP2KLgJF0uiB2E26V/1CP1fO/h3Z8D+gHs2D2HP8OQWps1oaJN9?=
 =?us-ascii?Q?2sL75Kbt1OhOl5MAjv7D27n6hWugpwe+v2zv84PFsBdQx8V1tEhLZQwx0cmA?=
 =?us-ascii?Q?woitvEtAYNC0zauQEMRWMrY1WZbZk+TfzueZU2wHJIetSFiK6kmXeck65R2R?=
 =?us-ascii?Q?sdp3XuUGTWdr60ZIT63DR+7LsTfEsZhL7nnL8UmVbCqMNQxlg678caHPqzUi?=
 =?us-ascii?Q?xkJ5FNSdRR9IBTPes8FSQ/YrY0v4SBeKaXWHhyg9Wi6jxrYMfYZMrQ4qy+jS?=
 =?us-ascii?Q?ys5uqqljkYNVszqcBVa0NOKZ1EguNBUXwF2lwJ5R29UoSwOYbvCbhzv72CeT?=
 =?us-ascii?Q?4muWyXMzmPGN5gnkFe7rD7tl8ablEMjSWixluOUgGHTIkuCrSE2VWi2RMYlB?=
 =?us-ascii?Q?E5CEkcnmA5H3mqAJsKi+AbdNiQi5bKj/JUa42hMLoqmIzLUFVK9YRVjlQ6n1?=
 =?us-ascii?Q?PVkFnXd53QR8m8yCevsPVBnQMjNNNc2BGGXWXp6o27wqyb/yX3oEobC0bXVn?=
 =?us-ascii?Q?08jeqffUPHnz63wIfD/7UyKfcmg2iVBgHepbrSU/hRAD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e221941-e3a0-406c-03aa-08d9f27a4edb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 01:02:17.6293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uArRe2v3zJD7qbcCrUTigEHVxyzTASVY9zng6/YotCyqjCNMu198/djJdW4BxttdLvvwDXEEMj648eBCnnGPIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3341
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10261 signatures=677564
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180005
X-Proofpoint-GUID: 9yHgvdqvIJPhq3pqkZKRKY1OWzBbvTAM
X-Proofpoint-ORIG-GUID: 9yHgvdqvIJPhq3pqkZKRKY1OWzBbvTAM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 'commit 393c3714081a ("kernfs: switch global kernfs_rwsem lock to
per-fs lock")' per-fs kernfs_rwsem has replaced global kernfs_rwsem.
Remove redundant declaration of global kernfs_rwsem.

Fixes: 393c3714081a ("kernfs: switch global kernfs_rwsem lock to per-fs
lock")

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/kernfs-internal.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index f9cc912c31e1b..fc3b32f82a605 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -122,7 +122,6 @@ int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr);
 /*
  * dir.c
  */
-extern struct rw_semaphore kernfs_rwsem;
 extern const struct dentry_operations kernfs_dops;
 extern const struct file_operations kernfs_dir_fops;
 extern const struct inode_operations kernfs_dir_iops;

base-commit: 763a906a02e961eedabab7dbedd16904a3bd0184
-- 
2.30.2

