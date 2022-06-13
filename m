Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D14549B07
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244615AbiFMSDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242039AbiFMSCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:02:24 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52449D43;
        Mon, 13 Jun 2022 06:45:14 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id a15so7218824wrh.2;
        Mon, 13 Jun 2022 06:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eyb0gzzBMaZAiHZGYYnJBj5umG33L2ZCgocNe/btits=;
        b=POBeCUtP2bRjkE8xG8FepF04OX9JLidQUypChR17MOEDStRDopytquh3SHns8KSgZt
         66N29qRsjzwrb8DLhGpCcqoGgxA10SMXOLA3cVpe41qGm+mRkEETZ8YpHr83QtRfe+I3
         /8W4NynY9JWXkbQsA4Ag2v/UcgTSt/iSRpoju81g29x8uxiQQvt9N4tKt73HWhC6oKYN
         GgvbuUKBYSNo2SAjOUSCyP2Jm9/7KvtZe4SoOAeS0OADqhtfplAEvF8H/bJU9nFChTh8
         Q0KOK4G+iCNqOvct/Y18ttSII1J0HVgjOTwmfWH5JLvf3TmBKxG6jZbls+Z411DtHIs5
         Fa+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eyb0gzzBMaZAiHZGYYnJBj5umG33L2ZCgocNe/btits=;
        b=XuuKW3zPtNzSRs+Sbge2Vxns2XuRhpPksn8KgJCF4OxVffdWsEJDAyOVuZVt1sk0Mj
         EzrALy5fx0VZdqC6XRQV/H3kViweznzLG7FlLhzEchdCo53X86Zh3dTtHnhzCHbWIvaE
         CfeeruKiD/MjA7LONWFWFMunr90H4s4ZbXGsq7Dv1FMD/8d1Yq9PULPWpuwto53bnin0
         PiH8bHte4n69+SgZ28dy27GSXBuVl4a2RgKPmmITF/Yl+kwwj8cOlvQVEaJUKlfjS5Nx
         18CgbMNP39wEX0I4TkDRxE4w99MadPoY9UdLeOE3148LGLg63ws1AFSjTn7mM5zMCavd
         qQEQ==
X-Gm-Message-State: AOAM531LP94icO9rTGVLJW1tzWBOeh9Wc5VHK9e+CZ1oMoRY1OnVtryJ
        eQzmVPMZVC1ia9EyycBmGb8=
X-Google-Smtp-Source: ABdhPJz2pbmpIApaOG7ch0omubRyWUhWs8eyCgKuj08tEh4cWJp66mZgAsiwdGQ8m6S31d5lgoaKGA==
X-Received: by 2002:adf:ffc7:0:b0:210:2bba:f431 with SMTP id x7-20020adfffc7000000b002102bbaf431mr58377219wrs.495.1655127912771;
        Mon, 13 Jun 2022 06:45:12 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id i1-20020a5d5221000000b002103aebe8absm8647510wra.93.2022.06.13.06.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 06:45:12 -0700 (PDT)
From:   Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2 2/5] PM / devfreq: Fix kernel warning with cpufreq passive register fail
Date:   Mon, 13 Jun 2022 15:42:10 +0200
Message-Id: <20220613134213.8904-3-ansuelsmth@gmail.com>
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
index 6252f109f8d1..b1d3a1e7e3f4 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -325,7 +325,6 @@ static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
 err_put_policy:
 	cpufreq_cpu_put(policy);
 err:
-	WARN_ON(cpufreq_passive_unregister_notifier(devfreq));
 
 	return ret;
 }
-- 
2.36.1

