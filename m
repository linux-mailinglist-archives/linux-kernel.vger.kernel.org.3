Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBE64F1094
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377940AbiDDIOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377924AbiDDIOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:14:39 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D7D30F7F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:12:41 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id i6-20020a1c3b06000000b0038e710da2dcso778395wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 01:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U1Fdq0DczHkP3YF2vj5LPcppX6TH/kpuXtMffHmyoZQ=;
        b=ccWa7BZsRyHZFk7vojdgTbQYkDBDeSyof2uyKirvXqz3ERteAC5pvLBFmlrdNffaDj
         p+h/6RjcW3bvMEt4clBiGuxS4MnUtbhEuG6ULWRAL2wzcrUkKm7nekYS/fEmLz/nNeNu
         rv9ohiz3Y5OUaUaCiliDT7BFQiWeSfvOCBU4JEOkxtTWkO+lb2KjOob3dSsPWNC+WSym
         Xz41jfw5uuRnvhkaF78QwpwQTRVkpeaag5/JyFtzF18D3ufw8rxZ/9ZKSIGOMCBuaqHz
         1aFgwncugW9a6H6tmYi7vFWdcmEJ0e0LgjX57qkWrFqFewDBYMps4GhpSaLFvMGpi787
         jtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U1Fdq0DczHkP3YF2vj5LPcppX6TH/kpuXtMffHmyoZQ=;
        b=0FsGAc7bOb+w2Mi/la6XBUeMBoOMEZ6QrlNA10ZR/lITKmIGO15m+yzYfvYuaVHUes
         axFL+dkND7R7oSXuJCZ7BsG34y9HEJfj0wXJcmKcJYH/QkGfSNEPOJ02XwFlVKHxZx/R
         l6xu7ognkzeceW21bQa47g1i3fkYhpqOPv5ZkKKrLTz928UZml2Ea5HLM9d4NIRjCRVL
         OnNXtY0/1zfWGalmMB2/GSQA/KiinYsJwtOLVMcwo2vddrpG5k0TFWnKBPju6XVKEmg+
         6F8opbT/TlwBjbhBDBHzlsY7AU606DYcnQzz7Maf5F1BmcVHogmNjmuWbUkJZXYpMmUL
         v96g==
X-Gm-Message-State: AOAM531Bp1YqP4Lr6+N/QjOxv7h2essNdoLMOMXn/iGAq7+NUR5c/V6e
        o7vQzXC1xw+5oZqhNU0pUqwkEQ==
X-Google-Smtp-Source: ABdhPJwWjslOc4kHuu+OQclfFY0BZN3W5Rz/UbNzTFSp4pRRp+RHXzsaOZB05j1V4cEt05SxETfHWg==
X-Received: by 2002:a7b:cb87:0:b0:38e:7464:f796 with SMTP id m7-20020a7bcb87000000b0038e7464f796mr1674221wmi.133.1649059959885;
        Mon, 04 Apr 2022 01:12:39 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:1add:1b28:2457:eb46])
        by smtp.gmail.com with ESMTPSA id s12-20020a7bc38c000000b0038e708d163dsm3297510wmj.0.2022.04.04.01.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 01:12:39 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     krzk+dt@kernel.org, khilman@baylibre.com,
        Shunzhou Jiang <shunzhou.jiang@amlogic.com>, robh+dt@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V0] arm64: dts: add support for S4 power domain controller
Date:   Mon,  4 Apr 2022 10:12:34 +0200
Message-Id: <164905994877.1805420.15799716011771473596.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220401110306.3364551-1-shunzhou.jiang@amlogic.com>
References: <20220401110306.3364551-1-shunzhou.jiang@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 1 Apr 2022 19:03:06 +0800, Shunzhou Jiang wrote:
> Enable power domain controller for Meson s4 SoC
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.19/dt64)

[1/1] arm64: dts: add support for S4 power domain controller
      https://git.kernel.org/amlogic/c/085f7a298a14ed2a088c8ba01d2feda2499cbc72

-- 
Neil
