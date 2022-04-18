Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFE3505F2C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 23:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348004AbiDRVTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 17:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347990AbiDRVS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 17:18:57 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D9D2D1C2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 14:16:12 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id bg24so14033902pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 14:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qm/BmS5rZykflggAWLelmGp8fWeLhZCgEzC+nt/A6s4=;
        b=jOGlGDc4Wz6w//dtoJeqZYjBwmgJ9X0uBmiWSlHHhhny2QoTzwVyv3a/QnVezngt8l
         3ttINehXise0pulBtGu+lsTlr5/YM61z/YnIc3bJtEjb2TyAH4JhublL+rlgv5TvhhtK
         wp3ot4iekb0EvbU7nv54WtdXLzyXLG7sI6Sbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qm/BmS5rZykflggAWLelmGp8fWeLhZCgEzC+nt/A6s4=;
        b=4p8aaoLNjAFgxOZC48mdBnYEih+B3xyON87De0uJr44uxvRMgLmB+tYg5eSZfhC2KM
         uI4o3ZvgK4YfkubDxjgLlXDg6qEV0DPKDybu3Ilec8yaHDht4QgYoWFsdkmA10/Omxrt
         ka3OSaCejdpfL7RT/sTPszfmp92UrCxspFyO50dhERpB3Dp5dhYc1OtVxBO4+8sflOU3
         umY8CAZaFOccXN9gYWe3KNVBEWdOe+JvF3MsP1C/Hq3iDaOvOmBbq0hcnGR6VwBG+6eP
         h2jnat3lnDHAWyGZsC0xrSOyHnNbplKgzWBpPcxNncFcOZBhhUz8dmZxa5G8Aud6G5BX
         Nzxw==
X-Gm-Message-State: AOAM532YTUxHyR43+XgOA4LgLWA7RTsLSQlIilqwQ8rAXmU61qXEyXHK
        bX1WgTAREMSZ0l6lkCXSaktanA==
X-Google-Smtp-Source: ABdhPJwvT6hPqXjTca3Xc2+bb0JBOY7ovGiOak9BOvmgcSEBCUg/Tyd1ChxcMzkWocvs0mSZVqmGYw==
X-Received: by 2002:a17:90b:4b01:b0:1d2:abf5:c83f with SMTP id lx1-20020a17090b4b0100b001d2abf5c83fmr4999347pjb.93.1650316571711;
        Mon, 18 Apr 2022 14:16:11 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6b32:a0a5:ec32:c287])
        by smtp.gmail.com with UTF8SMTPSA id d16-20020a17090a02d000b001cba39c88fcsm1487068pjd.0.2022.04.18.14.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 14:16:11 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        Song Liu <song@kernel.org>,
        linux-security-module@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>, dm-devel@redhat.com,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 3/3] dm: verity-loadpin: Use CONFIG_SECURITY_LOADPIN_VERITY for conditional compilation
Date:   Mon, 18 Apr 2022 14:15:59 -0700
Message-Id: <20220418141545.3.I5aca2dcc3b06de4bf53696cd21329dce8272b8aa@changeid>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220418211559.3832724-1-mka@chromium.org>
References: <20220418211559.3832724-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
---

 drivers/md/Makefile               | 7 +------
 include/linux/dm-verity-loadpin.h | 2 +-
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index e12cd004d375..a96441752ec7 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_DM_LOG_WRITES)	+= dm-log-writes.o
 obj-$(CONFIG_DM_INTEGRITY)	+= dm-integrity.o
 obj-$(CONFIG_DM_ZONED)		+= dm-zoned.o
 obj-$(CONFIG_DM_WRITECACHE)	+= dm-writecache.o
+obj-$(CONFIG_SECURITY_LOADPIN_VERITY)	+= dm-verity-loadpin.o
 
 ifeq ($(CONFIG_DM_INIT),y)
 dm-mod-objs			+= dm-init.o
@@ -100,12 +101,6 @@ ifeq ($(CONFIG_IMA),y)
 dm-mod-objs			+= dm-ima.o
 endif
 
-ifeq ($(CONFIG_DM_VERITY),y)
-ifeq ($(CONFIG_SECURITY_LOADPIN),y)
-dm-mod-objs			+= dm-verity-loadpin.o
-endif
-endif
-
 ifeq ($(CONFIG_DM_VERITY_FEC),y)
 dm-verity-objs			+= dm-verity-fec.o
 endif
diff --git a/include/linux/dm-verity-loadpin.h b/include/linux/dm-verity-loadpin.h
index 12a86911d05a..be63ac76f98d 100644
--- a/include/linux/dm-verity-loadpin.h
+++ b/include/linux/dm-verity-loadpin.h
@@ -13,7 +13,7 @@ struct trusted_root_digest {
 	struct list_head node;
 };
 
-#if IS_ENABLED(CONFIG_SECURITY_LOADPIN) && IS_BUILTIN(CONFIG_DM_VERITY)
+#if IS_ENABLED(CONFIG_SECURITY_LOADPIN_VERITY)
 void dm_verity_loadpin_set_trusted_root_digests(struct list_head *digests);
 bool dm_verity_loadpin_is_md_trusted(struct mapped_device *md);
 #else
-- 
2.36.0.rc0.470.gd361397f0d-goog

