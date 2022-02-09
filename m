Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC364AFDE9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiBIT7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 14:59:30 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiBIT7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 14:59:23 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CE9E06C41B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 11:59:18 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219HQFZo020151;
        Wed, 9 Feb 2022 19:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ZgkuZ8r/VymLdhLJB2PMa9DE7jwyd1kzggyTkOXJs4M=;
 b=J10VBaVi9FiJ+cVVOh+xRvssRPodyFrgG+2IUxJni0CICa8l8Cg+I2w3LNftTxUXDaZU
 uuXFDEc22RByczPGW/by7D2GJU5aJ8cWT/tEG1yaa3TpIPTbhFrYau1R8sFGo1htNe15
 b9K/dFFNje6jJItAEsKyOkJAgyJzM5epP7kqZODhIaDLYnbpCSuuNZggfp5Optf2ENnt
 ofIoU6gCe5ZxwtG6Ul4meHZN05CEPspcdpg/U+9wO6Ffkn5xcMID0+zFYmG3Q/tbk56a
 qYcNg96XJnvcThIcJnkj2Wa3bYPK5M0jMf9Ixn+6jD96RNH3DP3gXLqIylCkK4o3vEOZ DA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e366wxyj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 19:57:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219JuGjJ095815;
        Wed, 9 Feb 2022 19:57:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by aserp3030.oracle.com with ESMTP id 3e1f9hy63q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 19:57:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfmZ9JOA+ghOrXXIOR4Q3sZtKS1Cr624GuPBM2RzW2WWb9VGor50Nm/jR4yau3G2VjdkqorkwSOO4rQOOFr5bucbIGq4JXdXHY2nvjfAalQy0CXPQSXJk/hcsnXd6RHFOAzeZzcI2mfRnjMidwYj83k4maYKuP+wxXzFTaXDida1VfgWcd8MDMjxbkAEOU+3mqb+RVh/frF5H5pxRyIax9BtCtdkuPjC7wA0mXnYhBxsrQ6Rj2JNUxGN+retTPC+rTbyWesdpFLibvFp5LNVJDUlfqkJSrP9RwHqs+2cdflVgyXmrNxJVdiO6M+f+VfJziEQKmWg/gZH+9MKK/q4DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgkuZ8r/VymLdhLJB2PMa9DE7jwyd1kzggyTkOXJs4M=;
 b=DN5PtjgygjlQ+sUKaFwo8ViceSTJthkrYYlFcFmHozmyr6EM05Le+O6o1lGWBtutglEJS249t9HfhX4FAghWPbb7St0it0FLWnfPK6ymraTXNQVXqahGCC1s+ITvZ219/6bji8ju9FWTtJZTdu1i0/U6cB0HoRyNzK3VE7Yv49nqxo0OptUQI8JONgTP5eue2ysD5/0ZSN/ZcJmfJE+mhsBwFt7mwx1d0lb9g6ycJ9GdxU6VjKnreU4NfU0tu51/e3K0xxgqCdsAHm2YbBSyQQ9ipGBhm+8TIkoh5dytsRFnoMSoOVzncDj/2iwp5Mw9Yx+kXqa+lUT3t4nlJVGfyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgkuZ8r/VymLdhLJB2PMa9DE7jwyd1kzggyTkOXJs4M=;
 b=yyNZLD/ArfqNjy+ghqt/8gaNty3n3weJPRkYzC+mML0i8zkhFZWXAJ2jNZ/QiSP/N7FVQS8Tm1om05A0iMH/lvTnGuycZIFTNxm2tu+R22glrF1Jj1MEMCSLjVsK117zRaVMksHI7WtCTdpN0mzDuUStl1HX9C+PcsVMYNuwGQY=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DM6PR10MB3721.namprd10.prod.outlook.com (2603:10b6:5:156::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 19:57:22 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac06:be4:5723:771c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac06:be4:5723:771c%5]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 19:57:21 +0000
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
Subject: [PATCH v4 01/10] crash: fix minor typo/bug in debug message
Date:   Wed,  9 Feb 2022 14:56:57 -0500
Message-Id: <20220209195706.51522-2-eric.devolder@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 014c89ee-d4ac-45ed-d68b-08d9ec06628b
X-MS-TrafficTypeDiagnostic: DM6PR10MB3721:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3721F18F9106C3FAAFEB0F7B972E9@DM6PR10MB3721.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9bs7mvm4EBP/KyK6OyCXu4BZQOawkwvrEQsbycIWQHcWk7A9bv2Z+K0omu1DSN8VDGfUpQPXL8O8CyMfaryHAjnc5Od0H4x893tnHXXUfmxnGU8NZj3QNlO71um35vj+hZrS7dYat3dx4EgFMBGlPyiw04Bwl8V7UPxJVVVgMKnBfHnohtHx3lAM+uxllXDa9U/nN0CmRcZ1zWNkQt1tCAn9c0ppJsMjekHpFt62UTm7AMKxiHTWjShnV59OQbPL6TPRWVfUdn3c3cYvzMKNDk7CctvUbIPwnHs8nL+Qfn9/ZFOQCWnMO9GHd/okItrWqGoyElZtJXJbn/bvhAhTKoEzbzdFEAvKxUCmyeqDeFyDUFAnW5JEX8WQcbudWu6Ffl4anTHviZQdpOF7HjjqFMeGcLL7B6psmbHe/i8JvR0Jxtjd2vzSgUfKOjqdwIJjAtWYagILEsfVQKWZ4A1jUrKPcBxmUb/4S1Mm9JSdx2fsB8BiWXirg2NmiXPAsSDOVIB//1FS3LFXhZ+OfQwTBEfJyDszcu2e2nItm4FKaN4vGS5nc7UJP7qmMdkOfPJo7B8yecSCmXPx6SNhZHvmEvhxdsKySTeeq5x7jDBqYTPDj+OggUMNLDe+uTvz6rul+7BywgNaADavpiiGuUrqIOOMf3vVVt9da1icS7JYIif1uXcXzQ2Whpna4oWrEgD6y/G4HnOm6fC7ZwaQlxeVKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(2616005)(5660300002)(26005)(107886003)(1076003)(2906002)(6666004)(508600001)(36756003)(38350700002)(6486002)(38100700002)(7416002)(6512007)(4744005)(52116002)(4326008)(316002)(66946007)(86362001)(8676002)(6506007)(8936002)(66476007)(83380400001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9xa8x88pbgOYgAmMh9WtLOZ25YLb8r/xyGL7B6Y17Yiivw+5i21Pi4sAiHee?=
 =?us-ascii?Q?g9vF+Z1BuYku6uDKGydZcdz/45MQJSXrCxZeyG+w1y/+MUVE74B9TKt2QYaa?=
 =?us-ascii?Q?mD5KY4OXoXgFrnbrnkqjC1E1HWDguvIlCKDOnuW0AXQedDrzXAjt70EFZWsO?=
 =?us-ascii?Q?pePr4A+LeU2pa9q8ixfB05UKX1sR770l1Q42S5Co3/L1S2ayh/i5wh5ztNpl?=
 =?us-ascii?Q?wxMr/JjXlejTR/+CBlCCjWtIzcKoRMhiT5D/xNQG1uQYMVPRZ501ufF1hRNx?=
 =?us-ascii?Q?rDN5lLXUpigQpkB6MvqkIXI159PbwsSdRF85r7+r9CI40yMhhb/bZUnEEB1A?=
 =?us-ascii?Q?VfP9LSGroA7iPeHUgHSJmz1X02LIvHHs00hVJjV33V96YPpijvXY0KezRgzu?=
 =?us-ascii?Q?oWMtOdiMk+jT4srP2RC9vmgthOTFwBYkuGPqjhf5RIOxLEa5rxKLauJVNajP?=
 =?us-ascii?Q?zGbDZNQX9E+Yo1icwt7/+nC5dS12FSXbEFcKosxrnNgHQSk0vhvpPKfmHiHy?=
 =?us-ascii?Q?NrW53x9zvKyxfjmdS8HZzCHp9PElRSxFSs/Emzkwxqe2Vf/xR/jPGDB3dHfq?=
 =?us-ascii?Q?ETOC621lIwiRSh+/VjjDtWqfSXXaAddxNFrA3zsLO/0cLBfM8Ms/DgJ1+3/E?=
 =?us-ascii?Q?6nRLcrWGFbdrGUOfXc2W7M2Kw21ufi5GqY70fLGFuSvQtp2ffnZmo7s8AaCD?=
 =?us-ascii?Q?KDtoSjQ5qBmZEFYaTkhsjRI8A5fUerE/wFeO9UBvqZsj6gAU+DDQFHgKkZh6?=
 =?us-ascii?Q?sd/JA4JHTu6JAKXA/s8gWe4PqLrhTRJPT5YPzUCPED4MkXkMffZhBnQL7m0e?=
 =?us-ascii?Q?LpO2K1659WkiPCMCsFafu3bRvyiKZ6MzwIUhdTyMRmMHlO9XheZn9dqkS9id?=
 =?us-ascii?Q?79DEMkcRoUEphArZbS2H+rHTUfOKSqaQmO+n2xtmx+HAptgDXCuO8e88+nef?=
 =?us-ascii?Q?rFJdF6O2aUv75VUS4tzsOGHVVFtNkNqbq/7yBXBaAm0ydlkHI9r+V412hnwL?=
 =?us-ascii?Q?nrbHio78SgRjzFLeix/77O4SV/yCrTxyEjbGN3gkoEEsvkv/vUtrqvKbEagY?=
 =?us-ascii?Q?h2C3BTw6ICMOvxp5aE5fr+fBBIHYxIg1iVI+uz7T2Ys8tsjjbVQK5NgEnas8?=
 =?us-ascii?Q?QM2fGpPxEvHA9kJfLHyHuuWxAYNRaLqD/OaozCh/f1hm6eXhXBFzWN3VWzPR?=
 =?us-ascii?Q?gIlrj2cAoseUqXhOUXMxaInBhDSWA28qCTiEdjmZa83D+xSm+ZBd1V0VKHgG?=
 =?us-ascii?Q?EmJufQkdKfjP/DhHb1IBA1VjzW+NDciwFuAHGi2EYx0JktQDZOTtnFdCv3Zj?=
 =?us-ascii?Q?/vM938j+FFc01vkRCEN/ArcmEmLtN9k3LNylU7DdQ3TzFh49Z/c8Kykn6z65?=
 =?us-ascii?Q?oJtKcdGUKFLMjbORwVD4fZHLk3aKmu+xihjZPWYMEnr56m7WwECJE3wmI2tq?=
 =?us-ascii?Q?foCtDrVoNwfSJKMWpyHEpqtkM7mZRO/FeanxQQ28VJnI2p1E/qUUqiFnALtO?=
 =?us-ascii?Q?iPs+LwjUAjfOygCNf7in3BMqQaS1nf5uGehIgLcgG1wQk+4h19CW6t/iMue7?=
 =?us-ascii?Q?n/uBnzKZLUI+OM5mBCT7N7o4AT4Y8udOf76vlR9Weq6Pf5OpAH4P3oX+m4GY?=
 =?us-ascii?Q?p11mBNVSSIKCN67oJ8YLYLYTUp4Rl+5oFnnqcAtHbNqr9x7zG4NspvYOF/oW?=
 =?us-ascii?Q?wTG4RQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 014c89ee-d4ac-45ed-d68b-08d9ec06628b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 19:57:21.8801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +TpSpYHv74e6umZBTG9PYSfmuu/E7z/b19M+QEu5Kl3rahNjmexAB/WyVrT+EbTipJ/TTJrnH1Ar/Y5AXQWh971v6KO6uSJAAjjpHJTd2d4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3721
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090106
X-Proofpoint-GUID: JtPs_LH4agUDwEAMv3heDCQFfOM9Y2FV
X-Proofpoint-ORIG-GUID: JtPs_LH4agUDwEAMv3heDCQFfOM9Y2FV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pr_debug() intends to display the memsz member, but the
parameter is actually the bufsz member (which is already
displayed). Correct this to display memsz value.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/crash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index e8326a8d1c5d..9730c88530fc 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -407,7 +407,7 @@ int crash_load_segments(struct kimage *image)
 	}
 	image->elf_load_addr = kbuf.mem;
 	pr_debug("Loaded ELF headers at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-		 image->elf_load_addr, kbuf.bufsz, kbuf.bufsz);
+		 image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
 
 	return ret;
 }
-- 
2.27.0

