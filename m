Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A865542EBD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 13:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237775AbiFHLH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 07:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237205AbiFHLHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 07:07:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E3E197621
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 04:07:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5358FB826EE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 11:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B14C3411C;
        Wed,  8 Jun 2022 11:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654686468;
        bh=Y2zEIvkumbtfbZTzLHB/1UeYKWBKqqO+FvV51b/QS4Q=;
        h=From:To:Cc:Subject:Date:From;
        b=Q93ItgVV7UeEimtM8LBxDebYZ3C0FZ5gP7ZoLK/rUwN5fjXlJIFI00YFmiL5TfhTU
         G4O6owHpiXVtQWo4j20Fn1woa+Fqrma3MdNzFWWyN4TLLiXVj1LR3xdoTQjd3RpjYu
         IRgQgjTUYYXhXIru4YZROMPOQ+9lKYBf8VCtG99rTgzYSvum+SjgR6yJhrPyD6wovj
         xYfZfXI7cXSfKNgHi9kRZyIXVRsjFcn3Apiact87Rz5s8bX+Sg2WZd8e+2zTA839Av
         DodfW/mWPa9lw2KSKv4Svwr/o81OG0ld5YA364i07MIBUqFXDUR0+iDieEI8FBbN12
         Tk+9CNQUmmPZA==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/23] platform/chrome: Kunit tests and refactor for cros_ec_query_all()
Date:   Wed,  8 Jun 2022 11:07:11 +0000
Message-Id: <20220608110734.2928245-1-tzungbi@kernel.org>
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

Tzung-Bi Shih (23):
  platform/chrome: cros_ec_commands: fix compile errors
-> Fixes compile errors when including cros_ec_commands.h.

  platform/chrome: cros_ec_proto: add Kunit tests for
    cros_ec_query_all()
-> Adds Kunit tests for cros_ec_query_all().  They are baseline tests
   for the following refactor patches.  They are designed to pass current
   code.

  platform/chrome: use macros for passthru indexes
  platform/chrome: cros_ec_proto: assign buffer size from protocol info
-> Refactors.

  platform/chrome: cros_ec_proto: remove redundant NULL check
-> Clean up.

  platform/chrome: cros_ec_proto: use cros_ec_map_error()
-> Changes the internal return code.

  platform/chrome: cros_ec_proto: separate cros_ec_get_proto_info()
-> Move refactor.

  platform/chrome: cros_ec_proto: add Kunit tests for getting proto info
  platform/chrome: cros_ec_proto: handle empty payload in getting proto
    info
-> Test and handle if send_command() returns 0 in cros_ec_get_proto_info().

  platform/chrome: cros_ec_proto: separate
    cros_ec_get_proto_info_legacy()
-> Move refactor.

  platform/chrome: cros_ec_proto: add Kunit test for getting legacy info
  platform/chrome: cros_ec_proto: handle empty payload in getting info
    legacy
-> Test and handle if send_command() returns 0 in
   cros_ec_get_proto_info_legacy().

  platform/chrome: cros_ec: don't allocate `din` and `dout` in
    cros_ec_register()
-> Clean up.

  platform/chrome: don't use devm variants for `din` and `dout`
-> Replace devm variants to non-devm.

  platform/chrome: cros_ec_proto: don't show MKBP version if unsupported
-> Minor fix up.

  platform/chrome: cros_ec_proto: return 0 on getting cmd mask success
-> Conform to kernel convention: return 0 on success;
   otherwise, negative integers.

  platform/chrome: cros_ec_proto: add Kunit test for getting cmd mask
    error
  platform/chrome: cros_ec_proto: check `msg->result` in getting cmd
    mask
-> Test and handle if `msg->result` isn't EC_RES_SUCCESS in
   cros_ec_get_host_command_version_mask().

  platform/chrome: cros_ec_proto: add Kunit tests for getting cmd mask
  platform/chrome: cros_ec_proto: handle empty payload in getting cmd
    mask
-> Test and handle if send_command() returns 0 in
   cros_ec_get_host_command_version_mask().

  platform/chrome: cros_ec_proto: return 0 on getting wake mask success
-> Conform to kernel convention: return 0 on success;
   otherwise, negative integers.

  platform/chrome: cros_ec_proto: add Kunit test for getting wake mask
  platform/chrome: cros_ec_proto: handle empty payload in getting wake
    mask
-> Test and handle if send_command() returns 0 in
   cros_ec_get_host_event_wake_mask().

 drivers/platform/chrome/Kconfig               |    6 +
 drivers/platform/chrome/Makefile              |    1 +
 drivers/platform/chrome/cros_ec.c             |   17 +-
 drivers/platform/chrome/cros_ec_proto.c       |  320 ++--
 drivers/platform/chrome/cros_ec_proto_test.c  | 1402 +++++++++++++++++
 drivers/platform/chrome/cros_ec_trace.h       |    8 +-
 drivers/platform/chrome/cros_kunit_util.c     |   98 ++
 drivers/platform/chrome/cros_kunit_util.h     |   36 +
 .../linux/platform_data/cros_ec_commands.h    |    4 +-
 include/linux/platform_data/cros_ec_proto.h   |    3 +
 10 files changed, 1717 insertions(+), 178 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_kunit_util.c
 create mode 100644 drivers/platform/chrome/cros_kunit_util.h

Changes from v2:
(https://patchwork.kernel.org/project/chrome-platform/cover/20220607145639.2362750-1-tzungbi@kernel.org/)
- Split patches into smaller pieces.

Changes from v1:
(https://patchwork.kernel.org/project/chrome-platform/cover/20220606141051.285823-1-tzungbi@kernel.org/)
- Fix review comments.
- Split and reorder patches.

base-commit: 4319cbd4ed99003e0c981728ab1626c25be7af4a
-- 
2.36.1.255.ge46751e96f-goog

