Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24FD48A092
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243754AbiAJT6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:58:18 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:16166 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241296AbiAJT6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:58:14 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AJm2Lp026247;
        Mon, 10 Jan 2022 19:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ZgkuZ8r/VymLdhLJB2PMa9DE7jwyd1kzggyTkOXJs4M=;
 b=Sde0l2fxd/3QoMfViCjUQukoQ7IcqoPzaGMgXumVR2iILnNw5Pepscrm8u5kmboO6P61
 zU8iO/qktiPKAHk4YVp0cXc/3JqLMXCZhZD7bPvk6HsaJDQ3WElB/1Gml/FpVSx4x3xj
 b58q8nloeFxJHgocAwEk5ShXDfeAvTM/8h8dqPysxRBUJF3fbN4wi6GWSwe6GRi//7jW
 wEGGAqdL1XDFyw6dl7cFKbpSITEV53q1LeL75L/P3Q5OyJb6QHqoQHarmD691KHUdxDr
 fBmQvjuXD7xThPgwMZMtExZUsJgYL+dSISeQmWRRY2atj5jIcMMMoQeawTlte9+6XZJ0 Xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgp7nh0rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 19:57:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20AJtvbp110332;
        Mon, 10 Jan 2022 19:57:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3020.oracle.com with ESMTP id 3df2e3ravy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 19:57:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4o2lewWs6m2/z+YIq4vRpoaSR550Rq4DtGdAC9z3FQY/09lU1fAuHYZCv5QHiKRdmYKJi5GveDBnLS1UUXAQ15IfZOuVcgVG1d+EbUeCo/4WrNbSaZg/hawfH+qSMVkmWbdn9V+XA1rmtJOI2aNdqBqtzEE0fw+C9jmL05b1DGkT3fOzJmzty+ciNSLiflcclc+bYNeOp21tcm4DwZj6s4p8w2E7yhpWDn9cxALult8dkRJUgxn9lwwkJQGt6vVD+k2BiycRAXRNO8JgrvoP7FFVMJQdN8WQl9kIZlWVPHf7h7wIVkjlebkkW4TUKSxFcSFEo+9ndmwOnzjts+Hbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgkuZ8r/VymLdhLJB2PMa9DE7jwyd1kzggyTkOXJs4M=;
 b=VO+01SurI38g/2Ph8Cn0LBQAGyNg0Qa1NGNL5X90Ht+12miPYoBCOXB0waRklj7OwuwZX2o0v2oC854A+jpMhzio/zhVFfbaYTy1ciH3XJZ3oLhpEJ3DtLGoy9zD2wYEk7aKh8j7Bhiist7ID1bsIOR+F/cOzo+CjtT7tZ4YjwDlGGw4F5vgLyX+sCLV2QmVKBUaym5jShmVZRij3BO4cx5C4O7JwFdnGWzTkTl3Gv0k8XnYmZDZ673M/I7NpgQtc4imtW+7bm5+ysrYHtob1nQ2UIKHPWbFkllw5Yc4rcYyctrcLdlcxMszXsEjzsLo84d4Z4GrQkNkIJ9mvA/Qqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgkuZ8r/VymLdhLJB2PMa9DE7jwyd1kzggyTkOXJs4M=;
 b=GstXPGZJiGyihjT0hKXZd1caY2oPdUkE6q6wnohxjO9gmppsTbF7XmKVRIgjOa/F+yDYc3LEZ91jk913cOm0lssZ6rIr5b3O03AgYY62cHF4ll8FHE4syhYZdbnOuwQAXzYcDIB3++jN6RAw+syQJbIzlQCs7QLjbzBFBkLIgzo=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MWHPR10MB1711.namprd10.prod.outlook.com (2603:10b6:301:a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 19:57:46 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::d573:6cc0:c616:6f2c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::d573:6cc0:c616:6f2c%6]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 19:57:46 +0000
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
Subject: [PATCH v3 1/6] crash: fix minor typo/bug in debug message
Date:   Mon, 10 Jan 2022 14:57:22 -0500
Message-Id: <20220110195727.1682-2-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220110195727.1682-1-eric.devolder@oracle.com>
References: <20220110195727.1682-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0149.namprd11.prod.outlook.com
 (2603:10b6:806:131::34) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b131dbef-6381-43c1-8b97-08d9d4737891
X-MS-TrafficTypeDiagnostic: MWHPR10MB1711:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB171105624A4726E120C655D597509@MWHPR10MB1711.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fNq5cjSjgnjo1/WIN9phyJtviE/F9qi8j6RQJ/BAjFEnt2IRub/4vYAeHvfgDk6XDGaRCs4qQ0cKAe+YFj9UB0HiaKA6lY83hRJp5lvQnz4hYaWEjZGxmAazLHWRbPpRwrGJB1RRFu0IsfUf48+xOroESgOWCT+mSXZZ3dq+i7KhcwSGSbkrSfE+r5aGMuSMzuSVbEkIF8hUu978twMZU0W5WLDtKfXXbg3Sx/FtlOFS03ns0iPW8a9L4x8JsQYgQDiXBNjKtz+HvovBtlBpuNrNXmUTxrxzgbAiUGVj3l/KoDkYzc4u8tyRsfCn8rQcomkettA7vIKZVxu7bl95tEx8P0c1jcFXqLac9tdH9Qro/7Y9rYpa1u2EJ0JVcsKuZBnru/3i5zAA7Y5DbkcBUCBVBmGn7rPc00qOBM1Cl7H75ua7VsIpF9HjZQJf/jQG/6ppiPABEMLxlkfrq6Oe0wn5C+grlx8Ae8LYioZKf2WgC3D8hp0v2wXOYcKjbEPbp9+ug3utrnEBhwvszZYQmBxxthNeabS3/DdTL1Aq+ZZABbFbxhT6P2Fcg285prxIENhlxJgOI4zV3G/UsnbZyJ4CC9brSjFqOJZukrDBBDbGciFmI6nSynMor1845KASKddX74N3aBXEL4jaC0H2x/6V08w3abqXxi9OsO5ZmBkswN8kfPH5iBG61FtYyyLfHjR9EWEuh1A3r4JPZvS5wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(8936002)(4326008)(4744005)(66946007)(6486002)(1076003)(38350700002)(83380400001)(508600001)(5660300002)(6666004)(66556008)(86362001)(38100700002)(316002)(6506007)(26005)(186003)(7416002)(52116002)(2906002)(36756003)(66476007)(107886003)(6512007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?if/bfzC9AlSXsz0QElvEg4YtU9iljKP+CU3XtIxGxwbiKsQyUqiasWiQAg2P?=
 =?us-ascii?Q?o7dy5FJz8VBnFPyBxyWMimskTEMuCvLU9ycStRNYMxDcocEIxfBV+KOwNSVV?=
 =?us-ascii?Q?s0XYyEImXqWzbSy2jePsYQJ8u2aNXzF5Llw1TovRe5DeNQambND40+jtEICz?=
 =?us-ascii?Q?I+H8l0v7oZmHhPBrCkkIY3NLx4N0CUbKgcEwHyRo5l2wICeDCcZFCht9CYaM?=
 =?us-ascii?Q?1CiJaOBKHgUW61PIstF2sTBzYBmdG8PhiUmJq5T52nhGOzehuLE64dOKydYz?=
 =?us-ascii?Q?zVMWuJz8DTqlxrj6F/zA4PGIAP9QweKDu3Vbcupjq9NUxzIzoRi8DyNIRk6c?=
 =?us-ascii?Q?cIxAov1JKhAA3YPorawqC2+7rJykXzrcrXEfxzHm0EDUWT+YnN/XMUpeW0ut?=
 =?us-ascii?Q?9mvzXsTEGJwIAVklR7/ZYQ0CNTWwGx45hkFmBTIMx+7u6VawZPJKkgrvwJ24?=
 =?us-ascii?Q?PgAPm4TBzCGeuUS5Vx8TlmBpIRYvOSj4LnbQUa+N8JzFzikDMYC6wR79Yxc/?=
 =?us-ascii?Q?7mb4XrZn62Paf4/SptAr4P8z0ClEv/tAE8moGbKvepva/NiY1u4YDsqbDeQ6?=
 =?us-ascii?Q?l4H15WsWN2ZS7vLYCU+m0sILzwojW5kVfwMqBtc0+NSu5APnAPF0ROOLp+b2?=
 =?us-ascii?Q?vl9lLhHjhnjjemF9wNhSeX4iqyfCXQzPlTN3CLlDn7iaZD+D6xkTAwWwrPf8?=
 =?us-ascii?Q?6M3DrL0WrOBPjvUocfCx5jjAHycyLn+YsQzbeZUTOHSHnm6TCLr4L4739SXU?=
 =?us-ascii?Q?9dIq6//491WNogybLHn8msur436vlbK4boiH3EpuRRHw70Onfa+rscGMip79?=
 =?us-ascii?Q?HYisWSXjXRaCaBA2u+f1o7r1ZlgyxjDxXYceWXR596XMmpLA+Oplc6MIY++o?=
 =?us-ascii?Q?Mva8nTjZ1THDPZDVS7fQf5ClH5avM45H0ytvzCdQgFUdk/SDdxUHfM+pkYBt?=
 =?us-ascii?Q?eUlkcN3x3UfQ41z91hT1DljK+aduCI/c1dZrIZmXqLhiACABJIRP8ZXNB1h5?=
 =?us-ascii?Q?LIRmTnpMx4ZhW2cHCmGKBxYLA7gXc5NuDimL6qJ01IuqcBF/5nNiiOf13LyY?=
 =?us-ascii?Q?vBx9nIEuWTKz6s4eSYvxf4z2kQ9ZN/X8zwmYsKoKmtyikI0ti7eQCQGemmGI?=
 =?us-ascii?Q?dv5Sdc7Hx+eTCtKpwWmV1tbKQUDHkktmoFkqXKTQP08hJ4NcXoRcxnZo+Vsh?=
 =?us-ascii?Q?Ei1GGVl3azrEf8vSVeN7Om0lJos8PoqR7oVh5NjJE/UMjw5mBBchn32y8Xyg?=
 =?us-ascii?Q?GMKggJda8lGtD5P1OPji4eP8IJUXMSg2EHgYlnz5qvaIykAy8Haft8PQze/S?=
 =?us-ascii?Q?i2a/dQ8R7LdGiGApwjCAo19MKvcrPuUTvgnN+r11b9FKMM96FocEjkt3HGU1?=
 =?us-ascii?Q?kOVwsZCOXmFQ+fLP3IrMSe8QEJxZuYtrOeOIzTRDzEr06+ndLxEq6iOLIV/z?=
 =?us-ascii?Q?mjzR68N1x1MXHtIacGMIxct4SbAsA8tEuVr8X3/QLFFXC9WmmPYfiy5VVCeG?=
 =?us-ascii?Q?gk2nGJbWQkS1pF/LVQFT4Q3xz+qW1L2xS+lLouZdiwkgIFljUbtgfh16O/D8?=
 =?us-ascii?Q?e3kAWB958CD9wkEVU9GPI8HR4feJTlnneI0K7GNv92daP1ZuTLuFHIHCAcvS?=
 =?us-ascii?Q?rxzzIgrgSRPbjv6yvrqPBFyigVqsZ54P5ZjUWs/noI1Ef7pP7icIxjLAazv1?=
 =?us-ascii?Q?o82WnA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b131dbef-6381-43c1-8b97-08d9d4737891
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 19:57:46.1892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2BF8rlwWRUu3SwOjDXPvylu7T8dXcpEHjdUUVD1Tm+c240Jxxc3ubRAB9KcMs8Fl4oT+vwgL6rRIlQRFTckMa+WGsYXXQaJEgB9xqgaT1mM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1711
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100136
X-Proofpoint-GUID: 7AB86n4gpG8g-8I4p7ke7XAuaC2Or0_G
X-Proofpoint-ORIG-GUID: 7AB86n4gpG8g-8I4p7ke7XAuaC2Or0_G
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

