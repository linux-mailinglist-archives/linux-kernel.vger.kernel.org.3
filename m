Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8A34873C8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 08:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345167AbiAGHyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 02:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbiAGHya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:54:30 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46F8C061245;
        Thu,  6 Jan 2022 23:54:30 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id n30-20020a17090a5aa100b001b2b6509685so5722703pji.3;
        Thu, 06 Jan 2022 23:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Kz6NSaBgfjb815/CYCxrJUTQyu9TXdUqaXEdKyqxTDU=;
        b=bQzOvSJ3E/5y9bVC3vU05/Sf0U10u3GZWknMesoriq1bS2kKEJ0VZ1vTPk94yPW5D3
         YW8c5PkhrnGDYfIkP4Y8UD+V7x97OSZxnC9cNaesfMSRyWCMJ/+F+63cJQXyPH0eHr1x
         5qVt18lxG9+AWakYrX8SNkA49rBiIFZs6KgOaNSYWpWYs1+WTkyG4jvp10Orw+rrzKV9
         4rzD3z2moD8JzGxJIromkf31Y4ctQCk1ZgrXITWBN2slsBDiY3dxAqGiLZ5+0JQYiAjc
         tVPXwM5MH9zSWj+4XKqHiCh0oucBJNUftedRJHJpaiMnKj5anZy0bQKLlN9vKWpEuwvm
         +VFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Kz6NSaBgfjb815/CYCxrJUTQyu9TXdUqaXEdKyqxTDU=;
        b=6b3B/jdclTKuUfvqFuo5uHJt3hRSdTJvlq8mUZdhcJ5uPuGsbHjUt5QI02fA8L8Gn6
         3B3coXMVhiisaCEsEgWtGjyweoGsA9DliZ42ybMzhDX4mMahXA8nQBF1zgR3NB14lOxR
         k4/0h4V7j1YY21ExvLji6yodjkSM4Ylv8GBsrYV108ijjPTGprbfNQMzoXZq1lt/rkav
         GsyR4l7YB4ZCBMyq66FfiHTkVkU3tLGsBcG3gHCS6E7wc97auq48FzXJ/YyQZjec1lLv
         67QGoOie4tWLzdw7csbc5Fld0Ka0tFf4K4bF32U6mkgeWstM5xiXGE9bjUyD7srklUC9
         8QeQ==
X-Gm-Message-State: AOAM533oH2LiUDDQ8AjbYEocrCa6ruQVHAXhc82y59+eEVZAOE7uKQAC
        mz307NYyRKAYKRPHp7UbjqU=
X-Google-Smtp-Source: ABdhPJwqY8SnGJn0tDg8v3BvwMkY1ZGWeh7yo2X8fc1stSlxsQsqftvSk9c8pZc1HnKKnztmzpprkQ==
X-Received: by 2002:a17:903:120a:b0:149:8b16:ee19 with SMTP id l10-20020a170903120a00b001498b16ee19mr46741995plh.11.1641542070356;
        Thu, 06 Jan 2022 23:54:30 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id 193sm4601347pfz.43.2022.01.06.23.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 23:54:30 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Beniamino Galvani <b.galvani@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: spi-meson-spifc: Add missing pm_runtime_disable() in meson_spifc_probe
Date:   Fri,  7 Jan 2022 07:54:24 +0000
Message-Id: <20220107075424.7774-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the probe fails, we should use pm_runtime_disable() to balance
pm_runtime_enable().
Add missing pm_runtime_disable() for meson_spifc_probe.

Fixes: c3e4bc5434d2 ("spi: meson: Add support for Amlogic Meson SPIFC")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/spi/spi-meson-spifc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index 8eca6f24cb79..c8ed7815c4ba 100644
--- a/drivers/spi/spi-meson-spifc.c
+++ b/drivers/spi/spi-meson-spifc.c
@@ -349,6 +349,7 @@ static int meson_spifc_probe(struct platform_device *pdev)
 	return 0;
 out_clk:
 	clk_disable_unprepare(spifc->clk);
+	pm_runtime_disable(spifc->dev);
 out_err:
 	spi_master_put(master);
 	return ret;
-- 
2.17.1

