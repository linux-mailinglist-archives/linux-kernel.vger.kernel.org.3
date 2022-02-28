Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EDA4C6577
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbiB1JMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbiB1JMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:12:05 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89806663A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:11:26 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id iq13-20020a17090afb4d00b001bc4437df2cso10812920pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OeLL4lKnmthZzGm3Ht7K/jZBXOToEYNqwKUWhC0cZkM=;
        b=JJboFRW5+9vbH4s42UCtdyOxHWzZhonlIhJ6g1jD0UYKsbrVBUVFCNhmvskYHId9mx
         uLfZQRqrQwUShj+52TBQzYbqxo1M1wsxlbSW/3qWC72OC3HHqP529ZUZjwG8Acywm7qa
         JNlUK80XGWpFVzOxv+HEELDK6Mtidd3tljLagQcv27qBbfqHTmZ5nZc5bQus6urAIL8n
         XSY068EwonQywjy4hIrLBiVdEMf3Dx0GVQ49c7TydpoBC7z5LNgVSEM8Vx08zHmm/WzE
         vVby2/1Llqv8xMHYbMW5NkIKTcp++triDH0tZrLfxYu1jCgholbbK+8BiwtdW1eUdEa2
         Bkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OeLL4lKnmthZzGm3Ht7K/jZBXOToEYNqwKUWhC0cZkM=;
        b=Qb4zVvIgtE0UsoknkiysncTjaXLcrA2wYcleS+RQ8kcQE6VILPKP05tKQ5FOY/yWBD
         1WUJ25BCk2RNNjCr89/dL8y4smnHwJ1pwWqUuR1s2vtEz6HnlSYswZwa6OI2KqpsMTr5
         /nucD2NdaUDuY98teVWbKNCtp1NwUuZOAKFYqgjH08wBrLgeXqo0NPyJ8V6+DIQkZ1ae
         e6aqDh+9eSU2MUJ/rZn8MR+TXVu5OuizAhH6AvJhtsfRPxBSHspD5ZRrgxdeVB3G1ix9
         YrBoli5F18vUsHY7BEzYTdvrpAZXJATZk4rmZT1o1memN0APdeR+A1l2lUjdIJZrha40
         W6ng==
X-Gm-Message-State: AOAM532k3UE3OGrC1JxB8yZxflvrHlNc2+LdyiCKD663mSNCurxQV21A
        oa/BsNvXfiQpoXSYqjBXsGAI9M0tbe4JF9jM
X-Google-Smtp-Source: ABdhPJw3rr4qT1Ye/wOojFetibRRFcKxLJTBeXNycqhdvhVfvn9KNcvskoTRkjWIH6g78qbp4eYMAg==
X-Received: by 2002:a17:903:32c3:b0:151:58b1:adf8 with SMTP id i3-20020a17090332c300b0015158b1adf8mr7597373plr.29.1646039486284;
        Mon, 28 Feb 2022 01:11:26 -0800 (PST)
Received: from slim.das-security.cn ([103.84.139.53])
        by smtp.gmail.com with ESMTPSA id bo10-20020a17090b090a00b001bc8405bd55sm16622829pjb.30.2022.02.28.01.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 01:11:25 -0800 (PST)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] powerpc: kernel: fix a refcount leak in format_show()
Date:   Mon, 28 Feb 2022 17:11:03 +0800
Message-Id: <20220228091103.39749-1-hbh25y@gmail.com>
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

node needs to be dropped when of_property_read_string fails. So an earlier call
to of_node_put is required here.

Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 arch/powerpc/kernel/secvar-sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index a0a78aba2083..cd0fa7028d86 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -30,13 +30,12 @@ static ssize_t format_show(struct kobject *kobj, struct kobj_attribute *attr,
 		return -ENODEV;
 
 	rc = of_property_read_string(node, "format", &format);
+	of_node_put(node);
 	if (rc)
 		return rc;
 
 	rc = sprintf(buf, "%s\n", format);
 
-	of_node_put(node);
-
 	return rc;
 }
 
-- 
2.25.1

