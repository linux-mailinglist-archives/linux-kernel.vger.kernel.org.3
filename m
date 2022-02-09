Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A954AFDE5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiBIT71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 14:59:27 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiBIT7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 14:59:23 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EC0E06C42B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 11:59:18 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219HK0eP020152;
        Wed, 9 Feb 2022 19:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=zWuAGEPnxML/EZcjnzCwskuUNhD3Rjrsbq7/CLvb68k=;
 b=CDgSFEGuQJBMIlWEo77OTYJUksn2Zqww1UFh0cjnZCwxdLJDSWGE5KkdwSjVWEs3yRO9
 JO35U/d+MxH5trxHjG/IZkJTUs1F4YC6JjFfkvfLULZKaIb3vfF12Lo/y8Wnpjj8H6pZ
 EwC1GjKlLvNR/I4ehM0pN8yVXG8vDU3vA8I1EoLuRAXIwKAS/wgsPO3lEZU2kb6iYJrp
 hvK9ITAZJiSn/EX5iVYvMFjBJRbAv9o1vuO02xiyfOkXwHwKIua0W//SiCLkszumnrz0
 HjcSzGH8fJEwiosVw+r6Uc6x+oIk2exNX+obg3VFeGFlbw7WjxhPQaEwYrJpwzYxauxp Mw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e366wxyje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 19:57:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219JtqWK046284;
        Wed, 9 Feb 2022 19:57:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by userp3030.oracle.com with ESMTP id 3e1ec3b07a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 19:57:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cvb1BKhZlpKz28ajZ+/AgxjExvieru0J5WKF1dRcDtDnqm7W6G/pG3a7rG44zj3VR7NGXY9S55xK1K82Y/Gl+3/ejz+PSaZmtbaSPLYglIa3uXVzHloTIN2/8/IPWe79Rn5Sj40JeEdyJm+ZU7mmgISA4O3ZOfPeMGCxHeMAuFXZ0+8IpN3bszggTyBz9mYFZ5DBHRanvoJkD6byongHFvygES9y0YGRZIdg07lI6SXzqb3YDE8xydsZIpOC9E6Iiu6zfJrfrbvJqru+ESlFcNqmxxku2zYcerzW42blEnlxr4ZCOQuZSjiLkpzySBqEAHy2EdmDo+qrD4ZS0TbqWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWuAGEPnxML/EZcjnzCwskuUNhD3Rjrsbq7/CLvb68k=;
 b=SPO9PhuRp8pCyggqA5n7mrgEBI0vYChKA3Q5u2uStjoSPgXI+vmUBJ2tpqkqe2bTHnEmyZpleheer7d/Sy0gbb212LM/bTHoT2hdSDgfSXXZpzRHaDl3I4dM0blrqUcdvQva3wZZaNt+Ai/Y0wQqec1Dd/kqxcE2APOJ8bVAqF/JEtiT1bLsNRfbW1Fpf1ZqB27ip9WtY1PFg4fhgBtZ647Gdh7Y0E6ds2gxeHNgOg0L7lfTOl7Blfnja9IScd3PVcr7VOSmTy8rvmp9l5QBr2mWXn/Xg9bq6MF1ZjZNL7X9HRGU8D/w3BrTjFvsdf5cQHrfvrx6jJrXZntS+0H29w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWuAGEPnxML/EZcjnzCwskuUNhD3Rjrsbq7/CLvb68k=;
 b=L2Tm5r0xg5I+mgc5QmPGQSrBHZB50tLVtwvW7nWRSai/41Exb7DxoiC1KDSENHqjkbyOa4ouE5CUul71KqGKN31/2mJ5qgpxxEjDJ8dbqFRtnnh1GNO/vBNAmYYceta+5nO8hdrUwbNZWpuJcJ1VeYjt/+DONwe+A2YGrQpA94Y=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MW4PR10MB5701.namprd10.prod.outlook.com (2603:10b6:303:18b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 19:57:26 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac06:be4:5723:771c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac06:be4:5723:771c%5]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 19:57:26 +0000
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
Subject: [PATCH v4 03/10] crash hp: definitions and prototype changes
Date:   Wed,  9 Feb 2022 14:56:59 -0500
Message-Id: <20220209195706.51522-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220209195706.51522-1-eric.devolder@oracle.com>
References: <20220209195706.51522-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:5:335::15) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d7a162d-7074-4f7d-9660-08d9ec066559
X-MS-TrafficTypeDiagnostic: MW4PR10MB5701:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB5701C9CABE19BE4C9E8CFB49972E9@MW4PR10MB5701.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yd5VuPJupO2Hu0LP0C8n0pN8H8eNoc3BESFLyP7wdRN5wbWyVHczeB7cP7i4T+tWpzCJpT4GcLh+P7AukqzkywDukd7+qfsrPBkN+CHW0FMFV/JQ1gejnieTnuZ0Paogd8Jsl3pu7dDCIYtyVHJzDKsfmF08+Br3m8/SzlBWS3ysKGW7bfKXCK2JGxFxkDwrhf+C3AI6QTWBcvR1bombfqh102HEfCwQ2lsxM69+7bm9zT3G/itwm8hrb+dO0e3vvMJ4ciVZrhW1/UX3W5VMuIAf2ct4867SY6ak8aj18zROTZCUxOY0RoeopLVmOeUqKSAa1FmSh2sTPgRuUvDeRbP40uyf+cR4DkoZOxfGc0ER/OGcY8qW76lnN88UC0Gsn7kGW2CbcQejCmYHcWN0aCOggKZyZHyD9uhR0bl6iDyXUolbDg22oMTsJbIrYp7K2Ftt2dHGkPO/iKPAMCw13LU37VAfb4W55vz+QQPwUIWnIpLoA6+RE/ciHN2Mo4cbXZPueMafAYjzPxAhI+9sx3A/+7DsVCsfdx87RCyAFM7EutpQa7dDqODJTyZdM5qTVySwlLj/beFkXLS1/T5F+M1sGT9W/1mlp6ShxE/zD8oFW+DfIPrf1JcVH5bcvSLKdHVSKJ1Bjx1SW2rgqBAPwdhI4fL2mlMePR4YM2pPWnvHm5pcxxgtiPTTGfxapc4k87FaZWMxjDrYaJBOhW8LsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(7416002)(5660300002)(1076003)(26005)(107886003)(2616005)(186003)(38100700002)(2906002)(38350700002)(8676002)(86362001)(316002)(6486002)(508600001)(6666004)(6512007)(52116002)(6506007)(8936002)(4326008)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IHdtQy024+uHycREsj1jg3lpWcYXtjwFmgW3w62aDBi59lIHQlkRueYRvkTs?=
 =?us-ascii?Q?yj9R5T1BHjA4yfzTZJqfIq8Tf+8yJMdVp0Ww3bXCvYyT+D096JTzdx671eMB?=
 =?us-ascii?Q?dgqUfwKIxStdJdFHbJB+BZWGY9L5m6CL3mgqTIWvYNe3KIKR6Ajpmx7MYimT?=
 =?us-ascii?Q?Cnv9iRDXBHCyghhlBwWz6T6fgblN3Yjc3rYDxvCfpYMf8R6IZi1yylBG1lXX?=
 =?us-ascii?Q?5KrQO7GeKlJr7kJBfXpmqEGk0WmVg6Shkcf/KfAVqo6yrGTx3L78nyI87nOS?=
 =?us-ascii?Q?DXeVP09Fe0s0rzbnf2FKaM8YjUactKyV7uTt3QJBLZk0D5ZaprL+02tDZeRc?=
 =?us-ascii?Q?P2h1efiUsdXRA6PN3ymHJGKP7o5BiMFC2ZppoEH0UqlCtMqjxHOGgJC47Gnn?=
 =?us-ascii?Q?rN9iuyiTaFk8Gb/H9luKcvoqvskcSHNoNCnMZ5GTd6SR33TwH3bfeC7ezgFt?=
 =?us-ascii?Q?PPZbQIrxTFFmUSP+O0n0ysfdujyYFxWoGBTgvA3WRz3wtjaSK4ORO9kyjUVu?=
 =?us-ascii?Q?T9xyIe7XEF3F83EJ0rv4MhSN2B+4TCVN/KHh2aOr0R7gHaIMUq4atigcNja7?=
 =?us-ascii?Q?XdKC4BxhVD83CE9tl02sEDwprQjFKgIqoNMK9L6uQYMlaAGhyrzEBAEpPcN+?=
 =?us-ascii?Q?vns+IiDMmQtys9pP0/23seLWurWmJWnFq495Bl4jdbpd8xn7Xzfx20a/gxqs?=
 =?us-ascii?Q?wqaEROW8c5SkOLvm+jm4tyu46uTRpCNunrBXybLH+KgNXlokgEk+r9/ITaJV?=
 =?us-ascii?Q?3YnApn3hT56A7FlAhor8a9PrLVyo7fRiPNMwFZc8gA0DifhVgyWaEGtDJ5y1?=
 =?us-ascii?Q?oQsKufhQ3hD376KKLJ4Zk83836kEAPfdPTGn1wGH8iJ+a6129ouIPfqi5cYa?=
 =?us-ascii?Q?iYbljHCf6qnCKValC4a8pmpy4mU+t8YGZ3QN6JgQSa7E2J9Y2IQrl40qIhrB?=
 =?us-ascii?Q?FH5nDn6qKeOyy5ZbvOf6LaiKLrWG/RjaJfv43iLHZYL0QhgEn3mem6ThU+G/?=
 =?us-ascii?Q?S0MMIkoztk5R4jeQgs3Y0lJX+sWbBsLxBLwFqVC7vu8bYU3isp5NX+9KCA4d?=
 =?us-ascii?Q?nDRuNBJAYW+SSY0WY8TZ403Qy7tUsIWsETjaH7210mzhSTWXgWu+lfVUaTMj?=
 =?us-ascii?Q?rwwrHLMyZCvG2bbuHt9po7tw/dhC4fuYPzGoLi+3vMHR23IfYIoEqXrL1Mzm?=
 =?us-ascii?Q?lP4XfmT666UpjmBKE6K3xR0MfzmtJw4KO5P+40M2laPLheJEN52NcT2W/e/P?=
 =?us-ascii?Q?efSKhTUeB3vbjAGxYXYb3U2jX8c5BXsK3Gy5TFbl4CeGjW50hDK+9yZ/AVQS?=
 =?us-ascii?Q?bkNTV29ZAd0U8onfVQa2cmo53o4c6JX4H6eu1baYt6DZWEthKylxnRNRS2wD?=
 =?us-ascii?Q?Ru9He1FfoOjQ/IbmUjzUwCphXb/fO0DmoRaGsEF3A1Qvh13DaP/NRvu3rzLh?=
 =?us-ascii?Q?TLFJVpo288d4Tbeh9cBRunMQAqbzofAmdygP8FCPQRuCah6DK5KBnzwOgWub?=
 =?us-ascii?Q?0x6MeH8xuja7dX3AOqrX7azgs2CMXCwXmDLwS3XK/O3LOZTQsw0n7gPugjwG?=
 =?us-ascii?Q?7OYBcCTg1eWDYjkJrNbCmoOBPJNfbV04KTtgwQaJABpYqzvAu/hplkxZfRum?=
 =?us-ascii?Q?2eAatqGTSGe/HxIal0dxSY18MrGCvbzpt8gD7rctetmEJEYfAVcYcJ2lm88Z?=
 =?us-ascii?Q?GrMXiw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7a162d-7074-4f7d-9660-08d9ec066559
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 19:57:26.5526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WTPMnxEcOpL7r0Q6I2kb4kMdo5101o4PeMpyVgKgFZUJTKNOzx9BQz6KiedUzgK08TAGUPibf2bsz4OpiT7VLVkzW9eHpiY8Cl8/GQ5494=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5701
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090106
X-Proofpoint-GUID: ddJlKh0XWCcWpIh9UiVM8OH-Nd3WTO8N
X-Proofpoint-ORIG-GUID: ddJlKh0XWCcWpIh9UiVM8OH-Nd3WTO8N
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds members to struct kimage to facilitate crash
hotplug support.

This change also defines crash hotplug events and associated
prototypes.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 include/linux/kexec.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 0c994ae37729..13c238c2da48 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -299,6 +299,13 @@ struct kimage {
 
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
@@ -315,6 +322,15 @@ struct kimage {
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

