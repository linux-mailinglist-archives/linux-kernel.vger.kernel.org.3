Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345D159FE69
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236726AbiHXPdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbiHXPdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:33:03 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E8D205DC;
        Wed, 24 Aug 2022 08:33:02 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id h1so8948522wmd.3;
        Wed, 24 Aug 2022 08:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=L1CRzway24QdCfBYns+2r9yxTGCOw/2hnCmosLBB2r8=;
        b=jLnr4rEjiEXa3dBspon7XRBATWKHOlqWLCYcOka7m9rDZ6U4pw8kV+xEbE4di16kaW
         Qm+gY1iAC2FrlT3ohk8Im329DbQZsBSfG1OH7x66oh2JPUWA2qsbG85itfFyrfiD1+8E
         JN+H+fk7leDmk0R1sDjBpXZ3ptRt5KkRqnuugbiPB+IjEOVQH3/fbABfdNiGLEXQ9Z1c
         fHHa83dsJEWnKWbunxtxIC9ykyShW2YHKGPETqKEX4SPPQ435XPSExFbXHiayB7LHHjO
         EzuaYcnmdhAcIk0icmG5A38j8Fcci4rOVqxQe9zAAXebWshCkL2iBZKegWHiVmUOulN+
         2SHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=L1CRzway24QdCfBYns+2r9yxTGCOw/2hnCmosLBB2r8=;
        b=vR5pDm/7/VKRY2dygnc1cfiJlW2IPhN5pZnA7XVSVdS55QkWyIXaNv6gUu8qrU+6U9
         seC2EEvjXHBOPRQJ7+D07ZihvbfILvMauezc5jRGzSUOb1yezNPmDbTc+vqS82vSfzvH
         ZvSLsRK38xHihlvIIrle8+YIw1ft/DFx9qEL1JI7E+Rq5C8qQloi7YiBsW4E+2fMG+ja
         VTird9H9nidqItXSjHlHZkl0RMTxPcvSJ4ww2JGYGGCcpYaeJAiz1rYpybuuM4TyOj7a
         1uUzKNGKewV3tHoiBBzmwMbC952VSrGEuz8BxmxJ3M63FZBKAM99YDP0+M5HgWv1fPg+
         osSg==
X-Gm-Message-State: ACgBeo32aepOYTOnig+Z2ChxT48QechbLPXHWAj+szkPJ+Ep+19dqfPX
        BdR0GkfV3ZQKRPkCm46Lf0k=
X-Google-Smtp-Source: AA6agR6JgFXxoSYlgrTlnkUOgrbnMrCnYd8RxmpJNC5g5B4cmNPpTgbwIN5AEdLHZ8gdlNHpActs+Q==
X-Received: by 2002:a05:600c:35cc:b0:3a6:f08:9b1 with SMTP id r12-20020a05600c35cc00b003a60f0809b1mr5507116wmq.22.1661355181191;
        Wed, 24 Aug 2022 08:33:01 -0700 (PDT)
Received: from localhost (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id y8-20020a5d4ac8000000b0021f73c66198sm16902283wrs.1.2022.08.24.08.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 08:33:00 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] of/device: Fix up of_dma_configure_id() stub
Date:   Wed, 24 Aug 2022 17:32:56 +0200
Message-Id: <20220824153256.1437483-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.37.2
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

From: Thierry Reding <treding@nvidia.com>

Since the stub version of of_dma_configure_id() was added in commit
a081bd4af4ce ("of/device: Add input id to of_dma_configure()"), it has
not matched the signature of the full function, leading to build failure
reports when code using this function is built on !OF configurations.

Fixes: a081bd4af4ce ("of/device: Add input id to of_dma_configure()")
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 include/linux/of_device.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 1d7992a02e36..1a803e4335d3 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -101,8 +101,9 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
 }
 
 static inline int of_dma_configure_id(struct device *dev,
-				   struct device_node *np,
-				   bool force_dma)
+				      struct device_node *np,
+				      bool force_dma,
+				      const u32 *id)
 {
 	return 0;
 }
-- 
2.37.2

