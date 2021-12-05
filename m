Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6F4468C8B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 19:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237011AbhLESL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 13:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbhLESLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 13:11:55 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1029C061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 10:08:27 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso8748916wmr.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 10:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rF5hjb+HWpI1Ih1xwXVy9ddAAkLWiFGmzep35P6NJa8=;
        b=el1s2Fn6aF3tZlnWmb8zajw9s3UfJDaH4P7gRXmjfZ0zEuwgbQ10kfgx4IMio5hn1p
         Uu01lLR2bp1mP5HcalLld668UrcpEogLnqglK6gQCNhsPWYfbVpdwz9cJObju0IwJkgt
         2in494V04RNe3zH+i10XdrbAXd6bPXEGKLAZGg7DNpMw1IDcQNMYGoI59YjQEBOv5MaW
         xrfgtJ7jhiSODqLz00ZmPrE7MECID4hKFta7CvplgqryADVCiT3PF43MxF7tSnrgBrr0
         FB7KKHgoNBy1H004sZN+ugdwQY4TeZtSiEMQv4aYM5JaHO3omtBdMj03KvEsC5cavoC3
         m2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rF5hjb+HWpI1Ih1xwXVy9ddAAkLWiFGmzep35P6NJa8=;
        b=fGRqVKUwuxhccK7549r/28s6dKZhmnNkUKv+qSLL0P4ySDxagLU+h2xCa6so1dX8Zw
         eOGbpdX6g70TbChjuTXd0Db/iN21iyU4c38pqbl+5cQMo0i/h6RCfphOrjf10AmS7P6R
         hWoF7kjtOywiRwjV6ieV7cQt/xFlLgMfzmiQFVFxz++TGWfjJ3qk/1XZQDT+st1QrAWc
         JKyuQiCckkF99vMtrKC8Atw5M9OP8y/gGZgoNH49+YbTK1UEJBEAwPVe61pJPypZ/N1M
         J0ewpf8lQhkwFZEvt/l6WBQWvUsL7TmApUi6n48RWOBbexORmh3V11WNoOw94q1XqfWc
         21Ig==
X-Gm-Message-State: AOAM533MZEp6kXqIiuDXlgMaEHVsgvlAoddNQewuV6T34DIu7ND+lz4P
        aweFT27G/Zg7+WsMm2HNMeM=
X-Google-Smtp-Source: ABdhPJxFtMAxnY+guAh4BzBOqq0b0PVbyY4w9h4fGaJTVCB19FDi+PDoMvxlhtL74NWjjqZg6FhP0A==
X-Received: by 2002:a1c:20d3:: with SMTP id g202mr33026556wmg.129.1638727706049;
        Sun, 05 Dec 2021 10:08:26 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-c11b-a200-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c11b:a200:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id x13sm9250551wrr.47.2021.12.05.10.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 10:08:25 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        alsa-devel@alsa-project.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v1 0/2] ASoC: meson: aiu: two fixes
Date:   Sun,  5 Dec 2021 19:08:14 +0100
Message-Id: <20211205180816.2083864-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jerome,

in this series I am proposing two fixes for the "aiu" driver, used on
Amlogic Meson8, Meson8b, Meson8m2, GXBB, GXL and GXM SoCs.

The first patch is the result of me trying to understand the way how
we get the DMA buffer and address for the audio data. I'm not an expert
in terms of DMA. From what I understand we need to inform DMA core
about the limitations of the hardware. In case of AIU it's DMA address
registers only take 32 bits, so DMA core should be aware of this.

The second patch is what I could come up with to fix the infamous I2S
buffer underrun issue, also called the "machine gun noise" (MGN) bug.
After a lot of testing, debugging and comparing vendor code with the
upstream "aiu" driver I have come up with this fix. I have written down
my thoughts in the description of that patch. To be clear: these are my
thoughts, unfortunately I have no way of proving this other than asking
other people to test this patch (off-list I have already received
positive feedback along with confirmation that both 2-ch and 6-ch audio
are still working fine. Even with Kodi's menu - which is an easy way to
reproduce the MGN bug - sound output is fine with this patch).

Please let me know what you think about these patches and especially
the patch descriptions.


Martin Blumenstingl (2):
  ASoC: meson: aiu: fifo: Add missing dma_coerce_mask_and_coherent()
  ASoC: meson: aiu: Move AIU_I2S_MISC hold setting to aiu-fifo-i2s

 sound/soc/meson/aiu-encoder-i2s.c | 33 -------------------------------
 sound/soc/meson/aiu-fifo-i2s.c    | 12 +++++++++++
 sound/soc/meson/aiu-fifo.c        |  6 ++++++
 3 files changed, 18 insertions(+), 33 deletions(-)

-- 
2.34.1

