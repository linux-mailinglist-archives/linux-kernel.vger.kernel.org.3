Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2A246C406
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 20:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241084AbhLGT44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 14:56:56 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:37474 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240657AbhLGT4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 14:56:31 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7I4cUm023471;
        Tue, 7 Dec 2021 19:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ZgkuZ8r/VymLdhLJB2PMa9DE7jwyd1kzggyTkOXJs4M=;
 b=HvcLw+g0B65TsUzz/UFXGjwOABCdq2R7CfxQHH8cIah6GtHV4t8FMzOaGJ2y9qDdUbci
 u2ZKgB4p8im97Pc496lLs2z3gSbRRUb2PYXQ6khymN2KhvFXkB6l54DcQRW+8ADnW/S4
 rFMKjwjc7vnnCmfU9Qu4j0U1rz/TydUSAG6+sQgpRXZKi07vIAaRKu3ib5ilUkssKFZv
 wjGr+kcKE/dK/MCbCH0n6sAgDfLVj6Pj0DBcNOcfCvBm2bQTu7vHh5U4PkxYkQ30LF7u
 gHYv+nmMadKzmuqGZxwOyf1p9NYAiAO53Iz2JqBGPI36vgtJP621y2D4c5XuRHFmL48S yQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csc72ee56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 19:52:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B7JjGnZ044941;
        Tue, 7 Dec 2021 19:52:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3030.oracle.com with ESMTP id 3csc4trbpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 19:52:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nd5V9ec0JHjY8E8fnGOniKUpIkY2r51nHDmhhZ41oj7bsCYz9vnQNjV/hHLPsHFacgtjzQKvAAKfga9OGQ5jTDKFrQ2GuKs7m7FMblNLB/Zn/VNKTjBh8tsoYG+ciB2pDz7xusA6559ZdTMmmJECZRPeZsSS9QGkPRxkaG/VLfsotKNbBWkjXDV2T17oRyGozFm7/nWoNkreW/MGAZhKjmlSLBVmT7bbY7uEbG/kWpECMDOk2xppN6cRZeeKgCgj2JGv1xArh7FZIOjk7Pd0Qv3w5tfbkEvCqq9zn6uQ58EUhanDCl8tHhqc8hgiAbA1LVYX9vQAKvDkb7xs4ioGcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgkuZ8r/VymLdhLJB2PMa9DE7jwyd1kzggyTkOXJs4M=;
 b=J6kwkP093wyTfkL7GZC8xA9AKRBHBNkaYLqvGZachUabeCkDsc+MVM99LcutcxetPAAsetCFxZ97IqObGvlf9AL3SD1HrcKHrCCnRLI+YakgpXFYXdJdT0aZhswPw9k79lVsZi8RE0QgarcRFEJHvZa0kSaQEkLSgm4Y9QQi9YXxazAOC2PM+pNIUQmUAVmg5brN51C4HjQnWPJqK5YDr3klZSOlw7gCKvtfEmjgNmF/zFUk1FOdiSgzo9m1z7q1i4jTQXJRY3nudyHlMKLcN/mjwkcjDkkrcWZ85jlh5h6RbNFUeB5Bz7JCQcYhHlH940JmLDn2ijH8DXFtW6yDjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgkuZ8r/VymLdhLJB2PMa9DE7jwyd1kzggyTkOXJs4M=;
 b=zFBwBQZZSMTLcgn2qbkcfPVlJtjKXtpDW9lRbXPC/YL+7LiBfmif1w2LoirdqBi3nE3yWQTIStWa27oPqTD57nYbQMoYnY5LO6psPFabfJzt7lv2mZiLM75bIkNnpilm9XkFtCBT6ZNKtGULyVJ0mMEf2IxYl1Tg66QwGc7l1Mo=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MWHPR10MB1695.namprd10.prod.outlook.com (2603:10b6:301:7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 19:52:20 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::143c:ea64:7017:19f]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::143c:ea64:7017:19f%4]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 19:52:20 +0000
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
Subject: [RFC v2 1/6] crash: fix minor typo/bug in debug message
Date:   Tue,  7 Dec 2021 14:51:59 -0500
Message-Id: <20211207195204.1582-2-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211207195204.1582-1-eric.devolder@oracle.com>
References: <20211207195204.1582-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0210.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::35) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
Received: from localhost.localdomain (138.3.201.23) by SA0PR11CA0210.namprd11.prod.outlook.com (2603:10b6:806:1bc::35) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 7 Dec 2021 19:52:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dddf7290-37b7-40ac-2fb1-08d9b9bb148c
X-MS-TrafficTypeDiagnostic: MWHPR10MB1695:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1695AE1385308D3A4CCB9BB3976E9@MWHPR10MB1695.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SnGSFsCPyab3JSWRCROR6s4+jUR/8QreR6bf0SCU/imTAkEuz2QgCqeKbE0uJSc4433TnUp5ckDgX2czR73XnX4k6acSwRMOex32fw/uZ5fMAgJ8vi0Q92Df4/7/nFfQKAg/2BTg9G+NsbS2enSa4zJDwFA82w8t8CIu2MT0rx3+pAXJqypv4Lks1PYpGD1lGsR2LCDtsZTx73KfUiEI12ChfPlRvbhnY/HwjNYEJ+z99EG8cBpv1+NNKAD0vETk1ThMAvcWHLZiCYKFDbbCRCh1m7zHwQ4N5x25LaZUEkB8xRaysa6mtgenDKFh5+Hd6lHFoah+SSkS3xpuThu08JpLBNVj9HqfVNlmew7OEnvr4XYTDl9rdB4z+cLwVdhJkqfVTOL+YryejDKUNbh4HpFfd+txQvDiHzIipWO2esdFFz/xIywlEk189WR4DnnXfoym5sscVzAN5HSeG11hDUpLjTH7qHnhK5/Ph1jLKYBrcvEpiEx0lSRdVFTujpflLhBhpIZmnlHkWL/5FmOUbsXvbhuLJirYEjgsNMyQzj2I4Ia3mQatLhR4vfcqC37E4TwcZTjCSmsJZa0RTVcAu8nGHgCAKGotJepoAiDbV0z5hqS83PmAd97iNBq5AD1KIQHDz7W3Rcuj4o/oFw1SIf0OWgdaNrwFtVB42yDRRZ4YfeDbam1PNxyEUtuo+mQBRQhQ7ddHYYtYRRyIQg+VBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(508600001)(7416002)(6486002)(36756003)(4326008)(6512007)(6506007)(8936002)(66556008)(38100700002)(2616005)(52116002)(38350700002)(26005)(186003)(6666004)(2906002)(86362001)(956004)(107886003)(66476007)(5660300002)(4744005)(66946007)(1076003)(83380400001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rBtiix9ObqwhYYY8EB6/2NDVaYwygx9Sr4InbIvraWpP/lWB65ClWrs5trbG?=
 =?us-ascii?Q?h2+Wakubc7V7TUgtHuwxYrBtRso8iLzXBmFMkdo1uu/o79qkIP9K2G/uX223?=
 =?us-ascii?Q?2AWYcqZ8Kyju/0cbVM5lYbSjfWbSfggyx0VzDCdjk8Lhgb0CDLAvTFe1DGf5?=
 =?us-ascii?Q?e1wIuOpGKW7WsxdgkwWZKJ1Z+gDX3RM9Vcg7N1bdwctAthvqlu6bVXLqyiZt?=
 =?us-ascii?Q?16wDqu2Vvis7KtPzfFcCdcu87IYmyhaHlgoEI4iEdmMSBsqaRGDI82889asO?=
 =?us-ascii?Q?XqI9NazfEg3muCuaImcaZ2pQ3BoegbB7uaw57PR/JwwW75Q858xsIL1W6h/p?=
 =?us-ascii?Q?iMG1L6Q8qT4E+Mq6glaMkLT3HnzsZWFIaidMID2RzFkS6i0I11kNyTAd73/9?=
 =?us-ascii?Q?IgRt0vB/mI98XuPBgU4ippyit7msrEW7o6/9LSBbeSZ+gCTL6Fyr0xNw27dJ?=
 =?us-ascii?Q?6TWSsPcd6FJD66WeuPvoIdO8pyi5Ke4ojsrFbhD4Obawj0AmZ183o8zzHRiR?=
 =?us-ascii?Q?qXkzP/3vbuXhlVZ1Rw2pQci9N8Vnwdn/8IJLkFM6u9geqgPCzw064GHOf6vX?=
 =?us-ascii?Q?vVsvjG3wp6YYdSg4R++9THovheQyQclnvnYtDhlNBjugZ41/n+CE8St5WA2P?=
 =?us-ascii?Q?SSyXlI+Wf+hlJYKvauC7whTBqyasZ34NspAeXUNT5aEjTJ78h6/szFS42iGZ?=
 =?us-ascii?Q?rxmKvJYFsmfs+xJD5TRXdH6WMHdfLUCUjDOKki63OLa8LkYtmLwNoYo1nx0c?=
 =?us-ascii?Q?fXLpPOConic8PT1fBijqnmVsrC0ouK4aCrUTi/ijQXTtVebPOPxthaAk0Nh2?=
 =?us-ascii?Q?n8+tkydh0936XsXFZSkmhy2873Y9jhHOpWhH0YuLbCGRQ5L+942WZVappo7V?=
 =?us-ascii?Q?BeNCvi6B+KZ+LmOouCMOs/XqlHj0zdGrMeJxWZUtN9Q/826+Jx2D4WgZg0a8?=
 =?us-ascii?Q?tplLmutaqbosgodRRUZEC54C38QtKL8lWoSBo31vGdnyAVh1kX6g99nYEz1b?=
 =?us-ascii?Q?8AunR1CJ+PhYtaGuN/MERRdg0OxHYXwFBMh7Ihgy27QfM/ZJnfxkBWnHPFIr?=
 =?us-ascii?Q?+yL4tVnADmnVN6PVVRazj8Ux2KTuhC3QkNZnPKtA1ExNURCpyxIr6U3aEGBI?=
 =?us-ascii?Q?lxVQHxgrZXRV5FRmCHR0JclV4vHTWDFxVbCj5wWAkn+yciCyVgDvMotT1ukO?=
 =?us-ascii?Q?ryQeOY6qs6MBE9fFc29bKyZJqZoRuk3Sv9j/kiOYYmLqVHiPaGZmxGHJiMST?=
 =?us-ascii?Q?HGSxsV0ezavv4I1njjspFD8+cI7znH2+TF0runBOCwO7KBX9gG2W5dafCDID?=
 =?us-ascii?Q?cWnlx3aTVVKJJG+Ge8TfXBRrF+Vf08NgVrhjLRA6ScgBYeIoVkBSs9cBdQ0h?=
 =?us-ascii?Q?ROFEYIYKJhea3LCzFslkw6lSAne5ZIr88RGbb5O7/P3rqq4kFrcKD+nXMD6o?=
 =?us-ascii?Q?7QQMpnwyFiAueintWBD8tFGBZfrH/pGTuRK9kETbyUxSzEzDxqAWwhTeO0T/?=
 =?us-ascii?Q?6Pm+FJZS22D/POZAvxh9e3mcrlLqTBybgC4T1R+guzLoEx9jUV3nux34hrAH?=
 =?us-ascii?Q?2XIylUFRqwGBrTjOis1YWn/eIwgh0y3mwO9hzg6kN8iBbQoiIoo4BSkY1t4I?=
 =?us-ascii?Q?YwBWOdnlHIkHIkqdGEDDfz7t2VfER91RtCr+cTqe2LC/dHi2JI4sNoyN4AtJ?=
 =?us-ascii?Q?egmwpg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dddf7290-37b7-40ac-2fb1-08d9b9bb148c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 19:52:20.6577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WtqBCh0BR7PCnGeIoZN91CPX6ZfOdGde2gfJTinRdPD8hOnkq0rmjpHKXy6MyAuV9GUSHDeb3xnNKCPYJZh4v8iK8IqrZoSVTdCGXPWrJXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1695
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10191 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070124
X-Proofpoint-ORIG-GUID: qVQ_fqFR1SL_REKz53egt0QKVYzZpX8w
X-Proofpoint-GUID: qVQ_fqFR1SL_REKz53egt0QKVYzZpX8w
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

