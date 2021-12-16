Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006E4477020
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbhLPLXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbhLPLXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:23:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B19CC061574;
        Thu, 16 Dec 2021 03:23:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34322B8231A;
        Thu, 16 Dec 2021 11:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F21AC36AE2;
        Thu, 16 Dec 2021 11:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639653795;
        bh=d+QVv28ZDuplqXtOqdHMlrxWGQCchRWFxwGf5qiQbD0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GWnbaSnX43bKzSyjw91qm4c5NjJZCGEenoCLx9J2XkvUe6fB/nX1rq50xgAAoRH6a
         wizB2B5p/l6agXQu0BNFJvJVKdT0qUG+XF1L/DjdRr74VpOiiu67ahRDK5fyjDpF/w
         do5h9rrXAmI4FLyM/2YuLSOUTiUz4NWPFHGLZxZJSAoDnPfW90Rly5xfwzbJq4x1xu
         9CYnHDi3g1FMk57M7kqJNaiHMRbA9E8uRoxp7c2NNBxGHOa64VYh37ahZ/3NPekpYo
         JS8StnF9tU3FWrHQesoHCe/Ef24bXbCtX74dWOcM9ShUsazDWqnj3QSlFWHy9ZTcTZ
         uBKa45WcJDCIg==
Date:   Thu, 16 Dec 2021 12:23:11 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Cai Huoqing <caihuoqing@baidu.com>, linux-media@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-spdx@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: prefer generic SPDX-License expression to
 deprecated one
Message-ID: <20211216122311.0c9d154e@coco.lan>
In-Reply-To: <20211216103132.8087-1-lukas.bulwahn@gmail.com>
References: <20211216103132.8087-1-lukas.bulwahn@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 16 Dec 2021 11:31:32 +0100
Lukas Bulwahn <lukas.bulwahn@gmail.com> escreveu:

> Commit 8d395ce6f04b ("media: dvb-core: Convert to SPDX identifier") and
> commit e67219b0496b ("media: b2c2: flexcop: Convert to SPDX identifier")
> introduce the SPDX-License expression LGPL-2.1-or-later for some files.
> 
> The command ./scripts/spdxcheck.py warns:
> 
>   drivers/media/dvb-core/dmxdev.c: 1:28 Invalid License ID: LGPL-2.1-or-later
>   drivers/media/dvb-core/dvb_demux.c: 1:28 Invalid License ID: LGPL-2.1-or-later
>   drivers/media/dvb-core/dvbdev.c: 1:28 Invalid License ID: LGPL-2.1-or-later
>   drivers/media/common/b2c2/flexcop.c: 1:28 Invalid License ID: LGPL-2.1-or-later
> 
> The preferred SPDX expression for LGPL-2.1 or any later version is with
> the more generic "+"-extension for "any later version", so: LGPL-2.1+
> 
> This makes spdxcheck happy again.

It doesn't sound right to apply such patch.

See, the latest SPDX version uses LGPL-2.1-or-later:

	https://spdx.org/licenses/LGPL-2.1-or-later.html

And it deprecated LGPL-2.1+:

	https://spdx.org/licenses/LGPL-2.1+.html

So, those files are perfectly fine with regards to SPDX, and are
adherent to its latest specs. We do need the latest specs on media,
as our documentation is under GFDL-1.1-no-invariants-or-later, which
only exists on newer SPDX versions.

So, the right thing to do here seems to fix spdxcheck.py, letting it
either allow both variants (as we probably don't want to replace it
everywhere) or to emit a warning if the deprecated ones are used.

Regards,
Mauro

> 
> Fixes: 8d395ce6f04b ("media: dvb-core: Convert to SPDX identifier")
> Fixes: e67219b0496b ("media: b2c2: flexcop: Convert to SPDX identifier")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  drivers/media/common/b2c2/flexcop.c | 2 +-
>  drivers/media/dvb-core/dmxdev.c     | 2 +-
>  drivers/media/dvb-core/dvb_demux.c  | 2 +-
>  drivers/media/dvb-core/dvbdev.c     | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/common/b2c2/flexcop.c b/drivers/media/common/b2c2/flexcop.c
> index e7a88a2d248c..38c300da3fc2 100644
> --- a/drivers/media/common/b2c2/flexcop.c
> +++ b/drivers/media/common/b2c2/flexcop.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: LGPL-2.1-or-later
> +// SPDX-License-Identifier: LGPL-2.1+
>  /*
>   * Linux driver for digital TV devices equipped with B2C2 FlexcopII(b)/III
>   * flexcop.c - main module part
> diff --git a/drivers/media/dvb-core/dmxdev.c b/drivers/media/dvb-core/dmxdev.c
> index f6ee678107d3..2b4fb2ec1efd 100644
> --- a/drivers/media/dvb-core/dmxdev.c
> +++ b/drivers/media/dvb-core/dmxdev.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: LGPL-2.1-or-later
> +// SPDX-License-Identifier: LGPL-2.1+
>  /*
>   * dmxdev.c - DVB demultiplexer device
>   *
> diff --git a/drivers/media/dvb-core/dvb_demux.c b/drivers/media/dvb-core/dvb_demux.c
> index 83cc32ad7e12..35bf76b0425c 100644
> --- a/drivers/media/dvb-core/dvb_demux.c
> +++ b/drivers/media/dvb-core/dvb_demux.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: LGPL-2.1-or-later
> +// SPDX-License-Identifier: LGPL-2.1+
>  /*
>   * dvb_demux.c - DVB kernel demux API
>   *
> diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
> index 675d877a67b2..861559e8b4c9 100644
> --- a/drivers/media/dvb-core/dvbdev.c
> +++ b/drivers/media/dvb-core/dvbdev.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: LGPL-2.1-or-later
> +// SPDX-License-Identifier: LGPL-2.1+
>  /*
>   * dvbdev.c
>   *



Thanks,
Mauro
