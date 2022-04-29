Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CE9514280
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 08:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354621AbiD2Gmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 02:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbiD2Gml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 02:42:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F0DBABA1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 23:39:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4F8BB832F5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB805C385A7;
        Fri, 29 Apr 2022 06:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651214362;
        bh=5c8F2sq+4CEvKl5AkGR/1+aWdhR+TKH8lu0tldZgVqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=umbpuzVpvhhaRNlWnfx/nGJYtLvJUERYtcx/xz4Be93SbW1C3kWnYpEW+lhW+iv6V
         KmvAVC68u57wvTshflOSqi0k2uAoXeLo+TkatozuB9r6soy9LzkFVMw31V38j1KTD7
         SjDrO64gp1wEgUN3VJvBc23W3FmwT9Af4RmL5ohc=
Date:   Fri, 29 Apr 2022 08:39:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhang Jianhua <chris.zjh@huawei.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] vt: defkeymap.c_shipped remove unused variables
Message-ID: <YmuIEoOnJqYLy3CE@kroah.com>
References: <20220429014814.988829-1-chris.zjh@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429014814.988829-1-chris.zjh@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 09:48:14AM +0800, Zhang Jianhua wrote:
> The global variables 'funcbufptr' 'funcbufsize' and 'funcbufleft' have
> been initialized but not used, they are redundant and remove them.
> 
> --------

Why this extra "------" line?

> 
> Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>
> ---
>  drivers/tty/vt/defkeymap.c_shipped | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/tty/vt/defkeymap.c_shipped b/drivers/tty/vt/defkeymap.c_shipped
> index 094d95bf0005..80dee50bcb7a 100644
> --- a/drivers/tty/vt/defkeymap.c_shipped
> +++ b/drivers/tty/vt/defkeymap.c_shipped
> @@ -185,10 +185,6 @@ char func_buf[] = {
>  	'\033', '[', 'P', 0, 
>  };
>  
> -char *funcbufptr = func_buf;
> -int funcbufsize = sizeof(func_buf);
> -int funcbufleft = 0;          /* space left */
> -
>  char *func_table[MAX_NR_FUNC] = {
>  	func_buf + 0,
>  	func_buf + 5,
> -- 
> 2.31.0
> 

Shouldn't you fix up the loadkeys tool instead?  As the top of this file
says, it is auto-generated and is not something to be hand-edited at
all.

thanks,

greg k-h
