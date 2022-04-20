Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C301509337
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383023AbiDTW44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345330AbiDTW4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:56:54 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609A12251E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:54:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KkGF85JJwz4xR9;
        Thu, 21 Apr 2022 08:54:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1650495246;
        bh=qLGjkp6XaJCG2v9la8Z0Z1LTGbSB3IZhkcSgJ6/yvwg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=PErqBP2jpEF4B/n7y1EbTTycn/YDD/Zd3naDd0QJs/z4v+AgYgf9XdgIVCdUtaQYw
         4FwVbt6qqTFcXzCRMll0FheC6mKtJ84MyV8b5nTEWTGu9PDEQnaCO5sjpy9o0l2VQV
         ykE3BoykcnWH3H6ui7YZ3wgsN+SkhCW3ufppgnNXNINAtxQ3zaFhH+uRrSUzwZw038
         HELDg4p9aNQbWegyo7fkesOFjSbjds8lhcI2wm/UAeN3K0AMVhwo4oodnoiiBpuELi
         qSre6nYZRuZGYhZASVtnmuQAmRsx2Ul3t4e+zw1IQlN+XJTlYQYc7zhVXaKe9fndkh
         ayhFeoZcy4c2Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Hangyu Hua <hbh25y@gmail.com>, fbarrat@linux.ibm.com,
        ajd@linux.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        alastair@d-silva.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: Re: [PATCH] misc: ocxl: fix possible double free in
 ocxl_file_register_afu
In-Reply-To: <20220418085758.38145-1-hbh25y@gmail.com>
References: <20220418085758.38145-1-hbh25y@gmail.com>
Date:   Thu, 21 Apr 2022 08:54:04 +1000
Message-ID: <87czhbfjsj.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hangyu Hua <hbh25y@gmail.com> writes:
> info_release() will be called in device_unregister() when info->dev's
> reference count is 0. So there is no need to call ocxl_afu_put() and
> kfree() again.

Double frees are often exploitable. But it looks to me like this error
path is not easily reachable by an attacker.

ocxl_file_register_afu() is only called from ocxl_probe(), and we only
go to err_unregister if the sysfs or cdev initialisation fails, which
should only happen if we hit ENOMEM, or we have a duplicate device which
would be a device-tree/hardware error. But maybe Fred can check more
closely, I don't know the driver that well.

cheers


> Fix this by adding free_minor() and return to err_unregister error path.
>
> Fixes: 75ca758adbaf ("ocxl: Create a clear delineation between ocxl backend & frontend")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>  drivers/misc/ocxl/file.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
> index d881f5e40ad9..6777c419a8da 100644
> --- a/drivers/misc/ocxl/file.c
> +++ b/drivers/misc/ocxl/file.c
> @@ -556,7 +556,9 @@ int ocxl_file_register_afu(struct ocxl_afu *afu)
>  
>  err_unregister:
>  	ocxl_sysfs_unregister_afu(info); // safe to call even if register failed
> +	free_minor(info);
>  	device_unregister(&info->dev);
> +	return rc;
>  err_put:
>  	ocxl_afu_put(afu);
>  	free_minor(info);
> -- 
> 2.25.1
