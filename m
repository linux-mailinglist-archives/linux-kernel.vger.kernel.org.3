Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F8051E786
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 15:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358997AbiEGNyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 09:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiEGNyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 09:54:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BD8112A;
        Sat,  7 May 2022 06:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFBAAB808D4;
        Sat,  7 May 2022 13:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58529C385A5;
        Sat,  7 May 2022 13:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651931419;
        bh=B7GSCKocZC3GBeIhJDtdHMfmZs2C5IMwNTLpWyg91fc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K99WYHydVRKLh7Dg1GnpwwXTn7WiXFCk9LfdVkHbv6I0CX+LQxktTck0pIQybiqEm
         mZUL/n3vQgPwMJEVxzKz3OMApHskwNbQXmNg8RQ+eqF2dPn0UYZYlGG3gnM01dpdqg
         VcRQ8+fQ8MWIRc+kLOMaL33HtFVloDope/dm/pFTQjQ1ee0vjv/4xjjj4Rt/ECh5yP
         opCF+gZ8QS2RMRDXBBNvyzxr1QdHInWiaBM0u4Y3AbsqoHPpRfSyyx9qyep9ikie41
         /w9fcoBg+R4ytMNPAyTeX9DJdr0IyKLX1TScSFeP2kmqyt6bhP9Oj6webp4/rhInZL
         X753MfQXFk1Vg==
Date:   Sat, 7 May 2022 14:58:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Yannick Brosseau <yannick.brosseau@gmail.com>, lars@metafoo.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        fabrice.gasnier@foss.st.com, olivier.moysan@foss.st.com,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: adc: stm32: Fix ADC IRQ handling on STM32F4
Message-ID: <20220507145845.06504c3b@jic23-huawei>
In-Reply-To: <CGHHBR.49W7GPLHSYOE@crapouillou.net>
References: <20220506225617.1774604-1-yannick.brosseau@gmail.com>
        <CGHHBR.49W7GPLHSYOE@crapouillou.net>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 May 2022 00:05:00 +0100
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi Yannick,
>=20
> Le ven., mai 6 2022 at 18:56:15 -0400, Yannick Brosseau=20
> <yannick.brosseau@gmail.com> a =C3=A9crit :
> > Recent changes to the STM32 ADC irq handling broke the STM32F4=20
> > platforms
> > These two patches bring it back to a working state. =20
>=20
> If the STM32 ADC was broken recently, and these two patches fix it,=20
> then I'd expect to see a Fixes: tag on both commits and Cc:=20
> linux-stable.

I normally add the Cc: for stable, but don't mind for obvious cases
if patches come in with it already there.

Sometimes the marking can be timing dependent (no point in sending
things to stable if they are going to hit in the same cycle etc)

Absolutely agree on fixes tag though!

Thanks,

Jonathan

>=20
> Cheers,
> -Paul
>=20
> > Yannick Brosseau (2):
> >   iio: adc: stm32: Iterate through all ADCs in irq handler
> >   iio: adc: stm32: Fix check for spurious IRQs on STM32F4
> >=20
> >  drivers/iio/adc/stm32-adc-core.c | 7 ++++++-
> >  drivers/iio/adc/stm32-adc.c      | 9 ++++++---
> >  2 files changed, 12 insertions(+), 4 deletions(-)
> >=20
> > --
> > 2.36.0
> >  =20
>=20
>=20

