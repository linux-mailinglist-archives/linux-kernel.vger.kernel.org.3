Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9CA49B177
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243351AbiAYKU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243260AbiAYKQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:16:01 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97685C061401
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:16:00 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n2-20020a255902000000b0060f9d75eafeso40634321ybb.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RGrFnh9zh++a9BFh/Jb2qGqRL46uda17I0gKh7myi08=;
        b=TsQtEztz6vq21oNr0OUxFPxnzt5F+kOhGsC+mOg8FUbuVu5e/hJcCZ6yGEdV74ebuJ
         fp6LloOSuhIxDgVHJ3zsLME58BsbHhERfI2BDbms8PEZAonZcoc5wIAvgfZ+eNouyBMH
         3HhcuvcifcWJ+gm/0of+r635IyeGkTVsE+UFOo+s1L3ZJfT+17BvQt1F7bZ1L+C2YhTn
         hnWlffC0AFbXOHd45LHMJWXBOEYsw4uqWFWMuZhT7IIwpGb2X84uU4QfFH5ZSbfTgefn
         CsTTLuodpYpq/YmB2UUCYf83Y/D7h2/Pf0Y2UBQaId1t+a1Q168H8ERVMWAUVJm9A88u
         ZaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RGrFnh9zh++a9BFh/Jb2qGqRL46uda17I0gKh7myi08=;
        b=4pvDOSH4qjg2IHn63uPS061Rj9CtyHUDSsSta+fslMi29PBdKbp7XR1ulNjYmtm2a8
         s6sQNjTlB7dm0K4GHIilWZJTTY4CM9oYILoEs3JLrnc7jNaBmTdMpATiQ9+6MVyfZhtN
         H0UUysGr3FxWze6fwfc+XtJJsNS6xx2b+n55aRIpoZ21OgKq/0jLLQFZPggh0cRRERtT
         Iedf5831s0VJAnqdKuG4ctlnp/xzFlFqRb2Ic3x/JZY2NoExrX3LPiJMnSG6Bi4o8Jdm
         ruJtvt7+djvqRvw3pkd/tGOLWyqAmIk5GXxbWB6jqGngIXQuYgqQsdtrTZt1QFdIgdJW
         CPew==
X-Gm-Message-State: AOAM532zyje+1ZRm0+YmLSP/iaWvoGlgnbz1fb0BBCgprT8DPubuMeAu
        zwpJ1yloBa14MMfkEcFXtKXyW6REaTpi
X-Google-Smtp-Source: ABdhPJyNMr3PDYuABChRC1ug5r38sZa+F8+T+qC6ZbQ2T8ZOWBTaXQVlN+yFBCLFOf2VGk7lexIw7JKW7o3w
X-Received: from tzungbi-z840.tpe.corp.google.com ([2401:fa00:1:10:69af:7f25:2010:2c85])
 (user=tzungbi job=sendgmr) by 2002:a5b:611:: with SMTP id d17mr28025716ybq.92.1643105759872;
 Tue, 25 Jan 2022 02:15:59 -0800 (PST)
Date:   Tue, 25 Jan 2022 18:15:24 +0800
In-Reply-To: <20220125101527.1812887-1-tzungbi@google.com>
Message-Id: <20220125101527.1812887-4-tzungbi@google.com>
Mime-Version: 1.0
References: <20220125101527.1812887-1-tzungbi@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH 3/6] platform/chrome: cros_ec: determine `wake_enabled` in cros_ec_suspend()
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     bleung@chromium.org
Cc:     groeck@chromium.org, tzungbi@google.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`wake_enabled` indicates cros_ec_resume() needs to call
disable_irq_wake() to undo enable_irq_wake() in cros_ec_suspend().

Determines `wake_enabled` in cros_ec_suspend() instead of
reset-after-used in cros_ec_resume().

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 drivers/platform/chrome/cros_ec.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index a37448f3e179..abbe71309e40 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -342,6 +342,8 @@ int cros_ec_suspend(struct cros_ec_device *ec_dev)
 
 	if (device_may_wakeup(dev))
 		ec_dev->wake_enabled = !enable_irq_wake(ec_dev->irq);
+	else
+		ec_dev->wake_enabled = false;
 
 	disable_irq(ec_dev->irq);
 	ec_dev->suspended = true;
@@ -383,10 +385,9 @@ int cros_ec_resume(struct cros_ec_device *ec_dev)
 		dev_dbg(ec_dev->dev, "Error %d sending resume event to ec",
 			ret);
 
-	if (ec_dev->wake_enabled) {
+	if (ec_dev->wake_enabled)
 		disable_irq_wake(ec_dev->irq);
-		ec_dev->wake_enabled = 0;
-	}
+
 	/*
 	 * Let the mfd devices know about events that occur during
 	 * suspend. This way the clients know what to do with them.
-- 
2.35.0.rc0.227.g00780c9af4-goog

