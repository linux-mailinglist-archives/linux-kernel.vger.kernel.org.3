Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3990954F38B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381265AbiFQItt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381250AbiFQItr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:49:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DE169720
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:49:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5462560EBC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 08:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD3DC3411B;
        Fri, 17 Jun 2022 08:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655455785;
        bh=SR3t3kAs3ZUrejMpbmONDUblGHAye+LGAEF/vhniQDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M994WxztFrhplQAhepTnA1+aqCJSwiNPMrj/TPwe+R2t/WnvqfWOLYrrvkLbYrEws
         bbx+2WAXrtm54Mc+3+ZtPLsvd8PrbOnHvkfTUDjAGGckYk7MbZTHGZnpj2XmPNTI3E
         wpux8heLvNMeG9EVrZP4Wlnes8VRouBaHld1Qm3Q=
Date:   Fri, 17 Jun 2022 10:49:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     wuchi <wuchi.zero@gmail.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/kobject: Simplify checking of parameters in
 kobj_ns_type_register.
Message-ID: <YqxAJ0JiN7V1uekr@kroah.com>
References: <20220617083832.85287-1-wuchi.zero@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617083832.85287-1-wuchi.zero@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 04:38:32PM +0800, wuchi wrote:
> 1. Merge checking of following code:
>     if (type >= KOBJ_NS_TYPES)
>     ...
>     if (type <= KOBJ_NS_TYPE_NONE)

Why?

> 2. Move the checking of parameters out of critical section, there is
> no need to check that with spinlock.

Why does it matter?


> 
> Signed-off-by: wuchi <wuchi.zero@gmail.com>
> ---
>  lib/kobject.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/kobject.c b/lib/kobject.c
> index 5f0e71ab292c..6a8b009682b8 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -996,19 +996,13 @@ static const struct kobj_ns_type_operations *kobj_ns_ops_tbl[KOBJ_NS_TYPES];
>  int kobj_ns_type_register(const struct kobj_ns_type_operations *ops)
>  {
>  	enum kobj_ns_type type = ops->type;
> -	int error;
> -
> -	spin_lock(&kobj_ns_type_lock);
> +	int error = -EBUSY;
>  
> -	error = -EINVAL;
> -	if (type >= KOBJ_NS_TYPES)
> -		goto out;
> +	if (unlikely(type >= KOBJ_NS_TYPES || type <= KOBJ_NS_TYPE_NONE))

Why add unlikely?  Did you measure the performance benifit?  If not,
please never add likely/unlikely.

> +		return -EINVAL;
>  
> -	error = -EINVAL;
> -	if (type <= KOBJ_NS_TYPE_NONE)
> -		goto out;
> +	spin_lock(&kobj_ns_type_lock);
>  
> -	error = -EBUSY;


How did you test this?  What is the benefit?

thanks,

greg k-h
