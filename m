Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF4352D9A0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241545AbiESP6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238551AbiESP6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:58:46 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF08D9E9E2;
        Thu, 19 May 2022 08:58:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6671ACE25D8;
        Thu, 19 May 2022 15:58:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF23C385AA;
        Thu, 19 May 2022 15:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652975922;
        bh=H5hgmjgqxim+cvpsLbstqaJDE2jglCvDhPW2rIHtuuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZOGa9PuVEsUF7/C7qPzj6Ius1MG4OsRvVVjiDfvuCSqiIIyjyZwNKL34fxPvzLsAL
         9i4dOfsKMxJN2sIMqZwpSd+fVf3fbW+3t0mbwUh9tbBmo3ckYPoRszhDrSFPavEY3d
         TuvdLvg4dJIoROqRjgVxnJi4ACJdfQgolnTTiAg0=
Date:   Thu, 19 May 2022 17:58:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yongzhi Liu <lyz_cs@pku.edu.cn>
Cc:     pawell@cadence.com, peter.chen@nxp.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, fuyq@stu.pku.edu.cn
Subject: Re: [PATCH] usb: cdnsp:  Fix potential dereference of NULL pointer
Message-ID: <YoZpKzT6txHJoAxP@kroah.com>
References: <1652891743-110930-1-git-send-email-lyz_cs@pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652891743-110930-1-git-send-email-lyz_cs@pku.edu.cn>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 09:35:43AM -0700, Yongzhi Liu wrote:
> The return value of cdnsp_get_transfer_ring()
> needs to be checked to avoid use of NULL pointer
> in case of an acquisition failure.

Please use the full 72 columns

> 
> Fixes: 3d8290455 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> 
> Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>

Please do not put a blank line between "Fixes:" and your signed off by
line.

> ---
>  drivers/usb/cdns3/cdnsp-ring.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.c
> index 1b14384..9f206b9 100644
> --- a/drivers/usb/cdns3/cdnsp-ring.c
> +++ b/drivers/usb/cdns3/cdnsp-ring.c
> @@ -655,6 +655,8 @@ static int cdnsp_cmd_set_deq(struct cdnsp_device *pdev,
>  	 * to reflect the new position.
>  	 */
>  	ep_ring = cdnsp_get_transfer_ring(pdev, pep, deq_state->stream_id);
> +	if (!ep_ring)
> +		return -EINVAL;

How did you test this?

Don't you need to properly clean up and handle the hardware issues if
you exit early here?

Without good testing, I am loath to take this.

thanks,

greg k-h
