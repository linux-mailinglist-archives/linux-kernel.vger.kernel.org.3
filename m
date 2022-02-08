Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801D34AE13E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385189AbiBHSpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385349AbiBHSpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:45:01 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF91C03FEE0;
        Tue,  8 Feb 2022 10:44:51 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 218ILqQQ020213;
        Tue, 8 Feb 2022 18:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=EJD1NXkyPpVL2e6EUCJnMp0hne6/ZXEXfHgkebDyDt8=;
 b=vewfROWgWbldW7bfRzfJ6sczC8YwiiHI4dZtc++rDSKwaTw2lvFSCb2dEz547ROg+TPn
 c+efZ8hbxGzZsA1fhEqLfvqhomXeA89MXRav5DUq0oJdhI5sadHHYPBVZSwlBMu4GNTb
 bCYcz4rEGWQL6y7IodJtTrXaLoezaCALRitg494LSNcvx14bQfBEBT+2S46O8Spub4rs
 ekxx+/wVwMggyHdGDZYa4HwldKkvxSd0+ENVwZnU4y9zdgXZpCr188kfgZ9ehjQpVEr9
 pTf2s/Mv/OSzDEDEoZitP+3yO1quLLh+T9u/O27ODBXB3FA/aSr8i46vCKK+2uh8N+Cq yQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e366wus0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 18:44:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 218Ia5NH082722;
        Tue, 8 Feb 2022 18:44:22 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2048.outbound.protection.outlook.com [104.47.73.48])
        by aserp3030.oracle.com with ESMTP id 3e1f9fuvna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 18:44:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lx7YDPoCu0+I/YNIcLxjiyXRR8LXl2/Dn/Xqo601XsV8ouytUNlS3D1uiJqtFzFM4t62flLJDbkXO5adC1Jo7nQZZHSreJV9WrEqyNVQ71FFSRYdaBcIzZ3zVBSj6HvKuD++W7m83r8lKrSVHZn03dqKQsIOIfUhIo5/sUikOWmZc02q0vGUmfotSsQRckUta42rtIwIm/on0wfHvVv+vEtuAVL93PwC4BjeohbHHhfcmlz5QneK2TQLhTk33735qfMkJQ6kJlV4w02v4pJDrr3QD54FBB1XfxZQNzMSVMuFMRwV1HP8f2jx02B4zZaV5ZeCros7cG351rBdkO8UUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJD1NXkyPpVL2e6EUCJnMp0hne6/ZXEXfHgkebDyDt8=;
 b=CtkoBsoVv9b/mAwyD1EONLMAshVky9Pf1jvV4NLawE6a5OTNeEC/TslUqtCYqV6uOyfHdY7iDA6cPHrEEC6RRGm7Cbzlj6yJFJK3T9CDdGsZbsyCXBFASTgGiNQYovnBRSFuHSBe2jwgwdeEStcMX3KQBZFViK+W5QSjqJfr0mW6tlbnuANPpaqxa48esGd4oaR7y/0ktLlT12EG8d27gGwvemLVkuF6DLAlZGOE8ZFw70Ny3GQspfC+HFgUSdkLbXx4q3U7pG43f0dgUbQWYd0DiTThHQFvT2uzOyAPF5vrjXcqj/0YkZQH5HWxCqd7eXk8+UCU/X0RFrgUbyrlNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJD1NXkyPpVL2e6EUCJnMp0hne6/ZXEXfHgkebDyDt8=;
 b=xa2Lol9j9PzQ+rqC3MhDmetZym+G7RkD8FCc3L/iWox4FU96Udj7QebBBTJZ8PFGqa12L3UWrTZEOXsBqsaKLgulCl57BE6u7RakT/9hpocuH/nMrappiLBRpQhpLxfZJk2/oW1qRBJ1DzHbEEgC50Se5sewdhkszdBuXODjACY=
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by DM6PR10MB3114.namprd10.prod.outlook.com (2603:10b6:5:1a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 18:44:19 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::644e:5828:a72c:c1de]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::644e:5828:a72c:c1de%3]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 18:44:19 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, masahiroy@kernel.org
Cc:     jolsa@kernel.org, rostedt@goodmis.org, bas@baslab.org,
        tglozar@gmail.com, Ast-x64@protonmail.com, viktor.malik@gmail.com,
        dxu@dxuuu.xyz, acme@kernel.org, adrian.hunter@intel.com,
        ak@linux.intel.com, irogers@google.com,
        linux-kbuild@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v8 5/6] kallsyms: optimize .kallsyms_modules*
Date:   Tue,  8 Feb 2022 18:43:08 +0000
Message-Id: <20220208184309.148192-6-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.35.0.260.gb82b153193.dirty
In-Reply-To: <20220208184309.148192-1-nick.alcock@oracle.com>
References: <20220208184309.148192-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0088.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::21) To SA2PR10MB4715.namprd10.prod.outlook.com
 (2603:10b6:806:fb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10ef29cc-889d-477e-6eb6-08d9eb3303dc
X-MS-TrafficTypeDiagnostic: DM6PR10MB3114:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3114B2FC399CD5550D93E9FF8B2D9@DM6PR10MB3114.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /dO46U8shIzcEB+mbxdIwmNIYb6Z9M0inBqJ/uQf/LSa7J4sg9X3yvPl0yDQ32CbeYLuA7zuesfHgSclsUUlnkynElrk3AnQjeKLV7o6etbLhwB1Jktg2bvcHydZwGrAfJtMhihHXD2ZgAhYOnhyt5z2u9Z1JAYZv4LrEmpeNsabNnjBTFEWwEE2edoeb5FdYz9Hy06hQ4ZfMZ+m0QbR4l1IpXOaqZ4TewYEnKXc+xprFfHWmZGVLVoNAQdXywCVxhXQ+GOKIqFwYWBQ9SpA3JKrJ4Wa/kPG0DAwXx9b2FNx2MosfsjcaaR3YRVyP1jecFFUPEfJjerUlirI8jX8ze/UB9RJ4i+tUCioML/pcmHF2cLsDPN+tYAQPtJZo6Bnhn6XRmh030aH7CEVfy11RGw2mOPbpKXQBfU2Fi5tVCaz4wtmhVajH7Fs+zeprOg4jiXWOG/lwVSM3Q6/tlT9xjltIflJDbDM+aD6nkdwip1Id0k8UnIcI4TOYKjiPYCGUr6pbeNLY2FpbWTgEqZCJg9NmtJFOr1bje6AzzF+VqhraKxiZuOjFuSFqGLtpIh4e83cwKTnGre280SfnZVSKVbPXW3IA5PHJJ560hBbPqtmC9QncPQBRcMF5jmJWnTs7uFfmqS7HrVw7JTlgwb8JHfCpLgMIbs//rZtoINiAhKDTh8G9tg4I8o8thwzFohHX2370SE/O/s/UR14hUCNsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(508600001)(66556008)(86362001)(316002)(2616005)(6506007)(38100700002)(5660300002)(6512007)(44832011)(52116002)(1076003)(4326008)(8676002)(6666004)(83380400001)(30864003)(107886003)(2906002)(186003)(7416002)(66946007)(8936002)(66476007)(36756003)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ibdEeo0bnNT/BsXUVvhP+VTRvFa8uiBCYqgOffvzpdlfR/aDApUy2t3bOKek?=
 =?us-ascii?Q?kCGAzn6IQE5JQBqQEfv/M+A+1wPrSKFcDNth43dxY9oz0wx3aHZcELRUIT8T?=
 =?us-ascii?Q?secgDwO4aTk3gALcINwTHcpihWj6uhPy5sPsxmVmVH8YmvJDHfgqP8+Tnaof?=
 =?us-ascii?Q?RXW5JspKW5tmVG06cB8GAoBOrxTjYEmZ25HSAP8j5xnEhBG5kBOYaSLd+MtD?=
 =?us-ascii?Q?2xAcVR2JTqD3NCCVUac6/S8g+od5oNIr64IC+8v++1uAxYt4pU1UhPtvxgzX?=
 =?us-ascii?Q?+ZGT/nSCcwFXppjlJa/1r34aGwYhHjWd13Sv7IvXaf3WbYHfrYM1bxMl9suY?=
 =?us-ascii?Q?PjvdF0sNDJBJTO0kYdurT03GsjRso82SlGzXfG5biosY/QcD/AaQdITAwBaO?=
 =?us-ascii?Q?lqxFbX6E5hhBOdKPM1OJeE96fIhSVM++wLZ2BSQBoUucqBobvoCmUlXF7Dtv?=
 =?us-ascii?Q?hwmrAqgq2VWFOzoKx9wshNs25mGQoSxDtbdxTxUowiENZ4oiVi7FIXXxTdYh?=
 =?us-ascii?Q?Si7Q8BALhLU05jY7pc7ccUdv302svPqdMksMWTqEIyOsbyk1JuxOLvKIhtVV?=
 =?us-ascii?Q?Ru2Cm5o7Eex4dSxZPeAArF4odKT4whmw6VC8x5/Jciu5AIOn22jQy5qZrlzr?=
 =?us-ascii?Q?XjeG0drhrTKPrKTQwrNjTEGg+EqpVKeuX50b3ZVdYIbxIjy1vMTpE36wWpA5?=
 =?us-ascii?Q?McA1/hK3uqETheZWk3oE8vqSeV5uP9UYvVRQrEU4no5uMJ6kyv3cfbDTgQ2h?=
 =?us-ascii?Q?wa8uqXFPfQuSUZjU7WNXrTWi9CUlkUbKW8DKWf1uBzQ2LS+ZKzB3pxzdnIJU?=
 =?us-ascii?Q?zOQnu0m4jXEEIwZ3+MNJou3mOd3Nt/YjJaC4kuImd6Q8LbrETpQgdzqUT+VQ?=
 =?us-ascii?Q?29/qKZvZA0AKGkjc0KkwEdcoYRmzGwbpYu1i1yV+2feIoGXex4kayNulfP1q?=
 =?us-ascii?Q?yfz7xYMHTIHEKcIqufeQIGIblTOr6AsN2tQ5BRWCimA8yaKS5cAVdfgiZaFc?=
 =?us-ascii?Q?jVD5w7N7vSS74NahFPbSGwu/ZI6L6mRG6wqIdhlfEbQaJqQIip2yfLIRJ/lm?=
 =?us-ascii?Q?rEs7s3Wd6bwIrshAiYzheHw55rFLlLUNdJ/g9AOaWV87fG2tKnJLJmge/ojx?=
 =?us-ascii?Q?XlXJzWQQK5uNc/mDnGUjuGK0c3NFwrxIfJu8KSwiY7NCwacAmpVwxhz/HP5l?=
 =?us-ascii?Q?wi88/4sXZS63IlHVpRllpuS/xofsBtz+dMEstozeW/JbdAGZKHwNXwFGMfUt?=
 =?us-ascii?Q?DT+oiVbLnu47AF8glY5hthg8uqemlLT3BxhHNt9cWCINS0piRgYenE9eBjwQ?=
 =?us-ascii?Q?70o5I6mFkW8FvhwZBgAIEqlu47vQ57Pwo7mG+YfIj6Uq2gRTHluNg1+LgW2X?=
 =?us-ascii?Q?Gbd6qND8Ld4ZZR8H6W/2fHFog6cZgFQgFQLWe7U4vPXIFW6SIlvAScti8Y2j?=
 =?us-ascii?Q?mxvRaeBBR+doqCOyOzzEMVpZOdJedeqZzpjBpa1YGMR1hbRXruiSHIWg+HoO?=
 =?us-ascii?Q?AXQd89t/mNYsx3AX5Xrpevizt2LiYcnzPW8MOQEQT0DBcEzyCmpiv/lzNde1?=
 =?us-ascii?Q?8ju5plKepkV7mIi/n0qCQtqUFL4vgmFMkw7rrrU8m4O0CvVygoU5ESYTksty?=
 =?us-ascii?Q?Cp53wzCaeDX0sntPamLmF201y0zQ6vt2l2dtD6BIzRwu?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ef29cc-889d-477e-6eb6-08d9eb3303dc
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 18:44:19.1693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+gC7i0Kl3Ft2gCqbCJUmfsOmmTb9439tRfaQXnd4okgXVczx841syKlgMS2frelPiwm5VRgLsNKGyTLpm0A6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3114
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10252 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202080109
X-Proofpoint-GUID: apyUiTFpsP5UN8DOcHHDYKDWc4vlbFe1
X-Proofpoint-ORIG-GUID: apyUiTFpsP5UN8DOcHHDYKDWc4vlbFe1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These symbols are terribly inefficiently stored at the moment.  Add a
simple optimizer which fuses obj2mod_elem entries and uses this to
implement three cheap optimizations:

 - duplicate names are eliminated from .kallsyms_module_names.

 - entries in .kallsyms_modules which point at single-file modules which
   also appear in a multi-module list are redirected to point inside
   that list, and the single-file entry is dropped from
   .kallsyms_module_names.  Thus, modules which contain some object
   files shared with other modules and some object files exclusive to
   them do not double up the module name.  (There might still be some
   duplication between multiple multi-module lists, but this is an
   extremely marginal size effect, and resolving it would require an
   extra layer of lookup tables which would be even more complex, and
   incompressible to boot).

 - Entries in .kallsyms_modules that would contain the same value after
   the above optimizations are fused together, along with their
   corresponding .kallsyms_module_addresses/offsets entries.  Due to
   this fusion process, and because object files can be split apart into
   multiple parts by the linker for hot/cold partitioning and the like,
   entries in .kallsyms_module_addresses/offsets no longer correspond
   1:1 to object files, but more to some contiguous range of addresses
   which are guaranteed to belong to a single built-in module, but which
   may well stretch over multiple object files.

The optimizer's time complexity is O(log n) in the number of objfiles at
most (and probably much lower), so, given the relatively low number of
objfiles, its runtime overhead is in the noise.

Optimization reduces the overhead of the kallmodsyms tables by about
7500 items, dropping the .tmp_kallsyms2.o object file size by about
33KiB, leaving it 8672 bytes larger than before: a gain of .4%.

The vmlinux size is not yet affected because the variables are not used
and are eliminated by the linker: but if they were used (after the next
commit), the size impact of all of this on the final kernel is minimal:
in my testing, vmlinux grew by 0.17% (10824 bytes), and the compressed
vmlinux only grew by 0.08% (7552 bytes): though this is very
configuration-dependent, it seems likely to scale roughly with the
kernel as a whole.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>
---
 scripts/kallsyms.c | 267 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 258 insertions(+), 9 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 8f87b724d0fa..93fdf0dcf587 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -85,6 +85,17 @@ static unsigned int strhash(const char *s)
 	return hash;
 }
 
+static unsigned int memhash(char *s, size_t len)
+{
+	/* fnv32 hash */
+	unsigned int hash = 2166136261U;
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		hash = (hash ^ *(s + i)) * 0x01000193;
+	return hash;
+}
+
 #define OBJ2MOD_BITS 10
 #define OBJ2MOD_N (1 << OBJ2MOD_BITS)
 #define OBJ2MOD_MASK (OBJ2MOD_N - 1)
@@ -94,14 +105,24 @@ struct obj2mod_elem {
 	size_t nmods;			/* number of modules in "mods" */
 	size_t mods_size;		/* size of all mods together */
 	int mod_offset;			/* offset in .kallsyms_module_names */
+	/*
+	 * If set at emission time, this points at another obj2mod entry that
+	 * contains the module name we need (possibly at a slightly later
+	 * offset, if the entry is for an objfile that appears in many modules).
+	 */
+	struct obj2mod_elem *xref;
 	struct obj2mod_elem *obj2mod_next;
+	struct obj2mod_elem *mod2obj_next;
 };
 
 /*
- * Map from object files to obj2mod entries (a unique mapping).
+ * Map from object files to obj2mod entries (a unique mapping), and vice versa
+ * (not unique, but entries for objfiles in more than one module in this hash
+ * are ignored).
  */
 
 static struct obj2mod_elem *obj2mod[OBJ2MOD_N];
+static struct obj2mod_elem *mod2obj[OBJ2MOD_N];
 static size_t num_objfiles;
 
 /*
@@ -143,6 +164,8 @@ static void obj2mod_add(char *obj, char *mod)
 
 	elem = obj2mod_get(obj);
 	if (!elem) {
+		int j = strhash(mod) & OBJ2MOD_MASK;
+
 		elem = malloc(sizeof(struct obj2mod_elem));
 		if (!elem)
 			goto oom;
@@ -156,8 +179,15 @@ static void obj2mod_add(char *obj, char *mod)
 
 		elem->obj2mod_next = obj2mod[i];
 		obj2mod[i] = elem;
+		elem->mod2obj_next = mod2obj[j];
+		mod2obj[j] = elem;
 		num_objfiles++;
 	} else {
+		/*
+		 * TU appears in multiple modules.  mod2obj for this entry will
+		 * be ignored from now on, except insofar as it is needed to
+		 * maintain the hash chain.
+		 */
 		elem->mods = realloc(elem->mods, elem->mods_size +
 				     strlen(mod) + 1);
 		if (!elem->mods)
@@ -177,6 +207,164 @@ static void obj2mod_add(char *obj, char *mod)
 	fprintf(stderr, "kallsyms: out of memory\n");
 	exit(1);
 }
+
+/*
+ * Used inside optimize_obj2mod to identify duplicate module entries.
+ */
+struct obj2mod_modhash_elem {
+	struct obj2mod_elem *elem;
+	unsigned int modhash;		/* hash value of this entry */
+};
+
+static int qstrcmp(const void *a, const void *b)
+{
+	return strcmp((const char *) a, (const char *) b);
+}
+
+static int qmodhash(const void *a, const void *b)
+{
+	const struct obj2mod_modhash_elem *el_a = a;
+	const struct obj2mod_modhash_elem *el_b = b;
+	if (el_a->modhash < el_b->modhash)
+		return -1;
+	else if (el_a->modhash > el_b->modhash)
+		return 1;
+	return 0;
+}
+
+/*
+ * Associate all TUs in obj2mod which refer to the same module with a single
+ * obj2mod entry for emission, preferring to point into the module list in a
+ * multi-module objfile.
+ */
+static void optimize_obj2mod(void)
+{
+	size_t i;
+	size_t n = 0;
+	struct obj2mod_elem *elem;
+	struct obj2mod_elem *dedup;
+	/* An array of all obj2mod_elems, later sorted by hashval.  */
+	struct obj2mod_modhash_elem *uniq;
+	struct obj2mod_modhash_elem *last;
+
+	/*
+	 * Canonicalize all module lists by sorting them, then compute their
+	 * hash values.
+	 */
+	uniq = malloc(sizeof(struct obj2mod_modhash_elem) * num_objfiles);
+	if (uniq == NULL)
+		goto oom;
+
+	for (i = 0; i < OBJ2MOD_N; i++) {
+		for (elem = obj2mod[i]; elem; elem = elem->obj2mod_next) {
+			if (elem->nmods >= 2) {
+				char **sorter;
+				char *walk;
+				char *tmp_mods;
+				size_t j;
+
+				tmp_mods = malloc(elem->mods_size);
+				sorter = malloc(sizeof(char *) * elem->nmods);
+				if (sorter == NULL || tmp_mods == NULL)
+					goto oom;
+				memcpy(tmp_mods, elem->mods, elem->mods_size);
+
+				for (j = 0, walk = tmp_mods; j < elem->nmods;
+				     j++) {
+					sorter[j] = walk;
+					walk += strlen(walk) + 1;
+				}
+				qsort(sorter, elem->nmods, sizeof (char *),
+				      qstrcmp);
+				for (j = 0, walk = elem->mods; j < elem->nmods;
+				     j++) {
+					strcpy(walk, sorter[j]);
+					walk += strlen(walk) + 1;
+				}
+				free(tmp_mods);
+				free(sorter);
+			}
+
+			uniq[n].elem = elem;
+			uniq[n].modhash = memhash(elem->mods, elem->mods_size);
+			n++;
+		}
+	}
+
+	qsort (uniq, num_objfiles, sizeof (struct obj2mod_modhash_elem),
+	       qmodhash);
+
+	/*
+	 * Work over multimodule entries.  These must be emitted into
+	 * .kallsyms_module_names as a unit, but we can still optimize by
+	 * reusing some other identical entry.  Single-file modules are amenable
+	 * to the same optimization, but we avoid doing it for now so that we
+	 * can prefer to point them directly inside a multimodule entry.
+	 */
+	for (i = 0, last = NULL; i < num_objfiles; i++) {
+		const char *onemod;
+		size_t j;
+
+		if (uniq[i].elem->nmods < 2)
+			continue;
+
+		/* Duplicate multimodule.  Reuse the first we saw.  */
+		if (last != NULL && last->modhash == uniq[i].modhash) {
+			uniq[i].elem->xref = last->elem;
+			continue;
+		}
+
+		/*
+		 * Single-module entries relating to modules also emitted as
+		 * part of this multimodule entry can refer to it: later, we
+		 * will hunt down the right specific module name within this
+		 * multimodule entry and point directly to it.
+		 */
+		onemod = uniq[i].elem->mods;
+		for (j = uniq[i].elem->nmods; j > 0; j--) {
+			int h = strhash(onemod) & OBJ2MOD_MASK;
+
+			for (dedup = mod2obj[h]; dedup;
+			     dedup = dedup->mod2obj_next) {
+				if (dedup->nmods > 1)
+					continue;
+
+				if (strcmp(dedup->mods, onemod) != 0)
+					continue;
+				dedup->xref = uniq[i].elem;
+				assert (uniq[i].elem->xref == NULL);
+			}
+			onemod += strlen(onemod) + 1;
+		}
+
+		last = &uniq[i];
+	}
+
+	/*
+	 * Now traverse all single-module entries, xreffing every one that
+	 * relates to a given module to the first one we saw that refers to that
+	 * module.
+	 */
+	for (i = 0, last = NULL; i < num_objfiles; i++) {
+		if (uniq[i].elem->nmods > 1)
+			continue;
+
+		if (uniq[i].elem->xref != NULL)
+			continue;
+
+		/* Duplicate module name.  Reuse the first we saw.  */
+		if (last != NULL && last->modhash == uniq[i].modhash) {
+			uniq[i].elem->xref = last->elem;
+			assert (last->elem->xref == NULL);
+			continue;
+		}
+		last = &uniq[i];
+	}
+	return;
+oom:
+	fprintf(stderr, "kallsyms: out of memory optimizing module list\n");
+	exit(EXIT_FAILURE);
+}
 #endif /* CONFIG_KALLMODSYMS */
 
 static void usage(void)
@@ -479,7 +667,7 @@ static void output_kallmodsyms_modules(void)
 	size_t i;
 
 	/*
-	 * Traverse and emit, updating mod_offset accordingly.
+	 * Traverse and emit, chasing xref and updating mod_offset accordingly.
 	 * Emit a single \0 at the start, to encode non-modular objfiles.
 	 */
 	output_label("kallsyms_module_names");
@@ -489,9 +677,15 @@ static void output_kallmodsyms_modules(void)
 		     elem = elem->obj2mod_next) {
 			const char *onemod;
 			size_t i;
+			struct obj2mod_elem *out_elem = elem;
 
-			elem->mod_offset = offset;
-			onemod = elem->mods;
+			if (elem->xref)
+				out_elem = elem->xref;
+			if (out_elem->mod_offset != 0)
+				continue;	/* Already emitted.  */
+
+			out_elem->mod_offset = offset;
+			onemod = out_elem->mods;
 
 			/*
 			 * Technically this is a waste of space: we could just
@@ -500,13 +694,13 @@ static void output_kallmodsyms_modules(void)
 			 * entry, but doing it this way makes it more obvious
 			 * when an entry is a multimodule entry.
 			 */
-			if (elem->nmods != 1) {
+			if (out_elem->nmods != 1) {
 				printf("\t.byte\t0\n");
-				printf("\t.byte\t%zi\n", elem->nmods);
+				printf("\t.byte\t%zi\n", out_elem->nmods);
 				offset += 2;
 			}
 
-			for (i = elem->nmods; i > 0; i--) {
+			for (i = out_elem->nmods; i > 0; i--) {
 				printf("\t.asciz\t\"%s\"\n", onemod);
 				offset += strlen(onemod) + 1;
 				onemod += strlen(onemod) + 1;
@@ -533,6 +727,13 @@ static void output_kallmodsyms_objfiles(void)
 		long long offset;
 		int overflow;
 
+                /*
+                 * Fuse consecutive address ranges citing the same object file
+                 * into one.
+                 */
+                if (i > 0 && addrmap[i-1].objfile == addrmap[i].objfile)
+                        continue;
+
 		if (base_relative) {
 			if (!absolute_percpu) {
 				offset = addrmap[i].addr - relative_base;
@@ -558,6 +759,13 @@ static void output_kallmodsyms_objfiles(void)
 
 	for (i = 0; i < addrmap_num; i++) {
 		struct obj2mod_elem *elem = addrmap[i].objfile;
+		int orig_nmods;
+		const char *orig_modname;
+		int mod_offset;
+
+		if (i > 0 && addrmap[i-1].objfile == addrmap[i].objfile)
+			continue;
+
 		/*
 		 * Address range cites no object file: point at 0, the built-in
 		 * module.
@@ -568,13 +776,53 @@ static void output_kallmodsyms_objfiles(void)
 			continue;
 		}
 
+		orig_nmods = elem->nmods;
+		orig_modname = elem->mods;
+
+		/*
+		 * Chase down xrefs, if need be.  There can only be one layer of
+		 * these: from single-module entry to other single-module entry,
+		 * or from single- or multi-module entry to another multi-module
+		 * entry.  Single -> single and multi -> multi always points at
+		 * the start of the xref target, so its offset can be used as is.
+		 */
+		if (elem->xref)
+			elem = elem->xref;
+
+		if (elem->nmods == 1 || orig_nmods > 1)
+			mod_offset = elem->mod_offset;
+		else {
+			/*
+			 * If this is a reference from a single-module entry to
+			 * a multi-module entry, hunt down the offset to this
+			 * specific module's name (which is guaranteed to be
+			 * present: see optimize_obj2mod).
+			 */
+
+			size_t j = elem->nmods;
+			const char *onemod = elem->mods;
+			mod_offset = elem->mod_offset;
+
+			for (; j > 0; j--) {
+				if (strcmp(orig_modname, onemod) == 0)
+					break;
+				onemod += strlen(onemod) + 1;
+			}
+			assert (j > 0);
+			/*
+			 * +2 to skip the null byte and count at the start of
+			 * the multimodule entry.
+			 */
+			mod_offset += onemod - elem->mods + 2;
+		}
+
 		/*
 		 * Zero offset is the initial \0, there to catch uninitialized
 		 * obj2mod entries, and is forbidden.
 		 */
-		assert (elem->mod_offset != 0);
+		assert (mod_offset != 0);
 
-		printf("\t.long\t0x%x\n", elem->mod_offset);
+		printf("\t.long\t0x%x\n", mod_offset);
 		emitted_objfiles++;
 	}
 
@@ -1093,6 +1341,7 @@ static void read_modules(const char *modules_builtin)
 
 	free(module_name);
 	modules_thick_iter_free(i);
+	optimize_obj2mod();
 
 	/*
 	 * Read linker map.
-- 
2.35.0.260.gb82b153193.dirty

