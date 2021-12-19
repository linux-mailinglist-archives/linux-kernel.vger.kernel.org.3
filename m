Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1034F47A033
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 11:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbhLSKWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 05:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhLSKWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 05:22:44 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53217C061574;
        Sun, 19 Dec 2021 02:22:44 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id i63so10943677lji.3;
        Sun, 19 Dec 2021 02:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UDj0bqfvRW0PUJOwth1byik65yNq/l4IKd71H+NRaHE=;
        b=F+z54Ip8WJ+0iKytMXzGSZxwmmjcXg779+r/AONkR6REROSrwp7oCye+MOHF7dsfPX
         u3BjIzrkPT445detkLdmzePP2KXwAIW6amQdwaEwV+0H6vBmwFAdEKFrU4kL87pWz3S7
         DAfbFwUm1q7n37n2GurbVQ8oIr8JXzs1hWeYjwq3v70ybukoMP4OHAku/ehI/YR4Ckh6
         jV5/PA8VPC7gM1A153YN7bkHl3j4FdiujNud0a3+/PwpfNhXti1eHlJVsmU5HhXkuvVu
         EKc3BQ4G7iOoIZws5PTRnv4DNW3z8txpOcNUYpKwKQe/J8A6vPQ4ohR7xsTc7bIEkUSa
         OmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UDj0bqfvRW0PUJOwth1byik65yNq/l4IKd71H+NRaHE=;
        b=eYfTKRSS29rNOpinJcAG+mvzu6Y3kG8qYT72FnRJKR57BwZIKp+9s5RHP4YkxrNYcW
         6SIlxVjXuPM60KHByKSW71dO2rqJm2two84tr1t6TIU1mvfXZuAfEM4MtsuwD/wOxdaT
         MIn2iNntaDaQZAPimYaazMlr+ojCU0iGjavf/RZPQq3zMcEliTBKvlWkWse5qPFP+qLm
         xKzarR7Yoa6I1Y7/J9xlDgAwZkA00mMHfnygcsxTaNSbGy+4AbXjYNzb02yqWhRRD92Z
         E1KnOVq4MkMdpQgOhe8GZ6DbfvWKdC1xZkqmBta76UYxfj6XHe93IeXpqp4Bu1pbe/BH
         NFSg==
X-Gm-Message-State: AOAM532i2ctSBtoujXhrkmn7Q7kyXYwz3wRPhSlrUYa+O88R+T09Oq4+
        HtdvnEIAJiy2YBIBe5jQ+bzys6MTtHiMKQ==
X-Google-Smtp-Source: ABdhPJw4CT5MITX4QqF1WRZxa7B7RFvURV53UZI73h8Q9AbIO0+fZt9AFo0yrWw8+z6UjnFZZznuZw==
X-Received: by 2002:a2e:80a:: with SMTP id 10mr10194727lji.337.1639909362289;
        Sun, 19 Dec 2021 02:22:42 -0800 (PST)
Received: from NB-893.corp.yadro.com (109-252-131-14.dynamic.spd-mgts.ru. [109.252.131.14])
        by smtp.googlemail.com with ESMTPSA id p21sm2007531lfu.142.2021.12.19.02.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 02:22:41 -0800 (PST)
From:   Arseny Demidov <arsdemal@gmail.com>
X-Google-Original-From: Arseny Demidov <a.demidov@yadro.com>
To:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        rahul.tanwar@linux.intel.com, andriy.shevchenko@intel.com,
        Arseny Demidov <a.demidov@yadro.com>
Subject: [PATCH v1 1/1] hwmon : (mr75203) fix wrong power-up delay value
Date:   Sun, 19 Dec 2021 13:22:39 +0300
Message-Id: <20211219102239.1112-1-a.demidov@yadro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the file mr75203.c we have a macro named POWER_DELAY_CYCLE_256,
the correct value should be 0x100. The register ip_tmr is expressed
in units of IP clk cycles, in accordance with the datasheet.
Typical power-up delays for Temperature Sensor are 256 cycles i.e. 0x100.

Fixes: 9d823351a337 ("hwmon: Add hardware monitoring driver for Moortec MR75203 PVT controller")
Signed-off-by: Arseny Demidov <a.demidov@yadro.com>
---
 drivers/hwmon/mr75203.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index 868243dba1ee..1ba1e3145969 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -93,7 +93,7 @@
 #define VM_CH_REQ	BIT(21)
 
 #define IP_TMR			0x05
-#define POWER_DELAY_CYCLE_256	0x80
+#define POWER_DELAY_CYCLE_256	0x100
 #define POWER_DELAY_CYCLE_64	0x40
 
 #define PVT_POLL_DELAY_US	20
-- 
2.25.1

