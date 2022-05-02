Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089A551713A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 16:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385568AbiEBOJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 10:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385647AbiEBOJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 10:09:21 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247A611C0F;
        Mon,  2 May 2022 07:05:51 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id t5so6097343edw.11;
        Mon, 02 May 2022 07:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pPLLrK87W5L0xDS+IAmgyi2hotQv2CviI90UwehzET8=;
        b=hmwoWd+7A0ykHs4a7yIByjDsaD/555iYWv+o5vIkKMRNFHBgkVh08WtoVS0qZy5qg1
         aursqahrAnvKBXwaEm7qNxfzmpO6HTMQo9GBKFBPmEtgDCw78/7MqlLwChTtfIyYmmgF
         EanfTT6fkKHKzycCLw6k5nAC2vT9HY51Hmbq25Ec4o3thDyf1lpQDIoi6nhVD1SPZM1k
         p/TRfT5KJQ52fRbDo0oKgiWgKdf6+QUFu8820KL5vh4vPpR7QWHijDRPmZKymg0NoZ4I
         e5QexQWmWNwKU0eBDUHnoMT6XFhtD/w0cUbamJxfsjXjNeNOuLW9XFkEjAH3ICfO7WmF
         XiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pPLLrK87W5L0xDS+IAmgyi2hotQv2CviI90UwehzET8=;
        b=bpyxXgv6qk9PJMwZMTvNxhtgD846rziHusczV8JOckgS+42iV6c28O2R7jNr1oZVTV
         ZcXD61ThMwTaJzEJvO6WvTrxW8DYO2gWeEXMEcVW5Gjr53ygC82b7BrNwdMiqHgbAZmo
         Dw92eMFPuKiWmwkjHF3BeXD4l4xTZXd3yAgBh8sDXd23cs+frmtEyZWuEIflinJhNrJO
         0bV096Xry+ONT1nSmPcQmX6EGNdqsonLa96FS3jFVs+E/lKNatELDriHLrvFTbsb2gVQ
         2IiAVZgVvFpiHjWHHnW1Yuahjbo458SP3W6WXaYL+c9pFvu4t4dBOl9ZNOCNdRibVxd9
         pO8g==
X-Gm-Message-State: AOAM532Y/OyBwhJfFzkJwAkW3vTboO7FQxZ+6FNcctnrMAc/pBSSZV/6
        Ll8n8RvH9ZK8sOQHZPxfgQnHKwcO+nI=
X-Google-Smtp-Source: ABdhPJz6MwjmAyI5sDX00wnuRU4QLpTrLSXCZiWltNObVS9OTx1QifsXZ0NGMiXZyfadV36KrOFXWw==
X-Received: by 2002:a50:e78d:0:b0:41d:c8ec:81b0 with SMTP id b13-20020a50e78d000000b0041dc8ec81b0mr13340760edn.56.1651500349642;
        Mon, 02 May 2022 07:05:49 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-135-067.77.1.pool.telefonica.de. [77.1.135.67])
        by smtp.gmail.com with ESMTPSA id jx28-20020a170907761c00b006f3ef214e29sm3682355ejc.143.2022.05.02.07.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 07:05:49 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Michal Orzel <michalorzel.eng@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Austin Kim <austin.kim@lge.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: fix indentation level of mls_ops block
Date:   Mon,  2 May 2022 16:05:46 +0200
Message-Id: <20220502140547.32685-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one level of indentation to the code block of the label mls_ops in
constraint_expr_eval(), to adjust the trailing break; to the parent
case: branch.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/services.c | 42 +++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 802a80648c6c..e62e04b1ec6c 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -358,27 +358,27 @@ static int constraint_expr_eval(struct policydb *policydb,
 				l2 = &(tcontext->range.level[1]);
 				goto mls_ops;
 mls_ops:
-			switch (e->op) {
-			case CEXPR_EQ:
-				s[++sp] = mls_level_eq(l1, l2);
-				continue;
-			case CEXPR_NEQ:
-				s[++sp] = !mls_level_eq(l1, l2);
-				continue;
-			case CEXPR_DOM:
-				s[++sp] = mls_level_dom(l1, l2);
-				continue;
-			case CEXPR_DOMBY:
-				s[++sp] = mls_level_dom(l2, l1);
-				continue;
-			case CEXPR_INCOMP:
-				s[++sp] = mls_level_incomp(l2, l1);
-				continue;
-			default:
-				BUG();
-				return 0;
-			}
-			break;
+				switch (e->op) {
+				case CEXPR_EQ:
+					s[++sp] = mls_level_eq(l1, l2);
+					continue;
+				case CEXPR_NEQ:
+					s[++sp] = !mls_level_eq(l1, l2);
+					continue;
+				case CEXPR_DOM:
+					s[++sp] = mls_level_dom(l1, l2);
+					continue;
+				case CEXPR_DOMBY:
+					s[++sp] = mls_level_dom(l2, l1);
+					continue;
+				case CEXPR_INCOMP:
+					s[++sp] = mls_level_incomp(l2, l1);
+					continue;
+				default:
+					BUG();
+					return 0;
+				}
+				break;
 			default:
 				BUG();
 				return 0;
-- 
2.36.0

