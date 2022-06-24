Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24AA5598D0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 13:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiFXLor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 07:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiFXLog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 07:44:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2959517F7;
        Fri, 24 Jun 2022 04:44:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 402426221A;
        Fri, 24 Jun 2022 11:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A190C34114;
        Fri, 24 Jun 2022 11:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656071074;
        bh=CU5jt/jyRnQdq4KWWdyD9qYFMISV9kZzU+u4tN56sew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=We6p10MXSSgBa5S8Rw3HyK4tx91+8lHNVrmF/J0raRmpR4/jYwRc1vallc1qAcoH2
         /LogGzlzWdqtCl68WoRNymfPyqqgAoK0OYMq+2dG9gVzTSVYZi2i+bgL1FvN1cc6yu
         d3o5pChEgCKVm+5Fdktn3FpOL/gI/b8ChAdUT9eA=
Date:   Fri, 24 Jun 2022 08:46:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Roger Quadros <roger.quadros@nokia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cai Huoqing <cai.huoqing@linux.dev>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [PATCH v2] usb: gadget: f_mass_storage: Make CD-ROM emulation
 works with Windows OS
Message-ID: <YrVd0wmBTbtGfBy9@kroah.com>
References: <20220624021916.318067-1-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624021916.318067-1-neal_liu@aspeedtech.com>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 10:19:16AM +0800, Neal Liu wrote:
> Add read TOC with format 1 to support CD-ROM emulation with
> Windows OS.
> This patch is tested on Windows OS Server 2019.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  drivers/usb/gadget/function/f_mass_storage.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
> index 3a77bca0ebe1..9edf76c22605 100644
> --- a/drivers/usb/gadget/function/f_mass_storage.c
> +++ b/drivers/usb/gadget/function/f_mass_storage.c
> @@ -1209,7 +1209,8 @@ static int do_read_toc(struct fsg_common *common, struct fsg_buffhd *bh)
>  
>  	switch (format) {
>  	case 0:
> -		/* Formatted TOC */
> +	case 1:
> +		/* Formatted TOC, Session info */
>  		len = 4 + 2*8;		/* 4 byte header + 2 descriptors */
>  		memset(buf, 0, len);
>  		buf[1] = len - 2;	/* TOC Length excludes length field */
> @@ -1250,7 +1251,7 @@ static int do_read_toc(struct fsg_common *common, struct fsg_buffhd *bh)
>  		return len;
>  
>  	default:
> -		/* Multi-session, PMA, ATIP, CD-TEXT not supported/required */
> +		/* PMA, ATIP, CD-TEXT not supported/required */
>  		curlun->sense_data = SS_INVALID_FIELD_IN_CDB;
>  		return -EINVAL;
>  	}
> -- 
> 2.25.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
