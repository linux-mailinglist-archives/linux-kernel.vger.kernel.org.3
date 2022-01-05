Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CF3485B4E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244814AbiAEWH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244761AbiAEWHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:07:16 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56192C061201
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 14:07:15 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id g22so391755pgn.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 14:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6WCJwqEj0h+pT7JB6ahklNMVuD59VbpyBsBSLRT5cf8=;
        b=fN1tszztLxbDkQIdMMcqOJ235HOU+Blra8hAC4uP2jC/GkcvaV4rcTYeL5gO6imU2c
         v8oIMhul3cnFXt5+ZhztZ+lSbd36tUaA87OK7SpEsQMXrjWIpup2WJmP7isAFsEBcxgh
         2e23ZneP1y+Tm8fXD7T9kCQlSU9EUQaO6mcOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6WCJwqEj0h+pT7JB6ahklNMVuD59VbpyBsBSLRT5cf8=;
        b=NoIdtU+Dg8iXYThydo+uM2beiqrJ7uu/8eo8MpnNcLyEmlLb9l5QSUhWV8pDH83XXG
         f7yRbYaFvZK5YoeIBVlF533Ls23Q0mM+BJ5QNIchbuFBJrjsFAgfV1ZqgXBkkkKEC9b0
         WG07ZjaIUgKj6/1DoUZl0TJoewao/OHyLMGETrdWcJgIfKBwBX4eYlk/0a71SHuKO7P1
         piCxcOpQyG0Gi9+0DmKWYe4gnyrxSIqMCZwCrIXcbdCj/bh19WPt/iYOGOHdSSXYHsm2
         zD+1iMykiyhQyQkxeiN9NFjsulNmXgGSpkiuoQxeAi16SVICOVaYO0x2zEpvd2NSJzTV
         crOA==
X-Gm-Message-State: AOAM531/5TvUqdxogX2aTFZF9cFSpa8YlJL55C5rdG+ocF3qHMCswiFq
        wAxOoYHydd3aiocMKJeE4xsZsg==
X-Google-Smtp-Source: ABdhPJz4WzeTSE3RuDHmyrq9+T6VZmBV9cNIOFs480PMKwLRjbWNwP646fMYiINOu57skRSKY7sUJw==
X-Received: by 2002:a63:c045:: with SMTP id z5mr49684605pgi.441.1641420434905;
        Wed, 05 Jan 2022 14:07:14 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7fcd:6709:f1b5:a22a])
        by smtp.gmail.com with UTF8SMTPSA id 185sm102031pfe.26.2022.01.05.14.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 14:07:14 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, groeck@chromium.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, benjamin.tissoires@redhat.com,
        jic23@kernel.org, dtor@chromium.org, hverkuil-cisco@xs4all.nl,
        mchehab@kernel.org, lee.jones@linaro.org, pmalani@chromium.org,
        sre@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lgirdwood@gmail.com,
        a.zummo@towertech.it, cychiang@chromium.org, perex@perex.cz
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 06/17] mfd: cros_ec_dev: Add PL_CHROMEOS dependency
Date:   Wed,  5 Jan 2022 14:06:42 -0800
Message-Id: <20220105220653.122451-7-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20220105220653.122451-1-gwendal@chromium.org>
References: <20220105220653.122451-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 'make nsdeps' to add missing dependencies.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/mfd/cros_ec_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 546feef851abb5..9f501f8f30a5a2 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -330,3 +330,4 @@ MODULE_AUTHOR("Bill Richardson <wfrichar@chromium.org>");
 MODULE_DESCRIPTION("Userspace interface to the Chrome OS Embedded Controller");
 MODULE_VERSION("1.0");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PL_CHROMEOS);
-- 
2.34.1.448.ga2b2bfdf31-goog

