Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4366349B17A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346480AbiAYKVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243295AbiAYKQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:16:20 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07E1C061787
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:16:17 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a3-20020a056902056300b0061496fc6a45so25465246ybt.14
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=x2MdSdGv5+J9gN355PMaPNhrV9fxjS31nvsNBZsbXJQ=;
        b=Qd1J/nzdXCvpZXg4Ebtb2NAj9AiXOkPXKNlMoRUksh23IVkQtwcbo/g+gBp8sL2mI/
         wB0fdgQYZT1r2oENBwCRqNmua4MWvgYkWYYYk/1tlMpoT/IafHw0LLe/E196cG2xAPd1
         iiZM5Fc4s3bPpYDTGLw/6xUCRBk/9/4B491qCxK+GMzuov6baBkem/Zt7tt7dn0p+Ylr
         c5E7yNcBtCpdrA/s4Mp+rBWHUgWKnhFqiXIU15c/T4pPjBcucq38+JCNO4fpPmAMQ6p7
         X8wklLVpirP9mvJkdiQAL/41Wf9BP/rS16b/4eSAQJMDceS7/JQfrBGeEL97qTIn2R/j
         /iUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x2MdSdGv5+J9gN355PMaPNhrV9fxjS31nvsNBZsbXJQ=;
        b=Kw+htHJVzwCccyiXjH0meuItcwt1tH6Mf8qk1fWD0qQB57W3FmjM0AAAMufhHk/TyW
         CMLeJ/myPZLdCyfGlsyk0HZ9LU3txF565RUCXKdCaLEk1RLW7WlDDL9OcQhkzBbc7QXR
         IwYBZxthbeYCu8QIiJPphFGT0nUwSV/7dWlcZYTBdOBq48VHe6Cb1QK4FiDd48JHEir4
         mm+siWQPHBA8qtT/ahbiUloaLU46xa7ulymEIKa+SPfE/t02B2gvl22pZfP/2ePKk8Me
         6JEKdZViY5ZguxmqHLuGFVhbBDGDSintFWW6Pm4FnPWNtiJSJVzVDpL+T4Afw6znWfej
         AhiA==
X-Gm-Message-State: AOAM530byw977Z1/s/FfHhBLJeGNolvtqvaluX9nUzwN9kDtaJtL9t4Q
        BFkgv/yLUghLDCUx6vwvgxzanXkI7oxq
X-Google-Smtp-Source: ABdhPJyATR5uZn9dMeDP8WCoFnEs9KhBUGqkfTI6wA4cdQPp6P0oNpVhO+YHNNhosXwm8J8AHtnJCg2Db1TW
X-Received: from tzungbi-z840.tpe.corp.google.com ([2401:fa00:1:10:69af:7f25:2010:2c85])
 (user=tzungbi job=sendgmr) by 2002:a25:af4b:: with SMTP id
 c11mr28212004ybj.49.1643105777186; Tue, 25 Jan 2022 02:16:17 -0800 (PST)
Date:   Tue, 25 Jan 2022 18:15:27 +0800
In-Reply-To: <20220125101527.1812887-1-tzungbi@google.com>
Message-Id: <20220125101527.1812887-7-tzungbi@google.com>
Mime-Version: 1.0
References: <20220125101527.1812887-1-tzungbi@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH 6/6] platform/chrome: cros_ec: append newline to all logs
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     bleung@chromium.org
Cc:     groeck@chromium.org, tzungbi@google.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be consistent, appends newline ("\n") to all logs.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 drivers/platform/chrome/cros_ec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 934ab30c9d08..679df6af5612 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -213,7 +213,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 						"chromeos-ec", ec_dev);
 		if (err) {
-			dev_err(dev, "Failed to request IRQ %d: %d",
+			dev_err(dev, "Failed to request IRQ %d: %d\n",
 				ec_dev->irq, err);
 			return err;
 		}
@@ -264,7 +264,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 	 */
 	err = cros_ec_sleep_event(ec_dev, 0);
 	if (err < 0)
-		dev_dbg(ec_dev->dev, "Error %d clearing sleep event to ec",
+		dev_dbg(ec_dev->dev, "Error %d clearing sleep event to ec\n",
 			err);
 
 	if (ec_dev->mkbp_event_supported) {
@@ -337,7 +337,7 @@ int cros_ec_suspend(struct cros_ec_device *ec_dev)
 
 	ret = cros_ec_sleep_event(ec_dev, sleep_event);
 	if (ret < 0)
-		dev_dbg(ec_dev->dev, "Error %d sending suspend event to ec",
+		dev_dbg(ec_dev->dev, "Error %d sending suspend event to ec\n",
 			ret);
 
 	if (device_may_wakeup(dev))
@@ -382,7 +382,7 @@ int cros_ec_resume(struct cros_ec_device *ec_dev)
 
 	ret = cros_ec_sleep_event(ec_dev, sleep_event);
 	if (ret < 0)
-		dev_dbg(ec_dev->dev, "Error %d sending resume event to ec",
+		dev_dbg(ec_dev->dev, "Error %d sending resume event to ec\n",
 			ret);
 
 	if (ec_dev->wake_enabled)
-- 
2.35.0.rc0.227.g00780c9af4-goog

