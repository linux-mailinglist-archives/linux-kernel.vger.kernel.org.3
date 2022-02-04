Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDEC4AA2A6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 22:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244788AbiBDVzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 16:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbiBDVzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 16:55:00 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35940C06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 13:54:59 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id t199so10041085oie.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 13:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=12+DSXO64Dap/aP4vKIGmR4NHNGPLRNkLER2lR9L6+c=;
        b=dACRuFLWefOoiEXteXAUFMlCSaQy65jO3vKmQR5Rhekl+ZYHItdAHdDv+lHzDhloPl
         BCwxjNcN0YTKkkQXoNBw9VvS6GMN/U0/SI9PNIV9sZCpk91BSQD4cxrqlr2FKxKGdKjy
         jJPAjK13QQ1/IUd+5mENCLVH+ZPKh+/ECIb5eCqKu6+LwP15d7VrMdsrGYyFv9kkXuTd
         I10VQViMJyx8zmiawbrDogOvOV8pB4KN9iQy5BKkj6eAW0LoJQBJfnWw5cGJIb9Q3RZk
         JJe10jp5ksQgTy5hb6UevHwDVneP2uNtmwbuphWuYErGQiUTSgOowmc3hqfs8GUo7qJy
         qDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=12+DSXO64Dap/aP4vKIGmR4NHNGPLRNkLER2lR9L6+c=;
        b=X4ETuktlBOspOVpDgInIwOLLMVuiOtF3uIPOugyd5wq354jWrncgUBSLHrrpEusrR5
         u9grSEBcdB9TnQxVu9tZre3+DOtCkVYGaePh4z8BQWbum8ZGfoqCNufV79qX/l5OmWHk
         dpO16mkohQaZOCvA2SuVrwZn0fvxcw16cfWwdskYguzInygvwNECUMYt/ktCDvQAcqPD
         23+8CAq8600bS3RqYog4jamJMqRMh07wDI9Og/kDOQfqUbs0IKtVIw8iFGlXEx4q9Tnx
         A5AX0aHiGIousYKNXq4LJFkDq9mpcE93ObSEzxzwFyzds9J0ikxtAECLy9TnkGbIguI1
         K+iQ==
X-Gm-Message-State: AOAM530mwWMCjOVxaKzaVSW69gPXjiuzgYkm8UaVOJfSpZ+RPOxXRLVC
        ParD6YQ4Cg5LKh3DF4RDhO5X2Q==
X-Google-Smtp-Source: ABdhPJwdWkdM6Lof9EzJJon83VOgGlAe1OC0M1B+Ed6d7QIQ7Kab6R3NnfYUX4JUzLRW41iVmgdXFw==
X-Received: by 2002:aca:bb83:: with SMTP id l125mr2247249oif.153.1644011698548;
        Fri, 04 Feb 2022 13:54:58 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id y15sm1171692oof.37.2022.02.04.13.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 13:54:58 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     pmaliset@codeaurora.org, swboyd@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, quic_rjendra@quicinc.com,
        konrad.dybcio@somainline.org, kgodara@codeaurora.org,
        linux-arm-msm@vger.kernel.org, sibis@codeaurora.org,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>
Subject: Re: (subset) [PATCH v3 00/14] arm64: dts: qcom: sc7x80: A smattering of misc dts cleanups + herobrine-rev1
Date:   Fri,  4 Feb 2022 15:54:56 -0600
Message-Id: <164401167666.3404829.1032738612788365624.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220202212348.1391534-1-dianders@chromium.org>
References: <20220202212348.1391534-1-dianders@chromium.org>
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

On Wed, 2 Feb 2022 13:23:34 -0800, Douglas Anderson wrote:
> This series is "v2" of my "smattering of misc dts cleanups" series
> plus v3 of the tail end of the series adding herobrine-rev1. I've set
> the version number to the larger of the two to (I hope) help
> allevitate confusion.
> 
> For the cleanups, there's not a lot holding this series together
> except that it fixes a smattering of random dts stuff that I noticed
> recently. There are not a lot of dependencies and some of the patches
> could be reordered if desired.
> 
> [...]

Applied, thanks!

[01/14] arm64: dts: qcom: sc7180-trogdor: Add "-regulator" suffix to pp3300_hub
        commit: 171bac46700fcdb2310209dffb382533fe54522a
[02/14] arm64: dts: qcom: sc7280-herobrine: Consistently add "-regulator" suffix
        commit: 7a86ac04056569bf5ec663fbb02d79c5e304545a
[03/14] arm64: dts: qcom: sc7280: Properly sort sdc pinctrl lines
        commit: b1969bc522187dc6f436301eb71051b24135b607
[04/14] arm64: dts: qcom: sc7280: Clean up sdc1 / sdc2 pinctrl
        commit: f9800dde34e678d7ed1de9e95b4b65a257fd0f93
[05/14] arm64: dts: qcom: sc7280-idp: No need for "input-enable" on sw_ctrl
        commit: 8fdedd6c64643884dc6bbf6d9a7aabda1713354f
[06/14] arm64: dts: qcom: sc7280: Fix sort order of dp_hot_plug_det / pcie1_clkreq_n
        commit: bbef2a9ca08749c89925d2bb49f4ce1c945acc90
[07/14] arm64: dts: qcom: sc7280: Add edp_out port and HPD lines
        commit: 118cd3b8ec0db02eb7306c30c1551ef9af885689
[08/14] arm64: dts: qcom: sc7280: Move pcie1_clkreq pull / drive str to boards
        commit: 376e9183c1d1dde6972257a823cf484cc5124b7b
[10/14] arm64: dts: qcom: sc7280: Move dp_hot_plug_det pull from SoC dtsi file
        commit: ad4152d6e2599c62ef012e528acc5e77ca6765c1
[11/14] arm64: dts: qcom: sc7280: Add a blank line in the dp node
        commit: 96b34a6ea7d03876fb9b82ac8db5648a24fc7b2e

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
