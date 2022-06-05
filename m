Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAF553DAA2
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 08:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244334AbiFEG41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 02:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbiFEG4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 02:56:24 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2486220BD4;
        Sat,  4 Jun 2022 23:56:23 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id i1so9856492plg.7;
        Sat, 04 Jun 2022 23:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mxNx/eu/+3jETThuZa71za5QJF8vd3IjqfaM5dMqnqk=;
        b=Mp6NYVdXLrUrL7C1roe06pjMkSyBVQ/2fz0wh1lUh+HggBAcRPfF/C32aiQayJF4sw
         gBrEuipC/tRivmIXfhOpqt6s4uDjZbVIaiVdGLEV1jVIhJKnKHmKzTzIzQhKYqxsn47H
         pej6gfvFc71nKOP2Elh1uivP7eUc1tthIOi7/eNhKz00gBfWmFjRyP/9rBz2W1aC+rAo
         bDc3McutohoWMJtGYdPzYc34bOk1snVrXhjUhN7Hyuw4lxZ/kV6XoHRY3cibARu8u4Ew
         TjtobaRJebTk6xBBgSpnhpg61ujtVr4pgR9N1DLX1m1xf9BtgDe8HuRYn3qxztuODBf3
         mO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mxNx/eu/+3jETThuZa71za5QJF8vd3IjqfaM5dMqnqk=;
        b=lnrAWMtcXdXGI61XqUIPEQHkpYcYVNS3bzBgb4jwiA+qEdGCmVPFwxs6AQRWFENegC
         Q/mm6zVPCCr7eEYdQsArmJilfp8863cOfnkO/Rf+PrWw9T0ngdPWhIzQ3pOFTrvKHLzU
         zA7Yh4KB6bBduw5sDtOppQ/2Ix0NlS4Q0stleQonqmtef4m/Laf8dL1efWOLQgkKnaUn
         ixfLQt9L9AMerPbPaa/eoyu9ybiAcl4oE2TjRFGQQLs6W5KZYdcQNbnwJ4B393bBHo6u
         udggoBC0xo6D16OtQ8OYHqFck51DgWblmp+KocNM9mR8i3i4ZTD4MX2CuXR6XJ2+c1uX
         6Tfw==
X-Gm-Message-State: AOAM532PuEB7Uu3TsIxOS+RyF2AqsGlqO/S9gGMvjq5DGuCUTu+5EG4j
        CNE96o/YjPn+MS6mrloWeEg=
X-Google-Smtp-Source: ABdhPJxivFGKaULMkM3wSdRQeNIS7sRldLfuI2XMX39T38Nn7ulyFHC7xdXCcB9raJA3YQm2LoEZxg==
X-Received: by 2002:a17:90a:4a0b:b0:1df:7168:9888 with SMTP id e11-20020a17090a4a0b00b001df71689888mr55014212pjh.16.1654412182543;
        Sat, 04 Jun 2022 23:56:22 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id q11-20020a170902a3cb00b0015f0dcd1579sm8239871plb.9.2022.06.04.23.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 23:56:21 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] Bluetooth: btbcm: Fix refcount leak in btbcm_get_board_name
Date:   Sun,  5 Jun 2022 10:56:13 +0400
Message-Id: <20220605065614.1332-1-linmq006@gmail.com>
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

of_find_node_by_path() returns a node pointer with refcount incremented,
we should use of_node_put() on it when not need anymore.
Add missing of_node_put() in the error path to avoid refcount leak.

Fixes: 63fac3343b99 ("Bluetooth: btbcm: Support per-board firmware variants")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/bluetooth/btbcm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 76fbb046bdbe..6f05054794e8 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -495,8 +495,10 @@ static const char *btbcm_get_board_name(struct device *dev)
 	if (!root)
 		return NULL;
 
-	if (of_property_read_string_index(root, "compatible", 0, &tmp))
+	if (of_property_read_string_index(root, "compatible", 0, &tmp)) {
+		of_node_put(root);
 		return NULL;
+	}
 
 	/* get rid of any '/' in the compatible string */
 	len = strlen(tmp) + 1;
-- 
2.25.1

