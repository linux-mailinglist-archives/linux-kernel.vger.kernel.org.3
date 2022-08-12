Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C834C5914B3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 19:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239299AbiHLRPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 13:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbiHLRPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 13:15:34 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7F76A4B6;
        Fri, 12 Aug 2022 10:15:32 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id C74905FD07;
        Fri, 12 Aug 2022 20:15:30 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660324530;
        bh=eWXwqhgdPV1eTqKNnJQ+Ha5K6D1MKORyyBt4mURjNrM=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=HxwwIYCzaqSnF3otq8qXX6bd095sQtfpl9hVBF0XApCRm/XHNyHePuYll5ruLa57t
         dvhJY/Zfwx4Ag3PPbJ6oQv3vPHn20M9IYXoKCx7JYTVo5MTurpV0qKtjHC0geMq7xC
         Br2ETjqfXVzs2tnyHBUXlhaP76sxz+Eh/zPa2LqOJO86MXiMfP8r5Z6sGYArd3cwSF
         AkpcH7qZ0sItcBiza1/VgfBzotanjjUKIFUbA3fDDn/IEyPHoGqjKdO5RBSWZP5SLv
         0kQFjF6rBRB3L3RT457bTBkJmVLSupCveJ+krDDjms8ZDl29EU0Qsj2XBwK0xe9u5/
         aElLADejzqOzw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Fri, 12 Aug 2022 20:15:30 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        kernel <kernel@sberdevices.ru>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/7] lib/string_helpers: Add str_read_write() helper
Thread-Topic: [PATCH v5 1/7] lib/string_helpers: Add str_read_write() helper
Thread-Index: AQHYrmvlXLMGJM4ctk2gw8SerH637a2rTxcA
Date:   Fri, 12 Aug 2022 17:15:00 +0000
Message-ID: <20220812171526.anjszroov76z4hrt@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220812165243.22177-1-ddrokosov@sberdevices.ru>
 <20220812165243.22177-2-ddrokosov@sberdevices.ru>
In-Reply-To: <20220812165243.22177-2-ddrokosov@sberdevices.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CD67D4ABED2DDE43A341CCD57C13E484@sberdevices.ru>
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

Hello Andy,

Please be informed, I've patched commit msg a little bit, replaced
'retun' misstyping to 'return'.

On Fri, Aug 12, 2022 at 04:52:25PM +0000, Dmitry Rokosov wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> Add str_read_write() helper to return 'read' or 'write' string literal.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  include/linux/string_helpers.h | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/include/linux/string_helpers.h b/include/linux/string_helper=
s.h
> index 4d72258d42fd..9e22cd78f3b8 100644
> --- a/include/linux/string_helpers.h
> +++ b/include/linux/string_helpers.h
> @@ -126,4 +126,9 @@ static inline const char *str_enabled_disabled(bool v=
)
>  	return v ? "enabled" : "disabled";
>  }
> =20
> +static inline const char *str_read_write(bool v)
> +{
> +	return v ? "read" : "write";
> +}
> +
>  #endif
> --=20
> 2.36.0

--=20
Thank you,
Dmitry=
