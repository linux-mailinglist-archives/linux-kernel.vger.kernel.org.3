Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6F753EA6F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiFFJXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbiFFJWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:22:52 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9429FCC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 02:22:41 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c2so17943624edf.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 02:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B2qzsX69MvR2kCiL+jvxQvKEdryENRI1HIL++8WDe/w=;
        b=Y67yUMGG1L54Iix+TwVcCNtQwwej4I3qQb1F+CHMMmGjw6QKVjozWq6Fx4EycRNUUZ
         6IrYPx1DfkPnAQX5bPoxFNVDAsyQ8Q3L7zyB/vdOeIx28haXVu6lBbFz0RC+SNOBPW4s
         fwA0NHprHvm5a6kBWfGkYNzgNsyxdCD2dad5NoMHuMwlHEwhM2g0VgCFB8616ZMuckit
         BRzWFtsDjBBBrNEscs4OfgSRUEWW4zGWI0zzOe41GqyVtcdafWRW94cm0CPdAKrngm8R
         hGvBDHsLtSGPYRcuIH/3XRJcQe/mpCKjrb1PP6hNGLTNdCqef05XZUppB44tvkAiVDad
         vgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B2qzsX69MvR2kCiL+jvxQvKEdryENRI1HIL++8WDe/w=;
        b=gkOQVMO9WYcW6nMNQOsOdBWeGNtoa9so+gpka/r70roTz5wsAWV+NGdxg2BU41Wrhe
         Rs+u7fiGp3W0O7s38way1MAr9aqYSGLi/7vWRi3034soC+Yqx56RShSN6PTN2xRTdBua
         vKUvf6b/PU9y9p+oOjK/QKol9gkTe0glTvgm1oHJxqtgJ2RYwDRPax6tGzNsXs6B0Xj8
         Er2Q+gLcA6vOc5Zq7Sa1CrPRSCbZ2INKRQ7BHxuFxqCvD0zFGXzkteBafhx5xWSobC0p
         1cSfMzBgaE7yYKNPh4V7HvifouWruKcfJhO0ivwo2OmSLzEPO9CRXQNkrgXRQeZXpKMU
         WlyQ==
X-Gm-Message-State: AOAM532ideK0d6jrFXhxQSebzjDvv4cK9gm9q48/1vLbCl1z4hhs7C5o
        UmaRES11Hq5Ubo04uwQ4TQwCoQ==
X-Google-Smtp-Source: ABdhPJycVq+J7OYvPWU1JTC/TbbgFFrNf8+e//O5eWC5vdnfYYDvqu7odLkoJkNvgVDSAfTvWgSrjg==
X-Received: by 2002:a05:6402:542:b0:42d:c7d6:4121 with SMTP id i2-20020a056402054200b0042dc7d64121mr25284704edx.302.1654507360418;
        Mon, 06 Jun 2022 02:22:40 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u21-20020a1709064ad500b006f3ef214e14sm5956397ejt.122.2022.06.06.02.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 02:22:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-scsi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        avri.altman@wdc.com, Bharat Uppal <bharat.uppal@samsung.com>,
        devicetree@vger.kernel.org, martin.petersen@oracle.com,
        pankaj.dubey@samsung.com, robh+dt@kernel.org,
        chanho61.park@samsung.com, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, bvanassche@acm.org
Subject: Re: (subset) [PATCH v2 7/7] arm64: dts: fsd: add ufs device node
Date:   Mon,  6 Jun 2022 11:22:31 +0200
Message-Id: <165450734050.62970.5177963742920277216.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220603154714.30532-8-alim.akhtar@samsung.com>
References: <20220603154714.30532-1-alim.akhtar@samsung.com> <CGME20220603154912epcas5p2bf984fb4e32ee1b1357a3cc595e70a67@epcas5p2.samsung.com> <20220603154714.30532-8-alim.akhtar@samsung.com>
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

On Fri, 3 Jun 2022 21:17:14 +0530, Alim Akhtar wrote:
> Adds FSD ufs device node and enable the same for fsd platform.
> This also adds the required pin configuration for the same.
> 
> 

Applied, thanks!

[7/7] arm64: dts: fsd: add ufs device node
      https://git.kernel.org/krzk/linux/c/c75f5c9e11cf71e77c5cb8f0e082e5ee1e71545a

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
