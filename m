Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD961576C93
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 10:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiGPIYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 04:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiGPIYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 04:24:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034691C93E
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 01:23:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22AA160EE1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 08:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF5EC34114;
        Sat, 16 Jul 2022 08:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657959837;
        bh=5dE+ypv3zng6jNf0Fnl5tGw2xHsfI3mi20S2F7wJInQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c2D6gGShhwj9YiyxsKgNCGrteonGBfPqQ6fQ3SM0x4SdzrmcwyvKnhHCFMgk2Sxnz
         i4vupKpDJfNhkv93RrixQBd1nJBfYgK1LP63bEqdX8Q6FrurQFmz6y/fcNv4uNUzYn
         uoYdsu8jxQ8acgPOK7u6OgIlzhfPa8rKop/0b8gc=
Date:   Sat, 16 Jul 2022 10:23:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        gongruiqi1@huawei.com, wangweiyang2@huawei.com
Subject: Re: [PATCH -next] nvmem: core: Fix memleak in nvmem_register()
Message-ID: <YtJ1mthCP+4laqOn@kroah.com>
References: <20220716075352.2622809-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220716075352.2622809-1-cuigaosheng1@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 03:53:52PM +0800, Gaosheng Cui wrote:
> dev_set_name will alloc memory for nvmem->dev.kobj.name in
> nvmem_register, when nvmem_validate_keepouts failed, nvmem's
> memory will be freed and return, but nobody will free memory
> for nvmem->dev.kobj.name, there will be memleak, so using
> kfree_const(nvmem->dev.kobj.name) to fix it.
> 
> Fixes: de0534df9347 ("nvmem: core: fix error handling while validating keepout regions")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  drivers/nvmem/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 1e3c754efd0d..6c75c9afa5f3 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -833,6 +833,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>  		rval = nvmem_validate_keepouts(nvmem);
>  		if (rval) {
>  			ida_free(&nvmem_ida, nvmem->id);
> +			kfree_const(nvmem->dev.kobj.name);
>  			kfree(nvmem);

Something is really wrong, you should never be touching the name pointer
of a kobject directly like this.  Also the device structure itself
should be cleaning up the memory, not a kfree.  So this feels wrong...

greg k-h
