Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AA84B5D2A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiBNVpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:45:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiBNVp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:45:29 -0500
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C9018462D;
        Mon, 14 Feb 2022 13:45:19 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4JyHnn48nNz9sPp;
        Mon, 14 Feb 2022 22:45:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1644875115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oRr78yIBPxY77+I5AuoDVOFQS9ad7sIPGYxZpt1x9Ws=;
        b=s4lNrCnZ79xMhCyGsG/v/JFzek6MJhnrRCzr71iFa2YSfHBoOvnlCqFBHuHNFyiAV5Zz+N
        l+Ia+TNt3KObZLrxTmqtqtEa4Ueqn/DslRUXZgYEdBcrHFhK6GkCyP4r4nDWDGSaSpfojH
        a6CWJ+O+Z/hBd1wwfibrF/2e2pLT49iyUpzBJjIC9hrD3PFP1ngW7krrHWkG4gzhEZtEi1
        Ql/1ALNYt5KZtUzbWf/vBtGeWNC2aLChOkc3iq8zHQdk19MELWGGDIkV00P4K6r1nveRbI
        oqEQQOFhCEDVkF8sYskSeML9PgFoi6zsBROKD8gWZnxfiz9tHCJiZmMeYxIj6w==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
Subject: [PATCH v3 0/4] Support pli1209bc Digital Supervisor
Date:   Mon, 14 Feb 2022 22:44:52 +0100
Message-Id: <cover.1644874828.git.sylv@sylv.io>
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

Change in v3:
- prevent potential over- or underflow of PMBUS_READ_POUT

Changes in v2:
- Multiply PMBUS_READ_POUT with 10 (R=1)
  instead of dividing PMBUS_READ_PIN by 10.
- Set all pmbus formats to direct.
- Comment reason why page 0 is redundant.
- Import pmbus namespace.

[1]: https://www.spinics.net/lists/linux-hwmon/msg14097.html
[2]: https://www.spinics.net/lists/linux-hwmon/msg14123.html

Marcello Sylvester Bauer (4):
  dt-bindings: vendor-prefixes: add Vicor Corporation
  dt-bindings:trivial-devices: Add pli1209bc
  pmbus: Add support for pli1209bc
  pmbus (pli1209bc): Add regulator support

 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 Documentation/hwmon/pli1209bc.rst             |  73 +++++++++
 drivers/hwmon/pmbus/Kconfig                   |  16 ++
 drivers/hwmon/pmbus/Makefile                  |   1 +
 drivers/hwmon/pmbus/pli1209bc.c               | 146 ++++++++++++++++++
 6 files changed, 240 insertions(+)
 create mode 100644 Documentation/hwmon/pli1209bc.rst
 create mode 100644 drivers/hwmon/pmbus/pli1209bc.c

-- 
2.34.1

