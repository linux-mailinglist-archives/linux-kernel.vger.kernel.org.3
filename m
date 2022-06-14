Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAE654B405
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344244AbiFNO6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344238AbiFNO6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:58:11 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC13326FE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:58:04 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id c196so8803438pfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7/7Nun5DdQ8mGRCniPuZkv4R/MOUzVUJ7jdOPQL28kA=;
        b=i++0mW3x/3PtuwLNuag3xkdbQ27/xmLnGkFTjVmILQ6Z9WHR3vylL2jRCRnYHQsuGo
         z82HnoVX0koIj6WeEOvM54C9QUSyGORQnBBVmcaJEPGA4EqNI40EN+uTDB9c6dQAubs1
         LKqV7kBd55ZvY0WKseoyFHbLoWSBvThjfCsavIWXyOZFI9/PebDL+e9Z+1TqVvY/OqUA
         bXSZmFzK5MNJR71boI8luIBihuaNGsNo6BuFC2fIgUkJPCtbhq6FZrUXD2z19nid0TtW
         HIKVLxKHjA4fcuxuBj53GjbPq1BZHwD616kgO+U0bVgALetyd9l7R5m4KMGc70C2PJvP
         Se6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7/7Nun5DdQ8mGRCniPuZkv4R/MOUzVUJ7jdOPQL28kA=;
        b=D9G1V7Qe45ywjUNhluLbfrY2dh9pwU6EgGsry5is2vubMemrCIB9yIAH0CGY+s0IKM
         TwnaiiE8WQZOPfA3jBYYt0P5fH3d6aLiLVsn/qPQzYSsKczjVcyaS5yKPsa79KNrPYnU
         erE0SuTwxR/NBMawu8Zy5q1jWwQ6TQA6DHNlI/9ANmki0Kfk0Kh7q3raewKOTT9OQYNu
         M9lMDE654ibsulWY1W8ia4BFHl9vql1JB0NJbN7AbqT3isaHqpNXmTyXJVJmnrlFtWvc
         LdvJ+WcskcYWvbO4NMlWrGTWJZrAb8GLH6zX8jCYA0M7xsn0Lr4jLHFZZtYoF1vK4xDC
         WlxA==
X-Gm-Message-State: AOAM533b0WiEuosbupiK8qWS4YD76vGzVfJMGJ6XfJ1NaZM8MANypePD
        /hlRB7qLkwlFr5EFOBvUr7T4GQ==
X-Google-Smtp-Source: ABdhPJysBYTm7t4CZlSBOZ/3iSY7+3sbB6LXbEGkGEZVCE+DuMAmp6yPksJQGuPX++QxTvgpgi8MJw==
X-Received: by 2002:a63:8841:0:b0:3fc:6f1f:d11 with SMTP id l62-20020a638841000000b003fc6f1f0d11mr5006117pgd.498.1655218684265;
        Tue, 14 Jun 2022 07:58:04 -0700 (PDT)
Received: from n131-251-240.byted.org ([121.30.179.216])
        by smtp.gmail.com with ESMTPSA id g23-20020aa78197000000b0051bd9981ccbsm7627749pfi.39.2022.06.14.07.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 07:58:03 -0700 (PDT)
From:   Zhi Song <zhi.song@bytedance.com>
To:     vilhelm.gray@gmail.com, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhi Song <zhi.song@bytedance.com>
Subject: [PATCH] isa: put_device after failing to device_register
Date:   Tue, 14 Jun 2022 22:57:57 +0800
Message-Id: <20220614145757.1734996-1-zhi.song@bytedance.com>
X-Mailer: git-send-email 2.30.2
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

device_register() is used to register a device with the system.

We cannot directly free dev after calling this function,
even if it returns an error.

We should use put_device() to give up the reference
initialized in this function instead.

Signed-off-by: Zhi Song <zhi.song@bytedance.com>
---
 drivers/base/isa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/isa.c b/drivers/base/isa.c
index 55e3ee2da98f..cf88f3d77b7d 100644
--- a/drivers/base/isa.c
+++ b/drivers/base/isa.c
@@ -173,8 +173,10 @@ static int __init isa_bus_init(void)
 	error = bus_register(&isa_bus_type);
 	if (!error) {
 		error = device_register(&isa_bus);
-		if (error)
+		if (error) {
+			put_device(&isa_bus);
 			bus_unregister(&isa_bus_type);
+		}
 	}
 	return error;
 }
-- 
2.30.2

