Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A175D52DD1D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244113AbiESSv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243463AbiESSvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:51:49 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2111.outbound.protection.outlook.com [40.107.22.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A933D5C74B;
        Thu, 19 May 2022 11:51:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSL8NuRd/P36+WAx74ABT2Ukk3LI42HqbeZWvQxhhxE+NowfuRWbJSo7uOB/HfkBv4zlgCLvS1jGlhB/DzYjTcfYrYG/Pmc8LpllxLm3KjN3O+k81fY1U7SRWcMRBCRHNn6Zs7P+gma80TdqWJ9R7ufwDHncpVjofSewEOTtIR3xFUq5OzOzAVKTeQYCef5i6jcnEC35Rlxrn+uv/e9Ei8zf9zeWJmOzgTe2n9SXZb8BN6hXEBjqxr98TEg4tdcnEisWrZlOmntuGu/EevDY7mSgcD7Id/aeMDq1nMiatjAYLYk7aF8qgPWFYN4l+gQGVl63jTYvfLll74hJYdb8KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IeUZ1Ug3OZrTf+7V9IOx/s+4P8CLFwfqXydfULKSVo0=;
 b=VD6jYRYhqL85C3YjdR+wS6hwc0CdFXwaW897XYb7HSIS4uPUnIYEo4TdsB83V5miq7qXwfyx+s4AZvQhjJbRabOAMXUjj0Dr8+MFq+B7bYopLaYaZy8lZC5cMogKA4wj08rSIJBknAPy1XATtVX8gNgnLwScjyhSUmpJ+CXIIcvoPtCoXpCnCGPYt316JbxdgksTqM3Dfc5hTFmQlivw/ut881KhePLBDzJQvhrRT2nEAYYR/Cgxw12ZkVRZ6A7t180ZpK1/8Obpa5osIrtj2JMd3ghPisu5eSyBbPuL3kvR/NoELiGLdhZck9O+behQ4a+43vHmpgwBPQbpBkCUag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeUZ1Ug3OZrTf+7V9IOx/s+4P8CLFwfqXydfULKSVo0=;
 b=Qy0MP3wEBGscOr2G9yH2zFWi5To8F6D7YtQklqVcNPWHE4UXcC6vV6tjtTYsrYrdNsPfUlwHeec13JKZEeQqs1ksMkgi5ANzqn3K5fEo7YbRNd8RKY3OXgI6FGvv2ALMkoTRv4f/O9dvKm2pN4QPxKIkUs3BqvkLbqHOHaU37lY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com (2603:10a6:803:51::25)
 by AM5PR0301MB2546.eurprd03.prod.outlook.com (2603:10a6:203:a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Thu, 19 May
 2022 18:51:44 +0000
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::b513:6272:f3c5:c709]) by VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::b513:6272:f3c5:c709%7]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 18:51:44 +0000
From:   Dragan Mladjenovic <Dragan.Mladjenovic@syrmia.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Paul Burton <paulburton@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        Greg Ungerer <gerg@kernel.org>,
        Chao-ying Fu <cfu@wavecomp.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] MIPS: CPS: Add a couple of multi-cluster utility functions
Date:   Thu, 19 May 2022 20:51:14 +0200
Message-Id: <20220519185125.11686-2-Dragan.Mladjenovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220519185125.11686-1-Dragan.Mladjenovic@syrmia.com>
References: <20220519185125.11686-1-Dragan.Mladjenovic@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0602CA0016.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::26) To VI1PR03MB4208.eurprd03.prod.outlook.com
 (2603:10a6:803:51::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63da7aa5-206d-4a7f-ff24-08da39c89e2c
X-MS-TrafficTypeDiagnostic: AM5PR0301MB2546:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0301MB2546B8D2A57841B79BC13E59EFD09@AM5PR0301MB2546.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W5lsVUT8w+QoeEFDvOe+FRvOK5/DwE0HV022VEC6kFgmENF1XKvSTxQ5UNeg1DGuiiogwS3sjEDEWxn1ZR1x2nzniiyF6fFOYxHao8IkT/U323eeNKuAcyfO4IhAfIDaLImwD0GhdZBCcZ5W6RcPX07o1vC4ZPyqSFc/2w5X2t2nNoy4Kr71gH3S36scscYeX95ZISbQ59UEb9fepngKKZkKlne3ldnzBXjq1y5HBEgUwGPmjRhVS/5cB+ps1eBzuska/kaxCke1wQBPbuAJnCVomz9gbKaXW5Up9YpfkhSAAJ2ClI4m2MKJvS8QBuk74PwlrqLE1SLeK7sTed9KvK5kxpq8a9bMTit98AQsyiAT10XeZdI/T5JvsZQhW0a4c5IyeCwy57dZtWWfOt5TLtWCyedYVhJ7ikYdbaypJpXuEMHo9OC3vwLJoLsIyVqegye0c1X5BkitsoHVOMOLV7Wpmq6RESzVRthOPDdiFUDnSXRDSuu9G4/kR6GSFOQNggj5tsW0pbscIcpKfwxd9rm3URQTAtYfboDDu+Vpi/RVzExY6QzfoinpOw1maHsLhWrmMbpf+5Fo6mHevTYq5ez4QLs25qdffCxUek8ZdlCkef9pW6Ti7+GYaGUpLSARG+kPg77MsAavc2QcrlpG9JNLutNObS2cJOE7TshTWjalDHtBVVTe+M6Tzrep3iuUZS44UsWCHtR3X/d/9peElg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4208.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(346002)(366004)(39840400004)(396003)(136003)(5660300002)(66476007)(66556008)(38100700002)(8676002)(38350700002)(4326008)(8936002)(66946007)(83380400001)(6512007)(26005)(86362001)(36756003)(52116002)(316002)(6666004)(41300700001)(2906002)(6916009)(54906003)(6506007)(6486002)(1076003)(2616005)(186003)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MEeBHc6sRFM0yoalDh8GRqv3HkxoMy6upXMQL7ywy9ot5MDjqvCuPsiFxBw0?=
 =?us-ascii?Q?YHvNzXng1Sgnm/t/byIwlKPk8P1J7FqxBnu/QTTbKwALAWQDB5a+yvyO3glj?=
 =?us-ascii?Q?WV22iAcY1lWuUP/9VXrf4wBwDqQmvsXeIjWfkKeZj+2Fd4FjNPsJA4c5YpvZ?=
 =?us-ascii?Q?5GUTx3wGqGPEbj0TPvYag+kB1IpGFdIj7SmVa8QqH+tqQ8bTOJf1uLb+oOAh?=
 =?us-ascii?Q?yHYtoz7Ph/EdAWk1bwu396LXr9fb3Z3GFsCh4egYFsY0NvdPKyhicFhox8xG?=
 =?us-ascii?Q?Kt5Jdr3AFSp0l+MM5XhPiK6iaBM08xT9K1INR96w0KdaXXmcjkW/VAS4k50n?=
 =?us-ascii?Q?IfSlma6VQOEJcNpjbvwdKlA9DMiTMIe3VJUYQElZ1RfiLM9T4PQw+9sw6bHh?=
 =?us-ascii?Q?gE4fN24CYrl5PVUa49bK+ztvmQ0CSfP3kCtMkoe7Xq5mmJ0idgjqdLknCfG1?=
 =?us-ascii?Q?Ht8i24uMza4A1uhZf29rqZovL5fvyvGtQswzXkd+AtOn8RnghWPwnzxRI+A1?=
 =?us-ascii?Q?4tX93CDdRxVhLp2VuOmlJPW5jDQ+B4Q2vLPq3SKzZv7bEi3l7zpMZi+UIw2M?=
 =?us-ascii?Q?Ov2mcWgZpeGe4Cz3HG+bI6eedWHKtTLE67xvFzBiX3dAEFv3troj8/44mrs5?=
 =?us-ascii?Q?5r4FGVVsiL0Nf435BWhAsqS0md5Ftcva5YneHDa16eKOMFXRe9jR8IqkJECu?=
 =?us-ascii?Q?fLpMdK6pCm3cjcYGioXFYPiVbay2NaJYhkrWceEodA5uJrG5UbI+mw7OZfLS?=
 =?us-ascii?Q?H3pXMnZ8B7l2LEQMZKUVboF0kpd36P6THJVdBILEzQznZCDEnNgHPcnak6Ik?=
 =?us-ascii?Q?3Hxui2WVFl6LYo3mzqWO1ej3L5P0HQvf1qzyt5+5au6a0LM80PuYNJXAtzgI?=
 =?us-ascii?Q?aqVqY9AsDHtwZBqquQTd/GmWgHX9QVrAWNoHCuOVXBKpN6NY4ee955IT9SXB?=
 =?us-ascii?Q?QQvgfYIqyyn4ss7pW9yoIE6srA7dOcKF08rokAhgmYdgB1iwAJGnEGEW0OAK?=
 =?us-ascii?Q?nXdAubXIOz/M5b/Lq2kWb1y/iowQl5JJDZDaxfgQBpHPasO/Z6GMzr9ecEUC?=
 =?us-ascii?Q?b64a3hMdhHqEqehrzE2DFT9FWEdSvoT9ewkTcsVrpfs4V26679dqBL9XYR+l?=
 =?us-ascii?Q?virreVGakY0eiQwWbbTFNpM+FoGYPADhzbto3lADzWHQJkpcePO1cdhWSuqQ?=
 =?us-ascii?Q?jscFpNFJZBwMRMOg6IyMzN1EUYsO/yMDbJ3bziQjISJKzRMwYwuM3Tf/UwjF?=
 =?us-ascii?Q?8HWlzmfJOE9ppx3uoSKhBRkJGd6k2JOLjBA6bZgGA/8xqrKBLbis4V2mrkWd?=
 =?us-ascii?Q?yiCXK1vTvZrNrXPnzkQv6n13WXrC93aBnYxy4vwS5YxQnINBcG2LK1Eo4gWq?=
 =?us-ascii?Q?zbzGDz/ABx4fjHEWgQe/8CgUgTnmD+8NiqsiUU3Icmxi1UyyPWKM76lCkmJ5?=
 =?us-ascii?Q?7/uAdbV0rqw84JRi9LF7DCYUcQphue6lnsY0NqKyg5ZCPC6mNAE/Pk4QUybR?=
 =?us-ascii?Q?zdZ+feR+D5vcOfIItLUJqyIjJ7ZMk+dundexltTmhaFc0M2/b9qOYFzUAV3e?=
 =?us-ascii?Q?RnaI37RmwFftTTTigv0RVosG4NRN3s19qkWHRy9BU+MAwBH581/RimLB1h8C?=
 =?us-ascii?Q?O3dzKoLzGj0leo4GcA/mmOG8R3mMqW8b4HtA38j32nTQ4bVWi5XDoRv0Eph9?=
 =?us-ascii?Q?FpWEWwVcI5lvUiLl5fPNwV6dxkcgm0rDpssXaKWlFN1XPsIvB1FNWzkbxT9e?=
 =?us-ascii?Q?okz6rSchSvvTKkBL0eQyb9UE0olpFYY=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63da7aa5-206d-4a7f-ff24-08da39c89e2c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4208.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 18:51:43.8681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tPCmlLnUiUS2vrJoXXE6ZoD6EKod03CfSmAxIKMA/QbcszV9Gn4SpO2/469ahRYYXr2Lq39Y87WwX41uln1HJK+XUeaEANFPDXSwH9rEgiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0301MB2546
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Burton <paulburton@kernel.org>

This patch introduces a couple of utility functions which help later
patches with introducing support for multi-cluster systems.

 - mips_cps_multicluster_cpus() allows its caller to determine whether
   the system includes CPUs spread across multiple clusters. This is
   useful because in some cases behaviour can be more optimal taking
   this knowledge into account. The means by which we check this is
   dependent upon the way we probe CPUs & assign their numbers, so
   keeping this knowledge confined here in arch/mips/ seems appropriate.

 - mips_cps_first_online_in_cluster() allows its caller to determine
   whether it is running upon the first CPU online within its cluster.
   This information is useful in cases where some cluster-wide
   configuration may need to occur, but should not be repeated if
   another CPU in the cluster is already online. Similarly to the above
   this is determined based upon knowledge of CPU numbering so it makes
   sense to keep that knowledge in arch/mips/. The function is defined
   in mips-cm.c rather than in asm/mips-cps.h in order to allow us to
   use asm/cpu-info.h & linux/smp.h without encountering an include
   nightmare.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>

diff --git a/arch/mips/include/asm/mips-cps.h b/arch/mips/include/asm/mips-cps.h
index c077e8d100f5..fa71cf3a25d7 100644
--- a/arch/mips/include/asm/mips-cps.h
+++ b/arch/mips/include/asm/mips-cps.h
@@ -228,4 +228,42 @@ static inline unsigned int mips_cps_numvps(unsigned int cluster, unsigned int co
 	return FIELD_GET(CM_GCR_Cx_CONFIG_PVPE, cfg + 1);
 }
 
+/**
+ * mips_cps_multicluster_cpus() - Detect whether CPUs are in multiple clusters
+ *
+ * Determine whether the system includes CPUs in multiple clusters - ie.
+ * whether we can treat the system as single or multi-cluster as far as CPUs
+ * are concerned. Note that this is slightly different to simply checking
+ * whether multiple clusters are present - it is possible for there to be
+ * clusters which contain no CPUs, which this function will effectively ignore.
+ *
+ * Returns true if CPUs are spread across multiple clusters, else false.
+ */
+static inline bool mips_cps_multicluster_cpus(void)
+{
+	unsigned int first_cl, last_cl;
+
+	/*
+	 * CPUs are numbered sequentially by cluster - ie. CPUs 0..X will be in
+	 * cluster 0, CPUs X+1..Y in cluster 1, CPUs Y+1..Z in cluster 2 etc.
+	 *
+	 * Thus we can detect multiple clusters trivially by checking whether
+	 * the first & last CPUs belong to the same cluster.
+	 */
+	first_cl = cpu_cluster(&boot_cpu_data);
+	last_cl = cpu_cluster(&cpu_data[nr_cpu_ids - 1]);
+	return first_cl != last_cl;
+}
+
+/**
+ * mips_cps_first_online_in_cluster() - Detect if CPU is first online in cluster
+ *
+ * Determine whether the local CPU is the first to be brought online in its
+ * cluster - that is, whether there are any other online CPUs in the local
+ * cluster.
+ *
+ * Returns true if this CPU is first online, else false.
+ */
+extern unsigned int mips_cps_first_online_in_cluster(void);
+
 #endif /* __MIPS_ASM_MIPS_CPS_H__ */
diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index b4f7d950c846..5b843c2ff077 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -513,3 +513,40 @@ void mips_cm_error_report(void)
 	/* reprime cause register */
 	write_gcr_error_cause(cm_error);
 }
+
+unsigned int mips_cps_first_online_in_cluster(void)
+{
+	unsigned int local_cl;
+	int i;
+
+	local_cl = cpu_cluster(&current_cpu_data);
+
+	/*
+	 * We rely upon knowledge that CPUs are numbered sequentially by
+	 * cluster - ie. CPUs 0..X will be in cluster 0, CPUs X+1..Y in cluster
+	 * 1, CPUs Y+1..Z in cluster 2 etc. This means that CPUs in the same
+	 * cluster will immediately precede or follow one another.
+	 *
+	 * First we scan backwards, until we find an online CPU in the cluster
+	 * or we move on to another cluster.
+	 */
+	for (i = smp_processor_id() - 1; i >= 0; i--) {
+		if (cpu_cluster(&cpu_data[i]) != local_cl)
+			break;
+		if (!cpu_online(i))
+			continue;
+		return false;
+	}
+
+	/* Then do the same for higher numbered CPUs */
+	for (i = smp_processor_id() + 1; i < nr_cpu_ids; i++) {
+		if (cpu_cluster(&cpu_data[i]) != local_cl)
+			break;
+		if (!cpu_online(i))
+			continue;
+		return false;
+	}
+
+	/* We found no online CPUs in the local cluster */
+	return true;
+}
-- 
2.17.1

