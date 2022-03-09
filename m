Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00234D2BA8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiCIJVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiCIJVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:21:07 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EEA1662E8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 01:20:08 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id s10so2067684edd.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 01:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nx24Pu2EtMIRNca2MHSzdGAjeTosa0c/taIRiMOtw1w=;
        b=Ebr2QynI5+t+8mrz83naeQWY1VBsYxUnEqRo8KV3wLAUgUfHhYg2ycxWNFFW6JCsl5
         8l7S58NSbq4paJt8UktEBhpQrMxMYU7roFGK/bRK4Vv022j28QtzHq4Lp8E3Z8TRqJrG
         6zDXYHdtc+pCBcucUn13KzRTRJArWv3H1XKqbAMB4r7o5zE/iSwN7hfjzu+HRZxRuGpk
         +c0x3jejRmSZRK60roVk4RuAVbvh0Aw3u92mN4VWCfqhKEO2XPv9YDCTxc9TBYxh6sm6
         ihfMclaidwhuYjaGvNtWNx1c1UNo8nbHC0fM9OOWowhS6HSLdssJ4F/tPTVYnIWLAjuk
         1Nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nx24Pu2EtMIRNca2MHSzdGAjeTosa0c/taIRiMOtw1w=;
        b=BhzNOPp/mCnivc5+7fG+c9lP9y1tIEdTkpoLlE1uWdktYBp4iGT2R5J6U1G+ntzdKg
         Dx8btrSmWLfxG+PHG+By7xpq8NhOAjy1LPZKdPHq3jbSWbcbpA3is3J+JWg1nfPTO9v3
         cAJ3lANxEzfRb29quCW445N/QKHRcljPMGArYwrgRxeFvCHneuAYhEMiroRMBFdP6hnY
         e7bcpmI3HF36HLpvP1z23M/DWpbpEijgve8cWOZ5mbyMCWwFZZ8PTO3n3wUJ1zaJeWap
         dWqyPw0TJ95oTMR+zHD9ud5K/KqLWcRLfgGBa8X30dDruguLAMjTb79Bg4ovEzFuyiig
         1rNQ==
X-Gm-Message-State: AOAM533nx9nGf0e8olQT2seTpXjIswzP/evy2TKVcxEMRG9SACQ7lydZ
        TQOZlMjPSQU+KYQQwllgctAmeEoTMI7XEJNl
X-Google-Smtp-Source: ABdhPJwlr/F3OrZaJ4msyWEoYHHKLGLeqryW4s0iXM2qWM9whSkmMEfDgyK8NOaJxoR84NZSwkIdOg==
X-Received: by 2002:a05:6402:1e94:b0:416:44fa:ef49 with SMTP id f20-20020a0564021e9400b0041644faef49mr14497527edf.0.1646817607277;
        Wed, 09 Mar 2022 01:20:07 -0800 (PST)
Received: from localhost.localdomain ([102.126.147.138])
        by smtp.gmail.com with ESMTPSA id r29-20020a50c01d000000b00415fb0dc793sm535180edb.47.2022.03.09.01.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 01:20:06 -0800 (PST)
From:   Hatim Muhammed <hatimmohammed369@gmail.com>
X-Google-Original-From: Hatim Muhammed
To:     linux-kernel@vger.kernel.org
Cc:     greg@kroah.com, abbotti@mev.co.uk, hsweeten@visionengravers.com,
        Hatim Muhammed <hatimmohammed369@gmail.com>
Subject: [PATCH 10/10] Constify comedi_lrange struct pointers
Date:   Wed,  9 Mar 2022 11:20:03 +0200
Message-Id: <20220309092003.13928-1-hatimmohammed369@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hatim Muhammed <hatimmohammed369@gmail.com>

Signed-off-by: Hatim Muhammed <hatimmohammed369@gmail.com>
---
 drivers/comedi/drivers/jr3_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/comedi/drivers/jr3_pci.c b/drivers/comedi/drivers/jr3_pci.c
index 951c23fa0369..f2a750a9112c 100644
--- a/drivers/comedi/drivers/jr3_pci.c
+++ b/drivers/comedi/drivers/jr3_pci.c
@@ -90,8 +90,8 @@ struct jr3_pci_dev_private {
 };
 
 union jr3_pci_single_range {
-	struct comedi_lrange l;
-	char _reserved[offsetof(struct comedi_lrange, range[1])];
+	const struct comedi_lrange l;
+	char _reserved[offsetof(const struct comedi_lrange, range[1])];
 };
 
 enum jr3_pci_poll_state {
-- 
2.35.1

