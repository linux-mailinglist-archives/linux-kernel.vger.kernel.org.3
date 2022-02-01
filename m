Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5E84A5633
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbiBAFUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbiBAFUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:20:15 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A223CC061748
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:14 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id i16-20020a056830011000b005a3cc8d20fbso8807175otp.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2apFGkxfX1t4PMALufUaS94H8GBvvJ1PAJONADrD3HA=;
        b=tUTMlzNzqdIuNJ6Ptljfy7CmsubEreZ54a6f/DWBTM/N4m5aTHNudHdz0kesj5QnHW
         bn30VzL9qvmS24D8AYxuBoj5TARj/dP9zpamcMkad5Xi6bZWQv88H31YDRjRZV5DxUfX
         dR6T+jSwabIPkse6AfvZFy8gJOINPBTvc2doaUvHRHVAlEJCTjFu8ZEHaPorqIVyB+Vu
         v/NxOE46ChnmEHXYs6/KzyqZfOXOFwNXGUGQgF7uZZts1cQ/TbxpdSyg8NaVsb93scn4
         ydR4HKFksdLdoDOD0QGr2TtGljB+22WwBPd6k9XbKMOfMIcYCS98DIUY5yNtyEAY4IX4
         rO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2apFGkxfX1t4PMALufUaS94H8GBvvJ1PAJONADrD3HA=;
        b=3IhFOIufiHQ+zQpQDZkktpgtenxgIHmLRugHge3OkLmJ5cHBYVoKWYZiiJZPezwoDN
         lrDFWAGKW44EaVQXL4nq51d8hc7gGhYaxK+1BJcV0NyI4aZATC0HLaxJ+y/bqX6a+yDM
         FXJAZ4UeofveHeictZP0RZFSihqr+nAoWuejVgZaY13TTuoMtEr8/YIcy5vL+Ahz4Buv
         evikqJS+J5bAFjBuAFWq/zna5snxBPZQI5bAIkerajGKtxLKNM5BECiv6Y4o3RAm2TWK
         KLCbKpfjsfo1MyGAu2HCqZZNime5HXQfYxA2gdujNR84T0n4DWhAvc+wv0rdGwO7j1wZ
         JHqA==
X-Gm-Message-State: AOAM533A+wHvXocC6YGYGMYTmFEB/TMzKX04jzcf61Xx/hzXag+sDNgu
        25MTICltV8EXfvhkeiBkO4N/8A==
X-Google-Smtp-Source: ABdhPJwrwYQAU5d3Yj0PCUyCjhiEO5uCs7OlDffQ/EpXZzX94VloxaC1wZq5SDTsavGNI9/VFOzR2w==
X-Received: by 2002:a9d:7604:: with SMTP id k4mr9461316otl.86.1643692814062;
        Mon, 31 Jan 2022 21:20:14 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id u3sm8193107ooh.19.2022.01.31.21.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 21:20:13 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Caleb Connolly <caleb@connolly.tech>,
        Anton Vorontsov <anton@enomsg.org>,
        Tony Luck <tony.luck@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        dri-devel@lists.freedesktop.org,
        Harigovindan P <harigovi@codeaurora.org>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org,
        Alexander Martinz <amartinz@shiftphones.com>,
        Colin Cross <ccross@android.com>
Subject: Re: (subset) [PATCH 6/6] arm64: dts: qcom: sdm845: add device tree for SHIFT6mq
Date:   Mon, 31 Jan 2022 23:19:23 -0600
Message-Id: <164369277345.3095904.2460167653068866280.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220123173650.290349-7-caleb@connolly.tech>
References: <20220123173650.290349-7-caleb@connolly.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jan 2022 17:38:15 +0000, Caleb Connolly wrote:
> From: Alexander Martinz <amartinz@shiftphones.com>
> 
> Add initial support for the SHIFT SHIFT6mq (axolotl) based on
> the sdm845-mtp DT.
> 
> Currently supported features:
> * Buttons (power, volume)
> * Bluetooth, DSPs and modem
> * Display and GPU
> * Touch
> * UART
> * USB peripheral mode
> * WLAN
> 
> [...]

Applied, thanks!

[6/6] arm64: dts: qcom: sdm845: add device tree for SHIFT6mq
      commit: 45882459159deb792718786514bc677c8a6b1f53

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
