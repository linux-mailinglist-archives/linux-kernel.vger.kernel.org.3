Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3B84F09F3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 15:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356995AbiDCNZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 09:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbiDCNZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 09:25:15 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36592FFF3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 06:23:20 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b13so6647694pfv.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 06:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3lAFfHy33FJv196rnV5yMyEFhXSQMIQgUO/mtSRSAR0=;
        b=zqgM88tMjPT3479UPmMgW/1Vt5OomA8m2uBCmnttd3pYcGNkHVGngtiW19+GXq3j1R
         1crt3TMtSfzxzaL/X+V5e3D2FpErMnah3HnC3tg4jJw96HD3VlaUPDcItFAzxt7X56j7
         a20shh/U9SrDZIjoUdtC75aUgrrdeVYWdV+y9pUXjgN0yA1XfhAbMq9rXpUQ4/6UcKw3
         MciZtQ2VV5zSXHi5TV7ZcyfwOWpkcuB+WJoFu2CFADcrQJM5BwdD5ynCiysupSlgp6E4
         XvF6LNU/LyVytPz4ici+1+/35ug3sLzrxXHlAz9Cjsk4LcLbI7iUqQ6EYYvQ89MyaCXN
         t14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3lAFfHy33FJv196rnV5yMyEFhXSQMIQgUO/mtSRSAR0=;
        b=WnN6tKyKJm6/2cyhTyiP9u27r/muBzmNAsnZwZHn+5uDa/SiVFI5XaIqx0HY3hZgCr
         /D7wH1cMuyGwhZH73HlAyZpk7ZVGX98sotYOZzcwZAZfJXC1A4SwUuEnXlv6CE8a4N4N
         BfCpMeLWxLGe3xyCjskQElOxdXGfDRmgafPXSviB9zPY+0AWDUTh7VuUerh3wZIMHeaa
         hU0+nQYmGfhHPu/RtQ0FXDXXqGRIoSASsPeLvw7QQyUX0dnkTY360UTEfLiQtkIPuifs
         Orc/rRoAkaxME4jeENn09bfohLATnyVVffgAg1mSTFvBFLyA88O36f2atohk43Qdxx+p
         f/rg==
X-Gm-Message-State: AOAM533tguJxryEmroq9UhoLD7r0DMEaA5W8HZ/X4ojcGj210lR9b14U
        GFPONY/gMrY2F0+wXKbt2fP4Zw==
X-Google-Smtp-Source: ABdhPJzZg3W2+/O6eiaJw7MyfgWgv36pluC9QAjr7JMaLDOOMO75DglFZ+PeD0tuKuVJCqXyZgY46w==
X-Received: by 2002:a05:6a00:1593:b0:4fb:344:2c40 with SMTP id u19-20020a056a00159300b004fb03442c40mr47937240pfk.44.1648992200299;
        Sun, 03 Apr 2022 06:23:20 -0700 (PDT)
Received: from alpha.. (122-117-179-2.hinet-ip.hinet.net. [122.117.179.2])
        by smtp.googlemail.com with ESMTPSA id d16-20020a056a00245000b004f7728a4346sm9277203pfj.79.2022.04.03.06.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 06:23:19 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        "Liam Girdwood linux-actions @ lists . infradead . org" 
        <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: atc260x: Fix missing active_discharge_on setting
Date:   Sun,  3 Apr 2022 21:22:35 +0800
Message-Id: <20220403132235.123727-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without active_discharge_on setting, the SWITCH1 discharge enable control
is always disabled. Fix it.

Fixes: 3b15ccac161a ("regulator: Add regulator driver for ATC260x PMICs")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/atc260x-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/atc260x-regulator.c b/drivers/regulator/atc260x-regulator.c
index 05147d2c3842..485e58b264c0 100644
--- a/drivers/regulator/atc260x-regulator.c
+++ b/drivers/regulator/atc260x-regulator.c
@@ -292,6 +292,7 @@ enum atc2603c_reg_ids {
 	.bypass_mask = BIT(5), \
 	.active_discharge_reg = ATC2603C_PMU_SWITCH_CTL, \
 	.active_discharge_mask = BIT(1), \
+	.active_discharge_on = BIT(1), \
 	.owner = THIS_MODULE, \
 }
 
-- 
2.32.0

