Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2994D3CAA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbiCIWLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238534AbiCIWLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:11:44 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AD7120E9E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:10:44 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 229KcmF2022216;
        Wed, 9 Mar 2022 22:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=rnCiA9rRkTMfW6osRF4fhz5Mw4VzlRtn338PAVBlhS4=;
 b=WM0gS0vxm3oipf7dpcmUQjjt7GNwVyAwwyaiLzjAarrRVh3wAZ8gcG7XGONdLGg17l3w
 NvSaYMEXguYUBeczLrLgZiFozme+wDhb15qA5bXaHNOJjIu8hjwSXAuqIodrBlXnj6Pk
 D72D+6+V4CJ0ZiJKGDMWIVG+J0wwQKgY/OFXiSnUFCpC+uMbS2kWDVehR3ZUds0Id3z1
 5NRAITGg/D0lbsMm1SsaCBKP/SVxiUAHw4ciIB76dmAJNxWtcQfRP222Me3RaBNx1+0K
 VyXNcX413XUbbaIi9vpdSiDMh7dN2zYMS/jbSXUv7z6PZlje6/HvNjsFiaqLTX9NhZcK Kg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxf0ugk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 22:10:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 229M6Pb9076248;
        Wed, 9 Mar 2022 22:10:04 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by userp3030.oracle.com with ESMTP id 3ekvyw6x88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 22:10:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SI5Hoh8aDSb0Z8aGf7T1U1kDMoMJoV4HCWtHEFpVMQP82LNiD7awJiPQjEF/TMAkIrarMjLM9X5qbvbs6Q/iJ5E5mk+NlRVDhBw2ygL19t30PByZe8cdTo52Xuy3R8O+2se7TKmw5ZwDr7QNhqpE5S0gPrSVRatECYxmQTgnuASn7KbIv3F/aZpz3LYlLkrX0Qmwct9KE8huKNPitcCl4gruVLdw4aYEgjM8B6U5PTZoydw17AV0uM0f9DyAOt8crYVEorpd8vnz61/RarBcU+ZO3Hx5w1Tu1LW8mFvckx/kcUxvh9Z/rs+vZW5X5GKIrG21Ns2o7A8lhQL2b5PWPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnCiA9rRkTMfW6osRF4fhz5Mw4VzlRtn338PAVBlhS4=;
 b=AL2XxlAeN0Mfj9fAgmczyRrdtjwD3vHKQjGQvp5TqYwzTdoYhOowrqimos/pp67JRkvjgCos004uldiYZSF1Cpw7zqa1ISqNjHK1yxcAl9HbIE92703wbeJgtIadjkjig+Sokxlw/y50dLuOMwYaN5FJ7TtG+ceRn4YrF0hlJf730AaNZXdfkoGE/IUxqBnDq5rtLehfflZtEhtcQio/dLZc3RRBIsXmrET3VOmhj2uh7OQ+9HAkEqoBGxe9hCjJsNIdFnmJrhCudRJuJ20RzBFay+sOsjtKPGZERmGYq2tJOi5EiDhd14oytdJSFK1aPy38KhHreav2mGkBsp6+LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnCiA9rRkTMfW6osRF4fhz5Mw4VzlRtn338PAVBlhS4=;
 b=qyLsBrUvbsbc76PoHQulR6Wp3tDrYbgbX17GHymVUT6lqef9XixO+bYr5eD7myJ8X28QlJCrU8wGM0bH0U1lzp40BW0XMpAZ2JXvb25zXf396atz3mHdIEaIUWLe7lwhKigEgBMXXe6L3GCIZ7XHwADstvSQJiS91aPuiu+kDdk=
Received: from SA1PR10MB5866.namprd10.prod.outlook.com (2603:10b6:806:22b::19)
 by SN4PR10MB5560.namprd10.prod.outlook.com (2603:10b6:806:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Wed, 9 Mar
 2022 22:10:01 +0000
Received: from SA1PR10MB5866.namprd10.prod.outlook.com
 ([fe80::e82a:9be1:793c:1702]) by SA1PR10MB5866.namprd10.prod.outlook.com
 ([fe80::e82a:9be1:793c:1702%4]) with mapi id 15.20.5061.021; Wed, 9 Mar 2022
 22:10:01 +0000
From:   Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     thomas.lendacky@amd.com, brijesh.singh@amd.com,
        kirill.shutemov@linux.intel.com, hpa@zytor.com,
        pbonzini@redhat.com, seanjc@google.com, srutherford@google.com,
        ashish.kalra@amd.com, darren.kenny@oracle.com,
        venu.busireddy@oracle.com, boris.ostrovsky@oracle.com,
        alejandro.j.jimenez@oracle.com
Subject: [RFC 1/3] x86: Expose Secure Memory Encryption capabilities in sysfs
Date:   Wed,  9 Mar 2022 17:06:06 -0500
Message-Id: <20220309220608.16844-2-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220309220608.16844-1-alejandro.j.jimenez@oracle.com>
References: <20220309220608.16844-1-alejandro.j.jimenez@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::25) To SA1PR10MB5866.namprd10.prod.outlook.com
 (2603:10b6:806:22b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1023780-1975-4c64-d336-08da02198e43
X-MS-TrafficTypeDiagnostic: SN4PR10MB5560:EE_
X-Microsoft-Antispam-PRVS: <SN4PR10MB55607FAC2D32A9E9A9A16B7AC70A9@SN4PR10MB5560.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eIBebYgwrevlZc7yBNaIbhz5aU7k+0Rz7XRvCNhf9K+LdlGeqboKQqKaUdH8ZcmyKMLvwdG9z8qSiym0N1Fqqsp7/F9CYpYczRb4XefQqCZRy4mJN0CT0l+C/H6prcoyEcI5ZyBzwIqq6teNf56+U7tP8sDPK9DNJwETaMuCJmnQmP1SIZSxPZQvOLB/wNW9zZIDLOC3y3/p51ZbAaOMdlTqeQIfQ631hGTenMaSAbM/1SCm4Wgv82LHHoH2B4dirO443yzb8yKhWfgLdHe73sZPe//uk7JS+N7LWR/1lO2Rxj/dYpQAdQxyhUEIcHA2kSHn1QqX3JPNtkiCe3kMolbTzMlx9rkU606w5LlE058Q6uhEBLLbBVg+28YoUHxj0Nft2Ypm8b25M2XZHJF/MsGQ5A3xzsOYUm9ha1qbQnbdawMuHJAxPPxPvh9Mn7AFyg7v7hRIcNChIu89JbzvituCRLcU1wNxzwQdkDocOeGiw5leHB9cFgeQs02a+8LkNfiBwP0YeuQ6zERWKbgiXINKhq02X7/0p7Yxiw82HiUY8GtSGnFsmNtiALJsuuvksICh5OlDLl8mSGeglSsmtu1B20JGTTn2UMyT4BbqZp19HIVNo5rWscOgTr5+CTHX17tcML25sPV/xBeQjTaE2JfT6qOY+tOHnH6PbyxnlVVrWbLAHP491TM5XSGUgB/fYQl1/bHoYVDmNnFqrI5b9wPv/wMsDaS1b2XWb6zjHJtrsk7DT/tKWQFflVx9Dt2DYLwB/tp8s3IY207KcEd4VR3Q3br3mRFkMsXMjCE29ari8O1FqorzXBsoRlPGff2/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5866.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(8676002)(4326008)(36756003)(86362001)(103116003)(107886003)(186003)(2616005)(1076003)(5660300002)(52116002)(966005)(6506007)(38350700002)(7416002)(66946007)(83380400001)(6486002)(26005)(38100700002)(6512007)(508600001)(30864003)(8936002)(66476007)(66556008)(2906002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dJfzMkfutQuFEhopymb10KYxUimqX0jlI5oY6yTXoQLxTrI6zzBUUgeCINvK?=
 =?us-ascii?Q?L964jFFXJ+r+7Knfig9u81v9fvggOSXJaEwt/M1ufqQ6SSNj+6EuHXV/Ufbn?=
 =?us-ascii?Q?k0CKqRhfGb5HefMc2FHYywokcdJ5hW9RMJYObRmO2dLnLi8PQBZwFDhp9AAt?=
 =?us-ascii?Q?8uUhTAjyuwrDh5fE67tZzQx+LeWuCwwu+gD/iopXfN7b+Gc430pYlWA9aEkw?=
 =?us-ascii?Q?4Z4epCeR9AP0XqCryV2FFXJCcdwDFYzvycAKaNOSZYAnu11i30jdkiGk/TN0?=
 =?us-ascii?Q?FvaNA3fzDkl+gbqrxfJZ1YNCiHomrsTbKlp30WxeMvldUJXAFUr/71T2kj++?=
 =?us-ascii?Q?sqvFhGX1H7/yS0b7Rdb2BaEGfqMpJa0Bzg0exsD7pNGMmiqyOvze0GK4Kbtz?=
 =?us-ascii?Q?lXUPHY6SmkQS2q79wWVNIyBOhmYrkEkH4odlpptTFcjKofHLyGccaPiLOvKx?=
 =?us-ascii?Q?XdE4v35PDxZ8YlL3VMJ+33aC5PlWZOvPHjmrtvHm2/uMSt5tAC553W94OVGv?=
 =?us-ascii?Q?18thDQ3aU6nrVRPo21yTMbapEIE0ImPUSA6DCKGm50dCy4orLzjidihMo6/e?=
 =?us-ascii?Q?p6NtodpvLvD6wQtT6j/QT2rGv1CbKcURg6MXhiGEJ2wLOAlayC/+NYc2aBGU?=
 =?us-ascii?Q?t2CiM/hyLzFMHtBK/2hY4pageyF+MSFHkev1EJjVVofdKQLB3KkaXRfjUtN2?=
 =?us-ascii?Q?kfKYz7hCwOVldsj+H7bMeA+pwIHB/3A4oT4VAfSiAN90iDwnFy4pwCStLHqS?=
 =?us-ascii?Q?Q3zvddPaWU0b6AyakE8dDtKov32rmFu+i9iH0mSUv+JG8YDvZWftXQhsiVus?=
 =?us-ascii?Q?F5/wJjANYMzdwg4J5aN9yGiNQ2M8akr1E0KpzN7Fgqp7O/l3ok5rkubY/Tub?=
 =?us-ascii?Q?Dn3YJZbGSxv4WPEI/YfTXDcYQ0L46CG+qeR80J06uoMXG5BRTdLje9zK65RN?=
 =?us-ascii?Q?PBdXBsROcIqrsPyQIQfoEhu9Rd12AlDl2jyhLw/gJXJjW1mKxE/ElnlIvWxd?=
 =?us-ascii?Q?5YIB4t5tlNZT3xkFaqcCLileNUHsQNilkCuizd7DpZwj/jsb5OBtvbhO1u4X?=
 =?us-ascii?Q?CA6D/qFH72Az1gZCurj9Jh5b9jas1wUZHcNSWI3PaODjV3QvjBFvxs7MDyc8?=
 =?us-ascii?Q?E/UDOKYmZAC4eC4QUsLJxVBnHilAeOkWKpaBLsJTtzqIfjOQGBNpyGTqOKqG?=
 =?us-ascii?Q?ompEs2DfeqReRcJo3QjnrWTKeucLqLxLESOlUQMQzylwEc2Z6B+51qAjEhut?=
 =?us-ascii?Q?Zgl4iVWV6TEL7Hkn08CTqTUEZp7R4eaqBTFNWjTDOu5qY9PbAOOjRLEjZZjK?=
 =?us-ascii?Q?d3CawjQOeRoDiEy4V4iG5JpIvFrnLHYW3JTg7VTujuTUSMLOKVhWXeuoc1Ii?=
 =?us-ascii?Q?xFp3kp6fUOPAjHKMEvHppmLJeTsx6bMjPtXwL4ZvuO//xS8C8Ey472QRKcNb?=
 =?us-ascii?Q?c/0zaJBcRPHKyw+/C/KkAoqB6e0clDL1j0iozGa2tkvXKSf9LLGHpnU0ZHyT?=
 =?us-ascii?Q?AggwMV9VEWvZ3/aHx5U1ESFkoTvHWG7KqtBG452UawAubiT6sRSOb28PaPlw?=
 =?us-ascii?Q?nVcGNubOTgC8udhhcHSPYC/tCE/bSf/EnzC4YE6ZR73edoUAE4bOLjdWfbJS?=
 =?us-ascii?Q?SlHlhTjtETflexrxJyKDy6yFG07mBOfV85DyEx6z6JRnKoURYR4eFz5vG04+?=
 =?us-ascii?Q?HgPI2g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1023780-1975-4c64-d336-08da02198e43
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5866.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 22:10:01.2312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0glKdRzjRSmZ7FUTp7Cd48Efa0qerEN61z6rBTykvOM5K6V0vPpFOBW8G2mKXxLSRXGpz3McNX+BsQTspu8pXcxcdDX/9Rk2Mdw3/2uiHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5560
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203090111
X-Proofpoint-ORIG-GUID: Lgz4s9sBR8F8vqqHjXb-sjpZN9sF0A1N
X-Proofpoint-GUID: Lgz4s9sBR8F8vqqHjXb-sjpZN9sF0A1N
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When testing SME behavior, it is useful to determine whether or not SME is
actively being used, or just merely enabled. The distinction between
supported, enabled, and active is provided by the documentation at:

https://www.kernel.org/doc/Documentation/x86/amd-memory-encryption.txt

There are currently no user-space interfaces to determine if SME is active
or not, other than searching dmesg:

$ sudo dmesg | grep -i sme
[    4.275215] AMD Secure Memory Encryption (SME) active

Provide a sysfs interface for a convenient way to display this information.
This patch also provides the framework to easily add entries for other
Confidential Computing features that are currently available e.g. SEV.

Also add documentation describing the new ABI.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 .../ABI/testing/sysfs-kernel-mm-mem-encrypt   |  31 +++
 arch/x86/include/asm/mem_encrypt.h            |   6 +
 arch/x86/mm/mem_encrypt.c                     |  27 +++
 arch/x86/mm/mem_encrypt_amd.c                 | 192 ++++++++++++++++++
 4 files changed, 256 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-mem-encrypt

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mem-encrypt b/Documentation/ABI/testing/sysfs-kernel-mm-mem-encrypt
new file mode 100644
index 000000000000..a53f87f28704
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-mem-encrypt
@@ -0,0 +1,31 @@
+What:		/sys/kernel/mm/mem_encrypt/
+Date:		March 2022
+KernelVersion:	5.17
+Contact:	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
+Description:	Interface for Secure Memory Encryption capabilities
+
+What:		/sys/kernel/mm/mem_encrypt/c_bit_position
+Date:		March 2022
+KernelVersion:	5.17
+Description:	Bit position of C-bit in a Page Table entries. Setting this bit
+		in a PTE indicates that the page is encrypted, causing
+		accesses to that memory to be automatically encrypted and
+		decrypted by the memory controller.
+
+What:		/sys/kernel/mm/mem_encrypt/sme/status
+Date:		March 2022
+KernelVersion:	5.17
+Description:	(Host only) Expose status of SME feature. Valid values are:
+
+		unsupported: Secure Memory Encryption capability is not
+		supported by the processor.
+
+		disabled: Memory encryption has been disabled by
+		System-Configuration Register (SYSCFG) MemEncryptionModeEn bit.
+
+		active: Secure Memory Encryption is supported, enabled, and the
+		kernel is applying encryption bit to page table entries.
+
+		inactive: Secure Memory Encryption is supported, enabled, but
+		the kernel is not applying encryption bit to page table entries
+		(SME mask in kernel is zero).
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index e2c6f433ed10..48d41cf764ab 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -17,6 +17,8 @@
 
 #include <asm/bootparam.h>
 
+struct kobject;
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
 extern u64 sme_me_mask;
@@ -49,6 +51,8 @@ void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages,
 
 void __init mem_encrypt_free_decrypted_mem(void);
 
+int amd_cc_sysfs_init(struct kobject *parent);
+
 /* Architecture __weak replacement functions */
 void __init mem_encrypt_init(void);
 
@@ -85,6 +89,8 @@ early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages, bool enc) {}
 
 static inline void mem_encrypt_free_decrypted_mem(void) { }
 
+static inline int amd_cc_sysfs_init(struct kobject *parent) { return 0; }
+
 #define __bss_decrypted
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 50d209939c66..f1731faa96de 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -14,6 +14,33 @@
 #include <linux/mem_encrypt.h>
 #include <linux/virtio_config.h>
 
+/*
+ * Expose the available Confidential Computing features via sysfs interface.
+ */
+static struct kobject *coco_kobj;
+
+static int __init coco_sysfs_init(void)
+{
+	int err;
+
+	coco_kobj = kobject_create_and_add("mem_encrypt", mm_kobj);
+	if (!coco_kobj) {
+		pr_err("Failed to create sysfs directory for CoCo features.\n");
+		return -ENOMEM;
+	}
+
+	/*
+	 * Initialize sysfs entries for CoCo features. Each CPU vendor providing
+	 * features of this type must add a call to initialize relevant entries.
+	 */
+	err = amd_cc_sysfs_init(coco_kobj);
+	if (err)
+		kobject_put(coco_kobj);
+
+	return err;
+}
+subsys_initcall(coco_sysfs_init);
+
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
 bool force_dma_unencrypted(struct device *dev)
 {
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 2b2d018ea345..ccd6448042fe 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -34,6 +34,35 @@
 
 #include "mm_internal.h"
 
+#define CPUID_MAX_EXTENDED_CAP		0x80000000
+#define AMD_CPUID_ENCRYPTED_MEM		0x8000001f
+
+#define AMD_SME_BIT			BIT(0)
+
+#define CC_ATTR_RO(_name) \
+	static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
+
+#define foreach_cc_feature(ccf, feat_list)				\
+	for ((ccf) = (feat_list);					\
+		(ccf)->cc_attr_grp;					\
+		(ccf)++)
+
+#define AMD_CC_FEATURE(cc_name, attr_grp, kobj)		\
+{							\
+	.name           = cc_name,                      \
+	.cc_attr_grp    = &attr_grp,                    \
+	.cc_kobj        = kobj,                         \
+}
+
+#define CC_FEATURE_NAME_LEN	32
+
+struct amd_cc_feature {
+	char name[CC_FEATURE_NAME_LEN];
+	/* Specifies the attributes exposed by this cc feature */
+	const struct attribute_group *cc_attr_grp;
+	struct kobject *cc_kobj;
+};
+
 /*
  * Since SME related variables are set early in the boot process they must
  * reside in the .data section so as not to be zeroed out when the .bss
@@ -47,6 +76,169 @@ EXPORT_SYMBOL(sme_me_mask);
 /* Buffer used for early in-place encryption by BSP, no locking needed */
 static char sme_early_buffer[PAGE_SIZE] __initdata __aligned(PAGE_SIZE);
 
+static u8 cbit_pos;
+static u32 sec_encrypt_support_mask;
+
+static inline bool is_vm(void)
+{
+	return boot_cpu_has(X86_FEATURE_HYPERVISOR);
+}
+
+/*
+ * Initialize and cache values from Memory Encryption Caps CPUID Function.
+ */
+static void encrypted_mem_caps_init(void)
+{
+	u32 eax, ebx, ecx, edx;
+
+	/* Already verified that AMD_CPUID_ENCRYPTED_MEM CPUID exists */
+	cpuid(AMD_CPUID_ENCRYPTED_MEM, &eax, &ebx, &ecx, &edx);
+
+	cbit_pos = ebx & 0x3f;
+	sec_encrypt_support_mask = eax & AMD_SME_BIT;
+}
+
+/* Verify that memory encryption capabilities are supported */
+static inline bool mem_encrypt_feat_supported(u32 feat_bit)
+{
+	return !!(sec_encrypt_support_mask & feat_bit);
+}
+
+/*
+ * sysfs interface for SME/SEV.
+ * Expose whether the various memory encryption capabilities are
+ * supported/enabled/active.
+ */
+static ssize_t status_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	if (!mem_encrypt_feat_supported(AMD_SME_BIT))
+		return sysfs_emit(buf, "%s\n", "unsupported");
+
+	/*
+	 * Memory encryption must be enabled in BIOS.
+	 * We can avoid reading MSR_AMD64_SYSCFG MSR to check for
+	 * MemEncryptionModeEn (bit 23) since an earlier call to
+	 * early_detect_mem_encrypt() clears the feature from the CPU
+	 * caps if the bit is not set. It is sufficient to check the
+	 * CPU caps here.
+	 */
+	if (!boot_cpu_has(X86_FEATURE_SME))
+		return sysfs_emit(buf, "%s\n", "disabled");
+
+	return sysfs_emit(buf, "%s\n",
+			!!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) ?
+			"active" : "inactive");
+
+}
+CC_ATTR_RO(status);
+
+static ssize_t c_bit_position_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", cbit_pos);
+}
+CC_ATTR_RO(c_bit_position);
+
+static struct attribute *sme_attrs[] = {
+	&status_attr.attr,
+	NULL,
+};
+static const struct attribute_group sme_attr_group = {
+	.attrs = sme_attrs,
+};
+
+/* List of features to be exposed when running as hypervisor host */
+static struct amd_cc_feature host_cc_feat_list[] = {
+	AMD_CC_FEATURE("sme", sme_attr_group, NULL),
+	{},
+};
+
+/* List of features to be exposed when running as guest */
+static struct amd_cc_feature guest_cc_feat_list[] = {
+	{},
+};
+
+static int cc_sysfs_add_feature(struct amd_cc_feature *ccf,
+				struct kobject *parent)
+{
+	int err;
+
+	ccf->cc_kobj = kobject_create_and_add(ccf->name, parent);
+	if (!ccf->cc_kobj) {
+		pr_err("Failed to create %s kobject.\n", ccf->name);
+		return -ENOMEM;
+	}
+
+	err = sysfs_create_group(ccf->cc_kobj, ccf->cc_attr_grp);
+	if (err) {
+		pr_err("Failed to register %s group.\n", ccf->name);
+		kobject_put(ccf->cc_kobj);
+		ccf->cc_kobj = NULL;
+	}
+	return err;
+}
+
+static void cc_sysfs_remove_features(struct amd_cc_feature *feature_list,
+					struct kobject *parent)
+{
+	struct amd_cc_feature *ccf;
+
+	/* Remove standalone files created for common features */
+	sysfs_remove_file(parent, &c_bit_position_attr.attr);
+
+	foreach_cc_feature(ccf, feature_list) {
+		if (ccf->cc_kobj) {
+			sysfs_remove_group(ccf->cc_kobj,
+						ccf->cc_attr_grp);
+			kobject_put(ccf->cc_kobj);
+		}
+	}
+}
+
+int amd_cc_sysfs_init(struct kobject *parent)
+{
+	int err;
+	struct amd_cc_feature *ccf, *feature_list;
+
+	/*
+	 * Check Encrypted Mem Capabilities CPUID function is available.
+	 * Nothing to do otherwise.
+	 */
+	if (cpuid_eax(CPUID_MAX_EXTENDED_CAP) < AMD_CPUID_ENCRYPTED_MEM)
+		return -EOPNOTSUPP;
+
+	encrypted_mem_caps_init();
+
+	/* C-bit position is common to all AMD CoCo features */
+	err = sysfs_create_file(parent, &c_bit_position_attr.attr);
+	if (err) {
+		pr_err("Failed to add entry for %s attribute.\n",
+			c_bit_position_attr.attr.name);
+		return err;
+	}
+	/*
+	 * Not all features or attributes in a feature are relevant to both
+	 * hypervisor hosts and guests (e.g. SME is never available on guests).
+	 * Determine which mode we are running in and register the appropriate
+	 * list of features.
+	 */
+	feature_list = is_vm() ? guest_cc_feat_list : host_cc_feat_list;
+
+	foreach_cc_feature(ccf, feature_list) {
+		err = cc_sysfs_add_feature(ccf, parent);
+		if (err) {
+			pr_err("Failed to add entry for CoCo feature: %s.\n",
+				ccf->name);
+
+			cc_sysfs_remove_features(feature_list, parent);
+			return err;
+		}
+	}
+
+	return err;
+}
+
 /*
  * This routine does not change the underlying encryption setting of the
  * page(s) that map this memory. It assumes that eventually the memory is
-- 
2.34.1

