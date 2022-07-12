Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11295722BB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 20:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbiGLSfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 14:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiGLSfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 14:35:04 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710F1BE680
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 11:35:03 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id c18-20020a17090a8d1200b001ef85196fb4so7950503pjo.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 11:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aTFa+EXvspcGAaBNVFKNjAnYDuS4P2vMVH5b6FohaN0=;
        b=PxFEJSeldFwzWT/ph478MqOUHbaDyBkFP5YVbw2uC7i8ch7kIt7z2Kd13rfQsnd4J4
         ihsTP3NXqEr3e1i+6fCQf9dAWOgqkbK92Xr+/BOwO+hxTGdCyztyA3XWWNTQSkkkpZEi
         DKCnEk5o4jIqddeT3oqzM2ymhe8BRFGVQ6liu2WAnOJWGBD2AoIwosYw9zw61wZEgWtK
         qkojML11B+F8ndVNJl82aFFeMPeQevywCc0Xk2YuUPPJhhiMNU5z3NVUbWzXFGLhZqbH
         C+yG/gNVbNdkCO67Mfhi9qjzFMop9H+YTsCkfdbHDUAoko5638JvKH9nOV5FQpB3k5vc
         KB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aTFa+EXvspcGAaBNVFKNjAnYDuS4P2vMVH5b6FohaN0=;
        b=pUb9OZ8qkuxZfUbSUwAP9/wTOHyYuLzxMFy8/9PK75P386fWom7czXuomTMqWwz3Ka
         l4o8wLwanuhBVXC4cl43h19lwP+ELk84CfeYVPpFHHMKEWuUXPJg4+1qCT++S9Hcct4g
         7PMlOieixzZH4AUDibgWEcNd6cg8lIDI1TRxECQ5uKD/o4pEX379/UfRURy+FCcgG98Y
         4TDrKUKlTmvPIJWCgSg/ydaP52vk7j802kEqh25HKM6PpIalfoZI8ffTfAe0+p7QTEJB
         ncn7a59HhG0/0FMSctqAWP708x+AsrpishvyFB7GPPMrgUIz9ksZMb206myY7+F6U4Xz
         jAEg==
X-Gm-Message-State: AJIora8UQja/3a3Lm/lj4nuHX9KHc1JAw1o7Ep7h23/I0ze6X6Pbdv/F
        7SE+1Q/oORg8CRYqqQBTSDww5iMgHyucWFWJUw==
X-Google-Smtp-Source: AGRyM1u2jFGn06qwns9QwaUZtogt9vhqbc3XHrPa+A5/DP9jt5eA8c+8dgfFzOmuVTewki+898hLqu6jkozgkPoeVw==
X-Received: from justinstitt.mtv.corp.google.com ([2620:15c:211:202:b1e8:210d:ae12:d0df])
 (user=justinstitt job=sendgmr) by 2002:aa7:88d5:0:b0:52a:ea1f:50c6 with SMTP
 id k21-20020aa788d5000000b0052aea1f50c6mr3988540pff.81.1657650903009; Tue, 12
 Jul 2022 11:35:03 -0700 (PDT)
Date:   Tue, 12 Jul 2022 11:34:52 -0700
In-Reply-To: <Ys0zZACWwGilTwHx@salvia>
Message-Id: <20220712183452.2949361-1-justinstitt@google.com>
Mime-Version: 1.0
References: <Ys0zZACWwGilTwHx@salvia>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
Subject: [PATCH] netfilter: xt_TPROXY: remove pr_debug invocations
From:   Justin Stitt <justinstitt@google.com>
To:     pablo@netfilter.org
Cc:     coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com,
        fw@strlen.de, justinstitt@google.com, kadlec@netfilter.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pabeni@redhat.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pr_debug calls are no longer needed in this file.

Pablo suggested "a patch to remove these pr_debug calls". This patch has
some other beneficial collateral as it also silences multiple Clang
-Wformat warnings that were present in the pr_debug calls.

Suggested-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Suggestion here: https://lore.kernel.org/all/Ys0zZACWwGilTwHx@salvia/

 net/netfilter/xt_TPROXY.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/net/netfilter/xt_TPROXY.c b/net/netfilter/xt_TPROXY.c
index 459d0696c91a..dc7284e6357b 100644
--- a/net/netfilter/xt_TPROXY.c
+++ b/net/netfilter/xt_TPROXY.c
@@ -74,18 +74,10 @@ tproxy_tg4(struct net *net, struct sk_buff *skb, __be32 laddr, __be16 lport,
 		/* This should be in a separate target, but we don't do multiple
 		   targets on the same rule yet */
 		skb->mark = (skb->mark & ~mark_mask) ^ mark_value;
-
-		pr_debug("redirecting: proto %hhu %pI4:%hu -> %pI4:%hu, mark: %x\n",
-			 iph->protocol, &iph->daddr, ntohs(hp->dest),
-			 &laddr, ntohs(lport), skb->mark);
-
 		nf_tproxy_assign_sock(skb, sk);
 		return NF_ACCEPT;
 	}
 
-	pr_debug("no socket, dropping: proto %hhu %pI4:%hu -> %pI4:%hu, mark: %x\n",
-		 iph->protocol, &iph->saddr, ntohs(hp->source),
-		 &iph->daddr, ntohs(hp->dest), skb->mark);
 	return NF_DROP;
 }
 
@@ -123,13 +115,11 @@ tproxy_tg6_v1(struct sk_buff *skb, const struct xt_action_param *par)
 
 	tproto = ipv6_find_hdr(skb, &thoff, -1, NULL, NULL);
 	if (tproto < 0) {
-		pr_debug("unable to find transport header in IPv6 packet, dropping\n");
 		return NF_DROP;
 	}
 
 	hp = skb_header_pointer(skb, thoff, sizeof(_hdr), &_hdr);
 	if (hp == NULL) {
-		pr_debug("unable to grab transport header contents in IPv6 packet, dropping\n");
 		return NF_DROP;
 	}
 
@@ -168,19 +158,10 @@ tproxy_tg6_v1(struct sk_buff *skb, const struct xt_action_param *par)
 		/* This should be in a separate target, but we don't do multiple
 		   targets on the same rule yet */
 		skb->mark = (skb->mark & ~tgi->mark_mask) ^ tgi->mark_value;
-
-		pr_debug("redirecting: proto %hhu %pI6:%hu -> %pI6:%hu, mark: %x\n",
-			 tproto, &iph->saddr, ntohs(hp->source),
-			 laddr, ntohs(lport), skb->mark);
-
 		nf_tproxy_assign_sock(skb, sk);
 		return NF_ACCEPT;
 	}
 
-	pr_debug("no socket, dropping: proto %hhu %pI6:%hu -> %pI6:%hu, mark: %x\n",
-		 tproto, &iph->saddr, ntohs(hp->source),
-		 &iph->daddr, ntohs(hp->dest), skb->mark);
-
 	return NF_DROP;
 }
 
-- 
2.37.0.144.g8ac04bfd2-goog

