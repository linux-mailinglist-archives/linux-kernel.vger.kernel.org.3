Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF1B57922F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 06:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbiGSEsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 00:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbiGSEsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 00:48:13 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC153718B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 21:48:12 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-10bec750eedso29283247fac.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 21:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hrgm9iEjYHCT7vDiZxnb9/DfHJ5rEp8gmRRLQ6cFG7c=;
        b=RECNLmCaJxojJZNOm+5PR9WHb91ExNN0P3ArQuuOqntoErDHl8ElcnKbaB7IkyjEkh
         /iyZZpjBO2PbufjY3pu42n0cHnrmL3bpkj2bm1YeZqu9PDnKZ0E7BGNMg8cqGRww1262
         ekvKjnBeaHtkMUvVMBbRXOWuPVTQUQuqQbmaOVT8xjIDw0vPCLFZQepPNgZTuaxGHtXn
         SZwr+YjzyqHmkDkXIi2TxCOzrf5m57cCw6zxkajKmplEyyoj+LiRbzZPVM1AQr7OtCCz
         lpiySCgc4GRaa5+f3VHDQbXPwWWWF63DXxrkKd0O6GqchZrOePtNbbvC3EDCKMW/Sbsq
         Ad1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hrgm9iEjYHCT7vDiZxnb9/DfHJ5rEp8gmRRLQ6cFG7c=;
        b=TD0bCvZ2t2ozozsHK6VTovxSTwhLSELDYXQBaZWf2FSViyJeS9rUmIyC+gvuev0bft
         BY16RdCkkKasN5FKAgjhxl8g2b12niZX31MxUthLkXpY0dewj88Ei2U3GJkNTfzXYsG8
         0Qy1A3YQSYRPUOvWuKoYDCvM5jpCFPvoZKDFyeWkitr7C7KpvYgvGZ67iv26dED3hupj
         7OVeVyD3vqlwtWbprrCEu4bZpoUaC7n6N/Vq8suS+Aq1a6svBF9u9oWOHSLunjWmjo+D
         Govl4aaxLTRnmDjYWgadLf41EQW/o/dSkABF8jfOTI8Zu7jpIocUBBZDQwCE2u0AVXAK
         FePg==
X-Gm-Message-State: AJIora9ZvK6xqWTtlPMeFJSrgPE4y0ggMqISv3ysShho6y8PJB+VX+W6
        x3TviyMjaisZSp66fQUqTiqZgA==
X-Google-Smtp-Source: AGRyM1vGiqdkuIEkrXAVQzakFroZcZdk2ytwJ2YMCWLQz7mDYQ0epTYbKJP1cZ/zA5Q6b9I/RVOpDQ==
X-Received: by 2002:a05:6870:5715:b0:101:a89e:8d6b with SMTP id k21-20020a056870571500b00101a89e8d6bmr16289832oap.277.1658206091614;
        Mon, 18 Jul 2022 21:48:11 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w9-20020a9d70c9000000b0061c9bbac1f9sm2803209otj.16.2022.07.18.21.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 21:48:11 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     bjorn.andersson@linaro.org, sboyd@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org,
        linux-clk@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: (subset) [PATCH v2] clk: qcom: gdsc: Bump parent usage count when GDSC is found enabled
Date:   Mon, 18 Jul 2022 23:47:59 -0500
Message-Id: <165820608069.1955453.5113985730851647863.b4-ty@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220713212818.130277-1-bjorn.andersson@linaro.org>
References: <20220713212818.130277-1-bjorn.andersson@linaro.org>
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

On Wed, 13 Jul 2022 14:28:18 -0700, Bjorn Andersson wrote:
> When a GDSC is found to be enabled at boot the pm_runtime state will
> be unbalanced as the GDSC is later turned off. Fix this by increasing
> the usage counter on the power-domain, in line with how we handled the
> regulator state.
> 
> 

Applied, thanks!

[1/1] clk: qcom: gdsc: Bump parent usage count when GDSC is found enabled
      commit: 41fff779d7948147f2440c4bb134cdf8b45b22d7

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
