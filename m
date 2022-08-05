Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BFB58B179
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241614AbiHEVyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241528AbiHEVyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:54:22 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7B4101C1;
        Fri,  5 Aug 2022 14:54:19 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id j20so1975163ila.6;
        Fri, 05 Aug 2022 14:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=66tB9GURiJGDaXzm2IfI1R+C6P9N6jM87DtEYp8w9s8=;
        b=dgd+LLVPNiPJaSKBVWtT4Zbrhte0+5f0xGVwua9lB+amp0r06ne081BVPeuysGQfVy
         B29SsUeBngUq34NP88kyqho6gSyjz34xlIC/USckZDng+OQZv8goMxRKQA03ABRzcBd0
         aAZ+CBBWePvCN3kUwH4EYfOSISYXjUPP8ZXfH0oPGfcMexyLS6Vxz16Fch/fYRc43CcD
         h6G6O8nkZbmHpzetqnntDg5Zib/pD4u+1z3iJ8z6TOATqewv5E6xnluDu/IaExNjLqWm
         0D3Jd0LJlJOcVmbDYGtHyerwGVhcxoMT874pS287WwzN3ne6cWGax4fucNDz+Iei8SEj
         /sMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=66tB9GURiJGDaXzm2IfI1R+C6P9N6jM87DtEYp8w9s8=;
        b=nBuS3x1CMVUUpNgu2jJitG4zRfzAEBhWVesiPqusd5sRh9ibDB0nX2GI8YJb25DCdJ
         /tDAjcQ5TCKPSYy5Qb17wKjhLjNy8DMrVOB1DjjyWxpDS1sIj/rNfAogvhbDTBj8Gxbf
         6Sbfz4VDTQ5iPlgiRoDarlHzs/hSTn5HKkPySk779a+ALRSEG7TaVcor81lbNjHj/r+G
         PNAjHtRR3VAusijTAxcxluJUEmTDmh310/rxht4t37wYY/q3l5UJdWnBEXeKoImZrQBH
         +pa8ntMVU72liSYWD1eAQbqvDTE83nsMvTBsIbzhHAT/O4C73X+2ktqgcnZwJ90dsh2M
         Ct4A==
X-Gm-Message-State: ACgBeo1nh1KRKmtIUkvBw19TOBmFgl4vOTCVyWxS2nNpb5cUzXzZKolf
        b/zOatOIKHeT2l21C8rr+qGeIpne/d6bQg==
X-Google-Smtp-Source: AA6agR5KFUx/S28wJBHf8esIf0A1i4foONGppbKZtYzDKa5yseZsXVQGDnoxzq0dnljYp9wy7F7U6A==
X-Received: by 2002:a92:d606:0:b0:2dc:e2d1:b75b with SMTP id w6-20020a92d606000000b002dce2d1b75bmr4023671ilm.91.1659736458782;
        Fri, 05 Aug 2022 14:54:18 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b0067c09fd0b53sm1765532iov.21.2022.08.05.14.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 14:54:18 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 03/33] dyndbg: show both old and new in change-info
Date:   Fri,  5 Aug 2022 15:53:25 -0600
Message-Id: <20220805215355.3509287-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805215355.3509287-1-jim.cromie@gmail.com>
References: <20220805215355.3509287-1-jim.cromie@gmail.com>
MIME-Version: 1.0
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

print "old => new" flag values to the info("change") message.

no functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Acked-by: Jason Baron <jbaron@akamai.com>
---
 lib/dynamic_debug.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index a56c1286ffa4..8faf584f2f4b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -156,7 +156,7 @@ static int ddebug_change(const struct ddebug_query *query,
 	struct ddebug_table *dt;
 	unsigned int newflags;
 	unsigned int nfound = 0;
-	struct flagsbuf fbuf;
+	struct flagsbuf fbuf, nbuf;
 
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
@@ -217,11 +217,12 @@ static int ddebug_change(const struct ddebug_query *query,
 				static_branch_enable(&dp->key.dd_key_true);
 			}
 #endif
+			v4pr_info("changed %s:%d [%s]%s %s => %s\n",
+				  trim_prefix(dp->filename), dp->lineno,
+				  dt->mod_name, dp->function,
+				  ddebug_describe_flags(dp->flags, &fbuf),
+				  ddebug_describe_flags(newflags, &nbuf));
 			dp->flags = newflags;
-			v4pr_info("changed %s:%d [%s]%s =%s\n",
-				 trim_prefix(dp->filename), dp->lineno,
-				 dt->mod_name, dp->function,
-				 ddebug_describe_flags(dp->flags, &fbuf));
 		}
 	}
 	mutex_unlock(&ddebug_lock);
-- 
2.37.1

