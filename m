Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85B24B4308
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 08:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241442AbiBNHig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 02:38:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiBNHia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 02:38:30 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239264F47F;
        Sun, 13 Feb 2022 23:38:23 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a8so35538447ejc.8;
        Sun, 13 Feb 2022 23:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AVMu6NN3biChFR5UuxImcxGSWWGJG/KG7InEx8tN/zM=;
        b=IPJ5L/Gd4eaUTATgSsFFcNgdogHy+3PeWddDTcM6RMYnTojO8nmAYe7DljsIrAzQi7
         i6Xq60F/Pxt9k7ZOk+UNVayYR5d+XRZEWfTHX4xqxF3NJeSWi2Ba3sXXw1T2vMJ7P/k2
         0q2yOtYrF0KsL7CqQ1tilLcKdjZIOlRwwrbAdhBQlaBN67Jsh/4AXatn4i/PS4Q8JaFZ
         Xk3o5MhHB45kSupMfzS4bbVM4XeZWBRsDr4HHvKhy1mvgFGUlCXpGbj9MqsOOg7mNmyh
         HqHuq3rMqOhyQH6KQejnupSrrDv7sThFB11ck/fYmCvMTihbse0366OMsDRigwHyLm1L
         hK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AVMu6NN3biChFR5UuxImcxGSWWGJG/KG7InEx8tN/zM=;
        b=NrhgAzS/DQ9i9Op8MsYy93b2x4qVyGVfvI4wlpRtl35B9dirrCUJjbOiVZ525TfPS2
         4n8zVAXU5ufgkC0a3TWgX1K29fNFSEcW8+nlzxrz56OCW5V+4RT+5ZhInVcxpEMXzX34
         RjstpmJhYH8NgPWiqfwFE1R+4tXMjHINKK0+9HgadoGry82xKYmBgmT9CdUfsRge8o6s
         GMndHts+ODkHV+S1oAtI0FXO5XBmdMsFciDAsus1+O84pxKKRR/47ZtjFmwHeZ5siq2y
         NmDkny7ZpWgk3sPOBV6XRbXEjoGHyYo5bIG+mgj6N+mO72suMcxjkSNxQ4hxvq+BSxeJ
         JV9A==
X-Gm-Message-State: AOAM533HfKq3ustlt7jyAABbc9XzrbQSHLpwG3WHoZfi53Q0vFqJ0dsA
        GOg97vPZY2jbq2/l2l6Dcdg=
X-Google-Smtp-Source: ABdhPJyLQdlZaKqPwB9HMGZNonoU8F290JfXnTh8DZkkz1YHIEXvNVVeuSBR8STeaI9T4YvrnHaKgw==
X-Received: by 2002:a17:907:970f:: with SMTP id jg15mr10393921ejc.705.1644824301740;
        Sun, 13 Feb 2022 23:38:21 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.58.131])
        by smtp.gmail.com with ESMTPSA id 9sm2480065ejd.184.2022.02.13.23.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 23:38:21 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/5] iio: introduce mag_referenced
Date:   Mon, 14 Feb 2022 09:38:06 +0200
Message-Id: <20220214073810.781016-2-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220214073810.781016-1-cosmin.tanislav@analog.com>
References: <20220214073810.781016-1-cosmin.tanislav@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some accelerometers that support activity and inactivity
events also support a referenced mode, in which the
gravitational acceleration is taken as a point of
reference before comparing the acceleration to the
specified activity and inactivity magnitude.

For example, in the case of the ADXL367, for activity
detection, the formula is:

abs(acceleration - reference) > magnitude

Add a new event type that makes this behavior clear.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/iio/industrialio-event.c | 1 +
 include/uapi/linux/iio/types.h   | 1 +
 tools/iio/iio_event_monitor.c    | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index d0732eac0f0a..ce8b102ce52f 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -230,6 +230,7 @@ static const char * const iio_ev_type_text[] = {
 	[IIO_EV_TYPE_THRESH_ADAPTIVE] = "thresh_adaptive",
 	[IIO_EV_TYPE_MAG_ADAPTIVE] = "mag_adaptive",
 	[IIO_EV_TYPE_CHANGE] = "change",
+	[IIO_EV_TYPE_MAG_REFERENCED] = "mag_referenced",
 };
 
 static const char * const iio_ev_dir_text[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 48c13147c0a8..472cead10d8d 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -104,6 +104,7 @@ enum iio_event_type {
 	IIO_EV_TYPE_THRESH_ADAPTIVE,
 	IIO_EV_TYPE_MAG_ADAPTIVE,
 	IIO_EV_TYPE_CHANGE,
+	IIO_EV_TYPE_MAG_REFERENCED,
 };
 
 enum iio_event_direction {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index b94a16ba5c6c..2f4581658859 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -68,6 +68,7 @@ static const char * const iio_ev_type_text[] = {
 	[IIO_EV_TYPE_THRESH_ADAPTIVE] = "thresh_adaptive",
 	[IIO_EV_TYPE_MAG_ADAPTIVE] = "mag_adaptive",
 	[IIO_EV_TYPE_CHANGE] = "change",
+	[IIO_EV_TYPE_MAG_REFERENCED] = "mag_referenced",
 };
 
 static const char * const iio_ev_dir_text[] = {
-- 
2.35.1

