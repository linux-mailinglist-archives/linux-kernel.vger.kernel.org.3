Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153EB50A254
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389444AbiDUOaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389241AbiDUOaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:30:23 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8743ED15
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:27:30 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w194so5752083oiw.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iy+XsehI6myAL6KVn5dImXgKFPVtiwpahoxHlaa6W+8=;
        b=YL/XFCuKPTSpDT9LQ0u2gSLWguoJmeREzY3fUT2kajNVSBHiMcBeQIYPBsWAVI53Tw
         O2gEBPqLa5XtoDiwwKnD/glOhKSSFNst4A3YoEgwlA36QaQdk1VKRi3i12bQ5AYuavem
         miBA0FuUIFzrNd84QYVxH3kGm8AOwbOIV4GEsroyQY9MrEO3emTL5f8+oy2ROcEim8ux
         EfpeOHh0MYnvkUVNM+ZmCi305wClm7GKFI7EvpByocn+6R/J+qU53MYUPqonG/ztF9AF
         lKfRTEb8E2HLRd5qv+VhNku51bcI9pXl8Ya+vEJMctnqP9hV/0q0BNSQgACKxF/77MqN
         gSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iy+XsehI6myAL6KVn5dImXgKFPVtiwpahoxHlaa6W+8=;
        b=P/7O3kvKs5gQJT598zhP2mKNQOGSn9z8W3QAA9hZIssAs7iRftM7MDYNUNYSMLRe22
         TeN7t3q3jTmFCB/V9kjDW54MdxmetCoYv6yxrvPJhcYmLKxJ5zOlSWEr5ZHy57q4Ise7
         bJlHXN8n2MPtxHx43ZsXaygbokWSnHecptOcoM5rg4uTWaUvmSi6a2mGuW6qeK+uNYn7
         1TqYGCRH7HW9uzuQb7kRpn+eYlKaeT/nDq311pJ9/74MBpf72pfMVuOUuy1uJiC+qN96
         hTDKGiDWWjBvMEpnL0L+VlcFka56m2cnNLDo4hxtRxSM/LR1AxpRCOJK3D28EUFMzock
         oTQg==
X-Gm-Message-State: AOAM532XgKMtBbPEuOoPCS8AXan9zkqCQasxcLChy/9G3QMAXBRwdrFG
        YXZ4Js5WmFz4CiA9sTfOtm+gSQ==
X-Google-Smtp-Source: ABdhPJwDJSTzhIjX39Fq4tMduvuKO7oY4rI+JlI6xy2v8gHC0G9bwShy/fxLVML9LC1jPY0qkdgzJQ==
X-Received: by 2002:aca:ef0a:0:b0:323:24d2:1ccd with SMTP id n10-20020acaef0a000000b0032324d21ccdmr348679oih.261.1650551249529;
        Thu, 21 Apr 2022 07:27:29 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id s14-20020a0568302a8e00b006054e841915sm4296295otu.73.2022.04.21.07.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:27:28 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Cc:     quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        devicetree@vger.kernel.org, quic_kriskura@quicinc.com,
        quic_vpulyala@quicinc.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: (subset) [PATCH v13 6/6] arm64: dts: qcom: sc7280: Add wakeup-source property for USB node
Date:   Thu, 21 Apr 2022 09:27:05 -0500
Message-Id: <165055095990.2574292.11484347980865320517.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1649704614-31518-7-git-send-email-quic_c_sanm@quicinc.com>
References: <1649704614-31518-1-git-send-email-quic_c_sanm@quicinc.com> <1649704614-31518-7-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Apr 2022 00:46:54 +0530, Sandeep Maheswaram wrote:
> Adding wakeup-source property for USB controller in SC7280.
> This property is added to inform that the USB controller is
> wake up capable and to conditionally power down the phy during
> system suspend.
> 
> 

Applied, thanks!

[6/6] arm64: dts: qcom: sc7280: Add wakeup-source property for USB node
      commit: 97276cbfb4fbe33c3ab8b5f5277a73c0b5f3732b

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
