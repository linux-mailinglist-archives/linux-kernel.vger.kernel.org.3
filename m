Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E0E474601
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbhLNPG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:06:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41168 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbhLNPG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:06:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BF9261513;
        Tue, 14 Dec 2021 15:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351BCC34605;
        Tue, 14 Dec 2021 15:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639494416;
        bh=EYufVmTkuXTD1hBchy+lUX58PL7FQ1rkvQEWSW24zgo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=azrQ8ZdL6+6aF7cIbJDAnKqEYJ1Sm+kqvBgyqvWd2Re2fdqhR7CK7nXHBb/IQCp/8
         yJBxN+vTJswJ0QhZaRXG+OntA+NEbh3wssubCaBJ+ix0V421BGY4umqz+5CSX0X9Qz
         aYqa5QoHc+px4V0HjQ6EBfTgfpmqjZkJb6Pkmku4z2oP/GVvFDrcvUmE262SXTlpN2
         5MJ6rfRHZuFs3fiuWs9zBpv/xjZwvmoVqVz0XS839291yWwHHrQ8Jmvm/kI/8AHxN3
         2ELQY9T4t9IumZNDQxnxU5i05w/q6N/JDelfBo1zPZftO2WaY99zTHrVnEvLLOtNsN
         EOgSImDUrYnfQ==
Date:   Tue, 14 Dec 2021 16:06:52 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Sean Young <sean@mess.org>, Brad Love <brad@nextdimension.cc>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Antti Palosaari <crope@iki.fi>,
        Jan Pieter van Woerkom <jp@jpvw.nl>
Subject: Re: [RFC PATCH][DO NOT COMMIT] media: dvb_frontend: Support
 concurrent DVB-T/DVB-T2 scan
Message-ID: <20211214160652.058673f1@coco.lan>
In-Reply-To: <4c32558d-3be7-9a57-b655-65c744c1e532@free.fr>
References: <4c32558d-3be7-9a57-b655-65c744c1e532@free.fr>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 11 Jun 2020 13:57:13 +0200
Marc Gonzalez <marc.w.gonzalez@free.fr> escreveu:

> Some demodulators (e.g. si2168) are able to scan for DVB-T and DVB-T2
> signals concurrently. Use SYS_DVBT_AUTO for this purpose.
> ---
> This is a Request For Comments from media maintainers and users :-)

Sorry for taking so long to answer... Somehow, this one got stuck in the
middle of the pile of patches.

I don't think this patch is needed. The same also happens with DVB-S/S2
cards: when some of those are set to the second gen, it may report both
1st and 2nd gen channels.

The main issue is actually how to report that a scanned channel is
DVB-T during a DVB-T2 scan: the driver should likely identify those
and set the properties accordingly.

> 
> One issue: suppose DVB Project publishes DVB-T3 in a few years.
> Today's demods might handle T/T2, but they won't handle T3, while users
> may expect SYS_DVBT_AUTO to mean "all DVB-T standards".
> 
> Therefore, perhaps the delsys name should be explicit,
> like SYS_DVBT_DVBT2 or SYS_DVBT_1_2.
> Then if/when DVB_T3 appears, we can add SYS_DVBT_1_2_3 ???
> 
> Or maybe use the FE_CAN_2G_MODULATION and hypothetical FE_CAN_3G_MODULATION
> 
> Or maybe, with several standards having a v2 and possibly v3 in the future,
> delivery system might move to a bitmask approach? (API issues though)
> 
> Reference to related implementation:
> https://patchwork.kernel.org/patch/10744999/
> ---
>  drivers/media/dvb-frontends/si2168.c | 2 +-
>  include/uapi/linux/dvb/frontend.h    | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/dvb-frontends/si2168.c b/drivers/media/dvb-frontends/si2168.c
> index 14b93a7d3358..8578b8917955 100644
> --- a/drivers/media/dvb-frontends/si2168.c
> +++ b/drivers/media/dvb-frontends/si2168.c
> @@ -624,7 +624,7 @@ static int si2168_deselect(struct i2c_mux_core *muxc, u32 chan)
>  }
>  
>  static const struct dvb_frontend_ops si2168_ops = {
> -	.delsys = {SYS_DVBT, SYS_DVBT2, SYS_DVBC_ANNEX_A},
> +	.delsys = {SYS_DVBT, SYS_DVBT2, SYS_DVBT_AUTO, SYS_DVBC_ANNEX_A},
>  	.info = {
>  		.name = "Silicon Labs Si2168",
>  		.frequency_min_hz      =  48 * MHz,
> diff --git a/include/uapi/linux/dvb/frontend.h b/include/uapi/linux/dvb/frontend.h
> index 4f9b4551c534..3a6348748041 100644
> --- a/include/uapi/linux/dvb/frontend.h
> +++ b/include/uapi/linux/dvb/frontend.h
> @@ -600,6 +600,8 @@ enum fe_rolloff {
>   *	Terrestrial TV: DVB-T
>   * @SYS_DVBT2:
>   *	Terrestrial TV: DVB-T2
> + * @SYS_DVBT_AUTO:
> + *	Terrestrial TV: Autodetect DVB-T gen
>   * @SYS_ISDBT:
>   *	Terrestrial TV: ISDB-T
>   * @SYS_ATSC:
> @@ -645,6 +647,7 @@ enum fe_delivery_system {
>  	SYS_DVBT2,
>  	SYS_TURBO,
>  	SYS_DVBC_ANNEX_C,
> +	SYS_DVBT_AUTO,
>  };
>  
>  /* backward compatibility definitions for delivery systems */



Thanks,
Mauro
