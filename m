Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BFB476196
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344219AbhLOTVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344205AbhLOTVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:21:42 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519C0C06173E;
        Wed, 15 Dec 2021 11:21:42 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id g14so77562253edb.8;
        Wed, 15 Dec 2021 11:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=207KaoW2Trkie6tyY+9Hew758Xu7i3oKxvhUBwe6PzU=;
        b=GwZGl02Uyxnz2NT+8NyLB4LJEuvgBQTxcsmvIcjjS+OmClMuuUc3Set7rw6rpnIeit
         DWLFLK7z5WVsGNasIoFltaQ6sw8XiilsI54Z/yNpwq1gR0GbqKZ+82XkWKd4nYJf2JOM
         yEcNGvm4Zf1cB+Qfv0RHJN2n+q5O0VoUA64lXFKoblVHti8hYUyl24CiXSVL98Cn9dcg
         auAKwblIZcBrjIb+cReSHDokfy8XhCJ3rbZ69LDfzNtULQMzkTs+WIIggaq0iFfzLuws
         Qq+jjoW5IGIuTlfFdzzu8KJ5LtXzBRDVe5PT+qvwIqLsNm6HINXdtVjhefrgSyVa7tLy
         JZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=207KaoW2Trkie6tyY+9Hew758Xu7i3oKxvhUBwe6PzU=;
        b=XlTK8kFVAE+brpsZ6nMjZudNhxBdUMlZaKTyFyztSK8T55rqPPTMtwa788WLcugUZG
         9H2pA/Af2ki//t7xCkazTKfugI5tsNNeHUE7EgzbvytYrnSUX2BdpbKVSJy2KX9hP6SA
         3MgPL4I4EG9qPY+/4bdbL8mU/b+gpcFlDXbIBFgULBE5e0WqcVQeZL3oAuyq0PBo23Fk
         hZXdvmN0CYMPOvKqBv2wCBmJPN0O0+He0Lu09ZiUI+NsEKN2c2W1GdMZLbuyJD/9vpe6
         3M6z3qXh+hTijkEXMJeIbsUqUGGhudZTW7XOtgXu2HpSTJOy0DVfLJFenGn9Ces5fcNo
         el8A==
X-Gm-Message-State: AOAM533pCN2UdPpjUN6nc5bjK5UOEyhXqrJYxd7HpgDM6CKUa9xcEi2n
        3ijUsAVuKkrH+Uv9cU2rz39STGHanoFk344yn4M=
X-Google-Smtp-Source: ABdhPJwHj487Tk04EVsrSmJgLW/tQld79w5yYgBJarBHVLl96INq5Ysehmm6qNall1kmsyfShwaUWA==
X-Received: by 2002:a17:906:4781:: with SMTP id cw1mr3691101ejc.116.1639596100951;
        Wed, 15 Dec 2021 11:21:40 -0800 (PST)
Received: from zenorus.myxoz.lan (81-232-177-112-no2390.tbcn.telia.com. [81.232.177.112])
        by smtp.gmail.com with ESMTPSA id n10sm1461049edx.3.2021.12.15.11.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 11:21:40 -0800 (PST)
From:   Miko Larsson <mikoxyzzz@gmail.com>
To:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Miko Larsson <mikoxyzzz@gmail.com>
Subject: [PATCH 2/2] zram: zram_drv: replace strlcpy with strscpy
Date:   Wed, 15 Dec 2021 20:21:28 +0100
Message-Id: <20211215192128.108967-3-mikoxyzzz@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211215192128.108967-1-mikoxyzzz@gmail.com>
References: <20211215192128.108967-1-mikoxyzzz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy shouldn't be used; strscpy should be used instead.

Signed-off-by: Miko Larsson <mikoxyzzz@gmail.com>
---
 drivers/block/zram/zram_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 464ef53adcbc..b1774d04a6ea 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -500,7 +500,7 @@ static ssize_t backing_dev_store(struct device *dev,
 		goto out;
 	}
 
-	strlcpy(file_name, buf, PATH_MAX);
+	strscpy(file_name, buf, PATH_MAX);
 	/* ignore trailing newline */
 	sz = strlen(file_name);
 	if (sz > 0 && file_name[sz - 1] == '\n')
@@ -1034,7 +1034,7 @@ static ssize_t comp_algorithm_store(struct device *dev,
 	char compressor[ARRAY_SIZE(zram->compressor)];
 	size_t sz;
 
-	strlcpy(compressor, buf, sizeof(compressor));
+	strscpy(compressor, buf, sizeof(compressor));
 	/* ignore trailing newline */
 	sz = strlen(compressor);
 	if (sz > 0 && compressor[sz - 1] == '\n')
@@ -1988,7 +1988,7 @@ static int zram_add(void)
 	if (ret)
 		goto out_cleanup_disk;
 
-	strlcpy(zram->compressor, default_compressor, sizeof(zram->compressor));
+	strscpy(zram->compressor, default_compressor, sizeof(zram->compressor));
 
 	zram_debugfs_register(zram);
 	pr_info("Added device: %s\n", zram->disk->disk_name);
-- 
2.34.1

