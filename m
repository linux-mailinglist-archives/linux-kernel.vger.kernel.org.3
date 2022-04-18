Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46402505D7D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346436AbiDRR0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbiDRR00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:26:26 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3757833A1C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:23:46 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c12so12867822plr.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w84A5bSnfH8JPWuHmpfwhtHQL8kzzjVsgikmw3NAGNg=;
        b=fRhwSkr30I2GH+odEqNIwtcw6Mkc0hs533hCNGNu6B733isTMyN7mgdaKJgnWGDzEl
         uhuORa20O7wxLI2fE+KLlFcOaSk6ihk0xdw+Se0E4RwpcwCBNNsm470hU/synopNyK6a
         pws6E8OuSufQCw6xr+gShLZC0yxbf6DEZRQGxhBlFl/uT9ybPy4/2v200xJVgdS9V3aZ
         7JF4lfZ2lbZm6vMLIZBGdhDP7mUpgcMb0QdGJgRz7QVUotehsgBRObxX9Wusw548AHgq
         q373jx7YHbzuvYTNCUJC6fW8z7kiHgN04Y6B1/+jto9xSuqRl/jrBAc/XVwzbTAd04Sn
         0pgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w84A5bSnfH8JPWuHmpfwhtHQL8kzzjVsgikmw3NAGNg=;
        b=5bkCD32dSJG9mjyPyEui0GL5EKX+ep0Oln9oEB6FHeFipwpgDda0Lxb4eY60kp1Ink
         lQKP9Z6WSEH0CEkkZ5hvM9iHVfFl5A7UJLHUBr+E+KE16yBiSZi7vPgiqekvIhxOtmmv
         9SyZFHkO1VVsBGzEWBd/C+Le5FPZZ+JlBayo/A4ojpeq8l/T8QSbkF9O1RE6lX+0akYx
         GI2cCqMbnPppWiCtsxxaSqss9BkkffgfPG50nmwDyHSVo70PwbrcDKGnpKT4O8koT8Sm
         vXGzmvosYWbia6QwqHfH6Ray7gu36Ol/0WYV1wTZOyQgNuG8BPTiX0YtY/y3jrIv8s7Y
         PL2w==
X-Gm-Message-State: AOAM533O6bqGEWaMLvk7V8qehYbcNXQYDJCDa62azAvS0qq1dr5rIx5i
        2jIVkmyCpmxxJUU6gs9wAOwp5hx4cTWNPA==
X-Google-Smtp-Source: ABdhPJzAQUrr9wPWIp/IDtWYEjrW8r1+3GdG/Kl5eQZZhBJXkcJeST2nsFkYH/qrtsTT3vQplbAPOA==
X-Received: by 2002:a17:90b:201:b0:1cb:a159:65ce with SMTP id fy1-20020a17090b020100b001cba15965cemr19878149pjb.104.1650302625656;
        Mon, 18 Apr 2022 10:23:45 -0700 (PDT)
Received: from aliyar-HP-Laptop-15-da1xxx.domain.name ([14.139.241.88])
        by smtp.gmail.com with ESMTPSA id y9-20020aa78f29000000b005098201d2f5sm13041394pfr.205.2022.04.18.10.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:23:45 -0700 (PDT)
From:   Aliya Rahmani <aliyarahmani786@gmail.com>
To:     clabbe@baylibre.com
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Aliya Rahmani <aliyarahmani786@gmail.com>
Subject: [PATCH v3 2/3] staging: media: zoran: else is not generally useful after a break or return
Date:   Mon, 18 Apr 2022 22:44:54 +0530
Message-Id: <20220418171453.16971-3-aliyarahmani786@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418171453.16971-1-aliyarahmani786@gmail.com>
References: <20220418171453.16971-1-aliyarahmani786@gmail.com>
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

Remove the else without affecting the logic. 
Fixes the following checkpatch warning:
 else is not generally useful after a break or return

Signed-off-by: Aliya Rahmani <aliyarahmani786@gmail.com>
---
changes since v2: Rework commit description and subject
---

 drivers/staging/media/zoran/videocodec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/media/zoran/videocodec.c b/drivers/staging/media/zoran/videocodec.c
index 16a1f23a7f19..19732a47c8bd 100644
--- a/drivers/staging/media/zoran/videocodec.c
+++ b/drivers/staging/media/zoran/videocodec.c
@@ -98,9 +98,8 @@ struct videocodec *videocodec_attach(struct videocodec_master *master)
 
 				h->attached += 1;
 				return codec;
-			} else {
-				kfree(codec);
 			}
+			kfree(codec);
 		}
 		h = h->next;
 	}
-- 
2.25.1

