Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506F75B29DC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 01:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiIHXDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 19:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiIHXDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 19:03:00 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A229A993;
        Thu,  8 Sep 2022 16:02:56 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 10so150991iou.2;
        Thu, 08 Sep 2022 16:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Lh1d7xwAI6FSaEeuyG+QlzDPrQOD/TqkSwQQ7Nk24C8=;
        b=bssK1Y/5WmM0UQ657sCKy21zJ6QaSYOqqlQlG8mMV/5FM/sQk1kSugMdO4G6DNyY+5
         lx2Dak2YDuGpduOdV+uu/BBWWTfQBNXLsXeDDCIcDRl3GV6GACpFidQQ7N9Wm2H8nS7x
         7Vdi3DPC+FRqGWE5mIDX1drdc7nB8JvrzRfcoR2DooFuFYZQAY22Fhf5MpbQK9cXj7AG
         mP04RtyiDrpAuDycv9r6pikpBVVkrOvcwX0lOQL9NvLZPmcbz3zBFLQJYRaRtMoxbBjL
         6gpm1dkmdicNuLF6Cm/HOX71Nhe3PQ2fh7gi0qPfBVp3hcwE6wWLZmh0sZCs2bPYx9PA
         AgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Lh1d7xwAI6FSaEeuyG+QlzDPrQOD/TqkSwQQ7Nk24C8=;
        b=UJBZhfQJzMlIkat4L4uXRl/q8j8BoGLg9SIATUv9TdMo5khxgkfhKfHiduqs+1P4wx
         sXnsiGo4aC4EzavwrD1ry9JBxG+srHayPK/oxzM/nxAaEudAfJTR8GKenQ+LvRjTNW3D
         +fnrej2ZNEnggV7mpcF48CgiGGC+xdS8DWIKSIPMZm86T30kwGB17fFFViYEI6Zgh/Cp
         HGkO9ji3EsK7p9CGDcQGwu0gwICCrAPieco4OyjE9wDQ8fFPP8cRh5eV2aW7l61g9xZ2
         XZgVmul3RzLGoW1idV/mWr0Wm0c3LZBCort0cH9ekPe56QafdTs3cdwr5Jtg4NBwjzTg
         XniQ==
X-Gm-Message-State: ACgBeo1NYqL7WfA9t0jEl35Ciid2oKaglHG5yLrVrCsJ9wzU3kRW6sU9
        X4Y1XBb5BLH32D9dV3hBMOw=
X-Google-Smtp-Source: AA6agR52uNIsGsiNN3adCvfvBerjXs3GEPH9NruULNz1WsuQMF1qtz/Q2G17FSQDXjSx+uazAQSXGQ==
X-Received: by 2002:a6b:3e8a:0:b0:69b:2933:882b with SMTP id l132-20020a6b3e8a000000b0069b2933882bmr5360400ioa.11.1662678175890;
        Thu, 08 Sep 2022 16:02:55 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::6f2a])
        by smtp.gmail.com with UTF8SMTPSA id q28-20020a05663810dc00b0034c0f2229aasm114608jad.68.2022.09.08.16.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 16:02:55 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, caleb@connolly.tech,
        jo@jsfamily.in, Richard Acayan <mailingradian@gmail.com>
Subject: Re: [PATCH v2 3/3] clk: qcom: gcc-sdm845: add sdm670 global clock data
Date:   Thu,  8 Sep 2022 19:02:43 -0400
Message-Id: <20220908230243.207783-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <8233a19a-9b0b-6962-6f36-381c8f380ad3@linaro.org>
References: <8233a19a-9b0b-6962-6f36-381c8f380ad3@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > @@ -3515,6 +3881,7 @@ static const struct qcom_reset_map gcc_sdm845_resets[] = {
> >  	[GCC_QUPV3_WRAPPER_1_BCR] = { 0x18000 },
> >  	[GCC_QUSB2PHY_PRIM_BCR] = { 0x12000 },
> >  	[GCC_QUSB2PHY_SEC_BCR] = { 0x12004 },
> > +	[GCC_SDCC1_BCR] = { 0x26000 },
> 
> You are changing existing SDM845, so this should be separate patch with
> its own explanation.

I only added this reset for the sake of completeness. It is not used in my
initial dtsi so I will drop it from this series. It can be added later if
it is needed for a specific device.
