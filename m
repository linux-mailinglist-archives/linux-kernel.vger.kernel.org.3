Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BC25962FF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 21:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbiHPTTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 15:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236644AbiHPTTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 15:19:04 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4B35A3CC;
        Tue, 16 Aug 2022 12:18:59 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id D2B455FD0A;
        Tue, 16 Aug 2022 22:18:56 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660677536;
        bh=kNxXhkdr74OhUzWIPaRNsxTjWoPYvj2BCzIs18HaIVo=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=oOhLhAzpunZrgl0lSBeQWQlBFqtLT3ErhWptxDa8qGYuYxFwb7GdxjhK+44j+ZFDN
         v5Al9MmMzo/1zntXe8TMPnXOFaEo4RfMPmLWfvGguqiQjF90VArZ5rJpKWI0bz/+0x
         s0VtOow1USamuflKjsUew5ZdrKlUcZ4kWaCccg1GcvRt+NRtYVpS5bMYZJca+Nx5cC
         WFQzP+8kn22h9rY94phIvdmQhrt1iiJpA70De0PjU8ytaUIxir5KGB18trzsfwDi1l
         yXUH8DCRRHYky3qq8KODm6O7MA/S3tU1OPQoSJtaoDO240SEfZzIUQowPh7Oyj/L6y
         fEGRRa3gjI4vg==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Tue, 16 Aug 2022 22:18:56 +0300 (MSK)
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
Subject: [PATCH v6 1/4] lib/string_helpers: Add str_read_write() helper
Thread-Topic: [PATCH v6 1/4] lib/string_helpers: Add str_read_write() helper
Thread-Index: AQHYsaUAdZHJnw656k6pbt0EDuDqsQ==
Date:   Tue, 16 Aug 2022 19:18:43 +0000
Message-ID: <20220816191842.14020-2-ddrokosov@sberdevices.ru>
References: <20220816191842.14020-1-ddrokosov@sberdevices.ru>
In-Reply-To: <20220816191842.14020-1-ddrokosov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/16 16:01:00 #20126973
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
