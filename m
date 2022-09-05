Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BEB5ACE77
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 11:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbiIEJBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 05:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238065AbiIEJB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 05:01:26 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A13252BA;
        Mon,  5 Sep 2022 02:01:25 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id x80so7638109pgx.0;
        Mon, 05 Sep 2022 02:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=CPGGum1MDN+pB+HXDP5MXslll6uCmqFxPIpknbF02gw=;
        b=o8KqR9WhgbForHGilmBEfGdcPboFzgbTHbhcPuu+EI+oFveN32AgOGhxQAa+begKf3
         t8BSokBBWiL3lWgtGPup7EtQiyklecnN4+AidwO/Xi8uEgfjjvFBsgfOU7Hbs47vrk2l
         f2UBFkyMGaCzXHmL6rWSBpeHKiQT1LzTOZEbzyR55uUE5MWfdkF1pDoKD994jJuZaMU3
         8xGtN92me0hQOn7/Y5BfDEqHLnv28i8WVZWLtE1ig1srKPnnaph2wsULxdaNvOm4gTsJ
         slPxelEMQ33bDIfc1O8e5QwywvxOmP6tKahE2g06LAAEMJMfGfuqT7MKyR5MSdTsIhjv
         Y1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=CPGGum1MDN+pB+HXDP5MXslll6uCmqFxPIpknbF02gw=;
        b=A4c6pa9WpMGkAG67RGKM8VJI7fHaDQA9rzp1Pk6pjt61xU1A8RKXH+uAwXVjCOf2O8
         dE5ZchfJs44lrEXKVr3WtoHaJAHxLYCYZF0l4OnjQ+3mqlG6uJGk5d44j+mDDPSGVemR
         RA7LhnGJPqRG3Y08s4YWcVAIev3Thdq80239vxIMH+9/8XF2TwQZqX5JLM7N1jys13li
         AaESWh0EAQR21bsAa8QhseuO50333X/ujZa/XQBS7tvd/aZvMt5NK0avi3WeG+gybzwh
         v1DJuzxUMQJlwCDBgt8AQ8Pb1zKfyHdxj+GQ3tu1tYWQ9QaLCZ6fQ3OX+ylNSD5tIi0A
         JGEQ==
X-Gm-Message-State: ACgBeo1FnyKOwSvg1zijXAsY4472DE2thvKF/otSY6P3HjBbJdL4h8ST
        Bm8fkQNfP8oB89LXtoKiEdj2XZC5aYU=
X-Google-Smtp-Source: AA6agR5OTV2ApW7a35Iy7gFl0JtLj2i3ICXfyIXTSoj0yII/8ireAJylVlZpOWuQWPD6NGhBhCh1mw==
X-Received: by 2002:a65:6d19:0:b0:42a:37d7:90da with SMTP id bf25-20020a656d19000000b0042a37d790damr41036462pgb.16.1662368485331;
        Mon, 05 Sep 2022 02:01:25 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id r12-20020aa7988c000000b0053612ec8859sm7089440pfl.209.2022.09.05.02.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 02:01:25 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     alexandre.belloni@bootlin.com
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] rtc: s35390a: Remove the unneeded result variable
Date:   Mon,  5 Sep 2022 09:01:19 +0000
Message-Id: <20220905090119.335121-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value s35390a_set_reg() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/rtc/rtc-s35390a.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index 81d97b1d3159..b18daaf72b17 100644
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
