Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A6951C653
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbiEERoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382777AbiEERnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:43:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5B05C86D;
        Thu,  5 May 2022 10:40:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1279B82DBE;
        Thu,  5 May 2022 17:40:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5AEC385AC;
        Thu,  5 May 2022 17:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651772399;
        bh=gOSgZEk3jsHNIB+ckRTLVRGCrgRIybWDts/FsyhHUkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c/ZwZULIsr3S3e6l2j6DfUiZogiPnOiwDrXq2MAgB7w6Drf7ILW4AXDb/CGofQjGX
         LFHLjF/ekyxAgxdpg64X5AzSiYm0CgiReNVM9qPC/cS9kkyzcvrlSqr0u2MRqZGr2b
         c1mblinTzxMmUt1Y+6x50UimQPyOwpQLVobTatGg=
Date:   Thu, 5 May 2022 19:32:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] test_firmware: fix end of loop test in
 upload_read_show()
Message-ID: <YnQKQLMkUNgyN2+C@kroah.com>
References: <YnPMt/syJAqqOBh3@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnPMt/syJAqqOBh3@kili>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 04:10:15PM +0300, Dan Carpenter wrote:
> If a list_for_each_entry() loop exits without hitting a break statement
> then the iterator points to invalid memory.  So in this code the
> "tst->name" dereference is an out bounds read.  It's an offset from the
> &test_upload_list pointer and it will likely work fine most of the time
> but it's not correct.
> 
> One alternative is to fix this this by changing the test to:
> 
> 	if (list_entry_is_head(tst, &test_upload_list, node)) {
> 
> But the simpler, trendy new way is just create a new variable and test
> for NULL.
> 
> Fixes: a31ad463b72d ("test_firmware: Add test support for firmware upload")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  lib/test_firmware.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/test_firmware.c b/lib/test_firmware.c
> index 76115c1a2629..c82b65947ce6 100644
> --- a/lib/test_firmware.c
> +++ b/lib/test_firmware.c
> @@ -1392,7 +1392,8 @@ static ssize_t upload_read_show(struct device *dev,
>  				struct device_attribute *attr,
>  				char *buf)
>  {
> -	struct test_firmware_upload *tst;
> +	struct test_firmware_upload *tst = NULL;
> +	struct test_firmware_upload *tst_iter;
>  	int ret = -EINVAL;
>  
>  	if (!test_fw_config->upload_name) {
> @@ -1401,11 +1402,13 @@ static ssize_t upload_read_show(struct device *dev,
>  	}
>  
>  	mutex_lock(&test_fw_mutex);
> -	list_for_each_entry(tst, &test_upload_list, node)
> -		if (tst->name == test_fw_config->upload_name)
> +	list_for_each_entry(tst_iter, &test_upload_list, node)
> +		if (tst_iter->name == test_fw_config->upload_name) {
> +			tst = tst_iter;
>  			break;
> +		}
>  
> -	if (tst->name != test_fw_config->upload_name) {
> +	if (!tst) {
>  		pr_err("Firmware name not found: %s\n",
>  		       test_fw_config->upload_name);
>  		goto out;
> -- 
> 2.35.1
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
