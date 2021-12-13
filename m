Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1AD472289
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 09:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhLMI1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 03:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbhLMI1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:27:18 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EADFC0617A1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 00:27:15 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id l25so49770629eda.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 00:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XJRdC0yjBFixHgLfgHpK0QkgYqSbqgXhEhFiYj/UWmM=;
        b=4IFAqnvDAaIo5tSfp2ZczPVqUrV17/KtPbbAsne3ET+GUx9nZ1X1f0C1YUx0svfRBs
         ECvooUpFSiddxErIVtf/5dNLnLnu+XJTs6LMYkMeBsosIDcuFexBraetWKMp5vnwB1Sc
         TtXqzhctyQhPQXOjCIBFRt2S9s9ouhRTFzHt9yFUTsk9O+9yEm9Q32tjkv6YGL5pilA+
         8huA24F1mm7PFpGY8wbjKaw5KaR2YO4FqtSCNkGnmUQ0w/dZQB+CnzjfFcMp1+fOZCPM
         gcT15q+jRI3U+GIiFLHIcKaRcZ2b0dnpjG8HEVBAZRQKMgGd24mYOWuYh8kDptR9XHXn
         z4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XJRdC0yjBFixHgLfgHpK0QkgYqSbqgXhEhFiYj/UWmM=;
        b=N7xUpwZuE5GkMupZZPGjzdsWUUW5BBfajxkm8YMjoPJfkr2Cj5AG4YfWSiS8HkjFF6
         x+S67dxUqD27PcPYa+LI1jzFB280O1tbj+UGJr8sJx0QsIhO8Eg+9Wn5wYxHz10Zrwop
         VPlfE1/6hFu8/uXdQa1kuZfGkcX/pgYFIGnhHCRGZszUTZ3v/7mlnnIl8yt4N3BWWe98
         i5t6Odtye/0vFoV4ozzpe5zY1u1BGhVCFeBwU/Epyv5IDx1WgLUzh3A2BKUAbXvf7p6y
         SEFAZ5Z+1PaKzs0TyZC4qvrFyIx9pb78HdZHj2KdDsA74PXUqySArE769SaHyl1iTnS6
         to1w==
X-Gm-Message-State: AOAM530wltER92zF8XpL2VQ5XWB9G8s6UmWKthNQ3Rji+G2AEt72JeTf
        NHTF3P1Ks4T/OUTWQjxdPvk76Q==
X-Google-Smtp-Source: ABdhPJw4uNIAzEmJTEL6rnMtJpBxod1EerfVhHlrjQAw/mLDSAdcYPnkUY8fXsi+Y8QrzX+ai8bvlA==
X-Received: by 2002:a05:6402:405:: with SMTP id q5mr62424290edv.62.1639384033721;
        Mon, 13 Dec 2021 00:27:13 -0800 (PST)
Received: from localhost.localdomain ([2a02:a210:20c5:8c80:7d0a:cd68:c339:f426])
        by smtp.gmail.com with ESMTPSA id b11sm6062432ede.62.2021.12.13.00.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 00:27:13 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 03/10] dt-bindings: qcom,pdc: Add SM6350 compatible
Date:   Mon, 13 Dec 2021 09:26:04 +0100
Message-Id: <20211213082614.22651-4-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211213082614.22651-1-luca.weiss@fairphone.com>
References: <20211213082614.22651-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree compatible for pdc on SM6350 SoC.

Also correct the compatibles for sm8250 and sm8350.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
I do have the .txt -> .yaml conversion ready for this but will send
as a separate patch.

 .../devicetree/bindings/interrupt-controller/qcom,pdc.txt    | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
index 98d89e53013d..3b7b1134dea9 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
@@ -21,8 +21,9 @@ Properties:
 		    - "qcom,sc7180-pdc": For SC7180
 		    - "qcom,sc7280-pdc": For SC7280
 		    - "qcom,sdm845-pdc": For SDM845
-		    - "qcom,sdm8250-pdc": For SM8250
-		    - "qcom,sdm8350-pdc": For SM8350
+		    - "qcom,sm6350-pdc": For SM6350
+		    - "qcom,sm8250-pdc": For SM8250
+		    - "qcom,sm8350-pdc": For SM8350
 
 - reg:
 	Usage: required
-- 
2.34.1

