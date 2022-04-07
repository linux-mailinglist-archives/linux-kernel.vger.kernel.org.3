Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F434F6EF9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 02:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiDGANj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 20:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiDGANN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 20:13:13 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B75202152
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 17:09:49 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id t21so4066919oie.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 17:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IEK8wyACKyDwOMDDA6E3A9ixG1cmyZI8rYlASptfokU=;
        b=GmjX/EEEx8mtOIvA9NUHKz3CGPhXRYwt1Z4pVXu2aWdEmCcK3GPhaCfPohdyINvCoG
         KKcCWC3oB84wrGODn8+WPZTDwE41k5pDRIfr5LUuRtMqpcEbBwh/epsgN4U27ArA+ENe
         HZvt8UfzRVIDsQD6F2g0d40k1FIgzyXYlDWh73egrWo8Ci9qVmUdO0DymjBcjYLPKzC1
         fUCTvLGR9yhXtl2+xPQfyQ4hL4AER07qbO2zrzMKjbridnlvlEqgrxl6ZgDJUppcKNL0
         P3Y0NnsFnPCKlsyRCT3nABe4PAWExLIrTm04iZChnmbdJdFroB4GjTrbfeZ/KTBvIdRP
         RuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IEK8wyACKyDwOMDDA6E3A9ixG1cmyZI8rYlASptfokU=;
        b=zwmNU0UBWyJITQCiI+JLRI6yjyEAfaxEElA468vSp1HKp0381XqNdNSCesc9ckmR7J
         bxNXp7Ya/+wSxIYiCfia5dOtOLxxzX2eakCZnToCo3wE409uBNJSeDTnkqqvW4/BwQyv
         9UvtLfAVlk7a3NMb/H0FNxbJaRR+nKJaMiWmVT7yVEtu+ZbFoR0Vy8yRWWRCcG5C9jAD
         RE1jl/cHgIVlFrg1Gew7YXdivEp01p57Y7K8IawmmTEcFqhsAsSduKVTOWebyArghhEI
         DXuf+HGLEj1/4C0JtXYvXmaaHcuMS8rb0erzPT18V0TWA0BT12QGLeDoJbqF37T812q+
         LFPQ==
X-Gm-Message-State: AOAM530xKMNQKaUKQbVGQT/v9R1cSSN6tXJkASDqVfmIZkDLQ+/Tx9Hx
        LxgRbKBVrpmG5bd42edka1k=
X-Google-Smtp-Source: ABdhPJzY5a75RLfA5Jfn6b3d09YWBzWfIbEu+jApvVeNqhDGhi5wuMSZ1OvHr0KsPva0GXsqQx+wXQ==
X-Received: by 2002:aca:ad11:0:b0:2f7:23cd:b156 with SMTP id w17-20020acaad11000000b002f723cdb156mr4463428oie.171.1649290188266;
        Wed, 06 Apr 2022 17:09:48 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id q13-20020a4ab3cd000000b0032830efe365sm6630582ooo.43.2022.04.06.17.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 17:09:47 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 0/2] staging: rtl8192u: use min/max macros
Date:   Wed,  6 Apr 2022 19:09:42 -0500
Message-Id: <cover.1649288226.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
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

These patches replace ternary and if else statements with an
equivalent min/max macro. Found with minmax coccinelle script.

---
I noticed that ieee80211.h includes linux/kernel.h and linux/jiffies.h,
which both include linux/minmax.h. Would it be a good idea to add
#include <linux/minmax.h>
in ieee80211.h in case the content of linux/kernel.h or linux/jiffies.h
changes?
---

Rebecca Mckeever (2):
  staging: rtl8192u: use max macro instead of ternary operator
  staging: rtl8192u: use min_t/max_t macros instead of if else

 drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c   |  2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 13 +++++--------
 2 files changed, 6 insertions(+), 9 deletions(-)

-- 
2.32.0

