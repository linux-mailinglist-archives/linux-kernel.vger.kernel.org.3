Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB769477D54
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 21:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241303AbhLPUU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 15:20:26 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:34186 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241313AbhLPUUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 15:20:04 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BGIn4X2025843;
        Thu, 16 Dec 2021 20:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=cydgqgIbAFFV9frwO6tRQMlczTwcZCygPS8wi7Rls1I=;
 b=R7vAt5bCq0ajFoiNKOxrPR9I1UP3gcHsYLtAiMWabqpwbhQIM0A4ZatKhVoH9r9CweGD
 8o++YK9pFS4kRvTFG3HjkRvFNV7OZhjTRtiEfDf/WHOL9f44d67JW4bENMyAIKz76Z77
 4E3onRcHEuVd81J+Yj1xbTUU+wZfcUtMbNCaQbTUje6w7KnfbVPyqzJZvG75wjbCWTB1
 egNojAXmcsQGwuZOER+UBipBtS92yCS1c2pNEVTKWI8drzHmzC6jo955+lU4NSJ3bWi0
 V2tYMHZ5RqWAzcAXHsMwRZQW9fob9MBnSb92uNBAstRnHd59qK+jbayzM3quEUoZdrx/ 3A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknp3y7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 20:19:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BGKGbqo047602;
        Thu, 16 Dec 2021 20:19:53 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by aserp3020.oracle.com with ESMTP id 3cxmrdxb5q-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 20:19:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDerjdmeykT8JP0H1iYtTVewHS0D6jfedC6fL66NDMnxAjUMTxhtI5AsGv5XcG7+y379aJ8k5fDYwcJIGDGX27mSdur7kYQB8PM3QIDTgx4vu1Sw2bAfG82sdF7nrOUf1kg3qFmOxyn0CwZ3hRMpyJGaz9IsEknOLtKfmnXkjW//oTweYz2cnPDUr0VCjQvOfy4B1swhWOLIwaYR5XNFRH77lOyWQJ1I3xuYBB5yaWB38qAyrjeYb1x6wxhgI2lKws+J5SxlY4FtfJXk4WfEjOYBv6cH7ZwFoh+uP1P2+HirmC0SVQ4uqpkwg8gUA7azsJoD4wa9Qnro1+Otc2+3qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cydgqgIbAFFV9frwO6tRQMlczTwcZCygPS8wi7Rls1I=;
 b=D/FXoK0PLmZ9j2xqf6Ezp2BoqEacHNCtgrmdt9/lkfSidhMvISAmuXOC+ze0kUBT7hYEaawhmG5U7ABd0/WtpunbJ9eukdD3upXAbi/tOGR0F2XkNFQ+bZkjY1YHJt4c9HEdwi2rcn522Dbaq2aPwBV7cM3VAfoxJIDwCbwIwh6KdlTSZqKRCzlWtd6rT5vOeaQVgGHrrwv6SU1tr2Jp2ChriuYlJSD+PYBTr5Wpcy7nf9nfOzG9UrK57urJrvW8/MZ3ytuB8fqlNmzVgIdVD9wfYFVb+U55sq7BVsjJ8sFd8fX6HGohaG55/3G4AfIJSL1fbknT4/dNsXX+Rqwm6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cydgqgIbAFFV9frwO6tRQMlczTwcZCygPS8wi7Rls1I=;
 b=rNetWIjE2gvF1yn7N4MvA2OI9PpsbhzSN0oIQz/jG9wLzaGDd8ybIMu/HeYl7p1Oh2xKikI0/cvZXlii5IoB0Ue/u9hCPxgwLpArNGw+LjtwuMuWvctlh+a63B/U4c+GzrrUppdHm/3G3WKwt4tH8TeF+TYEg60s9vSxa5TK12g=
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SN6PR10MB2541.namprd10.prod.outlook.com (2603:10b6:805:44::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Thu, 16 Dec
 2021 20:19:52 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::c873:a8b4:278e:939e]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::c873:a8b4:278e:939e%7]) with mapi id 15.20.4801.015; Thu, 16 Dec 2021
 20:19:52 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v7 3/7] kbuild: generate an address ranges map at vmlinux link time
Date:   Thu, 16 Dec 2021 20:19:15 +0000
Message-Id: <20211216201919.234994-4-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.34.0.258.gc900572c39
In-Reply-To: <20211216201919.234994-1-nick.alcock@oracle.com>
References: <20211216201919.234994-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0095.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::10) To SA2PR10MB4715.namprd10.prod.outlook.com
 (2603:10b6:806:fb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9aadf8dc-6965-4e18-08d7-08d9c0d16a97
X-MS-TrafficTypeDiagnostic: SN6PR10MB2541:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB25419F852A2ADAF19CC2B0E08B779@SN6PR10MB2541.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GUgVsZK/vBV2sERPyNMGMzmPiIF3ZYNpOqsPqdIKb4s8GQTbw1eP5+0r1qvQVmA85wIin2ZFUnqNDBlYQoXXiW77MWvswEYLuwTzXqMzQ1sWU8c4fPPofxgYLxm/TQZpC74a8ClZmWtjpeErQiyuV9FA7Dvv2Uw22Xa3Orjx6MIwQ3GW/DGKXjqnRltSPRnWmEo9S7w8ST157l7WXY+yblTvm/eL/IG24Taw11CZ5WxbohM8Ekw+dFqaumpBxoAHSVkCtmh7gB/UVImhVKrF9lluV0buR9vp/WgbAkdfmK9JU8cyH7UQgAdzHJIGGMiN24z7f3BocroVRgCkmUucxrtxc5w2n6khcjFhhNbkq9cxt5rRofOIrnxjCR9PmHBYfKEEj7A4nEdGHv8okxlfXCZP18kxisXeMKo4LP3XMbaLSR+oeDO8lmxgCBuYSQDx/bEh8G3nx0sJOvviBGXNWII0PmB3E8UYgQF5u4DHzu9MEk/L7V4NiOFniu8l6vwpnEwGEyIfhblPn4qCA+Fvgny65G7NyHclPpNBRP+QIlbS5lw2wlEKnnFJ9mu1YYIYnxJoLQ5vuQQxgwXBRigTOBzsX9Lif6JSJ9s23pbku9ByBc7d1Zhs9mwLSSl4INJ28W8U9myx9YIp0n/Fq7nX7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(52116002)(38100700002)(86362001)(44832011)(36756003)(5660300002)(1076003)(2616005)(6506007)(508600001)(6666004)(66946007)(66556008)(66476007)(186003)(8676002)(316002)(107886003)(6486002)(2906002)(8936002)(4326008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LJbmgfFy3g+Wy9BaTshUrmmemTcdn1qRj9YQtAqrSE69S8Myjq+V4R72mpFR?=
 =?us-ascii?Q?u+D9QdtJKW3AE+h/XDzD58cPsH6B73DlNw/WFnx+Wfna0PVP1AdWAkB6YIz0?=
 =?us-ascii?Q?kQziMM48WvpHOcP1XXb2imgK/Rezi0o/Md6NrlIG3ZeT0nxuVaavL0TZ6ENY?=
 =?us-ascii?Q?9pLwrqYkhIG4gi91C4csPuivsv5UqvkN0QWyhTSCe6mlIbLEIrAWX1bt5F7R?=
 =?us-ascii?Q?5y7RoceXY4Uv6LEtBm8gOQ86r7BKQbDm4bZsGSr/ZR3/lEPw2vBWgv2i56B7?=
 =?us-ascii?Q?7efs87hOzbvAIVVCIN+FsYuaQZmI/ONxcImp55ki9sCaaxGCuXtGSWp2lqr+?=
 =?us-ascii?Q?nVRuBpcEm75eog5m78hOlKiZ9XmLiv3yS+MF7irKK29CKYg0A0Wz1S4y6QqN?=
 =?us-ascii?Q?i6Uv+efWHsBoDqlA+j7f5SyZZKWmkkxAYr3SzqBt9mEUKv4Pv9vjVnfcSDnV?=
 =?us-ascii?Q?EOFjVnx8tv9oZP6fA064wq/DVQ/HVu3ZZWKQ9lXMTuMU+lIr9h3/YPiCVJB1?=
 =?us-ascii?Q?JfzIi/dEXB/o6WP/O7i3F4a6YCjh/38T9QPP0S5aboLey/WN3cUgUCccyrKD?=
 =?us-ascii?Q?kiTJeErOnqE5YIM3HUYVYownhodSARW60dSAiLVjNcqxwOR2sA/OPhRlFNfL?=
 =?us-ascii?Q?50ZQIy1XUem3xSI7BB7UyIoLW31d1SYQNtRlbMIb6Nm2sQqxeAGVZWo+GSnw?=
 =?us-ascii?Q?ZnlvrYINTocS+pofqgnyY5kJuo0KvN0ju3dOD0q38roj+yvpmnxku/k8kmVn?=
 =?us-ascii?Q?jCXUnNZwNY2bM8rbgxvT+b3d72ipWBT5w9jXlpYCwnGoviVQUzi/CC3PX0Ej?=
 =?us-ascii?Q?pHTCl05+NZzUN+TRk5qmwfdCL4NjojgiZl1xHea/kqn+Y/5RSDPV3Sp/NhFN?=
 =?us-ascii?Q?uloG/9YNfjH9HTxr65vPDq3zcB/oaewJTfiziaKUUj4j+cwfHQxrAnZEwzWA?=
 =?us-ascii?Q?90cZCkuqydaPagfaH4XfsAkuS1tD6WpFd54Z1RAnZU3rYmpqcjcb8+wMxKQ8?=
 =?us-ascii?Q?wEEcgvQjyl34X1jOo0eKzyHj27QVivll0nip1bu88zswtr4qAeDI5Ek58xvh?=
 =?us-ascii?Q?+0waNn9KRXzDNywwuRhe3mBwCQXNdKG4RrSkxEtDtuPH4aCRbAgsG/VoTitE?=
 =?us-ascii?Q?MYuh64Q6beuFGXlCnswOKSRTxgKfSVobSzOND/KMpQ056/9paNB3Oa+Q5Yup?=
 =?us-ascii?Q?c1npR0bq+ydtK0LNinG3Yph/mSu9Ty2RlOaUS6hlrMvAj/nKbw0z1y4MMO2a?=
 =?us-ascii?Q?ilblxY14nZmARJplBUvY01m8sQTZqnt+6npWOqB20yEsxFEqQNaJ0/aEQctc?=
 =?us-ascii?Q?V4qu87pDYTcL2ZPaJDIlVgLgtRggAao/0eevj/7LRPR6//sSs8Nn5EGNXOdI?=
 =?us-ascii?Q?kzmTRKLscorstVfAPyajb7gA5wsjfj7AJRWXgYi9k2qv6UmMZe4G884Dt6tQ?=
 =?us-ascii?Q?ow6Yu0DJbscsJVQaEpF+qVvLiWicGaWhDXsW5+exI4FQj5tYzuBZHFR/R3v4?=
 =?us-ascii?Q?wrLxpWQfJq5MXeBA7gV8VecokjxMR0+P0yhowSR/XJZFbaUDuOPisaZiwMjo?=
 =?us-ascii?Q?w+bN50PCrdefELxrLtJTzowOb90wrRDshR4nB5Bcl1KqCbJPw/n5GV0u6S9+?=
 =?us-ascii?Q?JICSbzxHE8qOWcN0oUioh+latos75Uei6M9nVoo2Yc5d?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aadf8dc-6965-4e18-08d7-08d9c0d16a97
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 20:19:51.9710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: piu5SQb01mKjY0WATqx3Mk7X71d6tmVqfvJdXFPHT1bnwLAoMqFJqYWGFpsE0XOpnzWMac3JcypDPO0KKZ4jdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2541
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10200 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112160110
X-Proofpoint-ORIG-GUID: dA9hO4T1qMXn3hRMLQzWwAc8t9ujXhFn
X-Proofpoint-GUID: dA9hO4T1qMXn3hRMLQzWwAc8t9ujXhFn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This emits a new file, .tmp_vmlinux.ranges, which maps address
range/size pairs in vmlinux to the object files which make them up,
e.g., in part:

0x0000000000000000 0x30 arch/x86/kernel/cpu/common.o
0x0000000000001000 0x1000 arch/x86/events/intel/ds.o
0x0000000000002000 0x4000 arch/x86/kernel/irq_64.o
0x0000000000006000 0x5000 arch/x86/kernel/process.o
0x000000000000b000 0x1000 arch/x86/kernel/cpu/common.o
0x000000000000c000 0x5000 arch/x86/mm/cpu_entry_area.o
0x0000000000011000 0x10 arch/x86/kernel/espfix_64.o
0x0000000000011010 0x2 arch/x86/kernel/cpu/common.o
[...]

In my simple tests this seems to work with clang too, but if I'm not
sure how stable the format of clang's linker mapfiles is: if it turns
out not to work in some versions, the mapfile-massaging awk script added
here might need some adjustment.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
---

Notes:
    v6: use ${wl} where appropriate to avoid failure on UML

 scripts/link-vmlinux.sh | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 5cdd9bc5c385..5301f3e77116 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -196,7 +196,7 @@ vmlinux_link()
 	${ld} ${ldflags} -o ${output}					\
 		${wl}--whole-archive ${objs} ${wl}--no-whole-archive	\
 		${wl}--start-group ${libs} ${wl}--end-group		\
-		$@ ${ldlibs}
+		${wl}-Map=.tmp_vmlinux.map $@ ${ldlibs}
 }
 
 # generate .BTF typeinfo from DWARF debuginfo
@@ -239,6 +239,19 @@ kallsyms()
 {
 	local kallsymopt;
 
+	# read the linker map to identify ranges of addresses:
+	#   - for each *.o file, report address, size, pathname
+	#       - most such lines will have four fields
+	#       - but sometimes there is a line break after the first field
+	#   - start reading at "Linker script and memory map"
+	#   - stop reading at ".brk"
+	${AWK} '
+	    /\.o$/ && start==1 { print $(NF-2), $(NF-1), $NF }
+	    /^Linker script and memory map/ { start = 1 }
+	    /^\.brk/ { exit(0) }
+	' .tmp_vmlinux.map | sort > .tmp_vmlinux.ranges
+
+	# get kallsyms options
 	if [ -n "${CONFIG_KALLSYMS_ALL}" ]; then
 		kallsymopt="${kallsymopt} --all-symbols"
 	fi
-- 
2.34.0.258.gc900572c39

