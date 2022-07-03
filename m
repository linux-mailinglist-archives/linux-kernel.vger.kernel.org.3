Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6E6564485
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 06:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiGCEAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 00:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiGCD6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 23:58:43 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C774D118
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 20:57:46 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-f2a4c51c45so8815918fac.9
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 20:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Emxj6B8RLEpOF17lOK+icGSrGoqTCUV5gDGYAaGKNYU=;
        b=JIkCOxkvuDKif/JKQTFwmxzbCUkVlKSdTPVkMrcAKG+/yf21o0uLqYOrlf4Rbu738k
         TD23urciM/hGhP7KujJU8N6khIzr0037iDAOTzV8I4GOwACeSHmtjmRC/cL5Auaa1PUR
         Yrf4hCN3yd894HFTz9HFnkbXrpxgu6KRIgYt8bwVW+2S9cVi++rnRBfXFDywLYVyuoyU
         vcyCeVjSW2b7fE6jJuRYVuLIW/FwcxNNoWFvjTBidjq1trPxsMGxFmaisIQALHHrkYOz
         uMiSbw11tmgGIf0FgiJLf6gw9aOrztJz+VJr5EuEXzwxQPfBGz0bxbsDIImy9BykiYwB
         oo9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Emxj6B8RLEpOF17lOK+icGSrGoqTCUV5gDGYAaGKNYU=;
        b=Mo+oPCnqsjNP/JzorOuK2KJGiQLu99sGUrplfFuM2CjcGcii3pXylPWhsRzx82QgL8
         zZpT4ojQ9FC0aTi8UjN5xOHj03FAfst8NX9aiSZW6A8cvbrCim7lKmudCwzqPA3YvA+l
         9fZymTFrLnX08UkdjhUEsYwEyV4vFbmYQvO05ck4VfY9HI5f8uJfy2nO+7DMxyLWuZPs
         csTYxaYj3vzVLI8LaJmB+TYOzWR8t9dyxXVTYkMZU2M/D50qEOvkoD5sfimof6kCFbJg
         /Imjl+wc7ZAV9yv3UBNhxQCpP5gKV5b9zYee0V0VlaVyn4QPDCqcqyM8vZjGmU8sjObK
         Xtow==
X-Gm-Message-State: AJIora8Ds3d7aSaWdtCA1Rl2Kbyrx9UlHJQ6KWy+ogQKAPG78Kqs3Il7
        A34o0us+zNatJW+QcTR2xaPkYw==
X-Google-Smtp-Source: AGRyM1tCe8G0a4qQnf6SnaDROK2to8wo42AWtTmOaI55tWwortvw3/EP7wjiWIjRuBBFhYnRkyGarQ==
X-Received: by 2002:a05:6870:2e05:b0:106:7fdc:de95 with SMTP id oi5-20020a0568702e0500b001067fdcde95mr13253919oab.123.1656820660785;
        Sat, 02 Jul 2022 20:57:40 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 25-20020aca0f19000000b0032e5d0b5d5fsm12965910oip.58.2022.07.02.20.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 20:57:40 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        Rob Clark <robdclark@gmail.com>
Subject: Re: (subset) [PATCH] soc: qcom: ocmem: Fix refcount leak in of_get_ocmem
Date:   Sat,  2 Jul 2022 22:56:34 -0500
Message-Id: <165682055970.445910.4147931159861380417.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220602042430.1114-1-linmq006@gmail.com>
References: <20220602042430.1114-1-linmq006@gmail.com>
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

On Thu, 2 Jun 2022 08:24:30 +0400, Miaoqian Lin wrote:
> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
> of_node_put() will check NULL pointer.
> 
> 

Applied, thanks!

[1/1] soc: qcom: ocmem: Fix refcount leak in of_get_ocmem
      commit: 92a563fcf14b3093226fb36f12e9b5cf630c5a5d

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
