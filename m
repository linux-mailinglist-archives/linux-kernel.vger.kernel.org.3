Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906955AB1C4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 15:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbiIBNjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 09:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237787AbiIBNim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:38:42 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A0B155D50
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:17:01 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id v16so2273933wrm.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 06:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=drLF7rfbGFyvXeY1M1WJL6CSV1JIiJp9EbWQRGL1rFU=;
        b=dg3A8/XIlRqPp1CPoTasxNUHNieEKqRPUkIQRJSP30IIxvMZ3nilnRE7HylejN9mbV
         cXTjHFLpstcLyIKQXdYUqOHE9NxReukOLmasdZTY5TCbcpLkshUh101kBZ4RDr29op1W
         eVcar4IsoHkNcma0VlMXNgRgJ50BGWTSJ5TX5oZizKbSwox1qSPV+E6IFWvhC5Wv1yUZ
         1KrLEQTwXjfcptO9UO7w20FQE9s8UFJ8PyfhS6BQyAtZA7SQ0hQcOAbCspGoA4Dpc4ae
         o2xTfjqqZlH2PkJQzU2/t89OH6z81wjZjk1U6dj6yYEw8JABZ9lklsZZrkJlO34Pt32R
         uWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=drLF7rfbGFyvXeY1M1WJL6CSV1JIiJp9EbWQRGL1rFU=;
        b=o4DXhp4rsL19qgxEME6w3bgvOTjQzDBIjbIuOir2g6rDp2DjsxgZ8eNgcvRui1+UpQ
         Ib8wAcke+Ek6jaBW0IVwpZRUeE+lGAhY1cChbZr7in3y90YcLzEvSuGKUco7WW/l0KFQ
         BCyaHr8hL82Mj4d3FuMV38Qoi/jl/VhKPz+oDxnbqCFlXP4rebo4zSrduHPnCPvI895t
         RE+wpyAUfk7fCRXOEWNL4UXPvhSqrHtOjY9g1J/ozOqA63vuTiSnO6ekDTJ2gxbHutzq
         YOUvBkypEupUHYYWzWfAc+pBOdMi2X/6n14dfzVIKd2Yux/0/CrmUAHNvuZUDdte/F+O
         p+Vg==
X-Gm-Message-State: ACgBeo1lKvE/7B6bZ7kVt3IZpyvqyLfm36HHlun9BNqwq6gY3COs/nBf
        bdpQZvbSCameYyYBzHfL8ZJLpQ==
X-Google-Smtp-Source: AA6agR5R9G7qEf/kpeyJBujQrfYmCftSy6m0SLRKczMsXmGCtHr7J2rnQDY43bEkD0QHw1NBbh+9Ug==
X-Received: by 2002:a5d:59ab:0:b0:227:8f1e:f4ab with SMTP id p11-20020a5d59ab000000b002278f1ef4abmr2069723wrr.321.1662124469173;
        Fri, 02 Sep 2022 06:14:29 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id v14-20020a5d43ce000000b002253fd19a6asm1766253wrr.18.2022.09.02.06.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 06:14:28 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorande@qti.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ekansh Gupta <ekangupt@qti.qualcomm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/14] dt-bindings: misc: fastrpc: Document memory-region property
Date:   Fri,  2 Sep 2022 16:13:36 +0300
Message-Id: <20220902131344.3029826-7-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902131344.3029826-1-abel.vesa@linaro.org>
References: <20220902131344.3029826-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add memory-region property to the list of optional properties, specify
the value type and a definition

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
index 5ec124b138a6..3dd02aaa7ba7 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
@@ -17,6 +17,11 @@ other tasks.
 	Definition: should specify the dsp domain name this fastrpc
 	corresponds to. must be one of this: "adsp", "mdsp", "sdsp", "cdsp"
 
+- memory-region:
+	Usage: optional
+	Value type: <phandle>
+	Definition: reference to the reserved-memory for the region
+
 - qcom,non-secure-domain:
 	Usage: required
 	Value type: <boolean>
-- 
2.34.1

