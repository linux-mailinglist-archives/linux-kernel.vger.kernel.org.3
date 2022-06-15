Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A662254C117
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 07:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345832AbiFOFNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 01:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243490AbiFOFNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 01:13:08 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888102657B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 22:13:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6C49ACE1D14
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0205C34115;
        Wed, 15 Jun 2022 05:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655269983;
        bh=49EG9xEaXpkgOIcZrB2XUN9zAkDIcNJTAWZ7hH+D/Zo=;
        h=From:To:Cc:Subject:Date:From;
        b=roEfoD4Bpl/Yv1A+ollNbp2sgyzQoxmZ6cb+yueRVG7ykB+poUeW5cAvYMFG2iP40
         FlUdXD84jhxJ+FZW6gtBjokIDe843f9Evv2vJGskf308HdFit9opYetK7EvPVltPsj
         hcLc0kwsNArCxdJQ/e6EY//dj6xEONtDKFXhIwVwpJagNMN3eNqPqxZpMDAI+9oawh
         XjAtm5SO2B3O2zA3Bl5rTgPKo8jKqIRpKM8gYhCzQJebN2R4J5MNyP1Wnh0eSsJfpL
         JoTg9tPwaJMzGA1xjqzxlpqgkhs1BLOieAZCGeXljDtv+J0MuQzbrGsmK0l9FbEsfx
         ayTEnXpIxBrnQ==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] platform/chrome: Kunit tests and refactor for cros_ec_cmd_xfer()
Date:   Wed, 15 Jun 2022 05:12:37 +0000
Message-Id: <20220615051248.1628156-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
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

The first 5 patches add Kunit tests and refactors for cros_ec_cmd_xfer().

The last 6 patches change the behavior a bit by altering return codes.


Asynchronous mechanism in EC protocol:
EC returns EC_RES_IN_PROGRESS if the host command needs more time to complete.
It saves the result into `saved_result` once the command completed[1].

By design, AP should send another command EC_CMD_RESEND_RESPONSE for getting
the result from the previous pending command[2].  The mechanism was only
designed for commands that don't need responses[3].

However, the kernel code doesn't have such logic when dealing with
EC_RES_IN_PROGRESS.

The series doesn't fix it but leave it as is.  I doubt there is no existing
use case.

[1]: https://crrev.com/9b80051e01872d8cae86fff999b5d31a0bea985b/common/host_command.c#113
[2]: https://crrev.com/9b80051e01872d8cae86fff999b5d31a0bea985b/common/host_command.c#748
[3]: https://crrev.com/9b80051e01872d8cae86fff999b5d31a0bea985b/common/host_command.c#126


Return value overridden in cros_ec_send_command() if asynchronous:
By original intention, cros_ec_send_command() returns number of available
bytes of input payload.

When it falls into asynchronous path (i.e. EC_RES_IN_PROGRESS), both return
value and `msg->result` will be overridden by the subsequent
EC_CMD_GET_COMMS_STATUS.

The series doesn't fix it but leave it as is.

Tzung-Bi Shih (11):
  platform/chrome: cros_ec_proto: add "cros_ec_" prefix to
    send_command()
  platform/chrome: cros_ec_proto: add Kunit tests for cros_ec_cmd_xfer()
  platform/chrome: cros_ec_proto: add Kunit tests for
    cros_ec_send_command()
  platform/chrome: cros_ec_proto: separate cros_ec_xfer_command()
  platform/chrome: cros_ec_proto: separate cros_ec_wait_until_complete()
  platform/chrome: cros_ec_proto: change Kunit expectation when timed
    out
  platform/chrome: cros_ec_proto: return -EAGAIN when retries timed out
  platform/chrome: cros_ec_proto: change Kunit expectation for EC errors
  platform/chrome: cros_ec_proto: return standard error codes for EC
    errors
  platform/chrome: cros_ec_proto: add Kunit test for empty payload
  platform/chrome: cros_ec_proto: return -EPROTO if empty payload

 drivers/platform/chrome/cros_ec_proto.c      | 106 +++--
 drivers/platform/chrome/cros_ec_proto_test.c | 443 +++++++++++++++++++
 drivers/platform/chrome/cros_kunit_util.c    |  20 +
 drivers/platform/chrome/cros_kunit_util.h    |   4 +
 4 files changed, 527 insertions(+), 46 deletions(-)

-- 
2.36.1.476.g0c4daa206d-goog

