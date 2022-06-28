Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BD755D018
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiF1DQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiF1DQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:16:43 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FF418E15
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:16:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VHfG1vv_1656386193;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VHfG1vv_1656386193)
          by smtp.aliyun-inc.com;
          Tue, 28 Jun 2022 11:16:38 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, mark.rutland@arm.com
Cc:     baolin.wang@linux.alibaba.com, yaohongbo@linux.alibaba.com,
        nengchen@linux.alibaba.com, zhuo.song@linux.alibaba.com,
        xueshuai@linux.alibaba.com
Subject: [PATCH v2 0/3] drivers/perf: add DDR Sub-System Driveway PMU driver for Yitian 710 SoC
Date:   Tue, 28 Jun 2022 11:16:27 +0800
Message-Id: <20220628031630.18674-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220617111825.92911-1-xueshuai@linux.alibaba.com>
References: <20220617111825.92911-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: root <root@localhost.localdomain>

This patchset adds support for Yitian 710 DDR Sub-System Driveway PMU driver,
which custom-built by Alibaba Group's chip development business, T-Head.

Changes since v1:
- add high level workflow about DDRC so that user cloud better understand the
  PMU hardware mechanism
- rewrite patch description and add interrupt sharing constraints
- delete event perf prefix
- add a condition to fix bug in ali_drw_pmu_isr
- perfer CPU in the same Node when migrating irq
- use FIELD_PREP and FIELD_GET to make code more readable
- add T-Head HID and leave ARMHD700 as CID for compatibility
- Link: https://lore.kernel.org/linux-arm-kernel/eb50310d-d4a0-c7ff-7f1c-b4ffd919b10c@linux.alibaba.com/T/

Shuai Xue (3):
  docs: perf: Add description for Alibaba's T-Head PMU driver
  drivers/perf: add DDR Sub-System Driveway PMU driver for Yitian 710
    SoC
  MAINTAINERS: add maintainers for Alibaba' T-Head PMU driver

 .../admin-guide/perf/alibaba_pmu.rst          |  97 +++
 Documentation/admin-guide/perf/index.rst      |   1 +
 MAINTAINERS                                   |   8 +
 drivers/perf/Kconfig                          |   8 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/alibaba_uncore_drw_pmu.c         | 793 ++++++++++++++++++
 6 files changed, 908 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/alibaba_pmu.rst
 create mode 100644 drivers/perf/alibaba_uncore_drw_pmu.c

-- 
2.20.1.9.gb50a0d7

