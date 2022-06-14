Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE2254BE8B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 02:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbiFOAEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 20:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbiFOAD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 20:03:59 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17803186CD;
        Tue, 14 Jun 2022 17:03:57 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n185so5460377wmn.4;
        Tue, 14 Jun 2022 17:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DMTuvNRz1WP/wtYWEwAgZhtGlOYc4vZGQjh27l1KtGI=;
        b=j0v8Hc4uhX8Rwje+TwFKDBkE0s+n+7EeYfgd0FHCVN6K+uq/sZIIN+faP0pb9U2QrF
         10ASdlgVGj9Yi5I0Lm1ApHXISvVw9ISMvzLYXD4gOmlHfx8VtayiT7ca0uCUESqwDYUD
         jXXi+U1vnG8zy7k0LZ/IVK9wkL9fj5a1a00rhjON7ByojAhSG9YTNzxb3eWNIJENsBoC
         UBMrHWPeFepk6DeuM5uXTLuCd4MevPHQoFFK3NPqfxM0NavPwV1y5QDMXMgWZC83Vs3K
         FdFllAYjezWk/HrgFGBn2piPfFgwZnjlWf87c4P1+ZEBOGb8dHG21qjBiVs4YFUgqrNt
         LQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DMTuvNRz1WP/wtYWEwAgZhtGlOYc4vZGQjh27l1KtGI=;
        b=bXBk+SHgUNfGanHBss4RgfaYBiiWVVO97VnyhlnVOT+PmgrUhwvrmu1FSS823J7tGM
         tqYa4kagh7FrdyD9oiSmrUvkOMwQ8ZddfWOr1HsWV9WI7jlVeiOJZWNCb5MHi6GKxARP
         PnPFLhtbhS7LN6GgFBfsSMaaT2QmSfzNYLBGly1WJr6URZb/RnIhaTgW9ib+CDzbjOu1
         LkxJB952bkO+GGamlTGshP+iIk/uaVqs9hMkmq9mrgIVTAJ1EFmHAjdcx9YWCnzSNswj
         y1b6gb+lhLG6nr+gEDi/5K6RwA3CitpCoPjLMHpfXollt3+iiHQjKhhfFPrcVr7cdHJu
         z57w==
X-Gm-Message-State: AOAM530QXCr2Hl0eSHrMit5kpuDM1CISAGjHwG458QSfFNbm1/3eobfb
        xcAfLS8k7S6OWTMXve39xJ0Dhtt1U1M=
X-Google-Smtp-Source: ABdhPJzEwGYR3qR4dRsdnfq3T1H7/7WZfH25RqJBOXAGOWcgPN2pp1IVgsZv2WzTGijrhIWpZI4Ihg==
X-Received: by 2002:a05:600c:378d:b0:39c:4950:aef8 with SMTP id o13-20020a05600c378d00b0039c4950aef8mr6701943wmr.96.1655251435470;
        Tue, 14 Jun 2022 17:03:55 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id l7-20020a05600c4f0700b00397342e3830sm5546821wmq.0.2022.06.14.17.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 17:03:54 -0700 (PDT)
From:   Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v4 2/4] PM / devfreq: Fix kernel warning with cpufreq passive register fail
Date:   Wed, 15 Jun 2022 01:09:48 +0200
Message-Id: <20220614230950.426-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220614230950.426-1-ansuelsmth@gmail.com>
References: <20220614230950.426-1-ansuelsmth@gmail.com>
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

When the cpufreq passive register path from the passive governor fails,
the cpufreq_passive_unregister is called and a kernel WARNING is always
reported.
This is caused by the fact that the devfreq driver already call the
governor unregister with the GOV_STOP, for this reason the second
cpufreq_passive_unregister always return error and a WARN is printed
from the WARN_ON function.
Remove the unregister call from the error handling of the cpufreq register
notifier as it's fundamentally wrong and already handled by the devfreq
core code.

Fixes: a03dacb0316f ("PM / devfreq: Add cpu based scaling support to passive governor")
Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
---
 drivers/devfreq/governor_passive.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 95de336f20d5..dcc9dd518197 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -331,7 +331,6 @@ static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
 err_put_policy:
 	cpufreq_cpu_put(policy);
 err:
-	WARN_ON(cpufreq_passive_unregister_notifier(devfreq));
 
 	return ret;
 }
-- 
2.36.1

