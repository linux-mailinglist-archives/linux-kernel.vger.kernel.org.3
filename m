Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4673486640
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 15:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240146AbiAFOoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 09:44:13 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53732 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239677AbiAFOoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 09:44:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23E9A61A44
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 14:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D0AC36AE3;
        Thu,  6 Jan 2022 14:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641480251;
        bh=Pf6KG3/fKHQCDbLl6CkuKmq7eQc2OdPAsK506l7XEl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qa35U94Ndq2PKAWKNHD7T3MM+9RjxkaVBtJUiOfbTH+72tjTbZCMQ9qFXX2conzyG
         wGWysnA8AYu6BAY99qUplJMvzrPX836iKpcsVzEjKSVowzCafi9FlHkA+KllcvNued
         dHMU/Z0thqu9Aq/1M+WDyhWh/dLMwNeuxLZG+oOI=
Date:   Thu, 6 Jan 2022 15:44:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] firmware: remove old CONFIG_FW_LOADER_MODULE test
Message-ID: <YdcAOL6hCck2jqXq@kroah.com>
References: <20211230093932.2747587-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230093932.2747587-1-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 10:39:32AM +0100, Greg Kroah-Hartman wrote:
> The CONFIG_FW_LOADER_MODULE check in firmware.h is very obsolete given
> that this symbol went away decades ago, so it should be removed.
> 
> Reported-by: Borislav Petkov <bp@alien8.de>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  include/linux/firmware.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/firmware.h b/include/linux/firmware.h
> index 3b057dfc8284..0b1c4d9c5465 100644
> --- a/include/linux/firmware.h
> +++ b/include/linux/firmware.h
> @@ -34,7 +34,7 @@ static inline bool firmware_request_builtin(struct firmware *fw,
>  }
>  #endif
>  
> -#if defined(CONFIG_FW_LOADER) || (defined(CONFIG_FW_LOADER_MODULE) && defined(MODULE))
> +#if defined(CONFIG_FW_LOADER)
>  int request_firmware(const struct firmware **fw, const char *name,
>  		     struct device *device);
>  int firmware_request_nowarn(const struct firmware **fw, const char *name,
> -- 
> 2.34.1
> 

Odd, 0-day reports a bunch of warnings with this change:

drivers/base/firmware_loader/main.c:1054:1: error: redefinition of 'request_firmware_nowait'
drivers/base/firmware_loader/main.c:811:1: error: redefinition of 'request_firmware'
drivers/base/firmware_loader/main.c:838:5: error: redefinition of 'firmware_request_nowarn'
drivers/base/firmware_loader/main.c:863:5: error: redefinition of 'request_firmware_direct'
drivers/base/firmware_loader/main.c:887:5: error: redefinition of 'firmware_request_platform'
drivers/base/firmware_loader/main.c:941:1: error: redefinition of 'request_firmware_into_buf'
drivers/base/firmware_loader/main.c:970:1: error: redefinition of 'request_partial_firmware_into_buf'
drivers/base/firmware_loader/main.c:992:6: error: redefinition of 'release_firmware'


Luis, any ideas?

thanks,

greg k-h

