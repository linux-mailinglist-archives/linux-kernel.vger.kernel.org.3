Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2679951FBFB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbiEIMHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbiEIMHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:07:38 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E23223169;
        Mon,  9 May 2022 05:03:44 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id x12so11849751pgj.7;
        Mon, 09 May 2022 05:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IYRI7Pqf0IP4MnPle4/u6vz+EZZyL2gJOrFXkLgavrw=;
        b=XJwhm8aD6uz6rs2RSk1PlLLGRVS1S94WEtQG5UHmIfiztNanHnXpE0/e1BYTmoSpgr
         YxakmTkOw4DkCPdQ27I6ITyzkNNjkrKawPj5Lm2hI7wFpHjT05QkVLH/BAP7gd8lSPxe
         wlfhTe4vhCPc0usPZns2Y6wZzB/wAXIxplplkPEO/zMP59IcYe0vq+3Gv1Sdz9hB0Cwt
         Lw3n/tW0gYVpNTFX8OMb/3HODym747vypoK25Eoj+QxH8r7MWu4hTX0CRCYSV8pqT/Z7
         QCIBIPgo0Mzn4gO+cy6bqnuMSVvGRZLbL3FDZ1pY2JLUZcUN17RmPaXyCertLb7kuDUX
         HO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IYRI7Pqf0IP4MnPle4/u6vz+EZZyL2gJOrFXkLgavrw=;
        b=A21PfOpXZN4Bw/0NWE4XFXBcHQZc2zgRB8Ihb/JevWS2e4WbxQkdy27U3Ij6vEnaFT
         2Mj4KYvqRVLGJ42JWZPHw4ImXzxTkJX4AZ1mGjn938gPLyWMFalJ+ltziUb6rOfcmiUg
         H5akM5dfNf6BtBa9FPMQ7T3PLBFRpa3J7gVU+1zhzbx5sODPf8/FPcTwoms1mURCXEqz
         GFklkdp1Jf/WPvXSiRvSrL+PC9HVaaFRTF4Q3Pg5X9cfwg5Vywqr6s7RuPg7eW1XLFfu
         SDSDneyTI8RhT14/I5b4RKL69CmXgODDWtOBA6+MGW782KsuqQE38EiJJqAnxcOZ/F52
         tCPw==
X-Gm-Message-State: AOAM5330v3EahSZPWg0lCeo4jlJZrVeCMrOtZRL4bix+dS7O7AgjRKSQ
        ed7oVpWLV50cSlWN9vCxHHKGXG12+c5kAw==
X-Google-Smtp-Source: ABdhPJwddykpTCBJ3wUGQ3mfEdAJJX+oUyk/c7wjft0IjltvRnyAdSK3EDp1kzFCXGBpPjoDbtGLYg==
X-Received: by 2002:a63:8bca:0:b0:3c6:21ac:26f4 with SMTP id j193-20020a638bca000000b003c621ac26f4mr13221026pge.540.1652097823776;
        Mon, 09 May 2022 05:03:43 -0700 (PDT)
Received: from localhost.localdomain ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id c4-20020a170903234400b0015e8d4eb245sm7020283plh.143.2022.05.09.05.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 05:03:43 -0700 (PDT)
From:   Chanwoo Choi <cwchoi00@gmail.com>
X-Google-Original-From: Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     johnson.wang@mediatek.com, mka@chromium.org, wenst@chromium.org,
        jia-wei.chang@mediatek.com, andrew-sh.cheng@mediatek.com,
        hsinyi@chromium.org, saravanak@google.com, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v3 0/4] PM / devfreq: Add cpu based scaling support to passive governor
Date:   Mon,  9 May 2022 21:03:33 +0900
Message-Id: <20220509120337.92472-1-cw00.choi@samsung.com>
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

