Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B4C501BEB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345580AbiDNT3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238270AbiDNT3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:29:19 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247A2E33BC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:26:53 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id bx5so5969566pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wPa/6FlyvWIRPem5OetV4babaNSundzYasMD/hZ1m0k=;
        b=02ENnJGbo0YcUr3+ZaJIhNjLH1/QL6hzraEv1kgPKdc3nb8JhG3nB/3tYerTEtVCzF
         SMV5gBo2W7wLRQFSRq2zIhux6+ZoJ5dxerVN4rbwBwuCRcBorphOJm4nbSE/FjqCagqE
         jKNXnvlmrbkpKn9YSIjSjWNSAHNgHKJA3JDWtT+V7oB2MS0lOdCPBypdnvrL2Iu335S+
         sFcg2qV/iE3ubSv2a1NfJsTOQWYrmRnB76qrNdnxmmF6t0hsfkggPNYrjwnl5AnIYx9i
         Q2Z4yCvROjVOD25Y1Jx2a/8t7JjCxu/dlhSpC+GBKzrtXW8YkuoAOOJCdJh2pppL93b5
         QhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wPa/6FlyvWIRPem5OetV4babaNSundzYasMD/hZ1m0k=;
        b=A5AvVyl37QjlIq6hUNJZk3nDjJGY6f31ADHqprrcwi7ktRaI8zrtIL/PmUWpFz6QqV
         D4Czm10rrV2fFshC6RGKOdrHxopYldLMKuz/be8jYlm6l+MlkdJ7ETvoZ77SwK7FcOvV
         lIehfszzbLGr6jAyj+XGCrgBXSRtZgdY6oNIY364Su9KxKBMmRQ1hHqLKA/D6xzZ5M+H
         q1DV3eyLnza/vEMUQqPBEVEBcKtKuuzdbp/3TWhV4OmUXyq2BvWj5sSaymOTBYY18lXb
         0xUQLGQIKLzSYw1604f7hV5mo5TUzzJCttlT+DkYjmkjWsm7EXyfo9yn6eex66uY72eH
         cFTg==
X-Gm-Message-State: AOAM532Z4cTS7J97fDZN0VV3VkGBIo8BR7YlVf5OduH+lsH6IcXw5tQW
        aJW47y8NPC5PRRzar2Tw0Yl5Ng==
X-Google-Smtp-Source: ABdhPJz68+ja9Rk3m6NzdwebJgd6upA66XFcooeP3Is37+CGdm3mLdLvecugNkbiVEmq/aAKWSBM3w==
X-Received: by 2002:a17:90b:3881:b0:1c7:c02b:bcf8 with SMTP id mu1-20020a17090b388100b001c7c02bbcf8mr111237pjb.131.1649964412677;
        Thu, 14 Apr 2022 12:26:52 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1001:7090:5b60:6a76:138d:2646])
        by smtp.gmail.com with ESMTPSA id p17-20020a056a0026d100b00505ff62176asm590060pfw.180.2022.04.14.12.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 12:26:52 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH v3 0/2] soc: ti: wkup_m3_ipc: Add support for IO Isolation
Date:   Thu, 14 Apr 2022 12:27:22 -0700
Message-Id: <20220414192722.2978837-1-dfustini@baylibre.com>
X-Mailer: git-send-email 2.32.0
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

TI AM437x SoCs support isolation of the IOs so that control is taken
from the peripheral they are connected to and overridden by values
present in the control register for that pad. This series documents a
new property 'ti,set-io-isolation' and updates the wkup_m3_ipc driver to
inform the CM3 firmware when that property is set.

A prerequisite for this series is:
[PATCH v2 0/2] soc: ti: wkup_m3_ipc: support vtt toggle
https://lore.kernel.org/lkml/20220409211215.2529387-1-dfustini@baylibre.com/T/

Changes from v2:
- correct indentation of the 'allOf:' block in binding patch

Changes from v1:
- correct typo of 'ti,set-io-isolation' property
- make 'ti,set-io-isolation' only valid for 'ti,am4372-wkup-m3-ipc'

Dave Gerlach (1):
  soc: ti: wkup_m3_ipc: Add support for IO Isolation

Drew Fustini (1):
  dt-bindings: wkup-m3-ipc: Add ti,set-io-isolation property

 .../bindings/soc/ti/wkup-m3-ipc.yaml          | 78 +++++++++++++++++--
 drivers/soc/ti/wkup_m3_ipc.c                  | 14 +++-
 include/linux/wkup_m3_ipc.h                   |  1 +
 3 files changed, 86 insertions(+), 7 deletions(-)

-- 
2.32.0

