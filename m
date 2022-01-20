Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D074C49570E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 00:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348216AbiATXhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 18:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244889AbiATXhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 18:37:54 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28C3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 15:37:53 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id m4so35303616edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 15:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A37NAZU7Dg/jVCgTeXpx3o799yNXdvxbn6Y70BxIoe0=;
        b=gZZMXPdUh3oOG6X0PO9uts9sh3OUNE7s9qCz+w7jQq/hShSEQQYVp0nBU7kcjvxq5T
         GD8vnhstDPbmkGwgvAbMOS+VxvNhs5H1mVPQFgNd4XRg5fHRY8DbwvjDh1rXrnNK2GWp
         0tZ6fXYl6aezDP0KLtaJXJLSGCfyUGEB+eUhABS/rF0GqmzQSvQqukl5sUnsQuVnEKU0
         gei9rfXYLHa95B92ggOahyrhtlL9oLqPb9S3Y7PmehTmLW1kHNoFnz7E+vICXRMtolMz
         75GqArvaAQ5YQqRDDqPMh52s4T53nIw8lAv8kbbx9Ld8tCc1QF0h2dhiCJTd+IeZQaeC
         t3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A37NAZU7Dg/jVCgTeXpx3o799yNXdvxbn6Y70BxIoe0=;
        b=PXd2B3vdU6ju6WdbeHuvP+TgGCTAgSkfBm3R3B4qlYrlt6JkNxBRmy8fXuzQulIGNj
         qaKpUpkRBsIGNHFOa3cVlelDhsGlF8Fxr8tAHL+Ns+Bb4z3YRmibGV07Swq30M/a20st
         mv2EplrcGY9odlnd5sLK/d9MVAuvcGdobOF9+iU1t3dyTrRUBggh5l3ZEujTro+H4tNc
         BaRiZNTSJgUoSk/cyrA/TnRS26dsPYf3uKhFQ2ofmTUbJcm1gf4croJgjL/MR/FWeHQF
         /gJMPGjDdd3fIqKlr9Cc+Vvq3CoRPokcmCsb8/gBvjbmUaaOQUg5hESPwCfJDeBuqJ3u
         10lQ==
X-Gm-Message-State: AOAM531mMSHYPZj1c4DOv+BiywS3Vw4bkcImxVOTyi2ptciGNsBcQj57
        GkzxYfwT0nIrcrOAIox/IYVziBscT7A=
X-Google-Smtp-Source: ABdhPJy4b3PH3SKm0k6+DeEppued2mfDIhkyEaAmyUCZGAHp4Z9xN0iETINTwli5n23EneTUxzR9dA==
X-Received: by 2002:a05:6402:217:: with SMTP id t23mr1501594edv.283.1642721872103;
        Thu, 20 Jan 2022 15:37:52 -0800 (PST)
Received: from nz.home (host81-129-87-131.range81-129.btcentralplus.com. [81.129.87.131])
        by smtp.gmail.com with ESMTPSA id p23sm1825737edx.86.2022.01.20.15.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 15:37:50 -0800 (PST)
Received: by nz.home (Postfix, from userid 1000)
        id F16341B418A95; Thu, 20 Jan 2022 23:37:49 +0000 (GMT)
From:   Sergei Trofimovich <slyich@gmail.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Sergei Trofimovich <slyich@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2] objtool: check: give big enough buffer for pv_ops
Date:   Thu, 20 Jan 2022 23:37:48 +0000
Message-Id: <20220120233748.2062559-1-slyich@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220120230932.vgd3sj4yuk7mhmno@treble>
References: <20220120230932.vgd3sj4yuk7mhmno@treble>
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
Signed-off-by: Sergei Trofimovich <slyich@gmail.com>
---
Change since v1: added missing S-O-B.
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c2d2ab9a2861..f5bed94e4558 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2854,7 +2854,7 @@ static inline bool func_uaccess_safe(struct symbol *func)
 
 static inline const char *call_dest_name(struct instruction *insn)
 {
-	static char pvname[16];
+	static char pvname[32];
 	struct reloc *rel;
 	int idx;
 
-- 
2.34.1

