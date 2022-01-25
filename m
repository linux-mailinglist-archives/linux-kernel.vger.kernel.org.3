Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DF149B5F0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578284AbiAYORo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578154AbiAYOPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:15:01 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041D3C06175B;
        Tue, 25 Jan 2022 06:15:01 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id n10so47532544edv.2;
        Tue, 25 Jan 2022 06:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s0qfbDNJzKPba0DhXnUemGGVEXLf9/4C8NsMtd615sM=;
        b=jK5IrrVPlyG0wXI7OOjPs/2Yvc2N9yPtJs/Q4+Tt6MtETCsPvR3W7UUpqGHjB/HqYU
         JN+bFWu6P4SRwCcm0DoquiiZj5wgsQoZCGXo9qkTW28LEICFTZ8B3OD3hQtfz8xrn7T/
         J/zkxOOrVn05EfA3DSScssCal4uaOXHKC559mmurk5XRikQB3u+V/TFFQb5DcvLoqgtg
         q3Dn+TBZ+3rWaVk/CgS2moTrLj35KwTlV7H6xpxHzFHG8JgcRro1djS493tY4k9A73qO
         /leSfbIIyk/7OwxJbIUKK2US+4LUoE379KbsrQopjJFw+G8mwqqd2LoPH3rIJKr5jQR1
         xTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s0qfbDNJzKPba0DhXnUemGGVEXLf9/4C8NsMtd615sM=;
        b=EvB1XzVNqIzHCGQapdxGlBDfYaBD0MTIRIlw6zqaHZqt3HJCYbmCwwZ5mI5k1lbpF3
         nPtIejL8KczStHs80Yn8Wo//BHTOkYXx+2vV+77JPHYXoY8NzzH+J8EJvnTHSHZArUPL
         aHdAXVhSudsfWS6CBz4w9aHA4fLGsgMI0yyywvYS/jomHn19ahAShi4XiKKIr+P+uBxJ
         PTdm5D0faE686BgjBSE15OIbCXTIwjRtKa1VkmnM/JSGZ2SRMzVt1UgDyD+2du9wB9B5
         a6hByWydcC/O5MjPoDq9FAaZWwJajEoJLt4GMZnwA4XppSFoQXrmP9izpdgUZXgtEX+p
         WeJQ==
X-Gm-Message-State: AOAM532omobyoU2gz+IULHV2QmBFTYWG1828Idoqqs1XohP5J9OaL7Jj
        iRkMmyBLo1gCO20LUNhn0B/ZsraA113TIg==
X-Google-Smtp-Source: ABdhPJxODM4AMfMAR8MyMqMnECc4W2O1RzYZCge/y5M0rGpgtJA0z9t5Ye6wRrmObT8KwCd4BKrbcw==
X-Received: by 2002:a17:907:7210:: with SMTP id dr16mr5256193ejc.470.1643120099557;
        Tue, 25 Jan 2022 06:14:59 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-010-144-044.77.10.pool.telefonica.de. [77.10.144.44])
        by smtp.gmail.com with ESMTPSA id lu44sm6292929ejb.145.2022.01.25.06.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 06:14:59 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 7/9] selinux: do not discard const qualifier in cast
Date:   Tue, 25 Jan 2022 15:14:17 +0100
Message-Id: <20220125141422.32655-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125141422.32655-1-cgzones@googlemail.com>
References: <20220125141422.32655-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not discard the const qualifier on the cast from const void* to
__be32*; the addressed value is not modified.

Reported by clang [-Wcast-qual]

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/netnode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index 4a7d2ab5b960..889552db0d31 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -107,7 +107,7 @@ static struct sel_netnode *sel_netnode_find(const void *addr, u16 family)
 
 	switch (family) {
 	case PF_INET:
-		idx = sel_netnode_hashfn_ipv4(*(__be32 *)addr);
+		idx = sel_netnode_hashfn_ipv4(*(const __be32 *)addr);
 		break;
 	case PF_INET6:
 		idx = sel_netnode_hashfn_ipv6(addr);
@@ -121,7 +121,7 @@ static struct sel_netnode *sel_netnode_find(const void *addr, u16 family)
 		if (node->nsec.family == family)
 			switch (family) {
 			case PF_INET:
-				if (node->nsec.addr.ipv4 == *(__be32 *)addr)
+				if (node->nsec.addr.ipv4 == *(const __be32 *)addr)
 					return node;
 				break;
 			case PF_INET6:
-- 
2.34.1

