Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8458A4743CD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbhLNNqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:46:23 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52648 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhLNNqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:46:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B88F5B819B4;
        Tue, 14 Dec 2021 13:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E0EC34601;
        Tue, 14 Dec 2021 13:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639489579;
        bh=IPUyK9+cTg9d2YEDhc90Ub9/uzFy2tW8VkPRCEUQ3Dw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=urnGSGDpfLi3eHC8Ge0YggS1h4NDPuPnmRzrsrjOnq2Oc8POGut1BzG2LQHGVJbWN
         rI1uGalDQm4LOTdO8K4KowL00SF16QpUBr0syqGHY9Aoz5jOrRS3BkeskcKEW7Psbs
         YxvB5CCBhjmHCHuxRlY6J0tXphweVu1XMfBnqe1pEiZ4CNYn8ZRYZxegPsfowK5ZOo
         c1B+Mo8fBBwVVVj8jzU5/N3NEx2uulrUXO+7umSx10/KuNYm1GT6OvWd3GpppcTv/x
         BSs5yaydxuJjsxhzH6KFbneQoCBtm+WBS/GJVF1Vqn40gKp31s8741qw6q/ZHYH4zS
         OUHZsfGAkvvmw==
Date:   Tue, 14 Dec 2021 14:46:13 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Neil Armstrong <narmstrong@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: meson: vdec: Fix a NULL pointer dereference
 in amvdec_add_ts()
Message-ID: <20211214144613.35fec82a@coco.lan>
In-Reply-To: <20211202160357.75173-1-zhou1615@umn.edu>
References: <20211201084108.GE9522@kadam>
        <20211202160357.75173-1-zhou1615@umn.edu>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri,  3 Dec 2021 00:03:57 +0800
Zhou Qingyang <zhou1615@umn.edu> escreveu:

> In amvdec_add_ts(), there is a dereference of kzalloc(), which could lead
> to a NULL pointer dereference on failure of kzalloc().
> 
> I fix this bug by adding a NULL check of new_ts.
> 
> This bug was found by a static analyzer. The analysis employs
> differential checking to identify inconsistent security operations
> (e.g., checks or kfrees) between two code paths and confirms that the
> inconsistent operations are not recovered in the current function or
> the callers, so they constitute bugs.
> 
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
> 
> Builds with CONFIG_VIDEO_MESON_VDEC=m show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: 876f123b8956 ("media: meson: vdec: bring up to compliance")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
> Changes in v2:
>   -  Delete dev_err() message
> 
>  drivers/staging/media/meson/vdec/vdec_helpers.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.c b/drivers/staging/media/meson/vdec/vdec_helpers.c
> index b9125c295d1d..ac60514c475b 100644
> --- a/drivers/staging/media/meson/vdec/vdec_helpers.c
> +++ b/drivers/staging/media/meson/vdec/vdec_helpers.c
> @@ -234,6 +234,9 @@ void amvdec_add_ts(struct amvdec_session *sess, u64 ts,
>  	unsigned long flags;
>  
>  	new_ts = kzalloc(sizeof(*new_ts), GFP_KERNEL);
> +	if (!new_ts)
> +		return;
> +
>  	new_ts->ts = ts;
>  	new_ts->tc = tc;
>  	new_ts->offset = offset;

I don't think this change is ok. Sure, it needs to check if
kzalloc() fails, but it should return -ENOMEM and the caller
should check if it returns an error. So, I would expect
that this patch would also touch the caller function at
drivers/staging/media/meson/vdec/esparser.c.

Regards,
Mauro



Thanks,
Mauro
