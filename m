Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FC25199C8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346330AbiEDIeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346291AbiEDIeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:34:21 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B257E1658C
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:30:45 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id m20so1453186ejj.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 01:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ErOmZOxyyLEQmG82QPkXIYVhDcw5zGF7DldnAjYSsiI=;
        b=hP/qByODRrMS6I7dEG4gntx1JD+FPgG7GhgGIxPBHluOwTBQunh5Gnzjo+m0ovpq0z
         S+LUY+e9hpZTPyxMQ/HA9kV/MDjBWYdWNZQb+yBzE4/gtCu+CEUzzH/UUKalBa4Rn6f+
         gI5901gYuHXUdlzvggvSBmQOJZlzpSdvTRE/mu9zcnDqeVndSF4sQoeLr/ojLasx2m4w
         MBHzAyoU0N/giBU8BDesITIZViqGJSGU3ctWan9O+0SPZLeY9oHO2aGjiyQvcAKaarJM
         0JusOyQzklVom33CXNLC92+sNGbzJivuRQIU+yZJ7KBnssv02UfE+qE3fsc9XAKrhZXJ
         FDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ErOmZOxyyLEQmG82QPkXIYVhDcw5zGF7DldnAjYSsiI=;
        b=DCOruV1FJ8gv0c90G+fwzONB8zuNasTMpKXM/huab7M4sZbrRAftvm7uGiCmMrf8sM
         /EEPZtLhmdn3oxsQjnJMQQ++sNB+3Oal2FyoqXqkrqbDjcYuPU+B+tr1dUZrqHPNi9BW
         iqwH0hjJwFvzRw156EvPecarXcsdyMsgiHnaHBbm2xcEiu8dQdX94Qe3vGVr7ZDzPRdE
         9bzLWIzNcndr0j1H0QuGPpV0DjoNh1P2FMjmIQuv43GsLMMfBL+8nO5moO453M3FeBMc
         Qwbp0xm0rMqOfCb8EKZtwmZBLt2BdMp1iJMbez9LjpQe0Mv5o9dinVn9zeP54s/t5K/9
         D0AQ==
X-Gm-Message-State: AOAM531qIvxa9yiduGxgTzoCtpL/OvxjaUHZIpxrc92BtybUuCFout86
        7NLTRfzsvDQPc6x+Es7nqYfskA==
X-Google-Smtp-Source: ABdhPJzS5oVy647Jh4IwsSakOLpWrXbzFQ0z63fMaebc3X+NtTxQmPx/my9SBwD8f8mtDRfT0EA5Ww==
X-Received: by 2002:a17:907:8a12:b0:6f4:a586:de8f with SMTP id sc18-20020a1709078a1200b006f4a586de8fmr4482850ejc.514.1651653045029;
        Wed, 04 May 2022 01:30:45 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jz15-20020a17090775ef00b006f3ef214e4fsm5377029ejc.181.2022.05.04.01.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 01:30:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liviu Dudau <liviu.dudau@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Rob Herring <robh@kernel.org>
Subject: Re: (subset) [PATCH v2 3/9] arm64: dts: stratix10/agilex: drop useless 'dma-channels/requests' properties
Date:   Wed,  4 May 2022 10:30:32 +0200
Message-Id: <165165303187.30033.12158073564217341974.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220430121902.59895-4-krzysztof.kozlowski@linaro.org>
References: <20220430121902.59895-1-krzysztof.kozlowski@linaro.org> <20220430121902.59895-4-krzysztof.kozlowski@linaro.org>
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

On Sat, 30 Apr 2022 14:18:56 +0200, Krzysztof Kozlowski wrote:
> The pl330 DMA controller provides number of DMA channels and requests
> through its registers, so duplicating this information (with a chance of
> mistakes) in DTS is pointless.  Additionally the DTS used always wrong
> property names which causes DT schema check failures - the bindings
> documented 'dma-channels' and 'dma-requests' properties without leading
> hash sign.
> 
> [...]

Applied, thanks!

[3/9] arm64: dts: stratix10/agilex: drop useless 'dma-channels/requests' properties
      commit: a93fbb002310ef04fce504dbf1510f6eb8265188

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
