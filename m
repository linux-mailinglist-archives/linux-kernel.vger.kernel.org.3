Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC4B4B6F0A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238941AbiBOOpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:45:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238896AbiBOOny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:43:54 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02917105ABB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:43:34 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FDpSE7026447;
        Tue, 15 Feb 2022 14:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=bEy3iOM33VXsylmDntBT64YkiTZxFkyXz4Aq30e4568=;
 b=QLsMdGAvr65wOT15Fn5DhmgA4i104Wp46iNhah4t+iACjJD1odDpmBm8465HcK9H1F72
 9z3DmUq8qIp24VxK/5ogeDRcJvQ9QKNelntc1YQwQROVdCaqlRkHKR7ay8LxSDJBkcUC
 mWMq7EgRiyAushg92c5izlf5ghNXGS0eSW8Y+9aUsVGTPDKeOe4w+VLmU6BOcMmWGcJo
 Ef0LfBG0yynE9bcsVCbXk4/ZNwV2trDkviSeSlRttydaXmCuPx2nXzP0zblKRRSXhL7G
 jea0PLfFzaJrSVX75q2jnuNgX/wG78EH614zZgiUObQ9XPe9YBXCQjqWCWYH72IvqTk+ jw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e88hgh4f4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeUFv145877;
        Tue, 15 Feb 2022 14:43:21 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by aserp3030.oracle.com with ESMTP id 3e62xeqejm-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMutP4xajZlixunwgxwqh3GlJfqi2eVAf3ZoUxoi5rbV+F1Zfs1nmyPLx1k5xhOcC0fLYtrlq0pAYBr8l4vCWTkNDHYz/fwMqg0NOpSfJA5Na/wUad/yY6SNzwC7hmAFGxLmajzuTom7X99TspHZ0mCIavdzP09FgEnROTZtyvpKtbdhvQ/zM0dbAISB/UZxbmTLKqN04FIUHNu6lz6Ia5B5LerHY+RoGtZJjRPL4is55Gdfmo9Bwy0v34s4x2pNRkYX6KSVkL5V6XGrLDE9RTznPxiXMIUQSSLFAayEWqH8cLb6THj8pRrmqfsLodxY9hBCzXR2VtjsET/kSida9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEy3iOM33VXsylmDntBT64YkiTZxFkyXz4Aq30e4568=;
 b=Cqvf2OytChkB8D5eLXCbBItCWh1WXFCInZrRuJjuHgBFOkw7YJMu1Dzj4LGEMwz4zKbs+rMICqm0lyxveTv+UFCHELcx50F4/+LAFH9fZEQooIpF4n3Udp5r+rw7EILfEuoDjugOpmjAiAsdilYZR8R0ELNEPMkXukUstJ/GDl8an8IRI6YUlPXj98Oba1JdYiEAUTvqgnF33ApcMejvFZzOus/bUbrQ4/CGufpRjHfX/gZxqZGCUwkNshr3/qLXAwxqtUKU/fmLSnOGc/UbB1oPS5NaJQ7wuC4Ryz6sDItwskOLC1rAPE8bq3i+fI2S9moBaNn0A9J3fQIly10Sgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEy3iOM33VXsylmDntBT64YkiTZxFkyXz4Aq30e4568=;
 b=vI1GPrLaWyJ82stsd+k9r1mFI3xjT+6vjGpkxpC2QfBRsiwkbssRsKrvwisdjzciOIXC/xBicjrKfK71iF1zmJWqli3C+RAFx9w6ohgLJ9bxDqjeUkzJqJ8geiqqZiBttnBEYdTUYS9i75oenfkOPp3KOQR+ZzDCSlXzaCxkbL0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4689.namprd10.prod.outlook.com (2603:10b6:303:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 14:43:18 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:18 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 27/71] mm: Remove vmacache
Thread-Topic: [PATCH v6 27/71] mm: Remove vmacache
Thread-Index: AQHYInpbFBLqOwrlxkO2IKChws2XFA==
Date:   Tue, 15 Feb 2022 14:43:12 +0000
Message-ID: <20220215144241.3812052-27-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fc44b42-3f13-425b-55f0-08d9f09181be
x-ms-traffictypediagnostic: CO1PR10MB4689:EE_
x-microsoft-antispam-prvs: <CO1PR10MB4689EBB52842F71E9E260FDBFD349@CO1PR10MB4689.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: buzCpTO0GuvVcjOIOgp3AuvvtX1KPSXYe3qftsOA2HVm68knrFRksFQFuVImMut38rHBHTcBONWhDcKWv8g3eY0ZoY0uLUZdg0J6kCEUTxaZlyYnQztZjmFGwKO6KFcIIRVgcUD88SCDeG2xB2zEC1VsK9Yf8zrLFqt1lZGnlVbM8KSjAPs1K8u8FBAG2NFLzSjp4HDAuTx7wqgLr/YzH1F/3B0JQGfFyCbeXP5ayHpHFqAzdrD85AtU36iBp//N4Re+ArUiyqw0pzFkwuzmwJCEIlFUVv3hG/vbnSf1EqB+JpCN4hLAA66IMFICOIEQIn2ansh9QZy7+alwZWl6p3pXQpI+iaG1sJMReMN3rX8DYTGt5uv0yFn4fkl7TowPHc5Zi2afxxr7GqC60hmAoI2Xsfx+GE93ojDzS7fPHN+0MQHf8OvbA6viGKx9tysbWtTFA/g74iUACbYAtRTs17gIutg33Y0xhTTEZrXvfwHqLwoKulsTWAhDeXWA5mcdQ9AzQpQsuyn2qD7vXbzgnlTG0Wgp/uJvVrhYh64CbGTob7in3zT3PNFsO/WMHAsZKYFJUAfhk9zN61OOFtZOgMZyIxsSvPhOY4VZgTCdPEjgEAB36UYCRdyIGjTLUHRvljsOXENVUZlMT44MkDsEbLi8ttfhpQUZ+ryWUVpnT4rcMWOhblCU5piMKR090ftnem7NWDKFaVoN/PyWae2ogA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(76116006)(66446008)(64756008)(66476007)(66556008)(91956017)(8676002)(6486002)(8936002)(86362001)(316002)(110136005)(38100700002)(122000001)(38070700005)(2616005)(6666004)(6512007)(44832011)(36756003)(30864003)(1076003)(26005)(186003)(2906002)(5660300002)(83380400001)(6506007)(71200400001)(508600001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?e8lSDxeb2qYrFNbd6YAubi/6MHy04I9DskFzqNUUM/+GUqPDOAW9uDdtEJ?=
 =?iso-8859-1?Q?yWdETowlgHJidAjThZ6eVm3CRwSQxBaJ52H+PnIuP1cd/0ZiYz/q3tPeWA?=
 =?iso-8859-1?Q?g7fj25vltjkzSCUy1lq2rfw2/4YsOKp1jkBPkLgRAyoOSHTOj/8Yq7v//y?=
 =?iso-8859-1?Q?uXpBTN6yySXjX005R+ANc3yjeRx5viwSdqKNyq9ViM04tAFptZoqYdHQFa?=
 =?iso-8859-1?Q?5IcNtIy1Dzp8M86dNNz2Unb8FMMDdWY0DNDlEXK6UQHPPbLfJKc7wAvY4v?=
 =?iso-8859-1?Q?F3HHZld/i1q34vkyBd5jljcrNfXEzPzz4uTfo8RwodBRSFrGXGrIuDZrPs?=
 =?iso-8859-1?Q?NmPr52C4HTrSIBtoUAXXMeXbyM703bWpw1Zi/BHpJy1AKqL9HkctT3atLB?=
 =?iso-8859-1?Q?D1IumFYF8guCKiJte6z86dlLymt+4Z4Sg/sDUZDzcI3P3pk9fW9L4Me3zJ?=
 =?iso-8859-1?Q?Ie21z3fJUNTcZAPEks6213tGZw9ZtfeiQtJETm7od6uaZlM0PNWgS+lUeq?=
 =?iso-8859-1?Q?eDnIOlQ2+bEe6eRk/C0k6uLuHv2RNO53MF2P2s20lxzwywqFra+ndL3VXc?=
 =?iso-8859-1?Q?rLRLDgfn4qVM/cQ7Xd74hKvwxCm6mmn6AkuzQ6CKKY7V1eyAqLyJ515CA3?=
 =?iso-8859-1?Q?mlBeT+UKjUACZvRHu5zUvxS7KZ0TtN3MHaoi/04abgFFzBmXl5hnu1Bsow?=
 =?iso-8859-1?Q?miLtZLagFXzCknA8CE/GDKWQP6YUuePbj/6aAUFBsoccK7WpNGrRkSajFc?=
 =?iso-8859-1?Q?DVaresFOPTxlgkAuMmRspDMyHUxNUSqElo3BeKWbXFjvky7OTNVxucSjsA?=
 =?iso-8859-1?Q?y2x8Y9J58ub0XYga33woxdBqAj808zgZT5pHfVuHQYRIcSjsauKrIHiJ4D?=
 =?iso-8859-1?Q?Z/sTFetZ0pkzbC8bNkOvGf4UKL29T0Pl69+2JhAhgC4MWhHvM8r4pMoWGx?=
 =?iso-8859-1?Q?vrvpDZ8/8OhlHTMMvsRW+TEwsl9VtRuo7tqZ2rL1w9HKIesGnIrovKvnz5?=
 =?iso-8859-1?Q?EgFnUHSWwdNH6JYENrpQSUtmhTrhhsoYIw/aOOCNAgS3OJxCFD+k1ZhXqI?=
 =?iso-8859-1?Q?AsuIbr1cvBxvoOqDc7Gc+D/86icbfAY0qaHW4ZlSAUsV5zvs5qCAL7+zc5?=
 =?iso-8859-1?Q?04H70Dp7aSiYK3B6f12vlgjzgmqZKOPaqIgZT6ROCt305i584e4xSdBl77?=
 =?iso-8859-1?Q?cA3hZ0iCwwNC/cbR/BqyOdWf/A+Sodij7mjN4NIHwz09DOMSEMbIUG9/DS?=
 =?iso-8859-1?Q?2BBLABBgLAz+dbeUU53jJDrE6pIsNh+zuwQdcfWN20m/G7L3xgFcy+EpBp?=
 =?iso-8859-1?Q?pOdQOPcSqUn8kSjqLilPg+7umTt0MqhZbzme/QUy70G826M+EES6xxIlKG?=
 =?iso-8859-1?Q?7KLdMQCnaZGVz5BGs9whizkMMPCJaczqMg8WhMaiTuT437xCFJabwPB3Dk?=
 =?iso-8859-1?Q?EfUEKbJ1ywKfipolnTaHe0ZWemR6HJF4qiRmTvcN5s1PEIboiahc8/n58c?=
 =?iso-8859-1?Q?I8oub20Nf2TsJkGbhzmSeBxdPaqbk5Tq1BVyR164VZwpKr/IxDiNr+lJpZ?=
 =?iso-8859-1?Q?UTZnfdjCTIsQMKAZox43PaoC45MLDBEjyTcsyb4uO1gSWY0c4NR0Ut48Qm?=
 =?iso-8859-1?Q?6ZdeQvKEMW5Ivdw/96lfoRTaXeG5lKh66j2jeNkRSIJ8FzRq5nXoBItk7G?=
 =?iso-8859-1?Q?wsyDYI/k9TtHSsXe5hY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc44b42-3f13-425b-55f0-08d9f09181be
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:12.5267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: luQ+vLx3jL9OScHKi/PMwLKgL91QtElm1CG5j7f7yFYcUEzuRuj5k/IIaEujPft1vNF+30nogrk8GTsqNX3nxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4689
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-GUID: zechD2d3ZFWZhfaWCZmrgFm3qvVLZp4L
X-Proofpoint-ORIG-GUID: zechD2d3ZFWZhfaWCZmrgFm3qvVLZp4L
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

By using the maple tree and the maple tree state, the vmacache is no
longer beneficial and is complicating the VMA code.  Remove the vmacache
to reduce the work in keeping it up to date and code complexity.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 fs/exec.c                     |   3 -
 fs/proc/task_mmu.c            |   1 -
 include/linux/mm_types.h      |   1 -
 include/linux/mm_types_task.h |  12 ----
 include/linux/sched.h         |   1 -
 include/linux/vm_event_item.h |   4 --
 include/linux/vmacache.h      |  28 --------
 include/linux/vmstat.h        |   6 --
 kernel/debug/debug_core.c     |  12 ----
 kernel/fork.c                 |   5 --
 lib/Kconfig.debug             |   8 ---
 mm/Makefile                   |   2 +-
 mm/debug.c                    |   4 +-
 mm/mmap.c                     |  32 +---------
 mm/nommu.c                    |  37 ++---------
 mm/vmacache.c                 | 117 ----------------------------------
 mm/vmstat.c                   |   4 --
 17 files changed, 9 insertions(+), 268 deletions(-)
 delete mode 100644 include/linux/vmacache.h
 delete mode 100644 mm/vmacache.c

diff --git a/fs/exec.c b/fs/exec.c
index 79f2c9483302..0c34b17932fb 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -28,7 +28,6 @@
 #include <linux/file.h>
 #include <linux/fdtable.h>
 #include <linux/mm.h>
-#include <linux/vmacache.h>
 #include <linux/stat.h>
 #include <linux/fcntl.h>
 #include <linux/swap.h>
@@ -1018,8 +1017,6 @@ static int exec_mmap(struct mm_struct *mm)
 	activate_mm(active_mm, mm);
 	if (IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
 		local_irq_enable();
-	tsk->mm->vmacache_seqnum =3D 0;
-	vmacache_flush(tsk);
 	task_unlock(tsk);
 	if (old_mm) {
 		mmap_read_unlock(old_mm);
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 6e97ed775074..68e65280938e 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/pagewalk.h>
-#include <linux/vmacache.h>
 #include <linux/mm_inline.h>
 #include <linux/hugetlb.h>
 #include <linux/huge_mm.h>
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index bc5e55be5029..c36a3c4fc086 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -444,7 +444,6 @@ struct mm_struct {
 	struct {
 		struct vm_area_struct *mmap;		/* list of VMAs */
 		struct maple_tree mm_mt;
-		u64 vmacache_seqnum;                   /* per-thread vmacache */
 #ifdef CONFIG_MMU
 		unsigned long (*get_unmapped_area) (struct file *filp,
 				unsigned long addr, unsigned long len,
diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index c1bc6731125c..0bb4b6da9993 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -24,18 +24,6 @@
 		IS_ENABLED(CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK))
 #define ALLOC_SPLIT_PTLOCKS	(SPINLOCK_SIZE > BITS_PER_LONG/8)
=20
-/*
- * The per task VMA cache array:
- */
-#define VMACACHE_BITS 2
-#define VMACACHE_SIZE (1U << VMACACHE_BITS)
-#define VMACACHE_MASK (VMACACHE_SIZE - 1)
-
-struct vmacache {
-	u64 seqnum;
-	struct vm_area_struct *vmas[VMACACHE_SIZE];
-};
-
 /*
  * When updating this, please also update struct resident_page_types[] in
  * kernel/fork.c
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 75ba8aa60248..abf88f7cd062 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -861,7 +861,6 @@ struct task_struct {
 	struct mm_struct		*active_mm;
=20
 	/* Per-thread vma caching: */
-	struct vmacache			vmacache;
=20
 #ifdef SPLIT_RSS_COUNTING
 	struct task_rss_stat		rss_stat;
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 7b2363388bfa..30bfbd9ec213 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -122,10 +122,6 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		NR_TLB_LOCAL_FLUSH_ALL,
 		NR_TLB_LOCAL_FLUSH_ONE,
 #endif /* CONFIG_DEBUG_TLBFLUSH */
-#ifdef CONFIG_DEBUG_VM_VMACACHE
-		VMACACHE_FIND_CALLS,
-		VMACACHE_FIND_HITS,
-#endif
 #ifdef CONFIG_SWAP
 		SWAP_RA,
 		SWAP_RA_HIT,
diff --git a/include/linux/vmacache.h b/include/linux/vmacache.h
deleted file mode 100644
index 6fce268a4588..000000000000
--- a/include/linux/vmacache.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LINUX_VMACACHE_H
-#define __LINUX_VMACACHE_H
-
-#include <linux/sched.h>
-#include <linux/mm.h>
-
-static inline void vmacache_flush(struct task_struct *tsk)
-{
-	memset(tsk->vmacache.vmas, 0, sizeof(tsk->vmacache.vmas));
-}
-
-extern void vmacache_update(unsigned long addr, struct vm_area_struct *new=
vma);
-extern struct vm_area_struct *vmacache_find(struct mm_struct *mm,
-						    unsigned long addr);
-
-#ifndef CONFIG_MMU
-extern struct vm_area_struct *vmacache_find_exact(struct mm_struct *mm,
-						  unsigned long start,
-						  unsigned long end);
-#endif
-
-static inline void vmacache_invalidate(struct mm_struct *mm)
-{
-	mm->vmacache_seqnum++;
-}
-
-#endif /* __LINUX_VMACACHE_H */
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index bfe38869498d..19cf5b6892ce 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -125,12 +125,6 @@ static inline void vm_events_fold_cpu(int cpu)
 #define count_vm_tlb_events(x, y) do { (void)(y); } while (0)
 #endif
=20
-#ifdef CONFIG_DEBUG_VM_VMACACHE
-#define count_vm_vmacache_event(x) count_vm_event(x)
-#else
-#define count_vm_vmacache_event(x) do {} while (0)
-#endif
-
 #define __count_zid_vm_events(item, zid, delta) \
 	__count_vm_events(item##_NORMAL - ZONE_NORMAL + zid, delta)
=20
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index da06a5553835..c4e6f5159bed 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -50,7 +50,6 @@
 #include <linux/pid.h>
 #include <linux/smp.h>
 #include <linux/mm.h>
-#include <linux/vmacache.h>
 #include <linux/rcupdate.h>
 #include <linux/irq.h>
=20
@@ -282,17 +281,6 @@ static void kgdb_flush_swbreak_addr(unsigned long addr=
)
 	if (!CACHE_FLUSH_IS_SAFE)
 		return;
=20
-	if (current->mm) {
-		int i;
-
-		for (i =3D 0; i < VMACACHE_SIZE; i++) {
-			if (!current->vmacache.vmas[i])
-				continue;
-			flush_cache_range(current->vmacache.vmas[i],
-					  addr, addr + BREAK_INSTR_SIZE);
-		}
-	}
-
 	/* Force flush instruction cache if it was outside the mm */
 	flush_icache_range(addr, addr + BREAK_INSTR_SIZE);
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index dc991a76dda4..fd22da67e092 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -43,7 +43,6 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/mm_inline.h>
-#include <linux/vmacache.h>
 #include <linux/nsproxy.h>
 #include <linux/capability.h>
 #include <linux/cpu.h>
@@ -1047,7 +1046,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm=
, struct task_struct *p,
 	mm->mmap =3D NULL;
 	mt_init_flags(&mm->mm_mt, MM_MT_FLAGS);
 	mt_set_external_lock(&mm->mm_mt, &mm->mmap_lock);
-	mm->vmacache_seqnum =3D 0;
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
 	seqcount_init(&mm->write_protect_seq);
@@ -1502,9 +1500,6 @@ static int copy_mm(unsigned long clone_flags, struct =
task_struct *tsk)
 	if (!oldmm)
 		return 0;
=20
-	/* initialize the new vmacache entries */
-	vmacache_flush(tsk);
-
 	if (clone_flags & CLONE_VM) {
 		mmget(oldmm);
 		mm =3D oldmm;
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index cfcb8ef5cb89..a377c9049689 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -809,14 +809,6 @@ config DEBUG_VM
=20
 	  If unsure, say N.
=20
-config DEBUG_VM_VMACACHE
-	bool "Debug VMA caching"
-	depends on DEBUG_VM
-	help
-	  Enable this to turn on VMA caching debug information. Doing so
-	  can cause significant overhead, so only enable it in non-production
-	  environments.
-
 config DEBUG_VM_MAPLE_TREE
 	bool "Debug VM maple trees"
 	depends on DEBUG_VM
diff --git a/mm/Makefile b/mm/Makefile
index 70d4309c9ce3..524b3799617a 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -52,7 +52,7 @@ obj-y			:=3D filemap.o mempool.o oom_kill.o fadvise.o \
 			   readahead.o swap.o truncate.o vmscan.o shmem.o \
 			   util.o mmzone.o vmstat.o backing-dev.o \
 			   mm_init.o percpu.o slab_common.o \
-			   compaction.o vmacache.o \
+			   compaction.o \
 			   interval_tree.o list_lru.o workingset.o \
 			   debug.o gup.o mmap_lock.o $(mmu-y)
=20
diff --git a/mm/debug.c b/mm/debug.c
index bc9ac87f0e08..ef3555d07179 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -159,7 +159,7 @@ EXPORT_SYMBOL(dump_vma);
=20
 void dump_mm(const struct mm_struct *mm)
 {
-	pr_emerg("mm %px mmap %px seqnum %llu task_size %lu\n"
+	pr_emerg("mm %px mmap %px task_size %lu\n"
 #ifdef CONFIG_MMU
 		"get_unmapped_area %px\n"
 #endif
@@ -187,7 +187,7 @@ void dump_mm(const struct mm_struct *mm)
 		"tlb_flush_pending %d\n"
 		"def_flags: %#lx(%pGv)\n",
=20
-		mm, mm->mmap, (long long) mm->vmacache_seqnum, mm->task_size,
+		mm, mm->mmap, mm->task_size,
 #ifdef CONFIG_MMU
 		mm->get_unmapped_area,
 #endif
diff --git a/mm/mmap.c b/mm/mmap.c
index 8fb9a066a944..0ab24ad0d291 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -14,7 +14,6 @@
 #include <linux/backing-dev.h>
 #include <linux/mm.h>
 #include <linux/mm_inline.h>
-#include <linux/vmacache.h>
 #include <linux/shm.h>
 #include <linux/mman.h>
 #include <linux/pagemap.h>
@@ -687,9 +686,6 @@ inline int vma_expand(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 		/* Remove from mm linked list - also updates highest_vm_end */
 		__vma_unlink_list(mm, next);
=20
-		/* Kill the cache */
-		vmacache_invalidate(mm);
-
 		if (file)
 			__remove_shared_vm_struct(next, file, mapping);
=20
@@ -915,8 +911,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
=20
 	if (remove_next) {
 		__vma_unlink_list(mm, next);
-		/* Kill the cache */
-		vmacache_invalidate(mm);
 		if (file)
 			__remove_shared_vm_struct(next, file, mapping);
 	} else if (insert) {
@@ -2187,19 +2181,10 @@ struct vm_area_struct *find_vma_intersection(struct=
 mm_struct *mm,
 					     unsigned long start_addr,
 					     unsigned long end_addr)
 {
-	struct vm_area_struct *vma;
 	unsigned long index =3D start_addr;
=20
 	mmap_assert_locked(mm);
-	/* Check the cache first. */
-	vma =3D vmacache_find(mm, start_addr);
-	if (likely(vma))
-		return vma;
-
-	vma =3D mt_find(&mm->mm_mt, &index, end_addr - 1);
-	if (vma)
-		vmacache_update(start_addr, vma);
-	return vma;
+	return mt_find(&mm->mm_mt, &index, end_addr - 1);
 }
 EXPORT_SYMBOL(find_vma_intersection);
=20
@@ -2213,19 +2198,10 @@ EXPORT_SYMBOL(find_vma_intersection);
  */
 inline struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long=
 addr)
 {
-	struct vm_area_struct *vma;
 	unsigned long index =3D addr;
=20
 	mmap_assert_locked(mm);
-	/* Check the cache first. */
-	vma =3D vmacache_find(mm, addr);
-	if (likely(vma))
-		return vma;
-
-	vma =3D mt_find(&mm->mm_mt, &index, ULONG_MAX);
-	if (vma)
-		vmacache_update(addr, vma);
-	return vma;
+	return mt_find(&mm->mm_mt, &index, ULONG_MAX);
 }
 EXPORT_SYMBOL(find_vma);
=20
@@ -2604,9 +2580,6 @@ detach_vmas_to_be_unmapped(struct mm_struct *mm, stru=
ct vm_area_struct *vma,
 		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
 	tail_vma->vm_next =3D NULL;
=20
-	/* Kill the cache */
-	vmacache_invalidate(mm);
-
 	/*
 	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
 	 * VM_GROWSUP VMA. Such VMAs can change their size under
@@ -2988,7 +2961,6 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 	if (vma_mas_remove(&unmap, mas))
 		goto mas_store_fail;
=20
-	vmacache_invalidate(vma->vm_mm);
 	if (vma->anon_vma) {
 		anon_vma_interval_tree_post_update_vma(vma);
 		anon_vma_unlock_write(vma->anon_vma);
diff --git a/mm/nommu.c b/mm/nommu.c
index 9b8c033ef997..f500c57a59f3 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -19,7 +19,6 @@
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/sched/mm.h>
-#include <linux/vmacache.h>
 #include <linux/mman.h>
 #include <linux/swap.h>
 #include <linux/file.h>
@@ -583,23 +582,12 @@ static void add_vma_to_mm(struct mm_struct *mm, struc=
t vm_area_struct *vma)
  */
 static void delete_vma_from_mm(struct vm_area_struct *vma)
 {
-	int i;
-	struct address_space *mapping;
-	struct mm_struct *mm =3D vma->vm_mm;
-	struct task_struct *curr =3D current;
 	MA_STATE(mas, &vma->vm_mm->mm_mt, 0, 0);
=20
-	mm->map_count--;
-	for (i =3D 0; i < VMACACHE_SIZE; i++) {
-		/* if the vma is cached, invalidate the entire cache */
-		if (curr->vmacache.vmas[i] =3D=3D vma) {
-			vmacache_invalidate(mm);
-			break;
-		}
-	}
-
+	vma->vm_mm->map_count--;
 	/* remove the VMA from the mapping */
 	if (vma->vm_file) {
+		struct address_space *mapping;
 		mapping =3D vma->vm_file->f_mapping;
=20
 		i_mmap_lock_write(mapping);
@@ -611,7 +599,7 @@ static void delete_vma_from_mm(struct vm_area_struct *v=
ma)
=20
 	/* remove from the MM's tree and list */
 	vma_mas_remove(vma, &mas);
-	__vma_unlink_list(mm, vma);
+	__vma_unlink_list(vma->vm_mm, vma);
 }
=20
 /*
@@ -633,20 +621,9 @@ static void delete_vma(struct mm_struct *mm, struct vm=
_area_struct *vma)
  */
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
-	struct vm_area_struct *vma;
 	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
-	/* check the cache first */
-	vma =3D vmacache_find(mm, addr);
-	if (likely(vma))
-		return vma;
-
-	vma =3D mas_walk(&mas);
-
-	if (vma)
-		vmacache_update(addr, vma);
-
-	return vma;
+	return mas_walk(&mas);
 }
 EXPORT_SYMBOL(find_vma);
=20
@@ -680,11 +657,6 @@ static struct vm_area_struct *find_vma_exact(struct mm=
_struct *mm,
 	unsigned long end =3D addr + len;
 	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
-	/* check the cache first */
-	vma =3D vmacache_find_exact(mm, addr, end);
-	if (vma)
-		return vma;
-
 	vma =3D mas_walk(&mas);
 	if (!vma)
 		return NULL;
@@ -693,7 +665,6 @@ static struct vm_area_struct *find_vma_exact(struct mm_=
struct *mm,
 	if (vma->vm_end !=3D end)
 		return NULL;
=20
-	vmacache_update(addr, vma);
 	return vma;
 }
=20
diff --git a/mm/vmacache.c b/mm/vmacache.c
deleted file mode 100644
index 01a6e6688ec1..000000000000
--- a/mm/vmacache.c
+++ /dev/null
@@ -1,117 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2014 Davidlohr Bueso.
- */
-#include <linux/sched/signal.h>
-#include <linux/sched/task.h>
-#include <linux/mm.h>
-#include <linux/vmacache.h>
-
-/*
- * Hash based on the pmd of addr if configured with MMU, which provides a =
good
- * hit rate for workloads with spatial locality.  Otherwise, use pages.
- */
-#ifdef CONFIG_MMU
-#define VMACACHE_SHIFT	PMD_SHIFT
-#else
-#define VMACACHE_SHIFT	PAGE_SHIFT
-#endif
-#define VMACACHE_HASH(addr) ((addr >> VMACACHE_SHIFT) & VMACACHE_MASK)
-
-/*
- * This task may be accessing a foreign mm via (for example)
- * get_user_pages()->find_vma().  The vmacache is task-local and this
- * task's vmacache pertains to a different mm (ie, its own).  There is
- * nothing we can do here.
- *
- * Also handle the case where a kernel thread has adopted this mm via
- * kthread_use_mm(). That kernel thread's vmacache is not applicable to th=
is mm.
- */
-static inline bool vmacache_valid_mm(struct mm_struct *mm)
-{
-	return current->mm =3D=3D mm && !(current->flags & PF_KTHREAD);
-}
-
-void vmacache_update(unsigned long addr, struct vm_area_struct *newvma)
-{
-	if (vmacache_valid_mm(newvma->vm_mm))
-		current->vmacache.vmas[VMACACHE_HASH(addr)] =3D newvma;
-}
-
-static bool vmacache_valid(struct mm_struct *mm)
-{
-	struct task_struct *curr;
-
-	if (!vmacache_valid_mm(mm))
-		return false;
-
-	curr =3D current;
-	if (mm->vmacache_seqnum !=3D curr->vmacache.seqnum) {
-		/*
-		 * First attempt will always be invalid, initialize
-		 * the new cache for this task here.
-		 */
-		curr->vmacache.seqnum =3D mm->vmacache_seqnum;
-		vmacache_flush(curr);
-		return false;
-	}
-	return true;
-}
-
-struct vm_area_struct *vmacache_find(struct mm_struct *mm, unsigned long a=
ddr)
-{
-	int idx =3D VMACACHE_HASH(addr);
-	int i;
-
-	count_vm_vmacache_event(VMACACHE_FIND_CALLS);
-
-	if (!vmacache_valid(mm))
-		return NULL;
-
-	for (i =3D 0; i < VMACACHE_SIZE; i++) {
-		struct vm_area_struct *vma =3D current->vmacache.vmas[idx];
-
-		if (vma) {
-#ifdef CONFIG_DEBUG_VM_VMACACHE
-			if (WARN_ON_ONCE(vma->vm_mm !=3D mm))
-				break;
-#endif
-			if (vma->vm_start <=3D addr && vma->vm_end > addr) {
-				count_vm_vmacache_event(VMACACHE_FIND_HITS);
-				return vma;
-			}
-		}
-		if (++idx =3D=3D VMACACHE_SIZE)
-			idx =3D 0;
-	}
-
-	return NULL;
-}
-
-#ifndef CONFIG_MMU
-struct vm_area_struct *vmacache_find_exact(struct mm_struct *mm,
-					   unsigned long start,
-					   unsigned long end)
-{
-	int idx =3D VMACACHE_HASH(start);
-	int i;
-
-	count_vm_vmacache_event(VMACACHE_FIND_CALLS);
-
-	if (!vmacache_valid(mm))
-		return NULL;
-
-	for (i =3D 0; i < VMACACHE_SIZE; i++) {
-		struct vm_area_struct *vma =3D current->vmacache.vmas[idx];
-
-		if (vma && vma->vm_start =3D=3D start && vma->vm_end =3D=3D end) {
-			count_vm_vmacache_event(VMACACHE_FIND_HITS);
-			return vma;
-		}
-		if (++idx =3D=3D VMACACHE_SIZE)
-			idx =3D 0;
-	}
-
-	return NULL;
-}
-#endif
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 4057372745d0..9940b51a922b 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1378,10 +1378,6 @@ const char * const vmstat_text[] =3D {
 	"nr_tlb_local_flush_one",
 #endif /* CONFIG_DEBUG_TLBFLUSH */
=20
-#ifdef CONFIG_DEBUG_VM_VMACACHE
-	"vmacache_find_calls",
-	"vmacache_find_hits",
-#endif
 #ifdef CONFIG_SWAP
 	"swap_ra",
 	"swap_ra_hit",
--=20
2.34.1
