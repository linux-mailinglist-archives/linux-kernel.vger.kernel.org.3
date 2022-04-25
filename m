Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5CF50DB8A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbiDYIt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiDYIt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:49:57 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3764DE81
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:46:52 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id f22so9811985qtp.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RoUPIwUrpxEpqPERP6UMxnfciR7YsGll+EEgqVtfL+0=;
        b=CTnX8PQvIs3nVigjq23ejqFcuq2wGp98yn+dcVoXWE4csutcLPrB76JNjBvEt7pRwk
         7+zHfcI53HQF07OtIzvXtOMw5yHmlGRpzPfIQMVCOiOX/h/sPaxAXJg8K+PMewXVRmw/
         I4zT1KYZciezPWJnQFDIieW8YFtL/iQYQrGP5K4vYqYnuWE4ixUvoD5zxCOwBdKRuZED
         GcXC5yKlaHk0ZkW3tNiqk2w9BtsaiR7pwskphsdFnxCZKhXIAb5BsGsnrkjYSnx1jkLg
         Ru5ooSxOTER4x8qbiKCw2EEFECzs+YoWLRmc1MN6iYG7YpLFFZ353VcX1S1VVmGDGRwK
         wSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RoUPIwUrpxEpqPERP6UMxnfciR7YsGll+EEgqVtfL+0=;
        b=fqA4JetT1XSdcks1yxcM4K/kKLEGsp5mlSBQccO+mFFnTsn7wFqj4bZ+WmYn3D2qdo
         jxRqh75fm/IB2SAL+Ww6dCUI3Vq8i7+66y/axg7GYqvsHQtwWe6xIjIojRFL/R49G/E3
         RTM1sBbn6kUkU2pdBU0Mjag0pBLy+qLzoxEcq6K9O+z1obK8PmxF/NM0LaswGk+c3W89
         aAAV/KKFRvemHbYUja9U4rh4na4+qtKx9aYVpzVnuoS4MeAAmgAUojhsJJwmK6sINXRU
         uAGQZeWUOo+Qhwy/REaKaLfF3sl8puhwV9UL+ZfhVGPy6e2bove2RNGSMjBXAmPNINhZ
         vJtw==
X-Gm-Message-State: AOAM533WvLQ0m9F4TLreHatw/dUTaOfgWaeasHviBDWLDqA6CrD95OTL
        yVZ76TxQiHmGeqyIfLWZm5U=
X-Google-Smtp-Source: ABdhPJzjbo8Nynu7eyy/bMD0UTfv/3kGiC0iszLvZXyGM1qCt7rj7rWDmwSfBy8grDS7KxelgYbx6w==
X-Received: by 2002:ac8:5c0a:0:b0:2f3:4536:9bc9 with SMTP id i10-20020ac85c0a000000b002f345369bc9mr10850637qti.533.1650876412107;
        Mon, 25 Apr 2022 01:46:52 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s195-20020a37a9cc000000b0069ca29ab6f4sm4694760qke.26.2022.04.25.01.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 01:46:51 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     daniel@thingy.jp
Cc:     romain.perier@gmail.com, daniel.lezcano@linaro.org,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] clocksource/drivers: remove unnecessary return in switch statement
Date:   Mon, 25 Apr 2022 08:46:44 +0000
Message-Id: <20220425084644.3495153-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Since there's a return immediately after the 'break', there's no need for
this extra 'return'.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/clocksource/timer-msc313e.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clocksource/timer-msc313e.c b/drivers/clocksource/timer-msc313e.c
index 54c54ca7c786..fedcbcafd320 100644
--- a/drivers/clocksource/timer-msc313e.c
+++ b/drivers/clocksource/timer-msc313e.c
@@ -233,14 +233,10 @@ static int __init msc313e_timer_init(struct device_node *np)
 	switch (num_called) {
 	case 0:
 		ret = msc313e_clksrc_init(np);
-		if (ret)
-			return ret;
 		break;
 
 	default:
 		ret = msc313e_clkevt_init(np);
-		if (ret)
-			return ret;
 		break;
 	}
 
-- 
2.25.1

