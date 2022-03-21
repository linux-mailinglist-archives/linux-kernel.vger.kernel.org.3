Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFA04E2D87
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350884AbiCUQOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348341AbiCUQN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:13:58 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5512D2E08B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=jAxbIQUDN4uvFhBZPHKWfmWfwUw
        ggpRe45TqNvbcPEQ=; b=rIQpjLbMem3sQnGRGTvmlIobA+wYxnhNxICC8qdVl48
        1OgABgj/rtr73schbXCTGOSo7EzgqeNXw9YWwCGis6evu2yEPK4rh+DTwl+hYsaI
        l0/y9Hd6He7sgAWYw4II7oPByOCwLqEOoG9Dgw7tG7EZy8lkm2+yY6K13NO48n80
        =
Received: (qmail 957618 invoked from network); 21 Mar 2022 17:12:27 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Mar 2022 17:12:27 +0100
X-UD-Smtp-Session: l3s3148p1@v0I7w7zaFtkgAwDPXxCoAIeNYiWy88zT
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 00/15] treewide: rename fsleep
Date:   Mon, 21 Mar 2022 17:12:08 +0100
Message-Id: <20220321161223.2837-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently stumbled over the relatively new function fsleep(). While I
think it is usful, I also think the name is too short to be
self-explanatory. This is why I suggest a rename before it gets even
wider use in the kernel, see patch 1.  As you can see from the
statistics below, the churn is still in the acceptable range IMO.

The name 'usleep_autoyield' is the best I could come up with, but if you
can think of something better I am all ears. This is why the series is
still RFC and not sent to subsystem mailing lists. The base is v5.17-rc8
but my plan is to resend it after 5.18-rc1 with all new fsleep-users
fixed as well. And remove the fallback late in the 5.18 cycle. If we can
agree on something that is.

buildbot is happy with the changes. A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/usleep_autoyield

Please let me know what you think!

All the best,

   Wolfram


Wolfram Sang (15):
  delay: rename fsleep to usleep_autoyield
  base: regmap: use new name 'usleep_autoyield' instead of 'fsleep'
  bus: mhi: core: use new name 'usleep_autoyield' instead of 'fsleep'
  iio: adc: use new name 'usleep_autoyield' instead of 'fsleep'
  memory: tegra: use new name 'usleep_autoyield' instead of 'fsleep'
  mfd: use new name 'usleep_autoyield' instead of 'fsleep'
  mux: use new name 'usleep_autoyield' instead of 'fsleep'
  net: ethernet: realtek: use new name 'usleep_autoyield' instead of
    'fsleep'
  net: mdio: use new name 'usleep_autoyield' instead of 'fsleep'
  net: phy: use new name 'usleep_autoyield' instead of 'fsleep'
  net: wireless: realtek: rtw88: use new name 'usleep_autoyield' instead
    of 'fsleep'
  net: wireless: realtek: rtw89: use new name 'usleep_autoyield' instead
    of 'fsleep'
  thermal: tegra: use new name 'usleep_autoyield' instead of 'fsleep'
  usb: chipidea: use new name 'usleep_autoyield' instead of 'fsleep'
  delay: remove the fallback for fsleep

 Documentation/timers/timers-howto.rst             | 2 +-
 drivers/base/regmap/regmap.c                      | 4 ++--
 drivers/bus/mhi/core/main.c                       | 2 +-
 drivers/iio/adc/ti-tsc2046.c                      | 2 +-
 drivers/memory/tegra/tegra20.c                    | 2 +-
 drivers/mfd/acer-ec-a500.c                        | 2 +-
 drivers/mux/core.c                                | 2 +-
 drivers/net/ethernet/realtek/r8169_main.c         | 8 ++++----
 drivers/net/mdio/mdio-ipq4019.c                   | 2 +-
 drivers/net/phy/broadcom.c                        | 2 +-
 drivers/net/phy/mdio_bus.c                        | 4 ++--
 drivers/net/phy/mdio_device.c                     | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c     | 8 ++++----
 drivers/net/wireless/realtek/rtw89/fw.c           | 2 +-
 drivers/net/wireless/realtek/rtw89/mac.c          | 6 +++---
 drivers/net/wireless/realtek/rtw89/pci.c          | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c     | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c | 8 ++++----
 drivers/thermal/tegra/tegra30-tsensor.c           | 2 +-
 drivers/usb/chipidea/ci_hdrc_tegra.c              | 6 +++---
 include/linux/delay.h                             | 2 +-
 21 files changed, 37 insertions(+), 37 deletions(-)

-- 
2.34.1

