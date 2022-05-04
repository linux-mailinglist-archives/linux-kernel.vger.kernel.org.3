Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDD85199D0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346373AbiEDIer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346326AbiEDIe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:34:26 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5274B15FCC
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:30:50 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id m20so1453186ejj.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 01:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GXoJXDUDrgkUSMvyeYyAVqyRWBa+AE87coAVNtHrkMw=;
        b=NPczZLhU9GPldOjl9K3xHycnK7S7VeM5Wq/1pOrV69+fIfMPH0zY+nUanRgK+NK0ac
         pAfwuYM07mXYglV/p5nHQV47k8E99RayZx6MwTWjIjVDzRIUlaGIQj/g5kghmaXdds4x
         Hq+wolaOl21PVyj8kOM/wP7aH6WEz7R9rWrFpBeyJJauvavf6w4oH2UDzQudQiEC6dtO
         LXgGmkx/xzUF2IR0fG68+PIbQ/0n+IICqtfC7ki12LoIB/znMsqyxDQ7/ddPe1NUy/id
         goYmMpzIDKPTQ2HhADNvz63HKWxaSCiVpoJb9EscgiId3ShCPSvVvpL3BxqtRNmxOrG3
         6hJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GXoJXDUDrgkUSMvyeYyAVqyRWBa+AE87coAVNtHrkMw=;
        b=tXiSfXbBDzRbBuF1vqRvw4Mi/5+5Aa6bKMWexPPCgCkyfwuGNuq/gmvqYiivqowrUR
         nVb0ZDl5vWipD8i7fW886RxkpjzxkDH7eA+l62Io09Dn7assNyk5GisBR3f4aTGObLFl
         W8sLObg0wV36WnxkJLCBfiUF86j8B5rD5MjxUqnP5YPuObKFduqQ4AH34OEFs8VR9me6
         HjFWpli9rtgZx3nkRvFmBeo067MDcDbvXNDd5s9kmmmLQyCKk2dKgCcZwN3H5xA5a/rh
         W1yNMdKFybWo+8rSMOQwfgTVPpzYuHYOA/4WiAK7gI8t408IjuL3fdN5tN25iN4WENcz
         wkRw==
X-Gm-Message-State: AOAM532YpfIT8sDhuFvdqY6ABM9b5RauTu6QCslHq0xkY7JSJm6PIR6m
        l8OgdqZ1CSQhle2Fs97lIYQr3Q==
X-Google-Smtp-Source: ABdhPJy+824ENK7sN1D0LnLIeQEVCt6H7JiS+QZCacTvO4AyCNUK5LBfOVQrlEqXAnAqqelnDzRW3Q==
X-Received: by 2002:a17:906:2881:b0:6f3:f24a:756 with SMTP id o1-20020a170906288100b006f3f24a0756mr18899164ejd.444.1651653049903;
        Wed, 04 May 2022 01:30:49 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jz15-20020a17090775ef00b006f3ef214e4fsm5377029ejc.181.2022.05.04.01.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 01:30:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liviu Dudau <liviu.dudau@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Rob Herring <robh@kernel.org>
Subject: Re: (subset) [PATCH v2 8/9] arm64: dts: exynos: drop useless 'dma-channels/requests' properties
Date:   Wed,  4 May 2022 10:30:36 +0200
Message-Id: <165165303186.30033.9411024965777090941.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220430121902.59895-9-krzysztof.kozlowski@linaro.org>
References: <20220430121902.59895-1-krzysztof.kozlowski@linaro.org> <20220430121902.59895-9-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Apr 2022 14:19:01 +0200, Krzysztof Kozlowski wrote:
> The pl330 DMA controller provides number of DMA channels and requests
> through its registers, so duplicating this information (with a chance of
> mistakes) in DTS is pointless.  Additionally the DTS used always wrong
> property names which causes DT schema check failures - the bindings
> documented 'dma-channels' and 'dma-requests' properties without leading
> hash sign.
> 
> [...]

Applied, thanks!

[8/9] arm64: dts: exynos: drop useless 'dma-channels/requests' properties
      commit: 03e1d34d27a5e8065c5ef691648ee8a519e3c1b0

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
