Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975455A7AEC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiHaKF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiHaKFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:05:15 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0783B6E8A2;
        Wed, 31 Aug 2022 03:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1661940312;
  x=1693476312;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vUrM9ZM91DzPeAfuKiBbAxb18ShY/Z4MIs2oFy4nP+8=;
  b=YK1+mNlTNzlA013Mfv7+uEcS6hwmhxNkz04Jxm/etwyPgXo76Gxw4kgH
   EAj7iMmXd5+nVsxYcv4+7/tF3UR9o3e4cfrNYI0/qJBE6ubdFmozmGuhq
   VzSEVU5R0eARd7aCrFa0lJkuHlwj2dNgztaMfqjUyOER2SlonqpDeXXCq
   Jv+9+dWQhUPIs6KFZ3WbDUS75b5ppXR6EMoWJgk7Ix5rKD1Y7INu6chDG
   YoPPlSmwIYmMoM4Ru+aRqotpBitdpFRwdrjsjAbBr0BxT3rEYN/LRg2hs
   +e69HlrKmFQDS+pUf6QUlXiknCAVEZ0V7zg7fdDCghfHHysAU3fIbBKnl
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <jic23@kernel.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <andy.shevchenko@gmail.com>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/5] iio: adc: mcp320x: Add triggered buffer support
Date:   Wed, 31 Aug 2022 12:05:01 +0200
Message-ID: <20220831100506.3368103-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series makes some suggested cleanups and then adds triggered buffer
support to the mcp320x ADC driver.

v2:
- Replace device_index rx switch with callbacks in chip_info
- Replace device_index tx switch with computation based
  on number of channels.
- Use conv_time instead of device_index switch when initializing
  conv_msg.
- Keep includes in alphabetical order with iio includes in a separate group
- Replace diff_off with scan_index as parameter to macro
- Remove reformatting of macros which makes the real change hard
  to spot

Cc: andy.shevchenko@gmail.com
Cc: lars@metafoo.de
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Axel Jonsson (1):
  iio: adc: mcp320x: add triggered buffer support

Vincent Whitchurch (4):
  iio: adc: mcp320x: use callbacks for RX conversion
  iio: adc: mcp320x: remove device_index check for TX
  iio: adc: mcp320x: use conv_time instead of device_index switch
  iio: adc: mcp320x: use device managed functions

 drivers/iio/adc/Kconfig   |   2 +
 drivers/iio/adc/mcp320x.c | 297 +++++++++++++++++++++++---------------
 2 files changed, 183 insertions(+), 116 deletions(-)

-- 
2.34.1

