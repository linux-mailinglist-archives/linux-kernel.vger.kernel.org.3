Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD5553F62D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 08:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbiFGGc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 02:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbiFGGcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 02:32:50 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6E52898B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 23:32:49 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id er5so21591946edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 23:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kUL0/+TW0ZmFocb8yDY5jqKbncdLIBblavQc/eaSQJI=;
        b=sftAmM2OlEfC6VJ8zIEA0Xfsy6v2HTaNTjUKMfYdtxoSdcD3vxrEO/PCEGePaDtozC
         xyHlmLmsdRgR2yk1elTff9tbXqil/B41tk+0WtgEj08Gm/1Kmpx2r/HeUOPzdA0SMfGc
         wFE+ZMwPJFu6CpQ03yhMFxJ04tcjr5hJhfqrLepuc7NPW50CeYYD/ZycxufDQK3A+vuv
         T2ZpVYajmKu/RZ+gY+7+/lh8OekW/q2hi1jds/Xh06lKnW8KXQa4oJEoM09itLbjopST
         PwShn5HcVR8etj+2V8Zl0LAGZJFoRFdvIEiublN0VZCnbQrafYQwBrkLSxB59YhB/GsV
         tuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kUL0/+TW0ZmFocb8yDY5jqKbncdLIBblavQc/eaSQJI=;
        b=J9sV1hAv0+JiZz1m+6vO/1Sm3Tfqy0MTX7iyLfotkb5UXCBiUx7pRLPJeczZzCQJ8j
         2bGqIOxLom+AnZL7W6JII21AsHzeKsSTEIIjak7HSMNuexQkRA1/cr7umrFw8iOOGyGr
         VPnjRG4Ciq8CfyHDJeV8nAUG0o/KfBduElKmm/TAraDA5z1SgayCwooBhZOGBCLTk/gs
         hnewbcozB936CsDnhrqK6YXamHT1Rv+41LukrtrbsMzomKV9dunWOrfkSnpDT4KdzCgd
         bwMLvjeDqo+XEqOAa7J/iTL3N6d/N7w2nQmuufKRc1v3+IcmStzXrLwMQgR0Gi2OCjTh
         C0uw==
X-Gm-Message-State: AOAM531q9DlIk5t5IDUBpwjXYy4cyIKvM0lLdYBnEHFkj3oc4X4R169C
        voSCGwhcST19pud4knXz0L15fw==
X-Google-Smtp-Source: ABdhPJzMq/JTC9wN4RGWyrxYyQtSlviJZtlJ2Wjip2i6n2thkVBo2E+uQfiitHipF1MrM27CgRNrQQ==
X-Received: by 2002:a05:6402:139a:b0:431:6b50:11a2 with SMTP id b26-20020a056402139a00b004316b5011a2mr8272850edv.72.1654583567642;
        Mon, 06 Jun 2022 23:32:47 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id eg13-20020a056402288d00b0042dce73168csm9796349edb.13.2022.06.06.23.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 23:32:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-mmc@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: (subset) [PATCH v2 2/4] arm64: dts: exynos: align MMC node name with dtschema
Date:   Tue,  7 Jun 2022 08:32:41 +0200
Message-Id: <165458355453.6489.3351290853657960731.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220605163710.144210-3-krzysztof.kozlowski@linaro.org>
References: <20220605163710.144210-1-krzysztof.kozlowski@linaro.org> <20220605163710.144210-3-krzysztof.kozlowski@linaro.org>
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

On Sun, 5 Jun 2022 18:37:08 +0200, Krzysztof Kozlowski wrote:
> The node names should be generic and MMC controller dtschema expects
> "mmc".
> 
> 

Applied, thanks!

[2/4] arm64: dts: exynos: align MMC node name with dtschema
      https://git.kernel.org/krzk/linux/c/2164784a4b2700d1929854b5ec6b2169ff449814

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
