Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E428B4DA35E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351370AbiCOTkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239130AbiCOTkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:40:17 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D51D26AC8;
        Tue, 15 Mar 2022 12:39:05 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id eq14so321906qvb.3;
        Tue, 15 Mar 2022 12:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y4cddUoqVFpLUfMwb7praucCiytxMvdK4hfW8oMVM3k=;
        b=UdqtnIwKYE/RQUNi8xbISZLY68ugVrZDbBmSG46wN1Qh4dFxCjW1nc+T+V98qOLHMY
         Dj9Z0wSO09unlVnMQJPyOwFrsdLC6kek38k6lZBjwr5dCk/1g/LQtaYy1VMLUxSCRQYO
         MkFwfSwivnsczJLjF9pqqVtBF6fhOvzv+a78Jj0IJ2kdFnAOHFrVa/FGeVSNmAvdIeMw
         1tMUyfPMBZgBgPHdbjDtz2UCL5bWgjNweIid3whE7xu8vt353yFaToeqspW4lFNqcanI
         AEjVJRyIMj/6jSfWc4xPJwdT/dYkULXwIYEQSm816gbn8iiAWZJjry77sL+O+h72DDBv
         wgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y4cddUoqVFpLUfMwb7praucCiytxMvdK4hfW8oMVM3k=;
        b=Tg3v4NlvsvFY7YoR7VBul9HLoJvBur6OQUpt/mdx2DsV882D+ajRnH+GnD3c0/NQIT
         btrW4uBbnVgJGJW3hhbKFRS9ssF5C5G9RsaHpSAlRW+vG5mBvB/byKWEZFLIrDvZQxIS
         SmPKK7FWAjn2aprGIIFhPsvLOllxVlXM9iuRCK0FW6d2Ce9iFnDtd3LliRVfkWoKYS4m
         m1RyXq5ljuA/MOEbpCQpyznr0imc9Sr/dhnGV9QeDLNBBx1gZlQcF75kkaYGilLk5vao
         Kxu/S1EzR9VJNUYeWb3d0ZD2tHmm3Qv9MtWUrrt2+J/+SQaHiRrE2XG7d5UvSrxnsgqq
         9Neg==
X-Gm-Message-State: AOAM532cvPEmGdFoobc6cZg2aoqW6934NSfLIGO1iXURDqWTqsfeVjgV
        SZcIEc4aUZYrrrUJBXBZ1X4=
X-Google-Smtp-Source: ABdhPJxolmfxc5JsHpfwouLYMmw+9FQ4OY2rG6RV+xfUnEb1WEQYe3AwyNdjP9QexQraPiMdAUvIMA==
X-Received: by 2002:ad4:5aa1:0:b0:435:9404:bff5 with SMTP id u1-20020ad45aa1000000b004359404bff5mr22446368qvg.126.1647373144338;
        Tue, 15 Mar 2022 12:39:04 -0700 (PDT)
Received: from ishi.. (072-189-064-222.res.spectrum.com. [72.189.64.222])
        by smtp.gmail.com with ESMTPSA id o4-20020a05620a22c400b0067e02a697e0sm1440798qki.33.2022.03.15.12.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 12:39:03 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [RESEND PATCH 0/6] Counter updates, cleanups, and features for 5.18
Date:   Tue, 15 Mar 2022 15:38:51 -0400
Message-Id: <cover.1647373009.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

First set of new Counter updates, cleanups, and features for 5.18

Only a few changes this cycle, but we do see the addition of a new
COUNTER_EVENT_CHANGE_OF_STATE event type that allows userspace to watch
counter pulses.

Features
* Add new COUNTER_EVENT_CHANGE_OF_STATE. This adds new counter event to
  notify user space about every new counter pulse. The interrupt-cnt
  driver is the first to use this new feature.

Cleanups
- Add Counter subsystem git tree to MAINTAINERS file.
- Set counter device name. This provides a convenient way to identify
  the counter device in devres_log events and similar situations.
- Add defaults to switch-statements. This pacifies warning messages from
  Clang static analysis reports.

Driver Updates
* 104-quad-8
  - Add COMPILE_TEST depends
* interrupt-cnt
  - Add counter_push_event()

Oleksij Rempel (2):
  counter: add new COUNTER_EVENT_CHANGE_OF_STATE
  counter: interrupt-cnt: add counter_push_event()

Tom Rix (1):
  counter: add defaults to switch-statements

William Breathitt Gray (3):
  counter: 104-quad-8: Add COMPILE_TEST depends
  counter: Set counter device name
  MAINTAINERS: Add Counter subsystem git tree

 MAINTAINERS                      |  1 +
 drivers/counter/Kconfig          |  2 +-
 drivers/counter/counter-chrdev.c |  4 ++++
 drivers/counter/counter-core.c   | 12 +++++++++++-
 drivers/counter/interrupt-cnt.c  |  7 +++++--
 include/uapi/linux/counter.h     |  2 ++
 6 files changed, 24 insertions(+), 4 deletions(-)


base-commit: 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3
-- 
2.35.1

