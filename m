Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE214813D9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 15:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240096AbhL2OL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 09:11:28 -0500
Received: from ni.piap.pl ([195.187.100.5]:45936 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237129AbhL2OL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 09:11:27 -0500
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id ADD66C3EDF3E;
        Wed, 29 Dec 2021 15:11:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl ADD66C3EDF3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1640787083; bh=9zhor7CdxbsPCJIO83SEnIytnazMD9oMhN5rLvb/M4Q=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=HYayTqHPjS1OJrn7FnVeJLeW9slV/0uj2awpmgTAo3I/BIIT0EGClS5w6o5TOPoIS
         OvOwrxape7QZ9KUYx2GnUM+DVdJvMRtCEaUcjIaRQAZoCoOonXPyV5Hm2CSVbhSU5/
         3tkKyIXSA5gt3hGGWiWwJ6FCvI5viroqsuCOUVm0=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Joe Perches <joe@perches.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: Re: [PATCH v6 2/2] Driver for ON Semi AR0521 camera sensor
References: <m3ee63hkuu.fsf@t19.piap.pl> <m35yrfhkaf.fsf@t19.piap.pl>
        <cee1bbe6c8dda1c79ba19f7bbf68fc1d74558cae.camel@perches.com>
Sender: khalasa@piap.pl
Date:   Wed, 29 Dec 2021 15:11:22 +0100
In-Reply-To: <cee1bbe6c8dda1c79ba19f7bbf68fc1d74558cae.camel@perches.com> (Joe
        Perches's message of "Thu, 23 Dec 2021 09:49:58 -0800")
Message-ID: <m3wnjnfqlx.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 3
X-KLMS-Message-Action: skipped
X-KLMS-AntiSpam-Status: not scanned, whitelist
X-KLMS-AntiPhishing: not scanned, whitelist
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, not scanned, whitelist
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Joe,

Joe Perches <joe@perches.com> writes:

>> +/* External clock (extclk) frequencies */
>> +#define AR0521_EXTCLK_MIN	  (10 * 1000 * 1000)
>
> Generally, adding a prefix like AR0521_ to defines that are
> locally defined in a single file unnecessarily increases
> identifier length.

Right. In general, I don't do that (for that very reason), however in
drivers/media this looks like a common practice and I didn't want to
break it.

> e.g. Using this identifier anywhere
>
>> +#define AR0521_REG_HISPI_CONTROL_STATUS_FRAMER_TEST_MODE_ENABLE 0x80

Right. However, such a name helps looking this up in the docs.
E.g. the register name in the docs is "hispi_control_status" and the
bitfield is "framer_test_mode" or something like that.
Since it's just one register (+ value) and it actually fits in 80
columns without too much problems, I'd rather like to leave it
unchanged.

> Many of the 80 column line lengths and line wrapping used in this
> file are not really nice to read.  I believe you don't have to be
> strict about 80 column lines.

Well, personally I think we could all switch to VT100's 132 columns.
Introduced in '78 :-) That's what I currently use for non-kernel tasks
(not the VT100 but just the line length). OTOH I'm using that emacs
wrapping mode so longer lines aren't a problem either.
But here, in drivers/media, I'm told 80 column is strict.

>> +#define be		cpu_to_be16
>
> It's a pity there's no way to declare an array with all members
> having a specific endianness.  Making sure all elements in these
> arrays are declared with be() is tedious.

Right. Unfortunately anything else would mean recoding.

>> +#define AR0521_NUM_SUPPLIES ARRAY_SIZE(ar0521_supply_names)
>
> It's almost always better to use ARRAY_SIZE directly and not
> use a #define for the array size.

It's another custom in drivers/media, but I guess I don't have to follow
it closely, do I? I never liked the #define.

>> +static int ar0521_set_gains(struct ar0521_dev *sensor)
>> +{
> []
>> +	dev_dbg(&sensor->i2c_client->dev, "%s()\n", __func__);
>
> ftrace works and perhaps all the similar debug logging uses aren't
> really necessary.

TBH I've never used ftrace.
It appears that it can't show the arguments, can it?
If not, I'd rather leave these dev_dbg()s in place - like other
drivers/media/* in fact.
However obviously the code without deb_dbg()s would be cleaner, so if
ftrace can show the (formatted) arguments, I'm all for it.

Thanks for looking at this,
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
