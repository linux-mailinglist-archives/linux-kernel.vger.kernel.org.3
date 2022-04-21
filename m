Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A825098C6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385654AbiDUHRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbiDUHRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:17:02 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8868917E0E;
        Thu, 21 Apr 2022 00:14:12 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 60B4CFF802;
        Thu, 21 Apr 2022 07:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650525251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tF1l38yNLifs157p+0M0oAulXITisRKFk1XcRuMtgmc=;
        b=nxEEY6IhjbI4fyapFIUTPZo4lah0erUrXuFcAN7w8d77NGuaa4niY5mcgzgMOeU9pNbTom
        YSKG57ZLlaSC8qvE178ju++ZlyHZZ8YdwQKcA8fgtO913KIg3Z6J2xz3YmySWFLIU1uk+d
        LKVojsq9ytvhCDZwS4u77H+NyOlifILpiMio/gKbXpPOv6uQ4P9duhm8QOkK3++1ae+92v
        541EkVRonrkU/40KUqhKcaqY5gUn09VAbH/7EruqCiT/dhAK2nP0ieD2cF1bAybixTAtdC
        J9JYBJbMCefYRtQ/hu+mQsBZstKCOo0dpV4xhyALsIaFFfgxoIelCL0rLICaOg==
Date:   Thu, 21 Apr 2022 09:14:09 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Takahiro Kuwano <tkuw584924@gmail.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] spi: spi-mem: check if data buffers are on stack
Message-ID: <20220421091409.3b7ea7ac@xps13>
In-Reply-To: <20220421071056.4o33vlhoqarod3ow@ti.com>
References: <20220420102022.3310970-1-p.yadav@ti.com>
        <YmAE2IVRgPyWxmbn@sirena.org.uk>
        <20220421071056.4o33vlhoqarod3ow@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

p.yadav@ti.com wrote on Thu, 21 Apr 2022 12:40:56 +0530:

> On 20/04/22 02:04PM, Mark Brown wrote:
> > On Wed, Apr 20, 2022 at 03:50:22PM +0530, Pratyush Yadav wrote: =20
> > > The buffers passed in the data phase must be DMA-able. Programmers of=
ten
> > > don't realise this requirement and pass in buffers that reside on the
> > > stack. This can be hard to spot when reviewing code. Reject ops if th=
eir
> > > data buffer is on the stack to avoid this.
> > >=20
> > > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > > Acked-by: Mark Brown <broonie@kernel.org>
> > > ---
> > >=20
> > > Changes in v2:
> > > - Include task_stack.h. It might not get included indirectly on some
> > >   platforms and can cause build failures.
> > > - Add a WARN_ON_ONCE() for debuggability.
> > > - Add Mark's Ack. =20
> >=20
> > Since this is now an isolated patch does that mean whatever meant that I
> > acked rather than applying this patch has gone in and I can now apply it
> > directly? =20
>=20
> Yes, you should be able to apply it directly. Miquel's spi-mem-ecc=20
> branch is now in 5.18-rc1 and later. Though this patch never conflicted=20
> with that branch to begin with. The spi-mem-ecc branch does not touch=20
> spi_mem_check_op() as far as I can see.

It did during a few version AFAIR, but not the final ones anymore.

But it's upstream now, so please feel free to apply.

Thanks,
Miqu=C3=A8l
