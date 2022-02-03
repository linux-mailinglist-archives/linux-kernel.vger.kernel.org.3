Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8734A8923
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 17:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240440AbiBCQ4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 11:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbiBCQ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 11:56:22 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902CFC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 08:56:21 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DFB55C0004;
        Thu,  3 Feb 2022 16:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643907379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W0jSBYJYNVVKk+rv6PFxNqt0J0d+Gm942h0iR17woVA=;
        b=NgKC8vmwilXSNLQ/4Q+vBS+ywB596sC4eiVr2h3VOOkc1u13TPr1JZzOLcwUOK0w8/ihSL
        XLp5e7XzXxQwgKwgCSUjoTCA2rZ3T0ssFSeFXQXfRW5pnp4VMzTOyOQUDTdjLtZCi7gVUV
        RX7FAU/nSGOcQ+7v6W0plDXMGXtCU2X5A+wAHwqhbQuB1iCclhUrm9g/clkm17Ag6pV0Jz
        dobw3W7CXiVXhxObkM8RlkA19lQ8duduJ1EKUwPcIsYNZgPGtfRhA6MWQ/uxjiOg7lV9an
        MTpRE8uOVpzlXzL8ZI7MucW/d2TcoDSiBUXdhjyNDSYSvgypZ7OOYBJqb+t/UA==
Date:   Thu, 3 Feb 2022 17:56:16 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>,
        David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: Re: [RFC PATCH] mtd: tests: Fix eraseblock read speed
 miscalculation for lower partition sizes
Message-ID: <20220203175616.14f85dc1@xps13>
In-Reply-To: <20220203132434.25769-1-amit.kumar-mahapatra@xilinx.com>
References: <20220203132434.25769-1-amit.kumar-mahapatra@xilinx.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

+Cc: David, who's maintaining the tools. Please keep him in the
recipients list!

amit.kumar-mahapatra@xilinx.com wrote on Thu, 3 Feb 2022 18:54:34 +0530:

> While calculating speed during  mtd_speedtest, the time interval
> (i.e., start - finish) is rounded off to the nearest milliseconds by
> ignoring the fractional part. This leads to miscalculation of speed.
> The miscalculation is more visible while running speed test on small
> partition sizes(i.e., when partition size is equal to eraseblock size or
> twice the eraseblock size) at higher spi frequencies.
>=20
> For e.g., while calculating eraseblock read speed for a mtd partition with
> size equal to the eraseblock size(i.e., 64KiB) the eraseblock read time
> interval comes out to be 966490 nanosecond. This is then converted to
> millisecond(i.e., 0.966 msec.). The integer part (i.e., 0 msec) of the
> value is considered and the fractional part (i.e., 0.966) is ignored,for
> calculating the eraseblock read speed. So the reported eraseblock read
> speed is 0 KiB/s, which is incorrect.
>=20
> There are two approaches to fix this issue.
>=20
> First approach will be to keep the time interval in millisecond. and round
> up the integer value, with this approach the 0.966msec time interval in t=
he
> above example will be rounded up to 1msec and this value is used for
> calculating the speed. Downside of this approach is that the reported spe=
ed
> is still not accurate.
>=20
> Second approach will be to convert the time interval to microseconds
> instead of milliseconds, with this approach the 966490 nanosecond time
> interval in the above example will be converted t0 966.490usec and this
> value is used for calculating the speed. As compared to the current
> implementation and the suggested First approach, this approach will report
> a more accurate speed. Downside of this approach is that, in future if the
> mtd size is too large then the u64 variable, that holds the number of
> bytes, might overflow.
>=20
> In this patch we have gone with the second approach as this reports a more
> accurate speed. With this approach the eraseblock read speed in the above
> example comes out to be 132505 KiB/s when the spi clock is configured at
> 150Mhz.
>=20
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
> ---
> BRANCH: mtd/next
> ---
>  drivers/mtd/tests/speedtest.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/mtd/tests/speedtest.c b/drivers/mtd/tests/speedtest.c
> index 93e76648f676..2b76e7750c68 100644
> --- a/drivers/mtd/tests/speedtest.c
> +++ b/drivers/mtd/tests/speedtest.c
> @@ -161,13 +161,13 @@ static inline void stop_timing(void)
>  static long calc_speed(void)
>  {
>  	uint64_t k;
> -	long ms;
> +	long us;

Should this be an explicit 64-bit value? And unsigned?
unsigned long long int or uint64_t? I believe we are now 1000x closer
to the 4GiB limit so we might need to enlarge this variable.

> =20
> -	ms =3D ktime_ms_delta(finish, start);
> -	if (ms =3D=3D 0)
> +	us =3D ktime_us_delta(finish, start);
> +	if (us =3D=3D 0)
>  		return 0;
> -	k =3D (uint64_t)goodebcnt * (mtd->erasesize / 1024) * 1000;
> -	do_div(k, ms);
> +	k =3D (uint64_t)goodebcnt * (mtd->erasesize / 1024) * 1000000;
> +	do_div(k, us);
>  	return k;
>  }
> =20

Otherwise lgtm!

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miqu=C3=A8l
