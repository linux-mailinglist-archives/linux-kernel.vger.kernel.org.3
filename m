Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6ADE47A0A8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 14:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbhLSNYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 08:24:51 -0500
Received: from www.zeus03.de ([194.117.254.33]:35758 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233186AbhLSNYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 08:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=6S9HQBL4r3odhkkECEIs/X8yzGW
        X/KwaJV8Lve5KOFQ=; b=uSuPoT3dsjVyTzBWayEvF5QiHhgLqR9AwWu9wF5kqRJ
        x/1E00VzMmJ0g364EDMKTRFOjeL4g+hRsCFYw6VtJANSAa2w7O3G5ONC6Z/4ipqw
        o1T4PwDBW0GOXWIUiLkT8rvtELjbwewnIvmqz3I4M/PtPuH+4JWgdRm+uokIt62I
        =
Received: (qmail 612090 invoked from network); 19 Dec 2021 14:24:48 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Dec 2021 14:24:48 +0100
X-UD-Smtp-Session: l3s3148p1@F9s4sn/T9sUgAQnoAHzOAHbG3MPk/2E5
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-gpio@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v6 0/1] gpio: add simple logic analyzer using polling
Date:   Sun, 19 Dec 2021 14:24:41 +0100
Message-Id: <20211219132442.4080-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll start with the changes since v5, they are rather minimal:

* added introductory paragraph to RST docs
  (mostly provided by Linus Walleij, thanks!)
* fixed sorting order in Makefile
  (thanks Geert!)
* improved label name and errno, white space fixes to the script
  (thanks Andy!)

I'd really like to see this in 5.17. Given the review comments of the
last two iterations, I'd think they could have been fixed incrementally
as well. So, if no major issue comes up now, I hope we can merge this
for next cycle. I will stil be around for incremental updates and
bugfixes, of course. For completeness, here is the cover letter from the
last version, it still applies. git branch name is updated, of course.

===

The bravery continues with the next update of the in-kernel logic
analyzer based on GPIO polling with local irqs disabled. It has been
tested locally and remotely. It provided satisfactory results. Besides
the driver, there is also a script which isolates a CPU to achieve the
best possible result. I am aware of the latency limitations. However,
the intention is for debugging only, not mass production. Especially for
remote debugging and to get a first impression, this has already been
useful. Documentation is within the patch, to get a better idea what
this is all about.

A branch is here:
git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/gpio-logic-analyzer-v6

And an eLinux-wiki page with a picture of a result is here:
https://elinux.org/Kernel_GPIO_Logic_analyzer

I've used the analyzer in a few more scenarios and on another SoC
(Renesas R-Car M3-W) and was happy with the outcome. Looking forward to
other tests and comments. From my side this is good to go.

===

Happy hacking,

   Wolfram


Wolfram Sang (1):
  gpio: add sloppy logic analyzer using polling

 .../dev-tools/gpio-sloppy-logic-analyzer.rst  |  86 +++++
 Documentation/dev-tools/index.rst             |   1 +
 drivers/gpio/Kconfig                          |  17 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-sloppy-logic-analyzer.c     | 340 ++++++++++++++++++
 tools/gpio/gpio-sloppy-logic-analyzer         | 221 ++++++++++++
 6 files changed, 666 insertions(+)
 create mode 100644 Documentation/dev-tools/gpio-sloppy-logic-analyzer.rst
 create mode 100644 drivers/gpio/gpio-sloppy-logic-analyzer.c
 create mode 100755 tools/gpio/gpio-sloppy-logic-analyzer

-- 
2.30.2

