Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A644550045B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 04:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238161AbiDNChN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 22:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiDNChL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 22:37:11 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9527DFCC;
        Wed, 13 Apr 2022 19:34:48 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id md4so3822020pjb.4;
        Wed, 13 Apr 2022 19:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SoQ7t3GysTvAyNktAhNf5bL8501+vtGlmJoH0biErTE=;
        b=puW3ojoQg10vDzEtxIV4fzj4Ot9E6RGQVU9li4VMFoIVGdlKW39jCcf0JqKTux3bW4
         w0Nf3l8gGLj/N3ZGcq4p+CSUJqhvh8zcaBJQmZir/UnaNMZ2fFEfI1JwW6KIhchCDUWb
         I8C31NSsYaM5bQiKAgOjZNYjqnQdfXLGbqMqp2vavN9F1zhHJEFmcAqOIe5YxpIvMx4G
         kbCsYH3YCffGDPItMZYj7YXAaWhcpHgf+vpAnTxz2FXJIdLykr0wlQ/BPCLJeTjPgsVB
         reRFaGIPYqekxk5zJztKxJRLEoBYIwR6IJv5Pu+3bNdTERGUgNyIBKy9KDDWZG6y/wSA
         KSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SoQ7t3GysTvAyNktAhNf5bL8501+vtGlmJoH0biErTE=;
        b=Pzxd5ASTIhwlKniKzXv5xToCpQrt537uj/MsBaaw94uPA+3sQxzu23aZ419zk2IlMu
         HUoanuwK5cNTxRoseGRskt38i1loYSm0Yn3ajIJElrodX35U869v6PCXuvGIELq9tRPE
         0DDJ+m/m5rU72Ps3Myt6Gg1Uj/+MlNaKJB6aGPO9A0qlySgSuvoAparXAltMmv+NDaow
         jxz/YEyOmERBNYTM/Hjp3QS3wocUlMW6m36ojjoi4pRF053QB1c2I5Uzy2NoZeAlV1iO
         C0lQt47ULch9E8O0QIs7fragiVdN43sMViijXaqlHQCWmXG5eCxv4gpHWVfJC5WM+MXI
         DKbw==
X-Gm-Message-State: AOAM533w4uOaul3cNBAkU2SFNLGJXnz48whbFCVcUgAxESPVH3WjlpSQ
        9HGhJVcBQmaCLvHUyyxs533Zzs8k70URRjk=
X-Google-Smtp-Source: ABdhPJxcRr/CDaXT6LOYlxwkPbtPBcngxnqm+QIf17iaLISnfg0g+WXz4rRNecrSvlvgiixGpEifew==
X-Received: by 2002:a17:902:c94b:b0:158:8c9e:84e9 with SMTP id i11-20020a170902c94b00b001588c9e84e9mr9932512pla.115.1649903688407;
        Wed, 13 Apr 2022 19:34:48 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id j3-20020a17090a3e0300b001cb68d28544sm4283517pjc.37.2022.04.13.19.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 19:34:47 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     sakari.ailus@linux.intel.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v2] media: i2c: dw9714: Disable the regulator when the driver fails to probe
Date:   Thu, 14 Apr 2022 10:34:35 +0800
Message-Id: <20220414023435.1710775-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the driver fails to probe, we will get the following splat:

[   59.305988] ------------[ cut here ]------------
[   59.306417] WARNING: CPU: 2 PID: 395 at drivers/regulator/core.c:2257 _regulator_put+0x3ec/0x4e0
[   59.310345] RIP: 0010:_regulator_put+0x3ec/0x4e0
[   59.318362] Call Trace:
[   59.318582]  <TASK>
[   59.318765]  regulator_put+0x1f/0x30
[   59.319058]  devres_release_group+0x319/0x3d0
[   59.319420]  i2c_device_probe+0x766/0x940

Fix this by disabling the regulator in error handling.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/media/i2c/dw9714.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/dw9714.c b/drivers/media/i2c/dw9714.c
index cd7008ad8f2f..8c5797ba57d4 100644
--- a/drivers/media/i2c/dw9714.c
+++ b/drivers/media/i2c/dw9714.c
@@ -183,6 +183,7 @@ static int dw9714_probe(struct i2c_client *client)
 	return 0;
 
 err_cleanup:
+	regulator_disable(dw9714_dev->vcc);
 	v4l2_ctrl_handler_free(&dw9714_dev->ctrls_vcm);
 	media_entity_cleanup(&dw9714_dev->sd.entity);
 
-- 
2.25.1

