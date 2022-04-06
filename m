Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3454F6AF8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbiDFUOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbiDFUNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:13:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDB52EC506;
        Wed,  6 Apr 2022 10:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F67DB824DF;
        Wed,  6 Apr 2022 17:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18936C385A3;
        Wed,  6 Apr 2022 17:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649266214;
        bh=7lnEc/dVbTGKJwcO+vpl8TJuBka5jKqU+BsGyNZKjcQ=;
        h=From:To:Cc:Subject:Date:From;
        b=AvWc6IzVyufeZxhslT9jaoj3tbw7OzPJAdI8asHAw+4zMLK7sXziQSy6RG1qKY6Te
         GWZf5PjXZt4aUBkYWPibMXeNLXr1J/TqzoUoYBEA9G7CCqVmIG7Th6wugd5H58yAPh
         SRO++MeGBOKkFxD9KpahDomQgA7xuN65YohsMMKPPzt2G9GHROPO4NSMbJQaNSOtHs
         i+gOtIvzDu1RHXg71a5Yem0sCysOv0QBTfdfEd0sh1Mv/IMf1Vz/XgfM4yLKlljDBs
         mSBr41cY8Zq4JMNztD/9bYsjbdivEkZjsc2H1p4PAS7ixEl4nPIV0gi3dNTDddDSSX
         IIN3ZMj4EKdAQ==
Received: by wens.tw (Postfix, from userid 1000)
        id 3FD635FC39; Thu,  7 Apr 2022 01:30:11 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] drm/ssd130x: Add support for SINO WEALTH SH1106
Date:   Thu,  7 Apr 2022 01:29:52 +0800
Message-Id: <20220406172956.3953-1-wens@kernel.org>
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

Changes since v1:

- Fixed ordering of SINO WEALTH in vendor prefix list

- Updated allOf:if: blocks in DT binding, i.e. added default values for
  solomon,dclk-{div,frq}

- Added SSD130X_PAGE_COL_START_{HIGH,LOW}_SET and used that to set the
  bitfields for the two commands.
  I didn't feel SSD130X_PAGE_COL_START_{HIGH,LOW}_MASK was needed, as
  it was the same between both commands.

- Added SH110x to the SSD130X Kconfig help texts
  There are SH110[789] as well, but they don't seem to be easy to find.


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
  drm/ssd130x: Support page addressing mode
  drm/ssd130x: Add support for SINO WEALTH SH1106

 .../bindings/display/solomon,ssd1307fb.yaml   | 13 ++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 drivers/gpu/drm/solomon/Kconfig               |  9 ++-
 drivers/gpu/drm/solomon/ssd130x-i2c.c         | 11 +++
 drivers/gpu/drm/solomon/ssd130x.c             | 73 +++++++++++++++++--
 drivers/gpu/drm/solomon/ssd130x.h             |  2 +
 6 files changed, 99 insertions(+), 11 deletions(-)

-- 
2.34.1

