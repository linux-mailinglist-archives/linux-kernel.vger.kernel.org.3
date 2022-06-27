Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8290355C6C6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238569AbiF0Pfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238567AbiF0Pfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:35:40 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CB31A829
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:35:37 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id c205so9358842pfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0M1pQcOKied9vqnWW/vxW+YZhV9nZDUGj0eSUFDJbwg=;
        b=Cv61qlgrIl9Hv9WvUrykcJQWqfl6bT/dGI9EfXEXeQMObQcjF8qFPkJ4lxEIMKZQM+
         Tdw34lCxt44f5k2/Z7ulr6Lvy6lknHiv+9DdCmdMfimmwemlRrIpnNtY3WNnOhzWLM56
         9ocMgnjpRORfrpUiHF2ZQh+9fKbVOvnIBjg5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0M1pQcOKied9vqnWW/vxW+YZhV9nZDUGj0eSUFDJbwg=;
        b=PW/eOQutXafJEKh4pgDL5QFWG9AhoLDMdZ98nPsl6/iuyYuT8TJiuhzNi8iiOgqHxd
         i/INqI+xAxZLWUFs0ke2kK3lAF7gjA/oPyExYF6TvhDrxYyphOGBlU/KlxtKai3Lc/1b
         2UItXjNxlhqdeaozo3ZYxm7K3aza3p1hjq+S6KGlvsCxhlhpuzE09tO+sg8i8Q5MAgtW
         ycVxRnlVU7WMQ8K6ywzhYZ2i2+Ws9ckoZvUcHkJlxn1J11N0U7OZOwFsuBVzmlBs8kAJ
         LtxgAdAxqKuLgfoHKyRs4mZj1Lb1P+f+Z8uZ0IBY4GVmLIvdqWGFMmdYXeiG+WO/yiwY
         iyrA==
X-Gm-Message-State: AJIora9u4O+q3nhEkQ2o04LOTTyXXkAlyXGuTJbdbtUXKJlx9RSXrTTH
        nERURTx2jPuBPPTPWF4690t77g==
X-Google-Smtp-Source: AGRyM1tmA32fcPl+dNPL9uVWTM9M7VWXEcrf6Blr3EM8NH842MbiJviT40bZbAwSKyWKFIITMupuYg==
X-Received: by 2002:a63:8f56:0:b0:40c:9877:9f51 with SMTP id r22-20020a638f56000000b0040c98779f51mr13147028pgn.206.1656344137416;
        Mon, 27 Jun 2022 08:35:37 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:f31c:687c:3a61:62c5])
        by smtp.gmail.com with UTF8SMTPSA id cd21-20020a056a00421500b0051b32c2a5a7sm7434309pfb.138.2022.06.27.08.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 08:35:37 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>, Milan Broz <gmazyland@gmail.com>,
        dm-devel@redhat.com, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v7 3/3] dm: verity-loadpin: Use CONFIG_SECURITY_LOADPIN_VERITY for conditional compilation
Date:   Mon, 27 Jun 2022 08:35:26 -0700
Message-Id: <20220627083512.v7.3.I5aca2dcc3b06de4bf53696cd21329dce8272b8aa@changeid>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220627153526.3750341-1-mka@chromium.org>
References: <20220627153526.3750341-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The verity glue for LoadPin is only needed when CONFIG_SECURITY_LOADPIN_VERITY
is set, use this option for conditional compilation instead of the combo of
CONFIG_DM_VERITY and CONFIG_SECURITY_LOADPIN.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: Kees Cook <keescook@chromium.org>
---

Changes in v7:
- none

Changes in v6:
- none

Changes in v5:
- added 'Acked-by' tag from Kees

Changes in v4:
- none

Changes in v3:
- none

Changes in v2:
- none

 drivers/md/Makefile               | 7 +------
 include/linux/dm-verity-loadpin.h | 2 +-
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index 71771901c823..a96441752ec7 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_DM_LOG_WRITES)	+= dm-log-writes.o
 obj-$(CONFIG_DM_INTEGRITY)	+= dm-integrity.o
 obj-$(CONFIG_DM_ZONED)		+= dm-zoned.o
 obj-$(CONFIG_DM_WRITECACHE)	+= dm-writecache.o
+obj-$(CONFIG_SECURITY_LOADPIN_VERITY)	+= dm-verity-loadpin.o
 
 ifeq ($(CONFIG_DM_INIT),y)
 dm-mod-objs			+= dm-init.o
@@ -108,12 +109,6 @@ ifeq ($(CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG),y)
 dm-verity-objs			+= dm-verity-verify-sig.o
 endif
 
-ifeq ($(CONFIG_DM_VERITY),y)
-ifeq ($(CONFIG_SECURITY_LOADPIN),y)
-dm-verity-objs			+= dm-verity-loadpin.o
-endif
-endif
-
 ifeq ($(CONFIG_DM_AUDIT),y)
 dm-mod-objs			+= dm-audit.o
 endif
diff --git a/include/linux/dm-verity-loadpin.h b/include/linux/dm-verity-loadpin.h
index fb695ecaa5d5..552b817ab102 100644
--- a/include/linux/dm-verity-loadpin.h
+++ b/include/linux/dm-verity-loadpin.h
@@ -15,7 +15,7 @@ struct dm_verity_loadpin_trusted_root_digest {
 	u8 data[];
 };
 
-#if IS_ENABLED(CONFIG_SECURITY_LOADPIN) && IS_BUILTIN(CONFIG_DM_VERITY)
+#if IS_ENABLED(CONFIG_SECURITY_LOADPIN_VERITY)
 bool dm_verity_loadpin_is_bdev_trusted(struct block_device *bdev);
 #else
 static inline bool dm_verity_loadpin_is_bdev_trusted(struct block_device *bdev)
-- 
2.37.0.rc0.161.g10f37bed90-goog

