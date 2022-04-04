Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAE24F0DEE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 06:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354393AbiDDENY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 00:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbiDDENQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 00:13:16 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D11715A06
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 21:11:22 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so7848839pjk.4
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 21:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mmN7qtmnz9zJj+1xO5pDRuU70Xzo2jJcKr0sswtR2JA=;
        b=YhYyGtNTV+WpURFXebyNjUmPMblXNGgVGmDeL/ONC6eWKIhn3ZxB+jPYb//rCIdBNf
         u61GoO3kMvMBPqukrOIsONqSM5SvtOGiCLoPoqF3osM2bvjo6wGDQiI3FBOunsXFeUwd
         Mi05Gg7bCXubuHuKbvwdO6+/6jXTuGgdco2xFaUXf514EbMe6Tbm5XgYPRcBnmk+xPOW
         l2KL7mMZnjeR2jpkGt2d+QsOuj+Q4jyEPaPdeYSzB1W7ZRSKfScyn9DXOObWtjuz1iuj
         KfluTkS3dRUVj/oMhONDVj2Iak0G9I363XaZU/pxaZ+4T5PRpDNCEI0eQvysr6wZSvUv
         FCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mmN7qtmnz9zJj+1xO5pDRuU70Xzo2jJcKr0sswtR2JA=;
        b=j1emYZ7Iqvp0qaH/wBrZD+pSBlRFVLxuwCUjNPs1dnJ2CIFXf1ESmFNGV4RUn4ap9r
         vQi/LL/vJMZK99A9wBSN3F6YmsDxtbMdeCuqprW2c/oGwLzL7TH0Ru4wFfJ/SE1YSvEr
         k9KiVtOZguHrdxjov6IsBswIaOwJuH+U7Pefhcyrc/Ja+g+/yDydjYUvq1zZxFqvmyN9
         M2vSmAfClGq8/OD6rtpop1WtvREXAHL6AJ+kSqorhB3yAhYKH/dmzrw54xb1eYUvSmic
         M5+vJW1NQbrNEsy0o96rddf1abd4NcIpBzDf8MexZLezh+qLBQsK66FQwTbZAUHw3ef6
         cnNg==
X-Gm-Message-State: AOAM531ftVMKUtIQQ1u7CqcDAIj7AF/FI2FO/bfNXbqbjgtz/UVz9KKi
        DLNIcpYjWY9+9eVEcV7xA+MrMAmcnuI=
X-Google-Smtp-Source: ABdhPJxii3cMBBdQUfskIVXUrDArJikACE9u3FZkmsIVlTucBiyOSn1Atuuz0jETrgJfiv69ojYrMA==
X-Received: by 2002:a17:902:ce90:b0:154:3029:97e6 with SMTP id f16-20020a170902ce9000b00154302997e6mr20863385plg.111.1649045481102;
        Sun, 03 Apr 2022 21:11:21 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id x123-20020a623181000000b004fdf99d25f6sm2882641pfx.80.2022.04.03.21.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 21:11:20 -0700 (PDT)
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Akihiko Odaki <akihiko.odaki@gmail.com>
Subject: [PATCH] platform/chrome: cros_ec_typec: Check for EC driver
Date:   Mon,  4 Apr 2022 13:11:01 +0900
Message-Id: <20220404041101.6276-1-akihiko.odaki@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EC driver may not be initialized when cros_typec_probe is called,
particulary when CONFIG_CROS_EC_CHARDEV=m.

Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
---
 drivers/platform/chrome/cros_ec_typec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 4bd2752c0823..7cb2e35c4ded 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -1084,6 +1084,9 @@ static int cros_typec_probe(struct platform_device *pdev)
 	}
 
 	ec_dev = dev_get_drvdata(&typec->ec->ec->dev);
+	if (!ec_dev)
+		return -EPROBE_DEFER;
+
 	typec->typec_cmd_supported = cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_CMD);
 	typec->needs_mux_ack = cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK);
 
-- 
2.35.1

