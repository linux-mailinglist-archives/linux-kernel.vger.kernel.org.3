Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5815A4B2B91
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352095AbiBKRSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:18:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351982AbiBKRRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:17:53 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE599E;
        Fri, 11 Feb 2022 09:17:52 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4JwL0Z5XmDz9sWD;
        Fri, 11 Feb 2022 18:17:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1644599868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LFoHLbmYGw3RaD5AbKaJjy1KlhBpBhcXgZkvbLLIeM4=;
        b=0MiPVWZ1MPiI/rXvejS5+c8PXCl+pBEAq6CIYazTMrb/cS2587T8Oc/xP7MUfIRJzwOBl1
        Hcdg8qWrhHgTgx+yXRlcyNkpFMpiwFYmTy91QkoqPjaNBenPrZz2PGl0zERa2F2gb8Ef6l
        0yVIo3YFRU8Cn8mWxC0cm2O2qYTly1OkQpyVK1+WZKhAYAiPjUPskJEgmBp74DQfW7NzcJ
        18RWlnfDBaxIb48B5pPFRdjrIPtSgoV0JejI92z1LNG9mLEXKP0LW2wS+R+iyvu2sxdwvB
        wG6/fOIJL3qthk++fNpPbQAFbMhFhfz+6/IIvbY+ei7koayFa3SmZ5zG1XsnSw==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     linux-hwmon@vger.kernel.org
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] Support pli1209bc Digital Supervisor
Date:   Fri, 11 Feb 2022 18:17:09 +0100
Message-Id: <cover.1644597670.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch set adds support for PLI1209BC Digital Supervisor from Vicor
Corporation. It replaces the previous submitted driver "bcm6123" [1],
since there are multiple digital supervisors, which uses BCMs in different
configurations [2].

[1]: https://www.spinics.net/lists/linux-hwmon/msg14097.html
[2]: https://www.spinics.net/lists/linux-hwmon/msg14123.html

Marcello Sylvester Bauer (4):
  dt-bindings: vendor-prefixes: add Vicor Corporation
  dt-bindings:trivial-devices: Add pli1209bc
  pmbus: Add support for pli1209bc
  pmbus (pli1209bc): Add regulator support

 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 Documentation/hwmon/pli1209bc.rst             |  73 ++++++++++
 drivers/hwmon/pmbus/Kconfig                   |  17 +++
 drivers/hwmon/pmbus/Makefile                  |   1 +
 drivers/hwmon/pmbus/pli1209bc.c               | 137 ++++++++++++++++++
 6 files changed, 232 insertions(+)
 create mode 100644 Documentation/hwmon/pli1209bc.rst
 create mode 100644 drivers/hwmon/pmbus/pli1209bc.c

-- 
2.34.1

