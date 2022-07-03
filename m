Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B25D5643E3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 05:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiGCD5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 23:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiGCD5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 23:57:01 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA24BB1E4
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 20:56:58 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 73-20020a9d084f000000b00616b04c7656so5095790oty.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 20:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dc9vz6N7DKkZ82VTpYZZOu4EwmmX1IVNuq7aVvtCYLg=;
        b=zeYDcxMXG3Bfc271hs/yW15xnm8oYQfvzRsUdXI5TYj4vcCfgVJ1Vd1MJ1KKEcv9/8
         DfWE8j1e94BUq7mhLocGdLOjq+XO6qVMBgYN7NqzY9EPCJ2spjyhRsj4YCrJ85PxLv0G
         hte7WfuK8DEsWkmw386OrAYRS8P9HDS08aOCJO26GoNBU1BDqxK9VIX8ALHUcDwSJtiS
         YKkq+gLip8YUg3M4Tbv8lpoV5wSwXBGULIAfwdiv/1391ikt9LUOi2LnOGlCAAh8/SwX
         7TGRqvPIP9Ny3ExzilHv6/zY94xH9QcJ4UXTkM7/T3pfo4HzrbPjUG5ARZoXSH3TZvMZ
         +EJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dc9vz6N7DKkZ82VTpYZZOu4EwmmX1IVNuq7aVvtCYLg=;
        b=Ko0fIHVLDzY/bi++ixwXVzDnjUJxj6zzD/yYLz6xOnX/x1OgkzMguq9dXZJC6Wqp+T
         7qIRdh/IEKqbZDMvbiFj1aJkJJjjgyniV3TNfERLprI0/dmdR8q9MLJzEdhkXktz81bU
         GthvO4LnyjoeaSLuXU3pGz1220FWoP5BNOZ/u2Wr0ERS7b96mqEE0Z6KDsvVuXCwtJ/K
         1qSfbamV0uRHoir/OvH433ZOsrFcmzJrrP7gcApha5VuzR3OekN1Ljh2D9xQWkr9hqWs
         W7j9UFavlAEjbs/GMJuYHqOG4rS1phkHlmBu64mAetmgjyRIIaX8sDhlQbZedYgURk2Y
         Glpw==
X-Gm-Message-State: AJIora+32K2J+dQrBeBP6JEqBhs922joBtqU5yvJbd/bCBtrKRwbByuh
        OQSPXtqmRRCMgq/cNxrHg27EZA==
X-Google-Smtp-Source: AGRyM1sjOW8+NcP1/yVgLxMiRkSjc3NeZ5dMm0JT1zZBUJC7qJ3DQ4yXTHeopv4w72le8rSgf0vFYA==
X-Received: by 2002:a05:6830:3142:b0:617:131c:d671 with SMTP id c2-20020a056830314200b00617131cd671mr8612962ots.368.1656820617958;
        Sat, 02 Jul 2022 20:56:57 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 25-20020aca0f19000000b0032e5d0b5d5fsm12965910oip.58.2022.07.02.20.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 20:56:57 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        robh+dt@kernel.org, Alec Su <ae40515@yahoo.com.tw>,
        sboyd@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        y.oudjana@protonmail.com, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v4 0/2] Add support for Xiaomi Mi 5s Plus
Date:   Sat,  2 Jul 2022 22:55:54 -0500
Message-Id: <165682055970.445910.14607173848356967245.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220606024706.22861-1-ae40515@yahoo.com.tw>
References: <20220606024706.22861-1-ae40515.ref@yahoo.com.tw> <20220606024706.22861-1-ae40515@yahoo.com.tw>
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

On Mon, 6 Jun 2022 02:47:04 +0000, Alec Su wrote:
> This series adds the device tree for Xiaomi Mi 5s Plus (xiaomi-natrium)
> smartphone which is based on Snapdragon 821 SoC.
> 
> Changes since v3:
> - Remove the unnecessary properties in the device tree.
> - Correct the supplies in "dsi0" node
> - Add delay properties in "touchscreen" node
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: qcom: Document xiaomi,natrium board
      commit: bb856fdf07f666686439b2c186fbb80a41e93277
[2/2] arm64: dts: qcom: msm8996-xiaomi-natrium: Add support for Xiaomi Mi 5s Plus
      commit: 13e75fe786a16c35bccc5e9d8890224fd38ad733

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
