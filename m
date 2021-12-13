Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B67472275
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 09:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbhLMIYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 03:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbhLMIX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:23:59 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9904C0617A1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 00:23:58 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id g14so48545198edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 00:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eWVA6ZsYWEHpo4tPzSv+DObTmIZqBTZN1doDEY7feJ4=;
        b=A1CwDN5DROdNZy+tYAVQgJNRgQoGBNkcm994Wg1C/OwC6hiUAJTMyIges93UG1MHtE
         /38tm7oyuY6fSTE225Kg2rAom8rxXZc+fNQiigMJJSTVVU9MwC7bca7HWwlsjrZ9Fv9k
         erEW8ylz3aDlUqcGULZtOHFXJeI+dfWe8DbZDGBBYMDEvUbWqdQcd+a0QfKCTfcS0U9E
         JY8DEZLNeoLR1qCpTpPAXm1lX6TXeOyy6T2vnOWCO3Q+dPq4jrVO8vdUxzWQmTejyNN9
         D0mMcq1pHhuoDYTsWt4roJAyTGHFPpwczmxKDXS7JPR60ABueTVRfQtJkAax4lbDe2bN
         BZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eWVA6ZsYWEHpo4tPzSv+DObTmIZqBTZN1doDEY7feJ4=;
        b=a3aWQ0bX67YQtK3COdsfsePRdEjmk0jnuR57l5+4ArroGCj1vPLNaveTDLX3Saoh73
         otbgPgdhS0AFo3Lq+H11FDvKqSDCeRtdXpu5SevZaggFPmofVyiFzNAHeftu8phLao9q
         lkCXiU7qZPvkpAts/CJK6a2AheNJXkr3d0SKTxLakFDZZ+t0pOpFHiEStQ/bqAnzyPGT
         8dw5AYV6hZ9KPfyrouounh7JuUauXzc2vogmqKo5WJoaKSg92dpKuT+AhIJHfNqyeoky
         UiDE+JHGgY4AxRO8LvRP5eht6LWtiND1LC6y+hORelSL1KU23RfrEprh5gph0S4MgDU4
         VaSg==
X-Gm-Message-State: AOAM5305w0CftqnwmLYD+OBzY1YRpoZupu31QLDbfCCGJLXL7SUAqhcJ
        wcVdvicmM5am9E4x3dFpfFuGPQ==
X-Google-Smtp-Source: ABdhPJzqseDodTFGiVcwKAZ0+WEQQShfRm4wrCMlTqzPu1nhqzycrYKYDNrLdc20GYA8/1uq9sWN2Q==
X-Received: by 2002:a50:d710:: with SMTP id t16mr61915231edi.50.1639383837382;
        Mon, 13 Dec 2021 00:23:57 -0800 (PST)
Received: from localhost.localdomain ([2a02:a210:20c5:8c80:7d0a:cd68:c339:f426])
        by smtp.gmail.com with ESMTPSA id nb17sm5535561ejc.7.2021.12.13.00.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 00:23:57 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] remoteproc: qcom: pas: Add SM6350 MPSS support
Date:   Mon, 13 Dec 2021 09:22:02 +0100
Message-Id: <20211213082208.21492-3-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211213082208.21492-1-luca.weiss@fairphone.com>
References: <20211213082208.21492-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a config for the MPSS present on SM6350.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 03857dc9cdc1..2d43aa0dfeb7 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -804,6 +804,7 @@ static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,sdm845-adsp-pas", .data = &sdm845_adsp_resource_init},
 	{ .compatible = "qcom,sdm845-cdsp-pas", .data = &sdm845_cdsp_resource_init},
 	{ .compatible = "qcom,sdx55-mpss-pas", .data = &sdx55_mpss_resource},
+	{ .compatible = "qcom,sm6350-mpss-pas", .data = &mpss_resource_init},
 	{ .compatible = "qcom,sm8150-adsp-pas", .data = &sm8150_adsp_resource},
 	{ .compatible = "qcom,sm8150-cdsp-pas", .data = &sm8150_cdsp_resource},
 	{ .compatible = "qcom,sm8150-mpss-pas", .data = &mpss_resource_init},
-- 
2.34.1

