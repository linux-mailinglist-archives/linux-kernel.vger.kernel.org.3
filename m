Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5298A54B05A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245160AbiFNMNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356831AbiFNMMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:12:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8042949FA0;
        Tue, 14 Jun 2022 05:12:39 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LMnMs47CPzjXcV;
        Tue, 14 Jun 2022 20:11:05 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 20:12:34 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] lsm_audit: Clean up redundant NULL pointer check
Date:   Tue, 14 Jun 2022 20:10:30 +0800
Message-ID: <20220614121030.115491-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The implements of {ip,tcp,udp,dccp,sctp,ipv6}_hdr(skb) guarantee that
they will never return NULL, and elsewhere user don't do the check
as well, so remove the check here.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 security/lsm_audit.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 78a278f28e49..75cc3f8d2a42 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -44,9 +44,6 @@ int ipv4_skb_to_auditdata(struct sk_buff *skb,
 	struct iphdr *ih;
 
 	ih = ip_hdr(skb);
-	if (ih == NULL)
-		return -EINVAL;
-
 	ad->u.net->v4info.saddr = ih->saddr;
 	ad->u.net->v4info.daddr = ih->daddr;
 
@@ -59,8 +56,6 @@ int ipv4_skb_to_auditdata(struct sk_buff *skb,
 	switch (ih->protocol) {
 	case IPPROTO_TCP: {
 		struct tcphdr *th = tcp_hdr(skb);
-		if (th == NULL)
-			break;
 
 		ad->u.net->sport = th->source;
 		ad->u.net->dport = th->dest;
@@ -68,8 +63,6 @@ int ipv4_skb_to_auditdata(struct sk_buff *skb,
 	}
 	case IPPROTO_UDP: {
 		struct udphdr *uh = udp_hdr(skb);
-		if (uh == NULL)
-			break;
 
 		ad->u.net->sport = uh->source;
 		ad->u.net->dport = uh->dest;
@@ -77,8 +70,6 @@ int ipv4_skb_to_auditdata(struct sk_buff *skb,
 	}
 	case IPPROTO_DCCP: {
 		struct dccp_hdr *dh = dccp_hdr(skb);
-		if (dh == NULL)
-			break;
 
 		ad->u.net->sport = dh->dccph_sport;
 		ad->u.net->dport = dh->dccph_dport;
@@ -86,8 +77,7 @@ int ipv4_skb_to_auditdata(struct sk_buff *skb,
 	}
 	case IPPROTO_SCTP: {
 		struct sctphdr *sh = sctp_hdr(skb);
-		if (sh == NULL)
-			break;
+
 		ad->u.net->sport = sh->source;
 		ad->u.net->dport = sh->dest;
 		break;
@@ -115,8 +105,6 @@ int ipv6_skb_to_auditdata(struct sk_buff *skb,
 	__be16 frag_off;
 
 	ip6 = ipv6_hdr(skb);
-	if (ip6 == NULL)
-		return -EINVAL;
 	ad->u.net->v6info.saddr = ip6->saddr;
 	ad->u.net->v6info.daddr = ip6->daddr;
 	/* IPv6 can have several extension header before the Transport header
-- 
2.17.1

