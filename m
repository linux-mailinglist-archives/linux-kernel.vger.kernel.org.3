Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C7B49F70F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345620AbiA1KRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347813AbiA1KRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:17:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C162C06175C;
        Fri, 28 Jan 2022 02:17:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AE1261E45;
        Fri, 28 Jan 2022 10:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7FE2C340E0;
        Fri, 28 Jan 2022 10:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643365062;
        bh=55Yrs/fyGEbyWpCkjmNkgtBfGfMz8DsMaElA9YrhRoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A9rGfzrwztkrVnLvQ5llmUSVejcD4H7+DZNjbtlQ+vDdqG9GiCFMUAIcbSVT+4LOt
         Rj7Gc0KfNMgoIgXHF0mGzbfNJRV0C1u2lnXzeugSzGUXEIRNPXXOXTJR46ZMjPJ4cd
         y2eHc8d7Y9VhIGiwM5ZoJKu8XhcbxnnEr+fCIMag=
Date:   Fri, 28 Jan 2022 11:17:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Fitzsimons <robfitz@273k.net>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: bttv: Fix a NULL pointer dereference in
 bttv_overlay()
Message-ID: <YfPCwFs6RXj5KgLt@kroah.com>
References: <20220124172626.64077-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124172626.64077-1-zhou1615@umn.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 01:26:24AM +0800, Zhou Qingyang wrote:
> In bttv_overlay(), the return value of videobuf_sg_alloc() is assigned
> to variable new and there is a dereference of it after that. the return
> value of videobuf_sg_alloc() could be NULL on failure of allocation,
> which could lead to a NULL pointer dereference.
> 
> Fix this bug by adding a NULL check of new.
> 
> This bug was found by a static analyzer.
> 
> Builds with 'make allyesconfig' show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: 7c018804c090 ("V4L/DVB (7197): bttv: Fix overlay divide error")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
> The analysis employs differential checking to identify inconsistent 
> security operations (e.g., checks or kfrees) between two code paths 
> and confirms that the inconsistent operations are not recovered in the
> current function or the callers, so they constitute bugs. 
> 
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
> 
>  drivers/media/pci/bt8xx/bttv-driver.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/pci/bt8xx/bttv-driver.c b/drivers/media/pci/bt8xx/bttv-driver.c
> index 6338f98d845d..5aa46593ddc6 100644
> --- a/drivers/media/pci/bt8xx/bttv-driver.c
> +++ b/drivers/media/pci/bt8xx/bttv-driver.c
> @@ -2552,6 +2552,8 @@ static int bttv_overlay(struct file *file, void *f, unsigned int on)
>  	if (on) {
>  		fh->ov.tvnorm = btv->tvnorm;
>  		new = videobuf_sg_alloc(sizeof(*new));
> +		if (!new)
> +			return -ENOMEM;
>  		new->crop = btv->crop[!!fh->do_crop].rect;
>  		bttv_overlay_risc(btv, &fh->ov, fh->ovfmt, new);
>  	} else {
> -- 
> 2.25.1
> 

As stated before, umn.edu is still not allowed to contribute to the
Linux kernel.  Please work with your administration to resolve this
issue.

