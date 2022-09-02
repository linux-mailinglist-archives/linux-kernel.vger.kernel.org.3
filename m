Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51FD5AABA2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbiIBJkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbiIBJkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:40:45 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99964D145;
        Fri,  2 Sep 2022 02:40:36 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 145so1365054pfw.4;
        Fri, 02 Sep 2022 02:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=2mf2p7tXgNfJKj0YQG7P5+yHNN7XhttCDsbNgbRwUEM=;
        b=nqBKbg6YqMGZSjE0giHt9guuOISdmdzlE7V+D6MmW36jZzPpreJnyv6cPWUkfSmjbT
         NHTJ0lnJHbIQgAbIzidO8AtSDG/odboQz+5rvoFVdnee8QhppfUykZsfZk1n4OomzqeB
         Niv2YQKWYbrvsrcPP4jvFeulBG0mT8AQF1EMxaiU3SOHhEaTKeckTRvXy/ggDk/aIPLK
         uPFPNZDUO3UtvZCAuhKU/4CW0qp1digslVrBy7ex+f/gD/R48f3Vm3nve7tIdyDw3zMl
         7QDjXQNFqilSzSHI4wOoaMpS7EEizGYzkTtaKUUWzz2d+5DB45duV4ENF9SmdKehMbDw
         qAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2mf2p7tXgNfJKj0YQG7P5+yHNN7XhttCDsbNgbRwUEM=;
        b=OxtwLUBn6ZkEQYwNt9ez2R6MhP7cBObCijyVbtvOKY+Ic+mfwS/WzI8kmo0evXvi4L
         aVnyZ/ZjCZMFINqa7AyVXa9zI22thGi8f3pWDqPk2vry2ThGp3B7N1iHdgAjm+9d/Yza
         zUJbuPUyfhcdgl2CUGq5rh5zMa/G56zzwv3zMGqRlRLUfvotojQzGUcRuPSin9Pu+3w4
         UCOJfShAeYTXvj76+A607TMtImHz29C8lVUxtue4x/ezyXqi5N3yL47reJnd3/q+FyJw
         d8EWIIUo73D3qfCaEWDLnYe2CC43rAdsfGUOSDtJuvMeNb2KkQrSFOvfgiI/PPiHcIuZ
         sJOw==
X-Gm-Message-State: ACgBeo1+WAZicWzWPTKTk+E3ydGm7cB7vkG+UxY/8uFpTGLwx2AfUcNb
        0DhqzWRg8MR4eyvkfQEHsZ0=
X-Google-Smtp-Source: AA6agR44kD/XStneWGVMWph7psdN9TKWdt3s5W+cJhNDjj3kQnZqtW3vPywg7BPPshEQtjyozbDf/w==
X-Received: by 2002:a63:1857:0:b0:41c:4217:426e with SMTP id 23-20020a631857000000b0041c4217426emr29778744pgy.285.1662111635559;
        Fri, 02 Sep 2022 02:40:35 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id z14-20020a655a4e000000b0041d9e78de05sm971855pgs.73.2022.09.02.02.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 02:40:35 -0700 (PDT)
From:   Szuying Chen <chensiying21@gmail.com>
To:     gregkh@linuxfoundation.org, mario.limonciello@amd.com,
        mika.westerberg@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yd_Tseng@asmedia.com.tw, Chloe_Chen@asmedia.com.tw,
        Richard_Hsu@asmedia.com.tw
Subject: [PATCH v8 2/3] thunderbolt: Modify tb_nvm major and minor size.
Date:   Fri,  2 Sep 2022 17:40:09 +0800
Message-Id: <20220902094010.2170-3-chensiying21@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902094010.2170-1-chensiying21@gmail.com>
References: <20220902094010.2170-1-chensiying21@gmail.com>
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

From: Szuying Chen <Chloe_Chen@asmedia.com.tw>

Intel's version can be stored in 2 bytes, but ASMedia's version
requires 8 bytes. Extend the 'major' and 'minor' members of the tb_nvm
structure to support both vendors.

Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
---
v7->v8: Fix patch message based on suggestion by Mario

 drivers/thunderbolt/tb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 7ef571f88606..f3f834511983 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -50,8 +50,8 @@
  */
 struct tb_nvm {
 	struct device *dev;
-	u8 major;
-	u8 minor;
+	u32 major;
+	u32 minor;
 	int id;
 	struct nvmem_device *active;
 	struct nvmem_device *non_active;
--
2.34.1

