Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D319B46AC27
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 23:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357755AbhLFWeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 17:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356734AbhLFWei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:34:38 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F94DC0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 14:31:09 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso15660151otf.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 14:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gc3XKEdlwcQi21rErNXJzwZMgigjK1PyUPkJQEPB4SI=;
        b=cWPCB9Ra9CAor0a9Di3yqixNVVDX1o5qLCwHfZf2napJr6GbG5RNbBP/t0VeHfQdFt
         ae+vvfvYKJhxM7RHcsFQES+yyd4dkoB98d6WoMhVCo+HZEhx3OEday1x1yRfE6r6JMet
         E4EJl0Wzen4CYwy4zWLAKGsrVlkvHqZpsdXPOvpC2ZuTcsH8c09k2BhweO/kUdg9TrZU
         3U2nEYh8s7Sb2y9bB72RoC+gL7KHQhH6Ocx1hwWyvooicllIV67A1rNYaUgm7/A4Cp9l
         CX7TOFxmefvEhJMH5Kmp/psMbTL5jHMbXPO5YtKplN/arXEAOH/CQfsWM4Yk9XTNKJ/q
         kvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gc3XKEdlwcQi21rErNXJzwZMgigjK1PyUPkJQEPB4SI=;
        b=QlL+kgHl9UFyZgwMLHv3Ivk6A6EFRs7/3A/gFbgsnUCXeznD6cqnxSiUMNVSHz9/MS
         7HM3Qv+V8hmK3iyrRYDFZqzdCsswa0kPAdo4prd9lqBS1ruraNMy+z+kAifPj2OFptej
         RHz+HKiIGQCZ3DVTBtmUmvZLaReR1pRmHbvIgxF/Rx5hdn4G6Kp5Z586Fur8wnMivZ1Z
         bYbegnlD0yfd+QYfH+Uhwe0NnAdlH5tr3RFF7E0UY8wFVepuGJfMxFeLyrw+9Ocr6FhE
         TiQQcfTtDk7DuKW0U81dRtqaqvx5GB/n43C6k59ayOpr16dcWQJzYkiX1yXk7XAGEF7H
         GC/w==
X-Gm-Message-State: AOAM533P881Vh5NODsbLzyS8ax7gjC/uYQ5q4Yizy8uVyMGXR6yA6iFr
        SQSW3ps4Pk/mSMuo7nDVfZZ9bg==
X-Google-Smtp-Source: ABdhPJw29Gi11NTWTz5X7DKd8NxqD5kfh1TXsX0zn5LVjsDCc5qhT/eb9It0Ve9SzUQ0jq6Qgunp1g==
X-Received: by 2002:a9d:2d81:: with SMTP id g1mr32482183otb.25.1638829868719;
        Mon, 06 Dec 2021 14:31:08 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r5sm2911815oiw.20.2021.12.06.14.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 14:31:08 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, tglx@linutronix.de,
        agross@kernel.org, quic_vamslank@quicinc.com, robh+dt@kernel.org,
        maz@kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, manivannan.sadhasivam@linaro.org
Subject: Re: (subset) [PATCH v6 5/5] clk: qcom: Add support for SDX65 RPMh clocks
Date:   Mon,  6 Dec 2021 16:30:59 -0600
Message-Id: <163882985136.2324147.8953107100167794416.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <366448562ac52c600c45b5a15129d78b5e8dd5a7.1638402361.git.quic_vamslank@quicinc.com>
References: <cover.1638402361.git.quic_vamslank@quicinc.com> <366448562ac52c600c45b5a15129d78b5e8dd5a7.1638402361.git.quic_vamslank@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Dec 2021 16:21:35 -0800, quic_vamslank@quicinc.com wrote:
> From: Vamsi krishna Lanka <quic_vamslank@quicinc.com>
> 
> Add support for clocks maintained by RPMh in SDX65 SoCs.
> 
> 

Applied, thanks!

[5/5] clk: qcom: Add support for SDX65 RPMh clocks
      commit: 40affbf8e615addd8cc877f0a4fff1faafc4bb34

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
