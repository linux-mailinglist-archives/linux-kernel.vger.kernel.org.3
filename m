Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F9F5862B0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239187AbiHAChq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237684AbiHACho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:37:44 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B532DCCF
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:37:43 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id r186so8532354pgr.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=lXB0daiEp1IPszXD6lgU6e6WPPivz7kdrh5SiPt8e4w=;
        b=YPhNY15H5CaQQ/HwGPI1gF8eVX5EYfKwSwYqO74WPIVnF47YgVCKq3Ix7MQ0Y+s510
         +hn2Qv7HdutmdW2LNgHBDHzUqefm5CE2zE2AQuyDosrtf+RIYaGCqieFiubPyDTg9wZr
         nhYyZLZjFNhvpR+yCnjE3FixYjDog+mKJDa2p36UpYYOZUkJzFpIK8v6Sf4vmjI+loYf
         VuZZOLHqeZLeYy7GDLPNy9X5hS7dJVIqkbQJEUVe6DkiWfAuf9BZ50sbmVpQcFYYsqe5
         96dEdPbG4t5XbtCTsh7BXi3842ZZj8rlSZ+oiKDR0lvzTQZ0nuGQBJgc83EykzeRFymy
         Uibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=lXB0daiEp1IPszXD6lgU6e6WPPivz7kdrh5SiPt8e4w=;
        b=odgq2CGU3lfsHTmKXgVQigAR4je1RTz8yYMUfCysvUoDNaSlbw4pSktjk0rcIEBu9c
         scmp9WK5WP3b8ps9BqV/GtbgNVFlAaDhXnpjr3Mjp7E8/zNFNaJZCaXKAJGO9mLK6gBf
         VhZMr3wcJgTIC+UC/2s+3ZbW6kz5QKEzkn01uNWuE/gdm329AWM2McygLAmLf+48BvOz
         H3Kx58I/7TKrCHxEm88+ezYZG3BpPYpTVIOI8Zqv2gcj8gr6OIce5px8n57W5oYyOvyM
         JOeFRzH6aomG5AQlCxIEcQky4YHgZ3Z3w2ttG9UxhsqK3wVXp94Fp22i2wUa7I0V/UDk
         EkYg==
X-Gm-Message-State: AJIora9xaP7gb0UW4CBKtLMnM014Y4HpQSUoyPKMXFXGqakvEL2if2/l
        u9lVwPwOBFsPvKImF4aGpw45ylqVGcc=
X-Google-Smtp-Source: AGRyM1vkrnlUyBdeQSpJcGixcW0bP+dpn4G3gZyhx+d3gdoXpoeA9fV+ccVQOE/3hje7tjQGSCWiRQ==
X-Received: by 2002:a05:6a00:240e:b0:52c:81cf:8df8 with SMTP id z14-20020a056a00240e00b0052c81cf8df8mr14283962pfh.60.1659321463167;
        Sun, 31 Jul 2022 19:37:43 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a3ea300b001f317767790sm8594894pjc.23.2022.07.31.19.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 19:37:42 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] mtd: rawnand: gpmi: using the pm_runtime_resume_and_get  to  simplify the code
Date:   Mon,  1 Aug 2022 02:37:38 +0000
Message-Id: <20220801023738.1595203-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Using pm_runtime_resume_and_get() to instade of  pm_runtime_get_sync
and pm_runtime_put_noidle.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 93da23682d86..0e7da90d6559 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -2504,9 +2504,8 @@ static int gpmi_nfc_exec_op(struct nand_chip *chip,
 	for (i = 0; i < GPMI_MAX_TRANSFERS; i++)
 		this->transfers[i].direction = DMA_NONE;
 
-	ret = pm_runtime_get_sync(this->dev);
+	ret = pm_runtime_resume_and_get(this->dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(this->dev);
 		return ret;
 	}
 
-- 
2.25.1
