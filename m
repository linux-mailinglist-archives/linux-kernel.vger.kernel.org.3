Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA6D4C8BB7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 13:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbiCAMfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 07:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbiCAMfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:35:18 -0500
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F33097BAD;
        Tue,  1 Mar 2022 04:34:30 -0800 (PST)
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id 67F41C3F2A54;
        Tue,  1 Mar 2022 13:34:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 67F41C3F2A54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1646138068; bh=Upk6FCKfHLUjo081LeWtb4iS+Al74dKX2WaYB56S9xo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=kXYIsJ80HZokbCGHnuV2OFIkxix+CA3DMXYWfvgWcHU3RNN7Hr5+i3M2rzLz/hxMG
         pCIbWjt5jhEh7jb/ogvQ5lLrtV5TU086PUfetRWksya/uv6W5Nb6V0IXwZ03IBA83N
         xNdi/RU0jSCkllUrb+BGFJNs1d41WTd7OJdWS6PA=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v8 2/2] On Semi AR0521 sensor driver
References: <m3pmn66pie.fsf@t19.piap.pl> <m3h78i6p4t.fsf@t19.piap.pl>
        <20220301093107.ihokyp4xptkzpbpc@uno.localdomain>
Sender: khalasa@piap.pl
Date:   Tue, 01 Mar 2022 13:34:28 +0100
In-Reply-To: <20220301093107.ihokyp4xptkzpbpc@uno.localdomain> (Jacopo Mondi's
        message of "Tue, 1 Mar 2022 10:31:07 +0100")
Message-ID: <m38rtt7sx7.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 3
X-KLMS-Message-Action: skipped
X-KLMS-AntiSpam-Status: not scanned, whitelist
X-KLMS-AntiPhishing: not scanned, whitelist
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, not scanned, whitelist
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacopo Mondi <jacopo@jmondi.org> writes:

> In subject
>
> "media: i2c:"
>
> Same for 1/2 where permutation of "media: dt-bindings: i2c:" are used
> when adding bindings for media i2c drivers.

You know, it's rather hard to know all these tiny requirements. Let
alone get them right all the time.

>> +	pm_runtime_set_active(&client->dev);
>> +	pm_runtime_enable(&client->dev);
>> +	pm_runtime_idle(&client->dev);
>
> Do you have an _idle() callback ? This seems a no-op to me, or am I
> mistaken ? (runtime_pm is still cryptic to me sometimes)

Do you mean only the pm_runtime_idle()? Sakari just requested I add it.

> Can't you just remove power_on() if it's not needed ?

It wouldn't work without CONFIG_PM then, would it?

> There still are a few checkpatch warnings which might be worth
> considering  but nothing huge.

Do you mean this?

WARNING: Block comments use * on subsequent lines
#411: FILE: drivers/media/i2c/ar0521.c:351:
+               /* Reset gain, the sensor may produce all white pixels with=
out
+                  this */

WARNING: Block comments use a trailing */ on a separate line
#411: FILE: drivers/media/i2c/ar0521.c:351:
+                  this */

... which are about a single comment which I had to wrap to fit in 80
columns, hardly a block comment by my standards. Not to mention Linus
saying...
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
