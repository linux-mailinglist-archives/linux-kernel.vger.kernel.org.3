Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2922E53E963
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbiFFLLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 07:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbiFFLLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 07:11:23 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCC4243B9F;
        Mon,  6 Jun 2022 04:11:21 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id q1so28234877ejz.9;
        Mon, 06 Jun 2022 04:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R47nGdJkeSXdG5g2pNh9Q4I5tiJ/be6HekFEcNu4EV4=;
        b=V/8HhtFY1N2DkViJnGkLXICIzYdplKhkbswJkK/ohG3lTrOEG/OXfHtYmXU8++26+9
         QT9wEJ93C4wWo0roJWCCC4ib7Pj3sQz5aAC9xIbYWKfTCUiw0OtcxMGhGnhchk+CmVmd
         tdSWTE1RBc+oRFnY7SwNHJnUGrC+rLtIwKMMH/PNnuF5ATChvrn64zigxGdHekyqpONz
         on/QljA9yD+x4iRgFfhRFogGa/GZL7WWfVQsRBgMSowwSWA0ZihbNbFHoy3RZ3k9Eswz
         scSlFfY93iq60IV7SD/LECIaQWokbNPWbLcGn7HDHdEk7sCyDCTiFcHrkA76PM8JqIom
         RFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R47nGdJkeSXdG5g2pNh9Q4I5tiJ/be6HekFEcNu4EV4=;
        b=FcydvmLOCDqqJ9PlX+FAWNP0ocZFEd+3vU3MfGtPf0oG4XOkj1GgaTMI1Fs2jW0W1j
         61jLeK3dvjJJJinYCfu4sJmo7ADCaKXLkJ3k2f8L+nC2zVf3JqxNURe2eKK24GyayluW
         z6b4J1M31wIHhbQ1KZnA1Bk8bjaMOVUIAp8aw/kj6QVS4ewMVVyw9yhvXjQVvYrasATX
         7qE57N4sz2RsBWSWirKoMHXTSpg7m1J7YKishLcWV1F5qWqsE5zWaM70bbGUF6wA5srh
         BYl8ZL00kecB+Un7dbJnLtu+fSwjm7bBu6DoYWJqAtRVFdzWOJc8w6tU2dqOfcmeMi6g
         nwzg==
X-Gm-Message-State: AOAM532KTtka94is9tIGN6ovyU3N9arggbXs7l+eRqe/+2BtVGpszAeV
        AacmyvX8DMY+oc7gZCJRfDQ=
X-Google-Smtp-Source: ABdhPJyvE0g+UVK1RH5lXnexxiW93ismWefpNl3rm2c6oQXMmJfftHEo1bSll/4IcZWYIQQpMwuGHw==
X-Received: by 2002:a17:907:2d90:b0:6fe:cf3c:ac97 with SMTP id gt16-20020a1709072d9000b006fecf3cac97mr20177593ejc.742.1654513880439;
        Mon, 06 Jun 2022 04:11:20 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id z14-20020a170906074e00b006fecf62536asm3843506ejb.188.2022.06.06.04.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 04:11:20 -0700 (PDT)
From:   Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <skannan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 3/5] PM / devfreq: Fix kernel panic with cpu based scaling to passive gov
Date:   Mon,  6 Jun 2022 13:11:02 +0200
Message-Id: <20220606111104.14534-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220606111104.14534-1-ansuelsmth@gmail.com>
References: <20220606111104.14534-1-ansuelsmth@gmail.com>
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

The cpufreq passive register notifier can PROBE_DEFER and the devfreq
struct is freed and then reallocaed on probe retry.
The current logic assume that the code can't PROBE_DEFER so the devfreq
struct in the this variable in devfreq_passive_data is assumed to be
(if already set) always correct.
This cause kernel panic as the code try to access the wrong address.
To correctly handle this, update the this variable in
devfreq_passive_data to the devfreq reallocated struct.

Fixes: a03dacb0316f ("PM / devfreq: Add cpu based scaling support to passive governor")
Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
---
 drivers/devfreq/governor_passive.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index ab393c8174f4..528c8f3b25f0 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -395,8 +395,7 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
 	if (!p_data)
 		return -EINVAL;
 
-	if (!p_data->this)
-		p_data->this = devfreq;
+	p_data->this = devfreq;
 
 	switch (event) {
 	case DEVFREQ_GOV_START:
-- 
2.36.1

