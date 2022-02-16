Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3034B7E35
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 04:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344014AbiBPDHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 22:07:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237823AbiBPDHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:07:41 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C168BE01;
        Tue, 15 Feb 2022 19:07:28 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id o3so851993qtm.12;
        Tue, 15 Feb 2022 19:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uo90ND7vxwikC6O42ZnqZ8gM49VogQOE7nhLljaIMVw=;
        b=qQwnN28YhIiQjTZSULZQV5TguS1d/XvVlJEUPbGB5upCPYJNokkSDdphv31QN1j7pQ
         2fqxFL00OxshOvSVs9TnflPo3Iq5lsCE/+HgRdJdE4YWXGZA0Lp6Flsc9cG25c4gxpF4
         tTXhdQDLBDC7j7g3VaMP1Du/zYDV1WFr5weXTO47VzVWW6pNs12H1gSrTqtLUAe3CjWg
         5y3b9/6q6jsKPb+gVDxBxJui0AaVRq+SibXaoDY5w9i+MBZqqd0cTWewWovW5VilJq3V
         ztUbkEdZXdUkUZ5tQqs5tc63uNISS8mPEDHn6WMs6aHLXJgRPp5+EzDBNzXM2UFCY+yo
         AHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uo90ND7vxwikC6O42ZnqZ8gM49VogQOE7nhLljaIMVw=;
        b=SWZtM9nzVmIPnY2xH8rPSZfXWrTo58FUWL1xU6xR5Jo8ZZZBZx9TxQE33YrOPd/oYT
         y6pimwMbtZMzL9QwRMNwhdYKfnco7FdqdDK4PfhyDLSC+4OxlS0PKP1OqQWoLgxT92Ki
         Rl8R+ztgeOq7ubfUtACaFAO47hHdcKJ5+C1yuws6QwRNvBSEmdwWDBYdmA2+R9vicUEm
         inTdI6JEZl4u0hhd3DAx1etp1j4jt7jK1Pd6RFlNA0u4meyHhLJ7xa71iJyayFuqBDhC
         OvEoqEspmedox4CgeBlXEDAB0spYUo8U9HTTL0qMQFJixeABrYhiINZV0JMPENMDzBXe
         NC8w==
X-Gm-Message-State: AOAM530jPWEeFCbDobcSdiAkJSIzff0ePHSuoeayug6Kkzz/dAhD1WNi
        jR+kpuCTXLQK5idqwaF7QnLpKghzxGc=
X-Google-Smtp-Source: ABdhPJyRFrgWXQPlF/0WIAZLi/P13Nwm7gdMLmGfhlXUOmdKItQ+y9elCqEXcwltlSuX3Ytw7iUijA==
X-Received: by 2002:ac8:5e49:0:b0:2d6:cb37:9ee9 with SMTP id i9-20020ac85e49000000b002d6cb379ee9mr720460qtx.652.1644980847279;
        Tue, 15 Feb 2022 19:07:27 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h19sm10307679qtx.12.2022.02.15.19.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 19:07:26 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     agross@kernel.org
Cc:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] rpmsg: use struct_size over open coded arithmetic
Date:   Wed, 16 Feb 2022 03:07:20 +0000
Message-Id: <20220216030720.1839503-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>

Replace zero-length array with flexible-array member and make use
of the struct_size() helper in kzalloc(). For example:

struct glink_defer_cmd {
	struct list_head node;

	struct glink_msg msg;
	u8 data[];
};

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/rpmsg/qcom_glink_native.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 1030cfa80e04..f4f4e392d0d1 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -792,7 +792,7 @@ static int qcom_glink_rx_defer(struct qcom_glink *glink, size_t extra)
 		return -ENXIO;
 	}
 
-	dcmd = kzalloc(sizeof(*dcmd) + extra, GFP_ATOMIC);
+	dcmd = kzalloc(struct_size(dcmd, data, extra), GFP_ATOMIC);
 	if (!dcmd)
 		return -ENOMEM;
 
-- 
2.25.1

