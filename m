Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EC958B17C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241566AbiHEVyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241489AbiHEVyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:54:24 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC49DF9;
        Fri,  5 Aug 2022 14:54:23 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id o14so1990037ilt.2;
        Fri, 05 Aug 2022 14:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=uAM2bHt8Z4xuRTvJFeLRexags7bboegRrLg3WgQNpl4=;
        b=GttURaGyNyjlXmWKacrpk22jV/0PvPsnt5RSXlSpOmWKIOS1FVVSqslXr8i7diNjqQ
         B8bkPGOWHdOKP350Spcfvc2YAsmiq/DcD5C1wo0gN9gkyB/bIob/YY66WXpxdtoM3lUZ
         adw/rX4gz+YhYkxP4A+dvAgGqGer5xJc0fzlLSxAvmp99IRcl8QU2Tw2cTyWIMWa3mbk
         +WLxYSAXcQKdm2uaaGJq1a4Ooltfmbb2XptYWsKw4nHWkF5LzoQn2PdHKR0NRyGelXun
         xlOcEXK3Sj29apYYZlO8KM9a8Mtb/H4JV9NYpZbd8JqlUhRtKjxvE8x7Bg+2g4wCPp3q
         fBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=uAM2bHt8Z4xuRTvJFeLRexags7bboegRrLg3WgQNpl4=;
        b=CfTKgs9VHbZjqNZl7GMEUvvUhLJ6irDS3uFSv20yg6M1zNA/EsmvJVOBPL1487pfO4
         w5eeMvL6px5j3StqgkVEd5PUcv2pMklk+WywU+AEhQKP5/OMDljvH1gEvqO/I/L0JJvj
         b3tNmjWYk+pMFd+csdnQ1ZS8YYWm0C1IzXWxeAfyLLSxH4+UVV4MenMe2k/8G7Damrlu
         Lht4H/x4DNLtwr0fmbyyU5wa2IQkGAogtYyXH3hXBy0/EPI4B9mxcYBIb4zquqmhR6Gi
         eeVvOrHMQ9MFjtBbENxBw+HVq2zI5QDHgw5O1O7i21//KQrMVHQMbUlMuj0uetOTetiv
         H9tw==
X-Gm-Message-State: ACgBeo3hNQCi63aVVXmxQD9Y8bQWH4SE7ML1iLcBS0M9FQNDhjCM0a5D
        7m+wG5pyJdvUIcdTBtmmBmRha5Gwwn8DkQ==
X-Google-Smtp-Source: AA6agR7/BqFC2YyWdpPet7vO1o3I+g5zfP53AO5Z/UYQa5Q4GCzcWqQvhq1jsWqDvHh+aYBwIiWqsw==
X-Received: by 2002:a05:6e02:194d:b0:2de:a54b:2e51 with SMTP id x13-20020a056e02194d00b002dea54b2e51mr3914987ilu.257.1659736463061;
        Fri, 05 Aug 2022 14:54:23 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b0067c09fd0b53sm1765532iov.21.2022.08.05.14.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 14:54:22 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 04/33] dyndbg: reverse module walk in cat control
Date:   Fri,  5 Aug 2022 15:53:26 -0600
Message-Id: <20220805215355.3509287-5-jim.cromie@gmail.com>
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

/proc/dynamic_debug/control walks the prdbg catalog in "reverse",
fix this by adding new ddebug_tables to tail of list.

This puts init/main.c entries 1st, which looks more than coincidental.

no functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Acked-by: Jason Baron <jbaron@akamai.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8faf584f2f4b..7fb99492c16f 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -970,7 +970,7 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 	dt->ddebugs = tab;
 
 	mutex_lock(&ddebug_lock);
-	list_add(&dt->link, &ddebug_tables);
+	list_add_tail(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
 	vpr_info("%3u debug prints in module %s\n", n, dt->mod_name);
-- 
2.37.1

