Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0784A569B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbiBAFWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbiBAFUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:20:51 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC82C061773
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:49 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id q14-20020a05683022ce00b005a6162a1620so2403171otc.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F9HwklFMgrH0ZHo9rfrNQ1EtdGLFrJIK/z09jxQ6sQE=;
        b=NCBTFggGO1gX9FqyqbBI0ltcoWZj8mJa769wa6/KSNbC9l2eF3cU7jQuNvMoQcRd9H
         x2ltL54rif8kfP6tHwjX0Fm4qooi1XAlWv7gQ1gvpMgWDmF5s1yyImLGd5hLDZalfEeB
         WaX+CtM0qv+4vtKpm+n7faiKwkk24J7PgE32Gx78wZXjRc3bgGACgNtk5bHx7tjXopBf
         lfaTJ6/eEEybaneS0IHinTd7g8SQJyfQh+M4AZYljUix0ww/ts9067dtYJ96iU//8Xlh
         mAipd6OVms+UJ7xESwUONmb0oiHgUqSEPokef4R9xBRuftCu613+czXsKrFaauIUFtxe
         lZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F9HwklFMgrH0ZHo9rfrNQ1EtdGLFrJIK/z09jxQ6sQE=;
        b=sFs2B1PwGZ6Lx7R4pXXXigT0gB4K2daQQhYnyzu6Y8zjqe+tkBAigo+x6xXv4w6csi
         yfTA18Q295/AMLOPvCBsMUmPlhQUC9h7Jb6MCyGtDn9jBqbJt7D4GKb7+0hDDHldiiJh
         ppakRkvhOVEv85I2zNwzAOFH7pVhNJiKEPd78JD0Rh7ROkDD9bo8AcHsJ7qXPSon8hBs
         GXWmLuksAzX5FU4fXPsiWlaKz5Q5FXMoFc0sRWZwsZSWczDkFE5G9F4iZqUh+zR/SKrp
         +yJpjGiZ6tQZf5ORdmf1IDXfBFl/Bavx1OvlFnMFUBfFq8WodTF9ssU1yuyAyWasRx84
         DxeQ==
X-Gm-Message-State: AOAM532VEQhkJRpr7/ggvmfNgKLxJ4RcVP9WcmucuY8xN/dCUn5cRq+e
        F2/OUH2OExmb1wUaUgD4+YaXWg==
X-Google-Smtp-Source: ABdhPJxQgX0OxvwSIzQuemWh5fh9ef7s10rXI9v+cOHjLYoj53CFX2N69eo+c6EVORP4GKgX9ujvCw==
X-Received: by 2002:a05:6830:1f2f:: with SMTP id e15mr13175426oth.175.1643692848578;
        Mon, 31 Jan 2022 21:20:48 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id u3sm8193107ooh.19.2022.01.31.21.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 21:20:48 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     ulf.hansson@linaro.org, Maulik Shah <quic_mkshah@quicinc.com>
Cc:     quic_rjendra@quicinc.com, daniel.lezcano@linaro.org,
        quic_lsrao@quicinc.com, rafael@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 00/10] Add APSS RSC to Cluster power domain
Date:   Mon, 31 Jan 2022 23:19:58 -0600
Message-Id: <164369277345.3095904.10944386444643776011.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1641749107-31979-1-git-send-email-quic_mkshah@quicinc.com>
References: <1641749107-31979-1-git-send-email-quic_mkshah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jan 2022 22:54:57 +0530, Maulik Shah wrote:
> This series patches 1 to 4 adds/corrects the cpuidle states/
> apps_rsc TCS configuration to make it same as downstream kernel.
> 
> The patches 5, 6 and 7 adds apps_rsc device to cluster power domain such
> that when cluster is going to power down the cluster pre off notification
> will program the 'sleep' and 'wake' votes in SLEEP TCS and WAKE TCSes.
> 
> [...]

Applied, thanks!

[01/10] arm64: dts: qcom: sm8150: Correct TCS configuration for apps rsc
        commit: 17ac8af678b6da6a8f1df7da8ebf2c5198741827
[02/10] arm64: dts: qcom: sm8250: Add cpuidle states
        commit: 32bc936d732171d48c9c8f96c4fa25ac3ed7e1c7
[03/10] arm64: dts: qcom: sm8350: Correct TCS configuration for apps rsc
        commit: a131255e4ad1ef8d4873ecba21561ba272b2547a
[04/10] arm64: dts: qcom: sm8450: Update cpuidle states parameters
        commit: 6574702b0d394d2acc9ff808c4a79df8b9999173

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
