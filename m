Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D72E54AF0A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 13:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356010AbiFNLH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 07:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238354AbiFNLHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 07:07:24 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32195129;
        Tue, 14 Jun 2022 04:07:22 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id v19so11106007edd.4;
        Tue, 14 Jun 2022 04:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2L3AiVAVVeG2sI/RNWNH+L06x6mR1BlO2dFt+MC4cW4=;
        b=G8jKIzMDrhaRcHnf4xfevfhDAcizrmk8fQfzFi9FE9sZ3/BJ9W9jswvl2xPlE3ZiVR
         vx+k359CaZbFkkEBXrxQXsIFIGbJEghXIbWPkq6suRQ34CcUdjgFbD5zXqZD8qD3kN7V
         YkdT/u68ZB9SE0pqfrmOFvUzqflKxg4jIWi3Po3T1Z053UR5y8y3COriqxK3a9eY0pv3
         J5o2gpTy/oBsqWlgxLNy8YWFwaI32+KaKRbIYk6JZ968nNKE9K4/4FMV14ZPQ4M9hzzj
         WfOzzBB6cZGUkgQ2Gmhk31A4DvwgZ9Syx+grgyHcFLmaXfBO5JCmhF14szdMJ0FvCmBN
         DmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2L3AiVAVVeG2sI/RNWNH+L06x6mR1BlO2dFt+MC4cW4=;
        b=ziEetcfxiiv5V4NAJvUoWa5sfKYchNIn1c5ThDduudZBGTVJHnNwWBWcJMSba/l2Xf
         m+jtxfphJNGoZAvb5uCSK9GxOPZgRI16e9ppSduoNoCYtdiPrJFs54S/U7/rVvSggao8
         Brl5bxfTeC69iXiKYR7VwWBHDQGFFkPzbCnvUfQI5spv0VeN085othvUEKMSpuv2jhtW
         8aTdV0u43vZnd2wajlmU9AzZYS3JIsKfZYGfU8WIucki6P2/OsjwRO6KWjI8HJpqL6cP
         FpXc8MIvS0q5sW1S1DukLtnLTIfOJY+VSoXW56H8nWK3Yz+48+ytdwLjO81rZBfxiPbz
         ZsrQ==
X-Gm-Message-State: AOAM531GdrMQawLyCf/S7/Ep1NBlZYRPbRcd+LLbKlutkCulUSFUalcC
        DsGjfcj2I4FGL3laqMtp/b4=
X-Google-Smtp-Source: AGRyM1sETTyqNOJwd8g1bPuEU0Lnwx+38LnXvu9f8uCoUBzTrhI09bG0a7qYGPu7+kS9ZBUwmX/ZJw==
X-Received: by 2002:a05:6402:4301:b0:42d:e8fb:66f7 with SMTP id m1-20020a056402430100b0042de8fb66f7mr5270210edc.229.1655204840519;
        Tue, 14 Jun 2022 04:07:20 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id cb2-20020a0564020b6200b00433b5f22864sm6867456edb.20.2022.06.14.04.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 04:07:19 -0700 (PDT)
From:   Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v3 0/5] PM / devfreq: Various Fixes to cpufreq based passive governor
Date:   Tue, 14 Jun 2022 13:06:56 +0200
Message-Id: <20220614110701.31240-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
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

While developing a krait cache scaling devfreq driver I encounter tons
of panics and errors with using the new cpufreq passive governor
functions. While the krait cache scaling is still WIP and required some
testing I would like to push all the fixes to make the new
implementation wroking since currently with a the governor
PROBE_DEFERRing all sort of things happen from kernel panic from invalid
address access to freq_table getting corrupted.

With the following fixes my WIP driver works correctly without any
warning/problems. 

v3:
- Fix compilation error for list_for_each_entry_safe (i'm stupid -.-''')
v2:
- Fix wrong list_for_each_entry reported by Dan Carpenter

Christian 'Ansuel' Marangi (5):
  PM / devfreq: Fix cpufreq passive unregister erroring on PROBE_DEFER
  PM / devfreq: Fix kernel warning with cpufreq passive register fail
  PM / devfreq: Fix kernel panic with cpu based scaling to passive gov
  PM / devfreq: Rework freq_table to be local to devfreq struct
  PM / devfreq: Mute warning on governor PROBE_DEFER

 drivers/devfreq/devfreq.c          | 75 ++++++++++++++----------------
 drivers/devfreq/governor_passive.c | 41 ++++++----------
 include/linux/devfreq.h            |  4 ++
 3 files changed, 54 insertions(+), 66 deletions(-)

-- 
2.36.1

