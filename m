Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373B046C401
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 20:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240993AbhLGT4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 14:56:43 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:8460 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240663AbhLGT41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 14:56:27 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7I4YA8021521;
        Tue, 7 Dec 2021 19:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=4nZLkbLPQjF2e+CGpZP5Brt0FC6DaCqZwdobXBL//Ig=;
 b=Q7JOUZ/5V77CFgYAY0atzABZ80DIiLxN1CA4P9p4ixvriyJ17SOarjQAlCi7YM9hR8pm
 6hu3LyMROoOsMVW7nA1L3OuJKpa6FQoqJL895QOa5re7KCrJtUH3n0c1yYGsuF2LuHXn
 i0VLDhFv6uoyd0ZCth8naBlrra29VP0HGsGLx4OzbuwhnVhbEaDs0zEv9bklMSEAKxWU
 P/0RfeeZ61bi3cO7Hpw333Tq+rTXPgmcHnZWBihtq3hAYFPGud7zC/D7Fk6/O61C05o6
 ftDQKoT0Jw3E3bHFggb4+z589Ya11qVkSpA2vpFVqWHcGGM8IcxV6GsJVigc4ZqAm4Ii mA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csd2ye5r5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 19:52:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B7Jk8sh065014;
        Tue, 7 Dec 2021 19:52:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by aserp3020.oracle.com with ESMTP id 3cr055cnrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 19:52:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nULzUQeeDOLcwdOG0UPoLdmNiQIWkdyHCfnGFW+8HEoAddWLHiaWaTSuN7S9T+2r3x+HKyOQjR/PbSiF/wTcUWhy1dz2xaxp29xzjWvlm2SekbVavWYim50r43k1+GG1XO5vqZyBV9qPZPrQDSH2oXSPDglj3lxyMpWow86d2nRqLP5Hk6W+Godkz19PMqvaPBjYOvCJyOgIP7kYjfzz2sm5Vlf8VNxiwirGWs0lgQgarOhhenlRxOvX1dXFKF8z0fAvI+aWpUSwgz9dhnOdrUqGiroAfXWjgyTImB2NsN4qqZX726kDKa0pkH987jnUNWivOuFm7s9Xnbto+nye7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nZLkbLPQjF2e+CGpZP5Brt0FC6DaCqZwdobXBL//Ig=;
 b=BEy5bnyNDYnrLwrs7coLE69tg6fucllrgdrdl9Q52VFMSDs75/twqThGdBp6p2ou4RLdxfZ0Lbln9Gu/AaNLnedlGSsGziSSvPNwQGsIN2j/RXpTqDWtMpKSnXQrmQXSZZrdlCmce9ZPNGZ1FwYhXWsJb5v0Qwpq6eD5uuJColZKRLI0HTTHi7Vsi50pmAi+WeqAY51x48fVtFio+G3emsYi/dN9zx7/L2Uz0EzKeN4OCEftcgEe+1a44JvRGcUJp3xq5CwD6YZEWSfD/ZQMMLiGLkqm9HrEzY184sIdYFWUgICHHsoVJhL9sfvdX7e2Io7qmUqF53ax+VCUC8W2Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nZLkbLPQjF2e+CGpZP5Brt0FC6DaCqZwdobXBL//Ig=;
 b=DUyKIp/lKAyhoalHuhDDVpErhvfh9zIWoT3A8IqeLfjJMs+DLHxF/ZaCsx3okgJ+ZoZYg4wJvDl66Ijl/CKDYjBdlWrRMYdR4IYBeGBfiAk0p2FyL5JKh/h+A10xOPoQ7i9dAbdJBIAidfqvN10PcxjQYkupPgVv7qypYtq7eAU=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MWHPR10MB1695.namprd10.prod.outlook.com (2603:10b6:301:7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 19:52:25 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::143c:ea64:7017:19f]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::143c:ea64:7017:19f%4]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 19:52:25 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        eric.devolder@oracle.com
Subject: [RFC v2 3/6] crash hp: definitions and prototype changes
Date:   Tue,  7 Dec 2021 14:52:01 -0500
Message-Id: <20211207195204.1582-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211207195204.1582-1-eric.devolder@oracle.com>
References: <20211207195204.1582-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0210.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::35) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
Received: from localhost.localdomain (138.3.201.23) by SA0PR11CA0210.namprd11.prod.outlook.com (2603:10b6:806:1bc::35) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 7 Dec 2021 19:52:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 904fe2cd-f50b-4589-915c-08d9b9bb17a2
X-MS-TrafficTypeDiagnostic: MWHPR10MB1695:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB16951A05BA736B07B5D030DB976E9@MWHPR10MB1695.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pn3gk36+NN7BPtoVdOAhXeLc68ZXq3eo6scqeqcfUK7sFInUhZPzNdbP9LmaQBbuCFUy1XZDMV759b2d7w8egCWx/EXDhyawhGVeZVrdj82UkRs+2uvxxtR2FYZ8SwqEzSBoqjOKjOf4n3WQoMf5SZ3ibHIw7Y7yU5OTxIW03zxcyQ7m0GnW8Fmn/Z6kil3ZEKcu4a9whMuflR0FVZwt014DbzIXh7t8hNBVqMqA8JI/hRPRlb+vHh2we82N2msgYOv3H37ZEb+FrcUwFZmavSx26jmMlGmB/zQKz+tVJyLztPZwvqQgIcwrcXoS7wWcegjxlsGv7QLaXDxSIp8pFlhTeAXwhh4hZaBljyr/esSH/ogZVcjxP+MK36bTeoFTNPxuCIUBJLc5M9kt9O8ibYa2II49wdgXVTzYt2fFLly3kwffuRmXZMMtqG0wErcAEdCwpAEP3+SYhncaFN4mvspmseYqMmSyDS8TAnl/UBBKb2Tb2MotSWMLTyjPWZY0b6wTqfVXWnNMQ/XRC1VUIDr4YYh5TyPJRM2vNYxA2O9lW3izHTXwcez/zfuOcc//eQdPmHkKO29LT2735mRmNjtCEIqjXsTUYeHXQxasF/buZrT8d+8Y64ANDjO3kf8a0yLedMWPi5fDnFc/6VleI/1kTWfpFsfiqyaRniX1kBByJLRz+n1Sjj9S/OiPRQ/k4NTvd2zo7NCaiHemhKNCjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(508600001)(7416002)(6486002)(36756003)(4326008)(6512007)(6506007)(8936002)(66556008)(38100700002)(2616005)(52116002)(38350700002)(26005)(186003)(6666004)(2906002)(86362001)(956004)(107886003)(66476007)(5660300002)(66946007)(1076003)(83380400001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n7DFJMlK7OX0K98LHFMvuU3ydOPgasFaCiNt3FOofo7wRlX0nFsbMqvIOTJS?=
 =?us-ascii?Q?V9cPR+ssVRz1yHdvNzyNu1EYjrmLrUFVersif+2oOSGCxe2YVTSiK3Hh/zzX?=
 =?us-ascii?Q?6doBriAU07lTwxZa1CIjsPnn4UiUziTr/VZAd1HsVC0R+8NfjekxzUmOqmz4?=
 =?us-ascii?Q?TCmtjYLilsqrUanVHECRQUnffkk5eBMAhjFzgF0/w4cY8nS++9XFyvKYXO/N?=
 =?us-ascii?Q?AOBn3alZP+7+9l//1HCqfGRU7RneLD5fqstYa73YMJaNyslDsmuw3H3zHxoR?=
 =?us-ascii?Q?pH35yFn+TV3eV7jL8aQ7Z4k3z2O2FrjrJ7CO68KR80QxAoiA7syXr3AxzRil?=
 =?us-ascii?Q?5hk/0iX80ldcpJP+/iGtawsgu6+nCr0fDw+yLiLKDEMqduRI0WrMpY3P6jVe?=
 =?us-ascii?Q?4FDnDKOJd3yFe7lhCagzGbM6C8iBBlXPb+U4rUne/c8ZYCxCiKDvH0/TT9Kr?=
 =?us-ascii?Q?Md10N4jWGMJNWTwiBO3VhcDoHHDg0ftdhZWB86sVRuAdlYK60+iUVWvE+NQo?=
 =?us-ascii?Q?zXZrkoQoerMH1LwgQfVRYR+/R3pDobuXjCR2KeP+4UXrfLdTCcSnNyv5dz8a?=
 =?us-ascii?Q?i6J9mAxh2KaxiXO3NmJ8x9J32NyBnHqOxM6VfqafnKI4uacYwFZFANEThc0z?=
 =?us-ascii?Q?j44vcsOo2oUggR5mLr1GXH39OjnXk21rLwqka+FumfDbn+FlBnpx2vwf0lbv?=
 =?us-ascii?Q?PVSKJYZ+6nTOhGabTxjCeP5FHiA98WHw1M+oOGGzppRI9wkBFJkRhyP5uKMV?=
 =?us-ascii?Q?zd+/38ZnH4a7fNtQT8dXoX1XpSp4DCf+WzKIBHYXAyWqV5PPNqW+mtugTCN3?=
 =?us-ascii?Q?DT48H99wuIhQIlPp7XZutNdHMuto6Iuy2SVVdAMXDGDOpl8i/YZjtIr6lTPj?=
 =?us-ascii?Q?Iso2YJmPAjkCzyRlrOgCnJVbXkb4WX+e3QhbW39FsagLExCT71uQCVZtnGi+?=
 =?us-ascii?Q?61z7a7cHyD7ZpFFD1zF2BUldtYchARsrSCtj45Wjvd4+Il3dR1O4uq/QS7TA?=
 =?us-ascii?Q?9kFcRM/wfNgDP036dikMnEVkVyCCbv+Sbr1X3rNgrMtuAabI+CK10KP03iHg?=
 =?us-ascii?Q?eO3DxgWTS0qj5hLMbc+EpDqrThY6AKRu3BSB2y1ADFoRvCicXffUCy3TaOdF?=
 =?us-ascii?Q?VbEIk3O4Y/OUGqxemW7ZuwU+0o+oOR7OTPrJt+L5FntzRxocZfJkgPZF1R98?=
 =?us-ascii?Q?XtWXulw449K5tyjmxKIspyYN6PTJKghp6ozkOzPKkYpqCnqhod2ek6Qofam6?=
 =?us-ascii?Q?Cx2AjVscFPSxoiJezYdono2Hw1U1tjfiT/fyuVaDQ5PwrtOuQXrGe7MwuA/r?=
 =?us-ascii?Q?Tk3GJN2zyWHDg53EY5KngJyffZtF6ieeqLO+UcTFOja7yDROt//bjbM0h080?=
 =?us-ascii?Q?KN4iy/hAr95MrmYb7ZNzkpWdNKeHL0TCWQQVqqgIgmqJlELO+b8im7z4M5sE?=
 =?us-ascii?Q?uRMFmF6wDc/gOjrMSFpiLcvaFqsTKZBq8B3q1ewX4+2ouP1uxoT/FCNzaqHe?=
 =?us-ascii?Q?7Qd/6jLY5Cuqe9UceQrSKSGzPiEDPrZcj28enc4ByN5HMd2P/dhUJU//wRwK?=
 =?us-ascii?Q?6mLk8SE1DjYfp55JKThWsBLjUuiAcyEi4mkZXdT9WJcrc6yghIBLuGrs2lOF?=
 =?us-ascii?Q?hOtKmpMZni/UHhjFdVBYg4TdpdrwQ9SKrPZSEH2VuVVk6r/IVXMYOD7bEIwf?=
 =?us-ascii?Q?RafdIA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 904fe2cd-f50b-4589-915c-08d9b9bb17a2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 19:52:25.7907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fnTwZn+BYVnfoayfDiowo0CPM1KPgwHBIKZWD+JjU/Rvn8ndfoK7DTiV+WPXI/0EqiyIhZN35QGGbGBoHKOV5zmQeDv2ZmuZvbCyh55P5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1695
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10191 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=1 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112070124
X-Proofpoint-GUID: vf7xxPoIAQuNlr-YvCAaBAluieCPNiFT
X-Proofpoint-ORIG-GUID: vf7xxPoIAQuNlr-YvCAaBAluieCPNiFT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds members to struct kimage to facilitate crash
hotplug support.

This change also defines crash hotplug events and associated
prototypes.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 include/linux/kexec.h | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 0c994ae37729..068f853f1c65 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -221,8 +221,9 @@ struct crash_mem {
 extern int crash_exclude_mem_range(struct crash_mem *mem,
 				   unsigned long long mstart,
 				   unsigned long long mend);
-extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
-				       void **addr, unsigned long *sz);
+extern int crash_prepare_elf64_headers(struct kimage *image,
+					struct crash_mem *mem, int kernel_map,
+					void **addr, unsigned long *sz);
 #endif /* CONFIG_KEXEC_FILE */
 
 #ifdef CONFIG_KEXEC_ELF
@@ -299,6 +300,13 @@ struct kimage {
 
 	/* Information for loading purgatory */
 	struct purgatory_info purgatory_info;
+
+#ifdef CONFIG_CRASH_HOTPLUG
+	bool hotplug_event;
+	int offlinecpu;
+	bool elf_index_valid;
+	int elf_index;
+#endif
 #endif
 
 #ifdef CONFIG_IMA_KEXEC
@@ -315,6 +323,15 @@ struct kimage {
 	unsigned long elf_load_addr;
 };
 
+#ifdef CONFIG_CRASH_HOTPLUG
+void arch_crash_hotplug_handler(struct kimage *image,
+	unsigned int hp_action, unsigned long a, unsigned long b);
+#define KEXEC_CRASH_HP_REMOVE_CPU   0
+#define KEXEC_CRASH_HP_ADD_CPU      1
+#define KEXEC_CRASH_HP_REMOVE_MEMORY 2
+#define KEXEC_CRASH_HP_ADD_MEMORY   3
+#endif /* CONFIG_CRASH_HOTPLUG */
+
 /* kexec interface functions */
 extern void machine_kexec(struct kimage *image);
 extern int machine_kexec_prepare(struct kimage *image);
-- 
2.27.0

