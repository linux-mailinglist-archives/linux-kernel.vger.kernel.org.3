Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9421F559868
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 13:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiFXLUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 07:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiFXLUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 07:20:19 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A474667E6C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 04:20:18 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-317765eb7ccso19154107b3.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 04:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kNHqgFkl4YtCT8pApbI11s72RFD7Nt0OXIvThCLw2Rc=;
        b=ip2rsVnLkEXP2nEvAFw/6ziC0Ey7lsJnGlf1m/VagPLcx9QLX2XmZa8VwX/GffV0F2
         4P/V6EXhVlUAm9jt5y8faz2KrK5IA2RbQGSIKladV+3a6eUzSqXtRd2UVxXhjKuh3ivH
         dXUK/kVjsfphNKyEr+qpiE0+72XQgaLrwsB2u7j+NFI4KSlJhphu9XES6QOU8mfSb8LU
         m7+AitHnhFbSugm772jNJfcYfA8nqURR6IHxqQQD4sJvFae4nb0uNWssyPekbIUlrAWw
         w/CwN7Or004nIsaWGO7Gvn19Y9eqr1TO9qhdVcGpuK3qmVqlN34uDxFxtup6qQupj1IA
         r8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kNHqgFkl4YtCT8pApbI11s72RFD7Nt0OXIvThCLw2Rc=;
        b=xyQhIYScNYmkOfyWsuZ1MGRd//WHBsrCHyV1OZe30Lek2eBnsKzGaI8m7SZdqwZNrU
         pU5uzJcG1xL2eLGRFUM4BKXenalZad5e+RhYUZlsUVSaIwZV7zLRtiQ5hSimIPYK8CVD
         kkfFJQXUp3RiagmogcTFhOn+S5Snidg5kI/baJIqU0qKFu1STxeRCVXb59YRnQ/jEfqT
         mpglgoIvdJOVRjzCVu3gGtpsWmzYiNK1TC4IF51um5GOhuSrGf2wvfbih2886JDu5O+R
         eGE3rlTGMbw3VcVBaJG5EPOPIs8dxQm3DhTz2I53Oti+lUMjQ4fsQzXPTelLKumSRuqM
         Uqiw==
X-Gm-Message-State: AJIora+hCKIRD+SPXTYNWum06o/DnY8f33+jOd035YtbxANfU1ni7TLc
        nDIQK1/vQyOcVYHH0hQzLj94S5yK+yuB
X-Google-Smtp-Source: AGRyM1vZ2O5HPCKW+EpLjwKc7xAvjgcKU/GyVldbwoFqhyL9pKjZ3jZxN3A3KOAYEQyaMB2Ziq0YTbgmnJN9
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:17:fcdb:e3a1:45d7:ed39])
 (user=apusaka job=sendgmr) by 2002:a25:2309:0:b0:668:a570:f69a with SMTP id
 j9-20020a252309000000b00668a570f69amr14997205ybj.554.1656069617958; Fri, 24
 Jun 2022 04:20:17 -0700 (PDT)
Date:   Fri, 24 Jun 2022 19:20:12 +0800
Message-Id: <20220624192010.1.I9afcc6142cb963cf7014aa09edf61a94f5684799@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
Subject: [PATCH] Bluetooth: btmrvl_sdio: Remove hci_{suspend|resume}_dev
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@google.com>,
        Manish Mandlik <mmandlik@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Both calls are already handled by the hci_suspend_notifier.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@google.com>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>

---

 drivers/bluetooth/btmrvl_sdio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index b8ef66f89fc1..41f1c15ec5c1 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -1656,7 +1656,6 @@ static int btmrvl_sdio_suspend(struct device *dev)
 	priv->adapter->is_suspending = true;
 	hcidev = priv->btmrvl_dev.hcidev;
 	BT_DBG("%s: SDIO suspend", hcidev->name);
-	hci_suspend_dev(hcidev);
 
 	if (priv->adapter->hs_state != HS_ACTIVATED) {
 		if (btmrvl_enable_hs(priv)) {
@@ -1721,7 +1720,6 @@ static int btmrvl_sdio_resume(struct device *dev)
 	BT_DBG("%s: HS DEACTIVATED in resume!", hcidev->name);
 	priv->adapter->is_suspended = false;
 	BT_DBG("%s: SDIO resume", hcidev->name);
-	hci_resume_dev(hcidev);
 
 	/* Disable platform specific wakeup interrupt */
 	if (card->plt_wake_cfg && card->plt_wake_cfg->irq_bt >= 0 &&
-- 
2.37.0.rc0.104.g0611611a94-goog

