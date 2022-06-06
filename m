Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E38153E8CB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbiFFLLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 07:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbiFFLLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 07:11:20 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184AC243EEB;
        Mon,  6 Jun 2022 04:11:18 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id v19so18304323edd.4;
        Mon, 06 Jun 2022 04:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/RJd+8IYpSE2CY3/IEU/Ym/gq/tiHBKgXztdClQXGM0=;
        b=GaKY3sRKyxQvQSfrWdNM4s9qbbCAgxc7muOrOX72qgpljyMPje8m4vhPe3LrFZUs2S
         sEQmlHkpgb7+vdRVDqReDh763Z+ExUDfeHZmvLKvyEdXylEZ8NmzOPPhfsGo+kogehFh
         /DZ/j+Zsy87H/XnE7yV3s0Tbkj7doRqqAXX2MYYiG2abo96hdvtcDveMPuW5D5hvAID+
         ZXnHp6kHq6V01TO3901zwYCInlyg/Og8eGO1y/UxsaTyuVfzc1scFjD1iNix6+Y13rW9
         zYtB6AnwaNFQmw1zCG3fotvIt6qeqFw/2LvpImYE2s2xEq6rab5c48b7jH9nGjJyxvYI
         0McQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/RJd+8IYpSE2CY3/IEU/Ym/gq/tiHBKgXztdClQXGM0=;
        b=qAxsrm/fnsV6wCMV09ycn+e0uHfZyfop03cQmy7Uh0+gwmvv+0TpV09geQw77N/nqe
         D0DDKexC2cAFdOjrptGX+GXSQCMuUJmQ85meFMYIztBiuOmqUskRsTQDY2NnvnZowEHO
         41e8M0lEQ5pUC8OyqXoOByMpKzsNqoURCc6QJpRqeQ0/uYpK/tX9gPTZctxuXrzJoCh3
         Iztt0OGyFGWQDh//G39b9nOvQ69PhYtYUXt6VNrt7Mo6SHZCwXz+lSeS0I3Rhb74ag6U
         WrX51D19/HZ9N/zU7n4mTbuNr5u12yHPZ6glLIGrirqAe18bQV2x+kav+zKECWWY7EVc
         PY0Q==
X-Gm-Message-State: AOAM531STDqPL7j2DzzqZPRQnyzX77UeHoXqA9LEBCFwP4mk8TMpD9rR
        EQ28Vrjpw+cXqmJXjMtb6FM=
X-Google-Smtp-Source: ABdhPJwZUQeucIvJTVrAkFWEp+2hwlthwxK0gdOMxVGQXbZKVBzKHuyrVmDgczYxG3j2qVEvPDSnqA==
X-Received: by 2002:aa7:d441:0:b0:431:486b:2573 with SMTP id q1-20020aa7d441000000b00431486b2573mr8449526edr.60.1654513876058;
        Mon, 06 Jun 2022 04:11:16 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id z14-20020a170906074e00b006fecf62536asm3843506ejb.188.2022.06.06.04.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 04:11:15 -0700 (PDT)
From:   Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <skannan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 0/5] PM / devfreq: Various Fixes to cpufreq based passive governor
Date:   Mon,  6 Jun 2022 13:10:59 +0200
Message-Id: <20220606111104.14534-1-ansuelsmth@gmail.com>
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

Christian 'Ansuel' Marangi (5):
  PM / devfreq: Fix cpufreq passive unregister erroring on PROBE_DEFER
  PM / devfreq: Fix kernel warning with cpufreq passive register fail
  PM / devfreq: Fix kernel panic with cpu based scaling to passive gov
  PM / devfreq: Rework freq_table to be local to devfreq struct
  PM / devfreq: Mute warning on governor PROBE_DEFER

 drivers/devfreq/devfreq.c          | 75 ++++++++++++++----------------
 drivers/devfreq/governor_passive.c | 39 ++++++----------
 include/linux/devfreq.h            |  4 ++
 3 files changed, 53 insertions(+), 65 deletions(-)

-- 
2.36.1

