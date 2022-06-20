Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A39551036
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 08:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237951AbiFTGVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 02:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238645AbiFTGUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:20:50 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1847BDEDC
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 23:20:50 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id z14so9447968pgh.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 23:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wF1ARpvq25w7RuFa8seAqSZFDm59he3VhlAQIakNsJ8=;
        b=oof+xGwuBo9zlqgXnsDiErvFdrJlgxbaroYGmVAzIxvK1MTtT+9cegxq9gCnDMEjBm
         JO/41SWIVE2vzyo4Jrzsvq3KeKe3yoAZinwLPUdtBZIVwcFwmUnHu39k5iFiXEaL2QR7
         2/RjeVZ97Ii9IDkauIu/z1I8kFQmqK2Qtu/RPcjLtsY8BZOQWFnrndfLQwprPlLqtxrM
         vt4OfschuCeP/VEJrIWDzOnV/uXHYcy0mtFG/eftm+ekrQO7lMhU3aubK8iNiB+kSdlj
         ycHTzPvbxsE/IDSWiyNJURKRo+JoM6yhmR5ntWvzLJ/kLZYS58oV1toBZ0Bo8FqqCbsr
         PHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wF1ARpvq25w7RuFa8seAqSZFDm59he3VhlAQIakNsJ8=;
        b=0HZeZs+A2cXTYi86s9B6nhvNG/3M0TLD9xn1inBhOgFah6iQkyK7AVKiXo04EADOX3
         agiS693vVk0SWN0vyEmoAjzUN1j3eQAagMNJI98ZTO6qAWDrY5O4leJ0jfbuPFDApBiX
         8+cFZCWp/k/xv9aZ8NehoNdP3iRiOq/ifEr6OlZzHJVroqXMZhCZ9wxiiJU9ddDsdpv/
         5SXZi4hpefBpYfwElqmtvs8LnDECuyTNcYkb412ot6P82aGnaU49VFltmvgN4LwKmoJn
         5iwBFuyacCYCpHVomPmiIRduAWdi8l6Y9D0K/2FYmmP7M24UXGYeMQhul8bJSUN2X8WX
         SJLA==
X-Gm-Message-State: AJIora+C77FK41brW60uKMeBYJDo+L9PuKv7DxOHDbI0hgzC2SXwnf7C
        fIXO24e6dtKTnQsWDWudBl9C/M3in7I=
X-Google-Smtp-Source: AGRyM1sb4gdHygKceX4DZqzx+OUq4PvdwVgwyaAhJCp0z7FDFFq+ikMoip/qMioBzXkw43EUHK5WDQ==
X-Received: by 2002:a63:2b12:0:b0:408:b4d9:4274 with SMTP id r18-20020a632b12000000b00408b4d94274mr20142992pgr.439.1655706049642;
        Sun, 19 Jun 2022 23:20:49 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id p13-20020a63950d000000b003fd9e4911f9sm8010469pgd.31.2022.06.19.23.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 23:20:49 -0700 (PDT)
From:   Zhang Boyang <zhangboyang.id@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [PATCH v3 4/6] rslib: Fix kernel-doc style for rs_modnn()
Date:   Mon, 20 Jun 2022 14:20:13 +0800
Message-Id: <20220620062015.15612-5-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220620062015.15612-1-zhangboyang.id@gmail.com>
References: <20220620062015.15612-1-zhangboyang.id@gmail.com>
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

This patch fixes the style of kernel-doc of rs_modnn().

Signed-off-by: Zhang Boyang <zhangboyang.id@gmail.com>
---
 include/linux/rslib.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/rslib.h b/include/linux/rslib.h
index cd0b5a7a5698..e92923fff3bc 100644
--- a/include/linux/rslib.h
+++ b/include/linux/rslib.h
@@ -107,7 +107,8 @@ struct rs_control *init_rs_non_canonical(int symsize, int (*func)(int),
 /* Release a rs control structure */
 void free_rs(struct rs_control *rs);
 
-/** modulo replacement for galois field arithmetics
+/**
+ * rs_modnn() - Modulo replacement for galois field arithmetics
  *
  *  @rs:	Pointer to the RS codec
  *  @x:		the value to reduce
-- 
2.30.2

