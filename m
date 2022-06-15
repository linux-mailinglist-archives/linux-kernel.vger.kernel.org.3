Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B283754D0A9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 20:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354455AbiFOSHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 14:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346928AbiFOSHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 14:07:02 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC30D50B25;
        Wed, 15 Jun 2022 11:07:00 -0700 (PDT)
Received: from [127.0.0.1] (nyx.walle.cc [158.255.213.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B221F221D4;
        Wed, 15 Jun 2022 20:06:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1655316417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X31Y0rQlpQau1yeSY1ewrfTTggu40SW7YZpoP18Nyc4=;
        b=OYz6MguMMV3tV9zA8VtMkNpupo/XoNdrSezibyu9AwYYzlewf9Hez4YMuVDHDz4Cds2khU
        plTm2VquklTTvnLjD4bam0yzvWGufT3IaxfwAJRrzVOCljFuIYwhYLGBkrw5337vST1zxN
        IRtqmDNFGhS9FxsTaSwFM2BTvxXYEBo=
Date:   Wed, 15 Jun 2022 20:06:49 +0200
From:   Michael Walle <michael@walle.cc>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
CC:     brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com, lars@metafoo.de,
        rafael@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] pinctrl: Add AXP192 pin control driver
User-Agent: K-9 Mail for Android
In-Reply-To: <CACRpkdbObQ5WrzVC_xYobJPSBVSMyaz0HHXesLP+g1HCzCGJtQ@mail.gmail.com>
References: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com> <20220603135714.12007-11-aidanmacdonald.0x0@gmail.com> <CACRpkdbObQ5WrzVC_xYobJPSBVSMyaz0HHXesLP+g1HCzCGJtQ@mail.gmail.com>
Message-ID: <A3444B9B-FDCD-4292-9DE4-D7DBC9DFA597@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 15=2E Juni 2022 15:44:04 OEZ schrieb Linus Walleij <linus=2Ewalleij@lina=
ro=2Eorg>:
>On Fri, Jun 3, 2022 at 3:56 PM Aidan MacDonald
><aidanmacdonald=2E0x0@gmail=2Ecom> wrote:
>
>> The AXP192 PMIC's GPIO registers are much different from the GPIO
>> registers of the AXP20x and AXP813 PMICs supported by the existing
>> pinctrl-axp209 driver=2E It makes more sense to add a new driver for
>> the AXP192, rather than add support in the existing axp20x driver=2E
>>
>> The pinctrl-axp192 driver is considerably more flexible in terms of
>> register layout and should be able to support other X-Powers PMICs=2E
>> Interrupts and pull down resistor configuration are supported too=2E
>>
>> Signed-off-by: Aidan MacDonald <aidanmacdonald=2E0x0@gmail=2Ecom>
>
>Looks good to me (TM) but I'd like Michael Walle to take a look
>to check if this is one of those drivers that could make use of
>gpio-regmap=2Ec CONFIG_GPIO_REGMAP to make it even
>simpler=2E
>
>Yours,
>Linus Walleij

FWIW, I can look at it at the end of next week=2E I'm on vacation=2E

-michael 
