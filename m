Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9778569822
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 04:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbiGGCcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 22:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbiGGCbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 22:31:45 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB49F2F644
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 19:31:42 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-101b4f9e825so23685681fac.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 19:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FlZVePS47CQB2fLrsuYTYo7nXV1SeCYN43u6BIIpwag=;
        b=oWobDK4AJxR+fAUpb514GKNzQ2EGoC120X4ExMjisgW+rdPTqRp+tHdpNYt07KYNv4
         WxNap85AWfiQ2rxKfJbRhcGCFYlENtQVh1bUCXQjdPuGgG790gOtLP1mYa6+h3AeAxS/
         vVLA02wuK11K3ZpAwwnGgkr8/CkRJ0AUmKznTsss2RDL2g07dntfrVaX7IQYSmb6iS5D
         BGRKSCPaiJj/uBRIDphrNPMSIvm+On1QvWiGlmxxuzYV1hL8aPrxzccKjm4RQH7poKuC
         gDqpIwVavwMNAwAc/2czK5lr1fChsLQ6/kP3q+ouwoMCylM2uOfJW/4iEa4a5GumNUjx
         UCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FlZVePS47CQB2fLrsuYTYo7nXV1SeCYN43u6BIIpwag=;
        b=Gupegm67imyuGgo8XN84FptFJfk4nnoqiuCTxvkgS6uCRPGWbxjL90pWapQ0gaXWwB
         Xl+zuwfbjBmXkoebcUHFe8BOB+5yZKg2lZN5ih6EZbBHN8Y0nBOm/3bpdM8rXGy1gWA+
         64vzMcDjXQL9rZcfrqWzZT+XvmY7cM0rqN3i6K5dcG9kBFk4nzCoAPq0av0CSgGZ00md
         MEolAHd57ouV5ackcjvWStzMuSygqsy5ZvivZujKuzN1diewcTkmpwRfFUhpEOZb23df
         AosqdVaoWzxxu/QHCTEi7SW7wN/nxArrFBYUAqPiNN057rCZHCgXrg4NDbH1fV/FwW9W
         SV4Q==
X-Gm-Message-State: AJIora8+1z9ZpBgGztK8k6jwThqiE1HtNtyy5VsiEBan/Cx2AVqXeE/Q
        zsFdYLLWM9S3QuG6QHFEinmcxg==
X-Google-Smtp-Source: AGRyM1vd4NmRpUxaeieBA7/sWpTryt5OaUYEpF1qRSyIkhZ0rJiOsWdZMKsB6MkPUBrC/6cotMeapA==
X-Received: by 2002:a05:6870:4344:b0:10b:8499:395d with SMTP id x4-20020a056870434400b0010b8499395dmr1245950oah.214.1657161102210;
        Wed, 06 Jul 2022 19:31:42 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x48-20020a056830247000b006168c71ca4asm17024469otr.56.2022.07.06.19.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 19:31:41 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-arm-msm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@somainline.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        robh+dt@kernel.org, agross@kernel.org, devicetree@vger.kernel.org,
        Robert Foss <robert.foss@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>
Subject: Re: (subset) [PATCH v8] arm64: dts: qcom: sm8350: Replace integers with rpmpd defines
Date:   Wed,  6 Jul 2022 21:31:19 -0500
Message-Id: <165716107314.864223.15017336421009703415.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220706152830.2021197-1-robert.foss@linaro.org>
References: <20220706152830.2021197-1-robert.foss@linaro.org>
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

On Wed, 6 Jul 2022 17:28:30 +0200, Robert Foss wrote:
> Replace &rpmhpd power domain integers with their respective defines
> in order to improve legibility.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8350: Replace integers with rpmpd defines
      commit: d0e285c3d8d3b9c0a103760668f481a28aa16dd0

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
