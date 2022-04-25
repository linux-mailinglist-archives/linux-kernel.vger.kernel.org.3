Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C85B50E2E5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242432AbiDYOWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242421AbiDYOW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:22:26 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACA61F62B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:19:19 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id ay11-20020a05600c1e0b00b0038eb92fa965so12601539wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aZq4fC2Rak5UWYJ3VIIYdWjnbZR2sPVVIaexZnW1q/I=;
        b=2wZ7xxmndjI9NQJiBzvZ+9oMRSULwSsVZpMGKupZt4eoKXKcTrRG9ejghP6/CpyUuf
         J6GPivos0E0L1129DN23cCqKBulz4lsYlAPrpGnZ6FtWBesfKQ3dmZq47aZhBsvw1W0d
         XOBMBfRyII3XmWBbe2KvNrz4IVvlkNYoXEwxqphQoEOgA6OTnO4rTn/yENtnTY1ubKc1
         f6I+t24EcPrzRxmScY8seonziTlLJu+Ax7/kIJh4kvduJFvqVQg+P0tFvxfZBQen24xq
         pDwZgEepmZLygNr3idt9hH87SHj3JDbcc1047POsgs6eSmd/o2pGeWIMpYfT+SKHYHVV
         Cgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aZq4fC2Rak5UWYJ3VIIYdWjnbZR2sPVVIaexZnW1q/I=;
        b=K3ucsgc6WfY5yfcXYg3h6UAtiL64kUdtynmzlZ5FzQvx8GL5qYQTffUr0HEgvVSWDC
         areuYiKNjXhnJkremHnj/QHidTD8Y25RQLvHhNmuTS/2wmitIPim14Gub7VrYuxHUaR4
         dxyJNs62A2kzAHs/xON++ZV5/9syQGvLTKXfXFp24u6P9X+RtvX5uJSKPGHb0PH2PTYf
         BYL/Yj8kkMTvotY2WEjWAKaRi7WzxmzkjvCpS/n6Zsye70UuvmsvDPrRkHE6Tpg3/+SJ
         by7zOqKUKSEc2IMhWk9KkKZsCM4x7RBmBAnuBgFun6cliX9uPaPflbpXclqZTCggwCBV
         PB2g==
X-Gm-Message-State: AOAM533YdZovFj2QLZiWTA56AuvT+Tn+BYZ59Q0i/cZnXkaDBzd+cbQ6
        geDCcsWIp6JHCc8bzXBnL/qEoQ==
X-Google-Smtp-Source: ABdhPJwTt4DIcem5kvWlreKWpNVp5wVoIc2dUHMFQQOhMqjw6b7upbwNhmMWnsokCbGLHmVbmoRsdQ==
X-Received: by 2002:a05:600c:4f53:b0:392:e99:3002 with SMTP id m19-20020a05600c4f5300b003920e993002mr16952741wmq.35.1650896357823;
        Mon, 25 Apr 2022 07:19:17 -0700 (PDT)
Received: from groot.home ([2a01:cb19:85e6:1900:ce86:3a65:67d7:726d])
        by smtp.gmail.com with ESMTPSA id f10-20020a5d64ca000000b0020aa97b0383sm9144592wri.113.2022.04.25.07.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 07:19:17 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 0/2] Input: mt6779-keypad - fix hw code logic and row/col selection
Date:   Mon, 25 Apr 2022 16:19:12 +0200
Message-Id: <20220425141914.158959-1-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie is the first follow-up on the mt6779-keypad in
order to enable it on the MediaTek mt8183-pumpkin board.

To fully enable it on mt8183-pumpkin, we still need:
* double key support
* dts changes

To ease up reviewing, I preferred sending this first.

The first patch fixes a logic bug based on the (non-public) datasheet
I have.
The second patch configures the keypad correctly in order to not
report bogus values.

Thank you,
Mattijs

Mattijs Korpershoek (2):
  Input: mt6779-keypad - fix hardware code mapping
  Input: mt6779-keypad - implement row/column selection

 drivers/input/keyboard/mt6779-keypad.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)


base-commit: b243018eafeb69bf074ef013c54504632fd161ec
-- 
2.32.0

