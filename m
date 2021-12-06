Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447C846959E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243080AbhLFM2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:28:13 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36126 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbhLFM2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:28:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 383C8B81095;
        Mon,  6 Dec 2021 12:24:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AB5C341C1;
        Mon,  6 Dec 2021 12:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638793482;
        bh=NNkn8ZrC39abBKgNUEvj2xA272IAcSVlpr7eRH+++DU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z9HEgfvfOnMrwGZ8vMCrWWV5DBXuJO0hTcSeii4be/s5bSyhY4KDdRw7cJGwQq1Fl
         egkEGy9TcrmCmd6FG9EpJ8QosMNK/94QijddMKjrWS8idmei+n9eMZP8SSCSaoWF9R
         sSm7xFwjMUb0giS9M+AhVvQn5q6a98xGq9ga6h3MQ5S3f/hi9Qo1bsz3zAh+wesgcx
         KDZ2277qsEXsuVgObFwbxG2c8f7mO0dZHgsln7r525HhLumEQUgTOFo1LrBxIQRnmu
         X9uqz+Gn7fCiwkSwyrEgIx3Ig/FDLil+MRGLld9M+ECXRc2mT3ABikk5HcJ+dMdk8n
         ANHwuarXGTr8w==
Date:   Mon, 6 Dec 2021 13:24:38 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-media@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: media: Fix imbalance of LaTeX group
Message-ID: <20211206132438.206f2474@coco.lan>
In-Reply-To: <b3eeec4d-1a34-0a1a-3097-1ddea3b5f1c8@gmail.com>
References: <b3eeec4d-1a34-0a1a-3097-1ddea3b5f1c8@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, 4 Dec 2021 12:37:35 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> The beginning part of the "existing HSV/HSL formats" table (line 7742)
> reads:
> 
>   .. raw:: latex
> 
>       \begingroup
>       \tiny
>       \setlength{\tabcolsep}{2pt}
> 
> However, the ending part (line 7834) reads:
> 
>   .. raw:: latex
> 
>       \normalsize
> 
> 
> Fix the imbalance by replacing the \normalsize with \endgroup.
> 
> Note:
>     Actually, the imbalance is harmless and just results in an
>     informative message near the bottom of userspace-api.log:
> 
>       (\end occurred inside a group at level 1)
> 
>       ### semi simple group (level 1) entered at line 70696 (\begingroup)
>       ### bottom level 
> 
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> ---
> Hi,
> 
> This imbalance has existed ever since commit 70b074df4ed1 ("media:
> fix pdf build with Spinx 1.6") authored by Mauro.
> As it has no visible effect in the generated PDF, I'm not putting
> a Fixes: tag.
> 
> Mauro, are you OK with this fix going through the -doc tree?
> Otherwise, feel free to carry it through the -media tree.
> Either is fine by me.

I'm picking this one. It is usually easier this way, as it avoids the
risk of merge conflicts, as we update media API documentation together
with any patches touching the API itself.

Regards,
Mauro

> 
>         Thanks, Akira
> --
>  Documentation/userspace-api/media/v4l/subdev-formats.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/subdev-formats.rst b/Documentation/userspace-api/media/v4l/subdev-formats.rst
> index bd68588b2683..0cbc045d5df6 100644
> --- a/Documentation/userspace-api/media/v4l/subdev-formats.rst
> +++ b/Documentation/userspace-api/media/v4l/subdev-formats.rst
> @@ -7833,7 +7833,7 @@ The following table lists existing HSV/HSL formats.
>  
>  .. raw:: latex
>  
> -    \normalsize
> +    \endgroup
>  
>  
>  JPEG Compressed Formats
> 
> base-commit: 065db2d90c6b8384c9072fe55f01c3eeda16c3c0



Thanks,
Mauro
