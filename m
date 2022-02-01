Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5424A56A6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbiBAFXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbiBAFU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:20:58 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEF2C06177D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:51 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id e21-20020a9d0195000000b005a3cd7c1e09so8466023ote.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dAgRdlbtzfDJA3fxDZWwcXLHlGsqMKwkA2c7On9l7mY=;
        b=EegnhEj9MYuo4VjqxEZMT4nrpVI8IQpnJd2TdoGSACTswGSco3YdYly9NgkXffOvaC
         QOx0z4TmADBEDlzMD4ytBLRKU+RzILggcxQ+Kd6rjarmCy6QnJdkMgaS6f8nh/qB0I/a
         gF4VS6QFDY3+wq7asipqFZ0ekGWCap3xd4TpMTEspnqM45rjFX8uGIxAI5iN9r7AtSNA
         FhTwyjPER9+1w1ijtv5Sh/09S3TZzSFlLPhzx30qBoIKQL0bJYf2QKTtqO4JK6C8vpRK
         4ETGeiLOhdV2+ITaRwPh3vH4ZBb73HzU4BcDxzWlppdRNJolwKvtIbHe1RGR2sYkBoH8
         B5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dAgRdlbtzfDJA3fxDZWwcXLHlGsqMKwkA2c7On9l7mY=;
        b=gHpJrUjrEANJDTVrC4BYQqFu5KeoMBP3+ybTd/XYF1mWf8hF+6d49SGGUtxvq8bGIO
         AiSGqo0cSl39YrzrNgFyna0yby+UWwCDJBvPJtBb+aDGTNrqRCHS9b6SNN9MQmliLdoD
         AI8Ow3LbFIRH+l/eH3HZjmG8pngV6J/GzL5WjbAt3BsYOyb63jApgDRiLfp3rK8CeVZs
         Feds/ybbY2XXfrpyegD44G+1KYAkgaRRuM/kkENBg20ut6oUeeXrZfABmJg/8Brmxprl
         aEpdTBkSK6f58FQ+3B3j3VqzOZg+FqpXVSIJiHI4E/6ZlIYXMMMqRZa+fuCJD3N0IveY
         V5aQ==
X-Gm-Message-State: AOAM531D1n1J4HF2mtDigvK/qTwDyCiNBn2saeRu8Mqp1C9/j/oaJg6p
        w2YhdGyrRLWiUBDtR7U/We+cvA==
X-Google-Smtp-Source: ABdhPJw6kXuZp3tSgSWyM4P90f/w4AkE856R/zJMf+1nAa0zqoHaYjyHf2ujG9/TtZA/XxPgKq7tsw==
X-Received: by 2002:a9d:7097:: with SMTP id l23mr13773313otj.190.1643692850692;
        Mon, 31 Jan 2022 21:20:50 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id u3sm8193107ooh.19.2022.01.31.21.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 21:20:50 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>,
        Mauro Carvalho <mchehab@kernel.org>,
        devicetree@vger.kernel.org, Robert Foss <robert.foss@linaro.org>,
        agross@kernel.org, Andrey Konovalov <andrey.konovalov@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v4 0/2] Remove clock-lanes DT property from device trees
Date:   Mon, 31 Jan 2022 23:20:00 -0600
Message-Id: <164369277342.3095904.5682243255804634032.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211206154003.39892-1-robert.foss@linaro.org>
References: <20211206154003.39892-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 16:40:01 +0100, Robert Foss wrote:
> This series depends on the below series being merged.
> https://lore.kernel.org/all/20211206151811.39271-1-robert.foss@linaro.org/
> 
> Changes since v3:
>  - Bjorn: Added RBs for both patches
>  - Split series into two series for the ARM64 & Media trees
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: apq8016-sbc: Remove clock-lanes property from &camss node
      commit: 015bbdd314110ad20d440bec4d8483f73f4a8b58
[2/2] arm64: dts: qcom: sdm845-db845c: Remove clock-lanes property from &camss node
      commit: 6bf3c1895f5848977ab3912eb76fd996bc4d2768

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
