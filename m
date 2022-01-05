Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C05485318
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 13:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbiAEM4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 07:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbiAEM4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 07:56:39 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3382C061761;
        Wed,  5 Jan 2022 04:56:39 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id l15so14468216pls.7;
        Wed, 05 Jan 2022 04:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=pPTnnFDZ1+dEAgEFTmiqXGXGW+Zq8maAM3d4dtNv7OA=;
        b=leB0DAAq2hFztVJ5MxPombH0DHMtJsPeNZcp5d01NlhrPBbKTW3jP6+r2Y28OdSUeF
         wYbtG1N8aX308FVEcDPsFiSFU3DJIUX9cEOVC0tDVF54rIKPkN95xCfiHgLuMTn1Oupt
         Zz2WauHS0VjOA5Cbboxq2y/WW5Fla6r1TJSjnnU5N6LNobk57QQeAsb7l3hwWu/yNLrw
         ryrJWb49cj2r+G+Vmuc9xbWku39dEHl2loZkt0xEb5j1jueJorhoHfEfrlitvBvtSDEa
         qT8tLw3oc/6H8kYRBjhYRP4Sxo3raluCTXsfE/mFD5/PF1LsdDnqZltuFd99dMNX648D
         vCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pPTnnFDZ1+dEAgEFTmiqXGXGW+Zq8maAM3d4dtNv7OA=;
        b=uaXyIoAMwq5uBTxwQUdHIWMKAwCN+JQXWMH0A+A4kzC7YSrRlDgG3MKR8HgqTbKTsH
         p+71pVY5I7rJhAvvcHChBAMVOtwjAbYfmtrLBnlFdBCmO1iCcfS+Ul4VWCMaVV+rmGhi
         2DpPJdcet/GL7b0G4u2HXvJu4mkwlyQaVIz3ZGevvV9rz/wY+yXQj5DNSa9wbAqONaHd
         FvHghg9JdEKOibOyMtpR120xVVT67VWH5h+Tg1qwsp8KsjQaULcWIcK4rT7OIaAKua5x
         fiO22zIJPlGwZ0L1k60jJoJ7dszrd7DuW1st4InBPWgvmqH2MPsd6V+dW1AKzLugCP6s
         g7SA==
X-Gm-Message-State: AOAM533HzS4FpOkQ3AN6294kUvgW971A11SRykKw+e5E+MdwstxYkbIz
        n2yy6NaIeDgASFsboFT5gR8=
X-Google-Smtp-Source: ABdhPJzb29eoxT4uPyOXr7pcJfdD/DEWfaOS6qbIEeFyE1HmRX//qrtlQRHC37vJBqPyTnGruCZreQ==
X-Received: by 2002:a17:902:9894:b0:149:8a72:98ae with SMTP id s20-20020a170902989400b001498a7298aemr38401469plp.132.1641387399257;
        Wed, 05 Jan 2022 04:56:39 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id d17sm42901005pfl.125.2022.01.05.04.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 04:56:39 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Adriana Reus <adi.reus@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: gyro: bmg160: Fix error handling in bmg160_core_probe
Date:   Wed,  5 Jan 2022 12:56:30 +0000
Message-Id: <20220105125633.21989-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pm_runtime_enable will increase power disable depth.
If the probe fails, we should use pm_runtime_disable() to balance
pm_runtime_enable(). In the PM Runtime docs:
    Drivers in ->remove() callback should undo the runtime PM changes done
    in ->probe(). Usually this means calling pm_runtime_disable(),
    pm_runtime_dont_use_autosuspend() etc.
We should do this in error handling.

Fixes: 7d0ead5 ("iio: Reconcile operation order between iio_register/unregister and pm functions")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/iio/gyro/bmg160_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 17b939a367ad..81a6d09788bd 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -1188,11 +1188,14 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
 		dev_err(dev, "unable to register iio device\n");
-		goto err_buffer_cleanup;
+		goto err_pm_cleanup;
 	}
 
 	return 0;
 
+err_pm_cleanup:
+	pm_runtime_dont_use_autosuspend(dev);
+	pm_runtime_disable(dev);
 err_buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
 err_trigger_unregister:
-- 
2.17.1

