Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723B9524BD1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239966AbiELLiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239947AbiELLin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:38:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235B3393C6;
        Thu, 12 May 2022 04:38:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 81A77CE2859;
        Thu, 12 May 2022 11:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CDFC385B8;
        Thu, 12 May 2022 11:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652355518;
        bh=Y91zXput8gHSrrUajrSAKfMeVBw0dpergVzZ8Wdemnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kBzHcQwInf/39qtW1OD37z+Rdmlm/Rxlz6e3uAjCqtuN0DBY8L1kg7NvIzKIF6QHd
         JJ9haqR5sk3W40NdANoZ6ANSv8Y1lE6quRKw9RVCjN4xmjV658zs635QFbic5wHcIs
         D8q5ISyk0BrlILFSYP2RsnoP1EwcU7U6e7paa8cc=
Date:   Thu, 12 May 2022 13:38:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajat Jain <rajatja@google.com>, Andrew Lunn <andrew@lunn.ch>,
        Chris Chiu <chris.chiu@canonical.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Naveen kumar Sunkari <naveenkumar.sunkari@in.bosch.com>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        Eugeniu Rosca <rosca.eugeniu@gmail.com>
Subject: Re: [PATCH] usb: hub: Simplify error and success path in
 port_over_current_notify
Message-ID: <YnzxvJ7/LGpu92bK@kroah.com>
References: <1652354127-3499-1-git-send-email-erosca@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652354127-3499-1-git-send-email-erosca@de.adit-jv.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 01:15:27PM +0200, Eugeniu Rosca wrote:
> From: Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>
> 
> kasprintf() returns NULL or valid pointer. Since kfree() can handle
> NULL pointer condition, simplify error and success paths in function
> port_over_current_notify() by removing multiple error path labels.
> 
> Signed-off-by: Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>
> Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> ---
>  drivers/usb/core/hub.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 1460857026e0..9ab8abf14790 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -5511,7 +5511,7 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
>  /* Handle notifying userspace about hub over-current events */
>  static void port_over_current_notify(struct usb_port *port_dev)
>  {
> -	char *envp[3];
> +	char *envp[3] = { NULL, NULL, NULL };
>  	struct device *hub_dev;
>  	char *port_dev_path;
>  
> @@ -5533,15 +5533,13 @@ static void port_over_current_notify(struct usb_port *port_dev)
>  	envp[1] = kasprintf(GFP_KERNEL, "OVER_CURRENT_COUNT=%u",
>  			port_dev->over_current_count);
>  	if (!envp[1])
> -		goto exit;
> +		goto exit_path;

No need to rename this, right?

>  
> -	envp[2] = NULL;
>  	kobject_uevent_env(&hub_dev->kobj, KOBJ_CHANGE, envp);
>  
> +exit_path:
>  	kfree(envp[1]);
> -exit:

Move this up one line?

thanks,

greg k-h
