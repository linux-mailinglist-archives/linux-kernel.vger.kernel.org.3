Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA8B462825
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 00:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhK2XVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbhK2XVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:21:10 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D239C061714;
        Mon, 29 Nov 2021 15:17:52 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u1so40188972wru.13;
        Mon, 29 Nov 2021 15:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VbynDBrtrIEL8OAyHWbv2qBQ+JE1Sa3lpO8rfK9pZ10=;
        b=D7cqz37ZwlaazrxfTJ3ewMvMA586jbArHykVtSxDPLlJ9Gaprp40Q7xJ5YPIGkrwfq
         Mlcxqa9JNI9lgApB7r9dyNkQD67O884qRyro528JE7Sw4+ziEhv+lrl88IsnVrNvXLUY
         +j+errdudods9C6ix7Bzb954NcA7HsFnqW7xpu708DhY0mh4CfAhiQoRDXT90DnsALlA
         REWUSg3Os9Gbkeenirh24JoZAGl94tiVIixWoQGZU7FITfjGTMcFcacaEhheW63KuMh7
         mynt5Viw6StTLzXigZ4KHS1A8RmlisPRcr8HSHtbUmHJrXAo8GQskY3L82RTF0/xO3q0
         TTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VbynDBrtrIEL8OAyHWbv2qBQ+JE1Sa3lpO8rfK9pZ10=;
        b=LrnmPAE2fv5pHn1oXtoqHz/KnZk0GOgUw8l2lGHEqnzBqGz3+ococ7nGXn0MD0H3NY
         p9s3QRXNjI6aXlv+WqW3qSYL+LYI6VkdCcKnH1adL2HDV3n8n8EreULcW3NjuhdTS9st
         yXiK0HzlZwn2VESDmTUgdSL4Q4mPEE7pL0ALtynxS28Sk4v9ZYmajs9P2ELIculNCWyC
         5KfCSPajeouqngwsDrHeNgZW2ptLVFUA8SpnFQEUdtNW36R3HkWEAaDWw8UBW4zJlbOp
         4481qjlvK+GMQVjbfgqjBHSUiPYEWqTXrBE+PS7IAqKGjTXnXT0UgFc4fwtPJkoAL8+A
         gj6Q==
X-Gm-Message-State: AOAM532mlUL8ibt/waugDAMU6SKgnUx/RryddpCQ92tGEHMUqLy/1hdU
        H4OO8HOMSeIAww==
X-Google-Smtp-Source: ABdhPJxRaKrcRdpPqb0+Vtg25aoqMtpbWHxGvfRonzdT/5TkNunduBPY2zy2IV18CV8oevNodtZRMQ==
X-Received: by 2002:a5d:4f12:: with SMTP id c18mr36271541wru.547.1638227870912;
        Mon, 29 Nov 2021 15:17:50 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o3sm670224wms.10.2021.11.29.15.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 15:17:50 -0800 (PST)
From:   Colin Ian King <colin.i.king@googlemail.com>
X-Google-Original-From: Colin Ian King <colin.i.king@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] input: palmas-pwrbutton: make a couple of arrays static const
Date:   Mon, 29 Nov 2021 23:17:49 +0000
Message-Id: <20211129231749.619469-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate a couple of arrays on the stack but instead make them
static const. Also makes the object code smaller by a few hundred
bytes.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/input/misc/palmas-pwrbutton.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/palmas-pwrbutton.c b/drivers/input/misc/palmas-pwrbutton.c
index f9b05cf09ff5..1c7ceb20b5af 100644
--- a/drivers/input/misc/palmas-pwrbutton.c
+++ b/drivers/input/misc/palmas-pwrbutton.c
@@ -115,8 +115,8 @@ static void palmas_pwron_params_ofinit(struct device *dev,
 	struct device_node *np;
 	u32 val;
 	int i, error;
-	u8 lpk_times[] = { 6, 8, 10, 12 };
-	int pwr_on_deb_ms[] = { 15, 100, 500, 1000 };
+	static const u8 lpk_times[] = { 6, 8, 10, 12 };
+	static const int pwr_on_deb_ms[] = { 15, 100, 500, 1000 };
 
 	memset(config, 0, sizeof(*config));
 
-- 
2.33.1

