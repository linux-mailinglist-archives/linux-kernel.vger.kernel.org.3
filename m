Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424F54BC393
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 01:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240434AbiBSAo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 19:44:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236378AbiBSAoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:44:25 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4733C1FFCA1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:44:07 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IMJaRH014492;
        Sat, 19 Feb 2022 00:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=tGXEvL3QP41l163hsMTB+M/txIyoPe7N/F7oB8bqCOI=;
 b=hBQ4dbD5p1tRFy3siuPNO2NArtGblPiKi8XQS7Ih2ZC4exTmjCnTmCHnsd5THtO1h2v9
 KKfJf6NEOB6G+WBw+AUQR9AYlOMkUasCNCSIU2TLCrSuGe6XSKJv55NcHEY5eAlYu79F
 Iv7vYmpwV+sPEJq12FzM8wZI8bQH2/6CvxqxYjgnkxb9CUqX8OXZyWI3DAQP77WHwQdd
 lgO5wJ8gUJjIMjiPS/1j8rcrfG8FuCNayXzvE9pO98/vlT9mAmXljpg69fkI6NSQSp92
 xDeh7BYAWk3F3Od+pKK86gUOvYUNbwHBqp/QRu4BIscupkjAixZGCu5ywqYk0VdIAhbI ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8n3e33nu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Feb 2022 00:43:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21J0anEc027719;
        Sat, 19 Feb 2022 00:43:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by aserp3030.oracle.com with ESMTP id 3e9breg59f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Feb 2022 00:43:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQkXBBfi7KN+b2+fQ0BGERXdAkDjIHPNTiry6j6K28VBz8uEBU3YQUe7R39a1fj6mz3qIo+JLGnTl6hqo9PP0ucRfa/y2uMaSMmfx1bhohgF8X7VeYvm/eMBj009jTcAq8PbVV/3+2twDu5NnpsSoNnNBDWSAv6YRWfySJ8DHrbUDBdgZn3puQZRfjrC+pvMIMgxV/PDs8UmKkbHL+otinAMu4p5d04v0oXngnqv2ClVVpWmcjujRBBIQG7dAh8P2j826+LosOeI2Fq8v4KCkwiE16ZpyGHUZAoWCd0A15eed9rPBwmgOpXzf4SS7gCP5Iq/25032zr2qvWkiVqg+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGXEvL3QP41l163hsMTB+M/txIyoPe7N/F7oB8bqCOI=;
 b=iOUykN4ob/hGWWrO+56Y0mlrU5ZISdOO1YoPD/Y2nfU3TNbbR1y9mj5ap/0VozA18cGj6rwE3QchH87U7q1W7FiQcZ2+K5RRoVCpoVJLAtkaS++3slzYU8M/06ny244vbCtrZDbslze2czL0NRoSTIcDw0WteOcpSSS7cc6NqiVlI4H+gmECGpZ2cGoxKly5pUy5KPukVbTzJYIQFRro3M0FRPQscGxhvlNHm9COLwOC4MjiKPedvzTTIZFVZfCxgWFGwqOdTskRc41U6zaPSJTfJgvsvWspvZEDoAaOe8Avp3r4HT0UqYW1ivA25DkiwKxU7ETxHo68NCMpY3f39A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGXEvL3QP41l163hsMTB+M/txIyoPe7N/F7oB8bqCOI=;
 b=eoG4Yb6Nza7uT/eACBRRnT6KO/zga7hI4Gc+ZzFJdNfHQ0A6bH7CSfHzjl8Srg76URpc9NSYnWrP/7lM9ADmIb0VX0V9J7qTxMLNki98lBYhIZSS63AslVY93QHW6R/wgkXSVhxnMEzoX5ZszRv7nhXEi0m4l6lMoqP0gZBH+b0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5662.namprd10.prod.outlook.com (2603:10b6:a03:3da::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sat, 19 Feb
 2022 00:43:55 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1%5]) with mapi id 15.20.4995.024; Sat, 19 Feb 2022
 00:43:55 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] selftests/memfd: clean up mapping in mfd_fail_write
Date:   Fri, 18 Feb 2022 16:43:40 -0800
Message-Id: <20220219004340.56478-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CO2PR04CA0186.namprd04.prod.outlook.com
 (2603:10b6:104:5::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c145bf8-2eb0-40a7-fe5a-08d9f340e888
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5662:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB56627CAC852FCD85E8E4E2A7E2389@SJ0PR10MB5662.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9e/vSJUCuoJTl8gl2nAxBRGNoBSA6ac9rYE1s7UFaniUVtm/Mc0HcOWurhIR0yTySdXqps68MJTbDmh0ifQ9DSQfwEiQc19iP0l2Mxuwb9qcRic5jmWGWV+Em0gxD5alVgEi5FfUB9tHrZNy8j2D0isG7Gws9sOsUHlm/OxjqtGhbuTdLDpbui2rxfCBKZM5fyKWYgRjUX+xv22NehvDpvwN8m4PONVGTExtBIX+xugjBVEGDIj1QEJ1EGibEAUuOefX1a6yrzlIQ7d/pqX3p0UIQ1MIVkj6sWhb7QHVwUkhNgaT2tcFLe/AOGck0xP+9GZCcxesx1PiTTcDD6kF0ZBAhbU0LTLKCN+ZUvuGzWt96qvgnz3Li3isA3A8dT6l9L3E1vY9x6DW9O5EIdo+uJDugKElTzUn8K3HoidofEhqAYtcOZCbZXoU1QBssUBERhHp9oEbFab9btlciL905IOWtL5aSNmN7vv2QNofukXdC9yZdczUHnwGZx++LFcM8yYxuxukHxFuLO7VEIvfuwbyzLTujYSOQbJP912GUilm9AjkiltJ450+/XzYafWlKIThu9PaDmvdUDZxCb7nppfuSopEiGMdUGlu4VjqRaEWRGbKe0k0h+ItdE3fOuoneUfPU44fCTqgE7YyoUixe35j7b98Gpld9a937ToNw2p3NrNJgJ3EU/psk4ztFYpbhrFWbYK8EPhIX1CqvLiCcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(316002)(44832011)(1076003)(52116002)(2906002)(38350700002)(66476007)(38100700002)(36756003)(8936002)(54906003)(4326008)(5660300002)(66556008)(6666004)(66946007)(6486002)(508600001)(26005)(186003)(83380400001)(107886003)(6512007)(8676002)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LfrZEUVy154hHadGvuwmilN9DvxudSn7lEpobE9XUB4HP3+F2JNeCoAnzv5W?=
 =?us-ascii?Q?3EU7Riqm2qZWSr3U2TXARDwf2ABH69b1k43lj0BsTKzYagC0118W+IK7pKxd?=
 =?us-ascii?Q?wps1+4g3uGgaR2Djgx0/GD29tCU/IUt7aXaXzMaiEAisESQz4S6qWe7mzDMb?=
 =?us-ascii?Q?8D7tlj++z54WOorA51zZxjBEfEfg1peMCx/aK2ZneVnimnxcwpe9ipQIIA8t?=
 =?us-ascii?Q?Z1CJpgba7G1SiO7enSh9HOSr8A5Y1RDPY8uhFBslfysDN+LUynFzxsqErS1+?=
 =?us-ascii?Q?3CW7AUB2+WtChEFT0wFoATici48cWAO1/MPQu0n+DheN0x6IJogKKRpc3msl?=
 =?us-ascii?Q?D8Pldhk/ShO61slyH726EW17ijbLBHPSWhExW96+zo2Z6CtCQwkJmMh7iAoV?=
 =?us-ascii?Q?0KF7vSOYazzfvHXlKOdotpeIqqfl0SUmrGL2ZrhTrAbQtoVnJMJyzqTPh5Rl?=
 =?us-ascii?Q?RGM7tzfWTWAEzzbg5KCgI3I6ETTyV4TOx8hUbY06WCpvLwHYQAVLbQEvxBbG?=
 =?us-ascii?Q?T157DnRGw9PXmTev5HWtGETj3Q7/v6M/fWBhUebYym7gI6HdDhuv+So/5uc/?=
 =?us-ascii?Q?i98/FImhIUWeWHxPMHG+rToDP1zC0H8XjA9U6JOLnVJv/A7XoYk914QFUFAQ?=
 =?us-ascii?Q?NoyTBX7AgFozjHyH5VvoLmirDq9VkEgKjICbDQ24BajZFvLbVKYoLnG4wxWe?=
 =?us-ascii?Q?m+BLkvuMUrXgtiJucPY9UZpxO12mzmc/DBSuTFtE4UOA3mZxnlTf3rrXiWmX?=
 =?us-ascii?Q?MOuS0EZL+4seWrQN7/5fBWNZz+1ddQq5nB59jGb8/5jMHGC7GRoc7Yv2Gv1A?=
 =?us-ascii?Q?HjrK+kzDtqj+T9mpZbhodJmXsS1YEi76dGG8qjsUHIMAvsM7AXn1+t/9EUpN?=
 =?us-ascii?Q?pXwhmtT9NMg4UP/rW4rzAo5GNqms/HTy91Z7qb02GX7Y+QTEZ/PEcPNCy1aB?=
 =?us-ascii?Q?2KPPd5jfjE0IatzlAMsMSCjqeOHP4adr4W8UChWG1OxIFMAzq4NW8cgFjhrx?=
 =?us-ascii?Q?SLkPla115WWrxZAMUAbZESDDjBtFUmUMkX258YGpVnfadTxzCMBjiu5YO1ua?=
 =?us-ascii?Q?KzH3rvEK5Psz5TOXy1/TGebJRQPDYzJgA5+Z65f0trXrDeBJc8WZtfW2v7zM?=
 =?us-ascii?Q?tnVY0cOH+6jnmYmr92E9T9+nthTK8Ka6dEsrrQp+CHzG6OUMvTqGFOtFKtGZ?=
 =?us-ascii?Q?6BSowAoeK3xXpph/P4vkasWIeJhiOn722pG2m8XsrIG7A7H/WVw4RxdsKBuk?=
 =?us-ascii?Q?QL8g9nepMAxGU8TgEwpJlL3rPmy/YMkkZfGpBT3MhkE0OMR+hXK1Lpm0mZEn?=
 =?us-ascii?Q?hyF4ZmC4hzdPkVHy3c8XaOJHcthewj8Cv51oQzY5sLvTMvuuRPODlFz2oab+?=
 =?us-ascii?Q?W/Xsijc3+AYi2wzl2lFzltuW8lqPWhvB9zxOo125XyaMBbNx7qKLHDh8Tsbz?=
 =?us-ascii?Q?NNIBJSjLglruhiChcndnKEa+Y0WdwyoSKsojIt/UFPlIqgNI0V3GRKdFBGUL?=
 =?us-ascii?Q?64XgQxxlnFs8AyKbCXk1mtqU3DfYUhS2KIZdqEZgSTjiDs7O2O9oEjJwgC9U?=
 =?us-ascii?Q?aLnliIKDvkZuPcpWJMb7nSKAd3Heuykv98LRdXeyapfFUjGkRsK4FTEqOgnC?=
 =?us-ascii?Q?DC5LKrvAivPl7NPCBuJ6+IQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c145bf8-2eb0-40a7-fe5a-08d9f340e888
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2022 00:43:55.5790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7rA7R25Y9HjrWsXRDOshQ1atbPxAgPsO6LkfPrhnH4SrK8ZYM0voDe6dL+dulNIDDbAgqJcDm6MojX36haYgug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5662
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10262 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202190001
X-Proofpoint-ORIG-GUID: dqri6GLgFNNkIl0goRyJg8xhHgvD0h8d
X-Proofpoint-GUID: dqri6GLgFNNkIl0goRyJg8xhHgvD0h8d
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running the memfd script ./run_hugetlbfs_test.sh will often end in error
as follows:

memfd-hugetlb: CREATE
memfd-hugetlb: BASIC
memfd-hugetlb: SEAL-WRITE
memfd-hugetlb: SEAL-FUTURE-WRITE
memfd-hugetlb: SEAL-SHRINK
fallocate(ALLOC) failed: No space left on device
./run_hugetlbfs_test.sh: line 60: 166855 Aborted                 (core dumped) ./memfd_test hugetlbfs
opening: ./mnt/memfd
fuse: DONE

If no hugetlb pages have been preallocated, run_hugetlbfs_test.sh will
allocate 'just enough' pages to run the test.  In the SEAL-FUTURE-WRITE
test the mfd_fail_write routine maps the file, but does not unmap.  As a
result, two hugetlb pages remain reserved for the mapping.  When the
fallocate call in the SEAL-SHRINK test attempts allocate all hugetlb
pages, it is short by the two reserved pages.

Fix by making sure to unmap in mfd_fail_write.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 tools/testing/selftests/memfd/memfd_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 192a2899bae8..94df2692e6e4 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -455,6 +455,7 @@ static void mfd_fail_write(int fd)
 			printf("mmap()+mprotect() didn't fail as expected\n");
 			abort();
 		}
+		munmap(p, mfd_def_size);
 	}
 
 	/* verify PUNCH_HOLE fails */
-- 
2.34.1

