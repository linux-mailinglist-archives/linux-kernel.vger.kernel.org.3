Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2054CD618
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiCDOPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiCDOPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:15:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E5462E0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 06:14:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E37DB612A5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 14:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC4CC340E9;
        Fri,  4 Mar 2022 14:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646403255;
        bh=tOSwy/IqvLdbW9FFy93gGyEiwPOEyRNiwVpCXRt6x/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MiFWKHd1pf6MNX2q7gNhBlxfMu17suulJquUywyJOWN5XJwQYFVDdBpr50Jg7qKvK
         tXiEyW/yxfnpz1QlliiMeDq/DdXGQ0roFn/ZAaoN7PbRn+WnnGZUOPSUR4iaPrGQom
         WPLr6zwE/LP1I1Jeqm3iH5ayIPr9TTGx2ewKX/L0=
Date:   Fri, 4 Mar 2022 15:14:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xkernel.wang@foxmail.com
Cc:     linux@dominikbrodowski.net, akpm@linux-foundation.org,
        pombredanne@nexb.com, arnd@arndb.de, luc.vanoostenryck@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init/initramfs.c: check the return value of kstrdup()
Message-ID: <YiIesoVGiVm2KcUD@kroah.com>
References: <tencent_DE1C3D1422E1DD4A35FFDE2048CC48B94E08@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_DE1C3D1422E1DD4A35FFDE2048CC48B94E08@qq.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 05:27:34PM +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> kstrdup() is also a memory allocation function which is similar
> with kmalloc() in some way. Once some internal memory errors
> happen, it will return NULL. It is better to check the return
> value of it so to catch the memory error in time.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  init/initramfs.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/init/initramfs.c b/init/initramfs.c
> index a842c05..49deffb 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -139,8 +139,12 @@ static void __init dir_add(const char *name, time64_t mtime)
>  	struct dir_entry *de = kmalloc(sizeof(struct dir_entry), GFP_KERNEL);
>  	if (!de)
>  		panic_show_mem("can't allocate dir_entry buffer");
> -	INIT_LIST_HEAD(&de->list);
>  	de->name = kstrdup(name, GFP_KERNEL);
> +	if (!de->name) {

How can this fail?  Have you ever hit this in real life?

> +		kfree(de);
> +		panic_show_mem("can't duplicate dir name");

Why are you freeing memory if you are panicing?

How was this tested?

thanks,

greg k-h
