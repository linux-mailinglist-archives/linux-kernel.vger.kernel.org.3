Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D735D5AB5FC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236845AbiIBP4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237170AbiIBPzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:55:06 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8036338478
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:49:28 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u18so2827038wrq.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 08:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1fcl6Kulh1x6/Y+M+GkZaGHNlzH6/YOoS5vivMb0MlE=;
        b=GdX0/Lr71x+leoWDFGxoX9mQ4gWhiifvqrIG58YF8FjeVf3ugyvMJYpn2HRMaAgfXZ
         3wAfUVchhYk3g1ahLeJpRNYi8UiplDDOkIEN+FhoITX1Uk+OJj4AIItimVO3NxdSI/w2
         sGxKvfRi3O95WWXWnPXP0rqFXpvoY0UieDFq+yqX+Q2gtyGMwIOjaHntPP7tqiYhDCdU
         czUozYtMay1nywMCprsxZcyfwIYXqPvTcMB/pHmhOsYp1TvnD0eAq+7fwzAQ92Z3kE6m
         L1J2emAa4nx1n3ZV5VZ0IErL/4s2maRiA9Hn9rV2K50DHDI2w7bnQQde2DqYohnaiKoE
         xiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1fcl6Kulh1x6/Y+M+GkZaGHNlzH6/YOoS5vivMb0MlE=;
        b=wPXLClwCwtoREYKhBUvXO9MkY95h+jGAQFgn5HUDJssS+Vhb8e5a911y9mLnSyEHd+
         d9NIckSiOKisWX7nXixsEUOlN0tGKDV8y1U2mrtG5IkHkO8BnljNG1ZMMfGhxMm9JdC/
         UJQbB61rPEgmWb0wcqoO+U4V1gXpUAPN3FFIWep0fNDNLfF5HLmcaMnA2QgeLnHF0VD8
         NDlQUUnEx87ea0Q6rTgglAMuXi4NMRxrk3+FHUPiwmZWGYohKZiBEiZIWn9X4ePz/IVs
         fQqiGJdXBZuYMd/gCreNu3DrGC+ZfPaa+rL/Zpt+gV1lN/Raf4Uwiizo4LCM+2VAJJ1U
         fM4Q==
X-Gm-Message-State: ACgBeo0SWplkli4G5ReyO50oIAtNJNPdrXnT+XCHQ73lRHOxHa4Je8nK
        6gku94pO6udR7UlgAkvo6ZTUBw==
X-Google-Smtp-Source: AA6agR4EORuBuXV+b+aZAp3CJh26F5anxnwNPLBAhcQ90bs4+ypwtlQZkUHEqRPohEhnGsUdcYImNg==
X-Received: by 2002:a5d:430d:0:b0:223:808f:19c6 with SMTP id h13-20020a5d430d000000b00223808f19c6mr18124926wrq.273.1662133768058;
        Fri, 02 Sep 2022 08:49:28 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600010c100b002250f9abdefsm2046741wrx.117.2022.09.02.08.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 08:49:27 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ekansh Gupta <quic_ekagupt@quicinc.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 04/10] misc: fastrpc: Add fastrpc_remote_heap_alloc
Date:   Fri,  2 Sep 2022 18:48:54 +0300
Message-Id: <20220902154900.3404524-5-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902154900.3404524-1-abel.vesa@linaro.org>
References: <20220902154900.3404524-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split fastrpc_buf_alloc in such a way it allows allocation of remote
heap too and add fastrpc_remote_heap_alloc to do so.

Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/misc/fastrpc.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 52271f51800d..6730aa324e10 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -379,7 +379,7 @@ static void fastrpc_buf_free(struct fastrpc_buf *buf)
 	kfree(buf);
 }
 
-static int fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
+static int __fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
 			     u64 size, struct fastrpc_buf **obuf)
 {
 	struct fastrpc_buf *buf;
@@ -407,14 +407,37 @@ static int fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
 		return -ENOMEM;
 	}
 
+	*obuf = buf;
+
+	return 0;
+}
+
+static int fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
+			     u64 size, struct fastrpc_buf **obuf)
+{
+	int ret;
+	struct fastrpc_buf *buf;
+
+	ret = __fastrpc_buf_alloc(fl, dev, size, obuf);
+	if (ret)
+		return ret;
+
+	buf = *obuf;
+
 	if (fl->sctx && fl->sctx->sid)
 		buf->phys += ((u64)fl->sctx->sid << 32);
 
-	*obuf = buf;
-
 	return 0;
 }
 
+static int fastrpc_remote_heap_alloc(struct fastrpc_user *fl, struct device *dev,
+				     u64 size, struct fastrpc_buf **obuf)
+{
+	struct device *rdev = &fl->cctx->rpdev->dev;
+
+	return  __fastrpc_buf_alloc(fl, rdev, size, obuf);
+}
+
 static void fastrpc_channel_ctx_free(struct kref *ref)
 {
 	struct fastrpc_channel_ctx *cctx;
-- 
2.34.1

