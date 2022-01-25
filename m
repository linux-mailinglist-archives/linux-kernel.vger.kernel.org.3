Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEE649B5FA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578354AbiAYOSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578153AbiAYOPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:15:00 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067CCC06175A;
        Tue, 25 Jan 2022 06:15:00 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r10so32140653edt.1;
        Tue, 25 Jan 2022 06:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dSHVxcncpgTGJZyBI5FvlHJ6cEG9uXtzEUOqQoM02ug=;
        b=PxsjEzW+UVDQD5fk/HYoaJgllSqCsZiWEeBROCkyrFIeQxjgXAJRnMvVk9PNmjM4Qv
         u8P4/4oJP3HZKVd9KOHEDnc0s+2+gC7pDR9VsRBpMl9ACdbSeFpzg0OKW+V/fNqRkL6l
         FPvoQmdo5KDTNT9Qcv1/Bk1MsSgjseHFX3ER6jes4lamNZmuHxFlOrcSkygSWoIUSpFD
         ZLxssmqT6mqFm1k4lvlGsS+hMmqsCb2DOyAsH6o2jk9YP4TSpRqp6unvLX3uhXCAH3oR
         2KbiknUfeiQAOHbQ4oakh3U3DdaG74SkGYf83nmsfQC1xb46ltgxtXl6SqSJNStBb5Sp
         j/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dSHVxcncpgTGJZyBI5FvlHJ6cEG9uXtzEUOqQoM02ug=;
        b=cXK3qSn/W7jVnJQ7VHauS+GToAoWCkF/ILHA84KkzW/CtNeX4wLrpqcun2mORCuCn+
         ty5sMdByRHuneBfcLTUlMI9IM6ipgGpP+K9xQL65TQsh7UTrvAp/xd0KsRnqwjTpDy7Q
         qyCuaXWoqUuz5HbKC2o9l24Pj9ZIp1WPhLdMV3A/nDWjIIsaixjoFkdyUSHNKKFwif5m
         uE2zGJdgjVMH59WeZIGQo7dT2He0tcet6Hsp7jAwjMOK332sRwGYWI+qycu/ZqLj1o03
         t+BCiM1SkgWzZKy88QVjg4ecgU58pYrfRmXJmi7Igk3ZYgmuY7gAdngVUdDMrasB2F9b
         d6qg==
X-Gm-Message-State: AOAM533fPLayuRBz1NPJfZx+TTqJsgZCj4eaJ0QxchADsGBHgZrwrEw/
        j4vCAFAZ4/2iPAG875Pz2GI8qZqJN32Ejw==
X-Google-Smtp-Source: ABdhPJw3men/JcrtLRJpXMAI+7sycqVlmWUv4r7PVbiDGE4fcJ2pQpmSwQJ7/V0Y26cltczEp6Fy3Q==
X-Received: by 2002:a17:906:9501:: with SMTP id u1mr15654364ejx.511.1643120098486;
        Tue, 25 Jan 2022 06:14:58 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-010-144-044.77.10.pool.telefonica.de. [77.10.144.44])
        by smtp.gmail.com with ESMTPSA id lu44sm6292929ejb.145.2022.01.25.06.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 06:14:58 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 6/9] selinux: drop unused parameter of avtab_insert_node
Date:   Tue, 25 Jan 2022 15:14:16 +0100
Message-Id: <20220125141422.32655-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125141422.32655-1-cgzones@googlemail.com>
References: <20220125141422.32655-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameter cur is not used in avtab_insert_node().

Reported by clang [-Wunused-parameter]

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/avtab.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index c97695ae508f..cfdae20792e1 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -67,7 +67,7 @@ static inline int avtab_hash(const struct avtab_key *keyp, u32 mask)
 
 static struct avtab_node*
 avtab_insert_node(struct avtab *h, int hvalue,
-		  struct avtab_node *prev, struct avtab_node *cur,
+		  struct avtab_node *prev,
 		  const struct avtab_key *key, const struct avtab_datum *datum)
 {
 	struct avtab_node *newnode;
@@ -137,7 +137,7 @@ static int avtab_insert(struct avtab *h, const struct avtab_key *key,
 			break;
 	}
 
-	newnode = avtab_insert_node(h, hvalue, prev, cur, key, datum);
+	newnode = avtab_insert_node(h, hvalue, prev, key, datum);
 	if (!newnode)
 		return -ENOMEM;
 
@@ -177,7 +177,7 @@ struct avtab_node *avtab_insert_nonunique(struct avtab *h,
 		    key->target_class < cur->key.target_class)
 			break;
 	}
-	return avtab_insert_node(h, hvalue, prev, cur, key, datum);
+	return avtab_insert_node(h, hvalue, prev, key, datum);
 }
 
 struct avtab_datum *avtab_search(struct avtab *h, const struct avtab_key *key)
-- 
2.34.1

