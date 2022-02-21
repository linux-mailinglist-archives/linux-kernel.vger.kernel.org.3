Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA3B4BDDD9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355478AbiBULLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:11:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355438AbiBULKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:10:21 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB641176
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:41:42 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d3so10600793wrf.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o+5vqkQXPirAu/1Sjt7YkAPFccDLqMMWnr+8F22imTk=;
        b=nPaWk5LfwzEn0LL7hDjXHx+adKazsGK3boQBxuXVtBNxfdkOK746wnkgp6LMGfbhNb
         3KhQCNaITzFt30AfGjK/tMU6Ty0Y1aPMFmaXUWXdSX3geNrC4MbtJgK9NPA6Yi8KYO1o
         EX2g32al3a6ytLBMQhRI0spcxQ9/mBc+6ltz1kvW7dHU3NqyrHAKC2vhfes1UCWGIy4p
         jrYsuSRudJi9MWk7Fmvr9vgyfKZXrma/Y5v6yIlFaDHOZ6O5MQtRWS3HlhGu4Kh9aN/1
         6TvoM04B93mNPWb7ajM4h1WPBNwewoS/SuCfZ7+1gsLqUkKzAQwyQ+veib4QgYSn/z5Z
         wx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o+5vqkQXPirAu/1Sjt7YkAPFccDLqMMWnr+8F22imTk=;
        b=Zpd0XrkqmUlCTmjBvw1XCc87jvL34qMA9tcHU3t0KkaVLK6PKj3MVWhcmFLC3qYb6y
         KHO/lULliR9hn5WrMvUZumsuIisHDuFLZIbKhV+YEz5/aB1yCPkLncXKzbnBOpFhzLwV
         5slWeC+b0Xa4LnA9cppJ19ZMx116zeK5cbWfWcD574HEoLWH9iN+z2PEOqVIlPgq/SKP
         tl5SYmP5zmJXcMJWZkGZSlm+hujbA/E+DoY20A4SptROHQdYQ3sIpYA4+ufFoUcCOvnp
         a7BLp4an8YCVYgHRHSIcRFcNvsdg5/46+l8CKwSKJ8ZKS5AYDiDIEXeYTKhiJN8HfguR
         ny1w==
X-Gm-Message-State: AOAM5300KQ6lWeGVwBLL986tkOWm5hgO+P53i47+JLSiDxxg8blE8PbF
        6L1RrN4DgQQNf3eY6iaDCWMBDQ==
X-Google-Smtp-Source: ABdhPJzpstyVfklHCpbOqUjZGxa3zUfwEkkM2h9RLHKyNYm3+7V5P1Ua7b4QPNqF21HRAwBj9jw2Ng==
X-Received: by 2002:adf:efcc:0:b0:1e7:cf03:b419 with SMTP id i12-20020adfefcc000000b001e7cf03b419mr15153603wrp.122.1645440101330;
        Mon, 21 Feb 2022 02:41:41 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c4f9300b0037c06fe68casm7584817wmq.44.2022.02.21.02.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 02:41:40 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com
Cc:     pierre-louis.bossart@linux.intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/3] dt-bindings: soundwire: qcom: document optional wake irq
Date:   Mon, 21 Feb 2022 10:41:26 +0000
Message-Id: <20220221104127.15670-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220221104127.15670-1-srinivas.kandagatla@linaro.org>
References: <20220221104127.15670-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
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

Wake IRQ is optional interrupt that can be wired up on SoundWire controller
instances like RX path along with MBHC(Multi Button Headset connection).
Document this in bindings.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/soundwire/qcom,sdw.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt b/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
index b93a2b3e029d..bade68f429b0 100644
--- a/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
+++ b/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
@@ -22,7 +22,7 @@ board specific bus parameters.
 - interrupts:
 	Usage: required
 	Value type: <prop-encoded-array>
-	Definition: should specify the SoundWire Controller IRQ
+	Definition: should specify the SoundWire Controller and optional wake IRQ
 
 - clock-names:
 	Usage: required
-- 
2.21.0

