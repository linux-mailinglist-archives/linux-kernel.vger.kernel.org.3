Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149234D730D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 06:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbiCMF4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 00:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiCMF4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 00:56:37 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65B05622A
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 21:55:29 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id b8so11655418pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 21:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xFyi6CYJoEjSm5+1sguLJsv91/a710qzltT1W0qTjmc=;
        b=APGtWmOooE0GwzcShavkvPRur63kCnyYMMpFCY58hFomGr2GMQwwE14TVfG3ekC3D6
         GhJ+fad0u4r/rMM6DMb3LILbXzWbM2qJAyNyPQY7OcqPvJP1wG15uEohV5KevcoDwLin
         xhzWFFFCyNtFYTBfSExEIsI1bf1mycV4yIFYRBCOpK6S5p6vvY/T/LkwCHorheNJtmOV
         SZvCPlkMxbbCVG6F3d4M5N0NGicuB7rYR8/PdLq+bahUtrB2zfBLJo6yDfh2iyWeSoY4
         n9TG4SJqb3QvrMNIlSPiNL793vF3HMyshF5ljBq9sVj1aINgU997C8AP34Rl+lskG4bg
         kUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xFyi6CYJoEjSm5+1sguLJsv91/a710qzltT1W0qTjmc=;
        b=EB02TrQlgdLXtL/8t6Xd+NGu/iAshvrVOV8T/NyepCEkzXw+8MbByGMsWECRbwwU9+
         xmsdolRux3vUA1QDTNykU3AfSfnKsDBXwv5H864WhnA/e8P7DQ4Q3Pf8kk1OhXZXM+Z2
         dpOSDK1eUYQ8rsWFBJoyav4U3vjMA6M5pIF336hMqEDpeeHMC+0jq7iSZLL435gUihqp
         qhnIwYc4qKHLKp6rv+RjloMLY7adjTH1/w+WhPbxoGAo2cIuU+aVJ06Pg+5na7RV7vxH
         +jNU9QBkab5mCS+mP0ZkaWrOxLeqyG3qvB84Dxk6Ib59lM8wlpZ8bbz7wxNSCSjAA9jg
         /NBg==
X-Gm-Message-State: AOAM532wq34Iz6ykThu4cDSlxtwYakNMXkjIsES9onjBIru5cYRHCwdF
        nHtjFgjnL/bWPHEsdqoMUFAhng==
X-Google-Smtp-Source: ABdhPJxgY7Q7uv72XuecPePNWWP+SkoffrEYEZW2fP/ONZx69HHDRFzvxSczjmHZy1i/AvUkIB2u7Q==
X-Received: by 2002:a17:902:9a02:b0:14f:2d93:92f4 with SMTP id v2-20020a1709029a0200b0014f2d9392f4mr18810902plp.160.1647150929175;
        Sat, 12 Mar 2022 21:55:29 -0800 (PST)
Received: from localhost.localdomain (104.225.159.237.16clouds.com. [104.225.159.237])
        by smtp.gmail.com with ESMTPSA id m11-20020a056a00080b00b004f75d5f9b5csm14792447pfk.26.2022.03.12.21.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 21:55:28 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/3] arch_topology: Correct CPU capacity scaling
Date:   Sun, 13 Mar 2022 13:55:09 +0800
Message-Id: <20220313055512.248571-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to address issues for CPU capacity scaling.

"capacity-dmips-mhz" property might be absent in all CPU nodes, and in
another situation, DT might have inconsistent binding issue, e.g. some
CPU nodes have "capacity-dmips-mhz" property and some nodes miss the
property.  Current code mixes these two cases and always rollback to CPU
capacity 1024 for these two cases.

Patches 01 and 02 in this set are used to distinguish the two different
DT binding cases, and for the inconsistent binding issue, it rolls back
to 1024 without CPU capacity scaling.

Patch 03 is to handle the case for absenting "capacity-dmips-mhz"
property in CPU nodes, the patch proceeds to do CPU capacity scaling based
on CPU maximum capacity.  Thus it can reflect the correct CPU capacity for
Arm platforms with "fast" and "slow" clusters (CPUs in two clusters have
the same raw capacity but with different maximum frequencies).

This patch set is applied on the mainline kernel with the latest commit
68453767131a ("ARM: Spectre-BHB: provide empty stub for non-config").
And tested on Arm64 Hikey960 platform (with a bit hacking to emulate
fast and slow clusters).


Leo Yan (3):
  arch_topology: Correct semantics for 'cap_parsing_failed'
  arch_topology: Handle inconsistent binding of CPU raw capacity
  arch_topology: Scale CPU capacity if without CPU raw capacity

 drivers/base/arch_topology.c | 42 +++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 8 deletions(-)

-- 
2.25.1

