Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6353C48E517
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 08:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbiANH6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 02:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiANH6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 02:58:12 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA5BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 23:58:12 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id e9so14220956wra.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 23:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qQYjsQBGNm39+m2dg7I01Yy9Chp8U4KppaS99DbhPP8=;
        b=qIF7NumT6wIJyuqSTkndqu8vxCmN24tBqFBtZ4wPwMPkVE69PHgrfzgtCQUw5bshPx
         pMVV+t8w9BWVAIRIHBAqnb0SETIWFCYVMuekeGaC0cnTz3lf6LCgiJGWkI92KeBvBH3/
         9Zn/CPNgeaI3BzCfgAL17Pn9lAnXzX/F0b7NzVm6cGMGgGtvr2fAKckgnNyIilawCsvD
         BF4CdLwgIJwwkIneN8WpVwIACMSLPBXW8jiRb2XVmr5l4JDj1mnRP2tUhDhHIQ1unBca
         vHC/+hjJcAr4r39EB+oxaiprnleY27R80e2QFWHu4t5LXze2XDXMkwgLcp0+lZZaBMWh
         t9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qQYjsQBGNm39+m2dg7I01Yy9Chp8U4KppaS99DbhPP8=;
        b=CGX4Il7nV09SbvJCQh+uA7CbLMatuAQjT0gCHwgaYFV9dizpvewhnZ0SpEnjiRQBML
         AAkj1Mn1ItUYsEHDiqZYZ1YDGyynoo2bg1W0YF7Fa3z8H1CqpxIss9/KCizqj5E42Uwp
         mL6BX7ud8n0yC5TNnkrmS6FBISYc6zgr8k88KhWcdECiFC+EAaKnXoP3+x3h0ouSI1dr
         FPWuQsdXOxKl51g3tSLBOQ1Iz1VjIpZlt9SE/zmGFaFAFKAK48zZsHwfIt6RkCIrUt94
         +n0G5POaj0uVrm6tFlzjSfOAtgpcb7x6n6vbZ5tHYZalgRxtYtq/l95EIKHlFIek18eG
         aokg==
X-Gm-Message-State: AOAM531MALDgh1Y3GhTq1IeEMYjMuIxy6ulMq6AcZovTa0X+zdasnb4W
        EB2brhYqyyZsRA45vL1JJxE6aQD8iO4=
X-Google-Smtp-Source: ABdhPJxaAGWnJ+sjNOjsTnVJSiWbTg77K7MrJqJmVjBJj8UUVESt6Gakeb9jWYftaAF9t28SX0ay/A==
X-Received: by 2002:a05:6000:1543:: with SMTP id 3mr2943527wry.98.1642147090941;
        Thu, 13 Jan 2022 23:58:10 -0800 (PST)
Received: from nz.home (host81-129-83-154.range81-129.btcentralplus.com. [81.129.83.154])
        by smtp.gmail.com with ESMTPSA id k31sm3581154wms.15.2022.01.13.23.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 23:58:10 -0800 (PST)
Received: by nz.home (Postfix, from userid 1000)
        id 4FE9919DC1560; Fri, 14 Jan 2022 07:58:09 +0000 (GMT)
From:   Sergei Trofimovich <slyich@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Sergei Trofimovich <slyich@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] objtool: check: give big enough buffer for pv_ops
Date:   Fri, 14 Jan 2022 07:57:56 +0000
Message-Id: <20220114075756.838243-1-slyich@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gcc-12 build fails flagging possible buffer overflow:

    check.c: In function 'validate_call':
    check.c:2865:58: error: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 9 [-Werror=format-truncation=]
     2865 |                 snprintf(pvname, sizeof(pvname), "pv_ops[%d]", idx);
          |                                                          ^~

I think it's a valid warning:

    static char pvname[16];
    int idx;
    ...
    idx = (rel->addend / sizeof(void *));
    snprintf(pvname, sizeof(pvname), "pv_ops[%d]", idx);

we have only 7 chars for %d while it could take up to 9.

CC: Josh Poimboeuf <jpoimboe@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8c1931eab5f1..0fae132ea59f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2852,7 +2852,7 @@ static inline bool func_uaccess_safe(struct symbol *func)
 
 static inline const char *call_dest_name(struct instruction *insn)
 {
-	static char pvname[16];
+	static char pvname[32];
 	struct reloc *rel;
 	int idx;
 
-- 
2.34.1

