Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9A24B5068
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353382AbiBNMlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:41:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbiBNMld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:41:33 -0500
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEB5B864;
        Mon, 14 Feb 2022 04:41:23 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:105:465:1:4:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Jy3kB0pJgz9sS8;
        Mon, 14 Feb 2022 13:41:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1644842479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qoKWzDcOtobuMVSuCwxsjzVdagEa1CNaMRsJTTX1MhU=;
        b=sdpc0OcrYv60UWTNkK3VRawd7k4XyduYovw2+0vrA5eY7fZO41S4KcuTvYtyqumlk99tNw
        l+JByCSXt+MtswdjUDMepFSBBD6KurpOd82eON4ld/ZTSuQvDnj3Z4yLKf5xW5nfh5gkVo
        0ZYGTQIjelIwDZD7mQFYwKLM/63AePLmtlCZdgJ+IL9DsZWSK24ezuTc9ZQSxxYbCSN6fU
        vPYP/G0o6BRcaa5opT7hV4P9fV5R8zt51+cgm94c3otYSnaKI70OHzyOjoPHFpRokx9El4
        NUh9l/Ejy17aMkN/9bP4V43qs/3tSU/PGViyXEqVKKvUPgAAs/NVzYyjTwL5kQ==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
Subject: [PATCH v2 0/4] Support pli1209bc Digital Supervisor
Date:   Mon, 14 Feb 2022 13:40:31 +0100
Message-Id: <cover.1644834803.git.sylv@sylv.io>
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
 drivers/hwmon/pmbus/pli1209bc.c               | 145 ++++++++++++++++++
 6 files changed, 239 insertions(+)
 create mode 100644 Documentation/hwmon/pli1209bc.rst
 create mode 100644 drivers/hwmon/pmbus/pli1209bc.c

-- 
2.34.1

