Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E63A49B178
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344489AbiAYKUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243271AbiAYKQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:16:06 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84528C061782
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:16:06 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v70-20020a25c549000000b006130de5790aso40613235ybe.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lP/ZW2jfCoZSTJKpFAgOH7cQzMhxGPU0UuCQt1ZX2xg=;
        b=G6BjtBL2PQpKPzs/aslF4eV9StQg1wCafTxVudubwVNxLRrHUmHPP4wDH5xx21Lv4f
         qpEEbm8/Z+eR+/z2yndoa+iZ0Pn11Pi5aaa05k2ihLKMil9jJo3fcl721rFm8eR48E8o
         6BlHCvfb5t+8AGYpFCzDR0LH0DMEx+4xFtt0VA8fETU/Hi0E+7l3hm71aRHz/wSa9XC6
         fobrYBmzGPTdoE1T+F5Yd/pa+AQraStZgcyxSi4u3fbWOJRYEsTblWKP/hFVGdZ5d/e3
         qPBc3vZS5NL4gJwqFGH6fWCU9hMtt0vNgdcKtUU6xIkpAt31RqmalNQP+6ZWneht3ylC
         d9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lP/ZW2jfCoZSTJKpFAgOH7cQzMhxGPU0UuCQt1ZX2xg=;
        b=3OSIeRjmSAVL9nBQ1FQTN/XUytZfZMYqtyXGXdfMbwGYYJBlGCKyxhRUtxlm9TeM3U
         uaEgmJalQUv9XxVDx96KrGWMC2tqs2r6Oj3Ig+KIUc6ZayNKwj38y8dFEHI0Mly7dkNz
         an+eblTJAZSBd+ZYZNXZvgxnu+4aELrfg9QKMz8fO8EX0hCsuqCrDEp6JayA8VDF0J96
         pjR3yg1dTa6iREWawhsI87KuVwiDcNA3ZrCq5OUPmqp8egFjW0QJA0R5wKV1iKzLqY/t
         cYBBe9khBdWbOhHvEb+Uz00uNWEfxtB//WJFkAlYlxUyr2fY4VWf3AfYTuXi9P2DuIrf
         h+og==
X-Gm-Message-State: AOAM532dQnWTvWBn1TgHH2ujRslrHf5mnY+tapyhDTGbXni3FZ5FKp6F
        mjltuWFEQvlOCJkrrNB78XhTnjtlIUjl
X-Google-Smtp-Source: ABdhPJyunl1cw7ZQwlY/k4N0AAgqmv4udxGgJmmTXjkcLOpwjvvj+WTae4O2E+OJNsZ3pI+myw/RrVEkN4Al
X-Received: from tzungbi-z840.tpe.corp.google.com ([2401:fa00:1:10:69af:7f25:2010:2c85])
 (user=tzungbi job=sendgmr) by 2002:a81:8505:0:b0:2ca:287c:6be0 with SMTP id
 00721157ae682-2ca287c6e2fmr6127727b3.133.1643105765494; Tue, 25 Jan 2022
 02:16:05 -0800 (PST)
Date:   Tue, 25 Jan 2022 18:15:25 +0800
In-Reply-To: <20220125101527.1812887-1-tzungbi@google.com>
Message-Id: <20220125101527.1812887-5-tzungbi@google.com>
Mime-Version: 1.0
References: <20220125101527.1812887-1-tzungbi@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH 4/6] platform/chrome: cros_ec: don't initialize `err` in cros_ec_register()
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     bleung@chromium.org
Cc:     groeck@chromium.org, tzungbi@google.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`err` in cros_ec_register() doesn't need to be initialized.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 drivers/platform/chrome/cros_ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index abbe71309e40..c2c7a748e48f 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -182,7 +182,7 @@ static int cros_ec_ready_event(struct notifier_block *nb,
 int cros_ec_register(struct cros_ec_device *ec_dev)
 {
 	struct device *dev = ec_dev->dev;
-	int err = 0;
+	int err;
 
 	BLOCKING_INIT_NOTIFIER_HEAD(&ec_dev->event_notifier);
 
-- 
2.35.0.rc0.227.g00780c9af4-goog

