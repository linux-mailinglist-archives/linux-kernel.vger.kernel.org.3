Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB6549CB84
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241761AbiAZNyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241727AbiAZNyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:54:31 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B667C061747
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:54:31 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a13so25931579wrh.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z5AnMORgB0aa+xiAll7F0CRVY0oWDotsOZG4NUiDGN0=;
        b=NdW3yfIwrbjsYzOF1RonPMYJ0WpfZTFxuHuQxBM/dVV9Ezhl2+SeHHs6yoaIX8C0hy
         kaQzfRS4Cv/aIaxNI13XhtW+QBB12IbukOsEnmkeAILaSCT+8EzmnizAqSds4mKCYHbP
         QO9wRoQLxzIm0ZJkiWxg3aLbG2X7H7aqyR0eJSsbMjffMUG+vLkJgD5BkUowRQrp2Biy
         0nPMLYA5BTxmvVEZopjPMurq6WrIzYtc5zReiZB0wfE98dXUMNiuzVZZm73TgjmK8jP8
         B0DrAxSf/jAXaA/H7Z1fJZB/3bBRK0AwHucn0uREPTaW/9fn+pf3wmBqCuYvlA/4j+H+
         rKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z5AnMORgB0aa+xiAll7F0CRVY0oWDotsOZG4NUiDGN0=;
        b=QckhjZOwHWk1GTfTC6rXJASgpX+QqKPxWkMCJJd1cAal1NQw9DN+iQVep3ZcSdCXab
         9x/p5fxv7G7BMzYvKtdpC7d3YYXBwuy4+mx5uid+h6xcoF/p96fy6Cput11rH8u9YCnJ
         jaFHgJAWl3HqROx0KDZj3UyRknpTvUfD6++Vd730sxAuHLq6lmlK86toKUYHfpvVXyOB
         JTmo67PWNe3orWzFMwZ15SQtMGdB7TH7VyVCp2ANjj9tNrEW80SF6B1GRUes32SinhaG
         tXLzdgxkrAysFs7Mmi4+ZpnYGQ5xSKghGNQt13bRuQSnnxceI8CkjHhxjLccTEK6FLgj
         xQnw==
X-Gm-Message-State: AOAM531n0sAB6CE4QDVTbNycfM6aEGnNhWSZXmWGkbHfdRtJp22I89bQ
        6Y+yXX74dV9r+VBt3X1cZyz6Eg==
X-Google-Smtp-Source: ABdhPJymzELD6H/RrVSkXF0UApF80RbqrMriC5qEG36lxHjhh0tFfDjthzRNG7rS5Tlrp0AgnnLy4w==
X-Received: by 2002:a5d:6c68:: with SMTP id r8mr11040893wrz.406.1643205270062;
        Wed, 26 Jan 2022 05:54:30 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id n15sm3356593wmr.26.2022.01.26.05.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 05:54:29 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, ekangupt@qti.qualcomm.com,
        bkumar@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        srini@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, Jeya R <jeyr@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 04/12] dt-bindings: misc: add property to support non-secure DSP
Date:   Wed, 26 Jan 2022 13:52:56 +0000
Message-Id: <20220126135304.16340-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220126135304.16340-1-srinivas.kandagatla@linaro.org>
References: <20220126135304.16340-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeya R <jeyr@codeaurora.org>

Add property to set DSP domain as non-secure.

ADSP/MDSP/SDSP are by default secured, where as CDSP can be either be
secured/unsecured.
non-secured Compute DSP would allow users to load unsigned process
and run hexagon instructions, but limiting access to secured hardware
within the DSP.

Based on this flag device nodes for secured and unsecured are created.

Signed-off-by: Jeya R <jeyr@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
index 2a1827ab50d2..f9a01e2b4c96 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
@@ -17,6 +17,11 @@ other tasks.
 	Definition: should specify the dsp domain name this fastrpc
 	corresponds to. must be one of this: "adsp", "mdsp", "sdsp", "cdsp"
 
+- qcom,non-secure-domain:
+	Usage: required
+	Value type: <boolean>
+	Definition: Property to specify that dsp domain is non-secure.
+
 - #address-cells
 	Usage: required
 	Value type: <u32>
-- 
2.21.0

