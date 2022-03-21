Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798A34E340E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiCUXXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbiCUXXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:23:11 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A05F352E2F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 16:16:15 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d18so14015282plr.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 16:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jprZ5dlZvfVcHO5mE9ZsoLRmOINsWsg3Aq0+MlbJMbQ=;
        b=m3w0Z62CifEheFBP2aKif3vYzDSKk5kP4WmMFHWxicEhav1Zh1vUUcSqxMBflIqAWh
         13aAwdlYmvIgg9CRJATzDQJ+W51aQ+jfkK32jf7LTv6OZPp6Qs2ftu9cAAlYBepUB5Zf
         z37VcVrlpoe+qPR8Pbnx11ENZuL1iSdgBJQk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jprZ5dlZvfVcHO5mE9ZsoLRmOINsWsg3Aq0+MlbJMbQ=;
        b=QbS5fkFlJtkI+hoNQRSwhGioxImArL+Pa53BIdWLg1kYqXpdC7Z4wrBlI1nct+qiX4
         +EiysGKDG7mcKp8jpGqZcMzGjJ96400llpQnP1gVZ+owzzFg1gR0pJFRqnPsZhanj7cz
         K0HSe1FNP90EvgYecv2tz2JdRf3aH8UjPGDR5vprJxNK++452MO6GG7pOjUc4/AlKp/d
         i5NoSo4H/OswILbXRZxwiWZNr+VPLl7GFFcRu0fQ8FjMDsbpJ9hDS1TYOuVEASrt7gvm
         wTGmTt5UrM/a6Li++Qu3juQT63vtsdsj1NQldHql0qrQAdxutt8C9G/xWdlF57qQhU+m
         /kuQ==
X-Gm-Message-State: AOAM530kLsDj5303qkV6kERZz7T8BN6kup78SAJ4KNCW/JN2raDUWeYw
        LlZOrNedW/Oa5pZemk9TjqG9zA==
X-Google-Smtp-Source: ABdhPJy4o7zoUol63NLz6MOIzB5l3YwODgUiOck2+yxumSjiJkNDqtAnqeZi3MluXTRKMbqZP7s30w==
X-Received: by 2002:a17:902:ef46:b0:153:81f7:7fc2 with SMTP id e6-20020a170902ef4600b0015381f77fc2mr15499305plx.26.1647904574600;
        Mon, 21 Mar 2022 16:16:14 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:69b1:6a1d:ea0e:4fc9])
        by smtp.gmail.com with ESMTPSA id oo17-20020a17090b1c9100b001bf0ccc59c2sm481412pjb.16.2022.03.21.16.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 16:16:14 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: socinfo: add SC7280 entry to soc_id array
Date:   Mon, 21 Mar 2022 16:15:55 -0700
Message-Id: <20220321161546.1.Ifc4270fbe9bad536f08a47696e00cca5a0714abd@changeid>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for SC7280 SoC.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/soc/qcom/socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 8b38d134720a..dbdbad5db3e5 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -330,6 +330,7 @@ static const struct soc_id soc_id[] = {
 	{ 459, "SM7225" },
 	{ 460, "SA8540P" },
 	{ 480, "SM8450" },
+	{ 487, "SC7280" },
 };
 
 static const char *socinfo_machine(struct device *dev, unsigned int id)
-- 
2.35.1.894.gb6a874cedc-goog

