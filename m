Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5595C49133E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244140AbiARBC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243963AbiARBCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:02:03 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA01C061747;
        Mon, 17 Jan 2022 17:02:02 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id f21so15536288eds.11;
        Mon, 17 Jan 2022 17:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lj9tyHKwn1pbX2A1jzsdupYAHEFENiH62KbSI1f1j2c=;
        b=bMr3MbKYmOjqfILlGPAynUEEC0XPgkyTNRhiWETQ7zHBC6yGjtIb5ptlFBJ/3U13Yi
         estKbbFawC+Fr23oxP7lxLCt8Cd7hIcjfMBo1cHZ3bNJXouk7wc9eUb3pR9rPcbu5BQk
         SSK0dSe2fWOwFe64WUD9BU0A3ZaXePA8gK+xX50IeZCrdu/i6wstB4UltEOZv6YHP12E
         seC6bG7DSQUV0hU+l/UgRf9jKGc5QGkYtXernKxDqaEYHBXpfeToGHk+wJkMgI1X/2HN
         Ln4eXG5Qq6hWFnOAoD9gJVLoHPtjslSz/jmuD10F/zDwiQwJPgE9w3UCHPdk7Mbxanje
         j46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lj9tyHKwn1pbX2A1jzsdupYAHEFENiH62KbSI1f1j2c=;
        b=L+0aQ4L4huL3rWpg6G3tj2cBB1CpwTcSAgmyCoFSeg9iUl4K4daRvt/GFVC2anc0kP
         5bSPXJB1V2+iDS2trklSdyucD25aVsym3bbtBUKN+wuR7cBWWKgLrMlnOcnik7RW2M9v
         LCiBLNiZ3wljE4CfJyRnKN0ynXTTccv8ighW3cmyB/BWJq9KRJE8dpU8fhrXN7eeLU0m
         DVrA17j30mFHYrkiBqxtGBvQlFPR756zv4geCBNUnRaFWVt1JvVT2JQUUYGb/uYZQ4nZ
         0kjgCwmyNQfQOsfAdx+Zg4wzTfomh9r520kLMENLSCtESa4q61sxUZgDOWweLSIre263
         TkZA==
X-Gm-Message-State: AOAM532yNpUn1UpDOf3DMWNDvU2jyqpPqGm36EoaTDNMqi8qphfvz/HR
        0sJ3nS9LxmEA1yPM4RxA7PQ=
X-Google-Smtp-Source: ABdhPJy3IXye2zcrS9StAsu8r7oZBvJGEoTUKgACMf+lFQ+T07GUPm1rJQwRJIgqbkhDfkX5zrF6Xg==
X-Received: by 2002:a17:907:a42a:: with SMTP id sg42mr18750849ejc.413.1642467721155;
        Mon, 17 Jan 2022 17:02:01 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id 24sm4892127ejg.47.2022.01.17.17.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:02:00 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/14] drivers: clk: qcom: gcc-ipq806x: add additional freq for sdc table
Date:   Tue, 18 Jan 2022 01:44:29 +0100
Message-Id: <20220118004434.17095-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118004434.17095-1-ansuelsmth@gmail.com>
References: <20220118004434.17095-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add additional freq supported for the sdc table.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 7d1ddbbbc8ec..0923d7f79a1c 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -1304,6 +1304,7 @@ static const struct freq_tbl clk_tbl_sdc[] = {
 	{  20210000, P_PLL8,  1, 1,  19 },
 	{  24000000, P_PLL8,  4, 1,   4 },
 	{  48000000, P_PLL8,  4, 1,   2 },
+	{  52000000, P_PLL8,  1, 2,  15 }, /* 51.2 Mhz */
 	{  64000000, P_PLL8,  3, 1,   2 },
 	{  96000000, P_PLL8,  4, 0,   0 },
 	{ 192000000, P_PLL8,  2, 0,   0 },
-- 
2.33.1

