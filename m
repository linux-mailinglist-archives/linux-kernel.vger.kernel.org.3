Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA43599983
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 12:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348292AbiHSKIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 06:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348205AbiHSKIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:08:17 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AA8A2AD9;
        Fri, 19 Aug 2022 03:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0hZX+
        tOMDMPZsSCoOTot4Hawr1ODy8yH0Xermr/g8hc=; b=YrpnbZcbkI4rvNwQD6G3e
        WCac95eZFD7PgE7uXsgfjYCA/pqkoArqW4W/7yGH9Ze4c/yBjFn01uMCN2HVz1PW
        bTyCTKUZJbTYI17R1wFt40qucQH3kqgb2GwrtZMy/IPfW4JUafViq7GcqU2WMXuJ
        8Xy+ZAxPDxvC6i8D+REXcg=
Received: from localhost.localdomain (unknown [114.247.186.98])
        by smtp2 (Coremail) with SMTP id GtxpCgC3KKXpYP9iFfSYWg--.31202S2;
        Fri, 19 Aug 2022 18:07:38 +0800 (CST)
From:   "longguang.yue" <bigclouds@163.com>
To:     horms@verge.net.au
Cc:     ja@ssi.bg, kadlec@netfilter.org, fw@strlen.de, pablo@netfilter.org,
        lvs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "longguang.yue" <bigclouds@163.com>
Subject: [PATCH] ipvs: add a sysctl switch to control ipvs to bypass OUTPUT chain or not
Date:   Fri, 19 Aug 2022 18:07:02 +0800
Message-Id: <20220819100702.14889-1-bigclouds@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgC3KKXpYP9iFfSYWg--.31202S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr45Jw45ur4UWr47Ar18Xwb_yoWrCF18pF
        90yrWa9r4UJF13Jwn3ArWxuryagr40y34a9F4ak39Yy3WDJr9YqF4YyryYvFyI9rs5WFWr
        XF1Yq3y3Cws8AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziBHq3UUUUU=
X-Originating-IP: [114.247.186.98]
X-CM-SenderInfo: peljuzprxg2qqrwthudrp/xtbBZwpiQ1et8efQQAAAsw
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Netfilter's rules are matched in sequence, more rules worse performance.
IPVS is a special system, its traffic is clear and definite, for better
performance, should better not be interfered heavily. This patch adds a
sysctl switch and enable ipvs to control traffic to pass netfilter
OUTPUT chain or not.

Signed-off-by: longguang.yue <bigclouds@163.com>
---
 include/net/ip_vs.h             | 11 +++++++++++
 net/netfilter/ipvs/ip_vs_ctl.c  |  8 ++++++++
 net/netfilter/ipvs/ip_vs_xmit.c | 31 ++++++++++++++++++++++++-------
 3 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index ff1804a0c469..c1232ef3a1b5 100644
--- a/include/net/ip_vs.h
+++ b/include/net/ip_vs.h
@@ -932,6 +932,7 @@ struct netns_ipvs {
 	int			sysctl_schedule_icmp;
 	int			sysctl_ignore_tunneled;
 	int			sysctl_run_estimation;
+	int			sysctl_output_bypass;
 
 	/* ip_vs_lblc */
 	int			sysctl_lblc_expiration;
@@ -1077,6 +1078,11 @@ static inline int sysctl_run_estimation(struct netns_ipvs *ipvs)
 	return ipvs->sysctl_run_estimation;
 }
 
+static inline int sysctl_output_bypass(struct netns_ipvs *ipvs)
+{
+	return ipvs->sysctl_output_bypass;
+}
+
 #else
 
 static inline int sysctl_sync_threshold(struct netns_ipvs *ipvs)
@@ -1174,6 +1180,11 @@ static inline int sysctl_run_estimation(struct netns_ipvs *ipvs)
 	return 1;
 }
 
+static inline int sysctl_output_bypass(struct netns_ipvs *ipvs)
+{
+	return 0;
+}
+
 #endif
 
 /* IPVS core functions
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index efab2b06d373..8a08a783e85e 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -2019,6 +2019,12 @@ static struct ctl_table vs_vars[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+	{
+		.procname	= "output_bypass",
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
 #ifdef CONFIG_IP_VS_DEBUG
 	{
 		.procname	= "debug_level",
@@ -4094,6 +4100,8 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 	tbl[idx++].data = &ipvs->sysctl_ignore_tunneled;
 	ipvs->sysctl_run_estimation = 1;
 	tbl[idx++].data = &ipvs->sysctl_run_estimation;
+	ipvs->sysctl_output_bypass = 1;
+	tbl[idx++].data = &ipvs->sysctl_output_bypass;
 #ifdef CONFIG_IP_VS_DEBUG
 	/* Global sysctls must be ro in non-init netns */
 	if (!net_eq(net, &init_net))
diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index 029171379884..46a34dd2555e 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -653,8 +653,12 @@ static inline int ip_vs_nat_send_or_cont(int pf, struct sk_buff *skb,
 		skb_forward_csum(skb);
 		if (skb->dev)
 			skb_clear_tstamp(skb);
-		NF_HOOK(pf, NF_INET_LOCAL_OUT, cp->ipvs->net, NULL, skb,
-			NULL, skb_dst(skb)->dev, dst_output);
+		if (sysctl_output_bypass(cp->ipvs)) {
+			dst_output(cp->ipvs->net, NULL, skb);
+		} else {
+			NF_HOOK(pf, NF_INET_LOCAL_OUT, cp->ipvs->net, NULL, skb,
+				NULL, skb_dst(skb)->dev, dst_output);
+		}
 	} else
 		ret = NF_ACCEPT;
 
@@ -675,8 +679,12 @@ static inline int ip_vs_send_or_cont(int pf, struct sk_buff *skb,
 		skb_forward_csum(skb);
 		if (skb->dev)
 			skb_clear_tstamp(skb);
-		NF_HOOK(pf, NF_INET_LOCAL_OUT, cp->ipvs->net, NULL, skb,
-			NULL, skb_dst(skb)->dev, dst_output);
+		if (sysctl_output_bypass(cp->ipvs)) {
+			dst_output(cp->ipvs->net, NULL, skb);
+		} else {
+			NF_HOOK(pf, NF_INET_LOCAL_OUT, cp->ipvs->net, NULL, skb,
+				NULL, skb_dst(skb)->dev, dst_output);
+		}
 	} else
 		ret = NF_ACCEPT;
 	return ret;
@@ -1262,10 +1270,19 @@ ip_vs_tunnel_xmit(struct sk_buff *skb, struct ip_vs_conn *cp,
 	skb->ignore_df = 1;
 
 	ret = ip_vs_tunnel_xmit_prepare(skb, cp);
-	if (ret == NF_ACCEPT)
-		ip_local_out(net, skb->sk, skb);
-	else if (ret == NF_DROP)
+	if (ret == NF_ACCEPT) {
+		if (sysctl_output_bypass(cp->ipvs)) {
+			struct iphdr *iph = ip_hdr(skb);
+
+			iph->tot_len = htons(skb->len);
+			ip_send_check(iph);
+			dst_output(cp->ipvs->net, NULL, skb);
+		} else {
+			ip_local_out(net, skb->sk, skb);
+		}
+	} else if (ret == NF_DROP) {
 		kfree_skb(skb);
+	}
 
 	LeaveFunction(10);
 
-- 
2.34.1

