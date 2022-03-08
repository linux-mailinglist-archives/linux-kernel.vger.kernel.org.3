Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E18E4D132E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 10:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242090AbiCHJSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 04:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiCHJSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:18:03 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012E740A28
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 01:17:05 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id a14so2672225qtx.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 01:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QmFT5oX5WhVCf23K5lxag7wmD3+cmFNslYfO7qqS0x8=;
        b=O81yMp+25f3i4Ba9tRiFQz+DjxkdQvAuD7tM0reOk09HYPu27Ez//y0oCxFyKkVdbX
         R/sSoBoeDiFo9s4tYx2XUwDDcYv11O60isHjmVp68H+cDOTvi8MFquadaAVoClk9ja+v
         tgqVtJBnuu5sX6ALII+KxtdSdNG5YJKvNgNsV1Ul3e8zr5lBnLNM1T5puAZuTVFRO7fD
         ksosDAjF0UEXLdmjHrelsegsOtaPWnWvGdg7sUT57j0chxw3HyjuLjYpPYcdYKd6K5Sg
         VpzY5pDcfNa8suOuQoEaU1G9l/32J/ptGF+spDzNB9CfSYivKYkjoiflodvPIwrU+pjK
         AQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QmFT5oX5WhVCf23K5lxag7wmD3+cmFNslYfO7qqS0x8=;
        b=59j+BWf8nKAA5nBVw7BVJfOsoQ8KReXzNpmkVYIRIzC+BBBhMVka9ARi89+z/2gxXl
         xHi07G6XhT2jvPtn8dxwV9VCdh2fJkxVMPvKuevJm0LAYM+y07Fs8leXPCumtpZjih0i
         Z38qlnHIqMOwkDk04tgeR76ee2r2q6RfV4dBwmfJCAuVruZXyUszvbupZW+WrLFnfw5q
         zfh3Htdm9PgUGkbC+t1Jg0PBQX1jr8Mz3oG34LqKX4rUKLIOoziU0hf+mbhkWgPqVdGZ
         JtwQT0JONS2CvP57z1/fv6AIOaq8UYrj70+O52EPvaokNS6Ay4exaBShRM1nDyE3FWvS
         Qh/Q==
X-Gm-Message-State: AOAM531yPOw6Mec1WQJemBB32ebdeDGtwh/JpVYMcaK2ayn9MrZ+iiG0
        cG9IguZUjGptjuLiSEKpFDWi7MdFxoE=
X-Google-Smtp-Source: ABdhPJxfpMw9rImA2Ik5e7BO7RxSWcCdqoCiOk0uGbtELOW0XSZkacMxARR5CzcafSh1EaJcCfPZNQ==
X-Received: by 2002:a05:622a:13c6:b0:2de:8901:e3dd with SMTP id p6-20020a05622a13c600b002de8901e3ddmr12911101qtk.16.1646731024127;
        Tue, 08 Mar 2022 01:17:04 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c6-20020ac87d86000000b002ddd9f33ed1sm10976726qtd.44.2022.03.08.01.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 01:17:03 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     joonas.lahtinen@linux.intel.com
Cc:     rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch, ville.syrjala@linux.intel.com,
        hdegoede@redhat.com, lucas.demarchi@intel.com,
        deng.changcheng@zte.com.cn, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/i915/vlv_dsi_pll: use min_t() to make code cleaner
Date:   Tue,  8 Mar 2022 09:16:55 +0000
Message-Id: <20220308091655.2078825-1-deng.changcheng@zte.com.cn>
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

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Use min_t() in order to make code cleaner.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/gpu/drm/i915/display/vlv_dsi_pll.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/vlv_dsi_pll.c b/drivers/gpu/drm/i915/display/vlv_dsi_pll.c
index df880f44700a..f801f7ec3f9a 100644
--- a/drivers/gpu/drm/i915/display/vlv_dsi_pll.c
+++ b/drivers/gpu/drm/i915/display/vlv_dsi_pll.c
@@ -393,10 +393,7 @@ static void glk_dsi_program_esc_clock(struct drm_device *dev,
 	/* Calculate TXESC2 divider */
 	div2_value = DIV_ROUND_UP(div1_value, txesc1_div);
 
-	if (div2_value < 10)
-		txesc2_div = div2_value;
-	else
-		txesc2_div = 10;
+	txesc2_div = min_t(u32, div2_value, 10);
 
 	intel_de_write(dev_priv, MIPIO_TXESC_CLK_DIV1,
 		       (1 << (txesc1_div - 1)) & GLK_TX_ESC_CLK_DIV1_MASK);
-- 
2.25.1

