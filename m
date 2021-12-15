Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3304765C0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhLOW2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhLOW1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:27:55 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189A9C06175B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 14:27:55 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id s139so33621652oie.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 14:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0k/4WghU8oFurHJHEHSouu6Us6eVLuVOzOhdp+JcH0k=;
        b=NeDhHnDzQKmHQdukLfPb57fcY9sRvEeshRGWjl6VbHYN/VNd2WIdiGucN3VyQHfHyi
         ODX0tPBTzdHUhS/K/UFskuk3zbVPplOGuu1x/3hM6Od2OgzHrir6KktuGRDLF4LOX+Vz
         smHiXw5l4g/gYIGX3S+KGZWonIZx7TDqmoQI+DekZRsEy3SrNmlSXlyCCG5uZAu0Yfzf
         LJrhT5CgejLIjStw/okC2VQgzpIsD4mkhq6Jnn8j/tcQRpqfLEkVXuhlhZMr5QdglWyz
         S7wASV77km5m+lI0oQ4m2DMor4fr4TyP/uoOVeJECDFrpy5pBzEl3XpiE4O2sXMtjjSt
         YvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0k/4WghU8oFurHJHEHSouu6Us6eVLuVOzOhdp+JcH0k=;
        b=sHugcQr//uiPsTOD5ujEzTDPUSzneyws6PP4JMJLaLJqbtmISIgGinE61bVGB94D+o
         WbpNTi5ZLIIr8uvXMy/Wwae8AOPfysaQt7PPYMyu3FVSOhe+DAU4ukcJ8Og2jemBgSCR
         gaJJpIPXQC6KHD9xrZjJSNV7n1poZFnjTREAXldHYGOee7hPRqj3nWuuPiQj0pLtrF4z
         0VcAPnb3No2CEq+fFEW0DKfcyzIqWCk5ng9w8a4bPPU9wQug1QBJwuZMhEMWbcxIFh6L
         +hgGSWpJ3omU8THDzRAYkABA/vEgCrhuu6C7SO98k8mmQvM0cqATvOxxckLQqi5SIv7z
         Nnhg==
X-Gm-Message-State: AOAM530QazQIWPwQtO1LkRoCwmegJ0kubSU57NvH5ESVqwHoGtiQh1MD
        wXmo4Ed67vx5y3zK5kOIvrbSgg==
X-Google-Smtp-Source: ABdhPJyiZGSg7nl3iPZNacNkzzIriIsA8K+pbTW1R7BSm60R5ayfzMXsdIZwV+OW92zh2rfswPUntA==
X-Received: by 2002:aca:1202:: with SMTP id 2mr1806801ois.63.1639607274378;
        Wed, 15 Dec 2021 14:27:54 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t14sm700500oth.81.2021.12.15.14.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 14:27:53 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-arm-msm@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        de Goede <hdegoede@redhat.com>, linux-phy@lists.infradead.org,
        linux-fbdev@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Amit Kucheria <amitk@kernel.org>, phone-devel@vger.kernel.org,
        linux-usb@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>
Subject: Re: (subset) [PATCH 00/10] dt-binding patches for sm6350
Date:   Wed, 15 Dec 2021 16:27:26 -0600
Message-Id: <163960723734.3062250.16152122166909189415.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211213082614.22651-1-luca.weiss@fairphone.com>
References: <20211213082614.22651-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 09:26:01 +0100, Luca Weiss wrote:
> This series adds compatibles to the dt-bindings documentation where it
> was missed before.
> 
> Finally, the last patch solves some further dtbs_check errors by
> modifying the sm6350.dtsi to match the binding docs more closely.
> 
> Please note, that the first patch from Konrad is a resend that wasn't
> picked up when sent to the lists in August 2021.
> 
> [...]

Applied, thanks!

[10/10] arm64: dts: qcom: sm6350: Fix validation errors
        commit: f56498fc6a9364a35dd74af791bd1251467e9cc1

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
