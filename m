Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211D55199CA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346207AbiEDIe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238905AbiEDIeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:34:19 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2535B15A3D
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:30:44 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g20so869771edw.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 01:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yGMtR+zmOy0+jkPHlt/WBuJBg+CUiiGVOzODe4fOYTM=;
        b=cdKaQa/UZic0e21egEt8t5tLPtH1Mdw3UIxfN5el/N8NoZ8g8ocloGx3t9hoy/JLBl
         Mi1wSJoRueq1IL1XjOzuJw2gfibE0C0T3t6E9+8P37RHWf4SPxo4nr0AhAv1poVWjq85
         bRPdg7XuTucY/RqUJX88EBl0eZgmg7Ft5QdDSAmiheUQL7dFvbD79eFMFBYtf420XDxq
         BsSLClx5CU8VIyu8aSrscxIvWuX1Fd0h3mqAbQnlDInDgaxFePT+7zxgKiW/q3w4xlEI
         MiQ9Kx4yvM/Ka3LaePNz5xE8ldWxgBjYBnQRHveZktk7dR3L8Xs0vvX5zKVq/cO7VX4x
         yHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yGMtR+zmOy0+jkPHlt/WBuJBg+CUiiGVOzODe4fOYTM=;
        b=j1WAwxctrZEjLCDxmXfGETTjFP6jrcaFqWCnEN3MVAjrsV6ff2LZHUUyhOqqJC0Ut/
         3clZXxOAxp6t3JHB1w1flg66JyxRB/k5PlkWQ1pcIO3sTlTaf9sWk6qP3VLJDLKoocbO
         9wPPXU+gITtXfha6lmAGcBJN1nL1zzPlf4fHp/9q5jKGkFjtndC6H9JdrnaR7rooNna0
         lQw61JK96bwV9Swf8+PZa9DblPWHkexdob7L5/efqZUnla31KpdhfcM0Guydrja/2v8v
         uPEGPZ2dlFHVjed/Lru8+Mr+sMywitleaq8PN+jKUOyx7NwyZW/2lkAxFAshVxnkT34w
         8A9A==
X-Gm-Message-State: AOAM530tslk6/S3TFZb9JpXytDPbqB7TkfqXY/hoo7bmvxpD2EaQjY8M
        tGlITc4yKoM3/ymHLviNrCOCYZB0jiCwXQ==
X-Google-Smtp-Source: ABdhPJx4YLv1xoh1dxGnVZyx9WK43pDrX05wbRmo0EV1dk+MnLzMONHjOR5W80RNEkN6zKiPo+Jc9g==
X-Received: by 2002:aa7:d4d4:0:b0:427:5f6:c5d0 with SMTP id t20-20020aa7d4d4000000b0042705f6c5d0mr22160647edr.207.1651653042712;
        Wed, 04 May 2022 01:30:42 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jz15-20020a17090775ef00b006f3ef214e4fsm5377029ejc.181.2022.05.04.01.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 01:30:42 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ray Jui <rjui@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh@kernel.org>
Subject: Re: (subset) [PATCH v2 1/9] ARM: dts: zynq-7000: drop useless 'dma-channels/requests' properties
Date:   Wed,  4 May 2022 10:30:30 +0200
Message-Id: <165165303187.30033.4858903817618284357.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220430121902.59895-2-krzysztof.kozlowski@linaro.org>
References: <20220430121902.59895-1-krzysztof.kozlowski@linaro.org> <20220430121902.59895-2-krzysztof.kozlowski@linaro.org>
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

On Sat, 30 Apr 2022 14:18:54 +0200, Krzysztof Kozlowski wrote:
> The pl330 DMA controller provides number of DMA channels and requests
> through its registers, so duplicating this information (with a chance of
> mistakes) in DTS is pointless.  Additionally the DTS used always wrong
> property names which causes DT schema check failures - the bindings
> documented 'dma-channels' and 'dma-requests' properties without leading
> hash sign.
> 
> [...]

Applied, thanks!

[1/9] ARM: dts: zynq-7000: drop useless 'dma-channels/requests' properties
      commit: 0501eeca5aedab16a0dc4fd25135eb18d9408f80

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
