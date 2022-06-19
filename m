Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EE7550913
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 09:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbiFSHG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 03:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiFSHGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 03:06:55 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1AADFFE
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 00:06:54 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x1-20020a17090abc8100b001ec7f8a51f5so4026489pjr.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 00:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dBOTVmXLQ2WKVyNjwokSzfRoYEMv13f63lC25hv8tCg=;
        b=kv/n5h+HsLgab5rbqx8L5hyByiAvtbnjwWOvatO+vB/+cfMeU41JwNbGrphOvQY87U
         EtL9oILYzXCf8KhKs12s8XVUVr1F/aw7Oegnp6LaGgbetuisKUGGjNJ1KadzbBoH5yvO
         QveX6/c0nAUaY0rVzcFetLONb/NUCqwoJlzxr60OW3YfqZAd2yaDdSiKex52TwkxB/jp
         jbf0qrImyyYswFdFAFXgtKL0b9847i+rFSUP0QJ/msh213xnwiktOOPXwLg0/5vyS9yx
         k2PfzOX7WM3agoCkkNHP1OnNeoLcxa4onWEHrVPDD1tgx0tcfAPmDj7DccTcoLDzC0JR
         horQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dBOTVmXLQ2WKVyNjwokSzfRoYEMv13f63lC25hv8tCg=;
        b=FFhY2XsO6TeczEHipynL3dK6bUandoo1hQNhgWoUrkBq4V835NpcigWHPuvM15URlU
         4FfMSwnpt3hEi4b4eukb+6I6AUOMTPF3rzxpHCOJrbuozea1IKWx+e5YhgzML7KQjFhx
         jzrYxFWzjfsT86/p1T8ogOxUv3UffidITAQLWoVgFtyW4ByZebYSTZIt0hZLiC6UQF11
         QhnqLnVlmteqxr7tIjBu4XerzOj8zWLlOHsntK696MPHQS4WTjIeMUAXAVPRymKSzcLw
         1r60oDu/mSMQ33k8hO8nGACOKiVQVYAGcJEm5pgxDtiqE+7zG/p26RmKhvzk3pUUhNgz
         jUjg==
X-Gm-Message-State: AJIora8VNbHnTNPI2UrqDE/6eBLCdRuDf375sddha0Xx0WdtfZKPEyHH
        1p+CcmWz+r+YDhEGdeZYiF8=
X-Google-Smtp-Source: AGRyM1tECeVojpK1m+jhYMvz7IJirM4TRLEFk0/vXE7K/q8ZRRWuyq2tw3mPIzYtJQoNhW4+djLQ1A==
X-Received: by 2002:a17:90b:38c1:b0:1ea:8403:9305 with SMTP id nn1-20020a17090b38c100b001ea84039305mr19778992pjb.11.1655622413496;
        Sun, 19 Jun 2022 00:06:53 -0700 (PDT)
Received: from localhost.localdomain ([122.167.211.160])
        by smtp.gmail.com with ESMTPSA id w9-20020a17090a8a0900b001ec798b0dc4sm3681555pjn.38.2022.06.19.00.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 00:06:53 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        gregkh@linuxfoundation.org, alexandre.belloni@bootlin.com,
        rafael@kernel.org, mathieu.poirier@linaro.org,
        u.kleine-koenig@pengutronix.de, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>,
        Kernel test robot <lkp@intel.com>
Subject: [PATCH] vme: Added NULL check for bridge
Date:   Sun, 19 Jun 2022 12:36:45 +0530
Message-Id: <20220619070645.100947-1-jrdr.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>

Kernel test robot throws below warning ->
drivers/staging/vme_user/vme.c:662:20: warning: dereference
of NULL 'bridge' [CWE-476] [-Wanalyzer-null-dereference]

Added a NULL check.

Reported-by: Kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
---
 drivers/staging/vme_user/vme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index b5555683a069..ede774f2fe5a 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -659,7 +659,7 @@ ssize_t vme_master_read(struct vme_resource *resource, void *buf, size_t count,
 	struct vme_master_resource *image;
 	size_t length;
 
-	if (!bridge->master_read) {
+	if (bridge && !bridge->master_read) {
 		printk(KERN_WARNING "Reading from resource not supported\n");
 		return -EINVAL;
 	}
-- 
2.25.1

