Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF7854B544
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351390AbiFNQBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245380AbiFNQBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:01:34 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729CA4091E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:01:33 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id f65so8888620pgc.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yfKKCpGWWrtyBE1hPB2FQB9VM2Afg451ihttxYYfSq8=;
        b=3qAyoYKHMM89rP55LYc0Q/1vH+GQwym5ipFTr4nfuslQVEDKVeUmqv8LAEK+BQ+4Km
         QC0AYiM/8guw0NNXIIyHCLc9F9vW85qP921PlW9e/U9TB0r8vxiUypwdsR3JDPyIflZv
         o/EAUxmveHBYhebLZzoUFjU9b3bhE0YqgDZ76rWU3TUNSPCBzF9JybSsqfgcbmAltw2i
         0fUSbKvq6tAbecdxlW8nBGsNV5fI97r7ugSEE+4GhWl4X+NEwHlQq1cV5HumiNXEXeI/
         0HvXqqSYyvILILi6tRZfEpgwOR3+1lpbTzYh97bkF1jgIZkTcgob7ardrKp0xBHbvyE+
         kbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yfKKCpGWWrtyBE1hPB2FQB9VM2Afg451ihttxYYfSq8=;
        b=piNgW7ntO33/NF72rr40tND5D5OwLp7UdmkkPQ7iLcbnqXB6lbqhDilcgKgr0Ez5WP
         Ux+sdn51OQP2MQr7ZRipL4D66S6GSTWoVRyMD3ze8w8wi1Tg0N1pqzYS638dIi61Q1ME
         fegF29eu5taQxoDQo185m2fkhVqJYrbrqQivdW3/Df05GLdppmcj//IHu255yASObj9g
         OaBIqUecsTctt6CSehTzg98xAj6lKgiyqCCo9HqXk+OG54ixARf/vtc5PZHEtGrunfYP
         JnswIGkqOYEh9hgAwRxHsB8D2KGO7Lbd01Y7fS259WeM7goH3mgVBA0UOPMmzd6AJEv9
         ZAIg==
X-Gm-Message-State: AOAM531eN4LlXjIQWo870PgACHQrjYI6oW5XXWy+l2TalZhykzw+dM2y
        yNbfPE+dqbzSF3nYklcwgPeVTw==
X-Google-Smtp-Source: ABdhPJybS5LI36JCZHhD8ZpCLUW+z5Nk3J7fLPHvHYFmFHWDKUNMHhC73Vq2tDIMblY/9wr3Gtiv7w==
X-Received: by 2002:a63:3184:0:b0:3fc:5893:c866 with SMTP id x126-20020a633184000000b003fc5893c866mr5130632pgx.56.1655222492870;
        Tue, 14 Jun 2022 09:01:32 -0700 (PDT)
Received: from n131-251-240.byted.org ([121.30.179.216])
        by smtp.gmail.com with ESMTPSA id y15-20020a056a001c8f00b0051bc1865ca5sm7624059pfw.122.2022.06.14.09.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 09:01:32 -0700 (PDT)
From:   Zhi Song <zhi.song@bytedance.com>
To:     vilhelm.gray@gmail.com, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhi Song <zhi.song@bytedance.com>
Subject: [PATCH] isa: put_device after failing to device_register
Date:   Wed, 15 Jun 2022 00:01:26 +0800
Message-Id: <20220614160126.1739982-1-zhi.song@bytedance.com>
X-Mailer: git-send-email 2.30.2
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

device_register() is used to register a device with the system.
We need to call put_device() to give up the reference initialized
in device_register() when it returns an error and this will clean
up correctly.

Signed-off-by: Zhi Song <zhi.song@bytedance.com>
---
 drivers/base/isa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/isa.c b/drivers/base/isa.c
index 55e3ee2da98f..cf88f3d77b7d 100644
--- a/drivers/base/isa.c
+++ b/drivers/base/isa.c
@@ -173,8 +173,10 @@ static int __init isa_bus_init(void)
 	error = bus_register(&isa_bus_type);
 	if (!error) {
 		error = device_register(&isa_bus);
-		if (error)
+		if (error) {
+			put_device(&isa_bus);
 			bus_unregister(&isa_bus_type);
+		}
 	}
 	return error;
 }
-- 
2.30.2

