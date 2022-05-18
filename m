Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430CF52B5C7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbiERJSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbiERJSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:18:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1F21E3C2
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:18:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4497BCE1F4A
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 09:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E842C385AA;
        Wed, 18 May 2022 09:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652865511;
        bh=k+5bOoeP4HkT97sUXYxNDGu/Mgf1f/Xo/QI4gKpyZ8Q=;
        h=From:To:Cc:Subject:Date:From;
        b=LGWlx/5Uae5jMpB1EOF4pSpgE6Fqgc/nCVt+KzblLaxq2Volbi/4UUY/6bvIryHhJ
         R9BZreIFsvvf3qCayzZ+TLESM5NppAVLbkd0dzyaNnQ7X8HnLqtmHYBGJHTYqM7+ej
         S3X+AO0i/z+WqY2y+A3oG/34Zi6ta47AtETFzIwdUG8flmYjX3rBdQ2C477m1v4mXo
         wah9VXooUkD3jqP+q6SxUzPWkQFg98PbtrMED5h89OsT2h5PmON1fqn2ae6Zia/aEF
         a7ek7g7p5OfocUnqwh3EK+6c1qznifhqmPwgVvp2RwhP+2T9unBneyzqoGYWKT2wv0
         jdTgvx89tUIfw==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        tzungbi@kernel.org, dianders@chromium.org
Subject: [PATCH 0/4] platform/chrome: cros_ec_proto: add initial Kunit tests
Date:   Wed, 18 May 2022 17:18:10 +0800
Message-Id: <20220518091814.2028579-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series adds some early Kunit tests for ChromeOS EC protocol.

The 2nd patch is a refactor.

The 3rd patch updates code comment.

The 1st and 4th patches add Kunit tests.

Use the following example commands to run the Kunit tests:
$ ./tools/testing/kunit/kunit.py run \
        --arch=x86_64 \
        --kconfig_add CONFIG_CHROME_PLATFORMS=y \
        --kconfig_add CONFIG_CROS_EC=y \
        cros_ec*
$ ./tools/testing/kunit/kunit.py run \
        --arch=arm64 --cross_compile aarch64-linux-gnu- \
        --kconfig_add CONFIG_CHROME_PLATFORMS=y \
        --kconfig_add CONFIG_CROS_EC=y \
        cros_ec*

Tzung-Bi Shih (4):
  platform/chrome: cros_ec_proto: add Kunit tests for
    cros_ec_prepare_tx()
  platform/chrome: cros_ec_proto: factor legacy out from
    cros_ec_prepare_tx()
  platform/chrome: cros_ec_proto: update cros_ec_check_result() comment
  platform/chrome: cros_ec_proto: add Kunit tests for
    cros_ec_check_result()

 drivers/platform/chrome/Kconfig              |   9 +
 drivers/platform/chrome/Makefile             |   3 +
 drivers/platform/chrome/cros_ec_proto.c      |  58 ++---
 drivers/platform/chrome/cros_ec_proto_test.c | 214 +++++++++++++++++++
 4 files changed, 259 insertions(+), 25 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_ec_proto_test.c


base-commit: a0e7d2f65fa706a106dae4b52a7cfe48e0ddfdff
-- 
2.36.0.550.gb090851708-goog

