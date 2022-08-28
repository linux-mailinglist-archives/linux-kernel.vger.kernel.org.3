Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3284B5A3C75
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 08:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbiH1Gya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 02:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbiH1GyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 02:54:17 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268065467A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 23:54:16 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id og21so10099618ejc.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 23:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc;
        bh=1wt0+COcPjG5YjKoTxhU9uwwc/yZk2YLcRZA3ZenJZU=;
        b=Nsd9KvhZQcsnvM47UEMphvAImdicUWJKQkwR/F+vkuVw9WLLd6Te/QbTsAe9hLNTYc
         l0dgbulfF55UR6nj12s6QeR9e1hQ7O4H5IvCN9SFZVbpultj7qQGYZ+/mcdYfyh4hcH6
         6e3rmwtjeeBSiajAd4C16Nmtb/TnC+b5K1j4zCksKQaDz5QS/3D2wsWM3umPyzy2TtG1
         5sSC6UzRZZ+XW3B7w11thdAv9hDFUCuaGFfp59+iKBLhTJfZAZpuALAG+PMo/r1nIg7K
         zEJKOk1Kd7Z59t9+CR9Oetz6A9kitHD1sYqdaTlG1corFYsKbDajrbYwdiUoJB4hfHyk
         WQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc;
        bh=1wt0+COcPjG5YjKoTxhU9uwwc/yZk2YLcRZA3ZenJZU=;
        b=y/DNuSQl53LlU+pHjBe6FBdSq6Drk+9naVIQLpCqoozkrIt9bioIn5kwEg3+JN7kR+
         RALsZdqhVG7GSEnCYV6KjYe0NnvbIqgp3idgKzQbPeWWdb0vL2dJucRysQlypgmYQl5N
         0YMJaHd21cZO7bnxY95DQeu57ZVl+NLrOdqMun/6O7hzA8Ng1KELVjQ2k3o79cgdVHTq
         GKr7OIRinr8VxEM9JXywsqGqs/M4+s5KIddUaLPRHIS6XDzCUdcdJGFTe8aTSM3Sd2X5
         LTVupTEjloBvWmt+QEfMCaEqgAmWY1V3AHcJkszEnv56cri7E873HF/2L2JZT3INOKXQ
         K1RA==
X-Gm-Message-State: ACgBeo2ujpprNc/uZnB7pdgxFTBHQ47Ll/DgA/ZBlKqJu9Q2S/DPVP6t
        ryx6YY6BpIcnkhQNeAhnE4AFUvOd1hg=
X-Google-Smtp-Source: AA6agR4i+Oaws7v9FGF5ZqJl637PJLAFC7nZoP3ZjgGdvD2Diee1LI8k+YHpXyfgAKimvYEezvCoTg==
X-Received: by 2002:a17:907:2cc1:b0:73d:c2d9:3232 with SMTP id hg1-20020a1709072cc100b0073dc2d93232mr10190582ejc.763.1661669654686;
        Sat, 27 Aug 2022 23:54:14 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id e1-20020a50fb81000000b00447c0dcbb99sm3865125edq.83.2022.08.27.23.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 23:54:14 -0700 (PDT)
Date:   Sun, 28 Aug 2022 08:54:12 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] staging: vt6655: Replace macro MACvSetRFLE_LatchBase
Message-ID: <624068fef03d5226e3fb2d31d47e9dabc5562b3c.1661666677.git.philipp.g.hortmann@gmail.com>
References: <cover.1661666677.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1661666677.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro MACvSetRFLE_LatchBase with the called function as it is
just used once and to avoid CamelCase which is not accepted by
checkpatch.pl.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/baseband.c | 2 +-
 drivers/staging/vt6655/mac.h      | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index 5de841cb776c..6ce41983dcf4 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -2083,7 +2083,7 @@ bool bb_vt3253_init(struct vnt_private *priv)
 		priv->dbm_threshold[2] = 0;
 		priv->dbm_threshold[3] = 0;
 		/* Fix VT3226 DFC system timing issue */
-		MACvSetRFLE_LatchBase(iobase);
+		vt6655_mac_word_reg_bits_on(iobase, MAC_REG_SOFTPWRCTL, SOFTPWRCTL_RFLEOPT);
 		/* {{ RobertYu: 20050104 */
 	} else {
 		/* No VGA Table now */
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 3af8abc305b1..2af243b9389f 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -541,9 +541,6 @@
 
 #define VT6655_MAC_SELECT_PAGE1(iobase) iowrite8(1, iobase + MAC_REG_PAGE1SEL)
 
-#define MACvSetRFLE_LatchBase(iobase)                                 \
-	vt6655_mac_word_reg_bits_on(iobase, MAC_REG_SOFTPWRCTL, SOFTPWRCTL_RFLEOPT)
-
 #define MAKEWORD(lb, hb) \
 	((unsigned short)(((unsigned char)(lb)) | (((unsigned short)((unsigned char)(hb))) << 8)))
 
-- 
2.37.2

