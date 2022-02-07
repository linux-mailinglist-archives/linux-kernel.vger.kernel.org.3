Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED854AC531
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381674AbiBGQOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386002AbiBGQBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:01:07 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D568C0401D9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:01:06 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id m10so17503300oie.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 08:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wOnglUl1uAYKVVD35GZiXd9FDxbCo7pVui2xMN5ng2k=;
        b=LJseETUvhhlpjfqgNVx4CkEqAukgFRYI+4hAvQuyuTMG1aluYNFiioHHhHs4YS6orY
         QvLKeQ/tPRb+MH5WMnOc5QQQ/GeQgikPY4Q95JRgpEcS1avO/RpiWsWIQqo0xJ2tG5G/
         xYyiZuW2V2dWr1wbRRR6AUoZQiqyIj9fiGWW0oCilwBHaHdHboG+hfT4HnpZ89ayd494
         EGyFj3a2IlfCrcZSZzq1I/6SQJgsojXE6/bXZyMFmEXPtl7yofVPS7I1QBLTxFA6jeUB
         2X481JyOAL+HWXKP1WW+Vuf6yIwzREwCk9Onf4KbDjkT/oSlLC/pomSsIAvyz0Jli+bY
         pwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wOnglUl1uAYKVVD35GZiXd9FDxbCo7pVui2xMN5ng2k=;
        b=qWactqg/YVdSIZtA1pc02nz1aYhO2kPdSQPlh5NWim2L5FqUzs/yz0zcwdCQqunPAD
         qsmcJdjk6XcST9r6dtKEim77VKLL+NvTzfnzhy28H0NUMO+FOdiSbA8XE0Jq7nsbKqOP
         w8IXKjnpnrE/cDyaieOIB2xiuR+AcKiHG8LvbbqYTS9mzisqYM2oyoezpckBCCq4VyQI
         U7F5GdJ6GXRLwRvm4YPek6zl7VyVN0a5zjeSnJlXGDP3hquqH9F++xkjZU9fH2mDlgWh
         CxFIvgt8ThBt2kt3QhqoFMSZ6JE6YvrAmxk/jMFAvU5o03qadPwQdwSksPmFPx+QQ0tx
         usGg==
X-Gm-Message-State: AOAM533Dx1Re+Qh/7WRO0G8+kJt0BvA+EHMxFrpSpBkQZAX05SWvZdrg
        PZ8LDZ46rjSIk++a+sEGJFU=
X-Google-Smtp-Source: ABdhPJyD4UpToOvIQIFw9Irbe12rKVbwLrk8ws70xElXnFRMvNXDq7KX6BOTkKMWA9KfDBu0TUX8aA==
X-Received: by 2002:aca:f06:: with SMTP id 6mr173415oip.70.1644249664127;
        Mon, 07 Feb 2022 08:01:04 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4cd8:12bf:4134:806a:5a4a:2a88])
        by smtp.gmail.com with ESMTPSA id o144sm4157803ooo.25.2022.02.07.08.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 08:01:03 -0800 (PST)
From:   Leonardo Araujo <leonardo.aa88@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Leonardo Araujo <leonardo.aa88@gmail.com>
Subject: [PATCH] Staging: wfx: CHECK: usleep_range is preferred over udelay
Date:   Mon,  7 Feb 2022 13:00:51 -0300
Message-Id: <20220207160051.27829-1-leonardo.aa88@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the checks reported by checkpatch.pl for usleep_range.

Signed-off-by: Leonardo Araujo <leonardo.aa88@gmail.com>
---
 drivers/staging/wfx/bh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/bh.c b/drivers/staging/wfx/bh.c
index a0f9d1b53019..ebc7eaf93ef0 100644
--- a/drivers/staging/wfx/bh.c
+++ b/drivers/staging/wfx/bh.c
@@ -312,7 +312,7 @@ void wfx_bh_poll_irq(struct wfx_dev *wdev)
 			dev_err(wdev->dev, "time out while polling control register\n");
 			return;
 		}
-		udelay(200);
+		usleep_range(200, 200);
 	}
 	wfx_bh_request_rx(wdev);
 }
-- 
2.29.0

