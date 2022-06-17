Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E636654F2A8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbiFQITO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbiFQITK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:19:10 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF5D68324
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:19:08 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so1999719wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+zfxAXUXstiy9HFbkcUgRLR8H01OXibXa/AaMrxxFvw=;
        b=0/lpT5HykZNP39UyQqCjq47YFnbNhY6JYeUpCQof3XsUCTKrQxaR6kA28RIQxTsbd6
         1LEw0QDrN9P2uFjEA4gyoQ7AYXPWDm88DQ0XGhQzPDkWiZP5GoHzZaZ9lxAkY/imqrZr
         OxKFwb9rRWc2WMYOqSmapsicbLo5l+Ja0iMnyEsotqYS/ssTeCAl2EQeq9PuZhBGQ0f4
         SCrQSvV7U5fEf17jmRCIvxNuAxCpvn28FEJhgz3Qw4bsLodKjeeow04oKVRWlrHSrmRE
         4JvJEcYARhLkW9ETjyCako/k/bFGcivdLZH212LSaMl/R4vpsEF86YDRiinIbLXTzctp
         ntZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+zfxAXUXstiy9HFbkcUgRLR8H01OXibXa/AaMrxxFvw=;
        b=GJhyNL6kBHxoDZs0LUlmsFqCNsPkN3XPousKDB124z+twl1vHg4zQcBoy8sN2SGox/
         sEwZrqfI2IuTdWyrF2vBcyNVlw2opJzOIn4+lRBuOLVyk8coMBrf8K8tiwIOiFG85mG9
         fsV18RpNgw+aIarlnV4+hMZwPJrSQGjyE8f44ldwYPXR/PzTVEfYtAmdTiEtvTtCzY6N
         COnZ4oRNMnPmiQJhO/u3XW3rLuClV1vDk7FlMBjPAbwtpoXwIUCx+TbsZqYWXFu3vip3
         lhdauSynP5wk2e/b9ySS42QEFANcx16b1eCfsshWTgElllPBUyv+69DHuxcS4cKmYPj6
         bx2A==
X-Gm-Message-State: AJIora+FB0LCgrDA0ljRix2yT5cCgbs9lyyNufC5/ysBMbBpAkFMCmDv
        yMfeTHlrY6BmGNdERGuFNJ0r9g==
X-Google-Smtp-Source: AGRyM1uA1po67esnYEyNcEdUlzYn0dRDp8zP7JR6MJK74I8T9W1lnpShELLVdMBsJIPq0QGFqWNaXg==
X-Received: by 2002:a7b:ce87:0:b0:39c:5509:660c with SMTP id q7-20020a7bce87000000b0039c5509660cmr8961277wmj.163.1655453947001;
        Fri, 17 Jun 2022 01:19:07 -0700 (PDT)
Received: from groot.. ([2a01:cb19:85e6:1900:b8a0:45dd:a367:2e65])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600c4f0900b0039db500714fsm4970245wmq.6.2022.06.17.01.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 01:19:06 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v3 0/2] Input: mt6779-keypad - fix hw code logic and row/col selection
Date:   Fri, 17 Jun 2022 10:19:00 +0200
Message-Id: <20220617081902.2931099-1-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie is the first follow-up on the mt6779-keypad in
order to enable it on the MediaTek mt8183-pumpkin board.

To fully enable it on mt8183-pumpkin, we still need:
* double key support
* dts changes

To ease up reviewing, I preferred sending this first.

The first patch fixes the row/column logic to match the underlying
hardware matrix.
The second patch configures the keypad correctly in order to not
report bogus values.

Thank you,
Mattijs

Changes in v3:
* reworked row/column logic as discussed in [1] 
* Dropped Angelo's review since patch 1 changed

Changes in v2:
* Simplified SEL_COL/ROW_MASK macros as suggested by Dmitry
* Added Angelo's Reviewed-by on patch 1

Mattijs Korpershoek (2):
  Input: mt6779-keypad - match hardware matrix organization
  Input: mt6779-keypad - implement row/column selection

 drivers/input/keyboard/mt6779-keypad.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

[1] https://lore.kernel.org/r/YpMDZORAlHmg/x/0@google.com

base-commit: 69cf890d8b283c8d3a77d28dbd3024f58ae236a9
-- 
2.34.1

