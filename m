Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6DF51E90E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 20:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446767AbiEGSGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 14:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446748AbiEGSGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 14:06:52 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252892CE11;
        Sat,  7 May 2022 11:03:05 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e2so14042102wrh.7;
        Sat, 07 May 2022 11:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D7VtlgOsRgbFduqgmvE9B7kMfxFi0Jdh2MT6Sj/9wbU=;
        b=UXpTm9/8iVMwJ68tlYJQAFO4W4iNPNHGqWu7c1aOkfbiiI7sXHjvZSrk77C+ozGT3h
         X4lJlemZ5JkEcfIux7W6wGoKbllqParKp/8FTMGpzWQYzCoUfaieR9F8KngSBBt5x9Ki
         5+tzPLGITvCVuVCkjg7LZ+wsa6+Xsse5nbJCwRADQMcWikk3f2CHDWsTlKUX2/DTtGqh
         u5ugstVN1Gcfo9EtYDoxS5gA/vC6YMcN0AS02X6vFoiMRK6QbFiAV4JaEm/OU7Fjd0Zi
         WqhHoFZeXRkpyN4TWMJq/PTJAzwQjU3c5nKAvHNsYpxSZfyorqRFCrz1zKmGxb60an6w
         irHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D7VtlgOsRgbFduqgmvE9B7kMfxFi0Jdh2MT6Sj/9wbU=;
        b=0BMIty//4ANqlY3FjYQkv+OpbMlVDvXDEjlJsj8B5yAiism7e5b8AqjGRU1FmteWnC
         fQoMC7mBIN8Ewao5Rn60cBtkwP94pabqc2y6GB+XHVD/L2dnV4GFep+g6sY/o21CB4gF
         +DlcYYMMogG/V8VEykx6ho1guSjyNNf8wkfuyQMIGciz4l+5Vsmp9m6w05SXqAEsNjlx
         ukGKNiGWUzaiiVgSev3F4SZd50MbGXjkJSLL4kt748LjG4I3wKKN5kX+WF7ZYhMmVD+y
         aEvq7h74Jjp0ftuSJVbtQrIA7CNkKa7xkv+U4C+y45nL5AmAJdhSFwSRUz6AcwYKVHc6
         grCA==
X-Gm-Message-State: AOAM532s4xsT/ugdxrNXYXoZnSaDntx+OuIFwBGGtoQvr6RROoXV55HV
        Dyc4kQiXC5MhzBUc/SA5SD/HEbY0+Jo=
X-Google-Smtp-Source: ABdhPJzG5ttqjWeUlkVS2RItfVD/Q6KF+SDkvOoT5ySwDBUpkUOHyPJzih+GFjsN6KYpRD4014eJMw==
X-Received: by 2002:adf:e60a:0:b0:20a:c402:6810 with SMTP id p10-20020adfe60a000000b0020ac4026810mr7856140wrm.45.1651946583586;
        Sat, 07 May 2022 11:03:03 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c4f9200b003942a244f57sm3176153wmq.48.2022.05.07.11.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 11:03:03 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: tuners: mxl5005s: make array static const, reduces object code size
Date:   Sat,  7 May 2022 19:03:02 +0100
Message-Id: <20220507180302.25853-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Don't populate the array RegAddr on the stack, instead make it static
const. Also makes the object code smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/tuners/mxl5005s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/tuners/mxl5005s.c b/drivers/media/tuners/mxl5005s.c
index ab4c43df9d18..3a509038c8df 100644
--- a/drivers/media/tuners/mxl5005s.c
+++ b/drivers/media/tuners/mxl5005s.c
@@ -3637,7 +3637,7 @@ static u16 MXL_GetCHRegister_ZeroIF(struct dvb_frontend *fe, u8 *RegNum,
 	u16 status = 0;
 	int i;
 
-	u8 RegAddr[] = {43, 136};
+	static const u8 RegAddr[] = {43, 136};
 
 	*count = ARRAY_SIZE(RegAddr);
 
-- 
2.35.1

