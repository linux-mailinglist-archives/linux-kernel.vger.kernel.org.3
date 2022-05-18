Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8482E52C411
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242328AbiERUHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242317AbiERUHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:07:38 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4F83BA6A
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:07:37 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n18so2803415plg.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/aTjJISL+hLgT3Oh4KWxf84REgjPoBHl4TNKz8Pt9Ns=;
        b=h0ngPJZCtqiJ7DMxk4Zo1+r28FEcjbdu8+8/q7HvEqjbMsSuSpIyKsi82n1ZizHVW1
         Yo03gQPADW0UuzttQUaywcZyEpQQDksZ8aKJf2tabt2HW2LPI+wk46oqFUjL++VvxqcK
         /WgW81mQkknH3UxqHmwzn6QKNIxpZ1PeVWFawcCg+HSuES8OcqlC/qjOWgwyP6thPpLl
         gixdl1K/e/8/KnXzTLM8SqniAPEauVfLxzk7mgvWZC5t6+y8qSpYl1dLQwCjCPzlEiRZ
         BV/4QMsXefx5IpS4B5ns7+2d7ZSY4nSf1DMMMPelV9skT4er5IPUPbhwrvBLjS3BFOzz
         3ygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/aTjJISL+hLgT3Oh4KWxf84REgjPoBHl4TNKz8Pt9Ns=;
        b=HyMBiZTH0WxZ1j3bznwOV0I4bdTMIUIB1sK1ZniQBfhqTpcQJssbyTvBLYMHPxJ24O
         I8dJcHQbl7pOCR6snhnfncJE4+6WBmbCLtMGENrHr3bfOllF5YxJl4jUpxe82XYkNGUo
         n4h2llzkW07M2SmmuF1S+9n910PwLQqX10tV5+KXB4y7ywNjdcYeT7Hxc3suUZAYiirr
         jq+SljCbWSkm8+ORnZfxyvYurEaYezoP/zh/C8tEt+WI2EW26LCnATHRwUxSYlAFpm6C
         AUYnSF1OF//2hwwX/54ukNhG/CZxM6O80/+HyZ+d3tFwh8FP2lJaA4FUYl9723anrXUS
         UoaA==
X-Gm-Message-State: AOAM532kam0braUQQmvoetUIVht70YULUFKwp3OL4cqGhqtUD/cq4qX1
        M5XYs+dIXAvlbA8tI1Qp4mY=
X-Google-Smtp-Source: ABdhPJzzpv/ktvymYcPe+voTmmXwqEj3Om849eclSrGdgh3iil/TGbQalPGav05Z8lBhjgkH4j77HQ==
X-Received: by 2002:a17:902:ec92:b0:161:7e29:6f9d with SMTP id x18-20020a170902ec9200b001617e296f9dmr1001136plg.157.1652904456997;
        Wed, 18 May 2022 13:07:36 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w73-20020a62824c000000b0050dc7628175sm2228088pfd.79.2022.05.18.13.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:07:36 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     kursad.oney@broadcom.com, florian.fainelli@broadcom.com,
        joel.peshkin@broadcom.com, tomer.yacoby@broadcom.com,
        samyon.furman@broadcom.com, philippe.reynes@softathome.com,
        anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] arm64: defconfig: enable bcmbca soc support
Date:   Wed, 18 May 2022 13:07:34 -0700
Message-Id: <20220518200734.324833-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220514232800.24653-6-william.zhang@broadcom.com>
References: <20220514232800.24653-1-william.zhang@broadcom.com> <20220514232800.24653-6-william.zhang@broadcom.com>
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

On Sat, 14 May 2022 16:28:00 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Enable CONFIG_ARCH_BCMBCA in defconfig. This config can be used to build
> a basic kernel for arm64 based Broadcom Broadband SoC booting to
> console.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> 
> ---

Applied to https://github.com/Broadcom/stblinux/commits/defconfig-arm64/next, thanks!
--
Florian
