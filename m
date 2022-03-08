Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BC74D10F8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239201AbiCHH3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiCHH3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:29:48 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C563631DE2;
        Mon,  7 Mar 2022 23:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646724530; x=1678260530;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eSgr7kllToWa09Si12r9LxFjIEKFGm4w4wNIAFIoQ1U=;
  b=MIh5mULQaNKbI35JKWSNUD3fcNPG6sarTW9u2OplzWa4U3/GgHFKlnpD
   X9EmdTF84jzyyBiMXVyYLxpA+d4CJjmem/1qvfVLpsyB8mA5klL+mbgm0
   776exdvZ3NPOqb9y7T90wNgYjsFzzTOED9Aq7eNjP3XmCNXwrkEMeKDpF
   QykbEHEC/GDuY1/GAnWmxFWRFcYtWtdiw5eh3nXNBl3VLpXa76WexTcf7
   6mRIAmO5EfhrHuS+ZVa2vI5REnfvPkG+g1B7Si30i7jWQdujD7mcE3WKD
   cFPneFGz/FmFS0+5Ox87CftoCUCv2KkvZSXX3c0RPdYQofLn2xvNKcytk
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="252188011"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="252188011"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 23:28:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="687832143"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 07 Mar 2022 23:28:47 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 08 Mar 2022 09:28:47 +0200
Date:   Tue, 8 Mar 2022 09:28:47 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Yeqi Fu <fufuyqqqqqq@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        lyz_cs@pku.edu.cn, Yeqi Fu <fuyq@stu.pku.edu.cn>
Subject: Re: [PATCH 2/2] usb: typec: fix memory leak
Message-ID: <YicFr2CFBpEvQ35U@kuha.fi.intel.com>
References: <20220308065617.90401-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308065617.90401-1-fufuyqqqqqq@gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

NAK.

That resources are released in the release callback - typec_release()
in this case.

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

thanks,

-- 
heikki
