Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6220D522F8B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240356AbiEKJgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241889AbiEKJgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:36:08 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC391193F9;
        Wed, 11 May 2022 02:36:05 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c14so1509056pfn.2;
        Wed, 11 May 2022 02:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O88Szo+Omq4F6dF+s0q/ZFttzodkP+77b2tvfNUQP3c=;
        b=ghRHSjolHLt2VDl+GTER1jRRuG0yAr0hwwgCy3W89FomDCyWDWa31WsotgFihImdXk
         WUpIuoxhM1xvlXdz2opqG4GOMJD5Sn5OLV7KzJl76rdiYxeNoSKc3SQ8ogFmz0htPVzr
         MK8Acc3idh2/M5VqLgrAdUgFTae6VV4tKT8D6wOT9F8CDKIqZhunbwRbYBx92MK1vuvi
         gMqSyjuIqZdtZfJOC6DOo2rtxJFgsQtIxQfQQ2s1aiXw528Gw71fvVsHT/rvzdtmH1P+
         q7ZKHVXuFOaOR6/EmrmtvslcdOxY7ovrRhVasFPvMqdzMlM2XDz4taJXpFj55g0K5SbN
         3dCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O88Szo+Omq4F6dF+s0q/ZFttzodkP+77b2tvfNUQP3c=;
        b=Y0aOwRjT2uEAqh0JCpa98uzf1/urTqWjOZpO5jIIQxYgnaW62WkI/AsTyUYKf69HT1
         BRdRUUn1XE2+B3dpTozARJYK5pXVaciuTzycjiv0ltbj4G0wc/v5hOI7fYxVJHQ2tWqI
         YMo0d6agS1iybQLdsWiNqw5q17G+Z+mo5JeYW5ebpjMcZb3/qMN+s7/z9Jdg4WZVjEH/
         RgEuM1rm4I0Rb5opXsKnBg+M1uiT1PLv8iRK86+/nWjyIx3jMO0wxU3dvgOAQxTgFMOA
         UkA8MOMKrUIzYBQQrhKfCNqHP9C8x91eBlnzW+jqYIFd7yfSBncDyL5jnkkQ62LzGAaq
         FhVQ==
X-Gm-Message-State: AOAM533Y+ZJPWqOSoNzNXu+x7QB3AP7Z/B05WQ0S//5sM/LJG7oCKG6Q
        fTVlJ+CagnLqncM1qzzekYj8/BxFzJw3Cg==
X-Google-Smtp-Source: ABdhPJxmOhooQCAQx+k65II1F+oq1C/AsvE6sY9DXx8MY4psgP3uIMv6+nQOeogMk8mGb9emyq+Jyg==
X-Received: by 2002:a63:fe16:0:b0:3c6:48dd:f7e4 with SMTP id p22-20020a63fe16000000b003c648ddf7e4mr19483963pgh.458.1652261760238;
        Wed, 11 May 2022 02:36:00 -0700 (PDT)
Received: from localhost.localdomain ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id p14-20020a17090a428e00b001dcf8960a13sm3492640pjg.40.2022.05.11.02.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 02:35:59 -0700 (PDT)
From:   Chanwoo Choi <cwchoi00@gmail.com>
X-Google-Original-From: Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     johnson.wang@mediatek.com, mka@chromium.org, wenst@chromium.org,
        jia-wei.chang@mediatek.com, andrew-sh.cheng@mediatek.com,
        hsinyi@chromium.org, saravanak@google.com, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v4 0/4] PM / devfreq: Add cpu based scaling support to passive governor
Date:   Wed, 11 May 2022 18:35:50 +0900
Message-Id: <20220511093554.17535-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devfreq passive governor has already supported the devfreq parent device
for coupling the frequency change if some hardware have the constraints
such as power sharing and so on.

Add cpu based scaling support to passive governor with required-opp property.
It uses the cpufreq notifier to catch the frequency change timing of cpufreq
and get the next frequency according to new cpu frequency by using required-opp
property. It is based on patch[1] and then just code clean-up by myself.

Make the common code for both passive_devfreq and passive_cpufreq
parent type to remove the duplicate code.

[1] [RFC,v2] PM / devfreq: Add cpu based scaling support to passive_governor
- https://lore.kernel.org/patchwork/patch/1101049/

Changes from v3:
: ttps://patchwork.kernel.org/project/linux-pm/cover/20220509120337.92472-1-cw00.choi@samsung.com/
- Add tested-by tag of both Chen-Yu Tsai and Johnson Wang
- Fix some typo

Changes from v2:
: https://patchwork.kernel.org/project/linux-pm/cover/20220507150145.531864-1-cw00.choi@samsung.com/
- Drop the following patch ("PM / devfreq: passive: Update frequency when start governor")
- Move p_data->this initialization into cpufreq_passive_regiser_notifier()

Changes from v1:
: https://patchwork.kernel.org/project/linux-pm/cover/20210617060546.26933-1-cw00.choi@samsung.com/
- Rename cpu_data variable to parent_cpu_data to avoid build fail
- Use for_each_possible_cpu macro when register cpufreq transition notifier
- Add missing exception handling when cpufreq_passive_register_notifier is failed
- Keep cpufreq_policy for posible cpus instead of NR_CPU in order to avoid
  the memory waste when NR_CPU is too high.
- Add reviewed-by tag of Matthias Kaehlcke for patch1



Chanwoo Choi (3):
  PM / devfreq: Export devfreq_get_freq_range symbol within devfreq
  PM / devfreq: passive: Reduce duplicate code when passive_devfreq case
  PM / devfreq: passive: Keep cpufreq_policy for possible cpus

Saravana Kannan (1):
  PM / devfreq: Add cpu based scaling support to passive governor

 drivers/devfreq/devfreq.c          |  20 +-
 drivers/devfreq/governor.h         |  27 ++
 drivers/devfreq/governor_passive.c | 400 ++++++++++++++++++++++++-----
 include/linux/devfreq.h            |  17 +-
 4 files changed, 387 insertions(+), 77 deletions(-)

-- 
2.25.1

