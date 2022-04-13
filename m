Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1EE4FF061
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 09:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbiDMHOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 03:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiDMHOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:14:04 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573933464C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:11:43 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k22so1246009wrd.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Si/3MbWwfZmH4gHSlx8bfIyFjYYqoAHuCjt8KTbCgdQ=;
        b=ar4zDSwNZL+cCtEeGILU8VaPb61RRvMB9bbOIsYFHT/D8VLlJprUmgOuYrrZEnNscX
         66dJRXcz+4lDTfZJHsqb1063QlSKml+kxC+Bb4ApA6G4xwRCC0ndS2tge9u1SOa4dJH6
         EXZSR8Y/CBns7GZTHCpZgy3kaDXBNspbUl+761CF37VnRbY/u7UnRI1D1NWz9IoqSytS
         cAxhU+TW2v20c1RTqgtfU3ovqAP5ZzJxUQX7nZVW3e7+J3VhFOCRrFx6ML/Cws/2wP69
         pB7ztA1oeeef/ZfLTkAzUrMsLzwQhPyMmgZo4UOf7XbrTwWFRqdxC+osJxd5aMcfU8u9
         i8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Si/3MbWwfZmH4gHSlx8bfIyFjYYqoAHuCjt8KTbCgdQ=;
        b=rqwIfAZzf6yftThBZdl+cuT7RfxFdnbQ8oSoIS/QP/oKGiVn9L3t9+01IJzY25QClJ
         zeVK01h+KTuToaGu7h9mHbllpSi3s8TzbcBY3ZLWzJ7GnBpDGXSUXBE6dfjAM+F0TLW8
         9r44oQ9e65EB90So7PdryxL2cEL7yISKntOpJolvixhZTGQn0JVuiXyBFmlnftzQv6t9
         G3xuxB/PCgCi67raRA0rk+Ay3wBykp8vNzGwlfBjNJzr9mfRx9ae2BDlcQcQ/bwdOmeJ
         YimgTFN0aUfaFGZVghHj9nMbQ1b+GvOVobIO/qJFUBdp3RfhNq0jOaIHQcs8e6c+zTRN
         utUA==
X-Gm-Message-State: AOAM530I72DiSjHOgXM/iDXYFAg7m16oGGDH8A8pLkciwlV5VajOvXoR
        x3beIooZiFszn7tIOwM6RW8tbilcyun6DA==
X-Google-Smtp-Source: ABdhPJydOdWvQlu62gj+Tyjj1K6o+0v6Sdo48nGv500/8n/pBF4xK6Bd3vEpqm8kJYxbcwNpK5B9Vg==
X-Received: by 2002:adf:ea91:0:b0:207:b779:7890 with SMTP id s17-20020adfea91000000b00207b7797890mr1139788wrm.676.1649833901867;
        Wed, 13 Apr 2022 00:11:41 -0700 (PDT)
Received: from mclaren.neureality.corp (82.166.25.98.fix.netvision.net.il. [82.166.25.98])
        by smtp.gmail.com with ESMTPSA id p1-20020a5d59a1000000b002078c8b6dabsm18038442wrr.9.2022.04.13.00.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 00:11:41 -0700 (PDT)
From:   Ramon Fried <rfried.dev@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH] uio: make MAX_UIO_MAPS & MAX_UIO_PORT_REGIONS configurable
Date:   Wed, 13 Apr 2022 10:11:37 +0300
Message-Id: <20220413071137.4023184-1-rfried.dev@gmail.com>
X-Mailer: git-send-email 2.30.2
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

MAX_UIO_MAPS and MAX_UIO_PORT_REGIONS are hard-coded to 5.
This is not always sufficiant for some drivers.
Make the MAX_UIO_MAPS and MAX_UIO_PORT_REGIONS configurable by
providing Kconfig int option with the defaut value of 5.

Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
---
 drivers/uio/Kconfig        | 14 ++++++++++++++
 include/linux/uio_driver.h |  4 ++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
index 2e16c5338e5b..bc1fe83cec13 100644
--- a/drivers/uio/Kconfig
+++ b/drivers/uio/Kconfig
@@ -13,6 +13,20 @@ menuconfig UIO
 
 if UIO
 
+config UIO_MAX_MAPS
+	int "Maximum of memory nodes each uio device support(1-128)"
+	range 1 128
+	default 5
+	help
+	  Maximum memory mapping each uio device can support.
+
+config UIO_MAX_PORT_REGIONS
+	int "Maximum of port regions each uio device support(1-128)"
+	range 1 128
+	default 5
+	help
+	  Maximum port regions each uio device can support.
+
 config UIO_CIF
 	tristate "generic Hilscher CIF Card driver"
 	depends on PCI
diff --git a/include/linux/uio_driver.h b/include/linux/uio_driver.h
index 47c5962b876b..f7dc47347c71 100644
--- a/include/linux/uio_driver.h
+++ b/include/linux/uio_driver.h
@@ -44,7 +44,7 @@ struct uio_mem {
 	struct uio_map		*map;
 };
 
-#define MAX_UIO_MAPS	5
+#define MAX_UIO_MAPS	CONFIG_UIO_MAX_MAPS
 
 struct uio_portio;
 
@@ -64,7 +64,7 @@ struct uio_port {
 	struct uio_portio	*portio;
 };
 
-#define MAX_UIO_PORT_REGIONS	5
+#define MAX_UIO_PORT_REGIONS	CONFIG_UIO_MAX_PORT_REGIONS
 
 struct uio_device {
 	struct module           *owner;
-- 
2.30.2

