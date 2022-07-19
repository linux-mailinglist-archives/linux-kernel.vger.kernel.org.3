Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC0D57921E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 06:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbiGSEsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 00:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiGSEsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 00:48:09 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFFD28E09
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 21:48:08 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-10d7170b2fcso679152fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 21:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hkiu+cG08raUlSMsHwj2fBAC+OhD3tgUfNlIdHuSeFY=;
        b=eO9hMCacdMbGvyLkaQhQ6VR3Y0whUrntdWmZTcwtsdIDCs9xRNOF2ThGwN+U56m4c5
         bEvowBmbUZgJp/j6B2qxoTED07Yakx/wg4D8z4WD35llKGBGbCrX45GmbZoKS7K3eqWR
         bFg64BDGmY+3O+Q97hzZqh+4sXbWWrg01hnKCx1e0w+LWQu6aveFyVoOsWeqe6SLEsEz
         kjPrSmKf/9dQR+C0nzIWZZJr3ED5PZI0rGRPN1WhEcjqrnYppNOZ2WA2RKH0SX4FRf63
         VJ56Sxs18VMLIUraZpG+Ja+Lv1RTD7Mw1YfEtYNn/OcGtj0zUaDmtx5ftHDrojVhx68D
         8q5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hkiu+cG08raUlSMsHwj2fBAC+OhD3tgUfNlIdHuSeFY=;
        b=Qkt5hkTL8oCfls/v9dZTYK8tBauyOgkWpkt27yVKNOZFSGExDZYffOBHKPTC3y0Tq1
         5J+5WJyf6Y+I4HqrMHntfrVKB+m58/KCaZfkX2SyMEYKmIO9QA4X9n5tgNJMNhzpG0OZ
         hb8AkmsWAB0vNhy5fVcWHL3x28NYipeFt3vPvNnDh+n19eZhD6Bt3WEwgM/mUcNiWutg
         DEtNP2BGGlvORHw5YtHtMmLpHssVP/QQDrjjEzCm/wvN23YQBUqMzpeIPnVl6LeflLBt
         OTFbUjDWD82NxHZ+4TSAgAaPXmGPWzo2zcX8ArzUdghMNonqpjjb6t+I75h3jWz6Ss+H
         5ElA==
X-Gm-Message-State: AJIora9O9scY8xiWyzbw/u6L7/RF7vt1Ad0cWcK31gOYq3n/nF0iMMTX
        g17aKmIkErFRr5yHjmDcLz+urg==
X-Google-Smtp-Source: AGRyM1tXldy4JV3uE8SiOHe2MGzC/7sqxliT7J5TYS0+I0NtrocYx/mhAbI9fZoTJEuATplK1A7utw==
X-Received: by 2002:aca:90c:0:b0:33a:768b:50d5 with SMTP id 12-20020aca090c000000b0033a768b50d5mr4125286oij.294.1658206087475;
        Mon, 18 Jul 2022 21:48:07 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w9-20020a9d70c9000000b0061c9bbac1f9sm2803209otj.16.2022.07.18.21.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 21:48:07 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     abel.vesa@linaro.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        dmitry.baryshkov@linaro.org
Cc:     ulf.hansson@linaro.org, linux-arm-msm@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: (subset) [PATCH] clk: qcom: Drop mmcx gdsc supply for dispcc and videocc
Date:   Mon, 18 Jul 2022 23:47:55 -0500
Message-Id: <165820608069.1955453.1904686659140070869.b4-ty@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220713143200.3686765-1-abel.vesa@linaro.org>
References: <20220713143200.3686765-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022 17:32:00 +0300, Abel Vesa wrote:
> Both dispcc and videocc use mmcx power domain now.
> Lets drop the supply mmcx from every gdsc.
> 
> 

Applied, thanks!

[1/1] clk: qcom: Drop mmcx gdsc supply for dispcc and videocc
      commit: b1ec8b53c9ae5fae33d60e9638d39ca5346b941b

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
