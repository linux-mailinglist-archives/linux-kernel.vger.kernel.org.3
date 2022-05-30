Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD0253790C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbiE3KPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbiE3KPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:15:39 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6B57C14C
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 03:15:38 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id i18so10178889pfk.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 03:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dSIId2jwQ4+fUi86yIerIU/RtvrjvP8+8HeoM/mBGE8=;
        b=SjxfIl9RebcUiS1Zk1I09TdKR6wyANZYTIiZ6mdDZ797nms0DJexF9pVaGGCNW7gEh
         iF9nHDOx/hNYuJYeDzSfTjqWCHPo7UtBo+L6YX+5Mb6I2gz2Pvk3iPODz+jz8yRwHDFW
         bJhbDQ6cXk92AaQiDs7QQDa2HSqQcpkxMFRpnZmU08JZIP61sgXByYB7U3NNltcy/l6f
         PgqeyHdo4mvBI57wSOQGY0IGKVF7cGrqg7lswurjilm1nlV0KeDp9A6v7VqbL4ISN1t6
         LGsAaxMejmMC23BHj7WEnwTVP75R9g6SWm3edb7QeZ60PhNMaAC4z/emv7F4j/FlWXly
         lZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dSIId2jwQ4+fUi86yIerIU/RtvrjvP8+8HeoM/mBGE8=;
        b=5CzBFxM29dtbFULEL2zYUDHK9i56P0Tnng5XJr4TBGwVFv7ARqdZwg2ialaAeKkbw2
         RA2TU4WCYlzbig24ebJFShhra3VHXAS2YAJFrPRx4+sBiMPl7xQjb8qxHB3irYuEv942
         cRAPANwGUI9GR0HRQhek5eDo9ZGL0wAdyJoQ+Zs+I7NlJjPo+nsi1wqPNe4BYlRtGj/Q
         cjH98D+cQATljdImKvtmhzDKAdIczhDMrTP5LUf9N37V7xG5mDjnxo/tW2ZpFz30HDd0
         VqluszARpZZubx6s1jVcZmCSLltkEaclOozHue1Z852OoAzxAaXac2hE2MfkYzryrxI7
         0SCA==
X-Gm-Message-State: AOAM533YyNJnZgu7Ffw3IbYk8kJ2u0U6vLc0DsuNsWH+wIo321hPfeKh
        GTD6sg3k0DTRpwr1qGV88TG9Y1a/WwI=
X-Google-Smtp-Source: ABdhPJzYpOwc0bhssxkzw8xrYfOr4/qVMRe4DnIkCmHsOXhO/fad+aV1I0j8LYhcv7X4GNI9ZY2FGQ==
X-Received: by 2002:a05:6a00:298c:b0:518:afaf:f7cd with SMTP id cj12-20020a056a00298c00b00518afaff7cdmr35645564pfb.23.1653905737667;
        Mon, 30 May 2022 03:15:37 -0700 (PDT)
Received: from RedHat-Sangam.redhat.com ([2401:4900:1c2d:a0bf:bf5f:bf5f:7aee:cfb0])
        by smtp.gmail.com with ESMTPSA id a5-20020aa780c5000000b0050dc762816dsm8463329pfn.71.2022.05.30.03.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 03:15:37 -0700 (PDT)
From:   sababu <sangambabu1@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     sababu@redhat.com, jmaxwell@redhat.com,
        sababu <sangambabu1@gmail.com>
Subject: [PATCH] Qperf support for ipv4 when ipv6 is disabled at protocol layer
Date:   Mon, 30 May 2022 15:45:31 +0530
Message-Id: <20220530101531.173447-1-sangambabu1@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sababu <sababu@redhat.com>

    With qperf version 0.4.9 we defined AI_FAMILY as AF_UNSPEC, starting
    qperf 0.4.11 the same is changed to AF_INET6 which causes issues
    when ipv6 is disabled at protocol layer (as a kernel command line
    arguement). This patch reverses the behavior.

Signed-off-by: sababu <sangambabu1@gmail.com>
---
 src/qperf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/qperf.c b/src/qperf.c
index 89fe5b8..4de0cce 100644
--- a/src/qperf.c
+++ b/src/qperf.c
@@ -1418,7 +1418,7 @@ server_listen(void)
     AI *ai;
     AI hints ={
         .ai_flags    = AI_PASSIVE | AI_NUMERICSERV,
-	.ai_family   = AF_INET6,
+	.ai_family   = AF_UNSPEC,
         .ai_socktype = SOCK_STREAM
     };
     AI *ailist = getaddrinfo_port(0, ListenPort, &hints);
-- 
2.31.1

