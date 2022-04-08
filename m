Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA73A4F8CDA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbiDHDVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 23:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbiDHDVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 23:21:04 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911D5125CA1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 20:19:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so8383738pjk.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 20:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ihxscLrTzBaV4WXnBb9vogkk+ykI6foxyFnwvSuHsqQ=;
        b=LGJeLq+k6yjpt4t2UidZZNUQcAJ5PdedMv3QqHOd+DeOC6NHOYRfHyRVAfPKTiPXKW
         9+pkELk5Z8E9s9qBpYK2HdEpdQ3/wsu1JXPoraqSX4C8XRtJRCEnWECQKOExHZfV7lP3
         GrdLXP8YUuZ4FoB8iXJkJ02NHAev/P17TsKBArjrzh267F9wa8PJGW1Sl8hxNVqFJTq0
         urTkWzttjbCvrlHF2TTDCeNqmYRt4xO5p6HK8Djn4PlSzc0Uo3MutJO+G0mr5oOb8muX
         ZBTzuVfW2z2oqFM5hFgCtPegbv8Q58wTYCm2bHBwn0QBoixdbpaUe7m9uYW3NZfiBz51
         s9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ihxscLrTzBaV4WXnBb9vogkk+ykI6foxyFnwvSuHsqQ=;
        b=Cvs3Vku5l4MXXsvisGb/8ypa7rCiF5TG7FjZ/bSK2ID3WbzaTyRF3slqp5ydYPfQeH
         ZW8jsZu75KaDPue6+cwJeL+enE+omgpI58odxILHUmV+6/rclZXyR6sh2VUJM719VFnX
         t5mUUDV48ensthg9wgBzPJjdhiTJ5htuq20MOOgUuVZHwJ6YwmxpLj+Ajjan2xDiM3ta
         egjWvmItf12Ozk5KTSbIhtbCPx7jmGadHDlYOOqx835ONMgHT+DFwJAeM1M6NHANBEAc
         dDZNbqIEhCL7MzfwGtybiXInKyqZ5/btVuEZpZR68NI5LFqDBPqnksthkLULDTV4MTh0
         2wOw==
X-Gm-Message-State: AOAM532t7vM+pWpZnOcQdgh/OMRsQ+K12kPIo2Hpc2puuSrFp0Ax7CdB
        L91PU3DmkocsF4X/thD8S/lAkYopTxpSFtE=
X-Google-Smtp-Source: ABdhPJxdiXy3ky2yOREMCaRx2wuVo4Zwz2uMCCEvyntuafgZXVQKiUwuOSTZFh0j1tLm/x7LXPSV+Q==
X-Received: by 2002:a17:902:f112:b0:156:9aec:b05d with SMTP id e18-20020a170902f11200b001569aecb05dmr16934210plb.92.1649387942056;
        Thu, 07 Apr 2022 20:19:02 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id ca16-20020a056a00419000b004fdf8a00b64sm15248436pfb.176.2022.04.07.20.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 20:19:01 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     zbr@ioremap.net
Cc:     linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] w1: Fix warning on module removal
Date:   Fri,  8 Apr 2022 11:18:49 +0800
Message-Id: <20220408031849.897248-1-zheyuma97@gmail.com>
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

This happens because w1_process() can leave the kthread in
TASK_INTERRUPTIBLE state when the kthread is being stopped. Since
kthread_exit() might sleep in exit_signals(), the warning is printed.

Fix this by set the current state to running before exiting.

The following log can reveal it:

[   26.713749] ------------[ cut here ]------------
[   26.714135] do not call blocking ops when !TASK_RUNNING; state=1 set at [<ffffffff83c59b0f>] w1_process+0x22f/0x370
[   26.715053] WARNING: CPU: 4 PID: 282 at kernel/sched/core.c:9660 __might_sleep+0x96/0xb0
[   26.719007] RIP: 0010:__might_sleep+0x96/0xb0
[   26.727411] Call Trace:
[   26.727644]  <TASK>
[   26.727832]  exit_signals+0x2f/0x3b0
[   26.728143]  do_exit+0xcd/0x18c0
[   26.728423]  ? kthread_should_stop+0x5f/0xa0
[   26.728801]  ? w1_process+0x34e/0x370
[   26.729115]  kthread_exit+0x42/0x60
[   26.729407]  ? w1_process_callbacks+0x130/0x130
[   26.729804]  kthread+0x272/0x2e0
[   26.730083]  ? w1_process_callbacks+0x130/0x130
[   26.730464]  ? kthread_blkcg+0xa0/0xa0
[   26.730797]  ret_from_fork+0x22/0x30
[   26.731109]  </TASK>

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/w1/w1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index f2ae2e563dc5..ae169f3ee941 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -1206,6 +1206,7 @@ int w1_process(void *data)
 			schedule();
 	}
 
+	__set_current_state(TASK_RUNNING);
 	atomic_dec(&dev->refcnt);
 
 	return 0;
-- 
2.25.1

