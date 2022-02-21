Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2524BE787
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354760AbiBUKXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:23:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242237AbiBUKW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:22:57 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2094A60052;
        Mon, 21 Feb 2022 01:42:40 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4K2HQl0QQPz9sJ6;
        Mon, 21 Feb 2022 10:42:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1645436556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=O0vim5dUjqbxE12jR8gxo6NSfechSEkOIcqQEt0TBqo=;
        b=LnBXweTsIRrvzQ3Wm779e/V01xHJIN1UepyeKNH/p2MLBfqjz0AoIzQ4e5Ytl9L4oeA/7q
        aAwtzfkBsCthBRAxfWgCQ8QOLarumJXm7QZiGlghqCIi97RduserQ9cnv8Ky0L+fHyJ5UP
        WHp6Ck2O0Io49jTy+RtOgxB6QzQ1B+vilZP0tjnl01kRBMSj8GzAMafaNvVxeDqvuV/CbZ
        Ce2B2UZ5pz1k4V0z7X7RW4h/eu2j/7LxOAxAqjB+9IBk+Dbxsa64q2zq0i4gy3CtSUmjQh
        AKxi0ZnXYa1aiFr+0/jQdSzISa5MUPINIF6zDuZkBrkiP9y6g/yTx4mieam7gg==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
Subject: [PATCH v4 0/4] Support pli1209bc Digital Supervisor
Date:   Mon, 21 Feb 2022 10:42:03 +0100
Message-Id: <cover.1645435888.git.sylv@sylv.io>
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

Change in v4:
- Add Documetation to index.rst
- Add missing license identifier
- Fix typo and Makefile obj order

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
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/pli1209bc.rst             |  75 +++++++++
 drivers/hwmon/pmbus/Kconfig                   |  16 ++
 drivers/hwmon/pmbus/Makefile                  |   1 +
 drivers/hwmon/pmbus/pli1209bc.c               | 146 ++++++++++++++++++
 7 files changed, 243 insertions(+)
 create mode 100644 Documentation/hwmon/pli1209bc.rst
 create mode 100644 drivers/hwmon/pmbus/pli1209bc.c

-- 
2.34.1

