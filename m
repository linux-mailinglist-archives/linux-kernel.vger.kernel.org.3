Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E2047E73F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 18:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244610AbhLWRuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 12:50:08 -0500
Received: from relay033.a.hostedemail.com ([64.99.140.33]:48421 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229962AbhLWRuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 12:50:06 -0500
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id 3CFB321967;
        Thu, 23 Dec 2021 17:50:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 1522560014;
        Thu, 23 Dec 2021 17:49:55 +0000 (UTC)
Message-ID: <cee1bbe6c8dda1c79ba19f7bbf68fc1d74558cae.camel@perches.com>
Subject: Re: [PATCH v6 2/2] Driver for ON Semi AR0521 camera sensor
From:   Joe Perches <joe@perches.com>
To:     Krzysztof =?UTF-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Jacopo Mondi <jacopo@jmondi.org>
Date:   Thu, 23 Dec 2021 09:49:58 -0800
In-Reply-To: <m35yrfhkaf.fsf@t19.piap.pl>
References: <m3ee63hkuu.fsf@t19.piap.pl> <m35yrfhkaf.fsf@t19.piap.pl>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Stat-Signature: np36hfktpep65hys3tpd4hjqng9646pj
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 1522560014
X-Spam-Status: No, score=-3.31
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19Z3GPdwpXmwkGYSFVpQF+GO7Dm2x4ydkg=
X-HE-Tag: 1640281795-678023
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-12-23 at 08:06 +0100, Krzysztof Hałasa wrote:
> The driver has been extensively tested in an i.MX6-based system.
> AR0521 is a 5.7 mm x 4.3 mm, 5 MPix RGGB MIPI/HiSPi BSI CMOS sensor
> from On Semiconductor.

trivial notes:

> diff --git a/drivers/media/i2c/ar0521.c b/drivers/media/i2c/ar0521.c
[]
> +/* External clock (extclk) frequencies */
> +#define AR0521_EXTCLK_MIN	  (10 * 1000 * 1000)

Generally, adding a prefix like AR0521_ to defines that are
locally defined in a single file unnecessarily increases
identifier length.

It makes using short line lengths difficult.

e.g. Using this identifier anywhere

> +#define AR0521_REG_HISPI_CONTROL_STATUS_FRAMER_TEST_MODE_ENABLE 0x80

Many of the 80 column line lengths and line wrapping used in this
file are not really nice to read.  I believe you don't have to be
strict about 80 column lines.

> +#define be		cpu_to_be16

It's a pity there's no way to declare an array with all members
having a specific endianness.  Making sure all elements in these
arrays are declared with be() is tedious.

> +#define AR0521_NUM_SUPPLIES ARRAY_SIZE(ar0521_supply_names)

It's almost always better to use ARRAY_SIZE directly and not
use a #define for the array size.

> +static int ar0521_set_gains(struct ar0521_dev *sensor)
> +{
[]
> +	dev_dbg(&sensor->i2c_client->dev, "%s()\n", __func__);

ftrace works and perhaps all the similar debug logging uses aren't
really necessary.


