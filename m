Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA77A50D702
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 04:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240351AbiDYCpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 22:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240266AbiDYCpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 22:45:00 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D90F63515
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 19:41:57 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id o18so9507730qtk.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 19:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gImJskEZbUGQq/yGIUbA5C1222sfBMsWHD6+YF3THPg=;
        b=fmJQnQsXpPKz5cvRtNW5sdyaLchbq1R/zwtRKKM/0+eh+reY//gd4nzYNYVIauTvAo
         EY8Bh2mSzv9R//p+s87rqTuvX+awWpeUMMcZjN2mMkUxta/uJYZDh5kI4devsG0jRXTt
         T+16Z0i2ekWA8v1qiqyzIIOZsu/XSBrTkOGmUBgEuE9L5fs9vYQQEflyeBD4L61q0FhL
         GU4XmdC7+5RV671ujlZYnQowYylmd5CCgmGVI2lUW7JDu2v0ZmNDhFYZgwaijXL1dDc+
         xoQDqq1jC1jWVSJ4VIBZ/lXd5hFuX4Yhk33K9WNoi5y4RFzFafc5VVSyrDqfuGF6Hkpj
         1omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gImJskEZbUGQq/yGIUbA5C1222sfBMsWHD6+YF3THPg=;
        b=rQQ5XBLRhAKwRun4wsEFnN9z9Q+Jh0Nq2wc7QHLVnV/wHUd1NEhK6nP1sbv2/qYf+6
         lTMAr2T9gsvTHMEpMnMK05VLNIL5hGzD3FBXrSleh2yabidH2irTNxDKJRzqslR5gVNI
         jniZx/9uk/2GHt+oQ92C9IM6YJnh2G8sTvjMSmejoDscVFqxylYVnlfZFbwKK6cLfD8i
         WehBaSPF57/Q7sfmuNWqq9yV/6M2ro1ML1KemaIhjkKK0FqTN9ZrWnV4XDIGiyvfzFUX
         9/HYWyYApoGqgy9TckRXCf5ZFwW9jwdLYOGx+/xXqUneAMLz0jtrt9QMVKiHYpkMy2tW
         bMJQ==
X-Gm-Message-State: AOAM533i2CnhjRGMe7qBvz4IfvMY2XZSBz2489WVeW/DcAM9/PCxxSte
        IMKuK5rA8blJx8ZXw0ZRsERdlrQ6tek=
X-Google-Smtp-Source: ABdhPJwcntiUs7bpeBa07P0pFsaSM8L/5aS0IxSHCE8hk5PK/PHMtzYCO9tfOug8sAfJ0Y1MIyZ5pg==
X-Received: by 2002:a05:622a:19a1:b0:2f3:6a7b:25ff with SMTP id u33-20020a05622a19a100b002f36a7b25ffmr1102318qtc.13.1650854516591;
        Sun, 24 Apr 2022 19:41:56 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p3-20020a05620a15e300b0069e5b556f75sm4298227qkm.5.2022.04.24.19.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 19:41:55 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     mpe@ellerman.id.au, benh@kernel.crashing.org
Cc:     paulus@samba.org, maz@kernel.org, jgg@ziepe.ca, tglx@linutronix.de,
        lv.ruyi@zte.com.cn, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] powerpc/fsl_msi: fix return error value in error handing path
Date:   Mon, 25 Apr 2022 02:41:49 +0000
Message-Id: <20220425024149.3437751-1-lv.ruyi@zte.com.cn>
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

This function fsl_msi_setup_hwirq() seems to return zero on success and
non-zero on failure, but it returns zero in error handing path.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 arch/powerpc/sysdev/fsl_msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index b3475ae9f236..10f974cfa2f3 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -353,7 +353,7 @@ static int fsl_msi_setup_hwirq(struct fsl_msi *msi, struct platform_device *dev,
 	if (!virt_msir) {
 		dev_err(&dev->dev, "%s: Cannot translate IRQ index %d\n",
 			__func__, irq_index);
-		return 0;
+		return -EINVAL;
 	}
 
 	cascade_data = kzalloc(sizeof(struct fsl_msi_cascade_data), GFP_KERNEL);
-- 
2.25.1

