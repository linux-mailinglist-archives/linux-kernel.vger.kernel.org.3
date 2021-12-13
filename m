Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5111E471F4A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 03:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhLMCP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 21:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLMCP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 21:15:58 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1604BC06173F;
        Sun, 12 Dec 2021 18:15:58 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id p19so13902812qtw.12;
        Sun, 12 Dec 2021 18:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OK+01rE8av+7Y4vzBf+grUD9vYsbU9TwKKraT+N95Pc=;
        b=FY8iVW63KGP5lbyFd7OGt33SfGHPjhgQJ1TzdqCmeUE4+GmjPjoaiJ6eqGAG4qE654
         oDE/nPnSl4NdJwupq8c3L+W0enI5+YTZNkBQcLrR5hr8VEpTRR6stBLOoLeKMbtR7UU7
         XNWSiU7ZUTZOhiGHDpZVbZypFoSNYHVHXHAmUdjfoIdJniw9p4/rliw3smm7sKbV9Ezr
         ChdPRhgtdYHfDKa+W1Z8e1fVWhXTeEB9j4I/52KV8W1vtMQmwO7rwWAU/74hnaOCoqwM
         WJSKYG1muLUR+zWJbMCk9NEiaqLTvQWf42mJkI7dALIlBKnHhl1bZnJptTV+2AZ5HsQk
         YTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OK+01rE8av+7Y4vzBf+grUD9vYsbU9TwKKraT+N95Pc=;
        b=PMIPiR7NywmzQlnirhF2fRRWEI95CVqJiEMNlyEaDQ1lq15cpMFOqnarQaZlHcoNJ+
         X/aKWqenj7UdOdeYq1k5a3csnvXX3BhUKH3EdFi9D1oFUGoidk28dZEKkxTUWKLbOwVt
         s16ibKxuBK4QD7wm0oa985UnsKFfLOJ4zJujZ691e9RGcMd4ULta3WyLtrXPK8TOmZgl
         50mVhSc4oatFKCRcPA6Sy+nUdGZJiGvn9hosP64Kv6GKRF+mHUaPFPqHxzmkztRrKiaj
         ul+2belFuRG10xw4P96HJbpZF9UIR7icKGnhsUQYh+DstVoX9ampp/B7i6HOHORRNnne
         eeTw==
X-Gm-Message-State: AOAM532ve58lHKWCw544gs39/v+sh59MOWb+FZ+mvhGjhzqsG7sgNoGR
        cAMWGikxoSjzvpKbmzOSzAuq6ply378=
X-Google-Smtp-Source: ABdhPJxcsspCwPrhH0BGs6rwawHGlTuuolVIhdQfb0CPh3CD2DKPdKzE7rXYpuhCSXMYnZ5BvMfaNA==
X-Received: by 2002:a05:622a:287:: with SMTP id z7mr42809520qtw.223.1639361757084;
        Sun, 12 Dec 2021 18:15:57 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m20sm8573687qtx.39.2021.12.12.18.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 18:15:52 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     a.zummo@towertech.it
Cc:     alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH rtc-next] drivers/rtc: remove redundant err variable
Date:   Mon, 13 Dec 2021 02:15:38 +0000
Message-Id: <20211213021538.435341-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from s35390a_set_reg() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/rtc/rtc-s35390a.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index 26278c770731..b382759aa544 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -211,7 +211,7 @@ static int s35390a_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct s35390a	*s35390a = i2c_get_clientdata(client);
-	int i, err;
+	int i;
 	char buf[7], status;
 
 	dev_dbg(&client->dev, "%s: tm is secs=%d, mins=%d, hours=%d mday=%d, "
@@ -234,9 +234,7 @@ static int s35390a_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	for (i = 0; i < 7; ++i)
 		buf[i] = bitrev8(buf[i]);
 
-	err = s35390a_set_reg(s35390a, S35390A_CMD_TIME1, buf, sizeof(buf));
-
-	return err;
+	return s35390a_set_reg(s35390a, S35390A_CMD_TIME1, buf, sizeof(buf));
 }
 
 static int s35390a_rtc_read_time(struct device *dev, struct rtc_time *tm)
-- 
2.25.1

