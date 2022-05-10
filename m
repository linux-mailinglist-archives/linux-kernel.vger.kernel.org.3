Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D6A5212E5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbiEJK70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240550AbiEJK6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:58:46 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAC369CDF
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:53:07 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id x18so16403867plg.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sCueAiZ8pX86I1R/1I9WgSZcskWDRYR0Da8bJxkVfcs=;
        b=IPa6eL5aJa33heazIEv4jx+xlu5moXTQqaUnxxLpqMDpO8aGZZD8fYVApyYetHOyGg
         Kharz/D0Y90BOeII9ErtoiT1nAzQbr+8/uZ+6IiEh9YCcWBwJ+2Bk4lCLuoJZkd/Ueu0
         lXjBAAXZ/99vy2K6naeDpByfcz/54J8z2Tewefk6W6DpoOqXCsWEa4Hx7cVcQ1g5augC
         n221LoIraRQuX3oIIXRi0qYNUbr/1wANb6rJLLG+0kliVfQnXIMF8LACB2MLXuVkqP0g
         uFYLpxfj54oSbzV0x/AcbNRyjII4LdWqomR7faogAhyo2Znt0R48C59yLNK6e7PCHygm
         2rvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sCueAiZ8pX86I1R/1I9WgSZcskWDRYR0Da8bJxkVfcs=;
        b=EAXWiVhtisGG0+VZadVa8FgOKjpf89BW+RVAc93xuzSnCaBN70uuGkdbV9XzXE88aM
         5AW4s0VxCMnfnZdMQYAVnrCOZvF2QlwmZ2uieaCwbCZHdvLkuP+s8GJcWzuEI0y3b2+R
         QOKxI7YseQj1FIwDGTVc/gUoi6e8BLOExEa7ENhsMMZUmjWYzGtgMAbPwSZ/1rmH5AKT
         XNEZlObqOOnP+PzNl07d4VKFX5jHNEXUEKc+RBAmFrs93G4VlWGeBX4pF5n87RFIQShu
         eRP/CZ0lutE1YTC6XTT3+5XmfPoWPeh7cUcPtYTgh0Zm8qVPhHLI4NFT5t4+hji0pQr8
         8B/Q==
X-Gm-Message-State: AOAM532oBZ49TtZ58e8nRFCnMFmJNvfMe02xak3rHAArXGXCLc+uWH3Z
        seYL5S/vlIZUcF3Ik+yy0HM=
X-Google-Smtp-Source: ABdhPJx67ZlYTKYPHWjl22QUBHOCM+xy2RlMtychZuLoqjEZdoH+ht0H5OxHxYMrQPiy2NvxpAKV5w==
X-Received: by 2002:a17:902:70c3:b0:15e:f8ef:67b5 with SMTP id l3-20020a17090270c300b0015ef8ef67b5mr15377289plt.115.1652179987322;
        Tue, 10 May 2022 03:53:07 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a3-20020a1709027d8300b0015e8d4eb2ccsm1651840plm.278.2022.05.10.03.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 03:53:07 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     kbusch@kernel.org
Cc:     axboe@fb.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] NVMe: use kobj_to_dev()
Date:   Tue, 10 May 2022 10:53:03 +0000
Message-Id: <20220510105303.1352342-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Use kobj_to_dev() instead of open-coding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 510e3860358b..48d2bb0a4fad 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3267,7 +3267,7 @@ static struct attribute *nvme_ns_id_attrs[] = {
 static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nvme_ns_ids *ids = &dev_to_ns_head(dev)->ids;
 
 	if (a == &dev_attr_uuid.attr) {
@@ -3572,7 +3572,7 @@ static struct attribute *nvme_dev_attrs[] = {
 static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
 	if (a == &dev_attr_delete_controller.attr && !ctrl->ops->delete_ctrl)
-- 
2.25.1


