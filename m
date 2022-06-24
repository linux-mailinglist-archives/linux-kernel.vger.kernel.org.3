Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9621B558D46
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 04:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiFXCmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 22:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiFXCmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 22:42:22 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695CA56745;
        Thu, 23 Jun 2022 19:42:21 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a11-20020a17090acb8b00b001eca0041455so4555649pju.1;
        Thu, 23 Jun 2022 19:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4JPmBa9YRGGIbNymzaZBwCj2uTHp/bKyA501RluWmfw=;
        b=e2Zhs3JmLacTcis3WcQcUHnaiF05hNZPRtHQ7Ccd0f6j91n886n7ShnklJ/7geL43r
         QPRyDoYL0sQdysS8N8OmWcQyIHD0czcc1CoeTzh3cm13KOTe0vvuuJMNRebcxB0SZCqs
         t3S/na5PFpsTm3AflB39HpRqFGj/ts0lNqK9N72oG3OnlyiDURBEeTEZVr6XzN9MLSGf
         mMPSPgt+kJNqTZjdweGWGCF6dE6rn+ElPIM/zvmf4LdiRn1pqg2cpu3vuDqPkl/jiujx
         IDntf5nQbNdPewDyOqwJIt6tTTeBpk2WlRGBqmrCTl+DpTwllvAE5khWsxL3bMI42Z0v
         pXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4JPmBa9YRGGIbNymzaZBwCj2uTHp/bKyA501RluWmfw=;
        b=SPp4NN/XoULxxoZ3O8HlLaoKK0yZkz2/zBHYrJbD7+mV+syoVd7n0JMAPNvHI0jboP
         PJjZaN+hl9P6O0wrKA4gGXY2lKTEwkh7cH0S59QuGWWMN5xCm0/kGNf0gLL4x4dIaN3i
         ahJwXpi1V/Rx9vGPuE2FfZlDrJc53m1aDB4hYk30fL4T5Zf5A5ROmewXCpcEoVi9h0LR
         9FZBn3WU6LZG0nE/s2ZW5ML9e9JpCj2PbtaYTCjkTZWJWnSZP/Zl1iwG8NPq9Pp8w95D
         lSypzLn8kXj3bWeTqKibSJ9BZKiuiDhIVtH8n8eKM4503m2Qu+1rwGqMY1zlOnqueONP
         /VPw==
X-Gm-Message-State: AJIora8sQXtu5RhTwswktHhDWV4OeLpD++c2ZmpkFRIDsDaNSuwvQp6m
        wSt5rllzt+8Sc/g/heV6t7g=
X-Google-Smtp-Source: AGRyM1sVxQvVF3VBXrx/B6vbnyPpkt5bAwlk9QciKRe4kCbo1IIkaW9Sc1jU+vWxnjvIJuWbFRDMXQ==
X-Received: by 2002:a17:902:7005:b0:163:ffe7:32eb with SMTP id y5-20020a170902700500b00163ffe732ebmr42023769plk.18.1656038540717;
        Thu, 23 Jun 2022 19:42:20 -0700 (PDT)
Received: from localhost.localdomain ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id l10-20020a17090a660a00b001ec7c8919f0sm2625936pjj.23.2022.06.23.19.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 19:42:20 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        gregkh@linuxfoundation.org, krzysztof.kozlowski@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v2] rpmsg: fix possible refcount leak in rpmsg_register_device_override()
Date:   Fri, 24 Jun 2022 10:41:20 +0800
Message-Id: <20220624024120.11576-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.25.1
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

rpmsg_register_device_override need to call put_device to free vch when
driver_set_override fails.

Fix this by adding a put_device() to the error path.

Fixes: bb17d110cbf2 ("rpmsg: Fix calling device_lock() on non-initialized device")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

v2: change the commit log.

 drivers/rpmsg/rpmsg_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 290c1f02da10..5a47cad89fdc 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -618,6 +618,7 @@ int rpmsg_register_device_override(struct rpmsg_device *rpdev,
 					  strlen(driver_override));
 		if (ret) {
 			dev_err(dev, "device_set_override failed: %d\n", ret);
+			put_device(dev);
 			return ret;
 		}
 	}
-- 
2.25.1

