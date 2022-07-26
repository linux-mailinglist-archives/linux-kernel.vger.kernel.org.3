Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD535817ED
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 18:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239599AbiGZQvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 12:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239587AbiGZQvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:51:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDF3D68;
        Tue, 26 Jul 2022 09:51:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E732B80C63;
        Tue, 26 Jul 2022 16:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE143C433D6;
        Tue, 26 Jul 2022 16:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658854302;
        bh=HxwGMgHUC7SNxnI0lilNnOei/RhRQmPwyZwsZSODdDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bxFwo72ijEa+JY94NWPGk6+4nO55MQ3HVb96s8cM20v/18dyCfHVakLss2zkwazWX
         VBjzPR54yhnDgcyKW4TAzCzTw1elXEo+fNUXqLvGzfSMvAbVI7DAIdfdbMq2OIg9Ld
         3CWHdd+K/TXXqggm+sLrg+2z8eiLuJ95kCxb+H34=
Date:   Tue, 26 Jul 2022 18:51:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chen Xingdi <chenxingdi@huawei.com>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, chunkeey@googlemail.com
Subject: Re: [PATCH -next] usb: renesas-xhci: Use pr_info while fw verify
 success
Message-ID: <YuAbm09hv4ZGXIw5@kroah.com>
References: <20220726060509.20748-1-chenxingdi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726060509.20748-1-chenxingdi@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 02:05:09PM +0800, Chen Xingdi wrote:
> While fw verify success, it is confused to print an error
> log which is actually not an error, so use pr_info to print
> firmware version instead of pr_err.
> 
> Signed-off-by: Chen Xingdi <chenxingdi@huawei.com>
> ---
>  drivers/usb/host/xhci-pci-renesas.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-pci-renesas.c b/drivers/usb/host/xhci-pci-renesas.c
> index 52599d96634f..1eb1d863d545 100644
> --- a/drivers/usb/host/xhci-pci-renesas.c
> +++ b/drivers/usb/host/xhci-pci-renesas.c
> @@ -151,7 +151,7 @@ static int renesas_fw_verify(const void *fw_data,
>  	}
>  
>  	fw_version = get_unaligned_le16(fw_data + fw_version_pointer);
> -	pr_err("got firmware version: %02x.", fw_version);
> +	pr_info("got firmware version: %02x.", fw_version);

Why print anything at all?  When drivers are working properly, they
should be quiet.  Who relies on this message being sent to the kernel
log?

thanks,

greg k-h
