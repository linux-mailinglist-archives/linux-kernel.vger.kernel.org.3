Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50B8549B05
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244050AbiFMSDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244033AbiFMSCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:02:25 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E02D45;
        Mon, 13 Jun 2022 06:45:15 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a15so7218889wrh.2;
        Mon, 13 Jun 2022 06:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1QoX2JQbzTzugkblZY0snlzVou25XBMyzOT7SKDqoAA=;
        b=Clp/O2p1aA1nDN8gmHP/R3hfmo89E0ncB1dnJ219MtJgsBw1h9f322TWPjv2PVPXY/
         bcuIEqS98Qg0CVAyeiaq0nhwqFNDQ6fQWgqc5Hl44ARIzBCh1pa3t8e8d49ldIe8q/uD
         WKicSiC0edjaJwasmmX23rDqyNWxbbI/ZYl1g4Sz17nFLoPNK+rjTZhcESJgibJVHhC9
         9MPIvyP9zt72nPBnjc7Is4B0bkRitYNg7yxE/LJevn6njuF3Om4p/HuQXBepy7aVS4Bo
         V7CUy4RmFPbNwXGMC34Clk5+DhYyLd05FJOPFLekS5oWjT40iC+tHA6eBajTp5ODZvV4
         /rRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1QoX2JQbzTzugkblZY0snlzVou25XBMyzOT7SKDqoAA=;
        b=AV1edM0YLagDiY3FgmNgINJHN/go7/cAusrCurfLQlue7b2izaMxZvmigkLUUEEqVP
         W+VN6M/NLM0Q/UWDUQg3cXHIZ4yz0Xy+BEcFQ8CSE57hd8ZGsO6VThlkfyO0ZvxYAyrt
         YEQEx1JKcICAKQkUor1pC7TzLG0H3kqv7BZS6kug5+jevibm61tnlJ3dAo9YBdWTKqIN
         xukA+ADcFicD8eIjQiNOv3AlWHQCUIcxJPJavzGT72VDuv6yOFpRuFowXOV9X99YlVi0
         NT2lpi7WC7CXY713RHgQNJybnTHo1vyK6KutPMptZJzw+A0MCu5BytYTE3YzGMzMWDPL
         I4UQ==
X-Gm-Message-State: AOAM533Ossi5GXyWZbKZdlxCWibakAUoYooquj84cFfUgQjEBUWdrNWC
        Im9aYliz+/qLUfuHIbRfD4U=
X-Google-Smtp-Source: ABdhPJyilTmFwSNB9Dn6TA5YXf7cMgAkdbRaWjcfOaCNkCnh+TKlFLJg2xI3JkMsR0O0v69lYmQryw==
X-Received: by 2002:a05:6000:1f12:b0:216:642e:e2f2 with SMTP id bv18-20020a0560001f1200b00216642ee2f2mr45976872wrb.414.1655127913692;
        Mon, 13 Jun 2022 06:45:13 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id i1-20020a5d5221000000b002103aebe8absm8647510wra.93.2022.06.13.06.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 06:45:13 -0700 (PDT)
From:   Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2 3/5] PM / devfreq: Fix kernel panic with cpu based scaling to passive gov
Date:   Mon, 13 Jun 2022 15:42:11 +0200
Message-Id: <20220613134213.8904-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220613134213.8904-1-ansuelsmth@gmail.com>
References: <20220613134213.8904-1-ansuelsmth@gmail.com>
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
index b1d3a1e7e3f4..f7f223555c4b 100644
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

