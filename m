Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF7F51F1CE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 23:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbiEHVZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 17:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiEHVZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 17:25:47 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB48E64F3;
        Sun,  8 May 2022 14:21:55 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b19so16966128wrh.11;
        Sun, 08 May 2022 14:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iX+5Jc2rBzWBZS5PHHZcSGkidLaVy9RRBK1X3Ez2/O8=;
        b=Sx0x3tuqDNRY4wuNNNG6oNFM7QqWpxIs7L0kMWbtVyrli8zh2rm55fN8VwLcKyg0Gb
         l3KewF73FZjPO/QqKF/nL0erOhLJOfho6inZNdUpHRBU/JhXe4VBC+Mx7l82robY2VUN
         BucBCnlPYJYrE7MXVASe1rIE9wIkaYSS3wH/NPAhO98MWlvgzKHWYgvxUvCHtOidxPHg
         oDGvRFyxWw/P8g87Wj40dVxaxiVFxeDKfPLWmxHtJQCY6Lgm8AzUlL1tLKZ4TTMiP5Z2
         euFMy60VMtqdkIz9kmZXYtXNjM+JBP4SyB5mJhS7vK83A5UrvuPBDc0TPmMyAWK9ECN3
         6x/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iX+5Jc2rBzWBZS5PHHZcSGkidLaVy9RRBK1X3Ez2/O8=;
        b=KrWVM7kNUJI6aPmOUzd2DzC6emPLysjNtA66Q+S0kWVDO7utKXDporLzudgypKGAmE
         04yrG8/ufDZ/qCqL+lxG8k47bnVCK4MflzDELSAEyA9iH34mDolTexMRDDfaPOxYG3VO
         Xf+tj5BeMA+tcPIr9jFIRRAlfpuRqnINsV+bxjpdxMYoXiVCwre6zjgu5dxB9B5ZEHIJ
         wVuYybpsyQbj1bxKPeQMavizsZCaALLscBQ+2bHvihlAzcuFJ2y2+L5HQHE8bF87LZZh
         AeiDcOMKrYihx1VR9sVFgnv2gS5iglJo4psuZZoL/qNjeM+wXoxmlxJjHVq9pWiADq+A
         0ebw==
X-Gm-Message-State: AOAM532DkZCK4THV/UsKRIQ8ckoFLsBCHGQcLoTn0xyJKRxZBlOYENbW
        BjS6mVJsKRX1XZpFJCZYQduVzeNZLg8=
X-Google-Smtp-Source: ABdhPJxEXEVf07UXVcV4iAOZiY4edUaDEgg4TUK59avsk8p+89ui2UPJEzGSjUq/AvsFNKQl2PB/2w==
X-Received: by 2002:a5d:404a:0:b0:20a:eb17:559 with SMTP id w10-20020a5d404a000000b0020aeb170559mr11010583wrp.602.1652044914316;
        Sun, 08 May 2022 14:21:54 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id z18-20020adff1d2000000b0020c77f36b13sm9271504wro.100.2022.05.08.14.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 14:21:53 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Kalle Valo <kvalo@codeaurora.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] relay: remove redundant assignment to pointer buf
Date:   Sun,  8 May 2022 22:21:52 +0100
Message-Id: <20220508212152.58753-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Pointer buf is being assigned a value that is not being read, buf
is being re-assigned in the next starement. The assignment is
redundant and can be removed.

Cleans up clang scan build warning:
kernel/relay.c:443:8: warning: Although the value stored to 'buf' is
used in the enclosing expression, the value is never actually read
from 'buf' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 kernel/relay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/relay.c b/kernel/relay.c
index d1a67fbb819d..6a611e779e95 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -440,7 +440,7 @@ int relay_prepare_cpu(unsigned int cpu)
 
 	mutex_lock(&relay_channels_mutex);
 	list_for_each_entry(chan, &relay_channels, list) {
-		if ((buf = *per_cpu_ptr(chan->buf, cpu)))
+		if (*per_cpu_ptr(chan->buf, cpu))
 			continue;
 		buf = relay_open_buf(chan, cpu);
 		if (!buf) {
-- 
2.35.1

