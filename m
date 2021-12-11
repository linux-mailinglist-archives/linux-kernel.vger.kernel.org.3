Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7FB4710EA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 03:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345809AbhLKC0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 21:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244551AbhLKC0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 21:26:18 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B3BC061D5E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 18:22:41 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id r25so34847686edq.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 18:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4F5z90YwZ0RiEGzI0D+aa0jkXM6rObDGUTi8CCIv+cU=;
        b=QcwlGBpCYMzXFyCORsK6wBY3dOlB/Q/mhwnsNtTG9WItFKyfrqMYbaUv3n2mpzaEXF
         p7Hbr4os44THPRiYfbjLNYenvq5JAbysBnoYdBCWP5uFpBKaFXzstSZ4KbFq9P98V+hN
         Nr70sPmjx9RgZJ4bSX8gXCPGwSPjLuQ5xFvkDm1KWetzI9KU3/Iyx+18SUmqzvWwDM1d
         iHvWyZlDk1/xUZsrI6RWXRGP/6HTBFXTmQCP5zU9tMRdb9c2tl3Va0KwIZQdljOXKcT5
         ChzVt8hDxAF2mJebX4xKZo8bbc4GGZScKDOQif/TM+eaAtluLjn9paWcLWv1m4m/2tLk
         lArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4F5z90YwZ0RiEGzI0D+aa0jkXM6rObDGUTi8CCIv+cU=;
        b=IPcZ1G2NoXha7pRdcpi9MQYeImgcXg8Nvv+M8jjw1DD9o02NUQOK1Vdf2CA/ybMJHD
         e3rF8LkmqIW0AY5DGsrT/SV6rAT2C1dmHgJJPqTgqDuxi6QCa9owuAG8osKyZQgMcv5q
         tLKqcME6FiV12EYbJjEwQHuOCVXp2TZ0zUlwkWzD9nu4Tiz3wxwSfHQnTSTAFbFJN2FW
         y1jXdrRkL4R6Ulre9ApBigwQpT1cvtexhszABrxX6Wbr+8H0bHDxwLl8WPUSmQ3mQOKG
         Qiu5PmpWBhRlbMhBlPAXLqthm7eCB71z96Wedg18lE3VbCmfEn6rxl6cjClzG8hfoeK9
         CYQQ==
X-Gm-Message-State: AOAM533hur49PZR89P4ulASIgSKRc/yLKCVkLFTGz09xfzTVCEg8KoGP
        QiXrv2RmUNyCwEd+PES3MJy0Fw==
X-Google-Smtp-Source: ABdhPJweTOUDXwubeBdCK7QhTg06GCwERKfQaf2j45gyOyBxQWTURJrROQlrmfvCKfvxg4ftJk2hOA==
X-Received: by 2002:a17:906:c109:: with SMTP id do9mr28059191ejc.48.1639189360389;
        Fri, 10 Dec 2021 18:22:40 -0800 (PST)
Received: from lion.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id s2sm2449424ejn.96.2021.12.10.18.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 18:22:40 -0800 (PST)
From:   Caleb Connolly <caleb.connolly@linaro.org>
X-Google-Original-From: Caleb Connolly <caleb@connolly.tech>
To:     caleb.connolly@linaro.org, sumit.semwal@linaro.org,
        amit.pundir@linaro.org, john.stultz@linaro.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 6/7] arm64: dts: qcom: sdm845-db845c: enable rradc
Date:   Sat, 11 Dec 2021 02:22:23 +0000
Message-Id: <20211211022224.3488860-7-caleb@connolly.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211211022224.3488860-1-caleb@connolly.tech>
References: <20211211022224.3488860-1-caleb@connolly.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Caleb Connolly <caleb.connolly@linaro.org>

Enable the Round Robin ADC for the db845c.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 13f80a0b6faa..1c452b458121 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -595,6 +595,10 @@ resin {
 	};
 };
 
+&pmi8998_rradc {
+	status = "okay";
+};
+
 /* QUAT I2S Uses 4 I2S SD Lines for audio on LT9611 HDMI Bridge */
 &q6afedai {
 	qi2s@22 {
-- 
2.34.1

