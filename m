Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254C159570A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbiHPJuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiHPJtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:49:33 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E377BD76E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 02:22:04 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a9so14030139lfm.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 02:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Cc5a/Z1OZQ/Sp4oex9dmkDkQnrPr8Y8hlCBI2uCYHzA=;
        b=fiDRi2HZhnLH0aZUZxx5zMFYg+kRxqfZ8b/gbzXvdbEOMUSsLkKCvcNynL4hySDQxA
         m1GK8w5qxNUXZbhnbUOAb/RWoVguEnK7mq6wmLTVFwGDw++AVwE97trf0cZJGRUKHk4B
         ugdqIQgEN/iEh8C4L4b5JRrnQ/26tifMaIyc4O7HpNoSyICCI3YfXHi6BEJAVxkwfsoC
         4dXDHxU+eadTKBUHD1fgqE6Zq3Hmseu0E10W0cwd/dRDKo7b7wWBN7zhjkCK4R6N9lSf
         qRZ/bk+TKFGA2FewRcrhJcWB7mn/MYynRQCArUicMErP3l3KcqAYTACWZ1/r4jHH8EoE
         HRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Cc5a/Z1OZQ/Sp4oex9dmkDkQnrPr8Y8hlCBI2uCYHzA=;
        b=chCKCB97ZMUYCdTIrWLTPwySSK/BeuoYo/eD97UJl7e0qPqCahLZxe9jtPGqo4M/gp
         rXXL6bCNc8/K+mQzuadV+GFwG3FBIrmU4ZmwaZGLW9kvCn8iWKdF8Mf4YipPtKxjQNWC
         i423yHCmpFhrEcK7RtAuxoO0cQLTdFuS36ghpwXnVy4vUQPWC0v5JN54fBGYe4vQbR1d
         Hid8g3KzbySQBFWweMyBu0AhukC0Ag2QrT1yTEK22S/3sLPpPlM1/8JbVw7hYRZItPFQ
         Dk2DcLNuA0lSy+zRUMMIi10tKlLq8cgpFZY9Hkf77iyo1v6xsNrPc/Amgysqe4MHGSVI
         Ai2g==
X-Gm-Message-State: ACgBeo3Ovhilq7quVJv/PIb0TuhogLFX2MbNSNFuvrPFOVUFKsWM+/C3
        aOfBm7hHQCES2SknaKgC39jr4A==
X-Google-Smtp-Source: AA6agR7LFK/9gYrW8u+lnQRIAyItIlW8HzneqHrf3znVQXnPj5MscIKAG/LghM5wSDnWni05dkHGvg==
X-Received: by 2002:a2e:80da:0:b0:25e:6d34:6169 with SMTP id r26-20020a2e80da000000b0025e6d346169mr6447417ljg.531.1660641722837;
        Tue, 16 Aug 2022 02:22:02 -0700 (PDT)
Received: from krzk-bin.. (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id s17-20020a056512215100b0048aea84fa80sm1335691lfr.87.2022.08.16.02.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 02:22:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     yong.wu@mediatek.com, robin.murphy@arm.com, lee@kernel.org,
        angelogioacchino.delregno@collabora.com, robh+dt@kernel.org,
        tinghan.shen@mediatek.com, mandyjh.liu@mediatek.com,
        will@kernel.org, joro@8bytes.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v4 02/20] dt-bindings: memory: mediatek: Update condition for mt8195 smi node
Date:   Tue, 16 Aug 2022 12:21:59 +0300
Message-Id: <166064169630.37858.3837655509098916044.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220729063208.16799-3-tinghan.shen@mediatek.com>
References: <20220729063208.16799-1-tinghan.shen@mediatek.com> <20220729063208.16799-3-tinghan.shen@mediatek.com>
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

On Fri, 29 Jul 2022 14:31:50 +0800, Tinghan Shen wrote:
> The max clock items for the dts node with compatible
> 'mediatek,mt8195-smi-sub-common' should be 3.
> 
> However, the dtbs_check of such node will get following message,
> arch/arm64/boot/dts/mediatek/mt8195-evb.dtb: smi@14010000: clock-names: ['apb', 'smi', 'gals0'] is too long
>          From schema: Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> 
> [...]

Applied, thanks!

[02/20] dt-bindings: memory: mediatek: Update condition for mt8195 smi node
        https://git.kernel.org/krzk/linux-mem-ctrl/c/9f8fb8032febf594914999c33493c682eaf138cb

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
