Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F624C22C6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiBXD7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiBXD7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:59:04 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8808D25D26E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:58:35 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id t12-20020a17090a448c00b001b9cbac9c43so643090pjg.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=S/BktkTRg3IeOBKPRorlYf8cDypH5GwEH28l9JcLNGU=;
        b=ZQv2vKvk1pOFvbCHKtwEOcwunkRUKdEYXB3FRaaa1IRk3ge8LuaPQw3HhcCu12PSWn
         kfCVvYbvALDA+VKUM9caWeWM6Vi0SWRYp2nwzvQjeM4t0D+QyxLMhLkLCNlGm455POwQ
         GEtOAUlw0jbBFQTDccVh/sPZKHD0Is8L0KnY/3UFcE4KlnWmnTv1DgIg3wR9wYaP0j79
         aWlx8j+W2oMu5a6mOk3M71HzQv63tooHPxgF3QU4KD9NNYO7IfDVitzwHSskyRd2Mcq6
         ZFQHf1OMvGTZfeBMD+Jv1+6fn4xE4y/xEcb+gkgeBT7Q0YLFmvQceqMZm9Vc7O4ol467
         XS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=S/BktkTRg3IeOBKPRorlYf8cDypH5GwEH28l9JcLNGU=;
        b=V0Fh3xKffnfS+OI4pvpGUwMhSG6iVvDcXPkzO4RhfQVts0VSAzhWorRQxitxlOda1n
         vLjUb3oMgaFZmM7hQeix2dl8zzH7svUTNRwRaEpheBif+2OaQCG5XuUuV2jPlcmvhYT6
         wdgcpHzRvnRY9RY5EeeUxjYPbbpfiDEnbT2uFqB6+S9pOneYeLCIJfc71z2q1rb8TeUO
         6cLJsQIEYXx5dq3PZyzkruWt/OoRgPKB/mBFrsVQfbbxrzyQ5468ySXQTS61fpDouNmo
         Gu8LJFbzn23Y5CPAsUTPwTQMUK1f0ecaHyOK4N1jb7LAF5UXHsk8F2lLKLYD1DcfZ5JI
         nrKg==
X-Gm-Message-State: AOAM531BcdZsaQiivMS1+NvEbQUpJRsznyBNfzQuNNolVasv3JW02iVc
        Ul7FHThbUlCunWOQ3Mf0Nvjgez7euzXc3w==
X-Google-Smtp-Source: ABdhPJwbv0RBFl9Vkc/6rlQfWONrAPccTmsZ4K0XwDlcMLb+tBigsUI7IXGaatRjiIPnuFbk9rpA/+7gWSR9dA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:aa7:9911:0:b0:4e1:3a76:96f8 with SMTP id
 z17-20020aa79911000000b004e13a7696f8mr1055845pff.28.1645675114919; Wed, 23
 Feb 2022 19:58:34 -0800 (PST)
Date:   Thu, 24 Feb 2022 11:58:19 +0800
Message-Id: <20220224035819.1593730-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH] Input: samsung-keypad - Properly state IOMEM dependency
From:   David Gow <davidgow@google.com>
To:     Joonyoung Shim <jy0922.shim@samsung.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     David Gow <davidgow@google.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the samsung-keypad driver explicitly depend on CONFIG_IOMEM, as it
calls devm_ioremap(). This prevents compile errors in some configs (e.g,
allyesconfig/randconfig under UML):

/usr/bin/ld: drivers/input/keyboard/samsung-keypad.o: in function `samsung_keypad_probe':
samsung-keypad.c:(.text+0xc60): undefined reference to `devm_ioremap'

Signed-off-by: David Gow <davidgow@google.com>
---
 drivers/input/keyboard/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 0c607da9ee10..5c98d5f996e4 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -556,7 +556,7 @@ config KEYBOARD_PMIC8XXX
 
 config KEYBOARD_SAMSUNG
 	tristate "Samsung keypad support"
-	depends on HAVE_CLK
+	depends on IOMEM && HAVE_CLK
 	select INPUT_MATRIXKMAP
 	help
 	  Say Y here if you want to use the keypad on your Samsung mobile
-- 
2.35.1.473.g83b2b277ed-goog

