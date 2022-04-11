Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FAF4FB8FF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345072AbiDKKH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344898AbiDKKHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:07:20 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E731112092;
        Mon, 11 Apr 2022 03:05:01 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9035F24000C;
        Mon, 11 Apr 2022 10:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649671500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tbYj23K6jfuxj8TlVhbvMc+NFVh8TGna4cbWn2gXvfo=;
        b=LjGlxuAS+8lEZjBd1Z3IfJcpClR4X7Gistt7AQq+NgaeCMlVCkTK7N5+KG0/9RsLQqjtzO
        MBYF2FjKIsUzjTx7yHqq2bVhSrzUZ1XFzksIuoFAG9zL4EbBqo/y9Crl6XlbR5Xhw0lCZD
        P0tmVR9Aap+3OP6SNsDaCFJFQbW0BFfv7TpY7WMqbQB9IpPX0CnUYQyyOANqGAGKN8Nzmx
        BKnaGzS5FR8PG3XNdgAXFfPUQcTK/9UQoSWAazSoosjnDjyMsrpP1ImZD6SqnmD3OncxUj
        0UfN0FHRAxEf4LYFWYBl+pmJoF1vTToDPcehE1xHg+faEzuVwokH05/v+c+JkQ==
Date:   Mon, 11 Apr 2022 12:04:56 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Rini <trini@konsulko.com>, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u-boot@lists.denx.de, devicetree@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1p?= =?UTF-8?B?xYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 2/2] nvmem: add driver handling U-Boot environment
 variables
Message-ID: <20220411120456.16edb643@xps13>
In-Reply-To: <e6343890-2c8c-ea83-636a-61230a1e1759@linaro.org>
References: <20220411085926.10925-1-miquel.raynal@bootlin.com>
        <e6343890-2c8c-ea83-636a-61230a1e1759@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

srinivas.kandagatla@linaro.org wrote on Mon, 11 Apr 2022 10:45:53 +0100:

> On 11/04/2022 09:59, Miquel Raynal wrote:
> > On Wed, 2022-04-06 at 14:32:25 UTC, =3D?utf-8?b?UmFmYcWCIE1pxYJlY2tp?=
=3D wrote: =20
> >> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> >>
> >> U-Boot stores its setup as environment variables. It's a list of
> >> key-value pairs stored on flash device with a custom header.
> >>
> >> This commit adds an NVMEM driver that:
> >> 1. Provides NVMEM access to environment vars binary data
> >> 2. Extracts variables as NVMEM cells
> >>
> >> It can be used for:
> >> 1. Accessing env variables from user-space
> >> 2. Reading NVMEM cells by Linux drivers
> >>
> >> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl> =20
> >=20
> > Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.gi=
t mtd/next, thanks. =20
>=20
> Hi Miquel,
>=20
> Any reason why this nvmem driver is taken via mtd tree?
>=20
> This is going to conflict with other nvmem patches that are touching KCon=
fig and Makefile

Sorry I selected it by mistake. I'll let you take it through nvmem
unless there is still something missing on your side?

Anyway, it's now dropped from mtd.

Thanks,
Miqu=C3=A8l
