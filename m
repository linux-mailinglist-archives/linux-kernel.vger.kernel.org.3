Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582FC5866AB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiHAJBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiHAJBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:01:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49FBBC88
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 02:01:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 615AF6104D
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 09:01:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F59CC433D6;
        Mon,  1 Aug 2022 09:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659344505;
        bh=9N4MP54pi+2YzqlyPQl/AO6H4XWIGSthRqofo9l0eek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sXoKxt1uT3r9jg1/snWDbHd9R0DQ3gqMAjazuis+RmBHAFCbe6tjmpcrw2OB8WIes
         5M9dxG1xrCGbujUgNlWsuIqz+w8Q8z/gXg6Dy7/FlR7j3U5q4p/n1vl0ZERyoHwBgg
         cWLmW3eHXJba2A3L3NuT7pmOH3D5Sn03RfNxmrSk=
Date:   Mon, 1 Aug 2022 11:01:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "GONG, Ruiqi" <gongruiqi1@huawei.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        wangweiyang2@huawei.com
Subject: Re: [PATCH] tty: moxa: Refine error handling in moxa_pci_probe
Message-ID: <YueWdjtxvmmZAA9E@kroah.com>
References: <20220801085356.1716756-1-gongruiqi1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801085356.1716756-1-gongruiqi1@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 04:53:56PM +0800, GONG, Ruiqi wrote:
> Add pci_disable_device() into the error handling, and therefore make the
> function not jump to err if pci_enable_device() failed.
> 
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
> ---
>  drivers/tty/moxa.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
> index f3c72ab1476c..4432a39331d3 100644
> --- a/drivers/tty/moxa.c
> +++ b/drivers/tty/moxa.c
> @@ -1239,7 +1239,7 @@ static int moxa_pci_probe(struct pci_dev *pdev,
>  	retval = pci_enable_device(pdev);
>  	if (retval) {
>  		dev_err(&pdev->dev, "can't enable pci device\n");
> -		goto err;
> +		return retval;
>  	}
>  
>  	for (i = 0; i < MAX_BOARDS; i++)
> @@ -1300,6 +1300,7 @@ static int moxa_pci_probe(struct pci_dev *pdev,
>  err_reg:
>  	pci_release_region(pdev, 2);
>  err:
> +	pci_disable_device(pdev);

Are you sure you want to do this?  What happens if this is a
multi-function device, you just turned it off, right?

How did you test this change?  Do you have the hardware for it?

thanks,

greg k-h
