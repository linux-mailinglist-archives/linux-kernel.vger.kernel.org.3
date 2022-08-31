Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75BB5A7479
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 05:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbiHaDbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 23:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHaDbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 23:31:34 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9597D4DB74;
        Tue, 30 Aug 2022 20:31:33 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q9so12417747pgq.6;
        Tue, 30 Aug 2022 20:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=baY2iE9jN63ELxW+7nYlod339UpmE9j5lCsEmT9/vQE=;
        b=lw3ewESlvfVEfgaTlG7BXpOsACHMhxcVlFxiWhiGkBPWwBpZWt61tH/KgA3+TDKh1p
         BKn8vnJojOGZK4TT0FLdhSi3reykb/5C4vVGW8n9pyB2wkD3aCPYOEEcWL4LnHoHUx8A
         lRLXLg16lnwmPxSts6mriPtgJTxTqW9yn+0m0Pnema5k2CQspVcJm+/qHNKiIPPK3Iom
         KFjECmuze0HYP+j6UXq+qUEBrtlM5fYCEjNbtRmqK4Tpq9M7rI/8agKf9T9tPvo/q1a5
         ZlRfYal+hZxVFUwyZ0FTSKfxzyxHaFe0hqv1V/J9T6w2HXbHibrS/YDgaw+XKbwS7ojO
         iAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=baY2iE9jN63ELxW+7nYlod339UpmE9j5lCsEmT9/vQE=;
        b=NZQCDpe3J8zxB3m8rk7m+UJNVnLd459QQlQUmGvBPok/ygIQZDriAsaKfFBDvwOMdo
         4XuwmhOD5xmJjBjk6qwK9hOHCQlwLQjplZzQP3dc+H2Hyl+WWIdKutrjOn9yGSfSs4rw
         JVb2v25VJfysPhUCA82sUbvULeYTxY83ydh/HuAvz1a4cIQ1u624DmExnYBlqhfo+zSA
         CiQAyCQMhn+2hNX+ysAAJAfDIrZRL2pR/7Fjgw4grMe6NloKBawmxzE21T47vLJfty/W
         ftYRzKIRNdQAn+5xzdFisoMCdnHr3CIWLIMtGf7DITtbP5Wydt3XZ8c4hcD+52EaREV2
         gILw==
X-Gm-Message-State: ACgBeo34CIm2bxJP1oOvU+NGA4J6wldx/R2qQlJ0L0CEf8etY9Im1ERr
        bdhSwvK9slN9VDAKrbGI0Fo=
X-Google-Smtp-Source: AA6agR597aRKL83nEXdzZtBPT8WpY+zb0Vni0+r46xip3mPpbblSbAlVR2MvPf+TSpgLf2zqjMulrQ==
X-Received: by 2002:aa7:8096:0:b0:52d:d5f6:2ea6 with SMTP id v22-20020aa78096000000b0052dd5f62ea6mr24799324pff.0.1661916693152;
        Tue, 30 Aug 2022 20:31:33 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m1-20020a1709026bc100b00172d9f6e22bsm10439894plt.15.2022.08.30.20.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 20:31:32 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     rafael@kernel.org
Cc:     keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, lenb@kernel.org, james.morse@arm.com,
        bp@alien8.de, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ACPI: APEI: Remove the unneeded result variable
Date:   Wed, 31 Aug 2022 03:31:23 +0000
Message-Id: <20220831033123.301988-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value erst_get_record_id_begin() directly instead of storing it
 in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/acpi/apei/erst.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 31b077eedb58..247989060e29 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -1020,14 +1020,10 @@ static int reader_pos;
 
 static int erst_open_pstore(struct pstore_info *psi)
 {
-	int rc;
-
 	if (erst_disable)
 		return -ENODEV;
 
-	rc = erst_get_record_id_begin(&reader_pos);
-
-	return rc;
+	return erst_get_record_id_begin(&reader_pos);
 }
 
 static int erst_close_pstore(struct pstore_info *psi)
-- 
2.25.1
