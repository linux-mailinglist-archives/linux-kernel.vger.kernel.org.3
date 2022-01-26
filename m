Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9013D49CB8E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241841AbiAZNyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241742AbiAZNyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:54:38 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F39C061763
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:54:34 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id e8so24124515wrc.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JfDyyJdxrbqCuKZtcO0xhwTtHfbFdU/XHTzhH3bg3zs=;
        b=xQ+OwaQZsqUBm0KarXrQSNH61NcMrHSaNfTONVTcpJ1ZKeWbLsDHvthnPvx7u5/S68
         TBUNeQCVzi68Q7kBoUaAT74KnoonFPxC4SnsTJpfi562O7/smaiLz2kZXrk5BNF84XCx
         24yqBdFIkAaQI+zNxBZgpYkGS6W5LsU9UqqIVUODII0/fEYln+ULQ1dD1EQ8MPs7f8ll
         rYiDlYc4OncyxMAZxOzMBQhQwMsgRh6KuDPiTxJo1cX1kSKwm0U/4P/bHcKKyiS5rmuw
         F83y6/Xqv4sV2hUHDLnOWqokNnQqFA1Pa0h26n/Onfyad8lIvkVgtogIScmzqLClDugk
         rQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JfDyyJdxrbqCuKZtcO0xhwTtHfbFdU/XHTzhH3bg3zs=;
        b=OiIJv7Owg8MpaGtDhM0XrBPIl8U3hkDn470URt4q519HpELD1Gb2LtCnP0Wr6B1YZk
         W7+ionxNYeujPflyZJaMaRvFYKdao3b5OnSrmbWQQw7AH38YNxAu6oP3hOEr+/OYEK8e
         YhKUmk+LT6iWCQsZCcQJ1LJ7mB71AKcPlL8j07GbYiLdZQqy6FGgP7Ooe6Y/lp3W69lF
         wQ0uN03+13kl0kH0F3bzmfytPX/pLhCGemyw/z53r18kuO0ZZswl9ODs5fuJ4t947NHS
         TiwCFeTtWGulwM8VKkmbKAEfd01NVQwtLQz1ganrw6KvL5PGNotEAbYJGCdT/GSdn+UM
         Zbog==
X-Gm-Message-State: AOAM533ZOhRDyfvhmoXsHF9BrBSY+RarE+mGtZ+Ze1SKcgb/sgY3GKAY
        wOnMGEFsJRbIGfe5B1SSpJIPpg==
X-Google-Smtp-Source: ABdhPJxvUhx7LmYCVI86xbDzz7SI24ZYz1alBUACSqV3LEZJ2hFzVn4IT1IT85TbpInHLFk6ovP3pQ==
X-Received: by 2002:adf:9cd2:: with SMTP id h18mr12774785wre.483.1643205273450;
        Wed, 26 Jan 2022 05:54:33 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id n15sm3356593wmr.26.2022.01.26.05.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 05:54:32 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, ekangupt@qti.qualcomm.com,
        bkumar@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        srini@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org,
        Vamsi Krishna Gattupalli <quic_vgattupa@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 07/12] dt-bindings: misc: add fastrpc domain vmid property
Date:   Wed, 26 Jan 2022 13:52:59 +0000
Message-Id: <20220126135304.16340-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220126135304.16340-1-srinivas.kandagatla@linaro.org>
References: <20220126135304.16340-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vamsi Krishna Gattupalli <quic_vgattupa@quicinc.com>

Add fastrpc domain virtual machine IDs property. This property is used to
setup memory protection for remote processor.

Signed-off-by: Vamsi Krishna Gattupalli <quic_vgattupa@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
index f9a01e2b4c96..5ec124b138a6 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
@@ -22,6 +22,11 @@ other tasks.
 	Value type: <boolean>
 	Definition: Property to specify that dsp domain is non-secure.
 
+- qcom,vmids:
+	Usage: optional
+	Value type: <u32 array>
+	Definition: Virtual machine IDs for remote processor.
+
 - #address-cells
 	Usage: required
 	Value type: <u32>
-- 
2.21.0

