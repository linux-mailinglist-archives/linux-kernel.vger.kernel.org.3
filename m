Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27B948BFCE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351565AbiALI0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351552AbiALI0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:26:09 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C3FC06173F;
        Wed, 12 Jan 2022 00:26:09 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id kl12so2146826qvb.5;
        Wed, 12 Jan 2022 00:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pbh5ugGG5kq9R4YZuS+0n/vxa77/z6ywPhYc5oCvdO4=;
        b=Dbrwl30rc18ddXksZxzqTaOOXJ4TNzfkxYMc2uYc2Ugjer5/KWsHDUbNEi/nv50jbM
         olumQiAikZKZLrOreMpnuHfeu53x22vTK1/zyby4LpM/aRR84Vajtmedblv9O82dyPZl
         9eEq0y3jPxLN7MWtzGlTUJdrUQ5ZJydyyuyy7cM2zItL0em9D/v+GF/Z1zltewx9fyd4
         hitMpX4z+CcZhX3dr9ubkYgeRxmiBNdiUKwtzhPD/qtAOc1YjraU6LXUnbqhGcpnxiVq
         EpGAeJ3LoK4QaGCc0NkrAxKxMl8JertF0CMVwzwu65TOuLUZXhul0lR/UdWZ8lAQkpv5
         nkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pbh5ugGG5kq9R4YZuS+0n/vxa77/z6ywPhYc5oCvdO4=;
        b=sUktfK02jDeYuvl7d379kzrT3WUPmMcB8WkqfS3EVu435a5f7/JdlGQBxfrLKKrE2K
         A1eNeFvQZL38XbNgAG2mcexMpV6tmsBSr1WUSKsDK8kfQDtJfE62qOdUpj471tXG7sGf
         r1WID3tr0KX3lDB05Ua9nCERXaxcXZMyFDWdEThWFgFLa6f42u4hCwrWwOYUG/yPTO8T
         VMJnkE0zv4V5SLmQKDIabS7fjNzVJ5NizCQFjFXpK4yeFx6fWuCh2pZtBTXWp7rRfaQ+
         D4KRetbMI6NVq8Nz4DgwXDy+vci5vuOgOjExYHcZ9juOGfi79Ff5w6iQHKU4cqn2Vnse
         fH7A==
X-Gm-Message-State: AOAM530+Wgeg/padVgPn522xXcHNV/snYCaBKgLgUIQ2OSGskppMactH
        eOcbkesaANzID00sTssAQXU=
X-Google-Smtp-Source: ABdhPJxtEv6GLFDvcdsmdwALswtJ+qKKnpARZ0Q9yOqVl4mpATzFlaYXZebsothDkHBKmzTUWwzACQ==
X-Received: by 2002:ad4:5ba4:: with SMTP id 4mr4008541qvq.39.1641975968220;
        Wed, 12 Jan 2022 00:26:08 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d199sm7854767qkg.25.2022.01.12.00.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 00:26:07 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] drivers/hwmon: remove redundant freq variable
Date:   Wed, 12 Jan 2022 08:26:02 +0000
Message-Id: <20220112082602.667614-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value directly instead of taking this in another redundant
variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 drivers/hwmon/w83627hf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 9be277156ed2..0feb581975cf 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -283,9 +283,7 @@ static int TEMP_FROM_REG(u8 reg)
 
 static inline unsigned long pwm_freq_from_reg_627hf(u8 reg)
 {
-	unsigned long freq;
-	freq = W83627HF_BASE_PWM_FREQ >> reg;
-	return freq;
+	return W83627HF_BASE_PWM_FREQ >> reg;
 }
 static inline u8 pwm_freq_to_reg_627hf(unsigned long val)
 {
-- 
2.25.1

