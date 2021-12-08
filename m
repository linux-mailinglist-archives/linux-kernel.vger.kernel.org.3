Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CC246CF0E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 09:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240696AbhLHIg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 03:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240441AbhLHIg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 03:36:58 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4637C061574
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 00:33:26 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id e3so5806805edu.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 00:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ezHbFwEHOgtVXrEPyC2/Vvb45wpR1NFY6XpUn36BJXE=;
        b=Oaf+owd/RxE7FUplEWeI5CqQzsjKbRXuQa43xyIk8paq/kW39V2Jk0nlY1ZWyhxpzU
         X+N7Df1mmj2hufjljaOYnx6hIp5QRnh87y5eornCGGFjBBGRy+28h36VkFJBkOLHAIn0
         tP4YpbDPUYZNhTcWm7KU3yIvoj6iSxSMmyAepmyNHhV38hpTgWKrg9ic9zKd9uOxTAMR
         Ig9dgtPY0sOotTxVnxNOvU8F+wcYjME6qhBsYZAjLi568fI6/TBQTAaVRtg3oolVohXr
         AToDvZFgbftWn0HolfqaZyNLXnSZwSbZ1HBfyMnqcJv3yyJR4VduqbXUBvD4tfZkn7Kw
         43ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ezHbFwEHOgtVXrEPyC2/Vvb45wpR1NFY6XpUn36BJXE=;
        b=vPHNow1kL8xCKf8BmBDsxtHOD8t2vOaou2vhnO8c5tHUr/KzYDPh4/27nwiCB/T3so
         TCf0X1lt7+M7hi79anbcdtp2mfCuMZSufNHSdMkIiFScUrQYpks/sPoHg8h+tGtLd/If
         gXNDv9m65ryJkTeoMBKlmmbQuci+5NpHVib+Q7/HGZmjwZmEJEjmvYJPxV/0bESNPqyJ
         z8lXE86wFyRnkuOWoJhfM24hIxGrf0pFwjKi/+Qn4MYywlaOHiurLSWswlyz/3TzLEwd
         f9rZ1UjArmacYWpTDfIQb3iMhrEOnyWk8QagzsXegmDzYKn7j2tqXYcX/oGB1ZJ+WPnp
         V1CQ==
X-Gm-Message-State: AOAM532cJQswEDOefNA8SMOq7qTDKwtCrDON/juSPtt4exGVneO2S3iG
        3VGyGH0Umw740mkS4jqOaNoCfA==
X-Google-Smtp-Source: ABdhPJxHqGG5uVa6peGzKP9j9aIy5j3Okpl/7+N6i/8RUzX2jx1jDDBoDhwrbHIhuMk49gm26vKjEw==
X-Received: by 2002:a17:906:580a:: with SMTP id m10mr6157826ejq.213.1638952405323;
        Wed, 08 Dec 2021 00:33:25 -0800 (PST)
Received: from localhost ([104.245.96.202])
        by smtp.gmail.com with ESMTPSA id f17sm1493865edq.39.2021.12.08.00.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 00:33:24 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Balbir Singh <bsingharora@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, codalist@coda.cs.cmu.edu,
        linux-audit@redhat.com
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 0/7] pid: Introduce helper task_is_in_root_ns()
Date:   Wed,  8 Dec 2021 16:33:13 +0800
Message-Id: <20211208083320.472503-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel uses open code to check if a process is in root PID namespace
or not in several places.

Suggested by Suzuki, this patch set is to create a helper function
task_is_in_init_pid_ns() to replace open code.

This patch set has been applied on the mainline kernel and built for
Arm64 kernel with enabling all relevant modules.

Changes from v1:
* Renamed helper function from task_is_in_root_ns() to
  task_is_in_init_pid_ns(). (Leon Romanovsky)
* Improved patches' commit logs for more neat.


Leo Yan (7):
  pid: Introduce helper task_is_in_init_pid_ns()
  coresight: etm3x: Use task_is_in_init_pid_ns()
  coresight: etm4x: Use task_is_in_init_pid_ns()
  connector/cn_proc: Use task_is_in_init_pid_ns()
  coda: Use task_is_in_init_pid_ns()
  audit: Use task_is_in_init_pid_ns()
  taskstats: Use task_is_in_init_pid_ns()

 drivers/connector/cn_proc.c                         | 2 +-
 drivers/hwtracing/coresight/coresight-etm3x-sysfs.c | 8 ++++----
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 8 ++++----
 fs/coda/inode.c                                     | 2 +-
 fs/coda/psdev.c                                     | 2 +-
 include/linux/pid_namespace.h                       | 5 +++++
 kernel/audit.c                                      | 2 +-
 kernel/taskstats.c                                  | 2 +-
 8 files changed, 18 insertions(+), 13 deletions(-)

-- 
2.25.1

