Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC904C91F2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbiCARkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236577AbiCARk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:40:27 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208072E6BC;
        Tue,  1 Mar 2022 09:39:46 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221GanMt030718;
        Tue, 1 Mar 2022 17:39:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=TITRB1aPkAbT8oW7Zmx8pVIhc1z9aC1GC5o2A/kMoAw=;
 b=INipUm+7AJs2O6dPKNNXmW/HYi3RODN0xOkvc+rs2mVD2Bp6ThBqJlg5Ol27F9/SHfw6
 KCGCtaFl+jfKfBudqlsdtTVqyDA+gg9JpQMxEixJhWJn3Y872Qlp2N55WJiak392QIuD
 LFq5UsS0SWpM4mtruQc4nsglxv/w5KQwRtlfZPp7eBF28QasjdbkueW8QL8Qp20TUzo5
 P6udY3cdfs2VVWZXbYixaX+figWJ9LWqgA8spY1m1LktnUrbuEhydBLCjJ2V01quL85k
 FtEiLpJPXUdOZR1nkU8z3fqhHo/6WCqh4h/atf2ZGthHYp0TGnhwmMD10lcPPzEm5ler XA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh14bukre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 17:39:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 221HaGli075131;
        Tue, 1 Mar 2022 17:39:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3030.oracle.com with ESMTP id 3ef9axv7hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 17:39:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Shxmnxgb+OsnGCJz9xD9+JHcM6sjxbgw3liV+FPkvsQj+e17FhkH0zaBYo0KuRrGXM2Ua+Xwg8JzzZV6GibhilMcbZM+rMikx4SPFDhE1rENuDDKsrtXjCyR6j7Zu5dSoIXm45mKz/PBC8adMvCmtR2uKN/0AnwJQhoYMU57q63Ul+J7hAr+uHfoHT7jP9Y4sAVoWOo20m0K351VgBWAhOUZQgzs3ia2PDCJcqooQzV/9y0FfyDXWHj8FfWlZzd5kV5eKH5X0Q2jhKIVXKX006YPm+CBEtvY9HDEhfAU7kvJGZdXYa+EIwEuQY9S77/WgENowIC4pyMFO4e9TkHPJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TITRB1aPkAbT8oW7Zmx8pVIhc1z9aC1GC5o2A/kMoAw=;
 b=aaHMYj7OeGHexTLnB8neIPh/7TD0Fpp7Y7GDfCOirOjFB3HL9rNhRT8R5Bf1HNW2wPHzdR5tMHoFQfhQpLwhsbwLYcJ4gciGcL1f3bKftXKdvLZISY5fX64aD8DroctvrLoAznmLvGZi9uLArxZ7dJpUrxA4QUxoxv5IFPDd70hu9Jp2ELL512QcP352fO9IXrVrrLe+nnbtguVLVUc4ZjPgUneyt/NV6YaBVMzh8ozWGNbJZHbfFYdawBkQQVacfOcwSZmv43DE+GUYJ7R7SI/C3pFxNQ2riSgfFmZ/84ywnYBlHELSvtn8wX2Flat7NnhFPn9X8TS59IxYRslwVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TITRB1aPkAbT8oW7Zmx8pVIhc1z9aC1GC5o2A/kMoAw=;
 b=XePyFGC9lsFj9Ql3M3EO/8UTpoQPcVogKXOw3hFy06p1l1vsn9GBqjiOuA8Ezz1T6fPjx0axsSAQWCoKSK2XtJEQj/TkFC9HXAwCe4vtn8WWC8rGH807eDqfd5YDWnTKyXMNvfAmllNW56D6q0IY5XLUOTqU+e6i2Mjp/OMbBZs=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DM6PR10MB2795.namprd10.prod.outlook.com (2603:10b6:5:70::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Tue, 1 Mar
 2022 17:39:09 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::49ae:9ccb:2e59:8150]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::49ae:9ccb:2e59:8150%4]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 17:39:09 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     zohar@linux.ibm.com, jarkko@kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        jmorris@namei.org, serge@hallyn.com, eric.snowberg@oracle.com,
        stefanb@linux.ibm.com, nayna@linux.ibm.com,
        mic@linux.microsoft.com, konrad.wilk@oracle.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH 4/4] integrity: CA enforcement in machine keyring
Date:   Tue,  1 Mar 2022 12:36:51 -0500
Message-Id: <20220301173651.3435350-5-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220301173651.3435350-1-eric.snowberg@oracle.com>
References: <20220301173651.3435350-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0194.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::19) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4976faac-0623-4b24-3fac-08d9fbaa6430
X-MS-TrafficTypeDiagnostic: DM6PR10MB2795:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB2795D5BA1097A9E09F18B8FE87029@DM6PR10MB2795.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p3jnFQUOSE6D1IzK4kZq5xvCOUdoYwQribauWMeGW/uOIyy5PighXmkGzcjee/KXmKTqu4m+Klq9hcLSFe4axvZwDUupdqtiO3PRQdGNKCyzkVxPy9ODLZV3TSWFdC1jWJTBuOY3UwLH92+1qyfcj8lYVb0EGzw65wk5udLvG06ISvycWDdG6gJgCEw9ycKr5mbnvkGTssMifFGNp4aJ6dE2gpMTJkxwLVO+HM3bQqQw1CizAA543D/a77NJRiX1czjXxsAtyPgJTN8K6j9VXfyXnCdZD3nNiy2/C2PimXse9Vv5j4MbhHE5e7c7RoCT+83NU71l9cyS1TBbp0wxKuxEbQtPONtGR0XK13mKy1Z+xBSyGqUppYSjl2aWEByD1pstPNroOYq+JNlYV8AGSAPTzqjnm8YmnVfQpPiGcsLQQAnammqdgET2r/xOA+04IpE8dgAculw6LNLf0WDJiHjJYjg3siQLZohcW3qFMneGVQP+2J4BYq7shHAKyFhbMmIMiSrPdz6fEP+YHn+OL0pawOaCjDENmnnuC49MK7+wyyZeTf0YgztQIKxnTrXQeAi1kCKjVjFvI1MaThIX0zkDwyaahk80txAQJ4TPf7ofO2Eiog9lRIzM9sDXdC6QUGnZZSxlZMwxyO+ZnQaahOCMBNckukEl2grOVNymkEuMTYgaBrICxq0SemzhqInIrgPbzecZXCs1z+MN4ifjsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(6512007)(6666004)(6506007)(52116002)(508600001)(2616005)(36756003)(86362001)(316002)(26005)(66946007)(4326008)(66476007)(66556008)(8676002)(186003)(44832011)(8936002)(6486002)(5660300002)(38350700002)(38100700002)(2906002)(7416002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bx/Q8vjnlRvuPx5WOCzPkzcQQSLLtyGpBzhNn4ybRIzdAshiIEfjvLw9dXRn?=
 =?us-ascii?Q?2GXi3kJZfNOSP5LXXERh81IN/3vw1QERh6efhMVF9TAbJIkselmuNKl6YdZB?=
 =?us-ascii?Q?pXru1HsFY1HzALlN5cfoUpb7m2V6qLHUsMFliWIuiVxcS04WTZ2SjQ5bsyZp?=
 =?us-ascii?Q?FEDhGoyEZGUr40vHib6aHvcOEJ2/fCy+03levoIfd0W3S2FRpMfVZ89NyQUH?=
 =?us-ascii?Q?NY013u+TVyBeuCM1OHikCNsZWKAwKyn2+X2wI1IKv1Gmf7o6fm2LBB7mGGKL?=
 =?us-ascii?Q?J7dGiWg5Ir+m4br3T6Iws6oiDgliqUoAO02vXohM369mEp0lfbKx50TSQmwG?=
 =?us-ascii?Q?Y9jAkjW5QQuiTobjyE2Qj/Jigmch9VYoTl6cFOINQ5svB4iHVt5s9KcfHkSH?=
 =?us-ascii?Q?9kdvjh9aDWMVD4I48ouL+n1hgu0nhWnUevL9wzau/ikGwUM/QAhw1pV6LWg7?=
 =?us-ascii?Q?hgP6dt3hfOWFyQN1JtucJxudQdrrcKNSNYOVGk3GWyfOo4YOv4TbBGtqlBlk?=
 =?us-ascii?Q?TPB8MEFdABTj9QX8wXNDhAA6e1Mdm68PlJhJ9N2DD4soTeHuH1OEqNMLEyd/?=
 =?us-ascii?Q?y2GbzOVLkOmoo0MN2BKYVnTngIZAGnNog4tKXarAOW0Bn229tirLYtinZ4xd?=
 =?us-ascii?Q?RF5tqJuKP0sXtlCElk6eotm6fuB8NNkyM/Nj+K6K42emgeKXsMn1JNVSY0kU?=
 =?us-ascii?Q?ybDSVh3GtRLVU12Z+XuadweBYk2r1PZY0n6qFazCMmm5rT7P2z3lVcCNsZCa?=
 =?us-ascii?Q?leV67pl7jj6wcozZAcsMBClnooc+9EUYb+tEMbFTWVBlvl99+FamBaKhs+dG?=
 =?us-ascii?Q?xZIl+CjMzDBNRUwb5lvqP4B+RXH9q7XSIfuWzWsGJTDep++ZF1Hq+0iD1GIG?=
 =?us-ascii?Q?P57VGgU+J9VQP7bZSg7g5Q9I9N7a3sb20mUfUSFE+9iBsBKhkuZG/xPgPGle?=
 =?us-ascii?Q?JokkD0MVwKZPN1yAF2Vsaq5us9qHQ0QmmiSqvjxeX3bXP6YxZYVaQ6L3uXRd?=
 =?us-ascii?Q?QHfufD64e09CgTZ0wBagO3RpJgqf5I8D/e21Z6XE3UqXDPgRPuEC/BMIZRpX?=
 =?us-ascii?Q?7yJdgax5fkBxw4BZC3YKrYwpY2T6c4ApoXNCL4O91ld8W3Xwu5nX/sxrT/bt?=
 =?us-ascii?Q?X9lMkPDCD37DDLvJsxQV5yuK06ZUZNV4AU8xL95A480f94cJJyHBUJNPhTnU?=
 =?us-ascii?Q?PWN5XMWvpRp5eLN80PFGGi0hhpPYiCXxpvhkyjFMuzY9S4saak/h7MdAMCMR?=
 =?us-ascii?Q?fwLZgwT3PVF15aMN+hoFc6Y3qe7KPXz/d0wfmwtr8vR2Y3iUgkEa/kLhGnwQ?=
 =?us-ascii?Q?ANK7QWZsYSpXo4pArreaXMISvixXYqdurugY1grW1jOXBa7+s8bMxupT96LV?=
 =?us-ascii?Q?eVIkPUwnTR9gSuGjNPP9DbB0Gk+a9NmI8pLmclyPy/3tn2Oav/ED5QnFXnB6?=
 =?us-ascii?Q?yJIl6Ti8SvPecwdf00HG05NPmqEvaKtzvDvhChevsI+Alcww69RW3jTILCTY?=
 =?us-ascii?Q?FhLEZ4EoM8XY8RD/cScNShumotGg/pDhr0+xt1uyvpzD30EnGHLjZ9YR2lpZ?=
 =?us-ascii?Q?MsbqiIYH88aA+eBpvDJoZC6436/S9gSJ31Fe9kT3GDmN6yvKb77YYwSZSU+5?=
 =?us-ascii?Q?yN3HQYNPr1V5VGjqmfwlZ3FZrV3Irsx8FePExYKGZgtKPvgEy1YBoB207Cdr?=
 =?us-ascii?Q?XuMAzH/2nYMbF6qYmBA0Te7azrw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4976faac-0623-4b24-3fac-08d9fbaa6430
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 17:39:09.6980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPA4rIq/9I4XN3n2zXcfALBxRDtViIOnhuiYYtFq7AzgbwptmZ3xRbd7GofHtGbvbyUnJgz18KK9guUXDJ5Zm4iM/lm/XVGdF+C7T6YeWk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2795
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10273 signatures=685966
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203010091
X-Proofpoint-GUID: wQhYRWLiBi3U2pplMMepdnvZCx4Up2X5
X-Proofpoint-ORIG-GUID: wQhYRWLiBi3U2pplMMepdnvZCx4Up2X5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When INTEGRITY_MACHINE_KEYRING is set, all Machine Owner Keys (MOK)
are loaded into the machine keyring.  Add a new
INTEGRITY_MACHINE_KEYRING_CA_ENFORCED option where only MOK CA keys are
added.  

Set the restriction check to restrict_link_by_ca.  This will only allow 
CA keys into the machine keyring. Unlike when INTEGRITY_MACHINE_KEYRING
is enabled, IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY may
also be enabled, allowing IMA to use keys in the machine keyring as
another trust anchor.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 certs/system_keyring.c                        |  9 +++++---
 include/keys/system_keyring.h                 |  3 ++-
 security/integrity/Kconfig                    | 21 +++++++++++++++++++
 security/integrity/Makefile                   |  1 +
 security/integrity/digsig.c                   | 14 ++++++++++---
 security/integrity/integrity.h                |  3 ++-
 .../platform_certs/keyring_handler.c          |  4 +++-
 7 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 05b66ce9d1c9..0811b44cf3bf 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -22,7 +22,8 @@ static struct key *builtin_trusted_keys;
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
 static struct key *secondary_trusted_keys;
 #endif
-#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
+#if defined(CONFIG_INTEGRITY_MACHINE_KEYRING) || \
+    defined(CONFIG_INTEGRITY_MACHINE_KEYRING_CA_ENFORCED)
 static struct key *machine_trusted_keys;
 #endif
 #ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
@@ -89,7 +90,8 @@ static __init struct key_restriction *get_builtin_and_secondary_restriction(void
 	if (!restriction)
 		panic("Can't allocate secondary trusted keyring restriction\n");
 
-	if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING))
+	if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) ||
+	    IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING_CA_ENFORCED))
 		restriction->check = restrict_link_by_builtin_secondary_and_machine;
 	else
 		restriction->check = restrict_link_by_builtin_and_secondary_trusted;
@@ -97,7 +99,8 @@ static __init struct key_restriction *get_builtin_and_secondary_restriction(void
 	return restriction;
 }
 #endif
-#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
+#if defined(CONFIG_INTEGRITY_MACHINE_KEYRING) || \
+    defined(CONFIG_INTEGRITY_MACHINE_KEYRING_CA_ENFORCED)
 void __init set_machine_trusted_keys(struct key *keyring)
 {
 	machine_trusted_keys = keyring;
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 91e080efb918..e4a6574bbcb6 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -45,7 +45,8 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
 #define restrict_link_by_builtin_and_secondary_trusted restrict_link_by_builtin_trusted
 #endif
 
-#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
+#if defined(CONFIG_INTEGRITY_MACHINE_KEYRING) || \
+    defined(CONFIG_INTEGRITY_MACHINE_KEYRING_CA_ENFORCED)
 extern int restrict_link_by_builtin_secondary_and_machine(
 	struct key *dest_keyring,
 	const struct key_type *type,
diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index 599429f99f99..14c927eea5ee 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -62,6 +62,14 @@ config INTEGRITY_PLATFORM_KEYRING
          provided by the platform for verifying the kexec'ed kerned image
          and, possibly, the initramfs signature.
 
+
+choice
+	prompt "Machine keyring"
+	default INTEGRITY_MACHINE_NONE
+
+config INTEGRITY_MACHINE_NONE
+	bool "Do not enable the Machine Owner Keyring"
+
 config INTEGRITY_MACHINE_KEYRING
 	bool "Provide a keyring to which Machine Owner Keys may be added"
 	depends on SECONDARY_TRUSTED_KEYRING
@@ -75,6 +83,19 @@ config INTEGRITY_MACHINE_KEYRING
 	 in the platform keyring, keys contained in the .machine keyring will
 	 be trusted within the kernel.
 
+config INTEGRITY_MACHINE_KEYRING_CA_ENFORCED
+	bool "Provide a keyring to which Machine Owner CA Keys may be added"
+	depends on SECONDARY_TRUSTED_KEYRING
+	depends on INTEGRITY_ASYMMETRIC_KEYS
+	depends on SYSTEM_BLACKLIST_KEYRING
+	depends on LOAD_UEFI_KEYS
+	help
+	 If set, provide a keyring to which CA Machine Owner Keys (MOK) may
+	 be added. This keyring shall contain just CA MOK keys.  Unlike keys
+	 in the platform keyring, keys contained in the .machine keyring will
+	 be trusted within the kernel.
+endchoice
+
 config LOAD_UEFI_KEYS
        depends on INTEGRITY_PLATFORM_KEYRING
        depends on EFI
diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index d0ffe37dc1d6..370ee63774c3 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -11,6 +11,7 @@ integrity-$(CONFIG_INTEGRITY_SIGNATURE) += digsig.o
 integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o
 integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o
 integrity-$(CONFIG_INTEGRITY_MACHINE_KEYRING) += platform_certs/machine_keyring.o
+integrity-$(CONFIG_INTEGRITY_MACHINE_KEYRING_CA_ENFORCED) += platform_certs/machine_keyring.o
 integrity-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/efi_parser.o \
 				      platform_certs/load_uefi.o \
 				      platform_certs/keyring_handler.o
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index c8c8a4a4e7a0..041edd9744db 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -34,7 +34,11 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
 };
 
 #ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
+#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING_CA_ENFORCED
+#define restrict_link_to_ima restrict_link_by_builtin_secondary_and_machine
+#else
 #define restrict_link_to_ima restrict_link_by_builtin_and_secondary_trusted
+#endif
 #else
 #define restrict_link_to_ima restrict_link_by_builtin_trusted
 #endif
@@ -130,19 +134,23 @@ int __init integrity_init_keyring(const unsigned int id)
 		| KEY_USR_READ | KEY_USR_SEARCH;
 
 	if (id == INTEGRITY_KEYRING_PLATFORM ||
-	    id == INTEGRITY_KEYRING_MACHINE) {
+	   (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING))) {
 		restriction = NULL;
 		goto out;
 	}
 
-	if (!IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING))
+	if (!IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING) &&
+	    id != INTEGRITY_KEYRING_MACHINE)
 		return 0;
 
 	restriction = kzalloc(sizeof(struct key_restriction), GFP_KERNEL);
 	if (!restriction)
 		return -ENOMEM;
 
-	restriction->check = restrict_link_to_ima;
+	if (id == INTEGRITY_KEYRING_MACHINE)
+		restriction->check = restrict_link_by_ca;
+	else
+		restriction->check = restrict_link_to_ima;
 
 	/*
 	 * MOK keys can only be added through a read-only runtime services
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 2e214c761158..ca4d72fbd045 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -285,7 +285,8 @@ static inline void __init add_to_platform_keyring(const char *source,
 }
 #endif
 
-#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
+#if defined(CONFIG_INTEGRITY_MACHINE_KEYRING) || \
+    defined(CONFIG_INTEGRITY_MACHINE_KEYRING_CA_ENFORCED)
 void __init add_to_machine_keyring(const char *source, const void *data, size_t len);
 bool __init trust_moklist(void);
 #else
diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
index a2464f3e66cc..9c456ad0ab67 100644
--- a/security/integrity/platform_certs/keyring_handler.c
+++ b/security/integrity/platform_certs/keyring_handler.c
@@ -61,7 +61,9 @@ __init efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type)
 __init efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type)
 {
 	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) == 0) {
-		if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) && trust_moklist())
+		if ((IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) ||
+		     IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING_CA_ENFORCED)) &&
+		     trust_moklist())
 			return add_to_machine_keyring;
 		else
 			return add_to_platform_keyring;
-- 
2.27.0

