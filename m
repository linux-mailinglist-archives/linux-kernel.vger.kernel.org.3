Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8344249DA93
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 07:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbiA0GXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 01:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbiA0GXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 01:23:10 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B46C061714;
        Wed, 26 Jan 2022 22:23:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 483A7CE2030;
        Thu, 27 Jan 2022 06:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8C0C340E4;
        Thu, 27 Jan 2022 06:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643264586;
        bh=B58zBIa5L1VQWEgOaaZ3OhQmnqz1yN4j+5wV0UStBAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sYlAmJiwKrUobS69raN15IgOlBwsPEoGuVBGCtd3NoBD9nf/kfgKGUaaVzTVzvFuZ
         6r/HkV855hBTIbPTpNdBcqV/H2QJcGb0cF6PlKy1CEFyGLiBgsgLWAQhm5nheAV6Si
         lY+/RL0MpMcE13SuhE1m5oeE0p/Nr0ERzb+1uPGs=
Date:   Thu, 27 Jan 2022 07:22:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     davidcomponentone@gmail.com
Cc:     bhelgaas@google.com, yang.guang5@zte.com.cn, rajatja@google.com,
        Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] usb: core: replace snprintf with sysfs_emit
Message-ID: <YfI6Qj+oIsNQYPJ2@kroah.com>
References: <e205c334a8c65c03702a94ee382ec488bcc1d019.1643183299.git.yang.guang5@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e205c334a8c65c03702a94ee382ec488bcc1d019.1643183299.git.yang.guang5@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 07:54:54AM +0800, davidcomponentone@gmail.com wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> coccinelle report:
> ./drivers/usb/core/sysfs.c:921:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/usb/core/sysfs.c:730:8-16:
> WARNING: use scnprintf or sprintf
> 
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>

Again, no, this did not report this.  I'll keep ignoring changes like
this that get this wrong.

> Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
> Signed-off-by: David Yang <davidcomponentone@gmail.com>
> ---
>  drivers/usb/core/sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
> index fa2e49d432ff..6387c0dfe30e 100644
> --- a/drivers/usb/core/sysfs.c
> +++ b/drivers/usb/core/sysfs.c
> @@ -727,7 +727,7 @@ static ssize_t authorized_show(struct device *dev,
>  			       struct device_attribute *attr, char *buf)
>  {
>  	struct usb_device *usb_dev = to_usb_device(dev);
> -	return snprintf(buf, PAGE_SIZE, "%u\n", usb_dev->authorized);
> +	return sysfs_emit(buf, "%u\n", usb_dev->authorized);
>  }
>  
>  /*
> @@ -918,7 +918,7 @@ static ssize_t authorized_default_show(struct device *dev,
>  	struct usb_hcd *hcd;
>  
>  	hcd = bus_to_hcd(usb_bus);
> -	return snprintf(buf, PAGE_SIZE, "%u\n", hcd->dev_policy);
> +	return sysfs_emit(buf, "%u\n", hcd->dev_policy);
>  }
>  
>  static ssize_t authorized_default_store(struct device *dev,
> -- 
> 2.30.2
> 

Also this change is not correct, why are you only doing this for 2 sysfs
files and not all of them?  Is there anything incorrect about the
current sysfs handling in this file that requires them to be changed to
use the new api?

greg k-h
