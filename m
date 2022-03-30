Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4B54ECD03
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 21:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350681AbiC3TLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 15:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350610AbiC3TKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 15:10:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC5E2F387;
        Wed, 30 Mar 2022 12:09:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8ADA0B81E20;
        Wed, 30 Mar 2022 19:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16870C340EC;
        Wed, 30 Mar 2022 19:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648667345;
        bh=lcGIyaw5NkAgpr0QaCaz8WI5Mz33Xt/psg7AbDL8EG8=;
        h=From:To:Cc:Subject:Date:From;
        b=b2tlqYIyn9YlqauB8Rxm28WhT9le8mqRzBGIJbm0kdnQiM2lRb9trVMCL7iGf0lhq
         Z+S+zd8RmJEys5jYU9QHKjGpSi4IK9bzRc8zRMz4dqaBcxQdmaKww9DIww/qd9QuMg
         kvoY/d2QxLV+h/V1TAZfXbnG/xK11hxfLXdaP8vsPluW5IgJpamwLdAPSy3R2Svq6J
         xgeexh0C4glAYrU/T1oCHjbrSKq8PcyLQJlIe8xvOLx+532csHzoo06REn3BYFktTR
         fNLza88sJrMRwndPtkNCBD86sezGElb7HZdCndS/y9nUQgIl3Mx9AyRTHnCVG16bCk
         JGZo1u0LMi50Q==
Received: by wens.tw (Postfix, from userid 1000)
        id 08E765FD07; Thu, 31 Mar 2022 03:09:01 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] drm: ssd130x: Add support for SINO WEALTH SH1106
Date:   Thu, 31 Mar 2022 03:08:42 +0800
Message-Id: <20220330190846.13997-1-wens@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Hi everyone,

This series adds support for SH1106 to the ssd130x OLED display
driver.

The SINO WEALTH SH1106 is an OLED display driver that is somewhat
compatible with the SSD1306. It supports a slightly wider display,
at 132 instead of 128 pixels. The basic commands are the same, but
the SH1106 doesn't support the horizontal or vertical address modes.

This driver chip is found in some cheap 1.3" OLED panel modules. It
acts as a substitute for the SSD1306.

Patch 1 adds an entry to the vendor prefixes for SINO WEALTH
Eletronics Ltd.

Patch 2 adds an entry for SH1106 to the ssd1307fb binding.

Patch 3 adds support for the base "page addressing mode" to the ssd130x
driver.

Patch 4 adds support for the SH1106 to the ssd130x driver.

Please have a look.


Thanks
ChenYu


Chen-Yu Tsai (4):
  dt-bindings: vendor-prefixes: Add prefix for SINO WEALTH Eletronics
    Ltd.
  dt-bindings: display: ssd1307fb: Add entry for SINO WEALTH SH1106
  drm: ssd130x: Support page addressing mode
  drm: ssd130x: Add support for SINO WEALTH SH1106

 .../bindings/display/solomon,ssd1307fb.yaml   |  1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 drivers/gpu/drm/solomon/ssd130x-i2c.c         | 11 +++
 drivers/gpu/drm/solomon/ssd130x.c             | 72 +++++++++++++++++--
 drivers/gpu/drm/solomon/ssd130x.h             |  2 +
 5 files changed, 81 insertions(+), 7 deletions(-)

-- 
2.34.1

