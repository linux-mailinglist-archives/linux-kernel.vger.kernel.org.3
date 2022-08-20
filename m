Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300C959AD9E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 13:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345611AbiHTLqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 07:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241192AbiHTLqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 07:46:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A539C2CE;
        Sat, 20 Aug 2022 04:46:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EE4160C9B;
        Sat, 20 Aug 2022 11:46:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA217C433C1;
        Sat, 20 Aug 2022 11:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660995993;
        bh=KWya8Ir7VxqGsghF5iElXNfuH21OU6AhpqVzC3o0LYo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vJmQ9cp7v+CbrquW5fjf4f9qTzptUSTBEtW3y07hTULnCx1gcBIJ1YEfkbHDWzSby
         0ITtxpczsHUaf+wN0ev5KoyoIdCcZhqXjkO1gViZ5qPXjrgmPl+SnhW8qDKhL/Yf8/
         Qa1EKlB9fKZWfWaAn0NcXQJwXn0KOZiIh1dd7Yb1xhjeJXJC5RrV1jhJHYDPlb7p0W
         mIc+XHCGSXMh5f4UcsxGoBz1dypWOa62ZyslAICmma9wCTc8HdVjdfBpTVUWnYUE5K
         CIwvMklQe6ow3g/hor/QDsYWbUFfDDbt8B6FqcUBZC5t/4UqtVyGJzfBM6xEkbDjOk
         lO319oG8j397A==
Date:   Sat, 20 Aug 2022 12:57:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     sunliming <sunliming@kylinos.cn>
Cc:     ktsai@capellamicro.com, lars@metafoo.de,
        kai.heng.feng@canonical.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kelulanainsley@gmail.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: light: cm32181: make cm32181_pm_ops static
Message-ID: <20220820125709.7df567c1@jic23-huawei>
In-Reply-To: <20220815012930.150078-1-sunliming@kylinos.cn>
References: <20220815012930.150078-1-sunliming@kylinos.cn>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2022 09:29:30 +0800
sunliming <sunliming@kylinos.cn> wrote:

> This symbol is not used outside of cm32181.c, so marks it static.
> 
> Fixes the following sparse warnings:
> >> drivers/iio/light/cm32181.c:508:1: sparse: sparse: symbol 'cm32181_pm_ops'  
> was not declared. Should it be static?
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: sunliming <sunliming@kylinos.cn>

Applied.  Thanks,
> ---
>  drivers/iio/light/cm32181.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index edbe6a3138d0..001055d09750 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -505,7 +505,7 @@ static int cm32181_resume(struct device *dev)
>  					 cm32181->conf_regs[CM32181_REG_ADDR_CMD]);
>  }
>  
> -DEFINE_SIMPLE_DEV_PM_OPS(cm32181_pm_ops, cm32181_suspend, cm32181_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(cm32181_pm_ops, cm32181_suspend, cm32181_resume);
>  
>  static const struct of_device_id cm32181_of_match[] = {
>  	{ .compatible = "capella,cm3218" },

