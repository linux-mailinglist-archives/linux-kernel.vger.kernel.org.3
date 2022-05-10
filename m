Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B2E520FB7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238017AbiEJIct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbiEJIcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:32:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B96F36E26;
        Tue, 10 May 2022 01:28:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBFBA6120D;
        Tue, 10 May 2022 08:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD2AC385C9;
        Tue, 10 May 2022 08:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652171326;
        bh=RqCJf8kgze++idptJ3xnVFyet34bi4Uq9DXOU8Jttpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bVcGmUgWoobvo4Yl2VlegFG8I9rHVV733zwbuSWYQDm61T/rDtd4W5ynUfuDN5LOD
         w9uX+vridJ6m86tsTjUOb31amhwIgAajk1NLLt82ltQL5wzBAgndxIHJ/cxHD1tCK5
         D4Qu7Cu7BzrnBVMbg7Ocqxq6JRPK4nyhlFAK7jWo=
Date:   Tue, 10 May 2022 10:28:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guan Jing <guanjing6@huawei.com>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] usb: dwc3: include extcon.h to fix compile error
Message-ID: <YnoiOlkzvJKs/NN8@kroah.com>
References: <20220510082029.197841-1-guanjing6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510082029.197841-1-guanjing6@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 04:20:29PM +0800, Guan Jing wrote:
> If dwc3 is not include extcon.h, the dwc3 driver
> will fail to link:
> 
> drivers/usb/dwc3/core.o: In function `dwc3_probe':
> core.c:(.text+0x1095): undefined reference to `extcon_get_edev_by_phandle'
> core.c:(.text+0x10bd): undefined reference to `extcon_get_extcon_dev'
> 
> Add miss #include <linux/extcon.h> to fix this error.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Guan Jing <guanjing6@huawei.com>
> ---
>  drivers/usb/dwc3/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 950e238c65bf..ea7259443283 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -33,6 +33,7 @@
>  #include <linux/usb/gadget.h>
>  #include <linux/usb/of.h>
>  #include <linux/usb/otg.h>
> +#include <linux/extcon.h>
>  
>  #include "core.h"
>  #include "gadget.h"
> -- 
> 2.17.1
> 

Very odd, I do not see these build errors here.

What commit id does this change fix?  What caused the problem?

And please put the extcon.h include above the usb includes, as that's
the better place for it, right?

thanks,

greg k-h
