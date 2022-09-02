Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD5F5AB1A0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 15:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbiIBNhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 09:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236800AbiIBNgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:36:44 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8D1CD7AF
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:15:48 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id z14-20020a7bc7ce000000b003a5db0388a8so4376538wmk.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 06:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=OADg3UgKowYhLczGEB28pcVY5skR7AiQxx4OTT83oDk=;
        b=H0g/M+OnJxjS/Fxem0m6Me0vNgo4xJviND9t9DF+p6KUOS4dV40camDINciqlwBsc6
         1oZDtlnVq97CnomYp/1tuwInbIGN+Ta9z4Y89Grs1NH/0Ix8mnb7JpLaLQHd/dCNI5mx
         r+jZUQBh/A066D/ih4Uklqgtm86em8TrInlLu7opZzPX0eGmOw/de4pqi2e2gWtU+Tbd
         owVjzT7LjOk+vhiR8aBvkwJ5E4HwME8Pq6bWkRMvtKmUCOOv4P5NoLOKCCrkCL0Seju8
         xFX9wpR9OdzWH/C5cSNqK6O7C2XmxZLIIOEfuofLVAi9DG5wxihkllicwI4UARRB2W2F
         9nQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OADg3UgKowYhLczGEB28pcVY5skR7AiQxx4OTT83oDk=;
        b=JeyQqwUgdIRfDdVlThMQNR6nODdH45AhBXgkFtxL1VMK29mTBQq32r0LSzv6RaWVcZ
         0oZ0NJCZ1qBDp2jb9ggltB3WwURDZyNtJBc9R5kUjj08nDVVFFZVt8hPPvx6lEVvm3Zd
         o5YEKH2rlCZg5ZjoaCuTB8X/r/LHiXkb+9rULEaoJkeNfsz6pc1l7fCWToFgkY8SElEE
         aIZjWuhGA2Gol+7k2TlQBJx+u1g++DtB3TYO3p3HE/3Z8Kan5841TEAS+AvhOkGZV9Us
         nm7itwXFkLp1hlPudRt4o5tEQdpURNQCokuGYlfgeKBLZK4gQid8Vu7tT+9NoN6Fb6dd
         EdHQ==
X-Gm-Message-State: ACgBeo0k2M/Rvi53tDw+/FZRASETdTHDgoowBuqKVxXMWqt3vO2HbxDA
        Ff6AWi1BTmzUMqYqobj9n5Oeiw==
X-Google-Smtp-Source: AA6agR5QwGS7OPCyEFpfPg8vBBgyTrtB8Tf8na/GE9G5Ym492TMGsmtN6Vggy29GsnTDhZbxZYpI+Q==
X-Received: by 2002:a05:600c:3d93:b0:3a5:eb9b:b495 with SMTP id bi19-20020a05600c3d9300b003a5eb9bb495mr2767314wmb.91.1662124478358;
        Fri, 02 Sep 2022 06:14:38 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id v14-20020a5d43ce000000b002253fd19a6asm1766253wrr.18.2022.09.02.06.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 06:14:37 -0700 (PDT)
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
Subject: [PATCH 12/14] misc: fastrpc: Add mmap request assigning for static PD pool
Date:   Fri,  2 Sep 2022 16:13:42 +0300
Message-Id: <20220902131344.3029826-13-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902131344.3029826-1-abel.vesa@linaro.org>
References: <20220902131344.3029826-1-abel.vesa@linaro.org>
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

If the mmap request is to add pages and thre are VMIDs associated with
that context, do a call to SCM to reassign that memory. Do not do this
for remote heap allocation, that is done on init create static process
only.

Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/misc/fastrpc.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 41eabdf0a256..66dc71e20e4f 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1849,8 +1849,9 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
 
-	if (req.flags != ADSP_MMAP_ADD_PAGES) {
+	if (req.flags != ADSP_MMAP_ADD_PAGES && req.flags != ADSP_MMAP_REMOTE_HEAP_ADDR) {
 		dev_err(dev, "flag not supported 0x%x\n", req.flags);
+
 		return -EINVAL;
 	}
 
@@ -1896,6 +1897,22 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	/* let the client know the address to use */
 	req.vaddrout = rsp_msg.vaddr;
 
+	/* Add memory to static PD pool, protection thru hypervisor */
+	if (req.flags != ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
+		struct qcom_scm_vmperm perm;
+		int err = 0;
+
+		perm.vmid = QCOM_SCM_VMID_HLOS;
+		perm.perm = QCOM_SCM_PERM_RWX;
+		err = qcom_scm_assign_mem(buf->phys, buf->size,
+			&(fl->cctx->vmperms[0].vmid), &perm, 1);
+		if (err) {
+			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
+					buf->phys, buf->size, err);
+			goto err_assign;
+		}
+	}
+
 	spin_lock(&fl->lock);
 	list_add_tail(&buf->node, &fl->mmaps);
 	spin_unlock(&fl->lock);
-- 
2.34.1

