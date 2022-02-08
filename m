Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3718E4AE140
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385405AbiBHSpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385278AbiBHSo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:44:59 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C54CC0612B9;
        Tue,  8 Feb 2022 10:44:46 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 218ITQ3E011786;
        Tue, 8 Feb 2022 18:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=OKvrIewsRC0n7wQ1ADm9yNHvKDdLBMnjMk3Hmg292Y8=;
 b=vDWJDSDWJouAYAgbTNugpcKcsEm4ZRKe4muzn/jzntOfmYCSuoS18y4RieIeTJqMHrDh
 RX2pSfgTh6n/NMStxTGuAJhXJVd2Pwiiz/0tuGjgmIHGgKzFUGe0zugVYl//K2D/v+27
 thvbX+r51WFx9B2Kp/6WcrWvUJO6xdn1R3EBHX3qFohtH9EEWgnYKRwlkoOXVUYIsamr
 sexRZpn17387J3H6KL28dSdMW7gjMfaX2PC/l1sULcSakvUxny3PFJPQqncrg0RUVyh4
 4BYNMN+B042SXH+h859F1f3aZDBfOJY7n20IkQ8VPv9ycc73uc9hGFfe+OENZsjSYZi5 Og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e345sma1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 18:44:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 218Ia2CI166549;
        Tue, 8 Feb 2022 18:44:13 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2049.outbound.protection.outlook.com [104.47.56.49])
        by userp3020.oracle.com with ESMTP id 3e1jprbdg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 18:44:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W04DJFxhFg2CI+6KMCwe0xiuX8SoRTP8IYGizdwPnULivNDvIZNc8nnisgGRNNA2b0dE/Z5jJxO0Yy6zfq+f5r/91gFa3tpKZn2GL5a7jI3yhoZpCxwiwcH/ySsu/YVhhtAmq9D9xDWHq1Rt3IBjTu3ZqsfedVfojqEruhLr81SsDFe7xO/bJKRCnhIg/JsdtfNtuCCkujVr/stVnnNga+HeRLqy7xe4UGKdry+nz3m2FyCS5ImBwVpBOmOZ9Zrh3cBNE4xnU38o2ZG6iYmBHPivy5sB1NjNAeixujWi9aPyfoKOnqeK32bpzqiYcRDC1nsrIWQO/7kYw1PbpXfL/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKvrIewsRC0n7wQ1ADm9yNHvKDdLBMnjMk3Hmg292Y8=;
 b=MDIR+ViTcxbq6/iDBzktbXqfLqLlCrx12sZgnwHwLzdSTdoIn/D955stJS30O2cOO4wv36FpK17N/eWNDigjhOPluRhktct+PyM6sMrs/Fxv1Al9//DVj7CpvuwXCJTeBPvfMC7D8A/OzM+1SOGVFbvNecp7Go2Z3W25RGe+Et4Hyyqh83jJU7KCb5rBxzbX7+KoY+U1lY+l1e5zFfuuo0IoAlA2+BwYuMN0BWw2jtTISvt0D51HVSf4c47/4Em95/gczuk5FBCwOErT0WElcsO++PixVGX+4Edg25uS/qeOHKwD9/BAIwyd0L9rzPg8jj+D6B8/by5o8LrrwQdq7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKvrIewsRC0n7wQ1ADm9yNHvKDdLBMnjMk3Hmg292Y8=;
 b=humf0VKDHY8wXVG7+BkdfAUGOEf5zzarpnVDXHmY+io+aqLSk3Irgt/Yp33tVXHHxOFH1hUzS1PuzlkZtGmiZLkik+cAYY1C3Ton80QVIPwFFVQLCNUlTlra53Gotz7NNwa7HhTOOioowXSqHAEOB8oCuMR3BpfXAFf+Ywbu2xs=
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SA1PR10MB5781.namprd10.prod.outlook.com (2603:10b6:806:23e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Tue, 8 Feb
 2022 18:44:12 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::644e:5828:a72c:c1de]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::644e:5828:a72c:c1de%3]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 18:44:12 +0000
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
Subject: [PATCH v8 3/6] kbuild: generate an address ranges map at vmlinux link time
Date:   Tue,  8 Feb 2022 18:43:06 +0000
Message-Id: <20220208184309.148192-4-nick.alcock@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7299e23a-43e6-46ff-a828-08d9eb32ff8b
X-MS-TrafficTypeDiagnostic: SA1PR10MB5781:EE_
X-Microsoft-Antispam-PRVS: <SA1PR10MB5781F43BB2256F5980731CA88B2D9@SA1PR10MB5781.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hi+ZgWJuHnvJjNK5TRzX9SH7BWjs+tNHZ7yIUOreLn0m+TpJGdxE4dBncWAq4PxklcHmYppJSx1KIWq6EimIAEx7PUHWnBKoMNsPIjQlOGnVTOT4jF8N91oj5OM9I6w/m2VZS8zuzS2GuGilfJxbut483O2dDCvTF/rmjbW9RtMNSOBI8lj8V8C8RXlJdspYi0xDzUCvDfZmX2ldmjmZFczfbJWQ1jylE48kYplYXyLZDJRSu7aEz6J7K1Sle9ly4X/lWAZzGgFA4UfcXzS1iCKiZbpxUMofiH19hihyKSha3p/NVlqs9Q93zEsV+GpfQG7+7nHqDkvlR9An+SZKycm+1qx2fFo9L/QrtR93+/3YIvvPwvTUk5HrBrF2ljiJFduhDjBoT1GYY4zbW3KX3TI9zbJiObkq35jfTXzp8cYPvKO1dcXay1/TObWAJ2kShmOhefq9ZeP2i43ryuuvL51CGjbx6dvDfFfLxsJEfiv/TeE7EHocjZIu1W3HLdMhjp/6ld0XQ/uoN7JAwUCdFItyd9WGJRhtf38AXjfvWuTWaRdhbaKJW6qfClXFn+EX8UbvapNG9JaaF9VXut1CgV2T941QFaO3McW1AwPuTP72tHqajjUtGAh0w2dkprLaPVmvxUBy76MUIOR35pkdqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(107886003)(86362001)(6486002)(36756003)(52116002)(5660300002)(6512007)(1076003)(508600001)(6506007)(7416002)(186003)(6666004)(8676002)(44832011)(66556008)(316002)(2906002)(8936002)(66476007)(4326008)(2616005)(38100700002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0WrXCYwdBBG3yJITlGaqjgM+3ta16W7RnbwkoQKeTFXiiLO7CAVJ6ewC3eEd?=
 =?us-ascii?Q?N2EmnqZgahYdayiYLCYPDEnrG716rUA2NoCEqXGs0yyD740gxMrAB1hoFV1o?=
 =?us-ascii?Q?0oK3nHOsyziEb3sLlrsjRdEh2BAOAUOZAKQYG8/DiIVT8HX/w8OGn4k7JFwe?=
 =?us-ascii?Q?B1C/ZbgR+H7/1ijO1bP3OZXYLQRbAx8wETxVmQmu8enSt2M98HGLPFQET+J5?=
 =?us-ascii?Q?l1+S+w33EFDqWGkpFLox8dnPbJUfuaBUXVdueL0+gKdkZpZwttSU1ZWpQkTF?=
 =?us-ascii?Q?JeNEkifxgDjsSDIkx0VhxZxXJCgKs0+LB53AfwTvjBaXuWviguD0tjh9+lvF?=
 =?us-ascii?Q?qWQ7Pabtq6dY0EtYWYNmj2NiBrUim5gICAPyiLEaJh9q0GwOEdq1eRHpp6ZE?=
 =?us-ascii?Q?fIQ/XDat9qO7/37apyStESQx1jRo1olvPJzKod/T6kNnG2HzAWA5e1IE5x43?=
 =?us-ascii?Q?u4th4OvmpB5l0TRTSsNID+fOwhdMUMfR65trEW78CA0ze5Xx3xFSSBqkJ8/h?=
 =?us-ascii?Q?O6zUpaGSzbhwfWpJ7RBCR1mMt4yVTxpNtNUeEIRSlTScyLYFF0uwKYHvZJcY?=
 =?us-ascii?Q?GkXwCz7gBltU8+UifqG9hSb5g2WL6y0jczVxhwlJRAXBww78WVxc1Ggt2xRI?=
 =?us-ascii?Q?tjIJX27jyXyRh4rlIy9V7k4aFk+MU0HhuFwBlJBC5LA2iKlQOstIcGHVu9x3?=
 =?us-ascii?Q?b9qRQCWsQW9VipSwbogz/Tmsmic1vYEEOGmzpqpROH4UeIhMynd6dPlpI2oF?=
 =?us-ascii?Q?n55SuMZi269LlST8IXo1/BVoCHYv+8oD2srGz1yqVv8D9/J8+yiEBOKyyg3w?=
 =?us-ascii?Q?FEVWiEBGKA3XR5aovVfanoV5MD4I0nWao8KcI71FfbBvj1N46hJqv5RDNBEa?=
 =?us-ascii?Q?UfkU7xufrMDLEgf/PwoVCGAi2pSe2qnUIYRN6NoBPVnSetKomdk1f1xEt8k4?=
 =?us-ascii?Q?qd3WxYMO2/2tF9z+9KSS3ToqOc4e1iHWW3IsK/mgQ1kR7CJQESiyPTC2frVn?=
 =?us-ascii?Q?Sl8DsxGZ/tMjHKhw/j0RE7mMaVle8LGJ/zQLseJ1AQH+8mPUDlxGX9B9S1RE?=
 =?us-ascii?Q?vLbQpM/2RlZDLHd8uUg0qg2yB739Lf0ek19wCWDpjVLfG78qzSyq04h1zb0Q?=
 =?us-ascii?Q?ZVmnv96IE/h5R3372Tn5kYR3p9E9+dvv4bgbT5iaaLKXaqw6NaQ8HmAHgoq7?=
 =?us-ascii?Q?K3vFMeY0Lp4tKhFtBgnJkz6Lzm3ywgMdQNMFAzNVc+ldbpu+spoMR8zGVaDb?=
 =?us-ascii?Q?Dj7QzJXq0rim0slHMJCqQd88Or5cR1OOWUtILBia4wqioDEpfXIe5A2FKXkB?=
 =?us-ascii?Q?UCvABjvgZ8IZcNroE+QAFG401i7UASRebWxFx+EGNIGW3gTQYRAsVX+o3sUp?=
 =?us-ascii?Q?QbpIW+OnslLkhaBi3Z4jXDx5L3mWSXoiU8sej8fq8KDLjRcm6STCDQVJMqZo?=
 =?us-ascii?Q?oTckXzZjznzKT11ewl4PfsDNF8Tp7hOUrdD/ceqlil5C23eD6Kv8BPHwP1b5?=
 =?us-ascii?Q?LDy6M8XtQOKkDOKisXi2vPuizfDMCf7UdH88KfhEJuBv/2S0fCl6x1AlA0tl?=
 =?us-ascii?Q?4j6NTOz2wuFvLvDW5cztZwd29ux/T4iRMPWC1j9fVDNlThOwAPj3MO1XQROq?=
 =?us-ascii?Q?f7OWJM/I5KNq7gnht5en4e0E7yFEUOEHcEBFmB/VSdQM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7299e23a-43e6-46ff-a828-08d9eb32ff8b
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 18:44:11.9432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qK09pNms3OvQicK92w+BTupqufgjo6qho0AWgg7k8JfA/pQKOpsb7GRsBJpckRPiyGJE9OrN2wqaxllG7diKwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5781
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10252 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202080109
X-Proofpoint-GUID: DKmjGeWeqnWJ_J-6kbtWOobFbYo8HlKK
X-Proofpoint-ORIG-GUID: DKmjGeWeqnWJ_J-6kbtWOobFbYo8HlKK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>
---

Notes:
    v6: use ${wl} where appropriate to avoid failure on UML

 scripts/link-vmlinux.sh | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 666f7bbc13eb..981cd441ca21 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -203,7 +203,7 @@ vmlinux_link()
 	${ld} ${ldflags} -o ${output}					\
 		${wl}--whole-archive ${objs} ${wl}--no-whole-archive	\
 		${wl}--start-group ${libs} ${wl}--end-group		\
-		$@ ${ldlibs}
+		${wl}-Map=.tmp_vmlinux.map $@ ${ldlibs}
 }
 
 # generate .BTF typeinfo from DWARF debuginfo
@@ -246,6 +246,19 @@ kallsyms()
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
 	if is_enabled CONFIG_KALLSYMS_ALL; then
 		kallsymopt="${kallsymopt} --all-symbols"
 	fi
-- 
2.35.0.260.gb82b153193.dirty

