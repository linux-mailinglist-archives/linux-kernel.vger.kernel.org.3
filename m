Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051344C4723
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbiBYONN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbiBYOMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:12:49 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CAC16DAF1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:12:16 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21PDk5Pg017417;
        Fri, 25 Feb 2022 14:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=EeFqO3Q1ZO0qVBwp7OJ9bX9vYchbygP0Rhcm1mbQGbg=;
 b=UHwyByoiAu4FGvWkBP4I8D+iHq6/lFkjLYGejgk06u754KT/NLwApaSLUzy6tRinLQie
 sT1JhVdDJhbNIT7PNNDT74WrllKRNknXkoqNPg0XfFV/T1ceZJarOwMw8myhs4l4geTc
 u2QgvgKcnkcVcsuRUWIJV2/il3PNkcY8OTKjh7UjhGLEs6r+9jBamyoQVdNBXC9rz8xL
 7nWZ5hMXKprDNfjnLtSVqVVMsGyOnp+onjzoeBcCOwNr0J1cVsJktLaFzcm86e2AHC65
 LYRqzalXxwAVpU0Oi5a5e5GRt1KoxyeVjTpflakVb2W8Z/AkPqwlMZqIFu0zFgmtlMGr pA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ef09pr60b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 14:12:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21PEB2nw069584;
        Fri, 25 Feb 2022 14:11:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by aserp3030.oracle.com with ESMTP id 3eapkmvf11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 14:11:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEb5EZ1c9UPajH4W2ohgNprskgBBFAYivnweXYuJ96riElIDE6dK0vA6VbLh5cQAeWWfZbpeJ2F1notFuwd/8kHzhUggXVrOEJPJe2+TLg++s6+VsTDBrxCVJQuMKznFTUtLKu2e6eX6CSCcOSC8KIyMyEVkkqXgB5wipe2oZuQDYYXNwAJmBWIOWKNjGzX6LBRXeWE0YZa+LzZ0dbPpihVsWn0eiOxeDoOsBIqBqVXBWPc7xCpcYWxiDBRhDCr7a0cUElwQrSfpT0fH6Nbd5DaOyg3GPTgUnXFHMrnetFMNWCvM52dmoQTrMjsMzPfUZZY6Nxiu87LsU5yiFhDzJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeFqO3Q1ZO0qVBwp7OJ9bX9vYchbygP0Rhcm1mbQGbg=;
 b=Iv6JBSQFJdJS6gf+PER1HYbF+tb58Qnz6R3gjZZTk5s8fW6FqujP7MUV8hNaKTP2tzvAfBvnENBPKVNLdv6qw68bYVLrcQhG4bmUOunDtuILOCLmOQ/rxDObNVUI4oITEKvI6Xk8dNTav9sL/1Bjzu1kbGMR/fHc2grrb0p8nwAk24DfACDD/blmLLmjh8NFn7Gg1cj0Yq3aoXW0MzxFM4qQRmlcNDPVUyTScpXDj41Zc+QybGigJBWGsrRFv4FA9r8xljKSysMBOrV+W6HxoYCv9FKHW6f9HKpQU+MqjVBhsWV2dSy++qFFelpdW7InP/GHPPF6YMNx+vU8R2GrWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeFqO3Q1ZO0qVBwp7OJ9bX9vYchbygP0Rhcm1mbQGbg=;
 b=TIYa6Dij+TnAA4Nf5fjl/PDBsS181GSebPJyZg5jVsBWgnaiV2hRpwCb1o6cfWajvWZ8cMml830JBl3htb/6+p0w1O+jSiqlINPDkbHHNfM0fawHwRi9gH9RDPJkbW4pv5p2svCimvfmhteGhoNjc+pPrM3oZknp/Lsp21u1jzs=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by MN2PR10MB3328.namprd10.prod.outlook.com (2603:10b6:208:127::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 14:11:57 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a825:7455:e3c8:3b65]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a825:7455:e3c8:3b65%7]) with mapi id 15.20.5017.026; Fri, 25 Feb 2022
 14:11:57 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     ross.philipson@oracle.com, daniel.kiper@oracle.com,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        dave.hansen@linux.intel.com, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v2 1/2] x86/boot: Fix memremap of setup_indirect structures
Date:   Wed, 23 Feb 2022 21:07:35 -0500
Message-Id: <1645668456-22036-2-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1645668456-22036-1-git-send-email-ross.philipson@oracle.com>
References: <1645668456-22036-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0019.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::32) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0de1aa32-7728-4da7-6157-08d9f868c81e
X-MS-TrafficTypeDiagnostic: MN2PR10MB3328:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB33285C9307AA9DD9DF6623E3E63E9@MN2PR10MB3328.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tmindxeXHEscuVjVfQngNPB02uzufmIMj3HtX+4Cc9yU8dwBNWWWMoJK/kKwwdprpvgdcUxjv9lkj3IlJILUeZi2uWKdj7XkvKZq/vZbixwygNYzZGeFgODd+LDTPR+zUJh2iOPEJaJcll3VNINeRa6zBeJs9CryeglutcKENjTmJ/KkPW4S4tWD6glujv/tcY7rj4w1rWeSUU50gwmYkG9rETJi93z1GU0wMVzrPzJa5pCxcflPiEuHgfsQvZJIBgqo0TccJgWwwxX+5oGmv2a34OkRTPS3zp3ekvvUTtgpQ2KcOi5ADC5PGrsdQaplCvCV+PwFR/o+LijO9BfUGZFTkblhyhPiyxNWt/XgJP+oU4+IRUmBlCoh1tjDrTJJmDzg+MaF5Hce/OPzJpawc4M17YXI/xwg1WCqqZojEC70btDSLxnjZ1MjbUE1IaVi/XraM+2nZZz14y5u/BqHTdDoo5Tr9Veivvu0dVFpsoxGDuGa3f7PtMmzRG2CLowdPLkLk2zFfodyKHYEjYaW8hni3P3girFVE7T7bwQu90UYOre06yiLXhtZgf5I9LCGVjVi7oEBCgDCQ2IrDvCRy3piw2700dWPkKZfz29/t/GBRd6QAYJCw0FuQ97TcZm7b4wlylGNAAJu5WpCH8Za/d4dbcxJ03m6QtpAj4FAiCfHUZkcDERwSz4vUkK85Cqh57wQlZ+o38Cots+e4++xOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6486002)(4326008)(66476007)(38100700002)(66556008)(2616005)(66946007)(83380400001)(186003)(8676002)(26005)(6506007)(6666004)(6512007)(52116002)(2906002)(44832011)(8936002)(38350700002)(36756003)(86362001)(508600001)(30864003)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dhb5MH4OmWNDnEYvvpVa/ZwU3eGGJPnTnyM1DYgBOrOBP1IHFfjHOxEddtfx?=
 =?us-ascii?Q?meNvJPkTrMBSuscjgQptrpUmyjFNaq2UnIBeSgACU1dZ0wyWteIB04L4zZ6T?=
 =?us-ascii?Q?yNB9tL1WoTIUQP5GUEZRulUP2Q6XazswiBSxq09cbHFdo3vxYlnosgIU4KNM?=
 =?us-ascii?Q?zFAPvTaAaYMCPh0K7nwR6DExDqayYv676U+BmuoYFBHD/hWvxYX/b3Ss/pBr?=
 =?us-ascii?Q?B36xLO7JsjgzUqgmTJ2+pEwocI9+EVQ1MItSM/NoMYteTi5i3sqI+j3hiE5U?=
 =?us-ascii?Q?xSvPmcegqKd8SXsVJ2jNs5D21gUrZg4Je/Zfakx/Rmv28TZ06c1ioC2XpPCS?=
 =?us-ascii?Q?XV9z18XouNhNElky7nxmcAqn3vF8ibImeKkvz9OslHi1ZLV/wVgI4TzA69lh?=
 =?us-ascii?Q?GyvpoQntfc7XpCLPn3uCeh29Q/Fc1YYmHVsnJXkuw0NOFrw5C1ZPTlDpiP8x?=
 =?us-ascii?Q?OoteLGZbP7SJi1ZfLdkmMHIWTGK3GUdf1fygGlEEl/j2jBf/mzK2/yHQJx/B?=
 =?us-ascii?Q?yxZNIQm3Y2KHHnZLPqITqTjC/f7v6fUfuceL8zG8aaVG/DSugVFuZqeyWzHR?=
 =?us-ascii?Q?yy4GwvoDlVf9YPOWa9WceAZmLnZ9aR6We7k9dcfsxekutO3Mo7XGvTVWJniD?=
 =?us-ascii?Q?sClQyO80URk+CC34RdjUlKU0vwTg5cfRf4eVASV3ymLX4w5rZWigpfFLZ6jw?=
 =?us-ascii?Q?qiFx6xhaE8r6hje0UZ1oLQ6YOqnd40IzfMMfa4+zbLt34yxy5WZD+8iuAeLl?=
 =?us-ascii?Q?WwPmv0oIw6H3Za53fGgSNin9jcBRk4UW3/1debvPrTM10tly2Pr30sYJzjsu?=
 =?us-ascii?Q?YdE8uFq59wBXFxZlR3ZhRrT2IqdwnZTucGRkXQ8Qz3B4MPgL40RK3O9BplM4?=
 =?us-ascii?Q?1Mqcyma6N9QNvo8ult/YsVFJTznl4E00S3Vaw/+LWEQ17SL53A3mmmNU4XFM?=
 =?us-ascii?Q?w/TIqg+lc5BNriiSlLVMLwCYCVWz6zZSRsgnw2itYNf8afrCVfwbw7o765f8?=
 =?us-ascii?Q?MXA8/9FmJ+KOWz+Yyt10wBZLjN+dpHsUdXoy6uhsTgBmzfrgu+ZqtgM5d8IG?=
 =?us-ascii?Q?OlMSWa4SN7goWtu/n9P6t9KA8WCcNj3MeTLwyMfXbM4NmAxoKWm6BTqscuR4?=
 =?us-ascii?Q?qBZdfO86zxf1G967II5x5Hsdd+c7oMDBWpRuki16bfDQThJl0Sb++BhIbmCN?=
 =?us-ascii?Q?lJ3HHC06SNEOABeS1vdgApwKbcd1N8oG5I/Bj5/ic0BiNZDgBpyUTsuciTQb?=
 =?us-ascii?Q?EOEt02bcBqGqeRXG5Uacs2lBHKpYa4iE2/G7UQx1R5l+MuFB1mdSeWj4evn0?=
 =?us-ascii?Q?FQxUY4JdiiOjYMccM6OLZjVpSBOnN0UaV/vThaVsNUry0mk5+xMFCptbUhF4?=
 =?us-ascii?Q?BHRrim1YK16dBgY5Q17GKUWXngCOfH5nJkdvkhCOhKhol9U4hWXYoPJRmQUP?=
 =?us-ascii?Q?DU/Ralj5Dftt9pmL/xoop0ePw4hrQ+YlqUBcbGf8xl3DWdxnqDbfw7PeTudg?=
 =?us-ascii?Q?kpMdR84xI9QXCLLPEt+3E3Yz2aXuYZ74D8al59jhLfeQVXCNy8GyiuGI/zOO?=
 =?us-ascii?Q?r/YzfwAiklcEAHSl6RSbA1qjr8KxgxdctEXBgRwYRjMNzZcqn+/rvZqFnwEU?=
 =?us-ascii?Q?TeTG2zcXbNWByx36BKzock5vC37ONmIk/9jySAWxQfOMo7B1Y2+cz+7FasN+?=
 =?us-ascii?Q?HNnpOw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de1aa32-7728-4da7-6157-08d9f868c81e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 14:11:56.8763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwAzvrNgHPPQ83fgIfKKbCPAsjxSn2CT9Y0x67drGb5t08TbDw3UGMp+5bmJ4J3Phw2lpZl6F+qKUbUb6iElZ1pJf0w1Z6Kg6qnsYVpWOoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3328
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202250083
X-Proofpoint-ORIG-GUID: Wx8-O79KAXdZs0_Pci2pd7PrdDEHNZzj
X-Proofpoint-GUID: Wx8-O79KAXdZs0_Pci2pd7PrdDEHNZzj
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As documented, the setup_indirect structure is nested inside
the setup_data structures in the setup_data list. The code currently
accesses the fields inside the setup_indirect structure but only
the sizeof(struct setup_data) is being memremapped. No crash
occurred but this is just due to how the area is remapped under the
covers.

Properly memremap both the setup_data and setup_indirect structures
in these cases before accessing them.

Fixes: b3c72fc9a78e ("x86/boot: Introduce setup_indirect")
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/kernel/e820.c     | 41 +++++++++++++++++-------
 arch/x86/kernel/kdebugfs.c | 37 ++++++++++++++++------
 arch/x86/kernel/ksysfs.c   | 77 ++++++++++++++++++++++++++++++++++++----------
 arch/x86/kernel/setup.c    | 34 +++++++++++++++-----
 arch/x86/mm/ioremap.c      | 24 ++++++++++++---
 5 files changed, 166 insertions(+), 47 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index bc0657f..f267205 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -995,8 +995,10 @@ static int __init parse_memmap_opt(char *str)
  */
 void __init e820__reserve_setup_data(void)
 {
+	struct setup_indirect *indirect;
 	struct setup_data *data;
-	u64 pa_data;
+	u64 pa_data, pa_next;
+	u32 len;
 
 	pa_data = boot_params.hdr.setup_data;
 	if (!pa_data)
@@ -1004,6 +1006,14 @@ void __init e820__reserve_setup_data(void)
 
 	while (pa_data) {
 		data = early_memremap(pa_data, sizeof(*data));
+		if (!data) {
+			pr_warn("e820: failed to memremap setup_data entry\n");
+			return;
+		}
+
+		len = sizeof(*data);
+		pa_next = data->next;
+
 		e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
 
 		/*
@@ -1015,18 +1025,27 @@ void __init e820__reserve_setup_data(void)
 						 sizeof(*data) + data->len,
 						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
 
-		if (data->type == SETUP_INDIRECT &&
-		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
-			e820__range_update(((struct setup_indirect *)data->data)->addr,
-					   ((struct setup_indirect *)data->data)->len,
-					   E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
-			e820__range_update_kexec(((struct setup_indirect *)data->data)->addr,
-						 ((struct setup_indirect *)data->data)->len,
-						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
+		if (data->type == SETUP_INDIRECT) {
+			len += data->len;
+			early_memunmap(data, sizeof(*data));
+			data = early_memremap(pa_data, len);
+			if (!data) {
+				pr_warn("e820: failed to memremap indirect setup_data\n");
+				return;
+			}
+
+			indirect = (struct setup_indirect *)data->data;
+
+			if (indirect->type != SETUP_INDIRECT) {
+				e820__range_update(indirect->addr, indirect->len,
+						   E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
+				e820__range_update_kexec(indirect->addr, indirect->len,
+							 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
+			}
 		}
 
-		pa_data = data->next;
-		early_memunmap(data, sizeof(*data));
+		pa_data = pa_next;
+		early_memunmap(data, len);
 	}
 
 	e820__update_table(e820_table);
diff --git a/arch/x86/kernel/kdebugfs.c b/arch/x86/kernel/kdebugfs.c
index 64b6da9..e2e89be 100644
--- a/arch/x86/kernel/kdebugfs.c
+++ b/arch/x86/kernel/kdebugfs.c
@@ -88,11 +88,13 @@ static ssize_t setup_data_read(struct file *file, char __user *user_buf,
 
 static int __init create_setup_data_nodes(struct dentry *parent)
 {
+	struct setup_indirect *indirect;
 	struct setup_data_node *node;
 	struct setup_data *data;
-	int error;
+	u64 pa_data, pa_next;
 	struct dentry *d;
-	u64 pa_data;
+	int error;
+	u32 len;
 	int no = 0;
 
 	d = debugfs_create_dir("setup_data", parent);
@@ -112,12 +114,29 @@ static int __init create_setup_data_nodes(struct dentry *parent)
 			error = -ENOMEM;
 			goto err_dir;
 		}
-
-		if (data->type == SETUP_INDIRECT &&
-		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
-			node->paddr = ((struct setup_indirect *)data->data)->addr;
-			node->type  = ((struct setup_indirect *)data->data)->type;
-			node->len   = ((struct setup_indirect *)data->data)->len;
+		pa_next = data->next;
+
+		if (data->type == SETUP_INDIRECT) {
+			len = sizeof(*data) + data->len;
+			memunmap(data);
+			data = memremap(pa_data, len, MEMREMAP_WB);
+			if (!data) {
+				kfree(node);
+				error = -ENOMEM;
+				goto err_dir;
+			}
+
+			indirect = (struct setup_indirect *)data->data;
+
+			if (indirect->type != SETUP_INDIRECT) {
+				node->paddr = indirect->addr;
+				node->type  = indirect->type;
+				node->len   = indirect->len;
+			} else {
+				node->paddr = pa_data;
+				node->type  = data->type;
+				node->len   = data->len;
+			}
 		} else {
 			node->paddr = pa_data;
 			node->type  = data->type;
@@ -125,7 +144,7 @@ static int __init create_setup_data_nodes(struct dentry *parent)
 		}
 
 		create_setup_data_node(d, no, node);
-		pa_data = data->next;
+		pa_data = pa_next;
 
 		memunmap(data);
 		no++;
diff --git a/arch/x86/kernel/ksysfs.c b/arch/x86/kernel/ksysfs.c
index d0a1912..257892f 100644
--- a/arch/x86/kernel/ksysfs.c
+++ b/arch/x86/kernel/ksysfs.c
@@ -91,26 +91,41 @@ static int get_setup_data_paddr(int nr, u64 *paddr)
 
 static int __init get_setup_data_size(int nr, size_t *size)
 {
-	int i = 0;
+	u64 pa_data = boot_params.hdr.setup_data, pa_next;
+	struct setup_indirect *indirect;
 	struct setup_data *data;
-	u64 pa_data = boot_params.hdr.setup_data;
+	int i = 0;
+	u32 len;
 
 	while (pa_data) {
 		data = memremap(pa_data, sizeof(*data), MEMREMAP_WB);
 		if (!data)
 			return -ENOMEM;
+		pa_next = data->next;
+
 		if (nr == i) {
-			if (data->type == SETUP_INDIRECT &&
-			    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT)
-				*size = ((struct setup_indirect *)data->data)->len;
-			else
+			if (data->type == SETUP_INDIRECT) {
+				len = sizeof(*data) + data->len;
+				memunmap(data);
+				data = memremap(pa_data, len, MEMREMAP_WB);
+				if (!data)
+					return -ENOMEM;
+
+				indirect = (struct setup_indirect *)data->data;
+
+				if (indirect->type != SETUP_INDIRECT)
+					*size = indirect->len;
+				else
+					*size = data->len;
+			} else {
 				*size = data->len;
+			}
 
 			memunmap(data);
 			return 0;
 		}
 
-		pa_data = data->next;
+		pa_data = pa_next;
 		memunmap(data);
 		i++;
 	}
@@ -120,9 +135,11 @@ static int __init get_setup_data_size(int nr, size_t *size)
 static ssize_t type_show(struct kobject *kobj,
 			 struct kobj_attribute *attr, char *buf)
 {
+	struct setup_indirect *indirect;
+	struct setup_data *data;
 	int nr, ret;
 	u64 paddr;
-	struct setup_data *data;
+	u32 len;
 
 	ret = kobj_to_setup_data_nr(kobj, &nr);
 	if (ret)
@@ -135,10 +152,20 @@ static ssize_t type_show(struct kobject *kobj,
 	if (!data)
 		return -ENOMEM;
 
-	if (data->type == SETUP_INDIRECT)
-		ret = sprintf(buf, "0x%x\n", ((struct setup_indirect *)data->data)->type);
-	else
+	if (data->type == SETUP_INDIRECT) {
+		len = sizeof(*data) + data->len;
+		memunmap(data);
+		data = memremap(paddr, len, MEMREMAP_WB);
+		if (!data)
+			return -ENOMEM;
+
+		indirect = (struct setup_indirect *)data->data;
+
+		ret = sprintf(buf, "0x%x\n", indirect->type);
+	} else {
 		ret = sprintf(buf, "0x%x\n", data->type);
+	}
+
 	memunmap(data);
 	return ret;
 }
@@ -149,9 +176,10 @@ static ssize_t setup_data_data_read(struct file *fp,
 				    char *buf,
 				    loff_t off, size_t count)
 {
+	struct setup_indirect *indirect;
+	struct setup_data *data;
 	int nr, ret = 0;
 	u64 paddr, len;
-	struct setup_data *data;
 	void *p;
 
 	ret = kobj_to_setup_data_nr(kobj, &nr);
@@ -165,10 +193,27 @@ static ssize_t setup_data_data_read(struct file *fp,
 	if (!data)
 		return -ENOMEM;
 
-	if (data->type == SETUP_INDIRECT &&
-	    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
-		paddr = ((struct setup_indirect *)data->data)->addr;
-		len = ((struct setup_indirect *)data->data)->len;
+	if (data->type == SETUP_INDIRECT) {
+		len = sizeof(*data) + data->len;
+		memunmap(data);
+		data = memremap(paddr, len, MEMREMAP_WB);
+		if (!data)
+			return -ENOMEM;
+
+		indirect = (struct setup_indirect *)data->data;
+
+		if (indirect->type != SETUP_INDIRECT) {
+			paddr = indirect->addr;
+			len = indirect->len;
+		} else {
+			/*
+			 * Even though this is technically undefined, return
+			 * the data as though it is a normal setup_data struct.
+			 * This will at least allow it to be inspected.
+			 */
+			paddr += sizeof(*data);
+			len = data->len;
+		}
 	} else {
 		paddr += sizeof(*data);
 		len = data->len;
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index f7a132e..90d7e17 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -369,21 +369,41 @@ static void __init parse_setup_data(void)
 
 static void __init memblock_x86_reserve_range_setup_data(void)
 {
+	struct setup_indirect *indirect;
 	struct setup_data *data;
-	u64 pa_data;
+	u64 pa_data, pa_next;
+	u32 len;
 
 	pa_data = boot_params.hdr.setup_data;
 	while (pa_data) {
 		data = early_memremap(pa_data, sizeof(*data));
+		if (!data) {
+			pr_warn("setup: failed to memremap setup_data entry\n");
+			return;
+		}
+
+		len = sizeof(*data);
+		pa_next = data->next;
+
 		memblock_reserve(pa_data, sizeof(*data) + data->len);
 
-		if (data->type == SETUP_INDIRECT &&
-		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT)
-			memblock_reserve(((struct setup_indirect *)data->data)->addr,
-					 ((struct setup_indirect *)data->data)->len);
+		if (data->type == SETUP_INDIRECT) {
+			len += data->len;
+			early_memunmap(data, sizeof(*data));
+			data = early_memremap(pa_data, len);
+			if (!data) {
+				pr_warn("setup: failed to memremap indirect setup_data\n");
+				return;
+			}
 
-		pa_data = data->next;
-		early_memunmap(data, sizeof(*data));
+			indirect = (struct setup_indirect *)data->data;
+
+			if (indirect->type != SETUP_INDIRECT)
+				memblock_reserve(indirect->addr, indirect->len);
+		}
+
+		pa_data = pa_next;
+		early_memunmap(data, len);
 	}
 }
 
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 026031b..ab666c4 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -615,6 +615,7 @@ static bool memremap_is_efi_data(resource_size_t phys_addr,
 static bool memremap_is_setup_data(resource_size_t phys_addr,
 				   unsigned long size)
 {
+	struct setup_indirect *indirect;
 	struct setup_data *data;
 	u64 paddr, paddr_next;
 
@@ -627,6 +628,10 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
 
 		data = memremap(paddr, sizeof(*data),
 				MEMREMAP_WB | MEMREMAP_DEC);
+		if (!data) {
+			pr_warn("failed to memremap setup_data entry\n");
+			return false;
+		}
 
 		paddr_next = data->next;
 		len = data->len;
@@ -636,10 +641,21 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
 			return true;
 		}
 
-		if (data->type == SETUP_INDIRECT &&
-		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
-			paddr = ((struct setup_indirect *)data->data)->addr;
-			len = ((struct setup_indirect *)data->data)->len;
+		if (data->type == SETUP_INDIRECT) {
+			memunmap(data);
+			data = memremap(paddr, sizeof(*data) + len,
+					MEMREMAP_WB | MEMREMAP_DEC);
+			if (!data) {
+				pr_warn("failed to memremap indirect setup_data\n");
+				return false;
+			}
+
+			indirect = (struct setup_indirect *)data->data;
+
+			if (indirect->type != SETUP_INDIRECT) {
+				paddr = indirect->addr;
+				len = indirect->len;
+			}
 		}
 
 		memunmap(data);
-- 
1.8.3.1

