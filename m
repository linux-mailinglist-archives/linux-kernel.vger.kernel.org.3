Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F25448A091
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243419AbiAJT6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:58:15 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:14860 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239531AbiAJT6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:58:14 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AJm5i5026301;
        Mon, 10 Jan 2022 19:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=QpEhT3A33mbY79TXAXq1BUODIaBKsdOSAujrt93UEo0=;
 b=fz91YTFSrMcHyWS6ATJqpQqZJ2zs5twmRYFo6iU+kT7n/iXPuN0Mpy/FfNfYPmrJRXsl
 lq0JFJmf8phq3Ag5f0t5ZL6S4QIND4OPooAzmtfws7zkDtzChfi/nHuBAb7yifoqgdu6
 T8jGHuUTSfwD7N6/xQGP7xmSecj3WdBc5FAVFGROG+CFa63zePDVlJaQ2hyqmDARGOSE
 8uxDgsIC38HeP6q9DTUOzuNKS6QBjnX781TwSdBhC3+OJt3xXgzANDbFCAqdjnREmPy5
 8U7XdK/sFddWk418dzRC9pjFfJu12xW9ew35Bdr5j4v5ejH2wc1rofScuNORj1DBj6TP lg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgp7nh0ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 19:57:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20AJtvVh110383;
        Mon, 10 Jan 2022 19:57:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by aserp3020.oracle.com with ESMTP id 3df2e3ray4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 19:57:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiVLZ67b427s2mMumuLRVEHhdMONKOZf+00zFHSie66TLS1NQAiUNzZ8mtzJOY+gL1CtKutkwKK6cHSaxotUNSi7sEcsDwLGRULJp3UfWJMRwKwINk+ZRWdMYAP0lGqFAT1s71W3qYu7J5jt2ZU8jOxwkTqpexfO+fsIziWNyoRQpaCEVHdmzhbXlOtd4nMJNoWlqgHBnJLfyVV+v72tdj4bNcmE4z3y7mHwFTcFdVOsMFk7aRpiRXbK9/D6iFDnDzv/yVNybUjOVEZVParKaOrcl6nvqJz6+dOndlMaBYtBs/PwU39KF7JwVuQzCmhQYkl245lijDdO4dod7b6qLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpEhT3A33mbY79TXAXq1BUODIaBKsdOSAujrt93UEo0=;
 b=aHBroT0z2kPWfow64oE218Y+BjQZ8jhEUR19pz5QmwfNCx4VO9btc/06XS17kz2blKCFjM5lTICFg2MsScAElfWa9OYa18cnya9Mdcs0Fyad6wEgvrcGLiOI4ilqCzkcZefPlynuzpl6M4Lngn++KNGbZS24GU4qzoN5CMvi9Q0Mllk9doPuIwXfWdxUgSVngHxi5Yv2UR4ek+c9PiSSB1ikuyHOFu/SNldSPOTquI5XMmt/Yk8U3ahH9xjFbZue+9nDfr0yMBb4jCJ4je46lsvv/Sa2ZqyPq3VaNNBQbMKDYVBbpc30Gz+gvJOoUAoNC/FEOzs/20slXGYcmgo8sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpEhT3A33mbY79TXAXq1BUODIaBKsdOSAujrt93UEo0=;
 b=aW8NPOh4Pc/XkGQVqyqwJwb57N8uLatXXdeENTvywMMJTHFw7bk1TX5GqZcC2u8rOO3AmkRrYoRSs49hVRR9PKzRxqXut5Gw36/16k0dEoWoYFuR63ct2pLqHQXa364IdbmCURoFohdxi/MxtS4fkfviMV3R0Cm6ssSMdoOsQik=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MW4PR10MB5701.namprd10.prod.outlook.com (2603:10b6:303:18b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Mon, 10 Jan
 2022 19:57:49 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::d573:6cc0:c616:6f2c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::d573:6cc0:c616:6f2c%6]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 19:57:49 +0000
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
Subject: [PATCH v3 2/6] crash hp: Introduce CRASH_HOTPLUG configuration options
Date:   Mon, 10 Jan 2022 14:57:23 -0500
Message-Id: <20220110195727.1682-3-eric.devolder@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 503232e5-3f4a-49b0-1cb6-08d9d4737a97
X-MS-TrafficTypeDiagnostic: MW4PR10MB5701:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB570170B19D502175A07BFE7B97509@MW4PR10MB5701.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YQ435mDqH+IoyT/EUUiaUB/BA4ivcRLKBPAWZwL47QvwdeyL1NzTYS5esz7sUWifA9jSjM2guKT5ET1aZmog4ZGdCGO1zWyTzkh970WPoFAKzp+RyLYy4itS99Z6sZtgGLGeilmKve3/tHw/Ni53wcwVhxAjF2h7bmDutgxMz8t9KVeSXXo2zRIfgZenHcvnewMDNuXIjMkTHyl3p/9UgVi/4eiwXtZ4M4B22WRLQ4AwcffK1ZSgDb+BxoU9LY0Af117eF92fxfvQMGConlc+tFXtlNPNnSxS/ioGBXvY//9i/9Sfp/7szSyqfHki9gjInqEMxf5j3rh5QKHIg9ZvzfUHl+xnsjzvap934ltNQ5eoWsfxKHqUM/9jd/SbeZQFr07lNjevIaUcwDkh1J900RC4JHJaDDBmoorSvTtmECUJM6Q5V7lhoyixQo5q1Fu9xjHII1wn9HgVMdjUO7QhtluAfbXJapIHn/sXzVErhRl8CvDJ4en4Jg67jk8e4RyB7KX4ch0xg1uDKFu6y/r3rqZ871YLHICaa3cAM+r9FJf8EmKCSusFXqKu8myT07cAGqdjuNyZgMJ49bP9jQj8Arx3u960Q/Q3oqfIo1ZXDTLInc23g8i3BPLPcGEOEr4u1aXdvaE8EYXg1kQ306Y9nWZxckas3e41ua//wBD0BS+x3CAkybYkoAoxHhoTpHtT6iOUPgBLkE/KAZtCNh+Lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(66946007)(66476007)(5660300002)(36756003)(2906002)(8676002)(6512007)(52116002)(8936002)(6506007)(4326008)(26005)(508600001)(1076003)(66556008)(6486002)(38100700002)(107886003)(38350700002)(186003)(316002)(7416002)(6666004)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eEqkmUskNSU/p4hPpJrsPwvC2X4Z1k0Z0xCf4lQx7pH/cBvAIPJqIRILyNQr?=
 =?us-ascii?Q?vl51XKV7P1C73RvjWvr0HP5gXx6zpNhZmFlU1/B4UBLMkW6v8pNlBhTw/fzL?=
 =?us-ascii?Q?bvNFrL5tIJTXaKe43Y5pTG2ZOI2Hbsn/knP7J6hqxUCc0r6SkziMoByn76Lo?=
 =?us-ascii?Q?MZE87jMOc+hux2keu5Y/SooEw7hKz3qt8hZEbVNy9kHi5wk2/gLrGe89H4Iu?=
 =?us-ascii?Q?Chr6qCYf+qYVga28gHEc1Wf/U0h5olXqBA8UKKGEPDM9WCe22AMqymozClg3?=
 =?us-ascii?Q?ER4OhluoO8DsGnWUjTIqJd0NRzivKar8+1gb35NBXYgeaNhDwadpJfNDYcFc?=
 =?us-ascii?Q?piYW0AVl8bX6qq47jPv+MlfkcYpcCMsZ67vfsTMClN6yVTmLz/LDqzmwH2Ld?=
 =?us-ascii?Q?jHIcQgU2hCOrV1+ao3btraxSuScmlghiaaGXSUkwOSWF/7ZYTyTdf/RE8SgP?=
 =?us-ascii?Q?aKDWUz/RQwa2CiYH8sToZczlR6x9M5tZsqoIyfXBQU4xw4VwZvZel0zAwNGE?=
 =?us-ascii?Q?6mHtAvNov4HP8yM1hepIzm8ECgdoahtfen86SNpFxtAIvWu99EOYLHUnzQKp?=
 =?us-ascii?Q?97JQzy8rqR6WBkjVKrGs32hGzg7uZFhkj93HwiN1taVLvhSexuNP8fy3pSHy?=
 =?us-ascii?Q?wkkhMts262wfVf3Uu2reHrYMBNxqqk/9d//wJykn2sKzgNNusxhE7SBut96G?=
 =?us-ascii?Q?VqKbjgGytWgXJMrN4SJXn9SbuAWYKAy9T/0TSwpkA1Q2146Wxl6lEI742lls?=
 =?us-ascii?Q?E0fKrJatfMKcPlWZKzdq3y/OlW4WU33FDqUgACvUVe5tj42P14CuMZDd1fK1?=
 =?us-ascii?Q?7wuUchwZTX5fEdPQNdA70VAgvr89NqWGUYsCPAS5iJKwR1NJCj5Ojp4InLlk?=
 =?us-ascii?Q?UVDl6BsoblHlITsuUmzadx4FilDZctBBKzzKpNOp+x2D+K4OMJF0noZ02f5y?=
 =?us-ascii?Q?4aVZLVGoHlrcw1qOe4mu1ujJaRZbyIMH/yuDrPYZwxNaeAQgoOa8zC5AIHpN?=
 =?us-ascii?Q?MKJwzvbPTvfDxTRVklppRiwVXmFEiET/33l5m2XHm2KOj5FgjlPqAV4o5u1i?=
 =?us-ascii?Q?2kIAk6z/1UirQvc1Hn+Ge72odguSyu//2ys8aEE5f/miMOWznEIgTt2FVL46?=
 =?us-ascii?Q?hUEUgWS0WiPBa9G/ZryyOr5vEPHBFSav7A6WeIgj3XNDEixpayNRvyaUrpMN?=
 =?us-ascii?Q?GN1bg54rL7CsJlInjq9Gtr4QuyBnCd3KoEixJz2VSqG2Gwqon1Qcw9JFcUdX?=
 =?us-ascii?Q?Q2GWsac8OaSYreqxjFjKSnLYkuif7VmWzvpIDggNh7TVSC2D1h5tp4J8C2N0?=
 =?us-ascii?Q?3Zy4i5pQxpnj7ASSRfgs3odPMvcYmp43lMNyUi4b+G/8Pc8iLLgoUfaA6lbE?=
 =?us-ascii?Q?rkfKUI5BGi/er8udqPfUKqHb3KNBLZKPwnEywHRJdy9q7MW35JUUWuf6+/gQ?=
 =?us-ascii?Q?VkVNeuW3x0UrdXKmcXtm22p5791EUblH7246QLpuuBj+EkhATOmMdM9Lhg6W?=
 =?us-ascii?Q?EDpWxAN5K+N3f3QOu4w41d+6f8J/LOKMRkixGzBG4r+cmJY+Fv7/Y4cs6Lq7?=
 =?us-ascii?Q?ftkS/ziubkFvE0q52tSgLccH+JgWi+Y23B/wh+lfAEks6i4YgIraA1fmVybo?=
 =?us-ascii?Q?hlX5ptzpFdkZ32WkYKgkg+zZCiTYG020q6xl8QwuNToNjqU2g3zCLehZ6+cV?=
 =?us-ascii?Q?bThN8A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 503232e5-3f4a-49b0-1cb6-08d9d4737a97
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 19:57:49.5030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOOlgSaNdmiex7l8v0WeZb3Pcy1NnB/8/4nW1MKWluscUe4ApqIgYizPnT/1RLCxD9HzhdDDg6RMnBdZZ5x/ce7mTh40eOQR2gE9ZWDysTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5701
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100136
X-Proofpoint-GUID: V4t6ZCQpI4kmx5E8JOBPoMO_8GTzFpDc
X-Proofpoint-ORIG-GUID: V4t6ZCQpI4kmx5E8JOBPoMO_8GTzFpDc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for CPU and memory hotplug for crash is controlled by the
CRASH_HOTPLUG configuration option, introduced by this patch.

The CRASH_HOTPLUG_ELFCOREHDR_SZ related configuration option is
also introduced with this patch.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/Kconfig | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5c2ccb85f2ef..fcaae76fcfe9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2047,6 +2047,32 @@ config CRASH_DUMP
 	  (CONFIG_RELOCATABLE=y).
 	  For more details see Documentation/admin-guide/kdump/kdump.rst
 
+config CRASH_HOTPLUG
+	bool "kernel updates of crash elfcorehdr"
+	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG) && KEXEC_FILE
+	help
+	  Enable the kernel to update the crash elfcorehdr (which contains
+	  the list of CPUs and memory regions) directly when hot plug/unplug
+	  of CPUs or memory. Otherwise userspace must monitor these hot
+	  plug/unplug change notifications via udev in order to
+	  unload-then-reload the crash kernel so that the list of CPUs and
+	  memory regions is kept up-to-date. Note that the udev CPU and
+	  memory change notifications still occur (however, userspace is not
+	  required to monitor for crash dump purposes).
+
+config CRASH_HOTPLUG_ELFCOREHDR_SZ
+	depends on CRASH_HOTPLUG
+	int
+	default 131072
+	help
+	  Specify the maximum size of the elfcorehdr buffer/segment.
+	  The 128KiB default is sized so that it can accommodate 2048
+	  Elf64_Phdr, where each Phdr represents either a CPU or a
+	  region of memory.
+	  For example, this size can accommodate hotplugging a machine
+	  with up to 1024 CPUs and up to 1024 memory regions (e.g. 1TiB
+	  with 1024 1GiB memory DIMMs).
+
 config KEXEC_JUMP
 	bool "kexec jump"
 	depends on KEXEC && HIBERNATION
-- 
2.27.0

