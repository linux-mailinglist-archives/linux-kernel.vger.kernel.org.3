Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48AC591446
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbiHLQxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239118AbiHLQxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:53:05 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E8AACA05;
        Fri, 12 Aug 2022 09:52:58 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 839F05FD08;
        Fri, 12 Aug 2022 19:52:55 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660323175;
        bh=kNxXhkdr74OhUzWIPaRNsxTjWoPYvj2BCzIs18HaIVo=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=DEuwsuKrK0IUE/fmPNRTH7bHheRw7wS1s8L53Sl+UjpBa6xdpAZDmjbGMxb036Bdg
         6B+OkILYFXRLmIUsWzdAjaZvEaH2ml6PrpeMLzix2uxqipqsHh7rTYiQdJjK2LvQvl
         /4wicZ3i/UGvJQEPLJ5c1CN268hOkIuHzy9N+vVueef4hFb0oVnyE6Latp82+nXWaC
         +qzwpgKE4n++0A3IP4zaSbyjv0pefOO0x6Kb8Q8IYRJ6Oniy9lMaXPluDjvZeu0m9/
         Zq4xhUnuB79fGjCUsGffGWayE9lQC8U/HqgFu9PMAv7yNMFfU99YXvBnG0tNmndf+J
         37/2h7PcJNwtw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Fri, 12 Aug 2022 19:52:55 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "wsa@kernel.org" <wsa@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "jbhayana@google.com" <jbhayana@google.com>,
        "lucas.demarchi@intel.com" <lucas.demarchi@intel.com>,
        "jani.nikula@intel.com" <jani.nikula@intel.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>
Subject: [PATCH v5 1/7] lib/string_helpers: Add str_read_write() helper
Thread-Topic: [PATCH v5 1/7] lib/string_helpers: Add str_read_write() helper
Thread-Index: AQHYrmvlXLMGJM4ctk2gw8SerH637Q==
Date:   Fri, 12 Aug 2022 16:52:25 +0000
Message-ID: <20220812165243.22177-2-ddrokosov@sberdevices.ru>
References: <20220812165243.22177-1-ddrokosov@sberdevices.ru>
In-Reply-To: <20220812165243.22177-1-ddrokosov@sberdevices.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/12 13:28:00 #20103614
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Add str_read_write() helper to return 'read' or 'write' string literal.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 include/linux/string_helpers.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.=
h
index 4d72258d42fd..9e22cd78f3b8 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -126,4 +126,9 @@ static inline const char *str_enabled_disabled(bool v)
 	return v ? "enabled" : "disabled";
 }
=20
+static inline const char *str_read_write(bool v)
+{
+	return v ? "read" : "write";
+}
+
 #endif
--=20
2.36.0
