Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61539573D69
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 21:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbiGMT6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 15:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiGMT6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 15:58:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7110B2C105
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 12:58:28 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DJDoxY009777;
        Wed, 13 Jul 2022 19:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=qKbA3EXQWQxsjQj+nfzryOF4T2rgmG6ahpb+WfQkEYI=;
 b=MjwmRmrMgcK7aJaJMQKVQXQXS1BH9f6t3ePueezTKRNOb1Ux98O+2FROdUKk0/39HBCE
 +TaC7kRQUtPpkXOpk4IJC38icAEqcuOch9ihkSEFnXRCyC72P3DxK4yaHVx7qo2Yn3Qp
 ZmX3aXAGWNeyuwxXEn9Jqm/T6QCVB6gSgMk6FoZrDPMZ0ab62/q/xocsKqg7CvBfa2R4
 qsswluZ+cWCBViP0lDSDJYIEgzXa0ZsydkzOhus+KThYaINm1MFHSBA3p9VI0XF93HrK
 waaWSJyjcufCwoOD6W2+lcujYOAx5LSKbcO1ZCgdoej/33ixPijM5P/4xKUT0XfSGSkS HQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71r1aw8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 19:58:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26DJ5ptO018045;
        Wed, 13 Jul 2022 19:58:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7045gdu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 19:58:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NraO4U+I8dXDABap3AKKavnevByS2xzMZ5JlILGGeJ11/KLJZa00s7CvkvYlnKgSSPemyMlIhfR+dahRiU8Lzxe/H0OcGG7uf+7Fqv3CVD4XYip6AhTre7FIY9hp34zmg4ADPSjZhzhowWYfIkfuGuJH/E5mY5aYdHYfDG26YP2SZGY8+QvMBFTCFGJZSaXchdz6e5spf7wzA0wMphvCIn2YfuvJIcWeb+gpJz0FFFFx7t+YcLGDOjbz8lMA3jb5lgBRrZS5iqcI7pg9do24NSL1/LRBrP78gXddIkQiLbIzfBI915j1HFmSOVF/yt1lXrkxXPt+zdi5LBVFQ8c77g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKbA3EXQWQxsjQj+nfzryOF4T2rgmG6ahpb+WfQkEYI=;
 b=DbXZIzUvLhZwYC/1I4v/Oiq4KBSTphvQlQJ+tG8XgYI0DiSiQ6/ycYP8rWIlqmZm9jQha8REzhFqEidflurLGDSoP+ASgkU4ZC1B2jBPvQdSWlQpoHMOrQuQXqYGIthcAVAMntgwWlZLutLu4OSimmuLbkCUMYew1lOE+9rTPnEepTgu3DoKRep2v3kwyuzcEGyJlI7PvdfN5cZ2IjGTi+OrpRTzWXECSkR/6/NWV01yzvjfkzippdvhEZSmoeRCi8eDof9vaGPQ0DmVYkqorjOIywJvLND2TA+77C0dUqScWOx608pBED8HcmMsTsIBTmFm2Uc8MIyWMjObUKhMJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKbA3EXQWQxsjQj+nfzryOF4T2rgmG6ahpb+WfQkEYI=;
 b=YLGWjAK3j7WvLKjoD73FH8u99uG967C7KkVigKsU11GGwy99BYOx8GnfieX/uhAEY4BNd2rIx9DelLwUVUyZfJ0t14bLj+N0DZ1fI1xUVielIQXKqHF4HQ16gLVBPFUsW08kOPRpO4FRdncZOIMgaMORtuP7/Ucav/7h8AFsiaM=
Received: from SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18)
 by DM6PR10MB2634.namprd10.prod.outlook.com (2603:10b6:5:ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Wed, 13 Jul
 2022 19:58:08 +0000
Received: from SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::3579:b754:7f20:b262]) by SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::3579:b754:7f20:b262%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 19:58:08 +0000
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     peterz@infradead.org, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     konrad.wilk@oracle.com, alexandre.chartre@oracle.com,
        boris.ostrovsky@oracle.com, ankur.a.arora@oracle.com,
        maciej.szmigiero@oracle.com
Subject: [PATCH] x86/entry: Remove UNTRAIN_RET from native_irq_return_ldt
Date:   Wed, 13 Jul 2022 21:58:08 +0200
Message-Id: <20220713195808.452394-1-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1PR01CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:102::26) To SN4PR10MB5622.namprd10.prod.outlook.com
 (2603:10b6:806:209::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fe73b58-0caf-490c-d4b9-08da650a015a
X-MS-TrafficTypeDiagnostic: DM6PR10MB2634:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IZ++PsvIU49is84Zq9zdaCn5PV3lzSWI9yp+3+qjRgGK4iY2D/Nyku1+vFonijJUfmctMviijMhN+DYSNPtEas+Ff5Jy15A74gBwPrgbZAmZritOTyn9UjIK/uYSFOL7R0SKafUTrEisYy/TEV03fxGLy76S9zLK2s8qEBuCuL2tSeO/HAjkiB+9sQWAQFY8l8/Qme31g7a4D56cQPmZsqMeJo3EN2CEaieK3oifIUo/A1riaY+k2yDtV/tNkRjcB09XauQM4ymMoevpqt8qWFfoAUYzgq23/0vKpcEZ8HEo3rVa/K8CGTiOvHvFJoGOQehhQa7K9Om/z26cC2x5nuwqNue1PFmU82l+0e+9fLpbf88F2XHmnVeMNqygnHQ7jDWpY2+I8Llykyp/vopGP+7SgXn445AlzobadTqmholmQ9G2kOajGOUxhytvNUzwr3snoAnTfcRFNn8954L85Bng4yc4Th1swwcChveUqh/+cQxvTuNYqdlsfR7XQWksvYAID+ESVOlIcRc5GNwr8XpK5oYC9a2QAvcB7FKI1M3HjhxV9+s1cjVCHdadIUk2wsEYfqTGC2Oj+riKT6j7Ve2c9Tvfya3uBGDAnWINZSbuDCfSJiUpDEsYjfBYxQ08iemRy3hQzg7uYh53G8apJ2HZOdNgNhkrtAODWcdpAaqBDEAuz080GdFeEEZ3PdkRvfGjmpG3fI8c22VjhO4tE+6pjuFNTdf1l3wU0ch4jq79ASyTTW4CYAVrO7RelOHP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(396003)(39860400002)(376002)(136003)(8676002)(83380400001)(4326008)(66946007)(66476007)(38100700002)(107886003)(1076003)(8936002)(66556008)(186003)(2616005)(86362001)(2906002)(316002)(44832011)(6506007)(5660300002)(6512007)(6486002)(41300700001)(36756003)(26005)(478600001)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uIsPe7f79l/4WIbxmREtis2DTxcSp2+0RgnfWVziidJg38VV8V/a8MLzH3dj?=
 =?us-ascii?Q?N6NUUiE4eaV7iVl0nxWJKzDSuKTunUCrMV1RTdWTdrA6nFim/POzHgltZ3N+?=
 =?us-ascii?Q?IV7W+E4dwZdHwRUXEXgZhGQI3neQne1NfHpgrzYWSPAzXOEFGUD+w1qLtgQM?=
 =?us-ascii?Q?KTz+hfINphoYQvkGGjED1BwhKvQKrnZyYYqd9Lm+yfst+RBLvmrXbhU7UpLt?=
 =?us-ascii?Q?BMXuEL3XJi02jbOrAcn2qEVVE5VE+evzEkM1wlFnfFC4YI+v8MzlSXONALwe?=
 =?us-ascii?Q?QBfjEcf09UPhfglnYgGf7Xp5FZajgHskdBJWNesmxqJ3bH4bzhIHz7vMZ6op?=
 =?us-ascii?Q?04YeUmgPGukffppKLE5qDs2e6EmDOTSFZL+YDaTneg28hV7lgPP9qjY3JHgk?=
 =?us-ascii?Q?qbD2EB10bemnGeuUaOPynWXH8fgyMEJJP6fbOK0TcB4X1rrl5w+sOo0/tfR1?=
 =?us-ascii?Q?N77g0czaaulqUQQ9TaPuZL2SDTcO3qHsT8DVs31ekdL+ZnMQZttcoUMtZKBR?=
 =?us-ascii?Q?g4QUT3G8o5RwK+9x2VpD8x/YirPlbE+6TDaEz8XKu7K73lg4RVVMiIvANFUr?=
 =?us-ascii?Q?bqF7KZZqdm6ucOT7W/uTqEGufa0AUAl3qdrSIO9AlrBkBAwuK68G3dLlpOip?=
 =?us-ascii?Q?fAIU6W4x7gtJUZHHXROz/PUei7BDcPvfleOyFKjQv5pQKXf4WDlHJ8PV9A/b?=
 =?us-ascii?Q?Ix4M/toB6zwUjkfXQTaP20eDhn5cLOjGagZAQy9nq/PbT4y1zZaMBoIfJmyQ?=
 =?us-ascii?Q?wSnsBN+kd5hRBYBtcYCbYHRUFuAB+mGEtNCZPVp2iIFMgm7M6x0T6lSPQoTb?=
 =?us-ascii?Q?y89S0KVJuyxcyy3hjmrhpI5JRBOIaNLx3f7raQtQpZTdzETZALyvqQ3CMYRe?=
 =?us-ascii?Q?RBg02yJYSomHycz/c2Ad/k8DaqOPxi+p0SqJ2iIs0SF+UJSC2LZfjU4EzowU?=
 =?us-ascii?Q?byQ+kG2140kzNCQO0Q7iWbP+wm1u2WckSmZzlVLpk1mkdL1fyst/C978M0vz?=
 =?us-ascii?Q?csqhWLD5YI8x6t6dtHk2OWNIh3yPPaF/vQdYqBM95Hsg0vocX+IBUjMaPX69?=
 =?us-ascii?Q?ZMBNEosOVpaeCtHh9g8J4YUrkGA3yLyGyDUX4Fui0m85S+WyHlEKwFGCmyVH?=
 =?us-ascii?Q?K7kua8eNfGfdRNURPV2nbr2ijF3q3cK9NZzkj72/1Mas5a4Eud3iO0MORv0n?=
 =?us-ascii?Q?RqVqOw88kGhAeoHIwSzUVBrFwr1EufmBindSxLMr9rXEc4/KxgilbJGf9WmM?=
 =?us-ascii?Q?s1MENnfZ5QpaztlkCakI6Ib7sjDNhjXytC8lQJ+QnGrMaU147i+ryonsNV1T?=
 =?us-ascii?Q?goghUBslZSrxP4HGwNlXVks+SXn6CcgsuDp2YZNWKY9J/QtJu5QHbnjR8M2D?=
 =?us-ascii?Q?huLlrNUPb7PCdHEXjyN+DR+u6mfR8ZYaUNYKq4Vt/l+qwp3NkAHhvj5uMflA?=
 =?us-ascii?Q?Nk1gAN8ta++pv37kW0cxywhwkroCRUNygHhrxpFYWd8rUlQ0z+hqYKoMy+oJ?=
 =?us-ascii?Q?gkPMJwwdec4urbD8LNbc2KmK7k/KeW8xvdTxNFb0RAd8LdDHhy6vu/CXAu33?=
 =?us-ascii?Q?qCARuz5J6d4KOzLCxv/jjBNVUWRKY326+EIASnHyHS1/og22sRqY2T9dl6gL?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe73b58-0caf-490c-d4b9-08da650a015a
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 19:58:08.0809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfo2CY4Zr6yIOkEtRpcC/Lmr4dGKxmPU9ZYWOjnarr+1YNWnP6J+k4MrlDiUMja0uJHMWcsGMuko/cZ5dCkJeICY2rTXCW3pAHKiPryTcbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2634
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-13_07:2022-07-13,2022-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207130073
X-Proofpoint-ORIG-GUID: Mcfah_21eolcHOZqKh89N_KXaV1py_SV
X-Proofpoint-GUID: Mcfah_21eolcHOZqKh89N_KXaV1py_SV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UNTRAIN_RET is not needed in native_irq_return_ldt because ret untrain
has already be done at this point. In addition, when the RETBleed
mitigation is IBPB, UNTRAIN_RET clobbers several registers (AX, CX, DX)
so here it trashes user values which are in these registers.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/entry/entry_64.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 285e043a3e40..9953d966d124 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -727,7 +727,6 @@ native_irq_return_ldt:
 	pushq	%rdi				/* Stash user RDI */
 	swapgs					/* to kernel GS */
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi	/* to kernel CR3 */
-	UNTRAIN_RET
 
 	movq	PER_CPU_VAR(espfix_waddr), %rdi
 	movq	%rax, (0*8)(%rdi)		/* user RAX */
-- 
2.31.1

