Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869AB51A1C4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 16:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351307AbiEDOJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 10:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351203AbiEDOJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 10:09:26 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 954E440E7E
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 07:05:49 -0700 (PDT)
Received: (qmail 1122953 invoked by uid 1000); 4 May 2022 10:05:48 -0400
Date:   Wed, 4 May 2022 10:05:48 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH][next] USB: gadget: Fix return of -EBUSY
Message-ID: <YnKIPNtZ0wuPy7oS@rowland.harvard.edu>
References: <20220504135840.232209-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504135840.232209-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 02:58:40PM +0100, Colin Ian King wrote:
> Currently when driver->match_existing_only is true, the error return is
> set to -EBUSY however ret is then set to 0 at the end of the if/else
> statement. I believe the ret = 0 statement should be set in the else
> part of the if statement and not at the end to ensure -EBUSY is being
> returned correctly.
> 
> Detected by clang scan:
> drivers/usb/gadget/udc/core.c:1558:4: warning: Value stored to 'ret' is
> never read [deadcode.DeadStores]
> 
> Fixes: fc274c1e9973 ("USB: gadget: Add a new bus for gadgets")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Don't know how I missed that.  Thanks for fixing it.

In fact, since it's guaranteed that ret is already 0 before the 
driver->match_existing_only test, you could eliminate the assignment 
entirely.  But moving it into the second branch of the "if" statement is 
probably more clear.

Alan Stern

>  drivers/usb/gadget/udc/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index 61790592b2c8..3281d8a3dae7 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -1559,8 +1559,8 @@ int usb_gadget_register_driver_owner(struct usb_gadget_driver *driver,
>  		} else {
>  			pr_info("%s: couldn't find an available UDC\n",
>  					driver->function);
> +			ret = 0;
>  		}
> -		ret = 0;
>  	}
>  	mutex_unlock(&udc_lock);
>  
> -- 
> 2.35.1
> 
