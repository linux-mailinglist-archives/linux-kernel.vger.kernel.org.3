Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A404675A9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 11:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380122AbhLCK5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 05:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbhLCK5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:57:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D98FC06173E;
        Fri,  3 Dec 2021 02:54:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0154B82673;
        Fri,  3 Dec 2021 10:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803FFC53FC7;
        Fri,  3 Dec 2021 10:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638528854;
        bh=2mYA88Tt1gC+TWZBEbzJlGAv7cZjcjuIuSOE7ZeDp7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bREVVl7XYvdn+RgqY5hnwPUhWJfM/LBbKelBd4DafLH8DUh55CEhmMb5YF0TxFbaL
         AzsSnzdc9pAG84n+gxfVHYuyxGnsOmwRGerrIwWy3gZghVMsVj5sUbY0QTY43RCEBg
         Xf+wcIfR1ryPXxDbI84uxUKpdLDQjfh3YNg3wtn/rETyOIXxtnKaEKyhxUKdtSJc0e
         QvE/Zjd7wgGSVSWRqE1PApz5xsZy+M6d91fzBzaDR+hMRWjWd+AwJFnJ9hUuvH7uOv
         UIC60p6QCAP++NBkKh7vzLnmJB3mVkv+urlq/GTx5Dq02gR06gjaaXxqnYih8wwAyx
         YehVu5e7fwdOw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mt6CS-0002Cw-TI; Fri, 03 Dec 2021 11:53:56 +0100
Date:   Fri, 3 Dec 2021 11:53:56 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nadezda Lutovinova <lutovinova@ispras.ru>,
        Yu Xu <yuxu@marvell.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: mv_u3d: Fix a NULL pointer dereference in
 mv_u3d_req_to_trb()
Message-ID: <Yan3RHLH7UUjwSvE@hovoldconsulting.com>
References: <20211130172919.207823-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130172919.207823-1-zhou1615@umn.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 01:29:17AM +0800, Zhou Qingyang wrote:
> In mv_u3d_req_to_trb(), mv_u3d_build_trb_one() is assigned to trb and
> there is a dereference of it in mv_u3d_req_to_trb(), which could lead
> to a NULL pointer dereference on failure of mv_u3d_build_trb_one().
> 
> Fix this bug by adding a check of trb.
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
> Builds with CONFIG_USB_MV_U3D=m show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: 3d4eb9dfa3e8 ("usb: gadget: mv: Add USB 3.0 device driver for Marvell PXA2128 chip.")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
>  drivers/usb/gadget/udc/mv_u3d_core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/mv_u3d_core.c b/drivers/usb/gadget/udc/mv_u3d_core.c
> index a1057ddfbda3..e90ef4046a9d 100644
> --- a/drivers/usb/gadget/udc/mv_u3d_core.c
> +++ b/drivers/usb/gadget/udc/mv_u3d_core.c
> @@ -417,6 +417,12 @@ static int mv_u3d_req_to_trb(struct mv_u3d_req *req)
>  	 */
>  	if (length <= (unsigned)MV_U3D_EP_MAX_LENGTH_TRANSFER) {
>  		trb = mv_u3d_build_trb_one(req, &count, &dma);
> +		if (!trb) {
> +			dev_err(u3d->dev, "%s, mv_u3d_build_trb_one fail\n",
> +				__func__);

This looks correct, but the error message isn't needed as failures would
already have been logged by the helper (allocator).

> +			return -ENOMEM;
> +		}
> +
>  		list_add_tail(&trb->trb_list, &req->trb_list);
>  		req->trb_head = trb;
>  		req->trb_count = 1;

Johan
