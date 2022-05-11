Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694D9522EC7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237507AbiEKIy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiEKIyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:54:53 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A207B23276E
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:54:51 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id v11so1413318pff.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wistron-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=um6Mtxj9hn6MLF0/DG+dua7GL3nWe8jP1xt8gG30nLY=;
        b=oWFC3+tjFWuEzvrTD6PLpUDog2crstg0UDDK7T5h63Ev/TycWAdosWnW3B8xZx+Ii9
         pXeL8gStKi3H726nItUKPwvf3bK6BqVfeAR9w9JpaHikJk4HmVr+RQuzq9FsK+QOATHZ
         +eX6J+/X1EQF9VA6fWroiYEy7V9q4n40m6SMq+1qYQbd/uo9IY1IjAGYhXzBv/P40oaU
         u6bcuxKjUiLb9ElQ3gWbpPVaH9/ZMDvJ12XhEut73/QxTQr9p5ah/H5v/OTUvKhQ+X7e
         6rUc6LGrU4YtZcS05UjWlmL8Jq9rmLiDaD20TIO7VfNzVLUr6Q5kfzsx5oQiU6Ou1RSv
         tNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=um6Mtxj9hn6MLF0/DG+dua7GL3nWe8jP1xt8gG30nLY=;
        b=PfutLXbaAZMozuDLNVCw77anmZhahe/DWDMs3gUcl7R517ki/5NwedwHjBTgiIZ6E/
         v8INJj7KVBg2+2I9bujwrw66Nn3QiExIy6H8UXKUytx8L2aciwZZdn2lDmXIoJb2xtyE
         NTWWuGHifLu/dbYmZVEFeQKx4iZFrnaJpGtoSsswFqMb+aHNiD6++IFw89lzY21fE5XT
         Q5DnuZx4mXsJKBLjM4XciuUmIlOpObrTbmdUFx5mCf+gcSzHXfLFeFJYdb+0QlxOIUnl
         GRv35Jfm3wzfl7l3WA0YA+Yb9O/t4JQu6MFMdq+9Ye8nWx/ZuqyZ1BBp0WRGvx847AMS
         xdRw==
X-Gm-Message-State: AOAM531JY1SvDLRQZn5hUfQAZYl1kObLaDsLwGfBocUsEwLE+HLUbh5Y
        2aN/6nHoRY/r+sdssIHS9ifN6g==
X-Google-Smtp-Source: ABdhPJx/bnrxyo+MiOlZiVhC8KX3b6hkIYIcaQnvbU8nuJP5jgO8L6bFg7hbYAuoTjK+jW0KjksrZw==
X-Received: by 2002:a65:6297:0:b0:3db:4820:2867 with SMTP id f23-20020a656297000000b003db48202867mr239308pgv.503.1652259290924;
        Wed, 11 May 2022 01:54:50 -0700 (PDT)
Received: from localhost.localdomain ([180.217.250.247])
        by smtp.gmail.com with ESMTPSA id e2-20020a056a00162200b0050dc7628136sm1118590pfc.16.2022.05.11.01.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 01:54:50 -0700 (PDT)
From:   Scott Chao <scott_chao@wistron.corp-partner.google.com>
To:     hverkuil-cisco@xs4all.nl
Cc:     mchehab@kernel.org, bleung@chromium.org, groeck@chromium.org,
        scott_chao@wistron.corp-partner.google.com, zhuohao@chromium.org,
        linux-media@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: platform: Add moli to the match table
Date:   Wed, 11 May 2022 16:54:42 +0800
Message-Id: <20220511085442.23915-1-scott_chao@wistron.corp-partner.google.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Google Moli device uses the same approach as the Google Brask
which enables the HDMI CEC via the cros-ec-cec driver.

Signed-off-by: Scott Chao <scott_chao@wistron.corp-partner.google.com>
---
 drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index 8c8d8fc5e63e..25dc7309beab 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -217,6 +217,8 @@ static const struct cec_dmi_match cec_dmi_match_table[] = {
 	{ "Google", "Fizz", "0000:00:02.0", "Port B" },
 	/* Google Brask */
 	{ "Google", "Brask", "0000:00:02.0", "Port B" },
+	/* Google Moli */
+	{ "Google", "Moli", "0000:00:02.0", "Port B" },
 };
 
 static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
-- 
2.36.1

