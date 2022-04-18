Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7703504F21
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 12:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237769AbiDRLAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbiDRLAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:00:41 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8451A041;
        Mon, 18 Apr 2022 03:58:02 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id s70so4112622qke.8;
        Mon, 18 Apr 2022 03:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QTXRFs2PytkMyP9ASrbRnHHexSgu0R0pi23SwXdO0/c=;
        b=IHX2OJr8DTLq85Jmi7N5LImLl+m3uSg2nld7fNoRdygSzMu3wFtYexjiWrRzHXNQy/
         hJyb7nqcAUK/TzNTt8pDZ02DUgH6F1GR7NKsDshpvXZ26bCEuyhrrVWWBe4sQorKTB51
         nCEwIgZ5XGsqZgMrkqEpdFe8iswQgItsGpPK+SAeHDq4H/1E0+e1oMqj6V0JdE2Dy3L+
         ge1goZJqavoNJidHaIEZXIS+3dJuNjUfWhtRpkJq27atd5Vrbo2rkkVIxhqihDhYLddM
         fdFApmv1JAeKBiChd4piw5dXYGGDg4Ddy6hE4yp8g+N2j2aahHFDG2VyRUlUbKSMN6D3
         FdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QTXRFs2PytkMyP9ASrbRnHHexSgu0R0pi23SwXdO0/c=;
        b=CsmQzfW9o2QEtXjjj6E5D4+VRQGeXiUgmdTVMo1wMeYYXKKYTjIf31KovKEl1vFOqP
         ZMeVOGrDSKyGZpnnvmylKBx6G66qf8akad26pjVD1z51KlqR1v0osjxX1vuePUMCCM84
         BY0MD+05P850lwyFM4Tpj47P81WREmQ8zcgPl9z6uKVV4BRVTdVSqysEGdyqwN1f6XcK
         PYybU+U5Q7xJND5NoFE4Kb7oy825ZuDOfd7u+l9Ug3xLo1AMJiAeAvr9q+puRjqY5kZz
         7BxvHNPv4PH5boXHhmk882+l17obwSekKIf0aDmCe6IvbXoSVNYaPyW7cfVR+Qb3Idt3
         8Anw==
X-Gm-Message-State: AOAM531gKUxBEuUw+G+GUhat8+pF7PySU683+NbrLNw6iLsjuK9j4Fq2
        V9KJfHGXKX6zD15APVABqpc=
X-Google-Smtp-Source: ABdhPJzyKFaKK/7ykT8e3LhuItYakhZWqcVL29ecH5a6bWdpdhCYZgeNp2FukVe982PbFK4YAgHfMQ==
X-Received: by 2002:a05:620a:440f:b0:67d:2133:ec26 with SMTP id v15-20020a05620a440f00b0067d2133ec26mr6266601qkp.658.1650279481733;
        Mon, 18 Apr 2022 03:58:01 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id l19-20020a37f513000000b0069c5807ff10sm6528279qkk.27.2022.04.18.03.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 03:58:01 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com
Cc:     shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, megaraidlinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] megaraid: fix error check return value of register_chrdev()
Date:   Mon, 18 Apr 2022 10:57:55 +0000
Message-Id: <20220418105755.2558828-1-lv.ruyi@zte.com.cn>
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

If major equal 0, register_chrdev() returns error code when it fails.
This function dynamically allocate a major and return its number on
success, so we should use "< 0" to check it instead of "!".

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/scsi/megaraid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index a5d8cee2d510..bf491af9f0d6 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -4607,7 +4607,7 @@ static int __init megaraid_init(void)
 	 * major number allocation.
 	 */
 	major = register_chrdev(0, "megadev_legacy", &megadev_fops);
-	if (!major) {
+	if (major < 0) {
 		printk(KERN_WARNING
 				"megaraid: failed to register char device\n");
 	}
-- 
2.25.1

