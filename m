Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C675AB605
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237703AbiIBP5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237556AbiIBPzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:55:19 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D03C0BD3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:49:31 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e13so2864588wrm.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 08:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=gH4aJXKyf/IuSJWto9jZ1pfTJBkJztgjhsXCgC7qiLI=;
        b=YWUCF/R79HSCrrHnS4gnKeNpAvrTcplY00MBLGUZr8K2p59x9jLuarG0+i0lsuQSmR
         oHdtjNgnj+vjX5HXSAcBJxf8x1GVk/F58ZOgF+R9FCkDZEKJcysekxxiWBy1i75h0Rv+
         W5/KV7zy05rTj69s5clAtrKw3Kb+w447vIAs1V/U9GKvOueoBjNmbuC2WTWxPBfxBZIN
         Y/r/Bay1yYH5uGy3b5bz1v9bHwHdOLChNB8Y7xDZ0fU60PkNIIAyv/44VsaLbGGl7drB
         Cbfu2h16lC5sCnhDfKOzZ1KVWAIfnBSWSYbR0D+hGptfwlSnVEBcMh+oGIokaYfefwm+
         viMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gH4aJXKyf/IuSJWto9jZ1pfTJBkJztgjhsXCgC7qiLI=;
        b=hKxaICjrjSC85lZhxp+WGz3bEppRJ1t2nSL4iMnPCpMhqAobUgDyrEru6w4Dk/WVgQ
         aeigCY8WU2fXadK9m3UTu4NRxuvjMO65k/R5PSIBgKILxIH09KNt3W2h6vmt3HUhVE1+
         8WXuZQ/mFk5a4+tyNiRT1ttiEtrEBVuwsxQyuxT5tCb4mXmewacvLT0ZebqdpzOnBn0v
         Q75dzn57lBOWqfi1GbGWt1hlVnAywUaC16Wsh4FaC4egKm2LtHOFu0H204AMaZ3agR4h
         NKgl8ICfYA8cGsEj/yrL72mdhD1UO9NbIi7f6xKJqBwMUlJR+cBCu4+YTEPKdO/T4vis
         q4Ug==
X-Gm-Message-State: ACgBeo1PbRcxuc2ijxGVNfW8oT3JGMACXW/muWdpgqrGWlCsQDM+w9G1
        D3SzY5PJ55YGfqMdfNj7I4WIxQ==
X-Google-Smtp-Source: AA6agR7/b7cwzp9t0Xq6n/L3MnGKEQSdsFL5B2BwqfraG1Mc8/0Rz7lHMk07oIm12KI0AFMnuBd0wA==
X-Received: by 2002:a05:6000:1e18:b0:226:e095:a98c with SMTP id bj24-20020a0560001e1800b00226e095a98cmr11464157wrb.235.1662133771251;
        Fri, 02 Sep 2022 08:49:31 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600010c100b002250f9abdefsm2046741wrx.117.2022.09.02.08.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 08:49:30 -0700 (PDT)
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
Subject: [PATCH v2 06/10] misc: fastrpc: Rework fastrpc_req_munmap
Date:   Fri,  2 Sep 2022 18:48:56 +0300
Message-Id: <20220902154900.3404524-7-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902154900.3404524-1-abel.vesa@linaro.org>
References: <20220902154900.3404524-1-abel.vesa@linaro.org>
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

Move the lookup of the munmap request to the fastrpc_req_munmap and pass
on only the buf to the lower level fastrpc_req_munmap_impl. That way
we can use the lower level fastrpc_req_munmap_impl on error path in
fastrpc_req_mmap to free the buf without searching for the munmap
request it belongs to.

Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/misc/fastrpc.c | 47 +++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 5eececd9b6bd..7c364c58e379 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1630,30 +1630,14 @@ static int fastrpc_get_dsp_info(struct fastrpc_user *fl, char __user *argp)
 	return 0;
 }
 
-static int fastrpc_req_munmap_impl(struct fastrpc_user *fl,
-				   struct fastrpc_req_munmap *req)
+static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *buf)
 {
 	struct fastrpc_invoke_args args[1] = { [0] = { 0 } };
-	struct fastrpc_buf *buf = NULL, *iter, *b;
 	struct fastrpc_munmap_req_msg req_msg;
 	struct device *dev = fl->sctx->dev;
 	int err;
 	u32 sc;
 
-	spin_lock(&fl->lock);
-	list_for_each_entry_safe(iter, b, &fl->mmaps, node) {
-		if ((iter->raddr == req->vaddrout) && (iter->size == req->size)) {
-			buf = iter;
-			break;
-		}
-	}
-	spin_unlock(&fl->lock);
-
-	if (!buf) {
-		dev_err(dev, "mmap not in list\n");
-		return -EINVAL;
-	}
-
 	req_msg.pgid = fl->tgid;
 	req_msg.size = buf->size;
 	req_msg.vaddr = buf->raddr;
@@ -1679,12 +1663,29 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl,
 
 static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 {
+	struct fastrpc_buf *buf = NULL, *iter, *b;
 	struct fastrpc_req_munmap req;
+	struct device *dev = fl->sctx->dev;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
 
-	return fastrpc_req_munmap_impl(fl, &req);
+	spin_lock(&fl->lock);
+	list_for_each_entry_safe(iter, b, &fl->mmaps, node) {
+		if ((iter->raddr == req.vaddrout) && (iter->size == req.size)) {
+			buf = iter;
+			break;
+		}
+	}
+	spin_unlock(&fl->lock);
+
+	if (!buf) {
+		dev_err(dev, "mmap\t\tpt 0x%09llx [len 0x%08llx] not in list\n",
+			req.vaddrout, req.size);
+		return -EINVAL;
+	}
+
+	return fastrpc_req_munmap_impl(fl, buf);
 }
 
 static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
@@ -1693,7 +1694,6 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	struct fastrpc_buf *buf = NULL;
 	struct fastrpc_mmap_req_msg req_msg;
 	struct fastrpc_mmap_rsp_msg rsp_msg;
-	struct fastrpc_req_munmap req_unmap;
 	struct fastrpc_phy_page pages;
 	struct fastrpc_req_mmap req;
 	struct device *dev = fl->sctx->dev;
@@ -1755,11 +1755,8 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	spin_unlock(&fl->lock);
 
 	if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
-		/* unmap the memory and release the buffer */
-		req_unmap.vaddrout = buf->raddr;
-		req_unmap.size = buf->size;
-		fastrpc_req_munmap_impl(fl, &req_unmap);
-		return -EFAULT;
+		err = -EFAULT;
+		goto err_assign;
 	}
 
 	dev_dbg(dev, "mmap\t\tpt 0x%09lx OK [len 0x%08llx]\n",
@@ -1767,6 +1764,8 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 
 	return 0;
 
+err_assign:
+	fastrpc_req_munmap_impl(fl, buf);
 err_invoke:
 	fastrpc_buf_free(buf);
 
-- 
2.34.1

