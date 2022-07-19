Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F5B579234
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 06:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbiGSEsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 00:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbiGSEsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 00:48:16 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C49C3AB38
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 21:48:15 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-10d7170b2fcso679611fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 21:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8aJymfMTLF3V7ElX+b3QpJ+uAT3GT/5Q9yr/dFcNEhs=;
        b=vaKuG49TyhspbeY60kzZ6Im+k6xB5DEp9boY/8u3C6+YuM7Quo8zoXp0IiwwvMtxmU
         VXCgRWsb+lwpQfoVDwiQ73gnlkKo6WC8W8VA65guUg3D55tCqB1GYsGHeKLOcbCEzaB/
         BUc5PWm7ORAlDOM97jtyT+CLKNfmbAkWOKmtZjsrmCvJSFh+SwBWtIrzu+bgpjaBIEk/
         SfLonku3BdT8K0+nGwDZsiM5PjLpDVGPDNpl/vEFoKwVbpzvaxrG66Hl5ka1AiQ9AzdY
         tOqjKEuMcYMNPe6GuVWzOvL5/4I9Wy408AJFMpDsWdJONSblT0RJ/KrrT+DnJyuFWKRl
         XQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8aJymfMTLF3V7ElX+b3QpJ+uAT3GT/5Q9yr/dFcNEhs=;
        b=XnlANfmHyY0oAYdffdMGhGbhzHXawcK0yEXXUzaAmx+5Wq5680z4ZTi2Y5eSRI9S+5
         votQqFFaS9Npo1P4RJ1XXFPqjhH39nvfVvQGLX2Sld6bbFLHyMuzwWdfGq7CcVxttPMe
         iH+kn27gDdgEHQ+7KJJWrfYjVrBjEZLu0KCsLq9X0Zgt4hbIx0Ii6+zARCMDB0lvSska
         ACYyF5WrpkEwseaOcr5Ol967vssiY09pODnTE2ZMsiflh9U3k0xL8Opds8QqkrQPwnLl
         prx1CcI52VZOpY5Zmk8W0+Lwnz4yAOcvcYkAOSGBo847KKN+Z6nmhGUs/VRb56FP8C2v
         Trxw==
X-Gm-Message-State: AJIora/+F3sOIQeedShTrQmTBvKL3/r4Y64sgY8Og3QSkhz9SabgqgfN
        2J6374YCYcGSdsbW08HegG2dIg==
X-Google-Smtp-Source: AGRyM1u+ErfCuSHr5Erivc76AfPeU0LhRvfrJ7R7I2Ve4TYxaQ8gthTJr0jwPUUBpxCskBCB6aUsaA==
X-Received: by 2002:aca:1803:0:b0:337:e764:9927 with SMTP id h3-20020aca1803000000b00337e7649927mr14949031oih.51.1658206094780;
        Mon, 18 Jul 2022 21:48:14 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w9-20020a9d70c9000000b0061c9bbac1f9sm2803209otj.16.2022.07.18.21.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 21:48:14 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     robh+dt@kernel.org, robdclark@gmail.com, quic_khsieh@quicinc.com,
        sean@poorly.run, vkoul@kernel.org, swboyd@chromium.org,
        agross@kernel.org, devicetree@vger.kernel.org,
        dianders@chromium.org
Cc:     quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        quic_aravindh@quicinc.com, linux-arm-msm@vger.kernel.org,
        quic_kalyant@quicinc.coml, quic_abhinavk@quicinc.com,
        linux-kernel@vger.kernel.org, quic_mkrishn@quicinc.com
Subject: Re: (subset) [PATCH v2] arm64: dta: qcom: sc7280: delete vdda-1p2 and vdda-0p9 from both dp and edp
Date:   Mon, 18 Jul 2022 23:48:02 -0500
Message-Id: <165820608074.1955453.1557807402050131416.b4-ty@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <1657556603-15024-1-git-send-email-quic_khsieh@quicinc.com>
References: <1657556603-15024-1-git-send-email-quic_khsieh@quicinc.com>
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

On Mon, 11 Jul 2022 09:23:23 -0700, Kuogee Hsieh wrote:
> Both vdda-1p2-supply and vdda-0p9-supply regulators are controlled
> by dp combo phy. Therefore remove them from dp controller.
> 
> 

Applied, thanks!

[1/1] arm64: dta: qcom: sc7280: delete vdda-1p2 and vdda-0p9 from both dp and edp
      commit: 8ed85d1e515ff5f302a929308c7ccc06bec68632

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
