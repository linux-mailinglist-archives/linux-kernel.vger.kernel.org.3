Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B324ED184
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 04:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352462AbiCaCIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 22:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343905AbiCaCII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 22:08:08 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA4C62BDB;
        Wed, 30 Mar 2022 19:06:21 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w7so17887184pfu.11;
        Wed, 30 Mar 2022 19:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cH7JNBCCv3j747fUAlfa1CjtA4Hwk1Fl0PpjFB6cQa0=;
        b=ItPPzp3rxb6pYI3ni0M+/f8QK7UM1rEnwyHoNKvlTe0Gx4p3c4dL7RD1j4WTjxTwFI
         Zzcf6X4ebYVMtrrP09KUvfr1kFkbv0cGWWFz/wesiTdyf3XUMPUe2f1SCqePjQnHFEOj
         nAiR5NV16b8tV8g3/9tBXQSiuof3a25mDPN3G4+MMDCfbfQ8x7rM+JYscK+AcyLI1ltj
         0L2IcIs5fRbsKFNS0kPJcgnKFYXSGQEAF4bk/ZFfmZAVQXd7wlVbOE7M8ukB5nuKXTYV
         2FV+JShxWan3onVUiW99wkjAEcNjqYfqtQTTv/MRgeSNAY4ExWzIgxCwMIdtg+puVPMj
         WqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cH7JNBCCv3j747fUAlfa1CjtA4Hwk1Fl0PpjFB6cQa0=;
        b=2J5vLy2ZSXar3RwoT31NppeTX+uBkUo2vKbIkAmM69ndlZ6wWT/g/Vb1gbu4xR6nYh
         teY8wt5dPOMU/BQiiukbj7PEPzBe3U5eOMPFdxqYq5IFqJdu40R+WbHERHdfqr9SpSD7
         3V3QV1U1UAN9yArma1nS17vG5zBVi7CJJbreSbo5855sbx8uTWnw3SIvTJn1DwM1l2PZ
         lRQHYAV9Fw9QfVH03fwrK7E9StjdHwXnI6F0b6AsdPsJxg+6Cz8HOM4Hx/PXE3n57uqK
         9QyLWjFH6MhvvvR2Aoy/XEgpvzfIGK8r+HJ2rKH80w+xOQE973PtHiiPVTRRu6yr+rtc
         +57A==
X-Gm-Message-State: AOAM532BoePfiyWh9vAjWlXay3i1UyiYfUuCWPH2tX7N/LvmJ3ga1vmm
        vL+uJyZ8q+OqS9uabAAgcBA=
X-Google-Smtp-Source: ABdhPJykqlSJrqaZgcsLgTsfjTVNpTPTIYDNK1tlAtVIRp7w/JOb2tzq4jmxvMdjiw5Hgx4+b/YGYQ==
X-Received: by 2002:a63:54a:0:b0:382:1d72:b9e5 with SMTP id 71-20020a63054a000000b003821d72b9e5mr8615841pgf.468.1648692381225;
        Wed, 30 Mar 2022 19:06:21 -0700 (PDT)
Received: from slim.das-security.cn ([103.84.139.54])
        by smtp.gmail.com with ESMTPSA id m15-20020a638c0f000000b003827bfe1f5csm20062061pgd.7.2022.03.30.19.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 19:06:20 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     sakari.ailus@linux.intel.com, laurent.pinchart@ideasonboard.com,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v2] media: mc: delete redundant code in __media_device_unregister_entity
Date:   Thu, 31 Mar 2022 10:06:06 +0800
Message-Id: <20220331020606.11877-1-hbh25y@gmail.com>
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

media_gobj_destroy has already set graph_obj.mdev to NULL. There is no need
to set it again.

Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

v2: Remove an extra newline.

 drivers/media/mc/mc-device.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/mc/mc-device.c b/drivers/media/mc/mc-device.c
index cf5e459b1d96..585816e0901c 100644
--- a/drivers/media/mc/mc-device.c
+++ b/drivers/media/mc/mc-device.c
@@ -604,8 +604,6 @@ static void __media_device_unregister_entity(struct media_entity *entity)
 	media_gobj_destroy(&entity->graph_obj);
 
 	/* invoke entity_notify callbacks to handle entity removal?? */
-
-	entity->graph_obj.mdev = NULL;
 }
 
 /**
-- 
2.25.1

