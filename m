Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE3447808E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 00:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbhLPXbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 18:31:31 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:35663 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbhLPXb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 18:31:29 -0500
Received: by mail-ot1-f54.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso808839otr.2;
        Thu, 16 Dec 2021 15:31:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4CeoqAJqaVjfhKA4w5q6EV5uHP8MjvTT5rLWnYTWgO0=;
        b=OSr7yUYVmK7GKTzU/T7h4QIK+aGPZLZmhGynfzOquyxIklaFd2bhDAIHdEwgPeE62d
         bhvfC5qMdwIphsP8D7SH08peyxnBpscA9iaLSAgtSgleLU9Pmr7X3oBkur+vDo54s/1m
         ple9Da+GBcpS/ofajLoUnRotflgBAiLW4W35LCgT7Hj7dmISV28VV/w4jrakiSXJGdoT
         waR+s/pJ8+7Woakz4vOsjtiem52SQTIHva0u5WbGjAFgmujKMzubgk7nWTn5rD9O9FKo
         XN85+wD8gRBX1vDXa0RWuTdfJSJ9nenf5zTs0wLlA/yJCPrMXqAQJk5OhFdJ02jhQ9f8
         BADQ==
X-Gm-Message-State: AOAM531yDyObYxaCzpmukX1B4Tl2S22Ffkwuo+1vGk9i+XXJojSTpG4y
        7ebbpRIfNiyhoh6rs+9sLw==
X-Google-Smtp-Source: ABdhPJyRWgdmPmwqOixG+a/R4k7YU6rVBoJiG5qt9epniQEIzD8xrctDnOgNQDBQZkPK0EiqPA6Tqw==
X-Received: by 2002:a9d:7cda:: with SMTP id r26mr329913otn.5.1639697488458;
        Thu, 16 Dec 2021 15:31:28 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id n11sm1256646oor.9.2021.12.16.15.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 15:31:27 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 1/6] cacheinfo: Allow for >32-bit cache 'id'
Date:   Thu, 16 Dec 2021 17:31:20 -0600
Message-Id: <20211216233125.1130793-2-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211216233125.1130793-1-robh@kernel.org>
References: <20211216233125.1130793-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to set the cache 'id' based on the CPU h/w ids which are
64-bit on arm64, allow for a 64-bit bit 'id' value. The only case that
needs this is arm64, so unsigned long is sufficient.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/base/cacheinfo.c  | 8 +++++++-
 include/linux/cacheinfo.h | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index dad296229161..66d10bdb863b 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -366,13 +366,19 @@ static ssize_t file_name##_show(struct device *dev,		\
 	return sysfs_emit(buf, "%u\n", this_leaf->object);	\
 }
 
-show_one(id, id);
 show_one(level, level);
 show_one(coherency_line_size, coherency_line_size);
 show_one(number_of_sets, number_of_sets);
 show_one(physical_line_partition, physical_line_partition);
 show_one(ways_of_associativity, ways_of_associativity);
 
+static ssize_t id_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct cacheinfo *this_leaf = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%lu\n", this_leaf->id);
+}
+
 static ssize_t size_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 2f909ed084c6..b2e7f3e40204 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -48,7 +48,7 @@ extern unsigned int coherency_max_size;
  * keeping, the remaining members form the core properties of the cache
  */
 struct cacheinfo {
-	unsigned int id;
+	unsigned long id;
 	enum cache_type type;
 	unsigned int level;
 	unsigned int coherency_line_size;
-- 
2.32.0

