Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7925712EF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbiGLHSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiGLHSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:18:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC525951EF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:18:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D3E6B816B7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A891C3411E;
        Tue, 12 Jul 2022 07:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657610283;
        bh=z4IW8CyCNKewOiEMx21gPmE/TlmZbo7uErzj1tCUxPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yUroBLU+6EdrWtNipGeYGmY8DxSnJBO0cIm2+No8LZRSRPlO4JCfV/qejbeXDu0U2
         YlgIXfeKtjxGQnBLY2ryjH4g7Agg47QelLioXxrkP9QQGAoZdMVebRIGPqce9uOhTb
         CDuWWa8r6AjGVspOCheuJ06FiwSfZp5KFpRyh0LM=
Date:   Tue, 12 Jul 2022 09:17:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiangshan Yi <13667453960@163.com>
Cc:     rafael@kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: Re: [PATCH] component: replace ternary operator with min()
Message-ID: <Ys0gJlsZap/Qd1Gi@kroah.com>
References: <20220712071223.301160-1-13667453960@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712071223.301160-1-13667453960@163.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 03:12:23PM +0800, Jiangshan Yi wrote:
> From: Jiangshan Yi <yijiangshan@kylinos.cn>
> 
> Fix the following coccicheck warning:
> 
> drivers/base/component.c:544: WARNING opportunity for min().
> drivers/base/component.c:740: WARNING opportunity for min().
> 
> min() macro is defined in include/linux/minmax.h. It avoids
> multiple evaluations of the arguments when non-constant and performs
> strict type-checking.
> 
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---
>  drivers/base/component.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/component.c b/drivers/base/component.c
> index 5eadeac6c532..349c54694481 100644
> --- a/drivers/base/component.c
> +++ b/drivers/base/component.c
> @@ -541,7 +541,7 @@ int component_master_add_with_match(struct device *parent,
>  
>  	mutex_unlock(&component_mutex);
>  
> -	return ret < 0 ? ret : 0;
> +	return min(ret, 0);

This is a traditional "if there is an error, report it, otherwise return
0" pattern, and not really a min() call.  So perhaps the original should
stay, or be turned into:
	if (ret < 0)
		return ret
	return 0;
to make it more obvious?

thanks,

greg k-h
