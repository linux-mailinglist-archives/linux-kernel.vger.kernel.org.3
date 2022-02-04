Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8224AA33C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351170AbiBDWhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344982AbiBDWhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:37:43 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EF9D210536
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 14:37:43 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id s24so2541646oic.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 14:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m4mjKHRRyWOx/QSo+fyfDltdRNhQWfYo9UJ6vkly8Eo=;
        b=WgCz/FD8yhYOFUt6PljmHtzXqh40o+AEEiuBBVTWwDBcQlK9bY9aJdL0S9uLZJqLQO
         KcBP9T8ieCLhQUxzqqwL42MxkM6lVqiyCjuN6ptCxVpXTNdEDQ8RF+bez1kHW86ClFrG
         NC9AoRaXlGtrkrExQoCJclSuW82/44XiP+yVmYagHKBpYBh/WBDXXpqRniYYHeiy++Le
         t3dLu2P/3/uVJetkK8PXuTpzn9KunsMXej+kzRAeC3SbAnGbcQafJ+zq4edzbf56HI9N
         BF+QG7Y9purZTkFC4PwzNYvDlE13cjGiEFOL3NmZDjncPxQtT8DaDosmF/ZclZC6Y7UI
         2H1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m4mjKHRRyWOx/QSo+fyfDltdRNhQWfYo9UJ6vkly8Eo=;
        b=odOsy4mjNgh6I491cRBTJRoV2sxFKl0OAoJXNUwarvLtDn61HdtU3Rwnk37HK2L642
         xi4GIFxsvFPRzY2dfM/QX9XGswqg4ax3nRjev4+9gisK9HiJlNhcRfLcDZEQmCC5GNj+
         2N71njgLBgdj0+eCfoFCW/sfwqDNoD8YJaAlYPv9kDTr7yhx2bszIj2cx+taI8MZPq1F
         wry95n7C75mlE5MXBvkWi45u6kQ7D4tO4WVNjqbhKKJQhtk3ZIrv0mdEHBwY8/suPtSb
         PKsWpeg0wvlqgobCfZ/A5Fki1b6tae1LV/yxvPgZqOs81dTDOYYDLmZ+L9nlneC5P3LB
         Hv7g==
X-Gm-Message-State: AOAM533vLSPWa43WYaf+iBzCL5z1NYNZmcbEXOiKnkv3PLvUtZvsMZU6
        JZXPmupM+N0R7GWzntJruqjzWQ==
X-Google-Smtp-Source: ABdhPJyawiaiQeLzadnRHeiM9TF6jP50Z12Hb4yD86mxkjimWzTCeg12W0DrG0lp+jvm8biKNeihiQ==
X-Received: by 2002:aca:dfd5:: with SMTP id w204mr2525915oig.264.1644014262782;
        Fri, 04 Feb 2022 14:37:42 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id 71sm1263073otn.43.2022.02.04.14.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 14:37:42 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@somainline.org,
        mka@chromium.org, Andy Gross <agross@kernel.org>,
        pmaliset@codeaurora.org, quic_rjendra@quicinc.com,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        kgodara@codeaurora.org, sibis@codeaurora.org,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>, swboyd@chromium.org
Subject: Re: (subset) [PATCH v4] arm64: dts: qcom: sc7280: Add herobrine-r1
Date:   Fri,  4 Feb 2022 16:37:40 -0600
Message-Id: <164401424604.3413232.8977987384470598288.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220204140550.v4.1.I5604b7af908e8bbe709ac037a6a8a6ba8a2bfa94@changeid>
References: <20220204140550.v4.1.I5604b7af908e8bbe709ac037a6a8a6ba8a2bfa94@changeid>
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

On Fri, 4 Feb 2022 14:06:07 -0800, Douglas Anderson wrote:
> Add the new herobrine-r1. Note that this is pretty much a re-design
> compared to herobrine-r0 so we don't attempt any dtsi to share stuff
> between them.
> 
> This patch attempts to define things at 3 levels:
> 
> 1. The Qcard level. Herobrine includes a Qcard PCB and the Qcard PCB
>    is supposed to be the same (modulo stuffing options) across
>    multiple boards, so trying to define what's there hopefully makes
>    sense. NOTE that newer "CRD" boards from Qualcomm also use
>    Qcard. When support for CRD3 is added hopefully it can use the
>    Qcard include (and perhaps we should even evaluate it using
>    herobrine.dtsi?)
> 2. The herobrine "baseboard" level. Right now most stuff is here with
>    the exception of things that we _know_ will be different per
>    board. We know that not all boards will have the same set of eMMC,
>    nvme, and SD. We also know that the exact pin names are likely to
>    be different.
> 3. The actual "board" level, AKA herobrine-rev1.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: Add herobrine-r1
      commit: 116f7cc43d28ccd621ff1fecc9526c65dde28dcd

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
