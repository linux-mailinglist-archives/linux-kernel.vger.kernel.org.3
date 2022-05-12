Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577B95247F3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351521AbiELIg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351506AbiELIgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:36:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0AF26131
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:36:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEEC4B8271A
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3B3C385B8;
        Thu, 12 May 2022 08:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652344609;
        bh=3e5g6lhyha4VVxzhEZrSIdhjvbVTgz6Wec7JaF8MggI=;
        h=From:To:Cc:Subject:Date:From;
        b=fzxUcUT+iAN8VGvPA3YzzKI7NdkBfHJyPG2hgMqLywMtAeNASINqC+GbVP+Oosgnv
         n2IgFyK8BQo4efm45Oa2u1gdxrtxgiD8pKjn7ggbqqF27DD5FqH9yS2JssT8vBTYMS
         LguibDQrrEh1epPN65IA3niSh3P7ar4PomTuxjaubKoRLmJ8QmQ6y8lgD8xpVF0kFZ
         TjpAr6c1oSTsddOS8GSRTyYkQsUf13WnG0OwErPxAXs0f6GaxKl/AQ2jROpKVFZvcC
         DNi9Qmh/35lpa6H83U93JGDdNKpDwt4ST3vmTFFVbdpUCIlhsUG/I46r2dJSFDYfP+
         hIpABfuP1JhyQ==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] platform/chrome: get rid of BUG_ON()
Date:   Thu, 12 May 2022 16:36:21 +0800
Message-Id: <20220512083627.885338-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series gets rid of BUG_ON()s in drivers/platform/chrome/.  Most of them
can be replaced by returning proper return code.

The 2nd patch makes callers of cros_ec_prepare_tx() to take care of the
return code.

The 3rd patch turns cros_ec_prepare_tx() to return error code if any.

Tzung-Bi Shih (6):
  platform/chrome: cros_ec_proto: drop unneeded BUG_ON() in
    prepare_packet()
  platform/chrome: correct cros_ec_prepare_tx() usage
  platform/chrome: cros_ec_proto: drop BUG_ON() in cros_ec_prepare_tx()
  platform/chrome: cros_ec_proto: drop BUG_ON() in
    cros_ec_get_host_event()
  platform/chrome: cros_ec_i2c: drop BUG_ON() in cros_ec_pkt_xfer_i2c()
  platform/chrome: cros_ec_spi: drop BUG_ON()

 drivers/platform/chrome/cros_ec_i2c.c   | 12 ++++++++++--
 drivers/platform/chrome/cros_ec_ishtp.c |  4 +++-
 drivers/platform/chrome/cros_ec_lpc.c   |  2 ++
 drivers/platform/chrome/cros_ec_proto.c | 13 ++++++++-----
 drivers/platform/chrome/cros_ec_rpmsg.c |  2 ++
 drivers/platform/chrome/cros_ec_spi.c   | 19 ++++++++++++++-----
 6 files changed, 39 insertions(+), 13 deletions(-)

-- 
2.36.0.512.ge40c2bad7a-goog

