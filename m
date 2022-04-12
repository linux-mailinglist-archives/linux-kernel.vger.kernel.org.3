Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0CF4FEB74
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiDLXXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiDLXW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:22:58 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8675E142
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:09:55 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id e22so226262qvf.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vCDAOLehwCcYWONpYO55pEeYX9bgO2K2M5jLJHp+bpI=;
        b=f3wqgGp7zhfxxmUYx2wFIqyhK/dVBaSlOkIhRroiZYAKd56bRrIV6waKSNZ/2tsGv0
         Nw3QwGhQIWVYMCrfS8K7BlNJlyiFETnfKvQJlD7NcKbbpBxSuinhvljRQg1gG7HPZSLK
         Ili7D5D8shmf7l6YI7ifS+mCwSe1cVfvLtAZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vCDAOLehwCcYWONpYO55pEeYX9bgO2K2M5jLJHp+bpI=;
        b=hZqRfDhWWNDu8IejdfGF4TO2RFR0dVhQ0UH0sHmLzlrDsLbWkQJhQx4ULvwrCkple3
         rSUEb/54s92dxwS/brfT7WU/Lwt+GrMNM++LFhOiJsxSnNZha/SplLT9FRXcplRUWYzZ
         Ntu6A1Fh29R3QYwVZDxDBqD29AUeUjeJjRFZ3Uw9KHilHnHiLoEIsHZq4sHtGoi8NEEj
         +/bU4aarCkxwrn2Q9yi7J9ussN6qSt0a6rliqW2lZdrPfzWZFTwlsmPfDibFEmr+i7+T
         jpOCPulB3pYF3z6FF7KWGAgaR+CfzxNT3+vtWz38HtypF28F3j5akopgYU35j1mTjQu7
         tLMQ==
X-Gm-Message-State: AOAM53092Oc0khb+xtYTDcPrptOEEOxQaFXoLtBugZuN3k7t1zjgIwN1
        KNYUQp2x4PyouUmqgku0TIzi3mWAEGoLjw==
X-Google-Smtp-Source: ABdhPJzNEbYMytxD9EJ57XxGpAfifgM7NYJofzitQ2bTxFGc+O+FdsXfJu8X/2J7qcNA1BQorC6MMQ==
X-Received: by 2002:a17:902:e0c9:b0:158:9b65:aab with SMTP id e9-20020a170902e0c900b001589b650aabmr1738597pla.18.1649800836581;
        Tue, 12 Apr 2022 15:00:36 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:e880:a5db:8eff:6b6a])
        by smtp.gmail.com with ESMTPSA id p13-20020a056a000b4d00b004faecee6e89sm40565288pfo.208.2022.04.12.15.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 15:00:35 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Alex Elder <elder@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/2] interconnect: qcom: Remove IP0 resource
Date:   Tue, 12 Apr 2022 15:00:31 -0700
Message-Id: <20220412220033.1273607-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches remove the IP0 interconnect used for IPA because
they're also present in the clk-rpmh driver. I see there are some more
IP0 usages in the interconnect drivers, but I don't see a corresponding
IPA clk in clk-rpmh, so I left these out. We can remove all of them if
desired, but the sc7180 patch is most important to me as it fixes
boot on my trogdor lazor device.
 
Stephen Boyd (2):
  interconnect: qcom: sc7180: Drop IP0 interconnects
  interconnect: qcom: sdx55: Drop IP0 interconnects

 drivers/interconnect/qcom/sc7180.c | 21 ---------------------
 drivers/interconnect/qcom/sdx55.c  | 21 ---------------------
 2 files changed, 42 deletions(-)

Cc: Alex Elder <elder@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Taniya Das <quic_tdas@quicinc.com>
Cc: Mike Tipton <quic_mdtipton@quicinc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

base-commit: 3123109284176b1532874591f7c81f3837bbdc17
-- 
https://chromeos.dev

