Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D22648E299
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 03:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238848AbiANCo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 21:44:57 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50148 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236033AbiANCo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 21:44:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C69CB823F2;
        Fri, 14 Jan 2022 02:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F28C36AE3;
        Fri, 14 Jan 2022 02:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642128294;
        bh=hoWaolITibbpjY3rvx/9PKXFb7IqBd27ygqZfX08ruw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=udfgw4EBqtHSxMhp+cxKF1u4w/f8CZCaxPiimIzowE69TA84XgRnAgdO1ksdzHSPX
         gAhALx41PoyEGpEr6eID8Wmt9LVYyXo+PJC1HN0BJQVHZpJVESrQCpcWK0iFzBJPOu
         hcFsptohbS8Gvzpeybc2fYNczjvGk198eO8SoEXBVfxwsB+hF1uFzcOWc20L08Fkn7
         xSpZ9giyi7YJSxu7FUKcU2++FflPjz9+/9JZI7Y5VnuRteRN2JB1Gd3/mFO2KAltO0
         vVbWF+8quVzsdS1vQ3EyvzgkHYZlsXimqj1b1rTI8hZ3UpM55qinNxHlvnfkk2Z+Mz
         jNcraKaFtiBnA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1634280331-4150-1-git-send-email-wangqing@vivo.com>
References: <1634280331-4150-1-git-send-email-wangqing@vivo.com>
Subject: Re: [PATCH RESEND] clk-si5341: replace snprintf in show functions with sysfs_emit
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mike.looijmans@topic.nl, Qing Wang <wangqing@vivo.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Qing Wang <wangqing@vivo.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Robert Hancock <robert.hancock@calian.com>
Date:   Thu, 13 Jan 2022 18:44:52 -0800
User-Agent: alot/0.9.1
Message-Id: <20220114024453.D9F28C36AE3@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Robert

Quoting Qing Wang (2021-10-14 23:45:28)
> coccicheck complains about the use of snprintf() in sysfs show functions.
>=20
> Fix the following coccicheck warning:
> drivers/clk/clk-si5341.c:1471: WARNING: use scnprintf or sprintf.
> drivers/clk/clk-si5341.c:1486: WARNING: use scnprintf or sprintf.
> drivers/clk/clk-si5341.c:1501: WARNING: use scnprintf or sprintf.
> drivers/clk/clk-si5341.c:1516: WARNING: use scnprintf or sprintf.
>=20
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
>=20
> Signed-off-by: Qing Wang <wangqing@vivo.com>
> ---
>  drivers/clk/clk-si5341.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
> index 57ae183..5d62ddb 100644
> --- a/drivers/clk/clk-si5341.c
> +++ b/drivers/clk/clk-si5341.c
> @@ -1468,7 +1468,7 @@ static ssize_t input_present_show(struct device *de=
v,
>         if (res < 0)
>                 return res;
>         res =3D !(status & SI5341_STATUS_LOSREF);
> -       return snprintf(buf, PAGE_SIZE, "%d\n", res);
> +       return sysfs_emit(buf, "%d\n", res);
>  }
>  static DEVICE_ATTR_RO(input_present);
> =20
> @@ -1483,7 +1483,7 @@ static ssize_t input_present_sticky_show(struct dev=
ice *dev,
>         if (res < 0)
>                 return res;
>         res =3D !(status & SI5341_STATUS_LOSREF);
> -       return snprintf(buf, PAGE_SIZE, "%d\n", res);
> +       return sysfs_emit(buf, "%d\n", res);
>  }
>  static DEVICE_ATTR_RO(input_present_sticky);
> =20
> @@ -1498,7 +1498,7 @@ static ssize_t pll_locked_show(struct device *dev,
>         if (res < 0)
>                 return res;
>         res =3D !(status & SI5341_STATUS_LOL);
> -       return snprintf(buf, PAGE_SIZE, "%d\n", res);
> +       return sysfs_emit(buf, "%d\n", res);
>  }
>  static DEVICE_ATTR_RO(pll_locked);
> =20
> @@ -1513,7 +1513,7 @@ static ssize_t pll_locked_sticky_show(struct device=
 *dev,
>         if (res < 0)
>                 return res;
>         res =3D !(status & SI5341_STATUS_LOL);
> -       return snprintf(buf, PAGE_SIZE, "%d\n", res);
> +       return sysfs_emit(buf, "%d\n", res);
>  }
>  static DEVICE_ATTR_RO(pll_locked_sticky);
> =20
> --=20
> 2.7.4
>
