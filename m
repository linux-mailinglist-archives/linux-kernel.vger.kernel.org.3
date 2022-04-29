Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA3E5142C1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 08:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354829AbiD2HBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 03:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiD2HBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 03:01:41 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585E3BC878
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 23:58:24 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id i19so13613764eja.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 23:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3otK7G5mDlVdg7lJNS61dFQOJl59ip503etKmxwIT+Q=;
        b=e/lmvj5vaNcaQnSTylDlu0Pw85f4ht4NN4mZq8YYxB/mqQTJgxWJ0LRNN13bJLcDoQ
         z4+hPWCk1ws5H6+lzheYQCGQAxAas3JvU7ngVtVGWWW3RNgzvdf15k2zTLk5eXFXEtva
         1qwpWgAK+bVoE+rXCp2nhf6mNeVqMfgV+RhNRm0dxxYX318VVrs3vK3f0S1tc7y9rNct
         2HuG82BPwz4l8nUnDA8N6SMaqqGP7HwZhje3tiSgBnf+pcZ+k2MZeyFS5twLDKlLnfU3
         Q0RRlFoeWZztKYAOF21FgLfPBpciRuCiEAszUUw/70Vd7axetq71TXekH6JJU9Ha8lWs
         j3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3otK7G5mDlVdg7lJNS61dFQOJl59ip503etKmxwIT+Q=;
        b=Rp2/UqZGbUgHvq/7sPntInFzjoOorsoK5saEatLqI665+K4mXPbZGe1U9iBQOPhD4v
         WevEE4jw5ShUT4lFGjozd8NMxvSNQbTc0zhApSd5i+3oKiLXe0fRGKqrAGwz6aMMgdZA
         8Y2ZOwnQMRm9x2kiKFOksMCDWTpw2jUbuwCde36GLEfXGHUQlgxnv3gNH16Hv3ErjvGF
         iPxdgDNkf9e7LGsHULmezirQGq9ldqmLEKLhBkKt9LXo3tq+q9VKhJUCMsStxrtIAUMh
         nvyWEmPyn3gIV+QW18MbDGwbVGLUTOSCflmVS1XTjn6jkgcErOLSF9L8MAXDsscT4wux
         8yMA==
X-Gm-Message-State: AOAM530P/5xWW/bSP4VUcob8pxOr7SpMcQA9r8JbTo8kj0k8IHU4lziM
        Rg33BAl3MB8JGG6pYTQ7ogzzIg==
X-Google-Smtp-Source: ABdhPJy5IwCBPgKHwV5/ciE6nZsSCYnubwtZMdcLVKbVPJv43TkmACLi3MR0cMkx7xxn0HedaL+VEA==
X-Received: by 2002:a17:907:2d24:b0:6f3:91fd:db8f with SMTP id gs36-20020a1709072d2400b006f391fddb8fmr23847854ejc.150.1651215502911;
        Thu, 28 Apr 2022 23:58:22 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id co8-20020a0564020c0800b0042617ba63c6sm2591363edb.80.2022.04.28.23.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 23:58:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Roger Quadros <rogerq@kernel.org>, krzk@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        nm@ti.com, tony@atomide.com, kishon@ti.com, vigneshr@ti.com,
        miquel.raynal@bootlin.com
Subject: Re: [PATCH v4 0/2] memory: omap-gpmc: Allow module build
Date:   Fri, 29 Apr 2022 08:58:17 +0200
Message-Id: <165121548985.31307.18071225935651783225.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220426082611.24427-1-rogerq@kernel.org>
References: <20220426082611.24427-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 11:26:09 +0300, Roger Quadros wrote:
> These patches allow OMAP_GPMC config to be visible in menuconfig
> and buildable as a module.
> 
> cheers,
> -roger
> 
> Changelog:
> v4:
> - drop COMPILE_TEST as include/linux/irqdomain.h does not have
> fallbacks if CONFIG_IRQ_DOMAIN is not available. So build will
> fail with COMPILE_TEST on platforms not having CONFIG_IRQ_DOMAIN.
> - use GPL instead of GPL v2 for MODULE_LICENSE. Fixes checkpatch
> warning.
> 
> [...]

Applied, thanks!

[1/2] memory: omap-gpmc: Make OMAP_GPMC config visible and selectable
      (no commit info)
[2/2] memory: omap-gpmc: Allow building as a module
      (no commit info)

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
