Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6174882FF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 10:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiAHJ7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 04:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbiAHJ7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 04:59:37 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB5CC061574;
        Sat,  8 Jan 2022 01:59:37 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id ie13so7342274pjb.1;
        Sat, 08 Jan 2022 01:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=3YvpI2aQajSf+bmgHYcKJMYUYFxW4dc1y5z8f6G/cK0=;
        b=P2FVqzYVWe6+KuQVzsgZuDyn6OLCfg18oqD8JqrgzlOKXtzEiFgBrxjP8HTrxKQC9A
         PqCImA1ph6ebv+bJUQs2HCXe6aHjSkt9xdvm3Gnnzy2ktpjYQDDiglmMOFFz2N1puFrS
         B11v/Bodbv38vtOpVP8YVsfLUM7lGhWXAvRcSTXiS1oojkgyESmZFHP71k5rAfgyoJ2i
         DitOhmjFArNdHZE151HP2zwbTZyEOqjiXi6UbQErtkI1b6LbaMawlqYSlDUOYyulQaOr
         onmSGcdolKX41NuNDN3T6gwGu/8B+1m6NuUa8qlZMDzOtL2Dlj+DodBzXb47sTXupToF
         vs4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3YvpI2aQajSf+bmgHYcKJMYUYFxW4dc1y5z8f6G/cK0=;
        b=diJYNWNVQylvARzVJOmVlvCHhDPAYwSNCH754cMT3bBOPMiJ3Kx3HV78pptrSN1QXF
         6aibfRaSuP6iin/T02IhHTGBspRj600xPdO7W4Rmhxbsnxu5fNJ8CGLCEBs9HswHpkJd
         7VmMRvp4ob98P3k2cuTrLLClaWQMgnTeUe+LsELyzJjpBsTMvrDPLJIsYF6BbcUNcAQD
         br7gAIG9eVQ9bB4BFwTLiuwqQpq/JAQQqrnx6QoaWb8+Asy6lC4DMHx+hC00CW7iPxYC
         Sc3oCaegr9bq0mmb09gsc0r1Y9PEzYOloIfhV+yvPXI9o7ywbSOE1McLmcNP+hrqq330
         W6Qg==
X-Gm-Message-State: AOAM530dkkyZmyO/XievkN+BCcsr/MGWdLXKnFKnPXeyaG+qd3D93EIc
        cqr5u1+67sw3fM/mJeKJQF4=
X-Google-Smtp-Source: ABdhPJxTeodozfSS6DrwSXCJTyXIAQXTtLUReC93ySeR2bzKfk76kvJvE+iEcEuDK+CsgqweEPHeFg==
X-Received: by 2002:a17:90a:5295:: with SMTP id w21mr17888320pjh.179.1641635977318;
        Sat, 08 Jan 2022 01:59:37 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id q19sm1536777pfk.83.2022.01.08.01.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 01:59:37 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Deepak Kumar Singh <deesin@codeaurora.org>,
        Chris Lew <clew@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: aoss: Fix missing put_device call in qmp_get
Date:   Sat,  8 Jan 2022 09:59:31 +0000
Message-Id: <20220108095931.21527-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference taken by 'of_find_device_by_node()' must be released when
not needed anymore.
Add the corresponding 'put_device()' in the error handling paths.

Fixes: 8c75d585b931 ("soc: qcom: aoss: Expose send for generic usecase")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/soc/qcom/qcom_aoss.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index 34acf58bbb0d..e234d78b33e7 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -451,7 +451,11 @@ struct qmp *qmp_get(struct device *dev)
 
 	qmp = platform_get_drvdata(pdev);
 
-	return qmp ? qmp : ERR_PTR(-EPROBE_DEFER);
+	if (!qmp) {
+		put_device(&pdev->dev);
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+	return qmp;
 }
 EXPORT_SYMBOL(qmp_get);
 
-- 
2.17.1

