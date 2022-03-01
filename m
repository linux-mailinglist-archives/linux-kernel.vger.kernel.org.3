Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969A64C8B5C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 13:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbiCAMUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 07:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiCAMUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:20:06 -0500
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E2A56C2C;
        Tue,  1 Mar 2022 04:19:22 -0800 (PST)
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id D81C1C3F2A54;
        Tue,  1 Mar 2022 13:19:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl D81C1C3F2A54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1646137161; bh=kSabZj2uSQjgkFczSZMvF3bJRihRCuN2IOOpNDYapls=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=npohYuiYKQrXVL3bxAXH92cQ4bKwu1JU2dbQkAHuNe2mbrOCzB4CGM7rSyiUvFgRi
         00EWp3RezZb3EjsKrDNR0lV6Q7xFr80zE3T/6Zh2dj7UkGMlu4y8y4KfYtB54dAlxX
         9Qnl2Rvf+QHYzZlTkCE9cMR7N7CVV+291V3beeIM=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v7 2/2] Driver for ON Semi AR0521 camera sensor
References: <m3czl9eylt.fsf@t19.piap.pl> <m34k6leyb1.fsf@t19.piap.pl>
        <20220109153439.bfnfigocaeeeghmp@uno.localdomain>
        <m35yp387n4.fsf@t19.piap.pl>
        <20220301090132.g5xsodoeotcm6h2q@uno.localdomain>
Sender: khalasa@piap.pl
Date:   Tue, 01 Mar 2022 13:19:20 +0100
In-Reply-To: <20220301090132.g5xsodoeotcm6h2q@uno.localdomain> (Jacopo Mondi's
        message of "Tue, 1 Mar 2022 10:01:32 +0100")
Message-ID: <m3czj57tmf.fsf@t19.piap.pl>
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

>> They can. It appears, though, that clusters aren't about controls which
>> can't change independently. Both of the two are written to the hardware
>> at the same time, which appears to be a valid reason to combine them
>> into a cluster.
>
> Is there a reason to write them to hw at the same time ? :)

Sure, they are written in a single merged burst on I2C.

> As it doesn't seem to me you access registers during probe (to
> identify the sensor in example) there's no need to power up the device
> during probe, but should be enough to let runtime_pm do so when
> requested.

Yes, in fact I never try to read anything from the sensor :-)
Unfortunately I'm not sure how to initialize the (possibly nonexistent)
PM without powering it up, cleanly, in all kernel configs. I mean, I can
check if PM failed and power it up "by hand", but it's a bit messy.

Suggestions are welcome, though.
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
