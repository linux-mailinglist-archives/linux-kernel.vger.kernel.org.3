Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F2E53E7BF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239601AbiFFOL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239525AbiFFOL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:11:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C333899
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:11:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73FA76136A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 14:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05180C385A9;
        Mon,  6 Jun 2022 14:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654524715;
        bh=/AjJKSJMQW1agM11b8sXBOr3eb89Qd3sPF68DdJxlkk=;
        h=From:To:Cc:Subject:Date:From;
        b=qPoiifOmtGuPDr2CKbvgKSKxA7eCL/+tnh5UO6wHNzvVB4SPbPmfgLIxJIzNJ6AMM
         LSthrjIPExfn2GQ7za/RyT9MHN7R7k0NWuT+QI7InEP9RK/JOXwEN1ltt3Oom6TL0v
         A4eb2XJx9ziYdyZmwAWWHKr8Ms3zN9o6rgkqZM+byamYSrbfTCqGo+luRGxIrdO/Sx
         ala7aYh+uSj/frDhnw0Bh3gGBcG6ecYWp5Q25qT4rIZlaQszM9Zv2XaQt/RkPxxLE6
         T5U/8+gEEP1Ypde4WOX+3rOUdp6u3Ds1nCd0yB0pshv83LrEPGfQSV3lnTALFJ55vG
         iWTJ8WKeKUuoQ==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/13] platform/chrome: Kunit tests and refactor for cros_ec_query_all()
Date:   Mon,  6 Jun 2022 14:10:38 +0000
Message-Id: <20220606141051.285823-1-tzungbi@kernel.org>
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

The 1st patch fixes compile errors when including cros_ec_commands.h.

The 2nd patch adds Kunit tests for cros_ec_query_all().  They are baseline
tests for the following refactor patches.

The 6th, 11th, and 13th patches change the behavior a bit internally.

The rest of patches are refactor.

Tzung-Bi Shih (13):
  platform/chrome: cros_ec_commands: fix compile errors
  platform/chrome: cros_ec_proto: add Kunit tests for
    cros_ec_query_all()
  platform/chrome: use macros for passthru indexes
  platform/chrome: cros_ec_proto: assign buffer size from protocol info
  platform/chrome: cros_ec_proto: remove redundant NULL check
  platform/chrome: cros_ec_proto: use cros_ec_map_error()
  platform/chrome: cros_ec_proto: separate fill_protocol_info()
  platform/chrome: cros_ec_proto: separate fill_protocol_info_legacy()
  platform/chrome: cros_ec_proto: use devm_krealloc()
  platform/chrome: cros_ec_proto: arrange
    get_host_command_version_mask()
  platform/chrome: cros_ec_proto: fix get_host_command_version_mask()
    returns
  platform/chrome: cros_ec_proto: arrange get_host_event_wake_mask()
  platform/chrome: cros_ec_proto: fix get_host_event_wake_mask() returns

 drivers/platform/chrome/Kconfig               |   6 +
 drivers/platform/chrome/Makefile              |   1 +
 drivers/platform/chrome/cros_ec.c             |   3 -
 drivers/platform/chrome/cros_ec_proto.c       | 285 +++--
 drivers/platform/chrome/cros_ec_proto_test.c  | 983 ++++++++++++++++++
 drivers/platform/chrome/cros_ec_trace.h       |   8 +-
 drivers/platform/chrome/cros_kunit_util.c     |  98 ++
 drivers/platform/chrome/cros_kunit_util.h     |  36 +
 .../linux/platform_data/cros_ec_commands.h    |   4 +-
 include/linux/platform_data/cros_ec_proto.h   |   3 +
 10 files changed, 1254 insertions(+), 173 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_kunit_util.c
 create mode 100644 drivers/platform/chrome/cros_kunit_util.h


base-commit: 4319cbd4ed99003e0c981728ab1626c25be7af4a
-- 
2.36.1.255.ge46751e96f-goog

