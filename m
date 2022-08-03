Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BF0588A1F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237752AbiHCKGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237776AbiHCKGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:06:08 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1532AB1D7
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 03:06:05 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id 17so472919plj.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 03:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=N6470V84i8r/SrAbUOMPMzFLhAwImnUfo4s3+mmJyH4=;
        b=gIbeBO48HczBwJi8HhEhiZlbToMlHiOOoZJ/OiW7pomV3TCRTBIJFQek8ZQfpj8bdD
         6Haf2rdTJfq8QgglHWwURPMsF80Fw/7k3DdMkbG8Ul8vDmYN68blcn53jsfywQg5AhEw
         rVZiDEMDNxTj5ZHYNli3kUiEUXEQzk6YQYyigG80fN7BU3SOgL8dwQxupJRkyohV7Hj3
         /3ipKsYLv0Ccs0xzYfsu9YuYpJC/b2kwyR7oDx6/gXzPns/LzKz/64J0hR1ZEkf7ARAE
         IV/f9lRsZTgtCgxrOvsHw0fTO3SfZLEUokHTjt5RIypzKt6bGmoPYi6bGNIrgRZ6W7BH
         H2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=N6470V84i8r/SrAbUOMPMzFLhAwImnUfo4s3+mmJyH4=;
        b=DmC5TMZZjTBVZ01fQQw0DeI9O2daS1xCw5RSYpefOu0kFCAG1VWfRU9aTwcOfwonRX
         HKoOLJxk4Qqc+5gO2jUZoTlA7e7uXeswWEWbE+BnKAD5qh31e06OU7KnJqJx7Sa6RE5r
         rRsoMpxPqoa3lAJWq1oIBlgOvUhFkIzNAmToMjwCuxj6q8ALZlDZE3hCsFcoMMauipce
         KIhx77KoiMIEWtmj/yYetkGCVtxAEgKH837vWm4WTy95gWI3MkDVQypEbCxudWQKxAyg
         KVkjRI7gd4W9Poy3k23tL+05vEeiZRnbl1fZPTNw8U/xpGpklnweVQljf+uyGM1xqFSV
         MtKA==
X-Gm-Message-State: ACgBeo0HMK6wadc185QRY6HkCWj/G6EfKeE8INv5+jPlGRiao8+uCfeA
        9v7OGIyXnUhTct5dW0B3EII=
X-Google-Smtp-Source: AA6agR6ATn+tw5xU/Xs1DoivKBqKZJJ2fvM7DM7gwnYkVkEDKR9V5dy4GqCzUk4ZFQmpDss/ft05zg==
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id mw7-20020a17090b4d0700b001ef521cf051mr4171718pjb.164.1659521164547;
        Wed, 03 Aug 2022 03:06:04 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h3-20020a63df43000000b00416018b5bbbsm10809337pgj.76.2022.08.03.03.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 03:06:04 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.con.cn
To:     akpm@linux-foundation.org
Cc:     hughd@google.com, izik.eidus@ravellosystems.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, xu xin <xu.xin16@zte.com.cn>,
        CGEL <cgel.zte@gmail.com>
Subject: [RFC PATCH 4/4] ksm: show ksmd status of auto mode
Date:   Wed,  3 Aug 2022 10:05:59 +0000
Message-Id: <20220803100559.1653604-1-xu.xin16@zte.con.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803100306.1653382-1-xu.xin16@zte.con.cn>
References: <20220803100306.1653382-1-xu.xin16@zte.con.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

Add a sysfs interface of ksmd_status to show some details related
with auto-mode.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Signed-off-by: CGEL <cgel.zte@gmail.com>
---
 mm/ksm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index 78819b56efec..6417bc034a3d 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3070,6 +3070,29 @@ static ssize_t run_store(struct kobject *kobj, struct kobj_attribute *attr,
 }
 KSM_ATTR(run);
 
+static ssize_t ksmd_status_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	int len = 0;
+
+	if (ksm_run & KSM_RUN_AUTO) {
+		len += sysfs_emit_at(buf, len, "mode: auto\n");
+		len += sysfs_emit_at(buf, len, "auto_triggered %d\n",
+							auto_triggered);
+		len += sysfs_emit_at(buf, len, "scanning_factor: %u\n",
+							scanning_factor);
+	} else if (ksm_run & KSM_RUN_MERGE)
+		len += sysfs_emit_at(buf, len, "mode: on\n");
+	else if (ksm_run & KSM_RUN_UNMERGE)
+		len += sysfs_emit_at(buf, len, "mode: unmerge\n");
+	else
+		len += sysfs_emit_at(buf, len, "mode: off\n");
+
+
+	return len;
+}
+KSM_ATTR_RO(ksmd_status);
+
 static ssize_t max_scanning_factor_show(struct kobject *kobj,
 						struct kobj_attribute *attr, char *buf)
 {
@@ -3332,6 +3355,7 @@ static struct attribute *ksm_attrs[] = {
 	&sleep_millisecs_attr.attr,
 	&pages_to_scan_attr.attr,
 	&run_attr.attr,
+	&ksmd_status_attr.attr,
 	&max_scanning_factor_attr.attr,
 	&auto_threshold_percent_attr.attr,
 	&pages_shared_attr.attr,
-- 
2.25.1

