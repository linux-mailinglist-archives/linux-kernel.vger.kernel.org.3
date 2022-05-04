Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571A75199D3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346364AbiEDIfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346321AbiEDIe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:34:29 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3B5245BD
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:30:52 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id g6so1507292ejw.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 01:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u5DCd3gkGII5U0pKaCSu8S8zCepHUHc6pq9yX+4Mlao=;
        b=GMZUoxeuZjoJ/K6NQvljVb3HZYp4gFeB5Ykxz1ZY2nf9vzgANKEp/BX25OELqES/jC
         EprO5sEnB27Tgi+r4n/Ro3OmGEeJK4Ly6aLgmIJxXt3IkAL/+pbZtzvx58KQnkKz/kcw
         PSLFGTMsqoRTxhYIb61yHdvtIBUJx/U4a1uqdr1OWlIQ0CaGBI0yQ+xjrIve2e2x86vP
         9XB/KVf9D35/H11gFsGuOVnNi8gnScDX+QYdROFYjaNdBmNgTuMBEcoVII5ZcFRlg73U
         IZwbOR2Yr3zucaeXkAxp4PonSSOLm0IA3Gk4epfy1OiZCpwBBa5+Aw2rittnemiop/qY
         zJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u5DCd3gkGII5U0pKaCSu8S8zCepHUHc6pq9yX+4Mlao=;
        b=KCTr6n+ilVyUWMaMOmGPAt0llFnlbE3Wjetj4qkQRNzrc6JSE/q4e4aYRQNJcX2sv2
         dISg56ORtAgdyEEpmoDA174DrtDgNtDpmTLFnhLN/J7js+RAVKLZdTrxpAsSds74DPhZ
         mMjGS12RxSgtmHq+azlvtbZ/Bk3qVtwrFQIkw+BMIzII1ov7LghluqWeSzrn5jlMHAYC
         J2w2Ad8FTiB/Tagy582UhBepXCNUtA42SMNPrpQORub7mSFfnMl0G6Hm+g0g62U7Infy
         XRolQTpBWG02VV2lxKT5upFTziBe3rYANKoVvO9EJP60tDlvobSVdYkT4o+1hlY87tYA
         MXCg==
X-Gm-Message-State: AOAM533IsA3CjLlRQI2ggLm+l0JICe2WsqC8M49cEkGJ8jdumgcH7f8D
        M5ddmTMF8xNOtl+h0LPTDCkqTg==
X-Google-Smtp-Source: ABdhPJwwVKMcnsNd37Yy51jMHgfAXH7aYaCB3dEzXCD+dy/waRy/yEoHFbyD6ySsK3O90BBX5ARSzw==
X-Received: by 2002:a17:906:52c7:b0:6ce:a880:50a3 with SMTP id w7-20020a17090652c700b006cea88050a3mr19088588ejn.437.1651653051197;
        Wed, 04 May 2022 01:30:51 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jz15-20020a17090775ef00b006f3ef214e4fsm5377029ejc.181.2022.05.04.01.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 01:30:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ray Jui <rjui@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-samsung-soc@vger.kernel.org,
        Scott Branden <sbranden@broadcom.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liviu Dudau <liviu.dudau@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh@kernel.org>
Subject: Re: (subset) [PATCH v2 9/9] arm64: dts: fsd: drop useless 'dma-channels/requests' properties
Date:   Wed,  4 May 2022 10:30:37 +0200
Message-Id: <165165303186.30033.9938250875625514069.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220430121902.59895-10-krzysztof.kozlowski@linaro.org>
References: <20220430121902.59895-1-krzysztof.kozlowski@linaro.org> <20220430121902.59895-10-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Apr 2022 14:19:02 +0200, Krzysztof Kozlowski wrote:
> The pl330 DMA controller provides number of DMA channels and requests
> through its registers, so duplicating this information (with a chance of
> mistakes) in DTS is pointless.  Additionally the DTS used always wrong
> property names which causes DT schema check failures - the bindings
> documented 'dma-channels' and 'dma-requests' properties without leading
> hash sign.
> 
> [...]

Applied, thanks!

[9/9] arm64: dts: fsd: drop useless 'dma-channels/requests' properties
      commit: 6745dbc73112819529d776275b4e76dae5c12680

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
