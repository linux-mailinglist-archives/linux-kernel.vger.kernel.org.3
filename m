Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092B6496357
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381493AbiAUQ5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380315AbiAUQ45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:56:57 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ED6C061772;
        Fri, 21 Jan 2022 08:55:45 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id e81so14365960oia.6;
        Fri, 21 Jan 2022 08:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lfG5LLChWvRNdV9wVnldjwvOnVKmO3qiE7tQP9HKM08=;
        b=aW+lLvcniNVbrserfJPdMCLN+pjYIGdCJyovb01N9B356oX9NqLNjrEKpWRJypyk3G
         dhj4n3KX5qWKuXWdzY3XY1jKasWd4F6312ewviRlgL18S0j6Y+7LI4UwnLQqRGULGS1s
         dKrLEncGyDf5b/5ZQn81LzlEutk3qyhaYpInHqTzuJpyrdjtujD28LGSCfuVQXBz0nw/
         3j4OTSnLnUHGb8KX7UIDr4KG2raMwMNoJ4smKXRLBmNNuuyUiY/ifk58w5lDAX3ok+j1
         P0WmbqetCG/0NkSLF5hUPg2XjJ0lX/oS9w0N3UtacNfcmxnakpE4vG9VDgfVwsIraKOB
         iT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lfG5LLChWvRNdV9wVnldjwvOnVKmO3qiE7tQP9HKM08=;
        b=QB8aCx2K55ZfBqRo9Yev6JyM225d3phdGjyUydmFsDfhpY+Vg6AAFJkrgYymUzhF8F
         Fsi6/eao0wCKDH+VQQsasPa1SsKLSE4ExGi1we0kc/mnAcNX8zKcHPMQgR5fcH14v43Q
         2evdyhQdoOU/6h0r0g13IfU6Jt1gQQSmKaEGwipd3mDgBAUlG33/U5lIv5Re/HXyGyWH
         exGx7NADs6CA6gOZJdpYmbauVDNjm8l3rBtgY2dvUc9pqAGm9YbfaUpHIIF12jI3R2r6
         DuNvfBPqTPrOaNpyHvZjJgKmPAmFGKidIu3COdzrIhCvtK0NpYeGT7n7SurSAjS5ciWw
         TWAA==
X-Gm-Message-State: AOAM531AboBVnQzOEoIw+6ydYIfEcpvZS1mOoEzMkdzKVjZSGq95bFSD
        IVgs10ui3g+dbG/38L1BopsPPW5d3hw=
X-Google-Smtp-Source: ABdhPJyrJQEbFXhs9KtvBf+u6DpwUM4N/tZ43aXtQP893w84s/JggZSo1F8pUf7m1CvR0hfopANpZg==
X-Received: by 2002:a05:6808:1824:: with SMTP id bh36mr1239215oib.142.1642784144544;
        Fri, 21 Jan 2022 08:55:44 -0800 (PST)
Received: from thinkpad.localdomain ([2804:14d:5cd1:5d03:cf72:4317:3105:f6e5])
        by smtp.gmail.com with ESMTPSA id y8sm1089271oou.23.2022.01.21.08.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 08:55:44 -0800 (PST)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>,
        linux-leds@vger.kernel.org
Subject: [PATCH 25/31] include: linux: leds: changing LED_* from enum led_brightness to actual value
Date:   Fri, 21 Jan 2022 13:54:30 -0300
Message-Id: <20220121165436.30956-26-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121165436.30956-1-sampaio.ime@gmail.com>
References: <20220121165436.30956-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enum led_brightness, which contains the declaration of LED_OFF,
LED_ON, LED_HALF and LED_FULL is obsolete, as the led class now supports
max_brightness.
---
 include/linux/leds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/leds.h b/include/linux/leds.h
index ba4861ec73d3..814541e41ce0 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -597,7 +597,7 @@ void ledtrig_audio_set(enum led_audio type, enum led_brightness state);
 #else
 static inline enum led_brightness ledtrig_audio_get(enum led_audio type)
 {
-	return LED_OFF;
+	return 0;
 }
 static inline void ledtrig_audio_set(enum led_audio type,
 				     enum led_brightness state)
-- 
2.34.1

