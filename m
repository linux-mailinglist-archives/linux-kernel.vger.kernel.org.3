Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6284E681F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352405AbiCXRzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352390AbiCXRzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:55:53 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982AC6F488
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 10:54:21 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q19so4429473pgm.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 10:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VngdEZVbX9x4Xz2CBFnvT4wZYxRLd9SpJ73EFc0h42I=;
        b=Vkn9nrGhs1QUBXV2u+qj6/J78fl0nDP1ptgRmJ6HD7JO1mRbsvNNzkxQJ2DF2smcW1
         MhKeRSa/FWRFd+JMestXet6+s/iTeYPfXak7R/pEkl50XbgmhdEz48i1h+0A2o3SiYp7
         AxPwZ0vE4DUueiYRFlE/Pu/5u0DdEyOMvi50VJgjiAMPN7UgHF+/rr50siBqUubT9Ejb
         ytt+vg/V/pJmy8HLkM+cDt2GAq7jb/PZSY/QQZuwNZfa3kACE1bnrflWrpxHKdsBTt2u
         PTDrMAyMlbf5KsDwEAQE0HYQGq+q1FuxtYGEnL/68lax3B1Z0/eN4+LQVre4luNrqX6j
         Qp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VngdEZVbX9x4Xz2CBFnvT4wZYxRLd9SpJ73EFc0h42I=;
        b=7Wqv/Dqhc43CXi9Q468wDlBhAHnnYA6ihukI41SPIZPVkuuKYwOySns+V5LbCa3uqV
         KbnixAm4/dr02zTPeShrwz08LmplhyROmMMN31lvp4vBvU5v/9HVecRJlWdckDfd+4QC
         ZSFsUYuAd3y2u3DiFff6/tt5U91qf8IbJiHi/RjdV4zWM4PoRj0zXydMCaW/6JXyqtrm
         UsWeoxoFzIt4tAPmJmZbczVdM4//+NMEolSg6i+5R5JLA3DOEnTd+PuWQGgAoV6IHdeW
         U77ELV/xP8HFK0vFIBpmTrhsCRKj68w8T1MqeGk1HXvtCRICG6IZJ66CJd25B/O/8Xzv
         /e2g==
X-Gm-Message-State: AOAM533qakEnLMa2rcKrAar64As+2zvgC17v5vbS77RHF2UKVDJrVygw
        FFc2zb62c+vEh3wvxgzwEtY=
X-Google-Smtp-Source: ABdhPJyDd4JetVqC+cU+GjYxKVBslAM112lCvo8/emIeP8YRVzncxMCjqeFuDrN3SCjrAtY1d5+fnQ==
X-Received: by 2002:a05:6a00:1516:b0:4f7:d45:3769 with SMTP id q22-20020a056a00151600b004f70d453769mr6242093pfu.86.1648144461129;
        Thu, 24 Mar 2022 10:54:21 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f21-20020a056a00239500b004fb02a7a45bsm1003193pfc.214.2022.03.24.10.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 10:54:20 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org (open list),
        linus.walleij@linaro.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 0/2] ARM: MAX_DMA_ADDRESS fixes
Date:   Thu, 24 Mar 2022 10:54:15 -0700
Message-Id: <20220324175417.1014562-1-f.fainelli@gmail.com>
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

This patch series clamps the MAX_DMA_ADDRESS to 32-bit in order to fit
within a virtual address, and also fixes the off by one which was
suggested by Geert.

Florian Fainelli (2):
  ARM: Fix off by one in checking DMA zone size
  ARM: Clamp MAX_DMA_ADDRESS to 32-bit

 arch/arm/include/asm/dma.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.25.1

