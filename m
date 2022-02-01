Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6824A5693
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbiBAFWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbiBAFUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:20:48 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3307C061787
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:44 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 4so6755573oil.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hy1PRuFMC9Ce2a9cN4d8FhqZJnP42URBCgpnIQqeV8w=;
        b=DT4fm5bhm/yWpQy4ULEutr8AAWE+qCM7uAwskI4/Ky9os3bIMLZjEB+kPdWWzpwwTM
         LNaO9LEh5ze+ySW5/+ZaLAlWrA3NDnRLNUixmTVnh21wF+AooRQup+1FMM8FBIQ98YVm
         kI+q+pHOpprM1CiWG6S4Jk+Bzcercp4P0YkUkQMRdm7hvjBnJTyRSFlK9cvPrwf0djIz
         plMhzyIXQdzP1CtSSsUAgqRqd3ey8v6OAzuYYeJ2F0ZBoKRR/XAGqrzo7JtO6klBzAjD
         i1MWJ9kxETVIkixUx8FQQHImRkIm9qY3PSK0J3T8de4FM7qNmwQCU657dJwhZ7LkTl4Y
         3/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hy1PRuFMC9Ce2a9cN4d8FhqZJnP42URBCgpnIQqeV8w=;
        b=rdGvGPnyjjufOFnJhpoSxgI/uR5ohxRo4ZcDOf1reAsXM/0Q7rAIS73DWPH5LDCDHE
         CiMn9+DA/KKRUWowQupI8Um1uUC5MWdVxDsZ2OOWD/C21uoetq5Or4nYbbt17Kd+MIbt
         hAdCVInoPZft7g13um3uHOz8ZKZ0BloFLr2uX4wfAR9dZL0+uOJavphLgPzSGfZZY5HF
         UZYgRjfStiJMO4KoURhlBKoqeuAFBD1FUntXZ154b8TP4v73H0De5EJk32P/emxWDt/i
         q+fz5puT9wtEoO8gH573W+ISOUZX8XHb/byfuYOSUybPwuQAKEw4jW9nfQkZCVlvADGJ
         lKLQ==
X-Gm-Message-State: AOAM532RXWK9iY7qx/Mtu+3n0dloR2nirrHHIChAMLyWeepSj06do3JJ
        FO8InNnh05wlZ6S880J5b8k8zg==
X-Google-Smtp-Source: ABdhPJxtu24Ia2hL9Ce0dNrzZ5Z4HZ7RBd97CQJdFBRRdq5FIYEsqDkdRyAubR7kTtLy5M1jZp6x0A==
X-Received: by 2002:a54:4812:: with SMTP id j18mr216625oij.274.1643692844164;
        Mon, 31 Jan 2022 21:20:44 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id u3sm8193107ooh.19.2022.01.31.21.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 21:20:43 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     phone-devel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] Revert "arm64: dts: qcom: sm6125: Avoid using missing SM6125_VDDCX"
Date:   Mon, 31 Jan 2022 23:19:53 -0600
Message-Id: <164369277344.3095904.5938604292655738290.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211229220117.293542-1-marijn.suijten@somainline.org>
References: <20211229220117.293542-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2021 23:01:17 +0100, Marijn Suijten wrote:
> This reverts commit c23f1b77358c173a25ef21303d2a8cc893e9ce22.
> 
> The SM6125_VDDCX constant was replaced with 0 temporarily as the header
> patch defining this constant resided in a different branch, creating an
> unwanted dependency of the dts branch on the drivers branch.
> Now (by the time this patch will be applied) that both branches have
> been merged upstream, it is safe to revert to the constant again.
> 
> [...]

Applied, thanks!

[1/1] Revert "arm64: dts: qcom: sm6125: Avoid using missing SM6125_VDDCX"
      commit: a90b8adfa2ddfd74944fa73be97fabe230f0046d

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
