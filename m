Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AF0504FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 14:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237966AbiDRMGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 08:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbiDRMGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 08:06:18 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F9A17A88
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 05:03:39 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h5so18495728pgc.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 05:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NnfylWN7MavTPT553g+jrwdoRsttSRF9ea+q5wroK2g=;
        b=SXVE+pR8devV3hO4tWlgoxCYNAdT0Ru6k53XSx5WS1V7guQJZqXF8ndR5M3UPGPryX
         preJK3/gW+63QwRNfoPx6ZtriC621Oq+FkCL6drTNIh/HRWLzHbUGf2IPoX7n5X4zmXX
         DOHLFuiRIigUu3TNkQw8E0AE09g6RMFWg2NuKJNlFvl9WHksO8vijte7fP0g2D2sIvW6
         cjf/kHgxe3bUrrvBB1cpRYs6NnwocbAxBZ+d91sUaqoDCFnI2YmlkAmeOSVVFGgg+E5L
         FxhzYqayBHTPeyO4t2FIhCvufk0Wklhv0jvy7Bw7sgh4KWBIE4TrMpm74eEZ3RuR0IWn
         PXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NnfylWN7MavTPT553g+jrwdoRsttSRF9ea+q5wroK2g=;
        b=WDO+hYhsPNpFfBFyfR44Yzrbqs73R+/A9Au8BKmWWxuDtuYDuQNDSwFPyB1DrAfle5
         g+F7bI2SX+k20fOd4nYaywsmQre3/Jb/NoDm7kAx7BNishh0PpKTSb17HJCUdV7uvYEa
         ldCIG+a43A/AgtFSJ//7EmGLfOd9lke5FXSxFQE/088unIDFMRdyRn7/HlJyXRnnvuQz
         4Z6wbFrNtt8yOg9n+S2r7bOJW+5CYLmxDrM86fRffr+eAdup1bC86s0r1YmuNBrXGxyE
         k67MWlfF4MkiVuyqC3UZLiN47cbfKnlztwqbCYDDEZ37OVyh2rKz18/S9GtyRVQmu+Gz
         48YA==
X-Gm-Message-State: AOAM5307FDINZ5ushJcHNkr7QdGC37Kf5hsdw2sjlQk0uAg5P0qsraqu
        j6dXts8E6v6ja/Pi9izeLpw=
X-Google-Smtp-Source: ABdhPJxVYwRdke1zYGoWe8PpudWD0LJmyZsh75gb25UTnIp8YT9ms1lZ7EG2nblYE9sNVU+WooJIrQ==
X-Received: by 2002:a63:1d5f:0:b0:39d:b5e4:ae24 with SMTP id d31-20020a631d5f000000b0039db5e4ae24mr9551819pgm.502.1650283419258;
        Mon, 18 Apr 2022 05:03:39 -0700 (PDT)
Received: from aliyar-HP-Laptop-15-da1xxx.domain.name ([14.139.241.88])
        by smtp.gmail.com with ESMTPSA id p1-20020a17090a680100b001d28905b214sm3840628pjj.39.2022.04.18.05.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 05:03:38 -0700 (PDT)
From:   Aliya Rahmani <aliyarahmani786@gmail.com>
To:     clabbe@baylibre.com
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Aliya Rahmani <aliyarahmani786@gmail.com>
Subject: [PATCH 2/3] staging: media: zoran: Code cleanup - else is not generally useful after a break or return
Date:   Mon, 18 Apr 2022 17:29:50 +0530
Message-Id: <20220418115948.5456-3-aliyarahmani786@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418115948.5456-1-aliyarahmani786@gmail.com>
References: <20220418115948.5456-1-aliyarahmani786@gmail.com>
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

Remove the else without affecting the logic. Fixes the checkpatch warning: else is not generally useful after a break or return

Signed-off-by: Aliya Rahmani <aliyarahmani786@gmail.com>
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

