Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7022246E824
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237094AbhLIMLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237108AbhLIMKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:10:37 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760AAC0617A2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 04:07:03 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso6390021wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 04:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TiA6PgewKebLzTC/0Nu4JQ5xqNf0QAazS+rKuy2Mz40=;
        b=BzeK7MOwXel3g19BiDr5+Hxt0v6gJsFC4OvI1Uqz8XGJjvcMJ66JZdAC5TyOAF5ju+
         0XyA5c+Oo9PS1vMNn0GhFN06y97/P2CeSojCVzWp5r7v5c4Jg46sqVnmL3enXRXodjSm
         TwxXmCzpF82WZAs0ygjuPqw9SipJTGMf0w+cTFpd27zosBtsgFDXgaEZLt/zOB9UAg2y
         GC1MHrlL9oRCixdnaGr9A39sLNr+03NDmAkLEloMtYBAACcQbedFLtjd+nyJ09Z2kO1J
         NK8643ewa+vInO0JfiaHhmUbUgJ6nHk6NT/OKu/EvNpvAihWrC5rLP0/CoTfkBaYTfT5
         HStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TiA6PgewKebLzTC/0Nu4JQ5xqNf0QAazS+rKuy2Mz40=;
        b=4qhiMxxSwtB6Vfjhbz0qgiv4cwLyfnz9vkSJCfKAz57MkjMc7j5fKzkWmZRV+8lY11
         GO4J+3nJj2z7GhCu2PGBRdwgvW3FpZdgDis5ex22kSb6eIrnX1EAmjiQc50ldVKxhSvw
         jejf5IxHm5Ca8zDTSkTB6vUqNii8qORdiNL+EB2jdWJ2rzhKiqxXnrso1Cd1VGbG/Pma
         mPPhOkXsEOp0okPmq674h5G4s3+rht5Y1SlCOq8BSRLQMpumv7k+wtu2BVvZQ+jif98D
         XGe1J08Ust2OENK+mbmBJuSu3G5bs8vu9S2LOamxZbBUjCLR+E3VUn96zfcO1GLyhqZT
         jcQw==
X-Gm-Message-State: AOAM532TBqT/LlJpkiU2ufvUWk7xvHzziPbVneDbfhg0XC++oBbopBYj
        pOQ+TKY47mRo3/G/fF4Le5m6ug==
X-Google-Smtp-Source: ABdhPJxjsK+eRZ4ZlBtNszX24uRPmMbpOy3grcHWxBMAEA4GMp9WW+pd2vP5Y8FhkRZaUuQBXeX9xQ==
X-Received: by 2002:a7b:c848:: with SMTP id c8mr6758428wml.105.1639051621968;
        Thu, 09 Dec 2021 04:07:01 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id 4sm7513289wrz.90.2021.12.09.04.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 04:07:01 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, ekangupt@qti.qualcomm.com,
        jeyr@codeaurora.org, bkumar@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 5/8] dt-bindings: misc: add property to support non-secure DSP
Date:   Thu,  9 Dec 2021 12:06:23 +0000
Message-Id: <20211209120626.26373-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211209120626.26373-1-srinivas.kandagatla@linaro.org>
References: <20211209120626.26373-1-srinivas.kandagatla@linaro.org>
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

This patch has dependency this yaml conversion patch:
https://lore.kernel.org/lkml/20211208101508.24582-1-david@ixit.cz/T/

 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index f42ab208a7fc..f0df0a3bf69f 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -29,6 +29,11 @@ properties:
         - sdsp
         - cdsp
 
+  qcom,non-secure-domain:
+    type: boolean
+    description: >
+      Property to specify that dsp domain is non-secure.
+
   '#address-cells':
     const: 1
 
-- 
2.21.0

