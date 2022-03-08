Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732044D10BB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344508AbiCHHKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344488AbiCHHKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:10:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ED433882;
        Mon,  7 Mar 2022 23:09:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25AB561582;
        Tue,  8 Mar 2022 07:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0367AC340EB;
        Tue,  8 Mar 2022 07:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646723351;
        bh=Ykqhm2OjaBdscON2MKDblQOd82pwNXwdVIWReQQX+wE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EhIa4+r5vol4YPzhsiJlaNItlU5xbmUYgI//VgThOuUbCZZZbbedjwi3GyusORL9B
         naHlRfpDEuPN9FO3yXCNanZIiXETHbv6b7UMdo0S/Gkr0OavP2LHMP2JTMrw6t+zZL
         jcFX/sK6Y5cZtod4MRb8ocQFNkX/kseyCjM8MyUM=
Date:   Tue, 8 Mar 2022 08:09:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yeqi Fu <fufuyqqqqqq@gmail.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        lyz_cs@pku.edu.cn, Yeqi Fu <fuyq@stu.pku.edu.cn>
Subject: Re: [PATCH 2/2] usb: typec: fix memory leak
Message-ID: <YicBE18zTVVNLhsn@kroah.com>
References: <20220308065617.90401-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308065617.90401-1-fufuyqqqqqq@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 10:56:17PM -0800, Yeqi Fu wrote:
> From: Yeqi Fu <fuyq@stu.pku.edu.cn>
> 
> Resource release is needed on the error handling branch
> to prevent memory leak. Fix this by adding kfree to the
> error handling branch.
> 
> Signed-off-by: Yeqi Fu <fuyq@stu.pku.edu.cn>
> ---
>  drivers/usb/typec/class.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index ee0e520707dd..e210109c696d 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -2099,6 +2099,7 @@ struct typec_port *typec_register_port(struct device *parent,
>  	port->cap = kmemdup(cap, sizeof(*cap), GFP_KERNEL);
>  	if (!port->cap) {
>  		put_device(&port->dev);
> +		kfree(port);
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
> @@ -2106,6 +2107,7 @@ struct typec_port *typec_register_port(struct device *parent,
>  	if (IS_ERR(port->sw)) {
>  		ret = PTR_ERR(port->sw);
>  		put_device(&port->dev);
> +		kfree(port);
>  		return ERR_PTR(ret);
>  	}
>  
> @@ -2113,6 +2115,7 @@ struct typec_port *typec_register_port(struct device *parent,
>  	if (IS_ERR(port->mux)) {
>  		ret = PTR_ERR(port->mux);
>  		put_device(&port->dev);
> +		kfree(port);
>  		return ERR_PTR(ret);
>  	}
>  
> @@ -2120,6 +2123,7 @@ struct typec_port *typec_register_port(struct device *parent,
>  	if (ret) {
>  		dev_err(parent, "failed to register port (%d)\n", ret);
>  		put_device(&port->dev);
> +		kfree(port);
>  		return ERR_PTR(ret);
>  	}

How was this tested?
