Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F99952C8EB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 02:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbiESAsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 20:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbiESAsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 20:48:02 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E003ED11
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 17:48:02 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id p8so3680954pfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 17:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B6MA4+HMYbPobnbYL1B2L1IK014KXRJf7a7TG+xfkZ8=;
        b=Z5bDlAZoAJZzaN0On3Z6T7UXu6nBH07V6MPFeCvzeYdB7AGHqgryugiokuZYFZ8ZGy
         EpudKlTFAPEab5DxDvnEy1lIzUNPCHMkCFsBv5BMABvUw1FexfGOxVs1Zdnha01KAYjb
         V0cqc2H2myg58EeZp9uWNZMXVwVLoxwwTgin8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B6MA4+HMYbPobnbYL1B2L1IK014KXRJf7a7TG+xfkZ8=;
        b=lVpyYhsLu+G20QmhG7CySQl38y8GHwk8BZs0GBgp0dJPdorH4I4Lg5qwbrw/aKj/Hs
         qYZV7olcQHQ1oxiTHnVdvIRQvvhG1bUFOomF4QVBKWSxVBYgLrmUQyycDeW05AeScGJL
         VV2VJN+IuNbk2uKksOAwS+fSULjyUjSR1KWhPJnjdXBUH15hsjgYv4YgDGvL2RY0N6Km
         ObbbcAuqncJo7oRmL4oQVrab19lFjpYGXKczxFaZFqDRSyD9txEWhdK2rjrcFuxmQ0Ne
         uoSp58qHphShdkm1D6wDHEXagEXPCT4s76X4DFJqNWA3wXMWlibRoLQEHmp4UXCZLHSR
         4M7A==
X-Gm-Message-State: AOAM531d3r0xofp38lvJ7IVPWBjNgZ8F8F2NWKHxUIFH7bJTWKZ+7Hdj
        FwtcgptF5GLkCYszSjxz70YDMg==
X-Google-Smtp-Source: ABdhPJyMv1v72T0i8iVgL2HihKH/xs6LPltgtmNa5ruAuiR2wEA/c9aCEr6jXvMkXU6kAJcVSw0lsw==
X-Received: by 2002:a65:550c:0:b0:3da:fde8:62d7 with SMTP id f12-20020a65550c000000b003dafde862d7mr1783122pgr.334.1652921281818;
        Wed, 18 May 2022 17:48:01 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:e229:79ea:227e:d9dd])
        by smtp.gmail.com with UTF8SMTPSA id e11-20020a17090a9a8b00b001df4c27e5a5sm4154913pjp.35.2022.05.18.17.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 17:48:01 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     Song Liu <song@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-raid@vger.kernel.org,
        dm-devel@redhat.com, Milan Broz <gmazyland@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v5 3/3] dm: verity-loadpin: Use CONFIG_SECURITY_LOADPIN_VERITY for conditional compilation
Date:   Wed, 18 May 2022 17:47:54 -0700
Message-Id: <20220518174739.v5.3.I5aca2dcc3b06de4bf53696cd21329dce8272b8aa@changeid>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220519004754.2174254-1-mka@chromium.org>
References: <20220519004754.2174254-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index d37146dbb1a8..ac5d9f56c3a3 100644
--- a/include/linux/dm-verity-loadpin.h
+++ b/include/linux/dm-verity-loadpin.h
@@ -15,7 +15,7 @@ struct trusted_root_digest {
 	u8 data[];
 };
 
-#if IS_ENABLED(CONFIG_SECURITY_LOADPIN) && IS_BUILTIN(CONFIG_DM_VERITY)
+#if IS_ENABLED(CONFIG_SECURITY_LOADPIN_VERITY)
 bool dm_verity_loadpin_is_bdev_trusted(struct block_device *bdev);
 #else
 static inline bool dm_verity_loadpin_is_bdev_trusted(struct block_device *bdev)
-- 
2.36.1.124.g0e6072fb45-goog

