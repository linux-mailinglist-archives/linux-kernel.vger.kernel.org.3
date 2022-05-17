Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A0852A283
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344310AbiEQNCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347254AbiEQM77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:59:59 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EE04E380
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:59:19 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220517125917epoutp04f79711fbb3f1566a5dd295e46a371aad~v5eSB3w1O1581315813epoutp046
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:59:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220517125917epoutp04f79711fbb3f1566a5dd295e46a371aad~v5eSB3w1O1581315813epoutp046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652792357;
        bh=E2JvNYhoWnmcC+63r39NFyig1swETClHM3EyOWLAvdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=guZoXu11/qW9aV4/eoSVKzR6pZh7kkwRrJqBi+B6zS/78/9TL7MBKma+DH+TcFO7P
         i2MrjuYLYL7icHMfJjYSz6RaMjnNNxgqh0AiNgFje+GiueHqZeJrZNgM1v9JGtVy8B
         Fvec+382kB4tNzQsGPnpGcFsjTdWyM0XzJjx0BPc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220517125916epcas5p20315cbb4fbcd6dc653e8f601c740ff69~v5eQj_Tph3171731717epcas5p20;
        Tue, 17 May 2022 12:59:16 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4L2bmJ4lrfz4x9Pw; Tue, 17 May
        2022 12:59:12 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0E.4F.10063.02C93826; Tue, 17 May 2022 21:59:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220517125648epcas5p22201053e8a71dcd5ccc8d0566511b635~v5cHL-jp61797517975epcas5p2y;
        Tue, 17 May 2022 12:56:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220517125648epsmtrp1e6ebf55b9822c8b5b773e5d700fe633a~v5cHK_4Tk0134401344epsmtrp1F;
        Tue, 17 May 2022 12:56:48 +0000 (GMT)
X-AuditID: b6c32a49-4b5ff7000000274f-27-62839c206a45
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FC.AA.11276.09B93826; Tue, 17 May 2022 21:56:48 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220517125644epsmtip13208b27f88dcb8be82abaa5265da547c~v5cDXSalV2359123591epsmtip1W;
        Tue, 17 May 2022 12:56:44 +0000 (GMT)
From:   Smitha T Murthy <smitha.t@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        Smitha T Murthy <smitha.t@samsung.com>, linux-fsd@tesla.com
Subject: [PATCH 17/20] media: s5p-mfc: Clear workbit to handle error
 condition
Date:   Tue, 17 May 2022 18:25:45 +0530
Message-Id: <20220517125548.14746-18-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517125548.14746-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf1CTdRzH++7ZnucZBi6k+MYVrOeKC+XHhrC+kJiJ2iNgR8nl4V2tAc8N
        ZGy7bSTpZfycgGJqGoGAMECv+SMYAxEBYYKm/Fgcv7rLDQQNR3R6rDTFsMFG/ff6fL7vz497
        f79fEvP8Ffch0+QaRiWXyCjcjd1yLeDtIH5FXpLgePubaLKqBUe1f8+w0EStnY1MTc0EMo6c
        wtDZG10cdLpnkIMudU+xUeN9x+lQmYWNZk5fBMhWbsWRYXqMg+7M7kLDbRU4OtzQzEEXeiwE
        qh8fYqEzhmcspGv+k0AFHT0EsrS3AJSv7WFt8qbPV50HdKulDtDjdfMYfbncQtC17TYWbdAX
        4fTtsXacbqr7mi7ofcqmjxj1gF7MrSTo4p5xnLYbfOlbf9mJeI/d6RtSGUkKo+Iz8mRFSppc
        GkXF7hRHi8NFAmGQMAK9Q/HlkgwmitoSFx+0LU3mcIDifyGRZTpS8RK1mgrZuEGlyNQw/FSF
        WhNFMcoUmTJMGayWZKgz5dJgOaOJFAoEoeEO4efpqTm665jSzs3KaTyMZYPrZDHgkpAXBp80
        1mPFwI305F0BsNd2BXcG8wAWD2rZzuARgHmzv+MrJf2zWldJB4DG/nvAGeSzYNG1imUVzguE
        jx70LbMXLwfA6ULNEmO8BQyWjfgu8RpePDxzqQ9bYjbvLdjfWL2sd+dFwvZfxtjOaX7wXEOX
        Q0OSXEe+cvHTpVmQl8eFdRODwKnZAk2dTS5eA2dvGAkn+0DbN1oXS+GEPc+lUcLKbCPLye/B
        rpEK9lJ/jBcAf2wLcaZfhydvXWQ5V/aAJQt3XXJ32Fq1whTU9f/kag/h6B/NHCfT8Flfocu5
        EoeNpQ/wo8C3/P8R1QDowauMUp0hZdThSqGc2fvfrSUrMgxg+ZWv3d4KLJMPg02ARQITgCRG
        ebkLsrKTPN1TJF/uY1QKsSpTxqhNINzh3zHM5+VkheObyDViYViEIEwkEoVFrBcJKW933vOc
        JE+eVKJh0hlGyahW6lgk1yebFfcKLbv7UYsOEXVbP5k3H4i8Krqz+sTl0LaYTeyi32LM2nVz
        hkK3VSPd2/d8O/GV4J/Sdzc3nNR7hj5Jnuy09z/uN08e8MXMOsvP0Q+mX8wdvp9orab3lk3u
        EAQ8JIw3OzD/qbmnHjv0uu6anXQa54QXZbVG7Io7Zjs+/+GpgSP73v9MrB14I32/v1Wq3hN9
        Yer2a2lRU/5bN3pQZFBjKTCJD46tOrh/9UJZaG5A72PzwER9yvBAAVGSWO5fo88+G0s8t46W
        aUYLQs6RH2zLN8VwO19g7H6HPqZ+kFwNTEw4OuT9XWxsc0jCukMJiy/tntOvD8yqCZrxs93L
        4t80N4R+70Ox1akS4VpMpZb8C+XjIz5uBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSnO6E2c1JBusfqlo8mLeNzWLxj+dM
        FvcXf2axOLR5K7vFliuzmS2WHz/AajH/yDlWi+0HH7FYbHwBlL048y6LxfP56xgtXs66x2ax
        6fE1VouHr8ItLu+aw2bRs2Erq8XaI3fZLZZev8hksWzTHyaLRVu/sFu07j3CbnF3zzZGi5a2
        I0wO4h5r5q1h9Nhxdwmjx/Uln5g9ds66y+6xeM9LJo9NqzrZPO5c28PmsXlJvUfr0V8sHn1b
        VjF6/Guay+7RdeQ6m8fnTXIep75+Zg/gi+KySUnNySxLLdK3S+DKaFx0jLngM2dF48Ye5gbG
        YxxdjJwcEgImEmdetTF3MXJxCAnsZpT4/ecjI0RCQmLl70lQtrDEyn/P2SGKmpgkHi3dyw6S
        YBPQkfj2/jQbSEJEoJVR4vrKTiYQh1lgIovElOu/mEGqhAX8JHq2LgUbxSKgKnFm4wI2EJtX
        wEpiz41rLBAr5CVWbzgAVM/BwQkUn/svFsQUErCUeLrfYgIj3wJGhlWMkqkFxbnpucWGBYZ5
        qeV6xYm5xaV56XrJ+bmbGMHRpqW5g3H7qg96hxiZOBgPMUpwMCuJ8BpUNCQJ8aYkVlalFuXH
        F5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwLR8k6CEwtbD9/8vETCVtqpK
        nTDhmMa5jgj9l6opfNcbI7VllhR8Yi+f3z439eCf459NGPaaSQncnHG87IQaL3O4xvSnepou
        U2V+W2jWvn46Y/PJm9P4Nu1YJ/9+fwL34W6rowaiK40dNU9GWrIevFbYs+pF2KvloY9EbwWs
        LH8W7cD1rDveMmPhB8fpd/kbo7YJtnVOr9NOfv0vTb1S/oBEwLNZOmxSJ1xCMg5ve7Y+Td5A
        9mL0Gru0C9fLddlkghqdXm0of5Jq3FM6ZY5rtLtHfPje//2ZkruWF3zfVOcv8iv4OZv6xEtn
        m97vOfDs6584n//OBnmXG/c+KyrP5VHdOvubao7ed0bOl8vvPFViKc5INNRiLipOBABY0Kho
        JQMAAA==
X-CMS-MailID: 20220517125648epcas5p22201053e8a71dcd5ccc8d0566511b635
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517125648epcas5p22201053e8a71dcd5ccc8d0566511b635
References: <20220517125548.14746-1-smitha.t@samsung.com>
        <CGME20220517125648epcas5p22201053e8a71dcd5ccc8d0566511b635@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During error on CLOSE_INSTANCE command, ctx_work_bits
was not getting cleared. During consequent mfc execution
NULL pointer dereferencing of this context led to kernel
panic. This patch fixes this issue by making sure to
clear ctx_work_bits always.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
index a70283d4c519..057088b9d327 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
@@ -469,8 +469,10 @@ void s5p_mfc_close_mfc_inst(struct s5p_mfc_dev *dev, struct s5p_mfc_ctx *ctx)
 	s5p_mfc_hw_call(dev->mfc_ops, try_run, dev);
 	/* Wait until instance is returned or timeout occurred */
 	if (s5p_mfc_wait_for_done_ctx(ctx,
-				S5P_MFC_R2H_CMD_CLOSE_INSTANCE_RET, 0))
+				S5P_MFC_R2H_CMD_CLOSE_INSTANCE_RET, 0)){
+		clear_work_bit_irqsave(ctx);
 		mfc_err("Err returning instance\n");
+	}
 
 	/* Free resources */
 	s5p_mfc_hw_call(dev->mfc_ops, release_codec_buffers, ctx);
-- 
2.17.1

