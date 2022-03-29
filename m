Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D861E4EAA3D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 11:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbiC2JNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 05:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbiC2JNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 05:13:18 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0039A9AB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 02:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=b3Yrb0NuzwsS2/56fyOFME8dNLT
        D46th/ew7CyWBPdo=; b=T5K59klaYVviJYxX6pcJbDLJorzxh8igbwgjSS9rGtt
        E1bSMfP6X3cBnH3KSfiiyDi6Oq7yx4zpdBKy5KQM+Ohcm4A5NRlTtXJIyqf9Onw+
        SZ01N09u80r4gP1gLnJqQFaDW0iD5PWWLLVXsXeBZO2apKX3nFG3uuEXTnTGLVlQ
        =
Received: (qmail 1716952 invoked from network); 29 Mar 2022 11:11:31 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Mar 2022 11:11:31 +0200
X-UD-Smtp-Session: l3s3148p1@VBqS0FfbHKggAQnoAFHmAKNSQL+AeJes
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v8 0/1] gpio: add simple logic analyzer using polling
Date:   Tue, 29 Mar 2022 11:11:25 +0200
Message-Id: <20220329091126.4730-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
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

Here is the next version of the sloppy GPIO logic analyzer. Changes
since last version:

* white space fix found by Andy, thanks!
* rebased to v5.17

For those new to this sloppy GPIO logic analyzer, here is a small
excerpt from a previous cover-letter with the links updated:

===

Here is the next update of the in-kernel logic analyzer based on GPIO
polling with local irqs disabled. It has been tested locally and
remotely. It provided satisfactory results. Besides the driver, there is
also a script which isolates a CPU to achieve the best possible result.
I am aware of the latency limitations. However, the intention is for
debugging only, not mass production. Especially for remote debugging and
to get a first impression, this has already been useful. Documentation
is within the patch, to get a better idea what this is all about.

A branch is here:
git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/gpio-logic-analyzer-v8

And an eLinux-wiki page with a picture of a result is here:
https://elinux.org/Kernel_GPIO_Logic_analyzer

I've used the analyzer in a few more scenarios and on multiple SoCs
(Renesas R-Car H3 and M3-W) and was happy with the outcome. Looking
forward to other tests and comments. From my side this is good to go.

===

Thanks and happy hacking,

   Wolfram


Wolfram Sang (1):
  gpio: add sloppy logic analyzer using polling

 .../dev-tools/gpio-sloppy-logic-analyzer.rst  |  91 +++++
 Documentation/dev-tools/index.rst             |   1 +
 drivers/gpio/Kconfig                          |  17 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-sloppy-logic-analyzer.c     | 340 ++++++++++++++++++
 tools/gpio/gpio-sloppy-logic-analyzer         | 230 ++++++++++++
 6 files changed, 680 insertions(+)
 create mode 100644 Documentation/dev-tools/gpio-sloppy-logic-analyzer.rst
 create mode 100644 drivers/gpio/gpio-sloppy-logic-analyzer.c
 create mode 100755 tools/gpio/gpio-sloppy-logic-analyzer

-- 
2.30.2

