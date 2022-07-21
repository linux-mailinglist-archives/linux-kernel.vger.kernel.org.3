Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A51D57D3F0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 21:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiGUTQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 15:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbiGUTQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 15:16:07 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEAA87C29;
        Thu, 21 Jul 2022 12:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1658430933; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=t/aA/ADhLOvNZFh4969q9417Wjvts2tDDeNzP6zFyvc=;
        b=qP0EQAqVLlXA087iqzaLNqkpObBwcOcjymmvG9BcDFG1jq4QjSmC4WdYo61poWsTpXmKeP
        OsODCuzYz8m4resONXgYz7nm+lm4Eh4JgbMmy224Z/xcH3mdQx/UbdrtJtvXaSAD2xMSHS
        p1DrIZLQBkDnPkNfbbFa3bwGhSPYCKw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>, Peter Rosin <peda@axentia.se>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, list@opendingux.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/4] iio: afe/rescale improvements
Date:   Thu, 21 Jul 2022 20:15:22 +0100
Message-Id: <20220721191526.374152-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

This patchset adds support for converting the "scale avail" list that
may be provided by the source drivers. It also implements the
.write_raw() callback.

These two features will later be used by the
(drivers/power/supply/ingenic-battery.c) driver, which will pick the
best scale possible for the battery's max voltage (it's already
implemented in there, but doesn't yet support iio-rescale being in the
middle).

As you suggested after my RFC I added support for a new
IIO_AVAIL_LIST_WITH_TYPE and it's been a perfect solution, so thank you
for that.

Cheers,
-Paul

Paul Cercueil (4):
  iio: inkern: Remove useless argument to iio_channel_read_max()
  iio: core: Add support for IIO_AVAIL_LIST_WITH_TYPE
  iio: afe/rescale: Add support for converting scale avail table
  iio: afe/rescale: Implement write_raw

 drivers/iio/afe/iio-rescale.c   | 107 ++++++++++++++++++++++++++++++++
 drivers/iio/industrialio-core.c |  25 ++++++++
 drivers/iio/inkern.c            |  35 +++++++++--
 include/linux/iio/afe/rescale.h |   2 +
 include/linux/iio/consumer.h    |   6 +-
 include/linux/iio/types.h       |   1 +
 6 files changed, 168 insertions(+), 8 deletions(-)

-- 
2.35.1

