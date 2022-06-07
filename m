Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD94C5401D6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343617AbiFGO5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbiFGO4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:56:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074278CB1F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:56:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B546AB81FD1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8538AC385A5;
        Tue,  7 Jun 2022 14:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654613811;
        bh=voJ087E4pzciYU59HXk4T750efYW5DhTxnWtymSQi5M=;
        h=From:To:Cc:Subject:Date:From;
        b=jrarLnHavLeZaHIol8Z6pBwtP+0ngdIfunll6hgNd71e1p7LwBimWVVe+ABFhyltI
         m3yvd+O+B21bvorfGrFWqPZn7LQLU8u9ooTgZepMJM+WLkIM3fonciZZeC5OR4jVJK
         z/kOgGcbVzkRIt1/cSrzAL2JG3q/73/YxxsOtVDs08Jmbe4Le1WyImHihw0FPX4MFL
         GslxoBQWuZSgGkxQt4roJ2mxOAikO5nWHx6bmfEvj+S5eaom8vaZJvCDjjZziH/rXA
         EkZ6Qi7Jgl6J2RGW5KBIe1mPZkj4vxOdDP3HsB4IGjV/ER4q3DI+TfuuhDcg4UxVdX
         EAsbaNmEts38Q==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        tzungbi@kernel.org
Subject: [PATCH v2 00/15] platform/chrome: Kunit tests and refactor for cros_ec_query_all()
Date:   Tue,  7 Jun 2022 14:56:24 +0000
Message-Id: <20220607145639.2362750-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series adds Kunit tests, refactors, and clean-ups for cros_ec_query_all().

Tzung-Bi Shih (15):
  platform/chrome: cros_ec_commands: fix compile errors
-> Fixes compile errors when including cros_ec_commands.h.

  platform/chrome: cros_ec_proto: add Kunit tests for
    cros_ec_query_all()
-> Adds Kunit tests for cros_ec_query_all().  They are baseline tests
   for the following refactor patches.

  platform/chrome: use macros for passthru indexes
  platform/chrome: cros_ec_proto: assign buffer size from protocol info
-> Refactors.

  platform/chrome: cros_ec_proto: remove redundant NULL check
-> Clean up.

  platform/chrome: cros_ec_proto: use cros_ec_map_error()
-> Changes the internal return code.

  platform/chrome: cros_ec_proto: separate cros_ec_get_proto_info()
  platform/chrome: cros_ec_proto: handle empty payload in getting proto
    info
  platform/chrome: cros_ec_proto: separate
    cros_ec_get_proto_info_legacy()
  platform/chrome: cros_ec_proto: handle empty payload in getting info
    legacy
-> Check if send_command() returns negative integer.
   Call cros_ec_map_error() to see if msg->result isn't EC_RES_SUCCESS.
   Report -EPROTO if send_command() returns 0.

  platform/chrome: cros_ec: don't allocate `din` and `dout` in
    cros_ec_register()
-> Clean up.

  platform/chrome: use krealloc() for `din` and `dout`
-> Replace devm variant to non-devm.

  platform/chrome: cros_ec_proto: don't show MKBP version if unsupported
-> Minor fix up.

  platform/chrome: cros_ec_proto: return 0 on getting version mask
    success
  platform/chrome: cros_ec_proto: return 0 on getting wake mask success
-> Conform to kernel convention: return 0 on success;
   otherwise, negative integers.

 drivers/platform/chrome/Kconfig               |    6 +
 drivers/platform/chrome/Makefile              |    1 +
 drivers/platform/chrome/cros_ec.c             |   17 +-
 drivers/platform/chrome/cros_ec_proto.c       |  318 ++--
 drivers/platform/chrome/cros_ec_proto_test.c  | 1400 +++++++++++++++++
 drivers/platform/chrome/cros_ec_trace.h       |    8 +-
 drivers/platform/chrome/cros_kunit_util.c     |   98 ++
 drivers/platform/chrome/cros_kunit_util.h     |   36 +
 .../linux/platform_data/cros_ec_commands.h    |    4 +-
 include/linux/platform_data/cros_ec_proto.h   |    3 +
 10 files changed, 1713 insertions(+), 178 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_kunit_util.c
 create mode 100644 drivers/platform/chrome/cros_kunit_util.h

Changes from v1:
(https://patchwork.kernel.org/project/chrome-platform/cover/20220606141051.285823-1-tzungbi@kernel.org/)
- Fix review comments.
- Split and reorder patches.

-- 
2.36.1.255.ge46751e96f-goog

