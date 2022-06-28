Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0156355EF56
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbiF1UWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbiF1UVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:21:32 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269A53CFF3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:19:25 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id p6-20020a4aa846000000b0042599456d32so1812975oom.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RSJeobivsF3/icI+w6qtKuVl1DQmvnoCjP6gPHB7SW4=;
        b=qnO8QVVf4xxi1yjoGZd0OI/P82xCqkuy27+G5A6UA69Lhg1wdSCpB0YPNfMcPQ+aci
         4sDBifd5rmuAxKD7Da0mG2xEvUp2V7phzKgjRGi6gA9kzETMikAXs/Z3wcPWuN6RSpGz
         N1dptOeOYb2d5RnhsgdhCT5wz3oLPQM0WtgZ+wa9MBeAq6pWdn08Nn3L4Bz4MChNNvAD
         CwCG2p8XOOf274ufc/T3/0LKam00KlKNiDZYnUp4Q27ip5LgoySf2TW8onSSS1W12PQx
         CA6WtpgL/CSHDZN4tKNy2w6JEHasSYp75no0SdtLgouICwERQYAx4GvIJnR5sLm/MKop
         7ZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RSJeobivsF3/icI+w6qtKuVl1DQmvnoCjP6gPHB7SW4=;
        b=4GNS7O8UkGZpMBoRFMy1jlZJ+flpZB5ZHlo9PkiLtMQgTOidN/keCCkOpbo9sQdLp4
         TTOvHf1tU3IdKWvVKXOnv4RjEjCajBh+RK/QYYAVbrzZiBwz5hm4bGBLvYdC2XzAgUZ2
         T/xPQggCro1VS4V9V3xFQngAlpVGBiOkXmPaSOKs251HU79sms/UQ56cocA9LYY3ZxMl
         cdgqNpVuWmg4tTZa+dFbYdSAQ0xT6e8jWOfINszjo9Jhlnfb1nG4cFMjeuXDYm2zHeuM
         QNZJJRiKLZGr2c2YcqT+YSiKaNbBqO+SLK/joixm29R0ruhFGv3vUdNZRbpwWuxsxP7+
         d2RA==
X-Gm-Message-State: AJIora/WqMa0AybkTai9t4IeJPdYdaQP1wmFyiEPaPlz6T2zcSl8vODt
        dp86YW4bGKi+OSSVnd0QPYQw4Q==
X-Google-Smtp-Source: AGRyM1ssd/F3tbYccrOkJIGxlweqxdKEGoPMRZwAVliZOVtMpOjkmmOXzkIbr8GOg7Qj89shd1U5Qw==
X-Received: by 2002:a4a:95e8:0:b0:425:bf4b:b01a with SMTP id p37-20020a4a95e8000000b00425bf4bb01amr1771062ooi.17.1656447564503;
        Tue, 28 Jun 2022 13:19:24 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a12-20020a056870d60c00b000f30837129esm9536923oaq.55.2022.06.28.13.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 13:19:23 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     martin.botka@somainline.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        jamipkettunen@somainline.org, marijn.suijten@somainline.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        angelogioacchino.delregno@somainline.org
Subject: Re: (subset) [PATCH] arm64: dts: qcom: msm8996-tone: Drop cont_splash_mem region
Date:   Tue, 28 Jun 2022 15:18:57 -0500
Message-Id: <165644753307.10525.6593691125629813190.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220430162319.607629-1-konrad.dybcio@somainline.org>
References: <20220430162319.607629-1-konrad.dybcio@somainline.org>
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

On Sat, 30 Apr 2022 18:23:19 +0200, Konrad Dybcio wrote:
> Tone does not have a functioning bootloader framebuffer and Linux allocates
> the DRM framebuffer dynamically. Free up 36 MiB of precious RAM by removing
> this reservation.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: msm8996-tone: Drop cont_splash_mem region
      commit: bb9bb4123abe2f35db02ad3073cc85a8cdc32ff5

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
