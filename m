Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6094E53DEEA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 01:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351809AbiFEXSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 19:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348584AbiFEXSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 19:18:42 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7D23527A
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 16:18:39 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o6so5752587plg.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 16:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g3BmJglTAjdnPLCGYhrHUrRvgHR+8N25cKSWQP4OWdo=;
        b=ZAA3tFmKdv+hsGYm0P0OrG8/DX9rjJq2pyOvCXV69jvY+yDW/qejLqet7DFf4kJGkW
         a166XTuZRJPK82neRxN6fzYaAF+pqPSOVt+HnFAALjE9v3PGWFsfhpKRDS8NbFKrXQ4Z
         PvDD4J3CIthf1j8sOj8qIUfa94RLiByPZ2cMjVOMwbTmxudUsltxSC3Jq5jWReWbl7bd
         NeBTg1T93iIDg0dgzHUh8zwtZqJCOSNGKTgIuq4PlFgA5JvlpqTGd0RJ6onZtFgHs4o2
         HbKPNQnB4K/+EnfQqfxgyGkqjjbKbdi4Gdauzrj8sKFO8vGupI8A9zux47P51yWf1/M0
         9AOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g3BmJglTAjdnPLCGYhrHUrRvgHR+8N25cKSWQP4OWdo=;
        b=7lKe/AA3m1shqkqo5sERQReUV3XNYxmNTl+X3pq5Lf8CuZ1XblCjvtfBDbDXvR7FDr
         +mOWQYuIoTaeitYb0wG3f3YFCRsWpml+stv3XAED7bu/wq9JxklywfX5EieBOZ7Z43xm
         38WHdvrw2KqziXfdbSjLkDLXJ/QPtjvFKkIvMDZC1OlgvQsoUGk5gO7drkeHprXwbrxq
         4MZj3SksC+/gMkDmvs/6SMvrzftv0kXLzq/9abdmFbJs+xoSFeo/5Yf9uBJ46R8pUcFF
         uGh08h7JNiIAWSWWqO9Z1kWBDe0hFWkkNkemihYdfWv7fJyEBgeJcgOfqFQRYvLPVpzo
         vyhA==
X-Gm-Message-State: AOAM531Y8CJRrrYZZrOxL0Kb6U6XGT9bgkLsQUlP3/k6qJGwb+4+nuiG
        I+et0dNTquD9dlVJphcnPfot0pWQ7NC17DXSxgw=
X-Google-Smtp-Source: ABdhPJziDtmWG7/wz+O6OHwkY+cBzggnGgVgcvrHu3ixyvAj7J0WuFlqaijreDNHDRPBf4RSn78ITQ==
X-Received: by 2002:a17:902:d48e:b0:167:5752:3b43 with SMTP id c14-20020a170902d48e00b0016757523b43mr11355808plg.52.1654471119415;
        Sun, 05 Jun 2022 16:18:39 -0700 (PDT)
Received: from fedora.hsd1.wa.comcast.net ([2601:1c1:4202:28a0::ec2b])
        by smtp.gmail.com with ESMTPSA id f21-20020a170902f39500b0015e8d4eb1d7sm9051948ple.33.2022.06.05.16.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 16:18:39 -0700 (PDT)
From:   Jared Kangas <kangas.jd@gmail.com>
To:     vaibhav.sr@gmail.com
Cc:     mgreer@animalcreek.com, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        johan@kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, kangas.jd@gmail.com
Subject: [PATCH] staging: greybus: audio: fix loop cursor use after iteration
Date:   Sun,  5 Jun 2022 16:18:06 -0700
Message-Id: <20220605231806.720085-1-kangas.jd@gmail.com>
X-Mailer: git-send-email 2.34.3
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

gbaudio_dapm_free_controls() iterates over widgets using
list_for_each_entry_safe(), which leaves the loop cursor pointing to a
meaningless structure if it completes a traversal of the list. The
cursor was set to NULL at the end of the loop body, but would be
overwritten by the final loop cursor update.

Because of this behavior, the widget could be non-null after the loop
even if the widget wasn't found, and the cleanup logic would treat the
pointer as a valid widget to free.

To fix this, introduce a temporary variable to act as the loop cursor
and copy it to a variable that can be accessed after the loop finishes.

This was detected with the help of Coccinelle.

Signed-off-by: Jared Kangas <kangas.jd@gmail.com>
---
 drivers/staging/greybus/audio_helper.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/greybus/audio_helper.c b/drivers/staging/greybus/audio_helper.c
index 843760675876..07461a5d97c7 100644
--- a/drivers/staging/greybus/audio_helper.c
+++ b/drivers/staging/greybus/audio_helper.c
@@ -115,7 +115,7 @@ int gbaudio_dapm_free_controls(struct snd_soc_dapm_context *dapm,
 			       int num)
 {
 	int i;
-	struct snd_soc_dapm_widget *w, *next_w;
+	struct snd_soc_dapm_widget *w, *next_w, *tmp_w;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *parent = dapm->debugfs_dapm;
 	struct dentry *debugfs_w = NULL;
@@ -124,13 +124,14 @@ int gbaudio_dapm_free_controls(struct snd_soc_dapm_context *dapm,
 	mutex_lock(&dapm->card->dapm_mutex);
 	for (i = 0; i < num; i++) {
 		/* below logic can be optimized to identify widget pointer */
-		list_for_each_entry_safe(w, next_w, &dapm->card->widgets,
+		w = NULL;
+		list_for_each_entry_safe(tmp_w, next_w, &dapm->card->widgets,
 					 list) {
-			if (w->dapm != dapm)
-				continue;
-			if (!strcmp(w->name, widget->name))
+			if (tmp_w->dapm == dapm &&
+			    !strcmp(tmp_w->name, widget->name)) {
+				w = tmp_w;
 				break;
-			w = NULL;
+			}
 		}
 		if (!w) {
 			dev_err(dapm->dev, "%s: widget not found\n",
-- 
2.34.3

