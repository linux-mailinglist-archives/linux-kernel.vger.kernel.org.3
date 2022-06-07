Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2032253FFB6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244466AbiFGNLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242776AbiFGNLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:11:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE24BC9668;
        Tue,  7 Jun 2022 06:11:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61CFAB81F98;
        Tue,  7 Jun 2022 13:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDCCC385A5;
        Tue,  7 Jun 2022 13:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654607477;
        bh=gnONcHJ/AolSb/eRrOjC4crVY3aMOQooVXe77m9/SCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E1aM7qDxpgweXoAhOYGiV+2mSw0Is++BU/6XjT2OAM6oXhq1mzMlmVcAuXvUji2Re
         /bDK0bKs5/JgANacfr2W+969UPUvWxarIxWIUZ6F4Vba6leHS9cxwEUsOVug1tjxMR
         XAgWgR04m0g1CKjuM6vy+ZQb4nbNBF5Om5n5WEhA=
Date:   Tue, 7 Jun 2022 15:11:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tom Rix <trix@redhat.com>
Cc:     jirislaby@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        peter@hurleysoftware.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] serial: core: check if uart_get_info succeeds before
 using
Message-ID: <Yp9Ob3pXUS8Jggm4@kroah.com>
References: <20220529134605.12881-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220529134605.12881-1-trix@redhat.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2022 at 09:46:05AM -0400, Tom Rix wrote:
> clang static analysis reports this representative issue
> drivers/tty/serial/serial_core.c:2818:9: warning: 3rd function call argument is an uninitialized value [core.CallAndMessage]
>         return sprintf(buf, "%d\n", tmp.iomem_reg_shift);
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> uart_get_info() is used the *show() functions.  When uart_get_info() fails, what is reported
> is garbage.  So check if uart_get_info() succeeded.
> 
> Fixes: 4047b37122d1 ("serial: core: Prevent unsafe uart port access, part 1")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/tty/serial/serial_core.c | 52 ++++++++++++++++++++++++--------
>  1 file changed, 39 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 9a85b41caa0a..4160f6711c5d 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2690,7 +2690,9 @@ static ssize_t uartclk_show(struct device *dev,
>  	struct serial_struct tmp;
>  	struct tty_port *port = dev_get_drvdata(dev);
>  
> -	uart_get_info(port, &tmp);
> +	if (uart_get_info(port, &tmp))
> +		return 0;

As Andy pointed out, this is an error, don't tell userspace that all
went well and yet you returned no data?  That will just confuse it.

thanks,

greg k-h
